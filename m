Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882E6C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD00980882;
	Wed, 22 Jan 2025 14:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C0g0i+yi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8B7801FB; Wed, 22 Jan 2025 06:33:32 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3DE380137
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 06:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6f19a6c04so548581385a.0
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 21:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737524008; x=1738128808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wc8IJrDr9y9dZxHjglqxfiyjgroSBDngUTAAbElnm2I=;
 b=C0g0i+yifUB0UcDXaWNuILv8wDR1dIRNXxPco//y79vzuMEsXfb3hHXUj/6gpQPf5P
 zKqM01BNNy0UY1tLGKqZOOplE+2Oo875lslM81zJrvnXNZCPyDyfafxu6YDgPC7b5ivZ
 LjfQC0shNXG7isIc3/92O4h9zpE0k2ntxYQ+vrMtMXd3qrex5X5rSigbglCGht3GObwZ
 FLECdZTQi39EvjTklwxqUHPnlciH+0dc4V7TlZRPfkvXNruEKTd/gr7OLIz/x4n113qq
 q5TaO9TgcketExd+iKMd6vD73oZpyNTw2fpHYYXzQ2+Tl8JRG9FRI88vzDBa0RWSqtvx
 w/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737524008; x=1738128808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wc8IJrDr9y9dZxHjglqxfiyjgroSBDngUTAAbElnm2I=;
 b=K+ink9AvkqaYMZrUHqf2rTNy0SkDoB9oDswhxUPcmOBdGHA6VrndxNB+mnCwCRhalu
 uAz/nPXeCMPDKpoC+vsQd5ooedvYmvWH1waw6GIjWup3jtQUACFRPnk3f2l/HpNgDBzf
 jjBc7TBQIL+xCrSpYsdmyvmeh2dO9CRBbBH6cL/2p9qi7q50az90tg2uBeh7lhgCGAQB
 IaZhle66VInE6RQjAV7GoPmTY8y4FnPoaN6cr+RFWJ0oeNLUgsoJdiTaj0kP4A+iijKm
 Oj96JAQ70s2UkI5E4gbHLNHi3qIGbsSvj45ifSIRlNfQe5YG+iXioECybsXd5yoQKVD5
 LqRA==
X-Gm-Message-State: AOJu0Yx/jhHMDrBb3VtnzmdnfKk/i5Cx6ywhiwLIe7M8lGGlm5ly/kPi
 k0TuGiI5bn7jNj8R1X9+biGOFijdQEpxZ2LEVG4Pn/0Dx7qOiAYii2qo4LAdYdA=
X-Gm-Gg: ASbGncvjw0qfmQIa+7/uerbwPJHuXtDiDx8kn29DewbYjSbplf2E+1Okg78RWT1EfhC
 9nSiN//Bo3HEoYQbBFTDO8KvuTUKY0vYsn5IiYdm2rbjEOFGRNsb7iO8X0b0jlW1nirzYfL8gzf
 +E/9P2yyOKd2mHleMLFJsMiHAbIyrQsam4uUxpRFhpcI4BUWZB870duEsqdNMgHcvf7LUI2av6U
 FL66ggIVUvf7P7e8+NYlYCGIp9G9W0UY1s/guODl51S60DoELmQ3bgWTTsB4YCk4vMtZhYTnP5W
 LaHrfADhhwTComhoivjCq+/0/IfsdJHCZdlu99Byw9COzRpSOTN28jz4FXiYAVSflpTRXl0Aql/
 ENYBx
X-Google-Smtp-Source: AGHT+IGL3j3j1ggQ6+MU5erQ/DnyrWxI9jX4M3VxpeClyks/elVdKOaBBIDb5u1+siOzwns7AjzOuA==
X-Received: by 2002:a05:620a:f01:b0:7b6:da92:fcd0 with SMTP id
 af79cd13be357-7be63210312mr3436528485a.8.1737524008128; 
 Tue, 21 Jan 2025 21:33:28 -0800 (PST)
Received: from localhost.localdomain
 (bras-base-btfdon1720w-grc-54-174-88-143-14.dsl.bell.ca. [174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614d98b2sm634136785a.76.2025.01.21.21.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 21:33:27 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/6] fs: add rename infrastructure
Date: Wed, 22 Jan 2025 00:32:27 -0500
Message-Id: <20250122053232.17365-3-gabriel.dalimonte@gmail.com>
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

 fs/fs.c      | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/fs.h | 13 +++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/fs/fs.c b/fs/fs.c
index 99ddcc5e37..160a43c957 100644
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
+		log_err("** Unable to rename %s -> %s **\n", old_path, new_path);
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
@@ -975,6 +1007,21 @@ int do_ln(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	return 0;
 }
 
+int do_rename(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
+	      int fstype)
+{
+	if (argc != 5)
+		return CMD_RET_USAGE;
+
+	if (fs_set_blk_dev(argv[1], argv[2], fstype))
+		return 1;
+
+	if (fs_rename(argv[3], argv[4]))
+		return 1;
+
+	return 0;
+}
+
 int do_fs_types(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 {
 	struct fstype_info *drv = fstypes;
diff --git a/include/fs.h b/include/fs.h
index 2474880385..24b121f55d 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -270,6 +270,17 @@ int fs_unlink(const char *filename);
  */
 int fs_mkdir(const char *filename);
 
+/**
+ * fs_rename - rename a file or directory
+ *
+ * @old_path: existing path of the file/directory to rename
+ * @new_path: new path of the file/directory. If this points to an existing
+ * file or empty directory, the existing file/directory will be unlinked.
+ *
+ * Return: 0 on success, -1 on error conditions
+ */
+int fs_rename(const char *old_path, const char *new_path);
+
 /*
  * Common implementation for various filesystem commands, optionally limited
  * to a specific filesystem type via the fstype parameter.
@@ -290,6 +301,8 @@ int do_mkdir(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	     int fstype);
 int do_ln(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	  int fstype);
+int do_rename(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
+	      int fstype);
 
 /*
  * Determine the UUID of the specified filesystem and print it. Optionally it is
-- 
2.34.1

