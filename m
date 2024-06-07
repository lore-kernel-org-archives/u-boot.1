Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37BEC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 08:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68BF08843A;
	Fri,  7 Jun 2024 10:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FMQmuoSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D3E58780E; Fri,  7 Jun 2024 10:58:35 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE10688464
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 10:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4578wVmu000783;
 Fri, 7 Jun 2024 03:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717750711;
 bh=o4ttU8p/IaQJKoL2wmRDuhRaeh2C09BXTNN4+bblNSU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FMQmuoSM2M6Qj09J4MvvJbt2n/nqHZDbzEIMeagAx3befKaQYrJnBhtJfxpl0jibl
 F8TEEnHt1n3ZhiyD8HV/jGP5h5jh1AiMCko9RR+WFQ47KoSiv/kvC8zUOCttvKCo3h
 LamZPqgEFwOdyddz8yl9VVPShTuU/VqSymI8Hia8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4578wVx0013502
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Jun 2024 03:58:31 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 03:58:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 03:58:30 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4578wDDK073875;
 Fri, 7 Jun 2024 03:58:29 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vibhore Vardhan <vibhore@ti.com>, Neha Malcom
 Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH 2/2] arm: dts: k3: binman: am62p: add support for signing
 TIFSStub images
Date: Fri, 7 Jun 2024 14:26:41 +0530
Message-ID: <20240607085640.2900395-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607085640.2900395-1-d-gole@ti.com>
References: <20240607085640.2900395-1-d-gole@ti.com>
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

Adds TIFS stub binaries, this is required for deepsleep functionality.

This implements the same change as commit 128f81290b7d ("arm: dts: k3:
binman: am625: add support for signing TIFSSTUB Images") did for TI AM62
SK board.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 65 +++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index dea14945bf56..210179756a79 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -74,12 +74,74 @@
 			filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 		};
 	};
+	tifsstub-hs {
+		filename = "tifsstub.bin_hs";
+		ti-secure-rom {
+			content = <&tifsstub_hs_cert>;
+			core = "secure";
+			load = <0x60000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "custMpk.pem";
+			countersign;
+			tifsstub;
+		};
+		tifsstub_hs_cert: tifsstub-hs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_hs_enc: tifsstub-hs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	tifsstub-fs {
+		filename = "tifsstub.bin_fs";
+		tifsstub_fs_cert: tifsstub-fs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_fs_enc: tifsstub-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+	};
 
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
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
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
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -116,7 +178,8 @@
 				conf-0 {
 					description = "k3-am62px-sk";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl",
+					"tifsstub-hs", "tifsstub-fs";
 					fdt = "fdt-0";
 				};
 			};
-- 
2.34.1

