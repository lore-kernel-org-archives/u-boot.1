Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAD2E77188
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 02:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5116E805C5;
	Mon, 13 Jan 2025 03:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gSX1Q2Vm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD13805DA; Mon, 13 Jan 2025 03:08:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5863A80079
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 03:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=muhammad.hazim.izzat.zamri@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736734123; x=1768270123;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gCpgbu7cx9WFvchmOPpX8b71mdewf4c7+V0yNlgB90A=;
 b=gSX1Q2Vmu9jjBKKmZE6jEZtYhntF0zKjs3VViArD+70v3cE4pkik+N1u
 0PV/tsRJ7ak9qGo6h4mCAHJ4QUuGbFTprzwec9QSbSChJUzxJZZAIFNbf
 XLdmqeI3rEGR6FPaPjw6Tmn/uRUQtOzK2z+s7/VNDwcc7GvzQ0yfZAWAc
 9GvlZLJ/+X99XMDS1juLsGMSQzcrrSfjBT/FkNklI6F7KGrie+4/Z6j3K
 XdOc8ZYne+7quMXOCAE8trysUst6ZSKxi+eqKFsWibK4iv1g697EdyGIp
 VM3FaFLgzlz2TSaE6Fd8o2GzwKaxjal1UgKqoDwerYOrMpZchZvM/aSAR g==;
X-CSE-ConnectionGUID: RjvXY/WzQLywHcXAzUEzVA==
X-CSE-MsgGUID: rNotHYGhQFuZ44bG6DahmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="54522226"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="54522226"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2025 18:08:41 -0800
X-CSE-ConnectionGUID: S4ysnyUpTBOmWFI/XfcpTQ==
X-CSE-MsgGUID: pDvJFfhHQ3GgOFpDLPWJoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="135141569"
Received: from apgcp0d540107.png.altera.com ([10.244.77.29])
 by orviesa002.jf.intel.com with ESMTP; 12 Jan 2025 18:08:39 -0800
From: muhammad.hazim.izzat.zamri@intel.com
To: Tien Fong <tien.fong.chee@intel.com>
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>, u-boot@lists.denx.de,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@intel.com>
Subject: [PATCH v2 0/1] SoCFPGA: Add watchdog mode setting for Agilex 5
Date: Mon, 13 Jan 2025 10:08:06 +0800
Message-Id: <20250113020807.32728-1-muhammad.hazim.izzat.zamri@intel.com>
X-Mailer: git-send-email 2.26.2
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

From: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@intel.com>

This patch is to introduce another watchdog mode setting in Agilex 5
as additional watchdog4 has been introduced. This is to enable
the debug mode when the CPU is paused by the user.

This patch has been tested on Agilex 5 devkit with QSPI boot (UBI/UBIFS)
and RAM boot (TFTP & ARM DS debugger).

Muhammad Hazim Izzat Zamri (1):
  arm: socfpga:agilex5: Fix system manager watchdog mode setting

 arch/arm/mach-socfpga/include/mach/system_manager_soc64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.26.2

