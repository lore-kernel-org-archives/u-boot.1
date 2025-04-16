Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBACC369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 119AB82D6B;
	Wed, 16 Apr 2025 09:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vekwHCYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F14182D05; Wed, 16 Apr 2025 09:46:40 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA23182CF6
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7kZRl2600403
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 02:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744789595;
 bh=Lh4vzvbEtnpLtVyDD2g4XHrSdF16FFpfXrzYzi6uA5A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vekwHCYn1BLzPL8SyOH3VDzQV5lsyxwVOIf4PoAqoTJ6bbwgzqlv9tspXoM6Yjp+C
 iSgRUWZ/ZkYeUytWJZenWgccHI4w4rjjQpB/rHLD6rp3k+OnxB/VCxkmrgev3iNoGa
 Di4AKQYmFakpJMTm3PgqkWD8sdCPZ+8AFFuJBnc4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7kZ8k130329
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 02:46:35 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 02:46:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 02:46:35 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G7kYqr069829;
 Wed, 16 Apr 2025 02:46:34 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v4 3/8] arch: arm: k3-binman: add fit for falcon boot
Date: Wed, 16 Apr 2025 13:15:09 +0530
Message-ID: <20250416074515.1452854-4-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416074515.1452854-1-anshuld@ti.com>
References: <20250416074515.1452854-1-anshuld@ti.com>
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

This adds creation of tispl_falcon.bin for the am62a, 62p and 62x.

The contents are the same as the existing tispl.bin but A53's spl and
the fdt have been removed as they are not needed in falcon boot.

This reduces boot time since the payload size is smaller and we also
aren't authenticating the spl and fdt in secure boot.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 64 ++++++++++++++++++++++++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi | 64 ++++++++++++++++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 51 ++++++++++++++++++++
 arch/arm/dts/k3-binman.dtsi          | 69 ++++++++++++++++++++++++++++
 4 files changed, 248 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index bb5ad83b168..1bc551ea135 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -219,6 +219,70 @@
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
+						filename = "ti-dm.bin";
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
+					"tifsstub-gp", "dm", "jump-stub";
+				};
+			};
+		};
+	};
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index 09b93ce96a9..9885d5298de 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -211,6 +211,70 @@
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
+				tifsstub-gp {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
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
+						filename = "ti-dm.bin";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+				conf-0 {
+					description = "k3-am62a7-sk-falcon";
+					firmware = "atf";
+					loadables = "tee", "dm", "tifsstub-hs", "tifsstub-fs",
+					"tifsstub-gp", "jump-stub";
+				};
+			};
+		};
+	};
+
 	ti-spl {
 		insert-template = <&ti_spl_template>;
 
diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index 66bcef55653..26306e75b10 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -173,6 +173,57 @@
 
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
+						filename = "ti-dm.bin";
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
index 5d971ecf886..50dbee72708 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -520,6 +520,75 @@
 		end_address = <0x0 0x9fffffff>;
 	};
 
+	ti_falcon_template: template-9 {
+		filename = "tispl_falcon.bin";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration without SPL and FDT";
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
+				jump-stub {
+					description = "Jump stub for backwards compatibility with older ATF builds";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					load = <LEGACY_ATF_PRELOADED_BL33_BASE>;
+					entry = <LEGACY_ATF_PRELOADED_BL33_BASE>;
+					ti-secure {
+						content = <&jump_stub_falcon>;
+						keyfile = "custMpk.pem";
+					};
+					jump_stub_falcon: blob-ext {
+						filename = "jump_stub.bin";
+					};
+				};
+
+			};
+		};
+	};
+
 };
 
 #endif
-- 
2.49.0

