Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD923C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 054908083E;
	Wed, 22 Jan 2025 14:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bv4n1E1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D80F801FB; Wed, 22 Jan 2025 06:33:21 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B2080137
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 06:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7be3f230436so597063985a.3
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 21:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737523997; x=1738128797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfQ4qIQYo1C7Ki5cN6iirqz9JDYJxXN7ZAPlwA7cYts=;
 b=Bv4n1E1hUZ/APG7KufzhgsIpAhCqSyz1js9PiWOlViBMyZtDm8ulPhxLPJ3JYYfi8W
 1CGpb8c7rT2PHe0wiXrLDp/3B4cr6B8cSY6h63fguN7gDF1ZBMNYOxgaVW1gMKun1l6K
 CoQPy2lHWtq0TZ+CoITr6yi1owuVcRN76oHHanOypWSDq3JvYeYWmvL7rU/pq+e/oPV1
 ePI8ZZhXZ7NmNtTF7CbKpypaVmmw9DniY0rwzozjR4O0rhbxmz1AmtdcW76+8bKKATLR
 u3T/n2+Qve+vDp/4dKnjNeUZmmoXlIZItFWBT2QH8fcqM5Nja30bWBjYzSo3sX/CJQ6G
 MZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737523997; x=1738128797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfQ4qIQYo1C7Ki5cN6iirqz9JDYJxXN7ZAPlwA7cYts=;
 b=Yjauf8cXmoZtR1oVVx1k3fbRLAjspr6S95KH49K+lsnWBq7RBMD781tB/MEF6pAYS2
 2kJrkQsBhbD7FR9gJDWVR2Eurm1E/MKwaGQGss/WP9HtP7L++K+7n5e/JBYj39i7PkJp
 6MSshMlFzWVFOw9OH5UN4UuOA9gz8K4Y8WRyXGgkyJPTfP6FIbAEGngEv5wCps3rKaFK
 LLzPgA3RXorQSN4bsuQUVcchF3zEo/qq7Rezs7eT5cVp2nq49ChLROM1Y4MEMIo/94Bl
 NRI3y41ooNSYGd0rxLM5v6ryUGjMX3st+7frli+VxevXfpQuLkJadxVFTwYbnr1AfE9M
 2okw==
X-Gm-Message-State: AOJu0YyGKDPeWG9DJZUXsFBWIVZYuQ9yfk0jCIJhUI6IOMD07ggxG4kT
 XJWJL5QU3tvdkJ8Gyc2VxCBwgDqLroKl8kioWMwe67DPZi/Oy9MiJTIP1EOgb6w=
X-Gm-Gg: ASbGncsuxmtSbfBx5Tnks0Pz443NdKHk35TlIpNMmuBpxGEOGRUbabdGLZ76/MpsFj9
 UnKlCwzpgxw8qtRLEa/chogbaF21mM9sgZ04dKrYZ73xTHpl4zj8kjSfhSfTwKJ1XC2JWoF35ro
 LQRpGp7gKFEqoVspcx4jJUsZOzVjNGtxA90EA1zq0BvbLW2Au9XAigQmcQhYTfUyXGOm3VAtuk9
 X73gv+8cvmWST/FPgaZX4RWLcPt44e007eQ5Chtpl8WL/6exFjTuVxx6hR/GjLSwUbJnRKhE1VB
 Z9hwNSKmYbOpBuWxeg601xbmXyaWTGtxZKUm1Dh0dZonc49DkgfWYAr9LZG2gpxjEojQufn2zFk
 Ynkks
X-Google-Smtp-Source: AGHT+IGvQTJozP45hitXxLTKZzkKS3edcj48aP9J+7KXDox1+Ov+ZZNunJXCoQ714B0rJcdYvZ9Tng==
X-Received: by 2002:a05:620a:24c4:b0:7b6:d026:293 with SMTP id
 af79cd13be357-7be63210362mr3398518685a.9.1737523997337; 
 Tue, 21 Jan 2025 21:33:17 -0800 (PST)
