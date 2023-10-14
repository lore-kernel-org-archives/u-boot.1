Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A925CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C698C86867;
	Sun, 15 Oct 2023 08:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FJwqHsVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8407869C8; Sun, 15 Oct 2023 08:10:22 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4413F86538
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-35749078a59so13852595ab.3
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697350090; x=1697954890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ad3djbM3/XwnAajI5FtppVgBUAF6ntTIr4iFMjyTz+I=;
 b=FJwqHsVkr/F45rjugaTaxKP8Dn1eMjbI1+4V4to4Jq8Ma8Be3QSJFMxV0EXz1w5QiT
 /kkl+B9PSUb3xBOO8m9K44D/lrd+1nlZHet8TwN275GT915e+996pS4WLxqufRhYSvV4
 C7DAPYxZM+7TXvYgrvOtRM0n8ubg/bVcF5X2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697350090; x=1697954890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ad3djbM3/XwnAajI5FtppVgBUAF6ntTIr4iFMjyTz+I=;
 b=BbsgBopbwiBbMEOr7sgYeige6o9+sIjBPoti7S31qZK049pW7uIX8MRguacnm6x1eH
 GWm0L2FliOIhBZW+nLwKiR4p5JvS4sqWSjUk6iF7my6ZxZrHMTaqxf5Uf2oZtfKbL7pl
 ZtA+KKs/hMrgbOFL/h0gJ6oAjTMY+S0bZvGUjXVQM/EBUYkqvEMa2vlfSY5/m3mBYvE4
 TTXXtQBXQuBrrixjf+YKLGEfpCqmSEVC+iYszXhyUZD/awigGrNgxzZNG2S2fu2RcstB
 7UdoU39c6OxQkU/nBp+WOG6hQVfE/RxWR+FgmjjlgRApogfeRg7eX3gdxzhuyzJXaRs0
 8yJQ==
X-Gm-Message-State: AOJu0Yxinv6JeE7Rzf/IYt4qbkZN4MuswmSYHg31qz1MDN1VNZPU+bIP
 km1zqRNDp3KBubQRw4HhWtr0KMXix2tqAsfWpWBw1A==
X-Google-Smtp-Source: AGHT+IGPuAVYxGT92Z0ouSPXA29rcGIDKswi7hM0UOqil+ZzkgbgdbQbniUnwDFhXSM/7YXFU76N9Q==
X-Received: by 2002:a5e:a61a:0:b0:799:178c:7be5 with SMTP id
 q26-20020a5ea61a000000b00799178c7be5mr36651046ioi.17.1697316041306; 
 Sat, 14 Oct 2023 13:40:41 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a02cb1b000000b0042b14d9be7bsm5424649jap.22.2023.10.14.13.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 13:40:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 4/6] binman: Replace FILENAME_ALIGN 16 with ATTRIBUTE_ALIGN 4
Date: Sat, 14 Oct 2023 14:40:28 -0600
Message-ID: <20231014204033.3077052-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231014204033.3077052-1-sjg@chromium.org>
References: <20231014204033.3077052-1-sjg@chromium.org>
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

cbfsutil changed to 4-byte alignment for filenames instead of 16.
Adjust the binman implementation to do the same.

This mirrors commit 5779ca718c in coreboot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/cbfs_util.py      | 10 +++++-----
 tools/binman/cbfs_util_test.py | 19 ++++++++++---------
 tools/binman/ftest.py          | 10 +++++-----
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/tools/binman/cbfs_util.py b/tools/binman/cbfs_util.py
index 9ac38d8e4c1a..076768ae839b 100644
--- a/tools/binman/cbfs_util.py
+++ b/tools/binman/cbfs_util.py
@@ -42,7 +42,7 @@ HEADER_VERSION2    = 0x31313132
 FILE_HEADER_FORMAT = b'>8sIIII'
 FILE_HEADER_LEN    = 0x18
 FILE_MAGIC         = b'LARCHIVE'
-FILENAME_ALIGN     = 16  # Filename lengths are aligned to this
+ATTRIBUTE_ALIGN    = 4   # All attribute sizes must be divisible by this
 
 # A stage header containing information about 'stage' files
 # Yes this is correct: this header is in litte-endian format
@@ -186,7 +186,7 @@ def _pack_string(instr):
         String with required padding (at least one 0x00 byte) at the end
     """
     val = tools.to_bytes(instr)
-    pad_len = align_int(len(val) + 1, FILENAME_ALIGN)
+    pad_len = align_int(len(val) + 1, ATTRIBUTE_ALIGN)
     return val + tools.get_bytes(0, pad_len - len(val))
 
 
@@ -300,7 +300,7 @@ class CbfsFile(object):
             CbfsFile object containing the file information
         """
         cfile = CbfsFile('', TYPE_EMPTY, b'', None)
-        cfile.size = space_to_use - FILE_HEADER_LEN - FILENAME_ALIGN
+        cfile.size = space_to_use - FILE_HEADER_LEN - ATTRIBUTE_ALIGN
         cfile.erase_byte = erase_byte
         return cfile
 
@@ -859,8 +859,8 @@ class CbfsReader(object):
         """
         val = b''
         while True:
-            data = fd.read(FILENAME_ALIGN)
-            if len(data) < FILENAME_ALIGN:
+            data = fd.read(ATTRIBUTE_ALIGN)
+            if len(data) < ATTRIBUTE_ALIGN:
                 return None
             pos = data.find(b'\0')
             if pos == -1:
diff --git a/tools/binman/cbfs_util_test.py b/tools/binman/cbfs_util_test.py
index c3babbc64e78..64592525ec7d 100755
--- a/tools/binman/cbfs_util_test.py
+++ b/tools/binman/cbfs_util_test.py
@@ -96,7 +96,7 @@ class TestCbfs(unittest.TestCase):
         self.assertEqual(arch, cbfs.arch)
         return cbfs
 
-    def _check_uboot(self, cbfs, ftype=cbfs_util.TYPE_RAW, offset=0x28,
+    def _check_uboot(self, cbfs, ftype=cbfs_util.TYPE_RAW, offset=0x20,
                      data=U_BOOT_DATA, cbfs_offset=None):
         """Check that the U-Boot file is as expected
 
