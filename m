Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33959CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6C386FA8;
	Sun, 15 Oct 2023 09:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NMVJAOkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B0886F20; Sun, 15 Oct 2023 09:22:03 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308CD86F33
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6c644a1845cso2376427a34.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697354391; x=1697959191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oFAFcBBbMDjm0PJcXM+2fU2gURGkqhG9B7qnjn0Iwk=;
 b=NMVJAOkR1DIzxn1W25IBqaa+j1b3LwNvo3qZfHseiTViF+pFNSArqYY0L+L4FZ/ajp
 c8zjxWrkpOFH9z3YXfz86h61rWGpksP+P9sU6e2aCz5G/aTsh89hIjnG53dyKJV2o1qe
 o94BIm1A7v1Ny3HiaKwMi3BEGeAVzeuIRLyVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354391; x=1697959191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1oFAFcBBbMDjm0PJcXM+2fU2gURGkqhG9B7qnjn0Iwk=;
 b=EgbwN0950EKFpmlE6Wf9Yc/HMzC1VYo06p0fTnMUO5k4sLWsPRpEMznLx9poNJvlsZ
 /ieI6lnR6bQ+LmpK91gvFubf+26OgUvxEhciI/uuUQ7ndEcLX7Qq1XJzVH1ixU18VV2i
 ud+UzMkjOQIhcminacIvu7ybyT+sMVuUQF2kYpir3qenfWOPO6HkFsO2RHyaHWOHhVyB
 6H2haDLf61RzvNcbhrfLSEOEVfdujveAKR+X9cmYSBcvHbh4Drjq4/qATE7fQ/9Um8/F
 aB8xi+788mdzf/9v6TMeoYWxTDE6C+PaBnL5+sqciYEt078KTDLZFW6ah2NhL03+n6yU
 UrWg==
X-Gm-Message-State: AOJu0YzGytyy6akJ82Jd03B687ZFFg2HgJMGC4sfd5UYNcjw4WLpmA7u
 iEEpWarfxc/DSmfj8Exoc6X8TcWxpLSXRrgIDMMTBg==
X-Google-Smtp-Source: AGHT+IEgxmVlattviF/1Dx/IF+JHK47LGnvTfgIq6AQQ86QS2aAxVs/zuTFLdCUNwFvflyTEfvRbBA==
X-Received: by 2002:a6b:7e05:0:b0:79f:cb49:f476 with SMTP id
 i5-20020a6b7e05000000b0079fcb49f476mr31932304iom.21.1697316042835; 
 Sat, 14 Oct 2023 13:40:42 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a02cb1b000000b0042b14d9be7bsm5424649jap.22.2023.10.14.13.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 13:40:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 6/6] binman: Move stage header into a CBFS attribute
Date: Sat, 14 Oct 2023 14:40:30 -0600
Message-ID: <20231014204033.3077052-7-sjg@chromium.org>
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

cbfsutil completely changed the way that stages are formatted in CBFS.
Adjust the binman implementation to do the same.

This mirrors commit 81dc20e744 in coreboot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/cbfs_util.py      | 64 +++++++++++++++++++++-------------
 tools/binman/cbfs_util_test.py |  7 ++--
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/tools/binman/cbfs_util.py b/tools/binman/cbfs_util.py
index 9ca32f7309ff..671cafa34c0a 100644
--- a/tools/binman/cbfs_util.py
+++ b/tools/binman/cbfs_util.py
@@ -44,10 +44,10 @@ FILE_HEADER_LEN    = 0x18
 FILE_MAGIC         = b'LARCHIVE'
 ATTRIBUTE_ALIGN    = 4   # All attribute sizes must be divisible by this
 
-# A stage header containing information about 'stage' files
+# A stage-header attribute containing information about 'stage' files
 # Yes this is correct: this header is in litte-endian format
-STAGE_FORMAT       = '<IQQII'
-STAGE_LEN          = 0x1c
+ATTR_STAGE_FORMAT       = '>IIQII'
+ATTR_STAGE_LEN          = 0x18
 
 # An attribute describring the compression used in a file
 ATTR_COMPRESSION_FORMAT = '>IIII'
