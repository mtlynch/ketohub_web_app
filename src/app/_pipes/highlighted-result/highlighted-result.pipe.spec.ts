import { HighlightedResultPipe } from './highlighted-result.pipe';
import { SearchParams } from '../../_classes/search-params';

describe('HighlightedResultPipe', () => {
  let pipe: HighlightedResultPipe;

  beforeEach(() => {
    pipe = new HighlightedResultPipe();
  });

  it('should create an instance', () => {
    expect(pipe).toBeTruthy();
  });

  it('should match a single keyword occurrence', () => {
    expect(pipe.transform('the cat in the hat', new SearchParams(['cat']))).toBe('the <mark>cat</mark> in the hat');
  });

  it('should match multiple occurrences of the same keyword', () => {
    expect(pipe.transform('scams and flams', new SearchParams(['ams']))).toBe('sc<mark>ams</mark> and fl<mark>ams</mark>');
  });

  it('should match multiple keywords', () => {
    expect(pipe.transform('spam and eggs', new SearchParams(['spam', 'eggs']))).toBe('<mark>spam</mark> and <mark>eggs</mark>');
  });

  it('should match multiple keywords when second is single letter', () => {
    expect(pipe.transform('Loaded Keto Cauliflower Bowl', new SearchParams(['loaded', 'k']))).toBe('<mark>Loaded</mark> <mark>K</mark>eto Cauliflower Bowl');
  });
 
  it('should match when keywords overlap in their match', () => {
    expect(pipe.transform('jalapeno salad', new SearchParams(['jala', 'lapeno']))).toBe('<mark>jalapeno</mark> salad');
  });

  it('should coalesce adjacent matches', () => {
    expect(pipe.transform('jeeepers', new SearchParams(['e']))).toBe('j<mark>eee</mark>p<mark>e</mark>rs');
  });

  it('should ignore string case', () => {
    expect(pipe.transform('hAt HAT hat', new SearchParams(['hat']))).toBe('<mark>hAt</mark> <mark>HAT</mark> <mark>hat</mark>');
  });
});
