Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2956C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 03:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40DC680657;
	Sat, 18 Jan 2025 04:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SNNppTJH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="doDzV28A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F013F8070C; Sat, 18 Jan 2025 04:28:49 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC1F8036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 04:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZhsB741Yz9skn;
 Sat, 18 Jan 2025 04:28:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737170927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fsIWdltBr0IOcJB+KPKWkY7bLVAGI3VI5p/WX95kXAQ=;
 b=SNNppTJHDLeSPeMI6UY57kHnej5mSAOe1HvmbDMi7ufDCQQynemFJKFphaX6QPICMkze44
 cUX5mOWEpv/RuInELi4wDyFUU5/BAS0+sbDYspDyDfhEAPDm/jKRVHM5HYH4uUwvkmAKhf
 J6vnxEqBc20py71W8hBvKB9rWqdl6mAL8xzo7xarTmsCt+cQAMuHRGuTAwgKJ/HdgLMtYa
 HD0DDVAVjjxffprTRIb4Tw3sC6o/Ee0qYoJh5ZUq70KfMjskTOOMnFabvkdAS470fhOAV7
 gk3WZRGZa9gR2ZxQk/UpH7d6inj9mRajR7Sbnj8HR5L3SSJI26Q5B1zn4Q2P9A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737170925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fsIWdltBr0IOcJB+KPKWkY7bLVAGI3VI5p/WX95kXAQ=;
 b=doDzV28AKze/MoIHDpQqG7vdu7aaHfxQ4aZw6FdSg+fCUQfaBt4UqbM3GNzv2V6ELBLHbd
 tM0qEFnVA5ev+ksV28KAeNqr+JwIlKxrHJncq3Jhr7VNXY1aUW7bN0U9PYyRjQicRsQzl5
 svF4aOGMPLxMPr2Aq/ftWF99IDy8KIjAMfO301VlbBF4pHbDm2njaQWpnkwQFbfy4FAeo5
 eS67WtMtJ0Dfr10Xc+IbFB6DNfZbLkZjlbmwOou7npMONS63wCVp4HNtG15Wc6pw4s5H/L
 foYbZ4wxZxjeaZDb0peL6TFEHLzhD0FG6arvv9bOi+qiKXtJP8mik3SfeasBNg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] mmc: Exit from mmc_init() if mmc_complete_init() fails
Date: Sat, 18 Jan 2025 04:27:34 +0100
Message-ID: <20250118032832.32865-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qpy1k4pi1xumxhowunuy4thiiu46e6y4
X-MBO-RS-ID: fe03e3d126b051bea41
X-Rspamd-Queue-Id: 4YZhsB741Yz9skn
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

In case mmc_complete_init() returns error, exit from mmc_init()
without possibly calling cyclic_register(), which at that point
would be undesired.

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
 drivers/mmc/mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 0d0bda5dd35..4ea97974383 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3073,8 +3073,10 @@ int mmc_init(struct mmc *mmc)
 
 	if (!err)
 		err = mmc_complete_init(mmc);
-	if (err)
+	if (err) {
 		pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
+		return err;
+	}
 
 	if (CONFIG_IS_ENABLED(CYCLIC, (!mmc->cyclic.func), (NULL))) {
 		/* Register cyclic function for card detect polling */
-- 
2.45.2

