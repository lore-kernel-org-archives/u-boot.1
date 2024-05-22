Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA83BC25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 18:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 461DF88464;
	Wed, 22 May 2024 20:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KDlca9NA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8505B87E0D; Wed, 22 May 2024 19:47:45 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 842C587E53
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56e1bbdb362so8498190a12.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716400063; x=1717004863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sp+wddFN+o6HcmwyDdF6R6CImpZUGCE+0rU+expnbbI=;
 b=KDlca9NAR27fOSdlX8wLGRFRjGHGwxv3A5HN4LJFyT4RW3wF05k4GTstsk7GYLJs37
 ojKQkXC3T4ksbeLlGeex/dssfk/YssPlw+smL4bEWlAknhBQV+SxTaFwEdg7tXmRz8Ar
 zLFiOlhNOSj/4cQumhwVh/KMneyM33Q/fsCVRexE6/y0vc+w2K7/pNK4p0EXaKlJWWEI
 i1IMifTYUaVY1nc9QZdxG/He7eZT/zMzZJaHI92AkobXib75+J6iRSFemQx4XuQUxoji
 cVgmJvqtFNxTJSL9osH8A6olWxtS948eivEMw7NrOoiXAfGuvLNY8ZQkQFQ3FPD8qC5H
 O+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716400063; x=1717004863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sp+wddFN+o6HcmwyDdF6R6CImpZUGCE+0rU+expnbbI=;
 b=XoV2gOwd7NKvvhtNYOMX2uDjmQczo9u51sIDUfLvhgNKJmOGsDNHjRAVVd84xk5Grs
 sOSv33YPktm+sxJAS9JTtoIo+loGk7wmz4bb1J5+KZFdOpmeg28NQ0l2PWkgAyuGknas
 +sfz957S7/LKmRm1j8fwc3uPlIjog6xO+dR3P/HaproLfaj1uqRCA1xrFqPdylWKg7kH
 iVLxr0OFaH1HpPI17TkE6GF8w4FNN1W4MFbf6s78cASuL2qhAy2U1KHGZAfcMAa7gZRj
 HzENY+UfUtFfKx3fnpKfU14gLzyZoX+Xkmcy1l+4jbN6RpMcd49YIhcLCd8FTQw20P+d
 quZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrpul5j6cPcdhdxkHTzgzRoX55tRCO60xlEssfPGkiOKgk2yDg3fYobjwGInxn1c07KsjaKX0uVPOjlFeQmCneDRD+Aw==
X-Gm-Message-State: AOJu0YzKq3XeVNj5KIUkgndBU2Z+nnIcOo6l2FUZ05YIcmE86TnktrPd
 IWo6kM+6sQpV2Mn8n7HAm28rDQ1qJAc5BFWjVb/lPwRonrig4/XF
X-Google-Smtp-Source: AGHT+IHfnZBuPPNASI1VoA3GO/Jriv04RtssV/BsmWeiSxbGzBYO+AVKaBRv2aZD7If2i6nD4UzDFQ==
X-Received: by 2002:a17:906:75b:b0:a59:c5c2:a31c with SMTP id
 a640c23a62f3a-a622812a542mr263249666b.33.1716400062600; 
 Wed, 22 May 2024 10:47:42 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:cd60:c296:de6d:ffc9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b179casm1800697166b.203.2024.05.22.10.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 10:47:42 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: michal.simek@amd.com,
	trini@kosnulko.com
Cc: ashok.reddy.soma@amd.com, venkatesh.abbarapu@amd.com, sr@denx.de,
 LPolak@arri.de, vasileios.amoiridis@cern.ch,
 santoshsagar.algapally@amd.com, u-boot@lists.denx.de
Subject: [PATCH] xilinx: Add option to load environment from outside of boot
 media
Date: Wed, 22 May 2024 19:47:38 +0200
Message-Id: <20240522174738.73522-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 May 2024 20:36:34 +0200
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
 board/xilinx/versal-net/board.c | 21 +++++++++++++++++++--
 board/xilinx/versal/board.c     | 23 ++++++++++++++++++++---
 board/xilinx/zynq/board.c       | 31 +++++++++++++++++++++++++++----
 board/xilinx/zynqmp/zynqmp.c    | 31 +++++++++++++++++++++++++++----
 4 files changed, 93 insertions(+), 13 deletions(-)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index da03024e16..5648d6685e 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -372,6 +372,21 @@ void reset_cpu(void)
 {
 }
 
+static enum env_location env_locations[] = {
+#ifdef CONFIG_ENV_IS_IN_FAT
+	ENVL_FAT,
+#endif
+#ifdef CONFIG_ENV_IS_IN_EXT4
+	ENVL_EXT4,
+#endif
+#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
+	ENVL_SPI_FLASH,
+#endif
+#ifdef CONFIG_ENV_IS_NOWHERE
+	ENVL_NOWHERE,
+#endif
+};
+
 #if defined(CONFIG_ENV_IS_NOWHERE)
 enum env_location env_get_location(enum env_operation op, int prio)
 {
@@ -389,17 +404,19 @@ enum env_location env_get_location(enum env_operation op, int prio)
 			return ENVL_FAT;
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
 			return ENVL_EXT4;
-		return ENVL_NOWHERE;
+		break;
 	case OSPI_MODE:
 	case QSPI_MODE_24BIT:
 	case QSPI_MODE_32BIT:
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
 			return ENVL_SPI_FLASH;
-		return ENVL_NOWHERE;
+		break;
 	case JTAG_MODE:
 	case SELECTMAP_MODE:
 	default:
 		return ENVL_NOWHERE;
 	}
