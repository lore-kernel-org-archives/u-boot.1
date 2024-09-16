Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30178C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 08:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E5AE88E90;
	Mon, 16 Sep 2024 10:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X4730AiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AB1C88EA9; Mon, 16 Sep 2024 10:24:56 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF6E88E70
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 10:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=al.kochet@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso3812225e87.2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 01:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726475093; x=1727079893; darn=lists.denx.de;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+JxxT+0FbWLetJ+tatN+IiHfTf9KQZXnuUCSiEqFm6Q=;
 b=X4730AiXxeo9Katve66HFQul0ku/vAoC1HYi8ATu4ulEklyqTeBC0hAJd2kcoWqumA
 op1CVm8GQc1MrWSyrNQX3jvogmM59Cbod31heQ5zK5C+ORwekzWU1kyJfUjB0grTUo2Z
 AzXlvW4iqBxcmRNpAPUZ8Cymian+KqKkJQQS3I9q3tY+FP0x0ApI9VfhC/IORTv1w6es
 +hZcXV6rTnI8BYIjhU4upiitra5dEQH+hEtKiZWYsFFLwfDqLe0WQ3d+FVaKZRKNFrAz
 4Bc0UWsncGaZA3ukAGjKkebijIw7UCRxo40T7/c9eAo4r4msDFGZ+RnZyKLG0U3LLLCD
 IIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726475093; x=1727079893;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JxxT+0FbWLetJ+tatN+IiHfTf9KQZXnuUCSiEqFm6Q=;
 b=YI9lHfkufqBs0jfAiLu2gB9No7WP3VxF9kJC9W/u1v6/pWVtTEg4ZTIWBwWhFlFCo8
 owJoB+bJNB+rd2/mG2fxcS9gi+zjMdivEYDr9Ilgv8lCUij72ibteIbOfRf2oczoXKnU
 P77t3QdRghtPvfLjg/7Ku7VqnZH2QVYfHoyqcSPGJTnc/ndv5rCl8ikq38dkpBQZjR/4
 gPgqbQbpiR5bv6YMAwylLhr9U5+s9EY5mqaw97EFYWgLknl5gwgJLtKB5vgUznoxjV70
 KGfyWAUUMWGYOcyFvLnDXVtsVxbkA0CuNi7xqT1Nj3+ZFTEJd0vsg8Hqi909gqi1WuZ8
 gE5w==
X-Gm-Message-State: AOJu0YwoczHbRwcF6SC/k0B+eUFQmfPMZLneByFidC7dHlzCZS6g3hIN
 28FUAS/rYwIRWdHW1e5HwdqRkB7/hVKupVgtFDweMYoaXSaoJOYQz8lgww==
X-Google-Smtp-Source: AGHT+IHzMC4MoeI0+AfHU5meYucXNJY0Zqe21fec5F5DQHYA1SZc/W0hxdqz7IiixNt7w7F4nsZRcA==
X-Received: by 2002:a05:6512:3086:b0:536:53e3:feae with SMTP id
 2adb3069b0e04-5367feb965amr6898842e87.11.1726475092250; 
 Mon, 16 Sep 2024 01:24:52 -0700 (PDT)
Received: from localhost.localdomain ([80.87.144.137])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5368704dca5sm804367e87.111.2024.09.16.01.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:24:51 -0700 (PDT)
From: al.kochet@gmail.com
To: u-boot@lists.denx.de
Cc: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH 3/3] binman: implement signing FIT images during image build
Date: Mon, 16 Sep 2024 11:24:46 +0300
Message-Id: <20240916082446.32082-4-al.kochet@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240916082446.32082-1-al.kochet@gmail.com>
References: <20240916082446.32082-1-al.kochet@gmail.com>
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

From: Alexander Kochetkov <al.kochet@gmail.com>

The patch implement new property 'fit,sign' that can be declared
at the top-level 'fit' node. If that option is declared, fit tryies
to detect private keys directory among binman include directories.
That directory than passed to mkimage using '-k' flag and that enable
signing of FIT.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 tools/binman/btool/mkimage.py           |  5 +-
 tools/binman/entries.rst                |  7 ++
 tools/binman/etype/fit.py               | 51 +++++++++++++
 tools/binman/ftest.py                   | 95 ++++++++++++++++++++++++
 tools/binman/test/326_fit_signature.dts | 98 +++++++++++++++++++++++++
 tools/binman/test/326_rsa2048.key       | 28 +++++++
 tools/binman/test/327_fit_signature.dts | 98 +++++++++++++++++++++++++
 tools/binman/test/328_fit_signature.dts | 61 +++++++++++++++
 8 files changed, 442 insertions(+), 1 deletion(-)
 create mode 100644 tools/binman/test/326_fit_signature.dts
 create mode 100644 tools/binman/test/326_rsa2048.key
 create mode 100644 tools/binman/test/327_fit_signature.dts
 create mode 100644 tools/binman/test/328_fit_signature.dts

diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
index 39a4c8c143..78d3301bc1 100644
--- a/tools/binman/btool/mkimage.py
+++ b/tools/binman/btool/mkimage.py
@@ -22,7 +22,7 @@ class Bintoolmkimage(bintool.Bintool):
 
     # pylint: disable=R0913
     def run(self, reset_timestamp=False, output_fname=None, external=False,
-            pad=None, align=None):
+            pad=None, align=None, priv_keys_dir=None):
         """Run mkimage
 
         Args:
@@ -34,6 +34,7 @@ class Bintoolmkimage(bintool.Bintool):
                 other things to be easily added later, if required, such as
                 signatures
             align: Bytes to use for alignment of the FIT and its external data
+            priv_keys_dir: Path to directory containing private keys
             version: True to get the mkimage version
         """
         args = []
@@ -45,6 +46,8 @@ class Bintoolmkimage(bintool.Bintool):
             args += ['-B', f'{align:x}']
         if reset_timestamp:
             args.append('-t')
+        if priv_keys_dir:
+            args += ['-k', f'{priv_keys_dir}']
         if output_fname:
             args += ['-F', output_fname]
         return self.run_cmd(*args)
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 254afe7607..9151332c1e 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -815,6 +815,13 @@ The top-level 'fit' node supports the following special properties:
 
             fit,fdt-list-val = "dtb1", "dtb2";
 
+    fit,sign
+        Enable signing FIT images via mkimage as described in
+        verified-boot.rst. If the property is found, the private keys path is
+        detected among binman include directories and passed to mkimage via
+        -k flag. All the keys required for signing FIT must be available at
+        time of signing and must be located in single include directory.
+
 Substitutions
 ~~~~~~~~~~~~~
 
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index e96222f4b6..30d8532626 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -6,6 +6,7 @@
 """Entry-type module for producing a FIT"""
 
 import libfdt
+import os
 
 from binman.entry import Entry, EntryArg
 from binman.etype.section import Entry_section
@@ -87,6 +88,14 @@ class Entry_fit(Entry_section):
 
                 fit,fdt-list-val = "dtb1", "dtb2";
 
+        fit,sign
+            Enable signing FIT images via mkimage as described in
+            verified-boot.rst. If the property is found, the private keys path
+            is detected among binman include directories and passed to mkimage
+            via  -k flag. All the keys required for signing FIT must be
+            available at time of signing and must be located in single include
+            directory.
+
     Substitutions
     ~~~~~~~~~~~~~
 
@@ -355,6 +364,7 @@ class Entry_fit(Entry_section):
         self.mkimage = None
         self._priv_entries = {}
         self._loadables = []
+        self._fit_sign = None
 
     def ReadNode(self):
         super().ReadNode()
@@ -430,6 +440,45 @@ class Entry_fit(Entry_section):
         # are removed from self._entries later.
         self._priv_entries = dict(self._entries)
 
