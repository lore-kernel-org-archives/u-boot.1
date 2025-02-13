Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0D2C021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 14:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42CEB80A55;
	Thu, 13 Feb 2025 15:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VCZNlwFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE81807D9; Thu, 13 Feb 2025 15:01:30 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C49C80A55
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab7b80326cdso171323566b.3
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739455287; x=1740060087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fJEuA0Xv6jje4wt5uAms66ky20E2aLqEOi4lDjrIDaw=;
 b=VCZNlwFqA5+3Van0zvQZiu2UgJsmIsaYMWoxDOa7DQBjcU5QBLsRcfyjCYPgeQ+Sx4
 IR8MotmGzWg/oqCi98JiqteU+CEZ1ujWmITHpTjNHjiTHD0hrPhIlFWsvm5JqX76al2+
 UPZIjIkEX1ejUB6lYweGeZaJHghab1vmGDKMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739455287; x=1740060087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fJEuA0Xv6jje4wt5uAms66ky20E2aLqEOi4lDjrIDaw=;
 b=AqAQM21s+EUNvFn1tYUF9Gdld+pIcASS+yGe8szDju+OLT361KmLhVcoEbkpKSqQtn
 ywVQBNABzBaxrCKpF9fPq5yGxjLmqlFdZE0gafIYWBPe9LuZJe6oX7CX2+4Qn3n1Fh8A
 l4lT9DWyBZlw7cEV9mC8SfhBjKtHk6dQ82nQCq6klLOsYQeSn3lg+gRURz9rq8cOOQqZ
 rj9EQ+PVrUhZ34zaGNcP2XcBEFvgZxZA8vI8j4B7xICAl/cIGzqURhFqyLFSE0U24Byt
 65UZV57g0a66CdDw0FQs02l4WSm2r9qS193E3NZ11Q1r6U/goYxOyesMAOihXGepmsZw
 RsMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxP6qQiftr9CFeE1gNTf2fiCgAiryxGNmDOMTjR0Y1iciSpQCfYo+oBVuVrrEhiuu9ODU1MWg=@lists.denx.de
X-Gm-Message-State: AOJu0YynqAaZjqzDuK0TsgP7pHpgz3l1BSt3qNoX0EWijkcwfmuxDWYZ
 ww4PgIwiZWcYsNPAAEZXWQCDcXB/V2pgzU16bPOThjGaFkVWRDDZdE60nQtzdAf1a5yRUZ7yOwp
 wFDlibxPTaxLpdWpmLGS23xd85ctt1bBjvGvyw8iFP3Nehqg=
X-Gm-Gg: ASbGnct67Z6O/bTxv9UiIEqYuwIf6zthk5HVGqF/eVKFVkYwDvj9Rw6DlaKQ7opahME
 qI8XRWnxLXeIcAlZ11d/+0ldmdqkEdn5B1LnhDPyB8jQx+y3is0iOA9UyF51U81ZoRE69BtmLEi
 ePmcFqsYJLzKZHYz5owcmGUBTj7LHi
X-Google-Smtp-Source: AGHT+IGVks0wVzOKK16dIcvVOnPUse2u8s31xS/ZGxVNlu7iCoOXrlfuPXhMdW+lfIaFDa1B9MHCFdvv7mj0BwJrAvU=
X-Received: by 2002:a05:6402:34d2:b0:5dc:a44f:6ec4 with SMTP id
 4fb4d7f45d1cf-5dec9e7baf8mr2755147a12.13.1739455276009; Thu, 13 Feb 2025
 06:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-1-a4534bc67cbb@phytec.de>
 <CAFLszThHLn4+W0J0sdz=o84wObuYf20YhKV8XbxAGmAsct-8Vg@mail.gmail.com>
 <454617aa2ec54390e0fd40ff4693ba3b559cefc4.camel@phytec.de>
In-Reply-To: <454617aa2ec54390e0fd40ff4693ba3b559cefc4.camel@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Feb 2025 07:01:01 -0700
X-Gm-Features: AWEUYZk-o4vBa6YlmoLpyHtzWqDT7SH6-Mas9PGXJKZ2dOAU89tcgMSHXbY_M88
Message-ID: <CAFLszTgQRzJh-fDn=qqh3_p5boeraOqwCOK0ivAABZWt0w1eiA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/6] tools: binman: ftest.py: fake ext blobs per
 default
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, 
 "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, 
 Yashwanth Varakala <Y.Varakala@phytec.de>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Teresa Remmet <T.Remmet@phytec.de>
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

Hi Yannic,

On Thu, 13 Feb 2025 at 00:15, Yannic Moog <Y.Moog@phytec.de> wrote:
>
> Hi Simon,
>
> On Mon, 2025-02-10 at 06:06 -0700, Simon Glass wrote:
> > Hi Yannic,
> >
> > On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
> > >
> > > The top level Makefile calls binman with fake-ext-blobs.
> > > The test setup should reflect this to spot potential bugs before
> > > reaching users.
> > >
> > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > ---
> > >  tools/binman/ftest.py | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > > index a553ca9e564..1f194f9ecae 100644
> > > --- a/tools/binman/ftest.py
> > > +++ b/tools/binman/ftest.py
> > > @@ -372,7 +372,7 @@ class TestFunctional(unittest.TestCase):
> > >      def _DoTestFile(self, fname, debug=False, map=False, update_dtb=False,
> > >                      entry_args=None, images=None, use_real_dtb=False,
> > >                      use_expanded=False, verbosity=None, allow_missing=False,
> > > -                    allow_fake_blobs=False, extra_indirs=None, threads=None,
> > > +                    allow_fake_blobs=True, extra_indirs=None, threads=None,
> > >                      test_section_timeout=False, update_fdt_in_elf=None,
> > >                      force_missing_bintools='', ignore_missing=False, output_dir=None):
> > >          """Run binman with a given test file
> > >
> > > --
> > > 2.43.0
> > >
> >
> > I would like this default to stay the same (False) because that is the
> > normal case for Binman. We should expand the test-coverage as needed.
>
> Can you help me understand why we fake blobs in the call to binman when building U-Boot?
> You say that not faking is the normal case so why are we doing something abnormal in the top-level
> Makefile?

I mean that not faking is the normal case for Binman's code base. Yes,
U-Boot requests faking.

>
> I think that this inconsistency is a potential for bugs going unnoticed so whatever we decide to do
> I would very much like to be consistent with testing and "normal" builds.

Binman is tested by its own tests which handle both cases, so we don't
have a test gap there.

Regards,
Simon

>
> Yannic
>
> >
> > Regards,
> > Simon
>