+
+	return env_locations[prio];
 }
 #endif
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 4f6d56119d..8aed2e97df 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -291,12 +291,27 @@ void reset_cpu(void)
 {
 }
 
+static enum env_location env_locations[] = {
+#ifdef CONFIG_ENV_IS_IN_FAT
+	ENVL_FAT,
+#endif
+#ifdef CONFIG_ENV_IS_IN_EXT4
+	ENVL_EXT4,
+#endif
+#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
+	ENVL_SPI_FLASH,
+#endif
+#ifdef CONFIG_ENV_IS_NOWHERE
+	ENVL_NOWHERE,
+#endif
+};
+
 #if defined(CONFIG_ENV_IS_NOWHERE)
 enum env_location env_get_location(enum env_operation op, int prio)
 {
 	u32 bootmode = versal_get_bootmode();
 
-	if (prio)
+	if (prio >= ARRAY_SIZE(env_locations))
 		return ENVL_UNKNOWN;
 
 	switch (bootmode) {
@@ -308,17 +323,19 @@ enum env_location env_get_location(enum env_operation op, int prio)
 			return ENVL_FAT;
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
 			return ENVL_EXT4;
-		return ENVL_NOWHERE;
+		break;
 	case OSPI_MODE:
 	case QSPI_MODE_24BIT:
 	case QSPI_MODE_32BIT:
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
 			return ENVL_SPI_FLASH;
-		return ENVL_NOWHERE;
+		break;
 	case JTAG_MODE:
 	case SELECTMAP_MODE:
 	default:
 		return ENVL_NOWHERE;
 	}
+
+	return env_locations[prio];
 }
 #endif
diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index 6c36591001..6fa5016cdd 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -134,11 +134,32 @@ int dram_init(void)
 }
 #endif
 
+static enum env_location env_locations[] = {
+#ifdef CONFIG_ENV_IS_IN_FAT
+	ENVL_FAT,
+#endif
+#ifdef CONFIG_ENV_IS_IN_EXT4
+	ENVL_EXT4,
+#endif
+#ifdef CONFIG_ENV_IS_IN_NAND
+	ENVL_NAND,
+#endif
+#ifdef CONFIG_ENV_IS_IN_UBI
+	ENVL_UBI,
+#endif
+#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
+	ENVL_SPI_FLASH,
+#endif
+#ifdef CONFIG_ENV_IS_NOWHERE
+	ENVL_NOWHERE,
+#endif
+};
+
 enum env_location env_get_location(enum env_operation op, int prio)
 {
 	u32 bootmode = zynq_slcr_get_boot_mode() & ZYNQ_BM_MASK;
 
-	if (prio)
+	if (prio >= ARRAY_SIZE(env_locations))
 		return ENVL_UNKNOWN;
 
 	switch (bootmode) {
@@ -147,22 +168,24 @@ enum env_location env_get_location(enum env_operation op, int prio)
 			return ENVL_FAT;
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
 			return ENVL_EXT4;
-		return ENVL_NOWHERE;
+		break;
 	case ZYNQ_BM_NAND:
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_NAND))
 			return ENVL_NAND;
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_UBI))
 			return ENVL_UBI;
-		return ENVL_NOWHERE;
+		break;
 	case ZYNQ_BM_NOR:
 	case ZYNQ_BM_QSPI:
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
 			return ENVL_SPI_FLASH;
-		return ENVL_NOWHERE;
+		break;
 	case ZYNQ_BM_JTAG:
 	default:
 		return ENVL_NOWHERE;
 	}
+
+	return env_locations[prio];
 }
 
 #if defined(CONFIG_SET_DFU_ALT_INFO)
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index f370fb7347..7e646d342b 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -588,12 +588,33 @@ int mmc_get_env_dev(void)
 	return bootseq;
 }
 
+static enum env_location env_locations[] = {
+#ifdef CONFIG_ENV_IS_IN_FAT
+	ENVL_FAT,
+#endif
+#ifdef CONFIG_ENV_IS_IN_EXT4
+	ENVL_EXT4,
+#endif
+#ifdef CONFIG_ENV_IS_IN_NAND
+	ENVL_NAND,
+#endif
+#ifdef CONFIG_ENV_IS_IN_UBI
+	ENVL_UBI,
+#endif
+#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
+	ENVL_SPI_FLASH,
+#endif
+#ifdef CONFIG_ENV_IS_NOWHERE
+	ENVL_NOWHERE,
+#endif
+};
+
 #if defined(CONFIG_ENV_IS_NOWHERE)
 enum env_location env_get_location(enum env_operation op, int prio)
 {
 	u32 bootmode = zynqmp_get_bootmode();
 
-	if (prio)
+	if (prio >= ARRAY_SIZE(env_locations))
 		return ENVL_UNKNOWN;
 
 	switch (bootmode) {
@@ -605,22 +626,24 @@ enum env_location env_get_location(enum env_operation op, int prio)
 			return ENVL_FAT;
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
 			return ENVL_EXT4;
-		return ENVL_NOWHERE;
+		break;
 	case NAND_MODE:
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_NAND))
 			return ENVL_NAND;
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_UBI))
 			return ENVL_UBI;
-		return ENVL_NOWHERE;
+		break;
 	case QSPI_MODE_24BIT:
 	case QSPI_MODE_32BIT:
 		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
 			return ENVL_SPI_FLASH;
-		return ENVL_NOWHERE;
+		break;
 	case JTAG_MODE:
 	default:
 		return ENVL_NOWHERE;
 	}
+
+	return env_locations[prio];
 }
 #endif
 

base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
-- 
2.34.1

