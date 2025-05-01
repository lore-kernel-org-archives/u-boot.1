Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E483C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920E782102;
	Thu,  1 May 2025 15:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qds0FTg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4C481FDE; Thu,  1 May 2025 15:37:39 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2458880EFB
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85df99da233so98701339f.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106655; x=1746711455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4J3iDA6iJi5pfqZv97ROh4XFJI1xJ18uAD9GIXMpqRk=;
 b=Qds0FTg+3NEhrVwMtV46Gs4Dyuh8VUArSICMb+66OJJO4dFz60h6Ypvbn0DSTRWs2+
 +wYmky7t3sSHMfuxN22nXf7Sq/veb275yoxr85lSxwbi4Q4u0DK79nISs6EyZCcZuEA6
 tRUMg6UQ8ylApPKIIU9KkiI+h3dpA1FAuVAGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106655; x=1746711455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4J3iDA6iJi5pfqZv97ROh4XFJI1xJ18uAD9GIXMpqRk=;
 b=plNEwimhzbnaA+WPe5Ceg6cSQ6b9xzrOKVRnipgN3LwiylvdGiHIPuvArWEy3xIeXC
 8Oj5LA61S02Hu5KzY1jOny92qoJWu1wThYthBe7tLOGJFq+CC44j/dtHFDD/au5SZDjo
 xO/czuuMA0ouex3QYsXqRm79kGI6aR2jHEvvpYaM9gXV0O8h7xjDwrSs4DAAx8T06mKT
 QDzPxdNgSDo7RZIwC8tZRBBk1exbFLVhdgNH8w0sgyXtmexZJryREsIIMvfWqBQ8zKJk
 SQfwrVx8xGbKUBIP/f8tzMgR/9H48BCkwiByq0Ed6+OwwZB/8CE45dhrp5hMgX9f7Gv2
 wBaw==
X-Gm-Message-State: AOJu0YzNy2fno6BWcvuXfNkSlfW9cqt4/FU4BteRrFFqkcTjAsbBhd0r
 tKViOgO666pH9WPeUo5b+3N1ABvxNPZV+uuNyUMvSX6YakrAzWUplyEnJTh2YmN9tb8aJfkga84
 =
X-Gm-Gg: ASbGncsr6H2MHOd3hHwhyT/T5uVB3ARoK3xnjJJQSrBkQ3YDSleLdAzEzupp6ceJ+s1
 s4fslzHXDFWOyJIWowufV4jqNuDfQM5uvR7Nu+aoMWVzXHsjbVHU/rS4UNqSHcvUZYa8wy1xs5A
 6gaVawMIXjg1wRetQEskYkMsmvZA53sGZY0DV3VJL6oG2mtIr6/khXizsviCKbyPjarYcZaBreh
 DBFNXoK/U1Z3eJ5pa3kh12i2yU+FBXNwDvMb9MAVohNw0XNHbEf9OmW8oP16pxTBM1iV1vEhClZ
 vHhNoCdQnOM1UZDugk/XcnE30gN2+dhASL2xE9NUKwVgpiyjO+zSueBKezO0+hXJlnY9oRBeK0r
 4Ww==
X-Google-Smtp-Source: AGHT+IFCSYNr6MHj2XADDGQ25/4ehZHzMSYCiTNLaYRknvj4tHDY//1jxCdy9H334CzzJ7ZEdfYRjA==
X-Received: by 2002:a05:6602:3586:b0:861:cb60:1e93 with SMTP id
 ca18e2360f4ac-86497f80ef9mr857934439f.6.1746106654839; 
 Thu, 01 May 2025 06:37:34 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/18] fs: boot: Update fs_read_alloc() to use abuf
Date: Thu,  1 May 2025 07:37:02 -0600
Message-ID: <20250501133726.2627373-3-sjg@chromium.org>
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

Changes in v2:
- Update to use abuf_init_size()

 boot/bootmeth-uclass.c | 19 ++++++++++---------
 fs/fs.c                | 24 ++++++++++--------------
 include/fs.h           |  8 +++++---
 3 files changed, 25 insertions(+), 26 deletions(-)

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
index 7def8a9d65d..61161fe5356 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -1128,31 +1128,26 @@ int do_fs_types(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
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
+	if (!abuf_init_size(buf, size + 1))
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
@@ -1161,8 +1156,9 @@ int fs_load_alloc(const char *ifname, const char *dev_part_str,
 		  const char *fname, ulong max_size, ulong align, void **bufp,
 		  ulong *sizep)
 {
+	struct abuf buf;
+	size_t bsize;
 	loff_t size;
-	void *buf;
 	int ret;
 
 	if (fs_set_blk_dev(ifname, dev_part_str, FS_TYPE_ANY))
@@ -1181,8 +1177,8 @@ int fs_load_alloc(const char *ifname, const char *dev_part_str,
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
index 731aaa02637..86db5e04e80 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -7,6 +7,7 @@
 
 #include <rtc.h>
 
+struct abuf;
 struct cmd_tbl;
 
 #define FS_TYPE_ANY	0
@@ -341,11 +342,12 @@ int do_fs_types(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
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

