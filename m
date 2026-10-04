Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B38CA5FE4
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 04:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 228B840711;
	Sun,  4 Oct 2026 04:07:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6UXwJH-3lJnP; Sun,  4 Oct 2026 04:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5DFF14072C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791086839;
	b=e7ArOcWkM7tDZXPSbFN4EMQZR7hFMaM5xOabusQiiTGuRn9diHbJaDyD1MuQreONIqHn
	 9lq4cXG7BOp+0lojXCD6nzuZCD33HbjRpTZzBtRu3zcdysGaIejKhNMgkpqLKTzd5Dd/G
	 CF9ZnfnXwRQ7YUKn8TPnMjfo4ByrFgsXmT5L2VC4UoWchOmU3sjvoDp0T9KHGdjYPzwZ0
	 djBJ9IYNaOLXFXBy6hPPaCF/J0uUklvOrKsxKfb1oSL/f6Tx2u9pyExROpieMvNlfKI0s
	 w/vdQ5ZtKw3Tfzk8KOk57rOE6/0ah4Eb/NBy554CeoBensUdKyfXAy+sFnOt885dGeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791086839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xqxcDJ1LUUuswzYHq3NkT9IpllalIU73CwmQCMQZs/o=;
	b=DUCWe1+okmlUip5VBsM7SdF+qPiFyk1x8wjWWx8QTovCbqzP1q/EcJPcSZKjzf3Fm/ux
	 +/tJgTNZymAHmFMtxWJrb0EQRdUzqivRT2CzvvraAe1+Q4G4jKED1kjSetEZORXjRDbEt
	 1MIB2hnqXnBE0ynGBjWGAKBEZr4e5fl6RcC8EvcXvPf3b8v7yue3Vj7lGa9ZdBPjN99uy
	 +U6OCNdRZuV9x9a1gpMtcQhbe5HHA1eXzXVfc2bO5niT8WdGvFyccwNscLKGriDVAmVZl
	 h8fnPHiAbAxpOMiU04IEMPyp6WJykgKfNd8s4LXcTV7J2JmYqC3G3DVaJ99WrJVIGtQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=BzPKQ28s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791086839;
	bh=xqxcDJ1LUUuswzYHq3NkT9IpllalIU73CwmQCMQZs/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wDeIu1QJmemQVFNCpaJmJAcQt9UA7vPQpAFTekXAGDv3Q47LsvsgR0R6P+Rt3Lnru
	 ruOZ7RMQwih7I1fBCYRg6TGYux2mL+fHyohNn9N1sjA+ctTvDy2sXvdTCPvnc/oNAI
	 6jLQ+toO/oleGYlpNwuGssH04OibKVbJV/y1ocHC1gEPRS9FiJxP+BbTrb1fo0nNtd
	 FPgirYE8TCKVPBuDE8arI4PV+6E2A3geMYkt6v8YLtx550fPzI8uHbTqSJoY8DraJA
	 jWEn+DEQviq0Ypg9IEfE+HD4Z845x3mGLEvSko0JJsg0nfaRsTugtoiuXMpI6be1yN
	 CPurH1aChGK7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DFF14072C;
	Sun,  4 Oct 2026 04:07:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CDD5335
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EE534072C
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qiOHNGY5ivOM for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 04:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 45D9840711
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791086833;
 b=pW4ywkNMyH9XNVXuiLKQdJwhaXxpxFymYFyxkIEeTCJ+3LGrMDudYsiZTCMWOZnZXRNv
 LGNN0RdNgrvSxu9tUznsEgLoj3Esh6YIW9+QK5jrA3TsuQXoV7e2nVk17xZ63LpoVx3LO
 XfOP5QN3aVw8Qrcz58M+KcU3NK9GfnunlcAXqkcLr55zIOad5TPfUR65mGqkmKWESFFxM
 KntgPjajMugcD4X+8Ad2pVdvnX5kJL2VC+p4v4H/3UynAp4k3UmZaERb51Tnzpo8C8RU8
 GIPhdTf92p8Vk0BgK5wqjTH83XQYJxn2VwGC1Q8Hoic7/AomnRecC1Ba0WzZ/SWqFrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791086833;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=xqxcDJ1LUUuswzYHq3NkT9IpllalIU73CwmQCMQZs/o=;
 b=XfnoAgqIxyj4BhRwmQORkIw6Hpm4gLarrvvcf2Ua9zU5wEJbo2inNnYjYAMMR41DVWom
 jpgD/mlTXanPpMZsZCb1URCDSwCzpZtqpx8uGyGokVFByQLxw97KlvXP4OBLu+Pn9H38N
 xO2xe9ncRe0v1/xFMf0DalGxWv1F4sB9fGhqJSW/GzCuOJ2rrlm7sf1M3rzntCUqLPLnG
 LFeN1hQ+9NxucCKIPJ+kWJVbdH9jL4HiVw28EeQhG1zPWAhXDvg1WygdkIbSdNXdorqPr
 nUqSpoCwgt3cdgLKyJcllIJ9IEg0Z35qvfVEfti7F7+NnrlqBzGPCt5ySmarsFuNC8w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=BzPKQ28s; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=BzPKQ28s
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45D9840711
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 103BC107A25; Sun, 04 Oct 2026 06:07:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791086830; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=xqxcDJ1LUUuswzYHq3NkT9IpllalIU73CwmQCMQZs/o=;
 b=BzPKQ28sr88U9dFOFNwpYd0a2zUJx/IcTyBAZkcq+H9UmgL4AfFZlyangvasl3j+ILHpvd
 ffJaIyO5anlo3qEgNAJAtrd9R0eAUYQMVNnlrX7YOSH+lqS8Mf+8nnRndQ0ENw1gUJbsrO
 miL4fHyzN8Z8mC6PrcD30sCMepjN3nFG5T1oeMf2JC1GiwSnazFlSgmZ+SsWvBnZHgtMij
 sfc8vKBOALnBkjlZTA3gMBumFEpC09FMf1wHH/zCXPZPjtcJZwvdziiHVL2RO9yP0kstfo
 hpgxVXYnKmrnCPiMAK0OLpoCSiUJ1iiTQnHkUnn0+su9ygkiXusHmU/sVUvdHA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/5] mtd: align a partition on the write size if the device
 cannot erase
