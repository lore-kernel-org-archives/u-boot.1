Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A178606A321
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=atzhOaG3;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=hredb80+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02C3F80D7A;
	Wed, 28 Oct 2026 06:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hb36-m7__-_V; Wed, 28 Oct 2026 06:13:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 315A480DC3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793168012;
	b=ew6B7V2x7MZjnwl6JjtOSeHrOTqA0aEs5QT546KJsIuwRkCtx2S1AoRpilj9r5z0Rseo
	 8fDmWCG7JJCqMOvuyvCsT8BanLXgjt+F6UgXI96HsjSP6rYiBo8K4nP3OSZhuqJsyPpQ2
	 C9mrKz+kzhU5iUVVzan7Sz+CRoNQSRTD2j71NAFgtWM27xT3d/otwsmXagA/QIjVOWYsk
	 +koluGJvCkg+ur9BGpecQ2jw7e9T0PTB9QJe4ObxpxEm1K8yuApLw8FkKkL6pZF2Hx7+0
	 W+nQnddzS29o2Am7HfYXOMv5Se/mrov7ySFU+C+Sqjy0+4vHAj7bWHKRMeCGkjs+r9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793168012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NJs0jX+zL68CDXokUcGZhRf8G443cdGWjIihAh/FoU0=;
	b=kWxPvxcbCQZzUDwgaaERBcud9HHlJ7eEV5VSY9F95uXRs0zFVuQZ1pGb+dQpZtg9GyHF
	 YsXl2P/gcFqRwv0hkNLrMVlg9LWoVCbfULfDFqS/0ahBmqgoe4+HgfUnmmHLKa4HDPOW3
	 kjzs2ekEo85G/DOxUfzjN0mU4tNhH1EGBf7Au8nQ+1tbGiHrVIiqly2N1SnLodbu21K50
	 yZow3WoWKijeXx2zUa1685X3sO/nVtfO9lAmWSRTIfevOhw0x4iTBWR/1Anc6suQGlaIN
	 Ume8dcUaDJeK6qqAImZUoTF920YsEKF/JlPHlv0dKIZQRVuOtLeVQwTyiSQpTDRxRhA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793168012;
	bh=NJs0jX+zL68CDXokUcGZhRf8G443cdGWjIihAh/FoU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=atzhOaG34qIkbfbQAg6ISlEjol5oysJfLK6S12pne+zwwnxyRV9bh02UKfY5nMHgB
	 ZYRq6IPZKYCGukxwN+cnJYjaZdQxC4xN7RfyUHQ7oIbM6OaaJEpinsYf+I8U6mkjyb
	 CB0b3cngkzhU56QArk4LS4E04eSFUzHil9zTu/WUqswHaGeLacsId7ejzSbArvcXRU
	 KQtEGhe9HC+qaqeS9Vstg0Q8wcN1dT/vbEKC6GRE3LHrnh3wpMeXDdsCHpxXUJ8SZ/
	 2dZf7zGvUUt45HbGIbF2ZoR4lwSyZ9j4FfSxOcSR9gbrvcW39Tl79BmqgSfF1SI1El
	 E6FW+1ZZhRYlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 315A480DC3;
	Wed, 28 Oct 2026 06:13:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A73704D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98BE04056A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bjXxvdlejBSl for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 06:13:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C69D40561
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793168009;
 b=dw+WUk4+SwuRY1e7Km5z5M4LIAvobBw0qD0OwoQBKZTEH3xBie7EGRC5OE/MrePxMRiA
 EDPm4aCb7FR62E46oIT4Q3ifeo8ybG4nh7cFbEeazH9U1G8zYZEV1+Ih4BObaPPkAI7hl
 bwkIE/qMmNrKJjb79TteJrzVicedPAj18wrnHN7/iAZVDeWxITKnjOuPo0Zi4IMi9VVoo
 FBjCxlbt02hdb8p9ZVgQnuheGeUKP6P+7+AJ2k9FYurb7JPva96lmfRoWo/HB16aXlbC5
 w4NmZt5NNvPFUmZ+NghIpH5ACrwiPXsY1s27NZwhDxaBww9zSgg2fXxwxuF0B0sHgdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793168009;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=NJs0jX+zL68CDXokUcGZhRf8G443cdGWjIihAh/FoU0=;
 b=OQLQ6yBFYEyCIX1kS+udwDNLWSL6BBWl97Qc6kaUrf+OLHU5zo9TetoIXWxv86XJpE1w
 KCuzJ4PPnOUyFXRfFT+MmUor8Lpd8gyCjjb/QJ/sQKRfkr+6tTbOK/Vv72VfcK2aTHMwz
 z8ETVO/vEKWjINBCexOcXBQSLB5tl/Kc4FIeOIVB5egtNJCtFbah1LUtjTCvN4yUVDD9F
 dbv5fOIwpsVxURrn/uTayD7QR2gIdPhuWUJq2sk/vnqVV9cTTCHbHZFAA7ROXipvOK85L
 sWuXQD/b9MmmGXXPXbeDoCL0n7tOYijFGQQL1d9ENJCyaZ2gP94xZMEmpqCW2yMoXpA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=hredb80+; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=hredb80+
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C69D40561
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EEB2E10BAF7; Wed, 28 Oct 2026 07:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793168002; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=NJs0jX+zL68CDXokUcGZhRf8G443cdGWjIihAh/FoU0=;
 b=hredb80+G/twTHKYX6xTxEqt6RSz2nds3DPB4pARm63rTR8M3Zbho2S3hv/GQ9vHRYKhMP
 KVxlXNnVNEB92NkQcIFgpMB53p2jeDqLqQJLYV0WaCbrTk3YwzteX5+fyKa90VNcuwHM3F
 i0mZNnCM9ZNiXPgKzPOlDsefvAGNtCL/87t3M+y9PkEp9E3hpTlVT5oXHrYXcgDt2IWEij
 NLAoE7bh/zB3MN+vFqVR/l0fkempgS1+uEe7GXsmzL/n2Rp8VBxJX1qMwl7EzI6OT0/mW8
 zL80fKEWq0fkPGVWQeXyBNhPEAEvgVZyo0F73x27km4F5q0MuBwc4Gta/ohvMQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Daniel Golle <daniel@makrotopia.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/7] mtd: refuse an erase on a device that cannot erase
