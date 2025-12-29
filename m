Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32F3E784BE
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 01:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 583AE83D52;
	Mon, 29 Dec 2025 02:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nE9jMoMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BD878003E; Mon, 29 Dec 2025 01:06:08 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C9FA83C0C
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 01:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=aargri@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c6cc366884so4117161a34.1
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766966764; x=1767571564; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QD9TkyZRKMbzBP6Ai6d2A/qiqHMDAd4Xt3Y+qdKdx6k=;
 b=nE9jMoMjWQMTeN50lbr6gsxmDDBvDK/zYuA+HM792yJruZWzvwC7XurZtQvbU84hlF
 RJaNVvDtsofEF5SBbiYNddaVHAi4nMxi3VzHiqURH64mg861eDvJ1Atm1VthIOO9JWQn
 VfC8cFF8vzCzgD9HvZNBujzIhgE5P6JgDV2P8KUDVl/roiPcVXxUwhn0jYs0U6tMktl7
 omlqhGUQTirGj6xAWhVKeZiGEAUB8Erz3mv3xeZAq8NHSO/AvT5z79grqY9o1feXgwr+
 LA9//wgYQ8uU1MS77wbf8toJuiwrK1D5UVwEQ3JBWrTbimzTcwGOYrqAVpqX5YFDvTap
 hxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766966764; x=1767571564;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QD9TkyZRKMbzBP6Ai6d2A/qiqHMDAd4Xt3Y+qdKdx6k=;
 b=beaIe3Zih0LtkBszO6cr4LIlvSairy144Yq7q/HTkMhUWR2qF9PeCiLP3dbuv4MhnR
 i/Y7BKElvqmYE8gf0gA9+Zd1a0JLIYBSwEpBeQJrkkQF3ugEnVkci9ZsFwRdNKkr9k3u
 hSDCwHEfQIJ8Ku72I0Br6ztX6EStCqFnomOGrkXmfpLYiY54/bXsmZM7o2aVo4SgJc5y
 Ti2TaBXCOddmvFh9ZjLpKBayR/RBqnKq8eKFB0rRQ+gfjUi0P9IdSr8A92DjWsjCh1Cx
 AkXyjufCZ3UGrDulAp5v8RLGr4u0ChiKmtf9X1CPypwhU1CdtczhNLgRM7hWCoKQk6W+
 EBxA==
X-Gm-Message-State: AOJu0YyQd5mM7OlleHlA6Cx8eB+LXvkJCH0JYI/gh5ALuYkPva7fZR1j
 79XJ2p60guMiS/xyx2KASqGAvsAPSIWgZK5eI6wBUMJH48Kut0htfelm
X-Gm-Gg: AY/fxX4+UEoGyKEBL1utRDaiXwj8yFCbIvWCvrdvsOgtV6UW7FC+IbOEWI1GP52p9M2
 VKKx94+Y4Memp7b/xyjqRkWj5XlqXaggX8zdbKTidHuyesqKQqXjJ8ERu0fLNz4TvewFSY1gXL6
 6zPr2mei4WJk3DDJXQmvJXeibTKledv9sOqyqyC7gCMIOI+oYcGtZXX9pizdC8iijII7UTcYl7J
 4OQTCiKu06B7VX3P9mYHijJqOCCoXHQVuRH8BQJN2Y91eMkcKne+839E1thTTbgdDLDEkoP5aef
 oj9BElEBis3xBvxsvnWXGZobn4mP8KHDBxCIdrDUfzWw/LkrVCTUV8132EkNMf3c+9XkH/IMjtG
 ET6LfcLOtFHkyZXlfuY6q5AJqlIcYQqx3WHQVOWbZe9ZK3PKDs4pR0dALkYmke/YGq1/Y+uR73P
 qhx+V0Jc4IExDWWDO56CZszRsfg6Bb6MpEMBU56pgTWasf9HCXV9B0vdSiN0kBREyyTSA=
X-Google-Smtp-Source: AGHT+IE9bn0eFSCYGJgBRsnm2YtZLNnbtl/F0SyhBv6fn7se3X7uO33bsu9WS0n0lYThMShlLH6TnA==
X-Received: by 2002:a05:6808:1526:b0:450:3ff9:f4dd with SMTP id
 5614622812f47-457b20b7730mr14279949b6e.24.1766966763842; 
 Sun, 28 Dec 2025 16:06:03 -0800 (PST)
