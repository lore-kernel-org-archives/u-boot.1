Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC99C55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 067FC810AD;
	Thu, 30 Jul 2026 14:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8rj9LJ0-2r4w; Thu, 30 Jul 2026 14:18:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06CAD810F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785421123;
	bh=1HxquT60c463UuvqsAhwFvB0ZpmhZQSQ1UIxMJrE0yw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0yYIk3NlwejDcdeJg2IRDA1kyaxVIBzI2HUTVDOdnE2aWpZG+GuC9Ip+1UvPy8cEw
	 miUFn5L7muY65cUFKptGFqjTSOLbdnNloBgTTtQBqM95OqlKynbyeZIA+CU88NYwuN
	 BGA+hMB1hypCF3zVEUlLDoZ9h4MhzJ+i78WiVxkcNoQkWzeNAu+pWVrajA80F1RJrJ
	 xdAmpjXv3MywQO1me7R1vdufVpvdVslUx2Sm0edrB5OiB+RjBRvQcNR3L0mYysafHV
	 djiqmWVBOWURX8Y29TF8h2f2w2B+vplOh9XTXdxvRzLg0zSxUYGwyMK0Aij3bgJPXV
	 S4ZXmbawttE0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06CAD810F8;
	Thu, 30 Jul 2026 14:18:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D9501197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB7E6401A3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GgkOj06ySAJC for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:18:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BF1414008C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF1414008C
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF1414008C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:40 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15f020a223so336886766b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 07:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421119; x=1786025919;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1HxquT60c463UuvqsAhwFvB0ZpmhZQSQ1UIxMJrE0yw=;
 b=oTISkwJkKcV5tgx9Sme9zycVus5fRvzij/p2KqdmVQSxeT+4fd7H0PebCSiWxmvPBQ
 Ih0T8fMr56XVUiyntsqh6nxUJBsdkJi/x7mkofBUeG8OoCCjwYyqtp6Sas4vsTjakhAl
 oNsix29xlXAw2dwQcnemt81Vtjk5BUEBPbv+9L/PWnBesf7dt8sa3H4vYD0izj+vPjmP
 lRdRJqj4WMgAxfxnBTP033Pq8J7T4+/WyN0AtG2g2YhSqW1IN9I9mLsQK0NVUW0J3i3X
 UgPQZ1OA81ufycR74CRuOJKzbgk0s9HQuEgorRC11Gp7BmxJkvqUTQBOkkeYyUDanC+t
 ZVLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RorgPMUj2XGcdBpgBiAQnLsauyI2M/cOwnGGyaXb4HOjYYsDDSz9N+AdsGdYxDLPG4pC+GFDn0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx2C1u8IhK9Y7Ow3msY1slzO7jiqq3OiR7F2BUKO5XQ9adphEtu
 Az0XDEwnpRCnPcuuGOAxNaU2ackfiV+o5cgTxII3x4WRUhylaofE7xmYfJqbS0meOTI=
X-Gm-Gg: AR+sD11KJU7XnHQ0jIg8ZoOZNUYf1DaUoBA83VZ3+fGv0QcEPvTJRM9XSRtt/RL4SiQ
 PFRyJojjb5weyqIYixAaEElc4vYvR16yCj1g5B2lZV7GMreFWfCE9a0kx3+VsHArRf6GsZhz7oi
 Ewgaue7mJT0WoYxfGXllh1Hr6ZW4O6+HeXzuGhpe+qohQeQwPIBpdaRbefxgSVBNCryxAoGtzgL
 uvb4drCpC3nxkjzstgINxhfgyuz8ctT0zfOE1bIyEXxnIIZuapEnuUeNDXXWQuupio9A2gLUF3e
 sA4TYLZle+K5JSpncmWupLyHKg+SsEZQs4W1NZlXOL7vGUBHCk+Ys/VMWYx/5r7KSTqd3HF0BMH
 npHzm2A7he5vnWowEA2C219XIUxDvE1R71rRZZ4iTln9UlgTjoiwlgp2ZB7O16bvXon8XOiK5IB
 bFn21wX8mmA3qsFCFtuJhToI8ban6pbPxWpeP5NJ5r3ID+eNmRUCpGu81G4oeLtewvCsAGWidwh
 TrJ738mN5BPF/P9UCmq1ohQZrlBwNUAJfNY1kO/PUw/tKlEijEM4W5nahWhmGm3jL9T7dZH29V2
 pln08g==
X-Received: by 2002:a17:907:3e84:b0:c16:46b1:e0c2 with SMTP id
 a640c23a62f3a-c1fa57b058dmr147192666b.62.1785421118498; 
 Thu, 30 Jul 2026 07:18:38 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851b369sm78608266b.9.2026.07.30.07.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:18:36 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 30 Jul 2026 16:18:09 +0200
Subject: [PATCH v3 3/6] arm: mediatek: build Genio 510 and 700 boot images
 with binman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-ccaione-upstream-mt8390-spl-v3-3-82fb3bca27a4@baylibre.com>
