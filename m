Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CDBCE8D46
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6173F89016;
	Thu, 19 Sep 2024 05:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cG9wgE4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B5889016; Thu, 19 Sep 2024 05:56:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA78289099
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718195; x=1758254195;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tedIylFykmBhjpanqSIRn3IdqVqWjGmxG0XMbmCNtnE=;
 b=cG9wgE4JfVASRSEB3tbqnd8DQQe76u8sq9Q7oK+ZwpEctEqfWONvLRwh
 A3mNlqWqhTDmGhKa/z4H1xZUVXoDSqbI10nTKrjUJl0zw8rNvlSCGaJsV
 FVtkAnMwE5zFgGgBFFqgG/ISihe34lD+p6XSF486nY0x5QqFA541Ap0eD
 UYz+2AGtQeCkxQuR3PjHR1MQPe9PKyGqMURYRDgsdKbe/g9V0nVysCTxE
 JGE1fV4SZPZoBI6p7o6/ub7uLrR3iiAkU7dPEQPqpjM7E6k0c1qxwEIz1
 SVP/MDzFkJ8XHs2ZD9U4Uyxu7uXpj1F3Y88GCUZoL09ph57gDiX9D/aGO A==;
X-CSE-ConnectionGUID: ea16e1TZQXqALOkTyVyQpg==
X-CSE-MsgGUID: sedN/35IRKGhsqVHMQLPQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178082"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178082"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:56:34 -0700
X-CSE-ConnectionGUID: n0ibpciKTxa4B8dfvpi33g==
X-CSE-MsgGUID: lWKvNjLgRtusJHpYUPjvhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253889"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:56:29 -0700
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
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 13/19] drivers: nand: Enabled Kconfig and Makefile for
 cdns-nand
Date: Thu, 19 Sep 2024 11:55:06 +0800
Message-Id: <20240919035512.13854-14-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240919035512.13854-1-dinesh.maniyam@intel.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
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

This patch is to enable the Kconfig and Makefile for the
Cadence NAND driver for the agilex5 family device.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/Kconfig  | 9 +++++++++
 drivers/mtd/nand/raw/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 9f3f1267cb..709c85c6e5 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -207,6 +207,15 @@ config SPL_NAND_LOAD
 	def_bool y
 	depends on NAND_DAVINCI && ARCH_DAVINCI && SPL_NAND_SUPPORT
 
+config NAND_CADENCE
+	bool "Support Cadence NAND controller as a DT device"
+	depends on OF_CONTROL && DM_MTD
+	select SYS_NAND_SELF_INIT
+	imply CMD_NAND
+	help
+	  Enable the driver for NAND flash on platforms using a Cadence NAND
+	  controller as a DT device.
+
 config NAND_DENALI
 	bool
 	select SYS_NAND_SELF_INIT
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 46fead6fa4..4ad1a2037f 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_NAND_ATMEL) += atmel_nand.o
 obj-$(CONFIG_DM_NAND_ATMEL) += atmel/
 obj-$(CONFIG_NAND_ARASAN) += arasan_nfc.o
 obj-$(CONFIG_NAND_BRCMNAND) += brcmnand/
+obj-$(CONFIG_NAND_CADENCE) += cadence_nand.o
 obj-$(CONFIG_NAND_DAVINCI) += davinci_nand.o
 obj-$(CONFIG_NAND_DENALI) += denali.o
 obj-$(CONFIG_NAND_DENALI_DT) += denali_dt.o
-- 
2.26.2

