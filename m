Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B5606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x7ky8/d4;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=U6c/WlLx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D139404EC;
	Thu,  5 Nov 2026 06:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wHaKmyxQ8teu; Thu,  5 Nov 2026 06:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 465F1404F4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793859104;
	b=JJ4a+GUVjY0dUa3LoJ95cXT6wcUipwM7LX9IXNtub+xrCCkyUjjXocyQzAjTxJyKtxSq
	 TVf1rQYLfMxejoF6sjz5ePMzTcwEFKrQOnd0WO81Y+WT/ObtmWGp2ZdwI2zmeZcr7/CqA
	 W3QgTJoD7s9YVdeWYWU2+cCivwGma+payo5UEjotwB0dLFQsI0lk8KbCaOCNLJvLpE2jh
	 giAoQkIXpPomrjKUZVqfVPp49pt6lSPG95htztljm4cWfeOjB4R7zGJWyaJX/+EMxQJjr
	 gAnMyQmEYhstwSb/w5VHYhEPAaicwSz8yFOQRPOJ52yrzTylGdBYo+tjvPdVzLO5oRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793859104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5V2KGbmA3j17vLP4i0pVoZzcf/6Ec9oyqSqL8E0eOng=;
	b=nCDAKe/ipbquSLfoAEpz2dLXhjD8qbcAHIgu290EZWlY0ERQA0A9YDg93n2AMbNLMd6p
	 wp8c0FCr4qx6IKGDnxo+oLP+4rAKHZB8j7bxMFqzwwu3mWW0abimRuMGo7njYKuTT2fNS
	 IjQwFw7PpeFNl2BDsEJDelnxZ/G5bgRDZKCBeNvi4PwamGq7j+F1kZApZpQrENTQwIThX
	 Exa+ktgdHAoxTPdtU8SbG0DuDjmiPP/xFKNo7jPFCXmxBZo6Zxnxr/tilsFJirGDgFjYv
	 yJa+cv3lq0CNOd15qdaIJbIxDxFVcQreDoHTVaFuQv18x9vYFgTQWNGfFL2AsPW5KJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793859104;
	bh=5V2KGbmA3j17vLP4i0pVoZzcf/6Ec9oyqSqL8E0eOng=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=x7ky8/d4Al5gIsSqtFf0kRCKFOMShwoGw7vh6DEsbmSWhxiRcVZWizHin9ePpNg+8
	 A4/1TqC5gEMtL8gZfsdDnaiVhjHTCKdk2NN32jXBRmr5yE82TDm05Ds7nvZxJelfZQ
	 Y5gi/laLllO+z9zdPI97mGLeU+04I3EcM9+KjJkO+p/3Oi2BfhW2QisAYTU3yQBkEM
	 rp67bOIAhrvJvzaza8zIzsvrM26+/ijQa+3axMNuGCoJkozbBGkTc5WhzLYzASykZ7
	 1/SlN7pDZ9fwaevllJ02sDntPzLijQueiTmQnfOJRB8b5DIub7E7KLvzvgIZDsxpzZ
	 wKO3ynxHR0eJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 465F1404F4;
	Thu,  5 Nov 2026 06:11:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A3DB52B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F8D360768
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BjRb72uuiFZ0 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 06:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 30B92606D3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com;
 envelope-from=shubham@octane.security; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=octane.security
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=octane.security header.i=@octane.security
 header.a=rsa-sha256 header.s=google header.b=U6c/WlLx
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30B92606D3
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:11:40 +0000 (UTC)
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-36e99cf7bb3so98787eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 22:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=octane.security; s=google; t=1793859099; x=1794463899;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5V2KGbmA3j17vLP4i0pVoZzcf/6Ec9oyqSqL8E0eOng=;
 b=U6c/WlLx51CO8rMSGAf30uoaaqGcB3VuZPU07XFawOkf87/ibWQ4F2xI14piIA5C6g
 +gJcLWkofXaSyf8iLFsWx6m48hqrdc23ZWoJGWVljv6PmgdZB3UPizVIvHmQlEJwhil2
 EtkBCUELU6pj5OKQULNgSrVU5Y9OmBNLvyZ6II1+6tmNeTREVfInle+srkJnDic6uqTu
 agyHqaX1xSGEKZTX498x+PRp0L0Fgs52tucyvbcr0PwaXHQFarrZVejUc5suR/ECL9D5
 1TMIDX3a5vmn53ctzB5u3fecOWBSRJIRlWWJvnnHJ/zkybgWxHDIiuawLBAL7hg/lXC/
 Xq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793859099; x=1794463899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5V2KGbmA3j17vLP4i0pVoZzcf/6Ec9oyqSqL8E0eOng=;
 b=C5eeWdzBzoGQo+SiF4DeM2gLavtPK30A0jNTNc+w2oX8ZZs7GvzelgNTU6kPHWjOZ8
 SIb6yFefJ9IM/xRLb3HxKaQf2NwYHD4q0oTZ4UhS5CHXzG4xQH0iblUzGueEXVxN7WjU
 QexJ/eQrvgI11okcO1BKrIeVrhK0aNK88pUjLHtb9TMvZljQPcp7OrbTf8dRPQdSJ4j/
 2ALEGWPnYK05t3otiTFKnz5sPd+vwRbe1X+cuYui93XQTqAzbS/C4jJNL9ll3LKU6EUw
 32iSlnf8F6lK8iBvfl6OgwCKKwHLo9aQjPCSHW0EuR8c9JnFNNz3nB1he1J5Ig95Llzg
 Sm6g==
