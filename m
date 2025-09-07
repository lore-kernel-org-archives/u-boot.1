Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF535CA101F
	for <u-boot@archiver.kernel.org>; Sun,  7 Sep 2025 14:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3102B83071;
	Sun,  7 Sep 2025 16:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="J7lyPI0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F680800D7; Sun,  7 Sep 2025 16:36:40 +0200 (CEST)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B38803F5
 for <u-boot@lists.denx.de>; Sun,  7 Sep 2025 16:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1757255797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aO/4qhGJzdoAXsCp9ZqhkLhcAhm0otftZecHCY5Yh5U=;
 b=J7lyPI0xCtZwTlSPWEILezAv5GE+J0gR0TERt+vY+H9mvPn6KXxMV1/w8XooDR5Q0a5fhE
 WXdeinpzdZMbnwOhsaS1jxlEbsO18hPVqJJoc98sIw8LtOAHwvLDXyv+UX/QxeiQ5FFOCY
 8irZ4duJUG/HklznAvTTNVS/ntbAIDPpssQnfcTlt2/RP81HLOAydKaCUVK4mu/kAlsbA4
 RQkE3auRiwm9WEPHN2zk+0GwsuiNAmXHGrqpbnV26nMhE5rbW20142ns4ysKVffxCVTnDp
 cjI8tGt+MDR2VFREfCBArYYW8wAHZRSWF+f7FvrO0aIc57oyyH0WyZN+YqaVqQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Sun, 07 Sep 2025 14:36:13 +0000
Subject: [PATCH RFC 7/9] arm: dts: meson-gx-u-boot: add binman
 configuration for U-Boot SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250907-spl-gx-v1-7-37395d9ff5af@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3917;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=OxHHpbPRncLsPCSepT0IZn0Jw8TkSmS5DI70LN65klE=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBovZhrNfRRZKTF18K8/HUJ9FgAfc8WUYecfjUWP
 qdZtTS4pxqJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaL2YawAKCRCEr8vQ14ma
 A9ToD/wO0OzKxN+3rvQid67gRFh/i7Ncwqngo8W/dba6v1HZLvSGeQcGVep2rVYQoJO8D7rhKJC
 Y8pBzszd2dYXSXAbYSLNw9+1PdveRAj33fGY6MRgrssp4JHhy5ggbjrc69e9OizPjW2O/tFRWWl
 ZnXT0LfWwoE/dIriew0jyo140dmEbbwzJxHV5v1uMRSC5Tl1A7hGxC8u9dd6+1ARwfsCgFRG5O6
 ww29q1qYltjwh6ndSP+gw7ouwyXdPcwSRU96ZDmseZMEcbrF+xfytZSwDncc3n96jNiZC1agBtw
 6H/Slo9ITvCRwuawV6SYhS1PnaWdcnwtsOP52FWRXei1J0dTXz9xQc809YzroLBM327iNVCfnuL
 yVKTuutW2nREQ+xvkc9jHaBfyKZPBeQnDQvAA9IzuNMQ8S3tF0c2z60g5sMd3mwagvFASwaOVRs
 rl/vD/83fYDxAXYz5CZXG24DrBwugywFfcWoO9MCkDHjB3JmNY7S3zVV7oDM+py1Rv1zH1OHQ2l
 6M4+bbVptsyAfZzl5/KW+rj5HZ8KV8RhGHLg77HS5UUbk12pyaV/uX03/A/uQzUOLW+ImZ+KEJj
 Sdwz5Iqda7dZmFWWTi9IxM6lzuZauwZPKA/FZiqdygk2zLt6yOPmgbsCD2P1/AC7xJve4ttiHRR
 Yy6HPwvdJVkG6ow==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Add binman configuration to meson-gx-u-boot.dtsi to automate building
