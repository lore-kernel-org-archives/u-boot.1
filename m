Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48330EB1060
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 15:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1CF98412A;
	Tue, 10 Mar 2026 16:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E5Hewau0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4393F840D7; Tue, 10 Mar 2026 16:34:35 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C2C8415D
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 16:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-466ebbf7ff7so954236b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773156872; x=1773761672;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ip0UyXHhnItIxy4dXbxnxGe/8f3A8nMu+IJw+wFjAq4=;
 b=E5Hewau0azTMcIl1Q3Y6wrwSQrSQv6VszvaDOuQBg3PQAfTPQGbtpWdCwx+Rne83VE
 HH+MRocaP8I8NdXPvYFuw4fO4DpCQx2kPkcU2u8LGzajyu7NXRIine8R0hDMWH9hLmoA
 gqOMtQjIfK74J4y6h3EoNKkXqfs1mfPDn2Q4SaU3fN7upQGIpRcuvphFIG/umiqN7O0M
 hC0sz9/84kUp1AirPrlWjnX8e6l3lnWZ4GtReYxIIFI53knDWvxSj2NKatb0DiS8yDax
 mJE7jfeochHWnBFT+mYmcT26swDY8jdmwJZVSNlbD8a/KopXyObaRRRGoZRntbU3ga21
 eEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156872; x=1773761672;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ip0UyXHhnItIxy4dXbxnxGe/8f3A8nMu+IJw+wFjAq4=;
 b=Pq2f0S8CVK61NH9HASA5il4gbCSQD3gdAoPf2BmAG8ninkbhDE9uruN3zkt17Jca7v
 R5BF2bTq5Q2yiw9REn9FvAIIeMORLqIDkRjs9LijLazQeP3VKbW7/nFQ5BDSvnv11T2b
 iqN3PHXwPxrqcIihxhuatOTkQtA1+I06kD+iCCUCbzZDzwOXMJ9xEShKFEK+yD9B0/o/
 ild3O5YTmjDXUpDv3svhUupTPson/CnE3dQ+25e1+kjvlVqAEGTdFPewL/JWjAhEIzJP
 E+EYfv+a/mMAf8KVPCRYcVDLBvUsq2o/g8yE/B5YRaFW88S5dx4vBUnSXuhnNA2cjRwT
 59eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkvCFPJR2YB8kVCa6lYf8ud1cRaAPjkCFVdGt/yRxDNG2P9EhrRGwwfwo4r/RbCzkpgt+2SkM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/3BYUrbxX0uOxihfWUYKT3ilizZP9oQikYcqFvi40Y/KjQUvQ
 18ravqMIntKv5t8hAJCHsoSiAo0B24jyxijYiOF/yTc+y2XUqhX3qSFRegrk1kW1Fmw=
X-Gm-Gg: ATEYQzzceHHmwuFf1A2TT/fT7151RHoUf3eZZi6oOAy9L3w5Hrg+M/XJGC1twTwlXJg
 86WKH/mP89CRTkrX2y6gEEq/yUG7Ug+Ov+9C4rAXgg2UJdhYWJFX0eOo4W2rRxpqPuEl0o/LuWY
 iyR0gqoSWGsybyH6zu7t17xLKe1VUS72XInBHD1CXyBk2NfUaJPdtvI6he6yl97fR8bigLP6JE5
 NOYTO0A+Iz28tcDaH5t8x6aZXdcAE2FBCI5ZckEz0VwZFxjaDrOAMs1e3smSDK/08YVk+cPZdx4
 48e+Ig0zWEFxWfwABOl24g7YbtNzFiTc/wcHvZxv/0r+2xMSLE+rZzxRIsBoklLNFXXvj3Nnc9j
 EaXrmJ0YX9DcSqrbOD8GVW3zU2L2r1pb8199odU3JrMA85i4Sdsp2E3PJcU85P8zES6Ok/NHiss
 ty46X+vgLjGDr3hS3tzgSFu/X5kKc5
X-Received: by 2002:a05:6808:3a0d:b0:467:2a6e:adae with SMTP id
 5614622812f47-4672a6eb452mr389332b6e.4.1773156871761; 
 Tue, 10 Mar 2026 08:34:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:78e2:51e2:14b8:2e10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ecbcec59sm6320968b6e.7.2026.03.10.08.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:34:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 10:32:29 -0500
