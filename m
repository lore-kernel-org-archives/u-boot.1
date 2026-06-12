Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535A4CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 20:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4265284878;
	Fri, 12 Jun 2026 22:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FGd3yVVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E557D84932; Fri, 12 Jun 2026 22:19:25 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B3F8063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 22:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-5175cb5946dso9929471cf.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781295563; x=1781900363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaBosrt6O3GJ38dCgZBXghUqgI4+gqdxGETduy6AQ/Q=;
 b=FGd3yVVpn+OXgzh6m66TGSl2UXQQ8Lsk7MotYK6gpvH31qwbd1H+9XTzJ+CIKO1UuM
 CRzXi8zqw5Q3NUrilbvwWEYLT6ludQVLcyUJn6VRwNchaDf4sUPp5nU0TaESwhkRuB0W
 SfQfU6/UhcjExMaqASbe7RW9wecjWFMJlCUFbTeomrxOdO/UsKLZz9ykmyWZ+e6DoARx
 oPfez/yULt+gXAQ04IYqVtJjaJNqjSla04kax5ERQfj4/ywgQRxjsnkmryR/0u9NaMNr
 USOOZXDblzXSEh8h9UCSbZ4ZjO3HwA+W9Iz5/u7gAy9vx0OhzICA+TGKMhmvZ6BLSuGC
 N7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781295563; x=1781900363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TaBosrt6O3GJ38dCgZBXghUqgI4+gqdxGETduy6AQ/Q=;
 b=lbZ+BrnC/cx8cFYgebISy+2MkxCA77VeGVSSOhfu9efWIi4RLYtrgvxb3A9wjgfTcO
 fdsLFaILtyMSKaDhfyCllQ8z05t/0eFXSjolyekh4n1EVg0jM+UtgEHHsGsnuAUXj0oZ
 fawL3ukOjLEbeH3G7+eYoLWlnSbZZkm9i1oeL7lhOi/aBzUnp29FJLWy8zwzWwqKBSik
 ZmnjODV6CUE7JfUDjAfeCIKXjshOLrjJK6dq8pbPo586Kz/Au0h1lfj5Q1WXykDsRlxL
 tM2Cy6z63Gmh/Hh3bVEjofHLVBFmUwqTsI7poQjb/1FC4m4AkrmiPIH9BQ8smZB6BHzD
 YObA==
X-Gm-Message-State: AOJu0Yw7/q6QI3eLib/M5/xf77LTMBknMBk5Yan6gXUChuiRK7S7Ih+B
 rorXWdW9rzpkZO/F+XNHf3KQcEyQ2vWfiUA1POOqYbmvM2/l/Pjar5hz7y/aqnfx
X-Gm-Gg: Acq92OH1K3iSxvmRN45Tx59fGoqEWHUD5rfmrCMf44Np5AhgQASFG30Iqicj/cGkph1
 X4cT3qPV2R8X93rgT9MLnxzZrVtXK8A3sH3U2upxvdSftpew6YJ13OYCLa/LYlXhFRrzGlEkPZY
 ixqpZTHR1X7PNNFboWXNqhIcmtzEkB8U/A7AbkCi3UK3S43a6TLkQ+Ov0ZUP8y63/SYxobxRvyZ
 XpNSPoUZphRJGH8GQbfJdCF4oMNxYlJN9JfWm+EQ181jB9N1WJTDXwwibNWoEJRxCl+88X7wjXR
 7zurcheaEhi/UxNGdTq76nLB8Q1S2Tbj2QIGLM/DcL0Ekt3JFg8WvnARBwApD4sTglUv3RJ9xWF
 ozqbU30zh1LO+NpDlKBcs3DirU9YOmBK+9n29BaMu+TtyQ/r494Gt/DbxpfJvOIAj/iYssyxP0K
 Hqvi8PKRzECOsJFXx0Ta8aEmr8Htozjg4OiakuFaNi8t9HcXPVTxJgeNWkvVFBDlO2+KWS9uWpc
 Hog61WuqzRpMBfDaYM=
X-Received: by 2002:a05:622a:1102:b0:50d:863d:b50e with SMTP id
 d75a77b69052e-517fe4cded2mr62092121cf.3.1781295562660; 
 Fri, 12 Jun 2026 13:19:22 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb7a3c4asm31304551cf.14.2026.06.12.13.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 13:19:22 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH 4/8] configs: k1: enable SD and eMMC support
Date: Fri, 12 Jun 2026 16:18:57 -0400
Message-Id: <20260612201901.73657-5-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260612201901.73657-1-raymondmaoca@gmail.com>
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Guodong Xu <guodong@riscstar.com>

Enable high-speed MMC modes for PIO.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 board/spacemit/k1/MAINTAINERS |  1 +
 configs/spacemit_k1_defconfig | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

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
index 81409c844a6..a44e657c0dc 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -87,6 +87,20 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_MEM=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x000a0000
 CONFIG_CMD_SPI=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
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
@@ -94,3 +108,6 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_MMC_TINY=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-- 
2.25.1

