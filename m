Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF37BE784BE
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 01:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1577283CF5;
	Mon, 29 Dec 2025 02:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N2Q4tFoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C28B383BC7; Mon, 29 Dec 2025 01:06:06 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA5828003E
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 01:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=aargri@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c7533dbd87so6449975a34.2
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766966762; x=1767571562; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DDIBwgMBjHIU3/XnRBYmOu1vv20nNiMVSgKhCKogHw0=;
 b=N2Q4tFoaJW6r6T6NAq8nJLi62UmkGGzHo6UEAew8ZyfX7nsaz7d6fk18PG0UcnGHno
 zKvTx2ePB2ZWl3ECScMxiAKElZYKSlWxkbk8SpdH6mAeszEspc7yF/2GjbdvFiYD1/WV
 9rwEG2+J+I59p7zYkY31yz3JaOkCA0WWR8P6/8wmKIV6u70v0pWVSlk5bqN26N/nYsLO
 sAxxYVQfbve1H1SZuwaZdxQ5sdHhnCS9hI5zdg+LGzwnmSD9sO963VIViXid38JzpnP4
 GW8JeDl0LSnQCZi1PuH/1445AET4CusvJgU0PJkuKAblEP3wnePDsT6hNGpqWPXLD91n
 PTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766966762; x=1767571562;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DDIBwgMBjHIU3/XnRBYmOu1vv20nNiMVSgKhCKogHw0=;
 b=PJerN1G9mvmlZS7uAfuNayVfyO6GVpGDJgKwONldBjnVp+273+7hfFg0HoUB9yU+3F
 bPXumJYQLQtN2339Q2WGmuUeG8Tw8RwwQJFjlk6P0IijQpG2MyNrriONw2LNuZbbtn9C
 ZAT8ck5A0jAA05qixeQXOdrO7P5WPrhVQPJVwfdIhrb7mhzz0OqgQNtkxGDz+FU+GD9W
 0u3tMidNUtQTaU8OqHfF0vxe2pCj42RZjvaomnnLvT1orKQJO/dPhYd4/OjKPA17Jg+e
 5xo9atxx0s6WvUgJAB7VF2lxlQUDjhGwfa5p6dLWc7xE2felCXYaZXvdtvg8BAtly1y8
 zNoQ==
X-Gm-Message-State: AOJu0YzmmH2VxxPxGaWN20VcZhUvWIXTIaY9neY/d0r470UvjQOEM1Dm
 rkIFFwhMn3VtlbFqZ7hQXGMAxlFM79i1TAam3deEXUn3R9BuHT9bhRuX
X-Gm-Gg: AY/fxX7hY6pj7Le/8CHY5bhjImybkyx1WcZq+0fDrXIcc6w6NyDvk0EIrPyJmhToLbE
 k0xoGUqxQZJ54OQSJ0kj+qihnZDeW4uS9sT3q80G1x8+iygBSYlsnupGwUyR4XcQaZB64iYNH0O
 a0JLk40dwMwqPOwJEL2Y6kD5+eprokziUV74ppmUa6nJwc2yvdGmtYTh9SWB/NeK/PX20pWHdEh
 3aayI20XnpPo8Dkkz8agTX4esNKO5a3UWQQmyhSX1fbOJNj/QbCRCst3c2bDTiV9LrGIIkcgJXC
 9vxm2zNn8sgralXRyBQ5Zq//UBo2ukWlQ9BSaDeoUKrvVY81/vTW4ZaMWOtg8krgQ8Sx6iApY0t
 JtI0E82SJo6B96Zq4VWRAiYrxspYYvNZ92bPNxx3ha9XuepH6x3J1t8wmDnhO33fU5ATVOUASTl
 GpEmbk/vyK/XWtcTEDEwvTdhu15X9TpqQrxjt8h4zWE+qeZ/h9QTgRQthn
X-Google-Smtp-Source: AGHT+IHd+M3wC8jnXENDUXXpCRDWpMoZb04a/7gWKHciwnTQnt4hAJPVElqvipnvULisPXebKAT0EQ==
X-Received: by 2002:a05:6830:2b07:b0:7c7:5d72:567b with SMTP id
 46e09a7af769-7cc66a19be4mr15511692a34.23.1766966762545; 
 Sun, 28 Dec 2025 16:06:02 -0800 (PST)