X-Gm-Message-State: APuU4Z/DRANzXWVF4szEkSviKkYkocwPVG7cFGRlyamdjzu2Cey0WN6d
 a2Td2DeJvDcS/qfjLh/WR0D8PAvayN7FX7FM26RFktLmhDvj0+mQDwhn6VGwVpiUWw1xb9inImW
 RKudg
X-Gm-Gg: AYBFou2VA180KWVyZgRybnaYNxcXWxfGCGYKffPhQVlkKMTRGvdsU3I5kiocEj2KPIm
 w1k39+0PVx5V3PiWKn2kaaeTr1ou9uZj71c7cN9DJ/Dzy//+VKKOQvrYoRQvS65Y02FQ31ARmUo
 1+Z5f1eS6Dn200WnAv8sjab4EgTmi6b8PotiQLpNvYTcmczbocoDYLe6lXmQ9V+jPgQkXRVh/M4
 tOELXKNov3W4/5AsG2FFC9BsCGYno7RzIPOCFtR3mbyr6578ED5SblBQY7KzRHdduCtGBYya9UM
 OzznLl/LRj8eiLsqPLQRZzrIf1tpyUielJVp0YRgo7kjgNZgCOuzcZR/gtIrjHlx62e/i7/IWRR
 JzXj//Q6Dd7Sp2+KfQVFamgMls1NCXZnR6NBdUKd8Lile7OqcaM/juRgU0K0y9pyOprOPCJnDZi
 izf453uN57t58KzIJWx6o28LAq8D4rlGBgK8zBMSbgI42I2jgwkiWQopbOW9rsfP6+UIHYXbufr
 d7yI8TriVkTnphnpUsqho/YWbwHOwKaJ+jKsvFT9nMucsl2DCgFT4JTLqM8M0nJZs3pU+wPJOd5
 kz64++GnFoH78Tvg3WLwbAnlW4H/szmi8CErjZfiuCmpHadt0sCqKRkcdkGlRAX2D59zRo7MC4D
 rVtDZnIZRnTAJa1Baz8MGTh3DrkCV4FQlXkMbgap95qV3HFXNFg==
X-Received: by 2002:a05:693c:4152:20b0:36a:1807:75a4 with SMTP id
 5a478bee46e88-36a423cacb4mr30926096eec.20.1793859099411; 
 Wed, 04 Nov 2026 22:11:39 -0800 (PST)
