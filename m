Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F07DD25B54
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 03:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5092183B8F;
	Thu, 29 Jan 2026 04:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uQ7kYEXu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GIPQQNGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED0C83B9D; Thu, 29 Jan 2026 04:55:21 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51F3A83B0B
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 04:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f1lfH0VLQz9tQy;
 Thu, 29 Jan 2026 04:55:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769658919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y2bNUL91yfO1Sd2yeh9oYrjpZQe+QX+W8VLwZnV5DzI=;
 b=uQ7kYEXu436EYUyvuIYfW3VIgAuE3IEpvJ0ETLB0t4B0UTKwunFk233/4bovaVCAIYlnDh
 qp7Ay5KUrwZa5nlXFZUtX7KUY8eoVWhSCLrq7C3YH0RSePN2UCPjB89xcudglu5v2zIb2x
 hlyOG8s/TEym/rZxnjQvjjtFVlNr8Bk2EIziw87dQo63ejk2AftWow2q5IKoUb13EBJSEG
 uN9YLH6B0loRDNkSW/hfLq2NYYkKEVhT+ZRTNlBVRszLbBgT7V/ubl49D0xNtCnNL4d7pr
 /1W2yRjw2JLH+COO3pWA9zgo0UD803uLi6u5MAvSosaPijsWmxvz12yQ2XB3SA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769658917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y2bNUL91yfO1Sd2yeh9oYrjpZQe+QX+W8VLwZnV5DzI=;
 b=GIPQQNGkFFWS02u7UBbGrx8cULzjL/69F97MMNZVJL4+8rWfYk1+wSu5RRDfz4wofw1u8X
 1WcRhdSmSIhzgsqNajTpjM6FSHZdYV9zUyOGJRo0ROyJBR1oG9UbiMnJ/CZ6JsIF0FDYUF
 9p/CO6M2oMYU4FK96WmsIfgeu4olxjNTsAdNxtpciNdl73B9+5SKawtQ1pdqnhTWxaWiAm
 mKsMGAyIEjApZMugfJERhjV3YnijaBJpVh3GP7p3CdTTb/+vonQatvrdY68xtRYKEG6vVJ
 bX/UQflL/nViA2bHcYXSuGvrpgQyuADsMFjEYZ0VNvbrbZnOvV/lqONCCq3Y2Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Aristo Chen <jj251510319013@gmail.com>, Beleswar Padhi <b-padhi@ti.com>,
 Bryan Brattlof <bb@ti.com>, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH] mkimage: fit: align DTs in external data to 8 Bytes by default
Date: Thu, 29 Jan 2026 04:53:29 +0100
Message-ID: <20260129035512.639362-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d072b21350c2d80b15a
X-MBO-RS-META: q1fqyoomkwssb8o4hep39ez159knxcug
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

Unless specified otherwise using the mkimage -B n option, align
DTs in fitImage external data to 8 Bytes, and retain alignment
of everything else to 4 Bytes. This should fulfill the DTspec
requirement, that DTs must be placed at 8 Byte aligned addresses,
even for DTs that are part of fitImage with external data. For
fitImage with embedded data, there is nothing we can do, as the
embedded data are aligned to 4 Bytes, just like any other DT
property.

Replace fdtdec_get_child_count() counting of images with counting
of padding using fdt_for_each_subnode(). This is much more useful,
as the added up padding can be passed directly to calloc() when
allocating the buffer which holds the external data. The image
count is no longer needed.

Adjust the image layouting such, that buf_ptr is incremented to
place the next image at align_size aligned offset. This is done
at the beginning of the loop, once the align_size for current
image can be determined from the current image type.

Update binman test to validate the new 8 Byte alignment.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Aristo Chen <jj251510319013@gmail.com>
Cc: Beleswar Padhi <b-padhi@ti.com>
Cc: Bryan Brattlof <bb@ti.com>
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Cc: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/ftest.py | 20 +++++++--------
 tools/fit_image.c     | 58 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 21ec48d86fd..a53e37f31b3 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4073,7 +4073,7 @@ class TestFunctional(unittest.TestCase):
         external_data_size = len(U_BOOT_DATA) + 2
         expected_size = (len(U_BOOT_DATA) + 0x400 +
                          tools.align(external_data_size, 4) +
-                         len(U_BOOT_NODTB_DATA))
+                         len(U_BOOT_NODTB_DATA) + 8)
 
         # The data should be outside the FIT
         dtb = fdt.Fdt.FromData(fit_data)
@@ -4089,8 +4089,8 @@ class TestFunctional(unittest.TestCase):
 
         self.assertEqual(expected_size, len(data))
         actual_pos = len(U_BOOT_DATA) + fit_pos
