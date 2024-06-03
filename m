Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745D5C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 13:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F10C8851B;
	Tue,  4 Jun 2024 15:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HRJA3aM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E500878F7; Mon,  3 Jun 2024 18:47:46 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A13288395
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 18:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a3d21299aso3526213a12.2
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717433264; x=1718038064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJk3nZkjTANll2KjO1knbe9a/zJQrVBeqbktYmALTcA=;
 b=HRJA3aM3OkzWhd0EQhPq8MEe+FUfcvVGpj9fOn+YzF3np8eJjAo+h4GSE2YIh0oRfU
 L3AWa/gWHjXXBFOLCRltYRZZhWSlkSR3fxWi9+JkxHe6hjCz0uoDo+DbzebMStQmDkxk
 4ye34zX2qcYz128OMis6bsIpn+Np/wqQE/d3zsOdtmlnZWShHajfUk51sjWslyqPlHJX
 PADraD0om04jEMEmn120tWGtevCIfSFIIIMl040G42WMt5unXoCu1ywYzsRpr3vIapfW
 Y6n+Xvbf3lELHsjw/qN8Opkyc+XQ4sRWs4hd7RT74dSelCBM24hy2SDXPs8qPgHfX173
 4tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717433264; x=1718038064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJk3nZkjTANll2KjO1knbe9a/zJQrVBeqbktYmALTcA=;
 b=eb6eJ+GhFriCcMixM/RuzyTGW5+lRopIMvVC5yn6x3Ocpcg6oRML1NWoTBIwARWzNT
 JhO/Gcbdjwa2cF1TvKptWCSFIQcJ19WaKIP0TenRWTA3YQJP4R8LaGaHKLte84F6Aa3c
 LxJgpXsPVQSDeEoJ05tIxgssMuOPCu0WOGz923g9oVjMTfyfCyG/duX4C/CDCtfb2eY4
 P9523hJnzToDxr8TJkob642niIF4Lp2+SXUioOqRSsV+7p84KpmZANoykPhW1TtENckM
 S7S4ZFPxF3SRz0Xmm/4yJt/eJHkFeeA+ZRzLKQMboY+Xb/pteciB4AQaNUTIAkP76Zci
 vV+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLCjTAlM9VMu3J6LSEYoqkfEf7F4RFyZ6nS9pG+BUioQfeRjRkckrhc5Rej7QQ/pZaX8MRLHb5zuAhvYdA6G4WDQdY1g==
X-Gm-Message-State: AOJu0Yx8PIzXNT79SMluYBn/+GTcrwC97hd7gAg1yYgMGYWY6GtrVyzJ
 PMMIaL17RJWa5viqCHDnxrsjFPinea1WnxQQsBvKZQ+5X0XNhV3n
X-Google-Smtp-Source: AGHT+IGqBG4H9n9BeYxAw8s+gZhCasJ1RKguTiylGg6oAJG46D7kvow9JeIsPhy/CZ4M+1mfm2wuSQ==
X-Received: by 2002:a17:906:a1c5:b0:a67:b440:e50f with SMTP id
 a640c23a62f3a-a68224472c9mr607304666b.63.1717433263438; 
 Mon, 03 Jun 2024 09:47:43 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c014:12e2:7350:b51b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67e73faa76sm505449766b.75.2024.06.03.09.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 09:47:43 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: michal.simek@amd.com,
	trini@konsulko.com
Cc: santoshsagar.algapally@amd.com, vassilisamir@gmail.com,
 vasileios.amoiridis@cern.ch, LPolak@arri.de, venkatesh.abbarapu@amd.com,
 u-boot@lists.denx.de, sr@denx.de
Subject: [PATCH v2 1/1] xilinx: Add option to load environment from outside of
 boot media
Date: Mon,  3 Jun 2024 18:47:38 +0200
Message-Id: <20240603164738.437834-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240603164738.437834-1-vassilisamir@gmail.com>
References: <20240603164738.437834-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Jun 2024 15:18:43 +0200
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

From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>

