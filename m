Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958ACE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 10:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F23B583D0F;
	Thu, 19 Feb 2026 11:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hn+U46IF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1738C83A47; Thu, 19 Feb 2026 11:03:45 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119F483CD3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 11:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4376c0bffc1so589446f8f.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 02:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771495422; x=1772100222;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MYzn5XI3pSMScNRDuy7ym3ZX+wxaUgxJKIaLBlMXgwQ=;
 b=Hn+U46IFu0GZrhokpeRq9S92yfGAWUvr/gOzUfot4Y7Kt07VxtNP3Q/Hb3cXB7VeRv
 I4qjYh433b7DyyQpKYfiaf47ppxdkoHprDglznbzj/lcZssupOuYzjtT/vk0QIUC0qj5
 hVjCWkzov8nu+7NWsqFj50M9dHAWzojQA/jFDYIh8xsOkBTRhrF/a/ToEjMz8NnksYLN
 6C4umus2/C5lKCkI03vRf58d4bupWYT4r8vgwoQKxt3MX026wvhFxfrsHVrj83xFfSTY
 83C+3g8Nkjdb9sZx/spLQI8R7Nmsnz1KjYCkP4K6+NRvgVCBk8e+VdrdYDwW5hAlpTUp
 P7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771495422; x=1772100222;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MYzn5XI3pSMScNRDuy7ym3ZX+wxaUgxJKIaLBlMXgwQ=;
 b=rCfNZZsP3HUKPpFWsizadECEM+4rp4uh7fAnNXA0e6Ac9sik0DhUl7XZxY8CHLOO1H
 hiJESgCff5yFGyoub0gqgYncBMSzg0skxUvsK0lU+y3S9rcidsaNXIJ0HSmxjXnbon5p
 M23mDCFZbjl13Lu4g9dvfPuFjTpMasaOTmxMQNH4U0bdIGc8t1NtY7h/KsLQBvf1WzUH
 Tj87wShEu8nyQC5adrWs1Fhv/QTCNZBEkenhBXzttetlpTckuu/TQopWixPh16SmcmlA
 3LEGaLFnFoLA+cNOtAPRhGKV8L/VSquCmoVzq1DeOWYkPyAYZ3EMqFx6bSE/ZWKfnuYc
 nBeQ==
X-Gm-Message-State: AOJu0Yx8JeB35X/zkvqjd8eOdYvwTaZ//Mm5TkQ1NVngMlINoTieOGWM
 abFJNxSvgg8nghovY7VJZeCPoGnjCmnRgHlqj4PqX0WcYogwyi2ElRaG2dVD4SXS4YM=
X-Gm-Gg: AZuq6aK64HEZl2GASHzc9Un5BwpoJLVGxCF6066Tjzb24Zokr+/sxaQSkjKiAxMLhZH
 qGMgiGagrpzTr51/LTkaoG7k8LA3OIdcKXNf8QwSxaqzpF39CC0mMpdTXw3UQeQiOKJh+M3iNf2
 +Cc1wIJXbfSZCgGoBAZdnwTMxZQqUz2W5RHucnhpSpqB34KZuFyDKMfkYK0XvIxQVZeE1lSkrY6
 g9PgsyGUx6DFEW2mx5OGiJkRDpEZcYfegIitOOzMfKnkEilP/m1tO0T/T3WyB8sk70QJ3AyWmbz
 Z32gHsIy8989hqQ+oDz0FnkoAXRWcO4mf+65VO5btcdDiBTXEOegC7ttZ+LSSK16B+Fe7xvjKNy
 VjnlO/WrmeZqSjZbbvsqCGW1I9pIuEK0eWgCiCJFqOQ6QOyVj7Q7XE0RuhYGLs+7paTpHQsChVi
 dGtuIfQXDoUMjffmpLwtgW7ulx9E88pki3WWQ9LtDAhpQdU0lFHEjfS1MTiskuJxOkbYrb6da+I
 K/G50zM19grlVqv+H00tkxl8BuZQLH2
X-Received: by 2002:a05:6000:381:b0:437:6625:d0d7 with SMTP id
 ffacd0b85a97d-4395fd5c155mr3734438f8f.42.1771495422380; 
 Thu, 19 Feb 2026 02:03:42 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a74918sm47885240f8f.17.2026.02.19.02.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:03:41 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 19 Feb 2026 11:03:37 +0100
Subject: [PATCH v2 1/2] arm: mediatek: MT8195 fix mem_map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-add-mt8395-evk-v2-1-18b190d91cb6@baylibre.com>
References: <20260219-add-mt8395-evk-v2-0-18b190d91cb6@baylibre.com>
In-Reply-To: <20260219-add-mt8395-evk-v2-0-18b190d91cb6@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Commit 2517e2b524e8 ("arm: mediatek: add support for MediaTek MT8195
SoC") was merged after commit 24ffbb2aa17e ("arm: mediatek: consolidate
ARMv8 memory maps") but was not rebased on top of it, so mem_map is
defined twice. Fix it.

Fixes: 2517e2b524e8 ("arm: mediatek: add support for MediaTek MT8195 SoC")
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig       |  2 +-
 arch/arm/mach-mediatek/mt8195/init.c | 21 ---------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 8da4ba5ceab..671a6cb1cad 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -149,7 +149,7 @@ config MTK_MEM_MAP_DDR_BASE_PHY
 
 config MTK_MEM_MAP_DDR_SIZE
 	hex "DDR .size in mem_map"
-	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8188
+	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8188 || TARGET_MT8195
 	default 0xc0000000 if TARGET_MT8365
 	default 0x80000000 if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT8183
 	default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
diff --git a/arch/arm/mach-mediatek/mt8195/init.c b/arch/arm/mach-mediatek/mt8195/init.c
index c399550b8fc..0f68c589e9a 100644
--- a/arch/arm/mach-mediatek/mt8195/init.c
+++ b/arch/arm/mach-mediatek/mt8195/init.c
@@ -68,24 +68,3 @@ int print_cpuinfo(void)
 	printf("CPU:   MediaTek MT8195\n");
 	return 0;
 }
-
-static struct mm_region mt8195_mem_map[] = {
-	{
-		/* DDR */
-		.virt = 0x40000000UL,
-		.phys = 0x40000000UL,
-		.size = 0x200000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
-	}, {
-		.virt = 0x00000000UL,
-		.phys = 0x00000000UL,
-		.size = 0x20000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		0,
-	}
-};
-
-struct mm_region *mem_map = mt8195_mem_map;

-- 
2.52.0

