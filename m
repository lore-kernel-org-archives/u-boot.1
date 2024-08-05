Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6070BC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC290889CB;
	Mon,  5 Aug 2024 16:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gw+ZcSVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B294889B8; Mon,  5 Aug 2024 16:30:25 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43421889A2
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 475EUJJ2061799;
 Mon, 5 Aug 2024 09:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1722868220;
 bh=x0hsKQDYeg0QGHFwVF4CSZpfuzu3efbMioO2zTagZDU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gw+ZcSVGOrw+IiTaDeXHqbb/OMKFTjQiNNFkQG2IqTHPDN7C+si9zSV9K3zCmB7Nn
 UgmZHh6MIG5SD7nip/eMcReQ+4ywsLrHMOyB6p1H0Ly25aNoUEkrzvC73PYJbnexMX
 gaqHTX8NlBQSflNfwsYtluhEepKPKXkL2RPQGHOo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 475EUJAY007834
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 5 Aug 2024 09:30:19 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Aug 2024 09:30:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Aug 2024 09:30:19 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 475ETihs084343;
 Mon, 5 Aug 2024 09:30:15 -0500
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
Subject: [PATCH V8 5/7] arm: dts: k3-am625-beagleplay: Package TIFS Stub
Date: Mon, 5 Aug 2024 19:59:35 +0530
Message-ID: <20240805142937.443737-6-d-gole@ti.com>
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

Reviewed-by: Nishanth Menon <nm@ti.com>
Acked-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 33 +++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index 467cac68d0f6..a067b0ba3543 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -78,6 +78,23 @@
 		};
 	};
 
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
 	ti-spl_unsigned {
 		filename = "tispl.bin_unsigned";
 		symlink = "tispl.bin";
@@ -115,6 +132,19 @@
 					};
 				};
 
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
 					description = "DM binary";
 					type = "firmware";
@@ -158,7 +188,8 @@
 				conf-0 {
 					description = "k3-am625-beagleplay";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl",
+					"tifsstub-gp";
 					fdt = "fdt-0";
 				};
 			};
-- 
2.34.1

