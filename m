Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8968CCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5999086E4F;
	Sun, 15 Oct 2023 08:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PyVWdz0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11A5B86611; Sun, 15 Oct 2023 08:18:14 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BDEB86C3F
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57e3c2adbf0so1928219eaf.2
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697350631; x=1697955431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5Zt9jTqVlu4834j/UfyThdiRhb1To3H9mV2+I8039E=;
 b=PyVWdz0HKwvacWZ10cQ0XXsnHISG+bD7n8HlcuofDaU1d12ZroDQJWzvaIx9F31F0D
 MUhlUcpxA60l71QsuWmV/LqrAF6CwSlKhdiKYT6GxRMAWYnqMmRzILw8DFo4/yts3adC
 fCtNi0c49ijjWvGWpraUEFeKfoDxvVBBZn1vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697350631; x=1697955431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5Zt9jTqVlu4834j/UfyThdiRhb1To3H9mV2+I8039E=;
 b=acOTyC19nm7xMY0UGQOVD4fd/3twJ9uhc3W7c1+Fufeig9Gz6kDEFhPsykSHiNmxdE
 Gb0ed/yJsJshDvE+DR9PAvXfHyh6N02pnBJwq2OZMY6FSEaeIYrg7zV2/9hrj5KEyh6+
 Fv4fxM1BjQLAQy1oAkglpuBV5KdpUgIYYMdon7xiIyaOL/8QyrAVO+FQqRCwXxkaEg81
 q9JhoxGlqZIdVMmS48gkxsa2sg26zhlq6HcGV3yGKFkxFkiCVXuOlrBarRSAjzUdcMNq
 7lC7+4AiU79yW3mpnDtuXKmcMQbHyrW67cu61mSZNQ6j2Yc4VrmXQ6eNZqvxfrKtDYM1
 SsYA==
X-Gm-Message-State: AOJu0YxLwQCUM05HxsUVetZt3LedQ0czGZgG6KGHZ4fiL6Vl9+m9Qr2b
 vE+1e+c70pXFl62j1Qqlzqh1Dtcmi23ZF3yrJdCuZA==
X-Google-Smtp-Source: AGHT+IFRP2RzUHaQz873o9qTXPehhzg3o50g9fTBCJ7BlIfVjeX0WTd2jwsNg5Oik2ozWM2OUGMbrQ==
X-Received: by 2002:a6b:f319:0:b0:783:63d6:4c5 with SMTP id
 m25-20020a6bf319000000b0078363d604c5mr35209920ioh.12.1697316039720; 
 Sat, 14 Oct 2023 13:40:39 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a02cb1b000000b0042b14d9be7bsm5424649jap.22.2023.10.14.13.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 13:40:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 2/6] binman: Don't add compression attribute for uncompressed
 files
Date: Sat, 14 Oct 2023 14:40:26 -0600
Message-ID: <20231014204033.3077052-3-sjg@chromium.org>
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

cbfsutil changed to skip adding a compression attribute if there is no
compression. Adjust the binman implementation to do the same.

This mirrors commit 105cdf5625 in coreboot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/cbfs_util.py      | 13 ++++++++-----
 tools/binman/cbfs_util_test.py |  8 ++++----
 tools/binman/ftest.py          |  6 +++---
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/binman/cbfs_util.py b/tools/binman/cbfs_util.py
index fc56b40b7531..92d2add25146 100644
--- a/tools/binman/cbfs_util.py
+++ b/tools/binman/cbfs_util.py
@@ -333,7 +333,8 @@ class CbfsFile(object):
         if self.ftype == TYPE_STAGE:
             pass
         elif self.ftype == TYPE_RAW:
-            hdr_len += ATTR_COMPRESSION_LEN
+            if self.compress:
+                hdr_len += ATTR_COMPRESSION_LEN
         elif self.ftype == TYPE_EMPTY:
             pass
         else:
@@ -369,9 +370,11 @@ class CbfsFile(object):
                 data = self.comp_bintool.compress(orig_data)
             self.memlen = len(orig_data)
             self.data_len = len(data)
