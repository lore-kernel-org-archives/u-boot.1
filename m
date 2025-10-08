Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE24CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 10:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC186838E3;
	Wed,  8 Oct 2025 12:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="FB3q2b0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1616083981; Wed,  8 Oct 2025 12:01:04 +0200 (CEST)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B2A83C70
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 12:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1759917661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yJny4tvlIG5T7FzlmsIkwvxqVddMcEo3dOwIbStIwY=;
 b=FB3q2b0g2aLKxOjKL76Lqi+GsODGfpwaYDShiQ5aSzYbzUcOairMp1TSbsCdSaaMUnEhVZ
 CIolqim7bwWddNUxKQjLpcUCB91rffXDBmzLkUiv+b95DNBk4nWzNklWHMp539fbfHKX4F
 69bVSr4wI1PBrUeoYGSoZdTeMJc1GvOfPKfF6ytdb/vP6Yrsgg57O7r1FoACOCIqHjcBsO
 I4NJgwKHDV+muG4oUu6+SvCOG/KknSpN5KbrcdyzXKQ6ajDoB/9SekU/qOjBiS7lNYc+Vy
 iWRxeQF7xD9dKcQuY0CaXwSYvRMeLaH1YVEyxpABy5vu2GrKijg6TO3bxucVlQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Oct 2025 10:00:42 +0000
Subject: [PATCH RFC v3 6/8] arm: dts: meson-gx-u-boot: add binman
 configuration for U-Boot SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251008-spl-gx-v3-6-5999637df4b9@postmarketos.org>
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
In-Reply-To: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3974;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=v8Gr4ZhPWSVTDlE8SX6DRPQu4fzbDLctblwM0JGaAa8=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo5jZU7Itv7COGkMFYpECNJY0Y6Id0/hmem+yC+
 blWrdfRccSJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaOY2VAAKCRCEr8vQ14ma
 AwWAD/9HzL9m1un8nvlB/56XrB7NnIxNoVGerfGvffrjgoS8OyTq94yNB6A7+qWP4Bb4dSvrmwm
 dA9GAvHfMEI6bQJEkCUxdN3HXfBhs5s13SPXAsZbV0Hj55fIzLPVyo93cOWwvBH7uwCatl2N47G
 WVbpm9n6fdysSH9suf3ZxYDrFFihME0NS8GiPafD46QFrCvpEGnijmdQi8sQ+lEBstBxBKT7nHX
 ihsAjvK9a/o/+BWUE5qANFMb7A0I1I7eKfGihdCOmyDeCdZO1Q/f4JdYOlhFQnN0vSLXkDmql4l
 2kn/ym1WBR6jleukfcYc89p1Xd1xFwSY7vZc49HFjKgeoSPcGUT9+BbN86HD/ZkPY48iCkxiAtj
 yTvwSoysIdJhdka6WcNj1kilZEm6n7ZfcqqCo7KPweTJVZKgWo1TdStcM1Csh6e2tRd6tWNYDdP
 r7/BYwaziU2vxrSg4eidfHdV3vGDaJHhyUvN3mkIWDKdBU4vXDAqGXOEQHWixHv7QLoLMOzze6g
 HQVDsH7Nmi0BqvSorl9U+OUWjYUDCSQjK2+qIdTY1bmbspZ0yVoU3JJCLsJRtUAaaU07HaginTf
 KHGYaeENLLmdFGUedXagxdVO/fh07k9lF5YvJvQijRP3LO06lLTByLcE2zcT0tLLIHnRn1a5NSU
 RtPdREbrlDyEt9g==
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

