Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA1DC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D86578772A;
	Tue, 19 Dec 2023 12:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bZcRzvPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E0286FB8; Tue, 19 Dec 2023 11:13:23 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A9EF871B1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJADE3P040985;
 Tue, 19 Dec 2023 04:13:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702980794;
 bh=JijppZxq27gRCxBmi8qoNEVZ6HLGM2vyioNj7PX7B+8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=bZcRzvPcI9pxWKf/f9fwVQdJEuswYltGPn18fHu4a2IIuMvffmXI6Y4+d+4+rH/3/
 b9VxNu0Rgkm9uZYLk1+AxyIAjFnQcN0Qicx3zAVqQqQn3YGrHRmVnYYRajmz8ITgyE
 mcvDxeVFKywJyF5rXV1ZmWG/o7kOZ2LrDERNdqyc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJADESV031695
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 04:13:14 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 04:13:13 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 04:13:13 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJADDde089468;
 Tue, 19 Dec 2023 04:13:13 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BJADDsi018935;
 Tue, 19 Dec 2023 04:13:13 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 11/16] arm: dts: k3-am65x-binman: Add ICSSG2 overlay and
 configuration
Date: Tue, 19 Dec 2023 15:42:15 +0530
Message-ID: <20231219101225.3443978-23-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219101225.3443978-1-danishanwar@ti.com>
References: <20231219101225.3443978-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 19 Dec 2023 12:33:18 +0100
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

Add ICSSG2 overlay and configuration to tispl and u-boot images.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm/dts/k3-am65x-binman.dtsi | 85 +++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
index 8cc24da1f3..9a0c0fca47 100644
--- a/arch/arm/dts/k3-am65x-binman.dtsi
+++ b/arch/arm/dts/k3-am65x-binman.dtsi
@@ -98,6 +98,8 @@
 #define SPL_AM654_EVM_DTB "spl/dts/k3-am654-base-board.dtb"
 #define AM654_EVM_DTB "u-boot.dtb"
 
+#define AM654_EVM_ICSSG2_DTBO "arch/arm/dts/k3-am654-icssg2.dtbo"
+
 &binman {
 	ti-spl {
 		insert-template = <&ti_spl_template>;
@@ -124,6 +126,20 @@
 						filename = SPL_AM654_EVM_DTB;
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am654-icssg2 overlay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&spl_am65x_evm_icssg2_dtb>;
+						keyfile = "custMpk.pem";
+					};
+					spl_am65x_evm_icssg2_dtb: blob-ext {
+						filename = AM654_EVM_ICSSG2_DTBO;
+					};
+				};
 			};
 
 			configurations {
@@ -135,6 +151,13 @@
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am654-icssg2";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl";
+					fdt = "fdt-0", "fdt-1";
+				};
 			};
 		};
 	};
@@ -168,6 +191,24 @@
 					};
 				};
 
+				fdt-1 {
+					description = "k3-am654-icssg2 overlay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&am65x_evm_icssg2_dtb>;
+						keyfile = "custMpk.pem";
+
+					};
+					am65x_evm_icssg2_dtb: blob-ext {
+						filename = AM654_EVM_ICSSG2_DTBO;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+
 			};
 
 			configurations {
@@ -179,6 +220,13 @@
 					loadables = "uboot";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am654-icssg2";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0", "fdt-1";
+				};
 			};
 		};
 	};
@@ -205,6 +253,16 @@
 						filename = SPL_AM654_EVM_DTB;
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am654-icssg2 overlay";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = AM654_EVM_ICSSG2_DTBO;
+					};
+				};
 			};
 
 			configurations {
@@ -216,6 +274,13 @@
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am654-icssg2";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl";
+					fdt = "fdt-0", "fdt-1";
+				};
 			};
 		};
 	};
@@ -243,6 +308,19 @@
 						algo = "crc32";
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am654-icssg2";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = AM654_EVM_ICSSG2_DTBO;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
 			};
 
 			configurations {
@@ -254,6 +332,13 @@
 					loadables = "uboot";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am654-icssg2";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0", "fdt-1";
+				};
 			};
 		};
 	};
-- 
2.34.1