+    def _get_priv_keys_dir(self, data):
+        """Detect private keys path among binman include directories
+
+        Args:
+            data: FIT image in binary format
+
+        Returns:
+            str: Single path containing all private keys found or None
+
+        Raises:
+            ValueError: Filename 'rsa2048.key' not found in input path
+            ValueError: Multiple key paths found
+        """
+        def _find_keys_dir(node):
+            for subnode in node.subnodes:
+                if subnode.name.startswith('signature'):
+                    if subnode.props.get('key-name-hint') is None:
+                        continue
+                    hint = subnode.props['key-name-hint'].value
+                    name = tools.get_input_filename(f"{hint}.key")
+                    path = os.path.dirname(name)
+                    if path not in paths:
+                        paths.append(path)
+                else:
+                    _find_keys_dir(subnode)
+            return None
+
+        fdt = Fdt.FromData(data)
+        fdt.Scan()
+
+        paths = []
+
+        _find_keys_dir(fdt.GetRoot())
+
+        if len(paths) > 1:
+            self.Raise("multiple key paths found (%s)" % ",".join(paths))
+
+        return paths[0] if len(paths) else None
+
     def BuildSectionData(self, required):
         """Build FIT entry contents
 
@@ -460,6 +509,8 @@ class Entry_fit(Entry_section):
         align = self._fit_props.get('fit,align')
         if align is not None:
             args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
+        if self._fit_props.get('fit,sign') is not None:
+            args.update({'priv_keys_dir': self._get_priv_keys_dir(data)})
         if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
                             **args) is None:
             if not self.GetAllowMissing():
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8a44bc051b..22c3da5962 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6836,6 +6836,101 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                 ['fit'])
         self.assertIn("Node '/fit': Missing tool: 'mkimage'", str(e.exception))
 
+    def testFitSignSimple(self):
+        """Test that image with FIT and signature nodes can be signed"""
+        if not elf.ELF_TOOLS:
+            self.skipTest('Python elftools not available')
+        entry_args = {
+            'of-list': 'test-fdt1',
+            'default-dt': 'test-fdt1',
+            'atf-bl31-path': 'bl31.elf',
+        }
+        data = tools.read_file(self.TestFile("326_rsa2048.key"))
+        self._MakeInputFile("keys/rsa2048.key", data)
+
+        test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
+        keys_subdir = os.path.join(self._indir, "keys")
+        data = self._DoReadFileDtb(
+            '326_fit_signature.dts',
+            entry_args=entry_args,
+            extra_indirs=[test_subdir, keys_subdir])[0]
+
+        dtb = fdt.Fdt.FromData(data)
+        dtb.Scan()
+
+        conf = dtb.GetNode('/configurations/conf-uboot-1')
+        self.assertIsNotNone(conf)
+        signature = conf.FindNode('signature')
+        self.assertIsNotNone(signature)
+        self.assertIsNotNone(signature.props.get('value'))
+
+        images = dtb.GetNode('/images')
+        self.assertIsNotNone(images)
+        for subnode in images.subnodes:
+            signature = subnode.FindNode('signature')
+            self.assertIsNotNone(signature)
+            self.assertIsNotNone(signature.props.get('value'))
+
+    def testFitSignKeyNotFound(self):
+        """Test that missing keys raise an error"""
+        if not elf.ELF_TOOLS:
+            self.skipTest('Python elftools not available')
+        entry_args = {
+            'of-list': 'test-fdt1',
+            'default-dt': 'test-fdt1',
+            'atf-bl31-path': 'bl31.elf',
+        }
+        test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFileDtb(
+                '326_fit_signature.dts',
+                entry_args=entry_args,
+                extra_indirs=[test_subdir])[0]
+        self.assertIn(
+            'Filename \'rsa2048.key\' not found in input path',
+            str(e.exception))
+
+    def testFitSignMultipleKeyPaths(self):
+        """Test that keys found in multiple paths raise an error"""
+        if not elf.ELF_TOOLS:
+            self.skipTest('Python elftools not available')
+        entry_args = {
+            'of-list': 'test-fdt1',
+            'default-dt': 'test-fdt1',
+            'atf-bl31-path': 'bl31.elf',
+        }
+        data = tools.read_file(self.TestFile("326_rsa2048.key"))
+        self._MakeInputFile("keys1/rsa2048.key", data)
+        data = tools.read_file(self.TestFile("326_rsa2048.key"))
+        self._MakeInputFile("keys2/conf-rsa2048.key", data)
+
+        test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
+        keys_subdir1 = os.path.join(self._indir, "keys1")
+        keys_subdir2 = os.path.join(self._indir, "keys2")
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFileDtb(
+                '327_fit_signature.dts',
+                entry_args=entry_args,
+                extra_indirs=[test_subdir, keys_subdir1, keys_subdir2])[0]
+        self.assertIn(
+            'Node \'/binman/fit\': multiple key paths found',
+            str(e.exception))
+
+    def testFitSignNoSingatureNodes(self):
+        """Test that fit,sign doens't raise error if no signature nodes found"""
+        if not elf.ELF_TOOLS:
+            self.skipTest('Python elftools not available')
+        entry_args = {
+            'of-list': 'test-fdt1',
+            'default-dt': 'test-fdt1',
+            'atf-bl31-path': 'bl31.elf',
+        }
+        test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
+        self._DoReadFileDtb(
+            '328_fit_signature.dts',
+            entry_args=entry_args,
+            extra_indirs=[test_subdir])[0]
+
     def testSymbolNoWrite(self):
         """Test disabling of symbol writing"""
         self._SetupSplElf()
