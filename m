Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B433CC5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66A1140575;
	Sun, 23 Aug 2026 19:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8mh4EjpEnYYM; Sun, 23 Aug 2026 19:13:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787512414;
	bh=3olz7BJwe1bxxFhdPMTc+kJ6hS6QAr5MZ/vs/ml+V+o=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NALLRTarujhLvoE9WahqHeReCxjBkQTsn0go0J9zplRsLaXDl2JHLfUo9HysC77OQ
	 T/JeO1dZjBtnvnYqKBx9kDjoWrpwFrGOP9dJneTH3RTetNu8m1GBqdTTs/n/ISDRe/
	 fZwukkvIYTQpND48HVHwa2aIOq8UKUFcSdOnrfKvN4g7zH4E31KlcVN/k6zupSZicM
	 9vh4czs8ytwlZUSLK4mWMEI5yA7iqL9paUwJ18zaLtyx7L92GlNGegcl3qVOt/jigK
	 FMxaWtBfYO6oKuHMKP/nEBeYe3li5Gacd7dj/a0nBZ3c56fMTSz09+fBLlzbm+yDgk
	 GnE/c2lyAn01g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5003040587;
	Sun, 23 Aug 2026 19:13:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AB4E41A
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20DF260746
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IBftNlq73CEy for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:13:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24CC960744
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:13:31 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wyDd9-000000001jn-0eoK; Sun, 23 Aug 2026 19:13:19 +0000
Date: Sun, 23 Aug 2026 20:13:15 +0100
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
Subject: [PATCH 2/9] mtd: nand: sandbox: forbid sub-page writes
Message-ID: <99a003542ea5ba616bcaf7b60136be6943079f89.1787272661.git.daniel@makrotopia.org>
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
