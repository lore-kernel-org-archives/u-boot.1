Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7B4C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CB5880EF4;
	Sat, 25 Jan 2025 23:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gj2/Tuf6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCB080F10; Sat, 25 Jan 2025 23:57:28 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9053A80ECD
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5dbfab8a2b0so6406678a12.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737845846; x=1738450646; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l4Oi5W7AWHXkm8rPVJya0d/7+oJK0URxgqtiZwqbsY4=;
 b=gj2/Tuf6xrIEG68Wl3A3RwNAto36GJRGBzP0Az2zLQhDNCpUcmOSdIIvUFjvCngLCf
 vPPAzgKvimDMLQnwbIIOy+tP9BAWtpOK6HIaLRf1xv+4YQEaSHqtH+oivP9EVfq1cMLH
 W5BQQWFcLCEuYHw6ZmHTuQGMVRf4cZk1nFHbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737845846; x=1738450646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l4Oi5W7AWHXkm8rPVJya0d/7+oJK0URxgqtiZwqbsY4=;
 b=La+s+7orHQ4I+83e89sReI/piUhAF7rlVdgpCappYO/7E0aWRzled5PPplNKl0yOAa
 jRZxDbMD0thdoJ9pqNQeYjYAudUKx25UbbrZVsxKUQY7OvVsBdX7qxYln4Q1i13y+S1+
 srH1ZpbJotctOVtJY7RpwQ6s+xRZ2hYmvcPxQ/8qN7MuT67LjYUV+hiH8DhMlCOyVGwX
 /I3/fROLTHkO7fNkWAwdK0wkGUb7r0i7VWTNeALrE5VsiJzc/DaKKo+L8H+IMqR+bzIC
 ZVya9FovaG0JoGFEU+yI9M6By7SHAfcXm8zX45W4dRPAMfxBp0P6iIY4gC13sSEt+efC
 TZ4Q==
X-Gm-Message-State: AOJu0YxkR+u63qYfHQ2oJSvDuVhnsVnavHYLAaaXTy3OqpC4nMlkaQJq
 Qpj5k6Vb/PQp6q0CWG6AA7k5JCOaiA3PGv4J8kgQe8WUhHQ76CIW44Yu1vg265v+svz3+WdPKQW
 D84SaYWS3C4dGkNJyM6ox7mXv+DT6GLDhR/WING0PPO3rrWw=
X-Gm-Gg: ASbGnctGDWIbJdoV/J28Xh1dxfm6TsQqrxtqEYNZ2E9EQGdP1d7p9rttDudQJw8leZN
 4Ha7Ix0xArdDVfgcPbsfqkbqUEraFIU0eM5ids/YcSvK2AYTzOokBTrghgFCUfJ8=
X-Google-Smtp-Source: AGHT+IH5bw3TNev5/qsf6xH6EebvbP3owLeYH2YzTD4beXhZdwUaqPgy45kAHw0yYMqglaL3yRgPQlV7gJsqIYPoCe0=
X-Received: by 2002:a17:906:478d:b0:ab2:b610:35fb with SMTP id
 a640c23a62f3a-ab38b191888mr3408678666b.3.1737845845962; Sat, 25 Jan 2025
 14:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20250124185605.372347-1-sjg@chromium.org>
 <20250124192056.GU60249@bill-the-cat>
 <CAFLszTjowGVr2R0=bz-h=sU0NHjP8CDaF04cfO1Kbh8d8F5nFA@mail.gmail.com>
 <20250125183025.GB60249@bill-the-cat>
 <CAFLszThbkdt_RqvDGr6nV4QvFG4u6z1uh7Yu=65es_ZA3_5tEQ@mail.gmail.com>
 <20250125220119.GG60249@bill-the-cat>
 <CAFLszTgw+u3rQ8N3vqB1bZ6RdOY_poJUO_WULQ-Q+q28S46FaA@mail.gmail.com>
 <20250125225331.GI60249@bill-the-cat>
In-Reply-To: <20250125225331.GI60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 15:57:14 -0700
X-Gm-Features: AWEUYZnjk323zX2HJEs3HZqk8iHSFKvngZ9q3ENdFh_cOAr45738YmBGhKTQ2hQ
Message-ID: <CAFLszTiiVcjt89cGg8SSHbM+PUQOq4_D17eLvfKZRvBxqP_5pQ@mail.gmail.com>
Subject: Re: [PATCH] test/py: Add a report show test durations
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

