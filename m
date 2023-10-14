Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E45ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 349F886DBC;
	Sun, 15 Oct 2023 09:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a0Uyptys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0153A86F26; Sun, 15 Oct 2023 09:53:11 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C80786CF9
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6c61d955161so2125237a34.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697356311; x=1697961111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jngyHvJQKwExGSivrPudc+6sqw+qaZkTQrA61917H6w=;
 b=a0UyptysFNVVBH4a2nDAcnWxLqHiby3lDkxmNafmgr1lh5NAn1H74bxem1RSHTexri
 74SQSM4BxZYbqRfs/mr/3RrrYIkt4rSxRjNeHcGVE+GpBwlxr9CNtP4csm1wB1tZ96dG
 JfHSqnVgHFvRI4Kg+xmgYEyvqdPEi25XzpTy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697356311; x=1697961111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jngyHvJQKwExGSivrPudc+6sqw+qaZkTQrA61917H6w=;
 b=YXEGB5Ke3bsggOP0+fWLbgV2RqISoagREVuwD2NIe+uOi5iNyHxs7qhmpPHyT5mdXd
 cQ5su3H9S4qySzHPxSC0fVzuyhAG7RMGfJeFu9UKkqm9FQ0M/5IUpPvY9HPacsj3CeV7
 I4rPf6KBqFQnvPTe2IQRqNNSPaTmhedjWLtuFZDAIwZ4RqQZ2Pyug4oIZkDVs3cXQ0di
 be0PPQc+4uX0NDQIbRykWRFEQEIU9vVUua0E59H3oj+ssaoyxOjMH7WtOQpl4V/OpkfE
 iqAOBFzko6uYJinOQJfC/2IxczmnHkTAUPSa35f/4u0APU9LpVhADNpM8yKtqxA+91cG
 GwFQ==
X-Gm-Message-State: AOJu0YxMXdYMbEHYeedj/MaGjMOjxuE4EMquQpxEINXGJDEsbNugRlNB
 2tSJydlQoLMCYkebdOr/VB4CjoAwya6fiPd3kKjiqQ==
X-Google-Smtp-Source: AGHT+IH+/y9MFX7UVMvxXmnFrhmQUj9FHPeY8HJLBSPfoDZfmJX3hlRpbppdEqoMnQ6G74R56/qfFg==
X-Received: by 2002:a05:6602:2a46:b0:7a2:dee5:84b6 with SMTP id
 k6-20020a0566022a4600b007a2dee584b6mr34633899iov.21.1697316040505; 
 Sat, 14 Oct 2023 13:40:40 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a02cb1b000000b0042b14d9be7bsm5424649jap.22.2023.10.14.13.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 13:40:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 3/6] binman: Ensure attributes always come last in the metadata
Date: Sat, 14 Oct 2023 14:40:27 -0600
Message-ID: <20231014204033.3077052-4-sjg@chromium.org>
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

cbfsutil changed to write zero bytes instead of 0xff when a small
padding must be added. Adjust the binman implementation to do the same.

Drop the code which looks for an unused attribute tag, since it is not
used. A future patch moves the attributes to the end of the header in
any case, so no data will follow the attributes.

This mirrors commit f0cc7adb2f in coreboot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/cbfs_util.py | 46 ++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/tools/binman/cbfs_util.py b/tools/binman/cbfs_util.py
index 92d2add25146..9ac38d8e4c1a 100644
--- a/tools/binman/cbfs_util.py
+++ b/tools/binman/cbfs_util.py
@@ -54,10 +54,6 @@ ATTR_COMPRESSION_FORMAT = '>IIII'
 ATTR_COMPRESSION_LEN = 0x10
 
 # Attribute tags
-# Depending on how the header was initialised, it may be backed with 0x00 or
-# 0xff. Support both.
-FILE_ATTR_TAG_UNUSED        = 0
-FILE_ATTR_TAG_UNUSED2       = 0xffffffff
 FILE_ATTR_TAG_COMPRESSION   = 0x42435a4c
 FILE_ATTR_TAG_HASH          = 0x68736148
 FILE_ATTR_TAG_POSITION      = 0x42435350  # PSCB
@@ -394,6 +390,8 @@ class CbfsFile(object):
                 raise ValueError("Internal error: CBFS file '%s': Requested offset %#x but current output position is %#x" %
                                  (self.name, self.cbfs_offset, offset))
             pad = tools.get_bytes(pad_byte, pad_len)
+            if attr_pos:
+                attr_pos += pad_len
             hdr_len += pad_len
 
         # This is the offset of the start of the file's data,
@@ -410,7 +408,7 @@ class CbfsFile(object):
             # happen. It probably indicates that get_header_len() is broken.
             raise ValueError("Internal error: CBFS file '%s': Expected headers of %#x bytes, got %#x" %
                              (self.name, expected_len, actual_len))
-        return hdr + name + attr + pad + content + data, hdr_len
+        return hdr + name + pad + attr + content + data, hdr_len
 
 
 class CbfsWriter(object):
@@ -456,6 +454,9 @@ class CbfsWriter(object):
         self._arch = arch
         self._bootblock_size = 0
         self._erase_byte = 0xff
+
+        # Small padding to align a file uses 0
+        self._small_pad_byte = 0
         self._align = ENTRY_ALIGN
         self._add_fileheader = False
         if self._arch == ARCHITECTURE_X86:
