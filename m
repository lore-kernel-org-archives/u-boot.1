Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD56CA5FCE
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 04:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1870D80F05;
	Sun,  4 Oct 2026 04:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R7LUL0Bmv263; Sun,  4 Oct 2026 04:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AC02C809E7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791086837;
	b=C7QnnSU7VDBa6LOD6Isro3en0xGOqczuoq5qggtkAoA4QDaSvFosaXoUsWmRcZtR043A
	 lOpwdJzKrC9hFEJNZ7pAX5htYo3nnCxxeOyBDI9jJM5FIruUJ4/kOReoPPrHYyW+3RHzN
	 R2Sz3mCxxp+Yy5DSiZsTo0F9zWJbxh1JAgzlIeuJcPR+uW+CcgWXYjWAGij8NBzjHPKiW
	 d20bzwFXYzMiCu3A11rCCZDz3GXUxDIuD3s3rQRRFBz+CJYUSbjTY0SQWSnxXdt101LuX
	 uft7u2yX/bJRwzqb9fbZslak8mqMUfzH5Ie51/LRt93RzBoL/SYRgw5PRGBcUUpYynQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791086837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=az5cRuj8dYnshZLjottfjmVAnKAfk4ZWieLFg5gn8pw=;
	b=mkzJpfNLhdrChUa1dXVRluZDeK89l4wCMcm/l9YbKoo+wl8hgdlTqD8p1eI26bRkRe9A
	 xImEH9NsEn+W3Qvt1K4dztblsoV4RwV002qT0VLMjm/IXllI5ZaVIYZSP6g/HPLp0NPl9
	 4ZVnY+8B+9+pw9QNnchyNJ9/cXd56ey+EjK9OHKbBArby6azAwSw+jVLXNUZdtkBD2OYp
	 0EP2vDbgzH5238gwWKyX2KMyPgdUcZeK69g74VUdBTOQvCbaWKEtgvyvQZzqm956aVkc4
	 KNB6sSLKXEgL+M358KVtbq9KZKMQDc1Z4mb44wC3VTxg6xESDrIJVhJQw8ymRmvtCew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791086837;
	bh=az5cRuj8dYnshZLjottfjmVAnKAfk4ZWieLFg5gn8pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PWUhwJ8e2+7snvPpyrrA4q8oJ4n+7M8sZrS+4putkQYBm2AQU8quR70j1K+4u47Q0
	 7+TbyeQ83R/Wv6+I6Le5jWYWSKr3z+Qn7StA1W3gfRydMV9CeFr6a2jGcdcWLI2RNs
	 rPByHpc+vrMTESeHSGoicBsQkxWckSCIfD6O8UoVQJSOr/F9PmA4S6Qw/F2yTlX3nr
	 xWSHuQx3DNMLI2UKjsMK9K9cpV99ZF2oYBDUgX8Ij0EtfPfufihy/FseS/PCmrZEfX
	 qSZUIQAt8SMLHLOwYmQuElTZ3cf3BsRUxDln3IoqmsQ7oMupos2/wRIkeE2pw2o7Eb
	 +oNktLRJGhsMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC02C809E7;
	Sun,  4 Oct 2026 04:07:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 464AF282
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C8B84008E
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gMFEDl_07dmm for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 04:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 45DEB40068
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791086833;
 b=MGTppnQevKCDiU6EOT+QDuaVDwNzAE/f6g4Dt4phIGdL1WKr1yhdV5ndKxxPWxuj3I1H
 w7HeonL0/tSjAwWhCMTaeVIpGWH4A19wn4D7vxZzoC9TheTBJeCM4a/z5tmh4CmT3w5+A
 K4ZhlDGtj4vJ6SfzNEQXAUs4q+nMGfVN2mLDx6yz2JRa6SP9jrYt5dCfbSk6j431LXLHG
 RxLq1UmkeqR7aHnuyuzBpKJN3xNypuxyJNFSVMhZkd4mRcMdp/Pw9BsHsx198hed2R5Y1
 xfs9T1yG6SUNPAfEjTEyuZrUQwzCEujUY2Nqy85IoHNXf8wUVTB0iVVJm7quCKCx5pA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791086833;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=az5cRuj8dYnshZLjottfjmVAnKAfk4ZWieLFg5gn8pw=;
 b=gCqEpJ/cIqbniEeMEFytbwwTbfODYKHfwlWZfr31xsijwFlUHXEw1H4/DFAW77clsGcv
 XvpoASZt3tW9xFJY6khJLNgLKcCMnz1l1bq0SCq82MymRQ6E9Tc21VpXYW+we3qaQdS6O
 IOGlVgEZ503k0aMtz0t1k9R1KF6Ix3F78ZImaaY3wLO7qHigRXLiEsObGDiI6v+W1vd8N
 Y1OlRZi0CakXs5evw9A+4etw633Tyrv+jNZeT6NxvZZMqalmBjEHmWgq6hFXfVOqO0ItN
 03OEru5EiREL2ts0Y7+0WT4p12+dFLI7K62YEYjlcEdJJPCpdeFnNqkLNA1EWqb0wwA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=jzWb1KOJ; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=jzWb1KOJ
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45DEB40068
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3B7BB107A01; Sun, 04 Oct 2026 06:07:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791086829; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=az5cRuj8dYnshZLjottfjmVAnKAfk4ZWieLFg5gn8pw=;
 b=jzWb1KOJPzTOIbu3cSPclD1o0Y10jvt+iwrzSHqNnnnetKMlaAt+KWNEX2idBuod4tQw5d
 CFBws1EBse0LbP8wJKiUwShPVZbGwHCDylYSt3/OvayStAoD4jKGowUAn3gfrtQi4o0TSS
 UltwcGGWik/UBSlguIxF4wSKUNepHkJG0TCiT4OAYoQfsDnS2hIQN+XhMKro+qxRC6DJvz
 L4sbbUqAadpHL3XD/60H0mS0vhz71geuXdHPnYyXHd4WwcpUNGMJ3Od4xkcUBtXLl/MlLw
 o2aWm+RzT0tcU66EsvA2v+04Cpe1dnEQqpiVoFO/2g6qmpssIz8nfhyHpLlZhA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/5] mtd: refuse an erase on a device that cannot erase
Date: Sun,  4 Oct 2026 06:06:45 +0200
Message-ID: <20261004040657.3156402-2-hs@nabladev.com>
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

mtd_erase() calls mtd->_erase() without checking that the driver has
one, so a device which does not provide one will end in accessing
NULL pointer.

MTD_NO_ERASE flag exists, but nobody reads it yet.

Linux guards mtd_erase() with

	if (!mtd->erasesize || !master->_erase)
		return -ENOTSUPP;

so do the same in U-Boot, but with EOPNOTSUPP as the error code,
as checkpatch asks for ("ENOTSUPP is not a SUSV4 error code, prefer
EOPNOTSUPP").

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

Changes in v2:
- New patch. The SRAM driver of patch 3 has no erase, which the old
  mtd_erase() would have turned into a NULL pointer jump

 drivers/mtd/mtdcore.c | 3 +++
 drivers/mtd/mtdpart.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3bfa5aebbc6..bde74510d4f 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -906,6 +906,9 @@ EXPORT_SYMBOL_GPL(__put_mtd_device);
 
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