-        self.assertEqual(U_BOOT_DATA + b'aa',
-                         data[actual_pos:actual_pos + external_data_size])
+        self.assertEqual(U_BOOT_DATA + b'\x00\x00\x00\x00aa',
+                         data[actual_pos:actual_pos + 4 + external_data_size])
 
     def testFitExternalImagePos(self):
         """Test that we have correct image-pos for external FIT subentries"""
@@ -4103,13 +4103,13 @@ class TestFunctional(unittest.TestCase):
         self.assertEqual({
             'image-pos': 0,
             'offset': 0,
-            'size': 1082,
+            'size': 1090,
 
             'u-boot:image-pos': 0,
             'u-boot:offset': 0,
             'u-boot:size': 4,
 
-            'fit:size': 1032,
+            'fit:size': 1040,
             'fit:offset': 4,
             'fit:image-pos': 4,
 
@@ -4122,15 +4122,15 @@ class TestFunctional(unittest.TestCase):
             'fit/images/kernel/u-boot:image-pos': 1028,
 
             'fit/images/fdt-1:size': 2,
-            'fit/images/fdt-1:offset': 1028,
-            'fit/images/fdt-1:image-pos': 1032,
+            'fit/images/fdt-1:offset': 1032,
+            'fit/images/fdt-1:image-pos': 1036,
 
             'fit/images/fdt-1/_testing:size': 2,
             'fit/images/fdt-1/_testing:offset': 0,
-            'fit/images/fdt-1/_testing:image-pos': 1032,
+            'fit/images/fdt-1/_testing:image-pos': 1036,
 
-            'u-boot-nodtb:image-pos': 1036,
-            'u-boot-nodtb:offset': 1036,
+            'u-boot-nodtb:image-pos': 1044,
+            'u-boot-nodtb:offset': 1044,
             'u-boot-nodtb:size': 46,
          }, props)
 
diff --git a/tools/fit_image.c b/tools/fit_image.c
index e865f65a400..1dbc14c63e4 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -651,10 +651,9 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 	int ret;
 	int images;
 	int node;
-	int image_number;
-	int align_size;
+	int align_size = 0;
+	int len = 0;
 
-	align_size = params->bl_len ? params->bl_len : 4;
 	fd = mmap_fdt(params->cmdname, fname, 0, &fdt, &sbuf, false, false);
 	if (fd < 0)
 		return -EIO;
@@ -666,24 +665,58 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 		ret = -EINVAL;
 		goto err_munmap;
 	}
-	image_number = fdtdec_get_child_count(fdt, images);
+
+	/* Add up all the alignments, we no longer need to count images. */
+	fdt_for_each_subnode(node, fdt, images) {
+		const char *type;
+		int len;
+
+		if (params->bl_len) {
+			align_size += params->bl_len;
+			continue;
+		}
+
+		type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
+		if (type && len == sizeof("flat_dt") && !memcmp(type, "flat_dt", len)) {
+			align_size += 8;
+			continue;
+		}
+
+		/* Default alignment to 4 Bytes */
+		align_size += 4;
+	}
 
 	/*
 	 * Allocate space to hold the image data we will extract,
 	 * extral space allocate for image alignment to prevent overflow.
 	 */
-	buf = calloc(1, fit_size + (align_size * image_number));
+	buf = calloc(1, fit_size + align_size);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto err_munmap;
 	}
 	buf_ptr = 0;
 
-	for (node = fdt_first_subnode(fdt, images);
-	     node >= 0;
-	     node = fdt_next_subnode(fdt, node)) {
-		const char *data;
-		int len;
+	fdt_for_each_subnode(node, fdt, images) {
+		const char *data, *type;
+		int pl;
+
+		if (params->bl_len) {
+			align_size = params->bl_len;
+		} else {
+			type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &pl);
+			if (type && pl == sizeof("flat_dt") && !memcmp(type, "flat_dt", pl))
+				align_size = 8;
+			else	/* Default alignment to 4 Bytes */
+				align_size = 4;
+		}
+
+		/*
+		 * The 'len' is 0 in the first round, so 'buf_ptr' is
+		 * not incremented. Otherwise, 'len' is passed over
+		 * from the previous round.
+		 */
+		buf_ptr += ALIGN(len, align_size);
 
 		data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
 		if (!data)
@@ -716,10 +749,11 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 			ret = -EINVAL;
 			goto err_munmap;
 		}
-
-		buf_ptr += ALIGN(len, align_size);
 	}
 
+	/* Increment 'buf_ptr' for the trailing image. */
+	buf_ptr += ALIGN(len, align_size);
+
 	/* Pack the FDT and place the data after it */
 	fdt_pack(fdt);
 
-- 
2.51.0

