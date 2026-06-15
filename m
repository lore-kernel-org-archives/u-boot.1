Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF664CD98CF
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 19:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C81848E2;
	Mon, 15 Jun 2026 21:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="IXi57pUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1976848DC; Mon, 15 Jun 2026 21:24:39 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20FC6846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 21:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-43ccf0ba2e5so1503409fac.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781551476; x=1782156276; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=syl0zVayMmOwnBGmQEjnY3Is8JpsjY9UKCV5kuICZvA=;
 b=IXi57pUbcChWFTKMl9zMcWhG9sjsdkkAaXZ7GSEFxFS861aSmEObNXb3Ar8oTsu9fz
 M2R6t1ZNDCpoLz9ZfOmN1OWWpZB8m+De2pWViu7vcKB1ZsYOMHuRhnyT8QXKKcmDHFbR
 I48yhTxe5BiPrR3L7Kcfq2DOfm5g8k4ByBn63nIGYKJ2QSdi+uR995zZBF2hPE7dQX56
 9P0bpvfAF5ea/WRg5b8tagGPNQivY3roaChHjgJe3pXwSMvd7eKk49Kt7ce3oNkcgymV
 5OqO8a1CvBS5B3ujoPtsttK92/KY40vDupN9a/K3Ejn2JjNQxK4fpOG4EFSnvfonFOPZ
 nUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781551476; x=1782156276;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=syl0zVayMmOwnBGmQEjnY3Is8JpsjY9UKCV5kuICZvA=;
 b=V/5vnO+XYc2hjdHb5jMUVb8IS2vgtBhZU2bShiJp6ZQjfkE9LPu9njN7CDyCFWFJ6S
 t09bT53Aie36MOyoKDNLfAUvGKfmYJ6va8xO3DH8h8TJCAeSctABNkTG62wK8QmlL6Qf
 Eq6hcm36PUGIYrYiFDYmMrHfJQLtYpS/ISZZjyPE8kIbXsFtzj/4JL9GeGspcRqfRrBc
 b1SyWVJa64a4w6dYW7z2UaVhPz9NY6zKq/Dv3rN9zzt8vr2I2wMOSZytufy93JvUJGyD
 6RTLx/LoMcDHL8n6wWLQVYiUZxduscZz0oQipB2AdcexGkysv3ya8jb5mN0SZYmXlCxx
 MLQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Hc8VNkR9zyA7ijJIM8LUu50anZ3wSfJtNff31GWJOMkFGJPf3L5rNePWJ8zBlHqjBWbxCZfY=@lists.denx.de
X-Gm-Message-State: AOJu0YzpHNqCjMId5BbTtVH5DosjmVpb9NZNcqCVsLE+yF2b0ddGZYgJ
 LebkE+pu1TJWeA3xLkGRh1Kqyh6B1DOSnrtAvpLcixErJyyUs7C9tubQVEJOtUpazcA=
X-Gm-Gg: Acq92OFcaZLufHNWcv391Sji/1vQLQDMNrUt1NOVG0hWGig91cuNPlYfgI5nbOZfy0n
 hcwZbZpr35NAyJD+DvnW6nkAk8ZityZRB8kiURhCfg2RUdjLU3Rg+MiHL7iSkPfh59qx8EpucOe
 8UT9QnOMgmhpWLCb6+/ZGWzedPCpDKPB55nlsnBs9ETE6DzutgsnPkTCsi1xfgfZPNFG1xoyQbI
 ScXokJcRy1/MsI0J7Ejw0vWUs2xq0LCW4HooXm/YWXa0ze4ZLLX3ezWxf9pw7xa7yGIgDk8unjg
 pZi9USEM/NXuL0jduhII0UKJS8AfEBFcMiBXUprjiJFIwRaX405+c4QK/CDz7fkkhWot2fdHGnl
 qwZzONg7BnPZ6gkeMbrFW1W4Onii3O7NDh6AxjqHB6l92NvtRWfIjVkytdo74+g3ObSQQjnpTxu
 swjt6gwT7WnfftkcKBLvUGFYFe3dtq
X-Received: by 2002:a05:6870:65a9:b0:43d:2e43:9e4e with SMTP id
 586e51a60fabf-4426dfd1263mr10018971fac.17.1781551475843; 
 Mon, 15 Jun 2026 12:24:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430866fa15sm573450fac.0.2026.06.15.12.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:24:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 15 Jun 2026 14:23:34 -0500
