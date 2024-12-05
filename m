Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEFAE7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D867C894DC;
	Thu,  5 Dec 2024 14:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fE8xmLHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 950358942A; Thu,  5 Dec 2024 04:57:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13CA289265
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 04:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=muhammad.hazim.izzat.zamri@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733371035; x=1764907035;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OxGNn54TtdxhngWSsqY33daXderu4QPYPiTZ/o2bZLM=;
 b=fE8xmLHJDUfNxqO3WljUU1fJfMR2e+EIxfZu7jB3uszx/aNfth6d2tFr
 jlwOYQPKMOx0vcg6qJ+SmxScOnRx1OXu71LIVUAMiilN+DEOArvGZUd2l
 tbhUjpBjQCTo9OLgp/KALyhorPYiL2cIwZyHwX1Ijl2MXZrF/Tf2LGkVI
 ABHBi0EvtxLV++oYmVMzXyN7FZfGCWuveCZRN6Nm0rRvbXObf/q3ivQ0r
 kP6OAy+v0iPqHYLoFWQO6Wjz+goRO/FvXiPvOhOHs9XaXssd10SofG4jz
 63J3nNH+wEr7b0DvAU9ECdnqW9FsRJ04iY/J2sdyEFdzpAKZzjUXQjFaR g==;
X-CSE-ConnectionGUID: CxZq5ltFRWqN0Swhbd6f+g==
X-CSE-MsgGUID: Hb8m/WybT0aSS326Mu+7CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="51080336"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="51080336"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 19:57:13 -0800
X-CSE-ConnectionGUID: z+fbBH0+RGe42Khtb0kguw==
X-CSE-MsgGUID: 9K/OE+3oS+2lHjFMBkJUKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94154100"
Received: from apgcp0d540112.png.altera.com ([10.244.77.34])
 by fmviesa008.fm.intel.com with ESMTP; 04 Dec 2024 19:57:10 -0800
From: muhammad.hazim.izzat.zamri@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong <tien.fong.chee@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Kok Kiang <kok.kiang.hea@intel.com>, Dinesh <dinesh.maniyam@intel.com>,
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH v1 1/1] arm: socfpga:agilex5: Fix system manager watchdog mode
 setting
Date: Thu,  5 Dec 2024 11:56:00 +0800
Message-Id: <20241205035600.10545-2-muhammad.hazim.izzat.zamri@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20241205035600.10545-1-muhammad.hazim.izzat.zamri@intel.com>
References: <20241205035600.10545-1-muhammad.hazim.izzat.zamri@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Dec 2024 14:07:50 +0100
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
2.25.1

