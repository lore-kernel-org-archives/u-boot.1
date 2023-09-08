Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B35EE8006
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6140A86B37;
	Fri,  8 Sep 2023 16:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a0x13XdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9925886A2A; Fri,  8 Sep 2023 13:07:48 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3A4B86410
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 13:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388B7c8a094999;
 Fri, 8 Sep 2023 06:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694171258;
 bh=R8gEDRv3gEtlZ9ksK4hydNVb70ShkidwUoHpBehVmvM=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=a0x13XdGR+fEdRPKzMyPu4MfqM4A2OSv5xh5nchDsL30xiHtRscF7nb8Ljin9hnqJ
 Fb+My79+Q+m5KORUw9WjhJOUetZn3s3/wL7FZEDSvhv2EvUfozQ5pBx+mhuCoV1BxS
 hNXrRtyy/GEmuNX4VEsK3mDLoQhXo4+vFy+kq3yk=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388B7c66000628
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 06:07:38 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 06:07:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 06:07:36 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388B5qER018063;
 Fri, 8 Sep 2023 06:07:30 -0500
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jason
 Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v3 14/16] arm: dts: k3-j784s4-binman: Add support for AM69 SK
Date: Fri, 8 Sep 2023 16:35:49 +0530
Message-ID: <20230908110551.861575-15-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908110551.861575-1-a-nandan@ti.com>
References: <20230908110551.861575-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 08 Sep 2023 16:01:41 +0200
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

From: Dasnavis Sabiya <sabiya.d@ti.com>

The J784S4/AM69 has 2 platforms naming J784S4-EVM and AM69-SK.
Add binman support to build HS anad GP boot binaries for AM69 SK
platform

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm/dts/k3-j784s4-binman.dtsi | 92 ++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index b5d2f4bab6..5c30333a10 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -163,9 +163,11 @@
 
 #define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
 #define SPL_J784S4_EVM_DTB "spl/dts/k3-j784s4-evm.dtb"
+#define SPL_AM69_SK_DTB "spl/dts/k3-am69-sk.dtb"
 
 #define UBOOT_NODTB "u-boot-nodtb.bin"
 #define J784S4_EVM_DTB "u-boot.dtb"
+#define AM69_SK_DTB "arch/arm/dts/k3-am69-sk.dtb"
 
 &binman {
 	ti-dm {
@@ -272,6 +274,22 @@
 						filename = SPL_J784S4_EVM_DTB;
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am69-sk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					ti-secure {
+						content = <&spl_am69_sk_dtb>;
+						keyfile = "custMpk.pem";
+					};
+
+					spl_am69_sk_dtb: blob-ext {
+						filename = SPL_AM69_SK_DTB;
+					};
+				};
 			};
 
 			configurations {
@@ -283,6 +301,13 @@
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am69-sk";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl";
+					fdt = "fdt-1";
+				};
 			};
 		};
 	};
@@ -338,6 +363,26 @@
 						algo = "crc32";
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am69-sk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					ti-secure {
+						content = <&am69_sk_dtb>;
+						keyfile = "custMpk.pem";
+					};
+
+					am69_sk_dtb: blob-ext {
+						filename = AM69_SK_DTB;
+					};
+
+					hash {
+						algo = "crc32";
+					};
+				};
 			};
 
 			configurations {
@@ -349,6 +394,13 @@
 					loadables = "uboot";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am69-sk";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-1";
+				};
 			};
 		};
 	};
@@ -431,6 +483,17 @@
 						filename = SPL_J784S4_EVM_DTB;
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am69-sk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					blob {
+						filename = SPL_AM69_SK_DTB;
+					};
+				};
 			};
 
 			configurations {
@@ -442,6 +505,13 @@
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am69-sk";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl";
+					fdt = "fdt-1";
+				};
 			};
 		};
 	};
@@ -487,6 +557,21 @@
 						algo = "crc32";
 					};
 				};
+
+				fdt-1 {
+					description = "k3-am69-sk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					blob {
+						filename = AM69_SK_DTB;
+					};
+
+					hash {
+						algo = "crc32";
+					};
+				};
 			};
 
 			configurations {
@@ -498,6 +583,13 @@
 					loadables = "uboot";
 					fdt = "fdt-0";
 				};
+
+				conf-1 {
+					description = "k3-am69-sk";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-1";
+				};
 			};
 		};
 	};
-- 
2.34.1

