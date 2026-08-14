Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A29C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F6DA40F26;
	Fri, 14 Aug 2026 14:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 89XEBlWM4rdc; Fri, 14 Aug 2026 14:48:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9AFA40F1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786718898;
	bh=8AnNToHSP27lqbwvXbPvBt4hibsnoFTWPrPEKjyWnkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oc0DMi58Q4zVcaMZB/kAqjHZh86QppB26xpddxHv69jW097zxEqABelrlLT2yxymI
	 Yij//ggYVqbqzRASolZWXj9MmzX7vFz3VubmXyqPSdgtaFms7TjG+t4HybSbiVqDoY
	 ZkDJVjkTauf3R4l/uYo0jZXbsrN4N5qVJfjo4K1WF1i1TxwEuocmMqEpPg/BrQWmWU
	 wIZo8GLbXDBQo8HWNqqpaKdthsj3qV2DgWHwdj9IvEpJVi+Xtm1xqXU7H7+JsPpVxM
	 m/k0GF21lsTRZjAdwqoBjHNhKN5mlCm90/0f60yXpXfsAmTvHg9pXdWApSI1JIWcSw
	 1pAu+Pzo45IZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9AFA40F1B;
	Fri, 14 Aug 2026 14:48:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A5C5139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 007F340AA2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5kAkIXehnthP for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:48:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B1555400A4
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1555400A4
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eeA3FBQs
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1555400A4
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:12 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so158668866b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786718891; x=1787323691;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8AnNToHSP27lqbwvXbPvBt4hibsnoFTWPrPEKjyWnkE=;
 b=eeA3FBQsoMtEpcsouUq+6lrJVc/qWU3B4JQPCqljt6x0iz+yaWPSwcbi/mHhaqTpF6
 La2xb5mjXLKqtbcBxiDJNMBDMSCJsS4A5gy1Oxfu1varcozd6wwUfkX2BIT7Z9yUUvJr
 YNbOfe68I6n7MFAPkfzBy5g54MfPbnbyJlFGDI71Q7ECE85D5mx+eibXnunYRp6WYVXW
 BvlzTcUbhq3A2AyzZQwwRpJZGejoT7/ahp0TtU/5J7ixRiJFOQLTBJimmSaxVjVbERQd
 ddLG+wA6M5ErtIeMJODT1MFwPeAAYNOykCS7ka5BkY5tQVEzrUoqCZdmVbGEkZlvpWvs
 d9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786718891; x=1787323691;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8AnNToHSP27lqbwvXbPvBt4hibsnoFTWPrPEKjyWnkE=;
 b=IrmZ+0JFkOL0puZRa5V3oFngncBSon7v0XKbGv/t8C1w0i/aDhzFZvLt6d57uMEjWx
 Jq1ZcBOab0FDWV6ipjNt5fgZAos2Pbd+P74PD8xKlz0L/iAIDUbahOv9HDZ5Z4ss6QI9
 uSjR3evUn7CVIOH+ms/EeXGt8XcwLoc+POgCdQrtaCc9bjeKpctJGunzOkFuXFU/4YYl
 fVwt0iMocSlKK2Wbo8rMWRqiKQmwZC8MiJpXJe2clgQ2M3A8IFiogIRy0aLh6AFtgfVp
 i4TH70Rq26UBaNsPXYlK5yVCMDy/u9aM5JL9n1/L2kIdiynBIgPnHCZTVuFHsz3YBSnI
 fqSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxFe9GAQfU+nflUaBg9gPLvAp1ko8Xp+nASdom9OzmtqmdldaTJqkhO/ko8QHHdX5q7UwfUko=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyjAcN7qP3Nvv7vqM8GNUkI4c21oeLS4fYIGanBQCWLcGjQwGeb
 mhCV67CPj84Mj5I6NXd3XO/FHKGPrsuXfMomg2XUDjJV7DTP4O4NUqcLrZYuUZDBNJU=
