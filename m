Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913B3C5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B9886075D;
	Sun, 23 Aug 2026 19:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id prM3oM5tF_rA; Sun, 23 Aug 2026 19:13:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787512434;
	bh=9L1E393sxTix7BSmHx1zFXpKaSLfFxBvyje+dXO13W4=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XsDinyNm7b8zTVQ8ydhVl1WQ7Mhg9FkHQtKAu+cM0FUfLjttdvCrYQlu+98DZR6Ay
	 nwuk+JA9tRu5C6oQ6tlKEFNiZkjGTClWk9uQfiHCBTkrtnPYbfpjvgMTA0ih7P+mBk
	 ZfkkS+DRji1lI8QUu3NxCoEN4hHz64dHP3oKctlEd1YUCCWEyiDqwgTvxkXAUZj+Xe
	 t3AhVnXEKWi9aA4hEoxeo/9G2BFrIytKDOypEnCU9AMAoOxc0crd9xh/aVf4Llh/eE
	 RYj7i2WlCMFBZ4noXCYXJmiGAWnlWX85bVxsN6oJ3OtM6k4YQ+6Ui8XlmdcPsmlIFk
	 SkntgdFlUKAyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 632986072A;
	Sun, 23 Aug 2026 19:13:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 72F7742B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 654F340059
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:13:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2wc8JJRhNv8e for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:13:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C38640057
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:13:52 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wyDdX-000000001lw-0Jko; Sun, 23 Aug 2026 19:13:43 +0000
Date: Sun, 23 Aug 2026 20:13:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>,
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 4/9] mtd: nand: spi: drop the eager ubi_blk binding
Message-ID: <d1dec0e27adf1e4a466336b19b87f153b4613b08.1787272661.git.daniel@makrotopia.org>
References: <cover.1787272661.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787272661.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

spinand_bind() binds a ubi_blk device at bind time. Now that "cmd:
ubi: create a ubi_blk device when attaching UBI" binds one generically
when UBI is attached -- with an identical result, only lazily and for
any flash type -- the SPI-NAND-specific eager call is redundant.

Drop it to avoid the duplicate code path (a ubi_blk is unusable before
UBI is attached anyway). The mtd_blk binding is kept: bare mtd_blk
access to SPI-NAND remains available for users who want it.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/nand/spi/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 14af4264612..fb8ca0a787d 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1654,9 +1654,6 @@ static int spinand_bind(struct udevice *dev)
 			if (ret)
 				return ret;
 		}
-
-		if (CONFIG_IS_ENABLED(UBI_BLOCK))
-			return ubi_bind(dev);
 	}
 
 	return 0;
-- 
2.55.0
