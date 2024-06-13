Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F327AC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87DBE88931;
	Thu, 13 Jun 2024 14:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fNwLlnnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7EF7888FC; Thu, 13 Jun 2024 13:10:32 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B78888EB
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6267778b3aso78580966b.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277030; x=1718881830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F97OdxFh7m7etkRsVtKsfGsLMsJwZFYqELX6uCo4BS8=;
 b=fNwLlnnZ2Hq53YUDfvwXE/+ud8nk0gzgkZl0gtzhZQOMXN39bEj5kiUNu4TBQ37MwB
 2LCk0XjM91BwBk3z1/5C/BMlJUK/8SF3opm3ZYLyftZCTZnwfRqkIreWhrILPG1fBqSY
 O1xXKeq5jO29v/ELSeLerg7H+jNcSxFhOglR0Zn2KVpNqhXd5CjIQmTJdL27et1600MX
 sg+GhrHHdlyz/LDIlQzO6YIr44MG3kkJqmoLr4vITeQRCNtoI9PlLn/WsPCDyCyU3cDv
 UTdZSgkTAKRWPyIAIo8f8UtgTQF/d30mBZPCqi+eapUQnTFtxz2hnaqnYMpeQVIquVa9
 17/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277030; x=1718881830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F97OdxFh7m7etkRsVtKsfGsLMsJwZFYqELX6uCo4BS8=;
 b=jPn8UQsnrmRyyoRBIj6xYJT6eqyTaiT1CYNiv+VsUluRM/i7chngcgC9DMs/1KPcB0
 N1XMk8eO8b1uVmzSqNrmeB7LtoLN2JrrajS+6CUSvJuinYs1NpVUf77Ukb5CGSrZu7LT
 kcfFCMCGb2MzbAqtQ3DCLDpGQoD1NkiEPTL99ltTnzE6FNzFspahizQEf85HcpApZmYV
 H/QTRbCma1Lg5rSl9zvjwfZmMT+/ifXmNDZP9lrl9AjHYeSPqJ8EGIodrNYDMk2/HSgC
 eV4SZvkBioUHytX3IfM7Tz8MeqGvQK0boAC9CzSJ8k/KOZPCl4bJR9L8OCreVGBLE47i
 D9+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXs3HvA7DkIyFWrvlWZ0qh1t1zp7TVgGFWwIFh3oO79iVGQ9c5xZTEezNqVN2gJEhUOcGbMH1J2tlq9dscJzVYj19jIA==
X-Gm-Message-State: AOJu0Ywy+A16Pb+3/rYxAXjPC2ONrHz5vxQZ7G1wbHaS6g9m+7HO53+L
 HxlfOhbcGNPJCVooepsy/vDwslJ0LRLru1BuRd1eI+J2PoAxfIzz
X-Google-Smtp-Source: AGHT+IGrIp0gWNGksNjuIInMvUkCr1YDYlUnholzFrgC/WA4E9IgW/Z4BjMjEDqMY4lqPyw29daH3g==
X-Received: by 2002:a17:906:aada:b0:a6e:fb3a:b661 with SMTP id
 a640c23a62f3a-a6f4801bf90mr273831166b.68.1718277030230; 
 Thu, 13 Jun 2024 04:10:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:29 -0700 (PDT)
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
Subject: [PATCH v2 10/14] pinctrl: mediatek: add support for gpio-controller
 property in root node
Date: Thu, 13 Jun 2024 13:09:28 +0200
Message-ID: <20240613110949.11076-11-ansuelsmth@gmail.com>
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

