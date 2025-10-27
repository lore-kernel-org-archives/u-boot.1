Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3055CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 15:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE5D583700;
	Mon, 27 Oct 2025 16:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36F4C82A9E; Mon, 27 Oct 2025 16:51:36 +0100 (CET)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BAAF82E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 16:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cwJ055mFkz12Pq;
 Mon, 27 Oct 2025 16:51:33 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cwJ050xGVzJlJ; Mon, 27 Oct 2025 16:51:33 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 27 Oct 2025 16:51:22 +0100
Subject: [PATCH 1/3] rockchip: binman: template all of simple-bin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-rockchip-more-template-v1-1-430672840303@cherry.de>
References: <20251027-rockchip-more-template-v1-0-430672840303@cherry.de>
In-Reply-To: <20251027-rockchip-more-template-v1-0-430672840303@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

We may generate two different "simple-bin", one for MMC and one for SPI
flashes, respectively named u-boot-rockchip.bin and
u-boot-rockchip-spi.bin.

There aren't many differences between the two, namely:
- the TPL+SPL called "idbloader" has (for some SoCs) a different type
  to pass to mkimage arguments, namely rksd vs rkspi,
- because of the above, two images are generated, idbloader.img for MMC
  and idbloader-spi.img for SPI,
- we cannot install twice the same file, so even though the content of
  the FIT is the same for both MMC and SPI, we only expose one to the
  user (u-boot.itb filename),
- the FIT can be stored at different offsets for MMC and SPI, the former
  is typically controlled by CONFIG_SPL_PAD_TO but for the latter it
  typically is from CONFIG_SYS_SPI_U_BOOT_OFFS,

