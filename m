Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176CDC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 22:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DEBF8886D;
	Sat,  1 Jun 2024 00:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Eo1B+D46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF8188827; Sat,  1 Jun 2024 00:51:29 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2365F887C7
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 00:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VMpDKp000823;
 Fri, 31 May 2024 17:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717195873;
 bh=qqGeo4TSSPnxmTNpoLMsK5JQBLIY19blyHBQL+uIcpw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Eo1B+D46V2lyRnEN1oTuFL4Vgrft47jkmkPCaljzxfHRX3EfnbFRmu02TVVUulMdr
 /9dM4CJiUbwgsu3sluqm1/tE8yjMpOnUNu2VBU8Vd95PjpXu5M/U8sm9bSKLUwVevw
 3owjKEYaxKQT5vpmHsW+b0CO0woTQSdN2JktXqkA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VMpDtj062779
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 17:51:13 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 17:51:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 17:51:13 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VMpDNS065611;
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
Subject: [PATCH v3 2/9] dts: ti: binman: Add base K3 firmware capsule nodes
Date: Fri, 31 May 2024 17:51:03 -0500
Message-ID: <20240531225110.2622239-3-j-humphreys@ti.com>
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

Create capsule files for tiboot3.bin, tispl.bin, and u-boot.img.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm/dts/k3-binman-capsule-r5.dtsi | 21 ++++++++++++++
 arch/arm/dts/k3-binman-capsule.dtsi    | 38 ++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 arch/arm/dts/k3-binman-capsule-r5.dtsi
 create mode 100644 arch/arm/dts/k3-binman-capsule.dtsi

diff --git a/arch/arm/dts/k3-binman-capsule-r5.dtsi b/arch/arm/dts/k3-binman-capsule-r5.dtsi
new file mode 100644
index 00000000000..959ceb7479d
--- /dev/null
+++ b/arch/arm/dts/k3-binman-capsule-r5.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&binman {
+	capsule_tiboot3: capsule-tiboot3 {
+		filename = "tiboot3-capsule.bin";
+		efi-capsule {
+			image-index = <0x1>;
+			image-guid = "00000000-0000-0000-0000-000000000000";
+			private-key = "arch/arm/mach-k3/keys/custMpk.pem";
+			public-key-cert = "arch/arm/mach-k3/keys/custMpk.crt";
+			monotonic-count = <0x1>;
+
+			blob {
+				filename = "tiboot3.bin";
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-binman-capsule.dtsi b/arch/arm/dts/k3-binman-capsule.dtsi
new file mode 100644
index 00000000000..17e83c9fa44
--- /dev/null
+++ b/arch/arm/dts/k3-binman-capsule.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&binman {
+	capsule_tispl: capsule-tispl {
+		filename = "tispl-capsule.bin";
+		efi-capsule {
+			image-index = <0x2>;
+			image-guid = "00000000-0000-0000-0000-000000000000";
+			private-key = "arch/arm/mach-k3/keys/custMpk.pem";
+			public-key-cert = "arch/arm/mach-k3/keys/custMpk.crt";
+			monotonic-count = <0x1>;
+
+			blob {
+				filename = "tispl.bin";
+			};
+		};
+	};
+};
+
+&binman {
+	capsule_uboot: capsule-uboot {
+		filename = "uboot-capsule.bin";
+		efi-capsule {
+			image-index = <0x3>;
+			image-guid = "00000000-0000-0000-0000-000000000000";
+			private-key = "arch/arm/mach-k3/keys/custMpk.pem";
+			public-key-cert = "arch/arm/mach-k3/keys/custMpk.crt";
+			monotonic-count = <0x1>;
+
+			blob {
+				filename = "u-boot.img";
+			};
+		};
+	};
+};
-- 
2.34.1

