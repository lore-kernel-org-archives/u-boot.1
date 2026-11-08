Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A4606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VFCP0gIZ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WiFNqexT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5CA3405F5;
	Sun,  8 Nov 2026 15:12:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ye_co9GZmvf1; Sun,  8 Nov 2026 15:12:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C61E040604
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794150737;
	b=pTF2LbWDLGPT9MgoRFE64Ryug0aFdIaZ4+aHem/TuyUwXShhWYNh/QHon9hiKEmHoMU4
	 MdY42nCMF2mrfMNT+0lHk69sfU6N1QBtzr2Yu1rsRl4d+pGLNx8MrPniObrhuvvU2nCef
	 S5TT7EFvfMh3a8K4kU7/pUMik8aTkXsFBeomA33MqNXUasgDDcb4f0oo8zik6rKub8C0r
	 tTVLus/BED9UVFIx7jpoNbNZTTO/TR57kr8z5JpJrHg6i33vF5sAnqkT7hE7TD38NO5vP
	 dHwo6LaQYfPyhhEH/HjBSgV7N1n26HTfVInxwrMpB9bd91j9TcNKVN/6NVgx8QxuSLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794150737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IktHLgnHWsanVCtxyx8c4CryMP3iAKaDBJBnDLzNwzc=;
	b=n2lGret4QcY/UqJxN6zpxNN8mWj1b/WJr6OA6Y2342nkZ2Wytv2u89g10QFRTze54V+h
	 18ibN6wQisIg6ysznogE63OF+bhqks9FDMKRMLZ7r0kSmtAgZb9rQSa0/F18Sv+fBFjKh
	 s1VSnLQ1+fRIPuCmglUGprbsI4EfJiYBmwBKGhvvAa02/lbsZpKn8a2c8z+JuYNuVAnN4
	 lO4yN6NnovnPrkUKVlvLS0oGuimFeD0cqOCT1LRDDGObcr2c81JFM8N/hwyPw2M9OpybF
	 OyI6brB2RgbuSeexrW750MyFvsi1F1vnlWKjWjmUCNcIyJx3Obk5JeRvkeMVe5cguAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794150736;
	bh=IktHLgnHWsanVCtxyx8c4CryMP3iAKaDBJBnDLzNwzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VFCP0gIZaVee4JZeMNMm1UoUaLATDxzcxcfoUvdT7asW2JAnnVwZJbsaQ5y6ReqvM
	 jKwfEPgj3o2aiJvyy+uXgHdetBS5ydhS8vtbCm+FpZlz18ETWghDmTeQZOPObbEX/O
	 ZW6lkq0Q3BqB4L/sWXLpI1NelliqNAdqLZINHlDjO2CWVKUr0QPSruwwqQjgDDqElE
	 QEWZVE5Q+x+Oo7ypsvPbo9O70Mhd9O78QF/4jU5JRuiUXHzLYTVHxOX9HU7wYZxGoq
	 dWkBEUPguD8DKhkg/Gv+TfOkPYUcrLc6ULE1arNx9rLJ7xxzp68cwf4KrTl8NcynCc
	 kqugjV16ePExA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C61E040604;
	Sun,  8 Nov 2026 15:12:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B8732AC
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D913400A8
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r3BUuSK9UaP4 for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 15:12:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 585F14005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=WiFNqexT
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 585F14005E
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:13 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so404725e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 07:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794150731; x=1794755531;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IktHLgnHWsanVCtxyx8c4CryMP3iAKaDBJBnDLzNwzc=;
 b=WiFNqexTC9mq7eEUMxTA6qT34vQWoumuMoA//IN/CRZP+xgpQ/gMGP5kMh7h61hdwR
 5VrSS9byk3nI9l67aQc61vX5DSjKPno4ljbKJBBS6scEXMp1L1rcFkUAsp0IsWLwBS9C
 UeMHQU9J2dvtBVkYoySCiWZckOGlaugJ5RFTEYzkR3hISu4OUVHc/8vDZFjL6libPvwo
 pEismQm2XwB4nbUEUn/bl3c3revoGo/NuRTsbfhLcsIhiUeDTPwNDwAPDGxL3Lv6ql2j
 6okeoExPfyl8BISUbF+7uFcavE4mcsN8k3p/BLFMl99j6W772gaD4VYZzO2hoFqVZyz7
 QOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794150731; x=1794755531;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IktHLgnHWsanVCtxyx8c4CryMP3iAKaDBJBnDLzNwzc=;
 b=R5GYN4Olo0MMeRNbzlvoJkFqE54/cqm0X/gkn6tBVVasHHFhFKDFLRZYV6Zc8w7q0l
 +3LPVO5nhwerWoZ6z10GP12Rop+sDj+NJypeDOGOWqN5vUOhfcdEfVjIpmAgmSlLC9VO
 zsJ/HXDef2OXgezkEfNxLrNCPanrc4FRjixsw6mA3f6z9HuuGhnSG/7MqVzKUz9OEGqC
 E5wYqBbZtQgLQzFDRqhMhlOVCAPniUbk8Sq+VDSK+HkxVtjADD3eoP/R0YBMjMcMv4+3
 nl6du3/gMnbFCXdkmH0vcqzMYNCBAa+lEdeIVp+3CSvLaPoVIA3/AQlMzEFJG/sJ7ofC
 WaPQ==
