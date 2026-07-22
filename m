Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7E0C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 21:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E96B4608BF;
	Wed, 22 Jul 2026 21:36:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DooHblYHcnQX; Wed, 22 Jul 2026 21:36:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BF68608D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784756210;
	bh=SPtJkGE1TRsaMU25bcifJ0W7Ub4ZRp1iH/Ig1EPDJHk=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VO2RDangc2Kjzc6fOQ/v9NyzvSpxvUybdLlBDq7ub7V00LNIYhlElQ5j4/y990gOX
	 Hm8ClsH5nRUqThradlcwXX+VIKI+JiHmW77PB+sp17K+oxDRsObF9JTrD0zMlywoF/
	 u1w0dt2q5eN8uJOa2e2LzwEf/YUTDNrkg1Orbx8TAGhZVLkgvxSMjMakRg9+v0u8ZF
	 uAJ/dgxfrsr8mmnFCA/ymOy/gEA8T3zRjsKnaXKP5pXK8dwLePanZMtoqzeqfjgjTx
	 WmvWQES21JVEk+KZMZbUrgZNcVuNrnnXb4Bj0OIg4EwzEJpOZsWu4jQaqOrHUob4QV
	 pLvBiTkWnAizA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BF68608D5;
	Wed, 22 Jul 2026 21:36:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 95F88390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87E05406DA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4wWN-_M2-bye for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 21:36:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A86C5406CD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A86C5406CD
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A86C5406CD
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:45 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso25127845e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784756204; x=1785361004;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SPtJkGE1TRsaMU25bcifJ0W7Ub4ZRp1iH/Ig1EPDJHk=;
 b=F81tE8cMjAMKdWo/kTSBVp0dGdfJjpuqiwZC9IE8ZkXn+RdmAWZzDcm/zEMI9QyJxb
 eBDOgHo67AotCJK6aRpeELFq95it3k/NjVXfK3+yYlchdod8r0IG/vLVaabf/sYqd7MI
 K+MHX4VIF23pmmF9t3+SwDt9Sa72fCoZfyCIOD7+HIwtEl/ylHx6Y1FyNjerDA2XBVvS
 rGYWO/kWSJSRjNEkP/h064kEF2DFUFd953H456BYgk8w3dXBOLruNcNEgIvTVwbiN7v9
 3QDJmPexmxc+QrDls0GuoJPRLVpJk7VysvsLe/dkBEjVZKPffgPYpSfidQEDK43efBFC
 byTg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrgbw+codQTdD0SU/9qlA7UPBrN4AoqDOSXdvijUHQnmJfRerT6Iu3hToym2aM68pRa9qtkdjs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxTb3XKwgaVISaudGw7kyi5tCbvjOM4x7m4O0M5aTxhfdvHYdun
 p1rdyblbzxDYb7dMHDdIZJQh2VT0m/5DYLiD3IuD+Zkn/vQc77/z4HYGMeCC5hnl9SwLcRuyE+I
 pbehTTNQvK1aM
X-Gm-Gg: AR+sD12KjYkuDorQMCfsOpsAmY7jd+ghtq0cawtXjZ9b+KyaZms2WEiFaU4FzDbgkZZ
 L6eAcsoWdI/fq3hRsnZl2MtFtXJTIoVUI6L76wluicdb5oUQtMILoR/455rmoKWkShlpt5EjYKg
 3c5A/MshwWBqTO1MD8NUwiPXgaN2WbaLg+Y0/FSghIg2hULkJdzsMTPaLeBFu0Afqk23rmEgCMZ
 XsQg435WYKiAp9UcDlxShksr8M/9/oFXqh4ZjL7aj2SNUhXAyj4W/PKiRusPWPa7K65fgSd3zLy
 kyTtPQYJXWHF52rc9gd74hKQ6JWTmYnU5DGFbXPUFaPLHKBy2ZP9LlQpNgWB75a8mXqHzxkBKdW
 c6ZmvqMaFzVNd4PWfCbBewqnQs4oLiHqRIDmRgkG25EEk3ypYyVG37OSfYtEVPlGl2I+H/PUTz4
 hxjd1K3b44WMmI9Pg3PX1UkP2wwZZTp7QzMEzB/FHsvCZFdsnFdbdJcwQND6c45BpBAWhg7Q==
X-Received: by 2002:a05:600c:474e:b0:495:5e86:4e11 with SMTP id
 5b1f17b1804b1-49573ccd937mr5140105e9.12.1784756203677; 
 Wed, 22 Jul 2026 14:36:43 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a509901sm174954605e9.8.2026.07.22.14.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 14:36:43 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:35:50 +0200
Subject: [PATCH v2 3/4] arm: mediatek: mt8390: build boot images with
 binman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ccaione-upstream-mt8390-spl-v2-3-7aa005345711@baylibre.com>
References: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784756204; x=1785361004;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SPtJkGE1TRsaMU25bcifJ0W7Ub4ZRp1iH/Ig1EPDJHk=;
 b=UeNxGrkKrKTnB6HbvtWo27abZqXllhMR8PJSXbY6cGsj+HNEFXUNnVL8WIU6/78UsM
 33LW1Mv4Li9txnI+Ge3EZnTfdpVSGEVkXIfDIxCr13bDH+NAIECJKaEW2k7ygUz9HAiG
 FnaY5V6ZbuDBQe1KoJ/3WCR2Oemu0awP13RQ2t9qLickb40oT1cgb90tK30FnUxW2yGK
 FNRXdnFPebqAz8j8nzDgKcyWFo3ujJ8nXGtMwmvHPyYS7/6Q2D99Ck6nnZAKSO1H+3cK
 yriHGQqdiiZYAqSje/IbAgni0y92qFAx/uBPp0oT/Dp7wHYNGz/6adtEyt/U2jXH1UPz
 Bafw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UeNxGrkK
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
index 2b392c866fb..cd07538766a 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -4,6 +4,7 @@
  * Author: Julien Stephan <jstephan@baylibre.com>
  */
 
+#include <config.h>
 #include "mt8188-u-boot.dtsi"
 
 &clk26m {
@@ -43,11 +44,130 @@
 };
 
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

