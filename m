Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C74E9A03B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 23:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B22A883D5D;
	Wed, 18 Feb 2026 00:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qd/x0Zl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A3483D3D; Wed, 18 Feb 2026 00:31:16 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970AC83C72
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 00:31:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d18c654458so1941244a34.3
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 15:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771371072; x=1771975872;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KMjGYCYY9bPtG97Hit2lBTixy+BMK5/67t+iVUpfbIU=;
 b=qd/x0Zl2beqaYZk1fkvnNsXlgIjaKvX4V48bB6LVB4weXDegOWnBgdKXkIfwgQt8S1
 URfyUfVewyHh2HScpuHMJOqnCQXjyu9asdXdeEZQiYI1alezacEwEmhUD1JB7vkMleOD
 zB/yDakSQU7TBBQ0mNt+KFitRuwyJS22Xcgw1byNEoqw1S5oJqkbdgl/hyhL29rF1Dve
 lUyYN4t/2SKFBnwcgjp2tdOsA6JYhdVpcPmoy0oNgwMipb4wZLnGptDytV88s8VjCbOn
 erG6LMqm36mtQNnyOsLBC/V32zjgcPTeaLEaLxqSjgM7EuJaDGeX2jQ118nVKzHzVNlb
 nBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771371072; x=1771975872;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KMjGYCYY9bPtG97Hit2lBTixy+BMK5/67t+iVUpfbIU=;
 b=N4lL3G8PuOWavSigX+ETp+UTzqAHX97dFLUnmwkdHRz7iDtgOapy2g//0jWMQqaRP4
 csq7OnuJhqHg96licydwS92SqvBtp/7YEdEiYBhae9xvZquL/epDCzRPr4zyL88DowBv
 Q9Wl+iBGQJ863rhj2RHZ+3ZDgi2VWlggImuP5TqjbMXFQUnQf7xJhqUwhyM2jlXlaA/h
 NeQAcIgHm9B+Wd+pGOG3U7n4+zo5mqEFH8mkVL1vfaoZAKX08CDE5KDrL0thRZri/Osf
 D4omKR7eV45y4VaZyKQix5kLiL3j62OhwThiZ67VQ96stVM2PM44Q+2OaVVAgIgXJY7w
 02vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxB9OtRyvtD6LF95Sqo6vRo1dJfv9u+LM9bGZ4RXJZYIkc0NwwQXKra1O4H1s5I5wCz5jf9EY=@lists.denx.de
X-Gm-Message-State: AOJu0YxpnoPXyhjyZVum5sikMwzYq2y/Z3xMelzxv/770cPEoF8L+Bsg
 vlgpULEGJ+1avo0XLtPywjeRZ9vXdozJIm85+X+h8LM1uvA4eIQ5Jz1TCDK948cd+Y8=
X-Gm-Gg: AZuq6aLtq6J4CGsD5L8HavZJy0dUD/mYRd2U6z0Dv/LuoPOy1CJnwF7bRplzqvIdbNa
 HobYOQXd0+BR6TCtx8Lv0Tc9GTkAx/G35PaZdBMfXchKCu2oF4RNKLkXmiVHEMfGImuewqElGgo
 gZg5h4t/yQplaHyG2+Ue7TBRjgFQJtU7erWEiqyFesS3sK3562gas+fmZlJi/FY5MyNAfcffQcX
 M9ZLFNOBBm8z9Rn1RAxIxY70uXpNHN8lkNX8P0bp/hZ2lDclKiWB7+YVU2dWe7W3cv4rtY7cLL2
 jfLMt7IvlTHxlkNVHklIOKGdIKf2WhBQbMVST6amUxCb0SPgU75503qA7+DUrnNi2bYxMjUpTkx
 qiKbBZnPDrJ6vPUnyfqkHxw1ZwGQYDICdZxEgdUjfDSJ0tZbsvtyMgglVB6b8h0JzoN64XpZOjc
 xhftjrLbtM8uEB5/TQhfx3kTjgoLqYabOVt9Ks
X-Received: by 2002:a05:6830:9ca:b0:7cf:d191:2a50 with SMTP id
 46e09a7af769-7d4c4a3f6c6mr7708523a34.13.1771371072328; 
 Tue, 17 Feb 2026 15:31:12 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8c6:5b3:8109:1f08])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c7288d34sm11122198a34.18.2026.02.17.15.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 15:31:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Feb 2026 17:30:08 -0600
Subject: [PATCH v2 1/7] clk: mediatek: use correct struct type for infrasys
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-mtk-mt8189-clocks-v2-1-cd381cd05251@baylibre.com>
References: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
In-Reply-To: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBplPoQt16YDC2pjfXZ58riCbzrOMlrGE+DXC9VL
 abHh++GkTmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZT6EBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALXEH/1I3+PpEt7ruBKRG40SIpQYAyd2MiaP52LLKW6q
 j3HhWz2jCKiaY1ppD32xDCtn/ilKnRMlpxsMJ222w8I3Kcj6MgCgmgbiaoQdhPlLpGB6B2RqJgU
 v4wqKqM0JOcaUDWlEOS1Xc3dO77Z+QooKeew2EHK/vEj10C4HdopO4xIoxpPI9Ivzvr5FbRRzT9
 2pf9eySTVr8QG7M0V/dglKFyTSEYZHzEQ/aXWkvM2Wb0WRWpHf3EGz3G7IOcIEMrGKQhdUq5L4g
 JerbmZ8c35lF5yIKcsMgt3kpxVgNuQg7t35lnSVYtjNThfMK8FYVS7raHUQUCgWpmiIGdvMRq2a
 jCHI=
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

