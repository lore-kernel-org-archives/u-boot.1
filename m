Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C61CC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 07:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B658987B1C;
	Fri, 15 Dec 2023 08:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eZda1Fv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86ABF87B48; Fri, 15 Dec 2023 08:22:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31CE787A81
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 08:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702624935; x=1734160935;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HjMSHAjhoX+FVdSggEHDhH0GQJc4qIfk2j+Snitl2HA=;
 b=eZda1Fv3pzUARwcORai1u+2PRwBZtcJOMWUOVAf94IM/114DuaklnnEd
 IvMMe3hJkUFnNd98JhkchUt1U32GWCuXRO3pPAIG/rR5ISAb6McNPrxYI
 l3daurbQdu76J17SyK7mpJiOf6koS/19lCH+dG01etTgg3QSYDbyeEeSr
 VEcyd9GWP07TPRKC5fsDN1oDC8SFGK4Pn/tVYAYuSH3zuMHBhlQl0YpNh
 owujisuQ73IyFLBkV7HxLdZthjzAlfYKlLdqH9Gc+ad+XwK10eBfH2iVS
 z2YNOnzOImwHNEb+SyS+Fd0nf8uSPvdN0Ewk+5LI2DQgQo4XLd/rDFVih Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394982470"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; d="scan'208";a="394982470"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2023 23:22:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="947864810"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; d="scan'208";a="947864810"
Received: from ppglcf0283.png.intel.com ([10.126.161.129])
 by orsmga005.jf.intel.com with ESMTP; 14 Dec 2023 23:22:09 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH] arm: dts: agilex: Increase reserved memory size to 32MB
Date: Fri, 15 Dec 2023 15:21:51 +0800
Message-Id: <20231215072151.27261-1-dinesh.maniyam@intel.com>
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

The reserved space is extended to 32MB in Linux kernel because
additional space is needed for authorization execution of JIC/RBF file.
U-Boot required to align with Linux.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 arch/arm/dts/socfpga_agilex.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex.dtsi b/arch/arm/dts/socfpga_agilex.dtsi
index c3ead2d72b..712304d07a 100644
--- a/arch/arm/dts/socfpga_agilex.dtsi
+++ b/arch/arm/dts/socfpga_agilex.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier:     GPL-2.0
 /*
- * Copyright (C) 2019, Intel Corporation
+ * Copyright (C) 2019-2023 Intel Corporation <www.intel.com>
  */
 
 /dts-v1/;
@@ -20,7 +20,7 @@
 
 		service_reserved: svcbuffer@0 {
 			compatible = "shared-dma-pool";
-			reg = <0x0 0x0 0x0 0x1000000>;
+			reg = <0x0 0x0 0x0 0x2000000>;
 			alignment = <0x1000>;
 			no-map;
 		};
-- 
2.26.2

