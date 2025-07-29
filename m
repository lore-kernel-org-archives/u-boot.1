Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6C1C87FCA
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 18:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E3282F00;
	Tue, 29 Jul 2025 20:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z17yALPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4983D82B07; Tue, 29 Jul 2025 20:37:08 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89DD82B20
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 20:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56TIb1if2581544;
 Tue, 29 Jul 2025 13:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753814221;
 bh=JZHNtDUi2YnYS4sHSYSe5PRh20u8C9ls1wrXmCiozRc=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=Z17yALPm+Sw9CmaSLM1pEgF5FtIsZ/eqE5zgd/zCFsnwMR+OktAr+GPqi34z5YQnK
 nzZKHann8s/43IfS/YhKi4b+A8LXAboHD6VXq3rvJy/dxRR6TUgj47Ti746W3K4zw4
 r8j7cX49XN7GpSVWUXxJeEXvIxiGuCXFm9ttecSs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56TIb12Y1313190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 29 Jul 2025 13:37:01 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 29
 Jul 2025 13:37:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 29 Jul 2025 13:37:01 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56TIb1Ur4172149;
 Tue, 29 Jul 2025 13:37:01 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 29 Jul 2025 13:36:56 -0500
Subject: [PATCH 1/2] arm: dts: k3-am62a-sk: remove GP tiboot3 builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250729-no-62a-gp-v1-1-1dbdb4469ad3@ti.com>
References: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
In-Reply-To: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
To: Tom Rini <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>,
 Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6136; i=bb@ti.com;
 h=from:subject:message-id; bh=RrGlYOk3WuoUFFiCSqFhRPeo1DhCEiHgxDJXyAJSGSQ=;
 b=owNCWmg5MUFZJlNZGYM4RwAAZv//////3uc+3uCMtb8BWP+SePu/e5+Ze9/fyN/q7xPT29awA
 Rsssg0aDIaBpoNMmho0GmmQMAjIBoGmmR6mmTJpkDTTJkwgaBk0NGmgMh6mmjTRsppiGjTQ0aAa
 DENNNGjEA0wg0aGjIYho0ek0BoYmJiaaZqZqGgA0aaaZqHqNGmgZMmhih6mjTTI8o00ANGQ0ZGm
 hiZNAPUMQZNMgeoBoaA0aAaAaBtT1A0aAaAPSYJ6BBEGEqmyMxoxYMyIjPhDZIo7B89ab5pRLCA
 KCU/iALEP85qc/v+8JQBtpKqSOQikQUIkLSip3yK0Ij4vfsnoEavz+wdNRdPUZn3sVsQnUpyWKf
 WyDgnT0bICxk6KFqomqCFwgiSPO9uV5AaAffQN3MDj2qP3Rh87vvLvE7VCAq6wYjZXytE6aXcIj
 pg+zR2wzP1fEusu/jppKwUizjds74c/V5kxFXXz+OPa2ioDn8kTjzJQUQQX4T8kD31WUxmGROm3
 9487oyLxzEr9ZAV1t8MbFF2vCAizFJIl9t2FH9n0CC81eOPkfdg290wKUsH5xIoYM/lg3/xDVzP
 EGBCNSMbd+tERVixEsAf+Z4ky/H8FIUWBexgMDtrTgw4lvoQtkEvwGu9uUQkQoIR4M8XgtShdbD
 5cTkCwqE20Ff0mT7Bhf4u5IpwoSAzBnCOA=
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

The AM62Ax SoC family was the last part from TI to support the GP
security variant, however this security variant was used mostly
internally and with select early partners and never sold publicly.

To simplify things and to avoid any confusion of which parts are
supported in the future, remove the GP tiboot3.bin builds from binman.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am62a-sk-binman.dtsi | 181 +----------------------------------
 doc/board/ti/am62ax_sk.rst           |   7 +-
 2 files changed, 2 insertions(+), 186 deletions(-)

diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index 0685bdd7e0c78087777e12cfa3d936c63f2fa597..e64c165ecbf1cd82586b850549776ad189b104dc 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -98,43 +98,6 @@
 	};
 };
 
