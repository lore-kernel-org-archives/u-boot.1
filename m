Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36F2FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03CC848CF;
	Tue,  5 May 2026 14:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b="J/MMfgLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003F884882; Tue,  5 May 2026 12:38:33 +0200 (CEST)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF808486B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 12:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peter@pcc.me.uk
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2f30a4601bbso1793163eec.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pcc-me-uk.20251104.gappssmtp.com; s=20251104; t=1777977509; x=1778582309;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aB45sWpbcUzBqWwch8wSk3txE3uwgUFQUSVPA65ggCc=;
 b=J/MMfgLNTigGvhR05/VfVxzYMb2/eKKCLjBBZpOOZa9l2UGEZ3e5NMsJq4Me0FEiv0
 8yvLiWQaChEuGpwSxh5RXigkUFC3LXns7EddUTomGXs7q9hKFv7PPevlXnY0YfLo5CGo
 7IrOjkGx6PCcrWArSPpeb/8mz5pl+S2R+bqBceRr1Wn7fwdYj2oPE+4vHCC0fKoFxE0U
 P445Phoz5/GcpsofKzDcBJ9HWuJQq02LK8HODqX/0iJAhXRNSJF+YILIic/SpUY70w0N
 AVtZk0o/e1dMg58oMVFmbAh9SwVI6JVCBPSmDD2I4939IBfXBxWED+7uwNAZNzyKd0wf
 Dxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777977509; x=1778582309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aB45sWpbcUzBqWwch8wSk3txE3uwgUFQUSVPA65ggCc=;
 b=XjOt8b41PNVhnpT43RxcuWoROqpQqUiOnyH5Sd/iJB69XPOtwu4gYH67D4ub3JuCoI
 FgjG8Ygxflg/OzgHEpB+81Rzrwqn4fr4Uh7S/VYnj9aCavwF/aVCtYldCZXwMBO9qur9
 u4lVpwdLnu1Ntc/VbmCTBWlmIE+22f2nrT2efDPd64vb235pfR43C8qUQ3NhtQxNLF5x
 HdWHPPKKdtvRZf+G+DlRSRstP74lHLto7fSLN+OsW3DljrJrgFG8VePbMnZ4hk5XYwTo
 jTgSJGzo9bhmUeGIqhYql7x7Q9ZUyZ6hM4IpCZ+E/03y55pmfoBnAsT4qLByjaQP5P0O
 7hsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eE/I5b6lOuhhUQBJm87uK8PZbifZbybQgRbr8pBVYHxSibN/Q8NxhVmGZdkGeucyQjgHMUPw=@lists.denx.de
X-Gm-Message-State: AOJu0YyaPp7xwYjZaDEyII5OGiylExIijx16FOw/aHPfHW4sYr90P0x6
 l40M9ZH2jvGdNxt3I0B8C2n87tw04lGylo8FC6z6yDqF6/p61V08hHhgZ4gbInU8/M0=
X-Gm-Gg: AeBDietJMyXHAd8/bZ4dXzgyTPOO7mn6ou2kF9iO99AOdzQGQaPNraCZz8yhmJ7Azx9
 2uRz/rlZhSvPnhHZv+uoVMcExNqYlergKApCUbKLJKg4lCxhZdaAAewGJcBW9HZBctaOvo3OrT6
 ApzuF9DcHpreuRlHFmm1b/+ypkKB7tIG/MMHIU/IrvM+dXMpclasLFbWQVjFpxXlTlpKzCu6C8z
 k9y3pkLNqvYBe1es0rYY6l+ENy9ACWh+fYblucahxj7PJXpmTKG7r4gFTfEds7gaeKyUxT2NUdN
 hc9BvvulICU3AvEgyu9jhuqNvSFdAf66WK6qBgakUln/QzBrn/Z1gKQNDue85PDBnqzTFH5mimM
 Lr1iJdJLIwouUEfznsiINtiKHGfjSm8tQB73xHshvcYvsIuwjtsC5GfgENddkrSgQFnIjA15Veb
 DgSpeTgJ7gc3PqyNrzjhpWiud1qwUHhUVtHuHE0TgUG2f8CW2WjZzxrSyNfWtTB2ZNPw==
X-Received: by 2002:a05:7300:5712:b0:2d8:71c2:255d with SMTP id
 5a478bee46e88-2efb88a44b5mr6277110eec.14.1777977508885; 
 Tue, 05 May 2026 03:38:28 -0700 (PDT)
Received: from localhost (c-67-180-161-137.hsd1.ca.comcast.net.
 [67.180.161.137]) by smtp.gmail.com with UTF8SMTPSA id
 5a478bee46e88-2ee3bf6811fsm19660855eec.29.2026.05.05.03.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 03:38:28 -0700 (PDT)
