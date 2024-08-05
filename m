Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D49C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D14AC889D1;
	Mon,  5 Aug 2024 16:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PXzuhTk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726E6889A6; Mon,  5 Aug 2024 16:30:34 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4284D8899A
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 475EUTLG062171;
 Mon, 5 Aug 2024 09:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1722868229;
 bh=niuvnKXiRyqPgOv4tHWi2XveQRbyOmiGxOqrGW1zcRU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PXzuhTk46TmAHHQXzu+x0RRZc4EQ2/rEFatzWrTkNxpQ6sSTY9ksCNE89hbXF09UO
 ib+ol9oIo4ufTuHcy3+xlvDCBjqaPWj4mf9VKALlF9J+9CNMHe/Uq3qFuQ4ii910fe
 fnCaU+Vw94Bztc5BqetQOKTkAjjiUJ1S5ZAyVoh4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 475EUTdW111288
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 5 Aug 2024 09:30:29 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Aug 2024 09:30:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Aug 2024 09:30:28 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 475ETihu084343;
 Mon, 5 Aug 2024 09:30:24 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>, Nishant Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>,
 Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 Sebin Francis <sebin.francis@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V8 7/7] arm: dts: phycore-am62x: Package TIFS Stub
Date: Mon, 5 Aug 2024 19:59:37 +0530
Message-ID: <20240805142937.443737-8-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805142937.443737-1-d-gole@ti.com>
References: <20240805142937.443737-1-d-gole@ti.com>
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

Add support for packaging the TIFS Stub as it's required for basic Low
Power Modes like Deep Sleep.
The reason it is packaged using binman and not inherently as part of the
DM firmware is because for HS devices, customer owns the customer key
and only customer has access to it.
DM is release by TI, Since TI doesn't have access to the customer key it
cannot have a component that is signed by customer key.
Hence, it's left as part of binman to be signed and packaged.

While at it, also make sure it's documented in phycore-am62x

Reviewed-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 101 +++++++++++++++++-
 doc/board/phytec/phycore-am62x.rst            |   2 +-
 2 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index dbee4aa8d8a5..0961ca66f280 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -150,12 +150,107 @@
 			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 		};
 	};
+
+	tifsstub-hs {
+		filename = "tifsstub.bin_hs";
+		ti-secure-rom {
+			content = <&tifsstub_hs_cert>;
+			core = "secure";
+			load = <0x40000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "custMpk.pem";
+			countersign;
+			tifsstub;
+		};
+		tifsstub_hs_cert: tifsstub-hs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_hs_enc: tifsstub-hs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	tifsstub-fs {
+		filename = "tifsstub.bin_fs";
+		tifsstub_fs_cert: tifsstub-fs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_fs_enc: tifsstub-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+	};
+
+	tifsstub-gp {
+		filename = "tifsstub.bin_gp";
+		ti-secure-rom {
+			content = <&tifsstub_gp>;
+			core = "secure";
+			load = <0x60000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "ti-degenerate-key.pem";
+			tifsstub;
+		};
+		tifsstub_gp: tifsstub-gp.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62x-gp.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
 		fit {
 
 			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+
+				tifsstub-gp {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9dc00000>;
+					entry = <0x9dc00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -187,7 +282,8 @@
 				conf-0 {
 					description = "k3-am625-phyboard-lyra-rdk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
+						    "tifsstub-gp", "dm", "spl";
 					fdt = "fdt-0";
 				};
 			};
@@ -266,7 +362,8 @@
 				conf-0 {
 					description = "k3-am625-phyboard-lyra-rdk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
+						    "tifsstub-gp", "dm", "spl";
 					fdt = "fdt-0";
 				};
 			};
diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index af24acf9aac4..56c1fd8354b4 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -32,7 +32,7 @@ Sources
 
 .. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_boot_firmwares
-    :end-before: .. k3_rst_include_end_boot_firmwares
+    :end-before: .. k3_rst_include_end_tifsstub
 
 Build procedure
 ---------------
-- 
2.34.1

