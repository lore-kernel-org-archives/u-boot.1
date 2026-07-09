Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B77C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 02:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B58DF84B01;
	Thu,  9 Jul 2026 04:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qm8Bn7tP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0505D84B0E; Thu,  9 Jul 2026 04:29:21 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9F484AA2
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 04:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso1625065a34.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 19:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783564155; x=1784168955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8FfUL/l8zY/G4Mznf9Nti7950HyMtaG+vQ45yTlsYnE=;
 b=Qm8Bn7tPYKGtkIeZ/taKYGWYNJDz+UuHVX8Z2gjlAgyNdJ2MW/bJkiX0GNi6C0NJ9Y
 L8FYt4Xt8ExltYpOw24zcvKhhMpV+fL2S9kO0wBIr18/I34GRshM3KfB58muGMpAdcot
 q1rDpbY1cx5H/yDEWXWdAX+Us/J/oS15OgxPH+dpmrRQLkJpChk/aOoEB5Ld4uxD560i
 r1tG04A6xXhzLVIbJ3zWUqQIjuij05FKrL8bJYP3ac1gwPs3q9M+X9PpWHTsPvfP86OG
 auewptpa+OJvydnje/OKtTGV1PLPuM4vuLSAHirwq5QKzkfxCM54WDNxWjkxWcLwKP5E
 1qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783564155; x=1784168955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8FfUL/l8zY/G4Mznf9Nti7950HyMtaG+vQ45yTlsYnE=;
 b=a3cT30fjh9irzefS86ZrC129OnF1tM5VjjJa8+/5DsnIzmS11MHA5Jgk+vOplWVT+R
 kXBGf9Tr4PyaiIakghGVHJfKa1aAeZm/lJqMp0U5sVkqpWpxaAKpRSUNrDHHxC8DEr+G
 57ZGEG7W/mAttRp8z93xoLRJ66QFzdf/jDpj9yqGGeEar+qu6Sef0wNUfyudsZ/OBov2
 kiT6ZlYgkqG6IMhX/gqsOOavYGw94rJ0/HXSj4vIYFnVGL1KBT6HoYk8z135N6C2UF5y
 uzHVu2zNXa35/zbRPSyosszk2hv/BtxJCNKJFYPXklOSGvdUjX9b1BetEmwYa+mKa3Pz
 JwUQ==
X-Gm-Message-State: AOJu0YzKz5Nkn6wNV4eqdFW9VaZBLj0zqC3cWcy+LgHDBlhfmZgtaSbG
 XQqgMnVDTVbuerd7/JZ1aVj4w1ZiSH/HMnDM2p8pWYKunHIC3pgnxK6ej56o7y8wLqxkXA==
X-Gm-Gg: AfdE7cl7wm76ZDg9kWlkLMthsI1eB06xLorCLA5Kyj9SWrGRTHELcnjaZ/Wo5otTWGt
 HUbySNGrdTq8jjF+2IHxMH9Xm6uq8y31P8LdI7ImQ08RrEUGmKwJn01l3MZ3gKhGwjYN49Z99ny
 y9M2WqRhAcGEQUhOJnpgXJHhwpdJi4aKpTMZ6zJpSWnD+ByAo4E3fSSWEZuxIL9ete1G+70Jdgw
 LiJHyxWYGqrEWD33ze2S9jCAI2u0MOrKT7Sjx/feVODrGehuy/Q/iPy96cZTbtm1UI0kkcsUbIr
 0kOA/u5OQO/0/R60A909CHf3v6Wf5M94o9fAeo5JoFEWsaiJ8tDiMCUkhIvoX7Bsq7LtkdLbGve
 PGtuh64AfKS5druwxPvqWG9XouAx8HIsWeQ4M8Lmgv0lxOrlyfcWgMhvkY7k3g2lrnC73zejBP/
 kSEMt/3f7h1eor9HcDVQOYNaoUpNrgRb94DKUyC72HyRMKdmkuToaIcfgi9FyhRL2/w3YpdCyEP
 vdgVTc/w87thQac1QSL/gzX56CGNGzMxEqkom6PmXYR8KK7i8dfgoxy2BYZJBo+RlfDpFEA+/Tj
 CTWeoORKDw==