X-Gm-Gg: AR+sD10DHSGU+iTKqu1YKsjmXxBJLnLIY9dEGfGgx021mUIVE72ApQ2zb99wGCOAK79
 DUuf3Nfb6PukUM1d3W09kGJlic8rkriDgQhNjvsla8l+EFvR7uMbj9qEjkB57l49J77d2+w5/rt
 nAJvATxEE5KL32qH04a8meHHX6S1AN0AokEOq6u7LIbbDISqcdULUlAgs/GbRDjTdb9v103YLwS
 mypSChRiyqVeRsMPw0A1Q+tL4VtEc46ecQlJWnqGzo/ehzJYL4wkBYOye5kTW/+ivWGkfAPaQnk
 zPVagmaHBCj77kA+yMqYmPx4kNcBTrGjld/JwH2mzyjRa/0U2v1zP5Lgnd4cq1D9+NCOG0wcYmi
 BPUzbwLUcY2SVHqNey7aVP6TF/oCxc49/9SiBuDF2pwm2IYQQ0g7FU1qZHFf58n5ORcb1onFvv4
 E/e3KPL3cEsN0loUFRptNkSwxEvqDKd0N1Ty5AQLG6e5T+UN3zjyb5/XqjnEpIJq4wCclEJSSJ+
 Zp+8F6qcBuy0jseWD9S4LVE8o0g1NM6ZylOfAkK7asw6OUqjfyOHQiV6II=
X-Received: by 2002:a17:907:fdcb:b0:c16:101d:7afa with SMTP id
 a640c23a62f3a-c212a8e21c4mr256004766b.16.1786718890395; 
 Fri, 14 Aug 2026 07:48:10 -0700 (PDT)
Received: from macbook.tail959722.ts.net (static-226232.rol.raiffeisen.net.
 [195.254.226.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c212378d9fcsm114992666b.34.2026.08.14.07.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:48:09 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 14 Aug 2026 16:47:53 +0200
Subject: [PATCH v4 3/6] arm: mediatek: build Genio 510 and 700 boot images
 with binman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-ccaione-upstream-mt8390-spl-v4-3-f4f92978a79e@baylibre.com>
References: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
In-Reply-To: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi  |  9 +++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi  |  9 +++
 arch/arm/dts/mtk-genio-binman.dtsi             | 12 ++++
 arch/arm/dts/mtk-genio-bootloaders-binman.dtsi | 95 ++++++++++++++++++++++++++
 arch/arm/dts/mtk-genio-loader-spl-binman.dtsi  | 16 +++++
 arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi    | 26 +++++++
 arch/arm/mach-mediatek/Kconfig                 | 43 ++++++++++++
 board/mediatek/MAINTAINERS                     |  2 +
 common/spl/Kconfig                             |  1 +
 9 files changed, 213 insertions(+)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 1a5f45cba6b..e3cf1e306e9 100644
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
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-mtk-boot-binman.dtsi"
+#include "mtk-genio-bootloaders-binman.dtsi"
+#endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 1a5f45cba6b..cb50efab376 100644
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
+#include "mtk-genio-binman.dtsi"
+#include "mtk-genio-mtk-boot-binman.dtsi"
+#include "mtk-genio-bootloaders-binman.dtsi"
+#endif
diff --git a/arch/arm/dts/mtk-genio-binman.dtsi b/arch/arm/dts/mtk-genio-binman.dtsi
new file mode 100644
index 00000000000..7e718ddf8da
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-binman.dtsi
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
diff --git a/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi b/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
new file mode 100644
index 00000000000..c43d8c32507
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-bootloaders-binman.dtsi
@@ -0,0 +1,95 @@
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
+				optee {
+					description = "OP-TEE";
+					type = "firmware";
+					os = "tee";
+					arch = "arm64";
+					compression = "none";
+					load = <CONFIG_MTK_GENIO_OPTEE_LOAD_ADDR>;
+					entry = <CONFIG_MTK_GENIO_OPTEE_ENTRY_ADDR>;
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
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
new file mode 100644
index 00000000000..e49ad5c471f
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-loader-spl-binman.dtsi
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
diff --git a/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
new file mode 100644
index 00000000000..16ce9cacb66
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
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
+			       "-n", "media=emmc;arm64=1";
+
+			section {
+				pad-byte = <0>;
+#include "mtk-genio-loader-spl-binman.dtsi"
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 5e6c50ca64d..eb8d072e686 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -210,6 +210,49 @@ config MTK_BROM_HEADER_INFO
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
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
+config MTK_GENIO_OPTEE_LOAD_ADDR
+	hex "OP-TEE load address"
+	default 0x431fffe4 if TARGET_MT8188
+
+config MTK_GENIO_OPTEE_ENTRY_ADDR
+	hex "OP-TEE entry address"
+	default 0x43200000 if TARGET_MT8188
+
+endif
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index d0d25b096e5..2048cca22b2 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -24,6 +24,8 @@ S:	Maintained
 F:	arch/arm/dts/mt8188-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+F:	arch/arm/dts/mtk-genio-*-binman.dtsi
+F:	arch/arm/dts/mtk-genio-binman.dtsi
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

