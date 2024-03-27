Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E2FC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 12:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B1388069;
	Wed, 27 Mar 2024 13:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KbuhrMcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162EE8808F; Wed, 27 Mar 2024 13:47:00 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB7708803A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 13:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e205839a35so2030855ad.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711543616; x=1712148416; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t4SXIAN78kkyvXDD+eZqWJMWEegIJBMELE5aY0Arn2U=;
 b=KbuhrMcyo6s5LwdfkwtW3EpxA1NYNQah+/+W/0tuhkYvloaKFK9xfvBDeQW8FOUaG4
 9A3WCY9TrGOS2si3jV5IqbXZfjouDdS65GgwfR6qYS1zuKmxSUn4bxyEre3hekUILm2m
 FNv09dIItRGB/uxX9GZQ1lRMmRSsa2wWeLfpjbIlMyUJs25oUrdUVXOfsA0AeuD8YS9g
 auYyitTmA0mJLJDMV7byPZe3mssN9KYfBgTRPyGWr37G20tSKHSFwdkKu+5BmBI1AoOr
 /meF0r8NtgHFxOouriHsdkjA/C0rFsQrBIklsjgtKjxV5SPkrOUl4jmwLBn8RKaxsdEV
 wy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711543616; x=1712148416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4SXIAN78kkyvXDD+eZqWJMWEegIJBMELE5aY0Arn2U=;
 b=h+y65XrA7fl5nky6iSnduQ66fVIHQBP1iyDgirljOPpcNkU+5lh/7L5aBsgo+c/uxn
 2z0uVt31Uobk8hxxwSkDOsKe0tmmCQfOKS4H/DblssRXHLR1mfTxkFCtWf3SzijJnkea
 DeSTPo7YONxGzkbRQEzQBwYP8v+BO0QFSRO7zP9XOySRdK2CztK8mhRCNhXuS/8kU8k3
 +ysHd5wLH9Dkoc//wMzxVdD/gNpn0jyS3u2v7I7URqHxxga5e+7ICcFIDz5ClPR3rSAF
 CZNcDzlg4XAO532ygDx4mBsIGRFAB42RNGjuchWKaDT06Qv+AUVoG7+rlso5t5j8lxl/
 q2LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwVzJdVnIK78Fferr9FXcFLOZk0oOtZy7X5hn8WaolyggAKxTC+mcUY8z2SWA8E0frFvWk25IX5SjChWdReQekUg0SyQ==
X-Gm-Message-State: AOJu0Yxl5yruESm6Q5D4voDUdNiTbEoN0PviScHKp3TSK0YE4xMX3dra
 4+N9f+qat0cUfoCH30wk52RXbreKCpZsspvvi+JUBw0Myp69gTpc
X-Google-Smtp-Source: AGHT+IGZymb+XV3A4r5aQRPK7l+zA7t50JA9FOVfrBA/JtsSdZZVOrqNIDGKZGLW5RoBVyl+nSuJJg==
X-Received: by 2002:a17:902:76c4:b0:1dd:7b1d:af7f with SMTP id
 j4-20020a17090276c400b001dd7b1daf7fmr2367986plt.58.1711543616276; 
 Wed, 27 Mar 2024 05:46:56 -0700 (PDT)
Received: from frhdebian.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 mj16-20020a1709032b9000b001dc71ead7e5sm8971148plb.165.2024.03.27.05.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 05:46:56 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Hiago De Franco <hiago.franco@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v1] board: toradex: colibri-imx8x: Remove board_gpio_init
Date: Wed, 27 Mar 2024 09:45:50 -0300
Message-Id: <20240327124550.32138-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
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

From: Hiago De Franco <hiago.franco@toradex.com>

On Colibri iMX8X, the gpio initialization and usage should be handled by
the device tree, not by the colibri-imx8x.c code. Therefore, remove it.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 board/toradex/colibri-imx8x/colibri-imx8x.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/colibri-imx8x/colibri-imx8x.c
index 6fc8076163c6..1474297e1814 100644
--- a/board/toradex/colibri-imx8x/colibri-imx8x.c
+++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
@@ -93,15 +93,6 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_DM_GPIO)
-static void board_gpio_init(void)
-{
-	/* TODO */
-}
-#else
-static inline void board_gpio_init(void) {}
-#endif
-
 #if IS_ENABLED(CONFIG_FEC_MXC)
 #include <miiphy.h>
 
@@ -128,8 +119,6 @@ static void select_dt_from_module_version(void)
 
 int board_init(void)
 {
-	board_gpio_init();
-
 	if (IS_ENABLED(CONFIG_IMX_SNVS_SEC_SC_AUTO)) {
 		int ret = snvs_security_sc_init();
 
-- 
2.39.2

