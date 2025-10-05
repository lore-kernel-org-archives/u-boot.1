Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB3ECAC5BB
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 06:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE6C809A5;
	Sun,  5 Oct 2025 08:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g2JMTk/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19A98206E; Sun,  5 Oct 2025 08:38:36 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69DD4808AF
 for <u-boot@lists.denx.de>; Sun,  5 Oct 2025 08:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so33336165e9.2
 for <u-boot@lists.denx.de>; Sat, 04 Oct 2025 23:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759646314; x=1760251114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2VZ7EfE9AUggSem9zhcRWBhzrHYADLpTsqQqot4tQ8=;
 b=g2JMTk/mVMUU3NZrzDkABo4wdz7tUl3Kq1sa/twAknCNO7BNU9x/1GblH1rGFeoW7R
 OgYKuOs5IyTgX7pismrcuF4PYwgjAKLvrr66Wt+rfu+XA3C0sqs4ylCXESSVZEpLwowG
 uRtxUbqfblzREwUUPuJZBYiOcQM1KU1dpj49czNLfDLRtqj1o9UulF09MXcf1ULm6+lb
 To4uuZFC2y2nE5WFefuCefi9AJurLisuvg6BHrIoGKQiaRL3b7LPWnQiLHKGmj+xnqJk
 5y137N5OVIJhUPRUZKBSMGhr0SGBB1NJupXoEnLrBpSqOKgd9KB1QX5lF/TrOJ6Jrd2N
 ShEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759646314; x=1760251114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b2VZ7EfE9AUggSem9zhcRWBhzrHYADLpTsqQqot4tQ8=;
 b=jEdF4C5ybHPof8SIJtGk3Q9Mhovy2jODGXvG7r/owr/xYdiYSqW6U7EBGhy8yv5hy9
 7GB7I2b3tcbfQvWYx/aUN+FI1BwpmJT0QHk8LHgin4MTq11tTEhwA+nTu2UgfwhNufk8
 VMp2/D6RZyH4LMgExqOdfqyp+FVtOVqa9qJdyIzYvs7idykN10XoOBfpJkeEN/4IVJwG
 p9Cv/AI+dNFsMYnYm4GL4s0eCIR21ffxiPfb/Fsw11blzggB1+E2pbhydh72AaEc9lKh
 fOGA9Ycl1lnRYyYMeRmcri3YTCRxVphrHfYr2VTuAVLTf6NV9VB9KGM5m30OU5rMl527
 Betw==
X-Gm-Message-State: AOJu0YwQmOI0UDDxM9Ucwz3F30K4eInU9wa6uF1YjWOmnE6Cpwfr3JPn
 ++5nI7rGO4Q/NdHe7aAzpB7YpYUJint0XJShJy6WbLJ9Tl5frYyw56mRNaSqMRMS
X-Gm-Gg: ASbGnctG2c/CEVTG8uVCCs0nLRshbrkeH2dHteXpttOMgbm0KWlVC0fQ0zLilBoCr1+
 iHRxH5z8Ctq42XJLH1crbt67n0vfJADDuBS8g3V2ucGIYFa1+M603QHFk5OoSAc250pqIeia10T
 vZDd/8lI3Txol5HpgTn2A9KHTrQexho8hB8fdLhWfPah/pakxTE5rou1NG+QcPWkmCWsjHsoaML
 +QKq3zosE+v4BvBT7ZiwwbKd54WvxDMJCNr6SSDObY3ZjYBTecfSmlrE5zcAtZo0g9BIwcfRsFM
 CLbJDpqHHMM9XZwAiSd8PnIVG7l4hNRpjY6Mre88Az3UtlFiUfP/HQm8nZhqT7WzRklLlmF1hbN
 X0c+zz7u2EkS1QZFUoNCyFl87asR59tQruOHA9TprVOIHXo+LlWbaqGy8AvRx2umqdzthKIwZ0J
 52fOVY8KrI1qP/3Egx/fSsN9rfg/bZ
X-Google-Smtp-Source: AGHT+IEEepuRZbTCL1qHdTwFrRwuVSeeABI6mNBxdPlXeLjcarbbq5KCkmIjoB8PR+tnQKJHPED96w==
X-Received: by 2002:a05:600c:8409:b0:46e:5aac:54f9 with SMTP id
 5b1f17b1804b1-46e7115c89fmr60446995e9.37.1759646313661; 
 Sat, 04 Oct 2025 23:38:33 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net.
 [178.79.73.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ac750sm15313849f8f.24.2025.10.04.23.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 23:38:33 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rudi Horn <dyn-git@rudi-horn.de>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH] Fix detection of odd memory configurations on sunxi
