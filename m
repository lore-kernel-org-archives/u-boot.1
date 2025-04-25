Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F55FC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 22:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11AF382A31;
	Sat, 26 Apr 2025 00:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vsCIg3Qm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0FE82A46; Sat, 26 Apr 2025 00:54:11 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD4382A0A
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 00:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PMs6pT2295149
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 17:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745621646;
 bh=PPVJmACLNHB7Ti4iXWKjC0/9jvM1nKiFr5bnnxGtsMc=;
 h=From:To:CC:Subject:Date;
 b=vsCIg3QmJCui9iwa+N/xQsnLu+O5QZM6JJOYeNppOWmUD3JnTYOhwygYw1r0rLw7x
 rMdvyLQiyX3AL+wDlIC7nB6bAtK0JcE+Gpb0ZwbqfnzG6pb2GkivmP/hSWUiH3c7Ww
 764Dd+18lqQoa8sYQeRITIiBsXhu4a2MNSdqs00M=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PMs6K7049383
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 17:54:06 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 17:54:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 17:54:04 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PMs40V067604;
 Fri, 25 Apr 2025 17:54:04 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arm: dts: k3: binman: Fix DM firmware selection
Date: Fri, 25 Apr 2025 17:54:03 -0500
Message-ID: <20250425225403.861034-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Just like TF-A and OP-TEE, the documentation states a custom path for DM
can be provided at build time by setting TI_DM. This should then set
ti-dm-path which updates ti-dm node filenames in binman.

Two issues prevent this from functioning for most K3 boards. One is when
then DM firmware name is inside a blob-ext node instead of a ti-dm node.

The second is when the filename in the ti-dm node is a pointer to a
blob-ext node. In this case even though the filename is updated, the
filename in the blob-ext is not, so build can fail if the default
file in the blob-ext cannot be found, even if the updated ti-dm file
does exist.

Fix both of these for all K3 by removing any indirect ti-dm nodes and
making sure all DM nodes are labeled with "ti-dm".

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 11 ++-----
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 15 +++-------
 arch/arm/dts/k3-am625-sk-binman.dtsi          | 14 +++------
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 11 ++-----
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 14 +++------
 arch/arm/dts/k3-am62a-sk-binman.dtsi          | 14 +++------
 arch/arm/dts/k3-am62p-sk-binman.dtsi          | 11 ++-----
 arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi  | 12 ++------
 arch/arm/dts/k3-am69-sk-u-boot.dtsi           | 29 +++++++++++++------
 arch/arm/dts/k3-j7200-binman.dtsi             | 13 +++------
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   | 11 ++-----
 arch/arm/dts/k3-j721e-binman.dtsi             | 13 +++------
 arch/arm/dts/k3-j721s2-binman.dtsi            | 13 +++------
 arch/arm/dts/k3-j722s-binman.dtsi             | 12 ++------
 arch/arm/dts/k3-j742s2-evm-u-boot.dtsi        | 29 +++++++++++++------
 arch/arm/dts/k3-j784s4-binman.dtsi            |  8 ++---
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        | 29 +++++++++++++------
 17 files changed, 104 insertions(+), 155 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index a067b0ba354..01b6a8e417c 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -71,13 +71,6 @@
 #define AM625_BEAGLEPLAY_DTB "dts/upstream/src/arm64/ti/k3-am625-beagleplay.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-		};
-	};
-
 	tifsstub-gp {
 		filename = "tifsstub.bin_gp";
 		ti-secure-rom {
@@ -153,8 +146,8 @@
 					os = "DM";
 					load = <0x89000000>;
 					entry = <0x89000000>;
-					blob-ext {
-						filename = "ti-dm.bin";
+					ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 					};
 				};
 
diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 4a65427e877..9b536d679af 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -158,13 +158,6 @@
 #define AM625_PHYBOARD_LYRA_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-		};
-	};
-
 	tifsstub-hs {
 		filename = "tifsstub.bin_hs";
 		ti-secure-rom {
@@ -270,8 +263,8 @@
 						content = <&dm>;
 						keyfile = "custMpk.pem";
 					};
-					dm: blob-ext {
-						filename = "ti-dm.bin";
+					dm: ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 					};
 				};
 
