Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66137C4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 16:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF5F84979;
	Sat, 18 Jul 2026 18:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Ncaxx8Jx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBBD84A49; Sat, 18 Jul 2026 18:16:42 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F7E849AA
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 18:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493f45e20cdso51816105e9.2
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784391400; x=1784996200; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sjuIc3MYdCAzwXqk28qKXY/5pZHkMivM3NJAOMSJqQ8=;
 b=Ncaxx8JxzJNJ3+Cz66LRo0P308iFco1CxeFLCKk437SMwtMIJUME14h4Skd6Q08lnr
 gfftjy8RH1r0dk1NxykA8BLgCOBtsBnvlRtyHLD7phL5YWgZG+DKqaKBdYA41vMU06M6
 btNBZ263ILiGtqVpohjkWRIEW0TxGYe+PdXjyaDYTXb5G2LWpqtPX1n6L9LtQuAkw4tN
 i/aFKdkpti1V+R41pWL8wAlylUbn9DCDAimxA1dCt7vb9h66QvwhuGH3Qg9bAzRbT/mQ
 PaJJgvz/E22afihoHaCdxyBphGpxr1X8yfrJXgU5GFK4V5r+cBMXgbaci0nHdYvFCcFk
 8kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784391400; x=1784996200;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sjuIc3MYdCAzwXqk28qKXY/5pZHkMivM3NJAOMSJqQ8=;
 b=MTHGyD+91sKkjKkj9k9m5bqATSAZkTfCX/kzs0fWhEeQivdbuzH57EapJv7QvXKlqJ
 E2WN9wDKRejknZpnLo4/tqpvbHoYGXJVOA45JJyxJzAbL0VcSKjej4i13Ia12mcGlsFL
 zXJ6U34qv2Iz91Qm0BU58blsvgQ2GWB5wlPiGM1q5+1t7aPx0M1oU+gI+b4YNIECXbc6
 jMt6b0LqhCmrqgiF4NLy0fN0rl/CNRCjgyPQpL8CVaHK9aB+0jaOOZ4u5hfE8Ihr6ccZ
 Tm9CME31AjvAZmZlsio9GKTUqggcL/FpFyYWWLOrwfB62Fe1v3lTTbguoTzyx3AVyB2S
 1ANw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnV1g3N9ZMI0IsuLwj2M/NWtOSuzeXymGrP0+snlh8yET+TyC598piUbyjWPeTWGXTO0jfCD8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7N3xzMI6EbJfan+USCTnOTzWAkSZhp/JowIzyHsWbkfeHz+JK
 7KoZgn8XKNFl9uhZ+Y0HXNuvCavkLwpBz5b6ANbDX+z7SOMOw+7FAP1lwTo2eyq90OM=
X-Gm-Gg: AfdE7cnNg84TtaaWtqc7A8pTQHPdpM235CLen3Vv9kffBQaJvTn8uXvzo2CmEmyng0t
 0bJncIrWeble8NlvjbdGJr30IKfwaxmdDZukjB35w7Ia8py7VF7ifaBVd+JVgoOPWgIxkZW2Pj2
 I57d6bYFWGgF+tj8mdwr7HhlXy5sok9hotUasb8yBuLb/PoPa3SiEdvisDlozfJnOsG36v/Jc2+
 zbdZVtPDm4Now4LKYevNv86e09o7vQelnoiMQbcv+xyi2bU+jomrXvGKKOj6F6CsnNIGNTRva4b
 yGTiYAS3CFtcsAqwRjwo46BHOQdxryAAjbxXLm7CBpKT17Q5tZiwJYmVx2VYna4d1IKT/J8+XC3
 ABmFMMNE1MjRUbm4c4xtChuMye98ZH+7NVbHJ0ydw8Hxh/c27l5w4ISLVSfv6/6C/WehR0F0uLT
 HpSd4K99g/tPNBbEabA3IQzrIk61t+uSAgkz/QLAqJszZFNOW0uhSu5DrTsdJuifSynktwWhzdX
 3e2QROeTde/j8Slqcyv
X-Received: by 2002:a05:600c:6298:b0:493:c182:6b08 with SMTP id
 5b1f17b1804b1-4954a5125a0mr84528415e9.36.1784391399628; 
 Sat, 18 Jul 2026 09:16:39 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499d1d4asm88915955e9.2.2026.07.18.09.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 09:16:38 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sat, 18 Jul 2026 18:16:09 +0200
Subject: [PATCH 3/4] arm: mediatek: mt8390: build boot images with binman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ccaione-upstream-mt8390-spl-v1-3-1256b6dfda3f@baylibre.com>
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
In-Reply-To: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
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