Date: Sun,  4 Oct 2026 06:06:46 +0200
Message-ID: <20261004040657.3156402-3-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004040657.3156402-1-hs@nabladev.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

allocate_partition() aligns a partition on the erase size of its master
and checks the offset and the size against it with mtd_mod_by_eb(). A
device which cannot erase has no erase size, so that check divides by
zero, "mtd list" shows

	### ERROR ### Please RESET the board ###

Linux aligns the partition of such a device on the write size instead,
see wr_alignment in allocate_partition() in drivers/mtd/mtdpart.c. Do
the same here, and take the alignment for the MTDPART_OFS_NXTBLK
rounding from the same place, which divided by the erase size as well.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
checkpatch reports two warnings and four checks on the two
printk(KERN_WARNING"mtd: partition ... force read-only\n") lines.
This patch only changes s|erase block|erase/write block in the
string of the print, so ignoring the warnings.

Changes in v2:
- New patch mtd: align a partition on the write size if the device cannot erase
  Testing on the board dropped for "mtd list" command:
  ### ERROR ### Please RESET the board ###
  This is because division by erase_size, which the SPI RAM driver
  sets to 0. Added for this case also sandbox test.

 drivers/mtd/mtdpart.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index a3003cf44b0..eed0add71ff 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -563,8 +563,12 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
 					   const struct mtd_partition *part,
 					   int partno, uint64_t cur_offset)
 {
+	u32 wr_alignment = (master->flags & MTD_NO_ERASE) ? master->writesize :
+							    master->erasesize;
 	struct mtd_info *slave;
+	u32 remainder;
 	char *name;
+	u64 tmp;
 
 	/* allocate the partition structure */
 	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
@@ -665,9 +669,11 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
 		slave->offset = cur_offset;
 	if (slave->offset == MTDPART_OFS_NXTBLK) {
 		slave->offset = cur_offset;
-		if (mtd_mod_by_eb(cur_offset, master) != 0) {
-			/* Round up to next erasesize */
-			slave->offset = (mtd_div_by_eb(cur_offset, master) + 1) * master->erasesize;
+		tmp = cur_offset;
+		remainder = do_div(tmp, wr_alignment);
+		if (remainder) {
+			/* Round up to the next alignment boundary */
+			slave->offset += wr_alignment - remainder;
 			debug("Moving partition %d: "
 			       "0x%012llx -> 0x%012llx\n", partno,
 			       (unsigned long long)cur_offset, (unsigned long long)slave->offset);
@@ -731,19 +737,30 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
 		slave->erasesize = master->erasesize;
 	}
 
-	if ((slave->flags & MTD_WRITEABLE) &&
-	    mtd_mod_by_eb(slave->offset, slave)) {
+	/*
+	 * The erase size of the partition may differ from the one of the
+	 * master if the master exposes several erase regions. Align to the
+	 * one the partition ended up with.
+	 */
+	if (!(slave->flags & MTD_NO_ERASE))
+		wr_alignment = slave->erasesize;
+
+	tmp = slave->offset;
+	remainder = do_div(tmp, wr_alignment);
+	if ((slave->flags & MTD_WRITEABLE) && remainder) {
 		/* Doesn't start on a boundary of major erase size */
 		/* FIXME: Let it be writable if it is on a boundary of
 		 * _minor_ erase size though */
 		slave->flags &= ~MTD_WRITEABLE;
-		printk(KERN_WARNING"mtd: partition \"%s\" doesn't start on an erase block boundary -- force read-only\n",
+		printk(KERN_WARNING"mtd: partition \"%s\" doesn't start on an erase/write block boundary -- force read-only\n",
 			part->name);
 	}
-	if ((slave->flags & MTD_WRITEABLE) &&
-	    mtd_mod_by_eb(slave->size, slave)) {
+
+	tmp = slave->size;
+	remainder = do_div(tmp, wr_alignment);
+	if ((slave->flags & MTD_WRITEABLE) && remainder) {
 		slave->flags &= ~MTD_WRITEABLE;
-		printk(KERN_WARNING"mtd: partition \"%s\" doesn't end on an erase block -- force read-only\n",
+		printk(KERN_WARNING"mtd: partition \"%s\" doesn't end on an erase/write block -- force read-only\n",
 			part->name);
 	}
 
-- 
2.55.0

