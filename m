Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3434BC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 06:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908C084979;
	Sun,  5 Jul 2026 08:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="MCTSbA17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B628496E; Sun,  5 Jul 2026 08:09:00 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7C483314
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 08:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so707467a91.3
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 23:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783231737; x=1783836537;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LzFglR2GGAlw+R4ZH4aINvyMn+L4dnTITQAFLwuAq7A=;
 b=MCTSbA17FViMqpo0upcnSZHc0J3eKAVcGsd9PfQK2ADqQ96ZN+6mJDS8mziDLf0zRv
 AqS9Cjqqcmu0uB14ZzeifM4YFCDTK+UFA0QxOleQuLgK7Cz3G3C8iV4tgTZUTDVp+n8y
 qSBffONoWplAwe41CzotmHTcoo26PO2pz1n6SU4RfYF1r14pRbYRBFOZ0jil+9WW2TzX
 sAJ28PEDHVfs9MUwZxguUi56ddirNVGaoyOXmKQGV18Mi04U+Q4aj4aYHU5I/pWWhipK
 cEF6Wp5PjRBAzCbC+SyXgzQl448DOJGjq7yDLXyL81hlfT/SAniSWRfS9ojbHEREISqa
 +5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783231737; x=1783836537;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LzFglR2GGAlw+R4ZH4aINvyMn+L4dnTITQAFLwuAq7A=;
 b=VoYq0GF+9pQOoDADYEnh4xFPFeOfdQrF2blRDPSLT7TGen2k8//OMNdhHxLyuFkVnG
 FJVQaIVnk880WDAAqlgcwiYWjFSiBea4G07V/cpZKUbGaNvctoRn3vDrcDrzh9rmxrWl
 wP0Yt/HFvp5UaGy8GDTdOq/OY+wNGq5IY/l8euWJ7uvmn8FrM3dM/Wbasl0k3W8Xapr8
 QQm4xZyOA2eMOjEqo46Xzc2HBui3fZnQhjB8PtKwEXawJkVgvSNL0j6AK6sW4ba4JkCq
 9v/+DqCsLryVzPKL8kRhQUIrw3xObf7IO3KUK1aR00xkz1ZuOkb53RuMC/Q3aRM1luv+
 EXrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQllQFJk38NHxUPNstBLFzvcqP1NUCMogVIy1CtAs98yE5GMQZB10iaBSwWwSLyFhMtKJr9xA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9wYg6efLSZvN39cjHDXU+X1yJEhJulG634e65838YYC/ApjrG
 /BBj1QtNWoq/5EZjQFGmJD+Bv4ycaqUUFC3rjZipLQUlX3cKttr+xtL04VFxL+r9csI=
X-Gm-Gg: AfdE7ckQqxllzowCycy0tpjBdKpUOHTA2jgxAtavZI9RIgQ+/MdAZCaPeJiIjp0gErP
 0RuPMfwmPKguH1rdrIMC6I/Rp2yoLKYF0382nomWD6e1CqIp2eAcFQh6xaaRWFVoxIygVv0BpnI
 8ohUaxPn5y4N2d3cVdRH//DlKP6+kPpLJdh1rv6lU/I30n5kFY7KVzdNyHF3gxwVYSg4fbdzBzY
 Z092ZRUyiTzm7q1rQNcE5gr4S7MbYOyGQFTwbefPyzDTkvNrhYbdcU/FqkwVKMiRTLCO+e0diz9
 Ga/8INge3lfYAHb2Lc3nkKIVLB+/+en8MiklnVl5a7WNktLpGhwAX/yxOZnH+BVtRngf2o+RREn
 Ta/IPjT+dO9bk1lbL1WUCze3xuKKisxPgES0FJY2u/p1X0HQPlAXAUTmbAC+/UrtOdUYx7JKaso
 v4Gvr+KDiyvA1Ngo1GwJXdLivjfjJev9LB18oY5I2sUYEVS/ASgCdZkN3+TmyFHMPVOn0qHF/vR
 +DfnO5bjwuK0AD63K2DpMwMm3Wnfi6GJsdwFlR2SbTABZR0BJSViw==
X-Received: by 2002:a17:90b:4cca:b0:37e:1430:769b with SMTP id
 98e67ed59e1d1-3829f0054d4mr5266622a91.24.1783231736790; 
 Sat, 04 Jul 2026 23:08:56 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f38ee1333sm22291719eec.24.2026.07.04.23.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:08:56 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 05 Jul 2026 14:07:57 +0800
Subject: [PATCH v3 6/9] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-m4-v3-6-5a9bc7f25fc5@riscstar.com>
References: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
In-Reply-To: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
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
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>
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

