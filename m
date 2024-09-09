Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4596FECE581
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 23:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F59C88B6C;
	Tue, 10 Sep 2024 01:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hZxW1eiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E131488E5D; Tue, 10 Sep 2024 01:23:46 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FEA88549
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-160-200.46.114.pool.telefonica.de
 [46.114.160.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 76A963F776; 
 Mon,  9 Sep 2024 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1725924223;
 bh=g0BnHe3K8K1vKJzlAfH91THO4QJxuJPghJhrREBIaic=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hZxW1eiOazfKQqtu7Yql9ntOWyqsq20Y+bPT+iO7CfjlDHMumQ2OB25qzmgy6TlRg
 b32iptbVWYAXPODPzvS6GJxT/bImYlB3nYbFAii7y2NDcfAEWfvFoMbUXb326qF11w
 Oty9RfNundONONmJTEEyQEb1p8aPDVX1b7kxYnt0N+cMd900tmWAKluZtltShx88OL
 wy3g9fzB+sFGeppkI65AlckCrY0I5JzS1nInx4jLNmzSyrH5cfbG8CEWcXfCM0kDtG
 B+J7U1VOUijGEWpi+yDela4ivLf3S0iwVyNAtjE2l/n/4Y05MfN/M5lCHHm+s1Afi3
 8TOY2NzOu3nRg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: mtd: simplify mtd_show_device()
Date: Tue, 10 Sep 2024 01:23:34 +0200
Message-ID: <20240909232335.20440-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

CONFIG_DM=y is always true.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/mtd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 795aaa2b37d..260b26076ed 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -121,13 +121,11 @@ static void mtd_show_device(struct mtd_info *mtd)
 {
 	/* Device */
 	printf("* %s\n", mtd->name);
-#if defined(CONFIG_DM)
 	if (mtd->dev) {
 		printf("  - device: %s\n", mtd->dev->name);
 		printf("  - parent: %s\n", mtd->dev->parent->name);
 		printf("  - driver: %s\n", mtd->dev->driver->name);
 	}
-#endif
 	if (IS_ENABLED(CONFIG_OF_CONTROL) && mtd->dev) {
 		char buf[256];
 		int res;
-- 
2.45.2

