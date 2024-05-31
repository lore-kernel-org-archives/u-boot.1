Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AB0C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 22:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8671288838;
	Sat,  1 Jun 2024 00:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WiZby+pX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A96EF8812C; Sat,  1 Jun 2024 00:51:27 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 399D488816
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 00:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VMpDIo120635;
 Fri, 31 May 2024 17:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717195873;
 bh=3/jXT14wzidhJns5RK3ZMEHiT2/5tu3H2nLzDdurL7w=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=WiZby+pXxQ2ueuelnWf4ah695PGgtTAhPC/1kTFWrCxd5jbMkUOCih18PXRjpA2lA
 8MxxxL3n+BUSIXZQxjIXyxWWwPNXZy2VEBnvDZvULb/JqJ/yI4s/95tLMdvwKp8ozp
 tuccd5LeC5WJNXZostO+djX/fgL9wdAUxgRa/ivc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VMpDAR021624
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 17:51:13 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 17:51:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 17:51:13 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VMpD61046303;
 Fri, 31 May 2024 17:51:13 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v3 6/9] dts: am62px: binman: Include firmware capsules binman
 nodes
Date: Fri, 31 May 2024 17:51:07 -0500
Message-ID: <20240531225110.2622239-7-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531225110.2622239-1-j-humphreys@ti.com>
References: <20240531225110.2622239-1-j-humphreys@ti.com>
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

Fill in the am62px SK's capsule GUID properties of the base binman capsule
nodes.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index dea14945bf5..3ec73022c60 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -59,6 +59,17 @@
 	};
 };
 
+#include "k3-binman-capsule-r5.dtsi"
+
+// Capsule update GUIDs in string form.  See am62px_evm.h
+#define AM62PX_SK_TIBOOT3_IMAGE_GUID_STR "b08471b7-be2d-4489-87a1-cab28a0cf743"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		image-guid = AM62PX_SK_TIBOOT3_IMAGE_GUID_STR;
+	};
+};
+
 #endif /* CONFIG_TARGET_AM62P5_R5_EVM */
 
 #if IS_ENABLED(CONFIG_TARGET_AM62P5_A53_EVM)
@@ -170,4 +181,22 @@
 	};
 };
 
+#include "k3-binman-capsule.dtsi"
+
+// Capsule update GUIDs in string form.  See am62px_evm.h
+#define AM62PX_SK_SPL_IMAGE_GUID_STR "d02ed781-6d71-4c1a-a999-3c6a41c36324"
+#define AM62PX_SK_UBOOT_IMAGE_GUID_STR "7e6aea51-965c-44ab-b388-daeb03b54f66"
+
+&capsule_tispl {
+	efi-capsule {
+		image-guid = AM62PX_SK_SPL_IMAGE_GUID_STR;
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		image-guid = AM62PX_SK_UBOOT_IMAGE_GUID_STR;
+	};
+};
+
 #endif /* CONFIG_TARGET_AM62P5_A53_EVM */
-- 
2.34.1

