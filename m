Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29951C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 20:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D7D484CAD;
	Mon, 13 Jul 2026 21:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lgWQ4dG+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BB1384C4F; Mon, 13 Jul 2026 16:27:31 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F28E84C06
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493b779003fso14204985e9.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783952848; x=1784557648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ld8zaGpioEdhLkrTI1mQFECS3AIphnchbz29EClg6vQ=;
 b=lgWQ4dG+QnE1fOnG1x5iGFChfn6Wpu954pn4ICjovjLEHCEgplJ58RnNc8iVnSxT04
 8uLL382ujB88Kyo31lULYOk7JfRpiWyRfnNnhhJFJEZpzaNNHTe/8hMwHD4iLENbO+Os
 1X9zjKB222kGQA+S8E4H6Tk9rH/LlponBAGSNzWePXFLGoplSa0GL3WLqNPPioDdOQld
 o1lcXQyAFM/81J1xrDLrkMonBtUwAYqjn3SCfOfRQfCNJuX56KICbFARDOScsXa/gtCo
 fBaXKZDanSYYqnNBPuMYbWw1DBy1VIG0pYKZf5BNKwAfgzZJD29nL3Hue6W7pFJuEvh2
 eueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952848; x=1784557648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ld8zaGpioEdhLkrTI1mQFECS3AIphnchbz29EClg6vQ=;
 b=JXitq7SZ6ClIi0nN3RtS+tmpMxX54ZJzD6phgHvMStvXXwxX3uHE859FH9H1VMMNAZ
 5BKbj7PmUpvUSWANzCKfcRogBRuUJJoh1+tw6iquReNZIY0PZ5tVtvl7hY3A3767Sy7b
 k4U++XFJ01Wpw1FV6aUnO9Bwm7K9E+DkXvvvogYuZ4pAzlqh0dpZDayGlRzP5Slo2jga
 +Ky0Pgbym+BiHet2S2JcZ9mamdmoAJKjq9emrCtdiFkqg2yewAxJGA7jIlkVWxgL0Q5g
 1KHZuqCyWYHWmcuRb++SYXSaLgdyqDhogSGKFn8YsctvhHcJixq08JpGlt03meZMlFCM
 j+Cw==
X-Gm-Message-State: AOJu0Yyxl7CqNjwkv62b2ROazJ0vcZoXBwc8AyEuC0afpFPUvHjxit12
 hCCrhX3IMIXcvQxXz+F/RwLf00Xzwy72LbbCBUlg3zUegkXPhL+IXFBadNbRBNrJ
X-Gm-Gg: AfdE7claS45Jymyi4xh/jjtZTZHYaJLPlE8KzZKY9yKvBA4srLgJYJO6Z3LtPrp04At
 l/eh5CnTZVMjvt89SrpT72A05odIN4S8eJh+a3s2SLKAvQMSMr0tAjwDXHIKU6hosxiqfc5CMat
 ImukMz0ObbNsLavwQia+jLWmPuWJtIBF5unI6X2Wgru+DoDc2oMzK+LYi60YKza+HyUmhccjbC0
 +OnOzFC1f2YwvydLfDiCnlzYVhhgh78sjAyt5QNp/0sZKb4KiDSq/NuQQTIj0dB5MSJuv/IYDzi
 KCTbynv8as9qAVnKhj/cevYlzfBOA8NYfftCrxBUw+7RTRa6u5iqFb8iyyFqy5OEllrKkya5W/R
 PpY4VqydEzWkOmfDQf6cgS/6ozIYaA5jqIObush995CsSFDpgI3q2o99lXWT2cSoTyRSuZSuI82
 vhNpQuPn82nui3iXM8oq1mVpfpRQGochNWvIiJE/FmaUmZNZir2a3UHK5AFHRydh9DjymNMcMya
 615sAjF+VUTA+5XVdfjjHOcYjhGCDKGeqMNGn2waBX1D/tc+fFTXdeU2QCgPM1RxiHWjJMp/cg7
 YUUfZ/Xd6yiCXEc=
