Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965DDC4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 23:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5070881A8;
	Fri, 12 Apr 2024 01:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gVsIb4m7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D782A881D6; Fri, 12 Apr 2024 01:27:22 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CB5888123
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 01:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e2e09fc27so580073a12.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 16:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712878039; x=1713482839; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVW4yGkmHID4cCcaJcn0SWupSxU4LV0MbKbfDUcLT/g=;
 b=gVsIb4m70xdEEchcFOT2tcRkXpymvrQvyJSKa187+iu676FWVQY9nY18F6pfIboEY0
 udGLqJQDtEGUYxwyH9FLdh8TTe9+TpJOBIFzYqs7TfgCqVfz7z0I9ulPwSd8QLQZAKOU
 v002KOMB9lv7aBJvDPrI/52jVoKIxY1/z3hqFuFpx1LMkftpeZ0rP2ZkIjKCiknbN/MB
 h23mZdS2WVUBOByqqvFmo+ZXQtPAbMv51V33L/0BoAmL4Az90o05g7Oauwr4hEd9SEC5
 H/LsEcgdLEi2IOt+Ov9A9l4MfVPLsol25s4WWLRBNHz/3XEvJS511YgbOsUXL1nhFuvx
 uEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712878039; x=1713482839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVW4yGkmHID4cCcaJcn0SWupSxU4LV0MbKbfDUcLT/g=;
 b=AAVAG31Xv7R9N9S2HaHtBAli6CuuLHwlHmQY0fgSzESR3A/OZ4t5U5vJeBJAILfRRA
 EGNF88Go+1hGF1os2V8XENl0CsG+jAgmZwDOObkur/velmQe1JTRKntMHWAGHYn7QUlx
 BvXD6E4XnvxLM6j6o9Ol9m9k+lH1mmWOzNMYplceo8DCkyyjO1r9qDy7kBtE7rYU1bub
 Gb7jpOE0PzGDcmZ+hCEDtWOr3DFag+ra1SEjdeb+BL5NfIocbz0AS7hxVvvivYMmxJdH
 hUI4+DkKLVYIcgVeZhvH3g48J2O88P80spMvOtTnpvNMT4qzzxS/BN6oE+hzzLQn3Xzp
 J+oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbQAUOHOBk3mN5+yF2jwR0DUVZYZrAXvrabnEoikqM9391mJDEx4bcEYYswrNdixD2wjPPoogjp1FWSmY/cCOxsYVd1Q==
X-Gm-Message-State: AOJu0YzJz8Jd4Dso21cdBhEX9g/9kBR071R3ZTtg7Wb3pnrAuIiYrgYh
 552JnmI0on296cVf3lteXmScfo6fXzXMSZXWC4FydyrMZuwB5b8wNirB1xL8liIvyty7UMvetnW
 HR7CRPpgLampxs+ZAVjtIRxfTAsI=
X-Google-Smtp-Source: AGHT+IFLxkct+80l0LfY7iYevPyC87xecZEo0cq2bBilk9QmtEydT1zsHT25uZ8ekbEcwYp6DlBgMQrvkBAR59PrlHM=
X-Received: by 2002:a50:d7da:0:b0:56d:f29d:c80d with SMTP id
 m26-20020a50d7da000000b0056df29dc80dmr961850edj.5.1712878039352; Thu, 11 Apr
 2024 16:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 11 Apr 2024 17:27:08 -0600
Message-ID: <CAH5Ym4j_u8cx_efju70LxrirTH6g0_L_c_PGXO3H=L=cgB5S=w@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] Support SPI NAND booting on the T113
To: John Watts <contact@jookia.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Maksim Kiselev <bigunclemax@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 10, 2024 at 10:26=E2=80=AFPM John Watts <contact@jookia.org> wr=
ote:
>
> This series is my current working and tested setup for booting from
> SPI NAND chips on the Allwinner T113.
>
> I have included the following patches from others. I may have modified
> them to work with the latest mainline:
>
> https://lore.kernel.org/all/20221014030520.3067228-1-uwu@icenowy.me/
> https://lore.kernel.org/all/20231111133432.755363-2-bigunclemax@gmail.com=
/
>
> Hopefully this can get the ball rolling on how to properly implement
> SPI NAND support in mainline U-Boot.
>
> Signed-off-by: John Watts <contact@jookia.org>

Hi John,

It doesn't look like I was sent the whole series (only 00 and 01), but
I was able to find it on Patchwork and sift through it. A few general
comments follow:

