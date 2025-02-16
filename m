Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EF3C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 12:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C378C80F0A;
	Sun, 16 Feb 2025 13:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JXF1x6PB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD5C580F0B; Sun, 16 Feb 2025 13:56:13 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80B258056A
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 13:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3cfe17f75dfso30042535ab.2
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 04:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739710570; x=1740315370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EUlcH9wJr7D4LM0sSptjxiOUewg08u4KCwm2dm8ycUU=;
 b=JXF1x6PBd3Eo6bDWehXPHrj4+FiRkkMYUFOsw8/O2kJmXSJ0lz+3fD9E57kb5EFaw2
 Cl8V6ZM6plOwruarBTkPz79cgnycsyXUBRGGjVD+qSgAH4Fngxui+0mmhSMkXVjKSEgR
 oGv2NtlWAEVenA+SPVhCPq1DQzDWoBc9Fz+qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739710570; x=1740315370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EUlcH9wJr7D4LM0sSptjxiOUewg08u4KCwm2dm8ycUU=;
 b=DrOYnzFROBz1wquFoJJbwQn5KdGjIaGK/svBXRwyV7eTCfwtuQmS2XUAHUGmzz8dz3
 SDrTZ6EnreJliH9BuUtwm1J7yUrQ0RLpLiAIGhd3OqTeajFKi/PIcV3neeOWYEruaT5T
 0RMkAwcaGeLoIhaPcPYLWyRbSGP3rR8GXh6qKWpcjgViJlzQ9n0tGTq0xuJeq/4pgYLt
 BiNMFIVpZuW8ys5lgnymSXzScyNJLubhSWOX1c21ZkPkAYvMAzvj0MQXj7gQSYHyx9sf
 iWyENnlmSjoT30OwGbTMOOFJuQUIOh7xKnNmN9AuqQTFxyJD/a0LZU9R/0dfS4a3elyC
 SrXA==
X-Gm-Message-State: AOJu0Yyczcr2zKocVVeeXgYRfuuB/7EFKRTeh19GRk/RbP6oc1VeMeKd
 KYVQGBLWu53HFw2pCU55GXn/0U+/LXHtUqQFuy2Fj5Mv7FinXk7SAyrSDb+Hlov+MPbCtmHCrDM
 =
X-Gm-Gg: ASbGncsFjb2W5SxaoGkZqzTj0EMGa4BF4a4xNDN350JOzRw5P84aDDAFDCMm53+msiQ
 o1epbhEi7DCDoGzUo82MfVnJMToZcdDLlnzYaru6QYumd5ykQkGf8lBQxUQL8zbegb5w6hKLQ7b
 r3AgiUziHLA7jxePrVcBDW1TG65TynsiFVpU57REm3WUSKGTKdQl86nYlvm80e375+iVypZJBZn
 0phJL4yZOBcbFrBEv1cX+qFkgj3BVzGN06BtjOnsYptimgMMWJ5XMvL1AMSDQDVFncshjfGGs42
 4OwYt+1vusNQpmf2d7R5FzLy+kM6N2U306vRaDWzpQdXD6a0sru2
X-Google-Smtp-Source: AGHT+IEeZJ4U7UvWSxjstQWt7aBI2ySA1NmejXPsY3x/vlypgB3f6vgBPYvpqGpwjZ6d6kkURYBl0A==
X-Received: by 2002:a05:6e02:1c0f:b0:3d0:f31:3657 with SMTP id
 e9e14a558f8ab-3d2796b6803mr48628425ab.0.1739710569719; 
 Sun, 16 Feb 2025 04:56:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed282d74bcsm1672093173.105.2025.02.16.04.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 04:56:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mmc: Avoid uniniting twice
Date: Sun, 16 Feb 2025 05:55:59 -0700
Message-ID: <20250216125604.626298-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Each MMC device has a child which ihs a block device. At present we call
mmc_deinit() when the block device is removed.

But the MMC struct (i.e. struct mmc) is attached to the MMC's device,
not its child.

So at present, when an MMC device is removed, mmc_deinit() is called
twice, once for the MMC device and once for its block device. This
results in a double call to cyclic_unregister().

Fix this by adding a 'remove' method to the uclass and calling
mmc_deinit() from there.

Also drop the call to device_probe() within the block-device's probe()
method. The device is already in the process of being probed, so this
call does nothing.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: c822c1a50bd ("mmc: call device_probe() after scanning")
---

 drivers/mmc/mmc-uclass.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index c8db4f811c2..9af84da1599 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -498,22 +498,12 @@ static int mmc_blk_probe(struct udevice *dev)
 		return ret;
 	}
 
-	ret = device_probe(dev);
-	if (ret) {
-		debug("Probing %s failed (err=%d)\n", dev->name, ret);
-
-		mmc_deinit(mmc);
-
-		return ret;
-	}
-
 	return 0;
 }
 
-static int mmc_blk_remove(struct udevice *dev)
+static int mmc_remove(struct udevice *dev)
 {
-	struct udevice *mmc_dev = dev_get_parent(dev);
-	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(mmc_dev);
+	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct mmc *mmc = upriv->mmc;
 
 	return mmc_deinit(mmc);
@@ -533,7 +523,6 @@ U_BOOT_DRIVER(mmc_blk) = {
 	.id		= UCLASS_BLK,
 	.ops		= &mmc_blk_ops,
 	.probe		= mmc_blk_probe,
-	.remove		= mmc_blk_remove,
 	.flags		= DM_FLAG_OS_PREPARE,
 };
 #endif /* CONFIG_BLK */
@@ -543,4 +532,5 @@ UCLASS_DRIVER(mmc) = {
 	.name		= "mmc",
 	.flags		= DM_UC_FLAG_SEQ_ALIAS,
 	.per_device_auto	= sizeof(struct mmc_uclass_priv),
+	.pre_remove	= mmc_remove,
 };
-- 
2.43.0

