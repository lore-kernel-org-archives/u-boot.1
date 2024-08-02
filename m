Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC70C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C4588C18;
	Fri,  2 Aug 2024 21:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fi0PcWKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAE5F88BF2; Fri,  2 Aug 2024 21:48:55 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F2F884BE
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so57272415e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628133; x=1723232933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1ffhe+yC82JNyYO/g7cjw4EFuz84zGMpo1WugWXKtFc=;
 b=Fi0PcWKUxgAS5onpb2FJX4YioBbF/9nTP7lSPY9iNj6cHzzTtdj12k8DV/JlEUjePR
 od/qn7LBSbj/B0gvXEhjekJ3ypQj9qDleT14pTRKFMcATrhKFE14qgOq/GLmyg0twSrf
 JRzTfIYLVe2jzY8PEXdJ4IqVL/z7fxsFluFZgD8uLX09OfrlVP1DrR6cU1ONiT8CZ5er
 ThTpgk4NnKYRCsxrhD5KYtyFn0VWTZG8ZOFBzqxQ6m4OsSB7MHGKmaf3GTlFpEAHNv/h
 LkGHz8wLlfqqx+2zeh04rW3sh8v0mcr4xONwxJLNkDURUB6Ot/TIiHtsqUgNUw25Xccg
 A1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628133; x=1723232933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ffhe+yC82JNyYO/g7cjw4EFuz84zGMpo1WugWXKtFc=;
 b=ls0uZoBDK4PI6sdM3BpMVyZw0qaeVCopJQL+/WvbTSOb05rsrb07sz4bWNii55dQuY
 KNQDaE0aiZoKcBH9HRCisxFym+amq13sex8mrkBJqvYivYEVj6TxE4tnFSnpiXV8B3jY
 AVhGG5I60MY1EbtHp0XTSaVxAeAy8FXkhs44G5jLtALx9mPzkx72mNwTeSPYqJzc++HN
 DPSiW6zIEHuaggU0nsN8rfBSR9hpCnXqc1SWYLEdxGr3XuutY6D0jykCCMekAGZXyp0F
 794iMdB4mRtQiRz0Nbkd7gLGNiUE+OIfIONvZRbLdHMF7642aFWlIvZp7hodeXygEM5i
 zQUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzm2ZIGUV56OK7v+VaccBc/bISx1bvtFSciBhaQSgT/9aM4JN9WOnlwYwSQkZGIlD3cawT5c2xAGcSwqUFvocaANppfw==
X-Gm-Message-State: AOJu0YydElhCDFno+DO3PvYOHKnMGFT3WWXW0KYweqJ/Bh+KD8JH6Ozt
 jm0icXYm648J2cJsLOIaesmovk2Ur50eJv98Y/ua4nXpuWgne00j
X-Google-Smtp-Source: AGHT+IFk+I1KNp9GHaAFMrdb+ubKLFgZrUm0T+ftmTu08ZXqqmQ+sz+/wRcHx0xoCGrJRgdxeYjwtQ==
X-Received: by 2002:a7b:c846:0:b0:426:6f17:531 with SMTP id
 5b1f17b1804b1-428e6afe872mr30333915e9.13.1722628132873; 
 Fri, 02 Aug 2024 12:48:52 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428ebbe18c0sm24827455e9.17.2024.08.02.12.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:48:52 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/5] clk: mediatek: mt7623: split clk tree to dedicated
 topckgen and apmixed
Date: Fri,  2 Aug 2024 15:45:02 +0200
Message-ID: <20240802134511.23608-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802134511.23608-1-ansuelsmth@gmail.com>
References: <20240802134511.23608-1-ansuelsmth@gmail.com>
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

Split clk tree to dedicated topckgen and apmixed in preparation for
remap table.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7623.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 4be914c8297..79936f1803d 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -739,12 +739,15 @@ static const struct mtk_gate hif_cgs[] = {
 	GATE_ETH_HIF1(CLK_HIFSYS_PCIE2, CLK_TOP_ETHPLL_500M, 26),
 };
 
-static const struct mtk_clk_tree mt7623_clk_tree = {
-	.xtal_rate = 26 * MHZ,
+static const struct mtk_clk_tree mt7623_apmixedsys_clk_tree = {
 	.xtal2_rate = 26 * MHZ,
+	.plls = apmixed_plls,
+};
+
+static const struct mtk_clk_tree mt7623_topckgen_clk_tree = {
+	.xtal_rate = 26 * MHZ,
 	.fdivs_offs = CLK_TOP_SYSPLL,
 	.muxes_offs = CLK_TOP_AXI_SEL,
-	.plls = apmixed_plls,
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,
@@ -769,7 +772,7 @@ static int mt7623_apmixedsys_probe(struct udevice *dev)
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	ret = mtk_common_clk_init(dev, &mt7623_clk_tree);
+	ret = mtk_common_clk_init(dev, &mt7623_apmixedsys_clk_tree);
 	if (ret)
 		return ret;
 
@@ -783,27 +786,31 @@ static int mt7623_apmixedsys_probe(struct udevice *dev)
 
 static int mt7623_topckgen_probe(struct udevice *dev)
 {
-	return mtk_common_clk_init(dev, &mt7623_clk_tree);
+	return mtk_common_clk_init(dev, &mt7623_topckgen_clk_tree);
 }
 
 static int mt7623_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_tree, infra_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7623_topckgen_clk_tree,
+					infra_cgs);
 }
 
 static int mt7623_pericfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_tree, peri_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7623_topckgen_clk_tree,
+					peri_cgs);
 }
 
 static int mt7623_hifsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_tree, hif_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7623_topckgen_clk_tree,
+					hif_cgs);
 }
 
 static int mt7623_ethsys_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7623_clk_tree, eth_cgs);
+	return mtk_common_clk_gate_init(dev, &mt7623_topckgen_clk_tree,
+					eth_cgs);
 }
 
 static int mt7623_ethsys_hifsys_bind(struct udevice *dev)
-- 
2.45.2

