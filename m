Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF223C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E921280F67;
	Tue, 18 Feb 2025 09:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ll+0YETZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF2AD80F60; Tue, 18 Feb 2025 09:36:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77CF680F60
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867784; x=1771403784;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6/xCmS1lXM/4j7GdZzxWVNp+32ZUDdLC4uAYRf0vdNU=;
 b=ll+0YETZ/z0Ed8J3+VYjLDeHja05G97zie27lhO/M0qGb6jB14PIjCor
 K45K9XW9w3IwUnyBOk1YTIA4GgkKmWvlFi6KdlNpMjCaSk8Y1NxgpuKHc
 Zz6q0uP2skK3ngrbEUpCRM9sSGAfVt7lA/tob9TQ9Y5+Doy4AjcwemMO5
 nKC2cyPPBE/mG4OL6GJZCXjJHJJOJqhPZECdZRngiA9mFNXyQIXwyiiRT
 aUF5/EDBi1W0JORZ6oOShxBxScRhkbop2EyVCQ7ofR33Y30eZfvHSWuZ6
 zmcUg+YHmHuOSO4uWVHIrMu2cQlFwHk30UBpWzEithKyGlPVCV9NEZhFH A==;
X-CSE-ConnectionGUID: JNSXS9Y7Qn+G8mQ7g8XhUA==
X-CSE-MsgGUID: vUiJCnk1Sqa4VSbledvnDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028240"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028240"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:36:24 -0800
X-CSE-ConnectionGUID: 2RM2W3jdT8CM4HSvfTmUHQ==
X-CSE-MsgGUID: H7A04ic8RIW7qFcB6cCClg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237864"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:36:22 -0800
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
Subject: [PATCH v2 26/26] configs: agilex5: Enable watchdog autostart
Date: Tue, 18 Feb 2025 16:35:11 +0800
Message-Id: <20250218083511.29249-27-alif.zakuan.yuslaimi@intel.com>
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

Automatically start watchdog timer for Agilex5. This
configuration is enabled by default in the Kconfig,
hence removing this configuration from Agilex5 defconfig.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 5b3e8125aa2..ca3ec23acfe 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -86,7 +86,6 @@ CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_DWC2=y
-# CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
-- 
2.25.1

