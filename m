Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6166D46BF8
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 19:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B53A83DFF;
	Wed, 28 Jan 2026 20:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="skrGnB3e";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mpqSVfc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED88783DFF; Wed, 28 Jan 2026 20:41:03 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D7B83C2B
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 20:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f1Xgr40K8z9t6L;
 Wed, 28 Jan 2026 20:40:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769629256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UWHEqY5AGzyYb2a6UMHn1roh2GFuvnZ0nyRucQVb0DY=;
 b=skrGnB3emsaHFHDAOVh+GiCJStcBI+vE31WAyfuTlFI2w03EpkmN++MzTtQbdfOEFy/o2E
 6802iogNGKUxMJsV5SFrmLpQJR+xY/kbruU7vkZ34XJ4eVjZMh92xoW8xYuiBJbUVR24sR
 yb34pG1AYAV2xJPeoNM7fFC83Wl3y6oAB3bSPFS32u6Pld9XxamlncUfrD4QcTzD8QNDPW
 v6FdwV4t4wtdL5hbuYter47+h1rByD3TpUwYJSfB0cByIbwYZ0OPsDz0nLvMPS1Xfl//mP
 k/Vfs1JLMJamG19tmz0Kb4g2+NsN0xD3D0l02wScruuC8tctY+ilJiyxt4mSFQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769629254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UWHEqY5AGzyYb2a6UMHn1roh2GFuvnZ0nyRucQVb0DY=;
 b=mpqSVfc7p27APbC/WwWOkmWrfwTvW0mabwY6XCKEv2LxYgN7AfCOe3zy+sbTX7OhsYFCV0
 9sz/y+0Rom0k+YUrqln/2gBu9V/j85nmNVaZeN+xfz1GZ4OfkebZ+sl5AmTL2FxAYcWXm2
 OOfVm+C9jjD/ajOKdXKgCo8KRK0Ay65ZVDTUQ0CxxzWshPrfX2Pp26esixlj3Ygy13X0dX
 N0aQei4SHP88vUO+XJkKM5a0tU46FuhkwLtrMC2wKQAWfEy/P5VdRe4D5QHgp2h0cPxD17
 7/tNd+Be5hVY9/uzmoNJtEplJDz/hU5cTReo0p84pZnE4ZqSHX6APQeWaHw/4w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] gunzip: Fix len parameter in function signature
Date: Wed, 28 Jan 2026 20:40:40 +0100
Message-ID: <20260128194049.278542-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e3fc22727b377b41e2d
X-MBO-RS-META: 6czswgbw44qqdcqdnqo5gcqoe9ewopr6
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

The only call site of gzwrite() is cmd/unzip.c do_gzwrite(), where
the 'len' parameter passed to gzwrite(..., len, ...) function is of
type unsigned long. This usage is correct, the 'len' parameter is
an unsigned integer, and the gzwrite() function currently supports
input data 'len' of up to 4 GiB - 1 .

The function signature of gzwrite() function in both include/gzip.h
and lib/gunzip.c does however list 'len' as signed integer, which
is not correct, and ultimatelly limits the implementation to only
2 GiB input data 'len' .

Fix this, update gzwrite() function parameter 'len' data type to
size_t consistently in include/gzip.h and lib/gunzip.c .

Furthermore, update gzwrite() function 'szwritebuf' parameter in
lib/gunzip.c from 'unsigned long' to 'size_t' to be synchronized
with include/gzip.h . Rewrite the other parameters to size_t and
off_t and propagate the change too.

Since the gzwrite() function currently surely only supports input
data size of 4 GiB - 1, add input data size check. The limitation
comes from the current use of zlib z_stream .avail_in parameter,
to which the gzwrite() function sets the entire input data size,
and which is of unsigned int type, which cannot accept any number
beyond 4 GiB - 1. This limitation will be removed in future commit.

Reported-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.denx.de
---
V2: - Rewrite function parameters to size_t and off_t and propagate
      the changes into internal calls too
    - Use log_err()