Currently, if the environment is not in the current boot media, the
env_get_location() is returning ENVL_UNKNOWN or ENVL_NOWHERE which
is not true (i.e booting from FLASH with environment in eMMC). This
commit adds an extra check to find the environment in the other
supported boot media, keeping the same priority as of now.

Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
---
 board/xilinx/versal-net/board.c | 47 ++++++++++++++--------------
 board/xilinx/versal/board.c     | 47 ++++++++++++++--------------
 board/xilinx/zynq/board.c       | 49 +++++++++++++++--------------
 board/xilinx/zynqmp/zynqmp.c    | 55 +++++++++++++++++----------------
 4 files changed, 101 insertions(+), 97 deletions(-)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index da03024e16..5295221aaa 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -377,29 +377,30 @@ enum env_location env_get_location(enum env_operation op, int prio)
 {
 	u8 bootmode = versal_net_get_bootmode();
 
-	if (prio)
-		return ENVL_UNKNOWN;
-
-	switch (bootmode) {
-	case EMMC_MODE:
-	case SD_MODE:
-	case SD1_LSHFT_MODE:
-	case SD_MODE1:
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
-			return ENVL_FAT;
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
-			return ENVL_EXT4;
-		return ENVL_NOWHERE;
-	case OSPI_MODE:
-	case QSPI_MODE_24BIT:
-	case QSPI_MODE_32BIT:
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
-			return ENVL_SPI_FLASH;
-		return ENVL_NOWHERE;
-	case JTAG_MODE:
-	case SELECTMAP_MODE:
-	default:
-		return ENVL_NOWHERE;
+	if (!prio) {
+		switch (bootmode) {
+		case EMMC_MODE:
+		case SD_MODE:
+		case SD1_LSHFT_MODE:
+		case SD_MODE1:
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
+				return ENVL_FAT;
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
+				return ENVL_EXT4;
+			break;
+		case OSPI_MODE:
+		case QSPI_MODE_24BIT:
+		case QSPI_MODE_32BIT:
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+				return ENVL_SPI_FLASH;
+			break;
+		case JTAG_MODE:
+		case SELECTMAP_MODE:
+		default:
+			return ENVL_NOWHERE;
+		}
 	}
+
+	return arch_env_get_location(op, prio);
 }
 #endif
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 4f6d56119d..4201c3e2ef 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -296,29 +296,30 @@ enum env_location env_get_location(enum env_operation op, int prio)
 {
 	u32 bootmode = versal_get_bootmode();
 
-	if (prio)
-		return ENVL_UNKNOWN;
-
-	switch (bootmode) {
-	case EMMC_MODE:
-	case SD_MODE:
-	case SD1_LSHFT_MODE:
-	case SD_MODE1:
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
-			return ENVL_FAT;
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
-			return ENVL_EXT4;
-		return ENVL_NOWHERE;
-	case OSPI_MODE:
-	case QSPI_MODE_24BIT:
-	case QSPI_MODE_32BIT:
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
-			return ENVL_SPI_FLASH;
-		return ENVL_NOWHERE;
-	case JTAG_MODE:
-	case SELECTMAP_MODE:
-	default:
-		return ENVL_NOWHERE;
+	if (!prio) {
+		switch (bootmode) {
+		case EMMC_MODE:
+		case SD_MODE:
+		case SD1_LSHFT_MODE:
+		case SD_MODE1:
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
+				return ENVL_FAT;
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
+				return ENVL_EXT4;
+			break;
+		case OSPI_MODE:
+		case QSPI_MODE_24BIT:
+		case QSPI_MODE_32BIT:
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+				return ENVL_SPI_FLASH;
+			break;
+		case JTAG_MODE:
+		case SELECTMAP_MODE:
+		default:
+			return ENVL_NOWHERE;
+		}
 	}
+
+	return arch_env_get_location(op, prio);
 }
 #endif
diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index 6c36591001..4c9923de18 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -138,31 +138,32 @@ enum env_location env_get_location(enum env_operation op, int prio)
 {
 	u32 bootmode = zynq_slcr_get_boot_mode() & ZYNQ_BM_MASK;
 
-	if (prio)
-		return ENVL_UNKNOWN;
-
-	switch (bootmode) {
-	case ZYNQ_BM_SD:
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
-			return ENVL_FAT;
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
-			return ENVL_EXT4;
-		return ENVL_NOWHERE;
-	case ZYNQ_BM_NAND:
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_NAND))
-			return ENVL_NAND;
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_UBI))
-			return ENVL_UBI;
-		return ENVL_NOWHERE;
-	case ZYNQ_BM_NOR:
-	case ZYNQ_BM_QSPI:
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
-			return ENVL_SPI_FLASH;
-		return ENVL_NOWHERE;
-	case ZYNQ_BM_JTAG:
-	default:
-		return ENVL_NOWHERE;
+	if (!prio) {
+		switch (bootmode) {
+		case ZYNQ_BM_SD:
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
+				return ENVL_FAT;
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
+				return ENVL_EXT4;
+			break;
+		case ZYNQ_BM_NAND:
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_NAND))
+				return ENVL_NAND;
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_UBI))
+				return ENVL_UBI;
+			break;
+		case ZYNQ_BM_NOR:
+		case ZYNQ_BM_QSPI:
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+				return ENVL_SPI_FLASH;
+			break;
+		case ZYNQ_BM_JTAG:
+		default:
+			return ENVL_NOWHERE;
+		}
 	}
+
+	return arch_env_get_location(op, prio);
 }
 
 #if defined(CONFIG_SET_DFU_ALT_INFO)
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index f370fb7347..b610668d28 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -593,34 +593,35 @@ enum env_location env_get_location(enum env_operation op, int prio)
 {
 	u32 bootmode = zynqmp_get_bootmode();
 
-	if (prio)
-		return ENVL_UNKNOWN;
-
-	switch (bootmode) {
-	case EMMC_MODE:
-	case SD_MODE:
-	case SD1_LSHFT_MODE:
-	case SD_MODE1:
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
-			return ENVL_FAT;
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
-			return ENVL_EXT4;
-		return ENVL_NOWHERE;
-	case NAND_MODE:
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_NAND))
-			return ENVL_NAND;
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_UBI))
-			return ENVL_UBI;
-		return ENVL_NOWHERE;
-	case QSPI_MODE_24BIT:
-	case QSPI_MODE_32BIT:
-		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
-			return ENVL_SPI_FLASH;
-		return ENVL_NOWHERE;
-	case JTAG_MODE:
-	default:
-		return ENVL_NOWHERE;
+	if (!prio) {
+		switch (bootmode) {
+		case EMMC_MODE:
+		case SD_MODE:
+		case SD1_LSHFT_MODE:
+		case SD_MODE1:
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
+				return ENVL_FAT;
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
+				return ENVL_EXT4;
+			break;
+		case NAND_MODE:
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_NAND))
+				return ENVL_NAND;
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_UBI))
+				return ENVL_UBI;
+			break;
+		case QSPI_MODE_24BIT:
+		case QSPI_MODE_32BIT:
+			if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+				return ENVL_SPI_FLASH;
+			break;
+		case JTAG_MODE:
+		default:
+			return ENVL_NOWHERE;
+		}
 	}
+
+	return arch_env_get_location(op, prio);
 }
 #endif
 
-- 
2.34.1

