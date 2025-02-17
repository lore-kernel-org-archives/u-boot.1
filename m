Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C585EC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70D6880F9A;
	Tue, 18 Feb 2025 06:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HklnCcJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7DA680843; Mon, 17 Feb 2025 19:31:48 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D206807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 19:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6e66b4607d2so15929016d6.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739817105; x=1740421905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJ6q6hox5d4Vm/0DHSPtYQcilAr30BUMWMgYzQ9zq0U=;
 b=HklnCcJqA0p6qZi/fCySlgKwZY7gY+tw4HAJF1GuPy0PY0oTWrDZSOtQaZ3xYlnpEE
 vCPypM2xSidKCFa5HHNcsh6N9cZlNfklM+ZDhQPTv3Q1CTRtwFkl1Haor0/dfvzkxmq1
 Kw/2KE8nJonWdf5weicKxslrmdfSkVZYRS/VgYBOceoQyQZiLi8k3frfcxbSvXzS0u5L
 9bLS+Qo/iSOSWQvbTT0yMv+rQPFJKgiokM3X+sV1kmdC6QcjG2lhau/rjJJLLFYRyy0y
 tl8WpYrvpuG2CjxrdcJkBFB4rSQ8OSP25FALMHkVC4duSwW6JmvQMix3rxuQ3O2t0y6q
 C2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739817105; x=1740421905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJ6q6hox5d4Vm/0DHSPtYQcilAr30BUMWMgYzQ9zq0U=;
 b=UYDJbr/p9PmppzT7JR7n6HVCzIf1q2un/w0l+UXvpGyOh5thWP8i5xqu6SZg7wkoym
 1/OmsaxhN+NpmWqdl59Wr1Bi/0h9jDjhplIaCgx77+kJ7/oPFkMJ/6ee3lrXrAiKOAHm
 4nX+G0omtAq8IUak4ZQSrYUgo9PqhQsSmUmotdW2Hj9NpnpDOeLEfpr9VIjTE95AhY97
 b6b3EaSf+cDDtqXXIz/ihg/yjZUeJ1AaNKzCJWiFAeeLpTVRUSkuucGWsuMRvKyGbtpr
 l6Ic2wK7pKme8E5SgJaoqh5cuPRi1oWgLdgA1dCjtlFXnip6DO1uausMRGxCSdsWMQsn
 9p0w==
X-Gm-Message-State: AOJu0YzOeiduKCHGg8hpfwfYEYJwJR+jOrtS8aTJaWHHOW7SRc8vCuyk
 IUo65xK8UDR5E/ajeTz/j5Ux+lvLpE/xlXEv5RR5k1baScks/h5wen3k/w==
X-Gm-Gg: ASbGncuCXYzDmb7+dq7M/xL35UyfkRnpSx+iaWYsWah4hPiAB5P+B/xPDCmwvaJ7hiZ
 u1Cquki45bdd2Dc4SNXkUSZqueZsKoVvQPx+aM+L/wT2C/LvYzUg6GbLlywqkcRIhT6JpAbKQ1x
 echE/5z/DsgfWSyh7jWoPbYPMnrFdyrMdHb3oAIHFfIKNiUs8IJXA5aGivDWIUJK388ua2b7O9S
 uv2lwmrEJvhXzjgyejcJmNQNd6bPNTM9jC4j3M3lVnblbqAZnCw74sarjBFafROsIK4iEOGrgap
 E4KDw8CR0NGXneI5Bn2f+LePK7W+UiuhVPzlzw==
X-Google-Smtp-Source: AGHT+IGgO8h52phApvsqwQPBv2XrDm5A59tuMpqtWcUOJCi5BoZWBYqof5HzBbiVuq3mPxClyzP/mw==
X-Received: by 2002:a05:6214:627:b0:6d8:b594:c590 with SMTP id
 6a1803df08f44-6e66ccb1139mr145836926d6.6.1739817102677; 
 Mon, 17 Feb 2025 10:31:42 -0800 (PST)
