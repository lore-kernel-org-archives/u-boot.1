Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92573C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 656C9406DA;
	Thu, 27 Aug 2026 07:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d725aCXoLMH6; Thu, 27 Aug 2026 07:35:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816133;
	bh=8puldNUPP2NeYb5jN7oDbZ6b/C/v9b40CM7vKpDUYQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qw8ee3+E9HqZLmDbrMGfrXOLIOgHD8piqfYoavC6sgYpIifCxPP/WIaqjRMIL2Kl8
	 cb4DxZjieK3gJT5AFBmRdthDjQjroZ7WjtAwFCj3PnBHR44ItyaXW39d3NZxJksjyy
	 +LLEtlY9NMA4BJqO28qSJH0ubloPJ3sNwL4TaOq5o+ut51cj3YIz9Q/KPbg7hXeTja
	 VrSL6RHqTZgVPMrkIFdDwU+ed1bWigP2oXYWOJ4ZWPP3RSD344s6bmRaYPvQBKpJbz
	 LjoojvINuItZ6rW8ljdvB476VvVZgqjBjf3ZYDgkeexz5ON/1ERTzrfgoZJI+F2qHD
	 KPqEszbFLUUkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 115D5406B3;
	Thu, 27 Aug 2026 07:35:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 08F8C39E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDC366077C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id us63dI39jZCz for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:35:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YI76i+Gy
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B5536076B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:26 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-482e2fdf5abso754542f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787816125; x=1788420925;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8puldNUPP2NeYb5jN7oDbZ6b/C/v9b40CM7vKpDUYQs=;
 b=YI76i+GyP9QMvAcCymrMEDKza/d4viKwFTVoZNQzTkoHn+RNjYpihWeFp/5AeWwnSH
 6KH/tdFxCbyjbbRSrOYEOgwQHWC1kC9ZT+jVG3KCEupkCeGaK7ZgioyxcQLy51gBVZ6o
 3J9g/vz7Gcmh8bP7GmXfjNR/dps6LBSb1k77AZW3pZX5mCp+0ewSepW8Ilxzqv5rYCEa
 jxPxxK7uX+Q/Q2lbZ5m/dt4xHtYbHArD6L3n24sKT7BQCow3S+jfytTTvB9hCG5f8F8e
 7swG36Ry6VvlTq1uUM3adHZ15hjeTXH901O1GLmc7aazxTWJ+Kk+/+Ap+RrPfgYhc32z
 8o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816125; x=1788420925;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8puldNUPP2NeYb5jN7oDbZ6b/C/v9b40CM7vKpDUYQs=;
 b=EUw4cUYMHOiSOD5eP57m+pvlNj4lHRsAS4LDmGAOUdyWUGLLHRqYwJ9bk6aON9eQkh
 Ki6wIUbA+kZbcYrp7et+o4LMzaFyiKNVNI+OHElcmPZUqHjNwYXMiRccf/HMEX2X52xv
 5X9yZg7VkEtCXNmz5m7gvV9ekA/fnx3NZ3vjbBejn7C5y6EVD+F3oOYP5Znu8ssyHhDr
 4j8wvknSFb6Mp9fSBFLgXGlfBr2fl6uvqqS0hR6B4vD/krw2nGvqTWtWLUkoj+WO+Gkq
 sSoHZMe91496zpQuPZVQ2szskymDSRmEB4khkz9Io9n1cTNNSlMhAWkKHvsBhwE8982F
 Ughw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rry29nE6t/fq9fNkCVHlVb/02idea5Kme8tzXV+9jaT/H4DEq7X4QXvDiXRv2XDFzM4M8lOlBo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lVJQ7vBQGoHSbZCbhCJ0tmLPJcbxAchoUzF2ksVGExKJWuHXGX
 ntbx3WP8pLgUkyZV5TkRZb0hpAtqAZmY1Eh27x06+hAsfVZwkTocIK0FGdmqHfNRT09PDIIQiqZ
 PxGwmn98=
X-Gm-Gg: AR+sD13MBSFmFctzR1eszZf8wefIB8wa1P2LwgtgWzHUYnmPVn1h+U+SxVq6POZpABG
 wemReIyXkMLr/5qyV/VynjOUwNDk5DTGcacyxoe/BVIynW8+7GL3kNpsxdP1k1w+OO/FHeOUAQT
 oeMYFEyVPsZRIKZ+wyfmD9O124XmJC7+/SEPCp1G5pw6VPgTEdVORqDpDlEerh7KljkpSqE50df
 Rb9HojmRbeGPbp7Sa7MqHAoBtcA8xIuHbbXJzMTuWXmF2SzDBp1aahGdHH9Qe5V4AB9ACtPE0MF
 SYvO14fxy5you0EI+mZgxmtL/LhUMQPvYKe3apytdRvj/5pf8C6sB/tNJEkC6kvBCFIMgW9qTy9
 tpnfd+KCSpq/SKY/FVfHFJo3oniIDaRJhwHXPaOU+bGgvD4l8ruZwMvTb/OQLZFbUB8zB2rNcaE
 27mHUBoaYOMqymqIHPeB8WPYrYgK3RdjaEXF33NwjgoVMbUcYKdmHIj/i2MqoguvZ9tD73uAFup
 leWJO11m//PGvIXr0/MaLClHRt2XY8GF0Uj9vnQPzg2N4cf/J7bSw7uhcS49xHgb8414vNDizcG
 wTxrUiILiw==
