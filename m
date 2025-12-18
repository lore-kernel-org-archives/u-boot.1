Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA96FD6E2B1
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 886C183700;
	Thu, 18 Dec 2025 18:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qlb6+11y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED918042F; Thu, 18 Dec 2025 18:18:10 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA0483642
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e89d226c3aso599399fac.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766078286; x=1766683086;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GKp0fr5JhUJcOhH4Hmt5nHr6hwz0Aouh98zA89Jj6CQ=;
 b=Qlb6+11yZ/yLXWXnH5ylG2SSAUcciw3t3e0hcMqNu2OyXdrxj/7ppU4gyX/+e+EF6X
 LyvJ1icjZFTnb8d7Zc0To3vnYqANt0zLKsM67up0wz1WnRPvGAh5oV/bz8Fr4JNaXWVg
 7Ek0dyzNk+6MdmNsSkzZRIZ0nuE8CW4VYLfYmgk8ZEJVA3nedjiQgM9pl/XRDD1lQnyE
 ebvDDlGNnByt7lMHciKYXMhlusMt0eQn5vpK7C7T1QlbsZPkoI4e4cOegLZGccJboBMS
 HhXWjXHp0rUkH4n5MAc0TnDifmnKAYs3l8BJshwC/zofqaMp580ooPBJPnbBvwdm8wEn
 shNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766078286; x=1766683086;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GKp0fr5JhUJcOhH4Hmt5nHr6hwz0Aouh98zA89Jj6CQ=;
 b=tPbMk7kqYcCEc3cgeksllv+Ukw+rVX2GG9LCjIsDBRRR/blHwenBiX3iDdwdR4EaP6
 aq2uoysTcTHOYDfk07uq5NiARgj9wkzPetDWoqoEz7jXAfapBUdvj8mLsvF5Vh3Ubjbj
 C+h87oMIq+Fv3XRBBJBzrauR5xpqyzqXEA9AvmfRAn9k7mmmsQBxTrpAtGK7ubDVYO3z
 tQhQO168+35aoesgBKaw9cg25jt/VK1IA4KEGux7tjzzKPzohCdeYRzn38nsPVIVCPKp
 88ZPM5Cmcnqtc6ulT+Lm6wwRQQlUU4hbJqNUrrOaS1PEtc1aonIRipg25CEdpeZA0vp2
 fmfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbxs375IH3jMU/kYqJBis9MgHgzq0qh90N1ZJ3W02W5C7O8AKU5oMjK2Y6gxTZBlWV3Q5WGOU=@lists.denx.de
X-Gm-Message-State: AOJu0YwusY63nBMee1ei4sHb9WC+xqVPnkckCrSCSurbrcpqYp9WkTUm
 ACwkC6VBl45sIpdh2dCkGPvSQe6s3jlCT/SPWyUrBzc76CB8RGdHOE7yx9x6S5dWI1U=
X-Gm-Gg: AY/fxX5iU1Fgcb9AtixTeFXShddsQcfhCgaIDFIYkqPtEAAMqLQmhQRtJ8fTooOlyjX
 DGo8UE43Fv88VrB5gQPLjSLYugNnmXBA+hYco3lqE+4HVWN48oTcBRYFAfdiXmaMm7cq3nhmHiC
 sQ0IJ1LlOk+6wm/DaCPXwkxdvwwo/OpeI4SheJO0Gs/mpizJiSnZiYUcaFUIqQw1Nr0upe8r+dN
 t0xtANxlFocxkxoDBces/zTBTByWbZ3md+TELrN4+4O0x1gA62qKwjDcXI8qErxdWTwiS9dT6Yx
 ZqGS2K7RxhoU7RIDecwJdXrLoYBq/02jv0kUxgJ3TGOTKO++SJ6Yt0XxUcaDmQXEFTXiihPnvVl
 66S6+TDjpNjcxPhKU1bHqSsnamlnHgpRSdhMHTfmRn1qqF+mjvNpqz5U0awAde3N8KTGBSodftj
 bO3Gj3wg32owMZ578=
