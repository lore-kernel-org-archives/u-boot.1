Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF2FC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FD3884A7;
	Wed,  5 Jun 2024 21:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PODP7UGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1BF98825E; Wed,  5 Jun 2024 21:03:59 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3FBB88263
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e78fe9fc2bso2263431fa.3
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614237; x=1718219037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xFqKPNJ72o9/wknPsjhm4e1xJFjgwdxeCZsRwZeeCQA=;
 b=PODP7UGthzUbX0KzS+P0lP3byTsUNMsno9xf/N5k8BQCaX+PKHUDjCSI3peTAE07qZ
 r05hejpds8MjNVgNFxB26NDu3M/3bVN3OkF7MJy4QeT9Xph2hTMRqtw1VQNrrkglGJvZ
 KG9LrtVa8VuInoxkh6E+2wzyL+97ZIX4Z7luuyRgV4sI9NCtQxumjW2sLe1KIXn+nnRg
 8TMH61nSN0JTc8q4RtHjY0as+pz5w3YAC4BiRGrFWmX15IxQOR9Me/65eBsAWiTFSsiE
 ncyKMHqttXCfxvqtOGjBUZOpD/sdy30VGjiBbbk/VBFC/An2smrwOEgZkk1lv9XqQZ0x
 VpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614237; x=1718219037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFqKPNJ72o9/wknPsjhm4e1xJFjgwdxeCZsRwZeeCQA=;
 b=b5NtnDw0cOKEc85+nLMqs7jHUnJOFHWEO0o302GHiI3yraPL2uxzboql0mPQt/WE1g
 RyAWwsqjyMa5PEN78XbPfXgk1Y7J6ZwxOq1/ETZsSaA9z51ngmY5q2mxnPQsXNORpv8h
 n436sQtmeEPdi6l4QywToa84D31dDMP7e+YJ9wDylB/6S4wjowMhmg5JFtEXqqxGjTIC
 WLE2KurKxcssDJS5bGipHcuexpoaMnWe0nRTgILUD0l8tq2YFy1I2Ge7J4i9nlueD28v
 RzG3vWAhKIT40UrYcRis9hsn4vFElG+AvzhaFP3yxq85+yMwbhvyW2JIrEav/EJtPE9A
 1vZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWHCNY19kOmx7p2SHiti+peCjX5rWFi9hJk0er11e1DIxeBdVRIiFPBYXG7k8acaB5BSgw+lt97hCtoQWsXQHW9Osy8Q==
X-Gm-Message-State: AOJu0YwPnxWMlZJRw1dwpHS1Qr/4vD2r6GVeyCyqtEkKmSqYM6PT4mlb
 G2o5dOD1DG6dL8En98zGfl25rSIDPNgXPE0F71HY9TCBKfMbu7Cv
X-Google-Smtp-Source: AGHT+IEy8n/tE0TG59QmyZAReCnKOf7JreZz9kwfLrqAHivriYXqvXtDnMyrQs7pDEe9O43411bxjw==
X-Received: by 2002:a2e:8649:0:b0:2e9:8374:3820 with SMTP id
 38308e7fff4ca-2eac7a6af02mr19239411fa.40.1717614236735; 
 Wed, 05 Jun 2024 12:03:56 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:56 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 Francois Berder <fberder@outlook.fr>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Michal Simek <michal.simek@amd.com>, John Crispin <john@phrozen.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mason Huo <mason.huo@starfivetech.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Sergei Antonov <saproj@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 11/11] pinctrl: mediatek: mt7981: init device before relocation
Date: Wed,  5 Jun 2024 21:02:18 +0200
Message-ID: <20240605190220.17616-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605190220.17616-1-ansuelsmth@gmail.com>
References: <20240605190220.17616-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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
2.43.0

