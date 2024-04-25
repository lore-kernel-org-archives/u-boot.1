Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B3CC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 23:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7B38908C;
	Fri, 26 Apr 2024 01:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714086105;
	bh=DHYqXHDPY/UpyZD50LtwNOalcqVOZRfU+3VI8jqk2SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L2AgmXw+3H0fl7qXrN5t7Km/bzrG8STgxVjlbsAoHozx38aCX8rs4mhn/MMTPF8gV
	 0UpEc7dWW/hXgd4Xa8ZBZI5QM1SQK+FHcK+u2iQjsh/yNw5WyvpDoGiyNt4/w2vtxC
	 +zL6BiEalX8fXbgAVjRoN+XCpFmboOJ60mrvHMLtcgdHPLSkLAVLrNLFv+ByDcr+Ze
	 AuHL/aoig9xcp/ZFwM+MN4ItamypuapJrrdYj/3zA+zlKG4oC1OJaHbTWRQrIEAOXI
	 M+F24SSGhK1/C94JubMNeyKPQ1zY3yLlGRviJOwKTXEuE17sU6jI4GkIvSLGwn/Y15
	 ceNjYNjH3N9TQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B65D589085;
 Fri, 26 Apr 2024 01:01:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714086103;
 bh=DHYqXHDPY/UpyZD50LtwNOalcqVOZRfU+3VI8jqk2SY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wcHHWSjgBAS80itF9hn9X68pfDoXSqxxzOMsQLjDR/nurzvw8lefLoY8Fplr7JKOY
 qp848bnX0DP/Bny+9FUtch/5GroHYoMPlUpLbb6Q4Zos+MuO9U1r6rAvQZkDce6OvY
 d1i0dfuaU8llHPFADAlxj2BnIXPSfr+FcgK2cuvmWIofCxmmigiVfDOU6cQguOcj98
 ZY/MH5TMhwKLjyqg/u8dpw8zMjw2HOHvhezjSnhTSiYeE0Y1d+i8X0lG8VKr6fI/GM
 zEKcs/y3T0aaE9vBPFViTOcvb44s5DLs6E+cBIwKmARaJQajzbeYGTqouKzt6aY2px
 0ugQgdhkT7n6w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm, u-boot@dh-electronics.com
Subject: [PATCH v2 3/3] ARM: dts: imx: Convert i.MX8M flash.bin image
 generation to binman
Date: Fri, 26 Apr 2024 01:00:37 +0200
Message-ID: <20240425230102.497160-3-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240425230102.497160-1-marex@denx.de>
References: <20240425230102.497160-1-marex@denx.de>
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

Rework the flash.bin image generation such that it uses the new binman
nxp_imx8mimage etype. This way, the flash.bin is assembled in correct
order using plain binman, without any workarounds or sections assembled
in special DT node order.

Reviewed-By: Tim Harvey <tharvey@gateworks.com>
Tested-By: Tim Harvey <tharvey@gateworks.com> # imx8mm_venice
Tested-by: Fabio Estevam <festevam@gmail.com> # imx8mm-evk and imx8mn-evk
Signed-off-by: Marek Vasut <marex@denx.de>
---
WARNING: This is very likely to break corner case uses, so please do
         test this on your platform.
