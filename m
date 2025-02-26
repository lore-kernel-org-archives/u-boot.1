Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83828C18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA25C8118A;
	Wed, 26 Feb 2025 17:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fPpP/4qN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA2C8004F; Wed, 26 Feb 2025 17:19:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6536F8118A
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586793; x=1772122793;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EVzPCcETdd4wNKE669MHKnm9JEoy+IIcbAEGlyy8CeM=;
 b=fPpP/4qNWpKh1KQAp/dcUumj17Uc8TYwIU6NNRDtFoFjtRKhI/tmWo9G
 C3kz3Z14k+RygKWxUw7pF+hKHedxxQyOJ37lb1N00q8CnKiT24t2q4waV
 efyjp4cAluyly/oBMUc1YbPWkAiPfr2cy4lQ8ispHwbWexXwt+HILvpEq
 ZimRYJHz/WAE0ajAVB8gf5bRZwenjDkEu7c6lnLTEDomN5hitEjGCIyBT
 K8uL1tF7jMnWiVqWeH++8TG7dBDbXLAaDwVzzseqCCZuknskO+IaJu7r/
 slGyx/2emM5XWddf5ffxsKwXl22M/KhKHjyHR62kZ22k68bxobwKrC6Pe w==;
X-CSE-ConnectionGUID: pBBsWakxRZa9ggbdfdhUGQ==
X-CSE-MsgGUID: Z3M8kKBJQIiSiaQOmsa9sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640170"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640170"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:19:52 -0800
X-CSE-ConnectionGUID: zkB6VwP9Qr6gXKI3dXSERA==
X-CSE-MsgGUID: TRehdJULRbWblibyNftHAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602801"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:19:47 -0800
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
Subject: [resend v3 12/19] drivers: nand: Enabled Kconfig and Makefile for
 cdns-nand
Date: Thu, 27 Feb 2025 00:18:26 +0800
Message-Id: <20250226161833.53689-13-dinesh.maniyam@intel.com>
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

Enable the Kconfig and Makefile for the
Cadence NAND driver for the agilex5 family device.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
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
2.19.0

