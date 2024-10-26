Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D36ED10BE5
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 06:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AFE289031;
	Sat, 26 Oct 2024 08:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="g+ORpOHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66AC988FC7; Sat, 26 Oct 2024 08:41:05 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BF3C88E74
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.c.hoisthospitality.com (unknown [87.215.50.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3CC3842649; 
 Sat, 26 Oct 2024 06:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729924860;
 bh=+oGeDVjKO1oFlGIabhV9RJBQAiOGLxH6pOniOjmDHM4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=g+ORpOHcuQt4AQQS9YlOIPVkdR4sqWN3NH31vrGRsL5EJ1iTNR4nSsATLwxmtNi6A
 /6GNgTBypNNbT3Ysz/RvxishneSOvsHAQy0yVBIK0MqcAIp2YuHBtF3ojw1xDWSwVX
 KgZE0HNfW4bxnX+k6/kpkzXJwpZ0oghuO1EzjU/g9QBIYa5hmrjRFq7hUGInAOEKza
 ZV+a1jhw41yObjG7EgwSHDtwFj1VKuOcgLSu7CqS4jzMCJVdyQbEzreqf8v+6Q1B/x
 7JhvIjeQip1romWmRWvW+kNp4lIzAChTQzSgPjZIXcDk/wjKHLZJfvZ1DtyJ2Fnmp0
 ABD+ZoZ1NYPsg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/5] fs: ext4: simplify ext4fs_iterate_dir()
Date: Sat, 26 Oct 2024 08:40:44 +0200
Message-ID: <20241026064048.370062-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
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

Remove copying a pointer with a cast to the very same type.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4_common.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 76f7102456e..c1e38978bb9 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -2046,24 +2046,23 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
 	unsigned int fpos = 0;
 	int status;
 	loff_t actread;
-	struct ext2fs_node *diro = (struct ext2fs_node *) dir;
 
 #ifdef DEBUG
 	if (name != NULL)
 		printf("Iterate dir %s\n", name);
 #endif /* of DEBUG */
-	if (!diro->inode_read) {
-		status = ext4fs_read_inode(diro->data, diro->ino, &diro->inode);
+	if (!dir->inode_read) {
+		status = ext4fs_read_inode(dir->data, dir->ino, &dir->inode);
 		if (status == 0)
 			return 0;
 	}
 	/* Search the file.  */
-	while (fpos < le32_to_cpu(diro->inode.size)) {
+	while (fpos < le32_to_cpu(dir->inode.size)) {
 		struct ext2_dirent dirent;
 
-		status = ext4fs_read_file(diro, fpos,
-					   sizeof(struct ext2_dirent),
-					   (char *)&dirent, &actread);
+		status = ext4fs_read_file(dir, fpos,
+					  sizeof(struct ext2_dirent),
+					  (char *)&dirent, &actread);
 		if (status < 0)
 			return 0;
 
@@ -2077,7 +2076,7 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
 			struct ext2fs_node *fdiro;
 			int type = FILETYPE_UNKNOWN;
 
-			status = ext4fs_read_file(diro,
+			status = ext4fs_read_file(dir,
 						  fpos +
 						  sizeof(struct ext2_dirent),
 						  dirent.namelen, filename,
@@ -2089,7 +2088,7 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
 			if (!fdiro)
 				return 0;
 
-			fdiro->data = diro->data;
+			fdiro->data = dir->data;
 			fdiro->ino = le32_to_cpu(dirent.inode);
 
 			filename[dirent.namelen] = '\0';
@@ -2104,7 +2103,7 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
 				else if (dirent.filetype == FILETYPE_REG)
 					type = FILETYPE_REG;
 			} else {
-				status = ext4fs_read_inode(diro->data,
+				status = ext4fs_read_inode(dir->data,
 							   le32_to_cpu
 							   (dirent.inode),
 							   &fdiro->inode);
@@ -2140,10 +2139,10 @@ int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
 				}
 			} else {
 				if (fdiro->inode_read == 0) {
-					status = ext4fs_read_inode(diro->data,
-								 le32_to_cpu(
-								 dirent.inode),
-								 &fdiro->inode);
+					status = ext4fs_read_inode(dir->data,
+								   le32_to_cpu(
+								   dirent.inode),
+								   &fdiro->inode);
 					if (status == 0) {
 						free(fdiro);
 						return 0;
-- 
2.45.2