Received: from [127.0.1.1] (172-2-191-226.lightspeed.clmboh.sbcglobal.net.
 [172.2.191.226]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9468sm19397294a34.28.2025.12.28.16.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 16:06:02 -0800 (PST)
From: Aaron Griffith <aargri@gmail.com>
Date: Sun, 28 Dec 2025 19:05:26 -0500
Subject: [PATCH 4/5] rockchip: sdram: refactor bi_dram logic into separate
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-rockchip-tpl-use-atags-v1-4-8ac5140c3763@gmail.com>
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

This part of rockchip_dram_init_banksize decides what to do with the
memory information it reads out of ATAGS. Right now, this is used to
add holes for reserved memory from mem_map and for BL31.

This change factors it out into a separate function. This function is
marked weak, so that a board or SoC can implement its own logic for
reserved memory. For example, the RK3506 has no BL31, and should not
reserve memory for it.

This new function body is a copy of the existing code with only two
small changes:

 * Replace index j with *next_bank in function body.

 * Increment *next_bank at the end of the function, rather than in the
   for-loop that calls this function. This makes the meaning of the
   *next_bank argument more consistent: it is always incremented when
   a bank is added.

Signed-off-by: Aaron Griffith <aargri@gmail.com>
---
 arch/arm/mach-rockchip/sdram.c | 234 ++++++++++++++++++++++-------------------
 1 file changed, 127 insertions(+), 107 deletions(-)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 98c02570dc4e4a8315c25a5caad5d568db10c5d8..287073c0e50839cc9366baacbc47512dbe2b4476 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -105,6 +105,129 @@ static u32 js_hash(const void *buf, u32 len)
 	return hash;
 }
 