Date: Sun, 05 Oct 2025 08:38:32 +0200
Message-ID: <10731113.nUPlyArG6x@jernej-laptop>
In-Reply-To: <13857032.uLZWGnKmhe@jernej-laptop>
References: <56f44755-fca8-4364-905e-685e79fd1aea@rudi-horn.de>
 <20251005014021.4b1b035a@minigeek.lan> <13857032.uLZWGnKmhe@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 5. oktober 2025 ob 08:10:27 Srednjeevropski poletni =C4=8Das j=
e Jernej =C5=A0krabec napisal(a):
> Hi Andre!
>=20
> Dne nedelja, 5. oktober 2025 ob 02:40:21 Srednjeevropski poletni =C4=8Das=
 je Andre Przywara napisal(a):
> > On Mon, 11 Aug 2025 09:35:19 +0200
> > Rudi Horn <dyn-git@rudi-horn.de> wrote:
> >=20
> > Hi Rudi,
> >=20
> > thanks for sending a patch to address this long-standing issue!
> >=20
> > But ... ;-)
> >=20
> > > I encountered a bug where u-boot detects that my OrangePI zero 3 (wit=
h=20
> > > 1.5GB) has 2GB and crashes.
> >=20
> > As Jernej already said, this is a known limitation: we simply don't
> > support not-power-of-2 DRAM sizes at the moment.
> >=20
> > > The orangepi u-boot source code contains an additional
> > > modification in the `mctl_calc_size` which removes a quarter of the=20
> > > memory the
> > > calculated last address cannot be written to:
> > >=20
> > > https://github.com/orangepi-xunlong/u-boot-orangepi/blob/v2024.01/arc=
h/arm/mach-sunxi/dram_sun50i_h616.c#L1365-L1368
> > >=20
> > > I'm not entirely sure if there is some specific logic that applies to=
 this
> > > modifier, but it does fix the issue on my system.
> >=20
> > So can someone shed some light on how this is supposed to work? If I
> > understand the code correctly, it checks for *aliasing* between the
> > first and the last word of DRAM, which doesn't make much sense to me: I
> > would expect a simple write/verify to see if the last quarter of DRAM
> > is for real, or to check for a known aliasing pattern with this "odd"
> > setup (as in: last quarter is aliased to first or third quarter or
> > something), but checking those two words for aliasing seems wrong.
>=20
> Hm... I've never tested this patch on HW, so you might have a point. Stil=
l,
> I think testing for aliasing makes sense. Just writing and reading might
> not be enough due to possible caching (not necessarily in CPU).

I see where the confusion comes from. Rudi tried to replicate OrangePi code
but inadvertently used function for aliasing check instead of write/verify
as noticed by Andre.

While probably using OrangePi approach [1] would work fine, I learned to
distrust simple write/verify checks, especially when size is only 1 word.
I would be still more confortable to use current aliasing check, which uses
16 words check.

Best regards,
Jernej

[1] https://github.com/orangepi-xunlong/u-boot-orangepi/blob/v2024.01/arch/=
arm/mach-sunxi/dram_helpers.c#L48-L63

