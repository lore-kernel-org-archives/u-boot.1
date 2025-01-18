Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE60C02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F117807DC;
	Sat, 18 Jan 2025 07:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="t7NtZQoz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I9jS41H/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669C0807E9; Sat, 18 Jan 2025 07:54:53 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C4E807D6
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YZnQz0hDFz9sjF;
 Sat, 18 Jan 2025 07:54:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7w03rZNTcCz3vGnU1/GjisrbIYzsAQQaRY9Lagr3/M=;
 b=t7NtZQozEa5To09sKDwe7VO1AC1nd+dT79J/C6ILokG+1QzCB2s/qsC6o3JAtvcgyE8tM+
 kaopIdh0KxjzMP0HTeiDu9jVXsforGIWnkdTDihBTh3kQI6sGN2sYSAoG3eLs5nXpI2oyt
 ilnrP43HMOE/p/ruE5qHJqzqkLVVL+4h5qQlkzPsAIkIwq3vMZVTo5hGdpT+RYpLo0CXWP
 +5SiqFgs7UdcaGRLd/ABDtVXe7mtMux7BAl5v83h+dyrRNZSoEdFWHQOgR1maoSHmQBqKh
 HKBwqg/rUwAcn3zbfOFMxEzSj96YUOG6VoSrNbjWp8ZY24F7OBLBnQZRdx1GuA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7w03rZNTcCz3vGnU1/GjisrbIYzsAQQaRY9Lagr3/M=;
 b=I9jS41H/Yv4he1RwFALNE3kEsgH4kAXy8E80qyHLYbQ4xM50UEQC6uUcZWPtAyvDI5QEhy
 lZqsWTdLLU7kgSqhmr+DqCMMzWIAML6m4bqJNI1kv8ScoorKJkcakaaLWhFRFh6hs2ihS3
 QqLW8+Ncgf4jqAXMuDkUgt3TcYXuRnt67/XMElgXIcygNvftH5XbElIZRNXY5SPAp29veR
 CCO2YPHleEyPIb2OOJoIagUtIhrJcW810pGZo3kq9Od3+1Zkx5fgDvz5P0LgfYejfdIR4P
 9XAIanFf/KhT0d6rDZ0wt6HDIypq/McWsV/s35GYbZIt2FSZVKvb3Nyli9twFw==
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
Subject: [PATCH 12/17] net: miiphybb: Drop bb_miiphy_init()
Date: Sat, 18 Jan 2025 07:53:16 +0100
Message-ID: <20250118065402.172253-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xg15nmkmt7ethikyeh5ic64rtac8ieig
X-MBO-RS-ID: cf8e638b9ca21c3a6c3
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

There are no more users of the init callback, drop the entire mechanism.

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
 common/board_r.c           |  3 ---
 drivers/net/phy/miiphybb.c | 11 -----------
 include/miiphy.h           |  8 --------
 3 files changed, 22 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 179259b00de..db0c5cb8032 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -749,9 +749,6 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_BOARD_LATE_INIT
 	board_late_init,
 #endif
-#ifdef CONFIG_BITBANGMII
-	bb_miiphy_init,
-#endif
 #ifdef CONFIG_PCI_ENDPOINT
 	pci_ep_init,
 #endif
diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index cdb0ee9dc8a..27654347725 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -18,17 +18,6 @@
 #include <miiphy.h>
 #include <asm/global_data.h>
 
-int bb_miiphy_init(void)
-{
-	int i;
-
-	for (i = 0; i < bb_miiphy_buses_num; i++)
-		if (bb_miiphy_buses[i].init != NULL)
-			bb_miiphy_buses[i].init(&bb_miiphy_buses[i]);
-
-	return 0;
-}
-
 static inline struct bb_miiphy_bus *bb_miiphy_getbus(struct mii_dev *miidev)
 {
 	return container_of(miidev, struct bb_miiphy_bus, mii);
diff --git a/include/miiphy.h b/include/miiphy.h
index 03ae4e0078a..9d9fe58b41c 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -79,14 +79,6 @@ struct bb_miiphy_bus {
 extern struct bb_miiphy_bus bb_miiphy_buses[];
 extern int bb_miiphy_buses_num;
 
-/**
- * bb_miiphy_init() - Initialize bit-banged MII bus driver
- *
- * It is called during the generic post-relocation init sequence.
- *
- * Return: 0 if OK
- */
-int bb_miiphy_init(void);
 struct bb_miiphy_bus *bb_miiphy_alloc(void);
 void bb_miiphy_free(struct bb_miiphy_bus *bus);
 
-- 
2.45.2

