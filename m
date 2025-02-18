Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C43C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E3D80F7D;
	Tue, 18 Feb 2025 09:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Xs7Na+JZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F298807F1; Tue, 18 Feb 2025 09:35:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B7280F9A
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867749; x=1771403749;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RYHTAt5p3S9l61gNjaDrg2U73uHC0QIlw1+nvqRR+8o=;
 b=Xs7Na+JZMilOJr1di708pW/RQomDJddEFPNFtdIsrBp9yxwXyzjuy66h
 Fru4C0K4u82XW32r46k3xQep7KP2TlMMiTqkhfs+CpvXRTW2FE8HCTRee
 Uo45fuXZ5V1F5W3zdHEyz3IpY2IZlSrhVe9DJ6tnYpvA2LEH+OeHDXpD1
 wUgb3rvBsaGe5SlbLDoZK9+vO+P/KLajUpAAy8veGBJtXbwlKzJREoYS3
 kx+DrxhPHA7/MECG9sKLdUMB3ZvcLqrZIErFfLwmzEXSZ0swWw8RDSXKO
 hZfaQaqQd8zqCN1uvAWWHBk1aRZpL+00kBQsbe4jmMmOhFIsCe+cOXFtL A==;
X-CSE-ConnectionGUID: ueBmBv3JQJypL0Ra+TKF7w==
X-CSE-MsgGUID: tbUev3VPQpOkNZj0dfmy6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028156"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028156"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:35:49 -0800
X-CSE-ConnectionGUID: Oh+GckcqQIqNgTt3dpSxmg==
X-CSE-MsgGUID: Wng/eo8jTV+siwC3k570TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237744"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:47 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 12/26] arch: arm: Enable PSCI reset driver for Agilex5
Date: Tue, 18 Feb 2025 16:34:57 +0800
Message-Id: <20250218083511.29249-13-alif.zakuan.yuslaimi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Enable PSCI reset driver for Agilex5 cold and warm reset

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>

---

v1->v2
- Use common PSCI reset driver instead of implementing separate
  reset driver for Agilex5
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 865a56e2c8d..eb9a9eea9fa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1131,6 +1131,7 @@ config ARCH_SOCFPGA
 	select SYSRESET_SOCFPGA if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select SYSRESET_SOCFPGA_SOC64 if !TARGET_SOCFPGA_AGILEX5 && \
 	  TARGET_SOCFPGA_SOC64
+	select SYSRESET_PSCI if TARGET_SOCFPGA_AGILEX5
 	imply CMD_DM
 	imply CMD_MTDPARTS
 	imply CRC32_VERIFY
-- 
2.25.1

