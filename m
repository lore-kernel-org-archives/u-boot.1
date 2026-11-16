Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B724606A330
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 04:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XwX54CAp;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b5Cuh2gp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D94E081061;
	Tue, 17 Nov 2026 04:34:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8V1fjcFIPe8z; Tue, 17 Nov 2026 04:34:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F17D81046
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794890092;
	b=HjXu05/g1R0g9xF1qO1esAJIxeFOa1K1KLcedJqI8TCcDKTpRo1XqfGLV8IDemqSWFj2
	 +D/gfPt7v6GT40yNPQEP1NrkNQh0aEbfyUlAghkjmNc4xC23NBKU8Utyw1Gh02AopxL2X
	 z3PUjbPf69D5ncK39vfYAlkWF1gig8yY6b+8BuY0SEeWKBmhwnROT+RYNTrAeXt/RR5Gb
	 Jjpn2I5FfO8ZiKXIvZXQ3y8Yf0o6+l/zqOKGjt5bkgeFJ9ZUAoE/bKphZB/BRStCxFLwK
	 vjn0J2Td7AZD66PAOiPlpfW0DZk+NP8k8G1nFnamVTbrKH4G1HikXogOjCIVXoIz5xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794890092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2bji/ZkitVvrzYoOgIs3uifhefn1GDl44EqY37u/QmM=;
	b=DLycfLJDegY8/0WyYB6wfzmhJmlAjdKeoK+JTH/qNatNCIEsDCtM4lc8X1Rfl8eOaqlL
	 C1joqm5w4k1i/jW/yJtCMflqlwfURRn/i8Q6NjQmrOc70qSZSKfuBW6luqcF8Clt0CPm+
	 Bpg5AkTPOb0Xv2sq+2gJB3LdqK1ed5n0heedWWVeitjRLDsdAI8NSkCTZYmuV794TtvgY
	 VqP0QLP2//2THWmWXmu7sWhxexMXAJmJEqFMUTw8SrEjyMhLURtG7EJ5RKTgfQqd94tOt
	 GU6jAGPWyxaMC5tqySRAwDXAXR+LWpsGU/o4CW2pePWHHLuDTyLFmfBB0efWy80iC6A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b5Cuh2gp;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794890092;
	bh=2bji/ZkitVvrzYoOgIs3uifhefn1GDl44EqY37u/QmM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XwX54CAp/VSVKInfGKAgSpCyZTnUPrU9XBENJqy9V5yE2YXGKIrh2rYP3fITCFZbm
	 hzWHx97mGHUoxRiQcnSby92aROZnYH1XEGYmJpIs8DRt3mlAqVbX1JelXZYowQHiBO
	 0HeaZR6Fpza678Z3UhDUACKvTO6HAHGY7h86VHUl+8YCYY25hvQFkwo2aqQxt43XJL
	 uUKcfMfRlre3uqSWpE6idowFIux0tI8VEQgyVGmUnLyo5qPxWKSHP6BY/yzqpA609z
	 MW8yCTaXQCls9eo1CmS3NSi1UNEl/fbJE3b/kAB9GZ9HmZ0qT0vCTgkwyNh+MwYEPu
	 nJTpf35SNyKNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F17D81046;
	Tue, 17 Nov 2026 04:34:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E0994DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F31B81046
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hx1oCeUNmvGP for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:02:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 763C580B5F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=dilipchowdary21@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=b5Cuh2gp
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 763C580B5F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:02:28 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b4bc216e9dso15367447b3.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794862947; x=1795467747;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2bji/ZkitVvrzYoOgIs3uifhefn1GDl44EqY37u/QmM=;
 b=b5Cuh2gp7HW1DCjD5LsxaAwAUW8r/GGAkbUjQgps0fiF5TxGAGsNkg6v86wOkaNbvp
 U7Hs6hy9JEOUF7Zc+P3tREEwUOriri8FPucEcGl9QNmeRru+PzgYGy3iaAcOyAIibvLT
 3D2OFesVIG8qhAViqwYO2T6Vxmr3uG+5VcUqJdHEZM+5UUyLRHGKyad3g/ngK5WtqrT9
 cFQaIbCYtBsfPIx0qSWGPWRowkfy85dwWm3aFvfy3IbndJIbG6nL+C1+m/9fh1YhUUm0
 /62URDA+4vyKWKqDj5XvXcOi2RXDOtY5apJuY9BHkJytwilA0MHDQNeUPF6Nvt1WcyfN
 zVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862947; x=1795467747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2bji/ZkitVvrzYoOgIs3uifhefn1GDl44EqY37u/QmM=;
 b=hRZ1yOlSstyO42EONMC2bSk3Zz1cNICgaL348RmZm3oRr9fURaQ7ilbHXuubu0NdbL
 s1GDXl/GVpkJ9evJapSNDCtNN2VY3ncwI1NeudNZ8QshMayXlraGrj8wYMSEJhbCMGQe
 VTgvwx+UiRLr55X5Zj06xN4zaqpjphxc2wCIvoPXSaEznZuwWfJ2lKAXX4BCDMjEuCWR
 6/M/lxmqnm7beK7IpYjlulEQkgnR+oFcOgRdC3by05ACou/ZOvsDZUwhbMkBcigE/h2E
 pxEH4P6CCBLpIjQZw4bNQTM6jcM8KoCJXJ0GNXR4dUYqDiSVjynF1kOFRsmr8Iht8qJj
 VJ7g==