Received: from localhost.localdomain ([174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c2af3722sm50499271cf.49.2025.02.17.10.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:31:42 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/6] fs: fat: update parent dirs metadata on dentry
 create/delete
Date: Mon, 17 Feb 2025 13:26:45 -0500
Message-Id: <20250217182648.31294-5-gabriel.dalimonte@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
References: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Feb 2025 06:35:28 +0100
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

POSIX filesystem functions that create or remove directory entries contain
text along the lines of "[function] shall mark for update the last data
modification and last file status change timestamps of the parent
directory of each file." [1][2][3] The common theme is these timestamp
updates occur when a directory entry is added or removed. The
create_link() and delete_dentry_link() functions have been changed to
update the modification timestamp on the directory where the direntry
change occurs. This differs slightly from Linux in the case of rename(),
where Linux will not update `new_path`'s parent directory's timestamp if
it is replacing an existing file. (via `vfat_add_entry` [4])

The timestamps are not updated if the build configuration does not support
RTCs. This is an effort to minimize introducing erratic timestamps where
they would go from [current date] -> 2000-01-01 (error timestamp in the
FAT driver). I would assume an unchanged timestamp would be more valuable
than a default timestamp in these cases.

[1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/rename.html
[2] https://pubs.opengroup.org/onlinepubs/9799919799/functions/unlink.html
[3] https://pubs.opengroup.org/onlinepubs/9799919799/functions/open.html
[4] https://elixir.bootlin.com/linux/v6.12.6/source/fs/fat/namei_vfat.c#L682

Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>

---

Changes in v2:
 - remove setting ATTR_ARCH on parent dirs during renames
 - skip updating timestamps if no RTC present
 - make fat_itr stack allocated in update_parent_dir_props
 - update parent dir props in create_link and delete_dentry_link


---
 fs/fat/fat_write.c | 78 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index d4952e259ff..0b924541187 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -1237,6 +1237,64 @@ static int fat_itr_parent(fat_itr *itr)
 	return fat_itr_resolve(itr, "..", TYPE_DIR);
 }
 
+/**
+ * update_parent_dir_props - updates the modified time for the parent directory
+ *
+ * @dir_itr:	iterator positioned anywhere in a directory whose parent
+ * should be updated
+ * @Return:	0 for success, -errno otherwise
+ */
+static int update_parent_dir_props(fat_itr *dir_itr)
+{
+	int ret = 0;
+
+	fat_itr itr;
+	fsdata fsdata = { .fatbuf = NULL, }, *mydata = &fsdata;
+	__u32 target_clust = dir_itr->start_clust;
+
+	/* Short circuit if no RTC because it only updates timestamps */
+	if (!CONFIG_IS_ENABLED(DM_RTC))
+		return ret;
+
+	/* duplicate fsdata */
+	itr = *dir_itr;
+	fsdata = *itr.fsdata;
+
+	/* allocate local fat buffer */
+	fsdata.fatbuf = malloc_cache_aligned(FATBUFSIZE);
+	if (!fsdata.fatbuf) {
+		log_debug("Error: allocating memory\n");
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	fsdata.fatbufnum = -1;
+	itr.fsdata = &fsdata;
+
+	if (!itr.is_root) {
+		ret = fat_itr_parent(&itr);
+		if (ret)
+			goto exit;
+
+		while (fat_itr_next(&itr)) {
+			if (START(itr.dent) == target_clust)
+				goto update;
+		}
+
+		/* dent not found */
+		ret = -EIO;
+		goto exit;
+update:
+		dentry_set_time(itr.dent);
+		ret = flush_dir(&itr);
+	}
+
+exit:
+	free(fsdata.fatbuf);
+
+	return ret;
+}
+
 /**
  * create_link() - inserts a directory entry for a file or directory
  *
@@ -1270,8 +1328,9 @@ static int create_link(fat_itr *itr, char *basename, __u32 clust, __u32 size,
 	}
 
 	fill_dentry(itr->fsdata, itr->dent, shortname, clust, size, attr);
+	ret = update_parent_dir_props(itr);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1612,20 +1671,25 @@ static int delete_long_name(fat_itr *itr)
  */
 static int delete_dentry_link(fat_itr *itr)
 {
+	int ret;
+
 	itr->dent = itr->dent_start;
 	itr->remaining = itr->dent_rem;
 	/* Delete long name */
 	if ((itr->dent->attr & ATTR_VFAT) == ATTR_VFAT &&
 	    (itr->dent->nameext.name[0] & LAST_LONG_ENTRY_MASK)) {
-		int ret;
-
 		ret = delete_long_name(itr);
 		if (ret)
 			return ret;
 	}
 	/* Delete short name */
 	delete_single_dentry(itr);
-	return flush_dir(itr);
+
+	ret = flush_dir(itr);
+	if (ret)
+		return ret;
+
+	return update_parent_dir_props(itr);
 }
 
 /**
@@ -2047,6 +2111,10 @@ int fat_rename(const char *old_path, const char *new_path)
 		*new_itr->dent = *old_itr->dent;
 		new_itr->dent->nameext = new_name;
 		new_itr->dent->lcase = lcase;
+
+		ret = update_parent_dir_props(new_itr);
+		if (ret)
+			goto exit;
 	} else {
 		/* reset iterator to the start of the directory */
 		ret = fat_move_to_cluster(new_itr, new_itr->start_clust);
@@ -2089,6 +2157,8 @@ int fat_rename(const char *old_path, const char *new_path)
 		ret = flush_dir(new_itr);
 		if (ret)
 			goto exit;
+		/* restore directory location to update parent props below */
+		fat_itr_child(new_itr, new_itr);
 	}
 
 	/* refresh old in case write happened to the same block. */
-- 
2.34.1