Subject: [PATCH v2 4/8] arm: mediatek: mt7988: fix gd->bd->bi_dram[0].size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-mtk-fix-ram-size-v2-4-f72cfc52ce58@baylibre.com>
References: <20260615-mtk-fix-ram-size-v2-0-f72cfc52ce58@baylibre.com>
In-Reply-To: <20260615-mtk-fix-ram-size-v2-0-f72cfc52ce58@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Rudy Andram <rmandrad@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3908; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=NhuoHGgdkLSxcIjU2fxzjV0A8aVING7wPjPCTJuTe54=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqMFFOBihxeaMFEktH+d3LqGJvOc6XjQjEiUmKc
 EJhuKfvAX+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajBRThYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ah2cH/AvmUHWqQS0lPB2F2Gb31u57VK+6vY+Fym8VvTy
 IMgC4YgU30Hw+Zk7YwKxDbh72rBL3MZtH12QMf62GDkyd+70MoRZNmHa0CDYzvWtosOVNrKqNsr
 0kUh3OkIEAcSThfHOFEeuQpbKfCAM0oMmZ9LGNYOoMbbJGqo84FfC+HM/HSIX3rSVNpVuWQozt1
 6NEIG/yFqT46vHZgwgxgcIES1+GAk/SQWHsiWUAPnt8o0d7+OLQqDHCoWUWCk03kWTbLjCNf9aK
 yHWqDGqH3fWAuNRlcZ3QJgslkY1Gk10vr37ArEs7J3sUaGm+GXroI16iwuqZoDiTf5wb2zeCQ27
 kWz0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Use board_get_usable_ram_top() instead of get_effective_memsize() to
set gd->ram_top to something <= 4GiB.

Both board_get_usable_ram_top() and get_effective_memsize() are used to
set gd->ram_top in setup_dest_addr(). However, get_effective_memsize()
also sets gd->bd->bi_dram[0].size in dram_init_banksize(), which is
undesirable.

Prior to commit bddd6bbef3dc ("arm: mediatek: mt7988:
drop dram_init_banksize()"), gd->bd->bi_dram[0].size was overridden in
a board-specific dram_init_banksize() implementation. When that was
removed get_effective_memsize() set gd->bd->bi_dram[0].size to the wrong
value because of CFG_MAX_MEM_MAPPED.

Rather than continue to use an old-style CFG_ option and the potentially
confusing overriding of gd->bd->bi_dram[0].size (it is difficult to see
which order the functions that set it are called), we can just use
board_get_usable_ram_top() to set gd->ram_top to the correct value
instead. This is possible now, thanks to LMB_LIMIT_DMA_BELOW_RAM_TOP
being set by default for 64-bit Mediatek ARM SoCs.

The CFG_MAX_MEM_MAPPED option is removed since it is no longer needed.
The config header and Kconfig option are also removed since that was
the last CFG_ option.

Reported-by: Rudy Andram <rmandrad@gmail.com>
Closes: https://lore.kernel.org/u-boot/20260602162233.2418471-1-rmandrad@gmail.com/
Fixes: bddd6bbef3dc ("arm: mediatek: mt7988: drop dram_init_banksize()")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig       |  1 -
 arch/arm/mach-mediatek/mt7988/init.c | 10 ++++++++++
 board/mediatek/mt7988/MAINTAINERS    |  1 -
 include/configs/mt7988.h             | 14 --------------
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 054b1bf92bf..799c630fed3 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -199,7 +199,6 @@ config SYS_CONFIG_NAME
 	default "mt7629" if TARGET_MT7629
 	default "mt7981" if TARGET_MT7981
 	default "mt7986" if TARGET_MT7986
-	default "mt7988" if TARGET_MT7988
 	default "mt8183" if TARGET_MT8183
 	default "mt8512" if TARGET_MT8512
 	default "mt8516" if TARGET_MT8516
diff --git a/arch/arm/mach-mediatek/mt7988/init.c b/arch/arm/mach-mediatek/mt7988/init.c
index 7f4d934bfe9..5b37a91cd72 100644
--- a/arch/arm/mach-mediatek/mt7988/init.c
+++ b/arch/arm/mach-mediatek/mt7988/init.c
@@ -6,6 +6,7 @@
 
 #include <fdtdec.h>
 #include <init.h>
+#include <linux/kernel.h>
 #include <linux/sizes.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
@@ -26,6 +27,15 @@ int dram_init(void)
 	return 0;
 }
 
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	/*
+	 * Limit gd->ram_top not exceeding SZ_4G. Because some peripherals like
+	 * MMC requires DMA buffer allocated below SZ_4G.
+	 */
+	return min(gd->ram_top, SZ_4G);
+}
+
 void reset_cpu(ulong addr)
 {
 	psci_system_reset();
diff --git a/board/mediatek/mt7988/MAINTAINERS b/board/mediatek/mt7988/MAINTAINERS
index a45bfff26ca..c7e30342e5c 100644
--- a/board/mediatek/mt7988/MAINTAINERS
+++ b/board/mediatek/mt7988/MAINTAINERS
@@ -2,6 +2,5 @@ MT7988
 M:	Sam Shih <sam.shih@mediatek.com>
 S:	Maintained
 F:	board/mediatek/mt7988
-F:	include/configs/mt7988.h
 F:	configs/mt7988_rfb_defconfig
 F:	configs/mt7988_sd_rfb_defconfig
diff --git a/include/configs/mt7988.h b/include/configs/mt7988.h
deleted file mode 100644
index e63825a5a19..00000000000
--- a/include/configs/mt7988.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Configuration for MediaTek MT7988 SoC
- *
- * Copyright (C) 2022 MediaTek Inc.
- * Author: Sam Shih <sam.shih@mediatek.com>
- */
-
-#ifndef __MT7988_H
-#define __MT7988_H
-
-#define CFG_MAX_MEM_MAPPED		0xC0000000
-
-#endif

-- 
2.43.0

