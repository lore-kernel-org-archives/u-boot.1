Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41BFC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 06:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9D2488440;
	Mon, 26 Aug 2024 08:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LsOs+lHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED54884AC; Mon, 26 Aug 2024 08:44:44 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08EFD883C3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-498d6d67390so1352188137.0
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 23:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724654681; x=1725259481; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AwRterKZd0pPSqlKjL3OIQKunwAXDrquFrKuneNhrlg=;
 b=LsOs+lHre7AK5vnimNEMcV0ZwHf+Yl2wdkqkM0QLuETivGZ9DD56BToOHwTyfi+UMV
 fXurhLqq9ZD9InXxk1XNG27n4zkFWZQSs3sMLI/2ugf//4ma9jVnoDwVLD75GmWwfDSQ
 URCdh8WHfdrTnCXyy1g377RQVljVWiMv5Xk/HcSFNKLpwzs4dzC5OOs0qJNj5Di5zupg
 tJYPEKYgtTl4wiT5NCIpr7xAwrY5fQ12i9x9DYw1nXKJTlak1+/u61iTfzslBy6R12Y1
 FYXTjoxd1WOJrMcrOdN2zt/aR1wg6q0WXzIA8G4I/L4eTgeMZHKJeuCiknnuOT0rJd4H
 efwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724654681; x=1725259481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AwRterKZd0pPSqlKjL3OIQKunwAXDrquFrKuneNhrlg=;
 b=gb36ncCqznXwErSUyk1lQ31HGRuBA7VaqiYmvmRGBZzmkgt5XcykIdgquCWh850zOd
 j+ebrsXRTwJCQFEGa/oZJaw3TKp/1KfY1Lwc6Q7KWwKh1GqsCKDTaxE00PjGDNENyFWG
 PeTDHG2fFoIyZF9PHjpl9Xh8KADUQFASkAtFyAjJYDeSMGSqgZ9JvaltNI4iGliOXtAF
 w2gWFu4OmV3J8cobrCPsCQlN59G1cZ4+eD29szFiraZcnaR7LZv7+JcSfEN2ES33Y8fY
 se97zp6NORV3rZcmMUsGYpxgKVF+GN/TdDAyKEXOkAWj+LGMLOFsPlavVzMDmnKoLvPQ
 vZqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnuE1JLHUm8D3bzeKEirKX1nz2ffq3cg6coTHA0PAsgA5EJLwBQGBAO2jhcXtzZ+6LOkxwx1k=@lists.denx.de
X-Gm-Message-State: AOJu0YyarXc3Vr/YCDajDMTuGOYrXYeTcc0IVbqyjVu11h262oTYPH/n
 3m7NnDatLx2G1pG1pLgv/So0wANBAojG3C7c+Vv0J1at6edrTIC7PE3tSM/pb1k+XO8xxpd1FhQ
 M4H/YYwZbNzkjplAMxxBz431yH5jl+P6E3fAHUQ==
X-Google-Smtp-Source: AGHT+IH6LJlkvdg5qAh+64ZMXArYLAoYFIObLp0qZzsMdJjY+fw2W5UM1Z8+mpas5BDh3KpJTPKRCnBJ6VodmYKtMRM=
X-Received: by 2002:a05:6102:274f:b0:48f:b1d3:4890 with SMTP id
 ada2fe7eead31-498f474f4d3mr7144098137.31.1724654680703; Sun, 25 Aug 2024
 23:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
In-Reply-To: <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Aug 2024 12:14:29 +0530
Message-ID: <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Wed, 14 Aug 2024 at 22:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 14.08.24 11:41, Jan Kiszka wrote:
> > On 13.08.24 14:52, Nishanth Menon wrote:
> >> On 11:16-20240813, Jan Kiszka wrote:
> >>> Hi all,
> >>>
> >>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
> >>> facing issues because I need to still build the u-boot-only overlays. It
> >>> is also a bit weird (but works) having to specify
> >>>
> >>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
> >>>
> >
> > Actually, this does NOT work: I just had a long morning debugging SPL
> > which no longer started because it picked the non-filtered dtb. The
> > filtered one ended up in a folder outside of the u-boot sources because
> > of all those ../ and hard-wiring to dts/upstream.
> >
> >>> for our spl dtb.
> >>>
> >>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
> >>> I'm a bit lost in the Makefile forest.
> >>>
> >>
> >> Sumit: Any suggestions?
> >>

Apologies for the delayed reply. I was a bit busy with other high
priority stuff.

> >
> > I would really like to hear some better proposals than my local
> > workarounds to far. They don't converge although I already patched some
> > core Makefile (overlays are building now).
> >
>
> OK, I side-stepped the spl issue by using one of our variant DTBs for
> spl as well - happens to work.

That's good to know.

>
> For the overlays, I need to add
>
> --- a/scripts/Makefile.dts
> +++ b/scripts/Makefile.dts
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
> +include $(srctree)/config.mk
> +
>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
>
>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>
>
> in order to then be able to do
>
> --- a/board/siemens/iot2050/config.mk
> +++ b/board/siemens/iot2050/config.mk
> @@ -5,4 +5,12 @@
>  # Authors:
>  #   Jan Kiszka <jan.kiszka@siemens.com>
>
> +ifneq ($(CONFIG_SPL_BUILD),y)
> +dtbo-list = \
> +       k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay \
> +       k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay
> +
> +dtb-y += $(patsubst %,../../../../arch/arm/dts/%.dtbo,$(dtbo-list))
> +endif
> +
>  flash.bin: all
>
>
> Does that make sense?

A switch to OF_UPSTREAM means that we build all the DT artifacts from
dts/upstream/src/ directory with the only exception that we include
U-Boot specific overrides via *-u-boot.dtsi from arch/<arch>/dts. In
case of overlays, is there any reason for IOT2050 board overlays not
being pushed into Linux kernel repo? AFAIU, overlays are also
describing puggable hardware so they shouldn't be referred to as
"u-boot-only" overlays.

-Sumit

>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