X-Received: by 2002:a05:6820:2212:b0:6a1:5c42:73fa with SMTP id
 006d021491bc7-6a36d9cf079mr3380124eaf.45.1783564155407; 
 Wed, 08 Jul 2026 19:29:15 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-11-8.hlrn.qwest.net.
 [174.29.11.8]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4519124d07dsm787551fac.2.2026.07.08.19.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 19:29:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aristo Chen <jj251510319013@gmail.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Subject: [PATCH v2] tools: binman: pass KEYDIR to FIT entries
Date: Wed,  8 Jul 2026 20:29:00 -0600
Message-ID: <20260709022904.3226038-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

U-Boot's Makefile passes KEYDIR to direct mkimage invocations, but
internal binman FIT builds only receive the generic BINMAN_INDIRS search
path. Adding KEYDIR to BINMAN_INDIRS treats it as one more input-file
search path: FIT entries still auto-detect a key directory from all
include directories, so an explicit KEYDIR may not be the directory that
gets passed to mkimage. It also makes a key-only directory part of the
generic blob lookup path.

Forward KEYDIR as a binman entry argument named keydir, matching the
existing entry-argument mechanism used for BL31, TEE, of-list and other
U-Boot build inputs. FIT entries use that directory directly for
mkimage -k when fit,sign or fit,encrypt is enabled, falling back to the
include-directory autodetection when keydir is not provided.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Use the existing EntryArg mechanism instead of adding a binman build
    -k/--keydir option and global state
  - Explain why KEYDIR should not just be added to BINMAN_INDIRS
  - Clarify KEYDIR documentation as a Makefile-forwarded EntryArg
---
 Makefile                  |  1 +
 tools/binman/binman.rst   |  5 +++++
 tools/binman/etype/fit.py | 28 +++++++++++++++------------
 tools/binman/ftest.py     | 40 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index d8287323c43..c8ac56d36e4 100644
