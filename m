Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EEACD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 20:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E6BB8056B;
	Thu, 11 Jun 2026 22:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Vl2yzN6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665CD8486B; Thu, 11 Jun 2026 22:32:07 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5367846D3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 22:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-486118ecd5dso244219b6e.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781209923; x=1781814723; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=syl0zVayMmOwnBGmQEjnY3Is8JpsjY9UKCV5kuICZvA=;
 b=Vl2yzN6m+PFoa5I7nA6rifIwyS53yJyRKz10NiaFukxn5pqunQv/wuxglvYMZQRbkE
 qxDXX4FTGWu4/HFmW28ehpKfP9maU76UDtIcQsF043MWWfKX/M6tin8TxDVBic4+9UYZ
 jN6jtpv0rLdS//G5UsY7JDLBhRquZ38S9FlZaZtqywMvTOimo4wwweb4uZ+hKZsdytgs
 E2LY6ZqkLoNhgRnwE55Id0i7fsTZ86eLtWLdzbasz9zudhNPR9c7JhbxjkVlz44OuERX
 4ZIKk78lLDyN6pbJNX65piT7UsZAH3BGPH9AUyZE6D8q6wcC+xskoU3Y7g6erwjecXHJ
 IEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781209923; x=1781814723;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=syl0zVayMmOwnBGmQEjnY3Is8JpsjY9UKCV5kuICZvA=;
 b=kMEQwTILxfyrXL11VPp1fle5vico+XbnsRCIOKI5lIXSV/Hik/dSnhrYgXlFJHSi48
 4ddiZBvJW6gmaX/cQ2f7QlP0Wzbc3v4/SoqgrtBTts4lsORdEEVDhZzpKD0b81h/52fb
 bFimKVKGe02znT32Hnv92ptFKjEBJ0o4Zr5+L2LBEy6D+FKjFeb5o/817jdf7QkWqUds
 yt1kc2pyFwYSzX6HQSyNmrJgcKhCFYazrLeOophck7bq+9sxv34JI50KZSTgCDK82NGi
 /hiuvgd99doOiRdW0vnQTi5JviRxfyGKnBaG/KH9LbBm+MGb4KrBZba97wQbIghmV2Pc
 yNyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ91/SisMTQhXOCkr+LzqQuH0Z/1JvvrA5y5Gstw4J6V0NP6MR5wKE+Ci+31VanS6APYVr7INoo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx49d+lKAZ+hPHwB/D2Q4KXYeoRjCWPG/6VNYVT5hMhRs9aPf9j
 ETu4fCLQ13dwOFLrNmwgzrfHVaU9Xl5ce0wlDfzkGZW1hXLotzUft1CB5YgwvAm+0JU=
X-Gm-Gg: Acq92OG3odakWtp2aeTej8pdCbvOVtttul4yzMCa+9vZ/yqGUT/2HxqhREXQByFGPcE
 i3+lUv5UZCg3MkcfGInKwMb5jDvDwKI13sL4dbF0SVnXbGjoWP7x/8ZD/uYCKOGPPegGxE7y8rg
 uylY9vEvlZmOAQef4FVgzaKVFjz8t2NsNA8E09hAHH8yyLiPkzknmvC8G02KrK5/KFIi0XgEVfs
 2NIO04o4TEHPo6nUP5YzQbK9JjKGN1AqB6VzGs1LBH5iY0dJKwWBNc7eS99fE5Tb6xM67D5EFpO
 XIUO5lAKasbrdTh6m+4g2GQE0V/PocDPY39GHDcK3RzXQeknE15A9iB3LViZuljBz3TwkvYVtDs
 zu9eP8hETEVv9L1ETKCYKyGm1xbA6VolQZd9CC3ae4yyHRiuV2kH5Sw4BEBgfNxgLR06CH24MGj
 mYUGo2qKkd6koecdh6UfUbxAmkzZpduxf/2L/RGg==
X-Received: by 2002:a05:6808:17a2:b0:46a:ccae:5517 with SMTP id
 5614622812f47-4871a546bfcmr3404799b6e.28.1781209923603; 
 Thu, 11 Jun 2026 13:32:03 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b32f372sm21081573b6e.0.2026.06.11.13.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:32:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 15:31:02 -0500
Subject: [PATCH 3/7] arm: mediatek: mt7988: fix gd->bd->bi_dram[0].size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-mtk-fix-ram-size-v1-3-42ed330660ca@baylibre.com>
References: <20260611-mtk-fix-ram-size-v1-0-42ed330660ca@baylibre.com>
In-Reply-To: <20260611-mtk-fix-ram-size-v1-0-42ed330660ca@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Rudy Andram <rmandrad@gmail.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3908; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=NhuoHGgdkLSxcIjU2fxzjV0A8aVING7wPjPCTJuTe54=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKxsbp0K1WCIIR1rmfHg7hJo+5DZOqgFUjbfhb
 DYUl4vj3fCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaisbGxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AYZIH/AwTXsqkv85BZgPaQtOFZAcKPDuycOoXFn9FYDF
 U7DAKL68/+QmPZimmm1wDfy9E7N/S0xIKeSE+81FMbZ5JL0NgSv24Hak4NGCrM4E6yMOfEtXSFB
 8A1I7SEETHcHl2RoCxojFl43Dx0x0AW0yhGcO/T1AOJX9iRDhnv7D5vxAs0XdMGiRUz+/lkMjPt
 vg/bRE/dCDkIQ5JJdXXnRUs4M5bZCX6jNk5XLi81jcki74Gd2361blCpMU7W4P8cc21MNYnCQhM
 pIzV4dKF3J0dvnH2LB0+ddmd2z4FW2zcfwt2aPsHdpHwoPlLZejaMt3CTCoNJmnzzDI7kCW48JV
 QtU8=
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

