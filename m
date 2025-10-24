Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32BECCD1AB
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 08:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 988918363D;
	Fri, 24 Oct 2025 10:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oKLfRqiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E6383655; Fri, 24 Oct 2025 10:33:31 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C208331F
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59O8XRVo1867839;
 Fri, 24 Oct 2025 03:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761294807;
 bh=6OKKb+jYxkwrIsUYHJxsmbMld+5kS/1VU99cIoFjd9E=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=oKLfRqiIBu+dgXUP7nr7RdsIgN4Nfuv/Lo8DpIXJGeCMytE541XTl0K6Aq12HXN/s
 Bk+/KlFRe0IoZebOLk8CYtK0d6SsjmbyEh25kceEgudYFKIkdT+sWsj9yXPaiFvG+w
 gQhsmdyiXpySubBNoH/tP0whVzmmKhUhXbmQjnP4=
Received: from DFLE202.ent.ti.com (dfle202.ent.ti.com [10.64.6.60])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59O8XRYg3040464
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Oct 2025 03:33:27 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 03:33:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 03:33:26 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59O8XPgQ066123;
 Fri, 24 Oct 2025 03:33:26 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Fri, 24 Oct 2025 14:02:56 +0530
Subject: [PATCH v2 2/8] arm64: dts: ti: k3-am62*: remove SoC dtsi from
 common dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251024-62sip_support-v2-2-23d4948af70c@ti.com>
References: <20251024-62sip_support-v2-0-23d4948af70c@ti.com>
In-Reply-To: <20251024-62sip_support-v2-0-23d4948af70c@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761294801; l=3622;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=1QG+PqhdQgv2V2I3hxHlXPIhYi/7hRwfA+700Uj0iHw=;
 b=ihrEt4/yKJpK9Qf8BOEcg9wlrd/Ybxpu2qEC8k1XWeW7svQEZWDZWrMZWLCE9tApLzinY76XU
 CEElBkzdP0vBpyK6ZH70QJ/WxfMvUtB74udKc2/P2RMXbFmOV94MzO3
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

The k3-am62x-sk-common dtsi represents the common hardware used across
am62x EVMs which can be configured with various DDR sizes or none (with
DDR integrated in the package) based on the specific am62x SoC used.

Therefore this patch moves the memory node and the SoC specific k3-am625
dtsi out of sk-common and into the board dts files. No functional change
is intended from this patch. The device-tree inheritance is changed as
follows:

Before:

               k3-am62
                 ^
               k3-am625
                 ^
         k3-am62x-sk-common
                 ^
  am62x EVMs (k3-am625-sk, k3-am62-lp-sk)

After:

        k3-am62
          ^
        k3-am625    k3-am62x-sk-common
          ^              ^
  am62x EVMs (k3-am625-sk, k3-am62-lp-sk)

Signed-off-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
Link: https://patch.msgid.link/20250814134531.2743874-2-anshuld@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: e0b9feca7329c495a76891d7766a781dea73787d ]

(cherry picked from commit 0b0edbbdf43bac6b28dd59c88647bd5e0b73ffea)
---
 dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts       | 8 ++++++++
 dts/upstream/src/arm64/ti/k3-am625-sk.dts         | 5 +++--
 dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi | 8 --------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts b/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts
index 4609f366006e4cdf0c162f72634ce90623f60a90..ecfba05fe5c273c671cd0968f3eceaf54d22ac7d 100644
--- a/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62-lp-sk.dts
@@ -7,12 +7,20 @@
 
 /dts-v1/;
 
+#include "k3-am625.dtsi"
 #include "k3-am62x-sk-common.dtsi"
 
 / {
 	compatible = "ti,am62-lp-sk", "ti,am625";
 	model = "Texas Instruments AM62x LP SK";
 
+	memory@80000000 {
+		/* 2G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+		device_type = "memory";
+		bootph-pre-ram;
+	};
+
 	vmain_pd: regulator-0 {
 		/* TPS65988 PD CONTROLLER OUTPUT */
 		compatible = "regulator-fixed";
diff --git a/dts/upstream/src/arm64/ti/k3-am625-sk.dts b/dts/upstream/src/arm64/ti/k3-am625-sk.dts
index d240165bda9c57b01772feb57f14f209bbcc5668..1c6812a8ae9b5d8f274f5a3fa88738eafbc747a7 100644
--- a/dts/upstream/src/arm64/ti/k3-am625-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am625-sk.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 
+#include "k3-am625.dtsi"
 #include "k3-am62x-sk-common.dtsi"
 
 / {
@@ -23,10 +24,10 @@
 	};
 
 	memory@80000000 {
-		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-
+		device_type = "memory";
+		bootph-pre-ram;
 	};
 
 	vmain_pd: regulator-0 {
diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
index 43ee16f171fdfdb07e7a4bd1719bd8b62d81654b..ce8be23b068ea97901b50fbf1b3241ebd54c9f34 100644
--- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
@@ -8,7 +8,6 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
-#include "k3-am625.dtsi"
 
 / {
 	aliases {
@@ -29,13 +28,6 @@
 		stdout-path = "serial2:115200n8";
 	};
 
-	memory@80000000 {
-		bootph-pre-ram;
-		device_type = "memory";
-		/* 2G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-	};
-
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;

-- 
2.51.0

