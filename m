Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54611C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 15:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27A0880D00;
	Tue, 25 Aug 2026 15:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lFTXZHsTTKV3; Tue, 25 Aug 2026 15:58:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673523;
	bh=9L1E393sxTix7BSmHx1zFXpKaSLfFxBvyje+dXO13W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eHuCBNWU7QlIRWSc4rwlYQehMUkKPGqIha3dpObPviWVob1om5EBtTVUTlwGPBmYG
	 BRDFUTo3Yb124iAGED7xLQfcy5SMMBAf6Z9gZdthhbj9W6cFMa+L9YFaJI+vbAZxLi
	 kvAPtHfABZyQU+VtpyNeWRt/Jb+PHS01OucKiYKO44MRqFE27F9GJZNMujVJnyYeZs
	 i79RYwrV+s7/pcu3tIw67HCzfPYbHn2PGFs8e2W5LSPqi4CGkPosma1dXlR5tCUYii
	 U1xFUCcWAO7dHSCCtsiHm1sT/Kc0/x2sg5Er6vwH3oYqhUb0Dde4mrm60XwxOGHc54
	 EQN+ewwOpgPUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41A20806BC;
	Tue, 25 Aug 2026 15:58:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A89041465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EAEE405B6
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uejwzHxarZhv for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 15:58:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69B2E40497
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:39 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wytXp-000000003td-1TKu; Tue, 25 Aug 2026 15:58:37 +0000
Date: Tue, 25 Aug 2026 16:58:34 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 04/11] mtd: nand: spi: drop the eager ubi_blk binding
Message-ID: <6c801ccba6f947c176ee2d4bd3c47322ea345fbd.1787673209.git.daniel@makrotopia.org>
References: <cover.1787673209.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787673209.git.daniel@makrotopia.org>
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
