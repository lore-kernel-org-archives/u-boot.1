Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1958C0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C295A80C83;
	Sun,  9 Feb 2025 13:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VTNw6yrN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="w9/BsZXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3076580C77; Sun,  9 Feb 2025 13:04:59 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A12480A29
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YrRGc5Cptz9sQb;
 Sun,  9 Feb 2025 13:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUwfDDPQqUdSy6prHy3LyrZwVD5xqL78ZNCraYo2cXo=;
 b=VTNw6yrNLyJcYmki/FId0IaDQhi0LNz8Nw1UtSLi3YYtBsPwkPC50Fa1z9/jEIYMTPRQ8+
 j5kW/236JlmEomXwY8+4xA7fOTJLo4SpX+ngrCVjvkW+U43WcepOhZtr7TpLmX2uK3EmwO
 29EYrc3eYPQZ23JCoNMm97mwR5elNjzHuBxp26vRU25mNghrRrraRNPwt7Gt/u9gnkDIy+
 5J47pcmWIvGv27MGCwjxTz8fDvbx1wEekD2ToTJFHLc9Un0/QWZaeEvuiSANvn4DNgphQG
 juYYvNLL+he6GEi53AEhpcfVC+XNVZqW340tJPK1TSI2Sz0sslnq0eDYb2LHow==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUwfDDPQqUdSy6prHy3LyrZwVD5xqL78ZNCraYo2cXo=;
 b=w9/BsZXXzf/Bwwyg+QgHEuJ07upIKr8+EomYmwf+n/6gnaWqdIXK7/28Uj9988YajzZLyb
 PuuUvAQC5naElWR312o30OdP67ZBO2ERUC4Jkzc8OyXSc3OjjciSr0RL0mtKoFfaAnUMHO
 RkP42VB10+WdqeNZtKaLSNZH/3/1SQk1hzIOeoJw1NvR6YD8/Wgb5uje66YoOEP/sJlxeZ
 g5E2dpn1tiXv+mEyX9JDcd0x5O35OLiQul0ZNxu4PtSeTwWCHEOgvZRT4Qvrz/RXp9Yza9
 9sZNS1bg3iINwiw4DkFsuhdqoApeyGHwXsPiYiwBnMaXs5F4JBB6ZlGG6BT0Hw==
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
Subject: [PATCH v2 09/24] net: miiphybb: Drop bb_miiphy_init()
Date: Sun,  9 Feb 2025 13:01:35 +0100
Message-ID: <20250209120403.5321-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 850b9aec8562146bd05
X-MBO-RS-META: g5ec91u7sftfatnqpdhprwmbxmf9cqes
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
V2: Reorder this earlier in the series
---
 common/board_r.c           |  3 ---
 drivers/net/phy/miiphybb.c | 11 -----------
 include/miiphy.h           |  9 ---------
 3 files changed, 23 deletions(-)

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
index 9f5f9b12c9f..75d9537b355 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -17,17 +17,6 @@
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
 static inline struct bb_miiphy_bus *bb_miiphy_getbus(const char *devname)
 {
 	int i;
diff --git a/include/miiphy.h b/include/miiphy.h
index 1e6c7041fdc..2485cb880ab 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -78,15 +78,6 @@ struct bb_miiphy_bus {
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
-
 int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg);
 int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
 		    u16 value);
-- 
2.47.2

