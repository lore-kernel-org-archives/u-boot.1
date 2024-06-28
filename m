Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B74C30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED97885B6;
	Fri, 28 Jun 2024 19:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CJy/mOJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7C6885B6; Fri, 28 Jun 2024 19:41:39 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4680788581
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4256f102e89so5504345e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596496; x=1720201296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LddlRVqLaui1Zlv5wf4Q0iURIWsOCtFSBVx2z/9tO1k=;
 b=CJy/mOJeWSIs8jeRDKYwrrrWfDVemv6pGGQgUNNPVSNRnSNJrx6LK+cUG1chSnBxKY
 dmNmkKYfy8i8hiO+XOrbgUCdiAGLDTlmPw3N6jXSwyAyfhC0Xp6mTLzc0z5d6Dp7mlTQ
 iBWCc3o84c6LVV3U4Ae17s0cM81r4ylo0hxU6rITaGFje9/YjL2LFXWPIrpgY9X4atL4
 ZRqULV6d9/70RplajOiuMu9BGdxTn0Lo6c3dWizJa0m0wvHnyze/hNIELM+ViDpM8726
 KCwHhVO6Mi9rCPdBX1RrSH7C5ZgsXklXChJVZCya1XjFRM5ron5NJj50mZwM4AmK19u6
 1n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596496; x=1720201296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LddlRVqLaui1Zlv5wf4Q0iURIWsOCtFSBVx2z/9tO1k=;
 b=DlSTCEcGO51hUudlTm5BXGy+Er52qVc8d2tIwY+tiLqE4KN/0at7mLXVs2/xNkrOnS
 HtLXlr8JBhIt1+2j2xR9dlFJAT7iO3KyXTRqYrf6a44fpqqX3tTPNS3DigvIh8ZKYSTe
 1vUSxiDKzM8Iek+IcYtwdWir1IiFMcNRgNDtoouhbCsYWeMzMu9KaV4k7MQyOzS5Cm85
 zDInSK+NojqVUklk6A2CGwlKexHSHzTT+4FXIPizYGFvw2vO0dhbeYGidDH2XUi7MHlc
 Eg18hvPgwzwjjNvB2UzGEJHBOeCNazWlLrI7csbesxPciZ+nxrEtIsWUT+kN1U3/JKYl
 2gew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMM4gieGMoq53MhkS9+ZtX4ilmAMVPM7hynjA1eLvolnlfcylmY1ELPenzaPZdQSmjc/tWmg0jXiQyU/7T4xDVx6rgQg==
X-Gm-Message-State: AOJu0Ywlw49VSTr2Rr7Khl98wNfTwN/VVRzX7UhlKj68RftVw6zMs984
 H+zyfwuPwBVtoNpOo6BjfanCp5gzgeJlDsiCBHuEMwaBWg9ukcMV
X-Google-Smtp-Source: AGHT+IEBiTq/rG/voXf2716Y83yAlmbfgqqJ/DsycQqv8HRZWKat38A8DVt7r1pge58R/94gbzWHxw==
X-Received: by 2002:a7b:c8cf:0:b0:425:63a9:f96e with SMTP id
 5b1f17b1804b1-42563a9fadbmr49198315e9.36.1719596495363; 
 Fri, 28 Jun 2024 10:41:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 01/12] clk: mediatek: return XTAL rate directly for gates with
 XTAL parent
Date: Fri, 28 Jun 2024 19:40:46 +0200
Message-ID: <20240628174114.8675-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240628174114.8675-1-ansuelsmth@gmail.com>
References: <20240628174114.8675-1-ansuelsmth@gmail.com>
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

There is currently a massive bug that makes any gate clk that have
CLK_XTAL as parent to return the wrong clock.

Following the code, with CLK_XTAL defined as TOPCKGEN parent, the
topckgen get_rate is called. The clk ID (0) is parsed and only in some
corner case (scenario where fixed clock are not defined) the correct
XTAL rate will be returned as get_factor or get_mux is called (that have
correct handling for CLK_XTAL). With fixed clock defined, the rate that
will be returned will always be the FIRST ELEMENT of the fixed clock
table instead of the hardcoded XTAL rate.

To handle this, add additional logic and if the flag is set to
PARENT_XTAL for the gate, return the XTAL rate directly.

We assume the clk_tree to have xtal_rate defined with clk gates that
have XTAL as parents.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index d2c45be30de..e68beccc060 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -543,6 +543,13 @@ static ulong mtk_clk_gate_get_rate(struct clk *clk)
 	struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_gate *gate = &priv->gates[clk->id];
 
+	/*
+	 * Assume xtal_rate to be declared if some gates have
+	 * XTAL as parent
+	 */
+	if (gate->flags & CLK_PARENT_XTAL)
+		return priv->tree->xtal_rate;
+
 	return mtk_clk_find_parent_rate(clk, gate->parent, priv->parent);
 }
 
-- 
2.45.1

