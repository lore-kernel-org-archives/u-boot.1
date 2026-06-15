Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BD6CD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 19:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA1484908;
	Mon, 15 Jun 2026 21:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="LDyH607I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB41848EB; Mon, 15 Jun 2026 21:24:41 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F0784895
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 21:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-69e2c792289so2813531eaf.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781551476; x=1782156276; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uOaIWfLAVQrsOxehjd+W1CKjgO25ldy9mG2aEZ4Dug8=;
 b=LDyH607If+SXYHTcj0eGEcw3Ysl1DBIF84fF0URCDprMTKSyD2Gh54f3tA3lmYFi98
 g5gyoXR8ja5mpp7YsHRs/f9trGQeK9w1qLjCFb3ojLJZwA++gM7fY5x8Hdac7GeKjB+K
 t4Af2KkTQ3S3CnN5Ck8fdVVKByIOh+nXQUkmnLhETnFHqXH0YFb4oV88K/jNaQtulncU
 e9+EHBmeQOK1AaJ6pWe0qef7XPQzS0qeErw4tMhJ6LoithDQOdPQQQVmVHJlp4meChLw
 msxuz4OHriU6+qEzN8aUv6+ZhXcmX14f0Xb/y3CeIKbwrJ/gDK2oAs3NceP2YJxa8t+1
 /jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781551476; x=1782156276;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uOaIWfLAVQrsOxehjd+W1CKjgO25ldy9mG2aEZ4Dug8=;
 b=ds30YhhQZii+iF/yHAwoF6ZUvqauwf8ZcJGQPUnbqLYhUvihQp3enh9J7qtNyc/Wvi
 MuLxHuOk7dGzOKdW8XdVeujnmBZpqQNLArPyqNMsOyz4Oh0Eqb7nC/UW5F+tBuds4jeT
 Dq/WL3nYko+MzKOvInuZ14QdUHGFz8Sy/FFLYe4IkVR/no/KZcP0WPOvUIuIu/4snUBj
 wmRxM4YEAU9hcBLZXGfzZt0kSdjPj6x1C7vEJp7DW5E+f4MIr00dguF4+jFCeTVc7ZSn
 XPYmtoccAvHjhDuOiXt/5/1rzxLgBexpLWdeJKzxZPVc8DeraF4iCpqU1VRU/OHYTgc+
 UWxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vwbsThbL2SbTTCbwdhyCgpiaRVwxmD/bt0jXwZDWx0SChABfXCCT5YgSoFVqS81/Zz6FpF1Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzBvXD3BiNrivSpvGFBuo83YtT6pxY05xumYTg5VJ3a+NT9zBe5
 UuCyd7FLYNiZYCB3RKAI5LmdZ5Vqf1xx19wFRNjPR/yZf065baa0MvfCh40qwWYAVGc=
X-Gm-Gg: Acq92OEEC0mNNOl1xGbc/mD+Pj4jZ1ddyU+TCo7eW1WSzmQLDrDtwnlBsFsVT3IntAm
 QQ8DWm8DzGLEfWnm0qPM2aAThLuN2pKe4X2ldfRnwQBa2pCS2a2++39WGDwPvIT7xQ7wm15PVcO
 PJrBq868n481LdyYHXlxaeoT3+Km46BkVTcPC7mpf1TkeNeRZge7YWx3RChEFJgpPDmDqOL8COr
 2oeCxa7yXuyiW09S8RZXWh8UkRCN96uoLw9wQL/Qd7FK0Stf7pMziYkQcTq6/XwNI+NSRpvAIFO
 ZgzKAfBEDMrJCEKBdtAJU0WxfLmvBRuD1E1EDGclzR2dORiYQMCWZETqpEmTQKwEuSjYeurg4Rg
 PrC3N+lEFivNLd0ka8Yow7d1jdZQD4BkCja05DopwikrH6fpCRIBKbZOR16UvnB+4n1MkUpB5si
 DufeI28AARky0m6EzPYnlhaLujkZT7
X-Received: by 2002:a05:6820:4dc3:b0:696:2b09:5988 with SMTP id
 006d021491bc7-6a0a4421fddmr380016eaf.40.1781551476633; 
 Mon, 15 Jun 2026 12:24:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430866fa15sm573450fac.0.2026.06.15.12.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:24:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 15 Jun 2026 14:23:35 -0500
Subject: [PATCH v2 5/8] arm: mediatek: mt8188: fix gd->bd->bi_dram[0].size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-mtk-fix-ram-size-v2-5-f72cfc52ce58@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3SEPqW6Z0Cpv9L7GacgWwIRHkbnOWpPJ6SF6jYUl5AA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqMFFVHn0mJfk59FSW4VIDqgRzOISk9NkV95OhR
 e/lqPA1v3SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajBRVRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AzJ8H/1UBq6ZBi7hkg3qOG44K2r3UAG+T1K6qjk0Os56
 7g6e9GaLNY9krz6nMhs5fDDiaSihrs0V2UyoB19tiErkNE/k/niZxN+qFvQXSwfDc/7XHWgSn7j
 VPpDDt3YUce5gvY9khnWQBuvCz9sUG3NWvyYqDZwHxm6jBz3QL+TuvW080Jc/49pZ9Q6rvYoUE+
 dFB+JQBFxjU8SrpYbtiLrcRAdGZVdLsnq+JZm9gpvxDfa6fIIZnSBjH94oJDb4ppfOMGt6BT5lU
 eXZSymbbsLq8MXVpkiOki3oho8w4q8twySWLutwbWAVhBe7ZaCtNBouiidb1o6vkUdrksyJ8gy7
 chew=
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

Prior to commit b3467e51e92b ("arm: mediatek: mt8188:
drop dram_init_banksize()"), gd->bd->bi_dram[0].size was overridden in
a board-specific dram_init_banksize() implementation. When that was
removed get_effective_memsize() set gd->bd->bi_dram[0].size to the wrong
value because of get_effective_memsize() being overridden in commit
7518e10cd235 ("arm: mediatek: mt8188: fix gd->ram_top limit").

We can just use board_get_usable_ram_top() now to set gd->ram_top to the
correct value instead. This is possible now, thanks to
LMB_LIMIT_DMA_BELOW_RAM_TOP being set by default for 64-bit Mediatek
ARM SoCs.

Fixes: b3467e51e92b ("arm: mediatek: mt8188: drop dram_init_banksize()")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8188/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index a48a41f3b97..1108bc19373 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
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
 
 void reset_cpu(void)

-- 
2.43.0

