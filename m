Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7412D109C057
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9C48408D;
	Wed, 25 Mar 2026 20:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="iwEahxxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5F9783DA7; Wed, 25 Mar 2026 20:27:26 +0100 (CET)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E23F83DA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=WqS98PaNxS2RmnM1eHM++iejeGjh5scYoEE4+zGI1Is=;
 b=iwEahxxZ9RUs/4q2wRijscN0Y7S7m+chu6LV02pUFs8FPETGHef+H2kHJLEaPYFQ0x2vlRsv0OLvc632WIbWm4ezffaEMhS+AD5unX4CsOHOp8EvsDAAvqt8hUz7k9DYuBkKJ/lE/W/RkSN8qrOrzkA1Il1QaXA7zdAbMrJGLcU=
Received: from lukas-hpz440workstation.lan.sk100508.local
 (193-80-178-216.hdsl.highway.telekom.at [193.80.178.216])
 by mail.netcube.li with ESMTPA ; Wed, 25 Mar 2026 20:27:23 +0100
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH 5/6] sunxi: extend binman FIT description for signed SPL images
Date: Wed, 25 Mar 2026 20:26:12 +0100
Message-ID: <20260325192628.750398-6-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325192628.750398-1-lukas.schmid@netcube.li>
References: <20260325192628.750398-1-lukas.schmid@netcube.li>
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

Extend the sunxi binman/FIT description to support signed SPL FIT
images. Add an SPL public-key DTB image, per-image hash nodes,
fit,sign support, and a configuration signature that covers
firmware, loadables and the selected FDT.

Handle TOC0 SPL output as well by adding the required filename and
mkimage wrapping so the generated sunxi image remains verifiable.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 arch/arm/dts/sunxi-u-boot.dtsi | 68 ++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
index e1a9a7f5d4c..313fcad3922 100644
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
+	image {
+		filename = "spl/sunxi-spl.bin";
+
+		mkimage {
+			args = "-a 0x20060 -T sunxi_toc0";
+			data-to-imagename;
+
+			u-boot-spl {
+			};
+		};
+	};
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
2.47.3


