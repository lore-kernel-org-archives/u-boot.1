Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D93FC0218D
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D79780F4E;
	Sat, 25 Jan 2025 23:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="beyO56Mv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A063680F52; Sat, 25 Jan 2025 23:50:16 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8592C80EB5
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaef00ab172so531901466b.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737845414; x=1738450214; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PhyhT5dVCyhyV4GOK4Fv6xRp3YcKiZrMnq2qlYGaCGM=;
 b=beyO56MvvLGtWZ8kyl22QxUuw0BzRa3/C3NRX+/tzm7s7IPt7Q3HiORlPmbkwHUdSW
 AHxmcWbTirJuO+yGWIhfJhKLoQCBhQxXvE4WgygD8uOLPopGuexPKwhqppUJuIwOoPQa
 xZr53+1SYnDo7eUdMxCV6g59h2QZOMlHBDPaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737845414; x=1738450214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PhyhT5dVCyhyV4GOK4Fv6xRp3YcKiZrMnq2qlYGaCGM=;
 b=gD+R+qr/oiYewwjwdxdKbajuYZord+Jd8y4coQiiSeXdIP7DH+BJuV8o+p9K6Et8w2
 mRbAKukjfSatrOBl2uvXSdbPDJ1tZcYIeNezBgPkSrIMUW+azrlkz7deOoNy7+0po4+y
 g2QR4AQ7xwvfqMP6Lb4y/0/iRRE+eWEofr13/Ac5IQ02IKjECm+kM+dsMvhcKrelpdEr
 jM3UaStfeI00k7VxjnqX1oXsMdM0VCPph1QDecdfg55mxvWALXqqH+zPr7zERsrFLLvF
 M0v7+55BXPzc3VHpBEpmcADDZLxNzpWLm8tKi8//0pv3KD3ib2pscn8/aCdNLGug5MBI
 ycag==
X-Gm-Message-State: AOJu0YwrJFjP1v22AQUbPJG5lSG9cSl1u5PKDK36GGZbG9MVQxRA9UIN
 q3TtBYUjTmgl6max6s8yK1xcieMV/EeK0W3jlAUc+mro50jl/1SFdPuxqzXauzHIjiT/wxDsc0K
 ZL+n6W5mTRzuOVx28Fo1FrZZ0mObRDGdnX3+A95yEy7cwcf4=
X-Gm-Gg: ASbGncsff+TGEj8RQDp/7QztF6mOb0CN+sl8iF9P3pPrFy+AW4tsz/uNSOzxhJnss2E
 3VrMyxHUwHIvg5Q7Sliq7x3XXhdC+kij6giLv7wBJ6zN2bTRDkWqL5EeCM1PYnsU=
X-Google-Smtp-Source: AGHT+IHKFYlmUXayMUubwQeSUvr4+unanzFJigsyKiV3MMmlDDlGfyY4XtLKN0r01r3YZ62LKXY4/JrrRzOusVC76Sg=
X-Received: by 2002:a05:6402:5106:b0:5d0:ced8:d22d with SMTP id
 4fb4d7f45d1cf-5db7db07334mr79550444a12.22.1737845413984; Sat, 25 Jan 2025
 14:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20250124185605.372347-1-sjg@chromium.org>
 <20250124192056.GU60249@bill-the-cat>
 <CAFLszTjowGVr2R0=bz-h=sU0NHjP8CDaF04cfO1Kbh8d8F5nFA@mail.gmail.com>
 <20250125183025.GB60249@bill-the-cat>
 <CAFLszThbkdt_RqvDGr6nV4QvFG4u6z1uh7Yu=65es_ZA3_5tEQ@mail.gmail.com>
 <20250125220119.GG60249@bill-the-cat>
In-Reply-To: <20250125220119.GG60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 15:50:02 -0700
X-Gm-Features: AWEUYZm0Id0db6KbMhLCnPLovRPhqVrlTrebifTPEb8kXHvYFt9V8flN0qUTICY
Message-ID: <CAFLszTgw+u3rQ8N3vqB1bZ6RdOY_poJUO_WULQ-Q+q28S46FaA@mail.gmail.com>
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