@@ -477,7 +478,7 @@ class CbfsWriter(object):
                                               self._bootblock_size, self._align)
             self._hdr_at_start = True
 
-    def _skip_to(self, fd, offset):
+    def _skip_to(self, fd, offset, pad_byte):
         """Write out pad bytes until a given offset
 
         Args:
@@ -487,16 +488,16 @@ class CbfsWriter(object):
         if fd.tell() > offset:
             raise ValueError('No space for data before offset %#x (current offset %#x)' %
                              (offset, fd.tell()))
-        fd.write(tools.get_bytes(self._erase_byte, offset - fd.tell()))
+        fd.write(tools.get_bytes(pad_byte, offset - fd.tell()))
 
-    def _pad_to(self, fd, offset):
+    def _pad_to(self, fd, offset, pad_byte):
         """Write out pad bytes and/or an empty file until a given offset
 
         Args:
             fd: File objext to write to
             offset: Offset to write to
         """
-        self._align_to(fd, self._align)
+        self._align_to(fd, self._align, pad_byte)
         upto = fd.tell()
         if upto > offset:
             raise ValueError('No space for data before pad offset %#x (current offset %#x)' %
@@ -505,9 +506,9 @@ class CbfsWriter(object):
         if todo:
             cbf = CbfsFile.empty(todo, self._erase_byte)
             fd.write(cbf.get_data_and_offset()[0])
-        self._skip_to(fd, offset)
+        self._skip_to(fd, offset, pad_byte)
 
-    def _align_to(self, fd, align):
+    def _align_to(self, fd, align, pad_byte):
         """Write out pad bytes until a given alignment is reached
 
         This only aligns if the resulting output would not reach the end of the
@@ -521,7 +522,7 @@ class CbfsWriter(object):
         """
         offset = align_int(fd.tell(), align)
         if offset < self._size:
-            self._skip_to(fd, offset)
+            self._skip_to(fd, offset, pad_byte)
 
     def add_file_stage(self, name, data, cbfs_offset=None):
         """Add a new stage file to the CBFS
@@ -571,7 +572,7 @@ class CbfsWriter(object):
             raise ValueError('No space for header at offset %#x (current offset %#x)' %
                              (self._header_offset, fd.tell()))
         if not add_fileheader:
-            self._pad_to(fd, self._header_offset)
+            self._pad_to(fd, self._header_offset, self._erase_byte)
         hdr = struct.pack(HEADER_FORMAT, HEADER_MAGIC, HEADER_VERSION2,
                           self._size, self._bootblock_size, self._align,
                           self._contents_offset, self._arch, 0xffffffff)
@@ -583,7 +584,7 @@ class CbfsWriter(object):
             fd.write(name)
             self._header_offset = fd.tell()
             fd.write(hdr)
-            self._align_to(fd, self._align)
+            self._align_to(fd, self._align, self._erase_byte)
         else:
             fd.write(hdr)
 
@@ -600,24 +601,26 @@ class CbfsWriter(object):
         # THe header can go at the start in some cases
         if self._hdr_at_start:
             self._write_header(fd, add_fileheader=self._add_fileheader)
-        self._skip_to(fd, self._contents_offset)
+        self._skip_to(fd, self._contents_offset, self._erase_byte)
 
         # Write out each file
         for cbf in self._files.values():
             # Place the file at its requested place, if any
             offset = cbf.calc_start_offset()
             if offset is not None:
-                self._pad_to(fd, align_int_down(offset, self._align))
+                self._pad_to(fd, align_int_down(offset, self._align),
+                             self._erase_byte)
             pos = fd.tell()
-            data, data_offset = cbf.get_data_and_offset(pos, self._erase_byte)
+            data, data_offset = cbf.get_data_and_offset(pos,
+                                                        self._small_pad_byte)
             fd.write(data)
-            self._align_to(fd, self._align)
+            self._align_to(fd, self._align, self._erase_byte)
             cbf.calced_cbfs_offset = pos + data_offset
         if not self._hdr_at_start:
             self._write_header(fd, add_fileheader=self._add_fileheader)
 
         # Pad to the end and write a pointer to the CBFS master header
-        self._pad_to(fd, self._base_address or self._size - 4)
+        self._pad_to(fd, self._base_address or self._size - 4, self._erase_byte)
         rel_offset = self._header_offset - self._size
         fd.write(struct.pack('<I', rel_offset & 0xffffffff))
 
@@ -810,8 +813,6 @@ class CbfsReader(object):
                 # We don't currently use this information
                 atag, alen, compress, _decomp_size = struct.unpack(
                     ATTR_COMPRESSION_FORMAT, data)
-            elif atag == FILE_ATTR_TAG_UNUSED2:
-                break
             else:
                 print('Unknown attribute tag %x' % atag)
             attr_size -= len(data)
@@ -846,7 +847,8 @@ class CbfsReader(object):
     def _read_string(cls, fd):
         """Read a string from a file
 
-        This reads a string and aligns the data to the next alignment boundary
+        This reads a string and aligns the data to the next alignment boundary.
+        The string must be nul-terminated
 
         Args:
             fd: File to read from
-- 
2.42.0.655.g421f12c284-goog

