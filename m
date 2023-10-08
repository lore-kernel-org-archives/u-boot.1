Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154F2E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 11:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D439A866B2;
	Sun,  8 Oct 2023 13:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vkp3M2E/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FE79867EF; Sun,  8 Oct 2023 13:39:25 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0287D864D4
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 13:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=inindev@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c61bde0b4bso31274755ad.3
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696765152; x=1697369952; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c9s2HiLtS396RSrfxfUb7p+gAyY8yWMn3NmSgQPL0g8=;
 b=Vkp3M2E/xHzcnuooHFsWNQSFC5xMANBDmJIXZQkGZlah2rmSDH30g0QScwk3OnoF0b
 7mmhL2IT5RQwNlCkeIo7kYxMGgZHT0ZROFDAMEDC3FlyLsa8JTa+udeMdsATz75+i8mW
 64khjK8JgSL4gV95LSa7a+aa5zEJdIkEF298lxu6gsS8kY+dv+3UZg0r6h8u5NdYXQlW
 9cnH4kx7pJne83/XOI9jVbO1fafMoRbIqkMH3h1Hmpz4sDuv+wPvyGuNFGBBYR+KgLuR
 oiJWpaCMi9DBZo9FJE9OlO0lPbnZlWiKWMJtMyyR42fjJgWejSGQqmoEzJdcxV27Wdtx
 gYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696765152; x=1697369952;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c9s2HiLtS396RSrfxfUb7p+gAyY8yWMn3NmSgQPL0g8=;
 b=k39v8bCkCWk3Cr8FAM3TSgY9UUU6kNQFnYIeIo6lGPNHMIn2vNQPRHRf/ej0BGRLgM
 +oUyAsOopOxRS/8A8XVovCAHAwdOcvMB8m05fk0c2eitrhnfIROvMJzeyaB1jGokTeOI
 k2KEPtnN2XynVX42MEmptgowAx7IEbV2absfyc6T0GOtyNMpXkY4qD58EOn8Vrdoufla
 CdR70hypLk5y/wqLcAjv22Vn/WaVOHpWJkaZ35Xde9rRlg9dBfvIpZxqu0Z1je8kAxJK
 2A6y4/Irf/YnSijwlv/V2qJDGEMKPJe1yB+SdGwAv9c/mkWj9j11xPPxVabMw05KIKNe
 wjTg==
X-Gm-Message-State: AOJu0Yyn8W7UFNF9tY8tx6J90QwTIevXotMFaLW1O0tOL0QUrsoy6NGR
 jzLDr4N/S8NlIA3GXSjKI+q4ltlqUZYJ8Elo1Io=
X-Google-Smtp-Source: AGHT+IFF96XJqfCxdTYM27Snj/+pIKXJaK5KcppuIH3aSGWwgMCsUcxU2puHN/W5rtMOL46yDiUuE2AWmpSg5uVz7x8=
X-Received: by 2002:a17:90a:ba87:b0:268:b682:23de with SMTP id
 t7-20020a17090aba8700b00268b68223demr12959389pjr.28.1696765151900; Sun, 08
 Oct 2023 04:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231007212552.11109-1-inindev@gmail.com>
 <3145ccc9-d6d6-ee81-4158-9ac576f1a236@rock-chips.com>
In-Reply-To: <3145ccc9-d6d6-ee81-4158-9ac576f1a236@rock-chips.com>
From: John Clark <inindev@gmail.com>
Date: Sun, 8 Oct 2023 07:39:00 -0400
Message-ID: <CALtTj7z61mpdu94LghJD5aW+-isJDdT+gun1NJ=jniqKU+m20w@mail.gmail.com>
Subject: Re: [PATCH] board: rockchip: add FriendlyElec NanoPC-T6 rk3588 board
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 chenfen <chenfen@rock-chips.com>, =?UTF-8?B?6LW15Luq5bOw?= <zyf@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

In commit fd6e425, Jonas finds the rock-5b device has a value of 6 at
CFG_IRAM_BASE + 0x10 (0xff000010) when booted from spi and creates the
BROM_BOOTSOURCE_SPINOR_RK3588 enum value.
https://github.com/u-boot/u-boot/commit/fd6e425be243dce518a02710482514faccf=
3c211

