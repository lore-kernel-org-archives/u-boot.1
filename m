Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDB2C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 15:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92CA24037B;
	Tue, 25 Aug 2026 15:58:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ah5rwhke8TiB; Tue, 25 Aug 2026 15:58:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673503;
	bh=3olz7BJwe1bxxFhdPMTc+kJ6hS6QAr5MZ/vs/ml+V+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aocQlOTfgJ85cceWfRovXKVoKzrKAEbvrvZeoyC4mx3T1o3v9Tp8/LJD3tIWXm0EB
	 p65jxI+RO3LP9A9Zhw2y8ynjACWToAe7skrxVB4KF4th4fE7xKJ7nLJOPRqk+H7S7U
	 dEfhA0LXK0Mv3B0sTfENxG80pxxhppKRhOrWk/vtvrt9eMzvRH2bVYw/8HhgZvmUPj
	 UBRm/Bork4oMW4tG5EI11YBEDlYGz/+TfpLTqlqdcXjWEcJOyHFU6anjcXaeWoJClI
	 I2iWMTTWOPo4WCH/iGI+m2SLY5FVHHv9AOyD53X/6iVtknJ9gD0hamEcc2rjDUBrk1
	 XB3iOwxYaTz0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AC7540372;
	Tue, 25 Aug 2026 15:58:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 677952FD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DFA880D09
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NROxYKHG6vlc for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 15:58:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD9F280D05
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:19 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wytXV-000000003sc-37r6; Tue, 25 Aug 2026 15:58:17 +0000
Date: Tue, 25 Aug 2026 16:58:15 +0100
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
Subject: [PATCH v2 02/11] mtd: nand: sandbox: forbid sub-page writes
Message-ID: <c5c51ef5afcb79782b03ba63f131e715ccfda429.1787673209.git.daniel@makrotopia.org>
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

The sandbox NAND model programs each page in a single operation and
rejects a second write to an already-programmed page. UBI writes the
EC and VID headers into the first page in two separate sub-page
operations, which the model fails with -EIO, so UBI cannot attach to a
sandbox NAND.

Advertise NAND_NO_SUBPAGE_WRITE so callers place each header in its
own page, matching what the model can actually do. This lets the
imagemap UBI-volume unit test attach UBI on the sandbox NAND.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/nand/raw/sand_nand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/sand_nand.c b/drivers/mtd/nand/raw/sand_nand.c
index 3678bb8a41b..5c48b43a882 100644
--- a/drivers/mtd/nand/raw/sand_nand.c
+++ b/drivers/mtd/nand/raw/sand_nand.c
@@ -602,6 +602,8 @@ static int sand_nand_probe(struct udevice *dev)
 
 		nand = &chip->nand;
 		nand->options = not_xpl() ? 0 : NAND_SKIP_BBTSCAN;
+		/* Each page is programmed in a single operation only */
+		nand->options |= NAND_NO_SUBPAGE_WRITE;
 		nand->flash_node = np;
 		nand->dev_ready = sand_nand_dev_ready;
 		nand->cmdfunc = sand_nand_command;
-- 
2.55.0
