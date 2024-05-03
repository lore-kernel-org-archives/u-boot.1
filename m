Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8B2C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 01:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E84588BFF;
	Fri,  3 May 2024 03:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714698354;
	bh=iq6q7a1Ce6eef7Hbmo0YXysNFlCqRgEKmHXJzw/9xoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lQuQ4U9TU9EnsoFtuUKhhWO3vMw9u+EXNGZDNUMPIQJibW6dbejnjNYgnmWYVE+Pg
	 oqeiYOyi2GL0Na9cVtHXC6WMg6CGXbAN+XHOEAMR8sglg8ho77CPp/2ZBF4XwbzqqY
	 HnFSfq3hVQmzGWqCJd5vi5SSGYwciBYgULIwxVU2KFDNG9OUwLpCZIlSLHJmZRv8qi
	 rtzjdtuWZH8m1JmJgqgrOYg9LLGqp8uZYvoft2vEg+/g70HNs7QaMWHq4FF3cNGhHd
	 QUvH29bh4yLnZ5PKyE/TyGIcgidIJGVuuUCAy42YZEElX0dkKMr8UeFG0pb2SUVSwX
	 JFvpQoZ2kJksA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 086C888AB5;
 Fri,  3 May 2024 03:05:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714698352;
 bh=iq6q7a1Ce6eef7Hbmo0YXysNFlCqRgEKmHXJzw/9xoc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lM6VRURrpJN0Ebzpr8Egg+H/VmR9QJS+6lm8xTLUv6fS9LKbsc69EHJeBny7Ok1H3
 jk/XzGS//QxXcqTUiozTP6i1i76b9CMJFDKu5wSPnsyV0nmUNlgOV5Mh+nm7rMpsxU
 5CJsokZoZ2/+dFw4MEUgnt+w+4S/FiBxRLZd1AoRDYNMXiQD/hvRk+LyU2SVu1c7Ib
 KwtqR5Wp5gNO6vl2hjmMoXpi665f6krlvtvmjZZBbJjmtZLDi//L1q1PRMD6ZPAlbh
 SPbqVnOB6Ap8Uk8jvcsbECXuXya/1ewuABNaDvTpSjhsdRaVkqgGbw36XbR3BTSnyX
 eDDB3x1tqvGUg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: anton.gres@ifm.com, ch@denx.de, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, kernel@puri.sm, u-boot@dh-electronics.com
Subject: [PATCH v2 3/4] ARM: dts: imx: Wrap i.MX8M binman SPL and FIT nodes in
 CST node if IMX_HAB enabled
Date: Fri,  3 May 2024 03:05:11 +0200
Message-ID: <20240503010518.263458-3-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503010518.263458-1-marex@denx.de>
References: <20240503010518.263458-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In case CONFIG_IMX_HAB is enabled, extend the binman image description for
all of i.MX8M{Q,M,N,P} with CST wrapper node. This way, if CONFIG_IMX_HAB
is enabled, binman will be automatically used to sign SPL and fitImage.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: kernel@puri.sm
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
V2: New patch
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 195 ++++++++++++++++-------------
 arch/arm/dts/imx8mn-u-boot.dtsi | 209 ++++++++++++++++++--------------
 arch/arm/dts/imx8mp-u-boot.dtsi | 172 ++++++++++++++------------
 arch/arm/dts/imx8mq-u-boot.dtsi | 182 ++++++++++++++-------------
 4 files changed, 424 insertions(+), 334 deletions(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index b9b1193823a..c02e11def5f 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -54,126 +54,151 @@
 		};
 #endif
 
