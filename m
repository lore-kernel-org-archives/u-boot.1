Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E65CCF58DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83F88893B3;
	Fri, 20 Sep 2024 09:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ils8l6Am";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D52893A4; Fri, 20 Sep 2024 09:03:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92AFB89391
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726815824; x=1758351824;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D013z8FWmJPvOnvaG82jSMXNAXKh3OHHToPv17LCfXM=;
 b=Ils8l6AmV7ddxoqyNA9Ae8pOih4jP+Hm1cyUMxW39eRaAINeW4GJa0op
 hR9o2iinrXYkoYK7UcspicRoSUv5AZq/4UIk0JdyFsIPmcnsN2xNe2qt4
 zRoyllFuMd7fuYK6IxHzSGbyXhqCczNpHgnilQfEH75IVQPEJZ0bdbSiU
 loVE4z5sYm2w3HHR29mZaawk4garbrFdeHBZjIxleWZaswsjLUjxc3Q45
 T7taEeto3PXBIYjsdYGF1ITO+axCdYP6z6TebN4eaxh7muvC112QTn28r
 v8byR4jOseTRk41MXi3B30dHJ3HWwzHNwtjy7UBYTmktoJBzV/cLfncGW w==;
X-CSE-ConnectionGUID: Oi/waYTIS6OfsGo1iZXEzw==
X-CSE-MsgGUID: rdK6duFJRRutUHJ9GAZUbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25961086"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25961086"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:03:43 -0700
X-CSE-ConnectionGUID: rKz4UdBlSlGkta/RhWbBcg==
X-CSE-MsgGUID: 7zNdzsQHRHyOPnWJRZlXMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="70235221"
Received: from pglc00502.png.intel.com ([10.221.239.194])
 by orviesa009.jf.intel.com with ESMTP; 20 Sep 2024 00:03:41 -0700
From: tien.fong.chee@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v1 14/20] configs: agilex5: Add configuration for malloc pool
Date: Fri, 20 Sep 2024 15:02:36 +0800
Message-Id: <20240920070242.20884-15-tien.fong.chee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920070242.20884-1-tien.fong.chee@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
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

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
---
 configs/socfpga_agilex5_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index dc1cef3754e..81bbe967dcf 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -29,6 +29,10 @@ CONFIG_BOOTDELAY=5
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