@@ -122,7 +122,7 @@ class TestCbfs(unittest.TestCase):
         self.assertEqual(len(data), cfile.memlen)
         return cfile
 
-    def _check_dtb(self, cbfs, offset=0x28, data=U_BOOT_DTB_DATA,
+    def _check_dtb(self, cbfs, offset=0x24, data=U_BOOT_DTB_DATA,
                    cbfs_offset=None):
         """Check that the U-Boot dtb file is as expected
 
@@ -437,8 +437,9 @@ class TestCbfs(unittest.TestCase):
             pos = fd.tell()
 
         # Create a new CBFS with only the first 4 bytes of the compression tag,
-        # then try to read the file
-        tag_pos = pos + cbfs_util.FILE_HEADER_LEN + cbfs_util.FILENAME_ALIGN
+        # then try to read the file. Note that the tag gets pushed out 4 bytes
+        tag_pos = (4 + pos + cbfs_util.FILE_HEADER_LEN +
+                   cbfs_util.ATTRIBUTE_ALIGN)
         newdata = data[:tag_pos + 4]
         with test_util.capture_sys_output() as (stdout, _stderr):
             with io.BytesIO(newdata) as fd:
@@ -489,7 +490,7 @@ class TestCbfs(unittest.TestCase):
         load = 0xfef20000
         entry = load + 2
 
-        cfile = self._check_uboot(cbfs, cbfs_util.TYPE_STAGE, offset=0x28,
+        cfile = self._check_uboot(cbfs, cbfs_util.TYPE_STAGE, offset=0x20,
                                   data=U_BOOT_DATA + U_BOOT_DTB_DATA)
 
         self.assertEqual(entry, cfile.entry)
@@ -520,7 +521,7 @@ class TestCbfs(unittest.TestCase):
         self.assertIn('u-boot', cbfs.files)
         cfile = cbfs.files['u-boot']
         self.assertEqual(cfile.name, 'u-boot')
-        self.assertEqual(cfile.offset, 56)
+        self.assertEqual(cfile.offset, 0x30)
         self.assertEqual(cfile.data, COMPRESS_DATA)
         self.assertEqual(cfile.ftype, cbfs_util.TYPE_RAW)
         self.assertEqual(cfile.compress, cbfs_util.COMPRESS_LZ4)
@@ -529,7 +530,7 @@ class TestCbfs(unittest.TestCase):
         self.assertIn('u-boot-dtb', cbfs.files)
         cfile = cbfs.files['u-boot-dtb']
         self.assertEqual(cfile.name, 'u-boot-dtb')
-        self.assertEqual(cfile.offset, 56)
+        self.assertEqual(cfile.offset, 0x34)
         self.assertEqual(cfile.data, COMPRESS_DATA)
         self.assertEqual(cfile.ftype, cbfs_util.TYPE_RAW)
         self.assertEqual(cfile.compress, cbfs_util.COMPRESS_LZMA)
@@ -598,8 +599,8 @@ class TestCbfs(unittest.TestCase):
         data = cbw.get_data()
 
         cbfs = cbfs_util.CbfsReader(data)
-        self.assertEqual(0x28, cbfs.files['u-boot'].cbfs_offset)
-        self.assertEqual(0x68, cbfs.files['u-boot-dtb'].cbfs_offset)
+        self.assertEqual(0x20, cbfs.files['u-boot'].cbfs_offset)
+        self.assertEqual(0x64, cbfs.files['u-boot-dtb'].cbfs_offset)
 
 
 if __name__ == '__main__':
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 2875194d750e..5ace2a825dc5 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2667,12 +2667,12 @@ class TestFunctional(unittest.TestCase):
             'cbfs:offset': 0,
             'cbfs:size': len(data),
             'cbfs:image-pos': 0,
-            'cbfs/u-boot:offset': 0x38,
+            'cbfs/u-boot:offset': 0x30,
             'cbfs/u-boot:uncomp-size': len(U_BOOT_DATA),
-            'cbfs/u-boot:image-pos': 0x38,
-            'cbfs/u-boot-dtb:offset': 0xa8,
+            'cbfs/u-boot:image-pos': 0x30,
+            'cbfs/u-boot-dtb:offset': 0xa4,
             'cbfs/u-boot-dtb:size': len(U_BOOT_DATA),
-            'cbfs/u-boot-dtb:image-pos': 0xa8,
+            'cbfs/u-boot-dtb:image-pos': 0xa4,
             }, props)
 
     def testCbfsBadType(self):
@@ -2854,7 +2854,7 @@ class TestFunctional(unittest.TestCase):
 '  u-boot                  0     4  u-boot             0',
 '  section               100   %x  section          100' % section_size,
 '    cbfs                100   400  cbfs               0',
-'      u-boot            128     4  u-boot            28',
+'      u-boot            120     4  u-boot            20',
 '      u-boot-dtb        180   105  u-boot-dtb        80          3c9',
 '    u-boot-dtb          500   %x  u-boot-dtb       400          3c9' % fdt_size,
 '  fdtmap                %x   3bd  fdtmap           %x' %
-- 
2.42.0.655.g421f12c284-goog

