Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F979C3DA61
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 22:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A71B88AD4;
	Fri, 19 Jul 2024 00:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O0/V0oT0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE46188AB7; Thu, 18 Jul 2024 19:36:38 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAEA988B05
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2eebc76119aso13938461fa.2
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324194; x=1721928994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5D5e1uW+3MJ2vliZQDGYECoz4KDHNsGTw/fjqguBI44=;
 b=O0/V0oT0/YfurJMCRvPBEfZPVDLKF2TB7ZafDhiVKJfLvGdjEL6dkYiBikBlykIR8d
 V8WUa1nLoMFeCBCdMPnek57qJBU/64K/hAljr2TupCrkfNCbBQoImftZRs+zl4mhCdaT
 DdOqvflsXP2uHSPLJb46Os9xtyRXD9C0oN1iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324194; x=1721928994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5D5e1uW+3MJ2vliZQDGYECoz4KDHNsGTw/fjqguBI44=;
 b=Tfxlwal1n/8flUOgJu5VavovB17VdWnL5sXkkxBix2R4+WsBNszz5/SeXA6cJfusxB
 J0d+4rs7UTxoiTVQtlLWu0219QlGL/O5ZUZPwtDi3sfhQLrldS7fWJQQbdKHxl2vOakQ
 SOZQKo6WKKqo1qZtlQ1y1z+g41K1Zn6+UvjjmKb5t5QHJXkryc0+74jkyhxQmQ/BhKkI
 RaBKD1+IBph+4ivW9g8VUrXnBKjwL+7nBZS0caiHltSOawKJoQGMsO9C3prJRA0Hwa2r
 htd9as0shgUjhee7XVmxXc9TV1Z00rCwtu20koE+Zi8xHgCvbG57sKL1TxWGjmWpv0kE
 M9Ow==
X-Gm-Message-State: AOJu0YyiB6dEIB+4MKi5Ygf9gLt+7byGKLWI52CP4KHYzGAKtq7Aibfp
 UgX0DyLyQS5GaVJaonSlWpd4cWSLDq42GVvxB9nwzsCjTRmfup9L4Pi3mBcAGPifInc1ZUa8fTI
 =
X-Google-Smtp-Source: AGHT+IGKz6Nf48YpLLzgK0H8xMQHdZ66aQp9R0fo3+4ZyI/if1OOvEXMdOEaT+5kQtAcibc/yf0uyQ==
X-Received: by 2002:a2e:80d3:0:b0:2ee:8d81:5a92 with SMTP id
 38308e7fff4ca-2ef05d2e1c5mr21972561fa.38.1721324193750; 
 Thu, 18 Jul 2024 10:36:33 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Aaron Williams <awilliams@marvell.com>,
 Albert ARIBAUD <albert.aribaud@3adev.fr>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>,
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitacienergy.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Markus Niebel <Markus.Niebel@tq-group.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Michal Simek <michal.simek@amd.com>, Niel Fourie <lusus@denx.de>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Paul Burton <paul.burton@mips.com>, Paul Kocialkowski <contact@paulk.fr>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philip Richard Oberfichtner <pro@denx.de>,
 Pramod Kumar <pramod.kumar_1@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Rainer Boschung <rainer.boschung@hitachienergy.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Sinan Akman <sinan@writeme.com>,
 Stefano Babic <sbabic@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tang Yuantian <andy.tang@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 egnite GmbH <info@egnite.de>
Subject: [PATCH 00/20] i2c: Chip away at some old code
Date: Thu, 18 Jul 2024 18:35:51 +0100
Message-Id: <20240718173611.4014274-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 19 Jul 2024 00:14:18 +0200
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

This series aims to remove some of the older contents of i2c.h so that
we can move towards having just the dm API.

It removes four boards which are getting in the way.


