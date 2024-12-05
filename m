Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEB8E7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC15894B3;
	Thu,  5 Dec 2024 10:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aNyCYJw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71AD1894CC; Thu,  5 Dec 2024 10:25:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 034BB89499
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390703; x=1764926703;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DE6lgqPvm01IWd1xDpucr8PnqoMQ7iAcnt9EXXLmgL8=;
 b=aNyCYJw5zz2A6Nxi7hXWTlb7JY1r5u+aeG/v+xsgMWW1CZO5rE2jXMht
 jcpoPwA5/zvj/nwlOWCzGtIV9aY9FtTYGwEe/Iih9+i95YYobl9BXYb8/
 KVPxLY//P0xJPagAJJ8KWEZYxi59DqbU8T0i7DinysA0TjhSqQtsJ9hJm
 5e+1evaiFilAX+mSiPmUOw7MfXqTFLnahGXkgjGuuTvNRgJR+6D8ggDlE
 p8eH1Dz+9ur0Jv4eVLH9VcFNZqreRGBO7Vhn0/PoWgFmOEAYQ+lIcWhGG
 8ua474vn7YoWn08OlIy5Rr1MkOK6ZHU4pJkBCYNblD89glMcwhkw4r81n A==;
X-CSE-ConnectionGUID: YPEqZPoySqm3iW2c6G98GA==
X-CSE-MsgGUID: r2++VqxRS7eN6gB2SM7UoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610414"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610414"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:25:02 -0800
X-CSE-ConnectionGUID: GXzT2iBSRTO8oqWSzNHteQ==
X-CSE-MsgGUID: SVfmldgGQKWwTcfSD3L+YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94122143"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:58 -0800
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
Subject: [resend v2 18/19] drivers: mtd: nand: Kconfig: Remove
 SYS_NAND_BLOCK_SIZE dependency
Date: Thu,  5 Dec 2024 17:23:14 +0800
Message-Id: <20241205092315.25060-19-dinesh.maniyam@intel.com>
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

Remove SYS_NAND_BLOCK_SIZE dependency for cadence NAND.
This config is not needed as the driver will send command read
parameter page to identify the NAND block size during initialization.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index a9515c7b74..90f8f4b688 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -680,7 +680,7 @@ config SYS_NAND_BLOCK_SIZE
 	depends on ARCH_SUNXI || SPL_NAND_SUPPORT || TPL_NAND_SUPPORT || \
 		MVEBU_SPL_BOOT_DEVICE_NAND
 	depends on !NAND_MXS && !NAND_DENALI_DT && !NAND_LPC32XX_MLC && \
-		!NAND_FSL_IFC && !NAND_MT7621
+		!NAND_FSL_IFC && !NAND_MT7621 && !NAND_CADENCE
 	help
 	  Number of data bytes in one eraseblock for the NAND chip on the
 	  board. This is the multiple of NAND_PAGE_SIZE and the number of
-- 
2.19.0

