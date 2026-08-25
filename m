Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C2EC61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 15:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBA3D80CD3;
	Tue, 25 Aug 2026 15:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yfnThBP93CvS; Tue, 25 Aug 2026 15:58:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673495;
	bh=K0saYYd6pQ/r0mi9/fbkE5mZe/i9S9qQr0TVo22/kaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dzm/0ZtzQnFmWAzOj0+rBH1ETjmbehsnQGd8r5ed2gUPp+1DmcaeG9cd0ksEsi5rI
	 bvdB0M459MO/E46SW1diiu8hUVB0GdAFkbluJP9F1mtqtSBnUXw2xZD7R/iOuBCpVb
	 /kCq/4m2ETifprG7G52lw59UXHERccjEl2S3sFdZTTEOXVlCCLbyq8fzFULmv+3bS/
	 64v4K+1YNSBZWmWt2WB46sawJn5iURSqi3MoAN/5s9d5aGQhx8U/Gh90VoQMhriCEx
	 YW8L88/jyX8lmlIAWt1jFKMcqrV/kshQLwdQ2NApqgHwoSFPVIXpuRYVTRoCSjhNdr
	 MUSPPoxpVIZmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D553806BC;
	Tue, 25 Aug 2026 15:58:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 633ED1465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49B7E40149
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lBuVH8cnNvuu for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 15:58:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3544740092
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:58:12 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wytXO-000000003sH-0Yls; Tue, 25 Aug 2026 15:58:10 +0000
Date: Tue, 25 Aug 2026 16:58:07 +0100
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
Subject: [PATCH v2 01/11] mtd: bind an mtd_blk device for non-NAND MTD masters
Message-ID: <e169e47b65b0079b64e9cf0631876c5b1d86f977.1787673209.git.daniel@makrotopia.org>
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

Only the SPI-NAND bind path currently creates an mtd_blk block device,
so a bare NOR (parallel NOR, SPI-NOR, ...) has no block-device access
at all. Bind an mtd_blk device for every non-NAND MTD master when
CONFIG_MTD_BLOCK is enabled, so its partitions become reachable
through the block layer (and thus by bootstd, imagemap, ...).

NAND is excluded on purpose: it needs UBI, which brings its own block
device. Partitions inherit the master's block device via the "mtd"
partition type, so only masters are bound.

mtd_bind() keeps a pointer to the passed mtd_info pointer (SPI-NAND
fills it after bind), so the generic caller provides a small heap slot
that lives as long as the block device; an MTD master is never removed
in practice.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/mtdcore.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3bfa5aebbc6..e0d0b5ae2e9 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -494,6 +494,30 @@ int add_mtd_device(struct mtd_info *mtd)
 #endif
 
 	mutex_unlock(&mtd_table_mutex);
+
+	if (IS_ENABLED(CONFIG_MTD_BLOCK) && mtd->dev &&
+	    !mtd_is_partition(mtd) && !mtd_type_is_nand(mtd)) {
+		/*
+		 * Expose a non-NAND MTD master (parallel NOR, SPI-NOR, ...) as
+		 * a mtd_blk block device, so its partitions are reachable
+		 * through the block layer (and thus by imagemap, bootstd, ...).
+		 * NAND is excluded: it needs UBI, which brings its own block
+		 * device. Partitions inherit the master's block device via the
+		 * "mtd" partition type, so only masters are bound.
+		 *
+		 * mtd_bind() keeps a pointer to the passed mtd_info pointer, so
+		 * it needs storage that lives as long as the block device; the
+		 * MTD master is never removed in practice, so a small heap slot
+		 * is fine.
+		 */
+		struct mtd_info **mtdp = kmalloc(sizeof(*mtdp), GFP_KERNEL);
+
+		if (mtdp) {
+			*mtdp = mtd;
+			mtd_bind(mtd->dev, mtdp);
+		}
+	}
+
 	/* We _know_ we aren't being removed, because
 	   our caller is still holding us here. So none
 	   of this try_ nonsense, and no bitching about it
-- 
2.55.0