References: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
In-Reply-To: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785421119; x=1786025919;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1HxquT60c463UuvqsAhwFvB0ZpmhZQSQ1UIxMJrE0yw=;
 b=ENMtgrxtJQTEydhIyOtITxNoHCmPCUyPoXYv242bV/d+s4b3b3bt/tw1knEru0CS+4
 ETJ+NujWvhkA7qC2xKz6HFK19zzegXP4c+77HmDq7QgmevJ0eFfurOys9L6ZZaDf9Z70
 HtyR4XHl89XvKoNBDDUftgvybw2xayyt1ODmoWCI/4Cdo2xY/5ck12f+rlgnfXzpe04h
 ATou6TS8PCICL5gxyx6OBYEv5cbEHhMr+Tzw0iIKiYkJT1m5a7EaY6f5fEP1s/NB96lB
 QiyxGhKpNQvnMxTMEN12ZzD+DPzoj0inVmoH/DyfyolXLGNUdjugwYRLZz3Z3w0uu4Gz
 lX4Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ENMtgrxt
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

The complete Genio 510 and Genio 700 boot-chain images depend on
platform firmware built outside U-Boot. Keep image assembly opt-in
through CONFIG_MTK_BOOT_IMAGES so the default configurations build
U-Boot proper and SPL without requiring external blobs, while
integration builds can enable the canonical binman image layout.

mtk-boot.bin wraps an external DDR loader, padded to its fixed
0x4b000-byte ABI, followed by a CONFIG_SPL_MAX_SIZE U-Boot SPL region
in a MediaTek eMMC BootROM image. The external loader copies that
complete fixed-size SPL window, so pad the region to keep every source
byte inside the BootROM-loaded payload.

bootloaders.img is a conventional FIT containing BL31, U-Boot proper,
OP-TEE, and the U-Boot control devicetree. Both boards share this layout,
with their descriptions supplied by the board-specific U-Boot
devicetree includes.

Use the standard BL31 and TEE binman inputs and obtain ddr-loader.bin
through BINMAN_INDIRS. Disable SPL binman symbols by default on MT8188
because SPL does not consume runtime offsets for entries in mtk-boot.bin
and U-Boot proper lives in a separate storage image. SPL locates U-Boot
through the GPT FIT partition, so there are no in-image U-Boot offsets
to publish.

Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |   7 ++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |   7 ++
 arch/arm/dts/mt8390-genio-common-binman.dtsi  | 127 ++++++++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                |   8 ++
 board/mediatek/MAINTAINERS                    |   1 +
 common/spl/Kconfig                            |   1 +
 6 files changed, 151 insertions(+)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 1a5f45cba6b..fa03e6ac05e 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -4,4 +4,11 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
+#include <config.h>
 #include "mt8390-genio-common-u-boot.dtsi"
+
+#ifdef CONFIG_MTK_BOOT_IMAGES
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 510 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 510 boot chain"
+#include "mt8390-genio-common-binman.dtsi"
+#endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 1a5f45cba6b..f8e7e78a25f 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -4,4 +4,11 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
+#include <config.h>
 #include "mt8390-genio-common-u-boot.dtsi"
+
+#ifdef CONFIG_MTK_BOOT_IMAGES
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 700 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 700 boot chain"
+#include "mt8390-genio-common-binman.dtsi"
+#endif
diff --git a/arch/arm/dts/mt8390-genio-common-binman.dtsi b/arch/arm/dts/mt8390-genio-common-binman.dtsi
new file mode 100644
index 00000000000..c16282027c6
--- /dev/null
+++ b/arch/arm/dts/mt8390-genio-common-binman.dtsi
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+/ {
+	binman: binman {
+		multiple-images;
+	};
+};
+
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
+			description = MTK_BOOTLOADERS_DESCRIPTION;
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
+					description = MTK_BOOT_CHAIN_DESCRIPTION;
+					firmware = "atf";
+					loadables = "uboot", "optee";
+					fdt = "uboot-fdt";
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 5e6c50ca64d..05ba7c209bc 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -210,6 +210,14 @@ config MTK_BROM_HEADER_INFO
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
+config MTK_BOOT_IMAGES
+	bool "Build MediaTek firmware images"
+	depends on TARGET_MT8188 && SPL
+	select BINMAN
+	help
+	  Enable binman to assemble the MediaTek BootROM image and firmware
+	  FIT from U-Boot and external platform firmware components.
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index d0d25b096e5..83662079068 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -24,6 +24,7 @@ S:	Maintained
 F:	arch/arm/dts/mt8188-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+F:	arch/arm/dts/mt8390-genio-common-binman.dtsi
 F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0618f42c941..e5d0aade7fc 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -194,6 +194,7 @@ config SPL_SHOW_ERRORS
 config SPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in SPL"
 	depends on SPL_FRAMEWORK && BINMAN
+	default n if TARGET_MT8188
 	default y
 	help
 	  This enables use of symbols in SPL which refer to other entries in

-- 
2.55.0

