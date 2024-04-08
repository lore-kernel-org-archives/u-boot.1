Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B1ACD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F232882F7;
	Tue,  9 Apr 2024 00:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HqrhF/Hn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B9288165; Tue,  9 Apr 2024 00:17:57 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA1E880F9
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 00:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438MHohG038131;
 Mon, 8 Apr 2024 17:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712614670;
 bh=mfA184P9pg9LTljJGUJYhfxwD30ifUGMbk9co3uFFRU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HqrhF/HnK7yhKXQcsMS/C+ySKE9cTh7bf1hevoCKeh8NzY803Szxq2EzbIUkwLMfW
 EQsx2Bf/6f8lq+Z/M+KF7O4kWfbPE/8lPmEkV6rxgf5swMOxcMo+dN2mTAsouk02j3
 wOijDtKEP9LPXe3VQcuR8nEMAZudkIOadiji9Shw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438MHoh5122744
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 17:17:50 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 17:17:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 17:17:50 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438MHokZ002385;
 Mon, 8 Apr 2024 17:17:50 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>, Andrew Davis
 <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof
 <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon
 <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 7/7] dts: beagleboneai64: binman: Include firmware capsules
 binman nodes
Date: Mon, 8 Apr 2024 17:17:35 -0500
Message-ID: <20240408221735.164871-8-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408221735.164871-1-j-humphreys@ti.com>
References: <20240408221735.164871-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Apr 2024 00:46:15 +0200
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

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  9 ++++++++
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   | 22 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
index 116ee373118..a3c5fa1f0b5 100644
--- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
@@ -355,4 +355,13 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule.dtsi"
+&tispl_name {
+	filename = "tispl.bin_unsigned";
+};
+&uboot_name {
+	filename = "u-boot.img_unsigned";
+};
+
 #endif
diff --git a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
index 43da4dafba8..1a98ad9e34f 100644
--- a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
+++ b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
@@ -183,3 +183,25 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule-r5.dtsi"
+
+// Capsue update GUIDs.  See ti_armv7_common.h.
+#define K3_SYSFW_IMAGE_UUID_STR "6fd10680-361b-431f-80aa-899455819e11"
+
+&binman {
+	capsule-sysfw {
+		filename = "sysfw-capsule.bin";
+		efi-capsule {
+			image-index = <0x4>;
+			image-guid = K3_SYSFW_IMAGE_UUID_STR;
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

