Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E76D1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 10:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95FF083C14;
	Tue,  9 Dec 2025 11:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="owO92AHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC55383BC9; Tue,  9 Dec 2025 11:22:46 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF4983B81
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 11:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42e2e08b27eso2313588f8f.1
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 02:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765275764; x=1765880564;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zxoA329VhsfuBXJiruf8KLQFeahHQJ9GQAio9AOmsmQ=;
 b=owO92AHfpT1spc1G6Q/nbt8XU4tSst28ujkYZQZjy0kFibPi3gza+FYsXxMhA9mS4G
 /5ZHXFa+tBAAfmK/DCTWxuIgOf0WSfPgXDbpIUyUh89jV/jnPczZ79uQbvNPw4aKFctm
 o5ntiBBwv6a91IyGuB40n/yd7asAPa/S1lJu2eFCP1rCoKL1/aYUL0fQ0BtXel4MQ6Bq
 ELsqlA1Q0S6wme/hCp0Sv9qRG/e/ow1QdaWiqIOWpOmIY9oiGGFkFVnWti3+G7IZA/lk
 KnyHknni1aYNiqjnBu8ADajZKfG3f4kgH92XEq3Nf2I+SYJpS3IGBCDS2/LZzOPhrAWy
 +xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765275764; x=1765880564;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zxoA329VhsfuBXJiruf8KLQFeahHQJ9GQAio9AOmsmQ=;
 b=QEuoNYzyr9Q78y1B0XJvyiVCSzPI3dWA5JF22vsi3g3HFhN1hjrjAM21J0AcW6aoDv
 xAAQ/bq4B2cLazDdpDh26AwzCOjeLlZ7IA3amLA0OlyoBNte9V4tPrCSq3gO6XZ1ruNn
 EtgnDOFkD9dRz6jNuSTSwQnEJKaCPQpIJfenxsDKysnaKRLhAdrr+/WlMGovAn+EIDGD
 icdk84DDxCv9FkJcSF8mj51gSHWAL/aqM3R4jj65d8CcxgvY4Rbrn0SG6+ypu/o2CDGr
 HkyjhdamVHRoRvY5EToh4tm4cZ+yhYtu0B80TpmT0SB0kCS5PuDL8wmUQfhKtAlMVlbl
 V+iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO6IEgSdruGfYrl6L/hh3tkeE50oKic9qOUXi5hVkOnQLKklw6rCA6bwQDTQE4iU5gtLHlAuA=@lists.denx.de
X-Gm-Message-State: AOJu0YyJctQ1oA5gsbw7W7FgjVJh1KDgIL6Lhr0rfhPnAHsE/Q3Ahq7w
 XoANRRTpGC7tIUS62UOBO0CgK0uxBRYdmLYmqDORoHxPLwsbmMegmmHpbyB/mJkELq8=
X-Gm-Gg: ASbGnct3pXwusUWC1fyKPQwyKIRG/PU82qp3l13wfZEUJ8wIAU8WrH7Yh1m5qARoOYD
 hpKK0YqhOyfbhpcRp3i9H/hBg1VIq9n+znj7guBmE/wi2MFd8vPoXPRpRxkoQIKBW+wdBcYY/Up
 ViMoZKaLYUJxyWlk3OwTM3YOsyateyrnau3c07IP1IYLOLFX8o+zeBfKcTY/0/zdL8kR7wTbuoo
 bjb7ekGSv4elvnuJMsqKdkxefbsP4Wu8Nz2W3to6hoHvKQKo1qsX7Goyrg8YjU4fPy4cCzxRrbF
 bAeEhfrqCvG8w+6Vcuvx4GzScYLeVf8Of+IQpGI52U2DTh/fGJwxOUv3jCKuXxZyk941pcbqHSQ
 Y0zWZAhMtVpWHKp0H++rFoxV04bY1n0Bdw0gIpsyof2ZOqGaNmeJFQzsZI6tYP11FJ40r4mb3G6
 1dmuEE3QCiKFd9/B1gh2EtrO+pYjAD/Wipu8+au8icyG87anTycNfIrA0+GKbTY4qFZk8oOh+bg
 rbZMFenVn/hSIpTD2Iv
X-Google-Smtp-Source: AGHT+IHQMNmSe/HRe3mZRkiOX8f52gB2QmwORf/HgrHCqfI0brn0iLcXMZq823MGkGmIBWDcb8kg0w==
X-Received: by 2002:a05:6000:250d:b0:42f:8816:a509 with SMTP id
 ffacd0b85a97d-42f89f644a1mr11823123f8f.62.1765275763765; 
 Tue, 09 Dec 2025 02:22:43 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-f92a-5586-f2e9-b313.rev.sfr.net.
 [2a02:842a:d52e:6101:f92a:5586:f2e9:b313])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee66sm30497029f8f.11.2025.12.09.02.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 02:22:43 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 09 Dec 2025 11:22:24 +0100
