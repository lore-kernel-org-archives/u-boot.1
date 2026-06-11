Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F4DCD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 20:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F05BF8484C;
	Thu, 11 Jun 2026 22:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="aLxEJQXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC3F803F0; Thu, 11 Jun 2026 22:32:05 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92AAC803F0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 22:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-486304fa184so235296b6e.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781209922; x=1781814722; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f747iuF/mwZOJJeipM2wN1+6hCMJjd+4AeP7o3BdU6A=;
 b=aLxEJQXr5xYS864ZqN4afih1dq32t92Lo5yT4tm1XhkblOY2u6OhpT2XfiRpvE8kfb
 z8KualeSV8/7o8FzmxTdIRC8DEpBvyFJAAPsLLECpIikCAb6Yaa9pN1WtKvimExsbDOC
 Thvizgz/Ptj1g2PYvKkIv38JuFRcPCvZ2PnZhd6IzlKuCafM3G1SfUmYhsFAPp5l8tgg
 xJSnRzIiE2sJvTXXxkpqyc2AnDwEgAcOJs+WUnmp1FEtDdRU2jx6mffN7lMMlFVAhqkk
 UjtO8LS6Q8UvMRA8XCuwu9I7P4PE9U+QxWkKO7GDVDgKJYTKgq6FZZ7ij4tl6DSU/z1U
 Dc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781209922; x=1781814722;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f747iuF/mwZOJJeipM2wN1+6hCMJjd+4AeP7o3BdU6A=;
 b=qNG6vcMtgBF2GDHcJwOL7h9uYtkbh1opSl3Z50RcTOTb9LDVx88WjbFIyk0ObU4U1l
 ItErvLI45zv2B26TjdLtY636VhE/GdfT97zmDucWPWu+ll8/Vo/ouyYICmlyuCU9nE87
 1Ctcgm4mDfkDs16nxiGFfwvx07yXHaenddNetUhDdaA4JmfWT3OgP442qB5GA+kKQ+rL
 h6gP9gt2N1NPZvXnG7mjX8M4ljUD3WgG1QsCiHluwVvjiB68dDdDVTXlUyXlksqJvo6f
 eCn51BWf1rMNoKLyuNQe+X53BPtPR2We2GO0ohXuOEXutqate8kMDeKDfzdGC7U4NDIf
 UTGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kGZXn2rW3gD5dfye1kNxznrSC4kWP1lQAX6v9r7q864vIBzytjKqIfVS9SaS59N60/DNpQRY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6a3Rftp53+tGluq6hbZdbdo524XRHxDgmCkn+nlLHpdmz91bk
 3xODGykTfz6Aqo/E9VPN1+s23lPnkGaNsG+akP7qT1D17HbuOB66v47Z4O6BypIExB4=
X-Gm-Gg: Acq92OGY6TFtrtHvrHpGSkc0pwsBVQrApPlkTJgegL1QXXhzqcurgcVo0mDph3xsBiT
 cH3j2XDZ42faVlWk/oe3GOR7sbKxDZ/wZau6OHn6cVeGJK5oMrGaPz+sFTiqsINpDwOZhyOvIpw
 eYPup99f1QSvXg5XUGCXeWVvxjzwYdSobUBMMB6dMgnSKir5HGueiS93fcP35p2LJLNXxuLnlsD
 l8VlbAVsy7Eh5f34mLQPsR3hA2UXa3ToZ2wRKOagT+4tkyVfMzLQCIdlB/lO0iuF/+F5SUlDdj6
 e7YKDNQpb4X5n12Dmqn9hQrl53ng7FVhia99rgXniF98r/AX831VT9cGflZg8CwRv2VW+j48UvO
 Mno4MCmicmG7bByRRiNT1AZ+ZP1J5PBg6bF/tXIbp2/2kHFAK6ZWpIQOYFStbWntG65EKJ6pmIg
 Wui7ciQTOmBFSTVkdflHlKPZvSFPA=
