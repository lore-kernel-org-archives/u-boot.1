Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F02C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EC686074E;
	Sun, 23 Aug 2026 19:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iJxJtPbV0aLM; Sun, 23 Aug 2026 19:13:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787512402;
	bh=K0saYYd6pQ/r0mi9/fbkE5mZe/i9S9qQr0TVo22/kaI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TKYyMFmW5AOliLjnZbjp1lc2ouzQZXfbzczhDCxS2fS4EvUJ00hb/nFrzR4AyYEso
	 HlP7Oca9FhdY8MMf/7vxnR1MHSIIGccQdwCueM1PehivKYFJ1q1mVVo9KZlX3K0rO7
	 ylR6aVQ5B5wDgszvPFeRg3TCz6jR6q3eP4UzgyXZUawzRTF5CfoVLIAqhEtvPt/8Om
	 ikE6KvVTDWtqueUJKVGYCVPPZ6ZJlXGwjsFbq8AowWHCpxC95E1+AFwhA6BLaoGn1j
	 cPlcivOChBtxQg737Orky4Bwfws8lMLkghpOcPxKNmjHMCKGYv82ngSEdjupVRPOSg
	 59AwK8QNRikww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1706C606ED;
	Sun, 23 Aug 2026 19:13:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2514336
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C43EC606ED
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYSzg6GjoJ5c for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:13:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEFAA606C5
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:13:19 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wyDcv-000000001jE-3tul; Sun, 23 Aug 2026 19:13:06 +0000
Date: Sun, 23 Aug 2026 20:13:02 +0100
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
Subject: [PATCH 1/9] mtd: bind an mtd_blk device for non-NAND MTD masters
Message-ID: <84040f2872e5df8667841a526a07b4c702de8511.1787272661.git.daniel@makrotopia.org>
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
