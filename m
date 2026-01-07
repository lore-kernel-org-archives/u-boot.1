Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07013CFD658
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C02BB84083;
	Wed,  7 Jan 2026 17:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SZmDcSVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B0A83A47; Wed,  7 Jan 2026 16:51:33 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C2F383AAC
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3ec5df386acso1623972fac.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767801089; x=1768405889;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=81G6IsLWsutFI4wQABascq8HwnVa159ENETd9gL+ezk=;
 b=SZmDcSVmVFcpNRpQJcNInECD2L+acnVA16JN20lI73TjqV1lbmt8TI3klrREsSzBFd
 9riIVr7LSoVJiTHOULnNMkKFnH7GrJL2m0InOVhq/ChZ0fuShVKPrR2858nKfsqrC+PI
 T9KlOTaPM+rqZcSNZOg7HNbjAIyUk3uNEQzjTT/SGiamvfCs2yvmUUbhwg/pc9Z48UJZ
 L1UY74FYZTFU8kVvThJqYV5MYeNXpZupQOBQB7rYQcQbriNQL9fL/Je2YpiMy8z7/lZ8
 pPKvLtaABWv6d6Q6V8WnVvXmvUsu41wGJKSdXxbTFU9BHjK6YXjKciqpbraIAhy77UfF
 zoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767801089; x=1768405889;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=81G6IsLWsutFI4wQABascq8HwnVa159ENETd9gL+ezk=;
 b=NZayum7WWV7H/8Yf38GsBYKDAAlEmwH+AEkMLQOz4/F6o18H9Q5gia5cKOYsXOjc3f
 wGWTI6VY5RJU3W/rOkzLeQrWu8IRLR+IwnGi93/mhFjmrICSL1JgvBlaPLRtatFwx2NY
 coD7F1URkcg7gQfXy6WOdrwX0aaCk49WQmr241No6vvmxq0d/Cjutj1MeIA8aawKpgaC
 cbb7a17Il9//IUfHfk14s3RwXtE4xf07zzDD9j98lwn19xZIQX/dT/BoYZN7PWw7+PD3
 PH6Er8sqkjIqqvvDG9nGTHux99wR/qm4nt2yl5p4IWP6hu4WEufn1RaMLETFYjH4V+EI
 9sQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLSDZnhLG6aDValHn3iRUGo5cdPZEYJFNhwWOnjyZhexRrtQlClpo3dDEN5o6v/EZtbsbhKdg=@lists.denx.de
X-Gm-Message-State: AOJu0YwvILDK80dprDen+eprS/KZIq4j6Ny3LhR4Hy2CRl5+p1dHHaVU
 rUGEVlRsTw1wcrYD/mELI0Ldg7yGWGi1FoPC7u4SzWrdsihvP4cGCyUyFOXhhwT7CneGEDyH710
 zJmog
X-Gm-Gg: AY/fxX6ghxteVPJ6+0eYzN7hRxvfK1nBjwe7AadZjtVW3kcriR/qr9Q6EGGEzzM4dD2
 w5DBjzC5qtPoDL7KhxVPHzcDD5RPZA7KF6T8argq872hUeF2w2UlEfAWEPZIq6T1bGGfiAdDjMU
 6zTBkccDBleVXsqOycKGdyGO8p1l7AfvBn6Lx9oL+bRjgE0zyAoJRR6tMbQspMyFWZf/do3LJMp
 53fYzTgk+sM1QxRN+DdK29Gd3HEhAcCCZIOJgvmBzqxPOqMR8TupwTFMHPbaun4NXLeNsNdfuF5
 q0C3LR8JhuFdHQ61UXfte4gsV50AXsryO7h316/OLHwJXziGXKbJzkFcCoqJWptkYLyxVnL4hWv
 kvd1BzveAKFZd+GGKVU7VDQKLIGw+FYCAJ6vckTZ4zNpUt3+Lnbk8RzcHDSuLsxAR4RLhocKf61
 bBgp0t5GTK9MR7GGE=
X-Google-Smtp-Source: AGHT+IEPKo1kHhDNp9CGzE+UgLGQN8Q5SHsAp3cRILbcfC5ObtvJRu0jTtfaCSXwpXADm+BD3t6UsA==
X-Received: by 2002:a05:6870:2188:b0:3ff:4ae5:1452 with SMTP id
 586e51a60fabf-3ffc0b662d5mr1295873fac.29.1767801089173; 
 Wed, 07 Jan 2026 07:51:29 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507220csm3345317fac.11.2026.01.07.07.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:51:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 Jan 2026 09:50:16 -0600
