Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07703CCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 10:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD97A835FE;
	Wed, 22 Oct 2025 12:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Tgdr9QhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271DB832BC; Wed, 22 Oct 2025 12:26:18 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9727D83303
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 12:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59MAQDDr1392516;
 Wed, 22 Oct 2025 05:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761128773;
 bh=WnEWg2+FhhVUUESqQknku2ttF4vRI6lv8DBAiWNjZ84=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=Tgdr9QhNKSC0FU5d92aJju2YjHlwlu9vqlQ26VF4ZyuGuUiHE9CxcU0htF7wiGhh0
 yQC+58D0rH88O3EqDlWTaHPfDgfTKFxmcVytV2VJZ0A5iNfO7ZqixHrGeEbxMTvohW
 081wK3ien8/0jBjNUOGKjl1/a89Bm24vR1RY50sM=
Received: from DFLE203.ent.ti.com (dfle203.ent.ti.com [10.64.6.61])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59MAQDpd1948651
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Oct 2025 05:26:13 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:26:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 05:26:13 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59MAQCj91063187;
 Wed, 22 Oct 2025 05:26:12 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 22 Oct 2025 15:55:37 +0530
Subject: [PATCH 1/8] arm64: dts: ti: k3-am6*-boards: Add label to
 reserved-memory node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251022-62sip_support-v1-1-eed08d15e76d@ti.com>
References: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
In-Reply-To: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761128770; l=7930;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=WbMJ4qMgRk7kaR9Ye/2Ck+wyifzRoWaNdsPG9/sBVIo=;
 b=NSy8KB1LLXTFl/Gtt7nubJVC6VtFwmb1Pq2SRykSI4TAu5vBi0MemsfSmwv+U+A15dA3JLFUq
 3mI+E8Btfy6AGLNhZEXX0SibIx1zFFaT2a5+fMuZAxWosXRCNWs2ftk
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
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

From: Beleswar Padhi <b-padhi@ti.com>

Add the label name 'reserved_memory' to the reserved-memory node in all
K3 AM6* board level dts files. This is done so that the node can be
referenced and extended to add more carveout entries as needed in future
refactoring patches.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://patch.msgid.link/20250908142826.1828676-13-b-padhi@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 4f1aee4723a796a92f17b23699dc861b582ddfd2 ]

(cherry picked from commit 58c447fe500d78f5adc373b4945d8317e11df072)
---
 dts/upstream/src/arm64/ti/k3-am62-verdin.dtsi         | 2 +-
 dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi   | 2 +-
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts            | 2 +-
 dts/upstream/src/arm64/ti/k3-am62d2-evm.dts           | 2 +-
 dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi        | 2 +-
 dts/upstream/src/arm64/ti/k3-am62p5-sk.dts            | 2 +-
 dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi     | 2 +-
 dts/upstream/src/arm64/ti/k3-am642-evm.dts            | 2 +-
 dts/upstream/src/arm64/ti/k3-am642-sk.dts             | 2 +-
 dts/upstream/src/arm64/ti/k3-am642-sr-som.dtsi        | 2 +-
 dts/upstream/src/arm64/ti/k3-am642-tqma64xxl.dtsi     | 2 +-
 dts/upstream/src/arm64/ti/k3-am65-iot2050-common.dtsi | 2 +-
 dts/upstream/src/arm64/ti/k3-am654-base-board.dts     | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62-verdin.dtsi b/dts/upstream/src/arm64/ti/k3-am62-verdin.dtsi