X-Gm-Message-State: APuU4Z8FemRbdJivYG0TRrHFO1AVx4r1Rsq0R9Wd+meXX+6LiuCYfvfi
 umWlfa5QYBLS5fQjfTDEymhwjCOlNrdfJmEy45MD28T0O+i+HgLSB3kz8ftehecqmEDKQg==
X-Gm-Gg: AYBFou3iD2buR0uNhB5zgUPRAwhvwI4R+1cWr6usEe4MfcqFo70bC0A1da0ZiVDoSel
 37DET1GJVurVe4ioyLSYV8JGSHiOfovtUwq9V49Ne0khxR2erLZ43lxpzijuioMfdwlkT62cuDA
 rJGK1oN4/NPewMDO6bn5TZivPzr/gm2jiPKMjjTVpkODPhC14RtKRB9z6iVwzPZl9HhdkrpZoB1
 PGbEjzF4YYvS9tiSVyumtj7g4TdxFQxpNBYQ4xaNq02oQU6BuEE48ALNwn94SPnnO1SY6OAhPBA
 58VR+yQ9nzklXSXS2Ve1UBtwCxeHgN0os/OYPq5I2iTqu5bJAXtcJOinQc4OAR2XIJp4epe5H4g
 hPJsPpCljGxxshV4FkNMgEIDzJZPA+IllQctpNeXwMvkLgdRnrXYFeAs6FX7/ZhhSZkPbkiboce
 tlBWtixQPKQiMod3kDiloq/gf7yAtt4anOs4LJ+wN9+MgvcRla0MUmHeSsf56VrbWdshLup6Jsh
 HTyr36eVUMJotn7GPHxZk3btGsxse/tpTOapdKLBMioc55Rvx605C8T4peXo9dkPGJ+snYnN+xz
 8At+rxfT14iT6nUgwMQEYl8QaJ0EgN8=
X-Received: by 2002:a05:600c:524e:b0:4a2:a9:ed5a with SMTP id
 5b1f17b1804b1-4b960d9bb10mr35434595e9.8.1794150731041; 
 Sun, 08 Nov 2026 07:12:11 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7efb0d7a7sm154623605e9.9.2026.11.08.07.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 07:12:10 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/6] fs: ext4: check directory entries before using them
Date: Sun, 08 Nov 2026 15:12:09 +0000
Message-ID: <9fe7adf0-424f-445d-9aae-21df93002f95@gmail.com>
In-Reply-To: <5072bec2-e2e3-405d-91eb-58fe78ea6669@gmail.com>
References: <5072bec2-e2e3-405d-91eb-58fe78ea6669@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

ext4fs_update_parent_dentry() looks for room for a new name by walking
the entries of the parent directory's last block by their on-disk
rec_len. The walk only stops at an entry whose rec_len reaches exactly
to the end of the block, so an entry that claims a length past the end
of the block, or a misaligned or too short one, moves the walk out of
the block buffer: it reads entries from the memory after it, and the
new entry is then written there.

search_dir() and unlink_filename() check the alignment and the minimum
length of each entry since commit ecdfb4195b20 ("ext4: recover from
filesystem corruption when reading"), but not that the entry's name
fits in its rec_len and in the block.

An entry with a rec_len of 0 also ends the walk early, and the new
entry is then written over it.

Add ext4fs_get_dirent(), which returns an entry of a directory block
only if it is aligned, lies inside the block and its rec_len covers its
header and name, much as Linux checks in ext4_check_dir_entry(), and
use it for every entry the three functions walk. search_dir() and
unlink_filename() stop reading a corrupt block, as they did at a
misaligned entry, and ext4fs_update_parent_dentry() now refuses to
write to one. A block it has just added to the directory has no entry
yet, so it is not walked.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 fs/ext4/ext4_common.c | 90 ++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 30 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index ccfce5c745c..9c41d2f60fc 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -443,6 +443,37 @@ uint16_t ext4fs_checksum_update(uint32_t i)
 	return crc;
 }
 