+/*
+ * Populate gd->bd->bi_dram[*next_bank] (and possibly banks after) with
+ * the memory region received from the TPL starting at start_addr with
+ * given size.
+ *
+ * Increment *next_bank by the number of used banks.
+ */
+__weak int rockchip_dram_init_banksize_add_bank(u8 *next_bank, phys_addr_t start_addr,
+						phys_size_t size)
+{
+	struct mm_region *tmp_mem_map = mem_map;
+	phys_addr_t end_addr;
+
+	/*
+	 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
+	 * have it, so force this space as reserved.
+	 */
+	if (start_addr < CFG_SYS_SDRAM_BASE + SZ_2M) {
+		size -= CFG_SYS_SDRAM_BASE + SZ_2M - start_addr;
+		start_addr = CFG_SYS_SDRAM_BASE + SZ_2M;
+	}
+
+	/*
+	 * Put holes for reserved memory areas from mem_map.
+	 *
+	 * Only check for at most one overlap with one reserved memory
+	 * area.
+	 */
+	while (tmp_mem_map->size) {
+		const phys_addr_t rsrv_start = tmp_mem_map->phys;
+		const phys_size_t rsrv_size = tmp_mem_map->size;
+		const phys_addr_t rsrv_end = rsrv_start + rsrv_size;
+
+		/*
+		 * DRAM memories are expected by Arm to be marked as
+		 * Normal Write-back cacheable, Inner shareable[1], so
+		 * let's filter on that to put holes in non-DRAM areas.
+		 *
+		 * [1] https://developer.arm.com/documentation/102376/0200/Cacheability-and-shareability-attributes
+		 */
+		const u64 dram_attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			PTE_BLOCK_INNER_SHARE;
+		/*
+		 * (AttrIndx | SH) in Lower Attributes of Block
+		 * Descriptor[2].
+		 * [2] https://developer.arm.com/documentation/102376/0200/Describing-memory-in-AArch64
+		 */
+		const u64 attrs_mask = PMD_ATTRINDX_MASK | GENMASK(9, 8);
+
+		if ((tmp_mem_map->attrs & attrs_mask) == dram_attrs) {
+			tmp_mem_map++;
+			continue;
+		}
+
+		/*
+		 * If the start of the DDR_MEM tag is in a reserved
+		 * memory area, move start address and resize.
+		 */
+		if (start_addr >= rsrv_start && start_addr < rsrv_end) {
+			if (rsrv_end - start_addr > size) {
+				debug("Would be negative memory size\n");
+				return -EINVAL;
+			}
+
+			size -= rsrv_end - (start_addr - CFG_SYS_SDRAM_BASE);
+			start_addr = rsrv_end;
+			break;
+		}
+
+		if (start_addr < rsrv_start) {
+			end_addr = start_addr + size;
+
+			if (end_addr <= rsrv_start) {
+				tmp_mem_map++;
+				continue;
+			}
+
+			/*
+			 * If the memory area overlaps a reserved memory
+			 * area with start address outside of reserved
+			 * memory area and...
+			 *
+			 * ... ends in the middle of reserved memory
+			 * area, resize.
+			 */
+			if (end_addr <= rsrv_end) {
+				size = rsrv_start - start_addr;
+				break;
+			}
+
+			/*
+			 * ... ends after the reserved memory area,
+			 * split the region in two, one for before the
+			 * reserved memory area and one for after.
+			 */
+			gd->bd->bi_dram[*next_bank].start = start_addr;
+			gd->bd->bi_dram[*next_bank].size = rsrv_start - start_addr;
+
+			*next_bank += 1;
+
+			size = end_addr - rsrv_end;
+			start_addr = rsrv_end;
+
+			break;
+		}
+
+		tmp_mem_map++;
+	}
+
+	if (*next_bank > CONFIG_NR_DRAM_BANKS) {
+		debug("Too many banks, max allowed (%d)\n",
+		      CONFIG_NR_DRAM_BANKS);
+		return -ENOMEM;
+	}
+
+	gd->bd->bi_dram[*next_bank].start = start_addr;
+	gd->bd->bi_dram[*next_bank].size = size;
+
+	*next_bank += 1;
+
+	return 0;
+}
+
 static int rockchip_dram_init_banksize(void)
 {
 	const struct tag_header *tag_h = NULL;
@@ -168,116 +291,13 @@ static int rockchip_dram_init_banksize(void)
 	 * Rockchip guaranteed DDR_MEM is ordered so no need to worry about
 	 * bi_dram order.
 	 */
-	for (i = 0, j = 0; i < ddr_info->count; i++, j++) {
+	for (i = 0, j = 0; i < ddr_info->count; i++) {
 		phys_size_t size = ddr_info->bank[(i + ddr_info->count)];
 		phys_addr_t start_addr = ddr_info->bank[i];
-		struct mm_region *tmp_mem_map = mem_map;
-		phys_addr_t end_addr;
-
-		/*
-		 * BL31 (TF-A) reserves the first 2MB but DDR_MEM tag may not
-		 * have it, so force this space as reserved.
-		 */
-		if (start_addr < CFG_SYS_SDRAM_BASE + SZ_2M) {
-			size -= CFG_SYS_SDRAM_BASE + SZ_2M - start_addr;
-			start_addr = CFG_SYS_SDRAM_BASE + SZ_2M;
-		}
-
-		/*
-		 * Put holes for reserved memory areas from mem_map.
-		 *
-		 * Only check for at most one overlap with one reserved memory
-		 * area.
-		 */
-		while (tmp_mem_map->size) {
-			const phys_addr_t rsrv_start = tmp_mem_map->phys;
-			const phys_size_t rsrv_size = tmp_mem_map->size;
-			const phys_addr_t rsrv_end = rsrv_start + rsrv_size;
-
-			/*
-			 * DRAM memories are expected by Arm to be marked as
-			 * Normal Write-back cacheable, Inner shareable[1], so
-			 * let's filter on that to put holes in non-DRAM areas.
-			 *
-			 * [1] https://developer.arm.com/documentation/102376/0200/Cacheability-and-shareability-attributes
-			 */
-			const u64 dram_attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-				PTE_BLOCK_INNER_SHARE;
-			/*
-			 * (AttrIndx | SH) in Lower Attributes of Block
-			 * Descriptor[2].
-			 * [2] https://developer.arm.com/documentation/102376/0200/Describing-memory-in-AArch64
-			 */
-			const u64 attrs_mask = PMD_ATTRINDX_MASK | GENMASK(9, 8);
-
-			if ((tmp_mem_map->attrs & attrs_mask) == dram_attrs) {
-				tmp_mem_map++;
-				continue;
-			}
-
-			/*
-			 * If the start of the DDR_MEM tag is in a reserved
-			 * memory area, move start address and resize.
-			 */
-			if (start_addr >= rsrv_start && start_addr < rsrv_end) {
-				if (rsrv_end - start_addr > size) {
-					debug("Would be negative memory size\n");
-					return -EINVAL;
-				}
-
-				size -= rsrv_end - (start_addr - CFG_SYS_SDRAM_BASE);
-				start_addr = rsrv_end;
-				break;
-			}
-
-			if (start_addr < rsrv_start) {
-				end_addr = start_addr + size;
-
-				if (end_addr <= rsrv_start) {
-					tmp_mem_map++;
-					continue;
-				}
-
-				/*
-				 * If the memory area overlaps a reserved memory
-				 * area with start address outside of reserved
-				 * memory area and...
-				 *
-				 * ... ends in the middle of reserved memory
-				 * area, resize.
-				 */
-				if (end_addr <= rsrv_end) {
-					size = rsrv_start - start_addr;
-					break;
-				}
-
-				/*
-				 * ... ends after the reserved memory area,
-				 * split the region in two, one for before the
-				 * reserved memory area and one for after.
-				 */
-				gd->bd->bi_dram[j].start = start_addr;
-				gd->bd->bi_dram[j].size = rsrv_start - start_addr;
-
-				j++;
-
-				size = end_addr - rsrv_end;
-				start_addr = rsrv_end;
-
-				break;
-			}
-
-			tmp_mem_map++;
-		}
-
-		if (j > CONFIG_NR_DRAM_BANKS) {
-			debug("Too many banks, max allowed (%d)\n",
-			      CONFIG_NR_DRAM_BANKS);
-			return -ENOMEM;
-		}
+		int ret = rockchip_dram_init_banksize_add_bank(&j, start_addr, size);
 
-		gd->bd->bi_dram[j].start = start_addr;
-		gd->bd->bi_dram[j].size = size;
+		if (ret)
+			return ret;
 	}
 
 	return 0;

-- 
2.47.3

