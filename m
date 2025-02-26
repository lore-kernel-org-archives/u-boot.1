Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999AEC18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29CDF8104B;
	Wed, 26 Feb 2025 17:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Pm4Zpt29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08FEC8104B; Wed, 26 Feb 2025 17:20:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6597481249
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586814; x=1772122814;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CmloqA78abXHt45BvMWNdZj2Y4X71ER3jLIp+u2uUx4=;
 b=Pm4Zpt29zOaSpFHYpDgHLyav28//hvatcQ0q2FBgJLXkwNQP09qSt4BT
 /NRIFErVQ49YtbQcQTREOuNZOVp7phguiAYxKmQyfO1Mq4kQdr/lZic27
 Llkf/NBV1ktFtxREITdS8NA8xgFEHcEBbHjUYWDVNdjqLoVnSZKrI7qml
 MxBJopcPL/Qp19QagP4YwngSnGrFnxUhHeD8IBIulAXDfEow5nfPPEY+6
 yxdvXCIazRfe+6+RSKfyI6iykWZXndW3vovxBHUCS3aSSVrlLtQ8T5TPL
 PPsUedZAbu/9NWWoJBHMqP8RFJBBsYhpQOzRYF10XZ0MhP/8mM21LrgOh A==;
X-CSE-ConnectionGUID: uuIv86ZhT3a2fP1cHoopxA==
X-CSE-MsgGUID: poApAfa7T8eJlLy7jWILfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640231"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640231"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:20:13 -0800
X-CSE-ConnectionGUID: aqPJ+/bvTNK/arxL30oY3A==
X-CSE-MsgGUID: HBcqePVYSj+LGmHgs0brhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602845"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:20:08 -0800
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
Subject: [resend v3 16/19] drivers: mtd: nand: Enabled Kconfig and Makefile
 for Cadence-SPL
Date: Thu, 27 Feb 2025 00:18:30 +0800
Message-Id: <20250226161833.53689-17-dinesh.maniyam@intel.com>
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

Enable the Kconfig and Makefile for the Cadence-Nand
SPL support in agilex5 family device.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/Kconfig  | 7 +++++++
 drivers/mtd/nand/raw/Makefile | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 709c85c6e5..a9515c7b74 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -801,6 +801,13 @@ config SPL_NAND_AM33XX_BCH
 	  so those platforms should use CONFIG_SPL_NAND_SIMPLE for enabling
 	  SPL-NAND driver with software ECC correction support.
 
+config SPL_NAND_CADENCE
+	bool "Support Cadence NAND controller for SPL"
+	depends on SPL_NAND_SUPPORT
+	help
+	  This is a small implementation of the Cadence NAND controller
+	  for use on SPL.
+
 config SPL_NAND_DENALI
 	bool "Support Denali NAND controller for SPL"
 	depends on SPL_NAND_SUPPORT
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 4ad1a2037f..58fde3272f 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -10,6 +10,7 @@ NORMAL_DRIVERS=y
 endif
 
 obj-$(CONFIG_SPL_NAND_AM33XX_BCH) += am335x_spl_bch.o
+obj-$(CONFIG_SPL_NAND_CADENCE) += cadence_spl.o
 obj-$(CONFIG_SPL_NAND_DENALI) += denali_spl.o
 obj-$(CONFIG_SPL_NAND_SIMPLE) += nand_spl_simple.o
 obj-$(CONFIG_SPL_NAND_LOAD) += nand_spl_load.o
-- 
2.19.0

