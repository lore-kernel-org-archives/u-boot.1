Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB687D12D6F
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B88FA83FDA;
	Wed,  3 Dec 2025 15:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZvYcg9l5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A656083F64; Wed,  3 Dec 2025 10:32:12 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17C8F83F5B
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 10:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so59875435e9.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 01:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764754328; x=1765359128;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7fTz35P070z/uq1lRLX7c6ve3oWJWUBYDQJfwPBPNDc=;
 b=ZvYcg9l5Uj/HDtQbZ2J+SUxQ1syLy9kw6+05V5ec/Cm8tW9sUiFzz6m9ElcChBd/2s
 PXLgOQGvgZbezDhRLc0DQzI3Ar8eb+eblpEvUz7pFwGl1AewgYmgCDkkuf6wt+xLorOL
 qgqmfsGKrEhHkxVd0b2DU/fWiqB3kSppUWHe+LXUHNe8gJF8LdVrN0TF5p8QBQgm05Nz
 qpyL6QUV6EJdaa/aoacefyHXaqn02NMY4vv8S+9lyycFCn9RYAb0nl4J6JlOuY+NzmLc
 y47xT5y05vcMTqEQtTZx0SFyCxE67nZAQ3SQbabKVbkh1B2gtYeGA5d2sroGjmzeoKif
 UmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764754328; x=1765359128;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7fTz35P070z/uq1lRLX7c6ve3oWJWUBYDQJfwPBPNDc=;
 b=e2tVoR+XbACT73xEY+f1xRuRnQdbz1f/f/4fp8Z1+OKLQ0iPwl9bLPdb65ZwRjYMhd
 UGWLvuST9id5rq2SzOQNxvvyNcOfRXj5ik7joyZh91uGibZhxhiz2DOrqNCggK3d1MkX
 PZY6BBi+jgAst5fEBqvwhJgDzw9+2yDZPsOwyASZY1jUsVGimOuY0EKa51R6vVSt/urT
 0qiHgheXPcn0DoQycIfoeBtZG5sHNHkJ2c1ODNEH4Try113pcuEcWb8my4mGtlpwyPli
 jJERD1tH8X0ZYpE4e080xIoBWESDT0qdhS7OQpMYc+vEHWgT7UvgQUa3K4m1Pik8+EFI
 fZWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwRzo3I5htC8s6JwE1tQ55T+NVMffGJ/nICeV2cN5Wn9ihDXTcSmTn5Bdhu3sthalGJbLxNqE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0deSZVZvLw5dAAv2RPrdi6SWvbw4lqvOFAaSCOWSz2Qsy0mhM
 1Bdrzb68ef5Ewk6pqbC4JDG3vqERTewdnQPVICitMtGzV9l71aOGTAaaa/d7/uUy288=
X-Gm-Gg: ASbGncueTL4TwRLeUnAMcq0EV8s7LJqgRy2Qxmxg/VfQpXFBQRJGwmpvxyMTw7xeRt9
 E9rfFRQDkNSLsNJmUQObmbSH7Xq1yXLrSXeX1DfzwBABWDwkgaKtMecE+A1a2WS4Y+F+JdAGLSC
 gT/JJpVUkyI0b3lAGJYYM56c6NWNl4GGqCxeGhWDOjcvmHxm2U54+MYmHszPWfYlH993x2qmYx7
 WpZ7dcQks6ArTLsEMl+6MoXALeZxygCbDV5R1B9G5E2I7T2WmixX6DaJgphCtacr3Ujc6ohrdEz
 yja6RoHsO4BecyEFeSWCdq4tiNOQJ93P5BUq8km/A2bmyyQvgKQZ+GvO7+AnvaE3seNdFwNNKyu
 tis7kSMQienJRLZJg/RIiA542Ec5eDbu9EdI2nAtTX/ettoWvkk7Txy2ccC6DlNAvcT8Y3A5vfH
 2fxPAFV+jbzWfvs1jv+v+r00fbLElQNPklaY2mKJKP3DEjUHZqX7cajOzED5MqD9+NHCHaWpQmr
 Wr3NFQ=
X-Google-Smtp-Source: AGHT+IFHc2azKP9g4mLkvf9PHVkOqdvQKjK0+Im6oSVWQic+EzCTza9NYSO2ZWjDzYhf7NQTCGO2cA==
X-Received: by 2002:a05:600c:8b16:b0:477:55ce:f3bc with SMTP id
 5b1f17b1804b1-4792af30d19mr17911735e9.19.1764754328407; 
 Wed, 03 Dec 2025 01:32:08 -0800 (PST)
Received: from [192.168.1.64]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a396sm37964430f8f.22.2025.12.03.01.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 01:32:07 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 03 Dec 2025 10:31:52 +0100
Subject: [PATCH 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-add-mt8188-support-v1-1-9a06ebb97734@baylibre.com>
References: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
In-Reply-To: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
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
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
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
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Wed, 03 Dec 2025 15:46:17 +0100
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
 arch/arm/mach-mediatek/mt8188/init.c   | 69 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/mtk_wdt.c             |  1 +
 7 files changed, 95 insertions(+), 1 deletion(-)

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
index 0000000000000000000000000000000000000000..3389c03b06006e8130b4ce448d5dcfb8f103c28f
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Copyright (C) 2025 BayLibre, SAS
+ * Author: Julien Masson <jmasson@baylibre.com>
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