X-Received: by 2002:a05:6808:1813:b0:482:5bd1:d8e5 with SMTP id
 5614622812f47-4872f3136cdmr5099b6e.9.1781209922229; 
 Thu, 11 Jun 2026 13:32:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b32f372sm21081573b6e.0.2026.06.11.13.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:32:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 15:31:01 -0500
Subject: [PATCH 2/7] arm: mediatek: mt7987: fix gd->bd->bi_dram[0].size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-mtk-fix-ram-size-v1-2-42ed330660ca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5992; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=zoKlUdtnrJkLyoVnfGQeUaVXUeHyYmkrJ1+eAaTvkqo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKxsU/mp2TBZSDr3oagWvUaCR2I0pJd0DitG/2
 1Tf7MRC3auJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaisbFBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AQaoH/A5Ui3DSo/6/BpUyfsXyFl+EAg4XFyf8MRYlzgS
 lV35h2KWjO30h7GBP7pfL2pZknSR9ASUh/6Bm4s+xS4+bd3B2x1c6FADq9/m50Q5pf9GV+mvccj
 lus/0wxPekpuOb38525XCDHvjoRQw/1G3n5Yxchh2HzLbZmcSYKSZ9Lia91GUUpYTdFp1bA6aNY
 idbw1sn9rV5BbJrbAqUF9v3nXYx2N63z6hn4NyZygBVGy9N8Vb5VorAmtlIlyLQwL5/cKNRcvJo
 U3tLaOvF5wqc0x/tEEQ7B6JOF8ISzWSmkq8bedxNgWu3N6Hvob+xX/YjwTQQlLhKKeVjgkbIc+M
 iBok=
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

