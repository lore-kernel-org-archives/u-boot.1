Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DECC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4345688305;
	Tue,  9 Apr 2024 00:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H8Nn8bqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 695B088157; Tue,  9 Apr 2024 00:17:59 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA8388153
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 00:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438MHosT038119;
 Mon, 8 Apr 2024 17:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712614670;
 bh=7VsJQgbTK5kdDxAoZVyTXIME67OueSoYBvcgM4TXX+c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=H8Nn8bqU1ksfJwh0yvD9fnss+/N3CXK908CzY+tjQRqwMBOhdBDOIVK0jWnx/8CX3
 79PsajXxKlMf4cN0o1QMMwXgdvPhP7x7/xxQQwFBm7YOXzOPgpHS3pLneWdPt5rvOL
 u3pfHz2LyXsv/knIetkWVvnItiVSV7xd2Cjm1N1U=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438MHoTS122740
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 17:17:50 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 17:17:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 17:17:50 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438MHoOt002376;
 Mon, 8 Apr 2024 17:17:50 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>, Andrew Davis
 <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof
 <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon
 <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 1/7] dts: ti: binman: Add base K3 firmware capsule nodes
Date: Mon, 8 Apr 2024 17:17:29 -0500
Message-ID: <20240408221735.164871-2-j-humphreys@ti.com>
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

Create capsule files for tiboot3.bin, tispl.bin, and u-boot.img.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/dts/k3-binman-capsule-r5.dtsi | 24 +++++++++++++++
 arch/arm/dts/k3-binman-capsule.dtsi    | 42 ++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 arch/arm/dts/k3-binman-capsule-r5.dtsi
 create mode 100644 arch/arm/dts/k3-binman-capsule.dtsi

diff --git a/arch/arm/dts/k3-binman-capsule-r5.dtsi b/arch/arm/dts/k3-binman-capsule-r5.dtsi
new file mode 100644
index 00000000000..7a20afa46aa
--- /dev/null
+++ b/arch/arm/dts/k3-binman-capsule-r5.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+// Capsue update GUIDs.  See ti_armv7_common.h.
+#define K3_TIBOOT3_IMAGE_UUID_STR "e672b518-7cd7-4014-bd8d-40724d0ad4dc"
+
+&binman {
+	capsule-tiboot3 {
+		filename = "tiboot3-capsule.bin";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = K3_TIBOOT3_IMAGE_UUID_STR;
+			private-key = "arch/arm/mach-k3/keys/custMpk.pem";
+			public-key-cert = "arch/arm/mach-k3/keys/custMpk.crt";
+			monotonic-count = <0x1>;
+
+			tiboot3_name: blob {
+				filename = "tiboot3.bin";
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-binman-capsule.dtsi b/arch/arm/dts/k3-binman-capsule.dtsi
new file mode 100644
index 00000000000..4f11ca6f0ef
--- /dev/null
+++ b/arch/arm/dts/k3-binman-capsule.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+// Capsue update GUIDs.  See ti_armv7_common.h.
+#define K3_SPL_IMAGE_UUID_STR "86f710ad-10cf-46ea-ac67-856ae06efad2"
+#define K3_UBOOT_IMAGE_UUID_STR "81b58fb0-3b00-4add-a20a-c185bbaca1ed"
+
+&binman {
+	capsule-tispl {
+		filename = "tispl-capsule.bin";
+		efi-capsule {
+			image-index = <0x2>;
+			image-guid = K3_SPL_IMAGE_UUID_STR;
+			private-key = "arch/arm/mach-k3/keys/custMpk.pem";
+			public-key-cert = "arch/arm/mach-k3/keys/custMpk.crt";
+			monotonic-count = <0x1>;
+
+			tispl_name: blob {
+				filename = "tispl.bin";
+			};
+		};
+	};
+};
+
+&binman {
+	capsule-uboot {
+		filename = "uboot-capsule.bin";
+		efi-capsule {
+			image-index = <0x3>;
+			image-guid = K3_UBOOT_IMAGE_UUID_STR;
+			private-key = "arch/arm/mach-k3/keys/custMpk.pem";
+			public-key-cert = "arch/arm/mach-k3/keys/custMpk.crt";
+			monotonic-count = <0x1>;
+
+			uboot_name: blob {
+				filename = "u-boot.img";
+			};
+		};
+	};
+};
-- 
2.34.1

