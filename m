Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AD9D116EC
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 04:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1909F88FBA;
	Fri, 25 Oct 2024 06:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AtiB1uPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB8E88ED2; Fri, 25 Oct 2024 06:56:40 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B55288ED2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 06:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.c.hoisthospitality.com (unknown [87.215.50.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0DFDF3F191; 
 Fri, 25 Oct 2024 04:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729832187;
 bh=940elRngEAQqzEvX5cLFj8bDpMpfZNSSny10jqHRSfY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AtiB1uPRYh99lLNjOQaol4f8L/6fSQdYVGVDboZQl55uUxCNQDhn0ogEgyNz2a6lA
 by0yXAIcct6gG8ESmaCQh0yoZ0w07sk+JZmwmYXAnF+TCitT5ubhLZQXTqLTNQ8xWS
 TUg1vpwlzIxZI3J66+7YQuXyvVJl5Gvtn7F5iMU3wAjLQU/aUwwn+BKNeAYT8Y8z3p
 haAPMHhlBp6eHN9hSHWKakikbB7uQgZ5CRgZVf0/s2mvu3eZxZqaqkQL2AznAEp5Ik
 vTVg0lCKUP7RRJROlwdUwjdk5X1k2jLHTT+MdUBYsU1Z5cZ/Szd9lIFQ9PdcxRbWE6
 Hqu3xFcpeLaqQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Michael Walle <michael@walle.cc>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] fs: ext4: document struct ext2_inode
Date: Fri, 25 Oct 2024 06:56:01 +0200
Message-ID: <20241025045601.183796-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Provide Sphinx style documentation for struct ext2_inode.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	add reference to the Linux documentation
---
 include/ext_common.h | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/ext_common.h b/include/ext_common.h
index b09bbde116a..6e17fbd2771 100644
--- a/include/ext_common.h
+++ b/include/ext_common.h
@@ -173,20 +173,38 @@ struct ext2_block_group {
 	__le32 bg_reserved;
 };
 
-/* The ext2 inode. */
+/**
+ * struct ext2_inode - ext2 inode
+ *
+ * For details see Linux file
+ * Documentation/filesystems/ext4/inodes.rst.
+ */
 struct ext2_inode {
+	/** @mode: file mode */
 	__le16 mode;
+	/** @uid: lower 16 bits of owner UID */
 	__le16 uid;
+	/** @size: lower 32 bits of file size */
 	__le32 size;
+	/** @atime: last access time */
 	__le32 atime;
+	/** @ctime: last change time */
 	__le32 ctime;
+	/** @mtime: last modification time */
 	__le32 mtime;
+	/** @dtime: deletion time */
 	__le32 dtime;
+	/** @gid: lower 16 bits of group ID */
 	__le16 gid;
+	/** @nlinks: number of hard links */
 	__le16 nlinks;
-	__le32 blockcnt;	/* Blocks of either 512 or block_size bytes */
+	/** @blockcnt: lower 32 bit of block count */
+	__le32 blockcnt;
+	/** @flags: inode flags */
 	__le32 flags;
+	/** @osd1: operating system specific data */
 	__le32 osd1;
+	/** @b: block map or extent tree */
 	union {
 		struct datablocks {
 			__le32 dir_blocks[INDIRECT_BLOCKS];
@@ -197,10 +215,19 @@ struct ext2_inode {
 		char symlink[60];
 		char inline_data[60];
 	} b;
+	/** @version: file version (for NFS) */
 	__le32 version;
+	/** @acl: lower 32 bit of extended attribute block */
 	__le32 acl;
-	__le32 size_high;	/* previously dir_acl, but never used */
+	/** @size_high - dir_acl on ext2/3, upper 32 size bits on ext4
+	 *
+	 * In ext2/3 this field was named i_dir_acl, though it was usually set
+	 * to zero and never used.
+	 */
+	__le32 size_high;
+	/** @fragment_addr - (obsolete) fragment address */
 	__le32 fragment_addr;
+	/** @osd2: operating system specific data */
 	__le32 osd2[3];
 };
 
-- 
2.45.2

