Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32328CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BBE9831D5;
	Mon, 11 Aug 2025 18:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="Ukvb7++u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 273D68323A; Mon, 11 Aug 2025 18:11:22 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A24831E0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=hwD/g985jJNhQLabPX6V+9+rK2B2guPi5ipafSjbiuM=;
 b=Ukvb7++u2UbX8a5jA3bXv5nlvw3K3MPYEsRNE0/alabvyb9R6UjeNJnz+vhl/l18ukRydS/w4xEuBs5Oo1eX/PvmTdmPDLtelZ1yNf7UVzY8HFK0zgbGfGENoOAptkeuDTVKVKS0pzJK6PlOPCvHv4bw9Te32L80g1YcHoGoxsk=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPA
 ; Mon, 11 Aug 2025 18:11:19 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Tom Rini <trini@konsulko.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/2] sunxi: u-boot.dtsi: add support for signed SPL and
 U-Boot images
Date: Mon, 11 Aug 2025 18:10:34 +0200
Message-Id: <20250811161035.2703435-3-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811161035.2703435-1-lukas.schmid@netcube.li>
References: <20250811161035.2703435-1-lukas.schmid@netcube.li>
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

Add conditional nodes to sunxi-u-boot.dtsi to support building signed
SPL and U-Boot images, using the same #ifdef scheme as in the Rockchip
u-boot.dtsi.  When CONFIG_SPL_FIT_SIGNATURE is enabled, the FIT image
includes hash and signature nodes for firmware, loadables, and device
trees, enabling SPL to verify U-Boot and associated binaries before
boot.

This prepares Sunxi boards for secure boot flows similar to other SoCs.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 arch/arm/dts/sunxi-u-boot.dtsi | 68 ++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
index e1a9a7f5..bb428226 100644
--- a/arch/arm/dts/sunxi-u-boot.dtsi
+++ b/arch/arm/dts/sunxi-u-boot.dtsi
@@ -27,6 +27,38 @@
 #endif
 
 &binman {
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+	spl {
+#ifdef CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0
+		filename = "spl/u-boot-spl.bin";
+#else
+		filename = "spl/sunxi-spl.bin";
+#endif
+
+		u-boot-spl-nodtb {
+		};
+
+		u-boot-spl-pubkey-dtb {
+			algo = "sha256,rsa2048";
+			required = "conf";
+			key-name-hint = "dev";
+		};
+	};
+
+#ifdef CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0
+		image {
+			filename = "spl/sunxi-spl.bin";
+
+			mkimage {
+				args = "-a 0x20060 -T sunxi_toc0";
+				data-to-imagename;
+
+				u-boot-spl {
+		};
+			};
+		};
+#endif
+#endif
 	u-boot-sunxi-with-spl {
 		filename = "u-boot-sunxi-with-spl.bin";
 		pad-byte = <0xff>;
@@ -45,6 +77,9 @@
 			description = "Configuration to load U-Boot and firmware";
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+			fit,sign;
+#endif
 
 			images {
 				uboot {
@@ -60,6 +95,11 @@
 
 					u-boot-nodtb {
 					};
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+					hash {
+						algo = "sha256";
+					};
+#endif
 				};
 
 #if CONFIG_SUNXI_BL31_BASE
@@ -76,6 +116,11 @@
 						filename = "bl31.bin";
 						missing-msg = "atf-bl31-sunxi";
 					};
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+					hash {
+						algo = "sha256";
+					};
+#endif
 				};
 #endif
 
@@ -92,6 +137,11 @@
 						missing-msg = "scp-sunxi";
 						optional;
 					};
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+					hash {
+						algo = "sha256";
+					};
+#endif
 				};
 #endif
 
@@ -99,6 +149,11 @@
 					description = "NAME";
 					type = "flat_dt";
 					compression = "none";
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+					hash {
+						algo = "sha256";
+					};
+#endif
 				};
 			};
 
@@ -108,16 +163,21 @@
 				@config-SEQ {
 					description = "NAME";
 #if CONFIG_SUNXI_BL31_BASE
-					firmware = "atf";
+					firmware = "atf", "uboot";
 #else
 					firmware = "uboot";
 #endif
 #if CONFIG_SUNXI_SCP_BASE
-					loadables = "scp", "uboot";
-#else
-					loadables = "uboot";
+					loadables = "scp";
 #endif
 					fdt = "fdt-SEQ";
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+					signature {
+						algo = "sha256,rsa2048";
+						key-name-hint = "dev";
+						sign-images = "firmware", "loadables", "fdt";
+					};
+#endif
 				};
 			};
 		};
-- 
2.39.5


