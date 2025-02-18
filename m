Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D104AC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12C680FBC;
	Tue, 18 Feb 2025 09:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JkKM85Gd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11AC880F9E; Tue, 18 Feb 2025 09:36:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FA7680FB4
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739867762; x=1771403762;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uGL7IyvJ5dQOM2hbG0jh01wvLet2Fvy1S+UD8xlko5M=;
 b=JkKM85Gd/dUWKPM0z7MSs81lrFjmBWozWsoxX/xkfeQa169NxCw2km9y
 bO2ACtCNXkYl5zcsjpmXW9Msn47t0J+5459rGqDWddhjLS9yTwvjSMS0K
 GtZyv9uuNqQTo0Cio7eWWZGR2ZepasapDGEkc11GbQpcWWdop05lvFaCt
 VkERMWBKZhEsfewHZd+f8iemPFgKwKz0fhP317nLquohnlYq+mH8LWdcA
 WdPNGzU/jV0PfyDOvvJw8G7x75ornqp8fV8N9p228VsYycAKvLxo3pLBj
 heEuKpwZPDWOxS0Yg9GdJ2XOhBmUYTnjBY71DlMuNMIGVpuUQQa8RKFpK w==;
X-CSE-ConnectionGUID: MYSn3WQqQBG+6GbLOTi4GA==
X-CSE-MsgGUID: Jg0c0ycmTmexMput/zMl0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63028178"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="63028178"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:36:01 -0800
X-CSE-ConnectionGUID: eoD3bjz9RguQ8p8T4Sopqw==
X-CSE-MsgGUID: g0iLl2PmT9O+1flNzRIUTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145237770"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by fmviesa001.fm.intel.com with ESMTP; 18 Feb 2025 00:35:59 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 17/26] configs: agilex5: Add configuration for malloc pool
Date: Tue, 18 Feb 2025 16:35:02 +0800
Message-Id: <20250218083511.29249-18-alif.zakuan.yuslaimi@intel.com>
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

Adding configuration for SPL malloc pool.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 configs/socfpga_agilex5_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 60e625ea805..2a2c76113cd 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -30,6 +30,10 @@ CONFIG_BOOTDELAY=5
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 initrd=0x90000000 root=/dev/ram0 rw init=/sbin/init ramdisk_size=10000000 earlycon panic=-1 nosmp kvm-arm.mode=nvhe"
 CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xbfa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_CACHE=y
-- 
2.25.1

