Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B08C021B8
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 01:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684A9811DF;
	Sun,  2 Mar 2025 02:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="p+Jp3/Uu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vL2yNVbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13DA581253; Sun,  2 Mar 2025 02:28:42 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A528058A
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 02:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z548j5wKtz9sQb;
 Sun,  2 Mar 2025 02:28:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ik0elKOjAe0FfUmpDvMHuc8OfBj8faRinyoslDiK154=;
 b=p+Jp3/UuF9wIn5HkNmR4LxyUwyhSgpZxlkKGiyO9V5VlNfbq7HTvBsoggdjgZqat3DCmOT
 qdr0L6pwhSGMK5ZCKqqIew9STrZXzpE1k7gdneW7DiMNWZD66e5aPBs7UeJYSx0tlKMMQq
 w4WB6WtzzKoHn3g7Szls6PVxYifxHWTz4flmHuglwrj3aJIGx9JAyCoDIgchGoGYIO3ZMf
 +0OgeKGW97f31bH0dOL7KKRxS8gBftzsFylk6gCXJ+WnZalp+TgMYtQ3YMBGBxbBwPOzAd
 71LEThz38gcb91MasStECIUB45E5E7rZ+/+9XiocXb/UEZWTqxOSEp5wY4YAVw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ik0elKOjAe0FfUmpDvMHuc8OfBj8faRinyoslDiK154=;
 b=vL2yNVbEHuCmBfJyZmlLqecoDExoY22NAydoGVAQd8CGKHIjKEZQekhfe3ozXfp0jITvPx
 UhkItnj2aO8vu7rqdnw6XOkY9ONL0qaGMaG+WkL+xkIWju9GNF4zU9DTjaCq38AlR79LMK
 LAHAiMK2Y+EOVkg9lgGqtiejOXgLn/pPT9ToNsLX0J9d4cnwrZYV9kjAYT/jInot276Vhx
 pXqNwGsHxbxmu0NtcO5F0wuov08s5YOpWKBcUdfZw8E6coCUvwzTvjBBcTKHDSmXgypd8w
 JazWXBMSTzgQZ1gblvifHpKGfGS7fc+hQWdymfmXaDTzy4WZaNo/vHH8UtXXPQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/11] arm: mvebu: a38x: Switch back to mdio_alloc()
Date: Sun,  2 Mar 2025 02:24:50 +0100
Message-ID: <20250302012752.393608-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4p5ryeqtykgpcyzd8347mqr6tnyhg145
X-MBO-RS-ID: af3b9889d7d892304c5
X-Rspamd-Queue-Id: 4Z548j5wKtz9sQb
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

Use mdio_alloc() again to allocate MDIO bus. This is possible
because all the miiphybb parameters and ops passing is handled in
at bb_miiphy_read()/bb_miiphy_write() level.

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
 board/gdsys/a38x/ihs_phys.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 7aa427e0312..d51301869cd 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -244,14 +244,9 @@ static int mii_bb_miiphy_write(struct mii_dev *miidev, int addr,
 
 int register_miiphy_bus(uint k, struct mii_dev **bus)
 {
-	struct bb_miiphy_bus *bb_miiphy = bb_miiphy_alloc();
-	struct mii_dev *mdiodev;
+	struct mii_dev *mdiodev = mdio_alloc();
 	int retval;
 
-	if (!bb_miiphy)
-		return -ENOMEM;
-
-	mdiodev = &bb_miiphy->mii;
 	snprintf(mdiodev->name, MDIO_NAME_LEN, "ihs%d", k);
 	mdiodev->read = mii_bb_miiphy_read;
 	mdiodev->write = mii_bb_miiphy_write;
@@ -260,7 +255,7 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 	retval = mdio_register(mdiodev);
 	if (retval < 0)
 		return retval;
-	*bus = &bb_miiphy->mii;
+	*bus = mdiodev;
 
 	return mii_mdio_init(k);
 }
-- 
2.47.2

