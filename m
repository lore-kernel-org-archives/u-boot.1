Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A106C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 23:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1386587735;
	Sun,  3 Dec 2023 00:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MLH3dzh+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u2kmQ9ZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDF7876B2; Sun,  3 Dec 2023 00:40:28 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069ED877C4
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 00:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SjRHr4PLVz9sQ6;
 Sun,  3 Dec 2023 00:40:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701560424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=G4D/Ga86u1i0vRdLDq6rFZx/y2mkJrrE+3XuESXGjfU=;
 b=MLH3dzh+NY1cZYQ5LO8xCZvvjy64PPfXp6GrQ4mvMY97BnD+pe6/G6IttPOFIwXSkg8bsj
 NSuuwELsAw2Y1UrDel50CgBE+vdBrDmzozzSgNLjb6GeX7l6a1FLO5gnX+5hV5FUtUAMVG
 WNTs8x9VzRf7p3f2avlC/Q6gE4+oe+ZOZA6AUJRpFUsWbpEg7N6uSpHBH+XKdyttSww75s
 TghzbUZkE4PQjlM47IUn2CfVRMBM4kIVD4PtKL6b+vipx2v5e3qRjL9ysXXl+GhBz52IGb
 wEiyaI0UaG1I21vK5vQoH+1+bBB83g+XSgBGzYVXm0ti8juv8aSBkYpZRzxRRA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701560422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=G4D/Ga86u1i0vRdLDq6rFZx/y2mkJrrE+3XuESXGjfU=;
 b=u2kmQ9ZM2YYHsdpDDlB6ZCe+qS+W2yqW9KB1wEhou00SZ5gvumDOLh7x/EMARwkaaJK5J+
 WjIrd7eG1tVyglEsp44K3f1Hn10cRdyKUCP/gRu03muRqAxduHLfC3+HET/HgP1LFZjeDy
 U4kg5WxXYQ4Ou91fx0Dr6D8w0foeTIwJqs8kKo/aJLlHeYrT+HlvUMD0uUGos0YluCOJTc
 kdp1+C6mLPhzCSo+Y+yrV+dEdaa7HJ9rUEo7TMuCpRMwUylI1eVZMjH0xRSb95rbMYkpin
 lZgw/ZmZ3gBvWu+DIK1FQw4y/IoXDQ26gLcvIpihrH+Vu+L7JIfa99bQSqrRbg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: Unconditionally call mmc_deinit()
Date: Sun,  3 Dec 2023 00:39:45 +0100
Message-ID: <20231202234011.208212-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3088cc0ce6847c81ad5
X-MBO-RS-META: 9jmrnwqtaw9xyn8dbb5cji7pycr65o6d
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

Place the SDR104/HS200/HS400 checks into the mmc_deinit() and always
call it. This simplifies the code and removes ifdeffery. No functional
change is expected.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/mmc-uclass.c | 13 +------------
 drivers/mmc/mmc.c        |  9 +++++----
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 328456831dd..cdead044177 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -494,10 +494,7 @@ static int mmc_blk_probe(struct udevice *dev)
 	if (ret) {
 		debug("Probing %s failed (err=%d)\n", dev->name, ret);
 
-		if (CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) ||
-		    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) ||
-		    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
-			mmc_deinit(mmc);
+		mmc_deinit(mmc);
 
 		return ret;
 	}
@@ -505,9 +502,6 @@ static int mmc_blk_probe(struct udevice *dev)
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
-    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
-    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
 static int mmc_blk_remove(struct udevice *dev)
 {
 	struct udevice *mmc_dev = dev_get_parent(dev);
@@ -516,7 +510,6 @@ static int mmc_blk_remove(struct udevice *dev)
 
 	return mmc_deinit(mmc);
 }
-#endif
 
 static const struct blk_ops mmc_blk_ops = {
 	.read	= mmc_bread,
@@ -532,12 +525,8 @@ U_BOOT_DRIVER(mmc_blk) = {
 	.id		= UCLASS_BLK,
 	.ops		= &mmc_blk_ops,
 	.probe		= mmc_blk_probe,
-#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
-    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
-    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
 	.remove		= mmc_blk_remove,
 	.flags		= DM_FLAG_OS_PREPARE,
-#endif
 };
 #endif /* CONFIG_BLK */
 
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index d96db7a0f83..eb5010c1465 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3010,13 +3010,15 @@ int mmc_init(struct mmc *mmc)
 	return err;
 }
 
-#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
-    CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
-    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
 int mmc_deinit(struct mmc *mmc)
 {
 	u32 caps_filtered;
 
+	if (!CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) &&
+	    !CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) &&
+	    !CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
+		return 0;
+
 	if (!mmc->has_init)
 		return 0;
 
@@ -3034,7 +3036,6 @@ int mmc_deinit(struct mmc *mmc)
 		return mmc_select_mode_and_width(mmc, caps_filtered);
 	}
 }
-#endif
 
 int mmc_set_dsr(struct mmc *mmc, u16 val)
 {
-- 
2.42.0

