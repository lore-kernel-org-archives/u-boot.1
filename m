Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3237C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D039880F85;
	Tue, 18 Feb 2025 06:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QF0ukIB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A592780843; Mon, 17 Feb 2025 19:31:26 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18838807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 19:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-471d1af90a0so31103461cf.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739817082; x=1740421882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4iKcYc54Y/ptOpYp7CLvxR8sl76pBdQ2fXaI6BUvfo=;
 b=QF0ukIB5FWCHmSQ4LxPyvm9f8mOmQdxhz+L9m29OmMK3pY4jhOBbb6r+MfH6RBsL6d
 LMinVjLl/dM2ADmICCyBONasfBfSeomB26+TR3DJQwCqjrjqVksIe4BBrpdPbZTWm7T9
 8KYDl9G5ByCuXUYlTp5k3MprLefqPObx7m9Lxc8jt3UYdaANSFuxNKtJBgIrQHoEzO73
 Th7yBeK+v1hNgL/UmpvDV23VvVBJJlmPoNaPNO25T0UfVJdptXxA8TlcWRyv6AdPTWZu
 F/HibJnenG0EHDDROH1q481z2Y77dPeGEfXt5wJuofxlUMB4fCCe2PD7/kDORxqjOz6l
 IipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739817082; x=1740421882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4iKcYc54Y/ptOpYp7CLvxR8sl76pBdQ2fXaI6BUvfo=;
 b=eHJbGSsdpfzLf0eBNb74MXpBQ2myvKVMksA/OnDnsUlqMff/hKn9jdW33NJwK7GGp8
 4pZT1q+OOJEK4bbgcKzTlWBXOYaz+surRya3HE+Ks3fLOiyXxcYSJgd/6AWtU3PecwoG
 g3YfZZmEZ/1m7QTvCkNvnIwH2/YKtcTIEZfrtp6AUQ1ZXhj12RnHU9By07+QeNH23Dus
 rw3cMYT7Jp6ashAbcvobPyYfADL8Xz6+P6EmjJjPDhDg2w/fiwNbwEwE2t4oB8o5OUOc
 eW0VXCvkzDvE/U/+6PyTq8tWFAgMbbR9EsYltDO14Cc+kYVvhvMZGK1B5VXl0jHsAO1J
 d2Ng==
X-Gm-Message-State: AOJu0YxYLJnbATgFpm90szYmyiNnigTEpFK7lUQyvUH/CvO0ihF7/XNg
 ZTUp9E92b5xgemtL/UTcnm2JRLc+XsDE18bq/6X3hEx6yhN+Xxbso3opOg==
X-Gm-Gg: ASbGncvKvUEWTZhKptWRjmelcUOy1if4nK23if9b3FaB+ZaV1vqPd3CsAUcCXQ57Z/b
 sO4J7BntKypaSY5U23a/05iX2eKqUM/HqnRH7fZkOHruVigcjGSO/7SR4k+nzSFQQ/ts7A4dKjX
 ADkWtR7D+q4xhECeVb4AuyMip1FL7rn4V0pzVLravSeehFRGOVkeq9rdUw7dZXJRR5X1PpUp/ag
 1jgr6cq7ncg60ZIB2hzShgDLfQDNFsFxTYHYC6SqQiMOHMWcqLgh8932kaVEU1OxrdtitSZvhCQ
 whdAN+trt7kRUcg/RdvLrKEX9Bct/l28uf5ycw==
X-Google-Smtp-Source: AGHT+IExj9uXz18xbjWv8oOgFuQ0u+tadKwYkQX9RF9FpaUcZeRr7N9tBkVg5fcIStrF9WTmP+A2qg==
X-Received: by 2002:a05:622a:6a8d:b0:471:fea3:dec4 with SMTP id
 d75a77b69052e-471fea3e4f1mr5796531cf.2.1739817082263; 
 Mon, 17 Feb 2025 10:31:22 -0800 (PST)
