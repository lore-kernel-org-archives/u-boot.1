Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DF0CCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF7E82C7F;
	Mon, 27 Oct 2025 14:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l3K64RUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7336C836EE; Mon, 27 Oct 2025 14:00:13 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D4A580107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RD09XJ1283647;
 Mon, 27 Oct 2025 08:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761570009;
 bh=LAYvLmYDfqyBIDxRH9VCDBiFlfGCKRfrjHnKtcu+ufU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=l3K64RUzRJd9siRnpiJkZyUlX4vWMuWNfXO4HAv63FYKk25/0ov01w0pAEhwiu/xT
 IpPZjPRJumhO2RX9bStuPhXtH9aVN3/9c0PQln6xHI4VIwfyaZu0cY1mkhRwHSHBtq
 NO+q0xCiwqXW/8Vo9OE7OIboOpOavFcW6a75Nb3k=
Received: from DFLE205.ent.ti.com (dfle205.ent.ti.com [10.64.6.63])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RD09nM1399718
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 08:00:09 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 08:00:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 08:00:08 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RD07nW696547;
 Mon, 27 Oct 2025 08:00:08 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v8 1/8] arch: arm: k3-binman: add fit for falcon boot
Date: Mon, 27 Oct 2025 18:29:56 +0530
Message-ID: <20251027130004.2156121-2-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027130004.2156121-1-anshuld@ti.com>
References: <20251027130004.2156121-1-anshuld@ti.com>
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

This patch adds creation of tifalcon.bin for the AM62a, 62p and 62x.

The contents are the same as the existing tispl.bin but A53's SPL and
the FDT have been removed as they are not needed in falcon boot.

This reduces boot time since the payload size is smaller compared to the
regular tispl binary.

tispl.bin    = TFA + TEE + TIFS-STUB + A53 SPL + FDT
tifalcon.bin = TFA + TEE + TIFS-STUB

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 64 ++++++++++++++++++++++++++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi | 51 ++++++++++++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 51 ++++++++++++++++++++++
 arch/arm/dts/k3-binman.dtsi          | 54 +++++++++++++++++++++++
 4 files changed, 220 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index f743c4353b4..42edb35fa7b 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -206,6 +206,70 @@
 		};
 	};
 
+	ti-falcon {
+		insert-template = <&ti_falcon_template>;
+
+		fit {
+			images {
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
+				dm {
+					ti-secure {
+						content = <&dm_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					dm_falcon: ti-dm {
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+				conf-0 {
+					description = "k3-am625-sk-falcon";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
+					"tifsstub-gp", "dm";
+				};
+			};
+		};
+	};
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index e3a2d155d51..cb9a56b8c37 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -144,6 +144,57 @@
 
 	};
 
+	ti-falcon {
+		insert-template = <&ti_falcon_template>;
+
+		fit {
+			images {
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
+				dm {
+					ti-secure {
+						content = <&dm_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					dm_falcon: ti-dm {
+						filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+				conf-0 {
+					description = "k3-am62a7-sk-falcon";
+					firmware = "atf";
+					loadables = "tee", "dm", "tifsstub-hs", "tifsstub-fs";
+				};
+			};
+		};
+	};
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index feb59edcd83..e1443d6226b 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -161,6 +161,57 @@
 
 	};
 
+	ti-falcon {
+		insert-template = <&ti_falcon_template>;
+
+		fit {
+			images {
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
+				dm {
+					ti-secure {
+						content = <&dm_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					dm_falcon: ti-dm {
+						filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+				conf-0 {
+					description = "k3-am62p5-sk-falcon";
+					firmware = "atf";
+					loadables = "tee", "dm", "tifsstub-hs", "tifsstub-fs";
+				};
+			};
+		};
+	};
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 5163161b94d..761b1730464 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -489,6 +489,60 @@
 		end_address = <0x0 0x9fffffff>;
 	};
 
+	ti_falcon_template: template-9 {
+		filename = "tifalcon.bin";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration for falcon boot";
+			#address-cells = <1>;
+
+			images {
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					os = "arm-trusted-firmware";
+					load = <CONFIG_K3_ATF_LOAD_ADDR>;
+					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
+					ti-secure {
+						content = <&atf_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					atf_falcon: atf-bl31 {
+					};
+				};
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					ti-secure {
+						content = <&tee_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					tee_falcon: tee-os {
+						optional;
+					};
+				};
+				dm {
+					description = "DM binary";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "DM";
+					load = <0x89000000>;
+					entry = <0x89000000>;
+				};
+
+			};
+		};
+	};
+
 };
 
 #endif
-- 
2.51.0