Date: Wed, 28 Oct 2026 07:11:35 +0100
Message-ID: <20261028061231.39152-2-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028061231.39152-1-hs@nabladev.com>
References: <20261028061231.39152-1-hs@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mtd_erase() calls mtd->_erase() without checking that the driver has
one, so on a device which does not provide one it jumps to a NULL
pointer.

MTD_NO_ERASE alone does not tell us whether erase is supported, as the
flag means erase is unnecessary, not unavailable.

Linux guards mtd_erase() with

	if (!mtd->erasesize || !master->_erase)
		return -ENOTSUPP;

so do the same in U-Boot, but with EOPNOTSUPP as the error code,
as checkpatch asks for ("ENOTSUPP is not a SUSV4 error code, prefer
EOPNOTSUPP").

A partition gets part_erase() only when its master has an _erase, so
part_erase() cannot call through a NULL master->_erase either.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Dropped the sentence saying nobody reads MTD_NO_ERASE, which is wrong,
  spi-nor sets it for SPI_NOR_NO_ERASE parts. Say instead why the check
  asks for erasesize and _erase (Simon)
- Mention the mtdpart.c hunk, a partition gets part_erase() only when
  its master has an _erase (Simon)
- Added Reviewed-by from Simon, as all comments are in, beside
  mtd_is_aligned_with_block_size() comment which is moved to patch
  "cmd: mtd: get through a device that has no erase size"

Changes in v2:
- New patch. The SRAM driver of patch 3 has no erase, which the old
  mtd_erase() would have turned into a NULL pointer jump

 drivers/mtd/mtdcore.c | 3 +++
 drivers/mtd/mtdpart.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3d3a84df0a6..6d5b7023bf4 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -945,6 +945,9 @@ EXPORT_SYMBOL_GPL(__put_mtd_device);
 
 int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
+	if (!mtd->erasesize || !mtd->_erase)
+		return -EOPNOTSUPP;
+
 	if (instr->addr > mtd->size || instr->len > mtd->size - instr->addr)
 		return -EINVAL;
 	if (!(mtd->flags & MTD_WRITEABLE))
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index f3b7f1ee13c..a3003cf44b0 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -654,7 +654,8 @@ static struct mtd_info *allocate_partition(struct mtd_info *master,
 		slave->_block_isbad = part_block_isbad;
 	if (master->_block_markbad)
 		slave->_block_markbad = part_block_markbad;
-	slave->_erase = part_erase;
+	if (master->_erase)
+		slave->_erase = part_erase;
 	slave->parent = master;
 	slave->offset = part->offset;
 	INIT_LIST_HEAD(&slave->partitions);
-- 
2.55.0

