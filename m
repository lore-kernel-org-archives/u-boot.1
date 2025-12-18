Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E44BD6E2B1
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0140883946;
	Thu, 18 Dec 2025 18:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RbYmu/7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF3B80107; Thu, 18 Dec 2025 18:18:13 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD1183642
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6575e760f06so286365eaf.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766078289; x=1766683089;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/UhaqqpNRQrxTnp5e1pV7AFF7mSUEbz6N+lQDSYUH4E=;
 b=RbYmu/7LlKm05vfE9BwI9ReV3yuxUZNf0n79LVm9NjBTEPXW6uSN4QLr41ZEUYZOn2
 guUAEFQDdtt7JANG1WE1bVbqiyqmCd+mKu4KMb4dC1F9bthaEsKDr9G8mFihARVGj3D1
 Bh1OI7vAHcRhRWsphorK5EgD7j7zFPOHUyLNJdwZD1j0zijbRMAXNWQAtiwKd7ETs0gl
 YVg+SA3I+aDWw0kni0tl6WUGUkOXSb7WLUZ9/VxxElb08nTy5jdSjblQMagD7+R9ZqJC
 875YLspf4sy1qu9tx0S3NvUreKe2RiMXRfgN+8OmqbsGWk3+qrXaDQKO50BDOP5U+2m5
 mt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766078289; x=1766683089;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/UhaqqpNRQrxTnp5e1pV7AFF7mSUEbz6N+lQDSYUH4E=;
 b=cwVFmTmjCpDXKDT/auqyO00v5B7vs49bhQP+aaFZc3CBxhfoJGnGollBAlw2uEFG3j
 moDOG2to3smtUkDwrxc6vQjpBvuSQNpyIMTOiXPF74Q1Ds1vKwwXdfgqlqAbj3Z/rywc
 V+rPG9IJ2IVwLQ3Qe0TyRP6dnk/I1izgpiElQgT/iaEpB2RaYJOc3SZrfgWqrTHAuRt5
 gNhhKggeKjCLNSIzclLGHEKEJZmTQSLMNHuVbc9TwZrl7b16m6c4Bg6qxs/rSRyMxyKp
 h+j7rSWDUe9bhoza+v0/yNFv3gy1cum1uN8K3yhSNv/O93wj10knp002Gy4CLr8yHUAX
 JFCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvqyH4tN7FYAnAbblGMR3hC0jmGoP34KlAr1iHzBOiAklNJITjJz/3d2pli1RxuiP1Xxj92xE=@lists.denx.de
X-Gm-Message-State: AOJu0YyYjvHWJdbgqIXKLhIQ1ECVqZ8FVATO+ozriujLnapEjdXou0C8
 TMP+Z9kAbfof1+2D1QFMypoqfvYrpz5vp59aWTejAHIbpjHerW+4rCCjgSIwyyvRXBE=
X-Gm-Gg: AY/fxX7GD1lK77/KU3P/Z447ZMbTB2gIWO5rpZ2O14fJqLwsXq5tGQpcrlfAYYkWxyU
 hcd36wBkWepwV/dfYQMNbxFCgdsdRvfmgMLeX+m6jJ4vuDSYqnDeyoOfVq2/QqVsUbZWkVSOsQa
 +CD0acg8KOSqkUbV/ZKgkhoT0tl93K7YWFCR98BesfrHUP7qt3ciHHw1po+ApaCtQBuiGVAJ6xp
 Bli2JfyOSGYvH0DFXi4b37VQigXoYHjd4ftyYPh8qO6QqnWax0yuPERp35JXuLxm6LaLSQuasIE
 TrJSuGmsxHWsecPOHtJ6+51caAoNfoppmQoVIsnDtnsKcnK3EGEdwTL2x4OOuHt/HpXBlco6Jfa
 lGmS15xo/i2h50xCZXSra6eG9QYxBCaCOPhj80E2BYJevWfuun3F8vtT93fLjVY9ly4HI9PAOK+
 IsQiOVLJq1cpV/LmQ=
X-Google-Smtp-Source: AGHT+IH60Vn+mK0aGb7dyJ+3Ef4C0VXKz0ozve7dgngONK9mG9ytzGAg0oViYtSXlk4Iu191VyNsPw==
X-Received: by 2002:a05:6820:812:b0:656:b1c0:7f4c with SMTP id
 006d021491bc7-65d0e963665mr101785eaf.4.1766078289184; 
 Thu, 18 Dec 2025 09:18:09 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e5ea:76dc:e589:2d5e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65cff214d66sm1316372eaf.9.2025.12.18.09.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:18:08 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 11:17:04 -0600
Subject: [PATCH 6/8] clk: mediatek: clarify mapped vs. unmapped ID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-improvements-v1-6-72db131ba148@baylibre.com>
References: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
In-Reply-To: <20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com>
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
 bh=6JDa5+CXGOPe31h+2cUmvqat5YO7T+X+aZKWM5R7fiE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRDc39yYwBcESge8dNK5vWsVPVvw3Nv2z9gNdD
 QEztDhARPaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUQ3NxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjGwH+wUDtAZ3rkPzMvD7i+8EJX/u8zxru0CDWrHkqrl
 ydRVHAnAIG4HJavRW/brSk8qxT/4iGUJ9Z+xzWK3qhhk1tJl8CGTTn7RbmjC+LRozcZjP37/pPe
 yKFHMV2nLB0wYiE+dFxWgYqYo2Q8BDDuYrzDmVuzzAjbrOKy1ZEsXhPdplo4dzfKe9E5SImGXOK
 1qcpeuwy0we+ORieu8YSgI9xlfRnW+vp0sdXASR6AqcN/sx/fRjYkgCjbNca3X4iA0ZdkgvmP8U
 TD6NpBD5Fst6sSlFAiJlXc+WedsFBb9A7Kvla+tbCazB8OeCkkcNtsfcKbcbJqI3I+bkGC/ArhH
 mMUo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 18 Dec 2025 18:18:40 +0100
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
index 980d9aab809..915b872ec36 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -50,6 +50,7 @@
 
 /* struct mtk_pll_data - hardware-specific PLLs data */
 struct mtk_pll_data {
+	/* unmapped ID of clock */
 	const int id;
 	u32 reg;
 	u32 pwr_reg;
@@ -70,8 +71,8 @@ struct mtk_pll_data {
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
@@ -89,8 +90,8 @@ struct mtk_fixed_clk {
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
@@ -115,7 +116,7 @@ struct mtk_fixed_factor {
  * struct mtk_parent -  clock parent with flags. Needed for MUX that
  *			parent with mixed infracfg and topckgen.
  *
- * @id:			index of parent clocks
+ * @id:			unmapped ID of parent clocks
  * @flags:		hardware-specific flags (parent location,
  *			infracfg, topckgen, APMIXED, xtal ...)
  */
@@ -132,8 +133,8 @@ struct mtk_parent {
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
@@ -231,8 +232,8 @@ struct mtk_gate_regs {
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
@@ -250,13 +251,16 @@ struct mtk_clk_tree {
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

