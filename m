Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FD3CD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 19:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD36384932;
	Mon, 15 Jun 2026 21:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="KJlTCqnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BAE5848F0; Mon, 15 Jun 2026 21:24:41 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D25848A2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 21:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-69e402b625fso2678628eaf.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781551477; x=1782156277; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IL1QYcdTSwVqJjIRb/mwo0lMg/QZVF+8uz5wGO9I/js=;
 b=KJlTCqnJTCs28lou2mRTgVxlStu6bv5CUD/zuqXZs4vWhC70PMOWzfnJORWwaJa3xg
 E3z/04x1UexzUz5p5eXwx36T3t2jOin4WiVT4uY0DszXR9ZoAkCcSyxWn1WGHwV5DY08
 tisnyxgPWF9Ck7U5kwkqYL+jaUL40AtxTCCmtychkb8tSzT+uQZIm8c3LnEmU2wMaqLM
 aP3TW52RImQba1Mw7GiJj2UghHbN9U8dlI1HfH09rreCgka0ndLut55PQbc+/ai6cxOA
 twIGe4q3wHmlBucWZMTU63ZlmhzQKL4h1ZSGYl7UlEtBXLJ9YoO8ibP21g2xVRK6dGLb
 y4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781551477; x=1782156277;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IL1QYcdTSwVqJjIRb/mwo0lMg/QZVF+8uz5wGO9I/js=;
 b=pRNVDs9zrrGxWLmen5OVZetWrgUVq8uwW7vzaxvN+B5e0SLmln7QzJ11YwA6p1IZzK
 vvGDBjt8opVmPElDi3zWoqYaes33+ErNgdLmItQGWnLiKEMKPB9aIneGmcSVw7z2VBZX
 tjSvKDe8RFpiabuh7CMySW9/WBTKebGG4ZlUlU/eOm+l6ATTSCVVEdKd99TH7BX4K5DH
 RF/HaznqDXdj7i6OXqNdNKp/rOfzMn9aeUOrEDkWexZCjrMKVJGgR8FEmIaIrZaY0SXw
 D0erY16XZY1NeHCIXGexNp1myvfo580tbcw4pqgNY3zjnhrjNfrh80KmOG/2v3u0q9EW
 Mrfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qQ4zby7CLgeVBnTWknEsLIqxxGVgHrTBFh8JQEtHOaJGazezTUxFe+v517R7GpUnSnx5Q3ro=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6I4LZwMLh5X4dFW+QCCq2BC7ErkEwFwJhssUGjzQ5apgQ4+ql
 0xqrLwnxZ88v1EJMxco+MtoiQ7QQ0D0Kfg4U869ni3CYAYn5+UFePF8Wau99CLn/XcI=
X-Gm-Gg: Acq92OEMurUL0aSGTPlJJvdmO8n3JT+phxCzOEQLv9rHyZUGX2CiXeGj4sw6T3Qm3oj
 GkQNMp+7kgV048nd+AdwACHOSYFJvDbJLQRWoSThhZewCFKVM6UCRHHWymUijYEe34aQBm5SeY7
 NiH0pslpvV7frHmDdJhqQKznlNvmg9COseElLsMUJXYz0qfJdh2Y2kZ7d7m/ZB66LM/g19cllX/
 uhtsvJ5mhGfervwJG8CH6MwIMDxvhfT3eEIAaw3VDa06PV2NFT1SDLO0S/mF6b4apPiePaUUXtX
 cVRNkQVuMEQ+5C2NO2MpJajwPTjPjqxORWXZYaHbpDz0zyD5ioTzLPO5qHRQXzoTlrVEsnajS5H
 hAUw5yUzyHOGHLrecihUaDF9oPnJffQSZcIAz/PYpAlUEckhp1dVyjZ/IgJNDKk2+8Y/ySL4VaZ
 y9ecJsVuINHNpRv5lqX++RB6wUl/GS
X-Received: by 2002:a05:6820:211:b0:69e:4a3c:e00b with SMTP id
 006d021491bc7-6a0a4400129mr397014eaf.43.1781551477384; 
 Mon, 15 Jun 2026 12:24:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430866fa15sm573450fac.0.2026.06.15.12.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:24:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 15 Jun 2026 14:23:36 -0500
Subject: [PATCH v2 6/8] arm: mediatek: mt8189: fix gd->bd->bi_dram[0].size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-mtk-fix-ram-size-v2-6-f72cfc52ce58@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BHwbnopm1A1aal5QphbuwSBtYm5beARL1xpXNH1zPVg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqMFFcOkV4KX1S/vUCmYoMMDQwIVVTSm0FbdRJs
 OJPTEEMHSqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajBRXBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AgysIAJXL/9n+IU6I9thycS0gBqVcw7poJ+9C65xARRa
 0KNEwfBOPPa+UZMqLba9F90xNmzwj4dePXx5ynMKQDxrB8pW4FFkYVUouEwjRlsT0c8FNmIptkT
 elR/TDiLsnH+dUQsXMBZxCCaw3UkKEQ+1KoT1ypJmy+h2nPjIJjp6fTWTPLvgs1fSS1cnWP6RgE
 pyQwmgcXFf17STJ9Z3DK9OET0UCD8+dC4TZzWLUYSQm1MIACCx6whR8YQdBhi1L8BBoyOLw4Lnj
 uxf/zuKhoVWwR+K6VOKQUguS99gPYmA7iHFuGIc6k46fkQLbltfF0ZhZM8C3ltPytg4GRiK7Rv0
 a6f8=
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

