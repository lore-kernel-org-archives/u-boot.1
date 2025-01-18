Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92555C02183
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 03:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21468069D;
	Sat, 18 Jan 2025 04:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Arg231tt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="meNuVnyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2EEB8070C; Sat, 18 Jan 2025 04:09:20 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0125A80657
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 04:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YZhQj4BbLz9snt;
 Sat, 18 Jan 2025 04:09:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737169757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y6dPQ81r1beV7wwD+UXNqDQqL8pSK2UZUTAlpNUowMU=;
 b=Arg231ttYMj/QxA0tFq++iDS+dvt6enzIdGcJYcjeBh7EdfySohiEA1K4GKBazra7kW1G3
 Rgqozii3Him8sTngdnPnP6kFNcA3VYIJSPlTk1okU3kHSVZUz8YnNTvasDF5QVdVMPtMcx
 Jux/huJG1/T80KkkYd59d6QZrnjiDsT00VoGRyeTi77v0KU7mpiYyEmxSIBPy7Ef6c1AU3
 UhhRiOpaHWszWvwufevuZq30TvXEbm2wrqzFoRiq5g0yQ4Ah1xJV/l+O7ZYxE4V1Wlb5rq
 1XeSDDjYUxY6jUAtdVqSrUZkOfQfPOaUrLfkBzuZi3MBB+13z5yR4uTsDFLs/g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737169755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y6dPQ81r1beV7wwD+UXNqDQqL8pSK2UZUTAlpNUowMU=;
 b=meNuVnyvibndRrfO17v4DQtAtRZ2I6t0aGYLkQ3Cusz0bhTIk4sY43PZ29wIGPVcuMBuk0
 +O9KtQ5vqFrqQ640Q+SotZ4+rN6t3BxU4ivAWu/RcqkntEjtA5tfQ3+FVnZH4dI+PDq1mI
 O8KUvEjbfPxtyTScrTYcBLjq10Zekq0RSTyV41UXyhe0Xi3osSdjeetS71HZlLavERjt25
 W4QQWAbJQj5+uM6xCELPJ772gSC/EoQevN/XDfPFg/haym7WThud198MY5z4oXa5yHpdGG
 +Gjudc0xXqv6+ixYkHs5zAP5vXholRESZf+gRubhfR8Q9LJhWbyXYPs4Ot1pfg==
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
Subject: [PATCH] mmc: Simplify poll CD logic in case cyclic framework is
 enabled
Date: Sat, 18 Jan 2025 04:08:39 +0100
Message-ID: <20250118030857.29509-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c523130c56651dc0b05
X-MBO-RS-META: pz8oau6puwsynuud3bxrewr75rtmfzou
X-Rspamd-Queue-Id: 4YZhQj4BbLz9snt
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
 drivers/mmc/mmc.c | 10 ++++------
 include/mmc.h     |  6 +++++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 799586891af..821abc7dd66 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3042,7 +3042,7 @@ static int mmc_complete_init(struct mmc *mmc)
 
 static void __maybe_unused mmc_cyclic_cd_poll(struct cyclic_info *c)
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

