Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25821E77188
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 02:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A052A805DA;
	Mon, 13 Jan 2025 03:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W5CxN/tH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F59480079; Mon, 13 Jan 2025 03:08:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA5AC805EC
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 03:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=muhammad.hazim.izzat.zamri@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736734136; x=1768270136;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bq3iVSexk4nNIrX5ugKG3oYKOma/Xax2n20YBoXWTn8=;
 b=W5CxN/tHQpgy0f3Wzm9ypdDjyJNk7tkgtghkutkrvq9KyAydWIKZzh7a
 3PKGGFqJrChqJz+dp6mZuDjxc0tw5Xa+IhbEOovT2VBnOSx8JaVyZIHr2
 W0B8nWQANwqND8s0nwmHdFInjC/tmiO1TdEURx7mXhjqBhUYTXUQS6mlC
 t/WuC660OqYzWZU2BZGaKu6InVGO6NgEJtjp8r+ArX1EELSxAwELFCFOR
 ffWVsA/j64J+40XbfMzs2HhPjIhFQOaON2ij1pdxwRzvb7fvvIBjGr/tO
 zotlF6plb39RaUHSeUVcTnMs5AAnpU9GsznjR94AJhJGw3cx3Hq3Gok2b Q==;
X-CSE-ConnectionGUID: ui0WK7TJSXKA/kJMWntisw==
X-CSE-MsgGUID: iPeu+nHATQCHCkWaQGd6cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="54522250"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="54522250"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2025 18:08:54 -0800
X-CSE-ConnectionGUID: zfaFJg+/QA6SLuW7rQSvNA==
X-CSE-MsgGUID: f1W7o/mxTgy+GyzFSz2u4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="135141601"
Received: from apgcp0d540107.png.altera.com ([10.244.77.29])
 by orviesa002.jf.intel.com with ESMTP; 12 Jan 2025 18:08:52 -0800
From: muhammad.hazim.izzat.zamri@intel.com
To: Tien Fong <tien.fong.chee@intel.com>
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>, u-boot@lists.denx.de,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@intel.com>
Subject: [PATCH v2 1/1] arm: socfpga:agilex5: Fix system manager watchdog mode
 setting
Date: Mon, 13 Jan 2025 10:08:07 +0800
Message-Id: <20250113020807.32728-2-muhammad.hazim.izzat.zamri@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250113020807.32728-1-muhammad.hazim.izzat.zamri@intel.com>
References: <20250113020807.32728-1-muhammad.hazim.izzat.zamri@intel.com>
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

This commit is to fix the system manager watchdog mode setting to support
until mode_4 for Agilex5. This changes can refer to system manager register
map on wddbg fields.

In Agilex7 it is not detected as an issue because Agilex7 only have 4 watchdog
until mode_3 and it is already been set correctly for it to halt on any CPU in
debug mode. However, in Agilex5 this fix is needed in order to enable the watchdog
pause feature for mode_4 when entering debug mode. If 0xF is not been set on mode_4,
the Watchdog Timers will not halt on any CPU. As by default value, the pause signal
does not assert when any CPU is in debug mode and the watchdog continue to count.

Signed-off-by: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@intel.com>
---
 arch/arm/mach-socfpga/include/mach/system_manager_soc64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index b1ef4a70641..670aa3cc07e 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -182,7 +182,7 @@ void populate_sysmgr_pinmux(void);

 #define SYSMGR_DMAPERIPH_ALL_NS		0xFFFFFFFF

-#define SYSMGR_WDDBG_PAUSE_ALL_CPU	0x0F0F0F0F
+#define SYSMGR_WDDBG_PAUSE_ALL_CPU	0xFF0F0F0F

 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 #define	SYSMGR_SOC64_DDR_MODE_MSK	BIT(0)
--
2.26.2