diff --git a/tools/binman/test/326_fit_signature.dts b/tools/binman/test/326_fit_signature.dts
new file mode 100644
index 0000000000..9dce62e52d
--- /dev/null
+++ b/tools/binman/test/326_fit_signature.dts
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			description = "test desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+			fit,sign;
+
+			images {
+				u-boot {
+					description = "test u-boot";
+					type = "standalone";
+					arch = "arm64";
+					os = "u-boot";
+					compression = "none";
+					load = <0x00000000>;
+					entry = <0x00000000>;
+
+					u-boot-nodtb {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa2048";
+						key-name-hint = "rsa2048";
+					};
+				};
+				@atf-SEQ {
+					fit,operation = "split-elf";
+					description = "test tf-a";
+					type = "firmware";
+					arch = "arm64";
+					os = "arm-trusted-firmware";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					atf-bl31 {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa2048";
+						key-name-hint = "rsa2048";
+					};
+				};
+				@fdt-SEQ {
+					description = "test fdt";
+					type = "flat_dt";
+					compression = "none";
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa2048";
+						key-name-hint = "rsa2048";
+					};
+				};
+			};
+
+			configurations {
+				default = "@conf-uboot-DEFAULT-SEQ";
+				@conf-uboot-SEQ {
+					description = "uboot config";
+					fdt = "fdt-SEQ";
+					fit,firmware = "u-boot";
+					fit,loadables;
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa2048";
+						key-name-hint = "rsa2048";
+						sign-images = "firmware", "loadables", "fdt";
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/326_rsa2048.key b/tools/binman/test/326_rsa2048.key
new file mode 100644
index 0000000000..e74b20cf39
--- /dev/null
+++ b/tools/binman/test/326_rsa2048.key
@@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDVUiT2JAF8Ajcx
+3XTB5qdGxuPMVFcXKJH+4L66oSt4YUBGi1bClo80U2azu08BTzk2Jzv6hez/mvzL
+hBvL3WnPwMl5vdOxb1kvUQyKLSw2bkM8VB0X1jGsKsKjzArg/aI8RknfiaSc5jua
+2lqwUFwv2RMF8jvIMN/1GnTLdECeMFVgVFSFkzIocISAHGPoGUOxTf8xK7o0x4RX
+NzB+95RtIqTQ5Az/KPVCOcQR5ETrUBXHF1I0rYjJjHHO4dUxxfDqFabt60EzQ/R2
+oZu58C4y0TrRI98g4hVPBYapildWjaNQm1Exa4ZaSDVl01OXsFW9Dm80PqfW4tTH
+Cm4nuCq5AgMBAAECggEBAIoG5b2SHJfFwzrzpQmVmeTU6i6a3+MvMBAwEZkmkb8J
+hhJfNFsiGjTsRgbDiuI5BbbBejCmmWvmN+3jZCzr7fwsLPEl36TufFF+atO5WOM7
+Qyv07QIwaOGSpXBgpSVhV6kSfdgy8p1G54hSAt4UkSGwnnt5ei8VWMP6Q1oltW3k
+f9DQ/ar4UEVa4jlJU3xqchcUTiKBKSH6pMC/Fqlq8x5JTLmk1Yb6C2UNcgJYez1u
+sHkdCA0FG3rFPrpFoQ1LUjMj1uEYNAxM3jOxE7Uvmk4yo9WpQDY7cRb2+Th9YY8a
+IKQ2s81Yg2TmkGzr8f5nrZz3WbAmQhQgsKbwlo6snjUCgYEA7kBOt0JlU7bJTfOr
+9s51g2VUfIH9lDS2Eh8MY+Bt6Y0Kdw/UK4HR8ZlN/nn0bHuHkc12K8lXEsQpgIEW
+DaqHytZJHqFs2egzKu/IvQYZ2WXEMj47LZQxEDHO9gtjE+5qCW9yJGqxW9BJKPVD
+F4spus4NqC+yD5OHM+6ESUtL/wMCgYEA5TZj6OHmECeh3efrwHqjDcjrqQbOTozU
+KPCNCY3Pv4Cg4xas/L93TE2CY6HJTr6mwEMUM+M4Ujjj15VCmSDQ/YYcGau1jo+f
+XdphOEENrPwoe9ATWIyBpT/wDrEz3L6JbE9dWMYY8vKYESt3qhVqDlbpmnYl8Jm+
+O3r5Cy2NlJMCgYEAyqzsCZuy5QcesnByvm8dqpxdxdkzJYu9wyakfKZj+gUgfO57
+OFOkjFk07yFB27MuPctCFredmfpDr+ygHRoPkG7AHw2Fss2EEaeP5bU18ilPQMqN
+vxVMs5EblVVUgJUVoVcsC2yz2f4S7oPOAk5BPoehOIzydauznWrvIAas7I8CgYBr
+CFHxLoNq6cbZQ3JACERZrIf2/vmZjoOHtoR1gKYRK7R1NmKDB7lihRMtCSBix/4/
+61Lkw+bJ5kzmn4lgzgUpTdWTWy5FquVlQxOA3EfRjlItNsXB5KKpksi7Y53vJ34u
+eIUDbkW6NPQzmFOhtaw3k/gzq5Yd2v0M82iWAqiJRwKBgQCl2+e2cjISK31QhKTC
+puhwQ0/YuC3zlwMXQgB3nPw8b9RlaDTMrRBCIUFIrrX11tHswGWpyVsxW2AvZ3Zm
+jsWpwGkUdpRdXJBhSaisV/PA+x3kYhpibzEI8FrzhU69zNROCb8CTkN4WcdBdq6J
+PUh/jRtKoE79qrlnIlNvFoz2gQ==
+-----END PRIVATE KEY-----
diff --git a/tools/binman/test/327_fit_signature.dts b/tools/binman/test/327_fit_signature.dts
new file mode 100644
index 0000000000..77bec8df1e
--- /dev/null
+++ b/tools/binman/test/327_fit_signature.dts
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			description = "test desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+			fit,sign;
+
+			images {
+				u-boot {
+					description = "test u-boot";
+					type = "standalone";
+					arch = "arm64";
+					os = "u-boot";
+					compression = "none";
+					load = <0x00000000>;
+					entry = <0x00000000>;
+
+					u-boot-nodtb {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa2048";
+						key-name-hint = "rsa2048";
+					};
+				};
+				@atf-SEQ {
+					fit,operation = "split-elf";
+					description = "test tf-a";
+					type = "firmware";
+					arch = "arm64";
+					os = "arm-trusted-firmware";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					atf-bl31 {
+					};
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa2048";
+						key-name-hint = "rsa2048";
+					};
+				};
+				@fdt-SEQ {
+					description = "test fdt";
+					type = "flat_dt";
+					compression = "none";
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa2048";
+						key-name-hint = "rsa2048";
+					};
+				};
+			};
+
+			configurations {
+				default = "@conf-uboot-DEFAULT-SEQ";
+				@conf-uboot-SEQ {
+					description = "uboot config";
+					fdt = "fdt-SEQ";
+					fit,firmware = "u-boot";
+					fit,loadables;
+
+					hash {
+						algo = "sha256";
+					};
+
+					signature {
+						algo = "sha256,rsa2048";
+						key-name-hint = "conf-rsa2048";
+						sign-images = "firmware", "loadables", "fdt";
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/328_fit_signature.dts b/tools/binman/test/328_fit_signature.dts
new file mode 100644
index 0000000000..267105d0f6
--- /dev/null
+++ b/tools/binman/test/328_fit_signature.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			description = "test desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+			fit,sign;
+
+			images {
+				u-boot {
+					description = "test u-boot";
+					type = "standalone";
+					arch = "arm64";
+					os = "u-boot";
+					compression = "none";
+					load = <0x00000000>;
+					entry = <0x00000000>;
+
+					u-boot-nodtb {
+					};
+				};
+				@atf-SEQ {
+					fit,operation = "split-elf";
+					description = "test tf-a";
+					type = "firmware";
+					arch = "arm64";
+					os = "arm-trusted-firmware";
+					compression = "none";
+					fit,load;
+					fit,entry;
+					fit,data;
+
+					atf-bl31 {
+					};
+				};
+				@fdt-SEQ {
+					description = "test fdt";
+					type = "flat_dt";
+					compression = "none";
+				};
+			};
+
+			configurations {
+				default = "@conf-uboot-DEFAULT-SEQ";
+				@conf-uboot-SEQ {
+					description = "uboot config";
+					fdt = "fdt-SEQ";
+					fit,firmware = "u-boot";
+					fit,loadables;
+				};
+			};
+		};
+	};
+};
-- 
2.17.1

