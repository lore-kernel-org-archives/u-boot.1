Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CBACD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 20:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A75A8489D;
	Thu, 11 Jun 2026 22:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="UNYt92vN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32DBC8486B; Thu, 11 Jun 2026 22:32:08 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 143DD803F0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 22:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4866834f8deso146877b6e.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781209925; x=1781814725; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uOaIWfLAVQrsOxehjd+W1CKjgO25ldy9mG2aEZ4Dug8=;
 b=UNYt92vN9b/J3b8lNbwsfB2NFscrm57hbIpylA6UHRLg5lccUKRtB03Zd64H86NpS5
 lTLNs0vJqtlSsI1WOJPjOh//WxPf4HBRqWebnFFlcEmqRLC++OkaSzr1LWey0+cxIaFi
 8t6958XvYb9B4Umzu+m3hmixq5guKev3P26BFPiqMRaHkKBVA6yZR4G8TC9rznstlvBJ
 XBUcyZeI1hVeM4Rt02G/PkYaYqhK3Jg/2ZrmszBi+mXbaO3Hfok8Stm2HGylpTbrspKO
 QbXrCa6sTUN0Bdwr9aSwg4vW32GkkDso8G8EroOK8+9KKPu5bc6p3pHoe5M0m7NOx/ng
 cneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781209925; x=1781814725;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uOaIWfLAVQrsOxehjd+W1CKjgO25ldy9mG2aEZ4Dug8=;
 b=WboV1xSDhYouG5sbx0KH51fJuRQDpXfcIcxgggf3kX2hwitRhjuCFwEPT11A+dgg04
 9FMJGpILCQ/unCnuU33hzlepAx/9wriAnE3AOLrE932Mw49/HfqdaRJk+6yslk9vtk7i
 DRLZ5XVW5BZaVGBNPPaM35GatItqoHCkYJagZ72BHSpj7+hY3lI5LOQ0lslAFqjNlZcF
 RRu1XJyag4dJ3n3OfmIXkNvS8F6hdVFkH+oDXdE6sxxaDaAnMtcyXGA/GRb5chlEmMeS
 QfV+uMqUdZvBhfND+uy1ppJ2I/pa9U32UWtcv22Adg8PJTy1KP3tOJP8u162IFcfB/Gl
 JMgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+opkUViFaseHss1ILJ96brwu6VJM4fWUFWmjgCU+VQYwVUVXhqsinH4cDA3ZbiJCd3eq6mTQM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzz3ebRSWwESN1euiMMONx1crBe/l/PWhkP5L/0ZwRaj60MIvNW
 CsGNtE0TJHV3TO65EeClTa0WEuVnDlPc7mTjvzEQIbnfOY2kd19MIeuzP3PY7NBeecY=
X-Gm-Gg: Acq92OHRHSkNLnUMkhGhWZBE8f8DgK5JjZnRZTaOZRAnus/+qNc2t9jojjfyOajSlSm
 rss7VGHb6fmQvshKiaSmJoSaGNozQIqLjtLSC+yRf031w9Npm65qoXCslEhFtCESssXDXX//Stx
 Xw7VsoN7h0+s+fz74K3yFSpH3q9+vYwHHLTMC5+bY1p6U58u9jjTVew87hlkoF8TAX689Y1lf5s
 K6RiPAX9OVIBbVmAktSKGoo6wLDPc5wGOyDLnaHwItcNLEAPWyUI37HHWEfz3Fq3dYdEtQXh8FV
 Hqntx655/9BfuZe4mL+KCdd3mY1245BIDfJmrn+gxXrOr+MJk1DEksUi9VCglIUikSNDdYgdnq5
 mwk6Txw9GenN/SMnF0JbgDWOPgKQHTpqfvl9s66wbZMdFid/mfGdj/ChC6BKHpYMD3NBeHWQZyB
 bmJowYSdJ820hy3LivMhDXqs1Cp90=
X-Received: by 2002:a05:6808:3a15:b0:485:d6e7:9dbf with SMTP id
 5614622812f47-4872f11d549mr26001b6e.0.1781209924810; 
 Thu, 11 Jun 2026 13:32:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b32f372sm21081573b6e.0.2026.06.11.13.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 13:32:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 15:31:03 -0500
Subject: [PATCH 4/7] arm: mediatek: mt8188: fix gd->bd->bi_dram[0].size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-mtk-fix-ram-size-v1-4-42ed330660ca@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3SEPqW6Z0Cpv9L7GacgWwIRHkbnOWpPJ6SF6jYUl5AA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKxshmpCSmR1jh7CvwDakqplTDah4MhvvcQc/O
 peoQA33TYqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaisbIRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AAlgH/iI1OQsbKFHGsocYK5A2mJIvDOJ2fvJFZL1qsT7
 ZnOCf09BfP+4NmQUddrZaXezXhVT5dzlgB0W2u9DwnqnaDf56FfqzgMKvvRjbsqyLcshKORaxA0
 vRoNMWRhQeoXk1xH2A8z4e2N6rY7Kn11wMdYfuNJ+k62iAeXglHCWsaexWxFmvuozMoOu9F8bJ6
 hXK7hMRYhcv33FSR4xQNbhSyVP1PbJtiRAzlNcx3oODxEZFNRsprE+hsc4+3ohhGRxj+3bdJuJd
 WCTJvuKIhVf+jqxMGtQj9leaMqtnEk0OkYA+KPBZLNoea2RPHtqTnxt9saofPg7gEveQp/cmwFG
 M/jM=
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