>=20
> I should have some board with non-power-of-2 RAM size somewhere. I'll try
> to find it and test this.
>=20
> >=20
> > And indeed the code also fires on a board with 512MB and 4GB, capping
> > the memory there as well (resulting in 384 MB and 3GB, respectively).
> > This is somewhat expected, as we never would expect aliasing between
> > those two particular words, I'd say.
> >=20
> > So since I don't have a board with an "uneven" DRAM size, can you
> > please test some ideas to detect this RAM setup?
> > - Read the content of the first word to not exist (@1.5GB), then write
> >   something else there, and see if you can read this back? Don't forget
> >   a write barrier (dsb();) when doing so.
> > - Write some test pattern to some known good DRAM locations, like the
> >   beginning of DRAM, @512MB, @1GB, and see if any of those values pop
> >   up @1.5GB, to see if there is an aliasing pattern?
> > - Can you post the exact label on that DRAM chip, so that we can see if
> >   we find a datasheet? I'd be curious about the actual organisation of
> >   the DRAM array.
> >=20
> > Jernej, do you happen to know how those DRAM chips are organised? Do
> > they just feature a non-power-of-2 number of rows or columns?
>=20
> I don't know details how such chips are organized internally. However,
> number of rows and columns was never power-of-2.
>=20
> Btw, I think I saw 3 GB DRAM boards too somewhere, but not sure where.
> Quick search confirms that 24 Gb DRAM chips also exists, so I would leave
> this check as general 3/4 size fixup, not limited to any capacity.
>=20
> >=20
> > Oh, and also this patch was heavily malformed - line breaks and spaces
> > instead of tabs. Please try to fix this. Simplest is probably "git
> > format-patch", then sending this via "git send-email". Your email
> > server seems to be postfix, so you could just give the SMTP details and
> > credentials to git.
> >=20
> > Cheers,
> > Andre
> >=20
> >=20
> > >=20
> > > I propose the following patch, but am open to any further suggestions.
> > >=20
> > > Thanks,
> > > Rudi Horn
> > >=20
> > > Note: Submitted in my personal capacity and is not affiliated with my=
=20
> > > employer.
> > >=20
> > >=20
> > >  From 2199f3b28e5fc853ed1921586358c33f3f1502d3 Mon Sep 17 00:00:00 20=
01
> > > From: Rudi Horn <dyn-git@rudi-horn.de>
> > > Date: Mon, 11 Aug 2025 08:58:34 +0200
> > > Subject: [PATCH] arch: arm: mach-sonxi: Fix detection of odd memory
> > >   configurations
> > >=20
> > > Fix detection of odd memory configurations. Previously 1.5GB devices =
were
> > > incorrectly detected as 2GB devices, causing u-boot to crash.
> > >=20
> > > Signed-off-by: Rudi Horn <dyn-git@rudi-horn.de>
> > > ---
> > >   arch/arm/include/asm/arch-sunxi/dram.h |  1 +
> > >   arch/arm/mach-sunxi/dram_dw_helpers.c  | 10 +++++++++-
> > >   arch/arm/mach-sunxi/dram_helpers.c     |  8 ++++++++
> > >   3 files changed, 18 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/include/asm/arch-sunxi/dram.h=20
> > > b/arch/arm/include/asm/arch-sunxi/dram.h
> > > index 0eccb1e6c28..7580421ca77 100644
> > > --- a/arch/arm/include/asm/arch-sunxi/dram.h
> > > +++ b/arch/arm/include/asm/arch-sunxi/dram.h
> > > @@ -44,6 +44,7 @@
> > >   unsigned long sunxi_dram_init(void);
> > >   void mctl_await_completion(u32 *reg, u32 mask, u32 val);
> > >   bool mctl_mem_matches(u32 offset);
> > > +bool mctl_mem_matches_upto(u32 offset);
> > >   bool mctl_mem_matches_base(u32 offset, ulong base);
> > >=20
> > >   #endif /* _SUNXI_DRAM_H */
> > > diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c=20
> > > b/arch/arm/mach-sunxi/dram_dw_helpers.c
> > > index 24767354935..5bcd2672465 100644
> > > --- a/arch/arm/mach-sunxi/dram_dw_helpers.c
> > > +++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
> > > @@ -146,5 +146,13 @@ unsigned long mctl_calc_size(const struct=20
> > > dram_config *config)
> > >          u8 width =3D config->bus_full_width ? 4 : 2;
> > >=20
> > >          /* 8 banks */
> > > -       return (1ULL << (config->cols + config->rows + 3)) * width *=
=20
> > > config->ranks;
> > > +       unsigned long size =3D (1ULL << (config->cols + config->rows =
+ 3))=20
> > > * width * config->ranks;
> > > +
> > > +       /* some memory configurations such as 1.5GB rely on this to=20
> > > compute the correct size */
> > > +       if (!mctl_mem_matches_upto(size)) {
> > > +               size =3D (size * 3) / 4;
> > > +               debug("capping memory at 0x%lx\n", size);
> > > +       }
> > > +
> > > +  return size;
> > >   }
> > > diff --git a/arch/arm/mach-sunxi/dram_helpers.c=20
> > > b/arch/arm/mach-sunxi/dram_helpers.c
> > > index 83dbe4ca98f..68c75fa07a6 100644
> > > --- a/arch/arm/mach-sunxi/dram_helpers.c
> > > +++ b/arch/arm/mach-sunxi/dram_helpers.c
> > > @@ -61,4 +61,12 @@ bool mctl_mem_matches(u32 offset)
> > >   {
> > >          return mctl_mem_matches_base(offset, CFG_SYS_SDRAM_BASE);
> > >   }
> > > +
> > > +/*
> > > + * Test if memory at offset matches memory at end of DRAM
> > > + */
> > > +bool mctl_mem_matches_upto(u32 offset)
> > > +{
> > > +       return mctl_mem_matches_base(offset - sizeof(u32),=20
> > > CFG_SYS_SDRAM_BASE);
> > > +}
> > >   #endif
> > > --
> > > 2.43.0
> > >=20
> >=20
> >=20
>=20
>=20
>=20
>=20
>=20




