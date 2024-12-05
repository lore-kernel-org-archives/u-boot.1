Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94666E7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 309778919A;
	Thu,  5 Dec 2024 10:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QM0aaQQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A415989497; Thu,  5 Dec 2024 10:25:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0364C88EF7
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390698; x=1764926698;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CmloqA78abXHt45BvMWNdZj2Y4X71ER3jLIp+u2uUx4=;
 b=QM0aaQQTqhRAMAoT1blEa6HrVbI5s1MDg9E+b/d5mt6uEN+OCssBkEoX
 G24CnJQrAKGbJvU+H5EP2iPVq8pr5leQzjS1FP8PR2L0bQNIzL2FkQC8l
 koy2B8LSDQXjFAXsF2svaFT+E4noYAmeanS1dVgCX1PVRzlzXIwrwgKzu
 6h4BAi2OWd+1HDUDgGrmKs6NUwl+3hC+nT98/JoYF4UzJ+7RzfT3+tAxT
 waBzhZodgS4m1rQCSwJ1JZpRTiQTXCqLb+Iiu9+ExN2fy6ZJcnVA8Bth7
 nrgK7u3ytm9gDX8UFFcONP4hUypM+397acefQiwKbl2QNI0UNufUSVXaD g==;
X-CSE-ConnectionGUID: hI3O06bkQv2DGkWiVkZyQg==
X-CSE-MsgGUID: pRBo4NEbS0+Bf/SeAIiI9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610402"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610402"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:24:57 -0800
X-CSE-ConnectionGUID: zShVQe1vTSSW/2inF9thBg==
X-CSE-MsgGUID: IwUMtmKRTZatFzNrG98I1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94122090"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:53 -0800
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
Subject: [resend v2 17/19] drivers: mtd: nand: Enabled Kconfig and Makefile
 for Cadence-SPL
Date: Thu,  5 Dec 2024 17:23:13 +0800
Message-Id: <20241205092315.25060-18-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20241205092315.25060-1-dinesh.maniyam@intel.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
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