From: Peter Collingbourne <peter@pcc.me.uk>
To: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, Peter Collingbourne <peter@pcc.me.uk>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Simon Kagstrom <simon.kagstrom@netinsight.net>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>
Subject: [PATCH] fs: ubifs: fix bugs involving symlinks in ubifs_findfile
Date: Tue,  5 May 2026 03:38:16 -0700
Message-ID: <20260505103816.202758-1-peter@pcc.me.uk>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 14:19:33 +0200
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

When encountering a symlink pointing to an absolute path, ubifs_findfile
would return the target of the symlink as the result instead of resolving
any following components in the original path. Fix it by following the
same code path that is used for relative paths except that we set the
next inode to the root if we see a leading slash.

The existing code used memcpy and sprintf to copy the symlink target
into a fixed size stack buffer and was therefore vulnerable to buffer
overflows with a sufficiently long symlink target. Fix it by using a
heap buffer for the temporary path during path resolution.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
Fixes: 9d7952e4c636 ("ubifs: Add support for looking up directory and relative symlinks")
---
 fs/ubifs/ubifs.c | 70 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index b0cc0d2e1b2..aafbd01a028 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -505,26 +505,32 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
 {
 	int ret;
 	char *next;
-	char fpath[128];
-	char symlinkpath[128];
-	char *name = fpath;
+	char *buf;
+	char *name;
 	unsigned long root_inum = 1;
 	unsigned long inum;
 	int symlink_count = 0; /* Don't allow symlink recursion */
-	char link_name[64];
-
-	strcpy(fpath, filename);
+	size_t filenamelen;
 
 	/* Remove all leading slashes */
-	while (*name == '/')
-		name++;
+	while (*filename == '/')
+		filename++;
+
+	filenamelen = strlen(filename);
+	buf = kmalloc(filenamelen + 1, GFP_NOFS);
+	if (!buf)
+		return -ENOMEM;
+	memcpy(buf, filename, filenamelen + 1);
+	name = buf;
 
 	/*
 	 * Handle root-direcoty ('/')
 	 */
 	inum = root_inum;
-	if (!name || *name == '\0')
+	if (!name || *name == '\0') {
+		kfree(buf);
 		return inum;
+	}
 
 	for (;;) {
 		struct inode *inode;
@@ -537,41 +543,53 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
 			while (*next == '/')
 				*(next++) = '\0';
 		}
-
 		ret = ubifs_finddir(sb, name, root_inum, &inum);
-		if (!ret)
+		if (!ret) {
+			kfree(buf);
 			return 0;
+		}
 		inode = ubifs_iget(sb, inum);
 
-		if (!inode)
+		if (!inode) {
+			kfree(buf);
 			return 0;
+		}
 		ui = ubifs_inode(inode);
 
 		if ((inode->i_mode & S_IFMT) == S_IFLNK) {
-			char buf[128];
+			size_t newbufsize;
+			char *newbuf;
+			char *linkdata = ui->data;
+			size_t linklen = ui->data_len;
 
 			/* We have some sort of symlink recursion, bail out */
 			if (symlink_count++ > 8) {
 				ubifs_iput(inode);
 				printf("Symlink recursion, aborting\n");
+				kfree(buf);
 				return 0;
 			}
-			memcpy(link_name, ui->data, ui->data_len);
-			link_name[ui->data_len] = '\0';
 
-			if (link_name[0] == '/') {
-				/* Absolute path, redo everything without
-				 * the leading slash */
-				next = name = link_name + 1;
+			while (linklen && *linkdata == '/') {
+				/* Absolute path, i.e. relative to root. */
 				root_inum = 1;
+				linkdata++;
+				linklen--;
+			}
+			newbufsize =
+				linklen + 1 + (next ? strlen(next) : 0) + 1;
+			newbuf = kmalloc(newbufsize, GFP_NOFS);
+			if (!newbuf) {
+				kfree(buf);
 				ubifs_iput(inode);
-				continue;
+				return -ENOMEM;
 			}
-			/* Relative to cur dir */
-			sprintf(buf, "%s/%s",
-					link_name, next == NULL ? "" : next);
-			memcpy(symlinkpath, buf, sizeof(buf));
-			next = name = symlinkpath;
+
+			memcpy(newbuf, linkdata, linklen);
+			sprintf(newbuf + linklen, "/%s", next ?: "");
+			kfree(buf);
+			buf = newbuf;
+			name = newbuf;
 			ubifs_iput(inode);
 			continue;
 		}
@@ -583,6 +601,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
 		/* Found the node!  */
 		if (!next || *next == '\0') {
 			ubifs_iput(inode);
+			kfree(buf);
 			return inum;
 		}
 
@@ -590,6 +609,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
 		name = next;
 	}
 
+	kfree(buf);
 	return 0;
 }
 
-- 
2.54.0