index bc2289d74774575648ca74403b7164e03e6d146f..4e9a8921c95dfc2f3481299a032e542d19839a81 100644
--- a/dts/upstream/src/arm64/ti/k3-am62-verdin.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62-verdin.dtsi
@@ -189,7 +189,7 @@
 		regulator-name = "USB_1_EN";
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
index 5dc5d2cb20ccdd85d82a5067959f5ea83efcd96e..ebdbd782e9f103c839f0e24236c526301dcffaae 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
@@ -45,7 +45,7 @@
 		bootph-all;
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
index bceead5e288e6d78c671baf0afabd1a9aa23fbee..3f4c6fe2999b1fe48dcd0f8b7ca8ec5e353d32f8 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
@@ -39,7 +39,7 @@
 		bootph-all;
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts b/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
index daea18b0bc61c67fc1a1c8f4f47b4fd40b0235e1..dbee37f38b7b359f9e3722c07429baa2833addfd 100644
--- a/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
@@ -39,7 +39,7 @@
 		bootph-all;
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi b/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
index a2fdc6741da2cd8846ab8d7dd4bd44a15dc372e8..6a04b370d149ffa26747bdb6e657f1b890004fad 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62p-verdin.dtsi
@@ -147,7 +147,7 @@
 		regulator-name = "+V_SODIMM";
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
index 899da7896563b43021de14eda1b0058a5c6d36da..1234ebba811060f4a494c1d4b6f5e1eedfecd826 100644
--- a/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62p5-sk.dts
@@ -44,7 +44,7 @@
 		bootph-pre-ram;
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
index 13e1d36123d51f2ca8ec40ce61e4a53b5e7ba832..43ee16f171fdfdb07e7a4bd1719bd8b62d81654b 100644
--- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
@@ -36,7 +36,7 @@
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am642-evm.dts b/dts/upstream/src/arm64/ti/k3-am642-evm.dts
index e01866372293babcbe6687f32a094e9daaa815ec..b9f472ed1d8e390e84e000aa0492c7086d78d8d0 100644
--- a/dts/upstream/src/arm64/ti/k3-am642-evm.dts
+++ b/dts/upstream/src/arm64/ti/k3-am642-evm.dts
@@ -42,7 +42,7 @@
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am642-sk.dts b/dts/upstream/src/arm64/ti/k3-am642-sk.dts
index 1deaa0be0085c4e64136d3e8f68fdcd62ca7e068..37a5ab0b6b688e3eff8e004a90b379a3befe47cd 100644
--- a/dts/upstream/src/arm64/ti/k3-am642-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am642-sk.dts
@@ -40,7 +40,7 @@
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am642-sr-som.dtsi b/dts/upstream/src/arm64/ti/k3-am642-sr-som.dtsi
index a5cec9a075109aeec335e3f4d22a9fd60a3cd813..ad41479eba73d1c5c6e6ccadbaaf2f5237adf239 100644
--- a/dts/upstream/src/arm64/ti/k3-am642-sr-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am642-sr-som.dtsi
@@ -105,7 +105,7 @@
 		device_type = "memory";
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am642-tqma64xxl.dtsi b/dts/upstream/src/arm64/ti/k3-am642-tqma64xxl.dtsi
index 828d815d6bdfc24d96c9e36f16643ed8bb59abfb..df05a124804c368b4aae7f59cb1e01a207444bed 100644
--- a/dts/upstream/src/arm64/ti/k3-am642-tqma64xxl.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am642-tqma64xxl.dtsi
@@ -20,7 +20,7 @@
 
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am65-iot2050-common.dtsi b/dts/upstream/src/arm64/ti/k3-am65-iot2050-common.dtsi
index e5136ed947651736c5302f914939a4e57102b971..b86ee00d48f76110cf501bb3f2afee3e030d2b64 100644
--- a/dts/upstream/src/arm64/ti/k3-am65-iot2050-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am65-iot2050-common.dtsi
@@ -36,7 +36,7 @@
 		stdout-path = "serial3:115200n8";
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
diff --git a/dts/upstream/src/arm64/ti/k3-am654-base-board.dts b/dts/upstream/src/arm64/ti/k3-am654-base-board.dts
index e589690c7c8213d5e4989942735fa53825e610f5..d48171212ac93b6bd3f19609f4fe629b839440ab 100644
--- a/dts/upstream/src/arm64/ti/k3-am654-base-board.dts
+++ b/dts/upstream/src/arm64/ti/k3-am654-base-board.dts
@@ -39,7 +39,7 @@
 		      <0x00000008 0x80000000 0x00000000 0x80000000>;
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;

-- 
2.51.0

