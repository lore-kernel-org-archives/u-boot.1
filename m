Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28014C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92EF481E06;
	Wed, 19 Mar 2025 15:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CINbOXqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3117C81E02; Wed, 19 Mar 2025 15:38:48 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA37581DE3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3986011f8f.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395125; x=1742999925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D9rTcXbUNRe3OxIorWASboU/Fku7vYdN77JmmCWRuvs=;
 b=CINbOXqOI7+cS7pVIUA+qGseyQAKgSBJbQvPdlI3sJNJJjh/7h3FORIYUfvxaARTHZ
 kABWVMdLG1cGg4YzvERTJfUv6PPJuJMx68dUMrwqT5UBKrJBDWAdRx1ZhQlu+ZhyANFB
 8unBrGDNlshA7fGMrRBCFVqu0rIUCoiBSfBac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395125; x=1742999925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D9rTcXbUNRe3OxIorWASboU/Fku7vYdN77JmmCWRuvs=;
 b=mVkdjRlPWKwwXSwuCqBfsdJxKAeTAxdyPPCHNIMc7/Ja/g8xtVgXtsN5Vxo8ptCBfr
 yapiWmb2UeUIPbaA2SOZKK75SF+9P5KUlPFz1Hxde4Qn7UV1CCJs4p/fM73JC6OmJkg2
 UJAdSHUGkCyRkl1f/l89qlEid66ENwfpEY18acLNf6JdcRP3lBPKHjIf7cXE+wmw8NCp
 Xf53H6TRcBprjbEM5sAOZjRX+nILWFTUBX45qQ1KlY2ZVh9iJa2HrKRPMBMPJRHtM6ft
 j/Xp8yc3oEJdOAZ8+Um1DX5GobdvWZDwUnz5RT5ySwxDm8D2ZoBIaQDyyWWBMvZBetlf
 aSIA==
X-Gm-Message-State: AOJu0YyN3+ciNAXx0kq6sQBPFNCq4NlHzi+5zZm6IPDpRjx6OR6Rj+Oo
 VYNeEbwxAyoXkHwGCMqaOVLQYO4Q2AnDFDO/9Y8R/frh/9YZ3cX9lzOs5dlnb2KxQCaJy61R/wk
 =
X-Gm-Gg: ASbGnct12zxzWSypFJZPKpuffkujZNVIRDA9FyfUjdX10sYO+PhnPZaExJBAP2FEV6y
 A64GconEHin9ooNpKJpp40op+3aBUPJYfZ1f0vg5xEL/jGMBqQSk0+KJP5F+7qTFE4hBqDC38Hl
 Boi6Tj9bvP3ebFDrzaLEtGiUwCRsm88AEtn4MRb48dTVXix9qHBFp52ObNS5EgjEe6CxXlYIQCY
 ydz35mwaTvc9g9jWx2l7I8pJXlQOwMKvgDqm/zSJL4M+d2rQp8eFhMcR+T4tO0ouEij0ykAnrq/
 vVpHx4qw5XKee7qNYc+anEGBd0adNb/0bgMH2EAD6w==
X-Google-Smtp-Source: AGHT+IFmlWrXzBI4xJDxtDElrCxAl/cZ64kp6qbVJWO4Shm4Dyexp8JAqMvfF0gtSTZfYdpK6aZYug==
X-Received: by 2002:a5d:5983:0:b0:390:f641:d8bb with SMTP id
 ffacd0b85a97d-39973b500d3mr2485393f8f.36.1742395124779; 
 Wed, 19 Mar 2025 07:38:44 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:38:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/17] fs: boot: Update fs_read_alloc() to use abuf
