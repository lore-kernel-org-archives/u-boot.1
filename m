Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EBEC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 13:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 027EE80756;
	Fri, 14 Feb 2025 14:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OkqfGdc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B30A80DF7; Fri, 14 Feb 2025 14:49:08 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C5F806FE
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 14:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ab7e3d0921bso370050166b.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 05:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739540946; x=1740145746; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OlQeXi8SIY2SPOZOQD21nyXU0k/1xyuaScDAtowRE+U=;
 b=OkqfGdc8d9kE9VlNbJcZxaSpb5oOXnY+AGmUPym4crvoyqqOZk/1fOC9cJ++AKFhH8
 Bdx8E5hjgp1EgTwww0VyJmUTk53iHsocJUo+QdmVLXa7rqGHk2alZ6wPrWwhgQHAbxy7
 +jSpdOAum69QUXVqaxkxFUVGsis48uwMPaaRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739540946; x=1740145746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OlQeXi8SIY2SPOZOQD21nyXU0k/1xyuaScDAtowRE+U=;
 b=wP7g/iIJUSlZ7vIwZ5sTq8eAS8GOEFalngakiO7pPA3eVLngw6UJ7DNR2JxM6Fh+i5
 cQBaN0sKdopVmMXr3wPLD1dkMVEqoJd9jmYtueGdc85oDLnvQQG3g2p+eOlGBtW75iFZ
 v/mgtfxiGOw/rx5uULhysyGpy2kPIMO1dMGkJ3AQL30MIeZtc5po+MIz9+n6GECY9GPl
 vEqUy56fbR9sSG8FmiUr+SF/rPfuE1LcWP1xmb3n9c77FO9+XyE5q64VP0yhgrhOCb9Z
 6vRkLnWBFSCKWK666+SfphtulAB96WqLo2lNjePAJioYedOdIG8CCngDcZl2pjR0uCca
 BhLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWPC0dg6vkHL6PLzqfH8MGd9tLbcHyNKF+YNwCu7yC2sjDhkSW2yTv+8KnGFt1mBqamEy4Mic=@lists.denx.de
X-Gm-Message-State: AOJu0YznNfenWtMQa3KZRgLxCEKWJyUrFenBvdVeS+Zo57lgPAZGsyVp
 rZrKFXfMJmZ0nYLuv80xDoj/hJXlYwjVbKgGyE9WtPX/iDoACjSIXxC6ti29Od+n55DCEs/YIYz
 tW1ImkTrHX+xx7RF6gCHzZKApN8Q8ouwHePkv
X-Gm-Gg: ASbGncv643y1iJFqq0NBweeAa1rYYdnJ4bJpehNMtB5uiWZIsTUKI0QuLy/GeEeLgX5
 lUCZwP+Bh4cfXuqE3Y6pnKqmAReMKbBU3Fm/Ch5we/msZVrZUBGdCgp5p6eb9ThbaUwTdReGkBU
 ncaqMiUL43CyqTbPRZ+reHgkOXxvKj5w==
X-Google-Smtp-Source: AGHT+IH1erQfAmFHQXIH1beaJSHTXIKrLHCO+AVQ8kOVGeKuN/Pu84InS9YF7xhA7SXm7OoypQyUsQPBizgyddBSLTs=
X-Received: by 2002:a17:907:944b:b0:ab7:6c4a:6a74 with SMTP id
 a640c23a62f3a-aba4eba8348mr750103066b.16.1739540945777; Fri, 14 Feb 2025
 05:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-1-a4534bc67cbb@phytec.de>
 <CAFLszThHLn4+W0J0sdz=o84wObuYf20YhKV8XbxAGmAsct-8Vg@mail.gmail.com>
 <454617aa2ec54390e0fd40ff4693ba3b559cefc4.camel@phytec.de>
 <CAFLszTgQRzJh-fDn=qqh3_p5boeraOqwCOK0ivAABZWt0w1eiA@mail.gmail.com>
 <9a0969442915d922caedeb9fa9dd7c56dc3fa1ed.camel@phytec.de>