binman templating allows to override or supplement templates from the
inserter side, so let's just do that to remove even more duplication.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rockchip-u-boot.dtsi | 284 +++++++++++++++++++-------------------
 1 file changed, 140 insertions(+), 144 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index cc2feed6464..736f3598539 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -43,132 +43,10 @@
 
 #ifdef CONFIG_SPL
 &binman {
-#ifdef HAS_FIT
-	fit_template: template-1 {
-		type = "fit";
-#ifdef CONFIG_ARM64
-		description = "FIT image for U-Boot with bl31 (TF-A)";
-#else
-		description = "FIT image with OP-TEE";
-#endif
-		#address-cells = <1>;
-		fit,fdt-list = "of-list";
-		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
-		fit,align = <512>;
-		images {
-			u-boot {
-				description = "U-Boot";
-				type = "standalone";
-				os = "u-boot";
-				arch = FIT_ARCH;
-				compression = FIT_UBOOT_COMP;
-				load = <CONFIG_TEXT_BASE>;
-				entry = <CONFIG_TEXT_BASE>;
-				u-boot-nodtb {
-					compress = FIT_UBOOT_COMP;
-				};
-#ifdef FIT_HASH_ALGO
-				hash {
-					algo = FIT_HASH_ALGO;
-				};
-#endif
-			};
-
-#ifdef CONFIG_ARM64
-			@atf-SEQ {
-				fit,operation = "split-elf";
-				description = "ARM Trusted Firmware";
-				type = "firmware";
-				arch = FIT_ARCH;
-				os = "arm-trusted-firmware";
-				compression = "none";
-				fit,load;
-				fit,entry;
-				fit,data;
-
-				atf-bl31 {
-				};
-#ifdef FIT_HASH_ALGO
-				hash {
-					algo = FIT_HASH_ALGO;
-				};
-#endif
-			};
-			@tee-SEQ {
-				fit,operation = "split-elf";
-				description = "TEE";
-				type = "tee";
-				arch = FIT_ARCH;
-				os = "tee";
-				compression = "none";
-				fit,load;
-				fit,entry;
-				fit,data;
-
-				tee-os {
-					optional;
-				};
-#ifdef FIT_HASH_ALGO
-				hash {
-					algo = FIT_HASH_ALGO;
-				};
-#endif
-			};
-#else /* !CONFIG_ARM64 */
-			op-tee {
-				description = "OP-TEE";
-				type = "tee";
-				arch = FIT_ARCH;
-				os = "tee";
-				compression = "none";
-				load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
-				entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
-
-				tee-os {
-				};
-#ifdef FIT_HASH_ALGO
-				hash {
-					algo = FIT_HASH_ALGO;
-				};
-#endif
-			};
-#endif /* CONFIG_ARM64 */
-
-			@fdt-SEQ {
-				description = "fdt-NAME";
-				compression = "none";
-				type = "flat_dt";
-#ifdef FIT_HASH_ALGO
-				hash {
-					algo = FIT_HASH_ALGO;
-				};
-#endif
-			};
-		};
-
-		configurations {
-			default = "@config-DEFAULT-SEQ";
-			@config-SEQ {
-				description = "NAME.dtb";
-				fdt = "fdt-SEQ";
-#ifdef CONFIG_ARM64
-				fit,firmware = "atf-1", "u-boot";
-#else
-				fit,firmware = "op-tee", "u-boot";
-#endif
-				fit,loadables;
-				fit,compatible;
-			};
-		};
-	};
-#endif /* HAS_FIT */
-
-	simple-bin {
-		filename = "u-boot-rockchip.bin";
+	simple_bin_template: template-1 {
 		pad-byte = <0xff>;
 
 		mkimage {
-			filename = "idbloader.img";
 			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
 			multiple-data-files;
 
@@ -185,39 +63,157 @@
 
 #ifdef HAS_FIT
 		fit {
-			filename = "u-boot.itb";
-			insert-template = <&fit_template>;
+			type = "fit";
+#ifdef CONFIG_ARM64
+			description = "FIT image for U-Boot with bl31 (TF-A)";
+#else
+			description = "FIT image with OP-TEE";
+#endif
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+			fit,align = <512>;
+			offset = <CONFIG_SPL_PAD_TO>;
+			images {
+				u-boot {
+					description = "U-Boot";
+					type = "standalone";
+					os = "u-boot";
+					arch = FIT_ARCH;
+					compression = FIT_UBOOT_COMP;
+					load = <CONFIG_TEXT_BASE>;
+					entry = <CONFIG_TEXT_BASE>;
+					u-boot-nodtb {
+						compress = FIT_UBOOT_COMP;
+					};
+#ifdef FIT_HASH_ALGO
+					hash {
+						algo = FIT_HASH_ALGO;
+					};
+#endif
+				};
+
+#ifdef CONFIG_ARM64
+				@atf-SEQ {
+					fit,operation = "split-elf";
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = FIT_ARCH;
+					os = "arm-trusted-firmware";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					atf-bl31 {
+					};
+#ifdef FIT_HASH_ALGO
+					hash {
+						algo = FIT_HASH_ALGO;
+					};
+#endif
+				};
+				@tee-SEQ {
+					fit,operation = "split-elf";
+					description = "TEE";
+					type = "tee";
+					arch = FIT_ARCH;
+					os = "tee";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					tee-os {
+						optional;
+					};
+#ifdef FIT_HASH_ALGO
+					hash {
+						algo = FIT_HASH_ALGO;
+					};
+#endif
+				};
+#else /* !CONFIG_ARM64 */
+				op-tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = FIT_ARCH;
+					os = "tee";
+					compression = "none";
+					load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
+					entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
+
+					tee-os {
+					};
+#ifdef FIT_HASH_ALGO
+					hash {
+						algo = FIT_HASH_ALGO;
+					};
+#endif
+				};
+#endif /* CONFIG_ARM64 */
+
+				@fdt-SEQ {
+					description = "fdt-NAME";
+					compression = "none";
+					type = "flat_dt";
+#ifdef FIT_HASH_ALGO
+					hash {
+						algo = FIT_HASH_ALGO;
+					};
+#endif
+				};
+			};
+
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "NAME.dtb";
+					fdt = "fdt-SEQ";
+#ifdef CONFIG_ARM64
+					fit,firmware = "atf-1", "u-boot";
+#else
+					fit,firmware = "op-tee", "u-boot";
+#endif
+					fit,loadables;
+					fit,compatible;
+				};
+			};
+		};
 #else
 		u-boot-img {
-#endif
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
+#endif
 	};
 
-#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
-	simple-bin-spi {
-		filename = "u-boot-rockchip-spi.bin";
-		pad-byte = <0xff>;
+	simple-bin {
+		insert-template = <&simple_bin_template>;
+		filename = "u-boot-rockchip.bin";
 
 		mkimage {
-			filename = "idbloader-spi.img";
-			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
-			multiple-data-files;
-
-#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
-			rockchip-tpl {
-			};
-#elif defined(CONFIG_TPL)
-			u-boot-tpl {
-			};
-#endif
-			u-boot-spl {
-			};
+			filename = "idbloader.img";
+		};
+
+#ifdef HAS_FIT
+		fit {
+			filename = "u-boot.itb";
+		};
+#endif
+	};
+
+#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
+	simple-bin-spi {
+		insert-template = <&simple_bin_template>;
+		filename = "u-boot-rockchip-spi.bin";
+
+		mkimage {
+			filename = "idbloader-spi.img";
+			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
 		};
 
 #ifdef HAS_FIT
 		fit {
-			insert-template = <&fit_template>;
 #else
 		u-boot-img {
 #endif

-- 
2.51.0

