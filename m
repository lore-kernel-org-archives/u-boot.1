Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DB8C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B81E88444;
	Wed,  5 Jun 2024 21:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bTQfjFfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBAC187F39; Wed,  5 Jun 2024 21:03:57 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC7D88261
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4214fe0067fso2169665e9.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614235; x=1718219035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F97OdxFh7m7etkRsVtKsfGsLMsJwZFYqELX6uCo4BS8=;
 b=bTQfjFfmlQ3VBJT5s7wqWW8rajgUQCVfhdDIGM08d6sNBaYNeB6uRjRGm4ExVUozAS
 VPWzLbDtKLSPZy7lF0z+7PwGnggt5ro7dJXDTbmKzZc2KWtjgLpiGmySCxt+gP4jwqh2
 /b+9aW9GrI90Ow4m7J42z/TVyUw2Vovc+Fr4PLb4o9DGwfL1i5BJGuxxItNHNkoPRmva
 9x/1uwh78PvI1DNtXCKybSv24BuQijvEeLjzrX3TrgLem60OkH2DJg5h/EMA6PYFFh2+
 e3nyh+B2b6C68GSKZJHlFEjdEjWYXSTPrKCWP5/q+zVlg6U36KjY1vveVOUdvfxS3aVS
 Zt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614235; x=1718219035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F97OdxFh7m7etkRsVtKsfGsLMsJwZFYqELX6uCo4BS8=;
 b=X3jRMBY4cqoX/ZqJgoaT8968lR7wpsTCqrCuJYAddFb3h0RPmhvgFX/8jkuvNi4amW
 OTEDEDs7Gwm/wSzqeRVJwxAHwHVvlMWSUFrYzurNZ2KMvk+04bmM6X9Bonx9xbPCYHzn
 IiNJnID8655t8lndy+VplKhOME+skvpb/1ytoIkknQvDHIUHSzqmGdxCwy3oHqe/pW/n
 YbMRt5gWRTCglAtiTk4kwvoGWkl5lh4tdu50OiROU4QmvY4hEaOBpudOU1/pF0TaKRNM
 oQxXncDviPlvZUZRyqGrkUnSem97StK7NvnXbskkFkvXxs+9Nx77IdxAu7ynuOVYlgvG
 AwBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnLYM/OWCyS6yJY+BTrWaNZTlfsd5w0Gz5viZjwA0lF9RWpyjeqnO+EHVS347rsUQNF58ZZXM6yOFgo+0Oc80bTbggeA==
X-Gm-Message-State: AOJu0YxQc+OXHiU4WD/j1emMhbBqsk7/manY+0HvPWkvV34zlOb6fJUv
 5W+bg099Gff2stibSjenK2TTnuj0oPO8RdiGupfqoZHBR0mAJ9HS
X-Google-Smtp-Source: AGHT+IH7elCSkrK7K5AzBlYfE0Q/FitrF2CuJO+1sf2f6VBB34P2xKV8/5h0vSiu0qpaLwwy33tQSw==
X-Received: by 2002:a05:600c:5492:b0:418:fe93:22d0 with SMTP id
 5b1f17b1804b1-421562cf4dcmr29678985e9.11.1717614234983; 
 Wed, 05 Jun 2024 12:03:54 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:54 -0700 (PDT)
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
Subject: [PATCH 10/11] pinctrl: mediatek: add support for gpio-controller
 property in root node
Date: Wed,  5 Jun 2024 21:02:17 +0200
Message-ID: <20240605190220.17616-11-ansuelsmth@gmail.com>
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

Add support for gpio-controller property in root pinctrl node.
This is to follow upstream linux DTSI that doesn't define the
gpio-controller and cells in dedicated nodes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 0baef57c1c2..7465e236bc8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -762,6 +762,15 @@ static int mtk_gpiochip_register(struct udevice *parent)
 	if (!drv)
 		return -ENOENT;
 
+	/*
+	 * Support upstream linux DTSI that define gpio-controller
+	 * in the root node (instead of a dedicated subnode)
+	 */
+	if (dev_read_bool(dev, "gpio-controller")) {
+		node = dev_ofnode(parent);
+		goto bind;
+	}
+
 	ret = -ENOENT;
 	dev_for_each_subnode(node, parent)
 		if (ofnode_read_bool(node, "gpio-controller")) {
@@ -772,6 +781,7 @@ static int mtk_gpiochip_register(struct udevice *parent)
 	if (ret)
 		return ret;
 
+bind:
 	ret = device_bind_with_driver_data(parent, &mtk_gpio_driver,
 					   "mediatek_gpio", 0, node,
 					   &dev);
-- 
2.43.0

