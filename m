Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25FAE9A04D
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 00:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1587083A47;
	Thu, 19 Feb 2026 01:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GSsnQR7g";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PVFgIntS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D3D883AC5; Thu, 19 Feb 2026 01:34:08 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80A2B83936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 01:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fGZBH5Xgkz9tft;
 Thu, 19 Feb 2026 01:33:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771461239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=buFm9mRkrU5LmHCpTh0bQLQK7YjMGp7vaMZZ2SeuNwk=;
 b=GSsnQR7goBtB2SLPj56xK2ySyDz5VdTcr+vCIMhf316UfjcbSySdJgInPcnajjUf9VknMm
 1h/zN2I0tnCCnXiVhr8FycdcnA/5c2ZxtegWwD0gphb24QnSYoUCY8pSGhzuA7xzLWSbKb
 kJ83z/1lE3ZsHaH+tXfZPmjYGVbrOEW/C+T/V2sjPAtGkieBKy+BD2/ftx+8pB5nRWk1mu
 EzAXTXWHffPWtUIejZodSJhJ9ZJAI3iveEpSuNCO/6Kex8ip9rBmCq1dbObtAldNEAJmSU
 98wijWLek9HwJEe1cnu7j9nJ3sjZ+BaF6d3BVSP5Km4QPDg9x/688clbqGDomA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771461237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=buFm9mRkrU5LmHCpTh0bQLQK7YjMGp7vaMZZ2SeuNwk=;
 b=PVFgIntSmR/NwuNUhe54PImpakagXjX614PFiO0s/RerRKxZCaiiyDLE2e1J/gr5sKpnKN
 ZiVlvOqBR3NH9wsXbiGD5VDyG+uiCveQ5hkzRrBZ4EHBlZ58eh/lR/01NKBezaO5yzx17z
 ujbAoWJ6M2qPQZqQfSn/8o2bGkXNwCExwUImziefVK5rz4yKdaxvI8DoSGipDoX/wFP7fE
 +LZGauy1iClQhuGzsFmFlFne7zJY65fMsreQWkUuxHpe5QsV+7Wz54xNU3BcmSyPWEJU6S
 AX4u2nxoFQu3hP189mugX3IMzj+Of2r5YS6bnmYzDdggLoSUDA8lqLn/+VFu9w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH v2] gunzip: Implement chunked decompression
Date: Thu, 19 Feb 2026 01:33:25 +0100
Message-ID: <20260219003351.388722-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yuco9mqcgd1cy6mgyb9fm6h3pq5fb7zp
X-MBO-RS-ID: ac623c1eb7f33271960
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

The current gzwrite() implementation is limited to 4 GiB compressed
input buffer size due to struct z_stream_s { uInt avail_in } member,
which is of type unsigned int. Current gzwrite() implementation sets
the entire input buffer size as avail_in and performs decompression
of the whole compressed input buffer in one round, which limits the
size of input buffer to 4 GiB.

Rework the decompression loop to use chunked approach, and decompress
the input buffer in up to 4 GiB - 1 kiB avail_in chunks, possibly in
multiple decompression rounds. This way, the compressed input buffer
size is limited by gzwrite() function 'len' parameter type, which is
unsigned long.

In case of sandbox build, include parsing of 'gzwrite_chunk'
environment variable, so the chunked approach can be thoroughly tested
with non default chunk size. For non-sandbox builds, the chunk size is
4 GiB - 1 kiB.

The gzwrite test case is extended to test various chunk sizes during
gzwrite decompression test.

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
V2: Rebase on master
---
 lib/gunzip.c     | 76 +++++++++++++++++++++++++++++++++---------------
 test/cmd/unzip.c | 12 +++++++-
 2 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/lib/gunzip.c b/lib/gunzip.c
index 76f3397fced..20cc14f9688 100644
--- a/lib/gunzip.c
+++ b/lib/gunzip.c
@@ -8,8 +8,10 @@
 #include <command.h>
 #include <console.h>
 #include <div64.h>
+#include <env.h>
 #include <gzip.h>
 #include <image.h>