X-Gm-Message-State: APuU4Z+fSKRCpj9M66DHnlLdP836ezgC6ELnqqEsDKnvh3f/8s8x1R2i
 X1ZE3vrYA8PtTpwgoNNa+7nuWBPDJjamuKY1rT9uqn9xwhXIX9A6rPbu6fY5pvcr
X-Gm-Gg: AZFdTZdeSyzFxuTNi3XGeCHONJN5GB7+3Ft4AtbW/+FPqRvXpE3NItzP3u7uG8A7Aq9
 AdT2VgRuk7XOL4cIlAANvQwMUDqF1oCCB7rcXEuV8yDtNyz8Hnfz93g7n0j+aj75577cfpRzAIF
 O8VSaABda4oa7DloA5fJhRGchC5wbDP0/AhTBlq5IfDNnX1NqpQLzwl/eDsBIhLCaD3mmT+23K7
 9emUX3gp1SYMRJJ75zXLBbpfyxaBIVU9tL1ZPGD4OWZRByUiowb7tj9Od0eNb6pyuUY0G2Sdo+E
 G0xTJPbZJ26czIYRkDMSkj9AzkXWfXWmFHxWk1YFKl3LLibnovBuTzthnXD4bFXdi28BFioobQ+
 Zr2yWmMFZNQmubtY/zHJSGjYBXNryqnKoPrqPK23AZ+xhA6pRsp5ifuIqrLZBFQ7HoK0dFoD86h
 vKysfiAEL8QS40xU0rM0zROShA7eBbsb91ffHuSlWIt6e2X772leN7at8I6quje8lou0uI8N2uy
 GdVgDaKV/V3zi3HGhKfEWhnwk+t8AeF5oYmzhRXO7DnQaAbUBreDJ9bUJRR1zyXPqWMxCwx8h7q
 Tc5j8IZ8Ep+ZbgE6RmajgZOvS7d78jc7RU/zQFL+rSbBj3cVYUnxHBZG1fbh3CIFUarz47CKiBa
 3sQM4oydQ5SsC7nmeThjw9BavAY7o
X-Received: by 2002:a05:690c:9413:b0:8b3:b06d:68de with SMTP id
 00721157ae682-8b4aa3b2d79mr47189637b3.106.1794862946907; 
 Mon, 16 Nov 2026 13:02:26 -0800 (PST)
Received: from d3sec.localdomain ([216.170.66.174])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4eb7f0408sm8765837b3.2.2026.11.16.13.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:02:25 -0800 (PST)
From: Dilip Mallavarapu <dilipchowdary21@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Dilip Mallavarapu <dilipchowdary21@gmail.com>
Subject: [PATCH] fs/cramfs: bound decompression output to the destination size
Date: Mon, 16 Nov 2026 15:02:09 -0600
Message-ID: <20261116210209.15246-1-dilipchowdary21@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Nov 2026 04:34:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

