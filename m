Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3912EC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88FE480F77;
	Tue, 18 Feb 2025 06:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hOSACoLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 268B580843; Mon, 17 Feb 2025 19:31:19 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB572807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 19:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-471ea1a12dfso7297371cf.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739817075; x=1740421875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhbO/uEdPqMTyjZ5RoSLF2yKmW6kJ50uF02jYHg6qAg=;
 b=hOSACoLbv1mvACXv5lQL4+TUz7qnr0XQoXWluLkkKjUKEhHs/3GAwrBqP7o2Qc1936
 9Pk4k4LEeLQeGSfCPnXDcIRLnF6cJ8WoNaUZ9ozQjxyGYJdyVjZ91TfZ/ZP+wfy9X0dm
 gPqqVIULAk7dyhtpsfKgBxhKnPF1aHVBWVNg33TH4lhTzHqXvtKCf+SL2uuwT3eZkULU
 MxpXGEyQ1vgWBdbjONx177EkjbRfl137cxr/eeBAnm+KaAuKvqurWLAkYqcadf/XO5mK
 QPBpyIt034OY8dSSpWoWO+4Z5wYrrK/kelbdxbpjmtx9vVDZu6sBHy8hBgZt4lgJhV1L
 Heww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739817075; x=1740421875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhbO/uEdPqMTyjZ5RoSLF2yKmW6kJ50uF02jYHg6qAg=;
 b=AAeUh2Tt4VsMjmsfXVBUKz5QEyFMRa4pio0XH+6KjQzq6Leo9Xzmgpsx6wds9395eE
 6INoCjwpKxYHP/k/vMbkDq+WZS4kznuRDC+pmL2OsUYSHOT3IKBBI7sxQDoP4802pW6e
 1xMT+AKQSm6VK0UWkrFDgP3w90GRvrbZQMYh2jpSIaXMAdy8GbRxOU5hFw+hBX1BMttJ
 NEaXyJg8+PkCCHoyJVC6L4TlynmePu7lNMN/iCEnDkCYr+kUZFHsbkse55hYycaJmS+I
 3uPZBPBvl+pUpXnennV7HlHLoQrpTvXZ1PmhG8KMpGvdH6AvT0JgmHhYNRBAj0Njcbgx
 rKLA==
X-Gm-Message-State: AOJu0Ywdgd4TdWX6ap9OhTGZGxpnlunKF3gQiTE6Yk6vlVRiG0JHZZhQ
 SmOop98vSCCIGrj/LsQzAx/Jpf5cg66t4BghNUAHHWUEfgiqe/yFWZFVAQ==
X-Gm-Gg: ASbGncuAf7tW/pCO/OKLxkr0zIMVNSpoOeSbBQUCsesNi3RBYT0bUyJbQsn8hTwQ8Ew
 QmIxghBjprdEPBi4gVI5g4e3Q5Y8PXKWobtC3PyrTSZrqwkoYkI4j74B7aopbWwtSSNsLlDU6k6
 x1oym8nFnbYeS42lHrSXzTeqe8kQ9jJL75i5IJv+XgGP6usGoFia+Ytf5d4YOP3TrCXxyUMY1DF
 kLySxtFLQxTbAEQq1iBgwMlub8lP0lzfOqb12gw4IzQDRfUl+K8uARfiia22gv8JMJBSRhF21aE
 YMe4d+l9+4n1yqmC/DNT8f9ZHAKwUbDrnLwC1g==
X-Google-Smtp-Source: AGHT+IFMCThTYSO6jXbUEfGopKB6dasZt9Fk32gUgbnvjpxA/RG3DexiWw0xU8dNIY3z/NACMgXWuQ==
X-Received: by 2002:ac8:57c5:0:b0:471:c701:7351 with SMTP id
 d75a77b69052e-471dbccaa7dmr153917151cf.5.1739817075429; 
 Mon, 17 Feb 2025 10:31:15 -0800 (PST)
Received: from localhost.localdomain ([174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c2af3722sm50499271cf.49.2025.02.17.10.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:31:15 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/6] fs: fat: factor out dentry link create/delete
Date: Mon, 17 Feb 2025 13:26:42 -0500
Message-Id: <20250217182648.31294-2-gabriel.dalimonte@gmail.com>
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

The create_link() code was previously duplicated in two existing functions.
The two functions will be used in a future commit to achieve renaming.

Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>

---

Changes in v2:
 - update create_link() docstring
 - remove ATTR_ARCH being implicitly set in create_link()


---
 fs/fat/fat_write.c | 121 ++++++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 56 deletions(-)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index ea877ee9171..86366d03853 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -1215,6 +1215,43 @@ static void fill_dentry(fsdata *mydata, dir_entry *dentptr,
 	memcpy(&dentptr->nameext, shortname, SHORT_NAME_SIZE);
 }
 
+/**
+ * create_link() - inserts a directory entry for a file or directory
+ *
+ * @itr:	directory iterator
+ * @basename:	file name
+ * @clust:	cluster number the new directory entry should point to. Use 0
+ * if no cluster is assigned yet
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
+	fill_dentry(itr->fsdata, itr->dent, shortname, clust, size, attr);
+
+	return 0;
+}
+
 /**
  * find_directory_entry() - find a directory entry by filename
  *
@@ -1420,35 +1457,15 @@ int file_fat_write_at(const char *filename, loff_t pos, void *buffer,
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
+		ret = create_link(itr, basename, 0, size, ATTR_ARCH);
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
@@ -1564,6 +1581,31 @@ static int delete_long_name(fat_itr *itr)
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
@@ -1589,21 +1631,7 @@ static int delete_dentry_long(fat_itr *itr)
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
@@ -1725,9 +1753,6 @@ int fat_mkdir(const char *dirname)
 		ret = -EEXIST;
 		goto exit;
 	} else {
-		char shortname[SHORT_NAME_SIZE];
-		int ndent;
-
 		if (itr->is_root) {
 			/* root dir cannot have "." or ".." */
 			if (!strcmp(l_dirname, ".") ||
@@ -1737,25 +1762,9 @@ int fat_mkdir(const char *dirname)
 			}
 		}
 
-		/* Check if long name is needed */
-		ndent = set_name(itr, basename, shortname);
-		if (ndent < 0) {
-			ret = ndent;
-			goto exit;
-		}
-		ret = fat_find_empty_dentries(itr, ndent);
+		ret = create_link(itr, basename, 0, 0, ATTR_DIR | ATTR_ARCH);
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

