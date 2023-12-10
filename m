Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC77CC4167B
	for <u-boot@archiver.kernel.org>; Sun, 10 Dec 2023 11:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B71386314;
	Sun, 10 Dec 2023 12:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="m2gdIqyA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KD4mXq+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E67287076; Sun, 10 Dec 2023 12:07:42 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00C00807E2
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 12:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Sp2Cb3FKpz9snc;
 Sun, 10 Dec 2023 12:07:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702206459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q/hvqYwV7CjvDi0MSIfemIvHNl35zDXetc7Yqa+NFEQ=;
 b=m2gdIqyA6oH3e3lwYi5gWUSkknjdFnL4blUqHsDm38KZXMXNVPY2Ivd6iIw/iapkaZ9OcU
 WJQLTdtzg6igIpBUnz2my+mo+2bhoc4iYN0UvRRaEcexcUMEnAGHjv6DcNVYr7fEf0pyYY
 TqEwvJTUMss+j+uruYrSanRLE4aNtDyBOrlub5+2LelY99K8bAiTzBxYBZxeqp6MDwg3xF
 l5iv6PIita4HslP9s9iLcFaJYEhBT7xvV4Bmzxqr7LcN/CWcKTAH7fV9AY9BH/C3uzi0i9
 lK3sJ7oq+o48FCvAgBc/5cy1epo5gMQ4hJR4XBxfJ4HWWIk6c8zo32DcZV++fw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702206457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q/hvqYwV7CjvDi0MSIfemIvHNl35zDXetc7Yqa+NFEQ=;
 b=KD4mXq+Z+hp/xUGh3pFZ4IsmPN6wkXIar8ai6UKzO5I/siQAMZJIvqO94Ep/trUam1nuga
 PPsHoxNX0fJcJmzFv88YGcVbRDfajIq//KsU4FnG8DzPggzAu7vyzKWWW0TppgmzNGqPEb
 1O8Wa8LOVYsjLzJbGLT1FS+uzIJd/i+QpaigvaplaTlbBTmWtr4vQtxKCovJ0b5Ig0pjyA
 5ACX6XoPazwI/S6UU4HIg2PIw837PErenwCfh0ogqSZSPkhpy64XyesAEDYXg3m4+ATwVz
 7n6RsBlTfjc5e+bp+Kq2f6dQcRwhmBFZyxUJkK0cW+XUyRKx7SIBLMJlZsNIpA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] mmc: Poll CD in case cyclic framework is enabled
Date: Sun, 10 Dec 2023 12:07:11 +0100
Message-ID: <20231210110721.18600-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2a0f60a008b06355837
X-MBO-RS-META: dttpweh3tapju83sjd896mbh7t15wm51
X-Rspamd-Queue-Id: 4Sp2Cb3FKpz9snc
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

In case the cyclic framework is enabled, poll the card detect of already
initialized cards and deinitialize them in case they are removed. Since
the card initialization is a longer process and card initialization is
done on first access to an uninitialized card anyway, avoid initializing
newly detected uninitialized cards in the cyclic callback.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: Move the cyclic registration/unregistration into mmc init/deinit
---
 drivers/mmc/mmc.c | 30 ++++++++++++++++++++++++++++++
 include/mmc.h     |  5 +++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index eb5010c1465..2ff297c2970 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2985,6 +2985,20 @@ static int mmc_complete_init(struct mmc *mmc)
 	return err;
 }
 
+static void mmc_cyclic_cd_poll(void *ctx)
+{
+	struct mmc *m = ctx;
+
+	if (!m->has_init)
+		return;
+
+	if (mmc_getcd(m))
+		return;
+
+	mmc_deinit(m);
+	m->has_init = 0;
+}
+
 int mmc_init(struct mmc *mmc)
 {
 	int err = 0;
@@ -3007,6 +3021,17 @@ int mmc_init(struct mmc *mmc)
 	if (err)
 		pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
 
+	if (CONFIG_IS_ENABLED(CYCLIC) && !mmc->cyclic) {
+		/* Register cyclic function for card detect polling */
+		mmc->cyclic = cyclic_register(mmc_cyclic_cd_poll, 100 * 1000,
+					      mmc->cfg->name, mmc);
+		if (!mmc->cyclic) {
+			printf("Failed to register %s CD poll function\n",
+				mmc->cfg->name);
+			err = -EINVAL;
+		}
+	}
+
 	return err;
 }
 
@@ -3014,6 +3039,11 @@ int mmc_deinit(struct mmc *mmc)
 {
 	u32 caps_filtered;
 
+	if (mmc->cyclic) {
+		cyclic_unregister(mmc->cyclic);
+		mmc->cyclic = NULL;
+	}
+
 	if (!CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) &&
 	    !CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) &&
 	    !CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
diff --git a/include/mmc.h b/include/mmc.h
index 1022db3ffa7..4256d5567ef 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -14,6 +14,7 @@
 #include <linux/sizes.h>
 #include <linux/compiler.h>
 #include <linux/dma-direction.h>
+#include <cyclic.h>
 #include <part.h>
 
 struct bd_info;
@@ -739,6 +740,10 @@ struct mmc {
 	u8 hs400_tuning;
 
 	enum bus_mode user_speed_mode; /* input speed mode from user */
+
+#if CONFIG_IS_ENABLED(CYCLIC)
+	struct cyclic_info	*cyclic;
+#endif
 };
 
 #if CONFIG_IS_ENABLED(DM_MMC)
-- 
2.42.0

