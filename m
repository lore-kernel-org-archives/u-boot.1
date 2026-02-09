Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD87E7E0D2
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8981083C67;
	Mon,  9 Feb 2026 19:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cAdB8Bc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D039183BF4; Mon,  9 Feb 2026 19:24:05 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A198388D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6610e72112bso1492761eaf.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770661442; x=1771266242;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7PaeGBhDDLrFci7vvF1at4ENvsj+oZTisEy9LOVm2rU=;
 b=cAdB8Bc/928MzdjEASIuq8IWfMntqv7E8kvmdepeXgaFPpehYovTVrSeUE9NLKspgQ
 N+uf67q6fsX1yQzhGxEvQxhEt5F6+zbYyXyJ+shlc1EBA3IsvhUILWAAb39U2BM9rBKz
 Q6AOtqRV0MV1UuQUHMm+WOmkGV997F8x4CPIzWL8JtHYZogm/jgr3PU2seNyvoyt8jDo
 NKDe85rUp0bhgqT1OMNH2TvSXyr8IQycJxGAyQwAsxEt/S4icddGJTZKQivCxPvnhnvI
 fB2RPZj8Gz5GRPBw5qfAfMUjjqFd4Cvhs87MUzw50ogkZLYL8xieEviSS4d/0yNbn+SB
 TEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661442; x=1771266242;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7PaeGBhDDLrFci7vvF1at4ENvsj+oZTisEy9LOVm2rU=;
 b=wJK7J202lDkFREHVVnZGbmMNV9uVx6huPTqvf5lop7MulY9Ce2jaTNEaZRWTxJZR0g
 NgVydLhf8cewsU9zoukXuIACQubyhIhY++L20FR6auUhGOKeOcYcP9TxJlT2TzwIeXXz
 OvJZWO4He58RDRTdWFmbPLlGudcWraPJ7D9uwMIi3Q0K0im4GjJ1hqg1F3cG2rr6i2ix
 Bv0ScDhoq2PVx5yAmh3x8XSTbrLaXRufLxmYW3kShzumSNixA/xK8aqLXxXSLw6+f6S5
 AUFhOxHjvSxdIyiB51w6EGfyGdgoKldKvYf2zTAyyaxYpjgut9hsCYEpPhUyPuJkCOIq
 lvMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJaMuxEvnUNSs2VrIiT0Ke+vkIL80DPJPd+20Ot9Fo5BuS2/gSpZDNBO9WAuRcSPX1knSLncQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzeDyDIPBGA7lT4mX/k02vDONqXImAbJemXDOs/O3E7V3Som0rK
 V0a7vfq92WXefELpMpC/Xq9rcOt1vDVBvC96cSU0HtXLDSVN+fKWhhp4WZ0JFMy01+l1s4DANa8
 yJooP
X-Gm-Gg: AZuq6aI56SAvQ4pLEcEllW8JU3CauJw8xTgSU0A0eW6HJeVy7FZ79BJHKqK4u3YbBQE
 McUs9IduyR4O2C89vrX7Us6ZghTVQU3uEbq/XIve45YTu0bmGhJpcKxPRfOpUbZvG0NVasD1I37
 PZct77jFzO8Act48+W+2vQ15mLVwlGcvvPAZbTgzcJ2+SUbC+GtzWIRhzmmG4RCkIu1vhx1J6Vi
 oBzMY5QUcZhaIrarh/eY9oxuADUPTJXD12CTy+Un52UPqAnSCRkHMFMz3uT/cpoS6XlrheuBsL0
 YvG9WHz6Eh4eOKnceQ+OpTHkvVhFMKTjHcanNGkcNmz7qX5bNQDP7YU4O/UULFSOI8z9p0NrEoM
 zoJEO9/9PAuUGceAuVNqeuyms99o5KBFmQDKEihrH/zoIoiHXCPVb50VjISW+HjG6/ZYjh+XzBc
 hLPLG0V+l3iOPZBV4=
X-Received: by 2002:a05:6820:2912:b0:662:ef75:803a with SMTP id
 006d021491bc7-66d0c18acb4mr5378261eaf.44.1770661442276; 
 Mon, 09 Feb 2026 10:24:02 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a99359eb4sm7993335fac.9.2026.02.09.10.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:24:01 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 12:23:15 -0600
