Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F9BCD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 20:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158F08489E;
	Thu, 11 Jun 2026 22:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="kq1X34J4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4994484894; Thu, 11 Jun 2026 22:32:10 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A64784704
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 22:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-48633190849so163905b6e.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781209927; x=1781814727; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gAgrngpoJgbTNZS/TLtfGY5YBTQ2vq5V2GrHORa8VvI=;
 b=kq1X34J4KZ4CwRMTZbajNkih0yvcYWqwa1NW8+y3E8dlD5Xh3V6KKNX4plrmRWVz+S
 Tv0mdsxKBEDSAhDcbgdY7QvNAWNiRT97p4P7/6IRtqQB+6RjjRsstGmN+g7N1r4H2gYW
 b75+qpVITj/YZO8EMnGuoIZpX7yOHQnD/kXnEb8WNkLAZJlG6LP2EL42YXfmWGOMK4/g
 7PWlMlrjVbryaMkrvppEuDqA3URNq85iC3bTVbIsmvEriscJcQhwM5RuMTB1S2Q6IdPe
 kcG68UzzSeJ2nFb5lNpXr15aGEszDfCZxTkysSaIzvUeaX+oWb7UHa9rtOPKXR8jSsdU
 VkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781209927; x=1781814727;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gAgrngpoJgbTNZS/TLtfGY5YBTQ2vq5V2GrHORa8VvI=;
 b=cOxhyR91dMVnZlYTF5rQ3RnGmzaKw7TJj6dJ3pKX2c1Xx2FxzqAxXR14zZI5cegPNj
 Yyzrq4Pwf5nT0i29t1bYXLKNYUn9vQ3tnuU7IM7RIPNL0W5Ur/XVaXoTBYqZFP4v83Zo
 DvRHrgp6l040m0uVnms8VZstwvgQ1SfTt1JajGVH3hEfcX+ConUWz/uqQfmJtS+e6RLc
 tYS3vcedxcV7lzufMxSwBW3cyBeykofmWK+cvMYAtmkttZDzmu/hVTfV4RIrfbxhGwg7
 KRLl/Uq+Jzdl2oVaaDs9c0gXNMi8A7vEhUsxuGO/sTdKWlVueTXlCB+qA1H1/WlX+byg
 tU9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DDgrojcv1xisSezYWOthFI/ZmXEVB/VaBmPP+nVNnKGBpSzehzFBj1KQLtLVNof36nhp4hGE=@lists.denx.de
X-Gm-Message-State: AOJu0YxW1rdjiXNHpTGzJ0LJ83vSP+bZtMMm/pT4wroQXgsgvTzMcGFp
 JgtF5Qnb8inWLel/TRO4njLPAjcjbBG9uq4Tzd4xhafOc055lBaTJc9S8Uqa6MEjVDw=
X-Gm-Gg: Acq92OHgmG6Oesi3p9zccDBXXCtGHfBhA0IDkDuDt7QVhrCwwo54lpNMK2Jwuph8x7V
 pfzQI6uo5lE38XI6GZDyhcZYn8BSB6500XT6BKj0lYJ/7sdGkIAi9QAwARy1uGYVxJ/1Iesi8Xu
 pVYP2oZW1bddXp8rYR7HUVwTxvCmooUF0HddsdTkJvFkjpvkJFCTXlH9GzSdlG7z8PuzKMstcDC
 w/6SGmT63sQ2Zel/Xg0LWcTrQgnkLHuOcF8UpFHXKMRAqiy2ibxHe5k7vB0aaKtxcamz+5y8t6l
 jc2arHtKbN7IOiX8/RE26eiT+yE0dN0Gt7NWPqX4dtX+W3fE+AlhM9ORx3+qi9RCYsLXxVpCIXS
 8thbcssgjKvreY+6o4HNSuPMw+gWD3BzWWd7AQAcpoXwRrbqkm1U50Y3e4+5xkPtl+NhrjQZG34
 kth36OW6TPgnfvXEnghWDuy2RlxBg=
X-Received: by 2002:a05:6808:c2d6:b0:450:839a:557 with SMTP id
 5614622812f47-4872f314bb1mr6639b6e.9.1781209926921; 
 Thu, 11 Jun 2026 13:32:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b32f372sm21081573b6e.0.2026.06.11.13.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:32:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 15:31:05 -0500
Subject: [PATCH 6/7] arm: mediatek: mt8195: fix gd->bd->bi_dram[0].size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-mtk-fix-ram-size-v1-6-42ed330660ca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=1jYQfWm7RJMNvYS++KPQMzmyDPWi5jngdb+/YG0XkM0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKxswDilexdVk8LBkvePab+qJqUhhokyKwzzNG
 VxVHA3OhPyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaisbMBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1lYH/i/uZ5DXZnHoTmLpQVleyIzLizeCxKUTz/9vXFF
 RhLh49GGFRRRJKQt3HYwETlBtBwtxoNJN8vJFQuv2LK1X7JHMqgHB66CtWxq3YhfR4lD8ygzCXq
 YKFTGqWkNAzFSupXTn/Rek9OFZfy0CaXU1eMRTqAq8LNIY+pvNnA0Om0lwlhDvBSRURkciZJmqi
 MXjetUgiND2lOFpeYS8q9M8Zk8rzXw/pGd6z3HzVgc+fIpTothT0Sc5d7IlXYVOHavkDC+LrFRn
 YiLbGNvrmQ4S+jgA7+miqZHs2I3UyUyJ7rB9NIDVYjLpftARRvmyanlwe1iVt5I2V0wOTNbCYdC
 kqX8=
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

