Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D9ECD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5A778832D;
	Wed,  3 Apr 2024 14:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V3EgVHum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FBEE8833D; Wed,  3 Apr 2024 14:03:53 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3429F88367
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433C3mMV077067;
 Wed, 3 Apr 2024 07:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712145828;
 bh=R9Nbd9tyaPsYDnEX8+TdVXz68n68A+WMWPsqcrq0/5U=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=V3EgVHumqRITifoXrf9Opr1GIju4FgZZHaEycZ0nrDtB8vR087bpsFggQIsJ1YY+w
 eKq2TnOlY/nqiEMKpROJw0hRXatqe1zKKmy7wUzd8eeD485QKGSUmN7rObdLU6jCoX
 bxxf0mkVwCPj8i9iQcWOU9JjbYWPdg7CueWh+rJE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433C3mJD006161
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 07:03:48 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 07:03:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 07:03:48 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433C3T4j128691;
 Wed, 3 Apr 2024 07:03:46 -0500
From: Dhruva Gole <d-gole@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vibhore Vardhan <vibhore@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 2/2] arm: dts: k3: binman: am625: add support for signing
 TIFSSTUB Images
Date: Wed, 3 Apr 2024 17:33:10 +0530
Message-ID: <20240403120309.4026170-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403120309.4026170-1-d-gole@ti.com>
References: <20240403120309.4026170-1-d-gole@ti.com>
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

From: Kamlesh Gurudasani <kamlesh@ti.com>

Add support for signing of TIFSSTUB images for HSSE, HSFS and GP devices
and include them in tispl.bin and tispl.bin_unsigned.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 141 ++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 5b058bd03a07..dfd38d64f638 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -151,11 +151,107 @@
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
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
 		fit {
 			images {
+
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
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -189,7 +285,8 @@
 				conf-0 {
 					description = "k3-am625-sk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
+					"tifsstub-gp", "dm", "spl";
 					fdt = "fdt-0";
 				};
 			};
@@ -247,6 +344,45 @@
 		fit {
 			images {
 
+				tifsstub-hs {
+					description = "tifsstub";
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
+					description = "tifsstub";
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
+					description = "tifsstub";
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
+
 				dm {
 					ti-dm {
 						filename = "ti-dm.bin";
@@ -270,7 +406,8 @@
 				conf-0 {
 					description = "k3-am625-sk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
+						  "tifsstub-gp", "dm", "spl";
 					fdt = "fdt-0";
 				};
 			};
-- 
2.34.1