+#include <linux/sizes.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <u-boot/crc.h>
@@ -119,7 +121,7 @@ void gzwrite_progress_finish(int returnval,
 int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
 	    size_t szwritebuf, off_t startoffs, size_t szexpected)
 {
-	int i, flags;
+	int flags;
 	z_stream s;
 	int r = 0;
 	unsigned char *writebuf;
@@ -127,13 +129,23 @@ int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
 	ulong totalfilled = 0;
 	lbaint_t blksperbuf, outblock;
 	u32 expected_crc;
-	size_t payload_size;
+	size_t i, payload_size;
+	unsigned long blocks_written;
+	lbaint_t writeblocks;
+	int numfilled = 0;
 	int iteration = 0;
-
-	if (len > 0xffffffff) {
-		log_err("Input size over 4 GiB in size not supported\n");
-		return -1;
-	}
+	/*
+	 * Allow runtime configuration of decompression chunk on
+	 * sandbox to better cover the chunked decompression
+	 * functionality without having to use > 4 GiB files.
+	 */
+	const ulong minchunk = 0x400;
+	const ulong maxchunk = SZ_4G - minchunk;
+	const ulong chunk =
+		CONFIG_IS_ENABLED(SANDBOX,
+				  (clamp(env_get_ulong("gzwrite_chunk", 10, maxchunk),
+					 minchunk, maxchunk)),
+				  (maxchunk));
 
 	if (!szwritebuf ||
 	    (szwritebuf % dev->blksz) ||
@@ -175,7 +187,7 @@ int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
 		return -1;
 	}
 
-	payload_size = len - i - 8;
+	payload_size = len - i;
 
 	memcpy(&expected_crc, src + len - 8, sizeof(expected_crc));
 	expected_crc = le32_to_cpu(expected_crc);
@@ -205,35 +217,44 @@ int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
 		return -1;
 	}
 
-	s.next_in = src + i;
-	s.avail_in = payload_size+8;
+	src += i;
+	s.avail_in = 0;
 	writebuf = (unsigned char *)malloc_cache_aligned(szwritebuf);
 
 	/* decompress until deflate stream ends or end of file */
 	do {
 		if (s.avail_in == 0) {
-			printf("%s: weird termination with result %d\n",
-			       __func__, r);
-			break;
+			if (payload_size == 0) {
+				printf("%s: weird termination with result %d\n",
+				       __func__, r);
+				break;
+			}
+
+			s.next_in = src;
+			s.avail_in = (payload_size > chunk) ? chunk : payload_size;
+			src += s.avail_in;
+			payload_size -= s.avail_in;
 		}
 
 		/* run inflate() on input until output buffer not full */
 		do {
-			unsigned long blocks_written;
-			int numfilled;
-			lbaint_t writeblocks;
-
-			s.avail_out = szwritebuf;
-			s.next_out = writebuf;
+			if (numfilled) {
+				s.avail_out = szwritebuf - numfilled;
+				s.next_out = writebuf + numfilled;
+			} else {
+				s.avail_out = szwritebuf;
+				s.next_out = writebuf;
+			}
 			r = inflate(&s, Z_SYNC_FLUSH);
 			if ((r != Z_OK) &&
 			    (r != Z_STREAM_END)) {
 				printf("Error: inflate() returned %d\n", r);
 				goto out;
 			}
+			crc = crc32(crc, writebuf + numfilled,
+				    szwritebuf - s.avail_out - numfilled);
+			totalfilled += szwritebuf - s.avail_out - numfilled;
 			numfilled = szwritebuf - s.avail_out;
-			crc = crc32(crc, writebuf, numfilled);
-			totalfilled += numfilled;
 			if (numfilled < szwritebuf) {
 				writeblocks = (numfilled+dev->blksz-1)
 						/ dev->blksz;
@@ -241,14 +262,17 @@ int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
 				       dev->blksz-(numfilled%dev->blksz));
 			} else {
 				writeblocks = blksperbuf;
+				numfilled = 0;
 			}
 
 			gzwrite_progress(iteration++,
 					 totalfilled,
 					 szexpected);
-			blocks_written = blk_dwrite(dev, outblock,
+			if (!numfilled) {
+				blocks_written = blk_dwrite(dev, outblock,
 						    writeblocks, writebuf);
-			outblock += blocks_written;
+				outblock += blocks_written;
+			}
 			if (ctrlc()) {
 				puts("abort\n");
 				goto out;
@@ -258,6 +282,12 @@ int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
 		/* done when inflate() says it's done */
 	} while (r != Z_STREAM_END);
 
+	if (numfilled) {
+		blocks_written = blk_dwrite(dev, outblock,
+				    writeblocks, writebuf);
+		outblock += blocks_written;
+	}
+
 	if ((szexpected != totalfilled) ||
 	    (crc != expected_crc))
 		r = -1;
diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
index b67c5ba1956..623a2785884 100644
--- a/test/cmd/unzip.c
+++ b/test/cmd/unzip.c
@@ -105,7 +105,7 @@ static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
 {
 	struct udevice *dev;
 	ofnode root, node;
-	int i, ret;
+	int i, j, ret;
 
 	/* Enable the mmc9 node for this test */
 	root = oftree_root(oftree_default());
@@ -119,6 +119,16 @@ static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
 			return ret;
 	}
 
+	/* Test various sizes of decompression chunk sizes */
+	for (j = 0; j < ARRAY_SIZE(sizes); j++) {
+		env_set_ulong("gzwrite_chunk", sizes[j]);
+		for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+			ret = do_test_cmd_zip_unzip(uts, sizes[i], true);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 DM_TEST(dm_test_cmd_zip_gzwrite, UTF_CONSOLE);
-- 
2.51.0