The introduction of `SUNXI_BOOTED_FROM_SPINAND` is the right call,
since the newer sunxis use this for SPI-NAND, and
`SUNXI_BOOTED_FROM_SPI` for SPI-NOR. The older sunxis, however, will
use `SUNXI_BOOTED_FROM_SPI` for "it's either SPI-NAND or SPI-NOR, have
fun figuring out which." While the rationale in 09/15 ("Instead of
trying to boot from SPI NAND then SPI NOR in series, select one based
on the current boot device.") is solid, we still need some code
(perhaps in/called from `sunxi_get_boot_device`?) to handle the
`SUNXI_BOOTED_FROM_SPI` case by performing flash type detection --
disabled for those sunxis known to use `SUNXI_BOOTED_FROM_SPINAND`, of
course.

06/15 ("sunxi: enable support for SPI NAND booting on SUNIV") should
be dropped from the series. You are updating `suniv_get_boot_source`
when introducing `SUNXI_BOOTED_FROM_SPINAND` anyway, so you can just
hook up `SUNIV_BOOTED_FROM_NAND` at that time (and a heads-up: I think
you got it wired backwards in this version of the series).

On a more fundamental note: I am hesitant about the overall approach
of having NAND reading code in `arch/arm/mach-sunxi/spl_spi_sunxi.c`.
NANDs are more complex than NORs (requiring e.g. bad block handling)
and U-Boot generally keeps the SPL load methods in
`common/spl/spl_*.c`. It's good that the UBI-on-SPI-NAND method is
hooked up there, but the "U-Boot image follows the (good) blocks of
the SPL in NAND" method should probably live in the same directory.

Here's what I'd like to explore: can we introduce a
`common/spl/spl_spinand.c` and update the `drivers/mtd/nand/spi/*.c`
code to support running in SPL? This way
`arch/arm/mach-sunxi/spl_spi_sunxi.c` must only provide the SPL-mode
implementation of SPI -- that is, the actual sunxi-specific bit. Also,
updating the `drivers/mtd/nand/spi/*.c` drivers for SPL-friendliness
will mean dropping those `SPL_SPINAND_{PAGE,BLOCK}_SIZE` configuration
options: the tables in the drivers will be the ones providing those
after NAND autodetection.

Thoughts?

Cheers,
Sam

> ---
> Icenowy Zheng (5):
>       sunxi: SPL SPI: extract code for doing SPI transfer
>       sunxi: SPL SPI: add support for read command with 2 byte address
>       sunxi: SPL SPI: allow multiple boot attempt
>       sunxi: SPL SPI: add initial support for booting from SPI NAND
>       sunxi: enable support for SPI NAND booting on SUNIV
>
> John Watts (9):
>       sunxi: Separate boot device and boot position
>       spl: Add BOOT_DEVICE_SPINAND option
>       sunxi: Implement BOOT_DEVICE_SPINAND in SPL
>       spl: Add SPL_SPINAND configuration options
>       sunxi: Use SPL_SPINAND for configuration
>       nand: Add spinand_ helper functions
>       sunxi: Implement spinand_ helpers
>       spl: Support SPI NAND boot in UBI
>       spl: Support loading FIT images in UBI
>
> Maksim Kiselev (1):
>       sunxi: SPL SPI: Add SPI boot support for the Allwinner R528/T113 So=
Cs
>
>  arch/arm/include/asm/arch-sunxi/spl.h |   3 +-
>  arch/arm/include/asm/spl.h            |   1 +
>  arch/arm/mach-sunxi/Kconfig           |   2 +-
>  arch/arm/mach-sunxi/board.c           |  31 +--
>  arch/arm/mach-sunxi/spl_spi_sunxi.c   | 348 +++++++++++++++++++++++++---=
------
>  arch/mips/include/asm/spl.h           |   1 +
>  arch/riscv/include/asm/spl.h          |   1 +
>  arch/sandbox/include/asm/spl.h        |   1 +
>  common/spl/Kconfig                    |  21 ++
>  common/spl/spl_ubi.c                  |  49 ++++-
>  include/nand.h                        |   3 +
>  11 files changed, 354 insertions(+), 107 deletions(-)
> ---
> base-commit: 777c28460947371ada40868dc994dfe8537d7115
> change-id: 20240411-spinand-eb7d8319813b
>
> Best regards,
> --
> John Watts <contact@jookia.org>
>
