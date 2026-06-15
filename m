Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0064FCD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 19:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C578494B;
	Mon, 15 Jun 2026 21:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Nh1CLnxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B72398484C; Mon, 15 Jun 2026 21:24:42 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A00846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 21:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-44104dac6f5so3608128fac.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781551479; x=1782156279; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OwdYbyFr1Fu0I3t3xFAEqzzPX25+RaiVjpuROL+ACvU=;
 b=Nh1CLnxzV9Sp9/iXl3DI7jHFuHgdQhnlgXEuYZlLzg27hFjgqVko71/IPzF1OV10X0
 xuFDG5oydrfd4dDkMH2Cd0gjGBDnYhkcu5eD5HEYg6zmrKVgZEWXBaBWe1JWnwlfllDx
 BnYx/tTCnhFht1HhEXoggO0JWWtLFSjVikgm0M2+h0nr2lvA27T5UcYoDMNgcA2JiQkN
 lBU+ETRqsMzvoevUoL/az5s/Gq7t2abnTJmkNFvfmBw2xUd5lXNFtaa26eKfPWLBUFjw
 gWowwMt+iwM8+w+lvUhFIbrn1ZRpA7xitrRDbKanB1XiSvSpU8yWqtVDCnoVqhxUeKif
 eJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781551479; x=1782156279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OwdYbyFr1Fu0I3t3xFAEqzzPX25+RaiVjpuROL+ACvU=;
 b=IPVg9YoWZchomBZMnq2hhFXEn1HpKEVFsmiSBcx51SgIe/andLRVqTv/E8sHvKBUab
 7OONNUCcPYHp3hQ6BsJG76/k8m1O6U0y/9b5pAtDBvw4rZxhu0rWbfiT3JShTtSYpGzN
 CU+j1/BPxWl76/HaWaTrIRpl9gWgpSJRCqYcOfKENDaDcCo+rzXnOBRxkM1/OllkJbFe
 L9B/2xjl3ATM/NLcv53DBFllC6LKGmq7in/X4cGyd9RCrtAbkqgL2f8dGQs+xRgqfv/m
 +HmbjyrT3LEph+U6w4rVnJccz1TE0+N9XsUl61bK4UgwIhhgk7Da93z1IcgKwwL16ye2
 +gSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Xo99CiwN297o8WYw7Zkea+6I183jk/IF+6yidnNreyycLH0ovKcI5HBFvhXW27rSIFaFf0WU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw27BmWPQFWSNXiKBUrGJUheCCI3BZ14xKiZfTv49tuybXsYNM8
 mC+nWi+yO4kKJAt1mP6hV69KWtsJZ4ek6Das2seN2T43Z/2AZMLIVL6jlDkcwZN6c8U=
X-Gm-Gg: Acq92OFNF2NR0ZT/ptPDaIQjK8iyuEv3GZtAGZsLjcgXRczoBRdNMB4HOAIoc4w0ghr
 kk9akHSnFlvwR0FArjSgaxdXkl9+KrHb7tPFEwoIUDJBMS+nM4kkTvfBQxldznFf4RKZB/Bwz7K
 BafXgGmGOrohks64/iWWK8YF6AZQcxz7fva9cPBRwto+ijoSoPdqihb7bXtBnfslCWz6t8YP0oQ
 jQGSyXyulNofKwUyNcTzxz2r1L9BaqkIFNAAYyMvFpCcRkGWHUFEEAyLJBiKIbMeb+jKulAFGCH
 M3YwqxnXrvTuWF4eADyLp4DfHGW6UuAkLcM5Md4yhxHrWvue4QIoGgXaTMMBaTesnZvuGRErRL7
 bn9eSlmHPp+Dbs0JKG6KtcK/WO67Hd0hMmRf7saDNSg+tgliuQqccagLz9VDN2T9DeC7AG86rmB
 7ZDHkohlEqwfmQCbYdxWzbFQNaAOQdKbgiWTmuldA=
X-Received: by 2002:a05:6820:168d:b0:69d:5138:5540 with SMTP id
 006d021491bc7-6a0a3ec4ebemr351430eaf.9.1781551478956; 
 Mon, 15 Jun 2026 12:24:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430866fa15sm573450fac.0.2026.06.15.12.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:24:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 15 Jun 2026 14:23:38 -0500
Subject: [PATCH v2 8/8] arm: mediatek: mt8512: fix gd->bd->bi_dram[0].size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-mtk-fix-ram-size-v2-8-f72cfc52ce58@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=T4vvlBZY6a1vvaC2txujg4LEDXHgDfQ/H5XyExbtgnU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqMFFp4x+ZiJicSPRmyYJtuNnlx+39jBIvZoiz1
 WhzfE0GGimJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajBRaRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AKqsH/imQzL51K7JameTEVCYHo2LBtci8/WErEuYCwmN
 D/ibE9NjPk0FhE//IPqE+yVsMlSWemBZPX67jwrAQmbL7fW7FSR8EC3f0SPNCc8JqWr2trPf75a
 jyzy46pB7FCZbpNXuhuA3Y3i4tS8Xoss1BDRvYpu0WMXJKdRhRb2Crdl7gGUibNMBcY83QDREpx
 QizXhIaXeet09eL+c/BCAdsxkxCddOpq71spVbvfx07vKjnaZVzrQ8+s1m7vzPIQd+O3tunLQSS
 m8Xp/SI3oFg1GGrfamtxADaIo22vc70z/WkOAkpYsNEXakiAED+avTgbDJmF2ZgY4XqNLM6uRyy
 nGF8=
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

