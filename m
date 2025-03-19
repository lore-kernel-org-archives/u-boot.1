Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3F6C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC533819B1;
	Wed, 19 Mar 2025 15:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EzCOYneG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD1DF81E1F; Wed, 19 Mar 2025 15:38:49 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5AC8803CC
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so31296965e9.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395127; x=1742999927; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+K/u82J8vSqDjTka/9k1rHAqM9JfP9IFwmi6Df5UBM=;
 b=EzCOYneGGRSqdsrn2E3txVj6gvaQZexBgA965h95ATbfFIhQPF8ea1nRIMsSkE3TpI
 HoP1EObflarAZ3k5sG07dw+X5QjNfT9UfyHflmjZWm03B7Q3oBUcIHGWjr/1gi3IxQpl
 B/R4kwWNb2kGBx3KlIh+fReALeZS8nUGQE41M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395127; x=1742999927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0+K/u82J8vSqDjTka/9k1rHAqM9JfP9IFwmi6Df5UBM=;
 b=lth5PbrThrcW6lWrjUflOBkBnY6nQ4Xwo3ydKdsnh1h+5/Jku4T3jJH/tsKRiGtnVB
 mBSL7+VVruO70pjwjwXj91Q0pT8+ECUp+EHZPSttRiHxDm4sYv101zsbkEZwf6RhdT73
 QPWiBwWYp44XMMqV7Hf0Z3fsXk+m1zl9sWrlrDA0vXbH5ReMNUtbd09hV6xKsH9+fI72
 yp2/HYABSqBZE5BxGm8AYjqFnvi2aZ4RuqjU01u1q21VoUwTbAjGu9bv7HLR4ssbZBkt
 WuRrd7zgenMxaI1QsoIfwQ7G+spwBuxb1O8mNSCuyajDPDf+fFl5XPCWAbHk0U6wqTly
 nmmw==
X-Gm-Message-State: AOJu0YzG5zDEioiU70W7pW1K2gShYCofNLftpz0xcrN/jTN1/N5JRV2F
 9NM77Qmv8cLd7swsGZV0U0hr9d93vBZQB3bij79nuWjDusuxaF1XvnMI/in/fHMdHCCPkXjLOeo
 =
X-Gm-Gg: ASbGncsW3gqFyp1L8BOIF36L1/oR/Z2tDhvx3PzDuIKGIV7/M/6KZevQdViuAQsgvHH
 q1BR+0X16vqkt+CQusiMgCq5PI3HVkdix9f5rOXh3lxj/GXcONz59vaSlCimrR7ZIknbkVOK07V
 og6TfBExYmsqce019du7XLunkptddVcGINa7yS8lFXzL2N15fcOS04zAYeUtx0aAke99TCheBgd
 RD8gdRBcgPNixgG8weFvepeCy/1xUcxhQb5FlUmGb5vUgoOLZurxjfbxscC/f+AADwKxtsnjh7K
 0tIeR1ptuvcLI0nHvthLln5hKBY9ZCDAlJlF+1o6EQ==
X-Google-Smtp-Source: AGHT+IEJb2O/+SNZJfhns3Gse3iw7oydZNYw/C/Nq4vu7chvWCMZhgl/pNhqpOKKOMZwcF3GqM3WMQ==
X-Received: by 2002:a05:600c:4e44:b0:43c:f4b3:b094 with SMTP id
 5b1f17b1804b1-43d4378041cmr32521005e9.6.1742395126464; 
 Wed, 19 Mar 2025 07:38:46 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:38:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Roger Knecht <rknecht@pm.me>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/17] fs: boot: Update fs_load_alloc() to use abuf
Date: Wed, 19 Mar 2025 15:37:56 +0100
Message-ID: <20250319143820.2385092-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

Using an abuf for this function simplifies returning the size and also
makes it easier to free memory afterwards. Update the API and callers.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/cat.c    | 13 ++++++-------
 cmd/cedit.c  | 18 ++++++++----------
 fs/fs.c      | 11 ++++-------
 include/fs.h | 10 +++++-----
 4 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/cmd/cat.c b/cmd/cat.c
index 6828b7b364e..24983cb9ca0 100644
--- a/cmd/cat.c
+++ b/cmd/cat.c
@@ -4,6 +4,7 @@
  * Roger Knecht <rknecht@pm.de>
  */
 
+#include <abuf.h>
 #include <command.h>
 #include <fs.h>
 #include <malloc.h>
