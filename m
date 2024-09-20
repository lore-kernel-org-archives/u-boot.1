Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ACACF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E825989391;
	Fri, 20 Sep 2024 09:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aNOiW/rQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE7789391; Fri, 20 Sep 2024 09:04:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C0489399
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815838; x=1758351838;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7XwlD1u6WsjUbiHCVN79JTX/k60Es+X5zsKy8NPLsog=;
 b=aNOiW/rQM1LN2UiOInkQbH3uP4fIT2KpOhs9IJTYSbSWalMBoGH11Ky+
 tW2APCjOcMKC8S4WCHozeRVUkEW+vYqNwTDDaDOl04pU66Yr7WM7Iz90j
 TfvDzq8ubqrmZlRNxRAsBiZvbobrE7VKAD6vGw8k+nNbTfaQSCyGAX6ep
 ijsJDKSi4Fd+8JA784qqHRJmBdF72HXDDGtHHvrVxTRMTWnNJi3/27PDM
 3G/PSdJ1poY3KsN8bHM6UAELMQG9xUTYHHXfgirCBdlbWxoXswqYBJylq
 jnN3+oTUVsjfI1iD1rFGPwyZL2vMLebVZKYYsLyVdeVpzB4OLnhmljaxu g==;
X-CSE-ConnectionGUID: 7Wen6Ot4SDu2iflHW7WDXg==
X-CSE-MsgGUID: Awk7TjozSvS1AzqlP/kI3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961125"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961125"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:57 -0700
X-CSE-ConnectionGUID: SIxrIrIISCWneLXGWpGdoQ==
X-CSE-MsgGUID: P1wqM0D/R1qaz2niOrMbfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235305"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:55 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 20/20] configs: socfpga: soc64: agilex5: Enable QSPI boot
 with UBI / UBIFS
Date: Fri, 20 Sep 2024 15:02:42 +0800
Message-Id: <20240920070242.20884-21-tien.fong.chee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920070242.20884-1-tien.fong.chee@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
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

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 configs/socfpga_agilex5_defconfig      | 1 +
 include/configs/socfpga_soc64_common.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index a4a5064d9c2..4ac118f1fec 100644
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
index b7ee1dbf201..7a44f042165 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -56,6 +56,11 @@
 
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

