Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99453C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6597C88B59;
	Mon, 26 Aug 2024 21:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LHY3xP1M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B4A388C14; Mon, 26 Aug 2024 21:12:17 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFFBA88C73
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-39d26a8f9dbso16073255ab.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699532; x=1725304332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYxOxvsq/a2UynGTAQeUrpj4KczxeQI3Ie/NudhDdeE=;
 b=LHY3xP1MNhTp9Qa01Z6qDLHj0oVfgisYHDkefTcY0ywWhnVJZYTCt84/rSZs+Kx/PJ
 jKoO0JudJUx6nxQpbIQf/cxPXU0N7eZ4GXlCCseIMmAsnMdMrn0r65JhyKgi4dQ/i8Wx
 yMGX41nFHn7KjTMKmb6X3PORDPDF+uzQvNS/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699532; x=1725304332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYxOxvsq/a2UynGTAQeUrpj4KczxeQI3Ie/NudhDdeE=;
 b=kegidFeJeF3ye5SnBivhkiw6Bd6U/G00okmZfsLcKKzNVEeq3/MoMyS4/G8dNrt+1D
 ZMPWfIzLe6Bh+bQt+lNh2+lZbz2rVfGVHwnRgX+xN4ouENmabCeaPCV3qsGXrgVwsKv6
 va8PULYJ0WaTvPq3iK7PDayigUPT3jpWswwCfgNizUMMZA01D1F5JelVVdlXlcYZujdu
 aHTje3YVBPKtk5P87x0BaMGTvRvury01uaDzhZnxpk1Z/ZlhgB7y6W59jHkjijSPbP9l
 B1gkj63ScY/T5PwdiafjuiGbybYiQK4iSfdn1+45HfBv0aCf+CumRXXxuc96kHC6Q2Iu
 IMGg==
X-Gm-Message-State: AOJu0Ywqqmklu7gweVdN8BrkPL4sKVnGhPPE7DivdJkgiKwpyXoYh0mJ
 BDIpJCyGoOyn9qIovVM5K/tMpJufOrtHjdOpN7cE2/MxYnd6TLsk8Mr0Ydr2Js9vgZFGKzHZFt8
 =
X-Google-Smtp-Source: AGHT+IHye6FIDHyqx2uTlFTTR/Bfv05FGXwEHzg9jo3rJi8cLEnqxfuxv16cb4h5xF6xLY3G9f3v6w==
X-Received: by 2002:a92:c54f:0:b0:39a:e8cf:80d0 with SMTP id
 e9e14a558f8ab-39e63e3a07dmr8284095ab.14.1724699532121; 
 Mon, 26 Aug 2024 12:12:12 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:12:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>, Rong Tao <rongtao@cestc.cn>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/15] binman: Allow image_pos to be None when writing symbols
Date: Mon, 26 Aug 2024 13:11:42 -0600
Message-Id: <20240826191143.426387-15-sjg@chromium.org>
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

Some images do not have an image_pos value, for example an image which
is part of a compressed section and therefore cannot be accessed
directly.

Handle this case, returning None as the value.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/section.py          |  3 ++
 tools/binman/ftest.py                  | 49 +++++++++++++++++++-------
 tools/binman/test/338_symbols_comp.dts | 26 ++++++++++++++
 3 files changed, 65 insertions(+), 13 deletions(-)
 create mode 100644 tools/binman/test/338_symbols_comp.dts

diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 7d2eb42627d..f4f48c00e87 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -653,6 +653,9 @@ class Entry_section(Entry):
         if prop_name == 'offset':
             return entry.offset
         elif prop_name == 'image_pos':
