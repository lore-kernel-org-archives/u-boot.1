Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC8DC07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 10:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4176786FB2;
	Wed, 15 Nov 2023 11:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PBTX+XhU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29BD486F18; Wed, 15 Nov 2023 11:10:38 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F349686DB8
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 11:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AFAAV6i104326;
 Wed, 15 Nov 2023 04:10:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700043031;
 bh=0PLvX9MTX17kRQ/HxKB4vJu3VUrPGSAskTHZRk06mMI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PBTX+XhUywYqi5cSyajBZJbkCvXZs/Aju/1DAYou77wXqgzB9lO92wmolj9T489Zw
 8IjxrcTmiNgEGJ06z7pxDnJYUYZl17VRN0QyZqc4mZyF8Z0dKzUAC3W1T6alzfEJ/7
 pHQc8iiBnxyOzqrLxiwSbUFjyTIjIUJpf1zyRgfo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AFAAVow112986
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Nov 2023 04:10:31 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 04:10:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 04:10:31 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AFAAOSW027039;
 Wed, 15 Nov 2023 04:10:28 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <sjg@chromium.org>, <marcel.ziswiler@toradex.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <kamlesh@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <mkorpershoek@baylibre.com>, <n-francis@ti.com>
Subject: [PATCH 1/2] arm: dts: k3-binman: Add support for FIT templates
Date: Wed, 15 Nov 2023 15:40:23 +0530
Message-ID: <20231115101024.3441093-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115101024.3441093-1-n-francis@ti.com>
References: <20231115101024.3441093-1-n-francis@ti.com>
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

Add templates for FIT images used extensively across K3 boards with most
of the code common. This includes the FIT portions of:
	- tispl.bin
	- u-boot.img
	- sysfw.itb (in case of legacy boot flow)

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-binman.dtsi | 327 ++++++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 2ea2dd18a1..677a017403 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -113,4 +113,331 @@
 	};
 };
 
+&binman {
+	itb_template: template-5 {
+		fit {
+			description = "SYSFW and Config fragments";
+			#address-cells = <1>;
+			images {
+				sysfw.bin {
+					description = "sysfw";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					blob-ext {
+					    filename = "sysfw.bin";
+					};
+				};
+				board-cfg.bin {
+					description = "board-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&board_cfg>;
+						keyfile = "custMpk.pem";
+					};
+					board_cfg: board-cfg {
+						filename = "board-cfg.bin";
+						type = "blob-ext";
+					};
+
+				};
+				pm-cfg.bin {
+					description = "pm-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&pm_cfg>;
+						keyfile = "custMpk.pem";
+					};
+					pm_cfg: pm-cfg {
+						filename = "pm-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+				rm-cfg.bin {
+					description = "rm-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&rm_cfg>;
+						keyfile = "custMpk.pem";
+					};
+					rm_cfg: rm-cfg {
+						filename = "rm-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+				sec-cfg.bin {
+					description = "sec-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&sec_cfg>;
+						keyfile = "custMpk.pem";
+					};
+					sec_cfg: sec-cfg {
+						filename = "sec-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+			};
+		};
+	};
+
+	itb_unsigned_template: template-6 {
+		fit {
+			description = "SYSFW and Config fragments";
+			#address-cells = <1>;
+			images {
+				sysfw.bin {
+					description = "sysfw";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					blob-ext {
+					    filename = "sysfw.bin_fs";
+					};
+				};
+				board-cfg.bin {
+					description = "board-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					board-cfg {
+						filename = "board-cfg.bin";
+						type = "blob-ext";
+					};
+
+				};
+				pm-cfg.bin {
+					description = "pm-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					pm-cfg {
+						filename = "pm-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+				rm-cfg.bin {
+					description = "rm-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					rm-cfg {
+						filename = "rm-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+				sec-cfg.bin {
+					description = "sec-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					sec-cfg {
+						filename = "sec-cfg.bin";
+						type = "blob-ext";
+					};
+				};
+			};
+		};
+	};
+};
+
+#else
+
+&binman {
+	ti_spl_template: template-1 {
+		filename = "tispl.bin";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration to load ATF and SPL";
+			#address-cells = <1>;
+
+			images {
+
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					os = "arm-trusted-firmware";
+					load = <CONFIG_K3_ATF_LOAD_ADDR>;
+					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
+					ti-secure {
+						content = <&atf>;
+						keyfile = "custMpk.pem";
+					};
+					atf: atf-bl31 {
+					};
+				};
+
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <0x9e800000>;
+					entry = <0x9e800000>;
+					ti-secure {
+						content = <&tee>;
+						keyfile = "custMpk.pem";
+					};
+					tee: tee-os {
+					};
+				};
+
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
+				spl {
+					description = "SPL (64-bit)";
+					type = "standalone";
+					os = "U-Boot";
+					arch = "arm64";
+					compression = "none";
+					load = <CONFIG_SPL_TEXT_BASE>;
+					entry = <CONFIG_SPL_TEXT_BASE>;
+					ti-secure {
+						content = <&u_boot_spl_nodtb>;
+						keyfile = "custMpk.pem";
+
+					};
+					u_boot_spl_nodtb: blob-ext {
+						filename = "spl/u-boot-spl-nodtb.bin";
+					};
+				};
+
+			};
+		};
+	};
+	ti_spl_unsigned_template: template-2 {
+		filename = "tispl.bin_unsigned";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration to load ATF and SPL";
+			#address-cells = <1>;
+
+			images {
+
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					os = "arm-trusted-firmware";
+					load = <CONFIG_K3_ATF_LOAD_ADDR>;
+					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
+					atf-bl31 {
+						filename = "bl31.bin";
+					};
+				};
+
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <0x9e800000>;
+					entry = <0x9e800000>;
+					tee-os {
+						filename = "tee-raw.bin";
+					};
+				};
+
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
+				spl {
+					description = "SPL (64-bit)";
+					type = "standalone";
+					os = "U-Boot";
+					arch = "arm64";
+					compression = "none";
+					load = <CONFIG_SPL_TEXT_BASE>;
+					entry = <CONFIG_SPL_TEXT_BASE>;
+					blob-ext {
+						filename = "spl/u-boot-spl-nodtb.bin";
+					};
+				};
+			};
+		};
+	};
+	u_boot_template: template-3 {
+		filename = "u-boot.img";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "FIT image with multiple configurations";
+
+			images {
+				uboot {
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+					ti-secure {
+						content = <&u_boot_nodtb>;
+						keyfile = "custMpk.pem";
+					};
+					u_boot_nodtb: u-boot-nodtb {
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+		};
+	};
+	u_boot_unsigned_template: template-4 {
+		filename = "u-boot.img_unsigned";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "FIT image with multiple configurations";
+
+			images {
+				uboot {
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+					blob {
+						filename = "u-boot-nodtb.bin";
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+		};
+	};
+
+};
+
 #endif
-- 
2.34.1

