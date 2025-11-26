Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EF5D10F2E
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 12:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96EC841F7;
	Wed, 26 Nov 2025 13:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="BSEzU+VW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD77841E6; Wed, 26 Nov 2025 13:17:43 +0100 (CET)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 039C2841F7
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 13:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1764159459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdm4GOxBJrLtWvRmracnSPnPoFEFgfaiuh5gQChsT3U=;
 b=BSEzU+VWfd1evQGlba7u2twtFSiTDBPX5BA2Pva6xkG1Ng4SNGlnxTh66w82vsO2X7jYWq
 DbDF15Y6HGT7nSno8cz5wfwZY9o5+PkXkHsWNz670bflv+VrFF5dXO0SNNU65h8W2/ekzn
 qIz52lBaaT5b+xyB9IcYP5VKkdxa5dozLfrWWd1LsvYWf4D6obmmULTDwNdnTEjQursFXr
 EIdj68uE9mhbLckfLgqHmnyPHh6Bscqaio/nmn5DlOC9MsafjxjE/90S4gvRgjRkDDnwS8
 G7MNvgwgEzH7DLiGIgjTFh7eJ3v6KwewIsAsPGJ5ADkMWD8Cz0TvvDu7J4gbNw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 26 Nov 2025 12:17:09 +0000
Subject: [PATCH v5 07/10] arm: dts: meson-gx-u-boot: add binman
 configuration for U-Boot SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-spl-gx-v5-7-6cbffb2451ca@postmarketos.org>
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
In-Reply-To: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5038;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=ASz8VJeOwai5FaOyRxr4KoYBeY3M86ezR978ShbjrXU=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpJu/YaruX3LAlX7/OhJRF0+xIui88jZzJ8RXyA
 t+KGkEBo3CJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaSbv2AAKCRCEr8vQ14ma
 AyqLEACe87WUa7VH/G7LZVnEHKGjgwSf69wB9yKAzfObHMBmB30p/nm+Ncf+bye8dwVENPOpkpn
 xRZ0kqjz2lMlzC7H4TiDDUvKYMoFpbCwtxmn/sUH0rNCwJ+45Uison59geiRu99xhfQ4yVc1R1O
 7zuOeJjaouxXo19jbefCyQfDTrOgvJZnk/FyPaduYzSqTpn3mRiTyHK1f6g1UmkI/T6SYnKaJBs
 fJ9eaHwodvgIHGOD3KHosSuOtwQjxdgEN+EmJRyskIfAXuEGoZRP9T3G/ESprcN9e1VnMagRUaV
 Rg0DFKe/XQXAwOf7gAl8qKoTenjtAkrLxnxX+B18YkG3htFMKrLq3iveY8bVasQSzXR8L1vrqZx
 aK0G9brZTfwh8wbbyQeBLuVne/twbzynHblRtJEVIEVoi/870P5nZ5aSsl7IiIlYs4YHEz0RVFG
 TDjqmudPvClTh2njYACXE8db8K3xwFBBOflgsMxk7u/q7XLddm9qCc6dtCAv8X1lame0AyYITRu
 cwkfVKX1kIANPeZB+Oo0Z/BQcqILXCpMCzCVOkCtu6+5WBuhWN7t3mP8kl+0vNFKCNeSSzy7KVL
 mpdM1hkjGtyT8dEcbHgkeiguuGOqFhCFtSdbpmf4rwR65MbKlX7rdTIFYjJ+Rki5OD/J+J0UQr0
 zPCNVVajXwAvm0Q==
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/dts/meson-gx-u-boot.dtsi   | 125 ++++++++++++++++++++++++++++++++++++
 arch/arm/dts/meson-gxbb-u-boot.dtsi |  20 ++++++
 arch/arm/dts/meson-gxl-u-boot.dtsi  |  20 ++++++
 3 files changed, 165 insertions(+)

diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-boot.dtsi
index 9e0620f395e..cef7f90fcd4 100644
--- a/arch/arm/dts/meson-gx-u-boot.dtsi
+++ b/arch/arm/dts/meson-gx-u-boot.dtsi
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2019 BayLibre, SAS.
  * Author: Maxime Jourdan <mjourdan@baylibre.com>
