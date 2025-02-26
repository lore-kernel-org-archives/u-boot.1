Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D43C18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE4180FE2;
	Wed, 26 Feb 2025 17:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eddr+8cB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 851BD8004F; Wed, 26 Feb 2025 17:19:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB545810EA
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586739; x=1772122739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rgffRjKANW+MVCU5HmQ0fwOW6BNfDLyZ9PVKsZnxx9A=;
 b=eddr+8cBEeF4lW8brViat8/mCw6CEEpTNhn1VyjpSiZRaxKu69eT92/4
 ozvo3cko4nCX33ajYWD75RvKGzUx/v4U5r05fm7CQzB5DoZRa603ncEB5
 JPu1ilszfPSw2IVgHtUWETRDTNPkWzH6Kxva3HJGsNiA2lwLMAo0tSNEq
 lJgTvG85TLPYnjDHGZli5waC7RQsTEjLH8u2irmN30YI6lDE0nyIw9SLn
 /qAoXy04lL99T7HkWhEOimnUrDI1rXyMkmTJGe69WDSMSda2ZTUezkMOb
 Zj5JuZK6wfrHR5+1HeAgQqhP9S/eTUzeukzH3XIzPF/Q7OqcEV5vBgaeQ A==;
X-CSE-ConnectionGUID: R6WrGFAWQam/9fMRgerGsQ==
X-CSE-MsgGUID: 3+7SB90CR62HBo9ZOdy8OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41639919"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41639919"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:18:59 -0800
X-CSE-ConnectionGUID: 78oM9Mu7QW+gwCnKB6rrDg==
X-CSE-MsgGUID: wJJy9VtSRguacmyK1KbFZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602571"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:18:54 -0800
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
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [resend v3 02/19] arm: dts: agilex5: Enabled cdns-nand dts setting
Date: Thu, 27 Feb 2025 00:18:16 +0800
Message-Id: <20250226161833.53689-3-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20250226161833.53689-1-dinesh.maniyam@intel.com>
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
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

Enable cdns-nand dts setting for the socfpga_agilex5
family device.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v3 > v2:
- Moved &nand from uboot.dtsi to socdk.dts
---
---
 arch/arm/dts/socfpga_agilex5.dtsi             | 14 ++++++++++++++
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  9 ++++++++-
 arch/arm/dts/socfpga_agilex5_socdk.dts        | 19 +++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

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
index 9eb21d6542..23e0354cba 100644
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
@@ -121,4 +129,3 @@
 &watchdog0 {
 	bootph-all;
 };
-
diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_agilex5_socdk.dts
index 852e1e5ae3..976656a35a 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -161,3 +161,22 @@
 		};
 	};
 };
+
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
-- 
2.19.0