-            attr = struct.pack(ATTR_COMPRESSION_FORMAT,
-                               FILE_ATTR_TAG_COMPRESSION, ATTR_COMPRESSION_LEN,
-                               self.compress, self.memlen)
+            if self.compress:
+                attr = struct.pack(ATTR_COMPRESSION_FORMAT,
+                                   FILE_ATTR_TAG_COMPRESSION,
+                                   ATTR_COMPRESSION_LEN, self.compress,
+                                   self.memlen)
         elif self.ftype == TYPE_EMPTY:
             data = tools.get_bytes(self.erase_byte, self.size)
         else:
@@ -405,7 +408,7 @@ class CbfsFile(object):
         if expected_len != actual_len:  # pragma: no cover
             # Test coverage of this is not available since this should never
             # happen. It probably indicates that get_header_len() is broken.
-            raise ValueError("Internal error: CBFS file '%s': Expected headers of %#x bytes, got %#d" %
+            raise ValueError("Internal error: CBFS file '%s': Expected headers of %#x bytes, got %#x" %
                              (self.name, expected_len, actual_len))
         return hdr + name + attr + pad + content + data, hdr_len
 
diff --git a/tools/binman/cbfs_util_test.py b/tools/binman/cbfs_util_test.py
index ee951d10cf3b..c3babbc64e78 100755
--- a/tools/binman/cbfs_util_test.py
+++ b/tools/binman/cbfs_util_test.py
@@ -96,7 +96,7 @@ class TestCbfs(unittest.TestCase):
         self.assertEqual(arch, cbfs.arch)
         return cbfs
 
-    def _check_uboot(self, cbfs, ftype=cbfs_util.TYPE_RAW, offset=0x38,
+    def _check_uboot(self, cbfs, ftype=cbfs_util.TYPE_RAW, offset=0x28,
                      data=U_BOOT_DATA, cbfs_offset=None):
         """Check that the U-Boot file is as expected
 
@@ -122,7 +122,7 @@ class TestCbfs(unittest.TestCase):
         self.assertEqual(len(data), cfile.memlen)
         return cfile
 
-    def _check_dtb(self, cbfs, offset=0x38, data=U_BOOT_DTB_DATA,
+    def _check_dtb(self, cbfs, offset=0x28, data=U_BOOT_DTB_DATA,
                    cbfs_offset=None):
         """Check that the U-Boot dtb file is as expected
 
@@ -598,8 +598,8 @@ class TestCbfs(unittest.TestCase):
         data = cbw.get_data()
 
         cbfs = cbfs_util.CbfsReader(data)
-        self.assertEqual(0x38, cbfs.files['u-boot'].cbfs_offset)
-        self.assertEqual(0x78, cbfs.files['u-boot-dtb'].cbfs_offset)
+        self.assertEqual(0x28, cbfs.files['u-boot'].cbfs_offset)
+        self.assertEqual(0x68, cbfs.files['u-boot-dtb'].cbfs_offset)
 
 
 if __name__ == '__main__':
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 16156b741052..2875194d750e 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2670,9 +2670,9 @@ class TestFunctional(unittest.TestCase):
             'cbfs/u-boot:offset': 0x38,
             'cbfs/u-boot:uncomp-size': len(U_BOOT_DATA),
             'cbfs/u-boot:image-pos': 0x38,
-            'cbfs/u-boot-dtb:offset': 0xb8,
+            'cbfs/u-boot-dtb:offset': 0xa8,
             'cbfs/u-boot-dtb:size': len(U_BOOT_DATA),
-            'cbfs/u-boot-dtb:image-pos': 0xb8,
+            'cbfs/u-boot-dtb:image-pos': 0xa8,
             }, props)
 
     def testCbfsBadType(self):
@@ -2854,7 +2854,7 @@ class TestFunctional(unittest.TestCase):
 '  u-boot                  0     4  u-boot             0',
 '  section               100   %x  section          100' % section_size,
 '    cbfs                100   400  cbfs               0',
-'      u-boot            138     4  u-boot            38',
+'      u-boot            128     4  u-boot            28',
 '      u-boot-dtb        180   105  u-boot-dtb        80          3c9',
 '    u-boot-dtb          500   %x  u-boot-dtb       400          3c9' % fdt_size,
 '  fdtmap                %x   3bd  fdtmap           %x' %
-- 
2.42.0.655.g421f12c284-goog

