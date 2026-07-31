Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86972C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B72560B53;
	Fri, 31 Jul 2026 17:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oGBHGswYWMNP; Fri, 31 Jul 2026 17:19:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E34DF60B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518346;
	bh=guvN4UDS226D45SvgsiVbh815ThyB4qpPGg4v4iaL6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OZhQ7IMupmKb2HgcEk22hWbz6N1zR1gOL/n5VHJN6gTzUMyrrUfoMx644vgpS8kDD
	 EZRLW6uYa3vJuIrs8W0Wn0OjQlejkPPISIOx38vvhAWJChh9CJ0M2zpFNM+jGW/Ug2
	 m8MKaVkYXZ5xm+mwjE7Dtfu0g6+P6hoBlDHShwNCOXd4tNE7xfZe4ODSdkdfVjzrhL
	 q/1Vf9IFY06CYLGYaDd05IzEal2dxRM26mOdNwNAj3UhcGlcRTGvVp+jf3He+ZvJvw
	 4KQE13f39EPyvyaTBJOeHqlCjXxBn45Tg/MebT1Kxo7k+RpVj0BITmzy9GcHdcbCUq
	 hGQtrVPGDY7bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E34DF60B25;
	Fri, 31 Jul 2026 17:19:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7801636E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69D6260680
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mRUSufdSgJRf for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 17:12:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3E65F6067D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E65F6067D
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E65F6067D
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:59 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f752b3423so1118364f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517918; x=1786122718;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=guvN4UDS226D45SvgsiVbh815ThyB4qpPGg4v4iaL6w=;
 b=MZhb8sxlcG5Rqkbizwbts46kpEGoCn3KjEU/X19rFlXr0ZNtW9/8rM7pTEqxGaVGJw
 4JXLF8yUhciyofnQR5SPFMqDLT9AWIBEK+0ylbOdomzdnBKh+/8aZcRQXCt8MJCuhtey
 K2o6fwJbGmoJmJxm5iwdOOgcP8Az7xC18ckDx6EKJocyE1ND+Csd7DfO1IlUWJGradUn
 YIelOIQJNXobST1TSBkWNY0CuklAAGwdZDkYV9uKZGZX2eAKNjhUa/n9oVpaAxFCFqPS
 BaZVfaRyXrQRIuq4E068j6f10mb/WvM98xj8+nTqtC4p2ojTyGuwd1fthmPBsWwWFWhy
 ui0Q==
X-Gm-Message-State: AOJu0YxzaNj0421tDHH7XSQhOVqcGUB3BcEFUobsCjZRoFb5pGB4mSC6
 yBF6AryUBId2fcHXMYeqgbzUTNH6Gnv3uNuuSnBHz26ZU7FSJ/JEiqDZenT37VrIpUQ=
X-Gm-Gg: AR+sD10W7OKkZNbsfSywoujZfytCfRWjQLyXRnAuNpoRrkQ+h9qRjzgR+S7czTs5vrC
 Id03iZKFBSCgQNryie+LE9XSIZL/rHhZVZJ1FuoXJ12LNwZHWzRqYlrqvE+kBTAhciaMHLKu8g5
 U7xojeJiUxoinKukh8BVtQHoeceD9aLNRO/sCZCmS+3pD+m3Hil2z4WR6gjMZgU5LoitdjeW93h
 u+3WieQEtzJsEi6pxuCifedurqBzjF57RNhVFlst5u0W+1S7CSUafzrDpfiouAadc/gc/wx2LLb
 MTaJ1ENeVsshyJvSwdUrp46PgDigVDSD92cXus7sdIgnKJJ/+kALPAbDoWG/YeAGpcuN1o3aVTT
 t6UhRDl9UJPpzlxoXwQplA4etvst7m9fclhWlnhjTa+D+oSS9SV3sF8HVNVsi/KSlrxP/j2Zuyn
 tAOYvMb9EnsqwUnH4nRU4Uy7AWUOIiXRI0yrJW7AXN79e337+THhcHZJAhcUkqle9eRm6hM/1mz
 w7PP3ygrD5Ph7JI4BpEVXJX0F5beR48tEQj74aA7g==
X-Received: by 2002:a05:6000:1f07:b0:47d:ec60:658e with SMTP id
 ffacd0b85a97d-47fd72e2b99mr709746f8f.25.1785517917927; 
 Fri, 31 Jul 2026 10:11:57 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm7541484f8f.7.2026.07.31.10.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 10:11:57 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 21:10:53 +0400
