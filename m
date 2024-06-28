Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C6EC30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F7388614;
	Fri, 28 Jun 2024 19:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d7tLUxlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6589188591; Fri, 28 Jun 2024 19:41:50 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68801885A2
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42564a0d3ceso5977245e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596507; x=1720201307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCPESFVYZLx8pfHCBntDeROE12ytBprwJWjQJawmqUY=;
 b=d7tLUxlt9gfgrOL5itrAgRwWpMuAO9RU5xkl1BOIRYt3zyDWzHdQzSyK4WvK/fRywA
 T1syKitEb3Nn2thpIjSbln2ev9FtPP6NNOwzxnmy+m7FXHAb+ln9kLYPI274fOJtrNte
 ay6tCWHvjwfRjG4F7R2vOhNqvGtRNs5MKYly9JCNK5+Dy+26yIfeFr4sSkLKLxaPCLPC
 L2lFmGICq7b437CVXbKoERRzANFfnrgajwk6kY2PBfo/gYhiqlOC43GqbTGhJAxwz3d3
 J31aUUGc+HdsHhh3dMPG14ZOCRxoKha8BTKNiboJ04/FQbJzyTWEcJFUByvUYekpgupC
 UqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596507; x=1720201307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NCPESFVYZLx8pfHCBntDeROE12ytBprwJWjQJawmqUY=;
 b=r4RvyClOaZReMgqxW+UIotodRXbq+8fOzRJkLSPwIhO3TZMRpF2GOmh6BrRpcZrwCP
 SWRe1V9W8Hi4F+OvxMYhV8fxaig1o5EYKPj80TooCGukRdXaKIbhJzOO0Ffnm0vARp7T
 2Qfs7v0FUytmzwk6l5h605pN/DQPaAa0Y+Rp6/4LaIRtQtNSlJaGC0t4KlRIV05D46o6
 9WJpCXjTZjkREGetw2KUe0zDlzNaeF9wmVhKSGAIzQtPbcJv2MlOiF8By+XnKHxhmUZ8
 n/BjRLk8WvcUmLbszmPmMjd771zTKhRKzw/AwFkxK6Gd0LCEaTQiVmNEYTpQQoXE3og0
 HMfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1uqREpVtCdNlS8TPQXvos/9i3q6XjzaIfWtBkkSx5n2CFXIbKJIBMQgTqQn/KkhZOkWo5gtj3FwXOjPTUaXsGy3k0MA==
X-Gm-Message-State: AOJu0YxZt0cp5qhvzlwB8QOyh++jnN4y8AUNhIFqatv5dm3F77XgT3eu
 /A1QXBBt6fK6yZDVNrWJ8t+h5AEEgri0/lD3T3qp18CnOCEUnALBt5kIRA==
X-Google-Smtp-Source: AGHT+IENHQoO08xIlHW+iXT68F8N6bI6vnPyoZYtMBOgxrxfvEJv+9CP0aunXEVLRYAMVn5+rgfQUw==
X-Received: by 2002:a05:600c:2d55:b0:424:a319:6b46 with SMTP id
 5b1f17b1804b1-424a3196b9fmr74526035e9.18.1719596506808; 
 Fri, 28 Jun 2024 10:41:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:46 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 12/12] clk: mediatek: add support for APMIXED parent in infra
 MUX
Date: Fri, 28 Jun 2024 19:40:57 +0200
Message-ID: <20240628174114.8675-13-ansuelsmth@gmail.com>
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

Add support for APMIXED parent in infra MUX. This is the case for mt7622
that reference APMIXED parents for the MUX1_SEL clock.

We assume the second level parent is always APMIXED.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index c1d171624b9..66683aeb2d7 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -488,6 +488,10 @@ static ulong mtk_find_parent_rate(struct mtk_clk_priv *priv, struct clk *clk,
 	switch (flags & CLK_PARENT_MASK) {
 	case CLK_PARENT_XTAL:
 		return priv->tree->xtal_rate;
+	/* Assume the second level parent is always APMIXED */
+	case CLK_PARENT_APMIXED:
+		priv = dev_get_priv(priv->parent);
+		fallthrough;
 	case CLK_PARENT_TOPCKGEN:
 		return mtk_clk_find_parent_rate(clk, parent, priv->parent);
 	default:
-- 
2.45.1