@@ -12,11 +13,10 @@
 static int do_cat(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[])
 {
+	struct abuf buf;
 	char *ifname;
 	char *dev;
 	char *file;
-	char *buffer;
-	ulong file_size;
 	int ret;
 
 	if (argc < 4)
@@ -26,8 +26,7 @@ static int do_cat(struct cmd_tbl *cmdtp, int flag, int argc,
 	dev = argv[2];
 	file = argv[3];
 
-	ret = fs_load_alloc(ifname, dev, file, 0, 0, (void **)&buffer,
-			    &file_size);
+	ret = fs_load_alloc(ifname, dev, file, 0, 0, &buf);
 
 	// check file exists
 	switch (ret) {
@@ -51,10 +50,10 @@ static int do_cat(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	// print file content
-	buffer[file_size] = '\0';
-	puts(buffer);
+	((char *)buf.data)[buf.size] = '\0';
+	puts(buf.data);
 
-	free(buffer);
+	abuf_uninit(&buf);
 
 	return 0;
 }
diff --git a/cmd/cedit.c b/cmd/cedit.c
index f696356419e..b0eca7b4daf 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -34,22 +34,21 @@ static int do_cedit_load(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	const char *fname;
 	struct expo *exp;
+	struct abuf buf;
 	oftree tree;
-	ulong size;
-	void *buf;
 	int ret;
 
 	if (argc < 4)
 		return CMD_RET_USAGE;
 	fname = argv[3];
 
-	ret = fs_load_alloc(argv[1], argv[2], argv[3], SZ_1M, 0, &buf, &size);
+	ret = fs_load_alloc(argv[1], argv[2], argv[3], SZ_1M, 0, &buf);
 	if (ret) {
 		printf("File not found\n");
 		return CMD_RET_FAILURE;
 	}
 
-	tree = oftree_from_fdt(buf);
+	tree = oftree_from_fdt(abuf_uninit_move(&buf, NULL));
 	if (!oftree_valid(tree)) {
 		printf("Cannot create oftree\n");
 		return CMD_RET_FAILURE;
@@ -125,31 +124,30 @@ static int do_cedit_read_fdt(struct cmd_tbl *cmdtp, int flag, int argc,
 			     char *const argv[])
 {
 	const char *fname;
-	void *buf;
+	struct abuf buf;
 	oftree tree;
-	ulong size;
 	int ret;
 
 	if (argc < 4)
 		return CMD_RET_USAGE;
 	fname = argv[3];
 
-	ret = fs_load_alloc(argv[1], argv[2], argv[3], SZ_1M, 0, &buf, &size);
+	ret = fs_load_alloc(argv[1], argv[2], argv[3], SZ_1M, 0, &buf);
 	if (ret) {
 		printf("File not found\n");
 		return CMD_RET_FAILURE;
 	}
 
-	tree = oftree_from_fdt(buf);
+	tree = oftree_from_fdt(buf.data);
 	if (!oftree_valid(tree)) {
-		free(buf);
+		abuf_uninit(&buf);
 		printf("Cannot create oftree\n");
 		return CMD_RET_FAILURE;
 	}
 
 	ret = cedit_read_settings(cur_exp, tree);
 	oftree_dispose(tree);
-	free(buf);
+	abuf_uninit(&buf);
 	if (ret) {
 		printf("Failed to read settings: %dE\n", ret);
 		return CMD_RET_FAILURE;
diff --git a/fs/fs.c b/fs/fs.c
index e904b93258a..3505e698ba2 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -5,6 +5,7 @@
 
 #define LOG_CATEGORY LOGC_CORE
 
+#include <abuf.h>
 #include <bootstd.h>
 #include <command.h>
 #include <config.h>
@@ -1036,11 +1037,9 @@ int fs_read_alloc(const char *fname, ulong size, uint align, struct abuf *buf)
 }
 
 int fs_load_alloc(const char *ifname, const char *dev_part_str,
-		  const char *fname, ulong max_size, ulong align, void **bufp,
-		  ulong *sizep)
+		  const char *fname, ulong max_size, ulong align,
+		  struct abuf *buf)
 {
-	struct abuf buf;
-	size_t bsize;
 	loff_t size;
 	int ret;
 
@@ -1057,11 +1056,9 @@ int fs_load_alloc(const char *ifname, const char *dev_part_str,
 	if (fs_set_blk_dev(ifname, dev_part_str, FS_TYPE_ANY))
 		return log_msg_ret("set", -ENOMEDIUM);
 
-	ret = fs_read_alloc(fname, size, align, &buf);
+	ret = fs_read_alloc(fname, size, align, buf);
 	if (ret)
 		return log_msg_ret("al", ret);
-	*bufp = abuf_uninit_move(&buf, &bsize);
-	*sizep = bsize;
 
 	return 0;
 }
diff --git a/include/fs.h b/include/fs.h
index 7ff649da821..653e6e37738 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -344,15 +344,15 @@ int fs_read_alloc(const char *fname, ulong size, uint align, struct abuf *buf);
  * @fname: Filename to read
  * @max_size: Maximum allowed size for the file (use 0 for 1GB)
  * @align: Alignment to use for memory allocation (0 for default)
- * @bufp: On success, returns the allocated buffer with the nul-terminated file
- *	in it
- * @sizep: On success, returns the size of the file
+ * @buf: On success, returns the allocated buffer with the nul-terminated file
+ *	in it. The buffer size is set to the size excluding the terminator. The
+ *	buffer is inited by this function and must be uninited by the caller
  * Return: 0 if OK, -ENOMEM if out of memory, -ENOENT if the file does not
  * exist, -ENOMEDIUM if the device does not exist, -E2BIG if the file is too
  * large (greater than @max_size), -EIO if read failed
  */
 int fs_load_alloc(const char *ifname, const char *dev_part_str,
-		  const char *fname, ulong max_size, ulong align, void **bufp,
-		  ulong *sizep);
+		  const char *fname, ulong max_size, ulong align,
+		  struct abuf *buf);
 
 #endif /* _FS_H */
-- 
2.43.0

