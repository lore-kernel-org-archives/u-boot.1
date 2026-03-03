Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76283EDEBE5
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 19:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1146683F8A;
	Tue,  3 Mar 2026 20:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DWQCHEWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 466CE83E7F; Tue,  3 Mar 2026 20:55:53 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 019F183F2D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 20:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-45f18e8f2f5so3989944b6e.3
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 11:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772567750; x=1773172550;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KMjGYCYY9bPtG97Hit2lBTixy+BMK5/67t+iVUpfbIU=;
 b=DWQCHEWPQBO5rRwZ2QW1M1hXfxf5MW9DSQd/b2DoDnTB0H6W5fQX0MiT7vUKBJqhGi
 LIFleTgBzcWyMylDOiU15j5fxDmygNOd5yiH4dT6mgZ3sZ4d02wr5GpsCb23kd1Bwc5Y
 xbzLbvTESHGuGZ7M2uV50CXr+/2qmT7gU/9sgKF1DlQBm0XvKRxejZ7RmZQuCRi1AiV9
 +LuR1n9pRMm2s8uDPSc4WVumLvT7p3WpT6tYGF/qkMdh/YTfocAsw/M3yMuvy+DyfeeU
 zZtP5t73Y64EUaatZIiRgk47IU4TvuQyt+lyEV9U93mZQFK4CFguygIbwI1U9IPgZtrC
 2Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567750; x=1773172550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KMjGYCYY9bPtG97Hit2lBTixy+BMK5/67t+iVUpfbIU=;
 b=RrS7rJriN2BnhAdp02vU25Lb8Hb+oycnq2Ni7rHy3Uub3H8ngRj9Dva+SIPpg10Y2N
 5gj4L/epYjwZkrxaGZ7i2rHBfXRy7PHlj8vqs3Mnn1XZ/EoWoFRVPzqXfQ7aY0wPU21m
 DkZ13KgZrUv54dFRExGzeRnitlNh08waQ881kktbVmfYHGaVnkToZJFuAlxhee7sHQVF
 zrwh0Vcm9mbxFRuBcazNrb3dh2LL/WXdqb69WXXdUK3fOg09mjWJFGxMqlckoSzTKleV
 ymJ03DueSRdRqdNS+WYXH9Yj6p+YIz8mE38UFCSRpXxU1OU/RHNQPj9Pjg8yO75WE8qo
 JZng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUODEzccIcBpb5G3TUMwHLEPffEo+BHvuqsDgGPa0VQ/OtIz6aS3UWOv3aYfXIHBUsOE6UhffU=@lists.denx.de
X-Gm-Message-State: AOJu0YzZllnl34ozmCpnBarbtfiGzuV1X06zs4UPrib+wY9/9CoIZz3y
 FWN3pk/77bTmNvLTeUzbFZ8Bm49n6Zy3nqz0RKXEyOlh+dY/6o1G/ANTUn+0GKFI/Tk=
X-Gm-Gg: ATEYQzxr7RocpEzTRg7PJpiwZFLrzd6QaU0Dn7miM8z4lEQDk9Lt5MlUinqydtRX2Y/
 O/j+SApiiBNLUwL9ymP+L5cHTHWV/ZsTZbmY7gsoPe7QUPJ541fcUpmqacS1R4hoRPLq6OCKpNq
 rlA/oiNrPg11zymbbteU4KPCzLo46NqlWhyIZs9QyQaWwan1IWqetam1CSjIvsD1yh7l5T2TNoJ
 7zhlPV/57V7K1L2FYcD0H5M378llU5X5Zisl2ft4M/oDK76fHEOqm3YRSp7DYlPI1AcorhOOk/L
 BH7u5ElvjSUyuH0VP5OI1pkAq+k10naNG2TeBfoAQs/J/TQ1lm2r5LvUCbkwILctRREFgF3VTFR
 RQ/FZmF1Vsu2sfuuke3PGhAck7g5uhBHpiij0ojxfl4FnXfd3q0I8ZuaTuIWnbZSH0aODGg81jT
 Djp/BnZWKGjkKVUDGK1lxQTDDra11P
X-Received: by 2002:a05:6808:c14c:b0:464:a06d:6052 with SMTP id
 5614622812f47-464becae20cmr8444627b6e.37.1772567749577; 
 Tue, 03 Mar 2026 11:55:49 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e10b:3ef0:5af1:d180])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb352592sm9995183b6e.1.2026.03.03.11.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 11:55:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 03 Mar 2026 13:54:49 -0600
Subject: [PATCH v4 1/7] clk: mediatek: use correct struct type for infrasys
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-mtk-mt8189-clocks-v4-1-ee85f8dd2f0d@baylibre.com>
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
In-Reply-To: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppzyVanfczHYnI+uQlEICOc1ySZz4QsqUll2UA
 iCOkKcPQc2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaac8lRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Atk0H/ApLvCAnICOI53jtddiiCLL0uN+vTAjWhCgInf2
 kEU8nPHfD2kZBt8azHHPuhyWso2HaZupcbmz1g56Cnb2+a/TAPLZxrb+okT+t0Pv5KARYuuP67T
 e61Ti3YJ0R45jDZDetvHBmKQgapFhVqn8qUcIIFykK1T9u2VvTARcspjuXSk3U8NeUZuXy96tI5
 rVzy7voBReLZQpsuKIAaa9EjX64CjUwifnSBLpDxPh9KLn8AgXoX9D/8ValBqKm7CEp5ixulNbC
 0N+aiL1Gr2vL4lKtiBUzD0XkzfxeC9f6sgxpw5yPqgBKXK5QnvPXCA83tzI3VHFzY6bo+Cb7yXw
 Qkmw=
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

