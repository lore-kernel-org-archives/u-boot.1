Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C56C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 22:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14CB7407F9;
	Wed, 29 Jul 2026 22:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tDEGCAiU8Hoe; Wed, 29 Jul 2026 22:08:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34901407FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785362887;
	bh=+GsTX5/4OqXiDlj/7ztzI6LOadRziOoXdowzDZHMLdc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FrgkIfhJrzK+FTVpdbcbuV/6C68tS/q6GEmTn98Bfq+z/hBgvtmprPG/A0WaKlG9x
	 1wg2R2i5J0fv7eWbYzJxaMkADCx5+Sdmxmp6CB5Ew+UaG1o7c+Sxrxp0Z2Wrj2UXVZ
	 Vo9WELshDQ11Kafxc5IRz28T9idBSDVOOdKAEjKWbgIPiDhyG8HTQ/gL5YitT8KKNO
	 wlhoofM6Cyq7w4/E1AE5nStaCEt9Dn0tuB8hq43DdKDF4g13dE39p0pZ4JtV6yLfFQ
	 PAAFSWnYZHct+Hw4xWJELgPizWNN4LpSkQD096IxJzOZ0oFFzFQlGhPdOf6hH+P+Bs
	 IKlXY8CGk9iJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34901407FC;
	Wed, 29 Jul 2026 22:08:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E2BEF28E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4B11605E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bKrUooAkfPpP for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 22:08:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E521C605CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E521C605CA
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E521C605CA
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id DD968B0053D;
 Thu, 30 Jul 2026 00:07:53 +0200 (CEST)
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Wasim Khan <wasim.khan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] arm: dts: layerscape: drop leading zeros from unit addresses
Date: Thu, 30 Jul 2026 00:07:36 +0200
Message-ID: <20260729220736.226700-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=free.fr; s=smtp-20201208; t=1785362882;
 bh=Dpmsbu/uhcdQGSk25yyQQYmWSqgZ9QUI4g+EZuvTcZQ=;
 h=From:To:Cc:Subject:Date:From;
 b=oYVOt7vh+zVKz8qz8Wn5MP+i0XWUW9TFEk0GhZzZj6ffz0Ab+QkQnMbyMJfrhRSEM
 r3pzeeYtnlGDWI05eVcECOLgjLlBUnHnY2aE6WRAy3kNGZCW0ZTuC5Cr1JnK8G+tB0
 JLznvU9N2dcU0aajy0rnrqLA34y0gqstQC7sC8aHx5bF7r/yrO0qEimKiw2j3r/ztw
 BQNT/X2TF9LOVtLy29aZ87ht/EnnnJ4BPY6B6oVQ2wwRqeNFGPdQXax2tufaoshmd5
 aZmM74uAKqhGF6CdRL/smMT+7swm/NsAct20ZPiOBpr5hQ+k7uZE/j6qz1pfJbQQUC
 t3xbvUt99cufA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=free.fr
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=oYVOt7vh
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Fix many dtc warning for the Layerscape device trees with W=1.
Without this fix, it emits over 30 unit_address_format warnings.

No functional change.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 arch/arm/dts/fsl-ls1028a-qds-x5xx-sch-28021-LBRW.dtsi | 8 ++++----
 arch/arm/dts/fsl-ls1028a-qds.dtsi                     | 2 +-
 arch/arm/dts/fsl-ls1088a-qds.dtsi                     | 2 +-
 arch/arm/dts/fsl-lx2160a-qds.dtsi                     | 4 ++--
 arch/arm/dts/fsl-sch-28021.dtsi                       | 8 ++++----
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/fsl-ls1028a-qds-x5xx-sch-28021-LBRW.dtsi b/arch/arm/dts/fsl-ls1028a-qds-x5xx-sch-28021-LBRW.dtsi
index b6522069207..529adfcbaf4 100644
--- a/arch/arm/dts/fsl-ls1028a-qds-x5xx-sch-28021-LBRW.dtsi
+++ b/arch/arm/dts/fsl-ls1028a-qds-x5xx-sch-28021-LBRW.dtsi
@@ -25,28 +25,28 @@
 	status = "okay";
 	managed = "in-band-status";
 	phy-mode = "qsgmii";
