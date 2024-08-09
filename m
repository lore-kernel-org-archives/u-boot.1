Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CBFC52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 18:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC6288C2F;
	Fri,  9 Aug 2024 20:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eWpd0pt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3625880E6; Fri,  9 Aug 2024 20:38:06 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCFBD88C35
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 20:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b795574f9dso13106756d6.0
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723228683; x=1723833483; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OoYTwD+kUkV57vHwE6U5IOYZg7M+vRKYPtEHoOtoINE=;
 b=eWpd0pt9/FLlFKpJLo+44CajRrfvjQiz3bwEoGIt9jtUbGU1rLDKZdgt44sPTcrnv1
 UyoDHj0StLkPzxQ5xUh1lIQ1cyVgrwTVcgw/4IXo6lqmBJ6LTXpgUJgDkMF0BfmcV3Vy
 17MY+nYRSSRzrM+A4wcr/AnX/wrB7gYiCUXaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723228683; x=1723833483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OoYTwD+kUkV57vHwE6U5IOYZg7M+vRKYPtEHoOtoINE=;
 b=EiBwaoL8qeEujUm+23YyxN4BAs50rO0UtdSwuRw2pb5re+YyHjMtCJ2wrBHEBhLeN7
 f/7h35szh0elYUH0zpin8bOD1wtJqFKGvDMIGHfK/CAqThgncF5nZTBPvr3bZlAu9q9C
 +IjanCJShEUO74BHGT9xW7zjjEjpFoxshkq3c+sfVIcdqzVTTpiuKzCt0zktsCbYjR87
 P6+6HC4LDwB0P7ExuaayNpnYJ5mEMW+h4WkbkWc22PE8LkU229BYrDY0nVX7O5FJlYiH
 O3tM14+aEprf2qEvJceOKN/4wivZzC4nR1CA0Is5ruizil9EHMXJlc6nxJVIO+coT9Bx
 UUyg==
X-Gm-Message-State: AOJu0YwLAYzKZ2NpBxfIEHrHPGqMVr+6OXJM7F0a7E0e0BxsLQRXiQCX
 N2GE3smQkJTYpJHvvDFdoujWNnt7jAwZrJ2+hczRrPMCi2Sd6TBd0udkJgHaBtZCHuESrfOOpMm
 A+NyMIqU+AG1GPu+FkjAGuMoknPUY7LuBOHhWybDteVBRSNE=
X-Google-Smtp-Source: AGHT+IFbU7IzCt/gkqQnxJNexs7OuUQarxpa/V1bdUKWQpwUpdKjvxfn5qz+tWMDal/vqJUJwjoChUjEKNtExbAltaA=
X-Received: by 2002:a05:6214:5c09:b0:6b0:72c7:88d8 with SMTP id
 6a1803df08f44-6bd78edf71bmr26230706d6.35.1723228683272; Fri, 09 Aug 2024
 11:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240718173611.4014274-1-sjg@chromium.org>
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Aug 2024 12:37:52 -0600
Message-ID: <CAFLszTj3JsUHFvWUmP07mGwK315qO=Bt0uQ=JGeKrLgBOQxoJA@mail.gmail.com>
Subject: Re: [PATCH 00/20] i2c: Chip away at some old code
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>
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

-cc most

Hi,