Subject: [PATCH v2 09/10] rockchip: binman: Add support for Falcon mode FIT
 images with TF-A+Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10667; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=nb3GcAtQSWwTypZA3auKv0ZuzDsSY/XgZzfy7Z3Yeq0=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlXFd66jzl4u/Ahf6WXA0/2T9wxnbPqdfU/j4v6pSr3
 e73S7IvdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVZssZGVac+Tc3IzjIoXux44k9OQfyY31bTOL/rsm6x7eM+1xt1SdGhh131n8
 7ur/OK0Flb8zhBIdVtg/+iwqo+zVIvZVh1Ev4yAQA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:18:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785517918; x=1786122718;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=guvN4UDS226D45SvgsiVbh815ThyB4qpPGg4v4iaL6w=;
 b=mVsPn/sdCSGH82pJKePVGYTB52aiTZNxC5/whvBRwQ6/Ddpmw4qCmFxhXglxc7GDkR
 FfjS4rBa8J0H2z1TEYbVbD0XI+ZpIK4fd4qZQ5huZNsBkJXy9HoDkSNsiGGJ5ZssX1WK
 tqvFOX2OHTH38DSy73vc7wEYg42kEvnIDUOcHlZ9cxuqrdT2kj0SMgelpNkNhpJ7YqpW
 ga3IfhoY85IlcCO/Ai/ud8NNJD1DR6teE6G8JTZwSJ9KFvIEA+QkocH/5uLLZhudWrh0
 4taAsJPPiUsCJ8XNWIVatyvkTe/sEOGTRHpW//DYNsBucur2ADxY55bPpnQLfz9jY0XH
 1Yqg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=mVsPn/sd
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Modern Rockchip SoCs such as RK3576 require TF-A to be running to provide
firmware services to the OS. To enable booting Linux in Falcon mode on
such SoCs, add a binman template for generation of FIT images containing
appropriately split TF-A and TEE binaries (as is currently done by binman
for U-boot proper images), externally provided Linux kernel and optionally
an initrd.

Any FDTs provided to the generator will be pre-patched with a /chosen
node containing an initrd load address and size (if an initrd is provided)
and a bootargs property containing the kernel command line (if provided),
so that the kernel can be booted directly without external preprocessing.

A config fragment rockchip-falcon.config can be used to enable Falcon
mode boot and the building of TF-A+Falcon with binman, e.g.:

  make nanopi-m5-rk3576_defconfig \
        rockchip-falcon.config

This will produce a FIT image u-boot-rockchip-falcon.itb containing TF-A,
TEE, Linux kernel and optionally an initrd, which can be flashed to UFS
and booted in Falcon mode.

This can also be combined with the existing rockchip-ramboot.config
fragment to obtain images suitable for booting from RAM, e.g.:

  make nanopi-m5-rk3576_defconfig \
        rockchip-falcon.config \
        rockchip-ramboot.config

The resulting images can be uploaded directly to RAM via Maskrom with no
storage or USB loader required, e.g.:

  rockusb download-sram u-boot-rockchip-usb471.bin
  rockusb download-ddr u-boot-rockchip-usb472-falcon.bin

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/dts/rockchip-u-boot.dtsi     | 204 ++++++++++++++++++++++++++++------
 arch/arm/mach-rockchip/Kconfig        |  49 ++++++++
 board/rockchip/rockchip-falcon.config |   3 +
 3 files changed, 225 insertions(+), 31 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 4ba6a87e78ab..5e23ff761751 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -35,6 +35,16 @@
 #define HAS_FIT
 #endif
 
