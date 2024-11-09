Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43C2D5E37F
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 20:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D53A890C1;
	Sat,  9 Nov 2024 21:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CSTDnupK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F116C88E96; Sat,  9 Nov 2024 21:06:31 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B740B892E8
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 21:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-460d2571033so23421381cf.1
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 12:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731182788; x=1731787588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzvkW8rraqCAf1pRZoDHWtSY5WIfNgCZRWyEIUAmbsQ=;
 b=CSTDnupKiQkG/FXPrVShCD0cntxLVG+TumH4Si4jmUSNN2Yk4KMHn05jFDMng8WGPZ
 McYXfBlhXpuNMEVvc77N2VEbPzZ5Hpq1P+f1yVZ7FFXcovGNbLY/gUSyvX9ua4Rh1PsK
 rzjbt5tPioacGJo3XfdXRhf3a+0sE4Rw3wfReYgCze1mcVQIjkRXhIYOdDzPr1/p/80+
 q87f4l8Rf1Y40LKifeHaGSB2ko+R2+iCLAz4Iz3mMAOP5yW90uGV9Q48kTzzWoeKWkHF
 UM1ANInZ/D04PsNkk3NhU9RDO1saf927ul0/IGSu77TwPJyfUJy4+izumiZtBRzFELYD
 aXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731182788; x=1731787588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzvkW8rraqCAf1pRZoDHWtSY5WIfNgCZRWyEIUAmbsQ=;
 b=usRX3upoJbzEBTm35BGfkSjys0zVLuFGhH89td6fwavP/AbHu31MO7JUcW/Z4cFs0z
 jEl4YL27Ky5AqvTfHBB2VvbGSeVrkEDaw4RSh/KOWUgyIDXyvip/fRrCM4b0/jSd73P0
 vdp13ZxU+nhHQMFiT1q6Iedf6Zs6eHDf80WOKiRC/FPtVa1rA4mMBkoFOmcLk8Yq35Ym
 nTewSAOqCUcb2vA6H39S6Dx/+cIXDee8ROqJMu8mLSLPeR/xjEQqgDQtm6Vd6Bmg5GgS
 SvVnrP9UaAKjfZE8OAlXrk5NARXpvj+yOaKJZByd5rfc784Hr76EaLhkI1jvDBL97mFt
 iL5A==
X-Gm-Message-State: AOJu0YzneDjuNTRn4nkTysNpUfwJEMEeEa7PBuEh0FLD9N3cYi4TapN7
 oM/vFm5lBE5MP/YEXzkC3IpjnkUQ8tM2XU3ffuLSPA8ik4S8XnCjgV2kAw==
X-Google-Smtp-Source: AGHT+IFKXchphDnK9GG1tUNSan6vh2mKzXPPctxWD3G3y6EBt7ACgxoAGJfSXZozxQOrGlM0p1psFw==
X-Received: by 2002:a05:622a:4d:b0:458:3032:f463 with SMTP id
 d75a77b69052e-4630942c5fdmr87425431cf.46.1731182788181; 
 Sat, 09 Nov 2024 12:06:28 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff5d678asm36525341cf.85.2024.11.09.12.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 12:06:27 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, lukma@denx.de, Adam Ford <aford173@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 4/4] arm64: dts: imx8mm: Fix FSPI booting
Date: Sat,  9 Nov 2024 14:06:05 -0600
Message-ID: <20241109200610.1615430-5-aford173@gmail.com>
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
that there is a configuration file prepended at location 0. The
start of the file that would normally be flash.bin starts at 0x1000.
This used to be done properly until the device tree was converted to
nxp_imx8mimage.

Building these with the offsets built into the binman device tree
changes impacts how the actual image is built and the locations
of the various blobs aren't fetched properly and booting fails.

Fix this by building flash.bin as if the prepended header did not
exist, then assemble a second file called flexspi.bin which
has the contents of flash.bin starting at address 0x1000 with the
FSPI header at address 0.  Unlike Nano, which has a different rev
of the boot ROM, the "nxp,boot-from" parameter needs to be set
to fspi instead of sd.

