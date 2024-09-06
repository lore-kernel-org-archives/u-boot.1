Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D87E6FE33
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 17:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF76088CD8;
	Fri,  6 Sep 2024 19:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OB98+14z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ADLMdWgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F15F988D1C; Fri,  6 Sep 2024 19:11:33 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D860C8855C
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 19:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4X0jSL4lRSz9srB;
 Fri,  6 Sep 2024 19:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725642690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=muTRXOgIfkoW4EoNi5jZsMZVHJvfMl2bSNrkZLNY+pE=;
 b=OB98+14z4CjoXBa5IUFFS47fKPUniRocsjNv4rfuGbcB2ePYr87CaRg/ckJp2MrjcM+U3L
 XAxRSPSu41WirQVnw8GWiQmf2dU95ukbNM+6gZhoW5WsLv87UsPrJcSfh6d0V8g4E65JJH
 mNldO5YEyzgRYMGySzQ44D+TQHOLpCr46asqUr5lQEAHCzgwsp/ZGATaYExD4eiSZ2PuQs
 wlaPCEB8As2UNcwnSOlc/CXqhyPCIYw31a0iyzedvXQWNZ8/myLxSfvl1ahs1LzJarwCh7
 suVarvekOYUlduSoLErMO5O0Q7XplVgZVpQ1Kc68YDkUwwPwSNGn4kUFXCIKig==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725642688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=muTRXOgIfkoW4EoNi5jZsMZVHJvfMl2bSNrkZLNY+pE=;
 b=ADLMdWgLIaR6i8rl9xhhyTcr6ufQFeA6QUeVU5ver3eladV3TdfFH2gJVOLlQdAHOzXPkj
 biguZGGbGBswX3kMr1pbL7ZjBwAR0IybLBqyW57Xp4ZbcCXwOPRfcaeMU2EYGubCKX5jiz
 yTB012bJuyAo5w2GmoVXjITkC/gYkZPll6zGCiqN18H27jf8XyxRQkGngpJcgZDXmMJzA0
 qLwNAkUwXXgz1XYXi5xM/vTHKtVHKH4qmfmpNvgBH8BV2cJPwg19LO/0jay15aH4cBgmtW
 Qt7bRZzGu7N3aNUi+SgZx440M2+h6CApSFashRbcSOyXCKrZ6RSu/fvY86MdCA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6] mmc: Poll CD in case cyclic framework is enabled
Date: Fri,  6 Sep 2024 19:10:42 +0200
Message-ID: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y68a71jiqu3tea66pj1n3bdbx96gdjmy
X-MBO-RS-ID: 86292290c7a8c50cf60
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
V4: Stuff the code with CONFIG_IS_ENABLED() variants to avoid #ifdefs
V5: Rebase on u-boot/next
V6: Rebase on u-boot/next
---
 drivers/mmc/mmc.c | 25 +++++++++++++++++++++++++
 include/mmc.h     |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 0b881f11b4a..c787ff6bc49 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3039,6 +3039,20 @@ static int mmc_complete_init(struct mmc *mmc)
 	return err;
 }
 
+static void __maybe_unused mmc_cyclic_cd_poll(struct cyclic_info *c)
+{
+	struct mmc *m = CONFIG_IS_ENABLED(CYCLIC, (container_of(c, struct mmc, cyclic)), (NULL));
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
@@ -3061,6 +3075,14 @@ int mmc_init(struct mmc *mmc)
 	if (err)
 		pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
 
+	if (CONFIG_IS_ENABLED(CYCLIC, (!mmc->cyclic.func), (NULL))) {
+		/* Register cyclic function for card detect polling */
+		CONFIG_IS_ENABLED(CYCLIC, (cyclic_register(&mmc->cyclic,
+							   mmc_cyclic_cd_poll,
+							   100 * 1000,
+							   mmc->cfg->name)));
+	}
+
 	return err;
 }
 
@@ -3068,6 +3090,9 @@ int mmc_deinit(struct mmc *mmc)
 {
 	u32 caps_filtered;
 
+	if (CONFIG_IS_ENABLED(CYCLIC, (mmc->cyclic.func), (NULL)))
+		CONFIG_IS_ENABLED(CYCLIC, (cyclic_unregister(&mmc->cyclic)));
+
 	if (!CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) &&
 	    !CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) &&
 	    !CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
diff --git a/include/mmc.h b/include/mmc.h
index f508cd15700..0044ff8bef7 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -14,6 +14,7 @@
 #include <linux/sizes.h>
 #include <linux/compiler.h>
 #include <linux/dma-direction.h>
+#include <cyclic.h>
 #include <part.h>
 
 struct bd_info;
@@ -757,6 +758,8 @@ struct mmc {
 	bool hs400_tuning:1;
 
 	enum bus_mode user_speed_mode; /* input speed mode from user */
+
+	CONFIG_IS_ENABLED(CYCLIC, (struct cyclic_info cyclic));
 };
 
 #if CONFIG_IS_ENABLED(DM_MMC)
-- 
2.45.2

