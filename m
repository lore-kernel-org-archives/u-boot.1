Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AC2C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 13:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 618FF82163;
	Tue,  6 May 2025 15:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eyM7zg5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B519828F8; Tue,  6 May 2025 15:11:53 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D886282153
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 15:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546DBlGJ509282
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 08:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746537107;
 bh=TswnYNvFXZfaUhLgHMHr1W2Mfqvud87JrpEePAM+UE8=;
 h=From:Date:Subject:To:CC;
 b=eyM7zg5Le4z4J+KDIIGxfeIznBJGUnsJQxbPdj+D1+LTJMWT+O+xBdxmwUg+R/DWa
 nXgi1qDPXoK1gYTt1yLqmejdjZ8KtKVL5HKDtGyqjZ2EIeTk00iod9YYMituy8DA44
 YpcQQcAbhdCd+cOCal8kRQ+IuEsa8XRpBS9qTuWw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546DBl1l009424
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 08:11:47 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 08:11:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 08:11:47 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546DBkRT072573;
 Tue, 6 May 2025 08:11:47 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 6 May 2025 08:11:45 -0500
Subject: [PATCH v2] arm: dts: k3: require mandatory firmware in binman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250506-non-optional-v2-1-f58b12aab913@ti.com>
X-B4-Tracking: v=1; b=H4sIAJAKGmgC/3WMywrCMBBFf6XM2pEmtsS66n9IF3naAU1KEoJS8
 u/G7l2eyz1nh2Qj2QS3bodoCyUKvgE/daBX6R8WyTQG3vOxH/iEPngMW243+URhlONKGcVGB03
 ZonX0PnL3pfFKKYf4OeqF/dY/ocKQoRq0NBelhbhOc6azDi9Yaq1f5rBB/qUAAAA=
