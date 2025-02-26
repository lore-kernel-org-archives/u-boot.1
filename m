Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB5AC18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7467781273;
	Wed, 26 Feb 2025 17:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KcJwSLV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6918381249; Wed, 26 Feb 2025 17:20:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7F298004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586819; x=1772122819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BgNWChpNAUw67jYbm0soImzJV/pxhFV9ZHZid4WS6i0=;
 b=KcJwSLV/VKM5jzDzCk8NinFDpHBiZSiVjmHp0UgjqYDw/ve23l4FeTvK
 jjdjObSPSWiCVpCFe5jEhfOvpJ3XaJRoGy59V4+7/OJJaAmg3W7KXj/zG
 O0wMGDKuTZt9nvcE15zFKgN2yjLM71hnbbCdjduWSCJg9cZOP0qOJStk/
 9l5MXF0SxLcSDPfKmtxHMeHPyH0kD2wtLBowYzH+ENkmxRgPJMQSpa/LG
 nHuM0gW2FNpV7EQlssohFqEwHudpy2mmyV7guTZOHXjl5K7iXPKf0Kr7f
 78UPnOxebCmo6eLCVj7DcJOFQsmgdciFOkVNJdjYngxeEkqJkMcuVmWTn Q==;
X-CSE-ConnectionGUID: 7fA9nNh0SrKZmtoMPRjxZg==
X-CSE-MsgGUID: JEEaD+PnSCqAaN6juWlYxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640254"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640254"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:20:18 -0800
X-CSE-ConnectionGUID: gcOsqkz2S9+Q4eMnLYzJZg==
X-CSE-MsgGUID: roRN0hoXTKa9qaZh2xeKlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602852"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:20:14 -0800
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
Subject: [resend v3 17/19] drivers: mtd: nand: Enabled Kconfig and Makefile
 for SPL_NAND_FRAMEWORK
Date: Thu, 27 Feb 2025 00:18:31 +0800
Message-Id: <20250226161833.53689-18-dinesh.maniyam@intel.com>
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

Enable the Kconfig and Makefile for the SPL_NAND_FRAMEWORK
support in agilex5 family device. This will include all the basic
files needed to use the existing nand spl support.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/Kconfig  |  7 +++++++
 drivers/mtd/nand/raw/Makefile | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index a9515c7b74..d6ac730224 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -837,4 +837,11 @@ config SYS_NAND_HW_ECC_OOBFIRST
 
 endif	# if SPL
 
+config SPL_NAND_FRAMEWORK
+	bool "Compile the entire NAND framework into the SPL"
+	help
+	  Some drivers require a lot of functionality from the NAND framework
+	  core when used in SPL. This option allows compiling the full NAND
+	  framework into the SPL instead of it's reduced version.
+
 endif	# if MTD_RAW_NAND
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 58fde3272f..0a32e184dc 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -3,8 +3,18 @@
 # (C) Copyright 2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
+nand-framework-objs := nand.o nand_bbt.o nand_ids.o nand_util.o \
+		       nand_ecc.o nand_base.o nand_timings.o nand_amd.o \
+		       nand_hynix.o nand_macronix.o nand_micron.o \
+		       nand_samsung.o nand_toshiba.o
+
 ifdef CONFIG_SPL_BUILD
 
+ifdef CONFIG_SPL_NAND_FRAMEWORK
+obj-y += $(nand-framework-objs)
+NORMAL_DRIVERS=y
+endif
+
 ifdef CONFIG_SPL_NAND_DRIVERS
 NORMAL_DRIVERS=y
 endif
-- 
2.19.0

