Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5583F46113
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 13:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C396C84114;
	Mon, 23 Mar 2026 14:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D1/as+cv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFBB784114; Mon, 23 Mar 2026 14:43:19 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F59584150
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 14:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 66320600C4;
 Mon, 23 Mar 2026 13:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61AEC4CEF7;
 Mon, 23 Mar 2026 13:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774273395;
 bh=/cdDqnkmARcCVtIycTF2CQXXTceu5AYWx37gMowF26w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D1/as+cvbEKNAInYdfsixz72l9Ql5aP4b+VRp7qoiKEK7LqB4MzEkvNfP0FQ+z74Q
 JhIPH5vizYBKO7jPNAAoIKNWW79ODAWNbiIM7ad6iGYFZZSJMrx7/T4b1qk67MIrZm
 KxZa5g8ISLzfwdZe0Wc7YqDi5TYn4sWFRrkdAyM+t8fktoSvE3MsMbqIJrWWg0yity
 FM2U/B7Ug7nX/GobEK4rAZnpEPVvAQ+mwg4O2ydHEtJKSwf1c4+KOw7WTaeAmK15HW
 HZJQsted2nlIUt2fdPYfDjl3VCjifBbQZEfTIyLYzhqHavkDbhvmsaSngQCuA+ZASY
 wJ3CdEKTnU8sg==
From: Michael Walle <mwalle@kernel.org>
To: Huang Jianan <jnhuang95@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 3/4] fs/erofs: allocate data buffers on heap with alignment
 (2/3)
Date: Mon, 23 Mar 2026 14:42:19 +0100
Message-ID: <20260323134305.2675822-4-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323134305.2675822-1-mwalle@kernel.org>
References: <20260323134305.2675822-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The data buffers are used to transfer from or to hardware peripherals.
Often, there are restrictions on addresses, i.e. they have to be aligned
at a certain size. Thus, allocate the data on the heap instead of the
stack (at a random address alignment).

This will also have the benefit, that large data (4k) isn't eating up
the stack.

The actual change is split across multiple patches. This one allocates
the inode buffer on the heap. Before, if there was an extended inode,
the buffer was read incrementally. Now, as we need to have an aligned
buffer, the first part is just read again to keep the original buffer
address.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 fs/erofs/namei.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index b493ef97a09..7ce62955540 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -13,14 +13,20 @@ static dev_t erofs_new_decode_dev(u32 dev)
 int erofs_read_inode_from_disk(struct erofs_inode *vi)
 {
 	int ret, ifmt;
-	char buf[sizeof(struct erofs_inode_extended)];
+	char *buf;
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die;
 	const erofs_off_t inode_loc = iloc(vi->nid);
 
+	buf = malloc_cache_aligned(sizeof(struct erofs_inode_extended));
+	if (!buf)
+		return -ENOMEM;
+
 	ret = erofs_dev_read(0, buf, inode_loc, sizeof(*dic));
-	if (ret < 0)
+	if (ret < 0) {
+		free(buf);
 		return -EIO;
+	}
 
 	dic = (struct erofs_inode_compact *)buf;
 	ifmt = le16_to_cpu(dic->i_format);
@@ -29,17 +35,18 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	if (vi->datalayout >= EROFS_INODE_DATALAYOUT_MAX) {
 		erofs_err("unsupported datalayout %u of nid %llu",
 			  vi->datalayout, vi->nid | 0ULL);
+		free(buf);
 		return -EOPNOTSUPP;
 	}
 	switch (erofs_inode_version(ifmt)) {
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
 
-		ret = erofs_dev_read(0, buf + sizeof(*dic),
-				     inode_loc + sizeof(*dic),
-				     sizeof(*die) - sizeof(*dic));
-		if (ret < 0)
+		ret = erofs_dev_read(0, buf, inode_loc, sizeof(*die));
+		if (ret < 0) {
+			free(buf);
 			return -EIO;
+		}
 
 		die = (struct erofs_inode_extended *)buf;
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
@@ -113,6 +120,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	default:
 		erofs_err("unsupported on-disk inode version %u of nid %llu",
 			  erofs_inode_version(ifmt), vi->nid | 0ULL);
+		free(buf);
 		return -EOPNOTSUPP;
 	}
 
@@ -121,6 +129,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		if (vi->u.chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
 			erofs_err("unsupported chunk format %x of nid %llu",
 				  vi->u.chunkformat, vi->nid | 0ULL);
+			free(buf);
 			return -EOPNOTSUPP;
 		}
 		vi->u.chunkbits = sbi.blkszbits +
-- 
2.47.3

