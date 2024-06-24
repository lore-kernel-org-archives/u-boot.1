Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21656C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2072588580;
	Mon, 24 Jun 2024 23:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DLfU5cI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7E888859F; Mon, 24 Jun 2024 23:04:45 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C943D88405
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-421cd1e5f93so36771595e9.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263083; x=1719867883; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p9v9DjB0A3JjR41lueuEJ6VMkIeEOYx0CJAcYGaKU9c=;
 b=DLfU5cI8eMTie4P+KFwH6U5MgLpE3PHdRNzttlbCdTBq8WBukWSSf2fiIIJmoco1RU
 o0bjWBKOhSpv/Zq2sKz9hUoKgmiNs+Q5K92r3eCgyBGV8VhSEgw+bdqOrAn65HXAIFcn
 9oUcSA1e09OFlmVO7viG6laYCZHq/9bmjrqbTnO1u4sRsbchBbPJZphrj8FcVQoiqP9n
 DafnR9+j3LM/OovKlTyQy2CyIZjWs+KItd6zUGq9y03ttErLeoF9UbuY1dQPoUtgPBHA
 uDV28I4hOU9Fw6Da8qABNvrC5jbTPsRK+Rwox2nMxJ4PoIb0OgexvBytsFr+tdZHQbPb
 1oVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263083; x=1719867883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9v9DjB0A3JjR41lueuEJ6VMkIeEOYx0CJAcYGaKU9c=;
 b=ft4AP3q0HBAGMCVdfCjq+lscyGFjNLMY13DVKGAE2CI8oZNxY/6TaAeuoFEuXZLaZK
 spUBi5IMt1iOqa4Vq3joHYBfathyPj5D4e43juJjGgW7WnDdaxt9IXuRd5HhE4o/Y90h
 J586mcC+JDx4eb+kRSh7gCeUz8fm17GvcKuO1jS5WIxF+mMs/9G3OoAzLFBivkJUVR+S
 h+JdHZh1lKMZ9szp4c2q01HxNuaG0qLUarci2NocLXBzv0NKK4zZseERmaxbnJu6Ws1X
 gpUBO0ccjyZ6DySXQJa3h8isHhxFeqfIF6t0AaNi2z6KG0vUoU9QsgVhp7IHSscrcd8I
 aKAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWArdMazOHIPK+9Zk74daSW0voVjuoLY/G7/b7wTEmxgGvRs93Vh44QSMJBl1Dje7sK+zs4SmpxsvN/2ijt9fzSijw1Yw==
X-Gm-Message-State: AOJu0Yx1PhgsmZ8wuomgduQe/fivSZwG8+sa04hK5Jbq5IbZx/fLNxV3
 PPPnE49wLpFl6sPJqt0zI7RL/LrQZRIDjBIytN657PMjDu5+iul/
X-Google-Smtp-Source: AGHT+IEdll3ZIQ4UlK4nyoJqHel8df4FI0sY9fsgaskL4AV57MvlzxnQpreDjmV0eHHt3ApD0mrIFQ==
X-Received: by 2002:a05:600c:6b19:b0:424:918c:3f5b with SMTP id
 5b1f17b1804b1-424918c6d91mr28685895e9.29.1719263083214; 
 Mon, 24 Jun 2024 14:04:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:42 -0700 (PDT)
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
Subject: [PATCH v4 11/14] pinctrl: mediatek: mt7981: init device before
 relocation
Date: Mon, 24 Jun 2024 23:03:37 +0200
Message-ID: <20240624210418.19324-12-ansuelsmth@gmail.com>
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

Upstream kernel linux define pinctrl for uart0, hence this pin group
and pinctrl driver is needed before relocation. Add DM_FLAG_PRE_RELOC
flag to init and mute mtk_serial error on early serial init.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 3fa198ed79c..4bc4abe6518 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -1050,4 +1050,5 @@ U_BOOT_DRIVER(mt7981_pinctrl) = {
 	.ops = &mtk_pinctrl_ops,
 	.probe = mtk_pinctrl_mt7981_probe,
 	.priv_auto = sizeof(struct mtk_pinctrl_priv),
+	.flags = DM_FLAG_PRE_RELOC,
 };
-- 
2.45.1

