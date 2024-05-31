Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAFEC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 22:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6C688865;
	Sat,  1 Jun 2024 00:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GAh29RGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA80188826; Sat,  1 Jun 2024 00:51:29 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8967188827
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 00:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VMpD0Z000818;
 Fri, 31 May 2024 17:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717195873;
 bh=Jm32GiKnOILLaA7VZlfewmO1mO5Dz1DVrTztOXpcMgo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GAh29RGrBDUewVATzUv2KZjUzivN6Fxki4w6t8NbxUJNqgSvGeFOV5CsD1Yoc931l
 ZW4aLGDFLpIllPI9AnGQjKD7UsYMF3Fgi6GGwHpQtDeE7wDhcj9IWgdzsysQsTFstj
 oW13GJ91ZhMaeBlAg9vKgSw0Gk/CNI4v08E0avDQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VMpD3h024393
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 17:51:13 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 17:51:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 17:51:13 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VMpDm6065615;
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
Subject: [PATCH v3 3/9] dts: am64x: binman: Include firmware capsules binman
 nodes
Date: Fri, 31 May 2024 17:51:04 -0500
Message-ID: <20240531225110.2622239-4-j-humphreys@ti.com>
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

Fill in the am64x SK's capsule GUID properties of the base binman capsule
nodes.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/dts/k3-am64x-binman.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/k3-am64x-binman.dtsi b/arch/arm/dts/k3-am64x-binman.dtsi
index 37817ba60d2..f768c4d946d 100644
--- a/arch/arm/dts/k3-am64x-binman.dtsi
+++ b/arch/arm/dts/k3-am64x-binman.dtsi
@@ -114,6 +114,17 @@
 	};
 };
 
+#include "k3-binman-capsule-r5.dtsi"
+
+// Capsule update GUIDs in string form.  See am64x_evm.h
+#define AM64X_SK_TIBOOT3_IMAGE_GUID_STR "ede0a0d5-9116-4bfb-aa54-09e97b5afe1a"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		image-guid = AM64X_SK_TIBOOT3_IMAGE_GUID_STR;
+	};
+};
+
 #endif
 
 #ifdef CONFIG_TARGET_AM642_A53_EVM
@@ -373,4 +384,23 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule.dtsi"
+
+// Capsule update GUIDs in string form.  See am64x_evm.h
+#define AM64X_SK_SPL_IMAGE_GUID_STR "77678f5c-64d4-4910-ad75-52c9d95cdb1d"
+#define AM64X_SK_UBOOT_IMAGE_GUID_STR "c6ad43a9-7d31-4f5d-83e9-b8efecae05bf"
+
+&capsule_tispl {
+	efi-capsule {
+		image-guid = AM64X_SK_SPL_IMAGE_GUID_STR;
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		image-guid = AM64X_SK_UBOOT_IMAGE_GUID_STR;
+	};
+};
+
 #endif
-- 
2.34.1

