Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4A6C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 21:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B112886DA;
	Fri, 19 Apr 2024 23:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ELKe/JVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6718B88131; Fri, 19 Apr 2024 23:29:27 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7FF88629
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 23:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43JLTBUv119840;
 Fri, 19 Apr 2024 16:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713562151;
 bh=v9e1J1TH332tlCBoAaeIAo4jM6yB2ugR44uMBeQTCoQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ELKe/JVoxc4wfKZcG92qnoLOq6NcrU5/+mmFXe5+5WUQnrHuhi6M/+qxLmPEt+Slx
 8okNWzu+qzUaX8Na2IiKbrjolDAB6WS2U7HoAwturkDLrc8ahsDpXNjzGW3gi9lZiv
 4AfYuKgphvJnKgtHlo678zemKVxleFB9mwmKWA5o=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43JLTBUr124721
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Apr 2024 16:29:11 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 16:29:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 16:29:11 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43JLTB3X013846;
 Fri, 19 Apr 2024 16:29:11 -0500
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
Subject: [PATCH v2 6/7] dts: am62x: binman: Include firmware capsules binman
 nodes
Date: Fri, 19 Apr 2024 16:28:18 -0500
Message-ID: <20240419212819.170033-7-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419212819.170033-1-j-humphreys@ti.com>
References: <20240419212819.170033-1-j-humphreys@ti.com>
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

Fill in the am62x SK's capsule GUID properties of the base binman capsule
nodes.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index dfd38d64f63..eadfa398fa3 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -137,6 +137,17 @@
 	};
 };
 
+#include "k3-binman-capsule-r5.dtsi"
+
+// Capsule update GUIDs in string form.  See am62x_evm.h
+#define AM62X_SK_TIBOOT3_IMAGE_GUID_STR "abcb83d2-9cb6-4351-b8f1-6494bbe3700a"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		image-guid = AM62X_SK_TIBOOT3_IMAGE_GUID_STR;
+	};
+};
+
 #endif
 
 #ifdef CONFIG_TARGET_AM625_A53_EVM
@@ -452,4 +463,23 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule.dtsi"
+
+// Capsule update GUIDs in string form.  See am62x_evm.h
+#define AM62X_SK_SPL_IMAGE_GUID_STR "aee355fc-bf97-4264-8c82-437255efdc1d"
+#define AM62X_SK_UBOOT_IMAGE_GUID_STR "28ab8c6c-fca8-41d3-8ea1-5f171b7d2929"
+
+&capsule_tispl {
+	efi-capsule {
+		image-guid = AM62X_SK_SPL_IMAGE_GUID_STR;
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		image-guid = AM62X_SK_UBOOT_IMAGE_GUID_STR;
+	};
+};
+
 #endif
-- 
2.34.1