Simon Glass (20):
  arm: Remove pg_wcom boards
  i2c: Remove board_i2c_init()
  i2c: Remove IC2_xxx enum
  i2c: Remove CFG_I2C_MULTI_BUS
  mips: malta: Drop CMD_DATE
  armv8: ls2085a: Drop CMD_DATE
  mx28 / mx51: Drop CMD_DATE
  MPC837XERDB: ethernut5: work_92105: Drop CMD_DATE
  rtc: Drop CFG_SYS_RTC_BUS_NUM
  date: Drop the legacy I2C code
  keymile: Remove use of legacy I2C
  i2c: mxc: pg_wcom: Drop legacy I2c
  i2c: Drop reference to SYS_I2C_INIT_BOARD
  octeon: Drop OCTEON_I2C_FDT dead code
  i2c: Remove I2C_SET_BUS()
  i2c: Remove I2C_GET_BUS()
  i2c: Drop CFG_SYS_MAX_I2C_BUS
  i2c: Drop i2c_get_bus_num_fdt() and i2c_reset_port_fdt()
  i2c: Remove CFG_SYS_I2C_MAX_HOPS
  i2c: Remove CFG_SYS_I2C_DIRECT_BUS

 README                                        |  27 +--
 arch/arm/dts/ls1021a-pg-wcom-expu1.dts        | 141 -----------
 arch/arm/dts/ls1021a-pg-wcom-seli8.dts        | 124 ----------
 arch/mips/mach-octeon/octeon_fdt.c            |  22 --
 board/keymile/Kconfig                         |   4 -
 board/keymile/common/common.c                 |  69 ------
 board/keymile/pg-wcom-ls102xa/Kconfig         |  39 ----
 board/keymile/pg-wcom-ls102xa/MAINTAINERS     |  16 --
 board/keymile/pg-wcom-ls102xa/Makefile        |  11 -
 board/keymile/pg-wcom-ls102xa/ddr.c           |  91 --------
 .../keymile/pg-wcom-ls102xa/pg-wcom-expu1.env |   3 -
 .../keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c | 218 ------------------
 .../keymile/pg-wcom-ls102xa/pg-wcom-seli8.env |   3 -
 cmd/date.c                                    |  32 ---
 cmd/i2c.c                                     |  23 --
 configs/MPC837XERDB_defconfig                 |   1 -
 configs/ethernut5_defconfig                   |   1 -
 configs/ls2080aqds_nand_defconfig             |   1 -
 configs/ls2080aqds_qspi_defconfig             |   1 -
 configs/ls2080ardb_nand_defconfig             |   1 -
 configs/malta64_defconfig                     |   1 -
 configs/malta64el_defconfig                   |   1 -
 configs/malta_defconfig                       |   1 -
 configs/maltael_defconfig                     |   1 -
 configs/mx28evk_defconfig                     |   1 -
 configs/mx51evk_defconfig                     |   1 -
 configs/pg_wcom_expu1_defconfig               | 109 ---------
 configs/pg_wcom_expu1_update_defconfig        | 107 ---------
 configs/pg_wcom_seli8_defconfig               | 109 ---------
 configs/pg_wcom_seli8_update_defconfig        | 107 ---------
 configs/work_92105_defconfig                  |   1 -
 doc/I2C_Edge_Conditions                       |  10 +-
 drivers/ddr/fsl/main.c                        |   3 +-
 drivers/i2c/i2c_core.c                        | 141 -----------
 drivers/i2c/soft_i2c.c                        |  11 -
 drivers/power/power_i2c.c                     |   5 -
 drivers/usb/host/ohci-lpc32xx.c               |   4 -
 include/configs/ethernut5.h                   |   3 -
 include/configs/km/pg-wcom-ls102xa.h          | 167 --------------
 include/configs/ls1028aqds.h                  |   1 -
 include/configs/ls1028ardb.h                  |   2 -
 include/configs/ls1046afrwy.h                 |   1 -
 include/configs/lx2160aqds.h                  |   3 -
 include/configs/lx2160ardb.h                  |   3 -
 include/configs/lx2162aqds.h                  |   3 -
 include/configs/m53menlo.h                    |   2 -
 include/configs/omap3_beagle.h                |   3 -
 include/configs/pg-wcom-expu1.h               |  49 ----
 include/configs/pg-wcom-seli8.h               |  40 ----
 include/configs/sniper.h                      |  14 --
 include/configs/tqma6.h                       |   3 -
 include/configs/tqma6_wru4.h                  |   1 -
 include/i2c.h                                 | 107 ---------
 53 files changed, 6 insertions(+), 1837 deletions(-)
 delete mode 100644 arch/arm/dts/ls1021a-pg-wcom-expu1.dts
 delete mode 100644 arch/arm/dts/ls1021a-pg-wcom-seli8.dts
 delete mode 100644 board/keymile/pg-wcom-ls102xa/Kconfig
 delete mode 100644 board/keymile/pg-wcom-ls102xa/MAINTAINERS
 delete mode 100644 board/keymile/pg-wcom-ls102xa/Makefile
 delete mode 100644 board/keymile/pg-wcom-ls102xa/ddr.c
 delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-expu1.env
 delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
 delete mode 100644 board/keymile/pg-wcom-ls102xa/pg-wcom-seli8.env
 delete mode 100644 configs/pg_wcom_expu1_defconfig
 delete mode 100644 configs/pg_wcom_expu1_update_defconfig
 delete mode 100644 configs/pg_wcom_seli8_defconfig
 delete mode 100644 configs/pg_wcom_seli8_update_defconfig
 delete mode 100644 include/configs/km/pg-wcom-ls102xa.h
 delete mode 100644 include/configs/pg-wcom-expu1.h
 delete mode 100644 include/configs/pg-wcom-seli8.h

-- 
2.34.1

