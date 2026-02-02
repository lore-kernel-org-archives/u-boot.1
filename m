Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2A5E7315A
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 12:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A096683E21;
	Mon,  2 Feb 2026 13:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XqLoEyk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A25DC83E36; Mon,  2 Feb 2026 13:08:17 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F5983E1E
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 13:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso32924925e9.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 04:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770034094; x=1770638894;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=29mVhidq+dCHEzWKop8an4t3/dS+aqUNKHdtIlGc8kk=;
 b=XqLoEyk3EVr0gNEYjgPDCzWsBDs03R9hoRB6GXBgSSaiJXDqW3bNeUOT9kKFtms2zK
 WaeQ6cTIBGx6AK93hi1vyw26cMXIJbcj7JRG8NreA11or9FkVpS05ybUO3WYkyU94m85
 djLHaNqOhTW3JQVRXwDNfoQkrO98SWckXMlj/HvhThar7qrfyac6W0anWg2+D4jvZG8G
 L4N61gXeRuWUbDL1TQqhUD765AnOdgQywUqeUckG3Q6ZNykrMWU10HUiRzBoGDJsp+fL
 A0hkBM6rAjdlMY6bU6EyKVOQsAd+RR/SUlLJfurt+MUaNE5fG2aCV6/nDZ49VBPaBlxF
 OE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770034094; x=1770638894;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=29mVhidq+dCHEzWKop8an4t3/dS+aqUNKHdtIlGc8kk=;
 b=ZuohEBubJB5sqadUN+0bpUoyjDZjMPtMbD62pyB23UU7F/xdrdUXp8dw384gkLGTL5
 1F5SsWq7fuR3AWWoayN+eLIaWJ9BdAVXTDQyYOt9UbV8rHaZISIPYt4Mf9pjI2lweR3b
 mSzFUfAyIwmBR9jEhPa1ds4/CdBEu3sNV185JKCSOBa8UtMkGNHJ0Z7rORfW5J8pTejA
 6lB728GoeWyY1aHz2bVonxh0csXYbvfo3ON2PfsQfwUb0HFd8JeZUlZg6w393PtEyjd2
 vHRCRrbMIxsMg0ufnLUO0b8PEx3KF065czuUPqbzv2rsf+BBcJlHLsqD6Wd/WUrtP5CB
 a8Sg==
X-Gm-Message-State: AOJu0YwtVvbYfzO1w+4SeVjDwip6FrcreYnFY9ZhPmHtcPGSRKN+w5qT
 k+TX6KIHr2/d12yRrTbd47i4OodOeYkkM9Tn8FF50pmzDjBtIuSfELAEmXmPpdayyJE=
X-Gm-Gg: AZuq6aIirHCPRUqCOE6liKqrAv5XTYdAWx1TCIQ414+Y+O1yD9z6PUJOOJIw+UfVYr/
 DkhxgHJIK/wyG+1+EoISG4gtEJUxAnGFt3I9ru4wuZML7JqolFIxfZah1K1WSEsGBsGu9idTdki
 LbuV4LcvW2sXfGQXPtADw7Hz3az9UKuy+Dg8Qs4XufkAmvxq9PFl3hQjoHXpsCBD4Tt6dwrTHjo
 6toIPNjW5SQ49USoikdBCgf0eg86biL7GZZIkPxHeguc8gFQui7iVOLLpyLIiG76Me0Q6W2Y6kZ
 0GQouNIGcVSCF6Q2tyBbTunA/ZrE9x4R68dLbRXv9/Hgh6bQ+4Nkb9ioJMATwkoB39hfRZklNFO
 5jj8EwivAa4luc0gvW3dClxzPExnHCrDv5FGRUG3dHBgpLqF1B+WzOZdTTdjXtjcuK+lF98x3MB
 v5k48LXiLf1CQ/mVgPsAJdCmp4MvunJINFKgFraNgD+N/tVipUnUTw6lAqCR8vnUblvUTRDKYGe
 eqOkS5XtA==
