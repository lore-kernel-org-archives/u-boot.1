Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334B7C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B9288C45;
	Mon, 26 Aug 2024 21:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QUo5Ds2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957C888C73; Mon, 26 Aug 2024 21:12:13 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 408B588B8E
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-39d20c4be2eso18169055ab.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699529; x=1725304329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHzDU/4cD/NtXKsEYAy9yhCk8NC7V8Q7Q0rPIPfIXto=;
 b=QUo5Ds2r0Txbi8IGPZLd5c81SkUXvXy1Dwy5vRyq0GZMYft/b0ghgO6OBrfFCSz3DZ
 hjNNp64cf8aEg5o2KMJU9QWmHpmAYHeGnK7bt7g+7OJLl58wYdfw/yzSqMnril4OfoXz
 0DbwC/mmvtxNsRNmdA7Xp/hvFioena6fRCjs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699529; x=1725304329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHzDU/4cD/NtXKsEYAy9yhCk8NC7V8Q7Q0rPIPfIXto=;
 b=eSwmzQxTaBeNQnzDWFeTXFgIYvudXWje2s6EW4jJ1pPvdT172giQmxnbTxoZpY5eF5
 HFeFNTv4N3oOFNbLN/d1bZO10D+XDpqh7k7junsRwWfb8FlwVXMF1jcperYU5hrXo+Tv
 DhfXEnwNxlIWY/17fc4coCVuPtd1zSe/WtiaFVeY180mvbb6dZleSi16/yOaA4lv/YdB
 eC7Bi/NPwBDdS7XUXGNnLXBNptfPsTaTI9LKYv4p82lDy9npJmtFcdNnXmWFU0UKf5LG
 /j020MJ5JDze7XY9tOPrEhyWRmm2xyOK3gWw8O6Fg21qWG6poAu6euYEoHJcGPIywJ2m
 V6Lw==
X-Gm-Message-State: AOJu0YzYfrSD007Ek2ctBWi15vgdXIqj7T000RFQYg+QfIydTpT8aeTg
 i8wmAcbJODJo/1Vn2+oXWZ/3VYkbrClNEUI9fdjEU+wcOEDiQmxyGd4E9DgmhpWkHY1F+LNlxOU
 =
X-Google-Smtp-Source: AGHT+IE4g2U6Q8jwAVOfT/H3MSMiVYGLxOljSeB/qkJSphm3aj5PkbJSoSsJ9iP67MvyL0TCWbpcHQ==
X-Received: by 2002:a05:6e02:16cc:b0:375:b19d:deb4 with SMTP id
 e9e14a558f8ab-39e3c984987mr128404825ab.7.1724699529512; 
 Mon, 26 Aug 2024 12:12:09 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:12:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/15] binman: Provide a way to set the symbol base address
Date: Mon, 26 Aug 2024 13:11:40 -0600
Message-Id: <20240826191143.426387-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826191143.426387-1-sjg@chromium.org>
References: <20240826191143.426387-1-sjg@chromium.org>
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

The base address of the ELF containing symbols is normally added to
any symbols written, so that the value points to the correct address in
memory when everything is loaded. When the binary resides on disk, a
different offset may be needed, typically 0. Provide a way to specify
this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/binman.rst                       | 15 ++++++++
 tools/binman/elf.py                           |  7 ++--
 tools/binman/entry.py                         |  8 ++++-
 tools/binman/etype/blob_phase.py              |  5 +++
 tools/binman/ftest.py                         | 35 ++++++++++++++++---
 tools/binman/test/336_symbols_base.dts        | 23 ++++++++++++
 tools/binman/test/337_symbols_base_expand.dts | 24 +++++++++++++
 7 files changed, 110 insertions(+), 7 deletions(-)
 create mode 100644 tools/binman/test/336_symbols_base.dts
 create mode 100644 tools/binman/test/337_symbols_base_expand.dts

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 04564f4f66f..f9a3a42183b 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -502,6 +502,10 @@ For x86 devices (with the end-at-4gb property) this base address is not added
 since it is assumed that images are XIP and the offsets already include the
 address.
 
+For non-x86 cases where the symbol is used as a flash offset, the symbols-base
+property can be set to that offset (e.g. 0), so that the unadjusted image-pos
+is written into the image.
+
 While U-Boot's symbol updating is handled automatically by the u-boot-spl
 entry type (and others), it is possible to use this feature with any blob. To
 do this, add a `write-symbols` (boolean) property to the node, set the ELF
