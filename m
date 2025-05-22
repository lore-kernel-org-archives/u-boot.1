Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1914C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 07:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC8D83046;
	Thu, 22 May 2025 09:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ewZt7tXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D9F482E31; Thu, 22 May 2025 09:18:57 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E3CB83046
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54M7IqJI1746478;
 Thu, 22 May 2025 02:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747898332;
 bh=HLocn6wsgYf1ASS7AeAGrGKyc7+0yTpD8qr4Xp0vLKU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ewZt7tXRThIiL1lSLPz6ddHibRdBAYiBQkhJiZNjsqfJtf+0wv3uiiG8jAHMC6zq1
 RP64TPS+AqiJoOhjld1PsCq5LWKFoEgj1B6+FrsCn0BN1ObGDJC6024BM80eeOXyyN
 4QlX2hCT6n50R3ZkECxCJJQvrQIjGYY3sp7mivXU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54M7IqPQ3311774
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 22 May 2025 02:18:52 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 May 2025 02:18:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 May 2025 02:18:51 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54M7IT9O467991;
 Thu, 22 May 2025 02:18:49 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 6/6] DONOTMERGE: arm: dts: k3-j7*-mcu-wakeup: Enable split
 mode for MCU R5
Date: Thu, 22 May 2025 12:48:28 +0530
Message-ID: <20250522071828.285462-7-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522071828.285462-1-b-padhi@ti.com>
References: <20250522071828.285462-1-b-padhi@ti.com>
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

Previously, MCU R5F runs in lockstep mode. Enable split-mode on MCU R5F
as the support to shut down core1 and use it for loading other firmware,
while DM runs on core0, has been added.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi              | 2 +-
 dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi              | 2 +-
 dts/upstream/src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi             | 2 +-
 .../src/arm64/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi b/dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi
index 56ab144fea0..d8826be4685 100644
--- a/dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi
@@ -606,7 +606,7 @@
 
 	mcu_r5fss0: r5fss@41000000 {
 		compatible = "ti,j7200-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x41000000 0x00 0x41000000 0x20000>,
diff --git a/dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi b/dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi
index b02142b2b46..9a84ef7ca14 100644
--- a/dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi
@@ -588,7 +588,7 @@
 
 	mcu_r5fss0: r5fss@41000000 {
 		compatible = "ti,j721e-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x41000000 0x00 0x41000000 0x20000>,
diff --git a/dts/upstream/src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi b/dts/upstream/src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi
index bc31266126d..4ba26876aa0 100644
--- a/dts/upstream/src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -684,7 +684,7 @@
 
 	mcu_r5fss0: r5fss@41000000 {
 		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x41000000 0x00 0x41000000 0x20000>,
diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi b/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
index 52e2965a3bf..e51b004c03a 100644
--- a/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
@@ -589,7 +589,7 @@
 
 	mcu_r5fss0: r5fss@41000000 {
 		compatible = "ti,j721s2-r5fss";
-		ti,cluster-mode = <1>;
+		ti,cluster-mode = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x41000000 0x00 0x41000000 0x20000>,
-- 
2.34.1

