Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7B6C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 991E880FB4;
	Tue, 18 Feb 2025 09:36:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MxWeDmVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9B480F67; Tue, 18 Feb 2025 09:36:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FCE080FD0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867782; x=1771403782;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HgXzfyHPxcu0t43DTEtjI5+rsyZFOt25aP+HmzOEKs4=;
 b=MxWeDmVq5OaVIZUdI47qyweJ5Xff7/Nk2m/p+nYcC/QIXg1b01IoA2E0
 tPDcPAo9Q/p8nnWhue9yckdi0ffPb17IuYHBpbRIdY1zOjTEwteiyYDCS
 S9hqyk8s/Wx0v0m+C/SQ0BfHdh3WfX8ijVsjCCw8jaaOLStmp1PeGaWnE
 XjYkQeJJzy3rvpSSMlQ5Wpn2TKZBaMXGhX28XleHwqTiDjcfff/GkGSrd
 prB4OPOE71+v+SatP6dLluawdoQDLkrpwB0w6EVz/AOt+b8/BL9K/fElG
 r1qfdlrfYcff8iWO+u3gz1gqaoDMITrsuwkjYJ5YG9bAKDU/5hZmYru8+ g==;
X-CSE-ConnectionGUID: QYMFXZ7zTweGa3HOVDCi6A==
X-CSE-MsgGUID: Hwk2nM5RTYqkFbzQEbKWIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028235"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028235"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:36:21 -0800
X-CSE-ConnectionGUID: CsOj9W8tSaGRtKFUSmladQ==
X-CSE-MsgGUID: i+iF4+7lRRm0nG2hBJeXYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237856"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:36:19 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 25/26] configs: socfpga: soc64: agilex5: Enable QSPI boot
 with UBI / UBIFS
Date: Tue, 18 Feb 2025 16:35:10 +0800
Message-Id: <20250218083511.29249-26-alif.zakuan.yuslaimi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Add the required configuration in the U-Boot env to enable Linux QSPI
boot with UBI / UBIFS.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 configs/socfpga_agilex5_defconfig      | 1 +
 include/configs/socfpga_soc64_common.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 2b71ccac025..5b3e8125aa2 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -37,6 +37,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_SPI_FLASH_MTD=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
 CONFIG_SPL_ATF=y
diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index b7ee1dbf201..5ed17671f79 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
  * Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
 
@@ -56,6 +57,11 @@
 
 #define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
 	"bootcmd_qspi=ubi detach; sf probe && " \
+	"setenv mtdids 'nor0=nor0,nand0=nand.0' && " \
+	"setenv mtdparts 'mtdparts=nor0:66m(u-boot),190m(root); " \
+	"nand.0:2m(nand_uboot),500m(nand_root)' && " \
+	"env select UBI; saveenv && " \
+	"ubi part root && " \
 	"if ubi part root && ubi readvol ${scriptaddr} script; " \
 	"then echo QSPI: Running script from UBIFS; " \
 	"elif sf read ${scriptaddr} ${qspiscriptaddr} ${scriptsize}; " \
-- 
2.25.1