Received: from localhost.localdomain ([157.119.219.79])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca39c5f0csm12374354eec.29.2026.11.04.22.11.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 22:11:38 -0800 (PST)
From: Shubham Antil <shubham@octane.security>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, xypron.glpk@gmx.de, sjg@chromium.org,
 maxin.john@gmail.com
Subject: [PATCH] fs: fat: bound getsize in the FAT write-path cache fills
Date: Thu,  5 Nov 2026 11:41:33 +0530
Message-ID: <20261105061133.88030-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

set_fatent_value() and flush_dirty_fat_buffer() in fs/fat/fat_write.c
fill the FAT cache (mydata->fatbuf, FATBUFSIZE bytes) using a sector
count, getsize, derived from the on-disk fatlength:

	if (startblock + getsize > fatlength)
		getsize = fatlength - startblock;

getsize is a signed int and fatlength comes from the BPB without
validation, so when startblock > fatlength this underflows and the
wrapped value is passed to disk_read()/disk_write() as a __u32 block
count. In set_fatent_value() disk_read() has no bound of its own, so a
crafted FAT (tiny fatlength plus a directory entry with a large start
cluster, reached on the overwrite/truncate path) makes it read far
past the fixed-size fatbuf -- an out-of-bounds write of attacker disk
contents. flush_dirty_fat_buffer() has the identical computation
feeding disk_write().

Commit 87d85139a96a ("fs: fat: Perform sanity checks on getsize in
get_fatent()") added the same clamp to the read path in fs/fat/fat.c;
it did not touch fs/fat/fat_write.c. Make getsize unsigned and clamp
it to FATBUFBLOCKS at both write-path sites.

Fixes: 87d85139a96a ("fs: fat: Perform sanity checks on getsize in get_fatent()")
Signed-off-by: Shubham Antil <shubham@octane.security>
Cc: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Maxin B. John <maxin.john@gmail.com>
---
 fs/fat/fat_write.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index a1d28b4e..02b2d313 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -219,7 +219,7 @@ static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
  */
 static int flush_dirty_fat_buffer(fsdata *mydata)
 {
-	int getsize = FATBUFBLOCKS;
+	__u32 getsize = FATBUFBLOCKS;
 	__u32 fatlength = mydata->fatlength;
 	__u8 *bufptr = mydata->fatbuf;
 	__u32 startblock = mydata->fatbufnum * FATBUFBLOCKS;
@@ -236,6 +236,11 @@ static int flush_dirty_fat_buffer(fsdata *mydata)
 
 	startblock += mydata->fat_sect;
 
+	if (getsize > FATBUFBLOCKS) {
+		debug("getsize is too large for bufptr\n");
+		getsize = FATBUFBLOCKS;
+	}
+
 	/* Write FAT buf */
 	if (disk_write(startblock, getsize, bufptr) < 0) {
 		debug("error: writing FAT blocks\n");
@@ -465,7 +470,7 @@ static int set_fatent_value(fsdata *mydata, __u32 entry, __u32 entry_value)
 
 	/* Read a new block of FAT entries into the cache. */
 	if (bufnum != mydata->fatbufnum) {
-		int getsize = FATBUFBLOCKS;
+		__u32 getsize = FATBUFBLOCKS;
 		__u8 *bufptr = mydata->fatbuf;
 		__u32 fatlength = mydata->fatlength;
 		__u32 startblock = bufnum * FATBUFBLOCKS;
@@ -479,6 +484,11 @@ static int set_fatent_value(fsdata *mydata, __u32 entry, __u32 entry_value)
 
 		startblock += mydata->fat_sect;
 
+		if (getsize > FATBUFBLOCKS) {
+			debug("getsize is too large for bufptr\n");
+			getsize = FATBUFBLOCKS;
+		}
+
 		if (disk_read(startblock, getsize, bufptr) < 0) {
 			debug("Error reading FAT blocks\n");
 			return -1;
-- 
2.43.0