On Thu, 18 Jul 2024 at 11:36, Simon Glass <sjg@chromium.org> wrote:
>
> This series aims to remove some of the older contents of i2c.h so that
> we can move towards having just the dm API.
>
> It removes four boards which are getting in the way.
>
>
> Simon Glass (20):
>   arm: Remove pg_wcom boards
>   i2c: Remove board_i2c_init()
>   i2c: Remove IC2_xxx enum
>   i2c: Remove CFG_I2C_MULTI_BUS
>   mips: malta: Drop CMD_DATE
>   armv8: ls2085a: Drop CMD_DATE
>   mx28 / mx51: Drop CMD_DATE
>   MPC837XERDB: ethernut5: work_92105: Drop CMD_DATE
>   rtc: Drop CFG_SYS_RTC_BUS_NUM
>   date: Drop the legacy I2C code
>   keymile: Remove use of legacy I2C
>   i2c: mxc: pg_wcom: Drop legacy I2c
>   i2c: Drop reference to SYS_I2C_INIT_BOARD
>   octeon: Drop OCTEON_I2C_FDT dead code
>   i2c: Remove I2C_SET_BUS()
>   i2c: Remove I2C_GET_BUS()
>   i2c: Drop CFG_SYS_MAX_I2C_BUS
>   i2c: Drop i2c_get_bus_num_fdt() and i2c_reset_port_fdt()
>   i2c: Remove CFG_SYS_I2C_MAX_HOPS
>   i2c: Remove CFG_SYS_I2C_DIRECT_BUS
>
>  README                                        |  27 +--
>  arch/arm/dts/ls1021a-pg-wcom-expu1.dts        | 141 -----------
>  arch/arm/dts/ls1021a-pg-wcom-seli8.dts        | 124 ----------
>  arch/mips/mach-octeon/octeon_fdt.c            |  22 --
>  board/keymile/Kconfig                         |   4 -
>  board/keymile/common/common.c                 |  69 ------
>  board/keymile/pg-wcom-ls102xa/Kconfig         |  39 ----
>  board/keymile/pg-wcom-ls102xa/MAINTAINERS     |  16 --
>  board/keymile/pg-wcom-ls102xa/Makefile        |  11 -
>  board/keymile/pg-wcom-ls102xa/ddr.c           |  91 --------
>  .../keymile/pg-wcom-ls102xa/pg-wcom-expu1.env |   3 -
>  .../keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c | 218 ------------------
>  .../keymile/pg-wcom-ls102xa/pg-wcom-seli8.env |   3 -
>  cmd/date.c                                    |  32 ---
>  cmd/i2c.c                                     |  23 --
>  configs/MPC837XERDB_defconfig                 |   1 -
>  configs/ethernut5_defconfig                   |   1 -
>  configs/ls2080aqds_nand_defconfig             |   1 -
>  configs/ls2080aqds_qspi_defconfig             |   1 -
>  configs/ls2080ardb_nand_defconfig             |   1 -
>  configs/malta64_defconfig                     |   1 -
>  configs/malta64el_defconfig                   |   1 -
>  configs/malta_defconfig                       |   1 -
>  configs/maltael_defconfig                     |   1 -
>  configs/mx28evk_defconfig                     |   1 -
>  configs/mx51evk_defconfig                     |   1 -
>  configs/pg_wcom_expu1_defconfig               | 109 ---------
>  configs/pg_wcom_expu1_update_defconfig        | 107 ---------
>  configs/pg_wcom_seli8_defconfig               | 109 ---------
>  configs/pg_wcom_seli8_update_defconfig        | 107 ---------
>  configs/work_92105_defconfig                  |   1 -
>  doc/I2C_Edge_Conditions                       |  10 +-
>  drivers/ddr/fsl/main.c                        |   3 +-
>  drivers/i2c/i2c_core.c                        | 141 -----------
>  drivers/i2c/soft_i2c.c                        |  11 -
>  drivers/power/power_i2c.c                     |   5 -
>  drivers/usb/host/ohci-lpc32xx.c               |   4 -
>  include/configs/ethernut5.h                   |   3 -
>  include/configs/km/pg-wcom-ls102xa.h          | 167 --------------
>  include/configs/ls1028aqds.h                  |   1 -
>  include/configs/ls1028ardb.h                  |   2 -
>  include/configs/ls1046afrwy.h                 |   1 -
>  include/configs/lx2160aqds.h                  |   3 -
>  include/configs/lx2160ardb.h                  |   3 -
>  include/configs/lx2162aqds.h                  |   3 -
>  include/configs/m53menlo.h                    |   2 -
>  include/configs/omap3_beagle.h                |   3 -
>  include/configs/pg-wcom-expu1.h               |  49 ----
>  include/configs/pg-wcom-seli8.h               |  40 ----
>  include/configs/sniper.h                      |  14 --
>  include/configs/tqma6.h                       |   3 -
>  include/configs/tqma6_wru4.h                  |   1 -
>  include/i2c.h                                 | 107 ---------
>  53 files changed, 6 insertions(+), 1837 deletions(-)
>  delete mode 100644 arch/arm/dts/ls1021a-pg-wcom-expu1.dts
>  delete mode 100644 arch/arm/dts/ls1021a-pg-wcom-seli8.dts
>  delete mode 100644 board/keymile/pg-wcom-ls102xa/Kconfig
>  delete mode 100644 board/keymile/pg-wcom-ls102xa/MAINTAINERS
>  delete mode 100644 board/keymile/pg-wcom-ls102xa/Makefile
>  delete mode 100644 board/keymile/pg-wcom-ls102xa/ddr.c
>  delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-expu1.env
>  delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
>  delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-seli8.env
>  delete mode 100644 configs/pg_wcom_expu1_defconfig
>  delete mode 100644 configs/pg_wcom_expu1_update_defconfig
>  delete mode 100644 configs/pg_wcom_seli8_defconfig
>  delete mode 100644 configs/pg_wcom_seli8_update_defconfig
>  delete mode 100644 include/configs/km/pg-wcom-ls102xa.h
>  delete mode 100644 include/configs/pg-wcom-expu1.h
>  delete mode 100644 include/configs/pg-wcom-seli8.h
>
> --
> 2.34.1
>

What shall we do with this series?

Regards,
Simon