Received: from localhost.localdomain
 (bras-base-btfdon1720w-grc-54-174-88-143-14.dsl.bell.ca. [174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614d98b2sm634136785a.76.2025.01.21.21.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 21:33:16 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] fs: fat: factor out dentry link create/delete
Date: Wed, 22 Jan 2025 00:32:26 -0500
Message-Id: <20250122053232.17365-2-gabriel.dalimonte@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Jan 2025 14:22:36 +0100
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

Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
---

 fs/fat/fat_write.c | 122 ++++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 56 deletions(-)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index ea877ee917..b86e78abc0 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -1215,6 +1215,44 @@ static void fill_dentry(fsdata *mydata, dir_entry *dentptr,
 	memcpy(&dentptr->nameext, shortname, SHORT_NAME_SIZE);
 }
 
+/**
+ * create_link() - inserts a directory entry for a cluster
+ *
+ * @itr:	directory iterator
+ * @basename:	name of the new entry
+ * @clust:	cluster number the new directory entry should point to
+ * @size:	file size
+ * @attr:	file attributes
+ * Return:	0 for success
+ */
+static int create_link(fat_itr *itr, char *basename, __u32 clust, __u32 size,
+		       __u8 attr)
+{
+	char shortname[SHORT_NAME_SIZE];
+	int ndent;
+	int ret;
+
+	/* Check if long name is needed */
+	ndent = set_name(itr, basename, shortname);
+	if (ndent < 0)
+		return ndent;
+	ret = fat_find_empty_dentries(itr, ndent);
+	if (ret)
+		return ret;
+	if (ndent > 1) {
+		/* Set long name entries */
+		ret = fill_dir_slot(itr, basename, shortname);
+		if (ret)
+			return ret;
+	}
+
+	/* Add attribute as archive */
+	fill_dentry(itr->fsdata, itr->dent, shortname, clust, size,
+		    attr | ATTR_ARCH);
+
+	return 0;
+}
+
 /**
  * find_directory_entry() - find a directory entry by filename
  *
@@ -1420,35 +1458,15 @@ int file_fat_write_at(const char *filename, loff_t pos, void *buffer,
 		/* Update change date */
 		dentry_set_time(retdent);
 	} else {
-		/* Create a new file */
-		char shortname[SHORT_NAME_SIZE];
-		int ndent;
-
 		if (pos) {
 			/* No hole allowed */
 			ret = -EINVAL;
 			goto exit;
 		}
 
-		/* Check if long name is needed */
-		ndent = set_name(itr, basename, shortname);
-		if (ndent < 0) {
-			ret = ndent;
-			goto exit;
-		}
-		ret = fat_find_empty_dentries(itr, ndent);
+		ret = create_link(itr, basename, 0, size, 0);
 		if (ret)
 			goto exit;
-		if (ndent > 1) {
-			/* Set long name entries */
-			ret = fill_dir_slot(itr, basename, shortname);
-			if (ret)
-				goto exit;
-		}
-
-		/* Set short name entry */
-		fill_dentry(itr->fsdata, itr->dent, shortname, 0, size,
-			    ATTR_ARCH);
 
 		retdent = itr->dent;
 	}
@@ -1564,6 +1582,31 @@ static int delete_long_name(fat_itr *itr)
 	return 0;
 }
 
+/**
+ * delete_dentry_link() - deletes a directory entry, but not the cluster chain
+ * it points to
+ *
+ * @itr:	the first directory entry (if a longname) to remove
+ * Return:	0 for success
+ */
+static int delete_dentry_link(fat_itr *itr)
+{
+	itr->dent = itr->dent_start;
+	itr->remaining = itr->dent_rem;
+	/* Delete long name */
+	if ((itr->dent->attr & ATTR_VFAT) == ATTR_VFAT &&
+	    (itr->dent->nameext.name[0] & LAST_LONG_ENTRY_MASK)) {
+		int ret;
+
+		ret = delete_long_name(itr);
+		if (ret)
+			return ret;
+	}
+	/* Delete short name */
+	delete_single_dentry(itr);
+	return flush_dir(itr);
+}
+
 /**
  * delete_dentry_long() - remove directory entry
  *
@@ -1589,21 +1632,7 @@ static int delete_dentry_long(fat_itr *itr)
 		if (ret)
 			return ret;
 	}
-	itr->dent = itr->dent_start;
-	itr->remaining = itr->dent_rem;
-	dent = itr->dent_start;
-	/* Delete long name */
-	if ((dent->attr & ATTR_VFAT) == ATTR_VFAT &&
-	    (dent->nameext.name[0] & LAST_LONG_ENTRY_MASK)) {
-		int ret;
-
-		ret = delete_long_name(itr);
-		if (ret)
-			return ret;
-	}
-	/* Delete short name */
-	delete_single_dentry(itr);
-	return flush_dir(itr);
+	return delete_dentry_link(itr);
 }
 
 int fat_unlink(const char *filename)
@@ -1725,9 +1754,6 @@ int fat_mkdir(const char *dirname)
 		ret = -EEXIST;
 		goto exit;
 	} else {
-		char shortname[SHORT_NAME_SIZE];
-		int ndent;
-
 		if (itr->is_root) {
 			/* root dir cannot have "." or ".." */
 			if (!strcmp(l_dirname, ".") ||
@@ -1737,25 +1763,9 @@ int fat_mkdir(const char *dirname)
 			}
 		}
 
-		/* Check if long name is needed */
-		ndent = set_name(itr, basename, shortname);
-		if (ndent < 0) {
-			ret = ndent;
-			goto exit;
-		}
-		ret = fat_find_empty_dentries(itr, ndent);
+		ret = create_link(itr, basename, 0, 0, ATTR_DIR);
 		if (ret)
 			goto exit;
-		if (ndent > 1) {
-			/* Set long name entries */
-			ret = fill_dir_slot(itr, basename, shortname);
-			if (ret)
-				goto exit;
-		}
-
-		/* Set attribute as archive for regular file */
-		fill_dentry(itr->fsdata, itr->dent, shortname, 0, 0,
-			    ATTR_DIR | ATTR_ARCH);
 
 		retdent = itr->dent;
 	}
-- 
2.34.1

