Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE9ACD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 20:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B9D846D3;
	Thu, 11 Jun 2026 22:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="dpPH6e87";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DCD848A6; Thu, 11 Jun 2026 22:32:11 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A4EC846D3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 22:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-48611ccd5aeso221674b6e.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781209928; x=1781814728; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OwdYbyFr1Fu0I3t3xFAEqzzPX25+RaiVjpuROL+ACvU=;
 b=dpPH6e87X37qQEBWI8Z/yABZdqtQEW+jo0UAwJNvG9gKlUKqI6wslHU/66CsypOk+Y
 8zGTNGpF6WAwZokPGwda7OxfZTzagbbjD/dgMIOlQbhxp83IXSiHGSDj0usnu7Avl+AK
 h4LC+qpW40zcIckAtj1xNluSbwRRRkDGolfnww5dQoYXBBc/UNTKrpVCVNpM8hxH2E0l
 7NhO/UISEVLIXzB7FKlcfj05NdO2vV0sGwLYktVDkPOv3UIcFOBMJjviEIj1TvUysF6+
 YWLC0fZeEndbRMJhE1EfvrRfuVy+bUi1LsFA/wdFcLC7/93ggz55PynHIrePc5rk6nQV
 fW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781209928; x=1781814728;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OwdYbyFr1Fu0I3t3xFAEqzzPX25+RaiVjpuROL+ACvU=;
 b=C1048sZkEAKT57nttx+EZU5SXFmZLw+HzHg1day8//MX5ffQwECh5vVxMBlVTRP1+6
 sG6p9bN2ZbEza27FMUQQX5jnqo00VhHfvWUJCwgaVhGKvjgltnIB+K1nGBJhs7wQBYGZ
 +DO6YeQCBdxboemzRjTed2R9AtdDdG5R9qVrmK+7LnbiddkgIKc/B1Wx3M1TCebL4Fu2
 Pp9m7UnCKWcobgPd3EeYAb4dGnrzGBv1A5idvEp+qaq5cD1uvAI/MbIqkEutQASP8WwS
 9f2PdSvAK56dSe2KZ0Z0GONIOvUdxuHcAwqpeG9RskqWImAaxYO+pAoek21XKmeIzPdQ
 J5sA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YBvIyHnxm3jO1HjU20akV4ctK7EYVcGQSS0ehNvDi7LL8cw0IEJaNafUEjfl3gsjhDpYynZU=@lists.denx.de
X-Gm-Message-State: AOJu0YznGVrJrF9HPXw1ycyzgJP7CnZsin6lLqRlH206JjWjk4LTzxQz
 JZk9qi8+KZqSt9/CakHFG6XzkEn3FA2fvDHcd/hnkW/90AeOX0N3wbdTo8EwkmZ6bgE=
X-Gm-Gg: Acq92OHl0fDkUxaQTzg1lclvyxxSX3ETDWk/R9YhuYWGt5uJiQ6SbGeBS6eKZMiVXOi
 KyMXU4mCQ2elha1vJqUVfawkVsVOjyztzMg5DgT8XSLND+KTFdDTEmK1oRucjkRLrc2LeugR8Uk
 wgs3TrPfqCTpGgRmIkf3HEkANE/Sp+iVwdTN/P2RFEu/ZEw+PYsP5lTKXqJ0eTc3Cx5z8+9NIhp
 1zUH01FJ0lwCOcZan8P9p5H3pNjgxGV0m7Hc+BAoMFtkYxphss3QEZTjWG4qtcnLVNKip1GvaCT
 hP7UbBrzv+AZ6mweEVqIPuSmCFKUQGGB/nZCcuMv/560F+72XxQ9ALP/0cubEMo4d922myxjhTH
 b9H0+WzEtcfZHnYJTxVYSsL+M7+eRB7jSRhJErMg485epOjQC9YnRFCV5Pxm4vBSCySQ3R/hSgu
 ZRg/wCYa3qQ+JZnGCERsPl19T8dCA=
X-Received: by 2002:a05:6808:1920:b0:479:d57b:83b0 with SMTP id
 5614622812f47-4871a12a722mr2932489b6e.22.1781209928033; 
 Thu, 11 Jun 2026 13:32:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b32f372sm21081573b6e.0.2026.06.11.13.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:32:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 15:31:06 -0500
Subject: [PATCH 7/7] arm: mediatek: mt8512: fix gd->bd->bi_dram[0].size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-mtk-fix-ram-size-v1-7-42ed330660ca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=T4vvlBZY6a1vvaC2txujg4LEDXHgDfQ/H5XyExbtgnU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKxs2eJcnoQXSl3UDuk2ArX+dZe4TuFvo8apeU
 5vaVvvcjFmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaisbNhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ANkMH/2fVsq4RnmxAl5y25vbauK8Vfo5PvKEmpMGpcSN
 gn++vwQyvYOW6IYqg2zCn/S1Dckv3n1168vas3GpgJF4VhtIx3i835rK0V4LN+uFwB/Brjh3Uzp
 n2fIuGNCMFo/Fo45DhSlvfOabKxmx+HCxVxJ0Etl6XOM9AAyCSETxrVdU9PdVTm5j6Qar65Tfck
 7evLDdhbRuvxFO0YsTXhlFAZ4Fq0n6Yc6lMnxgWODdohW7JEdw1BsdT/dWYS0rB6D2bnikPnuTL
 eIZdOHOu4d/NBlcQNJxL9TCzhR8EqgcKs5HDa5boXwDmoR8bhAbLVd0UL4u+8Ir7FZuOjjUG6WW
 OZX0=
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
limit gd->ram_top.

Both board_get_usable_ram_top() and get_effective_memsize() are used to
set gd->ram_top in setup_dest_addr(). However, get_effective_memsize()
also sets gd->bd->bi_dram[0].size in dram_init_banksize(), which is
undesirable.

Prior to commit b9e6281632a8 ("arm: mediatek: mt8512:
drop dram_init_banksize()"), gd->bd->bi_dram[0].size was overridden in
a board-specific dram_init_banksize() implementation.

We can just use board_get_usable_ram_top() now to set gd->ram_top to the
correct value instead. Overriding gd->bd->bi_dram[0].size was a bit
confusing since it isn't easily apparent which order the functions that
set it are called.

Fixes: b9e6281632a8 ("arm: mediatek: mt8512: drop dram_init_banksize()")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8512/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8512/init.c b/arch/arm/mach-mediatek/mt8512/init.c
index bc1d515fcca..6a9ae776794 100644
--- a/arch/arm/mach-mediatek/mt8512/init.c
+++ b/arch/arm/mach-mediatek/mt8512/init.c
@@ -29,10 +29,10 @@ int dram_init(void)
 	return fdtdec_setup_mem_size_base();
 }
 
-phys_size_t  get_effective_memsize(void)
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
 	/* limit stack below tee reserve memory */
-	return gd->ram_size - 6 * SZ_1M;
+	return gd->ram_base + gd->ram_size - 6 * SZ_1M;
 }
 
 void reset_cpu(void)

-- 
2.43.0

