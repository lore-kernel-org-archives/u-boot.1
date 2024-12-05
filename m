Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DDCE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FF8893F6;
	Thu,  5 Dec 2024 10:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Sjalfjy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C0EC893F7; Thu,  5 Dec 2024 10:25:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF1BC893F6
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390708; x=1764926708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ItxIl1cgdEkODNGQk2jMBUDG7XpgBleEhDNocV/busI=;
 b=Sjalfjy+qG742m08X2oTndf/0vyetzy8tzosHZFF6M1tB+f2jfFMx8mj
 CT8Pp+3Z0RxmSv3aoNSgVr1Mi07bQW/YmAwZ7sTgVbrLaZlsAzchLvUDU
 PNbqbDqGGt4HYRB//Z4Mv3yKe82nn0sGb4QY1PU8pdNUhAS0A8WMtLzGc
 TqNDZgQqwCDL6uM9Z5FiE+onpxM/3bQcs6t4eKBOt2tyZfcmrgEHPWKmE
 1j6nWJOZ8eJle8N8lYpg1nEfoJpKJlJF5jTSp59ZJnf4hOY9kTOBpPS5i
 3ULGdyV/WvdI1UdtT+QRYwtNwwgjuNYnDRe7tZc60HmaNnoXkXXfoVB0s A==;
X-CSE-ConnectionGUID: JK8qBKsTQqK5KcIIlP5nrw==
X-CSE-MsgGUID: zcmLpwXYTcmZjB5jlT4BBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610424"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610424"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:25:07 -0800
X-CSE-ConnectionGUID: 7FRSzwCBSDesYcpEs2oSzw==
X-CSE-MsgGUID: BlhfymURSyyYHD2cXAV0pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94122169"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:25:03 -0800
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
Subject: [resend v2 19/19] drivers: mtd: nand: Kconfig: Enabled self-init for
 cdns-nand SPL
Date: Thu,  5 Dec 2024 17:23:15 +0800
Message-Id: <20241205092315.25060-20-dinesh.maniyam@intel.com>
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

Enable SPL_SYS_NAND_SELF_INIT for Cadence NAND SPL.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 90f8f4b688..32444c2468 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -211,6 +211,7 @@ config NAND_CADENCE
 	bool "Support Cadence NAND controller as a DT device"
 	depends on OF_CONTROL && DM_MTD
 	select SYS_NAND_SELF_INIT
+	select SPL_SYS_NAND_SELF_INIT
 	imply CMD_NAND
 	help
 	  Enable the driver for NAND flash on platforms using a Cadence NAND
-- 
2.19.0

