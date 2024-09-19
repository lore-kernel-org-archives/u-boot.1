Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D5FCE8D46
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00869890EE;
	Thu, 19 Sep 2024 05:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Np7NojgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4E0C88D94; Thu, 19 Sep 2024 05:57:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D0C89021
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718227; x=1758254227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nZTKi2lb+fHILrVJAenDnHyQ13RJ6uU939mS0TMhKgk=;
 b=Np7NojgBG9XomrGMvQH6WtxXL7cNTQHoleGsSXVQLjlpiYEmdsGaJ2xT
 LXo0nBrHN/a7XvRFqEZ7iBxlfy6DHJ3Hh3n7kgSPZGkRVBcIzPo7/aDgB
 3sVcIJ9JeQFzfnAHzhkyN1lyU5XX4zGJdKVEaoQq+JnUrwlDhECUlSZtW
 SDGsHY78nUiCNTBcBbBOmPbx/2pEFnt9l/rIdcvhWu0mcz6WEAxIGmdef
 9lAkA9krje9L6EIu/lud8UthXpMJDf7SJSVj9ARh6ejjncw0waCsIosOD
 MfDIPLoVvu7YItH29aw6y7GIHKyJ6hqcQWHoho3yDS2luotad+Cevb8AZ Q==;
X-CSE-ConnectionGUID: xAZn5d1BRT2KmQtTY00ZIw==
X-CSE-MsgGUID: Q+LFlRqcSq+W6xX+l7gvUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178149"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178149"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:57:07 -0700
X-CSE-ConnectionGUID: HJa05JgVR6uBIg751ycJ/w==
X-CSE-MsgGUID: v/tr2HoPR7OGEbD0MusXqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253969"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:57:02 -0700
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
Subject: [PATCH 19/19] drivers: mtd: nand: Kconfig: Enabled self-init for
 cdns-nand SPL
Date: Thu, 19 Sep 2024 11:55:12 +0800
Message-Id: <20240919035512.13854-20-dinesh.maniyam@intel.com>
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

This patch is to enable SPL_SYS_NAND_SELF_INIT for Cadence NAND SPL.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
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
2.26.2