When I boot the nanopv-t6 from spi, I am seeing a value of 4 at 0xff000010.

We both should be expecting a value of 3:

BROM_BOOTSOURCE_SPINOR =3D 3,        =3D>  0x0000 0011   pre-RK3588 variant=
s
BROM_BOOTSOURCE_SPINAND =3D 4,       =3D>  0x0000 0100   NanoPC-T6
BROM_BOOTSOURCE_SPINOR_RK3588 =3D 6, =3D>  0x0000 0110   Rock-5b

Since this is the only use of CFG_IRAM_BASE, I have to wonder if 0xff000000
is correct for the RK3588?


I have included the relevant code below for convenience:

/**
 * Boot-device identifiers as used by the BROM
 */
enum {
BROM_BOOTSOURCE_NAND =3D 1,
BROM_BOOTSOURCE_EMMC =3D 2,
BROM_BOOTSOURCE_SPINOR =3D 3,
BROM_BOOTSOURCE_SPINAND =3D 4,
BROM_BOOTSOURCE_SD =3D 5,
BROM_BOOTSOURCE_SPINOR_RK3588 =3D 6,
BROM_BOOTSOURCE_USB =3D 10,
BROM_LAST_BOOTSOURCE =3D BROM_BOOTSOURCE_USB
};

extern const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1];

/**
 * Locations of the boot-device identifier in SRAM
 */
#define BROM_BOOTSOURCE_ID_ADDR   (CFG_IRAM_BASE + 0x10)

https://github.com/u-boot/u-boot/blob/master/arch/arm/include/asm/arch-rock=
chip/bootrom.h


./include/configs/rk3128_common.h:#define CFG_IRAM_BASE 0x10080000
./include/configs/px30_common.h:#define CFG_IRAM_BASE 0xff0e0000
./include/configs/rk3188_common.h:#define CFG_IRAM_BASE 0x10080000
./include/configs/rk3568_common.h:#define CFG_IRAM_BASE 0xfdcc0000
./include/configs/rk3399_common.h:#define CFG_IRAM_BASE 0xff8c0000
./include/configs/rk3066_common.h:#define CFG_IRAM_BASE 0x10080000
./include/configs/rk3308_common.h:#define CFG_IRAM_BASE 0xfff80000
./include/configs/rk3368_common.h:#define CFG_IRAM_BASE 0xff8c0000
./include/configs/rk3288_common.h:#define CFG_IRAM_BASE 0xff700000
./include/configs/rk3328_common.h:#define CFG_IRAM_BASE 0xff090000
./include/configs/rv1108_common.h:#define CFG_IRAM_BASE 0x10080000
./include/configs/rk3588_common.h:#define CFG_IRAM_BASE 0xff000000
./include/configs/rk322x_common.h:#define CFG_IRAM_BASE 0x10080000
./include/configs/rv1126_common.h:#define CFG_IRAM_BASE 0xff700000


On Sun, Oct 8, 2023 at 5:09=E2=80=AFAM Kever Yang <kever.yang@rock-chips.co=
m> wrote:

>
> On 2023/10/8 05:25, John Clark wrote:
> > NanoPC-T6 is a Rockchip RK3588 based SBC by FriendlyElec.
> >
> > There are four variants depending on the DRAM size: 4G/32GB eMMC,
> 8G/64GB eMMC,
> > 16G/16MB SPI NOR, and 16G/256GB eMMC/16MB SPI NOR
>
> So the board is using SPI NOR flash.
>
>
> [...]
>
> > diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c
> b/arch/arm/mach-rockchip/rk3588/rk3588.c
> > index b1f535fad5..e08ebfa39b 100644
> > --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> > +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> > @@ -40,6 +40,7 @@ DECLARE_GLOBAL_DATA_PTR;
> >   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] =3D {
> >       [BROM_BOOTSOURCE_EMMC] =3D "/mmc@fe2e0000",
> >       [BROM_BOOTSOURCE_SPINOR] =3D "/spi@fe2b0000/flash@0",
> > +     [BROM_BOOTSOURCE_SPINAND] =3D "/spi@fe2b0000/flash@0",
>
> Why need a SPI NAND?
>
> If this is really needed, will be a separate patch to support a new boot
> source from bootrom.
>
>
> Thanks,
> - Kever
>
>