+ * Copyright (c) 2023 Ferass El Hafidi <funderscore@postmarketos.org>
  */
 
 / {
@@ -15,6 +16,12 @@
 	soc {
 		bootph-all;
 	};
+
+#if defined(CONFIG_BINMAN)
+	binman: binman {
+		multiple-images;
+	};
+#endif
 };
 
 &vpu {
@@ -30,3 +37,121 @@
 	      <0x0 0xc883c000 0x0 0x1000>;
 	reg-names = "hdmitx", "hhi";
 };
+
+#if defined(CONFIG_BINMAN)
+/* binman configuration on GXBB and GXL */
+
+&binman {
+	u-boot-amlogic {
+		filename = "u-boot-meson-with-spl.bin";
+		pad-byte = <0xff>;
+
+		mkimage {
+			filename = "spl/u-boot-spl-signed.bin";
+			/* args are per-SoC, and defined in meson-(gxbb/gxl)-u-boot.dtsi */
+
+			u-boot-spl {
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
+
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE) && CONFIG_IS_ENABLED(SHA256)
+					hash {
+						algo = "sha256";
+					};
+#endif
+				};
+
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					os = "arm-trusted-firmware";
+					arch = "arm64";
+					compression = "none";
+					/*
+					 * load and entry are SoC-specific, and thus
+					 * defined in meson-(gxbb/gxl)-u-boot.dtsi
+					 */
+
+					atf-bl31 {
+						filename = "bl31.bin";
+					};
+
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE) && CONFIG_IS_ENABLED(SHA256)
+					hash {
+						algo = "sha256";
+					};
+#endif
+				};
+
+				scp {
+					description = "SCP BL30 Firmware";
+					type = "scp";
+					arch = "arm"; /* The Cortex-M core is used as SCP */
+					compression = "none";
+					/*
+					 * On GXBB the base address of the SCP firmware doesn't matter as SPL will
+					 * send the firmware to the SCP anyway, and can get the base address from the
+					 * FIT. On GXL it matters, as BL31 is supposed to send the firmware, so set the
+					 * base address to what GXL BL2 would load the binary to.
+					 */
+					load = <0x13c0000>;
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
+
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE) && CONFIG_IS_ENABLED(SHA256)
+					hash {
+						algo = "sha256";
+					};
+#endif
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
+#endif
diff --git a/arch/arm/dts/meson-gxbb-u-boot.dtsi b/arch/arm/dts/meson-gxbb-u-boot.dtsi
index c35158d7e9e..a4dc1c136f1 100644
--- a/arch/arm/dts/meson-gxbb-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxbb-u-boot.dtsi
@@ -5,3 +5,23 @@
  */
 
 #include "meson-gx-u-boot.dtsi"
+
+#if defined(CONFIG_BINMAN)
+/* GXBB-specific binman configuration */
+&binman {
+	u-boot-amlogic {
+		mkimage {
+			args = "-n", "gxbb", "-T", "amlimage";
+		};
+
+		fit: fit {
+			images {
+				atf {
+					load = <0x10100000>;
+					entry = <0x10100000>;
+				};
+			};
+		};
+	};
+};
+#endif
diff --git a/arch/arm/dts/meson-gxl-u-boot.dtsi b/arch/arm/dts/meson-gxl-u-boot.dtsi
index c35158d7e9e..3f1bbc1038f 100644
--- a/arch/arm/dts/meson-gxl-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxl-u-boot.dtsi
@@ -5,3 +5,23 @@
  */
 
 #include "meson-gx-u-boot.dtsi"
+
+#if defined(CONFIG_BINMAN)
+/* GXL-specific binman configuration */
+&binman {
+	u-boot-amlogic {
+		mkimage {
+			args = "-n", "gxl", "-T", "amlimage";
+		};
+
+		fit: fit {
+			images {
+				atf {
+					load = <0x5100000>;
+					entry = <0x5100000>;
+				};
+			};
+		};
+	};
+};
+#endif

-- 
2.51.2