Subject: [PATCH 1/4] arm: mediatek: add support of MT8189 SoC family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-mt8391-initial-support-v1-1-b23ab9d0b9bc@baylibre.com>
References: <20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com>
In-Reply-To: <20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3962; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=jRW+MW+bDjlt/SpdnVKvbkCiF/2NcM7q34aTZ2u1+Iw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpiiYl/KscVqaZIHxomBCQ1F+sGpPquzjqqRPk9
 tkl3Co7u/yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYomJRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AQ5UH/jVV4RaPoGwaS9g8Dhj5BNGjcCTk6QyVU8Lzk30
 o7X4Riabjq4NWHWwartNJ+kPAhpTLmSmCnWXQkQlbIHjsseCgBQJ7ZI31PIrnA5tRKVVUKcUG05
 xRvXyrxBinKrAvZ9DHBKBUmEPBjBHfhPC/+z5BQQPqDPOmfcQALHSCcelKAvQLN6zdFMBjSjYKB
 CE87RgqHp+ALyoeakcayWcEocYlR60FHxZJX+Fvrzr5cASfyGJ1efXg3ieOcrsZwTJd37pke/rv
 Nn3tC9aaxuGruFtQI5I7XP0xMkhJ/Q+ZTi+2XJvCRdYoBFdOZskHe5ioeQQqinoHNo1hH8DAH+h
 /K68=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 19:39:13 +0100
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

From: Chris-QJ Chen <chris-qj.chen@mediatek.com>

Add TARGET_MT8189 for MT8189 and similar SoCs.

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig         | 11 ++++++-
 arch/arm/mach-mediatek/Makefile        |  1 +
 arch/arm/mach-mediatek/mt8189/Makefile |  3 ++
 arch/arm/mach-mediatek/mt8189/init.c   | 58 ++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 8da4ba5ceab..bdbc4233054 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -93,6 +93,15 @@ config TARGET_MT8188
           USB3.0 dual role, SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and
           several LPDDR3 and LPDDR4 options.
 
+config TARGET_MT8189
+	bool "MediaTek MT8189 SoC"
+	select ARM64
+	help
+	  The MediaTek MT8189 is a ARM64-based SoC with a dual-core Cortex-A78 and
+	  a six-core Cortex-A55. It is including UART, SPI, USB3.0 dual role,
+	  SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR4x
+	  and LPDDR5x options.
+
 config TARGET_MT8195
 	bool "MediaTek MT8195 SoC"
 	select ARM64
@@ -201,7 +210,7 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8195
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
 config MTK_TZ_MOVABLE
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index d1f64d61ab9..35f748a70d6 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_TARGET_MT7987) += mt7987/
 obj-$(CONFIG_TARGET_MT7988) += mt7988/
 obj-$(CONFIG_TARGET_MT8183) += mt8183/
 obj-$(CONFIG_TARGET_MT8188) += mt8188/
+obj-$(CONFIG_TARGET_MT8189) += mt8189/
 obj-$(CONFIG_TARGET_MT8195) += mt8195/
 obj-$(CONFIG_TARGET_MT8365) += mt8365/
 obj-$(CONFIG_TARGET_MT8512) += mt8512/
diff --git a/arch/arm/mach-mediatek/mt8189/Makefile b/arch/arm/mach-mediatek/mt8189/Makefile
new file mode 100644
index 00000000000..886ab7e4eb9
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8189/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += init.o
diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
new file mode 100644
index 00000000000..56e852e2374
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8189/init.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Chris-QJ Chen <chris-qj.chen@mediatek.com>
+ */
+
+#include <fdtdec.h>
+#include <stdio.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+#include <linux/sizes.h>
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
+	 * Limit gd->ram_top not exceeding SZ_4G.
+	 * Because some periphals like mmc requires DMA buffer
+	 * allocated below SZ_4G.
+	 *
+	 * Note: SZ_1M is for adjusting gd->relocaddr,
+	 *       the reserved memory for u-boot itself.
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
+void reset_cpu(ulong addr)
+{
+	if (!CONFIG_IS_ENABLED(SYSRESET))
+		psci_system_reset();
+}
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   MediaTek MT8391\n");
+
+	return 0;
+}

-- 
2.43.0

