Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE380C0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB55F80821;
	Sun,  9 Feb 2025 13:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oZ3AdYtQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eOLXa2vP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E431980EAF; Sun,  9 Feb 2025 13:05:21 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D486780805
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YrRH34ZH4z9sQb;
 Sun,  9 Feb 2025 13:05:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5qjqWJS4PJovkpwItOVqNmR5F3u9WuWAiVuGPe19kg=;
 b=oZ3AdYtQ5qxfWb3ZFNtA0DfdnxQSw/lkvqp/dudZI1/16Daw7IoI/aHOLtdQjBOGYwwbPD
 DkUXsjf6NaPx9HWcXdjmXjRaRTlARDflphZt0o6/x1wjxhi+xHoqB52sxzY1e4AOzuIT7Q
 wMz9K0XSIOIc47O2GBMIYgXo0sdfPqFFt161P9iyv+zuYY7BG0f/x8LhfI3rMPo8U0lRYK
 b6lki7IAb56yPQ/hQM0pGTcEaN5AU5rPj7yqBJzpXbIh8ZlLIQagUtJwfRnMMRh5vhOWlB
 MStPN4MXfPm30gRiFzdoGjDST8gCPVHmZiwmmFw7hNngBd9df9CTWOBgTliicg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5qjqWJS4PJovkpwItOVqNmR5F3u9WuWAiVuGPe19kg=;
 b=eOLXa2vPI5dFfYZcxa5QZOnDb6io54TpPTkqANAyAk8TI88naOXkeDR1cGlyTH018gOMoo
 07Dw8lb10ZlpcqQw2jUMy0WqCwUGjy7+AaAvME2JMX/sH03jr8l449esVnKEs40Q7Ar1T3
 3VnWKAqN5iXqOx3p6PF67Oj0cX8vI3xe8dB9/zVyigKZrGjY4Mkp+co+/NkMGyhLGuxXTl
 gkWrUTe3K67v7eBRKDBrI6V7vwpDG9L3SQrHiB67FhBx0Cj/o8RojLXbm/buXWR8zdhWxz
 Tk/VoVvyY92xYRFHFs6nBNCXEqYb4sjLPvaejyi9u1hCfu3ecjpCPg8WfggUfQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 19/24] net: miiphybb: Use container_of() in
 bb_miiphy_getbus()
Date: Sun,  9 Feb 2025 13:01:45 +0100
Message-ID: <20250209120403.5321-19-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b0436f23d0a4aad374b
X-MBO-RS-META: 3zx6sjr9pz4gwzh7y9qd1akurrrbi3i6
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
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Jim Liu <JJLIU0@nuvoton.com>
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
V2: No change
---
 drivers/net/phy/miiphybb.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 66d98d6cc26..553af2c1032 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -18,17 +18,9 @@
 #include <miiphy.h>
 #include <asm/global_data.h>
 
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
@@ -141,7 +133,7 @@ int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg)
 	int j; /* counter */
 	struct bb_miiphy_bus *bus;
 
-	bus = bb_miiphy_getbus(miidev->name);
+	bus = bb_miiphy_getbus(miidev);
 	if (bus == NULL) {
 		return -1;
 	}
@@ -209,7 +201,7 @@ int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
 	struct bb_miiphy_bus *bus;
 	int j;			/* counter */
 
-	bus = bb_miiphy_getbus(miidev->name);
+	bus = bb_miiphy_getbus(miidev);
 	if (bus == NULL) {
 		/* Bus not found! */
 		return -1;
-- 
2.47.2

