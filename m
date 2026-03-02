Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42427EB362A
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 18:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B1B83F2D;
	Mon,  2 Mar 2026 19:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fIsKjZnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D0583F4D; Mon,  2 Mar 2026 19:04:42 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4C1383F2A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 19:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45f053b7b90so3196707b6e.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772474679; x=1773079479;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KMjGYCYY9bPtG97Hit2lBTixy+BMK5/67t+iVUpfbIU=;
 b=fIsKjZnpYHBOoUE3eajqc6jzM/s2cS2yqou1EsmX3EF1q++SLOi1Zj3QVf80+PzQlQ
 mqLX6ZDxU4IG8XxN4EI1hDlRFpFWsYXULdSlLPRaKq1xMGdGtZuIha8s+QTLcPPkSYLS
 KbctH1px5la8wuDMUKFALkvoqyQY5ydOBEaqH62Kz/RvMpJWprwvuqyHJy2Sv6fhMgey
 /KQg3kqzNFzetBIx6wmwpor4RPaslUYrnflPhUkJknAXta8ObWXxqnDBTOXIWCZS80j+
 b7ywtpzZ8C9Za2dEZ+Xd5mvftUrFMRso38vhwjhn5oOxDbiRAaPVozffBle98d+mPFE8
 4ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772474679; x=1773079479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KMjGYCYY9bPtG97Hit2lBTixy+BMK5/67t+iVUpfbIU=;
 b=MDwakv5okcCjGOBeJxtzPeImDArB2PEEy6fd0dZrFtIXDQR4a+R/GvSjgJYP6VOzxd
 Adjv4eK2/cfsRVDRdxe5DF+9yrjzrd78fZV9ic6xcHUTCDI708MEsUL3q/9j5WdRpJR2
 QV21EaXW5vvLO0b9ecuOS2P7tlna1+y6n1kK+QxULM4P7mB37Y2oiDZuItYmUcgjfhdM
 GJ8pthbKnyjWQfzIdV3g3oPVOtxyQ1FIP6EqBcHm1000+OBrYEtKFP9HI9t5cYcxMFF2
 lsa28cx32Iwr10+q4lrvLBNWkUi0Nm9gHfl0c0qQdihOrTyJAZcT5IqBf3SZma77eXak
 5Jrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRy9EJwNYItfbuz31q10ICJQeBqWsUYEGSUK+ykaVHD+0HL1ZkRMEh0BOxGyRxhDaQ/gcjh3g=@lists.denx.de
X-Gm-Message-State: AOJu0YxnPFYqEI2Xblvfns6vjr/KaY9uUJ2msNmmD57rLrDmRc5mPQiH
 8R5ZsGka+DnJy8JS1Yd0k0wzqyG2UaRm+l78z8vA3Jt+LWa6aSlcVhbHNZFFY763RBI=
X-Gm-Gg: ATEYQzz7t43VlpUUM0EmLGGia5i2ZgSBVw0ielPYR3G5czfH2NyOjKySjaRdI31BtOC
 KvzubpDChCW/wX28DXsbsKynEYe6kO4BOt29w0R2yFpbjaViG1RVfTmSkYop+knCCJaaXi7k8Ik
 kOEtpTu+CZltRxWREr91SGy2zkIJIhUqXZR/JB3wWOLNsTb6QPepZSnwoukrioWGwz6ZWX3Ef5b
 Zbrk1P4P4K1HihoMxqJ9TPR7V7V2GMVj1f2ug2Y0rUQ7AM1Ijb8H4zlWaL0Hv9EH3QnGhm8PnGl
 NnIPdXtvcdjm/XaXEB5M4ehe8b3ixEwVBTO26nSxDs+WiyxpN9iYkSwvS56JzRDKGwgg9eHvKAi
 mQ6ats5fFMuXk5CTUwozzIfS3aUqCHsh5oCTmH7n0aEVbqpiWr3CqA7Pmsm5u/D0QP9IrTl/Lc6
 KBY+1vd6TRzlbnGCnbZeMWady6NXW+ArX3s/XJJV4=
X-Received: by 2002:a05:6808:30a0:b0:45a:8d42:646f with SMTP id
 5614622812f47-464bedc0a94mr7386456b6e.62.1772474679389; 
 Mon, 02 Mar 2026 10:04:39 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb3ab302sm7986125b6e.7.2026.03.02.10.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:04:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 02 Mar 2026 12:02:08 -0600
Subject: [PATCH v3 1/7] clk: mediatek: use correct struct type for infrasys
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-mtk-mt8189-clocks-v3-1-c48ec60344fd@baylibre.com>
References: <20260302-mtk-mt8189-clocks-v3-0-c48ec60344fd@baylibre.com>
In-Reply-To: <20260302-mtk-mt8189-clocks-v3-0-c48ec60344fd@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3SvhRcBSx6wfg31/2N2Df6aq5Y7l5XCklhamn77ImMQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppdEGryAQgvwJGGN6Jc+2tj7wLvXmKwBGka/wN
 y0CpxlfVUmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaXRBhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AA1wIAJn+9XxRDEsBTCg2pn5PoZTBF39jbdFNVMyCTDw
 djZ0Aj9BGqy7umsdkLEUQ0F4H/kkyh+Ud3gvHFNlqCvS2PjpneCvgQeZ2NjC8wgH0frzsO+k+c8
 c6K5rZDOHp0JcLJvu4Drc+4ITHMYe9viLRYaaoEAyw9vMSEeH7FELlIPLmCZcCnih0illjnT71d
 z2pwWHuIhA/AO5BFLRMkh1qn0CO1cIYRg+bh+DMgEip9yKdYXGb6C6BhuZ62ukHD63FNLNHPMmL
 81GtlfjiRY7VuUh7tiFZ4QkFiA9BU8VPDjZ+NDEJPVlwAm23yaQYPHkZhwhnsH1BTl8g8AB/WPs
 pBC8=
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

Fix the private data type struct type in a couple of infrasys clock
functions.

struct mtk_cg_priv is a superset of struct mtk_clk_priv and has the same
layout at the beginning so there was no compile errors or runtime bugs.
This could only be found by inspecting the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b4de38719e1..b3f05bf5a21 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -933,7 +933,7 @@ static const int mtk_infrasys_of_xlate(struct clk *clk,
 
 static int mtk_clk_infrasys_enable(struct clk *clk)
 {
-	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_gate *gate;
 
 	/* MUX handling */
@@ -946,7 +946,7 @@ static int mtk_clk_infrasys_enable(struct clk *clk)
 
 static int mtk_clk_infrasys_disable(struct clk *clk)
 {
-	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
+	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_gate *gate;
 
 	/* MUX handling */

-- 
2.43.0

