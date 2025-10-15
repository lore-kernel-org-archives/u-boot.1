Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7871CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 16:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F09983710;
	Wed, 15 Oct 2025 18:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="oZUQl/VT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4904583710; Wed, 15 Oct 2025 18:26:19 +0200 (CEST)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD9983692
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 18:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1760545576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+uHqac9wEul3LhTgGJ2vWqNvcj+yB8zp18RXMLwONU=;
 b=oZUQl/VTUrrApOwuN+QUoWtdAcoR/Qxu72fhEhIec0jj1iONZp6YP+Wp+Bu6NIRrHP+A1I
 IwwFxs2q6dTHtaZv/FuaiOS+Uh9pISVbAAG5+AXmA73sAMZUIV0ESDi2U4DasOTE/OXmGp
 mC/kcKQSYhdvd3l6f5QOMS7oXxpFEDPeQlKkn/wjrc7hpWltKDnFdF4smJwRiSoOERE5Af
 nl3hKaIYgk2S4sfuJBFCw9n3JqBoi7CjCc1N2FGyXRWQyXyQVgt7Z5wckGph70q5xXmQzn
 Pm2Ht8acWtiFXs4rI2cERaRRSPdVLrlv82JoB+UuoGDv4ucRtTcKCs/5vj6Zgg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 15 Oct 2025 16:25:53 +0000
Subject: [PATCH v4 6/8] arm: dts: meson-gx-u-boot: add binman configuration
 for U-Boot SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251015-spl-gx-v4-6-f5d7fe03225b@postmarketos.org>
References: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
In-Reply-To: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3916;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=MGDScDvr0ecHNMeVJtEMktgBY70YxwzIUIKzNaWNYMA=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo78sf0BdtOhB+k6ovBMpudlZ/XUKlDuiUUbY/M
 hpNprYMHhyJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaO/LHwAKCRCEr8vQ14ma
 AwZKD/wK3WZAMzOxgRG/vqxGj59HfdE2VfqEZSokyfgEittZRfoFfgMoHlIIVN4CPO4it1se3rK
 kwTNrbxNRdJW6dGgioTzB8E21ZHtQ2ey+EbeQrhjscOmWiw6Gj25OycC4LGA2puJa6tDzUMIdBB
 rzcG7WsXXuE35LSYWfHbHM4sgtY8Fut63qwMalBbW3WKH+u/sjzbAUO0wWwy0uDY6oEiyOqhI5I
 3Vj/8iaizGWmNKBG73/CLOoxcDDqGKJQeIEYxsPz4MOuTcQeDMPGDOoH4v4mWHe/0xdElixKtKs
 n+FJVXIZcVU44iwoQxlIYyd+sq+vb2rdYcPsQAxJBQKn3dczR6AETM0PRLmJ9jESUAkU8Do8InI
 jMMLBRIJmy9tPLFwL88R0qaEKEVod+r5HmeKsqt2aKbmRpSgyROikkD3w5JbGXYwXwAtsdYjpsF
 ohxQ/+M0XWTJWmfLA4e5oM4Z6TEDnIHvFBHib3dIpV1sqhWikjHSzpCRU4DiEFLZtSk1fKh6Eqw
 U4daLee3UGK95ZRsuI9XewleJkH+Q2Dt1QygoJlgpTA60VA3ZBEwzEyppB+Fbz6XQ/aGm+isRLO
 8jUSnbBn6V9WflS4bQ09T/SDzz8Zx43demNXKovieyG3p4VVUafWOq1wKd24Hr1n7/nXlDM4NAo
 WNDUGSVgbyGku+Q==
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/dts/meson-gx-u-boot.dtsi | 142 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-boot.dtsi
index 9e0620f395e..d05f869c06e 100644
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