On Sat, 25 Jan 2025 at 15:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 03:50:02PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 25 Jan 2025 at 15:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jan 25, 2025 at 02:36:52PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 25 Jan 2025 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Jan 25, 2025 at 10:14:05AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 24 Jan 2025 at 12:21, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jan 24, 2025 at 11:56:04AM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > Execution time varies widely with the existing tests. Provides a summary
> > > > > > > > of the time taken for each test, along with a histogram.
> > > > > > > >
> > > > > > > > Example:
> > > > > > > >
> > > > > > > >    Duration : Number of tests
> > > > > > > >    ======== : ========================================
> > > > > > > >        <1ms :  1
> > > > > > > >        <8ms :  1
> > > > > > > >       <20ms : # 20
> > > > > > > >       <30ms : ######## 127
> > > > > > > >       <50ms : ######################################## 582
> > > > > > > >       <75ms : ####### 102
> > > > > > > >      <100ms : ## 39
> > > > > > > >      <200ms : ##### 86
> > > > > > > >      <300ms : # 29
> > > > > > > >      <500ms : ## 42
> > > > > > > >      <750ms : # 16
> > > > > > > >       <1.0s : # 15
> > > > > > > >       <2.0s : # 23
> > > > > > > >       <3.0s :  13
> > > > > > > >       <5.0s :  9
> > > > > > > >       <7.5s :  1
> > > > > > > >      <10.0s :  6
> > > > > > > >      <20.0s :  12
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > >  test/py/conftest.py | 77 +++++++++++++++++++++++++++++++++++++++++++++
> > > > > > > >  1 file changed, 77 insertions(+)
> > > > > > >
> > > > > > > Whitespace issues aside,
> > > > > >
> > > > > > Do you mean the blank lines? pylint wants those for top-level items.
> > > > >
> > > > > That's weird but OK.
> > > > >
> > > > > >  we should probably not do this every time, just
> > > > > > > when requested.
> > > > > >
> > > > > > I'd like to see it on each run, actually. It doesn't take any time to
> > > > > > calculate and it lets us see where the time is going.
> > > > >
> > > > > We already print the full time, and I think knowing what the tests are
> > > > > that take so long, so that we can see if there's anything to do about
> > > > > it, would be more helpful. The general feedback about our pytests today
> > > > > is they're already too verbose in the normal case.
> > > >
> > > > This is what is shown in the full output (although with CI you have to
> > > > download the files to see it):
> > > >
> > > > [-] Section: Timing Report
> > > [snip]
> > >
> > > This is handy as a one-off, and maybe hints at a few tests to look at
> > > more, but perhaps it's mostly "is what it is" tests (and not just the
> > > sleep test).
> >
> > Perhaps, but I would hope we could speed some of these up, or reduce
> > the number of variations.
>
> Looking at it, all I see is a sample that yes, we should see if there's
> some way to speed up output from U-Boot to python. None of the "long"
> tests look otherwise out of line for what they're doing.
>
> > > > TIME: SINCE-SECTION: 0:00:00.004227
> > > >
> > > > This is just the summary which is visible in CI:
> > > >
> > > > [-] Section: Timing Summary
> > > > TIME: NOW: 2025/01/25 14:28:57.730179
> > > > TIME: SINCE-PREV: 0:00:00.004234
> > > > TIME: SINCE-START: 0:02:00.307984
> > > > TIME: SINCE-SECTION: 0:00:00.000041
> > > > Duration : Number of tests
> > > > ======== : ========================================
> > > >     <4ms :  1
> > > >     <8ms :  1
> > > >    <10ms :  3
> > > >    <20ms : #### 47
> > > >    <30ms : ######################################## 377
> > > >    <40ms : ############################# 278
> > > >    <50ms : ####### 69
> > > >    <75ms : #### 47
> > > >   <100ms : # 18
> > > >   <200ms : ### 29
> > > >   <300ms : # 15
> > > >   <400ms : # 13
> > > >   <500ms :  8
> > > >   <750ms :  6
> > > >    <1.0s :  2
> > > >    <2.0s :  9
> > > >    <3.0s :  3
> > > >    <4.0s :  4
> > > >    <5.0s :  2
> > > >    <7.5s :  2
> > > >   <20.0s :  1
> > > >
> > > > So what do you think would make most sense?
> > >
> > > By default, neither of these, and only when requested. Looking over at
> > > one of your runs, no, I don't want to waste more output space. If you
> > > must do something, log it off to examine later and not add to the main
> > > output.
> >
> > OK, I'll just put it in my tree for now.
>
> Sigh.
>
> > BTW what do you mean by 'by default'? What other way of running would
> > there be? Are you thinking of a CI flag?
>
> I mean passing some flag to pytest, like you do what you want more
> verbose output, or less output. I don't see this as something that adds
> value to run every time.

OK, we could do that. But I really like seeing the info in gitlab.
Perhaps we could have it appear just for the one 'sandbox' test?

Regards,
Simon
