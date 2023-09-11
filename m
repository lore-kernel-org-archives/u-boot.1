Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645FDEE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6E0864DD;
	Mon, 11 Sep 2023 16:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Qdenb/OG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E61D86E3D; Mon, 11 Sep 2023 16:44:15 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F4234864DD
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BEi41E052589;
 Mon, 11 Sep 2023 09:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694443444;
 bh=5GoAD+S0LXDJancxPOolGerNupDGgYkj9hZpdg+owGM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Qdenb/OGwtn3AhZqGCKpvuOZz3bBDxK6wa3KUeUwMxPWHU8vwxiT62LNMHM49m9PX
 4BGnEIEby3D2VHmrLcwnZsj1ZlwmJBa37CZk/A1bvIZUUotmECKjO58gmaeHevNSDJ
 Oqd8SHh50b/w/tG5KxULZ8VQtWQQMcOQKFCCIEZM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BEi4mH008255
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 09:44:04 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:44:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:44:04 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BEi4E1034709;
 Mon, 11 Sep 2023 09:44:04 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>
Subject: [PATCH 2/4] arm: dts: k3*: Use local header for SERDES MUX idle-state
 values
Date: Mon, 11 Sep 2023 09:43:59 -0500
Message-ID: <20230911144401.1011354-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230911144401.1011354-1-nm@ti.com>
References: <20230911144401.1011354-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The DTS uses constants for SERDES MUX idle state values which were earlier
provided as bindings header. But they are unsuitable for bindings.
So move these constants in a header next to DTS.

NOTE: sync with v6.6-rc1 will bring in this change naturally.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-am642-evm.dts               | 2 +-
 arch/arm/dts/k3-am642-sk.dts                | 2 +-
 arch/arm/dts/k3-j7200-common-proc-board.dts | 2 +-
 arch/arm/dts/k3-j721e-main.dtsi             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-am642-evm.dts b/arch/arm/dts/k3-am642-evm.dts
index 15c282c93467..fe2ea25b396f 100644
--- a/arch/arm/dts/k3-am642-evm.dts
+++ b/arch/arm/dts/k3-am642-evm.dts
@@ -6,11 +6,11 @@
 /dts-v1/;
 
 #include <dt-bindings/phy/phy.h>
-#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include "k3-am642.dtsi"
+#include "k3-serdes.h"
 
 / {
 	compatible = "ti,am642-evm", "ti,am642";
diff --git a/arch/arm/dts/k3-am642-sk.dts b/arch/arm/dts/k3-am642-sk.dts
index cbce43dbe3f9..ece75680f3f4 100644
--- a/arch/arm/dts/k3-am642-sk.dts
+++ b/arch/arm/dts/k3-am642-sk.dts
@@ -5,12 +5,12 @@
 
 /dts-v1/;
 
-#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include <dt-bindings/leds/common.h>
 #include "k3-am642.dtsi"
+#include "k3-serdes.h"
 
 / {
 	compatible = "ti,am642-sk", "ti,am642";
diff --git a/arch/arm/dts/k3-j7200-common-proc-board.dts b/arch/arm/dts/k3-j7200-common-proc-board.dts
index d14f3c18b65f..ef5e807a80b4 100644
--- a/arch/arm/dts/k3-j7200-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-common-proc-board.dts
@@ -8,8 +8,8 @@
 #include "k3-j7200-som-p0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
-#include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
+#include "k3-serdes.h"
 
 / {
 	chosen {
diff --git a/arch/arm/dts/k3-j721e-main.dtsi b/arch/arm/dts/k3-j721e-main.dtsi
index cf3482376c1e..d2edf5df2eb9 100644
--- a/arch/arm/dts/k3-j721e-main.dtsi
+++ b/arch/arm/dts/k3-j721e-main.dtsi
@@ -6,7 +6,7 @@
  */
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/mux/mux.h>
-#include <dt-bindings/mux/ti-serdes.h>
+#include "k3-serdes.h"
 
 / {
 	cmn_refclk: clock-cmnrefclk {
-- 
2.40.0

