Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E90C3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 11:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F20188706;
	Mon,  8 Jul 2024 13:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dSi0juqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A6A88706; Mon,  8 Jul 2024 13:37:01 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC35288702
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 13:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57cbc2a2496so4331687a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720438617; x=1721043417; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OIC0Ix26GHXA/dD/sSoBgYtl8g4CoranOI/dk7mOBug=;
 b=dSi0juqRsj3pNBcWhlP5pdadqSvWrOGcEcqtH+RLu4MWHlNmK7bdpCeKRX7i4N8hF4
 BT8EHZ0WE1NKXJnETF5ZADXmkJG4Iyq02Jdwb06EOhvEiuOrg0hUkRKGIcgHbupqB6Ih
 vC88DVks28945HSqxaaYgSJJW5UXM9B8OinPa/Qu/HsmZJjd1R46CPrbf6ow9rWb5YcG
 FQnKYzmkgSC9RufQggDdVk0tHxSAAeu5Y7fwf4wdbeIZKBHx2SmPRCIseL+DbL7Fn4mf
 ebx+s7Y2VC2D1A2trx3m1/WzWdCZDpSZSX62ZoGmsCCWwRX5qX99CsldTwDEQOAS7ezU
 Iphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720438617; x=1721043417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OIC0Ix26GHXA/dD/sSoBgYtl8g4CoranOI/dk7mOBug=;
 b=LxTbX+8LX2VD5wbP933uSH+L9BWPoQcFYr34rM2t9lOwl2rdXR8YxoPueem08OziEN
 ehKWfRL9jTxgnU5lPK1J2VENBz7uq1EzvcO4wl+eAyn8TE415y1/tIHzqlsa6n1tdnSh
 XnmH4tt0zzfbK2/AvuijiIDOsPZsXyJTX7CK+v0InTNHIealOhFxFPOmjAZeAYQJIaU2
 H1J7/Ak54Zxfv0ifOWuj4+ggfAdtz7iSXo48Nn6g59+9N21pSgt5L/Rii0NnYKtnu7m9
 WRQGcTrnx4JFgRmHDkLWGie5f3eNeWUW0ABX/PNjdCfXwOSyuBV/nGbNKT2Jz1ufTTsJ
 jMXw==
X-Gm-Message-State: AOJu0YysjFrZxOz0wxmv8S41gQs9UfP4GaNp2K0TinwzcTNIjp8U/MvW
 i0eK8iWdv7WJ8Ok0xidJyQlU4d7mgCYW34ZNM2iJAkURY/FGMfz/NW0NodyzU44fSpDCyzEU6za
 YohIZPaEjEfwC05nP9dlVbg2WBJOGpSBZaZWCrA==
X-Google-Smtp-Source: AGHT+IFhL37gwkGWwL4KqgX48yhowzSs5uQXZH2r/Ds4LqWzufc0F9FaeUMftEKAx/f0qzJLSE/m2q+pilx3bn3OvoU=
X-Received: by 2002:a05:6402:50c7:b0:57d:2c9:6497 with SMTP id
 4fb4d7f45d1cf-58e5a7f0fd0mr10454662a12.3.1720438617105; Mon, 08 Jul 2024
 04:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-17-sughosh.ganu@linaro.org>
 <20240705194841.GO38804@bill-the-cat>
In-Reply-To: <20240705194841.GO38804@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 8 Jul 2024 17:06:45 +0530
Message-ID: <CADg8p95b2XybOZSB=YcX6hwP6mQrvxZs4tLNjhT5g3AeKve4cA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 16/48] lmb: config: add lmb config symbols for SPL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, 
 Michal Simek <michal.simek@amd.com>
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

On Sat, 6 Jul 2024 at 01:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jul 04, 2024 at 01:05:12PM +0530, Sughosh Ganu wrote:
>
> > Add separate config symbols for enabling the LMB module for the SPL
> > phase. The LMB module implementation now relies on alloced list data
> > structure which requires heap area to be present. Add specific config
> > symbol for the SPL phase of U-Boot so that this can be enabled on
> > platforms which support a heap in SPL.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: New patch
> >
> >  lib/Kconfig | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 072ed0ecfa..7eea517b3b 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -1103,7 +1103,17 @@ config LMB
> >       default y if ARC || ARM || M68K || MICROBLAZE || MIPS || \
> >                    NIOS2 || PPC || RISCV || SANDBOX || SH || X86 || XTENSA
> >       help
> > -       Support the library logical memory blocks.
> > +       Support the library logical memory blocks. This will require
> > +       a malloc() implementation for defining the data structures
> > +       needed for maintaining the LMB memory map.
>
> Even today, LMB really should be def_bool y rather than an option, so
> this series should correct that. That said...

Okay

>
> > +config SPL_LMB
> > +     bool "Enable LMB module for SPL"
> > +     depends on SPL && SPL_FRAMEWORK && SPL_SYS_MALLOC
> > +     help
> > +       Enable support for Logical Memory Block library routines in
> > +       SPL. This will require a malloc() implementation for defining
> > +       the data structures needed for maintaining the LMB memory map.
>
> The question I guess becomes when do we need LMB in SPL, exactly? And I
> guess it's another case where it should be def_bool y (but still depends
> on what you have here) since we need to make sure we don't overwrite
> running SPL.

So this is a question even I had. Do we really need to enable LMB in
SPL ? The main reason for introducing the symbol was to have more
granularity to remove the LMB code from SPL, but should this really be
enabled in SPL is something that I am not too sure about.

-sughosh

>
> --
> Tom