X-Received: by 2002:a05:600c:4e0d:b0:492:6113:d4fc with SMTP id
 5b1f17b1804b1-494042b0a1emr22688205e9.17.1783952847813; 
 Mon, 13 Jul 2026 07:27:27 -0700 (PDT)
Received: from thinkpad-t15g-g2 (82-64-82-74.subs.proxad.net. [82.64.82.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm83691562f8f.13.2026.07.13.07.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 07:27:27 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Allan ELKAIM <allan.elkaim@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 3/3] fs/squashfs: fix dirs->entry leaks on
 sqfs_search_dir() error paths
Date: Mon, 13 Jul 2026 16:22:47 +0200
Message-ID: <20260713142420.2618339-7-allan.elkaim@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713142420.2618339-1-allan.elkaim@gmail.com>
References: <20260713142420.2618339-1-allan.elkaim@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 21:59:35 +0200
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

Several error paths in sqfs_search_dir() return through 'goto out'
while a directory entry obtained from sqfs_readdir_nest() is still
held, leaking dirs->entry: the inode lookup failure, the symlink
nesting limit check, every allocation/tokenization failure during
symlink resolution, and the case where readdir aborts after an
entry was already read.

Instead of freeing dirs->entry at each error site, centralize the
cleanup at the 'out' label: on error, no valid entry may be handed
back to the caller, so it can be freed unconditionally there. On
success, dirs->entry is already NULL: it is freed at the end of
each token iteration and before recursing into a symlink target,
and the root directory path never allocates it.

Explicit frees remain only where a success path needs them:
between reads in the readdir loop, at the end of each token
iteration, and before the recursive call. The now-redundant frees
on individual error paths are removed.

Suggested-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: Allan ELKAIM <allan.elkaim@gmail.com>
---

Changes in v3:
- Centralize dirs->entry cleanup at the 'out' label instead of
  freeing only on the inode lookup failure path, covering the
  remaining leaky error paths (suggested by Richard Genoud)

 fs/squashfs/sqfs.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index af32d008..471ea7d9 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -547,8 +547,10 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 		/* Get reference to inode in the inode table */
 		table = sqfs_find_inode(dirs->inode_table, new_inode_number,
 					sblk->inodes, sblk->block_size);
-		if (!table)
-			return -EINVAL;
+		if (!table) {
+			ret = -EINVAL;
+			goto out;
+		}
 		dir = (struct squashfs_dir_inode *)table;
 
 		/* Check for symbolic link and inode type sanity */
@@ -617,8 +619,6 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 			goto out;
 		} else if (!sqfs_is_dir(get_unaligned_le16(&dir->inode_type))) {
 			printf("** Cannot find directory. **\n");
-			free(dirs->entry);
-			dirs->entry = NULL;
 			ret = -EINVAL;
 			goto out;
 		}
@@ -630,8 +630,6 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 		/* Get dir. offset into the directory table */
 		offset = sqfs_dir_offset(table, m_list, m_count);
 		if (offset < 0) {
-			free(dirs->entry);
-			dirs->entry = NULL;
 			ret = offset;
 			goto out;
 		}
@@ -644,8 +642,6 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 		/* Check for empty directory */
 		if (sqfs_is_empty_dir(table)) {
 			printf("Empty directory.\n");
-			free(dirs->entry);
-			dirs->entry = NULL;
 			ret = SQFS_EMPTY_DIR;
 			goto out;
 		}
@@ -660,8 +656,6 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 
 	offset = sqfs_dir_offset(table, m_list, m_count);
 	if (offset < 0) {
-		free(dirs->entry);
-		dirs->entry = NULL;
 		ret = offset;
 		goto out;
 	}
@@ -673,6 +667,10 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 		memcpy(&dirs->i_ldir, ldir, sizeof(*ldir));
 
 out:
+	if (ret < 0) {
+		free(dirs->entry);
+		dirs->entry = NULL;
+	}
 	free(res);
 	free(rem);
 	free(path);
-- 
2.53.0