-&binman {
-	tiboot3-am62ax-gp-evm.bin {
-		filename = "tiboot3-am62ax-gp-evm.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62ax-gp.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
-	};
-};
-
 #endif
 
 #ifdef CONFIG_TARGET_AM62A7_A53_EVM
@@ -181,23 +144,6 @@
 
 	};
 
-	tifsstub-gp {
-		filename = "tifsstub.bin_gp";
-		ti-secure-rom {
-			content = <&tifsstub_gp>;
-			core = "secure";
-			load = <0x60000>;
-			sw-rev = <CONFIG_K3_X509_SWRV>;
-			keyfile = "ti-degenerate-key.pem";
-			tifsstub;
-		};
-		tifsstub_gp: tifsstub-gp.bin {
-			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-gp.bin";
-			type = "blob-ext";
-			optional;
-		};
-	};
-
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
@@ -229,18 +175,6 @@
 					};
 				};
 
-				tifsstub-gp {
-					description = "TIFSSTUB";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9ca00000>;
-					entry = <0x9ca00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -275,7 +209,7 @@
 					description = "k3-am62a7-sk";
 					firmware = "atf";
 					loadables = "tee", "dm", "spl",
-					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
+					"tifsstub-hs", "tifsstub-fs";
 					fdt = "fdt-0";
 				};
 			};
@@ -326,117 +260,4 @@
 	};
 };
 
-&binman {
-	ti-spl_unsigned {
-		insert-template = <&ti_spl_unsigned_template>;
-
-		fit {
-			images {
-				tifsstub-hs {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-hs";
-					load = <0x9ca00000>;
-					entry = <0x9ca00000>;
-					blob-ext {
-						filename = "tifsstub.bin_hs";
-					};
-				};
-
-				tifsstub-fs {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-fs";
-					load = <0x9ca00000>;
-					entry = <0x9ca00000>;
-					blob-ext {
-						filename = "tifsstub.bin_fs";
-					};
-				};
-
-				tifsstub-gp {
-					description = "tifsstub";
-					type = "firmware";
-					arch = "arm32";
-					compression = "none";
-					os = "tifsstub-gp";
-					load = <0x9ca00000>;
-					entry = <0x9ca00000>;
-					blob-ext {
-						filename = "tifsstub.bin_gp";
-					};
-				};
-				dm {
-					ti-dm {
-						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
-					};
-				};
-
-				fdt-0 {
-					description = "k3-am62a7-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = SPL_AM62A7_SK_DTB;
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am62a7-sk";
-					firmware = "atf";
-					loadables = "tee", "dm", "spl",
-					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
-					fdt = "fdt-0";
-				};
-			};
-		};
-	};
-};
-
-&binman {
-	u-boot_unsigned {
-		insert-template = <&u_boot_unsigned_template>;
-
-		fit {
-			images {
-				uboot {
-					description = "U-Boot for AM62Ax Board";
-				};
-
-				fdt-0 {
-					description = "k3-am62a7-sk";
-					type = "flat_dt";
-					arch = "arm";
-					compression = "none";
-					blob {
-						filename = AM62A7_SK_DTB;
-					};
-					hash {
-						algo = "crc32";
-					};
-				};
-			};
-
-			configurations {
-				default = "conf-0";
-
-				conf-0 {
-					description = "k3-am62a7-sk";
-					firmware = "uboot";
-					loadables = "uboot";
-					fdt = "fdt-0";
-				};
-			};
-		};
-	};
-};
 #endif
diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 43a1db688738d5c08dacdb698f4ac78d919c23ed..4dd998bcce95068f5d1b260a088fdeb8c3422f41 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -121,12 +121,7 @@ Set the variables corresponding to this platform:
 Target Images
 --------------
 In order to boot we need tiboot3.bin, tispl.bin and u-boot.img.  Each SoC
-variant (GP, HS-FS, HS-SE) requires a different source for these files.
-
- - GP
-
-        * tiboot3-am62ax-gp-evm.bin from step 3.1
-        * tispl.bin_unsigned, u-boot.img_unsigned from step 3.2
+variant (HS-FS, HS-SE) requires a different source for these files.
 
  - HS-FS
 

-- 
2.50.1

