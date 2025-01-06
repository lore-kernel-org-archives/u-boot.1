Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F54BE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C05C8058A;
	Mon,  6 Jan 2025 10:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l8QtJNle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7548D805DF; Mon,  6 Jan 2025 10:07:31 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 058718058A
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50697Rog2464502
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jan 2025 03:07:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736154447;
 bh=g1bijHJ1LZ4jS5KdM49rCPcqQmqeBsfAJJUyHI+qI84=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=l8QtJNleW+J+GoBxdB6o/woKvSpSuNGctmo9q3knQC+GGMDqQe2CGYEY0xexX3bF/
 GWG4pOHSlk4cktkToD+ZDxHRCRp7x6zhjtyQDWZcbwFDpFTxt8xpPMKQ4VFtbOItwH
 +4FyH2XJY3T0siCqGbhp5J8msYFYzhRu9FK+TFOM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50697RgY114167
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Jan 2025 03:07:27 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 03:07:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 03:07:26 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50697JuW103050;
 Mon, 6 Jan 2025 03:07:23 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v6 1/9] arm: dts: k3-*-ddr: Add ss_cfg reg entry
Date: Mon, 6 Jan 2025 14:37:00 +0530
Message-ID: <20250106090708.1541212-2-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106090708.1541212-1-s-k6@ti.com>
References: <20250106090708.1541212-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Add ss_cfg memory region which maps the DDRSS configuration region
for the memory controller node.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-am62a-ddr.dtsi  |  7 ++++---
 arch/arm/dts/k3-j721s2-ddr.dtsi | 12 ++++++++----
 arch/arm/dts/k3-j784s4-ddr.dtsi | 24 ++++++++++++++++--------
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/arch/arm/dts/k3-am62a-ddr.dtsi b/arch/arm/dts/k3-am62a-ddr.dtsi
index 8629ea45b847..42e41f78505a 100644
--- a/arch/arm/dts/k3-am62a-ddr.dtsi
+++ b/arch/arm/dts/k3-am62a-ddr.dtsi
@@ -4,11 +4,12 @@
  */
 
 / {
-	memorycontroller: memory-controller@f308000 {
+	memorycontroller: memory-controller@f300000 {
 		compatible = "ti,am62a-ddrss";
 		reg = <0x00 0x0f308000 0x00 0x4000>,
-		      <0x00 0x43014000 0x00 0x100>;
-		reg-names = "cfg", "ctrl_mmr_lp4";
+		      <0x00 0x43014000 0x00 0x100>,
+		      <0x00 0x0f300000 0x00 0x200>;
+		reg-names = "cfg", "ctrl_mmr_lp4", "ss_cfg";
 		ti,ddr-freq1 = <DDRSS_PLL_FREQUENCY_1>;
 		ti,ddr-freq2 = <DDRSS_PLL_FREQUENCY_2>;
 		ti,ddr-fhs-cnt = <DDRSS_PLL_FHS_CNT>;
diff --git a/arch/arm/dts/k3-j721s2-ddr.dtsi b/arch/arm/dts/k3-j721s2-ddr.dtsi
index 345e2b84f9e8..9764085163c4 100644
--- a/arch/arm/dts/k3-j721s2-ddr.dtsi
+++ b/arch/arm/dts/k3-j721s2-ddr.dtsi
@@ -5,6 +5,8 @@
 
 &main_navss {
 	ranges = <0x00 0x00114000 0x00 0x00114000 0x00 0x00000100>, // ctrl_mmr_lpr
+		 <0x00 0x02980000 0x00 0x02980000 0x00 0x00000200>, // ss cfg 0
+		 <0x00 0x029a0000 0x00 0x029a0000 0x00 0x00000200>, // ss cfg 1
 		 <0x00 0x02990000 0x00 0x02990000 0x00 0x00004000>, // ddr0 cfg
 		 <0x00 0x029b0000 0x00 0x029b0000 0x00 0x00004000>, // ddr1 cfg
 		 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
@@ -24,8 +26,9 @@
 		memorycontroller0: memorycontroller@2990000 {
 			compatible = "ti,j721s2-ddrss";
 			reg = <0x0 0x02990000 0x0 0x4000>,
-			      <0x0 0x0114000 0x0 0x100>;
-			reg-names = "cfg", "ctrl_mmr_lp4";
+			      <0x0 0x0114000 0x0 0x100>,
+			      <0x0 0x02980000 0x0 0x200>;
+			reg-names = "cfg", "ctrl_mmr_lp4", "ss_cfg";
 			power-domains = <&k3_pds 138 TI_SCI_PD_SHARED>,
 				<&k3_pds 96 TI_SCI_PD_SHARED>;
 			clocks = <&k3_clks 138 0>, <&k3_clks 43 2>;
@@ -2232,8 +2235,9 @@
 		memorycontroller1: memorycontroller@29b0000 {
 			compatible = "ti,j721s2-ddrss";
 			reg = <0x0 0x029b0000 0x0 0x4000>,
-			      <0x0 0x0114000 0x0 0x100>;
-			reg-names = "cfg", "ctrl_mmr_lp4";
+			      <0x0 0x0114000 0x0 0x100>,
+			      <0x0 0x029a0000 0x0 0x200>;
+			reg-names = "cfg", "ctrl_mmr_lp4", "ss_cfg";
 			power-domains = <&k3_pds 139 TI_SCI_PD_SHARED>,
 				<&k3_pds 97 TI_SCI_PD_SHARED>;
 			clocks = <&k3_clks 139 0>, <&k3_clks 43 2>;
diff --git a/arch/arm/dts/k3-j784s4-ddr.dtsi b/arch/arm/dts/k3-j784s4-ddr.dtsi
index 1c3242b0870c..fc74c539331e 100644
--- a/arch/arm/dts/k3-j784s4-ddr.dtsi
+++ b/arch/arm/dts/k3-j784s4-ddr.dtsi
@@ -9,6 +9,10 @@
 		 <0x00 0x029b0000 0x00 0x029b0000 0x00 0x00004000>, // ddr1 cfg
 		 <0x00 0x029d0000 0x00 0x029d0000 0x00 0x00004000>, // ddr2 cfg
 		 <0x00 0x029f0000 0x00 0x029f0000 0x00 0x00004000>, // ddr3 cfg
+		 <0x00 0x02980000 0x00 0x02980000 0x00 0x00000200>, // ss cfg 0
+		 <0x00 0x029a0000 0x00 0x029a0000 0x00 0x00000200>, // ss cfg 1
+		 <0x00 0x029c0000 0x00 0x029c0000 0x00 0x00000200>, // ss cfg 2
+		 <0x00 0x029e0000 0x00 0x029e0000 0x00 0x00000200>, // ss cfg 3
 		 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
 
 	msmc0: msmc {
@@ -26,8 +30,9 @@
 		memorycontroller0: memorycontroller@2990000 {
 			compatible = "ti,j721s2-ddrss";
 			reg = <0x0 0x02990000 0x0 0x4000>,
-			      <0x0 0x0114000 0x0 0x100>;
-			reg-names = "cfg", "ctrl_mmr_lp4";
+			      <0x0 0x0114000 0x0 0x100>,
+			      <0x0 0x02980000 0x0 0x200>;
+			reg-names = "cfg", "ctrl_mmr_lp4", "ss_cfg";
 			power-domains = <&k3_pds 191 TI_SCI_PD_SHARED>,
 				<&k3_pds 131 TI_SCI_PD_SHARED>;
 			clocks = <&k3_clks 191 1>, <&k3_clks 78 2>;
@@ -2234,8 +2239,9 @@
 		memorycontroller1: memorycontroller@29b0000 {
 			compatible = "ti,j721s2-ddrss";
 			reg = <0x0 0x029b0000 0x0 0x4000>,
-			      <0x0 0x0114000 0x0 0x100>;
-			reg-names = "cfg", "ctrl_mmr_lp4";
+			      <0x0 0x0114000 0x0 0x100>,
+			      <0x0 0x029a0000 0x0 0x200>;
+			reg-names = "cfg", "ctrl_mmr_lp4", "ss_cfg";
 			power-domains = <&k3_pds 192 TI_SCI_PD_SHARED>,
 				<&k3_pds 132 TI_SCI_PD_SHARED>;
 			clocks = <&k3_clks 192 1>, <&k3_clks 78 2>;
@@ -4442,8 +4448,9 @@
 		memorycontroller2: memorycontroller@29d0000 {
 			compatible = "ti,j721s2-ddrss";
 			reg = <0x0 0x029d0000 0x0 0x4000>,
-			      <0x0 0x0114000 0x0 0x100>;
-			reg-names = "cfg", "ctrl_mmr_lp4";
+			      <0x0 0x0114000 0x0 0x100>,
+			      <0x0 0x029c0000 0x0 0x200>;
+			reg-names = "cfg", "ctrl_mmr_lp4", "ss_cfg";
 			power-domains = <&k3_pds 193 TI_SCI_PD_SHARED>,
 				<&k3_pds 133 TI_SCI_PD_SHARED>;
 			clocks = <&k3_clks 193 1>, <&k3_clks 78 2>;
@@ -6650,8 +6657,9 @@
 		memorycontroller3: memorycontroller@29f0000 {
 			compatible = "ti,j721s2-ddrss";
 			reg = <0x0 0x029f0000 0x0 0x4000>,
-			      <0x0 0x0114000 0x0 0x100>;
-			reg-names = "cfg", "ctrl_mmr_lp4";
+			      <0x0 0x0114000 0x0 0x100>,
+			      <0x0 0x29e0000 0x0 0x200>;
+			reg-names = "cfg", "ctrl_mmr_lp4", "ss_cfg";
 			power-domains = <&k3_pds 194 TI_SCI_PD_SHARED>,
 				<&k3_pds 139 TI_SCI_PD_SHARED>;
 			clocks = <&k3_clks 194 1>, <&k3_clks 78 2>;
-- 
2.34.1