-	phy-handle = <&{/soc/i2c@2000000/fpga@66/mux-mdio@54/mdio@50/phy@08}>;
+	phy-handle = <&{/soc/i2c@2000000/fpga@66/mux-mdio@54/mdio@50/phy@8}>;
 };
 
 &mscc_felix_port1 {
 	status = "okay";
 	managed = "in-band-status";
 	phy-mode = "qsgmii";
-	phy-handle = <&{/soc/i2c@2000000/fpga@66/mux-mdio@54/mdio@50/phy@09}>;
+	phy-handle = <&{/soc/i2c@2000000/fpga@66/mux-mdio@54/mdio@50/phy@9}>;
 };
 
 &mscc_felix_port2 {
 	status = "okay";
 	managed = "in-band-status";
 	phy-mode = "qsgmii";
-	phy-handle = <&{/soc/i2c@2000000/fpga@66/mux-mdio@54/mdio@50/phy@0a}>;
+	phy-handle = <&{/soc/i2c@2000000/fpga@66/mux-mdio@54/mdio@50/phy@a}>;
 };
 
 &mscc_felix_port3 {
 	status = "okay";
 	managed = "in-band-status";
 	phy-mode = "qsgmii";
-	phy-handle = <&{/soc/i2c@2000000/fpga@66/mux-mdio@54/mdio@50/phy@0b}>;
+	phy-handle = <&{/soc/i2c@2000000/fpga@66/mux-mdio@54/mdio@50/phy@b}>;
 };
 
 &mscc_felix_port4 {
diff --git a/arch/arm/dts/fsl-ls1028a-qds.dtsi b/arch/arm/dts/fsl-ls1028a-qds.dtsi
index ac5b2d9dde9..92757260560 100644
--- a/arch/arm/dts/fsl-ls1028a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1028a-qds.dtsi
@@ -147,7 +147,7 @@
 			mdio-parent-bus = <&enetc_mdio_pf3>;
 
 			/* on-board MDIO with a single RGMII PHY */
-			mdio@00 {
+			mdio@0 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x00>;
diff --git a/arch/arm/dts/fsl-ls1088a-qds.dtsi b/arch/arm/dts/fsl-ls1088a-qds.dtsi
index 83635a2e40d..5bdc8675aa2 100644
--- a/arch/arm/dts/fsl-ls1088a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1088a-qds.dtsi
@@ -41,7 +41,7 @@
 			mux-reg-masks = <0x54 0xe0>; // reg 0x54, bits 7:5
 			mdio-parent-bus = <&emdio1>;
 
-			mdio@00 {
+			mdio@0 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x00>;
diff --git a/arch/arm/dts/fsl-lx2160a-qds.dtsi b/arch/arm/dts/fsl-lx2160a-qds.dtsi
index 6fa36de0622..c213088bdf0 100644
--- a/arch/arm/dts/fsl-lx2160a-qds.dtsi
+++ b/arch/arm/dts/fsl-lx2160a-qds.dtsi
@@ -161,7 +161,7 @@
 			mux-reg-masks = <0x54 0xf8>; // reg 0x54, bits 7:3
 			mdio-parent-bus = <&emdio1>;
 
-			mdio@00 {
+			mdio@0 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x00>;
@@ -170,7 +170,7 @@
 					reg = <0x1>;
 				};
 			};
-			mdio@08 {
+			mdio@8 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x40>;
diff --git a/arch/arm/dts/fsl-sch-28021.dtsi b/arch/arm/dts/fsl-sch-28021.dtsi
index 61245287b96..d819308ed8c 100644
--- a/arch/arm/dts/fsl-sch-28021.dtsi
+++ b/arch/arm/dts/fsl-sch-28021.dtsi
@@ -12,18 +12,18 @@
  * PHY addresses are 0x08 - 0x0b.
  * On the card the first port is the top port (farthest from PEX connector).
  */
-phy@08 {
+phy@8 {
 	reg = <0x08>;
 };
 
-phy@09 {
+phy@9 {
 	reg = <0x09>;
 };
 
-phy@0a {
+phy@a {
 	reg = <0x0a>;
 };
 
-phy@0b {
+phy@b {
 	reg = <0x0b>;
 };
---
base-commit: 616c3d79f01cf9204e38738857c4647a730dcb3b
branch: for-upstream/dts-layerscape-warnings-v1

-- 
2.43.0

