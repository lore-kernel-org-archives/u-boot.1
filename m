Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA35C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 04:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1882A8839F;
	Tue, 18 Jun 2024 06:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DOWbgZCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C8F8839F; Tue, 18 Jun 2024 06:56:32 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922558832D
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 06:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45I4uQ3G093692;
 Mon, 17 Jun 2024 23:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718686586;
 bh=osvtIc+QiaQ1+SIweD/qL4SLijIS7X3vwgAScGlVrPE=;
 h=From:To:CC:Subject:Date;
 b=DOWbgZCLCI9xsfbm+EbwqZr0mE+YjSAnKGkpsjIjlpiW5HtqEHtxhl23RyNnWq4Dp
 EbUkz1em3IomjOkVUqQLgYpnhKqrk7tHYLnhOzEtk7UQl3ySVGh1yuRIarjn/XuQum
 wR3Ekn3N/Mt//pt+TkCgUeeIkzk9G3UF/yZch8O8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45I4uQ6U009679
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 23:56:26 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 23:56:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 23:56:26 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45I4uNtm085735;
 Mon, 17 Jun 2024 23:56:23 -0500
From: Dhruva Gole <d-gole@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH v2] arm: dts: k3-am625-beagleplay: Package TIFS Stub
Date: Tue, 18 Jun 2024 10:26:10 +0530
Message-ID: <20240618045610.271884-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
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

Acked-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

No changes from v1, just picked Neha's ack and rebased on master again.
Link to v1:
https://lore.kernel.org/u-boot/20240612062351.3690091-1-d-gole@ti.com/

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 33 +++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index fb2032068d1c..5e2248a4a668 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -69,6 +69,23 @@
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
 		pad-byte = <0xff>;
@@ -105,6 +122,19 @@
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
@@ -148,7 +178,8 @@
 				conf-0 {
 					description = "k3-am625-beagleplay";
 					firmware = "atf";
-					loadables = "tee", "dm", "spl";
+					loadables = "tee", "dm", "spl",
+					"tifsstub-gp";
 					fdt = "fdt-0";
 				};
 			};

base-commit: 16324b43db3f2b4fbbc3b701893fcfc4104f33fb
-- 
2.34.1