@@ -418,8 +411,8 @@
 		fit {
 			images {
 				dm {
-					blob-ext {
-						filename = "ti-dm.bin";
+					ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 					};
 				};
 
diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 534eb14795b..cc619f5920e 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -156,14 +156,6 @@
 #define AM625_SK_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
-
 	tifsstub-hs {
 		filename = "tifsstub.bin_hs";
 		ti-secure-rom {
@@ -270,7 +262,8 @@
 						keyfile = "custMpk.pem";
 					};
 					dm: ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
@@ -397,7 +390,8 @@
 
 				dm {
 					ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 0e6188907e4..5a8788b227b 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -144,13 +144,6 @@
 #define VERDIN_AM62_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-		};
-	};
-
 	tifsstub-hs {
 		filename = "tifsstub.bin_hs";
 		ti-secure-rom {
@@ -257,7 +250,7 @@
 						keyfile = "custMpk.pem";
 					};
 					dm: ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 					};
 				};
 
@@ -380,7 +373,7 @@
 
 				dm {
 					ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 					};
 				};
 
diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index 325702ed6e0..1871926c207 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -164,14 +164,6 @@
 #define AM62A7_PHYBOARD_LYRA_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
-
 	tifsstub-hs {
 		filename = "tifsstub.bin_hs";
 		ti-secure-rom {
@@ -276,7 +268,8 @@
 						keyfile = "custMpk.pem";
 					};
 					dm: ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
@@ -462,7 +455,8 @@
 				};
 				dm {
 					ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index 2a8c260387b..ed973541fff 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -148,14 +148,6 @@
 #define AM62A7_SK_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
-
 	tifsstub-hs {
 		filename = "tifsstub.bin_hs";
 		ti-secure-rom {
@@ -260,7 +252,8 @@
 						keyfile = "custMpk.pem";
 					};
 					dm: ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
@@ -385,7 +378,8 @@
 				};
 				dm {
 					ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index 797644a7e0d..8216add3498 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -127,14 +127,6 @@
 #define AM62PX_SK_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-
-		blob-ext {
-			filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
 	tifsstub-hs {
 		filename = "tifsstub.bin_hs";
 		ti-secure-rom {
@@ -210,7 +202,8 @@
 					};
 
 					dm: ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
index 6c52038cdca..f1666f1ef76 100644
--- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
+++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
@@ -164,15 +164,6 @@
 #define BEAGLEY_AI_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-
-		blob-ext {
-			filename = "ti-dm/j722s/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
-
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
@@ -185,7 +176,8 @@
 					};
 
 					dm: ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/j722s/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
index 2f119508e18..fc686087023 100644
--- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
@@ -58,17 +58,18 @@
 #else // CONFIG_ARM64
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-
-		blob-ext {
-			filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
-
 	tispl {
 		insert-template = <&ti_spl>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+						filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
 	};
 
 	u-boot {
@@ -77,6 +78,16 @@
 
 	tispl-unsigned {
 		insert-template = <&ti_spl_unsigned>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+						filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
 	};
 
 	u-boot-unsigned {
diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
index 423badd7cb5..47a4cde6b85 100644
--- a/arch/arm/dts/k3-j7200-binman.dtsi
+++ b/arch/arm/dts/k3-j7200-binman.dtsi
@@ -237,13 +237,6 @@
 #define J7200_EVM_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/j7200/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
@@ -345,7 +338,8 @@
 						keyfile = "custMpk.pem";
 					};
 					dm: ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/j7200/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
@@ -430,7 +424,8 @@
 			images {
 				dm {
 					ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/j7200/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
index 8cefa39290d..6a773c1b3d1 100644
--- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
@@ -212,13 +212,6 @@
 #define J721E_BBAI64_DTB "dts/upstream/src/arm64/ti/k3-j721e-beagleboneai64.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-		};
-	};
-
 	ti-spl_unsigned {
 		filename = "tispl.bin_unsigned";
 		pad-byte = <0xff>;
@@ -263,8 +256,8 @@
 					os = "DM";
 					load = <0x89000000>;
 					entry = <0x89000000>;
-					blob-ext {
-						filename = "ti-dm.bin";
+					ti-dm {
+						filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
 					};
 				};
 
diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
index 0d607296f0e..6adfab164ee 100644
--- a/arch/arm/dts/k3-j721e-binman.dtsi
+++ b/arch/arm/dts/k3-j721e-binman.dtsi
@@ -333,13 +333,6 @@
 #define J721E_EVM_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
@@ -467,7 +460,8 @@
 						keyfile = "custMpk.pem";
 					};
 					dm: ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
@@ -551,7 +545,8 @@
 			images {
 				dm {
 					ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index d121d8c0c54..73af184d27e 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -145,13 +145,6 @@
 #define J721S2_EVM_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-		blob-ext {
-			filename = "ti-dm/j721s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
@@ -286,7 +279,8 @@
 						keyfile = "custMpk.pem";
 					};
 					dm: ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/j721s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
@@ -371,7 +365,8 @@
 			images {
 				dm {
 					ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/j721s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
index 6b521166575..8f1471371e5 100644
--- a/arch/arm/dts/k3-j722s-binman.dtsi
+++ b/arch/arm/dts/k3-j722s-binman.dtsi
@@ -116,15 +116,6 @@
 #define J722S_EVM_DTB "u-boot.dtb"
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-
-		blob-ext {
-			filename = "ti-dm/j722s/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
-
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
@@ -137,7 +128,8 @@
 					};
 
 					dm: ti-dm {
-						filename = "ti-dm.bin";
+						filename = "ti-dm/j722s/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-j742s2-evm-u-boot.dtsi b/arch/arm/dts/k3-j742s2-evm-u-boot.dtsi
index ede5d6e58f5..b1d79a3f64a 100644
--- a/arch/arm/dts/k3-j742s2-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j742s2-evm-u-boot.dtsi
@@ -43,17 +43,18 @@
 #else // CONFIG_ARM64
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-
-		blob-ext {
-			filename = "ti-dm/j742s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
-
 	tispl {
 		insert-template = <&ti_spl>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+						filename = "ti-dm/j742s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
 	};
 
 	u-boot {
@@ -62,6 +63,16 @@
 
 	tispl-unsigned {
 		insert-template = <&ti_spl_unsigned>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+						filename = "ti-dm/j742s2/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
 	};
 
 	u-boot-unsigned {
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 0553825b383..cb1fbc65923 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -165,8 +165,8 @@
 						keyfile = "custMpk.pem";
 					};
 
-					dm: blob-ext {
-						filename = "ti-dm.bin";
+					dm: ti-dm {
+						optional;
 					};
 				};
 
@@ -254,8 +254,8 @@
 		fit {
 			images {
 				dm {
-					blob-ext {
-						filename = "ti-dm.bin";
+					ti-dm {
+						optional;
 					};
 				};
 
diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
index 8a60d7c6107..cc0b562d27e 100644
--- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
@@ -52,17 +52,18 @@
 #else // CONFIG_ARM64
 
 &binman {
-	ti-dm {
-		filename = "ti-dm.bin";
-
-		blob-ext {
-			filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-			optional;
-		};
-	};
-
 	tispl {
 		insert-template = <&ti_spl>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+						filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
 	};
 
 	u-boot {
@@ -71,6 +72,16 @@
 
 	tispl-unsigned {
 		insert-template = <&ti_spl_unsigned>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+						filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
 	};
 
 	u-boot-unsigned {
-- 
2.39.2