NOTE: This also opens the implementation for proper CST signing etype,
      the CST signing would look similar to nxp-imx8mimage section, and
      it would likely wrap the whole topmost section {} in the binman
      node.
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
V2: Add TB from Fabio/Tim and RB from Tim
---
 arch/arm/dts/imx8mm-u-boot.dtsi               | 126 ++++++---------
 .../dts/imx8mm-verdin-wifi-dev-u-boot.dtsi    |   8 +-
 arch/arm/dts/imx8mn-u-boot.dtsi               | 147 +++++++-----------
 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi         |   2 +-
 arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi    |   2 +-
 arch/arm/dts/imx8mp-u-boot.dtsi               |  96 +++++-------
 arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi    |  15 +-
 arch/arm/dts/imx8mq-u-boot.dtsi               | 109 +++++--------
 8 files changed, 203 insertions(+), 302 deletions(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index 06f2f73a03f..6ab8f66256e 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -5,7 +5,6 @@
 
 / {
 	binman: binman {
-		multiple-images;
 	};
 
 #ifdef CONFIG_OPTEE
@@ -43,56 +42,61 @@
 };
 
 &binman {
-	u-boot-spl-ddr {
-		align = <4>;
-		align-size = <4>;
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
-
-		u-boot-spl {
-			align-end = <4>;
-			filename = "u-boot-spl.bin";
-		};
+	filename = "flash.bin";
+	section {
+		pad-byte = <0x00>;
 
-		ddr-1d-imem-fw {
-			filename = "lpddr4_pmu_train_1d_imem.bin";
-			align-end = <4>;
+#ifdef CONFIG_FSPI_CONF_HEADER
+		fspi_conf_block {
+			filename = CONFIG_FSPI_CONF_FILE;
 			type = "blob-ext";
+			size = <0x1000>;
 		};
+#endif
 
-		ddr-1d-dmem-fw {
-			filename = "lpddr4_pmu_train_1d_dmem.bin";
-			align-end = <4>;
-			type = "blob-ext";
-		};
+		nxp-imx8mimage {
+			filename = "u-boot-spl-mkimage.bin";
+			nxp,boot-from = "sd";
+			nxp,rom-version = <1>;
+			nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+			args;	/* Needed by mkimage etype superclass */
 
-		ddr-2d-imem-fw {
-			filename = "lpddr4_pmu_train_2d_imem.bin";
-			align-end = <4>;
-			type = "blob-ext";
-		};
+			section {
+				align = <4>;
+				align-size = <4>;
+				filename = "u-boot-spl-ddr.bin";
+				pad-byte = <0xff>;
 
-		ddr-2d-dmem-fw {
-			filename = "lpddr4_pmu_train_2d_dmem.bin";
-			align-end = <4>;
-			type = "blob-ext";
-		};
-	};
+				u-boot-spl {
+					align-end = <4>;
+					filename = "u-boot-spl.bin";
+				};
 
-	spl {
-		filename = "spl.bin";
+				ddr-1d-imem-fw {
+					filename = "lpddr4_pmu_train_1d_imem.bin";
+					align-end = <4>;
+					type = "blob-ext";
+				};
 
-		mkimage {
-			args = "-n spl/u-boot-spl.cfgout -T imx8mimage -e 0x7e1000";
+				ddr-1d-dmem-fw {
+					filename = "lpddr4_pmu_train_1d_dmem.bin";
+					align-end = <4>;
+					type = "blob-ext";
+				};
 
-			blob {
-				filename = "u-boot-spl-ddr.bin";
+				ddr-2d-imem-fw {
+					filename = "lpddr4_pmu_train_2d_imem.bin";
+					align-end = <4>;
+					type = "blob-ext";
+				};
+
+				ddr-2d-dmem-fw {
+					filename = "lpddr4_pmu_train_2d_dmem.bin";
+					align-end = <4>;
+					type = "blob-ext";
+				};
 			};
 		};
-	};
-
-	itb {
-		filename = "u-boot.itb";
 
 		fit {
 			description = "Configuration to load ATF before U-Boot";
@@ -101,6 +105,11 @@
 #endif
 			fit,fdt-list = "of-list";
 			#address-cells = <1>;
+#ifdef CONFIG_FSPI_CONF_HEADER
+			offset = <0x58C00>;
+#else
+			offset = <0x57c00>;
+#endif
 
 			images {
 				uboot {
@@ -166,43 +175,6 @@
 			};
 		};
 	};
-
-	imx-boot {
-		filename = "flash.bin";
-		pad-byte = <0x00>;
-
-#ifdef CONFIG_FSPI_CONF_HEADER
-		fspi_conf_block {
-			filename = CONFIG_FSPI_CONF_FILE;
-			type = "blob-ext";
-			size = <0x1000>;
-		};
-
-		spl {
-			filename = "spl.bin";
-			offset = <0x1000>;
-			type = "blob-ext";
-		};
-
-		binman_uboot: uboot {
-			filename = "u-boot.itb";
-			offset = <0x58C00>;
-			type = "blob-ext";
-		};
-#else
-		spl {
-			filename = "spl.bin";
-			offset = <0x0>;
-			type = "blob-ext";
-		};
-
-		binman_uboot: uboot {
-			filename = "u-boot.itb";
-			offset = <0x57c00>;
-			type = "blob-ext";
-		};
-#endif
-	};
 };
 
 &clk {
diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
index 8b397f535c1..90183aff8bc 100644
--- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
@@ -35,8 +35,12 @@
 	bootph-pre-ram;
 };
 
-&binman_uboot {
-	offset = <0x5fc00>;
+&binman {
+	section {
+		fit {
+			offset = <0x5fc00>;
+		};
+	};
 };
 
 &gpio1 {
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 96b1a1bc802..ba9967dbe4a 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -5,7 +5,6 @@
 
 / {
 	binman: binman {
-		multiple-images;
 	};
 
 #ifdef CONFIG_OPTEE
@@ -92,78 +91,83 @@
 };
 
 &binman {
-	 u-boot-spl-ddr {
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
-		align-size = <4>;
-		align = <4>;
-
-		u-boot-spl {
-			align-end = <4>;
-			filename = "u-boot-spl.bin";
+	filename = "flash.bin";
+	section {
+		pad-byte = <0x00>;
+
+#ifdef CONFIG_FSPI_CONF_HEADER
+		fspi_conf_block {
+			filename = CONFIG_FSPI_CONF_FILE;
+			type = "blob-ext";
+			offset = <0x400>;
 		};
+#endif
 
-		ddr-1d-imem-fw {
+		nxp-imx8mimage {
+			filename = "u-boot-spl-mkimage.bin";
+			nxp,boot-from = "sd";
+			nxp,rom-version = <2>;
+			nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+			args;	/* Needed by mkimage etype superclass */
+
+			section {
+				filename = "u-boot-spl-ddr.bin";
+				pad-byte = <0xff>;
+				align-size = <4>;
+				align = <4>;
+
+				u-boot-spl {
+					align-end = <4>;
+					filename = "u-boot-spl.bin";
+				};
+
+				ddr-1d-imem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-			filename = "lpddr4_pmu_train_1d_imem.bin";
+					filename = "lpddr4_pmu_train_1d_imem.bin";
 #elif CONFIG_IMX8M_DDR4
-			filename = "ddr4_imem_1d_201810.bin";
+					filename = "ddr4_imem_1d_201810.bin";
 #else
-			filename = "ddr3_imem_1d.bin";
+					filename = "ddr3_imem_1d.bin";
 #endif
-			type = "blob-ext";
-			align-end = <4>;
-		};
+					type = "blob-ext";
+					align-end = <4>;
+				};
 
-		ddr-1d-dmem-fw {
+				ddr-1d-dmem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-			filename = "lpddr4_pmu_train_1d_dmem.bin";
+					filename = "lpddr4_pmu_train_1d_dmem.bin";
 #elif CONFIG_IMX8M_DDR4
-			filename = "ddr4_dmem_1d_201810.bin";
+					filename = "ddr4_dmem_1d_201810.bin";
 #else
-			filename = "ddr3_dmem_1d.bin";
+					filename = "ddr3_dmem_1d.bin";
 #endif
-			type = "blob-ext";
-			align-end = <4>;
-		};
+					type = "blob-ext";
+					align-end = <4>;
+				};
 
 #if defined(CONFIG_IMX8M_LPDDR4) || defined(CONFIG_IMX8M_DDR4)
-		ddr-2d-imem-fw {
+				ddr-2d-imem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-			filename = "lpddr4_pmu_train_2d_imem.bin";
+					filename = "lpddr4_pmu_train_2d_imem.bin";
 #else
-			filename = "ddr4_imem_2d_201810.bin";
+					filename = "ddr4_imem_2d_201810.bin";
 #endif
-			type = "blob-ext";
-			align-end = <4>;
-		};
+					type = "blob-ext";
+					align-end = <4>;
+				};
 
-		ddr-2d-dmem-fw {
+				ddr-2d-dmem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-			filename = "lpddr4_pmu_train_2d_dmem.bin";
+					filename = "lpddr4_pmu_train_2d_dmem.bin";
 #else
-			filename = "ddr4_dmem_2d_201810.bin";
+					filename = "ddr4_dmem_2d_201810.bin";
 #endif
-			type = "blob-ext";
-			align-end = <4>;
-		};
+					type = "blob-ext";
+					align-end = <4>;
+				};
 #endif
-	};
-
-	spl {
-		filename = "spl.bin";
-
-		mkimage {
-			args = "-n spl/u-boot-spl.cfgout -T imx8mimage -e 0x912000";
-
-			blob {
-				filename = "u-boot-spl-ddr.bin";
 			};
 		};
-	};
-
-	itb {
-		filename = "u-boot.itb";
 
 		fit {
 			description = "Configuration to load ATF before U-Boot";
@@ -172,6 +176,11 @@
 #endif
 			fit,fdt-list = "of-list";
 			#address-cells = <1>;
+#ifdef CONFIG_FSPI_CONF_HEADER
+			offset = <0x59000>;
+#else
+			offset = <0x58000>;
+#endif
 
 			images {
 				uboot {
@@ -237,42 +246,4 @@
 			};
 		};
 	};
-
-	imx-boot {
-		filename = "flash.bin";
-		pad-byte = <0x00>;
-
-#ifdef CONFIG_FSPI_CONF_HEADER
-		fspi_conf_block {
-			filename = CONFIG_FSPI_CONF_FILE;
-			type = "blob-ext";
-			offset = <0x400>;
-		};
-
-		spl {
-			filename = "spl.bin";
-			offset = <0x1000>;
-			type = "blob-ext";
-		};
-
-		binman_uboot: uboot {
-			filename = "u-boot.itb";
-			offset = <0x59000>;
-			type = "blob-ext";
-		};
-#else
-
-		spl {
-			offset = <0x0>;
-			filename = "spl.bin";
-			type = "blob-ext";
-		};
-
-		binman_uboot: uboot {
-			offset = <0x58000>;
-			filename = "u-boot.itb";
-			type = "blob-ext";
-		};
-#endif
-	};
 };
diff --git a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
index b05be57e71b..cb37e28f28f 100644
--- a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
@@ -136,7 +136,7 @@
 };
 
 &binman {
-	itb {
+	section {
 		fit {
 			images {
 				fdt-dto-imx8mp-dhcom-som-overlay-eth1xfast {
diff --git a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi b/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
index 22171bd344e..aff5dcf615d 100644
--- a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
@@ -136,7 +136,7 @@
 };
 
 &binman {
-	itb {
+	section {
 		fit {
 			images {
 				fip {
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 4fadcaea509..c4c1a177102 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -6,7 +6,6 @@
 
 / {
 	binman: binman {
-		multiple-images;
 	};
 
 #ifdef CONFIG_OPTEE
@@ -83,55 +82,52 @@
 #endif
 
 &binman {
-	 u-boot-spl-ddr {
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
-		align-size = <4>;
-		align = <4>;
-
-		u-boot-spl {
-			align-end = <4>;
-		};
+	filename = "flash.bin";
+	section {
+		pad-byte = <0x00>;
 
-		ddr-1d-imem-fw {
-			filename = "lpddr4_pmu_train_1d_imem_202006.bin";
-			type = "blob-ext";
-			align-end = <4>;
-		};
+		nxp-imx8mimage {
+			filename = "u-boot-spl-mkimage.bin";
+			nxp,boot-from = "sd";
+			nxp,rom-version = <2>;
+			nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+			args;	/* Needed by mkimage etype superclass */
 
-		ddr-1d-dmem-fw {
-			filename = "lpddr4_pmu_train_1d_dmem_202006.bin";
-			type = "blob-ext";
-			align-end = <4>;
-		};
+			section {
+				filename = "u-boot-spl-ddr.bin";
+				pad-byte = <0xff>;
+				align-size = <4>;
+				align = <4>;
 
-		ddr-2d-imem-fw {
-			filename = "lpddr4_pmu_train_2d_imem_202006.bin";
-			type = "blob-ext";
-			align-end = <4>;
-		};
+				u-boot-spl {
+					align-end = <4>;
+				};
 
-		ddr-2d-dmem-fw {
-			filename = "lpddr4_pmu_train_2d_dmem_202006.bin";
-			type = "blob-ext";
-			align-end = <4>;
-		};
-	};
+				ddr-1d-imem-fw {
+					filename = "lpddr4_pmu_train_1d_imem_202006.bin";
+					type = "blob-ext";
+					align-end = <4>;
+				};
 
-	spl {
-		filename = "spl.bin";
+				ddr-1d-dmem-fw {
+					filename = "lpddr4_pmu_train_1d_dmem_202006.bin";
+					type = "blob-ext";
+					align-end = <4>;
+				};
 
-		mkimage {
-			args = "-n spl/u-boot-spl.cfgout -T imx8mimage -e 0x920000";
+				ddr-2d-imem-fw {
+					filename = "lpddr4_pmu_train_2d_imem_202006.bin";
+					type = "blob-ext";
+					align-end = <4>;
+				};
 
-			blob {
-				filename = "u-boot-spl-ddr.bin";
+				ddr-2d-dmem-fw {
+					filename = "lpddr4_pmu_train_2d_dmem_202006.bin";
+					type = "blob-ext";
+					align-end = <4>;
+				};
 			};
 		};
-	};
-
-	itb {
-		filename = "u-boot.itb";
 
 		fit {
 			description = "Configuration to load ATF before U-Boot";
@@ -140,6 +136,7 @@
 #endif
 			fit,fdt-list = "of-list";
 			#address-cells = <1>;
+			offset = <0x58000>;
 
 			images {
 				uboot {
@@ -195,21 +192,4 @@
 			};
 		};
 	};
-
-	imx-boot {
-		filename = "flash.bin";
-		pad-byte = <0x00>;
-
-		spl {
-			filename = "spl.bin";
-			offset = <0x0>;
-			type = "blob-ext";
-		};
-
-		binman_uboot: uboot {
-			filename = "u-boot.itb";
-			offset = <0x58000>;
-			type = "blob-ext";
-		};
-	};
 };
diff --git a/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi b/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi
index e3341a46d63..1a4568dac65 100644
--- a/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi
@@ -11,14 +11,13 @@
 };
 
 &binman {
-	/delete-node/ signed-hdmi;
-
-	signed-hdmi {
-		filename = "signed_hdmi.bin";
-
-		signed-dp-imx8m {
-			filename = "signed_dp_imx8m.bin";
-			type = "blob-ext";
+	section {
+		nxp-imx8mimage {
+			section {
+				signed-hdmi-imx8m {
+					filename = "signed_dp_imx8m.bin";
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index 90b2274754b..48dbe94f0c4 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -5,7 +5,6 @@
 
 / {
 	binman: binman {
-		multiple-images;
 	};
 
 };
@@ -35,65 +34,58 @@
 };
 
 &binman {
-	u-boot-spl-ddr {
-		align = <4>;
-		align-size = <4>;
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
-
-		u-boot-spl {
-			align-end = <4>;
-			filename = "u-boot-spl.bin";
-		};
+	filename = "flash.bin";
+	section {
+		pad-byte = <0x00>;
 
-		ddr-1d-imem-fw {
-			filename = "lpddr4_pmu_train_1d_imem.bin";
-			align-end = <4>;
-			type = "blob-ext";
-		};
+		nxp-imx8mimage {
+			filename = "u-boot-spl-mkimage.bin";
+			nxp,boot-from = "sd";
+			nxp,rom-version = <1>;
+			nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+			args;	/* Needed by mkimage etype superclass */
 
-		ddr-1d-dmem-fw {
-			filename = "lpddr4_pmu_train_1d_dmem.bin";
-			align-end = <4>;
-			type = "blob-ext";
-		};
-
-		ddr-2d-imem-fw {
-			filename = "lpddr4_pmu_train_2d_imem.bin";
-			align-end = <4>;
-			type = "blob-ext";
-		};
+			section {
+				align = <4>;
+				align-size = <4>;
+				filename = "u-boot-spl-ddr.bin";
+				pad-byte = <0xff>;
 
-		ddr-2d-dmem-fw {
-			filename = "lpddr4_pmu_train_2d_dmem.bin";
-			align-end = <4>;
-			type = "blob-ext";
-		};
-	};
+				u-boot-spl {
+					align-end = <4>;
+					filename = "u-boot-spl.bin";
+				};
 
-	signed-hdmi {
-		filename = "signed_hdmi.bin";
+				ddr-1d-imem-fw {
+					filename = "lpddr4_pmu_train_1d_imem.bin";
+					align-end = <4>;
+					type = "blob-ext";
+				};
 
-		signed-hdmi-imx8m {
-			filename = "signed_hdmi_imx8m.bin";
-			type = "blob-ext";
-		};
-	};
+				ddr-1d-dmem-fw {
+					filename = "lpddr4_pmu_train_1d_dmem.bin";
+					align-end = <4>;
+					type = "blob-ext";
+				};
 
-	spl {
-		filename = "spl.bin";
+				ddr-2d-imem-fw {
+					filename = "lpddr4_pmu_train_2d_imem.bin";
+					align-end = <4>;
+					type = "blob-ext";
+				};
 
-		mkimage {
-			args = "-n spl/u-boot-spl.cfgout -T imx8mimage -e 0x7e1000";
+				ddr-2d-dmem-fw {
+					filename = "lpddr4_pmu_train_2d_dmem.bin";
+					align-end = <4>;
+					type = "blob-ext";
+				};
 
-			blob {
-				filename = "u-boot-spl-ddr.bin";
+				signed-hdmi-imx8m {
+					filename = "signed_hdmi_imx8m.bin";
+					type = "blob-ext";
+				};
 			};
 		};
-	};
-
-	itb {
-		filename = "u-boot.itb";
 
 		fit {
 			description = "Configuration to load ATF before U-Boot";
@@ -158,21 +150,4 @@
 			};
 		};
 	};
-
-	imx-boot {
-		filename = "flash.bin";
-		pad-byte = <0x00>;
-
-		spl {
-			filename = "spl.bin";
-			offset = <0x0>;
-			type = "blob-ext";
-		};
-
-		binman_uboot: uboot {
-			filename = "u-boot.itb";
-			offset = <0x57c00>;
-			type = "blob-ext";
-		};
-	};
 };
-- 
2.43.0