Generate the Genio 700 boot-chain images from the U-Boot build.

mtk-boot.bin wraps an external DDR loader, padded to its fixed
0x4b000-byte ABI, followed by a CONFIG_SPL_MAX_SIZE U-Boot SPL region
in a MediaTek eMMC BootROM image. The external loader copies that
complete fixed-size SPL window, so pad the region to keep every source
byte inside the BootROM-loaded payload.

bootloaders.img is a conventional FIT containing BL31, U-Boot proper,
OP-TEE, and the U-Boot control devicetree.

Use the standard BL31 and TEE binman inputs and obtain ddr-loader.bin
through BINMAN_INDIRS. Disable SPL binman symbols because SPL and
U-Boot proper live in separate storage images. SPL locates U-Boot
through the GPT FIT partition, so there are no in-image U-Boot offsets
to publish.

Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi | 120 ++++++++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                |   1 +
 configs/mt8390_genio_700_evk_defconfig        |   1 +
 3 files changed, 122 insertions(+)

diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index ace9944ec41..69dc6e9d181 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -5,14 +5,134 @@
  * Author: Carlo Caione <ccaione@baylibre.com>
  */
 
+#include <config.h>
 #include "mt8188-u-boot.dtsi"
 
 / {
+	binman: binman {
+		multiple-images;
+	};
+
 	memory@40000000 {
 		bootph-pre-ram;
 	};
 };
 
+&binman {
+	mtk-boot {
+		filename = "mtk-boot.bin";
+
+		mkimage {
+			args = "-T", "mtk_image",
+			       "-a", "0x201000",
+			       "-e", "0x201000",
+			       "-n", "media=emmc;arm64=1";
+
+			section {
+				pad-byte = <0>;
+
+				/* Must match SPL_OFFSET in the external DDR loader. */
+				ddr-loader {
+					type = "blob-ext";
+					filename = "ddr-loader.bin";
+					size = <0x4b000>;
+				};
+
+				u-boot-spl {
+					size = <CONFIG_SPL_MAX_SIZE>;
+				};
+			};
+		};
+	};
+
+	bootloaders {
+		filename = "bootloaders.img";
+
+		fit {
+			description = "MediaTek Genio 700 bootloaders";
+			#address-cells = <1>;
+
+			images {
+				uboot {
+					description = "U-Boot";
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm64";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+					entry = <CONFIG_TEXT_BASE>;
+
+					u-boot-nodtb {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+				};
+
+				atf {
+					description = "ARM Trusted Firmware BL31";
+					type = "firmware";
+					os = "arm-trusted-firmware";
+					arch = "arm64";
+					compression = "none";
+					load = <0x54601000>;
+					entry = <0x54601000>;
+
+					atf-bl31 {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+				};
+
+				optee {
+					description = "OP-TEE";
+					type = "firmware";
+					os = "tee";
+					arch = "arm64";
+					compression = "none";
+					load = <0x431fffe4>;
+					entry = <0x43200000>;
+
+					tee-os {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+				};
+
+				uboot-fdt {
+					description = "U-Boot control devicetree";
+					type = "flat_dt";
+					arch = "arm64";
+					compression = "none";
+
+					u-boot-dtb {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf";
+
+				conf {
+					description = "Genio 700 boot chain";
+					firmware = "atf";
+					loadables = "uboot", "optee";
+					fdt = "uboot-fdt";
+				};
+			};
+		};
+	};
+};
+
 &mmc0_default_pins {
 	bootph-pre-ram;
 
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 5e6c50ca64d..9ff7e7a7f5e 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -87,6 +87,7 @@ config TARGET_MT8183
 config TARGET_MT8188
 	bool "MediaTek MT8188 SoC"
 	select ARM64
+	select BINMAN if SPL
 	help
 	  The MediaTek MT8188 is a ARM64-based SoC with a dual-core Cortex-A78
 	  cluster and a six-core Cortex-A55 cluster. It includes UART, SPI,
diff --git a/configs/mt8390_genio_700_evk_defconfig b/configs/mt8390_genio_700_evk_defconfig
index 5730b056e29..1287cdf0af6 100644
--- a/configs/mt8390_genio_700_evk_defconfig
+++ b/configs/mt8390_genio_700_evk_defconfig
@@ -2,6 +2,7 @@
 
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
 CONFIG_SPL=y
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
 CONFIG_SPL_TEXT_BASE=0x40000000
 CONFIG_SPL_MAX_SIZE=0xaf000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y

-- 
2.55.0