cramfs_uncompress_block() set stream.avail_out to a fixed 8192 bytes,
unrelated to the destination buffer. cramfs_uncompress_link() sizes its
buffer as malloc(size + 1) from the inode's declared size, so a crafted
block that inflates beyond that size overflows the heap buffer with
attacker-controlled content (CWE-787). The length check runs only after
the data has been written.

Pass the remaining destination size down and use it as avail_out, so an
over-long block fails decompression (Z_BUF_ERROR) instead of overflowing.

Reachable e.g. via cramfsls over a directory containing a symlink.

Signed-off-by: Dilip Mallavarapu <dilipchowdary21@gmail.com>
---
 fs/cramfs/cramfs.c         | 9 ++++++++-
 fs/cramfs/uncompress.c     | 4 ++--
 include/cramfs/cramfs_fs.h | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/cramfs/cramfs.c b/fs/cramfs/cramfs.c
index 22148ff8fe2..411e707528b 100644
--- a/fs/cramfs/cramfs.c
+++ b/fs/cramfs/cramfs.c
@@ -211,13 +211,20 @@ static int cramfs_uncompress (unsigned long begin, unsigned long offset,
 	unsigned long curr_block = (CRAMFS_GET_OFFSET (inode) +
 				    (((CRAMFS_24 (inode->size)) +
 				      4095) >> 12)) << 2;
+	int inode_size = CRAMFS_24 (inode->size);
 	int size, total_size = 0;
 	int i;
 
 	cramfs_uncompress_init ();
 
-	for (i = 0; i < ((CRAMFS_24 (inode->size) + 4095) >> 12); i++) {
+	for (i = 0; i < ((inode_size + 4095) >> 12); i++) {
+		/*
+		 * Bound each block's decompressed output to the remaining
+		 * declared size. Otherwise a crafted block can inflate past
+		 * the destination buffer (which is sized from inode->size).
+		 */
 		size = cramfs_uncompress_block ((void *) loadoffset,
+						inode_size - total_size,
 						(void *) (begin + curr_block),
 						(CRAMFS_32 (block_ptrs[i]) -
 						 curr_block));
diff --git a/fs/cramfs/uncompress.c b/fs/cramfs/uncompress.c
index 97af8cb2b4f..43ee5f7609c 100644
--- a/fs/cramfs/uncompress.c
+++ b/fs/cramfs/uncompress.c
@@ -29,7 +29,7 @@
 static z_stream stream;
 
 /* Returns length of decompressed data. */
-int cramfs_uncompress_block (void *dst, void *src, int srclen)
+int cramfs_uncompress_block (void *dst, int dstlen, void *src, int srclen)
 {
 	int err;
 
@@ -39,7 +39,7 @@ int cramfs_uncompress_block (void *dst, void *src, int srclen)
 	stream.avail_in = srclen;
 
 	stream.next_out = dst;
-	stream.avail_out = 4096 * 2;
+	stream.avail_out = dstlen;
 
 	err = inflate (&stream, Z_FINISH);
 
diff --git a/include/cramfs/cramfs_fs.h b/include/cramfs/cramfs_fs.h
index e0c14f04af5..02c4867386b 100644
--- a/include/cramfs/cramfs_fs.h
+++ b/include/cramfs/cramfs_fs.h
@@ -93,7 +93,7 @@ struct cramfs_super {
 #define CRAMFS_SET_NAMELEN(x,y) ((x)->namelen = (y))
 
 /* Uncompression interfaces to the underlying zlib */
-int cramfs_uncompress_block(void *dst, void *src, int srclen);
+int cramfs_uncompress_block(void *dst, int dstlen, void *src, int srclen);
 int cramfs_uncompress_init(void);
 int cramfs_uncompress_exit(void);
 
-- 
2.53.0