Received: from [127.0.1.1] (172-2-191-226.lightspeed.clmboh.sbcglobal.net.
 [172.2.191.226]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9468sm19397294a34.28.2025.12.28.16.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 16:06:03 -0800 (PST)
From: Aaron Griffith <aargri@gmail.com>
Date: Sun, 28 Dec 2025 19:05:27 -0500
Subject: [PATCH 5/5] rockchip: sdram: only reserve BL31 and use mem_map on
 ARM64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-rockchip-tpl-use-atags-v1-5-8ac5140c3763@gmail.com>
References: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
In-Reply-To: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Aaron Griffith <aargri@gmail.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 29 Dec 2025 02:48:58 +0100
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

This logic to reserve space for BL31 and to add memory holes from
mem_map only makes sense on ARM64. This change simply wraps all of
this logic to only run if CONFIG_ARM64 is enabled. On non-ARM64, it
falls back to accepting memory info from the TPL unmodified.

This is useful on e.g. RK3506, which is not ARM64, but which does
receive memory information from the TPL.

Signed-off-by: Aaron Griffith <aargri@gmail.com>
---
 arch/arm/mach-rockchip/sdram.c | 154 +++++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 287073c0e50839cc9366baacbc47512dbe2b4476..82e8e2876f6faca71ff0a8622f08ab3c10a7390a 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -115,103 +115,105 @@ static u32 js_hash(const void *buf, u32 len)
 __weak int rockchip_dram_init_banksize_add_bank(u8 *next_bank, phys_addr_t start_addr,
 						phys_size_t size)
 {
-	struct mm_region *tmp_mem_map = mem_map;
-	phys_addr_t end_addr;
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		struct mm_region *tmp_mem_map = mem_map;
+		phys_addr_t end_addr;
 
-	/*
-	 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
-	 * have it, so force this space as reserved.
-	 */
-	if (start_addr < CFG_SYS_SDRAM_BASE + SZ_2M) {
-		size -= CFG_SYS_SDRAM_BASE + SZ_2M - start_addr;
-		start_addr = CFG_SYS_SDRAM_BASE + SZ_2M;
-	}
-
-	/*
-	 * Put holes for reserved memory areas from mem_map.
-	 *
-	 * Only check for at most one overlap with one reserved memory
-	 * area.
-	 */
-	while (tmp_mem_map->size) {
-		const phys_addr_t rsrv_start = tmp_mem_map->phys;
-		const phys_size_t rsrv_size = tmp_mem_map->size;
-		const phys_addr_t rsrv_end = rsrv_start + rsrv_size;
-
-		/*
-		 * DRAM memories are expected by Arm to be marked as
-		 * Normal Write-back cacheable, Inner shareable[1], so
-		 * let's filter on that to put holes in non-DRAM areas.
-		 *
-		 * [1] https://developer.arm.com/documentation/102376/0200/Cacheability-and-shareability-attributes
-		 */
-		const u64 dram_attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			PTE_BLOCK_INNER_SHARE;
 		/*
-		 * (AttrIndx | SH) in Lower Attributes of Block
-		 * Descriptor[2].
-		 * [2] https://developer.arm.com/documentation/102376/0200/Describing-memory-in-AArch64
+		 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
+		 * have it, so force this space as reserved.
 		 */
-		const u64 attrs_mask = PMD_ATTRINDX_MASK | GENMASK(9, 8);
-
-		if ((tmp_mem_map->attrs & attrs_mask) == dram_attrs) {
-			tmp_mem_map++;
-			continue;
+		if (start_addr < CFG_SYS_SDRAM_BASE + SZ_2M) {
+			size -= CFG_SYS_SDRAM_BASE + SZ_2M - start_addr;
+			start_addr = CFG_SYS_SDRAM_BASE + SZ_2M;
 		}
 
 		/*
-		 * If the start of the DDR_MEM tag is in a reserved
-		 * memory area, move start address and resize.
+		 * Put holes for reserved memory areas from mem_map.
+		 *
+		 * Only check for at most one overlap with one reserved memory
+		 * area.
 		 */
-		if (start_addr >= rsrv_start && start_addr < rsrv_end) {
-			if (rsrv_end - start_addr > size) {
-				debug("Would be negative memory size\n");
-				return -EINVAL;
-			}
-
-			size -= rsrv_end - (start_addr - CFG_SYS_SDRAM_BASE);
-			start_addr = rsrv_end;
-			break;
-		}
+		while (tmp_mem_map->size) {
+			const phys_addr_t rsrv_start = tmp_mem_map->phys;
+			const phys_size_t rsrv_size = tmp_mem_map->size;
+			const phys_addr_t rsrv_end = rsrv_start + rsrv_size;
 
-		if (start_addr < rsrv_start) {
-			end_addr = start_addr + size;
+			/*
+			 * DRAM memories are expected by Arm to be marked as
+			 * Normal Write-back cacheable, Inner shareable[1], so
+			 * let's filter on that to put holes in non-DRAM areas.
+			 *
+			 * [1] https://developer.arm.com/documentation/102376/0200/Cacheability-and-shareability-attributes
+			 */
+			const u64 dram_attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				PTE_BLOCK_INNER_SHARE;
+			/*
+			 * (AttrIndx | SH) in Lower Attributes of Block
+			 * Descriptor[2].
+			 * [2] https://developer.arm.com/documentation/102376/0200/Describing-memory-in-AArch64
+			 */
+			const u64 attrs_mask = PMD_ATTRINDX_MASK | GENMASK(9, 8);
 
-			if (end_addr <= rsrv_start) {
+			if ((tmp_mem_map->attrs & attrs_mask) == dram_attrs) {
 				tmp_mem_map++;
 				continue;
 			}
 
 			/*
-			 * If the memory area overlaps a reserved memory
-			 * area with start address outside of reserved
-			 * memory area and...
-			 *
-			 * ... ends in the middle of reserved memory
-			 * area, resize.
+			 * If the start of the DDR_MEM tag is in a reserved
+			 * memory area, move start address and resize.
 			 */
-			if (end_addr <= rsrv_end) {
-				size = rsrv_start - start_addr;
+			if (start_addr >= rsrv_start && start_addr < rsrv_end) {
+				if (rsrv_end - start_addr > size) {
+					debug("Would be negative memory size\n");
+					return -EINVAL;
+				}
+
+				size -= rsrv_end - (start_addr - CFG_SYS_SDRAM_BASE);
+				start_addr = rsrv_end;
 				break;
 			}
 
-			/*
-			 * ... ends after the reserved memory area,
-			 * split the region in two, one for before the
-			 * reserved memory area and one for after.
-			 */
-			gd->bd->bi_dram[*next_bank].start = start_addr;
-			gd->bd->bi_dram[*next_bank].size = rsrv_start - start_addr;
+			if (start_addr < rsrv_start) {
+				end_addr = start_addr + size;
+
+				if (end_addr <= rsrv_start) {
+					tmp_mem_map++;
+					continue;
+				}
+
+				/*
+				 * If the memory area overlaps a reserved memory
+				 * area with start address outside of reserved
+				 * memory area and...
+				 *
+				 * ... ends in the middle of reserved memory
+				 * area, resize.
+				 */
+				if (end_addr <= rsrv_end) {
+					size = rsrv_start - start_addr;
+					break;
+				}
+
+				/*
+				 * ... ends after the reserved memory area,
+				 * split the region in two, one for before the
+				 * reserved memory area and one for after.
+				 */
+				gd->bd->bi_dram[*next_bank].start = start_addr;
+				gd->bd->bi_dram[*next_bank].size = rsrv_start - start_addr;
+
+				*next_bank += 1;
+
+				size = end_addr - rsrv_end;
+				start_addr = rsrv_end;
 
-			*next_bank += 1;
-
-			size = end_addr - rsrv_end;
-			start_addr = rsrv_end;
+				break;
+			}
 
-			break;
+			tmp_mem_map++;
 		}
-
-		tmp_mem_map++;
 	}
 
 	if (*next_bank > CONFIG_NR_DRAM_BANKS) {

-- 
2.47.3