---
 cmd/unzip.c    |  4 ++--
 include/gzip.h | 10 +++++-----
 lib/gunzip.c   | 32 +++++++++++++++++---------------
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/cmd/unzip.c b/cmd/unzip.c
index e7a3f9808b2..da958f12803 100644
--- a/cmd/unzip.c
+++ b/cmd/unzip.c
@@ -53,8 +53,8 @@ static int do_gzwrite(struct cmd_tbl *cmdtp, int flag,
 	unsigned char *addr;
 	unsigned long length;
 	unsigned long writebuf = 1<<20;
-	u64 startoffs = 0;
-	u64 szexpected = 0;
+	off_t startoffs = 0;
+	size_t szexpected = 0;
 
 	if (argc < 5)
 		return CMD_RET_USAGE;
diff --git a/include/gzip.h b/include/gzip.h
index 304002ffc42..fe8e21dc2a9 100644
--- a/include/gzip.h
+++ b/include/gzip.h
@@ -58,11 +58,11 @@ int zunzip(void *dst, int dstlen, unsigned char *src, unsigned long *lenp,
  *	gzwrite_progress_finish called at end of loop to
  *		indicate success (retcode=0) or failure
  */
-void gzwrite_progress_init(ulong expected_size);
+void gzwrite_progress_init(size_t expected_size);
 
-void gzwrite_progress(int iteration, ulong bytes_written, ulong total_bytes);
+void gzwrite_progress(int iteration, ulong bytes_written, size_t total_bytes);
 
-void gzwrite_progress_finish(int retcode, ulong totalwritten, ulong totalsize,
+void gzwrite_progress_finish(int retcode, ulong totalwritten, size_t totalsize,
 			     u32 expected_crc, u32 calculated_crc);
 
 /**
@@ -77,8 +77,8 @@ void gzwrite_progress_finish(int retcode, ulong totalwritten, ulong totalsize,
  *		for files under 4GiB
  * Return: 0 if OK, -1 on error
  */
-int gzwrite(unsigned char *src, int len, struct blk_desc *dev, ulong szwritebuf,
-	    ulong startoffs, ulong szexpected);
+int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
+	    size_t szwritebuf, off_t startoffs, size_t szexpected);
 
 /**
  * gzip()- Compress data into a buffer using the gzip algorithm
diff --git a/lib/gunzip.c b/lib/gunzip.c
index a05dcde9a75..76f3397fced 100644
--- a/lib/gunzip.c
+++ b/lib/gunzip.c
@@ -84,7 +84,7 @@ __rcode int gunzip(void *dst, int dstlen, unsigned char *src, unsigned long *len
 
 #ifdef CONFIG_CMD_UNZIP
 __weak
-void gzwrite_progress_init(ulong expectedsize)
+void gzwrite_progress_init(size_t expectedsize)
 {
 	putc('\n');
 }
@@ -92,35 +92,32 @@ void gzwrite_progress_init(ulong expectedsize)
 __weak
 void gzwrite_progress(int iteration,
 		     ulong bytes_written,
-		     ulong total_bytes)
+		     size_t total_bytes)
 {
 	if (0 == (iteration & 3))
-		printf("%lu/%lu\r", bytes_written, total_bytes);
+		printf("%lu/%zu\r", bytes_written, total_bytes);
 }
 
 __weak
 void gzwrite_progress_finish(int returnval,
 			     ulong bytes_written,
-			     ulong total_bytes,
+			     size_t total_bytes,
 			     u32 expected_crc,
 			     u32 calculated_crc)
 {
 	if (0 == returnval) {
-		printf("\n\t%lu bytes, crc 0x%08x\n",
+		printf("\n\t%zu bytes, crc 0x%08x\n",
 		       total_bytes, calculated_crc);
 	} else {
-		printf("\n\tuncompressed %lu of %lu\n"
+		printf("\n\tuncompressed %lu of %zu\n"
 		       "\tcrcs == 0x%08x/0x%08x\n",
 		       bytes_written, total_bytes,
 		       expected_crc, calculated_crc);
 	}
 }
 
-int gzwrite(unsigned char *src, int len,
-	    struct blk_desc *dev,
-	    unsigned long szwritebuf,
-	    ulong startoffs,
-	    ulong szexpected)
+int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
+	    size_t szwritebuf, off_t startoffs, size_t szexpected)
 {
 	int i, flags;
 	z_stream s;
@@ -130,13 +127,18 @@ int gzwrite(unsigned char *src, int len,
 	ulong totalfilled = 0;
 	lbaint_t blksperbuf, outblock;
 	u32 expected_crc;
-	u32 payload_size;
+	size_t payload_size;
 	int iteration = 0;
 
+	if (len > 0xffffffff) {
+		log_err("Input size over 4 GiB in size not supported\n");
+		return -1;
+	}
+
 	if (!szwritebuf ||
 	    (szwritebuf % dev->blksz) ||
 	    (szwritebuf < dev->blksz)) {
-		printf("%s: size %lu not a multiple of %lu\n",
+		printf("%s: size %zu not a multiple of %lu\n",
 		       __func__, szwritebuf, dev->blksz);
 		return -1;
 	}
@@ -182,12 +184,12 @@ int gzwrite(unsigned char *src, int len,
 	if (szexpected == 0) {
 		szexpected = le32_to_cpu(szuncompressed);
 	} else if (szuncompressed != (u32)szexpected) {
-		printf("size of %lx doesn't match trailer low bits %x\n",
+		printf("size of %zx doesn't match trailer low bits %x\n",
 		       szexpected, szuncompressed);
 		return -1;
 	}
 	if (lldiv(szexpected, dev->blksz) > (dev->lba - outblock)) {
-		printf("%s: uncompressed size %lu exceeds device size\n",
+		printf("%s: uncompressed size %zu exceeds device size\n",
 		       __func__, szexpected);
 		return -1;
 	}
-- 
2.51.0