@@ -743,6 +747,17 @@ insert-template:
     properties are brought into the target node. See Templates_ below for
     more information.
 
+symbols-base:
+    When writing symbols into a binary, the value of that symbol is assumed to
+    be relative to the base address of the binary. This allow the binary to be
+    loaded in memory at its base address, so that symbols point into the binary
+    correctly. In some cases the binary is in fact not yet in memory, but must
+    be read from storage. In this case there is no base address for the symbols.
+    This property can be set to 0 to indicate this. Other values for
+    symbols-base are allowed, but care must be taken that the code which uses
+    the symbol is aware of the base being used. If omitted, the binary's base
+    address is used.
+
 The attributes supported for images and sections are described below. Several
 are similar to those for entries.
 
diff --git a/tools/binman/elf.py b/tools/binman/elf.py
index 73394830ebe..c75f4478813 100644
--- a/tools/binman/elf.py
+++ b/tools/binman/elf.py
@@ -234,7 +234,7 @@ def GetSymbolOffset(elf_fname, sym_name, base_sym=None):
     return val - base
 
 def LookupAndWriteSymbols(elf_fname, entry, section, is_elf=False,
-                          base_sym=None):
+                          base_sym=None, base_addr=None):
     """Replace all symbols in an entry with their correct values
 
     The entry contents is updated so that values for referenced symbols will be
@@ -249,6 +249,8 @@ def LookupAndWriteSymbols(elf_fname, entry, section, is_elf=False,
         section: Section which can be used to lookup symbol values
         base_sym: Base symbol marking the start of the image (__image_copy_start
             by default)
+        base_addr (int): Base address to use for the entry being written. If
+            None then the value of base_sym is used
 
     Returns:
         int: Number of symbols written
@@ -278,7 +280,8 @@ def LookupAndWriteSymbols(elf_fname, entry, section, is_elf=False,
     if not base and not is_elf:
         tout.debug(f'LookupAndWriteSymbols: no base: elf_fname={elf_fname}, base_sym={base_sym}, is_elf={is_elf}')
         return 0
-    base_addr = 0 if is_elf else base.address
+    if base_addr is None:
+        base_addr = 0 if is_elf else base.address
     count = 0
     for name, sym in syms.items():
         if name.startswith('_binman'):
diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 7d4d4692776..8ad9fe89e0c 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -108,6 +108,9 @@ class Entry(object):
             not need to be done again. This is only used with 'binman replace',
             to stop sections from being rebuilt if their entries have not been
             replaced
+        symbols_base (int): Use this value as the assumed load address of the
+            target entry, when calculating the symbol value. If None, this is
+            0 for blobs and the image-start address for ELF files
     """
     fake_dir = None
 
@@ -159,6 +162,7 @@ class Entry(object):
         self.preserve = False
         self.build_done = False
         self.no_write_symbols = False
+        self.symbols_base = None
 
     @staticmethod
     def FindEntryClass(etype, expanded):
@@ -324,6 +328,7 @@ class Entry(object):
 
         self.preserve = fdt_util.GetBool(self._node, 'preserve')
         self.no_write_symbols = fdt_util.GetBool(self._node, 'no-write-symbols')
+        self.symbols_base = fdt_util.GetInt(self._node, 'symbols-base')
 
     def GetDefaultFilename(self):
         return None
@@ -713,7 +718,8 @@ class Entry(object):
             # Check if we are writing symbols into an ELF file
             is_elf = self.GetDefaultFilename() == self.elf_fname
             elf.LookupAndWriteSymbols(self.elf_fname, self, section.GetImage(),
-                                      is_elf, self.elf_base_sym)
+                                      is_elf, self.elf_base_sym,
+                                      self.symbols_base)
 
     def CheckEntries(self):
         """Check that the entry offsets are correct
diff --git a/tools/binman/etype/blob_phase.py b/tools/binman/etype/blob_phase.py
index 951d9934050..09bb89b3b78 100644
--- a/tools/binman/etype/blob_phase.py
+++ b/tools/binman/etype/blob_phase.py
@@ -57,3 +57,8 @@ class Entry_blob_phase(Entry_section):
         if self.no_write_symbols:
             for entry in self._entries.values():
                 entry.no_write_symbols = True
+
+        # Propagate the symbols-base property
+        if self.symbols_base is not None:
+            for entry in self._entries.values():
+                entry.symbols_base = self.symbols_base
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 9f329704115..a1a75266947 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1500,7 +1500,8 @@ class TestFunctional(unittest.TestCase):
         self.assertEqual(U_BOOT_SPL_NODTB_DATA, data[:len(U_BOOT_SPL_NODTB_DATA)])
 
     def checkSymbols(self, dts, base_data, u_boot_offset, entry_args=None,
-                     use_expanded=False, no_write_symbols=False):
+                     use_expanded=False, no_write_symbols=False,
+                     symbols_base=None):
         """Check the image contains the expected symbol values
 
         Args:
