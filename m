Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDCCC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9271080FD1;
	Tue, 18 Feb 2025 09:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WG8exsIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C6180FDD; Tue, 18 Feb 2025 09:36:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3FB780FB4
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867775; x=1771403775;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7jF5kTjut3kO7Ihs5AYKyxDixaykBvj/+iU/AOvNEIU=;
 b=WG8exsIU9Jyz/iczasQOHweES8oXb17rYC4rr9iJUWPc8mIYy2aX1PED
 sfn7qN7zsX/LKzNnpi1KbLhHGO26ioN4cQIcPlE1eNtaUBVge0k1CRO2h
 o8WKrkwusIZf76nPEqq2Pmg2MyO5GbPrGRE+89Vekyt3SfFKS+/AGWR+b
 v4qvD5kWhq7TrY44+nuHv4OnXnT7PhYr+18tCICNGXcb0gpWe8BFLMlAw
 bZqabrzLGiFEjfY34a8p9pdVR3pdnS6aLlatXKA249Xdu1vSN7kVQRIie
 cItCQThkVLFau+/r++pHgXApRoj5B1YZaA2Qi1MPC+Aql2FdHXsRP+NMU Q==;
X-CSE-ConnectionGUID: W7FNYK7zTOyCfpeuwl+S9Q==
X-CSE-MsgGUID: eQ09Zn8/R2iU9WqioY8XXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028213"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028213"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:36:14 -0800
X-CSE-ConnectionGUID: wC3ni61dQ66pgm+bmCqKxQ==
X-CSE-MsgGUID: qbCBuRqGQnyYArST2aIe1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237828"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:36:12 -0800
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
Subject: [PATCH v2 22/26] configs: socfpga: soc64: agilex5: Use common ARMv8
 linker script
Date: Tue, 18 Feb 2025 16:35:07 +0800
Message-Id: <20250218083511.29249-23-alif.zakuan.yuslaimi@intel.com>
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

Use default common ARMv8 linker script instead of a separate
SoC64 linker script

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

---

v1->v2
- Move to common ARMv8 linker script
---
 configs/socfpga_agilex5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 61ce065a2bf..97b00a82129 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_TEXT_BASE=0x80200000
 CONFIG_NR_DRAM_BANKS=3
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80300000
 CONFIG_SF_DEFAULT_MODE=0x2003
-- 
2.25.1

