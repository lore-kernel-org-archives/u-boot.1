Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85BAC3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D600E809A5;
	Thu,  1 May 2025 15:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R1Vb2sws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2702782132; Thu,  1 May 2025 15:37:41 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD3D781F7E
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8647a81e683so29623439f.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106657; x=1746711457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbEs6GRSttf/ncopRq145NigTf8fiGafGgPUjjceeMk=;
 b=R1Vb2swsJmsmnk+xU+BCvc9hwDT/Ji0m1rKPsToIbV8MhfRE12SZGQCbkvk9HASI0o
 ZmAL6qu4Zly9+8dbwyv514rIWxSWM45u0bFZFVd5zXG9+YHWe4yrEXF7LK/JmxExKevZ
 OJ2TUfi2OFMUgST6ZXjq/uM7U3+TjjDcSn558=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106657; x=1746711457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbEs6GRSttf/ncopRq145NigTf8fiGafGgPUjjceeMk=;
 b=iFockCZRiHHMcnNvE8OLVuaggzpcjI4UAR+23y43T/uwBM2dow6t+9MKio1ZzIfW+L
 hjDei9CynYlPbWV3zhnjaPFs6fDZuE6nwr1mfub3GSKCOjQS9wk/F4xcSG9915psm71a
 f4LHY/qcqC9ploq7FcHSBuSaRhOnrpoY5fPhc4VOI6ovA7l5LGR1fEhYlPaSAoJkzz0D
 tTY0krdCUQyJNbgGnC9tVT9OhHRYoTiOOXcgsdbjtzeKfVoMiEz7zE1Si2Jjd+qzSsuE
 GxGlf+VdFy2WZJeDRY1wTK8ZyL3DkkQh3o6M4POukPwy5THYGlO/d2krzuXIZjao190q
 hFRg==
X-Gm-Message-State: AOJu0YwbCED5ZDBfAVZFGkRUJj+mPi/8PUaBrn68yYgnte0ihuLMcaYM
 /+guhoaMaPmbyRzN8ND29Gp4Ora4Kn4pPnuX3n7LG4vqrAcjMus/CCqi6PXeffrK5pN6BODyDOU
 =
X-Gm-Gg: ASbGncu09qQe0eQFpWcywUEdZbGqzMTamtWPUA4EcX4FnLxczN1/Z4RXK1lebkqbu71
 joNPuM1U6d8hxtrBnu7D6Guj5xgBDHEuxpLGK0AfbY1grKYMbI0MUlcFsToIzHIc0lRvWSdxrT3
 mIVUwdn3V1v9QFRztjm3SjALm17T5KENGNamwDRk0hbRmbhqz4vae8CBWEhYoDoGaYJAAid83FZ
 9xoKPy85cmE4lah6hvyrYwerHCrNn1B0S9850DOyjw94idw+kG4EY9cvd3b0miC9Yd14P1CVsf3
 j82Xs2e+YZuI19Af4v42e9aofb7ohKN/MTSNRv/6KM8wfLVul5VXdx6zxiAP+G7z2mo6W8fjEH2
 6qQ==
X-Google-Smtp-Source: AGHT+IEG8u/fnVaHYc26N/32Bs3aA3GxyrobzR6FaEFycIhti4Bp+NRVi5pbpyiwgKXqKJWXGnHTZg==
X-Received: by 2002:a05:6602:4809:b0:861:c75a:27a2 with SMTP id
 ca18e2360f4ac-864a33bd3a2mr406763739f.4.1746106656983; 
 Thu, 01 May 2025 06:37:36 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Nam Cao <namcao@linutronix.de>, Roger Knecht <rknecht@pm.me>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/18] fs: boot: Update fs_load_alloc() to use abuf
Date: Thu,  1 May 2025 07:37:03 -0600
Message-ID: <20250501133726.2627373-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
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

(no changes since v1)

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
index 61161fe5356..63ed6436493 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -5,6 +5,7 @@
 
 #define LOG_CATEGORY LOGC_CORE
 
+#include <abuf.h>
 #include <bootstd.h>
 #include <command.h>
 #include <config.h>
@@ -1153,11 +1154,9 @@ int fs_read_alloc(const char *fname, ulong size, uint align, struct abuf *buf)
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
 
@@ -1174,11 +1173,9 @@ int fs_load_alloc(const char *ifname, const char *dev_part_str,
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
index 86db5e04e80..5cd9114f33b 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -359,15 +359,15 @@ int fs_read_alloc(const char *fname, ulong size, uint align, struct abuf *buf);
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

