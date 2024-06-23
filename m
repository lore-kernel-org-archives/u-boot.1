Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F3FC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71057884B2;
	Sun, 23 Jun 2024 19:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PfDHOjuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A5788405; Sun, 23 Jun 2024 19:53:32 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625B288551
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7f39116e564so78221939f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165209; x=1719770009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIVlvjCM6wlz/Uph5LRLcypc2mEYIAfW4W7EWyp4Ek0=;
 b=PfDHOjuYaBLv3xxfMohmQ42/xrWfT/ZGe2SkpR9W8tiro53bOnAzwwrUXq+60ehFXm
 U/plZblstXFj/KR/izRe/B69suh2s9No8A+54pej3GPjZTCtdf5fB0MR1+5RbxLIggGt
 i6SowJGhckO3GYWRZe0n/3QOLegcWcCp922b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165209; x=1719770009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIVlvjCM6wlz/Uph5LRLcypc2mEYIAfW4W7EWyp4Ek0=;
 b=V5MY3ls0cvrz4tQii0nupe0se2MlGRbSGdQOgbo+PWoKzC1DFvIa2QLEGuqoG8p8Fm
 DF/wsK/8Zf2QGpWRRp3fOXPWBsEdm53+PprNJHTm9vNpWffTSjtxfJjNOCmf4EfOXjIU
 XluJNow0phyZgjM4XCuCfSytMZe1usrtVHYrtn58hDObmUq6WvwJ+MaEgNVEWnvT6RUG
 pB/JH0Ye2Fl4NPsnbw2RqBAyvmPnb9r2dcwFN+cOmmdI4P76fcRXVN1SXsYLJPmjUJec
 Ccr06AswouQSEmxQhpZuk5RFeJHNTEUxD/NLIXNrf5JCCrxGAMKmpIlJznn5ykWkbbF6
 M9xg==
X-Gm-Message-State: AOJu0YxCmg8B/Hu5t6g1dDDiENka6fDxPf2POsa/RmrJnwMQ/owj4Ov1
 h1fj1TMdOja7v4WRe2KHT9IUi8bD5Nt7+z5xHUlxybMV1b6LfdZXfExOcptxdSLZft8mqJWFlXB
 Meg==
X-Google-Smtp-Source: AGHT+IHffGGWWH54BoJDFTQMI2Eed+7CxMyvzY46jTCwOSccTq6JVC8ALliykav9kvkRqSX/lxgcRQ==
X-Received: by 2002:a05:6602:1582:b0:7eb:cc55:af1d with SMTP id
 ca18e2360f4ac-7f3a4dda232mr313675339f.12.1719165208960; 
 Sun, 23 Jun 2024 10:53:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v4 13/16] rockchip: Ensure memory size is available in RK3399
 SPL
Date: Sun, 23 Jun 2024 11:52:59 -0600
Message-Id: <20240623175302.1463973-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

At present gd->ram_size is 0 in SPL, meaning that it is not possible to
enable the cache. Correct this by always populating the RAM size
correctly.

This increases code size by about 500 bytes in SPL, since it must call
the rather large rockchip_sdram_size() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Cut the patch down to bare bones

Changes in v2:
- Add new patch to correct memory size in SPL

 drivers/ram/rockchip/sdram_rk3399.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 02cc4a38cf0..3c4e20f4e80 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -3142,19 +3142,19 @@ static int rk3399_dmc_init(struct udevice *dev)
 
 static int rk3399_dmc_probe(struct udevice *dev)
 {
+	struct dram_info *priv = dev_get_priv(dev);
+
 #if defined(CONFIG_TPL_BUILD) || \
 	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
 	if (rk3399_dmc_init(dev))
 		return 0;
-#else
-	struct dram_info *priv = dev_get_priv(dev);
-
+#endif
 	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
 	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
 	priv->info.base = CFG_SYS_SDRAM_BASE;
 	priv->info.size =
 		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
-#endif
+
 	return 0;
 }
 
-- 
2.34.1

