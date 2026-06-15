Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B1BCD98CF
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 19:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB9B48493F;
	Mon, 15 Jun 2026 21:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="pU/5j7dh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC28E848A2; Mon, 15 Jun 2026 21:24:41 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EAFC8484C
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 21:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-441b5b4af7aso1882457fac.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781551478; x=1782156278; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gAgrngpoJgbTNZS/TLtfGY5YBTQ2vq5V2GrHORa8VvI=;
 b=pU/5j7dhLP6T2O0Mtk0+OWzNWq78fUKcMDR/7xTtm3ROyKZmZtrAqkOiV7Evvg/myt
 SoFbvXJvckTAMQMYRFSRPIuLrCIo6gj9WSpeLMWME2gvGQIMqpOZLixiGMUZWBwVBWIs
 UjPX7dr948MNy98d0h9quyp9PvjLndQF9iVP9uxxR/xFUa4UQ/6KH7oRuTSA18qHbINu
 QBgpVxiNjq9HELW+rNGeqMrX30ljsRmuq2unODVg0zvb93y8O7Ka/ZaS9W3KPVEpA1B9
 6WWQrgOJ/qzzsGcQdYnYh/pauBDuMTmSeRnvg1btMFiul7fvzphRo2kjEv6NCT9ygt7g
 6A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781551478; x=1782156278;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gAgrngpoJgbTNZS/TLtfGY5YBTQ2vq5V2GrHORa8VvI=;
 b=dHWkr2NdNlFy1fehgJ0yrTiJ207qtArLmWrAY3wRQk3rH958xbJkV88aiGDZMjsNMG
 tof9m4C5v+btkMNDdB2KYlSAHKbVL4QHztPj2uNGRg1VCuYPlm36exmI8Fbvj9/7HpDn
 Zep5H8zs8EJ4XvRhn4Biwtedf7tebeN2qhwzSzWOSNlIRXF8ZlphpQksZXzD6kTWZAc7
 o9aKFIxEq3et9B/N3oKwXhjVmmW9bfRBFexaJR4zv2fDwGFQVa6/hhTFc3LlTlxwHMWE
 5myz2MLXdxcEj6gVf5vWpWM44j6JtS0Bl8ybvn9WvDy3tbcazZT/T1oDQM8B0hYD2P5U
 2g8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+ID0tvlKpachiX6YIHy8UR4i49nfEZPmvJDR0YnccTddWkRRORN1v9+vlfDc4G8aYy2mS+GI=@lists.denx.de
X-Gm-Message-State: AOJu0YzjyC49QeZt6bSEmds8+uUikLPLvlCwxE8Oxcj0LU7LnH63XiL+
 x8TZ9xSDJprMx8vKYHES4FWnlweiklowBne7m1HvYE2arMrOkd7TLPTNkwHvlE0Zlv4=
X-Gm-Gg: Acq92OEnyD+v87Y9nA9l3kCPvrBoG/HJjfOzuGRrWZ7OoMG8aXBIJbeEk1KPKrwLSYV
 twfuthyz68AWIK6BE2fD433Xt5UkGgXRcCyG1wSbR6PlPEjdmWMjeKLjLoRXU+CLhl3Myy0pnuV
 C57BaNH97NQJhD2zU/2fGAJiKlX3dXwqDSNlIiSihz2lGiipL3kZYxdtG7EXZYfzybXIrofpv5C
 iK1MUwtgQ3QTvYRjQ2gMuwyQi9xdshfZjEBHKN//Y0AG7r76GhOXeowQS9aTYi8ltRQJVM9izo7
 pFZpaaCtHEpABvRWew5+elwg/caq/LsCh8unt3GuMT2+DQ2/ji6NVKZcYdz8eT1FbdAiVSWV/zU
 177ChWjGxd2Pu+4so5klUQ/0u6tjxCC5VTxFG6pWfxcRchJrKJbdS+yNLsh1tZGqGEKcrWSb/xG
 iolmfMblMJXJkX07DyYaSsLQVlzqvT
X-Received: by 2002:a05:6870:658e:b0:42c:25e7:bfcf with SMTP id
 586e51a60fabf-4426df7e4c4mr8675357fac.19.1781551478134; 
 Mon, 15 Jun 2026 12:24:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430866fa15sm573450fac.0.2026.06.15.12.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:24:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 15 Jun 2026 14:23:37 -0500
Subject: [PATCH v2 7/8] arm: mediatek: mt8195: fix gd->bd->bi_dram[0].size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-mtk-fix-ram-size-v2-7-f72cfc52ce58@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=1jYQfWm7RJMNvYS++KPQMzmyDPWi5jngdb+/YG0XkM0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqMFFjncqO9/Ilig2n1n5IDepW23FRyMvo4/idx
 bwzpe3kfFeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajBRYxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALmQH/3ggZZxR5Rt1AZfL6mNv9p2kmkqyRMTjQ22F34V
 8E497jkVj1TXr1krD8kVBYNWRVNJOT9X6OgTRea1mlPBMJxpfgN46F2I05JOJTwQg5yP/pMyLVS
 HlKWFbNoESJUuD/xuDd+f1uCXUV94C00lkas0OT41RqmJW1vhQq83Pg3NA2aae29kf0rgB5S0I/
 JW3Kuws6B5+0EY+PKQLSxXlxIpoSXutz8G4esjKkzFd3PCZbah1BhvTMUGIuAzVuW5Tg2eQOaCY
 ttadhwi39dokp0yobhnMExPMMabS+qEsqvnVMJVQgO0E6nvpnl563nayqMzAKAShkBObkKdHoj6
 +++s=
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

Prior to commit d83bd9729d75 ("arm: mediatek: mt8195:
drop dram_init_banksize()"), gd->bd->bi_dram[0].size was overridden in
a board-specific dram_init_banksize() implementation. When that was
removed get_effective_memsize() set gd->bd->bi_dram[0].size to the wrong
value because of get_effective_memsize() being overridden in commit
af4cba9a05aa ("arm: mediatek: mt8195: fix gd->ram_top limit")

We can just use board_get_usable_ram_top() now to set gd->ram_top to the
correct value instead. This is possible now, thanks to
LMB_LIMIT_DMA_BELOW_RAM_TOP being set by default for 64-bit Mediatek
ARM SoCs.

Fixes: d83bd9729d75 ("arm: mediatek: mt8195: drop dram_init_banksize()")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8195/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8195/init.c b/arch/arm/mach-mediatek/mt8195/init.c
index e31d4eec0fb..83cac9d01d6 100644
--- a/arch/arm/mach-mediatek/mt8195/init.c
+++ b/arch/arm/mach-mediatek/mt8195/init.c
@@ -20,13 +20,13 @@ int dram_init(void)
 	return fdtdec_setup_mem_size_base();
 }
 
-phys_size_t get_effective_memsize(void)
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
 	/*
 	 * Limit gd->ram_top not exceeding SZ_4G. Because some peripherals like
 	 * MMC requires DMA buffer allocated below SZ_4G.
 	 */
-	return min(SZ_4G - gd->ram_base, gd->ram_size);
+	return min(gd->ram_top, SZ_4G);
 }
 
 int mtk_soc_early_init(void)

-- 
2.43.0