X-Google-Smtp-Source: AGHT+IEKIKXOFq2fzYxsr6FLHOBJ15da2aDmhxURc1gpXTYJ3oLoyG4xU5znLLdJvZp+FRLPOPK+8Q==
X-Received: by 2002:a05:6820:2d81:20b0:65c:f583:d3e3 with SMTP id
 006d021491bc7-65d0eb73c3emr69108eaf.57.1766078286574; 
 Thu, 18 Dec 2025 09:18:06 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e5ea:76dc:e589:2d5e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65cff214d66sm1316372eaf.9.2025.12.18.09.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:18:06 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Dec 2025 11:17:01 -0600
Subject: [PATCH 3/8] clk: mediatek: add array size field for id_offs_map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clk-mtk-improvements-v1-3-72db131ba148@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ca4K+MSDoKO/hMCf2/m2RTuz6BsAKeOYIfb6YJKtfDs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpRDcigNHuR6FQv6wGNbWXOJBoFRzCEYPkaYO6w
 yVJD9zs2WOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUQ3IhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AaHgH/jjuA924PCqFFDuac5ilowZ0FQF7oySCnJ1NKcv
 6HoIIdA88MbNyvxsVxeKmQeTYLGgYCB9xNANhcqCOyZxMFYOOLjozw/F8kHs87LiGjXqBJiWZ6p
 1SF81Bz0Z82B7wkgrmTJe7dxyXL4WkXjCMzN9r0XUuZ8FnO6yYiHHHFsl56Zz/yRCrUz8CIdmwU
 xDp9uX8cV8jtra9sxzL1SrLYGPO8BqhZAiOS7Owt/C+j6LGW8ape1M77S9dTmqtZAG/twUnRJhv
 QGX9Mp/HZLn1tavcrHhvkwi+fozBCXaN+8099OwmoDKCjB29zFvx/yxEV6r8lvOdJ+J7rmjPgvU
 mEFw=
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

Add id_offs_map_size field to struct mtk_clk_tree and populate it for
all existing drivers.

Currently, there is no bounds checking when accessing the id_offs_map
array. Adding this field will allow for bounds checking in the future.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 3 +++
 drivers/clk/mediatek/clk-mtk.h    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 5a60a86233e..eca8352d8e6 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -996,6 +996,7 @@ static const struct mtk_gate hif_cgs[] = {
 static const struct mtk_clk_tree mt7623_apmixedsys_clk_tree = {
 	.xtal2_rate = 26 * MHZ,
 	.id_offs_map = pll_id_offs_map,
+	.id_offs_map_size = ARRAY_SIZE(pll_id_offs_map),
 	.plls = apmixed_plls,
 	.num_plls = ARRAY_SIZE(apmixed_plls),
 };
@@ -1003,6 +1004,7 @@ static const struct mtk_clk_tree mt7623_apmixedsys_clk_tree = {
 static const struct mtk_clk_tree mt7623_topckgen_clk_tree = {
 	.xtal_rate = 26 * MHZ,
 	.id_offs_map = top_id_offs_map,
+	.id_offs_map_size = ARRAY_SIZE(top_id_offs_map),
 	.fdivs_offs = top_id_offs_map[CLK_TOP_SYSPLL],
 	.muxes_offs = top_id_offs_map[CLK_TOP_AXI_SEL],
 	.fclks = top_fixed_clks,
@@ -1063,6 +1065,7 @@ static int mt7623_infracfg_probe(struct udevice *dev)
 
 static const struct mtk_clk_tree mt7623_clk_peri_tree = {
 	.id_offs_map = peri_id_offs_map,
+	.id_offs_map_size = ARRAY_SIZE(peri_id_offs_map),
 	.muxes_offs = peri_id_offs_map[CLK_PERI_UART0_SEL],
 	.gates_offs = peri_id_offs_map[CLK_PERI_NFI],
 	.muxes = peri_muxes,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 3259f6281dd..980d9aab809 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -257,6 +257,7 @@ struct mtk_clk_tree {
 	 * ID for factor, mux and gates.
 	 */
 	const int *id_offs_map; /* optional, table clk.h to driver ID */
+	const int id_offs_map_size;
 	const int fdivs_offs;
 	const int muxes_offs;
 	const int gates_offs;

-- 
2.43.0

