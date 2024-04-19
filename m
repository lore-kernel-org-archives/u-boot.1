Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B723C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 21:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA47F885AC;
	Fri, 19 Apr 2024 23:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d3HVsMWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9346D88634; Fri, 19 Apr 2024 23:29:23 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA1A88499
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 23:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43JLTBKA073515;
 Fri, 19 Apr 2024 16:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713562151;
 bh=b6jKP6NDnmBDadrkMevj7hKehBE08DMfoCv8I+yLqX4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=d3HVsMWrdxFEGfO1WGWggHL20J7vf8XrpRtjinHoKuEdyo5L4Cz4pAPctwD7wbiz2
 YfUHCMUhFyBLRokKWHewUmLOKIkbgaSzUPS9g5q6GR66KElZ6lYxHjgy3G1nRojXlz
 ln9ZpQm5qyqIu2WCPV0l13u5u/U+T2FwFRgF8iks=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43JLTBfT098843
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Apr 2024 16:29:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 16:29:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 16:29:11 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43JLTBc6014459;
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
Subject: [PATCH v2 3/7] dts: j721e: binman: Include firmware capsules binman
 nodes
Date: Fri, 19 Apr 2024 16:28:15 -0500
Message-ID: <20240419212819.170033-4-j-humphreys@ti.com>
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

Fill in the J721e SK's capsule GUID properties of the base binman capsule
nodes.
Also add it's SYSFW binman capsule node.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/dts/k3-j721e-binman.dtsi | 49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 75a6e9599b9..32cfd545e5c 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -207,6 +207,36 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule-r5.dtsi"
+
+// Capsule update GUIDs in string form.  See j721e_evm.h
+#define J721E_SK_TIBOOT3_IMAGE_GUID_STR "e672b518-7cd7-4014-bd8d-40724d0ad4dc"
+#define J721E_SK_SYSFW_IMAGE_GUID_STR "6fd10680-361b-431f-80aa-899455819e11"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		image-guid = J721E_SK_TIBOOT3_IMAGE_GUID_STR;
+	};
+};
+
+&binman {
+	capsule-sysfw {
+		filename = "sysfw-capsule.bin";
+		efi-capsule {
+			image-index = <0x4>;
+			image-guid = J721E_SK_SYSFW_IMAGE_GUID_STR;
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
+
 #endif
 
 #ifdef CONFIG_TARGET_J721E_A72_EVM
@@ -585,4 +615,23 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule.dtsi"
+
+// Capsule update GUIDs in string form.  See j721e_evm.h
+#define J721E_SK_SPL_IMAGE_GUID_STR "86f710ad-10cf-46ea-ac67-856ae06efad2"
+#define J721E_SK_UBOOT_IMAGE_GUID_STR "81b58fb0-3b00-4add-a20a-c185bbaca1ed"
+
+&capsule_tispl {
+	efi-capsule {
+		image-guid = J721E_SK_SPL_IMAGE_GUID_STR;
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		image-guid = J721E_SK_UBOOT_IMAGE_GUID_STR;
+	};
+};
+
 #endif
-- 
2.34.1