Received: from localhost.localdomain ([174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c2af3722sm50499271cf.49.2025.02.17.10.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:31:21 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/6] fs: add rename infrastructure
Date: Mon, 17 Feb 2025 13:26:43 -0500
Message-Id: <20250217182648.31294-3-gabriel.dalimonte@gmail.com>
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

The selection for *rename as the name for the rename/move operation
derives from the POSIX specification where they name the function
rename/renameat. [1] This aligns with Linux where the syscalls for
renaming/moving also use the rename/renameat naming.

[1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/rename.html

Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>

---

Changes in v2:
 - cleanup log message and verbosity in fs_rename()
 - update fs_close() docstring with reference to fs_rename()
 - clarify fs_rename() behaviour in docstring


---
 fs/fs.c      | 32 ++++++++++++++++++++++++++++++++
 include/fs.h | 14 +++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/fs/fs.c b/fs/fs.c
index 99ddcc5e37b..fdff83719b1 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -143,6 +143,12 @@ static inline int fs_mkdir_unsupported(const char *dirname)
 	return -1;
 }
 
+static inline int fs_rename_unsupported(const char *old_path,
+					const char *new_path)
+{
+	return -1;
+}
+
 struct fstype_info {
 	int fstype;
 	char *name;
@@ -183,6 +189,7 @@ struct fstype_info {
 	int (*unlink)(const char *filename);
 	int (*mkdir)(const char *dirname);
 	int (*ln)(const char *filename, const char *target);
+	int (*rename)(const char *old_path, const char *new_path);
 };
 
 static struct fstype_info fstypes[] = {
@@ -206,6 +213,7 @@ static struct fstype_info fstypes[] = {
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
 #endif
+		.rename = fs_rename_unsupported,
 		.uuid = fat_uuid,
 		.opendir = fat_opendir,
 		.readdir = fat_readdir,
@@ -238,6 +246,7 @@ static struct fstype_info fstypes[] = {
 		.closedir = ext4fs_closedir,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 	},
 #endif
 #if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_XPL_BUILD)
@@ -257,6 +266,7 @@ static struct fstype_info fstypes[] = {
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
 		.ln = fs_ln_unsupported,
+		.rename = fs_rename_unsupported,
 	},
 #endif
 #if CONFIG_IS_ENABLED(SEMIHOSTING)
@@ -276,6 +286,7 @@ static struct fstype_info fstypes[] = {
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
 		.ln = fs_ln_unsupported,
+		.rename = fs_rename_unsupported,
 	},
 #endif
 #ifndef CONFIG_XPL_BUILD
@@ -296,6 +307,7 @@ static struct fstype_info fstypes[] = {
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
 		.ln = fs_ln_unsupported,
+		.rename = fs_rename_unsupported,
 	},
 #endif
 #endif
@@ -317,6 +329,7 @@ static struct fstype_info fstypes[] = {
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
 		.ln = fs_ln_unsupported,
+		.rename = fs_rename_unsupported,
 	},
 #endif
 #endif
@@ -339,6 +352,7 @@ static struct fstype_info fstypes[] = {
 		.ln = fs_ln_unsupported,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 	},
 #endif
 #if IS_ENABLED(CONFIG_FS_EROFS)
@@ -360,6 +374,7 @@ static struct fstype_info fstypes[] = {
 		.ln = fs_ln_unsupported,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 	},
 #endif
 	{
@@ -378,6 +393,7 @@ static struct fstype_info fstypes[] = {
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
 		.ln = fs_ln_unsupported,
+		.rename = fs_rename_unsupported,
 	},
 };
 
@@ -713,6 +729,22 @@ int fs_ln(const char *fname, const char *target)
 	return ret;
 }
 
+int fs_rename(const char *old_path, const char *new_path)
+{
+	struct fstype_info *info = fs_get_info(fs_type);
+	int ret;
+
+	ret = info->rename(old_path, new_path);
+
+	if (ret < 0) {
+		log_debug("Unable to rename %s -> %s\n", old_path, new_path);
+		ret = -1;
+	}
+	fs_close();
+
+	return ret;
+}
+
 int do_size(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	    int fstype)
 {
diff --git a/include/fs.h b/include/fs.h
index 2474880385d..5b272eb9f5e 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -86,7 +86,7 @@ int fs_set_blk_dev_with_part(struct blk_desc *desc, int part);
  *
  * Many file functions implicitly call fs_close(), e.g. fs_closedir(),
  * fs_exist(), fs_ln(), fs_ls(), fs_mkdir(), fs_read(), fs_size(), fs_write(),
- * fs_unlink().
+ * fs_unlink(), fs_rename().
  */
 void fs_close(void);
 
@@ -270,6 +270,18 @@ int fs_unlink(const char *filename);
  */
 int fs_mkdir(const char *filename);
 
+/**
+ * fs_rename - rename/move a file or directory
+ *
+ * @old_path: existing path of the file/directory to rename
+ * @new_path: new path of the file/directory. If this points to an existing
+ * file or empty directory, the existing file/directory will be unlinked.
+ * If this points to a non-empty directory, the rename will fail.
+ *
+ * Return: 0 on success, -1 on error conditions
+ */
+int fs_rename(const char *old_path, const char *new_path);
+
 /*
  * Common implementation for various filesystem commands, optionally limited
  * to a specific filesystem type via the fstype parameter.
-- 
2.34.1