On Sat, 25 Jan 2025 at 15:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 02:36:52PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 25 Jan 2025 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jan 25, 2025 at 10:14:05AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 24 Jan 2025 at 12:21, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Jan 24, 2025 at 11:56:04AM -0700, Simon Glass wrote:
> > > > >
> > > > > > Execution time varies widely with the existing tests. Provides a summary
> > > > > > of the time taken for each test, along with a histogram.
> > > > > >
> > > > > > Example:
> > > > > >
> > > > > >    Duration : Number of tests
> > > > > >    ======== : ========================================
> > > > > >        <1ms :  1
> > > > > >        <8ms :  1
> > > > > >       <20ms : # 20
> > > > > >       <30ms : ######## 127
> > > > > >       <50ms : ######################################## 582
> > > > > >       <75ms : ####### 102
> > > > > >      <100ms : ## 39
> > > > > >      <200ms : ##### 86
> > > > > >      <300ms : # 29
> > > > > >      <500ms : ## 42
> > > > > >      <750ms : # 16
> > > > > >       <1.0s : # 15
> > > > > >       <2.0s : # 23
> > > > > >       <3.0s :  13
> > > > > >       <5.0s :  9
> > > > > >       <7.5s :  1
> > > > > >      <10.0s :  6
> > > > > >      <20.0s :  12
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > >  test/py/conftest.py | 77 +++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 77 insertions(+)
> > > > >
> > > > > Whitespace issues aside,
> > > >
> > > > Do you mean the blank lines? pylint wants those for top-level items.
> > >
> > > That's weird but OK.
> > >
> > > >  we should probably not do this every time, just
> > > > > when requested.
> > > >
> > > > I'd like to see it on each run, actually. It doesn't take any time to
> > > > calculate and it lets us see where the time is going.
> > >
> > > We already print the full time, and I think knowing what the tests are
> > > that take so long, so that we can see if there's anything to do about
> > > it, would be more helpful. The general feedback about our pytests today
> > > is they're already too verbose in the normal case.
> >
> > This is what is shown in the full output (although with CI you have to
> > download the files to see it):
> >
> > [-] Section: Timing Report
> [snip]
>
> This is handy as a one-off, and maybe hints at a few tests to look at
> more, but perhaps it's mostly "is what it is" tests (and not just the
> sleep test).

Perhaps, but I would hope we could speed some of these up, or reduce
the number of variations.
>
> > TIME: SINCE-SECTION: 0:00:00.004227
> >
> > This is just the summary which is visible in CI:
> >
> > [-] Section: Timing Summary
> > TIME: NOW: 2025/01/25 14:28:57.730179
> > TIME: SINCE-PREV: 0:00:00.004234
> > TIME: SINCE-START: 0:02:00.307984
> > TIME: SINCE-SECTION: 0:00:00.000041
> > Duration : Number of tests
> > ======== : ========================================
> >     <4ms :  1
> >     <8ms :  1
> >    <10ms :  3
> >    <20ms : #### 47
> >    <30ms : ######################################## 377
> >    <40ms : ############################# 278
> >    <50ms : ####### 69
> >    <75ms : #### 47
> >   <100ms : # 18
> >   <200ms : ### 29
> >   <300ms : # 15
> >   <400ms : # 13
> >   <500ms :  8
> >   <750ms :  6
> >    <1.0s :  2
> >    <2.0s :  9
> >    <3.0s :  3
> >    <4.0s :  4
> >    <5.0s :  2
> >    <7.5s :  2
> >   <20.0s :  1
> >
> > So what do you think would make most sense?
>
> By default, neither of these, and only when requested. Looking over at
> one of your runs, no, I don't want to waste more output space. If you
> must do something, log it off to examine later and not add to the main
> output.

OK, I'll just put it in my tree for now.

BTW what do you mean by 'by default'? What other way of running would
there be? Are you thinking of a CI flag?

Regards,
Simon
