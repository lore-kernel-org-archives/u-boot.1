Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756CEC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 20:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A838D8283E;
	Tue, 29 Apr 2025 22:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OpFM+cXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1CA48293C; Tue, 29 Apr 2025 22:02:03 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AABA88215E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 22:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53TK1wLO3171092
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 15:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745956918;
 bh=IKjP5tAmlnPoeG7///dt6bJROOVqOn9gxilFlaLN3zk=;
 h=From:Date:Subject:To:CC;
 b=OpFM+cXAna35H3zrTczAfY9MquVkExc8gr+sQB181XhwJu7a4mRdW0FfbaQ6TjrUF
 UgYUAeyQDQ5oXEFgyco7H6adRZcXzHSAFuRnfhbq6SDyT93HIySUnQA045vFHO9GdH
 Ie58FW/7KigG/8s9RnnoOUTVl56fV05uODVJDFgo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53TK1v48012221
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Apr 2025 15:01:58 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Apr 2025 15:01:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Apr 2025 15:01:57 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53TK1vw4092979;
 Tue, 29 Apr 2025 15:01:57 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 29 Apr 2025 15:01:56 -0500
Subject: [PATCH] arm: dts: k3: require mandatory firmware in binman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250429-non-optional-v1-1-b4cad3bc7789@ti.com>
X-B4-Tracking: v=1; b=H4sIADMwEWgC/x2MQQqAIBAAvyJ7TlBJor4SHTTXWggVjQjEvycdB
 2amQsFMWGBhFTI+VCiGDnJgsJ8mHMjJdQYllBajmnmIgcd0d81cfHLWK2udldpDT1JGT++/W7f
 WPsJv7qFeAAAA
To: Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>,
 "Nishanth Menon" <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Garrett Giordano
 <ggiordano@phytec.com>, Apurva Nandan <a-nandan@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

TI's Foundational Security (TIFS), Device Management (DM) and Device
Management and Security Control (DMSC) firmware are required for a
successful boot. Remove the 'optional' flag so binman will emit an error
if these firmware components are not found

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi     |  5 -----
 arch/arm/dts/k3-am625-r5-beagleplay.dts           |  1 -
 arch/arm/dts/k3-am625-sk-binman.dtsi              |  6 ------
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi |  5 -----
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi     |  6 ------
 arch/arm/dts/k3-am62a-sk-binman.dtsi              |  6 ------
 arch/arm/dts/k3-am62p-sk-binman.dtsi              |  5 -----
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi     |  5 -----
 arch/arm/dts/k3-am64x-binman.dtsi                 |  5 -----
 arch/arm/dts/k3-am65x-binman.dtsi                 |  3 ---
 arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi      |  5 -----
 arch/arm/dts/k3-am69-sk-u-boot.dtsi               |  1 -
 arch/arm/dts/k3-j7200-binman.dtsi                 | 10 ----------
 arch/arm/dts/k3-j721e-binman.dtsi                 | 10 ----------
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts       |  1 -
 arch/arm/dts/k3-j721s2-binman.dtsi                |  6 ------
 arch/arm/dts/k3-j722s-binman.dtsi                 |  5 -----
 arch/arm/dts/k3-j742s2-evm-u-boot.dtsi            |  1 -
 arch/arm/dts/k3-j784s4-binman.dtsi                |  5 -----
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi            |  1 -
 20 files changed, 92 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 4a65427e87782..bf28336a70db6 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -36,7 +36,6 @@
 		ti_fs_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -45,7 +44,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -82,7 +80,6 @@
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -91,7 +88,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -125,7 +121,6 @@
 		ti_fs_gp: ti-fs-gp.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
 			filename = "combined-tifs-cfg.bin";
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index 9e0a6ed678448..0ff46a2633039 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -103,7 +103,6 @@
 		ti_fs_gp: ti-fs-gp.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
 			filename = "combined-tifs-cfg.bin";
diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 534eb14795b3d..60a3811426a26 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -34,7 +34,6 @@
 		ti_fs_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -43,7 +42,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -80,7 +78,6 @@
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -89,7 +86,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -123,7 +119,6 @@
 		ti_fs_gp: ti-fs-gp.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -160,7 +155,6 @@
 		filename = "ti-dm.bin";
 		blob-ext {
 			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 0e6188907e474..1bfbf16c15c33 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -34,7 +34,6 @@
 		ti_fs_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -43,7 +42,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -80,7 +78,6 @@
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -89,7 +86,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -123,7 +119,6 @@
 		ti_fs_gp: ti-fs-gp.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
 			filename = "combined-tifs-cfg.bin";
diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index 325702ed6e060..0e2ada3b95e6d 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -41,7 +41,6 @@
 		ti_fs_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -50,7 +49,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -87,7 +85,6 @@
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -96,7 +93,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -130,7 +126,6 @@
 		ti_fs_gp: ti-fs-gp.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62ax-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -168,7 +163,6 @@
 		filename = "ti-dm.bin";
 		blob-ext {
 			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index 2a8c260387b2e..30278d44f82a3 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -38,7 +38,6 @@
 		ti_fs_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -47,7 +46,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -84,7 +82,6 @@
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -93,7 +90,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -127,7 +123,6 @@
 		ti_fs_gp: ti-fs-gp.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62ax-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -152,7 +147,6 @@
 		filename = "ti-dm.bin";
 		blob-ext {
 			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index 797644a7e0d5f..b4ee9572b0aa4 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -38,7 +38,6 @@
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
@@ -49,7 +48,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
@@ -87,7 +85,6 @@
 		ti_fs_enc_hs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_tifs_cfg_hs: combined-tifs-cfg.bin {
@@ -98,7 +95,6 @@
 		sysfw_inner_cert_hs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_dm_cfg_hs: combined-dm-cfg.bin {
@@ -132,7 +128,6 @@
 
 		blob-ext {
 			filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 	tifsstub-hs {
diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index 5228eed19bf58..966905bd64db9 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -33,7 +33,6 @@
 		ti_sci_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_sysfw_cfg: combined-sysfw-cfg.bin {
 			filename = "combined-sysfw-cfg.bin";
@@ -42,7 +41,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 	};
@@ -73,7 +71,6 @@
 		ti_sci_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_sysfw_cfg_fs: combined-sysfw-cfg.bin {
 			filename = "combined-sysfw-cfg.bin";
@@ -82,7 +79,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 	};
@@ -109,7 +105,6 @@
 		ti_sci_gp: ti-sci-gp.bin {
 			filename = "ti-sysfw/ti-sci-firmware-am64x-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_sysfw_cfg_gp: combined-sysfw-cfg-gp.bin {
 			filename = "combined-sysfw-cfg.bin";
diff --git a/arch/arm/dts/k3-am64x-binman.dtsi b/arch/arm/dts/k3-am64x-binman.dtsi
index f768c4d946d47..32e47a3f68888 100644
--- a/arch/arm/dts/k3-am64x-binman.dtsi
+++ b/arch/arm/dts/k3-am64x-binman.dtsi
@@ -29,7 +29,6 @@
 		ti_sci_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_sysfw_cfg: combined-sysfw-cfg.bin {
 			filename = "combined-sysfw-cfg.bin";
@@ -38,7 +37,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 	};
@@ -69,7 +67,6 @@
 		ti_sci_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_sysfw_cfg_fs: combined-sysfw-cfg.bin {
 			filename = "combined-sysfw-cfg.bin";
@@ -78,7 +75,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-sci-firmware-am64x_sr2-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 	};
@@ -105,7 +101,6 @@
 		ti_sci_gp: ti-sci-gp.bin {
 			filename = "ti-sysfw/ti-sci-firmware-am64x-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_sysfw_cfg_gp: combined-sysfw-cfg-gp.bin {
 			filename = "combined-sysfw-cfg.bin";
diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
index 350775e42c2ab..cc82c8b576890 100644
--- a/arch/arm/dts/k3-am65x-binman.dtsi
+++ b/arch/arm/dts/k3-am65x-binman.dtsi
@@ -32,12 +32,10 @@
 		ti_sci_cert: ti-sci-cert.bin {
 			filename = "ti-sysfw/ti-sci-firmware-am65x_sr2-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		ti-sci-firmware-am65x-hs-enc.bin {
 			filename = "ti-sysfw/ti-sci-firmware-am65x_sr2-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 	};
 	itb {
@@ -73,7 +71,6 @@
 		ti_sci: ti-sci.bin {
 			filename = "ti-sysfw/ti-sci-firmware-am65x_sr2-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 	};
 	itb_gp {
diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
index 6c52038cdcafe..26164f102d26a 100644
--- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
+++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
@@ -84,7 +84,6 @@
 		ti_fs_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_tifs_cfg: combined-tifs-cfg.bin {
@@ -95,7 +94,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_dm_cfg: combined-dm-cfg.bin {
@@ -136,7 +134,6 @@
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
@@ -147,7 +144,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
@@ -169,7 +165,6 @@
 
 		blob-ext {
 			filename = "ti-dm/j722s/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 
diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
index 2f119508e1846..406dbb0229683 100644
--- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
@@ -63,7 +63,6 @@
 
 		blob-ext {
 			filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 423badd7cb532..b70f1765baf30 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -35,7 +35,6 @@
 		ti_fs_enc_sr1: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_sr1: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -44,7 +43,6 @@
 		sysfw_inner_cert_sr1: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg_sr1: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -80,7 +78,6 @@
 		ti_fs_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j7200_sr2-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -89,7 +86,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j7200_sr2-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -127,7 +123,6 @@
 		ti_fs_enc_fs_sr1: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_fs_sr1: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -136,7 +131,6 @@
 		sysfw_inner_cert_fs_sr1: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j7200-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg_fs_sr1: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -172,7 +166,6 @@
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j7200_sr2-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -181,7 +174,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j7200_sr2-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -216,7 +208,6 @@
 		ti_fs_gp: ti-fs-gp.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j7200-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -241,7 +232,6 @@
 		filename = "ti-dm.bin";
 		blob-ext {
 			filename = "ti-dm/j7200/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 	ti-spl {
diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 0d607296f0e20..934c3b0ae41cc 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -46,12 +46,10 @@
 		ti_fs_cert: ti-fs-cert.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		ti-fs-firmware-j721e_sr1_1-hs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 	};
 
@@ -67,12 +65,10 @@
 		ti_fs_cert_sr2: ti-fs-cert.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		ti-fs-firmware-j721e_sr2-hs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 	};
 
@@ -148,12 +144,10 @@
 		ti-fs-cert-fs.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		ti-fs-firmware-j721e-hs-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e_sr1_1-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 	};
 	itb_fs_sr1_1 {
@@ -235,12 +229,10 @@
 		ti-fs-cert-fs.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		ti-fs-firmware-j721e-hs-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e_sr2-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 	};
 	itb_fs {
@@ -276,7 +268,6 @@
 		ti_fs: ti-fs.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 	};
 	itb_gp {
@@ -337,7 +328,6 @@
 		filename = "ti-dm.bin";
 		blob-ext {
 			filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 	ti-spl {
diff --git a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
index 586ddb6e7c8f1..5f0dfe9c2fa22 100644
--- a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
+++ b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
@@ -47,7 +47,6 @@
 		ti_fs: ti-fs.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721e-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 	};
 
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index d121d8c0c5442..f033386255ebf 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -34,7 +34,6 @@
 		ti_fs_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721s2-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -43,7 +42,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j721s2-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -79,7 +77,6 @@
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721s2-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -88,7 +85,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j721s2-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
 			filename = "combined-dm-cfg.bin";
@@ -123,7 +119,6 @@
 		ti_fs_gp: ti-fs-gp.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j721s2-gp.bin";
 			type = "blob-ext";
-			optional;
 		};
 		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
 			filename = "combined-tifs-cfg.bin";
@@ -149,7 +144,6 @@
 		filename = "ti-dm.bin";
 		blob-ext {
 			filename = "ti-dm/j721s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 	ti-spl {
diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
index 6b52116657567..b286dc34ec00a 100644
--- a/arch/arm/dts/k3-j722s-binman.dtsi
+++ b/arch/arm/dts/k3-j722s-binman.dtsi
@@ -36,7 +36,6 @@
 		ti_fs_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_tifs_cfg: combined-tifs-cfg.bin {
@@ -47,7 +46,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_dm_cfg: combined-dm-cfg.bin {
@@ -88,7 +86,6 @@
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
@@ -99,7 +96,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
@@ -121,7 +117,6 @@
 
 		blob-ext {
 			filename = "ti-dm/j722s/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 
diff --git a/arch/arm/dts/k3-j742s2-evm-u-boot.dtsi b/arch/arm/dts/k3-j742s2-evm-u-boot.dtsi
index ede5d6e58f5ea..15d72105861ac 100644
--- a/arch/arm/dts/k3-j742s2-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j742s2-evm-u-boot.dtsi
@@ -48,7 +48,6 @@
 
 		blob-ext {
 			filename = "ti-dm/j742s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 0553825b38350..1bdc6d701f036 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -39,7 +39,6 @@
 
 		ti_fs_enc: ti-fs-enc.bin {
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_tifs_cfg: combined-tifs-cfg.bin {
@@ -49,7 +48,6 @@
 
 		sysfw_inner_cert: sysfw-inner-cert {
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_dm_cfg: combined-dm-cfg.bin {
@@ -88,7 +86,6 @@
 
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
@@ -98,7 +95,6 @@
 
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
@@ -135,7 +131,6 @@
 
 		ti_fs_gp: ti-fs-gp.bin {
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
index 8a60d7c61075b..cc0dc6ce5e3fa 100644
--- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
@@ -57,7 +57,6 @@
 
 		blob-ext {
 			filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
 		};
 	};
 

---
base-commit: b249e08ec9b71f9d0b4eb48e3e63f63e8366b7e6
change-id: 20250429-non-optional-7dbf2bbdb15f

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

