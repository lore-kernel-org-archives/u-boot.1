Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B155C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 14:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E8A80EE5;
	Thu, 13 Feb 2025 15:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WfdptN5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59EDA80ECC; Thu, 13 Feb 2025 15:01:23 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E01D80ECB
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5de47cf9329so1442916a12.3
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739455281; x=1740060081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vEwVxOrnQujFgmV9SAb2q0KNik1qDBKI6L+dg31b/ig=;
 b=WfdptN5qIMTis+Th9emoOB9ZCUL56yiVYSp8IVTUkCt1CDafA5JXFn8jSYgI6jOovO
 za6VGC0WBiYo57wJcyZA0HDIVc3pF9VBZGfXRQO7kNOhRwjGl/51dz8vAHcvN2QCkWu/
 iP3V7OspLREAG4N4Hkwok/sKZAwZbd+p+Vj0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739455281; x=1740060081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vEwVxOrnQujFgmV9SAb2q0KNik1qDBKI6L+dg31b/ig=;
 b=JwtCIDyNeBKK6QSEVlH0iZM6QrMsPAqlNuVQZc4Q1Dm24OkyeRG1qtAbKBi8XZSxYk
 Gm3YebpG+a4+pmthYDw4r2kWiFAp+tC6JBs7gg2999ZVQwdaby5IgDwH6/Xg1w8mTRIr
 rCuyj3U803yOkRJZNNOG4mQhVof9xfLqfr/ypi8Vcexel/PQeeFLfHLrpnPHc+KsX2iw
 27xwm3gC0LFaUoNXt/x/DelBYEd1L3S6SQxH2AXpka3P7t9zLriROOcq6VEfI6ucL4yA
 KdTIFinDbE5NNXzqMn48dj8h4hDvf8aGAjODwperm7AGVPm3Sz/SkcbzBZl9xKO9LPUd
 kI6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdCZk+VDGmxUXlKVZYG6XKkPTJ3CV7cpoh/gF4kaHivrWp04mF5Re9fe9ndt/dB9vc0HhsCd0=@lists.denx.de
X-Gm-Message-State: AOJu0YzZOWzbUOQfz8hvU6q0dv8krC4dypBVJ8iHerjq+W0tr6Vu1ZGW
 wdKvuXvV3ALK8U6IACpOZpjlYWP8163OE4UxmTJw8ER9syO1REoa+NG2tn8gXTLz899RvzlOwXl
 pNZ08zRl5bZ8KFgouiiuybjaxix3+GeibCa7f
X-Gm-Gg: ASbGnctUQ0oAGyH/R9JUgDM5jyBlQmHGIbPB2IcWEW9Hxdg8hCtoc5jOsjs0JUnRqWK
 qryDT5p/r++TDKhjOOwSBVqDS232pgNK/0WMRTUAeAmmK1rF4YmEodN4k8OxXOlTsp0FBpk/6C9
 1RQdxRbgqc1M6XSKFxtt6ozgynrV4X
X-Google-Smtp-Source: AGHT+IEy+CLGY0Wn5ptYEXIFLLd9nLOI/5ZE30Cr+mPLpDTjue+TZ+8hXhj5swfOi2Hq632MyjH3fEDQSnB4HVH5q/4=
X-Received: by 2002:a05:6402:234c:b0:5d2:8f70:75f6 with SMTP id
 4fb4d7f45d1cf-5deb0bfb160mr6049240a12.30.1739455278900; Thu, 13 Feb 2025
 06:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
 <CAFLszTgFvp_YYHZ5GzvZAfLmWeGmoTW5_vhM88ebd7RoA3Mo=g@mail.gmail.com>
 <54732a43eeea4e18829a0c1d561110d9de07e286.camel@phytec.de>
In-Reply-To: <54732a43eeea4e18829a0c1d561110d9de07e286.camel@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Feb 2025 07:01:03 -0700
X-Gm-Features: AWEUYZnSak7CU9_Yx08oBmp3tRCajWTQVCmfXkZKemVEO3tCGPFqoOXV6O_dN0Q
Message-ID: <CAFLszTik+WRQUb8++nvZxdNPeipeOCyFwMF+WaVJZ95-peHY9Q@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] binman: doc: update Optional entries
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

On Thu, 13 Feb 2025 at 00:21, Yannic Moog <Y.Moog@phytec.de> wrote:
>
> On Mon, 2025-02-10 at 06:08 -0700, Simon Glass wrote:
> > On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
> > >
> > > The binman documentation of Optional entries is not accurate in the
> > > sense that it does not cover blobs entry type. As this is also the most
> > > widely used type to have the optional entry, document the interaction
> > > with faking blobs.
> > >
> > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > ---
> > >  tools/binman/binman.rst | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> > > index 990fc295770..2bafa6ca408 100644
> > > --- a/tools/binman/binman.rst
> > > +++ b/tools/binman/binman.rst
> > > @@ -1145,7 +1145,14 @@ called on all entries.
> > >  It is not possible for an entry to mark itself absent at any other point in the
> > >  processing. It must happen in the ObtainContents() method.
> > >
> > > -The effect is as if the entry had never been present at all, since the image
> > > +The effect depends on the type of entry.
> > > +
> > > +Blobs
> > > +~~~~~
> > > +For blobs, the effect depends on whether --fake-ext-blobs is passed
> > > +to binman. (This is the case by default)
> > > +In case --fake-ext-blobs is set, any missing entries will be faked.
> > > +If not set, it is as if the entry had never been present at all, since the image
> > >  is packed without it and it disappears from the list of entries.
> >
> > I'm not quite following this. The text seems OK but your heading
> > implies that things other than blobs can be faked. All of this
> > functionality is only for blobs.
>
> The heading is a subsection of "Optional entries". To my knowledge the "optional" property is not
> limited to blobs. But blobs get special treatment in regards to "optional" due to the --fake-ext-
> blobs option. Hence the subsection.
>
> What would you like me to change to make this clearer?

Oh I see. Are you saying that optional entries end up in the image
when they are faked, external blobs? If so, that seems like a bug to
me.

Regards,
Simon