+/**
+ * ext4fs_get_dirent() - get a directory entry of a directory block
+ *
+ * Check that the entry at @offset lies inside the block and that its length
+ * covers its header and name, as Linux does in ext4_check_dir_entry(), so
+ * that the entry can be used and the next one found at @offset plus its
+ * length.
+ *
+ * @block:	directory block
+ * @offset:	offset of the entry in @block
+ * @blksz:	size of @block
+ * Return:	the entry, or NULL if it is not valid
+ */
+static struct ext2_dirent *ext4fs_get_dirent(char *block, unsigned int offset,
+					     unsigned int blksz)
+{
+	struct ext2_dirent *dir;
+	unsigned int direntlen;
+
+	if ((offset & 3) || offset > blksz - sizeof(*dir))
+		return NULL;
+
+	dir = (struct ext2_dirent *)(block + offset);
+	direntlen = le16_to_cpu(dir->direntlen);
+	if (direntlen < sizeof(*dir) + dir->namelen ||
+	    direntlen > blksz - offset)
+		return NULL;
+
+	return dir;
+}
+
 static int check_void_in_dentry(struct ext2_dirent *dir, char *filename)
 {
 	int dentry_length;
@@ -493,6 +524,7 @@ int ext4fs_update_parent_dentry(char *filename, int file_type)
 	uint32_t new_size;
 	uint32_t new_blockcnt;
 	uint32_t directory_blocks;
+	bool new_blk = false;
 
 	zero_buffer = zalloc(fs->blksz);
 	if (!zero_buffer) {
@@ -530,16 +562,25 @@ restart_read:
 	dir = (struct ext2_dirent *)root_first_block_buffer;
 	totalbytes = 0;
 
-	while (le16_to_cpu(dir->direntlen) > 0) {
-		unsigned short used_len = ROUND(dir->namelen +
-		    sizeof(struct ext2_dirent), 4);
+	/* a block just added to the directory has no entry yet */
+	while (!new_blk) {
+		unsigned short used_len;
+		int direntlen;
+
+		dir = ext4fs_get_dirent(root_first_block_buffer, totalbytes,
+					fs->blksz);
+		if (!dir) {
+			printf("Corrupt directory block, not writing\n");
+			goto fail;
+		}
+		direntlen = le16_to_cpu(dir->direntlen);
+		used_len = ROUND(dir->namelen + sizeof(struct ext2_dirent), 4);
 
 		/* last entry of block */
-		if (fs->blksz - totalbytes == le16_to_cpu(dir->direntlen)) {
+		if (fs->blksz - totalbytes == direntlen) {
 
 			/* check if new entry fits */
-			if ((used_len + new_entry_byte_reqd) <=
-			    le16_to_cpu(dir->direntlen)) {
+			if ((used_len + new_entry_byte_reqd) <= direntlen) {
 				dir->direntlen = cpu_to_le16(used_len);
 				break;
 			} else {
@@ -581,17 +622,15 @@ restart_read:
 				    (root_first_block_buffer,
 				     first_block_no_of_root))
 					goto fail;
+				new_blk = true;
 				goto restart;
 			}
 		}
 
-		templength = le16_to_cpu(dir->direntlen);
-		totalbytes = totalbytes + templength;
+		totalbytes = totalbytes + direntlen;
 		sizeof_void_space = check_void_in_dentry(dir, filename);
 		if (sizeof_void_space)
 			break;
-
-		dir = (struct ext2_dirent *)((char *)dir + templength);
 	}
 
 	/* make a pointer ready for creating next directory entry */
@@ -663,17 +702,13 @@ static int search_dir(struct ext2_inode *parent_inode, char *dirname)
 
 		offset = 0;
 		do {
-			if (offset & 3) {
-				printf("Badly aligned ext2_dirent\n");
+			dir = ext4fs_get_dirent(block_buffer, offset,
+						fs->blksz);
+			if (!dir) {
+				printf("Corrupt directory block\n");
 				break;
 			}
-
-			dir = (struct ext2_dirent *)(block_buffer + offset);
-			direntname = (char*)(dir) + sizeof(struct ext2_dirent);
-
-			int direntlen = le16_to_cpu(dir->direntlen);
-			if (direntlen < sizeof(struct ext2_dirent))
-				break;
+			direntname = (char *)(dir) + sizeof(struct ext2_dirent);
 
 			if (dir->inode && (strlen(dirname) == dir->namelen) &&
 			    (strncmp(dirname, direntname, dir->namelen) == 0)) {
@@ -681,7 +716,7 @@ static int search_dir(struct ext2_inode *parent_inode, char *dirname)
 				break;
 			}
 
-			offset += direntlen;
+			offset += le16_to_cpu(dir->direntlen);
 
 		} while (offset < fs->blksz);
 
@@ -892,26 +927,21 @@ static int unlink_filename(char *filename, unsigned int blknr)
 
 	offset = 0;
 	do {
-		if (offset & 3) {
-			printf("Badly aligned ext2_dirent\n");
+		previous_dir = dir;
+		dir = ext4fs_get_dirent(block_buffer, offset, fs->blksz);
+		if (!dir) {
+			printf("Corrupt directory block\n");
 			break;
 		}
-
-		previous_dir = dir;
-		dir = (struct ext2_dirent *)(block_buffer + offset);
 		direntname = (char *)(dir) + sizeof(struct ext2_dirent);
 
-		int direntlen = le16_to_cpu(dir->direntlen);
-		if (direntlen < sizeof(struct ext2_dirent))
-			break;
-
 		if (dir->inode && (strlen(filename) == dir->namelen) &&
 		    (strncmp(direntname, filename, dir->namelen) == 0)) {
 			inodeno = le32_to_cpu(dir->inode);
 			break;
 		}
 
-		offset += direntlen;
+		offset += le16_to_cpu(dir->direntlen);
 
 	} while (offset < fs->blksz);
 