To: Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>,
 "Nishanth Menon" <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Garrett Giordano
 <ggiordano@phytec.com>, Apurva Nandan <a-nandan@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26150; i=bb@ti.com;
 h=from:subject:message-id; bh=eFKypzv8IQRVua1sZJMaMNXN+lGmrpkt0BVJT3Myljc=;
 b=owNCWmg5MUFZJlNZaF+p6gAAbH////7du/u/y7P9N/nO/37rNtr6/n6h33YB9V7f17v73P+wA
 RtTB2iA00ADMoBoNAABkNDIZANA0ADQAAAxAAZABp6gNAGg0aA2g9NUMkHqNBoAAaNA0AGgAAaa
 B6agaAHqABoBoxNBtID1A0eoepp6mj1AMmgB5TQ0B0HqB6TRpoxDI0NGmm1NNGmmRo00BoDQaGI
 yBkBobUGgZMR6gPUGgAAAaaAAZGgAAMaNSgv0Hevo8dPPiWCAOOC7/ssrtj/M/NjCZiYeRGGRj0
 FzPBkPICIsL4SGYnqsKHYdxrHzppOGeSgGQVG0qLA30HeUQPwWv4pVKuycsj1L/YVISjVSrKn4W
 AXKhEipDx59boFv5NxoyQfb5djMHf3DgOE0zTr2AXCFmxHaSJHQvgKdZSltwA6oJYSln4qMbkeS
 VVNBpkBHUl0ykEtmGD6yd6QveDpC7qFWiYLzNolJXkBOzREm4hjevMFQCwU/eXIoywAN9A+BNhu
 uOYZQWrRjnR2K9n1grR94+aXMhALO/qNA7BVuT4KftbsWw387MjcJLyKFcv815DzGenw2juV+mE
 azPt41lSVEJVWXlQazAIz8sDS4VUyzACDkDitlh9a5Eh+17NmNcktGoQAYKXAJPyWKFA4slhgR2
 5iaD/i7kinChINC/U9Q
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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
Changes in v2:
- Rebased on -master
- Link to v1: https://lore.kernel.org/r/20250429-non-optional-v1-1-b4cad3bc7789@ti.com
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi     |  5 -----
 arch/arm/dts/k3-am625-r5-beagleplay.dts           |  1 -
 arch/arm/dts/k3-am625-sk-binman.dtsi              |  7 -------
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi |  5 -----
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi     |  7 -------
 arch/arm/dts/k3-am62a-sk-binman.dtsi              |  7 -------
 arch/arm/dts/k3-am62p-sk-binman.dtsi              |  5 -----
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi     |  5 -----
 arch/arm/dts/k3-am64x-binman.dtsi                 |  5 -----
 arch/arm/dts/k3-am65x-binman.dtsi                 |  3 ---
 arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi      |  5 -----
 arch/arm/dts/k3-j7200-binman.dtsi                 | 11 -----------
 arch/arm/dts/k3-j721e-binman.dtsi                 | 11 -----------
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts       |  1 -
 arch/arm/dts/k3-j721s2-binman.dtsi                |  7 -------
 arch/arm/dts/k3-j722s-binman.dtsi                 |  5 -----
 arch/arm/dts/k3-j784s4-binman.dtsi                |  7 -------
 17 files changed, 97 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 9b536d679afa3..32d8804a395f1 100644
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
index cc619f5920e2b..6822a5dac896e 100644
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
@@ -263,7 +258,6 @@
 					};
 					dm: ti-dm {
 						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
@@ -391,7 +385,6 @@
 				dm {
 					ti-dm {
 						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 5a8788b227b12..bfbba28269cf3 100644
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
index 1871926c20776..fd3401015325c 100644
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
@@ -269,7 +264,6 @@
 					};
 					dm: ti-dm {
 						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
@@ -456,7 +450,6 @@
 				dm {
 					ti-dm {
 						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index ed973541ffffc..877a513a24186 100644
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
@@ -253,7 +248,6 @@
 					};
 					dm: ti-dm {
 						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
@@ -379,7 +373,6 @@
 				dm {
 					ti-dm {
 						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index 8216add3498b3..d65e5c4d4e1e5 100644
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
@@ -203,7 +199,6 @@
 
 					dm: ti-dm {
 						filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
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
index ba05d41035787..2a0023fb7c313 100644
--- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
+++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
@@ -88,7 +88,6 @@
 		ti_fs_enc: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_tifs_cfg: combined-tifs-cfg.bin {
@@ -99,7 +98,6 @@
 		sysfw_inner_cert: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_dm_cfg: combined-dm-cfg.bin {
@@ -140,7 +138,6 @@
 		ti_fs_enc_fs: ti-fs-enc.bin {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-enc.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
@@ -151,7 +148,6 @@
 		sysfw_inner_cert_fs: sysfw-inner-cert {
 			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-cert.bin";
 			type = "blob-ext";
-			optional;
 		};
 
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
@@ -181,7 +177,6 @@
 
 					dm: ti-dm {
 						filename = "ti-dm/j722s/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 47a4cde6b8544..b74bd1657f932 100644
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
@@ -339,7 +330,6 @@
 					};
 					dm: ti-dm {
 						filename = "ti-dm/j7200/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
@@ -425,7 +415,6 @@
 				dm {
 					ti-dm {
 						filename = "ti-dm/j7200/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 6adfab164ee2f..9522a95650622 100644
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
@@ -461,7 +452,6 @@
 					};
 					dm: ti-dm {
 						filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
@@ -546,7 +536,6 @@
 				dm {
 					ti-dm {
 						filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
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
index 73af184d27ed4..4f524e58ceba0 100644
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
@@ -280,7 +275,6 @@
 					};
 					dm: ti-dm {
 						filename = "ti-dm/j721s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
@@ -366,7 +360,6 @@
 				dm {
 					ti-dm {
 						filename = "ti-dm/j721s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
index 8f1471371e5bf..57e966ea66644 100644
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
@@ -129,7 +125,6 @@
 
 					dm: ti-dm {
 						filename = "ti-dm/j722s/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index cb1fbc6592355..a7ce1ee2b0317 100644
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
@@ -166,7 +161,6 @@
 					};
 
 					dm: ti-dm {
-						optional;
 					};
 				};
 
@@ -255,7 +249,6 @@
 			images {
 				dm {
 					ti-dm {
-						optional;
 					};
 				};
 

---
base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
change-id: 20250429-non-optional-7dbf2bbdb15f

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

