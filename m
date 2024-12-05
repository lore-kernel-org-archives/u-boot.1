Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303FEE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACD88940F;
	Thu,  5 Dec 2024 10:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hGK/W0Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D2D589282; Thu,  5 Dec 2024 10:23:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EBD892DC
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390625; x=1764926625;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BO9/Mh0ASn0L6YT1ewCle7qPZLsxmYMP2A++fsMTvAI=;
 b=hGK/W0Nh5rLcfZ9NxzPeaDKYG/3qSIYpNcLe4+BEAK5MnfMBzE60QZBA
 lxerhCV+Nxw09E8E8dvS+3gHpaxqB2ra3zh37+xSXbLXElitbIAwU1Caf
 LanmQJhYKzOpiKtdJd22nOf6nBe859sSAu1fiuKOe5LNF6lU2hWcychia
 Rn2u+pedkji274dciPTIteagzEwZ5PvzOo/zKZGH68RId9hAcqWibQjgU
 T9jWkpXK+xU1bOvBRL22z1c5oo2ZK9bThWZ+Zz9wW8rsUtToxcu2Xz4Ip
 pBXtunhEurDb9k89rcv1TMIUKDyzRdIOulqt+bup4aUjLx/UElKT4/TSJ w==;
X-CSE-ConnectionGUID: a1WlEZWvQ3GKh/M6JLwxVw==
X-CSE-MsgGUID: z1zc57wFRcSspuaIw2ZtDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610134"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610134"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:23:41 -0800
X-CSE-ConnectionGUID: zzFC4NT1RJquh7z5MsF29w==
X-CSE-MsgGUID: 3ca7JIOZQiCXjUv8HZC60w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121800"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:23:37 -0800
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
Subject: [resend v2 02/19] arm: dts: agilex5: Enabled cdns-nand dts setting
Date: Thu,  5 Dec 2024 17:22:58 +0800
Message-Id: <20241205092315.25060-3-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20241205092315.25060-1-dinesh.maniyam@intel.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
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
v2:
- remove the "this patch is to" commit phrases
---
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
2.19.0