Subject: [PATCH v2 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-add-mt8188-support-v2-1-31dbfcf7303c@baylibre.com>
References: <20251209-add-mt8188-support-v2-0-31dbfcf7303c@baylibre.com>
In-Reply-To: <20251209-add-mt8188-support-v2-0-31dbfcf7303c@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Julien Masson <jmasson@baylibre.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sam Shih <sam.shih@mediatek.com>, David Lechner <dlechner@baylibre.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
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

From: Julien Masson <jmasson@baylibre.com>

This adds basic support for MediaTek MT8188 SoC.

Add watchdog support by adding upstream compatible string.

Add tphy support by adding "mediatek,generic-tphy-v2" compatible string
in arch/arm/dts/mt8188-u-boot.dtsi

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS                            |  1 +
 arch/arm/dts/mt8188-u-boot.dtsi        | 10 +++++
 arch/arm/mach-mediatek/Kconfig         | 11 +++++-
 arch/arm/mach-mediatek/Makefile        |  1 +
 arch/arm/mach-mediatek/mt8188/Makefile |  3 ++
 arch/arm/mach-mediatek/mt8188/init.c   | 70 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/mtk_wdt.c             |  1 +
 7 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b43dae882b3ea33c2cd745bd3759e3f4d97abc80..5b52d2fe17506d2659be9016a7ca639062332ae9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -415,6 +415,7 @@ M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
 M:	Igor Belwon <igor.belwon@mentallysanemainliners.org>
 R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
 S:	Maintained
+F:	arch/arm/dts/mt*
 F:	arch/arm/mach-mediatek/
 F:	arch/arm/include/asm/arch-mediatek/
 F:	board/mediatek/
diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..6d1b2ab82da1c95a49b8a693eb0f854ab913a26b
--- /dev/null
+++ b/arch/arm/dts/mt8188-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 Baylibre SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+&u3phy0 {
+	compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3",
+		     "mediatek,generic-tphy-v2";
+};
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index e54c456aec0bda3bc1c06d0780d74e96a659531d..f7ef17e0203c74a5c18630636f978cbcfb948089 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -84,6 +84,15 @@ config TARGET_MT8183
 	  SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR3
 	  and LPDDR4 options.
 
+config TARGET_MT8188
+	bool "MediaTek MT8188 SoC"
+	select ARM64
+	help
+	  The MediaTek MT8188 is a ARM64-based SoC with a dual-core Cortex-A78
+          cluster and a six-core Cortex-A55 cluster. It includes UART, SPI,
+          USB3.0 dual role, SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and
+          several LPDDR3 and LPDDR4 options.
+
 config TARGET_MT8365
 	bool "MediaTek MT8365 SoC"
 	select ARM64
@@ -157,7 +166,7 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188
 	default "lk=1" if TARGET_MT7623
 
 config MTK_TZ_MOVABLE
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index c11d6ad8aed6e411636fd8aea1b1eca6ba4780a8..44591bed6fa0c57a026fa0b71f5e46911ca18a50 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_TARGET_MT7986) += mt7986/
 obj-$(CONFIG_TARGET_MT7987) += mt7987/
 obj-$(CONFIG_TARGET_MT7988) += mt7988/
 obj-$(CONFIG_TARGET_MT8183) += mt8183/
+obj-$(CONFIG_TARGET_MT8188) += mt8188/
 obj-$(CONFIG_TARGET_MT8365) += mt8365/
 obj-$(CONFIG_TARGET_MT8512) += mt8512/
 obj-$(CONFIG_TARGET_MT8516) += mt8516/
diff --git a/arch/arm/mach-mediatek/mt8188/Makefile b/arch/arm/mach-mediatek/mt8188/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..886ab7e4eb9fa4533d51995b1042fe2f1febdc33
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8188/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += init.o
diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
new file mode 100644
index 0000000000000000000000000000000000000000..ed67150e61192d89875a145404440a97036ed34b
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Copyright (C) 2025 BayLibre, SAS
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Chris-QJ Chen <chris-qj.chen@mediatek.com>
+ */
+
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <dm/uclass.h>
+#include <linux/sizes.h>
+#include <wdt.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	int ret;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret)
+		return ret;
+
+	fdtdec_setup_mem_size_base();
+
+	/*
+	 * Limit gd->ram_top not exceeding SZ_4G.  Some periphals like mmc
+	 * requires DMA buffer allocated below SZ_4G.
+	 *
+	 * Note: SZ_1M is for adjusting gd->relocaddr, the reserved memory for
+	 * u-boot itself.
+	 */
+	if (gd->ram_base + gd->ram_size >= SZ_4G)
+		gd->mon_len = (gd->ram_base + gd->ram_size + SZ_1M) - SZ_4G;
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = gd->ram_size;
+
+	return 0;
+}
+
+int mtk_soc_early_init(void)
+{
+	return 0;
+}
+
+void reset_cpu(void)
+{
+	struct udevice *wdt;
+
+	if (IS_ENABLED(CONFIG_PSCI_RESET)) {
+		psci_system_reset();
+	} else {
+		uclass_first_device(UCLASS_WDT, &wdt);
+		if (wdt)
+			wdt_expire_now(wdt, 0);
+	}
+}
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   MediaTek MT8188\n");
+	return 0;
+}
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 706deb9da84626d8935a30d9cf6831289804d99d..4d4ab4cbe903e867f834427dbff4d9ce44efe784 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -145,6 +145,7 @@ static const struct udevice_id mtk_wdt_ids[] = {
 	{ .compatible = "mediatek,wdt"},
 	{ .compatible = "mediatek,mt6589-wdt"},
 	{ .compatible = "mediatek,mt7986-wdt" },
+	{ .compatible = "mediatek,mt8188-wdt" },
 	{}
 };
 

-- 
2.50.1