@@ -59,6 +59,7 @@ FILE_ATTR_TAG_HASH          = 0x68736148
 FILE_ATTR_TAG_POSITION      = 0x42435350  # PSCB
 FILE_ATTR_TAG_ALIGNMENT     = 0x42434c41  # ALCB
 FILE_ATTR_TAG_PADDING       = 0x47444150  # PDNG
+FILE_ATTR_TAG_STAGEHEADER   = 0x53746748  # StgH
 
 # This is 'the size of bootblock reserved in firmware image (cbfs.txt)'
 # Not much more info is available, but we set it to 4, due to this comment in
@@ -97,6 +98,7 @@ ARCH_NAMES = {
 # File types. Only supported ones are included here
 TYPE_CBFSHEADER     = 0x02   # Master header, HEADER_FORMAT
 TYPE_LEGACY_STAGE   = 0x10   # Stage, holding an executable
+TYPE_STAGE          = 0x11   # New-type stage with ATTR_STAGE_FORMAT
 TYPE_RAW            = 0x50   # Raw file, possibly compressed
 TYPE_EMPTY          = 0xffffffff     # Empty data
 
@@ -265,7 +267,7 @@ class CbfsFile(object):
         Returns:
             CbfsFile object containing the file information
         """
-        cfile = CbfsFile(name, TYPE_LEGACY_STAGE, data, cbfs_offset)
+        cfile = CbfsFile(name, TYPE_STAGE, data, cbfs_offset)
         cfile.base_address = base_address
         return cfile
 
@@ -326,8 +328,8 @@ class CbfsFile(object):
         """
         name = _pack_string(self.name)
         hdr_len = len(name) + FILE_HEADER_LEN
-        if self.ftype == TYPE_LEGACY_STAGE:
-            pass
+        if self.ftype == TYPE_STAGE:
+            hdr_len += ATTR_STAGE_LEN
         elif self.ftype == TYPE_RAW:
             if self.compress:
                 hdr_len += ATTR_COMPRESSION_LEN
@@ -354,11 +356,11 @@ class CbfsFile(object):
         attr = b''
         pad = b''
         data = self.data
-        if self.ftype == TYPE_LEGACY_STAGE:
+        if self.ftype == TYPE_STAGE:
             elf_data = elf.DecodeElf(data, self.base_address)
-            content = struct.pack(STAGE_FORMAT, self.compress,
-                                  elf_data.entry, elf_data.load,
-                                  len(elf_data.data), elf_data.memsize)
+            attr = struct.pack(ATTR_STAGE_FORMAT, FILE_ATTR_TAG_STAGEHEADER,
+                               ATTR_STAGE_LEN, elf_data.load,
+                               elf_data.entry - elf_data.load, elf_data.memsize)
             data = elf_data.data
         elif self.ftype == TYPE_RAW:
             orig_data = data
@@ -639,7 +641,7 @@ class CbfsReader(object):
         files: Ordered list of CbfsFile objects
         align: Alignment to use for files, typically ENTRT_ALIGN
         stage_base_address: Base address to use when mapping ELF files into the
-            CBFS for TYPE_LEGACY_STAGE files. If this is larger than the code address
+            CBFS for TYPE_STAGE files. If this is larger than the code address
             of the ELF file, then data at the start of the ELF file will not
             appear in the CBFS. Currently there are no tests for behaviour as
             documentation is sparse
@@ -740,26 +742,28 @@ class CbfsReader(object):
             print('name', name)
 
         # If there are attribute headers present, read those
-        compress = self._read_attr(fd, file_pos, attr, offset)
-        if compress is None:
+        attrs = self._read_attr(fd, file_pos, attr, offset)
+        if attrs is None:
             return False
 
         # Create the correct CbfsFile object depending on the type
         cfile = None
         cbfs_offset = file_pos + offset
         fd.seek(cbfs_offset, io.SEEK_SET)
+        if DEBUG:
+            print(f'ftype {ftype:x}')
         if ftype == TYPE_CBFSHEADER:
             self._read_header(fd)
-        elif ftype == TYPE_LEGACY_STAGE:
-            data = fd.read(STAGE_LEN)
+        elif ftype == TYPE_STAGE:
             cfile = CbfsFile.stage(self.stage_base_address, name, b'',
                                    cbfs_offset)
-            (cfile.compress, cfile.entry, cfile.load, cfile.data_len,
-             cfile.memlen) = struct.unpack(STAGE_FORMAT, data)
-            cfile.data = fd.read(cfile.data_len)
+            cfile.load, entry_offset, cfile.memlen = attrs
+            cfile.entry = cfile.load + entry_offset
+            cfile.data = fd.read(cfile.memlen)
+            cfile.data_len = cfile.memlen
         elif ftype == TYPE_RAW:
             data = fd.read(size)
-            cfile = CbfsFile.raw(name, data, cbfs_offset, compress)
+            cfile = CbfsFile.raw(name, data, cbfs_offset, attrs)
             cfile.decompress()
             if DEBUG:
                 print('data', data)
@@ -783,8 +787,8 @@ class CbfsReader(object):
         """Read attributes from the file
 
         CBFS files can have attributes which are things that cannot fit into the
-        header. The only attributes currently supported are compression and the
-        unused tag.
+        header. The only attributes currently supported are compression, stage
+        header and the unused tag
 
         Args:
             fd: File to read from
@@ -794,11 +798,16 @@ class CbfsReader(object):
                                          attributes)
 
         Returns:
-            Compression to use for the file (COMPRESS_...)
+            Either:
+                Compression to use for the file (COMPRESS_...)
+                tuple containing stage info:
+                    load address
+                    entry offset
+                    memory size
         """
-        compress = COMPRESS_NONE
+        attrs = None
         if not attr:
-            return compress
+            return COMPRESS_NONE
         attr_size = offset - attr
         fd.seek(file_pos + attr, io.SEEK_SET)
         while attr_size:
@@ -813,10 +822,15 @@ class CbfsReader(object):
                 # We don't currently use this information
                 atag, alen, compress, _decomp_size = struct.unpack(
                     ATTR_COMPRESSION_FORMAT, data)
+                attrs = compress
+            elif atag == FILE_ATTR_TAG_STAGEHEADER:
+                atag, alen, load, entry_offset, memsize = struct.unpack(
+                    ATTR_STAGE_FORMAT, data)
+                attrs = (load, entry_offset, memsize)
             else:
                 print('Unknown attribute tag %x' % atag)
             attr_size -= len(data)
-        return compress
+        return attrs
 
     def _read_header(self, fd):
         """Read the master header
diff --git a/tools/binman/cbfs_util_test.py b/tools/binman/cbfs_util_test.py
index 2775d05b8120..4c415b7ce948 100755
--- a/tools/binman/cbfs_util_test.py
+++ b/tools/binman/cbfs_util_test.py
@@ -391,7 +391,7 @@ class TestCbfs(unittest.TestCase):
             cbfs_util.DEBUG = True
             with test_util.capture_sys_output() as (stdout, _stderr):
                 cbfs_util.CbfsReader(data)
-            self.assertEqual('name u-boot\ndata %s\n' % U_BOOT_DATA,
+            self.assertEqual('name u-boot\nftype 50\ndata %s\n' % U_BOOT_DATA,
                              stdout.getvalue())
         finally:
             cbfs_util.DEBUG = False
@@ -475,7 +475,7 @@ class TestCbfs(unittest.TestCase):
         self._compare_expected_cbfs(data, cbfs_fname)
 
     def test_cbfs_stage(self):
-        """Tests handling of a Coreboot Filesystem (CBFS)"""
+        """Tests handling of a CBFS stage"""
         if not elf.ELF_TOOLS:
             self.skipTest('Python elftools not available')
         elf_fname = os.path.join(self._indir, 'cbfs-stage.elf')
@@ -490,8 +490,7 @@ class TestCbfs(unittest.TestCase):
         load = 0xfef20000
         entry = load + 2
 
-        cfile = self._check_uboot(cbfs, cbfs_util.TYPE_LEGACY_STAGE,
-                                  offset=0x20,
+        cfile = self._check_uboot(cbfs, cbfs_util.TYPE_STAGE, offset=0x38,
                                   data=U_BOOT_DATA + U_BOOT_DTB_DATA)
 
         self.assertEqual(entry, cfile.entry)
-- 
2.42.0.655.g421f12c284-goog