X-Received: by 2002:a05:6000:4909:b0:482:eadd:174a with SMTP id
 ffacd0b85a97d-482eadd185bmr6440536f8f.17.1787816125012; 
 Thu, 27 Aug 2026 00:35:25 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab6d0sm6788666f8f.13.2026.08.27.00.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:35:24 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 27 Aug 2026 09:35:00 +0200
Subject: [PATCH v5 3/6] arm: mediatek: build Genio 510 and 700 boot images
 with binman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ccaione-upstream-mt8390-spl-v5-3-81d04e3ab785@baylibre.com>
References: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
In-Reply-To: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
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
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
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

Genio 510 and Genio 700 use an external DDR loader before U-Boot SPL,
then load the remaining firmware from a FIT. Add shared binman
descriptions for both images so integration builds can assemble the
complete boot chain.

Keep packaging optional because the required platform firmware is built
outside U-Boot.

Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  9 ++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  9 ++
 arch/arm/dts/mtk-genio-binman-u-boot.dtsi          | 12 +++
 .../dts/mtk-genio-bootloaders-binman-u-boot.dtsi   | 97 ++++++++++++++++++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    | 16 ++++
 arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi | 26 ++++++
 arch/arm/mach-mediatek/Kconfig                     | 38 ++++++++-
 board/mediatek/MAINTAINERS                         |  2 +
 common/spl/Kconfig                                 |  1 +
 9 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 1a5f45cba6b..726e060f281 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -4,4 +4,13 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
+#include <config.h>
 #include "mt8390-genio-common-u-boot.dtsi"
+
+#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 510 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 510 boot chain"
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
+#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 1a5f45cba6b..09cab1d2721 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -4,4 +4,13 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
+#include <config.h>
 #include "mt8390-genio-common-u-boot.dtsi"
+
+#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 700 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 700 boot chain"
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
+#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mtk-genio-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-binman-u-boot.dtsi
new file mode 100644
index 00000000000..7e718ddf8da
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-binman-u-boot.dtsi
@@ -0,0 +1,12 @@
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
diff --git a/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
new file mode 100644
index 00000000000..ce492790aee
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-bootloaders-binman-u-boot.dtsi
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+&binman {
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
+					load = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+					entry = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+
+					atf-bl31 {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+				};
+
+				@optee-SEQ {
+					fit,operation = "split-elf";
+					description = "OP-TEE";
+					type = "firmware";
+					os = "tee";
+					arch = "arm64";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
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
+					loadables = "uboot", "optee-1";
+					fdt = "uboot-fdt";
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
new file mode 100644
index 00000000000..e49ad5c471f
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+ddr-loader {
+	type = "blob-ext";
+	filename = "ddr-loader.bin";
+	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
+};
+
+u-boot-spl {
+	size = <CONFIG_SPL_MAX_SIZE>;
+};
diff --git a/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
new file mode 100644
index 00000000000..8fdafbd750d
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include <linux/stringify.h>
+
+&binman {
+	mtk-boot {
+		filename = "mtk-boot.bin";
+
+		mkimage {
+			args = "-T", "mtk_image",
+			       "-a", __stringify(CONFIG_MTK_GENIO_BROM_LOAD_ADDR),
+			       "-e", __stringify(CONFIG_MTK_GENIO_BROM_LOAD_ADDR),
+			       "-n", CONFIG_MTK_BROM_HEADER_INFO;
+
+			section {
+				pad-byte = <0>;
+#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 5e6c50ca64d..0bece6b1b3e 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -207,9 +207,45 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
+	default "media=emmc;arm64=1" if TARGET_MT8188
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
+config MTK_GENIO_BOOT_IMAGES
+	bool "Build MediaTek firmware images"
+	depends on TARGET_MT8188 && SPL
+	select BINMAN
+	select MTK_GENIO_IMAGE_CONTRACT
+	help
+	  Enable binman to assemble the MediaTek BootROM image and firmware
+	  FIT from U-Boot and external platform firmware components.
+
+config MTK_GENIO_IMAGE_CONTRACT
+	bool
+
+if MTK_GENIO_IMAGE_CONTRACT
+
+config MTK_GENIO_BROM_LOAD_ADDR
+	hex "BootROM payload load address"
+	default 0x201000 if TARGET_MT8188
+	help
+	  Address at which the MediaTek BootROM loads and enters the external
+	  DDR loader.
+
+config MTK_GENIO_DDR_LOADER_SIZE
+	hex "DDR-loader image region size"
+	default 0x4b000 if TARGET_MT8188
+	help
+	  Size reserved for the external DDR loader at the start of the
+	  BootROM payload. This is also the offset of U-Boot SPL and must match
+	  the loader's SPL_OFFSET value.
+
+config MTK_GENIO_BL31_LOAD_ADDR
+	hex "BL31 load and entry address"
+	default 0x54601000 if TARGET_MT8188
+
+endif
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index d0d25b096e5..57bb3095305 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -24,6 +24,8 @@ S:	Maintained
 F:	arch/arm/dts/mt8188-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
+F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	configs/mt8188.config
 F:	configs/mt8370_genio_510_evk_defconfig
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0618f42c941..f9b453df766 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -194,6 +194,7 @@ config SPL_SHOW_ERRORS
 config SPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in SPL"
 	depends on SPL_FRAMEWORK && BINMAN
+	default n if MTK_GENIO_BOOT_IMAGES
 	default y
 	help
 	  This enables use of symbols in SPL which refer to other entries in

-- 
2.55.0

