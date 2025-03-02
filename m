Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134F9C021B8
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 01:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4212E8129B;
	Sun,  2 Mar 2025 02:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KgqHxFcA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rSW+4P9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4147A811D8; Sun,  2 Mar 2025 02:28:46 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1E0081277
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 02:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z548m52fRz9swT;
 Sun,  2 Mar 2025 02:28:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5TIoj+LLxWHQ64+/0zwsHWXnkqTmw6rdvydeWX4Srw=;
 b=KgqHxFcAtWUqvGLvzW2ZMHaYitPocPGhIll+aFOIFpoPTQcUtWSb7JJmsTiqyvBtoLaveK
 O7NaSnwhZTXiNzIm2ZOEQ0u//rXEedTQH1ZYfmf3ACZwNNZj7LwXVayR2o4FRTAMXYo8wj
 KJHRjrrNl1utzQQIUXOsutRG0715+eH64tMWtYLi3KDlwvK0qvWwoyT3AW1aU935wrRy4d
 +SAXdgEmoKr8Leq8ujy3bz0qhSMXeoPg6I8JzR+YYzYbm/howSzlnstRfWXa0BJrwteObk
 dYzoQIUu6j3Yx2vq0l8jOAJ2vVSX9isj48tLGoIDI27zKx1X0HsgBRCvwx/q1A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5TIoj+LLxWHQ64+/0zwsHWXnkqTmw6rdvydeWX4Srw=;
 b=rSW+4P9kZFoDMXZrnB3n+Emhvb+UPm+oki9/YlpvhkF7J11Sp/Sr5rh6FCE7B5rTDTI9bl
 urlf15XNoA0K3pdHsoXNkc7Fdm7KQ9F/m01YQGqDhNAuFjv72xeTLQ7hPUq2nuXXX105IP
 fbXeDD01n4o8dflkgA2/JfgPuOS+C3otQJ7hSWqlJfhfRcsz5COk87K80TVjG+fZFwI94O
 UQGhOBrRvQHWHzUckQHt5wsh7jUD3qQsJ60yl4qEsIvGhisA9BZafp8M5VTKsgSj9CEQE6
 G3nXf/soxBEIgj2gIo3dZdLGYTeeTC8hBZ+A7I28L3Oxujqlt8o+BehGHwCxmg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/11] net: miiphybb: Drop mdio_init()
Date: Sun,  2 Mar 2025 02:24:52 +0100
Message-ID: <20250302012752.393608-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ssx1m4ii8rxn8wh91nui3sh3wctq3bky
X-MBO-RS-ID: f280da338ac93cc7bcb
X-Rspamd-Queue-Id: 4Z548m52fRz9swT
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

Inline mdio_init() back into mdio_alloc(), separate
access to mdio_init() is no longer necessary.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jim Liu <jim.t90615@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michael Chang <zhang971090220@gmail.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Parvathi Bhogaraju <pbhogaraju@microsoft.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 common/miiphyutil.c | 13 ++++---------
 include/miiphy.h    |  1 -
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/common/miiphyutil.c b/common/miiphyutil.c
index 2a034d3a77c..1298f07815e 100644
--- a/common/miiphyutil.c
+++ b/common/miiphyutil.c
@@ -65,14 +65,6 @@ void miiphy_init(void)
 	current_mii = NULL;
 }
 
-void mdio_init(struct mii_dev *bus)
-{
-	memset(bus, 0, sizeof(*bus));
-
-	/* initialize mii_dev struct fields */
-	INIT_LIST_HEAD(&bus->link);
-}
-
 struct mii_dev *mdio_alloc(void)
 {
 	struct mii_dev *bus;
@@ -81,7 +73,10 @@ struct mii_dev *mdio_alloc(void)
 	if (!bus)
 		return bus;
 
-	mdio_init(bus);
+	memset(bus, 0, sizeof(*bus));
+
+	/* initialize mii_dev struct fields */
+	INIT_LIST_HEAD(&bus->link);
 
 	return bus;
 }
diff --git a/include/miiphy.h b/include/miiphy.h
index 5930fa1b1c9..b4cad2c636f 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -44,7 +44,6 @@ struct phy_device *mdio_phydev_for_ethname(const char *devname);
 
 void miiphy_listdev(void);
 
-void mdio_init(struct mii_dev *bus);
 struct mii_dev *mdio_alloc(void);
 void mdio_free(struct mii_dev *bus);
 int mdio_register(struct mii_dev *bus);
-- 
2.47.2