+            if not entry.image_pos:
+                tout.info(f'Symbol-writing: no value for {entry._node.path}')
+                return None
             return base_addr + entry.image_pos
         if prop_name == 'size':
             return entry.size
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a1a75266947..6317e72e649 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -505,8 +505,9 @@ class TestFunctional(unittest.TestCase):
         return dtb.GetContents()
 
     def _DoReadFileDtb(self, fname, use_real_dtb=False, use_expanded=False,
-                       map=False, update_dtb=False, entry_args=None,
-                       reset_dtbs=True, extra_indirs=None, threads=None):
+                       verbosity=None, map=False, update_dtb=False,
+                       entry_args=None, reset_dtbs=True, extra_indirs=None,
+                       threads=None):
         """Run binman and return the resulting image
 
         This runs binman with a given test file and then reads the resulting
@@ -523,6 +524,7 @@ class TestFunctional(unittest.TestCase):
                 But in some test we need the real contents.
             use_expanded: True to use expanded entries where available, e.g.
                 'u-boot-expanded' instead of 'u-boot'
+            verbosity: Verbosity level to use (0-3, None=don't set it)
             map: True to output map files for the images
             update_dtb: Update the offset and size of each entry in the device
                 tree before packing it into the image
@@ -559,7 +561,8 @@ class TestFunctional(unittest.TestCase):
         try:
             retcode = self._DoTestFile(fname, map=map, update_dtb=update_dtb,
                     entry_args=entry_args, use_real_dtb=use_real_dtb,
-                    use_expanded=use_expanded, extra_indirs=extra_indirs,
+                    use_expanded=use_expanded, verbosity=verbosity,
+                    extra_indirs=extra_indirs,
                     threads=threads)
             self.assertEqual(0, retcode)
             out_dtb_fname = tools.get_output_filename('u-boot.dtb.out')
@@ -1507,7 +1510,8 @@ class TestFunctional(unittest.TestCase):
         Args:
             dts: Device tree file to use for test
             base_data: Data before and after 'u-boot' section
-            u_boot_offset: Offset of 'u-boot' section in image
+            u_boot_offset (int): Offset of 'u-boot' section in image, or None if
+                the offset not available due to it being in a compressed section
             entry_args: Dict of entry args to supply to binman
                 key: arg name
                 value: value of that arg
@@ -1525,13 +1529,20 @@ class TestFunctional(unittest.TestCase):
 
         self._SetupSplElf('u_boot_binman_syms')
         data = self._DoReadFileDtb(dts, entry_args=entry_args,
-                                   use_expanded=use_expanded)[0]
+                                   use_expanded=use_expanded,
+                                   verbosity=None if u_boot_offset else 3)[0]
+
+        # The lz4-compressed version of the U-Boot data is 19 bytes long
+        comp_uboot_len = 19
+
         # The image should contain the symbols from u_boot_binman_syms.c
         # Note that image_pos is adjusted by the base address of the image,
         # which is 0x10 in our test image
+        # If u_boot_offset is None, Binman should write -1U into the image
         vals2 = (elf.BINMAN_SYM_MAGIC_VALUE, 0x00,
-                u_boot_offset + len(U_BOOT_DATA),
-                0x10 + u_boot_offset, 0x04)
+                u_boot_offset + len(U_BOOT_DATA) if u_boot_offset else
+                    len(U_BOOT_SPL_DATA) + 1 + comp_uboot_len,
+                0x10 + u_boot_offset if u_boot_offset else 0xffffffff, 0x04)
 
         # u-boot-spl has a symbols-base property, so take that into account if
         # required. The caller must supply the value
@@ -1561,17 +1572,21 @@ class TestFunctional(unittest.TestCase):
             self.assertEqual(base_data[24:], data[24:blen])
             self.assertEqual(0xff, data[blen])
 
-            ofs = blen + 1 + len(U_BOOT_DATA)
-            self.assertEqual(U_BOOT_DATA, data[blen + 1:ofs])
+            if u_boot_offset:
+                ofs = blen + 1 + len(U_BOOT_DATA)
+                self.assertEqual(U_BOOT_DATA, data[blen + 1:ofs])
+            else:
+                ofs = blen + 1 + comp_uboot_len
 
             self.assertEqual(sym_values2, data[ofs:ofs + 24])
             self.assertEqual(base_data[24:], data[ofs + 24:])
 
             # Just repeating the above asserts all at once, for clarity
-            expected = (sym_values + base_data[24:] +
-                        tools.get_bytes(0xff, 1) + U_BOOT_DATA + sym_values2 +
-                        base_data[24:])
-            self.assertEqual(expected, data)
+            if u_boot_offset:
+                expected = (sym_values + base_data[24:] +
+                            tools.get_bytes(0xff, 1) + U_BOOT_DATA +
+                            sym_values2 + base_data[24:])
+                self.assertEqual(expected, data)
 
     def testSymbols(self):
         """Test binman can assign symbols embedded in U-Boot"""
@@ -7777,6 +7792,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                           entry_args=entry_args, use_expanded=True,
                           symbols_base=0)
 
+    def testSymbolsCompressed(self):
+        """Test binman complains about symbols from a compressed section"""
+        with test_util.capture_sys_output() as (stdout, stderr):
+            self.checkSymbols('338_symbols_comp.dts', U_BOOT_SPL_DATA, None)
+        out = stdout.getvalue()
+        self.assertIn('Symbol-writing: no value for /binman/section/u-boot',
+                      out)
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/338_symbols_comp.dts b/tools/binman/test/338_symbols_comp.dts
new file mode 100644
index 00000000000..15008507cfd
--- /dev/null
+++ b/tools/binman/test/338_symbols_comp.dts
@@ -0,0 +1,26 @@
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
+		};
+
+		section {
+			offset = <0x1c>;
+			compress = "lz4";
+
+			u-boot {
+			};
+		};
+
+		u-boot-spl2 {
+			type = "u-boot-spl";
+		};
+	};
+};
-- 
2.34.1

