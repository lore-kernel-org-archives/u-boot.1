Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A38C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2822884E5;
	Mon, 24 Jun 2024 23:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gm6IIyBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72FCF88571; Mon, 24 Jun 2024 23:04:44 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4809D8856F
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3636c572257so4165026f8f.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263081; x=1719867881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w4Z6k25VmjJ/5gBe1HIH9Q6FQ1XcQCG/0govOuSh6MI=;
 b=Gm6IIyBAXXWW6tnOxXiyzqUmdSWv29+zVLDeTeuBFN1GboQq9V1QM5Y7ZvCsjtCnSF
 m7J4pkyUD8o7qwjJPy5IGX89oDnRpj5b/z+YmmEcikREtcnX+4R/T3FDNjNLnroi6nwQ
 TnvW461tA12r96kYcQTn6iM3qmUKMHw8l8UqBA/fRQyrtGscqeKPPwrn4ox5DJMzXe3Z
 4Jq/3buL512zOkOx/rLNH+bFBcrnGpRrwuDErKDADlz0YsDPYE+rfRR23aHLA5Br42Vi
 hGCIoeJk44r3mN00VGoFZTlhMFXGSbbdnXJm3LeWcu41vIzaGmFfUHj53vjeGkUizQC+
 4VCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263081; x=1719867881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w4Z6k25VmjJ/5gBe1HIH9Q6FQ1XcQCG/0govOuSh6MI=;
 b=Oz6r1+aovxL6OVmbPjoa9gssjOK5mOgQHiTXMki+Q4i4EbKh4RiHpPM9Z4FeUZF889
 As4AD5ZkzV0iV5CtTI+phdU3y5NJMnr+w3ftIEyatVFY6aKMMGO/SsWUJnqU30Qms0F9
 NSzfUzw63aSef1Z/dX9JVqid86627eHpDI2pKZfYRIS6qLXoTaJFj6X6GW2B2dtRwcBn
 xHV1jtSKZ6IIuCEFMAnRpn7SPCwaFbGanUhgdlF94sxt8lj9OQplqjvWUwXmpKKRea+P
 SrN3f+Yesqz4PATDxnwPcZXr0IWR8QGKtG078XqJjQ4pxMHHntljSS98fbZtdhrdnr+B
 MjKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsDlbMbesSP65JpRPh0qAliyO0y0CCKMLikaQclXVfzoZ3JnPKquaMD3y7sfYdXqWc4Bc3bJV5KxpjjZKNXJFYNFlT9w==
X-Gm-Message-State: AOJu0YzZU+AKIC8uyeuPC8OrYR+pPVB8iXJ1SBRbON39X01M085vp5af
 klxbvBsWG9mmlLrkH2cii593CDeaPI5SmcQ7YsQwiAsxCL6w1gzG
X-Google-Smtp-Source: AGHT+IG8a1ZxmiU3g5rTDZdX3RBZCGaPe3ghStjgzV+kBFHJd04JK0bKDtxEvvC3fSz5BGj1mLmepg==
X-Received: by 2002:a5d:6c6e:0:b0:365:e76b:e914 with SMTP id
 ffacd0b85a97d-366e95eaf03mr5831070f8f.43.1719263081523; 
 Mon, 24 Jun 2024 14:04:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:41 -0700 (PDT)
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
Subject: [PATCH v4 10/14] pinctrl: mediatek: add support for gpio-controller
 property in root node
Date: Mon, 24 Jun 2024 23:03:36 +0200
Message-ID: <20240624210418.19324-11-ansuelsmth@gmail.com>
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

Add support for gpio-controller property in root pinctrl node.
This is to follow upstream linux DTSI that doesn't define the
gpio-controller and cells in dedicated nodes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 37fc28bb779..ede3959c94f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -761,6 +761,15 @@ static int mtk_gpiochip_register(struct udevice *parent)
 	if (!drv)
 		return -ENOENT;
 
+	/*
+	 * Support upstream linux DTSI that define gpio-controller
+	 * in the root node (instead of a dedicated subnode)
+	 */
+	if (dev_read_bool(parent, "gpio-controller")) {
+		node = dev_ofnode(parent);
+		goto bind;
+	}
+
 	ret = -ENOENT;
 	dev_for_each_subnode(node, parent)
 		if (ofnode_read_bool(node, "gpio-controller")) {
@@ -771,6 +780,7 @@ static int mtk_gpiochip_register(struct udevice *parent)
 	if (ret)
 		return ret;
 
+bind:
 	ret = device_bind_with_driver_data(parent, &mtk_gpio_driver,
 					   "mediatek_gpio", 0, node,
 					   &dev);
-- 
2.45.1