Date: Wed, 19 Mar 2025 15:37:55 +0100
Message-ID: <20250319143820.2385092-2-sjg@chromium.org>
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

 boot/bootmeth-uclass.c | 19 ++++++++++---------
 fs/fs.c                | 25 +++++++++++--------------
 include/fs.h           |  8 +++++---
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 014b7588e8d..78a3671f96a 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -332,7 +332,8 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
 			enum bootflow_img_t type)
 {
 	struct blk_desc *desc = NULL;
-	void *buf;
+	struct abuf buf;
+	ulong addr;
 	uint size;
 	int ret;
 
@@ -346,13 +347,13 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
 		return log_msg_ret("all", ret);
 
 	bflow->state = BOOTFLOWST_READY;
-	bflow->buf = buf;
+	addr = abuf_addr(&buf);
+	bflow->buf = abuf_uninit_move(&buf, NULL);
 
 	if (bflow->blk)
 		desc = dev_get_uclass_plat(bflow->blk);
 
-	if (!bootflow_img_add(bflow, bflow->fname, type, map_to_sysmem(buf),
-			      size))
+	if (!bootflow_img_add(bflow, bflow->fname, type, addr, size))
 		return log_msg_ret("bai", -ENOMEM);
 
 	return 0;
@@ -362,9 +363,10 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
 			 enum bootflow_img_t type, void **bufp, uint *sizep)
 {
 	struct blk_desc *desc = NULL;
+	struct abuf buf;
 	char path[200];
 	loff_t size;
-	void *buf;
+	size_t bsize;
 	int ret;
 
 	snprintf(path, sizeof(path), "%s%s", bflow->subdir, fname);
@@ -388,12 +390,11 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
 	if (ret)
 		return log_msg_ret("all", ret);
 
-	if (!bootflow_img_add(bflow, bflow->fname, type, map_to_sysmem(buf),
-			      size))
+	if (!bootflow_img_add(bflow, bflow->fname, type, abuf_addr(&buf), size))
 		return log_msg_ret("boi", -ENOMEM);
 
-	*bufp = buf;
-	*sizep = size;
+	*bufp = abuf_uninit_move(&buf, &bsize);
+	*sizep = bsize;
 
 	return 0;
 }
diff --git a/fs/fs.c b/fs/fs.c
index 77f7879276a..e904b93258a 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -1010,31 +1010,27 @@ int do_fs_types(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 	return CMD_RET_SUCCESS;
 }
 
-int fs_read_alloc(const char *fname, ulong size, uint align, void **bufp)
+int fs_read_alloc(const char *fname, ulong size, uint align, struct abuf *buf)
 {
 	loff_t bytes_read;
-	ulong addr;
-	char *buf;
 	int ret;
 
 	if (!align)
 		align = ARCH_DMA_MINALIGN;
 
-	buf = memalign(align, size + 1);
-	if (!buf)
+	abuf_init(buf);
+	if (!abuf_realloc(buf, size + 1))
 		return log_msg_ret("buf", -ENOMEM);
-	addr = map_to_sysmem(buf);
+	buf->size--;
 
-	ret = fs_read(fname, addr, 0, size, &bytes_read);
+	ret = fs_read(fname, abuf_addr(buf), 0, size, &bytes_read);
 	if (ret) {
-		free(buf);
+		abuf_uninit(buf);
 		return log_msg_ret("read", ret);
 	}
 	if (size != bytes_read)
 		return log_msg_ret("bread", -EIO);
-	buf[size] = '\0';
-
-	*bufp = buf;
+	((char *)buf->data)[size] = '\0';
 
 	return 0;
 }
@@ -1043,8 +1039,9 @@ int fs_load_alloc(const char *ifname, const char *dev_part_str,
 		  const char *fname, ulong max_size, ulong align, void **bufp,
 		  ulong *sizep)
 {
+	struct abuf buf;
+	size_t bsize;
 	loff_t size;
-	void *buf;
 	int ret;
 
 	if (fs_set_blk_dev(ifname, dev_part_str, FS_TYPE_ANY))
@@ -1063,8 +1060,8 @@ int fs_load_alloc(const char *ifname, const char *dev_part_str,
 	ret = fs_read_alloc(fname, size, align, &buf);
 	if (ret)
 		return log_msg_ret("al", ret);
-	*sizep = size;
-	*bufp = buf;
+	*bufp = abuf_uninit_move(&buf, &bsize);
+	*sizep = bsize;
 
 	return 0;
 }
diff --git a/include/fs.h b/include/fs.h
index 2474880385d..7ff649da821 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -7,6 +7,7 @@
 
 #include <rtc.h>
 
+struct abuf;
 struct cmd_tbl;
 
 #define FS_TYPE_ANY	0
@@ -326,11 +327,12 @@ int do_fs_types(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
  * @fname: Filename to read
  * @size: Size of file to read (must be correct!)
  * @align: Alignment to use for memory allocation (0 for default: ARCH_DMA_MINALIGN)
- * @bufp: On success, returns the allocated buffer with the nul-terminated file
- *	in it
+ * @buf: On success, returns the allocated buffer with the nul-terminated file
+ *	in it. The buffer size is set to the size excluding the terminator. The
+ *	buffer is inited by this function and must be uninited by the caller
  * Return: 0 if OK, -ENOMEM if out of memory, -EIO if read failed
  */
-int fs_read_alloc(const char *fname, ulong size, uint align, void **bufp);
+int fs_read_alloc(const char *fname, ulong size, uint align, struct abuf *buf);
 
 /**
  * fs_load_alloc() - Load a file into allocated space
-- 
2.43.0

