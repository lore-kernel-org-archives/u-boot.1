Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA66C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBEE587F95;
	Tue, 20 Feb 2024 12:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tR2lG4a3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABE4687F96; Tue, 20 Feb 2024 12:54:40 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E77A83346
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 12:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 143653F68E
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1708430074;
 bh=sBJsrfXsg+5koADtVd+VStsi4cpY2WzYSO4jNy5prZI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=tR2lG4a3za7qI1zJhMjgxkIRtvusiUCly9cjtPWuBkedl+2i6MFWj7OeuX9rR1n6F
 H/BpGUwQU+amS3kv71JH5FdtYjNnjXahfGUIvz4RLk78xhPcge1AelrxtD0YZ2bYoE
 AHthu4/Yyh+GfMF/kZKREfK3AuKWslSwj8kIYZ8kOAO/U2gvv3TZMaXi2TyKgvOUL9
 Gl1JBOI/pq6jfGbdb8hG4ojWUYFK5uAj5upQ+dpL1OfUtBAUfkEYqXb8K8BhZTxkGI
 q0eHkNCdk9usw8NU/O+qOhMkwr6S50hS30MCV4n+yba3yLHd81+ezYUrKsEHe1I4PB
 wgYjx572+M5YQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33d39bc6bf4so1372139f8f.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 03:54:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708430073; x=1709034873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sBJsrfXsg+5koADtVd+VStsi4cpY2WzYSO4jNy5prZI=;
 b=q1l3yJa3+CiMjc4MLlle7XI2BRveL9MQT7t4w6kEnMPhz/iRd7lC2QlHD/IpEmTeES
 etfplc7tHWrXeq3Pqe+I8BZOC0Uqbb4HTBPhTYRNFz3iKGMWbVkpY2Q4ZlJ4EjBC1+Wx
 D7iRfUES7/tHCF9udPrMOVKZhOF5vaCOD/aj9+qLhUWKxpJVNChHmeOFoMuyUbMRnq6R
 eHZ0dGfTodKfiRuv2TmEOoETCW6q8UnRhwJtPwhwV+9ADLHbHM2aL6UyK+tVFhNB3eJN
 OLHj7z1HUcyUmudPR0EIofWVKOzNeOUijEc7+cDHcYXtYAULbQsDdk3gAiIRdZm7xNhR
 ellA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+pgjzisFb7NYXIJC0P8CIypRGvYjb/uWGLx1BAQCIbBBpPNEwcz4dYWSmyiOyv+EBc6aIKU3z08Vn8pdMw5KfjOm2sg==
X-Gm-Message-State: AOJu0YwpTJyNqp5nJPIOCpGthXTfH0OgcS8WzAF1EWOiIhyfdSpV7s7v
 SRX59Ac7sU/s9rOoLsK7LW30H7HS+ZAYCePPrpHicPleibkjyQcMGVb97XzQ5gl38xO7c/kRJM2
 LF8bV70uSapcSsNj1W0CyrrkGxYatU0TFTL13bv788Dh+r0rrfttFZpDYBGiQQUYBF90=
X-Received: by 2002:a05:6000:1286:b0:33d:3490:6e05 with SMTP id
 f6-20020a056000128600b0033d34906e05mr6135616wrx.27.1708430073712; 
 Tue, 20 Feb 2024 03:54:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuEMVwsKGAypCufbGmBW3V+I1RSMzLbvHRhfSOID/iu9Ye/m79af8cvaBjvdDI5YcS7C5Wtw==
X-Received: by 2002:a05:6000:1286:b0:33d:3490:6e05 with SMTP id
 f6-20020a056000128600b0033d34906e05mr6135599wrx.27.1708430073290; 
 Tue, 20 Feb 2024 03:54:33 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 cl2-20020a5d5f02000000b0033d4dab14a8sm6853361wrb.22.2024.02.20.03.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 03:54:32 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sean Anderson <seanga2@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Hakgoo Lee <goodguy.lee@samsung.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 Manjunatha C Achar <a.manjunatha@samsung.com>,
 Iqbal Shareef <iqbal.ams@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] ext4: detect directories in ext4fs_exists()
Date: Tue, 20 Feb 2024 12:54:23 +0100
Message-ID: <20240220115423.61417-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

While fat_exists() reports directories and files as existing
ext4fs_exists() only recognizes files. This lead to errors
when using systemd-boot with an ext4 file-system.

Change ext4fs_exists() to find any type of inode:
files, directories, symbolic links.

Fixes: a1596438a689 ("ext4fs ls load support")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
I still need to figure out a good test. Currently 'xxd' is the only command
invoking fs_exists().
---
 fs/ext4/ext4_common.c |  5 ++---
 fs/ext4/ext4_common.h |  2 ++
 fs/ext4/ext4fs.c      | 11 +++++++----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index ea9b92298ba..365c5147c4b 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -2214,9 +2214,8 @@ static char *ext4fs_read_symlink(struct ext2fs_node *node)
 	return symlink;
 }
 
-static int ext4fs_find_file1(const char *currpath,
-			     struct ext2fs_node *currroot,
-			     struct ext2fs_node **currfound, int *foundtype)
+int ext4fs_find_file1(const char *currpath, struct ext2fs_node *currroot,
+		      struct ext2fs_node **currfound, int *foundtype)
 {
 	char fpath[strlen(currpath) + 1];
 	char *name = fpath;
diff --git a/fs/ext4/ext4_common.h b/fs/ext4/ext4_common.h
index 504c708b064..84500e990aa 100644
--- a/fs/ext4/ext4_common.h
+++ b/fs/ext4/ext4_common.h
@@ -54,6 +54,8 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos, loff_t len,
 		     char *buf, loff_t *actread);
 int ext4fs_find_file(const char *path, struct ext2fs_node *rootnode,
 			struct ext2fs_node **foundnode, int expecttype);
+int ext4fs_find_file1(const char *currpath, struct ext2fs_node *currroot,
+		      struct ext2fs_node **currfound, int *foundtype);
 int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
 			struct ext2fs_node **fnode, int *ftype);
 
diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 3b12ec54fa2..b1359d14909 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -208,11 +208,14 @@ int ext4fs_ls(const char *dirname)
 
 int ext4fs_exists(const char *filename)
 {
-	loff_t file_len;
-	int ret;
+	struct ext2fs_node *dirnode = NULL;
+	int filetype;
 
-	ret = ext4fs_open(filename, &file_len);
-	return ret == 0;
+	if (!filename)
+		return 0;
+
+	return ext4fs_find_file1(filename, &ext4fs_root->diropen, &dirnode,
+				 &filetype);
 }
 
 int ext4fs_size(const char *filename, loff_t *size)
-- 
2.43.0

