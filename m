Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F38C4167B
	for <u-boot@archiver.kernel.org>; Sun, 10 Dec 2023 15:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A9487076;
	Sun, 10 Dec 2023 16:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oRy69510";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gPulJVm9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF427876E0; Sun, 10 Dec 2023 16:03:21 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF53787045
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 16:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Sp7RW339Gz9sWJ;
 Sun, 10 Dec 2023 16:03:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702220599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GyrbgpuZV0QACoWoal/a6Tmb7RPLBuC96iL7prDqoQ4=;
 b=oRy69510cFJMPBzfFLSPhNaYTqcyThKKfxJGCJHDTAKIw5GR30dHNmggPw/8dnqoifHSw9
 tTAQLfQZyB4PL3lixctj6V3ZYWkGsN+wmSqH7b/qTvwD4GivreiXrsaeuhfPEHHVntlge9
 714ydHFAsYv9NXX3+pulMivD8u1b94dVeRRTgcTbltyc71Qcp5NEqZ++kuHoAuua5CVoB2
 LQGYFRelFjGgYfxJFPuWJyV06r4oiI5YZbp/VPsuGMUWjkN2jEAppc4o15CGvyCzKSfyJZ
 Gkt1GgJNJEmw1IM1l7w6hnSk21D8NmRS30QTNT4dBzDTn4ANKbjJ1Gs3vXl2CA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702220597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GyrbgpuZV0QACoWoal/a6Tmb7RPLBuC96iL7prDqoQ4=;
 b=gPulJVm9hqQxKh0zLcbYxbElOBf/j9rIkYW0CSXkkNTLOBIi3yGeMa9NFPX+y3xVV9Z8gm
 /gfQgmFR13vpvXyzfQc6tK27e7iJpNXrP0dhqBKiS/VBRyPPkNO/atkJl/0QkzsLyBqv04
 mkMsBEDD7lD7Fvw/j9UuMe7KCcxKqQ/sfHR414ETeUGz2sDELFLkvT74jpk4OVT37K3M3c
 U/bD/voshS2JAZYTgMCJkc1+XFaMJ5y8NE4fxsaHvy02jODnqe3hO4Yt8YmJdimUowSJfQ
 Oxj8dD258WSj8Ql9qqhg+059uFT070Be9Mj6tfkwSx16S6FYFIrfOe6elesPYQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3] mmc: Poll CD in case cyclic framework is enabled
Date: Sun, 10 Dec 2023 16:02:58 +0100
Message-ID: <20231210150304.124458-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kspaifqmgpaw6fypoo9ihho59o8n11e5
X-MBO-RS-ID: a57669e18755d20fefb
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
V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
    does not work with structure members
---
 drivers/mmc/mmc.c | 36 ++++++++++++++++++++++++++++++++++++
 include/mmc.h     |  5 +++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index eb5010c1465..a5686dbc12e 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2985,6 +2985,22 @@ static int mmc_complete_init(struct mmc *mmc)
 	return err;
 }
 
+#if CONFIG_IS_ENABLED(CYCLIC)
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
+#endif
+
 int mmc_init(struct mmc *mmc)
 {
 	int err = 0;
@@ -3007,6 +3023,19 @@ int mmc_init(struct mmc *mmc)
 	if (err)
 		pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
 
+#if CONFIG_IS_ENABLED(CYCLIC)
+	if (!mmc->cyclic) {
+		/* Register cyclic function for card detect polling */
+		mmc->cyclic = cyclic_register(mmc_cyclic_cd_poll, 100 * 1000,
+					      mmc->cfg->name, mmc);
+		if (!mmc->cyclic) {
+			printf("Failed to register %s CD poll function\n",
+				mmc->cfg->name);
+			err = -EINVAL;
+		}
+	}
+#endif
+
 	return err;
 }
 
@@ -3014,6 +3043,13 @@ int mmc_deinit(struct mmc *mmc)
 {
 	u32 caps_filtered;
 
+#if CONFIG_IS_ENABLED(CYCLIC)
+	if (mmc->cyclic) {
+		cyclic_unregister(mmc->cyclic);
+		mmc->cyclic = NULL;
+	}
+#endif
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

