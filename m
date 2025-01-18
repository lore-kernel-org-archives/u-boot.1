Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBD9C02183
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 03:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B5248069D;
	Sat, 18 Jan 2025 04:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oguxhy3v";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r+fR18Oo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 897848070C; Sat, 18 Jan 2025 04:10:27 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A92F80657
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 04:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YZhS10lblz9sZq;
 Sat, 18 Jan 2025 04:10:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737169825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9PF1mG3xzQRMZREmZQYqZ0h9b6bJFml4iZiyOuMxkSU=;
 b=oguxhy3vk2zww9CS2bAfvkS2hsZyPAihthnegFfg4jY8TPKxnFsN//yd8WXz/LPdiVzB8x
 jiTNwLTB5VGSNUinuQZ+csLRqrdlCi2UmB2KRQ3Rxg5ZdajCjYtHrWkjesN01UWgsfFtWj
 50eDsnw8qTxkm77sSjBeegIv83MHRhYA7h+I4kpurdJankjJyroOqu9rQH2ngBInuHVz9F
 ahAjs4VYn2h7iEk/WgA27xhyXMTX+Q6Eg9z2kg6iPFwJzI7ha5k4IAAjxfzYVDKd7bABIt
 +QwOJ9DPFD2GBh1xQtQTWEzjtmYc2gJ1NQ3UxMUL/Pr2CCG6LkQ41ERsO1KEPg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737169823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9PF1mG3xzQRMZREmZQYqZ0h9b6bJFml4iZiyOuMxkSU=;
 b=r+fR18Oo7V4TUk/jrRSF8npKfYffWUxvJLaod4P4+HugXFKlT5RYgkLdskilAJbHmxkmEi
 WkPBstKOaaKTZk8ZHlebmiN3rrmoN7ohv3fwLrw6AS6oalb5xfBoTIZM4AYivDIj2AnHZY
 GOXGWzEot6wh2drWB3hoBCMmtMNJEGtGrtnkyLvnAJ7P/fDxTzhVfvDJmMF4nNhqOAm+M+
 0Ctk2u/beue7DAbiWQAnyc86s1hUyEfa46/Jsi7R0Kk00IShjb3teWwdLDIyB+Lt7HT+iC
 6PdOV3wmB5FA4hNQJx9yHCoBxcSjpa+iLxJongbxo3+8TZv1zGltcCjIkuAfrw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] mmc: Simplify poll CD logic in case cyclic framework is
 enabled
Date: Sat, 18 Jan 2025 04:09:53 +0100
Message-ID: <20250118031008.29702-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a27b7c0ae7e535090f6
X-MBO-RS-META: 6mf9bk1aug9gfmrjxtq1976zqxrmf689
X-Rspamd-Queue-Id: 4YZhS10lblz9sZq
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

Simplify 90cc07fd786d ("mmc: Poll CD in case cyclic framework is enabled")
according to suggestions by Rasmus. The struct cyclic_info is zero-size in
case CONFIG_CYCLIC is not enabled and does not add any size to struct mmc,
so it can unconditionally be part of that structure. This allows clean up
of all the other conditionals in mmc.c which can now be unconditionally
present, as they also add no extra space.

Suggested-by: Rasmus Villemoes <ravi@prevas.dk>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de
---
V2: Drop __maybe_unused as well
---
 drivers/mmc/mmc.c | 12 +++++-------
 include/mmc.h     |  6 +++++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 799586891af..0d0bda5dd35 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3040,9 +3040,9 @@ static int mmc_complete_init(struct mmc *mmc)
 	return err;
 }
 
-static void __maybe_unused mmc_cyclic_cd_poll(struct cyclic_info *c)
+static void mmc_cyclic_cd_poll(struct cyclic_info *c)
 {
-	struct mmc *m = CONFIG_IS_ENABLED(CYCLIC, (container_of(c, struct mmc, cyclic)), (NULL));
+	struct mmc *m = container_of(c, struct mmc, cyclic);
 
 	if (!m->has_init)
 		return;
@@ -3078,10 +3078,8 @@ int mmc_init(struct mmc *mmc)
 
 	if (CONFIG_IS_ENABLED(CYCLIC, (!mmc->cyclic.func), (NULL))) {
 		/* Register cyclic function for card detect polling */
-		CONFIG_IS_ENABLED(CYCLIC, (cyclic_register(&mmc->cyclic,
-							   mmc_cyclic_cd_poll,
-							   100 * 1000,
-							   mmc->cfg->name)));
+		cyclic_register(&mmc->cyclic, mmc_cyclic_cd_poll, 100 * 1000,
+				mmc->cfg->name);
 	}
 
 	return err;
@@ -3092,7 +3090,7 @@ int mmc_deinit(struct mmc *mmc)
 	u32 caps_filtered;
 
 	if (CONFIG_IS_ENABLED(CYCLIC, (mmc->cyclic.func), (NULL)))
-		CONFIG_IS_ENABLED(CYCLIC, (cyclic_unregister(&mmc->cyclic)));
+		cyclic_unregister(&mmc->cyclic);
 
 	if (!CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) &&
 	    !CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) &&
diff --git a/include/mmc.h b/include/mmc.h
index e4b960b7294..c6ed25db728 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -759,7 +759,11 @@ struct mmc {
 
 	enum bus_mode user_speed_mode; /* input speed mode from user */
 
-	CONFIG_IS_ENABLED(CYCLIC, (struct cyclic_info cyclic));
+	/*
+	 * If CONFIG_CYCLIC is not set, struct cyclic_info is
+	 * zero-size structure and does not add any space here.
+	 */
+	struct cyclic_info cyclic;
 };
 
 #if CONFIG_IS_ENABLED(DM_MMC)
-- 
2.45.2

