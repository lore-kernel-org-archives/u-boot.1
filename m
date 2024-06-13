Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCE7C27C75
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC5F8891E;
	Thu, 13 Jun 2024 14:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V54Bqc5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B0D888D1; Thu, 13 Jun 2024 13:10:30 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A5F888EB
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6f1c4800easo108903466b.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277028; x=1718881828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+mEXw7F2lJQQgW+4oCLpZWuN1JwwLw7u8qEl078/N1E=;
 b=V54Bqc5UD7jILXRTpcJu3OpCnkTezDkQvStZmSFy3syH4m0vYNDOPu3btoABxCPBf9
 wVtYSZoMeks1y/hE6VQavkiugBgvRT65SulQZCUMvKhUyZDD7Tbet1RrGSOTPNjlekIM
 JNAu5dcHoCo9LL1RHd4FA1AwDdkMYeI7Vv/JxET9xNXh5ckuX+uUwHCpMXf7goJ4ZqF4
 kUdECQiOGY4QP8p5NWi+xsAKL+G3aQ3OhYswP5WAB7BShRYvLHpQSPlN6cR8gnvHjGkS
 aN156V5J6plOcR9Tj9E/Ya0549WxEic3J2n2HSwqHpECv+DovP8o/QaoogY9VoVvp2u0
 Eusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277028; x=1718881828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mEXw7F2lJQQgW+4oCLpZWuN1JwwLw7u8qEl078/N1E=;
 b=L2Lq1RuMvMmHSa4AD6lwg3hUofvlew+zJp+Bs9MkdON1ZsM33O14ZtXEGWvfVcTYgv
 AuYO3ybhO5wf75mWKLFvt0pB/gervaiaRMgfElhxcp/VLAfsPYHV/A92X7Lhc/KFjvAg
 bYd2LjTc0ED33hMaRrVga0NUDxcjHPu8lNhBh0jqkbRb8OjnNrolpBffLFROJ5mgTJNK
 JRr5r+MMJNf3CWcRxM4CsetLk8BrNwsGpXfRktzLgRHEQYF2s+wvkd/vDJDwRp7fkdiK
 yP0HIESK3cYwk21MOj27uSONXHIffSwvETrZndBS25p2qkpmuPbGX84BgY4i2g+OJ2l3
 qdHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWN8VFNvod5YqV4CUbF9R/P2luVAiP4Tw7EHalAiBPbfUAO6VncN0nbzM1e/B/dbry2iRnUIfewRKBsrzGZxbz8ZayNA==
X-Gm-Message-State: AOJu0YzgAF3D7dVHQQFL3F9r9J87gwNulXY4IXWfOBSkQ6V7BolLGxfk
 IG+sToImJ3W0Ayk7gp0sDwSpt3pEIghOpoBzmAq2ZYii84Rr20EW
X-Google-Smtp-Source: AGHT+IF9DFB3OsBM0QccNoafPzKxukCene5Kzvg/2ePEeyBzESJbsfLWyXR6eCB1TyWmUGzE4Gx29g==
X-Received: by 2002:a17:906:a199:b0:a68:ece7:8db5 with SMTP id
 a640c23a62f3a-a6f47d36429mr262342866b.31.1718277028348; 
 Thu, 13 Jun 2024 04:10:28 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:28 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Stefan Roese <sr@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 09/14] clk: mediatek: mt7981: support alternative
 compatible for fixed-plls
Date: Thu, 13 Jun 2024 13:09:27 +0200
Message-ID: <20240613110949.11076-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613110949.11076-1-ansuelsmth@gmail.com>
References: <20240613110949.11076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:43:53 +0200
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
the compatible mediatek,mt7981-apmixedsys.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 7fcb81419cd..13dc3df0e9e 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -543,6 +543,7 @@ static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
 
 static const struct udevice_id mt7981_fixed_pll_compat[] = {
 	{ .compatible = "mediatek,mt7981-fixed-plls" },
+	{ .compatible = "mediatek,mt7981-apmixedsys" },
 	{}
 };
 
-- 
2.43.0

