Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871EEC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C82C8076E;
	Sat, 18 Jan 2025 07:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fhSPoNpD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qZnxA0MK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427808063E; Sat, 18 Jan 2025 07:54:47 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF35F807CD
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YZnQr5KP6z9slj;
 Sat, 18 Jan 2025 07:54:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2YnivkZo9oswKda1bfLhWlzi/y1IClqp+u2bOG9WMY=;
 b=fhSPoNpDTH290w6IeW8Ilw+FJa13TTM1J4T3kmZ8H6wBHZg36d05U1n772wIzZeAoNV9Uz
 EQcG9Qpjt43stT6dGdKkf+8+838nwtPfWqpgNIsZVl0J9oEcgEt6jW6xAtgFbGtjFt7VoL
 zbhd3u7v6wKEEtg0Vq8l5+st1Jo97bCqCtVd9IJRKLrdMsnYaT87LJgsXbXvMX66e/oYMz
 ZGLqjNoog/lvZufcNgBjkwdz5AWwynOL/8X7jax63lVDoiQyvYnT78akVUxgbrAU88rX6o
 eHI1yjewDagWPwYU282FgS2TI7B5v/5L8v3/woBI/b11aFVNAupmyiMnZ3Nv5A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2YnivkZo9oswKda1bfLhWlzi/y1IClqp+u2bOG9WMY=;
 b=qZnxA0MKp5VK91rxvWeaXl0I4C4gPnngGJOYsEu8LxylOLkyR6NtUID2lRg2oEenFxm/qw
 ZZY1j1LPdttnmaArhAW2hY3eiyuoGlWy2e4nGvduJxQIhJbT4j+PUNcbomvcHdU/RrJiYb
 WYoupK6+DqzCnzkZt9KMlS7AXdO1yRpR8GRDSr0QsOyvKACQC9OYT3dPEtw2bhaVFEUk3G
 othHUx7ZsPEzixDY0jiPABjAY12CLdU3XX+Db/ZVNe/vcd2F1oepw6WL3bLNezye6qnkcE
 1iof5naXpXCfU32M67oOa8FXFJtOiCvRYvlF4NEHxoW2t0uEmyMEWLU5LQi5Hw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/17] net: miiphybb: Use container_of() in bb_miiphy_getbus()
Date: Sat, 18 Jan 2025 07:53:13 +0100
Message-ID: <20250118065402.172253-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9t76kcqud1az7ngtuyo9zw17oqk9xdbx
X-MBO-RS-ID: 6c271fd4ed1bf7942e0
X-Rspamd-Queue-Id: 4YZnQr5KP6z9slj
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

Replace the name based look up in bb_miiphy_getbus() with trivial
container_of() call. This works because the struct bb_miiphy_bus
always embeds the matching struct mii_dev . This also makes the
code much simpler and more efficient.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/phy/miiphybb.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 9733ebf6f09..cdb0ee9dc8a 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -29,17 +29,9 @@ int bb_miiphy_init(void)
 	return 0;
 }
 
-static inline struct bb_miiphy_bus *bb_miiphy_getbus(const char *devname)
+static inline struct bb_miiphy_bus *bb_miiphy_getbus(struct mii_dev *miidev)
 {
-	int i;
-
-	/* Search the correct bus */
-	for (i = 0; i < bb_miiphy_buses_num; i++) {
-		if (!strcmp(bb_miiphy_buses[i].name, devname)) {
-			return &bb_miiphy_buses[i];
-		}
-	}
-	return NULL;
+	return container_of(miidev, struct bb_miiphy_bus, mii);
 }
 
 struct bb_miiphy_bus *bb_miiphy_alloc(void)
@@ -152,7 +144,7 @@ int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg)
 	int j; /* counter */
 	struct bb_miiphy_bus *bus;
 
-	bus = bb_miiphy_getbus(miidev->name);
+	bus = bb_miiphy_getbus(miidev);
 	if (bus == NULL) {
 		return -1;
 	}
@@ -220,7 +212,7 @@ int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
 	struct bb_miiphy_bus *bus;
 	int j;			/* counter */
 
-	bus = bb_miiphy_getbus(miidev->name);
+	bus = bb_miiphy_getbus(miidev);
 	if (bus == NULL) {
 		/* Bus not found! */
 		return -1;
-- 
2.45.2