+#ifdef CONFIG_ROCKCHIP_FALCON_IMAGE
+/* Falcon-mode load addresses, relative to the SoC DRAM base. */
+#define FALCON_KERNEL_LOAD \
+	(CFG_SYS_SDRAM_BASE + CONFIG_ROCKCHIP_FALCON_KERNEL_LOAD)
+#define FALCON_FDT_LOAD \
+	(CFG_SYS_SDRAM_BASE + CONFIG_ROCKCHIP_FALCON_FDT_LOAD)
+#define FALCON_INITRD_LOAD \
+	(CFG_SYS_SDRAM_BASE + CONFIG_ROCKCHIP_FALCON_INITRD_LOAD)
+#endif
+
 / {
 	binman: binman {
 		multiple-images;
@@ -44,37 +54,13 @@
 #ifdef CONFIG_SPL
 &binman {
 #ifdef HAS_FIT
-	fit_template: template-1 {
-		type = "fit";
 #ifdef CONFIG_ARM64
-		description = "FIT image for U-Boot with bl31 (TF-A)";
-#else
-		description = "FIT image with OP-TEE";
-#endif
-		#address-cells = <1>;
-		fit,fdt-list = "of-list";
-		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
-		fit,align = <512>;
+	/*
+	 * Shared ARM Trusted Firmware (BL31) and optional OP-TEE split-elf
+	 * images, reused by both the U-Boot and Falcon Linux FIT templates.
+	 */
+	fit_firmware_template: template-firmware {
 		images {
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
 			@atf-SEQ {
 				fit,operation = "split-elf";
 				description = "ARM Trusted Firmware";
@@ -114,7 +100,42 @@
 				};
 #endif
 			};
-#else /* !CONFIG_ARM64 */
+		};
+	};
+#endif /* CONFIG_ARM64 */
+
+	fit_template: template-1 {
+		type = "fit";
+#ifdef CONFIG_ARM64
+		description = "FIT image for U-Boot with bl31 (TF-A)";
+		insert-template = <&fit_firmware_template>;
+#else
+		description = "FIT image with OP-TEE";
+#endif
+		#address-cells = <1>;
+		fit,fdt-list = "of-list";
+		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+		fit,align = <512>;
+		images {
+			u-boot {
+				description = "U-Boot";
+				type = "standalone";
+				os = "u-boot";
+				arch = FIT_ARCH;
+				compression = FIT_UBOOT_COMP;
+				load = <CONFIG_TEXT_BASE>;
+				entry = <CONFIG_TEXT_BASE>;
+				u-boot-nodtb {
+					compress = FIT_UBOOT_COMP;
+				};
+#ifdef FIT_HASH_ALGO
+				hash {
+					algo = FIT_HASH_ALGO;
+				};
+#endif
+			};
+
+#ifndef CONFIG_ARM64
 			op-tee {
 				description = "OP-TEE";
 				type = "tee";
@@ -132,7 +153,7 @@
 				};
 #endif
 			};
-#endif /* CONFIG_ARM64 */
+#endif /* !CONFIG_ARM64 */
 
 			@fdt-SEQ {
 				description = "fdt-NAME";
@@ -161,6 +182,97 @@
 			};
 		};
 	};
+
+#ifdef CONFIG_ROCKCHIP_FALCON_IMAGE
+	fit_falcon_template: template-falcon {
+		type = "fit";
+		description = "FIT image for Falcon Linux with bl31 (TF-A)";
+		insert-template = <&fit_firmware_template>;
+		#address-cells = <1>;
+		fit,fdt-list = "of-list";
+		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+		fit,align = <512>;
+
+		images {
+			kernel {
+				description = "Linux kernel";
+				type = "kernel";
+				arch = FIT_ARCH;
+				os = "linux";
+				compression = FIT_UBOOT_COMP;
+				load = <FALCON_KERNEL_LOAD>;
+				entry = <FALCON_KERNEL_LOAD>;
+
+				linux-kernel {
+					compress = FIT_UBOOT_COMP;
+				};
+#ifdef FIT_HASH_ALGO
+				hash {
+					algo = FIT_HASH_ALGO;
+				};
+#endif
+			};
+
+			ramdisk {
+				description = "ramdisk";
+				type = "ramdisk";
+				arch = FIT_ARCH;
+				compression = "none";
+				load = <FALCON_INITRD_LOAD>;
+
+				linux-initrd {
+					optional;
+				};
+#ifdef FIT_HASH_ALGO
+				hash {
+					algo = FIT_HASH_ALGO;
+				};
+#endif
+			};
+
+			@fdt-SEQ {
+				description = "fdt-NAME";
+				type = "flat_dt";
+				arch = FIT_ARCH;
+				compression = "none";
+				load = <FALCON_FDT_LOAD>;
+#ifdef CONFIG_USE_BOOTARGS
+				fit,bootargs = CONFIG_BOOTARGS;
+#endif
+				fit,initrd = "ramdisk";
+#ifdef FIT_HASH_ALGO
+				hash {
+					algo = FIT_HASH_ALGO;
+				};
+#endif
+			};
+		};
+
+		configurations {
+			default = "@config-DEFAULT-SEQ";
+			@config-SEQ {
+				description = "NAME.dtb";
+				fit,firmware = "atf-1", "kernel", "ramdisk";
+				fit,loadables;
+				fit,compatible;
+				fdt = "fdt-SEQ";
+#ifdef FIT_HASH_ALGO
+				hash {
+					algo = FIT_HASH_ALGO;
+				};
+#endif
+			};
+		};
+	};
+
+	falcon-fit {
+		filename = "u-boot-rockchip-falcon.itb";
+
+		fit {
+			insert-template = <&fit_falcon_template>;
+		};
+	};
+#endif
 #endif /* HAS_FIT */
 
 	simple-bin {
@@ -260,6 +372,36 @@
 		};
 		};
 	};
