Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63DECE8D49
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE10D88FB3;
	Thu, 19 Sep 2024 05:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HTac3Bnc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F4D188FB7; Thu, 19 Sep 2024 05:55:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC13889C3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718133; x=1758254133;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/IJZjXeowvXBwk0Q1jeKtidUQE4iFi0LOE55LwTHJZc=;
 b=HTac3Bnc6RpwUZdUm8DvfIk2veHV5ghXjYNSYViS5VNOrpWOvpivJ2NK
 vFCFAOdcQoP8aULjneYcUaQ1nVal5wjljZ1qgeNtpw3Qx0oqmfTf4JHCD
 TaiqXcPd4IvWlDwDWqZ3/2L6qHHiADznY1rRfOcDldGUhC7Xx73XVTFvy
 R4twiGUJ0U0F7UUClJl4sfSqu/wx5z1nHWBMyL69knOQ4s+wyCFnONOLJ
 1VnSbW9VzlbJ+oGIg76ySHGOKhpI+7cFsJKQyR5wR7gTQBjW0AVbsUAQK
 hDnp+MaDX+fAKDZgVnmcjlv7a6AZoe1vKkRDpXbLDpCjt1RmSvx2sOR0s A==;
X-CSE-ConnectionGUID: hwmdHX95To2iUo3sOPNWcA==
X-CSE-MsgGUID: w5VyRTIIR/msShuSozeobg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43177941"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43177941"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:55:32 -0700
X-CSE-ConnectionGUID: SeSAzsmFQe+iiVZTSZ25MA==
X-CSE-MsgGUID: Yn/YjNdzSF2yIzvkqpx/EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253705"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:55:27 -0700
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 02/19] arm: dts: agilex5: Enabled cdns-nand dts setting
Date: Thu, 19 Sep 2024 11:54:55 +0800
Message-Id: <20240919035512.13854-3-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240919035512.13854-1-dinesh.maniyam@intel.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
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

This patch is to enable cdns-nand dts setting for the socfpga_agilex5
family device.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 arch/arm/dts/socfpga_agilex5.dtsi             | 14 ++++++++++
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 28 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5.dtsi b/arch/arm/dts/socfpga_agilex5.dtsi
index 03b5504049..64665e499e 100644
--- a/arch/arm/dts/socfpga_agilex5.dtsi
+++ b/arch/arm/dts/socfpga_agilex5.dtsi
@@ -330,6 +330,20 @@
 			status = "disabled";
 		};
 
+		nand: nand@10b80000 {
+			compatible = "cdns,nand";
+			reg = <0x10b80000 0x10000>,
+				<0x10840000 0x1000>;
+			reg-names = "reg", "sdma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 97 4>;
+			clocks = <&clkmgr AGILEX5_NAND_CLK>;
+			resets = <&rst NAND_RESET>, <&rst COMBOPHY_RESET>;
+			cdns,board-delay-ps = <4830>;
+			status = "disabled";
+		};
+
 		ocram: sram@00000000 {
 			compatible = "mmio-sram";
 			reg = <0x00000000 0x200000>;
diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index 9eb21d6542..f9cca84ee3 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -41,6 +41,10 @@
 	/delete-property/ cdns,read-delay;
 };
 
+&flash1 {
+	bootph-all;
+};
+
 &i3c0 {
 	bootph-all;
 };
@@ -102,6 +106,10 @@
 	status = "okay";
 };
 
+&nand {
+	bootph-all;
+};
+
 &timer0 {
 	bootph-all;
 };
@@ -122,3 +130,23 @@
 	bootph-all;
 };
 
+&nand {
+	status = "okay";
+
+	flash1: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0 0x200000>;
+		};
+		partition@200000 {
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
+		};
+	};
+};
+
+
-- 
2.26.2

