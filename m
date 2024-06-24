Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58083C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01416883CD;
	Mon, 24 Jun 2024 23:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="awmd8F82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67BE88859A; Mon, 24 Jun 2024 23:04:49 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD9AE884B2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-362b32fbb3bso3238454f8f.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263086; x=1719867886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ouaA9glpsw4lLaDiPHKMwtMgf9xQnvqTg2ZrILZg59k=;
 b=awmd8F82kYvu+1iCJVC31m49rrcv6kxxASz7oULlijkNREjQE3wwM1VuJYNFuvta75
 ZGgqnPfKBpVPYkvPHU3x7EH48MbE0W+7crd1zzXN8wZ8Je0pHzRsCIIG3QzlQfqy4ppK
 vqibaHsSTfR0Qaxu2Nm4nseL9h+8USfu42FvJMzXOREs6XlUUQRkdf3qj6Uurqps+koZ
 rvQC4VGs/kOLr8mq3njFii2TKooF9NJWlqS82nRjCv+TDxYcfKjNr4zVYnkB34zX/942
 J+iLiOXcvevI7sVOTSpdSFoTT1hzqKiokZbToIoDod32Du3dLA2N+sOmIOVfjRPWW3Mn
 lLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263086; x=1719867886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouaA9glpsw4lLaDiPHKMwtMgf9xQnvqTg2ZrILZg59k=;
 b=J5BuGkhPRcq31tBrsh47oiawy3+3GwTtFCsE1dXAlrFvV7tIyFPsUxK32smAvUtIEb
 1SbJ4I6Ock/PJf/qta6gTp/sY8mvsh2vnwsZC4XF7STRypHTozEPtG4uGncGi4V9F4xc
 mav7RYsMci/U9b/4HvFaFQnqBSTQlDXwPjBSu+xKVdoPA/9ItuuApJWDjCEGhvptoJRQ
 hueTnPjYYawnIyvCkRgyQLuPi2PVG659jO5dgxS0UwQQQKd0Z1Uc6pXFuGuDeENBMQfu
 UeGzQZ264wvtakuJ/AOlXHGDoK/Vg/WjNB55nj/srO8HmG0RVU5MNak+KDSZ9PLqL9l2
 TzdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwtbEQBvSYFHY7J9aK5q/6rphcAjpuRnvUVPG5qHEWwKWMJEJG4mH6vKbFxcl5UF3pZ0B1QLIdIhOkTCOr150yE1ZmAg==
X-Gm-Message-State: AOJu0YxFUfOZo3ghjXSoMkoggBpUCbok8Nw1B5duRW1w7AN0WPfMISdg
 8QYPLAWQeuD9b64zeCU1wUc/8XYeP+CBtnYYtrb2yW4Xg8xswOLx
X-Google-Smtp-Source: AGHT+IF3b+SXU/1zS9OhMwz6qaG8BpAoP4TChH+UBuHyb0/okE05aaXUfJq+14GlIHEu6Fy3fkeiJg==
X-Received: by 2002:adf:f48d:0:b0:35f:2547:6be6 with SMTP id
 ffacd0b85a97d-366e7a1a128mr4410777f8f.21.1719263086248; 
 Mon, 24 Jun 2024 14:04:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:45 -0700 (PDT)
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
Subject: [PATCH v4 13/14] clk: mediatek: mt7988: support alternative
 compatible for fixed-plls
Date: Mon, 24 Jun 2024 23:03:39 +0200
Message-ID: <20240624210418.19324-14-ansuelsmth@gmail.com>
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
the compatible mediatek,mt7988-apmixedsys.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 34e7b2d734c..32b04511781 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -833,6 +833,7 @@ static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
 
 static const struct udevice_id mt7988_fixed_pll_compat[] = {
 	{ .compatible = "mediatek,mt7988-fixed-plls" },
+	{ .compatible = "mediatek,mt7988-apmixedsys" },
 	{}
 };
 
-- 
2.45.1