Fixes: 37e50627efac ("ARM: dts: imx: Convert i.MX8M flash.bin image generation to binman")
Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 259 +++++++++++++++++---------------
 1 file changed, 135 insertions(+), 124 deletions(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index d31bc82253..83593026b0 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -42,165 +42,176 @@
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
-			size = <0x1000>;
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
-				nxp,rom-version = <1>;
+			nxp-imx8mcst@0 {
+				filename = "u-boot-spl-mkimage.signed.bin";
 				nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+				nxp,unlock;
 				args;	/* Needed by mkimage etype superclass */
+#endif
 
-				section {
-					align = <4>;
-					align-size = <4>;
-					filename = "u-boot-spl-ddr.bin";
-					pad-byte = <0xff>;
-
-					u-boot-spl {
-						align-end = <4>;
-						filename = "u-boot-spl.bin";
-					};
+				binman_imx_spl: nxp-imx8mimage {
+					filename = "u-boot-spl-mkimage.bin";
+#ifdef CONFIG_FSPI_CONF_HEADER
+					nxp,boot-from = "fspi";
+#else
+					nxp,boot-from = "sd";
+#endif
+					nxp,rom-version = <1>;
+					nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+					args;	/* Needed by mkimage etype superclass */
+
+					section {
+						align = <4>;
+						align-size = <4>;
+						filename = "u-boot-spl-ddr.bin";
+						pad-byte = <0xff>;
+
+						u-boot-spl {
+							align-end = <4>;
+							filename = "u-boot-spl.bin";
+						};
 
-					ddr-1d-imem-fw {
-						filename = "lpddr4_pmu_train_1d_imem.bin";
-						align-end = <4>;
-						type = "blob-ext";
-					};
+						ddr-1d-imem-fw {
+							filename = "lpddr4_pmu_train_1d_imem.bin";
+							align-end = <4>;
+							type = "blob-ext";
+						};
 
-					ddr-1d-dmem-fw {
-						filename = "lpddr4_pmu_train_1d_dmem.bin";
-						align-end = <4>;
-						type = "blob-ext";
-					};
+						ddr-1d-dmem-fw {
+							filename = "lpddr4_pmu_train_1d_dmem.bin";
+							align-end = <4>;
+							type = "blob-ext";
+						};
 
-					ddr-2d-imem-fw {
-						filename = "lpddr4_pmu_train_2d_imem.bin";
-						align-end = <4>;
-						type = "blob-ext";
-					};
+						ddr-2d-imem-fw {
+							filename = "lpddr4_pmu_train_2d_imem.bin";
+							align-end = <4>;
+							type = "blob-ext";
+						};
 
-					ddr-2d-dmem-fw {
-						filename = "lpddr4_pmu_train_2d_dmem.bin";
-						align-end = <4>;
-						type = "blob-ext";
+						ddr-2d-dmem-fw {
+							filename = "lpddr4_pmu_train_2d_dmem.bin";
+							align-end = <4>;
+							type = "blob-ext";
+						};
 					};
 				};
-			};
 #ifdef CONFIG_IMX_HAB
-		};
-
-		nxp-imx8mcst@1 {
-			filename = "u-boot-fit.signed.bin";
-			nxp,loader-address = <CONFIG_SPL_LOAD_FIT_ADDRESS>;
-#ifdef CONFIG_FSPI_CONF_HEADER
-			offset = <0x58C00>;
-#else
-			offset = <0x57c00>;
-#endif
-
-			args;	/* Needed by mkimage etype superclass */
-#endif
+			};
 
-			binman_imx_fit: fit {
-				description = "Configuration to load ATF before U-Boot";
-				filename = "u-boot.itb";
-#ifndef CONFIG_IMX_HAB
-				fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
-#endif
-				fit,fdt-list = "of-list";
-				#address-cells = <1>;
-#ifdef CONFIG_FSPI_CONF_HEADER
-				offset = <0x58C00>;
-#else
+			nxp-imx8mcst@1 {
+				filename = "u-boot-fit.signed.bin";
+				nxp,loader-address = <CONFIG_SPL_LOAD_FIT_ADDRESS>;
 				offset = <0x57c00>;
+				args;	/* Needed by mkimage etype superclass */
 #endif
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
+				binman_imx_fit: fit {
+					description = "Configuration to load ATF before U-Boot";
+					filename = "u-boot.itb";
+#ifndef CONFIG_IMX_HAB
+					fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+	#endif
+					fit,fdt-list = "of-list";
+					#address-cells = <1>;
+					offset = <0x57c00>;
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
-						entry = <0x920000>;
-						load = <0x920000>;
-						type = "firmware";
-
-						atf-blob {
-							filename = "bl31.bin";
-							type = "atf-bl31";
+						atf {
+							arch = "arm64";
+							compression = "none";
+							description = "ARM Trusted Firmware";
+							entry = <0x920000>;
+							load = <0x920000>;
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
 	};
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
+			};
+
+			flashbin {
+				filename = "flash.bin";
+				type = "blob-ext";
+				offset = <0x1000>;
+			};
+		};
+
+	};
+#endif
 };
 
 &clk {
-- 
2.45.2