Prior to commit 56183fb025c2 ("arm: mediatek: mt7987: drop
dram_init_banksize()"), gd->bd->bi_dram[0].size was overridden in
a board-specific dram_init_banksize() implementation. When that was
removed get_effective_memsize() set gd->bd->bi_dram[0].size to the wrong
value because of CFG_MAX_MEM_MAPPED.

Rather than continue to use an old-style CFG_ option and the potentially
confusing overriding of gd->bd->bi_dram[0].size (it is difficult to see
which order the functions that set it are called), we can just use
board_get_usable_ram_top() to set gd->ram_top to the correct value
instead. This is possible now, thanks to LMB_LIMIT_DMA_BELOW_RAM_TOP
being set by default for 64-bit Mediatek ARM SoCs.

On mt7987, there is already an implementation of
board_get_usable_ram_top() for other reasons, so it is modified to
also limit ram_top to 4GiB (mt7987 is currently the only thing that
sets CONFIG_MTK_TZ_MOVABLE=y so it is safe to change this here without
unintentional side-effects).

The CFG_MAX_MEM_MAPPED option is removed since it is no longer needed.
The config header and Kconfig option are also removed since that was
the last CFG_ option.

Fixes: 56183fb025c2 ("arm: mediatek: mt7987: drop dram_init_banksize()")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig    |  1 -
 arch/arm/mach-mediatek/tzcfg.c    | 22 +++++++++++++---------
 board/mediatek/mt7987/MAINTAINERS |  1 -
 include/configs/mt7987.h          | 14 --------------
 4 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 80f7185e929..054b1bf92bf 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -199,7 +199,6 @@ config SYS_CONFIG_NAME
 	default "mt7629" if TARGET_MT7629
 	default "mt7981" if TARGET_MT7981
 	default "mt7986" if TARGET_MT7986
-	default "mt7987" if TARGET_MT7987
 	default "mt7988" if TARGET_MT7988
 	default "mt8183" if TARGET_MT8183
 	default "mt8512" if TARGET_MT8512
diff --git a/arch/arm/mach-mediatek/tzcfg.c b/arch/arm/mach-mediatek/tzcfg.c
index c8fe8ac0e9b..fbc96d96a4b 100644
--- a/arch/arm/mach-mediatek/tzcfg.c
+++ b/arch/arm/mach-mediatek/tzcfg.c
@@ -35,12 +35,13 @@ struct tz_reserved_region {
 };
 
 static bool fix_tz_region(struct tz_reserved_region region[],
-			  uint32_t used_regions)
+			  uint32_t used_regions,
+			  phys_addr_t ram_top)
 {
 	phys_addr_t size;
 
-	if (region[0].addr + region[0].size > gd->ram_top) {
-		if (region[0].addr >= gd->ram_top) {
+	if (region[0].addr + region[0].size > ram_top) {
+		if (region[0].addr >= ram_top) {
 			debug("Discarded region 0x%08llx, size 0x%llx\n",
 			      region[0].addr, region[0].size);
 
@@ -50,7 +51,7 @@ static bool fix_tz_region(struct tz_reserved_region region[],
 			return true;
 		}
 
-		size = gd->ram_top - region[0].addr;
+		size = ram_top - region[0].addr;
 
 		debug("Truncated region 0x%08llx, size 0x%llx -> 0x%llx\n",
 		      region[0].addr, region[0].size, size);
@@ -63,12 +64,15 @@ static bool fix_tz_region(struct tz_reserved_region region[],
 
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
-	phys_addr_t uboot_ram_top, pstore_size, uboot_size = 0;
+	phys_addr_t uboot_ram_top, ram_top, pstore_size = 0, uboot_size = 0;
 	struct tz_reserved_region region[2], tmp;
 	phys_addr_t top_addr, low_addr;
 	struct arm_smccc_res res;
 	u32 used_regions = 1;
 
+	/* ram_top must be <= 4GiB due to DMA limitations */
+	ram_top = min_t(phys_addr_t, gd->ram_top, SZ_4G);
+
 	/* BL31 region */
 	arm_smccc_smc(MTK_SIP_GET_BL31_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
 	if (res.a0) {
@@ -119,14 +123,14 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	}
 
 	debug("Effective memory @ 0x%08zx, size 0x%llx\n", gd->ram_base,
-	      gd->ram_top - gd->ram_base);
+	      ram_top - gd->ram_base);
 
 	/* Discard/fix region which is outside the effective memory */
-	if (fix_tz_region(region, used_regions)) {
+	if (fix_tz_region(region, used_regions, ram_top)) {
 		used_regions--;
 
 		if (used_regions) {
-			if (fix_tz_region(region, used_regions))
+			if (fix_tz_region(region, used_regions, ram_top))
 				used_regions--;
 		}
 	}
@@ -144,7 +148,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	uboot_size += U_BOOT_MIN_STACK_SIZE + REGION_ALIGNMENT - 1;
 	uboot_size &= ~(REGION_ALIGNMENT - 1);
 
-	uboot_ram_top = gd->ram_top & ~(REGION_ALIGNMENT - 1);
+	uboot_ram_top = ram_top & ~(REGION_ALIGNMENT - 1);
 
 	if (!used_regions ||
 	    (uboot_ram_top - region[0].addr - region[0].size >= uboot_size)) {
diff --git a/board/mediatek/mt7987/MAINTAINERS b/board/mediatek/mt7987/MAINTAINERS
index c257d0b09df..b245174b0f7 100644
--- a/board/mediatek/mt7987/MAINTAINERS
+++ b/board/mediatek/mt7987/MAINTAINERS
@@ -2,7 +2,6 @@ MT7987
 M:	Sam Shih <sam.shih@mediatek.com>
 S:	Maintained
 F:	board/mediatek/mt7987
-F:	include/configs/mt7987.h
 F:	configs/mt7987_rfb_defconfig
 F:	configs/mt7987_emmc_rfb_defconfig
 F:	configs/mt7987_sd_rfb_defconfig
diff --git a/include/configs/mt7987.h b/include/configs/mt7987.h
deleted file mode 100644
index 18ed3c7a55b..00000000000
--- a/include/configs/mt7987.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Configuration for MediaTek MT7987 SoC
- *
- * Copyright (C) 2025 MediaTek Inc.
- * Author: Sam Shih <sam.shih@mediatek.com>
- */
-
-#ifndef __MT7987_H
-#define __MT7987_H
-
-#define CFG_MAX_MEM_MAPPED		0xC0000000
-
-#endif

-- 
2.43.0

