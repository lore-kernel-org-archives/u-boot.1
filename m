Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB266C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C22D080FD8;
	Wed, 26 Feb 2025 17:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VjpUNg/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E133780FD8; Wed, 26 Feb 2025 17:20:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 660558004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586825; x=1772122825;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2701ighFYaXRC4Dryxo91VdTxaUfg23TYW/pnw3ACvc=;
 b=VjpUNg/mi/+XdmmCIOw3qVjJTpLEGfxKCfI5eXzEHK57twNawf8s8YNe
 NkM4u13i+6VoptWf3gZ0h3ICDApV1JvfBdaqm4ko1xs+CF+qcGvo9nWsi
 kb4zaUdArUXlecJMGQwQvocgSv6BF4w+53FElDP1gXJpVJGjVLfrTHEga
 /LCZ2TOKvjK+54hnmaa52tUyp3GlVChW1LCkit83w22/B4vReRVVHaCbx
 8I0UguF+2mN0aBtZvXPGf6bu/vus6B4qw+tWhNdfSCwkJ2LBzgwvc5z47
 KLqFvsDOY7iG+WrOTPwR8M1L/Y3qHKsWz62OXL+VwP/bePNhz+WHU3Izu g==;
X-CSE-ConnectionGUID: fqWUM0YXT9e1t0Eyka/dQw==
X-CSE-MsgGUID: PZeK/S+cQ6ybwPL0f+Gy8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640274"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640274"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:20:24 -0800
X-CSE-ConnectionGUID: vlKCcQd1R9iRY5ZIkCos+A==
X-CSE-MsgGUID: jA9TE3OhSnSNDOPlvqjTrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602862"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:20:19 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [resend v3 18/19] drivers: mtd: nand: Kconfig: Add SYS_NAND_PAGE_SIZE
 dependency
Date: Thu, 27 Feb 2025 00:18:32 +0800
Message-Id: <20250226161833.53689-19-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20250226161833.53689-1-dinesh.maniyam@intel.com>
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

Add SYS_NAND_PAGE_SIZE dependency for cadence NAND.
This config is needed as the SPL driver will use this parameter
to read uboot-proper image in NAND during booting.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index d6ac730224..2ede732204 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -699,7 +699,7 @@ config SYS_NAND_PAGE_SIZE
 		SPL_NAND_SIMPLE || (NAND_MXC && SPL_NAND_SUPPORT) || \
 		MVEBU_SPL_BOOT_DEVICE_NAND || \
 		(NAND_ATMEL && SPL_NAND_SUPPORT) || \
-		SPL_GENERATE_ATMEL_PMECC_HEADER || NAND_SANDBOX
+		SPL_GENERATE_ATMEL_PMECC_HEADER || NAND_SANDBOX || NAND_CADENCE
 	depends on !NAND_MXS && !NAND_DENALI_DT && !NAND_LPC32XX_MLC && !NAND_MT7621
 	help
 	  Number of data bytes in one page for the NAND chip on the
-- 
2.19.0