@@ -1512,6 +1513,8 @@ class TestFunctional(unittest.TestCase):
                 value: value of that arg
             use_expanded: True to use expanded entries where available, e.g.
                 'u-boot-expanded' instead of 'u-boot'
+            symbols_base (int): Value to expect for symbols-base in u-boot-spl,
+                None if none
         """
         elf_fname = self.ElfTestFile('u_boot_binman_syms')
         syms = elf.GetSymbols(elf_fname, ['binman', 'image'])
@@ -1526,10 +1529,19 @@ class TestFunctional(unittest.TestCase):
         # The image should contain the symbols from u_boot_binman_syms.c
         # Note that image_pos is adjusted by the base address of the image,
         # which is 0x10 in our test image
-        vals = (elf.BINMAN_SYM_MAGIC_VALUE, 0x00,
+        vals2 = (elf.BINMAN_SYM_MAGIC_VALUE, 0x00,
                 u_boot_offset + len(U_BOOT_DATA),
                 0x10 + u_boot_offset, 0x04)
+
+        # u-boot-spl has a symbols-base property, so take that into account if
+        # required. The caller must supply the value
+        vals = list(vals2)
+        if symbols_base is not None:
+            vals[3] = symbols_base + u_boot_offset
+        vals = tuple(vals)
+
         sym_values = struct.pack('<LLQLL', *vals)
+        sym_values2 = struct.pack('<LLQLL', *vals2)
         if no_write_symbols:
             self.assertEqual(
                 base_data +
@@ -1552,12 +1564,12 @@ class TestFunctional(unittest.TestCase):
             ofs = blen + 1 + len(U_BOOT_DATA)
             self.assertEqual(U_BOOT_DATA, data[blen + 1:ofs])
 
-            self.assertEqual(sym_values, data[ofs:ofs + 24])
+            self.assertEqual(sym_values2, data[ofs:ofs + 24])
             self.assertEqual(base_data[24:], data[ofs + 24:])
 
             # Just repeating the above asserts all at once, for clarity
             expected = (sym_values + base_data[24:] +
-                        tools.get_bytes(0xff, 1) + U_BOOT_DATA + sym_values +
+                        tools.get_bytes(0xff, 1) + U_BOOT_DATA + sym_values2 +
                         base_data[24:])
             self.assertEqual(expected, data)
 
@@ -7750,6 +7762,21 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: mkeficapsule")
 
+    def testSymbolsBase(self):
+        """Test handling of symbols-base"""
+        self.checkSymbols('336_symbols_base.dts', U_BOOT_SPL_DATA, 0x1c,
+                          symbols_base=0)
+
+    def testSymbolsBaseExpanded(self):
+        """Test handling of symbols-base with expanded entries"""
+        entry_args = {
+            'spl-dtb': '1',
+        }
+        self.checkSymbols('337_symbols_base_expand.dts', U_BOOT_SPL_NODTB_DATA +
+                          U_BOOT_SPL_DTB_DATA, 0x38,
+                          entry_args=entry_args, use_expanded=True,
+                          symbols_base=0)
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/336_symbols_base.dts b/tools/binman/test/336_symbols_base.dts
new file mode 100644
index 00000000000..e4dccd38c22
--- /dev/null
+++ b/tools/binman/test/336_symbols_base.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pad-byte = <0xff>;
+		u-boot-spl {
+			symbols-base = <0>;
+		};
+
+		u-boot {
+			offset = <0x1c>;
+		};
+
+		u-boot-spl2 {
+			type = "u-boot-spl";
+		};
+	};
+};
diff --git a/tools/binman/test/337_symbols_base_expand.dts b/tools/binman/test/337_symbols_base_expand.dts
new file mode 100644
index 00000000000..5a777ae63b8
--- /dev/null
+++ b/tools/binman/test/337_symbols_base_expand.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pad-byte = <0xff>;
+		u-boot-spl {
+			symbols-base = <0>;
+		};
+
+		u-boot {
+			offset = <0x38>;
+			no-expanded;
+		};
+
+		u-boot-spl2 {
+			type = "u-boot-spl";
+		};
+	};
+};
-- 
2.34.1

