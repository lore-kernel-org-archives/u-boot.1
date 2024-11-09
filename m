Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3002FD5E380
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 20:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A6189313;
	Sat,  9 Nov 2024 21:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BHbQ934U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B0D8929F; Sat,  9 Nov 2024 21:06:23 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366D3892E5
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 21:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4609e784352so21855481cf.0
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 12:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731182779; x=1731787579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUJW5brSs21zD1MUFFqoSgV6/RejK/8eXkma0RYODtA=;
 b=BHbQ934UVq/UTra4TuCab97AvKBLR5hxsd1wvWRr4F9XryYDnIa3FpLqPUxmjxF8WJ
 0vIkDukroLraHTlOpB4sYyJMAZ6vEsBrMpV0yvhFa/BxpIP0GcXIdhUojg4eo+6TUye/
 +9z8kRnlMYKNS72Snlj5wpib+yMjEbM5yVw/dwN5fXsKI+TxVOO+nl4lD1Q8kdEtjSll
 yu0RS7E6hVtN1RZ+eJzzoJYVJjvuHapohdPEw31Owb9qw7qY8bTVh0witsFNkS4SwFlY
 iTtLoriI0HibNVHErNi70SlaSrB59S7i+lnSejP7V06qbw7hrWbTbFnnVCWNuBwryta3
 5zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731182779; x=1731787579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUJW5brSs21zD1MUFFqoSgV6/RejK/8eXkma0RYODtA=;
 b=q7PtKABmw+Vqibs0iPlpM2KwVCbCqJzs3SClQs9nDzPLojSriPfGvtO/mN9Qsvr2dx
 dIk/DO5m65lzGUcfhpL1d6u03d5Nsg2OX70wx37SitNnAeoj1qCCf5lrBOsZwEMKNcYA
 xMAtmt2C1TI+9PieKCS10CEf92w6FnNmJWGw9mJMcdcvRQ9/kAqvmoC/jTW1lR3ojNOv
 AXagzSyDizX5LZl8IXGRAaSbkTN1Lz/Htnfq0NNlbaPSatHAe+2FGA8k33bXdomRiFJ5
 1ZyMQB2wPmVtmB1tpECgZcVtXPULgENHXS/AuUgY7+/kBGLfN3WAAGenFvdMx0BJgfzb
 cMVw==
X-Gm-Message-State: AOJu0Yxnpanb+I7GKXpp+8nd/Adfn/tQ96vjSu8efSQnHJO5KLZ1My89
 SMyKS28GvIzdmGAXU+W2woWpoMwamSmePF42vqJcOtcBXYvSbKJoV+T9AQ==
X-Google-Smtp-Source: AGHT+IGdFI8RR3WPJeNeuT+alkly4mzWFXNIeUcES4sFdkf0VMEOLDkrrL1YcImW+dSgBguBeaWCEA==
X-Received: by 2002:ac8:5fc7:0:b0:460:8559:e5bc with SMTP id
 d75a77b69052e-4630930ece8mr86115711cf.4.1731182779229; 
 Sat, 09 Nov 2024 12:06:19 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff5d678asm36525341cf.85.2024.11.09.12.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 12:06:18 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, lukma@denx.de, Adam Ford <aford173@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 1/4] arm64: dts: imx8mn: Fix FSPI booting
Date: Sat,  9 Nov 2024 14:06:02 -0600
Message-ID: <20241109200610.1615430-2-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241109200610.1615430-1-aford173@gmail.com>
References: <20241109200610.1615430-1-aford173@gmail.com>
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

When FSPI_CONF_HEADER is set, the binary needs to be built such
that there is a configuration file located at 0x400 and the start
of the file that would normally be flash.bin starts at 0x1000.
This used to be done properly until the device tree was converted to
nxp_imx8mimage.

Building these with the offsets built into the binman device tree
changes impacts how the actual image is built and the locations
of the various blobs aren't fetched properly and booting fails.

Fix this by building a standard image as if it were to boot from
eMMC or SD, then use that image as the input for a second image
which adds this FSPI header at 0x400, and then places the standard
image at offset 0x1000.  This also has the benefit of being able
to create both SD/eMMC image at the same time as a fspi image
called flexspi.bin.

Fixes: 37e50627efac ("ARM: dts: imx: Convert i.MX8M flash.bin image generation to binman")
Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/dts/imx8mn-u-boot.dtsi | 266 +++++++++++++++++---------------
 1 file changed, 138 insertions(+), 128 deletions(-)

diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 6875c6d44f..157e6b9a26 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -91,185 +91,195 @@
 };
 
 &binman {
-	filename = "flash.bin";
-	section {
-		pad-byte = <0x00>;
+	multiple-images;
 
-#ifdef CONFIG_FSPI_CONF_HEADER
-		fspi_conf_block {
-			filename = CONFIG_FSPI_CONF_FILE;
-			type = "blob-ext";
-			offset = <0x400>;
-		};
-#endif
+	standard_image: image1 {
+		filename = "flash.bin";
+		section {
+			pad-byte = <0x00>;
 
 #ifdef CONFIG_IMX_HAB
-		nxp-imx8mcst@0 {
-			filename = "u-boot-spl-mkimage.signed.bin";
-			nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
-			nxp,unlock;
-			args;	/* Needed by mkimage etype superclass */
-#endif
-
-			binman_imx_spl: nxp-imx8mimage {
-				filename = "u-boot-spl-mkimage.bin";
-				nxp,boot-from = "sd";
-				nxp,rom-version = <2>;
+			nxp-imx8mcst@0 {
+				filename = "u-boot-spl-mkimage.signed.bin";
 				nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+				nxp,unlock;
 				args;	/* Needed by mkimage etype superclass */
+#endif
 
-				section {
-					filename = "u-boot-spl-ddr.bin";
-					pad-byte = <0xff>;
-					align-size = <4>;
-					align = <4>;
-
-					u-boot-spl {
-						align-end = <4>;
-						filename = "u-boot-spl.bin";
-					};
+				binman_imx_spl: nxp-imx8mimage {
+					filename = "u-boot-spl-mkimage.bin";
+					nxp,boot-from = "sd";
+					nxp,rom-version = <2>;
+					nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+					args;	/* Needed by mkimage etype superclass */
+
+					section {
+						filename = "u-boot-spl-ddr.bin";
+						pad-byte = <0xff>;
+						align-size = <4>;
+						align = <4>;
+
+						u-boot-spl {
+							align-end = <4>;
+							filename = "u-boot-spl.bin";
+						};
 
-					ddr-1d-imem-fw {
+						ddr-1d-imem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_1d_imem.bin";
+							filename = "lpddr4_pmu_train_1d_imem.bin";
 #elif CONFIG_IMX8M_DDR4
-						filename = "ddr4_imem_1d_201810.bin";
+							filename = "ddr4_imem_1d_201810.bin";
 #else
-						filename = "ddr3_imem_1d.bin";
+							filename = "ddr3_imem_1d.bin";
 #endif
-						type = "blob-ext";
-						align-end = <4>;
-					};
+							type = "blob-ext";
+							align-end = <4>;
+						};
 
-					ddr-1d-dmem-fw {
+						ddr-1d-dmem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_1d_dmem.bin";
+							filename = "lpddr4_pmu_train_1d_dmem.bin";
 #elif CONFIG_IMX8M_DDR4
-						filename = "ddr4_dmem_1d_201810.bin";
+							filename = "ddr4_dmem_1d_201810.bin";
 #else
-						filename = "ddr3_dmem_1d.bin";
+							filename = "ddr3_dmem_1d.bin";
 #endif
-						type = "blob-ext";
-						align-end = <4>;
-					};
+							type = "blob-ext";
+							align-end = <4>;
+						};
 
 #if defined(CONFIG_IMX8M_LPDDR4) || defined(CONFIG_IMX8M_DDR4)
-					ddr-2d-imem-fw {
+						ddr-2d-imem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_2d_imem.bin";
+							filename = "lpddr4_pmu_train_2d_imem.bin";
 #else
-						filename = "ddr4_imem_2d_201810.bin";
+							filename = "ddr4_imem_2d_201810.bin";
 #endif
-						type = "blob-ext";
-						align-end = <4>;
-					};
+							type = "blob-ext";
+							align-end = <4>;
+						};
 
-					ddr-2d-dmem-fw {
+						ddr-2d-dmem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_2d_dmem.bin";
+							filename = "lpddr4_pmu_train_2d_dmem.bin";
 #else
-						filename = "ddr4_dmem_2d_201810.bin";
+							filename = "ddr4_dmem_2d_201810.bin";
 #endif
-						type = "blob-ext";
-						align-end = <4>;
-					};
+							type = "blob-ext";
+							align-end = <4>;
+						};
 #endif
+					};
 				};
-			};
 
 #ifdef CONFIG_IMX_HAB
-		};
+			};
 
-		nxp-imx8mcst@1 {
-			filename = "u-boot-fit.signed.bin";
-			nxp,loader-address = <CONFIG_SPL_LOAD_FIT_ADDRESS>;
-#ifdef CONFIG_FSPI_CONF_HEADER
-			offset = <0x59000>;
-#else
-			offset = <0x58000>;
-#endif
-			args;	/* Needed by mkimage etype superclass */
+			nxp-imx8mcst@1 {
+				filename = "u-boot-fit.signed.bin";
+				nxp,loader-address = <CONFIG_SPL_LOAD_FIT_ADDRESS>;
+				offset = <0x58000>;
+				args;	/* Needed by mkimage etype superclass */
 #endif
 
-			binman_imx_fit: fit {
-				description = "Configuration to load ATF before U-Boot";
-				filename = "u-boot.itb";
+				binman_imx_fit: fit {
+					description = "Configuration to load ATF before U-Boot";
+					filename = "u-boot.itb";
 #ifndef CONFIG_IMX_HAB
-				fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+					fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 #endif
-				fit,fdt-list = "of-list";
-				#address-cells = <1>;
-#ifdef CONFIG_FSPI_CONF_HEADER
-				offset = <0x59000>;
-#else
-				offset = <0x58000>;
-#endif
-
-				images {
-					uboot {
-						arch = "arm64";
-						compression = "none";
-						description = "U-Boot (64-bit)";
-						load = <CONFIG_TEXT_BASE>;
-						type = "standalone";
-
-						uboot-blob {
-							filename = "u-boot-nodtb.bin";
-							type = "blob-ext";
+					fit,fdt-list = "of-list";
+					#address-cells = <1>;
+					offset = <0x58000>;
+
+					images {
+						uboot {
+							arch = "arm64";
+							compression = "none";
+							description = "U-Boot (64-bit)";
+							load = <CONFIG_TEXT_BASE>;
+							type = "standalone";
+
+							uboot-blob {
+								filename = "u-boot-nodtb.bin";
+								type = "blob-ext";
+							};
 						};
-					};
 
 #ifndef CONFIG_ARMV8_PSCI
-					atf {
-						arch = "arm64";
-						compression = "none";
-						description = "ARM Trusted Firmware";
-						entry = <0x960000>;
-						load = <0x960000>;
-						type = "firmware";
-
-						atf-blob {
-							filename = "bl31.bin";
-							type = "atf-bl31";
+						atf {
+							arch = "arm64";
+							compression = "none";
+							description = "ARM Trusted Firmware";
+							entry = <0x960000>;
+							load = <0x960000>;
+							type = "firmware";
+
+							atf-blob {
+								filename = "bl31.bin";
+								type = "atf-bl31";
+							};
 						};
-					};
 #endif
 
-					binman_fip: fip {
-						arch = "arm64";
-						compression = "none";
-						description = "Trusted Firmware FIP";
-						load = <0x40310000>;
-						type = "firmware";
-					};
+						binman_fip: fip {
+							arch = "arm64";
+							compression = "none";
+							description = "Trusted Firmware FIP";
+							load = <0x40310000>;
+							type = "firmware";
+						};
 
-					@fdt-SEQ {
-						compression = "none";
-						description = "NAME";
-						type = "flat_dt";
+						@fdt-SEQ {
+							compression = "none";
+							description = "NAME";
+							type = "flat_dt";
 
-						uboot-fdt-blob {
-							filename = "u-boot.dtb";
-							type = "blob-ext";
+							uboot-fdt-blob {
+								filename = "u-boot.dtb";
+								type = "blob-ext";
+							};
 						};
 					};
-				};
 
-				configurations {
-					default = "@config-DEFAULT-SEQ";
+					configurations {
+						default = "@config-DEFAULT-SEQ";
 
-					@config-SEQ {
-						description = "NAME";
-						fdt = "fdt-SEQ";
-						firmware = "uboot";
+						@config-SEQ {
+							description = "NAME";
+							fdt = "fdt-SEQ";
+							firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-						loadables = "atf";
+							loadables = "atf";
 #endif
+						};
 					};
 				};
-			};
 #ifdef CONFIG_IMX_HAB
-		};
+			};
 #endif
+		};
+	};
+
+#ifdef CONFIG_FSPI_CONF_HEADER
+	flexspi_image: image2 {
+		filename = "flexspi.bin";
+		section {
+			pad-byte = <0x00>;
+
+			fspi_conf_block {
+				filename = CONFIG_FSPI_CONF_FILE;
+				type = "blob-ext";
+				offset = <0x400>;
+			};
+
+			flashbin {
+				filename = "flash.bin";
+				type = "blob-ext";
+				offset = <0x1000>;
+			};
+		};
+
 	};
+#endif
 };
-- 
2.45.2

