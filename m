Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF35FEB3641
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 00:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2AC283F75;
	Tue,  3 Mar 2026 01:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ge22mPWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D5B83F7F; Tue,  3 Mar 2026 01:05:12 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 071B783F30
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 01:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-679f6f0855bso3125337eaf.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 16:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772496303; x=1773101103;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mn5WHhhWWhT/nc6lRy58DfHo7wWmWcN+di/Qql7GYGM=;
 b=ge22mPWHHSMwO6YU5yfQ29Vy78QemN0j0jd1ZWaicM2+wjGTzVBXsGhWRH1g9Ih8UE
 pQ4hjBeAc1vLRwYXLqAvW4IYEi7ZNo+yg9m0CFYzesQZ6GS4e9IAPF7BozgR1ptMdfUP
 pPmQBWh2+pwfW7fYVmpTfDt03J7M3EtWprHLXtZNA/SIZFTRhF92ivBNmmq2c0tO8yVq
 T5AfL+X69DPhfRihLoG1A+8JBG691JP8KG4t9qtgPHR1TitNkCjUrwLdHOSySi0kXXXW
 EyUFYI+WpunsEcJP97uObyHuY+OuIMr1WtRKQ3ddN8Ub1eVP3tLhQGI9RuUl68jE4O90
 t6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772496303; x=1773101103;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mn5WHhhWWhT/nc6lRy58DfHo7wWmWcN+di/Qql7GYGM=;
 b=xLhQiMrzoSSVnk8BWDpSCByII109TrYz+x1UwV+OY4ENGIs8n2120/haC0A55AfbU1
 qW/yuJzihRmgpm0w+Ik6Zj73fsXIWlkTIRZdFQx0FR3qPH+vDgT+dhTxEKFkn7oXA2hO
 Bc9/c7N24jzM5fwlwaI85xBLMDh2pjPcHFte0d4BmF5b7iO+N2wZ1sySO3jEigqSt/eS
 kqydYDjpn2f0Q9+lyitvUY2yA3zj5MWsAr5dinz0J2lV9Ky1ZRJ80W2FOsePJ7bMcv54
 jxWZJ77yBNBBOG2fIIAcayy4wPOdCM3okzh41766VZALFOG0NGSF+Whvy2vL29fbh3U4
 Uo6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw0BT+AA7OD+DwimF9v4LNVlhUw7QR7kD1iPTtczfVXdTtbMbaOrVuipXh6/v76RJtiG9cDOc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb1Mw3iK75OA07PXJ2oQ2K5C/P2qTxhM6ILls6x7mV8xOXaIpU
 YkVJmvckUyV1+tiPawGtopzQe7cT4aT2TbmjcaVvE9kwSIwmCwvmt4Q0JT/Lb8nHcfAgEYbu9EC
 oYsZS
X-Gm-Gg: ATEYQzyM9Fi3dT6kK+utkc1h1ATsk5ubbjzeW8QjO9ibyvy9cffwrRBk54LWSQHUAmv
 TiDmi6ecDtaBo/A1O0kxNBiupIKrgYFm3GAV1nc5Cblk0SQ8WMqdcb1acoaz1qvbUZhDNKVlxtb
 dgKPIHsT6m91eFEwG37H2PjpSj6IZGU+s/2RijpOgctdy5Rq3G8MsJaPI68Q+uC+UzjNcJfak1I
 a99rtqM87e8U/8wUe/GkiBp6spXHdEpnDdIOO5a4pLeVdCOOBghcOrWMf+UeLfcVU72bjLLdcI9
 5NfuGpAfmKrXXLvttHXijMDblk1Q4IVJW/tcla3OiIv9RMhFOfNLDp56pUeHHFFop0pZxCN8bR7
 PvgIxjFwTFD1+2QJ4ZWYdIrdKGccWQJ02urb/9xo6R7xZ5aWLl2brH6SCsbI1+tCd2/B62CQFU/
 pEEprmiO4G7rDq+rpKBtho1k5xgVjY
X-Received: by 2002:a05:6820:98e:b0:66f:c72c:7c7 with SMTP id
 006d021491bc7-679fadf3cd0mr8496872eaf.18.1772496302920; 
 Mon, 02 Mar 2026 16:05:02 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf239e0sm13878551fac.1.2026.03.02.16.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 16:05:02 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 18:03:11 -0600
Subject: [PATCH 02/14] clk: mediatek: mt7622: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-clk-mtk-unify-mux-parents-v1-2-32f45085f4d0@baylibre.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VJjmPRU4q7eRJ9zPVfGbM1Vn9LC7W/D2F0EyIy/59jA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppiVXs4N3aIq30XUOeM4uA8W56rwJIeDs4nx6t
 A39sxUxwJmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaYlVxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5GoH/jmEhwWysa0wsvIrzSOz6gCFMxBzbI5epDpvjVb
 fzLVczviZ1Qw1DaDN+4ySH8T7+bR7XeDmXhaxuHoPd+qnI31l7Y9938gv2wKt0BTXyIbvCBD0w7
 kHYnMnPJnvT8pRBOTqbmRBmb6NvrbpNyALQbdT5jdLkH2MBQ07dZwMdJNKOdlkfbV7+BtylhEJ4
 EI3ard6wbovqpI2F/pI4x2Yc25BCkHHklT3T/cACxAseQJVr8sv88EFYlVOGHG5UAN/00Mpd01r
 mNyBYpGBhfU37+kmGrxNG9buC/07OIT2CxmcRQw33ZQj8LrIIkz9VHV+kXpkhZoW4DSQvtxMYMd
 xuu4=
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

Convert all parent clock arrays to use struct mtk_parent. This will
allow us to simplify core code later by having only one possible data
type for mux parent arrays.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 88ccb4cb8ea..bc1baf8c4e5 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -421,16 +421,13 @@ static const struct mtk_gate infra_cgs[] = {
 };
 
 /* pericfg */
-static const int peribus_ck_parents[] = {
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL1_D4,
+static const struct mtk_parent peribus_ck_parents[] = {
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 };
 
-#define PERI_MUX(_id, _parents, _reg, _shift, _width) \
-	MUX_FLAGS(_id, _parents, _reg, _shift, _width, CLK_PARENT_TOPCKGEN)
-
 static const struct mtk_composite peri_muxes[] = {
-	PERI_MUX(CLK_PERIBUS_SEL, peribus_ck_parents, 0x05c, 0, 1),
+	MUX_MIXED(CLK_PERIBUS_SEL, peribus_ck_parents, 0x05c, 0, 1),
 };
 
 static const struct mtk_gate_regs peri0_cg_regs = {

-- 
2.43.0