bootable images using amlimage.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/dts/meson-gx-u-boot.dtsi | 142 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-boot.dtsi
index 9e0620f395e81048273690af4cee4b196ee7b0a7..d05f869c06ebefa08f5480327e4a72bbaa9a5e94 100644
--- a/arch/arm/dts/meson-gx-u-boot.dtsi
+++ b/arch/arm/dts/meson-gx-u-boot.dtsi
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2019 BayLibre, SAS.
  * Author: Maxime Jourdan <mjourdan@baylibre.com>
+ * Copyright (c) 2023 Ferass El Hafidi <funderscore@postmarketos.org>
  */
 
 / {
@@ -15,6 +16,16 @@
 	soc {
 		bootph-all;
 	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+#if defined(CONFIG_BINMAN)
+	binman: binman {
+		multiple-images;
+	};
+#endif
 };
 
 &vpu {
@@ -30,3 +41,134 @@
 	      <0x0 0xc883c000 0x0 0x1000>;
 	reg-names = "hdmitx", "hhi";
 };
+
+#if defined(CONFIG_MESON_GX) && defined(CONFIG_BINMAN)
+/* binman configuration on GXBB and GXL */
+
+#if defined(CONFIG_MESON_GXBB)
+#define BL31_ADDR 0x10100000
+#else /* GXL */
+#define BL31_ADDR 0x05100000
+#endif
+
+/*
+ * On GXBB the base address of the SCP firmware doesn't matter as SPL will
+ * send the firmware to the SCP anyway, and can get the base address from the
+ * FIT. On GXL it matters, as BL31 is supposed to send the firmware, so set the
+ * base address to what GXL BL2 would load the binary to.
+ */
+#define  SCP_ADDR 0x13c0000
+
+&binman {
+	u-boot-amlogic {
+		filename = "u-boot-meson-with-spl.bin";
+		pad-byte = <0xff>;
+
+		mkimage {
+			filename = "spl/u-boot-spl-signed.bin";
+#if defined(CONFIG_MESON_GXBB)
+			args = "-n", "gxbb", "-T", "amlimage";
+#elif defined(CONFIG_MESON_GXL)
+			args = "-n", "gxl", "-T", "amlimage";
+#endif
+
+			blob {
+				size = <0xb000>; /* The BootROM loads 48K max (header is 4K) */
+				filename = "spl/u-boot-spl.bin";
+			};
+		};
+
+		fit: fit {
+			description = "ATF and U-Boot images";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+			fit,align = <512>;
+			offset = <CONFIG_SPL_PAD_TO>;
+
+			images {
+				u-boot {
+					description = "U-Boot";
+					type = "standalone";
+					os = "u-boot";
+					arch = "arm64";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+					entry = <CONFIG_TEXT_BASE>;
+
+					u-boot-nodtb {
+					};
+				};
+
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					os = "arm-trusted-firmware";
+					arch = "arm64";
+					compression = "none";
+					load = <BL31_ADDR>;
+					entry = <BL31_ADDR>;
+
+					atf-bl31 {
+						filename = "bl31.bin";
+					};
+					hash {
+						algo = "sha256";
+					};
+				};
+
+				scp {
+					description = "SCP firmware";
+					type = "scp";
+					arch = "arm"; /* The Cortex-M core is used as SCP */
+					compression = "none";
+					load = <SCP_ADDR>;
+
+					scp {
+						filename = "scp.bin";
+					};
+					hash {
+						/*
+						 * The hash is used by the SCP and passed to it
+						 * by U-Boot SPL.
+						 */
+						algo = "sha256";
+					};
+				};
+
+				@fdt-SEQ {
+					description = "NAME";
+					type = "flat_dt";
+					compression = "none";
+				};
+
+			};
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "NAME.dtb";
+					fdt = "fdt-SEQ";
+					firmware = "atf";
+					loadables = "scp", "u-boot";
+				};
+			};
+		};
+	};
+};
+
+&vpu {
+	/delete-property/ bootph-all;
+};
+
+&apb {
+	bootph-all;
+};
+
+&sd_emmc_b {
+	bootph-all;
+};
+
+&sd_emmc_c {
+	bootph-all;
+};
+#endif

-- 
2.51.0

