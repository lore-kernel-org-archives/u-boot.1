Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FC4CD1296
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 02:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0AF88077;
	Sun,  7 Apr 2024 04:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mailtundra.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailtundra.com header.i=@mailtundra.com header.b="Bfxzi5uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7A187FF2; Sun,  7 Apr 2024 03:47:54 +0200 (CEST)
Received: from mail-4330.protonmail.ch (mail-4330.protonmail.ch [185.70.43.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DBD087FC6
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 03:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mailtundra.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwleeds@mailtundra.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailtundra.com;
 s=protonmail2; t=1712454472; x=1712713672;
 bh=9xbdikNkzgt69LsUR7iZ895yu2ra31r2rg1dKjbra/E=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Bfxzi5uuiqTOLbPIAuAnBYaPkbV0VjV73effTh5tivFJJrQfUJ5LV7xrv7SGW9AAE
 OpSp47wcv/bG71bKmp5fS53vsi8LSEeOwmP7am3ZNpU1ZSLM+BIdyR2JHlj9qU4oob
 DG/Gc7VUUkjuWPd67HOYitUPEMrqQ6Qv5AmY3CRiHIuc3uphGXfCyhFOnHm27QxfRT
 RfkOK110kt2+tOApwuj74YvWdr5UoHX0WutzYgTzyeAmr4/fQXcGlHVc3fZAPRdi+g
 5qHY7fvhPppjMt0CuXs/az/kRbUBUqGqxru5sTrDIvQTjbTwZwEKr6VCk2I4mRy6/7
 kqhX+LaqqmzQQ==
X-Pm-Submission-Id: 4VBw8l46Ykz4wwdS
From: mwleeds@mailtundra.com
To: u-boot@lists.denx.de
Cc: Phaedrus Leeds <mwleeds@mailtundra.com>
Subject: [PATCH 5/5] zfs: Fix zfs_read() to actually work
Date: Sat,  6 Apr 2024 18:47:29 -0700
Message-ID: <20240407014743.13872-6-mwleeds@mailtundra.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240407014743.13872-1-mwleeds@mailtundra.com>
References: <20240407014743.13872-1-mwleeds@mailtundra.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Apr 2024 04:00:03 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Without this patch, the while loop being modified goes on infinitely,
but with the patch I am able to boot linux on zfs on a jetson tx2 nx.

It seems like this code was never tested because the logic is clearly
wrong. The function do_div(a,b) does a division that modifies the first
parameter to have a = a / b, and returns the remainder of the division.
So clearly in the usual case when file->offset = 0, the line
"blkid = do_div(blkid, blksz);" just results in blkid being set to zero
on every iteration of the loop, rather than being incremented as blocks
are read. Hence the zeroth block is read over and over and this becomes
an infinite loop.

So instead capture the remainder of the division in a "blkoff" variable,
and use that to properly calculate the memory address to move from in
memmove() below.

For example, if file->offset were 1337, on the first iteration of the
loop blkid would be 0 and blkoff would be 1337. If the blksz is 131072
(as it was for me), that amount of data would be copied into
data->file_buf. movesize would be 131072 - 1337 = 129735 so 129735 bytes
would be moved into buf. On the second iteration of the loop (assuming
there is one), red would be 129735, blkid would be 1, blkoff would be 0,
and 131072 bytes would be copied into buf. And so on...

Signed-off-by: Phaedrus Leeds <mwleeds@mailtundra.com>
Tested-by: Phaedrus Leeds <mwleeds@mailtundra.com>
---
 fs/zfs/zfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index 9a50deac18..bfc11fa667 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -2128,37 +2128,36 @@ zfs_read(zfs_file_t file, char *buf, uint64_t len)
 	 * now, this only reads in one data block at a time.
 	 */
 	length = len;
 	red = 0;
 	while (length) {
 		void *t;
 		/*
 		 * Find requested blkid and the offset within that block.
 		 */
 		uint64_t blkid = file->offset + red;
-		blkid = do_div(blkid, blksz);
+		uint64_t blkoff = do_div(blkid, blksz);
 		free(data->file_buf);
 		data->file_buf = 0;
 
 		err = dmu_read(&(data->dnode), blkid, &t,
 					   0, data);
 		data->file_buf = t;
 		if (err)
 			return -1;
 
 		data->file_start = blkid * blksz;
 		data->file_end = data->file_start + blksz;
 
 		movesize = min(length, data->file_end - (int)file->offset - red);
 
-		memmove(buf, data->file_buf + file->offset + red
-				- data->file_start, movesize);
+		memmove(buf, data->file_buf + blkoff, movesize);
 		buf += movesize;
 		length -= movesize;
 		red += movesize;
 	}
 
 	return len;
 }
 
 int
 zfs_close(zfs_file_t file)
-- 
2.44.0

