Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADB8CE8D49
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6751689076;
	Thu, 19 Sep 2024 05:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J8psw/7s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408D388DEA; Thu, 19 Sep 2024 05:57:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D79C589021
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718222; x=1758254222;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2eYifeLQ1Vd0xxSOpwh2VGYF6fo3j+lLiXP/Ul7s0iQ=;
 b=J8psw/7seX7WWeVh7LXRjv9OShCUbjLWpxDWfkZGnxjpBqT76faLGGhs
 e6eXRKRfJDWU6jbVawNu59ZdxE7rJsreHHNhTKX1EVAzl9sXzRoVE0tcf
 2Kkp8jYzurmLPCgGW5OVIx2/wQV58e2A9lSIBo70dPh/MErXp1yGxkh5m
 8+1uTMdIFEGkfxs5G9j7uOjf+WLacZ2ljOjh6v0QiEJQSSxt7cm3HK/ce
 rMQPHwBuoF3t90Yf+DTQnXiXd8ny2hEbPs7jH7Vrw8omhe0Q8dWJ2Jewu
 EL5eCT7GGAQi1IH/AlgPoK3L1Jch+rVqOxFlW766VrhEfnWc6T/vkvYtl w==;
X-CSE-ConnectionGUID: qo9BVvTOTNey2/ZivyL4+w==
X-CSE-MsgGUID: 5mkFr2eMQSu/UO/29aCHRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178138"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178138"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:57:01 -0700
X-CSE-ConnectionGUID: /UzlgHzYSWSLZqiw6PcKzA==
X-CSE-MsgGUID: PKVI6z/DRhu+g2QrcgbN7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253955"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:56:56 -0700
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
Subject: [PATCH 18/19] drivers: mtd: nand: Kconfig: Remove SYS_NAND_BLOCK_SIZE
 dependency
Date: Thu, 19 Sep 2024 11:55:11 +0800
Message-Id: <20240919035512.13854-19-dinesh.maniyam@intel.com>
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

This patch is to remove SYS_NAND_BLOCK_SIZE dependency for cadence NAND.
This config is not needed as the driver will send command read
parameter page to identify the NAND block size during initialization.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
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
2.26.2