--- a/Makefile
+++ b/Makefile
@@ -1689,6 +1689,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
 		$(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
+		$(if $(KEYDIR),-a keydir=$(KEYDIR)) \
 		-a atf-bl1-path=${BL1} \
 		-a atf-bl31-path=${BL31} \
 		-a tee-os-path=${TEE} \
diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 366491089ad..3a860421a69 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -2161,6 +2161,11 @@ BINMAN_INDIRS
     Sets the search path for input files used by binman by adding one or more
     `-I` arguments. See :ref:`External blobs`.
 
+KEYDIR
+    Sets the key directory passed to FIT entries by adding a
+    `-a keydir=$(KEYDIR)` argument. FIT entries use this directory for
+    mkimage's `-k` argument when `fit,sign` or `fit,encrypt` is enabled.
+
 BINMAN_TOOLPATHS
     Sets the search path for external tool used by binman by adding one or more
     `--toolpath` arguments. See :ref:`External tools`.
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index f28b1e6b4cb..32caa03a7e1 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -105,18 +105,20 @@ class Entry_fit(Entry_section):
         fit,sign
             Enable signing FIT images via mkimage as described in
             verified-boot.rst.
-            If the property is found and fit,engine is not set, the private
-            keys path is detected among binman include directories and passed to
-            mkimage via -k flag. All the keys required for signing FIT must be
-            available at time of signing and must be located in single include
-            directory.
+            If the property is found and fit,engine is not set, the `keydir`
+            entry argument is passed to mkimage via the -k flag. If no key
+            directory is provided, the private keys path is detected among
+            binman include directories. All the keys required for signing FIT
+            must be available at time of signing and must be located in a
+            single directory.
 
         fit,encrypt
             Enable data encryption in FIT images via mkimage. If the property
-            is found, the keys path is detected among binman include
-            directories and passed to mkimage via  -k flag. All the keys
-            required for encrypting the FIT must be available at the time of
-            encrypting and must be located in a single include directory.
+            is found, the `keydir` entry argument is passed to mkimage via the
+            -k flag. If no key directory is provided, the keys path is detected
+            among binman include directories. All the keys required for
+            encrypting the FIT must be available at the time of encrypting and
+            must be located in a single directory.
 
             Incompatible with fit,engine.
 
@@ -485,6 +487,7 @@ class Entry_fit(Entry_section):
                 includes 'generator' entries which are used to create the FIT,
                 but should not be processed as real entries. This is set up once
                 we have the entries
+            _keydir (str): Key directory from the keydir EntryArg, if provided
             _loadables (list of str): List of generated split-elf nodes, each
                 a node name
             _remove_props (list of str): Value of of-spl-remove-props EntryArg,
@@ -502,8 +505,9 @@ class Entry_fit(Entry_section):
         self._priv_entries = {}
         self._loadables = []
         self._remove_props = []
-        props = self.GetEntryArgsOrProps(
-            [EntryArg('of-spl-remove-props', str)], required=False)[0]
+        props, self._keydir = self.GetEntryArgsOrProps(
+            [EntryArg('of-spl-remove-props', str),
+             EntryArg('keydir', str)], required=False)
         if props:
             self._remove_props = props.split()
         self.mkimage = None
@@ -701,7 +705,7 @@ class Entry_fit(Entry_section):
             args.update({'engine': engine})
             # If no engine, keys must exist locally, find them
             if engine is None:
-                keydir = self._get_keys_dir(data)
+                keydir = self._keydir or self._get_keys_dir(data)
             elif self._fit_props.get('fit,encrypt') is not None:
                 self.Raise('fit,engine currently does not support encryption')
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac1..7b84d79eec0 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8167,6 +8167,31 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             self.assertIsNotNone(signature)
             self.assertIsNotNone(signature.props.get('value'))
 
+    def testFitSignKeydir(self):
+        """Test that the keydir EntryArg is passed to mkimage"""
+        if not elf.ELF_TOOLS:
+            self.skipTest('Python elftools not available')
+        data = tools.read_file(self.TestFile("fit/rsa2048.key"))
+        self._MakeInputFile("keys/rsa2048.key", data)
+
+        test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
+        keys_subdir = os.path.join(self._indir, "keys")
+        entry_args = {
+            'of-list': 'test-fdt1',
+            'default-dt': 'test-fdt1',
+            'atf-bl31-path': 'bl31.elf',
+            'keydir': keys_subdir,
+        }
+        data = self._DoReadFileDtb(
+            'fit/signature.dts',
+            entry_args=entry_args,
+            extra_indirs=[test_subdir])[0]
+
+        dtb = fdt.Fdt.FromData(data)
+        dtb.Scan()
+        signature = dtb.GetNode('/configurations/conf-uboot-1/signature')
+        self.assertIsNotNone(signature.props.get('value'))
+
     def testFitSignEngineSimple(self):
         """Test that image with FIT and signature nodes can be signed with an
            OpenSSL Engine"""
@@ -8507,6 +8532,21 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             dec_data = file.read()
         self.assertEqual(U_BOOT_NODTB_DATA, dec_data.encode('ascii'))
 
+    def testSimpleFitEncryptedDataKeydir(self):
+        """Test that encrypted FIT data uses the keydir EntryArg"""
+        data = tools.read_file(self.TestFile("fit/aes256.bin"))
+        self._MakeInputFile("keys/aes256.bin", data)
+
+        keys_subdir = os.path.join(self._indir, "keys")
+        data = self._DoReadFileDtb(
+            'fit/encrypt_data.dts',
+            entry_args={'keydir': keys_subdir})[0]
+
+        fit = fdt.Fdt.FromData(data)
+        fit.Scan()
+        node = fit.GetNode('/images/u-boot')
+        self.assertIn('data-size-unciphered', fit.GetProps(node))
+
     def testSimpleFitEncryptedDataMissingKey(self):
         """Test an image with a FIT containing data to be encrypted but with a missing key"""
         with self.assertRaises(ValueError) as e:
-- 
2.53.0