-		binman_imx_spl: nxp-imx8mimage {
-			filename = "u-boot-spl-mkimage.bin";
-			nxp,boot-from = "sd";
-			nxp,rom-version = <1>;
+#ifdef CONFIG_IMX_HAB
+		nxp-imx8mcst@0 {
+			filename = "u-boot-spl-mkimage.signed.bin";
 			nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+			nxp,unlock;
 			args;	/* Needed by mkimage etype superclass */
+#endif
 
-			section {
-				align = <4>;
-				align-size = <4>;
-				filename = "u-boot-spl-ddr.bin";
-				pad-byte = <0xff>;
-
-				u-boot-spl {
-					align-end = <4>;
-					filename = "u-boot-spl.bin";
-				};
+			binman_imx_spl: nxp-imx8mimage {
+				filename = "u-boot-spl-mkimage.bin";
+				nxp,boot-from = "sd";
+				nxp,rom-version = <1>;
+				nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+				args;	/* Needed by mkimage etype superclass */
+
+				section {
+					align = <4>;
+					align-size = <4>;
+					filename = "u-boot-spl-ddr.bin";
+					pad-byte = <0xff>;
+
+					u-boot-spl {
+						align-end = <4>;
+						filename = "u-boot-spl.bin";
+					};
 
-				ddr-1d-imem-fw {
-					filename = "lpddr4_pmu_train_1d_imem.bin";
-					align-end = <4>;
-					type = "blob-ext";
-				};
+					ddr-1d-imem-fw {
+						filename = "lpddr4_pmu_train_1d_imem.bin";
+						align-end = <4>;
+						type = "blob-ext";
+					};
 
-				ddr-1d-dmem-fw {
-					filename = "lpddr4_pmu_train_1d_dmem.bin";
-					align-end = <4>;
-					type = "blob-ext";
-				};
+					ddr-1d-dmem-fw {
+						filename = "lpddr4_pmu_train_1d_dmem.bin";
+						align-end = <4>;
+						type = "blob-ext";
+					};
 
-				ddr-2d-imem-fw {
-					filename = "lpddr4_pmu_train_2d_imem.bin";
-					align-end = <4>;
-					type = "blob-ext";
-				};
+					ddr-2d-imem-fw {
+						filename = "lpddr4_pmu_train_2d_imem.bin";
+						align-end = <4>;
+						type = "blob-ext";
+					};
 
-				ddr-2d-dmem-fw {
-					filename = "lpddr4_pmu_train_2d_dmem.bin";
-					align-end = <4>;
-					type = "blob-ext";
+					ddr-2d-dmem-fw {
+						filename = "lpddr4_pmu_train_2d_dmem.bin";
+						align-end = <4>;
+						type = "blob-ext";
+					};
 				};
 			};
+#ifdef CONFIG_IMX_HAB
 		};
 
-		binman_imx_fit: fit {
-			description = "Configuration to load ATF before U-Boot";
-#ifndef CONFIG_IMX_HAB
-			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
-#endif
-			fit,fdt-list = "of-list";
-			#address-cells = <1>;
+		nxp-imx8mcst@1 {
+			filename = "u-boot-fit.signed.bin";
+			nxp,loader-address = <CONFIG_SPL_LOAD_FIT_ADDRESS>;
 #ifdef CONFIG_FSPI_CONF_HEADER
 			offset = <0x58C00>;
 #else
 			offset = <0x57c00>;
 #endif
 
-			images {
-				uboot {
-					arch = "arm64";
-					compression = "none";
-					description = "U-Boot (64-bit)";
-					load = <CONFIG_TEXT_BASE>;
-					type = "standalone";
+			args;	/* Needed by mkimage etype superclass */
+#endif
 
-					uboot-blob {
-						filename = "u-boot-nodtb.bin";
-						type = "blob-ext";
+			binman_imx_fit: fit {
+				description = "Configuration to load ATF before U-Boot";
+#ifndef CONFIG_IMX_HAB
+				fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+#endif
+				fit,fdt-list = "of-list";
+				#address-cells = <1>;
+#ifdef CONFIG_FSPI_CONF_HEADER
+				offset = <0x58C00>;
+#else
+				offset = <0x57c00>;
+#endif
+
+				images {
+					uboot {
+						arch = "arm64";
+						compression = "none";
+						description = "U-Boot (64-bit)";
+						load = <CONFIG_TEXT_BASE>;
+						type = "standalone";
+
+						uboot-blob {
+							filename = "u-boot-nodtb.bin";
+							type = "blob-ext";
+						};
 					};
-				};
 
 #ifndef CONFIG_ARMV8_PSCI
-				atf {
-					arch = "arm64";
-					compression = "none";
-					description = "ARM Trusted Firmware";
-					entry = <0x920000>;
-					load = <0x920000>;
-					type = "firmware";
-
-					atf-blob {
-						filename = "bl31.bin";
-						type = "atf-bl31";
+					atf {
+						arch = "arm64";
+						compression = "none";
+						description = "ARM Trusted Firmware";
+						entry = <0x920000>;
+						load = <0x920000>;
+						type = "firmware";
+
+						atf-blob {
+							filename = "bl31.bin";
+							type = "atf-bl31";
+						};
 					};
-				};
 #endif
 
-				binman_fip: fip {
-					arch = "arm64";
-					compression = "none";
-					description = "Trusted Firmware FIP";
-					load = <0x40310000>;
-					type = "firmware";
-				};
+					binman_fip: fip {
+						arch = "arm64";
+						compression = "none";
+						description = "Trusted Firmware FIP";
+						load = <0x40310000>;
+						type = "firmware";
+					};
 
-				@fdt-SEQ {
-					compression = "none";
-					description = "NAME";
-					type = "flat_dt";
+					@fdt-SEQ {
+						compression = "none";
+						description = "NAME";
+						type = "flat_dt";
 
-					uboot-fdt-blob {
-						filename = "u-boot.dtb";
-						type = "blob-ext";
+						uboot-fdt-blob {
+							filename = "u-boot.dtb";
+							type = "blob-ext";
+						};
 					};
 				};
-			};
 
-			configurations {
-				default = "@config-DEFAULT-SEQ";
+				configurations {
+					default = "@config-DEFAULT-SEQ";
 
-				@config-SEQ {
-					description = "NAME";
-					fdt = "fdt-SEQ";
-					firmware = "uboot";
+					@config-SEQ {
+						description = "NAME";
+						fdt = "fdt-SEQ";
+						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-					loadables = "atf";
+						loadables = "atf";
 #endif
+					};
 				};
 			};
+#ifdef CONFIG_IMX_HAB
 		};
+#endif
 	};
 };
 
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index c9fb33cfb73..732191f5205 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -103,147 +103,172 @@
 		};
 #endif
 
-		binman_imx_spl: nxp-imx8mimage {
-			filename = "u-boot-spl-mkimage.bin";
-			nxp,boot-from = "sd";
-			nxp,rom-version = <2>;
+#ifdef CONFIG_IMX_HAB
+		nxp-imx8mcst@0 {
+			filename = "u-boot-spl-mkimage.signed.bin";
 			nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+			nxp,unlock;
 			args;	/* Needed by mkimage etype superclass */
+#endif
 
-			section {
-				filename = "u-boot-spl-ddr.bin";
-				pad-byte = <0xff>;
-				align-size = <4>;
-				align = <4>;
-
-				u-boot-spl {
-					align-end = <4>;
-					filename = "u-boot-spl.bin";
-				};
+			binman_imx_spl: nxp-imx8mimage {
+				filename = "u-boot-spl-mkimage.bin";
+				nxp,boot-from = "sd";
+				nxp,rom-version = <2>;
+				nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+				args;	/* Needed by mkimage etype superclass */
+
+				section {
+					filename = "u-boot-spl-ddr.bin";
+					pad-byte = <0xff>;
+					align-size = <4>;
+					align = <4>;
+
+					u-boot-spl {
+						align-end = <4>;
+						filename = "u-boot-spl.bin";
+					};
 
-				ddr-1d-imem-fw {
+					ddr-1d-imem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-					filename = "lpddr4_pmu_train_1d_imem.bin";
+						filename = "lpddr4_pmu_train_1d_imem.bin";
 #elif CONFIG_IMX8M_DDR4
-					filename = "ddr4_imem_1d_201810.bin";
+						filename = "ddr4_imem_1d_201810.bin";
 #else
-					filename = "ddr3_imem_1d.bin";
+						filename = "ddr3_imem_1d.bin";
 #endif
-					type = "blob-ext";
-					align-end = <4>;
-				};
+						type = "blob-ext";
+						align-end = <4>;
+					};
 
-				ddr-1d-dmem-fw {
+					ddr-1d-dmem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-					filename = "lpddr4_pmu_train_1d_dmem.bin";
+						filename = "lpddr4_pmu_train_1d_dmem.bin";
 #elif CONFIG_IMX8M_DDR4
-					filename = "ddr4_dmem_1d_201810.bin";
+						filename = "ddr4_dmem_1d_201810.bin";
 #else
-					filename = "ddr3_dmem_1d.bin";
+						filename = "ddr3_dmem_1d.bin";
 #endif
-					type = "blob-ext";
-					align-end = <4>;
-				};
+						type = "blob-ext";
+						align-end = <4>;
+					};
 
 #if defined(CONFIG_IMX8M_LPDDR4) || defined(CONFIG_IMX8M_DDR4)
-				ddr-2d-imem-fw {
+					ddr-2d-imem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-					filename = "lpddr4_pmu_train_2d_imem.bin";
+						filename = "lpddr4_pmu_train_2d_imem.bin";
 #else
-					filename = "ddr4_imem_2d_201810.bin";
+						filename = "ddr4_imem_2d_201810.bin";
 #endif
-					type = "blob-ext";
-					align-end = <4>;
-				};
+						type = "blob-ext";
+						align-end = <4>;
+					};
 
-				ddr-2d-dmem-fw {
+					ddr-2d-dmem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-					filename = "lpddr4_pmu_train_2d_dmem.bin";
+						filename = "lpddr4_pmu_train_2d_dmem.bin";
 #else
-					filename = "ddr4_dmem_2d_201810.bin";
+						filename = "ddr4_dmem_2d_201810.bin";
 #endif
-					type = "blob-ext";
-					align-end = <4>;
-				};
+						type = "blob-ext";
+						align-end = <4>;
+					};
 #endif
+				};
 			};
+
+#ifdef CONFIG_IMX_HAB
 		};
 
-		binman_imx_fit: fit {
-			description = "Configuration to load ATF before U-Boot";
-#ifndef CONFIG_IMX_HAB
-			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
-#endif
-			fit,fdt-list = "of-list";
-			#address-cells = <1>;
+		nxp-imx8mcst@1 {
+			filename = "u-boot-fit.signed.bin";
+			nxp,loader-address = <CONFIG_SPL_LOAD_FIT_ADDRESS>;
 #ifdef CONFIG_FSPI_CONF_HEADER
 			offset = <0x59000>;
 #else
 			offset = <0x58000>;
 #endif
+			args;	/* Needed by mkimage etype superclass */
+#endif
 
-			images {
-				uboot {
-					arch = "arm64";
-					compression = "none";
-					description = "U-Boot (64-bit)";
-					load = <CONFIG_TEXT_BASE>;
-					type = "standalone";
+			binman_imx_fit: fit {
+				description = "Configuration to load ATF before U-Boot";
+#ifndef CONFIG_IMX_HAB
+				fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+#endif
+				fit,fdt-list = "of-list";
+				#address-cells = <1>;
+#ifdef CONFIG_FSPI_CONF_HEADER
+				offset = <0x59000>;
+#else
+				offset = <0x58000>;
+#endif
 
-					uboot-blob {
-						filename = "u-boot-nodtb.bin";
-						type = "blob-ext";
+				images {
+					uboot {
+						arch = "arm64";
+						compression = "none";
+						description = "U-Boot (64-bit)";
+						load = <CONFIG_TEXT_BASE>;
+						type = "standalone";
+
+						uboot-blob {
+							filename = "u-boot-nodtb.bin";
+							type = "blob-ext";
+						};
 					};
-				};
 
 #ifndef CONFIG_ARMV8_PSCI
-				atf {
-					arch = "arm64";
-					compression = "none";
-					description = "ARM Trusted Firmware";
-					entry = <0x960000>;
-					load = <0x960000>;
-					type = "firmware";
-
-					atf-blob {
-						filename = "bl31.bin";
-						type = "atf-bl31";
+					atf {
+						arch = "arm64";
+						compression = "none";
+						description = "ARM Trusted Firmware";
+						entry = <0x960000>;
+						load = <0x960000>;
+						type = "firmware";
+
+						atf-blob {
+							filename = "bl31.bin";
+							type = "atf-bl31";
+						};
 					};
-				};
 #endif
 
-				binman_fip: fip {
-					arch = "arm64";
-					compression = "none";
-					description = "Trusted Firmware FIP";
-					load = <0x40310000>;
-					type = "firmware";
-				};
+					binman_fip: fip {
+						arch = "arm64";
+						compression = "none";
+						description = "Trusted Firmware FIP";
+						load = <0x40310000>;
+						type = "firmware";
+					};
 
-				@fdt-SEQ {
-					compression = "none";
-					description = "NAME";
-					type = "flat_dt";
+					@fdt-SEQ {
+						compression = "none";
+						description = "NAME";
+						type = "flat_dt";
 
-					uboot-fdt-blob {
-						filename = "u-boot.dtb";
-						type = "blob-ext";
+						uboot-fdt-blob {
+							filename = "u-boot.dtb";
+							type = "blob-ext";
+						};
 					};
 				};
-			};
 
-			configurations {
-				default = "@config-DEFAULT-SEQ";
+				configurations {
+					default = "@config-DEFAULT-SEQ";
 
-				@config-SEQ {
-					description = "NAME";
-					fdt = "fdt-SEQ";
-					firmware = "uboot";
+					@config-SEQ {
+						description = "NAME";
+						fdt = "fdt-SEQ";
+						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-					loadables = "atf";
+						loadables = "atf";
 #endif
+					};
 				};
 			};
+#ifdef CONFIG_IMX_HAB
 		};
+#endif
 	};
 };
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 8b5ac3faf1c..f2655a4d0c8 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -86,110 +86,130 @@
 	section {
 		pad-byte = <0x00>;
 
-		binman_imx_spl: nxp-imx8mimage {
-			filename = "u-boot-spl-mkimage.bin";
-			nxp,boot-from = "sd";
-			nxp,rom-version = <2>;
+#ifdef CONFIG_IMX_HAB
+		nxp-imx8mcst@0 {
+			filename = "u-boot-spl-mkimage.signed.bin";
 			nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+			nxp,unlock;
 			args;	/* Needed by mkimage etype superclass */
+#endif
 
-			section {
-				filename = "u-boot-spl-ddr.bin";
-				pad-byte = <0xff>;
-				align-size = <4>;
-				align = <4>;
-
-				u-boot-spl {
-					align-end = <4>;
-				};
+			binman_imx_spl: nxp-imx8mimage {
+				filename = "u-boot-spl-mkimage.bin";
+				nxp,boot-from = "sd";
+				nxp,rom-version = <2>;
+				nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+				args;	/* Needed by mkimage etype superclass */
+
+				section {
+					filename = "u-boot-spl-ddr.bin";
+					pad-byte = <0xff>;
+					align-size = <4>;
+					align = <4>;
+
+					u-boot-spl {
+						align-end = <4>;
+					};
 
-				ddr-1d-imem-fw {
-					filename = "lpddr4_pmu_train_1d_imem_202006.bin";
-					type = "blob-ext";
-					align-end = <4>;
-				};
+					ddr-1d-imem-fw {
+						filename = "lpddr4_pmu_train_1d_imem_202006.bin";
+						type = "blob-ext";
+						align-end = <4>;
+					};
 
-				ddr-1d-dmem-fw {
-					filename = "lpddr4_pmu_train_1d_dmem_202006.bin";
-					type = "blob-ext";
-					align-end = <4>;
-				};
+					ddr-1d-dmem-fw {
+						filename = "lpddr4_pmu_train_1d_dmem_202006.bin";
+						type = "blob-ext";
+						align-end = <4>;
+					};
 
-				ddr-2d-imem-fw {
-					filename = "lpddr4_pmu_train_2d_imem_202006.bin";
-					type = "blob-ext";
-					align-end = <4>;
-				};
+					ddr-2d-imem-fw {
+						filename = "lpddr4_pmu_train_2d_imem_202006.bin";
+						type = "blob-ext";
+						align-end = <4>;
+					};
 
-				ddr-2d-dmem-fw {
-					filename = "lpddr4_pmu_train_2d_dmem_202006.bin";
-					type = "blob-ext";
-					align-end = <4>;
+					ddr-2d-dmem-fw {
+						filename = "lpddr4_pmu_train_2d_dmem_202006.bin";
+						type = "blob-ext";
+						align-end = <4>;
+					};
 				};
 			};
+#ifdef CONFIG_IMX_HAB
 		};
 
-		binman_imx_fit: fit {
-			description = "Configuration to load ATF before U-Boot";
-#ifndef CONFIG_IMX_HAB
-			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
-#endif
-			fit,fdt-list = "of-list";
-			#address-cells = <1>;
+		nxp-imx8mcst@1 {
+			filename = "u-boot-fit.signed.bin";
+			nxp,loader-address = <CONFIG_SPL_LOAD_FIT_ADDRESS>;
 			offset = <0x58000>;
+			args;	/* Needed by mkimage etype superclass */
+#endif
 
-			images {
-				uboot {
-					description = "U-Boot (64-bit)";
-					type = "standalone";
-					arch = "arm64";
-					compression = "none";
-					load = <CONFIG_TEXT_BASE>;
-
-					uboot_blob: blob-ext {
-						filename = "u-boot-nodtb.bin";
+			binman_imx_fit: fit {
+				description = "Configuration to load ATF before U-Boot";
+#ifndef CONFIG_IMX_HAB
+				fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+#endif
+				fit,fdt-list = "of-list";
+				#address-cells = <1>;
+				offset = <0x58000>;
+
+				images {
+					uboot {
+						description = "U-Boot (64-bit)";
+						type = "standalone";
+						arch = "arm64";
+						compression = "none";
+						load = <CONFIG_TEXT_BASE>;
+
+						uboot_blob: blob-ext {
+							filename = "u-boot-nodtb.bin";
+						};
 					};
-				};
 
 #ifndef CONFIG_ARMV8_PSCI
-				atf {
-					description = "ARM Trusted Firmware";
-					type = "firmware";
-					arch = "arm64";
-					compression = "none";
-					load = <0x970000>;
-					entry = <0x970000>;
-
-					atf_blob: atf-blob {
-						filename = "bl31.bin";
-						type = "atf-bl31";
+					atf {
+						description = "ARM Trusted Firmware";
+						type = "firmware";
+						arch = "arm64";
+						compression = "none";
+						load = <0x970000>;
+						entry = <0x970000>;
+
+						atf_blob: atf-blob {
+							filename = "bl31.bin";
+							type = "atf-bl31";
+						};
 					};
-				};
 #endif
 
-				@fdt-SEQ {
-					description = "NAME";
-					type = "flat_dt";
-					compression = "none";
+					@fdt-SEQ {
+						description = "NAME";
+						type = "flat_dt";
+						compression = "none";
 
-					blob-ext {
-						filename = "u-boot.dtb";
+						blob-ext {
+							filename = "u-boot.dtb";
+						};
 					};
 				};
-			};
 
-			configurations {
-				default = "@config-DEFAULT-SEQ";
+				configurations {
+					default = "@config-DEFAULT-SEQ";
 
-				@config-SEQ {
-					description = "NAME";
-					fdt = "fdt-SEQ";
-					firmware = "uboot";
+					@config-SEQ {
+						description = "NAME";
+						fdt = "fdt-SEQ";
+						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-					loadables = "atf";
+						loadables = "atf";
 #endif
+					};
 				};
 			};
+#ifdef CONFIG_IMX_HAB
 		};
+#endif
 	};
 };
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index 72da674d245..e1cd6f8996d 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -38,116 +38,136 @@
 	section {
 		pad-byte = <0x00>;
 
-		binman_imx_spl: nxp-imx8mimage {
-			filename = "u-boot-spl-mkimage.bin";
-			nxp,boot-from = "sd";
-			nxp,rom-version = <1>;
+#ifdef CONFIG_IMX_HAB
+		nxp-imx8mcst@0 {
+			filename = "u-boot-spl-mkimage.signed.bin";
 			nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+			nxp,unlock;
 			args;	/* Needed by mkimage etype superclass */
+#endif
 
-			section {
-				align = <4>;
-				align-size = <4>;
-				filename = "u-boot-spl-ddr.bin";
-				pad-byte = <0xff>;
-
-				u-boot-spl {
-					align-end = <4>;
-					filename = "u-boot-spl.bin";
-				};
+			binman_imx_spl: nxp-imx8mimage {
+				filename = "u-boot-spl-mkimage.bin";
+				nxp,boot-from = "sd";
+				nxp,rom-version = <1>;
+				nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+				args;	/* Needed by mkimage etype superclass */
+
+				section {
+					align = <4>;
+					align-size = <4>;
+					filename = "u-boot-spl-ddr.bin";
+					pad-byte = <0xff>;
+
+					u-boot-spl {
+						align-end = <4>;
+						filename = "u-boot-spl.bin";
+					};
 
-				ddr-1d-imem-fw {
-					filename = "lpddr4_pmu_train_1d_imem.bin";
-					align-end = <4>;
-					type = "blob-ext";
-				};
+					ddr-1d-imem-fw {
+						filename = "lpddr4_pmu_train_1d_imem.bin";
+						align-end = <4>;
+						type = "blob-ext";
+					};
 
-				ddr-1d-dmem-fw {
-					filename = "lpddr4_pmu_train_1d_dmem.bin";
-					align-end = <4>;
-					type = "blob-ext";
-				};
+					ddr-1d-dmem-fw {
+						filename = "lpddr4_pmu_train_1d_dmem.bin";
+						align-end = <4>;
+						type = "blob-ext";
+					};
 
-				ddr-2d-imem-fw {
-					filename = "lpddr4_pmu_train_2d_imem.bin";
-					align-end = <4>;
-					type = "blob-ext";
-				};
+					ddr-2d-imem-fw {
+						filename = "lpddr4_pmu_train_2d_imem.bin";
+						align-end = <4>;
+						type = "blob-ext";
+					};
 
-				ddr-2d-dmem-fw {
-					filename = "lpddr4_pmu_train_2d_dmem.bin";
-					align-end = <4>;
-					type = "blob-ext";
-				};
+					ddr-2d-dmem-fw {
+						filename = "lpddr4_pmu_train_2d_dmem.bin";
+						align-end = <4>;
+						type = "blob-ext";
+					};
 
-				signed-hdmi-imx8m {
-					filename = "signed_hdmi_imx8m.bin";
-					type = "blob-ext";
+					signed-hdmi-imx8m {
+						filename = "signed_hdmi_imx8m.bin";
+						type = "blob-ext";
+					};
 				};
 			};
+#ifdef CONFIG_IMX_HAB
 		};
 
-		binman_imx_fit: fit {
-			description = "Configuration to load ATF before U-Boot";
+		nxp-imx8mcst@1 {
+			filename = "u-boot-fit.signed.bin";
+			nxp,loader-address = <CONFIG_SPL_LOAD_FIT_ADDRESS>;
+			offset = <0x58000>;
+			args;	/* Needed by mkimage etype superclass */
+#endif
+
+			binman_imx_fit: fit {
+				description = "Configuration to load ATF before U-Boot";
 #ifndef CONFIG_IMX_HAB
-			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+				fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 #endif
-			#address-cells = <1>;
-
-			images {
-				uboot {
-					arch = "arm64";
-					compression = "none";
-					description = "U-Boot (64-bit)";
-					load = <CONFIG_TEXT_BASE>;
-					type = "standalone";
-
-					uboot-blob {
-						filename = "u-boot-nodtb.bin";
-						type = "blob-ext";
+				#address-cells = <1>;
+
+				images {
+					uboot {
+						arch = "arm64";
+						compression = "none";
+						description = "U-Boot (64-bit)";
+						load = <CONFIG_TEXT_BASE>;
+						type = "standalone";
+
+						uboot-blob {
+							filename = "u-boot-nodtb.bin";
+							type = "blob-ext";
+						};
 					};
-				};
 
 #ifndef CONFIG_ARMV8_PSCI
-				atf {
-					arch = "arm64";
-					compression = "none";
-					description = "ARM Trusted Firmware";
-					entry = <0x910000>;
-					load = <0x910000>;
-					type = "firmware";
-
-					atf-blob {
-						filename = "bl31.bin";
-						type = "blob-ext";
+					atf {
+						arch = "arm64";
+						compression = "none";
+						description = "ARM Trusted Firmware";
+						entry = <0x910000>;
+						load = <0x910000>;
+						type = "firmware";
+
+						atf-blob {
+							filename = "bl31.bin";
+							type = "blob-ext";
+						};
 					};
-				};
 #endif
 
-				fdt {
-					compression = "none";
-					description = "NAME";
-					type = "flat_dt";
+					fdt {
+						compression = "none";
+						description = "NAME";
+						type = "flat_dt";
 
-					uboot-fdt-blob {
-						filename = "u-boot.dtb";
-						type = "blob-ext";
+						uboot-fdt-blob {
+							filename = "u-boot.dtb";
+							type = "blob-ext";
+						};
 					};
 				};
-			};
 
-			configurations {
-				default = "conf";
+				configurations {
+					default = "conf";
 
-				conf {
-					description = "NAME";
-					fdt = "fdt";
-					firmware = "uboot";
+					conf {
+						description = "NAME";
+						fdt = "fdt";
+						firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-					loadables = "atf";
+						loadables = "atf";
 #endif
+					};
 				};
 			};
+#ifdef CONFIG_IMX_HAB
 		};
+#endif
 	};
 };
-- 
2.43.0

