Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D24C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7248857E;
	Mon, 24 Jun 2024 23:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eTRNGXUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE3A883CD; Mon, 24 Jun 2024 23:04:51 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505AD8859C
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-421757d217aso52893355e9.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263088; x=1719867888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WZO1OdEDiGS/fPncwft2fUYjhIWbeKbsnL/B91ZUqXw=;
 b=eTRNGXUrcnhgU7G0uhFd/oJRSLwY/T2IMSg1qNQZUlJF7oi9JidMFob5J18QCQmErV
 Fa+E8WVHlxnopmLjv6keR+SM9xEsW88D5JoJpADa+kRdDxP+IUPWsp+CNO5BFeHx4WY4
 L0KOSX5m8DijrzRLiqbxDgAM1pRQpeMv8MryWqXUr/PP+qfzs6i8yoCGZTm9IODzk6Ra
 Luw4ELSEFv+P/MzHp98HPX8F3Q0TfMDDrkW5TVr7/Ri7R/x1SkV0v+2t5Z/LDjx8zOpX
 pWxjQAF8z+wKg3PLUt0xU0sXPZACyErAq1UFaz/UFvE/Ivuorq6YyldiaNgnDjOOqeio
 9NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263088; x=1719867888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZO1OdEDiGS/fPncwft2fUYjhIWbeKbsnL/B91ZUqXw=;
 b=rF+1JFSWFb9JkF8Fvd1uGOHxXsg0J63Tw9SXB4jm4A9hOBD0vqIRgE33/cU+Fo1gQt
 PbYLM2F64GFmRVC3t6F/8+l1HSE+cvwzpjiTnw1c5iXuT2COQfQg0E4rG+CElRsBYM4B
 1WTxd1DNV9zdVTMgDF3xG86imsp6au0ASCnAqU0ZlbGRAtve5paXDb6X8G2u+ublK3b6
 ySmFz6Ka2wVDNQVs65+wqyn8LWBkTa5v4cPTH7tuUUgV+faUCaidsiEKlOLRDXVwtU/h
 hrGd/kS0J9iFKHqwxdNud5P6xA66sd1pn+NEReA9w6KiJPtPfcLPqKcIXmZn1ycDQU9V
 EzKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgdhNkO9eQiV8OHrkZVY4c3hdGdFuKdzrsChHW9EcAlWtXTA6ecZB3xbcY1SKNA4jbLNvrsQup+CpYQGwWL2hs19Eq8Q==
X-Gm-Message-State: AOJu0Yz7bMZcRe1vvOXNemM4+OeaOcTIAu6lP/qq8Jdx5fCkWOcox+pe
 hQ2qhoNo7+Nev8f5eSO/pH1kPjdeYqPmiIrcYCVe6NXS53Ak4g5O
X-Google-Smtp-Source: AGHT+IFJ92YpLn27QkJ7H2p+0ZghUO0hL0HwBMXf6QSrBHUSTlVXA73u2Y/3Sm91RZ34ooBTFnPI0g==
X-Received: by 2002:a05:6000:174a:b0:364:29ce:b14e with SMTP id
 ffacd0b85a97d-366e96777a8mr4096138f8f.69.1719263087792; 
 Mon, 24 Jun 2024 14:04:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, John Crispin <john@phrozen.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Marek Vasut <marex@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH v4 14/14] clk: mediatek: mt7986: support alternative
 compatible for fixed-plls
Date: Mon, 24 Jun 2024 23:03:40 +0200
Message-ID: <20240624210418.19324-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624210418.19324-1-ansuelsmth@gmail.com>
References: <20240624210418.19324-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Support alternative compatible for fixed-plls clocks used upstream with
the compatible mediatek,mt7986-apmixedsys.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index b3fa63fc0ab..efc3d4120b7 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -533,6 +533,7 @@ static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
 
 static const struct udevice_id mt7986_fixed_pll_compat[] = {
 	{ .compatible = "mediatek,mt7986-fixed-plls" },
+	{ .compatible = "mediatek,mt7986-apmixedsys" },
 	{}
 };
 
-- 
2.45.1