+
+#ifdef CONFIG_ROCKCHIP_FALCON_IMAGE
+	simple-bin-usb472-falcon {
+		filename = "u-boot-rockchip-usb472-falcon.bin";
+		pad-byte = <0x00>;
+
+		u-boot-spl {
+		};
+
+		payload {
+			type = "section";
+			align = <CONFIG_SYS_CACHELINE_SIZE>;
+			/*
+			 * Must be named 'u-boot-any', unlike the non-Falcon
+			 * image which can call this 'fit': SPL declares
+			 * binman_sym(u_boot_any, image_pos) unconditionally, and
+			 * binman resolves that symbol against an entry of that
+			 * exact name or one called u-boot[-elf|-img|-nodtb].
+			 * Those only exist here by way of a U-Boot image inside
+			 * the FIT, which a Falcon FIT does not carry, so without
+			 * this name the symbol cannot be resolved and binman
+			 * fails. The type property is what selects the etype.
+			 */
+			u-boot-any {
+				type = "fit";
+				insert-template = <&fit_falcon_template>;
+			};
+		};
+	};
+#endif
 #endif /* CONFIG_ROCKCHIP_MASKROM_IMAGE */
 };
 #endif /* CONFIG_SPL */
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e7..321afc0fbdf6 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -758,6 +758,55 @@ config ROCKCHIP_MASKROM_IMAGE
 	  Rockchip SoCs support maskrom mode boot over USB. Enable this
 	  option to produce maskrom mode boot images containing U-Boot.
 
+config ROCKCHIP_FALCON_IMAGE
+	bool "Build a Falcon mode image for Rockchip"
+	depends on SPL_OS_BOOT && ARM64 && SPL_ATF && SPL_FIT
+	help
+	  Enable this option to produce a FIT image which SPL can use to boot
+	  Linux directly via TF-A, bypassing U-Boot proper (Falcon mode).
+
+	  The image bundles TF-A (BL31), an optional OP-TEE, a Linux kernel
+	  and an optional initramfs, and its device trees are pre-patched with
+	  a /chosen node so that no further processing is needed before boot.
+	  The kernel is mandatory and must be supplied at build time with
+	  LINUX_KERNEL=/path/to/Image; pass LINUX_INITRD=/path/to/initramfs to
+	  include an initramfs as well.
+
+	  This only controls image generation. Say N to build a Falcon-capable
+	  SPL without bundling a kernel into the U-Boot image, for example when
+	  the OS payload is assembled and written to storage separately.
+
+config ROCKCHIP_FALCON_KERNEL_LOAD
+	hex "Falcon mode kernel load offset"
+	depends on ROCKCHIP_FALCON_IMAGE
+	default 0x10000000
+	help
+	  Offset from the start of DRAM at which the Falcon mode kernel is
+	  loaded and entered.
+
+	  All three Falcon mode load offsets have to be checked against the
+	  memory layout of the SoC and of the firmware in use. None of the
+	  three payloads may overlap each other, and none of them may overlap
+	  the regions BL31 and OP-TEE are linked to run from - note that
+	  binman splits their ELFs, so each of those occupies several regions
+	  rather than one contiguous range.
+
+config ROCKCHIP_FALCON_FDT_LOAD
+	hex "Falcon mode devicetree load offset"
+	depends on ROCKCHIP_FALCON_IMAGE
+	default 0x1c000000
+	help
+	  Offset from the start of DRAM at which the Falcon mode devicetree is
+	  loaded. The same constraints as for the kernel offset apply.
+
+config ROCKCHIP_FALCON_INITRD_LOAD
+	hex "Falcon mode initramfs load offset"
+	depends on ROCKCHIP_FALCON_IMAGE
+	default 0x1e000000
+	help
+	  Offset from the start of DRAM at which the Falcon mode initramfs is
+	  loaded. The same constraints as for the kernel offset apply.
+
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default TEXT_BASE
 
diff --git a/board/rockchip/rockchip-falcon.config b/board/rockchip/rockchip-falcon.config
new file mode 100644
index 000000000000..ac903f16f46a
--- /dev/null
+++ b/board/rockchip/rockchip-falcon.config
@@ -0,0 +1,3 @@
+CONFIG_ROCKCHIP_FALCON_IMAGE=y
+CONFIG_SPL_OS_BOOT=y
+CONFIG_SYS_SPI_KERNEL_OFFS=0x0

-- 
2.54.0