X-Received: by 2002:a05:600c:a00d:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-482db465e44mr138110075e9.14.1770034093712; 
 Mon, 02 Feb 2026 04:08:13 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e267b699sm89784635e9.16.2026.02.02.04.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:08:13 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 02 Feb 2026 13:08:11 +0100
Subject: [PATCH 1/3] arm: mediatek: add support for MediaTek MT8195 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-add-mt8195-clock-support-v1-1-5d03495246b9@baylibre.com>
References: <20260202-add-mt8195-clock-support-v1-0-5d03495246b9@baylibre.com>
In-Reply-To: <20260202-add-mt8195-clock-support-v1-0-5d03495246b9@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

This adds basic support for MediaTek MT8195 SoC.

Add watchdog support by adding upstream compatible string.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig         | 11 +++-
 arch/arm/mach-mediatek/Makefile        |  1 +
 arch/arm/mach-mediatek/mt8195/Makefile |  3 ++
 arch/arm/mach-mediatek/mt8195/init.c   | 91 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/mtk_wdt.c             |  1 +
 5 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index d1d2605b2cc..69d6208b03d 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -93,6 +93,15 @@ config TARGET_MT8188
           USB3.0 dual role, SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and
           several LPDDR3 and LPDDR4 options.
 
+config TARGET_MT8195
+	bool "MediaTek MT8195 SoC"
+	select ARM64
+	help
+	  The MediaTek MT8195 is a ARM64-based SoC with a quad-core Cortex-A73 and
+	  a quad-core Cortex-A53. It is including UART, SPI, USB3.0 dual role,
+	  SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and several LPDDR3
+	  and LPDDR4 options.
+
 config TARGET_MT8365
 	bool "MediaTek MT8365 SoC"
 	select ARM64
@@ -165,7 +174,7 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
 config MTK_TZ_MOVABLE
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 44591bed6fa..723862722b1 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_TARGET_MT7987) += mt7987/
 obj-$(CONFIG_TARGET_MT7988) += mt7988/
 obj-$(CONFIG_TARGET_MT8183) += mt8183/
 obj-$(CONFIG_TARGET_MT8188) += mt8188/
+obj-$(CONFIG_TARGET_MT8195) += mt8195/
 obj-$(CONFIG_TARGET_MT8365) += mt8365/
 obj-$(CONFIG_TARGET_MT8512) += mt8512/
 obj-$(CONFIG_TARGET_MT8516) += mt8516/
diff --git a/arch/arm/mach-mediatek/mt8195/Makefile b/arch/arm/mach-mediatek/mt8195/Makefile
new file mode 100644
index 00000000000..886ab7e4eb9
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8195/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += init.o
diff --git a/arch/arm/mach-mediatek/mt8195/init.c b/arch/arm/mach-mediatek/mt8195/init.c
new file mode 100644
index 00000000000..c399550b8fc
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt8195/init.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ *         Chris-QJ Chen <chris-qj.chen@mediatek.com>
+ */
+
+#include <asm/armv8/mmu.h>
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
+	printf("CPU:   MediaTek MT8195\n");
+	return 0;
+}
+
+static struct mm_region mt8195_mem_map[] = {
+	{
+		/* DDR */
+		.virt = 0x40000000UL,
+		.phys = 0x40000000UL,
+		.size = 0x200000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x20000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		0,
+	}
+};
+
+struct mm_region *mem_map = mt8195_mem_map;
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 4d4ab4cbe90..3c7e043c08e 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -146,6 +146,7 @@ static const struct udevice_id mtk_wdt_ids[] = {
 	{ .compatible = "mediatek,mt6589-wdt"},
 	{ .compatible = "mediatek,mt7986-wdt" },
 	{ .compatible = "mediatek,mt8188-wdt" },
+	{ .compatible = "mediatek,mt8195-wdt" },
 	{}
 };
 

-- 
2.52.0

