Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BFFD3C93D
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 04:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B87F89202;
	Mon, 21 Oct 2024 06:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lVYJqiX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622F18923A; Mon, 21 Oct 2024 06:41:35 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DDC3892E5
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 06:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49L4fUH8011065;
 Sun, 20 Oct 2024 23:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729485690;
 bh=g1bijHJ1LZ4jS5KdM49rCPcqQmqeBsfAJJUyHI+qI84=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lVYJqiX/ufqVsuGk8K58exCjbTZqzuXofEMlmny9UZMAVmPAgm43fTKchpas2cOmP
 kTVGe8/EopeP5kfPmimKTSelo3QuxGGzFmQ/xv9A4DkjyoH8gvgsiWOBKTl4+YLMXS
 g3+ZIUkekQRM24llLmyfFXFsfb7s75jXbO2uvP0Q=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49L4fUck005592
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 20 Oct 2024 23:41:30 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 20
 Oct 2024 23:41:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 20 Oct 2024 23:41:29 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49L4f2u1059251;
 Sun, 20 Oct 2024 23:41:27 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v4 8/8] arm: dts: k3-*-ddr: Add ss_cfg reg entry
Date: Mon, 21 Oct 2024 10:10:24 +0530
Message-ID: <20241021044024.835846-9-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021044024.835846-1-s-k6@ti.com>
References: <20241021044024.835846-1-s-k6@ti.com>
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

