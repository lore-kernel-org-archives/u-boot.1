Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22C1E77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 15:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0134A801DB;
	Sun, 12 Jan 2025 16:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WWfK35da";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE6B78058A; Sun, 12 Jan 2025 16:44:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42B9E800D2
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 16:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=muhammad.hazim.izzat.zamri@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736696693; x=1768232693;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bq3iVSexk4nNIrX5ugKG3oYKOma/Xax2n20YBoXWTn8=;
 b=WWfK35daOpQdiG0VKMZb4JG6wSVKl9cRjHuF/YUu3rF+ByQYbiLD2TXH
 nOeUfr3aqyxOa24uX0bhi7i71/n1aUTIER98Y9yB38kBKALqHCB81l/bq
 kwNOiKfV7g3SYJpvsV0AA4JrCoMnTPPHrtIkqU7V3/6xQK3dWubtTsTSc
 uHnAnx0Gf/NwJQEvN41EifLY/hJ4N2mfu21zE5puOAkyfs5mGGp4EKvth
 DESp42Ehr76VTgcNsJHUF4jXd30otNZsnDX316uDaJkIsy2EbZ3JHsrYG
 iac769KloVM2xD7gztLvuaMvemwvsqG0j38cuadGzv44KBL/RgpE7Qn4Y g==;
X-CSE-ConnectionGUID: V4fZmJ+EQfy9ScRejb5ZAg==
X-CSE-MsgGUID: PWnVL9EXSeKUjAVhgrdAIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40868177"
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; d="scan'208";a="40868177"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2025 07:44:52 -0800
X-CSE-ConnectionGUID: pthMFjLwRtmrDqjYwW1EqQ==
X-CSE-MsgGUID: Ah48Ks4ERsm84yciQDTZ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; d="scan'208";a="109198970"
Received: from apgcp0d540107.png.altera.com ([10.244.77.29])
 by orviesa004.jf.intel.com with ESMTP; 12 Jan 2025 07:44:49 -0800
From: muhammad.hazim.izzat.zamri@intel.com
To: Tien Fong <tien.fong.chee@intel.com>
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tingting Meng <tingting.meng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/1] arm: socfpga:agilex5: Fix system manager watchdog mode
 setting
Date: Sun, 12 Jan 2025 23:44:06 +0800
Message-Id: <20250112154406.1556-2-muhammad.hazim.izzat.zamri@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250112154406.1556-1-muhammad.hazim.izzat.zamri@intel.com>
References: <20250112154406.1556-1-muhammad.hazim.izzat.zamri@intel.com>
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

