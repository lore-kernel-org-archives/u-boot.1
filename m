Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A851C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 15:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE9384A45;
	Mon, 29 Jun 2026 17:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="bhQ4hdvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB5384A45; Mon, 29 Jun 2026 17:52:20 +0200 (CEST)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643E284942
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 17:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-13810b63a1aso7831514c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782748337; x=1783353137;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LzFglR2GGAlw+R4ZH4aINvyMn+L4dnTITQAFLwuAq7A=;
 b=bhQ4hdvob0aHmJ7352UV1gs0+rEheXiZuFMi8lInHz/ZF8dIVHkKitoD0m5bXE/OhI
 5rKoTtLIIE4T5WkfGM/igt2gOw9AMZ6/VQPnmYmSFrme2tXmXvR6jY8OkdEO2SBFPMRi
 5HAaYtmdTqY3srGEcsNxAvMlXXHP2G5aSnM1fNLXxqUmJR6Rqiva54FCi3Dl9zAns9m8
 +CZGES/fl/mB/xx0ReMtilABeQVbpMBtefCzavU+zo1DdMpN63QVfs/HRdzqOywW6j0n
 mVQl3y7kHcAKWUc4JQsUf78JALf7aJMzAOxemY/YTXF9RI3MwB1+uoVoWW/EOOkptoZn
 ZEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748337; x=1783353137;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LzFglR2GGAlw+R4ZH4aINvyMn+L4dnTITQAFLwuAq7A=;
 b=HN4nqY354G2Sui+8ZYy6D1Z1nMPEbst8epP9bnowsrsiyPdArlPXv+1ZzvMbYig6ah
 uq6gJ1w5spKOj94Q8UZmbXxknrESmu9jbsAK+4uvGvNFAs0ptiCASdnrQOj10PeHoP97
 9jM91vsRLt8ZcCm+0qfoom5hZ75x9S92/q2zHK4c49zzamBePYt/PDx2ygvapkQT2NNj
 CY16wUAobXJJH/dzTD+45kQehxSIFjfU1LB2OkFOJlOBPACNv0WnWj6EFblTAAQ8JDps
 sReoVm3jrUC1pGYYjq39hahnewJtvUf5oQwjA4dwobFpPZBVDXjW7NnJuKL7Bk69s2hM
 HO3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Athw3uKQj/ButK2G+7ISIg05DWIPKw1AyrPS+GwTEof3wii08Bge24gvp82uM7YTLZwkBybU=@lists.denx.de
X-Gm-Message-State: AOJu0YwlJaC/FbOnZ+mDQpZlq/+mNvbj/9N3tIpHgMnAqiA5SGwD2s9O
 ExFmEDE775H/44byRVGnay1B1jZi6/WpVnvIes8Qsw8IrkzjYC1UjARoJ56qbR8rz+WgTFEwgyV
 4qDuZ0cd1vQ==
X-Gm-Gg: AfdE7cl0CeqE5Weav6h8AMxfjRyTnrNxQTvgM4bbZRCUCeWxYhSXUKI8FevQpAYFCmL
 510IepaipubClV0w1YFYSQCUKQB0WLOXpmF01jJ3FQ20IujwCr29qLGG+QrQdQJtetgiYm1tvzV
 wr+6W1yksjfBlBbDH27k7XfNB0rf8Fw/OY/wNsquHQm38qL8JySiA56jqwfkwFxwJM6N/ve4dCG
 YGs6xPsK+xolXhayVoYaLRMWyMPBFTFti/0sveFh0LZ/cx0EKrgRcS3SrXlM/Q3YvefCZR0Bt+Z
 DAf1KlnQ4DLUxqHIzqPJjQf6gO1Hme59HxjZTK0AlIIQ3bKWkLBZD5RqSgnRcBvAg7BQ7Z5zGdB
 Kgykc2FrRjJHSDg+DaPM2MG98PTe2OKF2wxEaKyVJZh/0QM6rO/O7hP60Q2qZxSW4xauGOfMjrA
 yFAHnFM2Dp6hqclLVkAeeDEemzeZEAKcSB0mwjEGffBYHJnLh/Nbxvc7KkqcsCzQEO7xYFoji0S
 SG6Xi4bJyllXlCr8sF8TKVfO1mH0MnEnbO9P1iahKcOFGcW73km8w==
X-Received: by 2002:a05:7022:3d0a:b0:139:86cf:c305 with SMTP id
 a92af1059eb24-13b2a141b21mr22652c88.3.1782748336602; 
 Mon, 29 Jun 2026 08:52:16 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm46510090c88.7.2026.06.29.08.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:52:16 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 29 Jun 2026 23:51:19 +0800
Subject: [PATCH v2 v2 5/8] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-m4-v2-5-cbc91c6b83d8@riscstar.com>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
In-Reply-To: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Enable high-speed MMC modes.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v2:
- Enable ADMA support.
- Enable SYSCON support.
---
 board/spacemit/k1/MAINTAINERS |  1 +
 configs/spacemit_k1_defconfig | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 32d47ecc8f1..ca994e2a1fb 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -9,6 +9,7 @@ F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
+F:	drivers/mmc/spacemit_sdhci.c
 F:	drivers/pinctrl/spacemit/
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 81409c844a6..886679367a9 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -23,6 +23,7 @@ CONFIG_DEBUG_UART_BASE=0xd4017000
 CONFIG_DEBUG_UART_CLOCK=14700000
 CONFIG_TARGET_SPACEMIT_K1=y
 CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_ISA_ZICBOM=y
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_RISCV_MMODE=y
 # CONFIG_SPL_SMP is not set
@@ -48,6 +49,7 @@ CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
@@ -87,6 +89,21 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_MEM=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x000a0000
 CONFIG_CMD_SPI=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_SPACEMIT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x4
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_EFI_PARTITION=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_DM_SPI_FLASH=y
@@ -94,3 +111,5 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y

-- 
2.51.0

