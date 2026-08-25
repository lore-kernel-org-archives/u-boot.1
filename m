Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D87C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 15:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CBC96070C;
	Tue, 25 Aug 2026 15:59:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id frFVrguPyR0T; Tue, 25 Aug 2026 15:59:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673559;
	bh=CshCN9xJNs9wLR1aA+2UF1nRVD1IuuUCvxuCECeoLQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bbMJjsvyk92AvPvvlL2KKy/PjJhlCBiAE46WNjqL8nN8pXPic7IQg4esOAXEEAchy
	 lVHgHCVUlnqe3RXg3EXlSJ1mBdrjrxOtHhnbAPgpWsuC2Ig3gOXfd+kE2c21pD4TbZ
	 xlShLdT5ZCPkUBVsJw6pGid244qsl6l2IelJlkB/pxhfgKdjOjjpvagDkUQv7tG2EZ
	 Ed7iLYDPgeH94NSfdOOTvDcbm9qXsy/pZLFzqOfnoG3iOOX9ZOsMtpK4Vd/jDih0bZ
	 TFAxUxVnsK3QuNqAF5L7x7n2pWuBhCboihgRT84IZHzHgk/DQbZ6jzkOEB9TxjPzcq
	 M3VQnlN6Hx7Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A550460604;
	Tue, 25 Aug 2026 15:59:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 603AC1465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 473098081F
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HNl3dA6c6geo for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 15:59:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E4B78081D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:16 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wytYR-000000003uQ-0Kb6; Tue, 25 Aug 2026 15:59:15 +0000
Date: Tue, 25 Aug 2026 16:59:12 +0100
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
Subject: [PATCH v2 06/11] mtd: ubi: block: only claim UBI block devices in
 the partition scan
Message-ID: <95ba335535b0f5585e582cc92d1427e30e57c308.1787673209.git.daniel@makrotopia.org>
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

part_test_ubi() reads the first block and returns success for any
readable device, so a bare block device with no partition table (for
example a sandbox "host bind" image) is mis-detected as UBI once
CONFIG_UBI_BLOCK is enabled. part_get_info_ubi() then calls
ubi_get_volume_by_index(), which dereferences ubi_devices[0] without a
NULL check and crashes when no UBI device is attached.

Fail part_test_ubi() when no UBI device is attached, and guard the volume
lookup and print helpers against a NULL ubi_device, so the driver only
claims devices while UBI is present and never dereferences a missing one.

Fixes: aa5b67ce226 ("disk: support UBI partitions")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/part.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/ubi/part.c b/drivers/mtd/ubi/part.c
index 6c017eb7299..e1bdd9e3008 100644
--- a/drivers/mtd/ubi/part.c
+++ b/drivers/mtd/ubi/part.c
@@ -19,6 +19,9 @@ static struct ubi_volume *ubi_get_volume_by_index(int vol_id)
 	struct ubi_device *ubi = get_ubi_device();
 	int i;
 
+	if (!ubi)
+		return NULL;
+
 	for (i = 0; i < (ubi->vtbl_slots + 1); i++) {
 		struct ubi_volume *volume = ubi->volumes[i];
 
@@ -66,6 +69,9 @@ static void __maybe_unused part_print_ubi(struct blk_desc *dev_desc)
 	struct ubi_device *ubi = get_ubi_device();
 	int i;
 
+	if (!ubi)
+		return;
+
 	for (i = 0; i < (ubi->vtbl_slots + 1); i++) {
 		struct ubi_volume *volume = ubi->volumes[i];
 
@@ -83,6 +89,9 @@ static int part_test_ubi(struct blk_desc *dev_desc)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, dev_desc->blksz);
 
+	if (!get_ubi_device())
+		return -1;
+
 	if (blk_dread(dev_desc, 0, 1, (ulong *)buffer) != 1)
 		return -1;
 
-- 
2.55.0
