Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3DDCD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 20:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEAD884704;
	Thu, 11 Jun 2026 22:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="WJPEz46i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 438D08484A; Thu, 11 Jun 2026 22:32:09 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E048485F
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 22:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-486b93fc7c8so168071b6e.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781209926; x=1781814726; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IL1QYcdTSwVqJjIRb/mwo0lMg/QZVF+8uz5wGO9I/js=;
 b=WJPEz46iWIDbOaIBJfhm8scwsxl6gVbUl0B5+Fb+NnFPBsj8dmvCTXHyh1IEMnTGq+
 iAcP/dzp6X8rxJvj5VXAgqE30+CtGNsb8B9Jker13/2q5S4btm1dqBLCyLoShwxgaMVy
 22/DZ/QOKSG3Vmsoq2+LRQpYLi5dQENkxp/4H/hWmf+ZoBvouO0GBK2Lp4kk4/BfdQdK
 ym/PkGsB5uGpl5E2IWVSbhvWTPmQ9G1KvHwdOBKO2tK3TOv2lWtWe9zBOS0DS+mPOey6
 rhmrfFsCuFmVB2xeHkvpWRLkDY1D0orv3dDZfCVVJqNwlO+5DmuHo94Ug+ERshPPX0XR
 R2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781209926; x=1781814726;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IL1QYcdTSwVqJjIRb/mwo0lMg/QZVF+8uz5wGO9I/js=;
 b=hgIS5xBaVQOKxPKEUoX8gyLIjOmTJBafAGRnE2SjGGtuKO2j/Kd72eGiPh+02l/Qju
 DzoBbCao4bvT01OSvRv4LRgrudKFSjJh/kK+QqaShjpFOsXE3S8VgUDJHw55wdzpVMCn
 6QI8QmCr6utEK44wJDZIGRnMbxupefbzRx0nTtoYIXrzKDqZOkj3xfoxsWyC/kvBfMAD
 OUqCPsOjWEngseLJS44evM1EuUWVHTkOJtLFEBoA9IL3+1WgJ4DTEzpht+5wAH6nTMzt
 fUZ0ZkeEkskt91mE1Cp+mTrJ2FmaGQHxhircJhzVhE0JkFoaVXYYffL/HvkY64rXI9+r
 zZsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ93RBSUpAJpiyNVNuF13i1HveZ3iwXUQggCRo0fFFE4hNF2AnRc1PG1scqGwot+pUmZoWH2Wkk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4M2rGg8HeiagVi3AN4tUIvSLGBbQLwOxe+lsNTw2+3u70HzlZ
 OYedrVRlNIjg26IaT1US1dUMpz6fupqbdolSWxh/6ijYlYocfFYhG1InJjeNr/N6W+8=
X-Gm-Gg: Acq92OGsziseoVzJNp9MIRFUh0AmO2I+flXeNoF/+2IL3mgfVbwg1WLlAU8PBzERAS+
 6Jx0vvAfCToodxpQPrkN8NveMEFxg07Zwwu1NHeCrXzN060teNsWkXQh4sSdMLlYs0czZJ5LbV2
 tEbGS43tiwMj/4B8l+QFfhJJ8+zyCJG9HUI1DfeaKwoxZHzBPomGOE5lHOCvYNWcohxvkr3PyAn
 BDTTO7sF6cZDyhoQXGqvfwdRjFuMMra97LrRuE++u0Cf5b7QLLGY8HMfMLd6Ypdp2I13tF1JhVL
 5Aoc8WAmy2dq3M9VvZxQNZ0ca6bCvusX8avUM0dAk+IoEoph5Mq2uHU0XCawSPr+5y0jcu4ckxZ
 hqDmYQ37BUR4yvZro179e841DHG+bWRbScFKFfPbFTTylpWZe6ps/Xedp6buoh/bYhr0tuVMdII
 MEAXSw/tOsPmLXEFtBWxzH1tKDLuc=
X-Received: by 2002:a05:6808:4f14:b0:485:6129:1112 with SMTP id
 5614622812f47-4871a126823mr3816471b6e.29.1781209925936; 
 Thu, 11 Jun 2026 13:32:05 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b32f372sm21081573b6e.0.2026.06.11.13.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:32:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 15:31:04 -0500
Subject: [PATCH 5/7] arm: mediatek: mt8189: fix gd->bd->bi_dram[0].size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-mtk-fix-ram-size-v1-5-42ed330660ca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BHwbnopm1A1aal5QphbuwSBtYm5beARL1xpXNH1zPVg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKxso9eQ+jZpEmet+rXaBGN8h6nIpC84EL29oT
 WEa7K+OpoSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaisbKBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AnRAH/1HlAWO+/V8i7i5S4KtGyr+EKRlAICr7RL1hK6t
 gzTXaJUrrTsG+N3hOMu8Gwjg9clEReR9V65ny7f+EttRLfGreSELZQNy0SecwSCjc37TOevoCV7
 cRzptmdxOo7xz/qXvJZbq2+Yvv8MkHew1fq8jwpQUzP4S/A5Kz5P5YwzdeqrlT2VA0uLvdSLHbn
 cdVl1BoBqJIjKVfn7q2M2/r7dfcW8i/hOF115jfQJ7xfuZsZSHWIQgIhZDAp7aWJKl6odbgcDNY
 FHXjLinKiIescMNHXzdw3kVrMmxW98HHAvDjP6xStssBhtwCQvYUwV9tMPxot3P83cYIdvU/Bzs
 oOjM=
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

We can just use board_get_usable_ram_top() now to set gd->ram_top to the
correct value instead. This is possible now, thanks to
LMB_LIMIT_DMA_BELOW_RAM_TOP being set by default for 64-bit Mediatek
ARM SoCs.

Fixes: a7c682565b4b ("arm: mediatek: add support of MT8189 SoC family")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8189/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
index ec7587c3586..4435c75a656 100644
--- a/arch/arm/mach-mediatek/mt8189/init.c
+++ b/arch/arm/mach-mediatek/mt8189/init.c
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
 
 void reset_cpu(ulong addr)

-- 
2.43.0