In-Reply-To: <9a0969442915d922caedeb9fa9dd7c56dc3fa1ed.camel@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Feb 2025 06:48:53 -0700
X-Gm-Features: AWEUYZk7_QBQyx0F4HAD6K9ywja1QBcNNWAKyDcG88TCY9E6oDT6cKNKOfmq-Fk
Message-ID: <CAFLszTgdM3U3foHUKsXQY3SSs0-Gb1MpJOsW0KB+t1Wt=NUsWg@mail.gmail.com>
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

On Fri, 14 Feb 2025 at 00:18, Yannic Moog <Y.Moog@phytec.de> wrote:
>
> Hi Simon,
>
> On Thu, 2025-02-13 at 07:01 -0700, Simon Glass wrote:
> > Hi Yannic,
> >
> > On Thu, 13 Feb 2025 at 00:15, Yannic Moog <Y.Moog@phytec.de> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Mon, 2025-02-10 at 06:06 -0700, Simon Glass wrote:
> > > > Hi Yannic,
> > > >
> > > > On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
> > > > >
> > > > > The top level Makefile calls binman with fake-ext-blobs.
> > > > > The test setup should reflect this to spot potential bugs before
> > > > > reaching users.
> > > > >
> > > > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > > > ---
> > > > >  tools/binman/ftest.py | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > > > > index a553ca9e564..1f194f9ecae 100644
> > > > > --- a/tools/binman/ftest.py
> > > > > +++ b/tools/binman/ftest.py
> > > > > @@ -372,7 +372,7 @@ class TestFunctional(unittest.TestCase):
> > > > >      def _DoTestFile(self, fname, debug=False, map=False, update_dtb=False,
> > > > >                      entry_args=None, images=None, use_real_dtb=False,
> > > > >                      use_expanded=False, verbosity=None, allow_missing=False,
> > > > > -                    allow_fake_blobs=False, extra_indirs=None, threads=None,
> > > > > +                    allow_fake_blobs=True, extra_indirs=None, threads=None,
> > > > >                      test_section_timeout=False, update_fdt_in_elf=None,
> > > > >                      force_missing_bintools='', ignore_missing=False, output_dir=None):
> > > > >          """Run binman with a given test file
> > > > >
> > > > > --
> > > > > 2.43.0
> > > > >
> > > >
> > > > I would like this default to stay the same (False) because that is the
> > > > normal case for Binman. We should expand the test-coverage as needed.
> > >
> > > Can you help me understand why we fake blobs in the call to binman when building U-Boot?
> > > You say that not faking is the normal case so why are we doing something abnormal in the top-
> > > level
> > > Makefile?
> >
> > I mean that not faking is the normal case for Binman's code base. Yes,
> > U-Boot requests faking.
> >
> > >
> > > I think that this inconsistency is a potential for bugs going unnoticed so whatever we decide to
> > > do
> > > I would very much like to be consistent with testing and "normal" builds.
> >
> > Binman is tested by its own tests which handle both cases, so we don't
> > have a test gap there.
>
> Sorry, I am still stumped here. I feel like my question as to why U-Boot requests faking has not
> been answered above. Can you please explain that again?

U-Boot needs to use fakes largely because in some cases the fake is
passed to mkimage, which sometimes cannot operate at all if there is a
missing or zero-sized file. So we create a fake just so that the build
will succeed (with warnings).

>
> And I am left a bit confused since I thought these RFC patches show that there indeed was a test gap
> (in a single test case testFitFirmwareLoadables only, but still) due to not faking external blobs.
> Is it not possible that there are other potential problems in regards to faking blobs that we have
> not discovered, yet?

Yes, please fix the test gap and if there are other tests we need to
add, we should add them. The goal of Binman is 100% test coverage. But
faked blobs are more of an unfortunate workaround, not the primary
goal of Binman. So I would like tests to explicitly select faked blobs
when needed, rather than having this on everywhere. It should only
affect a very small amount of tests which deal with the pain of
external blobs.

Regards,
Simon
