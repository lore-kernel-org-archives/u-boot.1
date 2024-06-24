Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5D2C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531608858B;
	Mon, 24 Jun 2024 23:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EZfiHzTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE03883CD; Mon, 24 Jun 2024 23:04:42 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A369188405
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4249196a361so11247475e9.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263080; x=1719867880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0HtW2upwI2Gp/9gEF71H/9ktujLXrI6rcMk4+DF/9WM=;
 b=EZfiHzTO7sH0Ajlo5LILeJy9rnENpG6jGdR9ivTB8pjIdA74O9hlO1goONtyJM/sEt
 AlVw1PBJFpaJhX7pB7bGH5xnLF73I3WvrlPFSa0vqQ2/DmKupLXuj0xRQSmn6k3t0be4
 A/9AiWpJ3YpoakCvrlubYSpYM2lMk4V/QE5hS6VKhF5TLPuF/gneHypJHVrY7QE2BTPn
 hyLINSfA/OPBj0vWskSF+FWA9kolDEYeFjIIkCgoRhQwfwKl/vRzNCZFJuG6+Am5oFye
 nKRHhMsnjz1nPjYO/zG/5fqm+e19JN/IEBDLkZeN+wOsF4cR2ffnc8xk0V+SXrVUk9qz
 VWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263080; x=1719867880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HtW2upwI2Gp/9gEF71H/9ktujLXrI6rcMk4+DF/9WM=;
 b=LrO8VugMEKYniaLT/lq9tJTqZzioj5vEv7x9U+NMWNRTKEkDrNaHN/3eHT/EHML7yz
 cxVvRK9EGl/ecfdUv/14RDdpwITlK/VRqz+zy3ejRPIp+WAQhrrEyW2dtx/2W5HknVaV
 4WaLXDfZA9pfQ6uWDKGsVzGm48Eu1a4fGXMN4kfp349BMIo5aj7uMLSUFLVHfBiPjSHR
 DWFdwvUG/h0K/V4iOB+J0jiVsfQYuNmyjAIALnOD+19Rmz7bww3wovaW93PKYHgqrcrH
 voPGhu1Ce9EtJ/mkKVTQMR9O9j+ukC7Cs8mn/2epNRz30LT7MYFjdNXcD3RPrRI9hz+m
 UFGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcWC4EFpnQ5NhHsN6mYSF6+P5y4DuRb5X1YEtvdgQlweiaDsE+v8zOS/kjfQYvalxaGko+cPZ/G/iPqSs5lddTzu6ubw==
X-Gm-Message-State: AOJu0Yzt9I87loX1QxQg4oTTTZvwb3QLVmbv89aqyWqSqP6OzIijbbCi
 bu15Hp+9XmSxr7553rzmLBmCtkwOCmk8keHXv2gWY/JdZz6N4qpR
X-Google-Smtp-Source: AGHT+IGZFoWkUtbhEZKAhYs9ThmG3KgwzIf0BlPecmeT2IVx6SJKWIW7YTjfNzzHjyRTDh84GUGp2A==
X-Received: by 2002:a5d:6daa:0:b0:363:b8fc:449b with SMTP id
 ffacd0b85a97d-366e9529da3mr4480059f8f.28.1719263080035; 
 Mon, 24 Jun 2024 14:04:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:39 -0700 (PDT)
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
Subject: [PATCH v4 09/14] clk: mediatek: mt7981: support alternative
 compatible for fixed-plls
Date: Mon, 24 Jun 2024 23:03:35 +0200
Message-ID: <20240624210418.19324-10-ansuelsmth@gmail.com>
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
2.45.1

