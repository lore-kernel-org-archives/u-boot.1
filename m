Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFDBC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD8FD80793;
	Sat, 18 Jan 2025 05:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KlBOW0U7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S8nG+flH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F824807BC; Sat, 18 Jan 2025 05:02:24 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59B48036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZjbx1LhCz9sZL;
 Sat, 18 Jan 2025 05:02:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OryxPMtEMnAgyRGOi7HYME/V/fiFl3wcrzG5WIO1iTY=;
 b=KlBOW0U7w7X3smNKNrwJ7JsM+HDe0yjy3XRSMKKdAJr5kQSIKYAP+3chnH33sfBCm1AOMr
 i5imnmptjVhzVbzNEBj8Ell/btpGoOO2ldv2fCgKFH9hsjsJdQ5MlTlueIRt9Uf9yQCV7C
 B/qJJvJps02BvL9Ntuy5JaOjSgYuwTbHxbvPRcLOsAP14qrGisSnsnolbsS1cExSyrXmsm
 8rLf/lW407IetYfEhYFZ8rZLQQjVA9970h45sB1VEJKXwfTkj/zuC9lOHNfiVetkxbFPRS
 4yjbTdiqoFO8LQe7cuANAOU6OM9qeYcnNW4kFJMtQzr6x2Nfkqe5gncxZGFtNQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OryxPMtEMnAgyRGOi7HYME/V/fiFl3wcrzG5WIO1iTY=;
 b=S8nG+flHchEtWUQX2qPf1E2784I0SHiy1MFIPqGs3d7VkHIoZsD2zIwDOg/X7GrWCYO8zu
 luKF4jvgPRWi94idkmzZPrWiZUxG4kZYeCIXr5HIVZCXH2+cmVdn5Tj46kyS0DOP3+TVrh
 PuxpABYTdZFv5TqUXnTDie5CR6TEm/xEK7sO3ytihairyZ7l/msLwtUvxnjYzylyyujdrZ
 5PJ9AQbiIDpMQr8hXjY1Xuad5rJEaUnz4mmvuQKFtbiAmNlFh6N783x9ug4Ea4lKkEnwk7
 lQ2sNUmeZIu2hxif2lBjcb8uT064HTRR5T0POtfAanrcDQH+ZO7mszh8VMrNgg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Williams <awilliams@marvell.com>, Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/8] mmc: Handle return value from cyclic_register()
Date: Sat, 18 Jan 2025 05:01:00 +0100
Message-ID: <20250118040130.74921-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fqfj8i6o4fq5uxjnpo9oygrkbfionsyg
X-MBO-RS-ID: 74179df69eafc50d345
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

Handle the error code returned by cyclic_register() and propagate it,
except in case the return code is EALREADY. The cyclic_register() in
mmc.c can be called multiple times with the same parameters, and that
is not an error, so depend on the cyclic_register() to skip such a
repeated registration and consider EALREADY as non-error here.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aaron Williams <awilliams@marvell.com>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Devarsh Thakkar <devarsht@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/mmc/mmc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 4ea97974383..9c58d052261 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3078,11 +3078,17 @@ int mmc_init(struct mmc *mmc)
 		return err;
 	}
 
-	if (CONFIG_IS_ENABLED(CYCLIC, (!mmc->cyclic.func), (NULL))) {
-		/* Register cyclic function for card detect polling */
-		cyclic_register(&mmc->cyclic, mmc_cyclic_cd_poll, 100 * 1000,
-				mmc->cfg->name);
-	}
+	/* Register cyclic function for card detect polling */
+	err = cyclic_register(&mmc->cyclic, mmc_cyclic_cd_poll, 100 * 1000,
+			      mmc->cfg->name);
+	/*
+	 * This cyclic_register() here might be called multiple times, this
+	 * is not a problem in this specific case, because the mmc subsystem
+	 * always registers the same function with the same polling delay,
+	 * so the EALREADY error can be ignored here.
+	 */
+	if (err && err == -EALREADY)
+		err = 0;
 
 	return err;
 }
@@ -3091,8 +3097,7 @@ int mmc_deinit(struct mmc *mmc)
 {
 	u32 caps_filtered;
 
-	if (CONFIG_IS_ENABLED(CYCLIC, (mmc->cyclic.func), (NULL)))
-		cyclic_unregister(&mmc->cyclic);
+	cyclic_unregister(&mmc->cyclic);
 
 	if (!CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) &&
 	    !CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) &&
-- 
2.45.2

