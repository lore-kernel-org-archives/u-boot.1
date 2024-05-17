Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E77C25B77
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7178884B9;
	Fri, 17 May 2024 14:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L1nKcuUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 744E288496; Fri, 17 May 2024 07:27:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E5A8882D9
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715923668; x=1747459668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DSfhaJsRLN+yY4oDLT7dh3t16UXjX9woI4MzerKywIM=;
 b=L1nKcuUvlPxkZ3KS8P6knY5m4auOHQ0SJ5j4WlKSxMp+JEjd+oUw/iin
 X0QmXiIXaTH7Zr/Ez7hanxrrkm9lyCIsYFj6e3yfSghXf+Zq6Ee8kLYXZ
 b8buPsF8nPTfryD2l+80sgVuETT794TfmYBsibWtLR63SoLarKzft59Vf
 Wy9eWp80/fUlBkpyarKO1KZJWzYeM0fNNplGbo1C93XCfXZHOC1/0lPa6
 U4kFW+FkdnzuzYts8AqNNUp7HKg9IJrev9gZckxIH/6XEhX/4B9FUp4Zs
 eWsbcwcoCdZGdvPHj9y2uJ7j1Wyxxfx62ibuQRkEda+sE33NNdeLk7ZJW Q==;
X-CSE-ConnectionGUID: jNe9XzfYQoGPHbGRhkL2VQ==
X-CSE-MsgGUID: vZyUtY4UQmeEafvqpXdG7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11929960"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="11929960"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 22:27:47 -0700
X-CSE-ConnectionGUID: YNR9BhQLQuS5wzUodKS+Bg==
X-CSE-MsgGUID: WxbX9eOkRq6IVWatjdghbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; d="scan'208";a="36188231"
Received: from pglc00543.png.intel.com ([10.221.239.235])
 by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 22:27:43 -0700
From: tingting.meng@intel.com
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Tingting Meng <tingting.meng@intel.com>
Subject: [Agilex7 M-series Platform Enablement v1 04/16] arch: arm:
 mach-socfpga: Update handoff settings for Agilex7 M-series
Date: Fri, 17 May 2024 13:26:49 +0800
Message-Id: <20240517052701.12949-5-tingting.meng@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240517052701.12949-1-tingting.meng@intel.com>
References: <20240517052701.12949-1-tingting.meng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 May 2024 14:50:41 +0200
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

From: Wan Yee Lau <wan.yee.lau@intel.com>

Handoff settings updated for new platform Agilex7 M-series.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Tingting Meng <tingting.meng@intel.com>
---
 arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
index d839f28841..747016b436 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -28,10 +28,20 @@
 #define SOC64_HANDOFF_OFFSET_DATA	0x10
 #define SOC64_HANDOFF_SIZE		4096
 
-#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10) || \
-	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX)
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64) || \
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 #define SOC64_HANDOFF_BASE		0xFFE3F000
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
+#define SOC64_HANDOFF_MISC		(SOC64_HANDOFF_BASE + 0x62C)
+/* DDR handoff */
+#define SOC64_HANDOFF_MAGIC_DDR	0x5344524D
+#define SOC64_HANDOFF_DDR_BASE	(SOC64_HANDOFF_BASE + 0x610)
+#define SOC64_HANDOFF_DDR_LEN	2
+#define SOC64_HANDOFF_DDR_INTERLEAVING_MODE_MASK	BIT(0)
+#define SOC64_HANDOFF_DDR_MEMORY_TYPE_MASK		BIT(0)
+#else
 #define SOC64_HANDOFF_MISC		(SOC64_HANDOFF_BASE + 0x610)
+#endif
 #elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 #define SOC64_HANDOFF_BASE		0x0007F000
 #elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
-- 
2.25.1