Subject: [PATCH 16/16] clk: mediatek: remove CLK_PARENT_XTAL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-clk-mtk-parent-cleanup-v1-16-66175ca8f637@baylibre.com>
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
In-Reply-To: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2928; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=51Lmbq++jKQ2ySx1FfKrf9zjoFBgCME5FysqBuuk4Os=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsDnugV0udkHZESyYlAaws1/9YUk67gsTsQb5q
 p6g2jeEfOWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabA57hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/APloIAJdZ+cWTDtdZ69xm7N4LnETh3unlNCfqhn/biFj
 MZ6w3LbNzmLGYcFMW1ngPraCjMNtxOeDP/pkBLK4u/8iMqJU6n6Mr4q4l6o+/vsPunsk/B/SpsO
 JtiogxhYgH3NfmaFTMuYk94b5pR7cPD+TTK1Wgjg/7lC+Uz3EqYPgDj09mWD+KssQC5FNzm/nPD
 f2mSZCkfSYrlB9fQ+j6UgislwdZ5Du3CNtTvQI+kBK9XqjLKWvrf3LxLTgD9o9JrYUMHtbN1/w3
 1UCEuyhFcrDLq7jCJkxYq3JN779RO889jpQ87okringxooquey/UO0Z9u0t+sdNZaSO0nsUZupx
 mwyM=
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

Remove the CLK_PARENT_XTAL flag and related code. These have no more
users.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 11 -----------
 drivers/clk/mediatek/clk-mtk.h |  9 +++------
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 0b6eb0dbc04..3557aeac3d5 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -241,8 +241,6 @@ static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 
 		parent_dev = clk->dev;
 		break;
-	case CLK_PARENT_XTAL:
-		return priv->tree->xtal_rate;
 	case CLK_PARENT_EXT:
 		return mtk_ext_clock_get_rate(priv->tree, parent);
 	default:
@@ -352,9 +350,6 @@ static void mtk_clk_print_parent(const char *prefix, int parent, u32 flags)
 	case CLK_PARENT_INFRASYS:
 		parent_type_str = "infrasys";
 		break;
-	case CLK_PARENT_XTAL:
-		parent_type_str = "xtal";
-		break;
 	case CLK_PARENT_EXT:
 		parent_type_str = "ext";
 		break;
@@ -1104,12 +1099,6 @@ static ulong mtk_clk_gate_get_rate(struct clk *clk)
 	    parent->driver != DM_DRIVER_GET(mtk_clk_topckgen)) {
 		priv = dev_get_priv(parent);
 		parent = priv->parent;
-	/*
-	 * Assume xtal_rate to be declared if some gates have
-	 * XTAL as parent
-	 */
-	} else if (gate->flags & CLK_PARENT_XTAL) {
-		return priv->tree->xtal_rate;
 	} else if (gate->flags & CLK_PARENT_EXT) {
 		return mtk_ext_clock_get_rate(priv->tree, gate->parent);
 	}
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 682b4303585..b39a62edc43 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -8,7 +8,7 @@
 #define __DRV_CLK_MTK_H
 
 #include <linux/bitops.h>
-#define CLK_XTAL			0
+
 #define MHZ				(1000 * 1000)
 
 /* flags in struct mtk_clk_tree */
@@ -27,9 +27,8 @@
 #define CLK_PARENT_APMIXED		BIT(4)
 #define CLK_PARENT_TOPCKGEN		BIT(5)
 #define CLK_PARENT_INFRASYS		BIT(6)
-#define CLK_PARENT_XTAL			BIT(7)
-#define CLK_PARENT_EXT			BIT(8)
-#define CLK_PARENT_MASK			GENMASK(8, 4)
+#define CLK_PARENT_EXT			BIT(7)
+#define CLK_PARENT_MASK			GENMASK(7, 4)
 
 #define ETHSYS_HIFSYS_RST_CTRL_OFS	0x34
 
@@ -120,7 +119,6 @@ struct mtk_parent {
 #define APMIXED_PARENT(id)	PARENT(id, CLK_PARENT_APMIXED)
 #define TOP_PARENT(id)		PARENT(id, CLK_PARENT_TOPCKGEN)
 #define INFRA_PARENT(id)	PARENT(id, CLK_PARENT_INFRASYS)
-#define XTAL_PARENT(id)		PARENT(id, CLK_PARENT_XTAL)
 #define EXT_PARENT(id)		PARENT(id, CLK_PARENT_EXT)
 #define VOID_PARENT		PARENT(-1, 0)
 
@@ -233,7 +231,6 @@ struct mtk_gate {
 
 /* struct mtk_clk_tree - clock tree */
 struct mtk_clk_tree {
-	unsigned long xtal_rate;
 	const struct mtk_parent pll_parent;
 	/* External fixed clocks - excluded from mapping. */
 	const ulong *ext_clk_rates;

-- 
2.43.0