Subject: [PATCH v2 6/8] clk: mediatek: clarify mapped vs. unmapped ID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-clk-mtk-improvements-v2-6-7d4338e520a1@baylibre.com>
References: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
In-Reply-To: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4102; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=S1/qxTuSkqIVrZMnrhpUZaQU1g2SB7nblzBd962BiG8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpXoDgsBkib4Pq2xnCRkpyeenije7mDsP1TW1qJ
 n/Hr2Y3cQSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV6A4BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Akr4H/jiS+B9HiFoL6aJbM5dUMpe0Biu7HY6gvT/ErXT
 HQS5R/hEMqBMCG4OJKmL0zb3WSqkGrK9lfZ9lWFZD57uTNpSP37RKBOheePy9INmMzp1CdbDRSu
 ftesBYV0UjOCBr4l9gKXzaQoworLhxiU4oSyz4Dy1Um1iCKKoKli1Z7YQHvWhVzc0tW3PakuRae
 p9vXHiv04hKYnLEKjyrIKqqSUsDPsNKLOl83uiEg1EPUIY9SA2THOkf3hMhk6uRCwcV1Byfqu1g
 2UE2rtxppiL0+dsXkbqQ79Iqio9K+hetxkYDUiUhrrylJaj8jCNlIyNWq2qjJ39xy4Ldgm8Kja7
 xY6w=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:05:54 +0100
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

Update documentation comments to clarify the difference between which
.id fields are mapped (only struct clk.id) vs. unmapped (all struct
mtk_*.id and .parent fields). The unmapped IDs are the ones defined
in the devicetree bindings, while the mapped IDs are the ones used as
the index into the various clk arrays.

Also fix spelling of "parent" while we are touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This applies on top of [1] which removed a duplicate @parent doc line.

[1]: https://patchwork.ozlabs.org/project/uboot/patch/20251211-clk-mtk-fix-dup-parent-doc-v1-1-41816d98f857@baylibre.com/
---
 drivers/clk/mediatek/clk-mtk.h | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 8a1cb0839a0..bd8899193c9 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -45,6 +45,7 @@
 
 /* struct mtk_pll_data - hardware-specific PLLs data */
 struct mtk_pll_data {
+	/* unmapped ID of clock */
 	const int id;
 	u32 reg;
 	u32 pwr_reg;
@@ -65,8 +66,8 @@ struct mtk_pll_data {
 /**
  * struct mtk_fixed_clk - fixed clocks
  *
- * @id:		index of clocks
- * @parent:	index of parnet clocks
+ * @id:		unmapped ID of clock
+ * @parent:	unmapped ID of parent clock
  * @rate:	fixed rate
  */
 struct mtk_fixed_clk {
@@ -84,8 +85,8 @@ struct mtk_fixed_clk {
 /**
  * struct mtk_fixed_factor - fixed multiplier and divider clocks
  *
- * @id:		index of clocks
- * @parent:	index of parnet clocks
+ * @id:		unmapped ID of clock
+ * @parent:	unmapped ID of parent clock
  * @mult:	multiplier
  * @div:	divider
  * @flag:	hardware-specific flags
@@ -110,7 +111,7 @@ struct mtk_fixed_factor {
  * struct mtk_parent -  clock parent with flags. Needed for MUX that
  *			parent with mixed infracfg and topckgen.
  *
- * @id:			index of parent clocks
+ * @id:			unmapped ID of parent clocks
  * @flags:		hardware-specific flags (parent location,
  *			infracfg, topckgen, APMIXED, xtal ...)
  */
@@ -127,8 +128,8 @@ struct mtk_parent {
 /**
  * struct mtk_composite - aggregate clock of mux, divider and gate clocks
  *
- * @id:			index of clocks
- * @parent:		index of parent clocks
+ * @id:			unmapped ID of clocks
+ * @parent:		unmapped ID of parent clocks
  * @parent_flags:	table of parent clocks with flags
  * @mux_reg:		hardware-specific mux register
  * @gate_reg:		hardware-specific gate register
@@ -226,8 +227,8 @@ struct mtk_gate_regs {
 /**
  * struct mtk_gate - gate clocks
  *
- * @id:		index of gate clocks
- * @parent:	index of parnet clocks
+ * @id:		unmapped ID of gate clocks
+ * @parent:	unmapped ID of parent clocks
  * @regs:	hardware-specific mux register
  * @shift:	shift to the gate bit field
  * @flags:	hardware-specific flags
@@ -245,13 +246,16 @@ struct mtk_clk_tree {
 	unsigned long xtal_rate;
 	unsigned long xtal2_rate;
 	/*
-	 * Clock ID offset are remapped with an auxiliary table.
-	 * Enable this by defining .id_offs_map.
-	 * This is needed for upstream linux kernel <soc>-clk.h that
-	 * have mixed clk ID and doesn't have clear distinction between
-	 * ID for factor, mux and gates.
+	 * Clock IDs may be remapped with an auxiliary table. Enable this by
+	 * defining .id_offs_map and .id_offs_map_size. This is needed e.g. when
+	 * the upstream Linux kernel <soc>-clk.h has mixed clk IDs and doesn't
+	 * have clear distinction between ID for factor, mux and gates. When
+	 * this is enabled, the struct clk->id will contained the mapped ID that
+	 * is the index in the various arrays in this struct. The .id and
+	 * .parent fields in the various mtk_* structs will contain the
+	 * unmapped IDs as defined in the upstream Linux kernel <soc>-clk.h.
 	 */
-	const int *id_offs_map; /* optional, table clk.h to driver ID */
+	const int *id_offs_map; /* optional, maps clk.h ID to array index */
 	const int id_offs_map_size;
 	const int fdivs_offs;
 	const int muxes_offs;

-- 
2.43.0

