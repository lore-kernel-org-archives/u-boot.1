Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9200EC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 21:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A2448866A;
	Fri, 19 Apr 2024 23:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TfeMaNB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC7C688634; Fri, 19 Apr 2024 23:29:23 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC6688131
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 23:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43JLTBeB002037;
 Fri, 19 Apr 2024 16:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713562151;
 bh=2sm8DOIgt8SustlJD4JNHsG/FrGs7SGenX8CwDK6TnM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TfeMaNB7uoyS2I0o7RSRKFfbjzsN9DnGTUXRFOpbXg4QRzr07mUb+u0i93+e96xZg
 N94ifRlmEh8y+LYXQyDBgOd+AZo3Zkx2Agen3QIkwa82c6w3eC/3e9C5EY189TOXsT
 9135tmAcQx74PcmeKer5bkALE1Zbz14rM+OoPcBg=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43JLTBLn029017
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Apr 2024 16:29:11 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 16:29:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 16:29:11 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43JLTBuB014466;
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
Subject: [PATCH v2 7/7] dts: beagleboneai64: binman: Include firmware capsules
 binman nodes
Date: Fri, 19 Apr 2024 16:28:19 -0500
Message-ID: <20240419212819.170033-8-j-humphreys@ti.com>
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

Fill in the BeagleBoneAI64's capsule GUID properties of the base binman capsule
nodes.
Also add it's SYSFW binman capsule node.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   | 23 +++++++++++++++
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   | 29 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
index e202ae16644..884f44239e1 100644
--- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
@@ -351,4 +351,27 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule.dtsi"
+
+// Capsule update GUIDs in string form.  See beagleboneai64.h
+#define BEAGLEBONEAI64_SPL_IMAGE_GUID_STR "83447222-1e26-40cd-a395-b7de0957e875"
+#define BEAGLEBONEAI64_UBOOT_IMAGE_GUID_STR "4249ff77-c17d-4eb7-a1db-45aa9887d49e"
+
+&capsule_tispl {
+	efi-capsule {
+		image-guid = BEAGLEBONEAI64_SPL_IMAGE_GUID_STR;
+
+		blob {
+			filename = "tispl.bin_unsigned";
+		};
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		image-guid = BEAGLEBONEAI64_UBOOT_IMAGE_GUID_STR;
+	};
+};
+
 #endif
diff --git a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
index 43da4dafba8..d4ef18248b0 100644
--- a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
+++ b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
@@ -183,3 +183,32 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule-r5.dtsi"
+
+// Capsue update GUIDs.  See beagleboneai64.h.
+#define BEAGLEBONEAI64_TIBOOT3_IMAGE_GUID_STR "772a4810-2194-4923-8754-0115870ef367"
+#define BEAGLEBONEAI64_SYSFW_IMAGE_GUID_STR "dfc9c683-49b7-46bd-b3c1-3a3b2fdb135b"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		image-guid = BEAGLEBONEAI64_TIBOOT3_IMAGE_GUID_STR;
+	};
+};
+
+&binman {
+	capsule-sysfw {
+		filename = "sysfw-capsule.bin";
+		efi-capsule {
+			image-index = <0x4>;
+			image-guid = BEAGLEBONEAI64_SYSFW_IMAGE_GUID_STR;
+			private-key = "arch/arm/mach-k3/keys/custMpk.pem";
+			public-key-cert = "arch/arm/mach-k3/keys/custMpk.crt";
+			monotonic-count = <0x1>;
+
+			blob {
+				filename = "sysfw.itb";
+			};
+		};
+	};
+};
-- 
2.34.1

