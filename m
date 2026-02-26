Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB01AFD9E25
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3A883F6E;
	Fri, 27 Feb 2026 00:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PTnU+6yt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2237C83F32; Fri, 27 Feb 2026 00:49:20 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD6183EC8
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8cb38e6d164so185832285a.3
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149753; x=1772754553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HU5m6nNUc7ur8ir8q6DaaeMq8DUc0LoODB55TY5kQFI=;
 b=PTnU+6ytJyOomvGayxOD2XwJNVP8zRmw6rGjAmM1+iYH5b2vi90TT3Oja2nU1mvR/t
 JvqNHn0/4v+F3icIC0lLoLhcO7rybrcTBWoMmBYlzph1wtko4TWwUzC52+8gJSA3fgQt
 txWaj316WXkJDHk3WEpkOLbVPLhdoo24uhA7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149753; x=1772754553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HU5m6nNUc7ur8ir8q6DaaeMq8DUc0LoODB55TY5kQFI=;
 b=SNGclU4Pc3C89Qq28BiS5foBj05x4xShdx0YwEks62z7kqxmpRfcwnkoR+XUOZyD/k
 3IiZwac0YJVoW2ruNKWDeLIasRVdYVn9nWxAQ+Ifm3O4xedJPpLMgXd94Ge1A5b3dmrw
 1FoFQjZ85ml86pEksAp61FXLPll7oyeQ5c5olp2+dQfPsP8x4J9U5Z4G9rEhVZg8zqVF
 764ImjyuMaDt1ii5hxcmoguuwJPDSO/o2XSSQbS1axhWUrRVAfIS6/fqBfYJcKOii70c
 g0glxhYoNSqjT8C6KNUMB0OJFY/J7hg2jqvDIqBJs1E27/3CUt9BAOdf+jFT2pk39Wmg
 L2QA==
X-Gm-Message-State: AOJu0YzjmA+0hHqP8QQctGaCFWLT5RqsgmKKPTx+EDt9849tHBGxI13O
 SKkiqNP/J4x6qL6oo2vKjLID93pqYrJFy71kjgOC5Hi4QmLRG4kQvi4NolybWLgoTVlphjrTHpV
 Ds+o=
X-Gm-Gg: ATEYQzzf2VXeMcIQEDeyUyHZNaPc0SoeesKOT96qy0cnqgqzUzymJvu8EF8He27RrI0
 JLr5r7Yh/nTBdCUihXDSzCbjfHNuZzmLPPXoi4KM0cVrVfMGc9bYnDamgf1dQCTua4Lru1btAPH
 N811Kl5gd6FQ6k7bxsqSfWk9OIskMSIZIZHw+5txYmdBfn1EdjkbmoQF33TnaroCrAXC9WxsMNn
 rVCRc78uHT+TUIVugoks9zYnjrcyaXUdcXlNw00yNAPT5ScrVlKJyVNy2G36mwCUMBE729SSEVL
 Z/DEWfkGUN+CMVQlMYP13Wkcy77Ay2Nrvy0iXjC1wM1xAXLpKJ72wLjrBsenVfOxC63NVWyr1t4
 h28GSohIwVpl3upRHKUiukMgzt7MtlRbwmVeaURHH4nUWegkYrsxoacVN5XFFR3r0XnMaWmgRU/
 ZbKu3pYh/Se0kYXCI1sXMpMvmxyd15
X-Received: by 2002:a05:620a:2549:b0:8ca:2cf9:8197 with SMTP id
 af79cd13be357-8cbc8e4f6b1mr99077485a.47.1772149752490; 
 Thu, 26 Feb 2026 15:49:12 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf68a0fbsm322024385a.22.2026.02.26.15.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:49:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [RFC PATCH 15/16] binman: test: Move remaining test files to
 test/entry/
Date: Thu, 26 Feb 2026 16:47:55 -0700
Message-ID: <20260226234802.345968-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226234802.345968-1-sjg@chromium.org>
References: <20260226234802.345968-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Move the remaining 60 or so test files into an entry/ subdirectory.
These cover general entry types and features: entry args, fill, text,
env, compress, replace, template, collection, ELF, overlap, listing,
sections, symlink, TEE OS, and other miscellaneous entries. Drop the
numeric prefixes and update all references.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 doc/develop/binman_tests.rst                  |   2 +-
 tools/binman/fdt_test.py                      |   2 +-
 tools/binman/ftest.py                         | 160 +++++++++---------
 .../test/{262_absent.dts => entry/absent.dts} |   0
 .../collection.dts}                           |   0
 .../collection_other.dts}                     |   0
 .../collection_section.dts}                   |   0
 .../{083_compress.dts => entry/compress.dts}  |   0
 .../compress_extra.dts}                       |   0
 .../compress_image.dts}                       |   0
 .../compress_image_less.dts}                  |   0
 .../compress_section.dts}                     |   0
 .../compress_section_size.dts}                |   0
 .../test/{096_elf.dts => entry/elf.dts}       |   0
 .../elf_strip.dts}                            |   0
 .../entry_args.dts}                           |   0
 .../entry_args_missing.dts}                   |   0
 .../entry_args_required.dts}                  |   0
 .../entry_args_unknown_datatype.dts}          |   0
 .../test/{174_env.dts => entry/env.dts}       |   0
 .../env_no_size.dts}                          |   0
 .../env_too_small.dts}                        |   0
 .../test/{084_files.dts => entry/files.dts}   |   0
 .../files_align.dts}                          |   0
 .../files_compress.dts}                       |   0
 .../files_no_pattern.dts}                     |   0
 .../files_none.dts}                           |   0
 .../test/{069_fill.dts => entry/fill.dts}     |   0
 .../fill_empty.dts}                           |   0
 .../fill_no_size.dts}                         |   0
 .../image_entryarg.dts}                       |   0
 .../test/{127_list.dts => entry/list.dts}     |   0
 .../name_prefix.dts}                          |   0
 .../test/{268_null.dts => entry/null.dts}     |   0
 .../offset_from_elf.dts}                      |   0
 .../{269_overlap.dts => entry/overlap.dts}    |   0
 .../overlap_bad.dts}                          |   0
 .../overlap_no_size.dts}                      |   0
 .../overlap_null.dts}                         |   0
 .../prop_test.dts}                            |   0
 .../read_image_skip.dts}                      |   0
 .../remove_template.dts}                      |   0
 .../{132_replace.dts => entry/replace.dts}    |   0
 .../replace_all.dts}                          |   0
 .../replace_multi.dts}                        |   0
 .../replace_repack.dts}                       |   0
 .../replace_section_deep.dts}                 |   0
 .../replace_section_simple.dts}               |   0
 .../replace_with_bintool.dts}                 |   0
 .../section_fname.dts}                        |   0
 .../section_timeout.dts}                      |   0
 .../{055_sections.dts => entry/sections.dts}  |   0
 .../{259_symlink.dts => entry/symlink.dts}    |   0
 .../test/{222_tee_os.dts => entry/tee_os.dts} |   0
 .../tee_os_opt.dts}                           |   0
 .../{286_template.dts => entry/template.dts}  |   0
 .../template_multi.dts}                       |   0
 .../template_phandle.dts}                     |   0
 .../template_phandle_dup.dts}                 |   0
 .../template_section.dts}                     |   0
 .../test/{066_text.dts => entry/text.dts}     |   0
 .../unique_names.dts}                         |   0
 .../unique_names_multi.dts}                   |   0
 .../unknown_contents.dts}                     |   0
 .../unknown_pos_size.dts}                     |   0
 65 files changed, 82 insertions(+), 82 deletions(-)
 rename tools/binman/test/{262_absent.dts => entry/absent.dts} (100%)
 rename tools/binman/test/{198_collection.dts => entry/collection.dts} (100%)
 rename tools/binman/test/{246_collection_other.dts => entry/collection_other.dts} (100%)
 rename tools/binman/test/{199_collection_section.dts => entry/collection_section.dts} (100%)
 rename tools/binman/test/{083_compress.dts => entry/compress.dts} (100%)
 rename tools/binman/test/{186_compress_extra.dts => entry/compress_extra.dts} (100%)
 rename tools/binman/test/{182_compress_image.dts => entry/compress_image.dts} (100%)
 rename tools/binman/test/{183_compress_image_less.dts => entry/compress_image_less.dts} (100%)
 rename tools/binman/test/{185_compress_section.dts => entry/compress_section.dts} (100%)
 rename tools/binman/test/{184_compress_section_size.dts => entry/compress_section_size.dts} (100%)
 rename tools/binman/test/{096_elf.dts => entry/elf.dts} (100%)
 rename tools/binman/test/{097_elf_strip.dts => entry/elf_strip.dts} (100%)
 rename tools/binman/test/{062_entry_args.dts => entry/entry_args.dts} (100%)
 rename tools/binman/test/{063_entry_args_missing.dts => entry/entry_args_missing.dts} (100%)
 rename tools/binman/test/{064_entry_args_required.dts => entry/entry_args_required.dts} (100%)
 rename tools/binman/test/{065_entry_args_unknown_datatype.dts => entry/entry_args_unknown_datatype.dts} (100%)
 rename tools/binman/test/{174_env.dts => entry/env.dts} (100%)
 rename tools/binman/test/{175_env_no_size.dts => entry/env_no_size.dts} (100%)
 rename tools/binman/test/{176_env_too_small.dts => entry/env_too_small.dts} (100%)
 rename tools/binman/test/{084_files.dts => entry/files.dts} (100%)
 rename tools/binman/test/{190_files_align.dts => entry/files_align.dts} (100%)
 rename tools/binman/test/{085_files_compress.dts => entry/files_compress.dts} (100%)
 rename tools/binman/test/{087_files_no_pattern.dts => entry/files_no_pattern.dts} (100%)
 rename tools/binman/test/{086_files_none.dts => entry/files_none.dts} (100%)
 rename tools/binman/test/{069_fill.dts => entry/fill.dts} (100%)
 rename tools/binman/test/{080_fill_empty.dts => entry/fill_empty.dts} (100%)
 rename tools/binman/test/{070_fill_no_size.dts => entry/fill_no_size.dts} (100%)
 rename tools/binman/test/{188_image_entryarg.dts => entry/image_entryarg.dts} (100%)
 rename tools/binman/test/{127_list.dts => entry/list.dts} (100%)
 rename tools/binman/test/{056_name_prefix.dts => entry/name_prefix.dts} (100%)
 rename tools/binman/test/{268_null.dts => entry/null.dts} (100%)
 rename tools/binman/test/{274_offset_from_elf.dts => entry/offset_from_elf.dts} (100%)
 rename tools/binman/test/{269_overlap.dts => entry/overlap.dts} (100%)
 rename tools/binman/test/{271_overlap_bad.dts => entry/overlap_bad.dts} (100%)
 rename tools/binman/test/{272_overlap_no_size.dts => entry/overlap_no_size.dts} (100%)
 rename tools/binman/test/{270_overlap_null.dts => entry/overlap_null.dts} (100%)
 rename tools/binman/test/{045_prop_test.dts => entry/prop_test.dts} (100%)
 rename tools/binman/test/{191_read_image_skip.dts => entry/read_image_skip.dts} (100%)
 rename tools/binman/test/{346_remove_template.dts => entry/remove_template.dts} (100%)
 rename tools/binman/test/{132_replace.dts => entry/replace.dts} (100%)
 rename tools/binman/test/{143_replace_all.dts => entry/replace_all.dts} (100%)
 rename tools/binman/test/{133_replace_multi.dts => entry/replace_multi.dts} (100%)
 rename tools/binman/test/{139_replace_repack.dts => entry/replace_repack.dts} (100%)
 rename tools/binman/test/{278_replace_section_deep.dts => entry/replace_section_deep.dts} (100%)
 rename tools/binman/test/{241_replace_section_simple.dts => entry/replace_section_simple.dts} (100%)
 rename tools/binman/test/{239_replace_with_bintool.dts => entry/replace_with_bintool.dts} (100%)
 rename tools/binman/test/{261_section_fname.dts => entry/section_fname.dts} (100%)
 rename tools/binman/test/{202_section_timeout.dts => entry/section_timeout.dts} (100%)
 rename tools/binman/test/{055_sections.dts => entry/sections.dts} (100%)
 rename tools/binman/test/{259_symlink.dts => entry/symlink.dts} (100%)
 rename tools/binman/test/{222_tee_os.dts => entry/tee_os.dts} (100%)
 rename tools/binman/test/{263_tee_os_opt.dts => entry/tee_os_opt.dts} (100%)
 rename tools/binman/test/{286_template.dts => entry/template.dts} (100%)
 rename tools/binman/test/{287_template_multi.dts => entry/template_multi.dts} (100%)
 rename tools/binman/test/{309_template_phandle.dts => entry/template_phandle.dts} (100%)
 rename tools/binman/test/{310_template_phandle_dup.dts => entry/template_phandle_dup.dts} (100%)
 rename tools/binman/test/{289_template_section.dts => entry/template_section.dts} (100%)
 rename tools/binman/test/{066_text.dts => entry/text.dts} (100%)
 rename tools/binman/test/{237_unique_names.dts => entry/unique_names.dts} (100%)
 rename tools/binman/test/{238_unique_names_multi.dts => entry/unique_names_multi.dts} (100%)
 rename tools/binman/test/{057_unknown_contents.dts => entry/unknown_contents.dts} (100%)
 rename tools/binman/test/{041_unknown_pos_size.dts => entry/unknown_pos_size.dts} (100%)

diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
index 2bdb7756465..78b02e6f435 100644
--- a/doc/develop/binman_tests.rst
+++ b/doc/develop/binman_tests.rst
@@ -402,7 +402,7 @@ Another type of test is one which checks error-handling, for example:
     def testFillNoSize(self):
         """Test for an fill entry type with no size"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('070_fill_no_size.dts')
+            self._DoReadFile('entry/fill_no_size.dts')
         self.assertIn("'fill' entry is missing properties: size",
                       str(e.exception))
 
diff --git a/tools/binman/fdt_test.py b/tools/binman/fdt_test.py
index ef659c0f276..ef81a3262d2 100644
--- a/tools/binman/fdt_test.py
+++ b/tools/binman/fdt_test.py
@@ -41,7 +41,7 @@ class TestFdt(unittest.TestCase):
         self._DeleteProp(dt)
 
     def testFdtNormalProp(self):
-        fname = self.GetCompiled('045_prop_test.dts')
+        fname = self.GetCompiled('entry/prop_test.dts')
         dt = FdtScan(fname)
         node = dt.GetNode('/binman/intel-me')
         self.assertEqual('intel-me', node.name)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 0ca4d935dae..0f1a799821d 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -1431,7 +1431,7 @@ class TestFunctional(unittest.TestCase):
     def testUnknownPosSize(self):
         """Test that microcode must be placed within the image"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('041_unknown_pos_size.dts', True)
+            self._DoReadFile('entry/unknown_pos_size.dts', True)
         self.assertIn("Section '/binman': Unable to set offset/size for unknown "
                 "entry 'invalid-entry'", str(e.exception))
 
@@ -1626,7 +1626,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSections(self):
         """Basic test of sections"""
-        data = self._DoReadFile('055_sections.dts')
+        data = self._DoReadFile('entry/sections.dts')
         expected = (U_BOOT_DATA + tools.get_bytes(ord('!'), 12) +
                     U_BOOT_DATA + tools.get_bytes(ord('a'), 12) +
                     U_BOOT_DATA + tools.get_bytes(ord('&'), 4))
@@ -1634,7 +1634,7 @@ class TestFunctional(unittest.TestCase):
 
     def testMap(self):
         """Tests outputting a map of the images"""
-        _, _, map_data, _ = self._DoReadFileDtb('055_sections.dts', map=True)
+        _, _, map_data, _ = self._DoReadFileDtb('entry/sections.dts', map=True)
         self.assertEqual('''ImagePos    Offset      Size  Name
 00000000  00000000  00000028  image
 00000000   00000000  00000010  section@0
@@ -1647,7 +1647,7 @@ class TestFunctional(unittest.TestCase):
 
     def testNamePrefix(self):
         """Tests that name prefixes are used"""
-        _, _, map_data, _ = self._DoReadFileDtb('056_name_prefix.dts', map=True)
+        _, _, map_data, _ = self._DoReadFileDtb('entry/name_prefix.dts', map=True)
         self.assertEqual('''ImagePos    Offset      Size  Name
 00000000  00000000  00000028  image
 00000000   00000000  00000010  section@0
@@ -1659,7 +1659,7 @@ class TestFunctional(unittest.TestCase):
     def testUnknownContents(self):
         """Test that obtaining the contents works as expected"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('057_unknown_contents.dts', True)
+            self._DoReadFile('entry/unknown_contents.dts', True)
         self.assertIn("Image '/binman': Internal error: Could not complete "
                 "processing of contents: remaining ["
                 "<binman.etype._testing.Entry__testing ", str(e.exception))
@@ -1718,7 +1718,7 @@ class TestFunctional(unittest.TestCase):
             'test-str-arg': 'test1',
             'test-int-arg': '456',
         }
-        self._DoReadFileDtb('062_entry_args.dts', entry_args=entry_args)
+        self._DoReadFileDtb('entry/entry_args.dts', entry_args=entry_args)
         self.assertIn('image', control.images)
         entry = control.images['image'].GetEntries()['_testing']
         self.assertEqual('test0', entry.test_str_fdt)
@@ -1731,7 +1731,7 @@ class TestFunctional(unittest.TestCase):
         entry_args = {
             'test-int-arg': '456',
         }
-        self._DoReadFileDtb('063_entry_args_missing.dts', entry_args=entry_args)
+        self._DoReadFileDtb('entry/entry_args_missing.dts', entry_args=entry_args)
         entry = control.images['image'].GetEntries()['_testing']
         self.assertEqual('test0', entry.test_str_fdt)
         self.assertEqual(None, entry.test_str_arg)
@@ -1744,7 +1744,7 @@ class TestFunctional(unittest.TestCase):
             'test-int-arg': '456',
         }
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('064_entry_args_required.dts')
+            self._DoReadFileDtb('entry/entry_args_required.dts')
         self.assertIn("Node '/binman/_testing': "
             'Missing required properties/entry args: test-str-arg, '
             'test-int-fdt, test-int-arg',
@@ -1752,7 +1752,7 @@ class TestFunctional(unittest.TestCase):
 
     def testEntryArgsInvalidFormat(self):
         """Test that an invalid entry-argument format is detected"""
-        args = ['build', '-d', self.TestFile('064_entry_args_required.dts'),
+        args = ['build', '-d', self.TestFile('entry/entry_args_required.dts'),
                 '-ano-value']
         with self.assertRaises(ValueError) as e:
             self._DoBinman(*args)
@@ -1764,7 +1764,7 @@ class TestFunctional(unittest.TestCase):
             'test-int-arg': 'abc',
         }
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('062_entry_args.dts', entry_args=entry_args)
+            self._DoReadFileDtb('entry/entry_args.dts', entry_args=entry_args)
         self.assertIn("Node '/binman/_testing': Cannot convert entry arg "
                       "'test-int-arg' (value 'abc') to integer",
             str(e.exception))
@@ -1780,7 +1780,7 @@ class TestFunctional(unittest.TestCase):
             'test-bad-datatype-arg': '12',
         }
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('065_entry_args_unknown_datatype.dts',
+            self._DoReadFileDtb('entry/entry_args_unknown_datatype.dts',
                                 entry_args=entry_args)
         self.assertIn('GetArg() internal error: Unknown data type ',
                       str(e.exception))
@@ -1792,7 +1792,7 @@ class TestFunctional(unittest.TestCase):
             'test-id2': TEXT_DATA2,
             'test-id3': TEXT_DATA3,
         }
-        data, _, _, _ = self._DoReadFileDtb('066_text.dts',
+        data, _, _, _ = self._DoReadFileDtb('entry/text.dts',
                                             entry_args=entry_args)
         expected = (tools.to_bytes(TEXT_DATA) +
                     tools.get_bytes(0, 8 - len(TEXT_DATA)) +
@@ -1870,14 +1870,14 @@ class TestFunctional(unittest.TestCase):
 
     def testFill(self):
         """Test for an fill entry type"""
-        data = self._DoReadFile('069_fill.dts')
+        data = self._DoReadFile('entry/fill.dts')
         expected = tools.get_bytes(0xff, 8) + tools.get_bytes(0, 8)
         self.assertEqual(expected, data)
 
     def testFillNoSize(self):
         """Test for an fill entry type with no size"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('070_fill_no_size.dts')
+            self._DoReadFile('entry/fill_no_size.dts')
         self.assertIn("'fill' entry is missing properties: size",
                       str(e.exception))
 
@@ -2043,13 +2043,13 @@ class TestFunctional(unittest.TestCase):
 
     def testFillZero(self):
         """Test for an fill entry type with a size of 0"""
-        data = self._DoReadFile('080_fill_empty.dts')
+        data = self._DoReadFile('entry/fill_empty.dts')
         self.assertEqual(tools.get_bytes(0, 16), data)
 
     def testTextMissing(self):
         """Test for a text entry type where there is no text"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('066_text.dts',)
+            self._DoReadFileDtb('entry/text.dts',)
         self.assertIn("Node '/binman/text': No value provided for text label "
                       "'test-id'", str(e.exception))
 
@@ -2162,7 +2162,7 @@ class TestFunctional(unittest.TestCase):
     def testCompress(self):
         """Test compression of blobs"""
         self._CheckLz4()
-        data, _, _, out_dtb_fname = self._DoReadFileDtb('083_compress.dts',
+        data, _, _, out_dtb_fname = self._DoReadFileDtb('entry/compress.dts',
                                             use_real_dtb=True, update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
@@ -2192,13 +2192,13 @@ class TestFunctional(unittest.TestCase):
 
     def testFiles(self):
         """Test bringing in multiple files"""
-        data = self._DoReadFile('084_files.dts')
+        data = self._DoReadFile('entry/files.dts')
         self.assertEqual(FILES_DATA, data)
 
     def testFilesCompress(self):
         """Test bringing in multiple files and compressing them"""
         self._CheckLz4()
-        data = self._DoReadFile('085_files_compress.dts')
+        data = self._DoReadFile('entry/files_compress.dts')
 
         image = control.images['image']
         entries = image.GetEntries()
@@ -2218,14 +2218,14 @@ class TestFunctional(unittest.TestCase):
     def testFilesMissing(self):
         """Test missing files"""
         with self.assertRaises(ValueError) as e:
-            data = self._DoReadFile('086_files_none.dts')
+            data = self._DoReadFile('entry/files_none.dts')
         self.assertIn("Node '/binman/files': Pattern \'files/*.none\' matched "
                       'no files', str(e.exception))
 
     def testFilesNoPattern(self):
         """Test missing files"""
         with self.assertRaises(ValueError) as e:
-            data = self._DoReadFile('087_files_no_pattern.dts')
+            data = self._DoReadFile('entry/files_no_pattern.dts')
         self.assertIn("Node '/binman/files': Missing 'pattern' property",
                       str(e.exception))
 
@@ -2371,14 +2371,14 @@ class TestFunctional(unittest.TestCase):
         self._SetupTplElf()
         with open(self.ElfTestFile('bss_data'), 'rb') as fd:
             TestFunctional._MakeInputFile('-boot', fd.read())
-        data = self._DoReadFile('096_elf.dts')
+        data = self._DoReadFile('entry/elf.dts')
 
     def testElfStrip(self):
         """Basic test of ELF entries"""
         self._SetupSplElf()
         with open(self.ElfTestFile('bss_data'), 'rb') as fd:
             TestFunctional._MakeInputFile('-boot', fd.read())
-        data = self._DoReadFile('097_elf_strip.dts')
+        data = self._DoReadFile('entry/elf_strip.dts')
 
     def testPackOverlapMap(self):
         """Test that overlapping regions are detected"""
@@ -2761,7 +2761,7 @@ class TestFunctional(unittest.TestCase):
     def testList(self):
         """Test listing the files in an image"""
         self._CheckLz4()
-        data = self._DoReadFile('127_list.dts')
+        data = self._DoReadFile('entry/list.dts')
         image = control.images['image']
         entries = image.BuildEntryList()
         self.assertEqual(7, len(entries))
@@ -3300,7 +3300,7 @@ class TestFunctional(unittest.TestCase):
         self.assertEqual(len(U_BOOT_DATA), entry.size)
 
     def _RunReplaceCmd(self, entry_name, data, decomp=True, allow_resize=True,
-                       dts='132_replace.dts'):
+                       dts='entry/replace.dts'):
         """Replace an entry in an image
 
         This writes the entry data to update it, then opens the updated file and
@@ -3377,13 +3377,13 @@ class TestFunctional(unittest.TestCase):
         expected = U_BOOT_DATA + b'x'
         with self.assertRaises(ValueError) as e:
             self._RunReplaceCmd('u-boot', expected, allow_resize=False,
-                                dts='139_replace_repack.dts')
+                                dts='entry/replace_repack.dts')
         self.assertIn("Node '/u-boot': Entry data size does not match, but resize is disabled",
                       str(e.exception))
 
     def testReplaceMulti(self):
         """Test replacing entry data where multiple images are generated"""
-        data = self._DoReadFileDtb('133_replace_multi.dts', use_real_dtb=True,
+        data = self._DoReadFileDtb('entry/replace_multi.dts', use_real_dtb=True,
                                    update_dtb=True)[0]
         expected = b'x' * len(U_BOOT_DATA)
         updated_fname = tools.get_output_filename('image-updated.bin')
@@ -3502,7 +3502,7 @@ class TestFunctional(unittest.TestCase):
         """Test replacing a single file in an entry with a larger file"""
         expected = U_BOOT_DATA + b'x'
         data, _, image = self._RunReplaceCmd('u-boot', expected,
-                                             dts='139_replace_repack.dts')
+                                             dts='entry/replace_repack.dts')
         self.assertEqual(expected, data)
 
         entries = image.GetEntries()
@@ -3599,7 +3599,7 @@ class TestFunctional(unittest.TestCase):
                 Output directory
                 Expected values for updated entries, each a string
         """
-        data = self._DoReadFileRealDtb('143_replace_all.dts')
+        data = self._DoReadFileRealDtb('entry/replace_all.dts')
 
         updated_fname = tools.get_output_filename('image-updated.bin')
         tools.write_file(updated_fname, data)
@@ -3686,7 +3686,7 @@ class TestFunctional(unittest.TestCase):
 
     def testReplaceCmd(self):
         """Test replacing a file fron an image on the command line"""
-        self._DoReadFileRealDtb('143_replace_all.dts')
+        self._DoReadFileRealDtb('entry/replace_all.dts')
 
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
@@ -3742,7 +3742,7 @@ class TestFunctional(unittest.TestCase):
 
     def testReplaceCmdMap(self):
         """Test replacing a file fron an image on the command line"""
-        self._DoReadFileRealDtb('143_replace_all.dts')
+        self._DoReadFileRealDtb('entry/replace_all.dts')
 
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
@@ -3760,7 +3760,7 @@ class TestFunctional(unittest.TestCase):
 
     def testReplaceNoEntryPaths(self):
         """Test replacing an entry without an entry path"""
-        self._DoReadFileRealDtb('143_replace_all.dts')
+        self._DoReadFileRealDtb('entry/replace_all.dts')
         image_fname = tools.get_output_filename('image.bin')
         with self.assertRaises(ValueError) as e:
             control.ReplaceEntries(image_fname, 'fname', None, [])
@@ -3769,7 +3769,7 @@ class TestFunctional(unittest.TestCase):
 
     def testReplaceTooManyEntryPaths(self):
         """Test extracting some entries"""
-        self._DoReadFileRealDtb('143_replace_all.dts')
+        self._DoReadFileRealDtb('entry/replace_all.dts')
         image_fname = tools.get_output_filename('image.bin')
         with self.assertRaises(ValueError) as e:
             control.ReplaceEntries(image_fname, 'fname', None, ['a', 'b'])
@@ -4421,7 +4421,7 @@ class TestFunctional(unittest.TestCase):
 
     def testEnvironment(self):
         """Test adding a U-Boot environment"""
-        data = self._DoReadFile('174_env.dts')
+        data = self._DoReadFile('entry/env.dts')
         self.assertEqual(U_BOOT_DATA, data[:len(U_BOOT_DATA)])
         self.assertEqual(U_BOOT_NODTB_DATA, data[-len(U_BOOT_NODTB_DATA):])
         env = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
@@ -4431,14 +4431,14 @@ class TestFunctional(unittest.TestCase):
     def testEnvironmentNoSize(self):
         """Test that a missing 'size' property is detected"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('175_env_no_size.dts')
+            self._DoTestFile('entry/env_no_size.dts')
         self.assertIn("'u-boot-env' entry must have a size property",
                       str(e.exception))
 
     def testEnvironmentTooSmall(self):
         """Test handling of an environment that does not fit"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('176_env_too_small.dts')
+            self._DoTestFile('entry/env_too_small.dts')
 
         # checksum, start byte, environment with \0 terminator, final \0
         need = 4 + 1 + len(ENV_DATA) + 1 + 1
@@ -4530,7 +4530,7 @@ class TestFunctional(unittest.TestCase):
         """Test compression of the entire image"""
         self._CheckLz4()
         data, _, _, out_dtb_fname = self._DoReadFileDtb(
-            '182_compress_image.dts', use_real_dtb=True, update_dtb=True)
+            'entry/compress_image.dts', use_real_dtb=True, update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
         props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
@@ -4573,7 +4573,7 @@ class TestFunctional(unittest.TestCase):
         """Test compression where compression reduces the image size"""
         self._CheckLz4()
         data, _, _, out_dtb_fname = self._DoReadFileDtb(
-            '183_compress_image_less.dts', use_real_dtb=True, update_dtb=True)
+            'entry/compress_image_less.dts', use_real_dtb=True, update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
         props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
@@ -4618,7 +4618,7 @@ class TestFunctional(unittest.TestCase):
         """Test compression of a section with a fixed size"""
         self._CheckLz4()
         data, _, _, out_dtb_fname = self._DoReadFileDtb(
-            '184_compress_section_size.dts', use_real_dtb=True, update_dtb=True)
+            'entry/compress_section_size.dts', use_real_dtb=True, update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
         props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
@@ -4646,7 +4646,7 @@ class TestFunctional(unittest.TestCase):
         """Test compression of a section with no fixed size"""
         self._CheckLz4()
         data, _, _, out_dtb_fname = self._DoReadFileDtb(
-            '185_compress_section.dts', use_real_dtb=True, update_dtb=True)
+            'entry/compress_section.dts', use_real_dtb=True, update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
         props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
@@ -4671,7 +4671,7 @@ class TestFunctional(unittest.TestCase):
     def testLz4Missing(self):
         """Test that binman still produces an image if lz4 is missing"""
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('185_compress_section.dts',
+            self._DoTestFile('entry/compress_section.dts',
                              force_missing_bintools='lz4')
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing bintools.*: lz4")
@@ -4680,7 +4680,7 @@ class TestFunctional(unittest.TestCase):
         """Test compression of a section with no fixed size"""
         self._CheckLz4()
         data, _, _, out_dtb_fname = self._DoReadFileDtb(
-            '186_compress_extra.dts', use_real_dtb=True, update_dtb=True)
+            'entry/compress_extra.dts', use_real_dtb=True, update_dtb=True)
         dtb = fdt.Fdt(out_dtb_fname)
         dtb.Scan()
         props = self._GetPropTree(dtb, ['offset', 'image-pos', 'size',
@@ -4764,7 +4764,7 @@ class TestFunctional(unittest.TestCase):
             'cros-ec-rw-path': 'ecrw.bin',
         }
         data = self.data = self._DoReadFileDtb(
-            '188_image_entryarg.dts',use_real_dtb=True, update_dtb=True,
+            'entry/image_entryarg.dts',use_real_dtb=True, update_dtb=True,
             entry_args=entry_args)
 
         image_fname = tools.get_output_filename('image.bin')
@@ -4779,7 +4779,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFilesAlign(self):
         """Test alignment with files"""
-        data = self._DoReadFile('190_files_align.dts')
+        data = self._DoReadFile('entry/files_align.dts')
 
         # The first string is 15 bytes so will align to 16
         expect = FILES_DATA[:15] + b'\0' + FILES_DATA[15:]
@@ -4787,7 +4787,7 @@ class TestFunctional(unittest.TestCase):
 
     def testReadImageSkip(self):
         """Test reading an image and accessing its FDT map"""
-        data = self.data = self._DoReadFileRealDtb('191_read_image_skip.dts')
+        data = self.data = self._DoReadFileRealDtb('entry/read_image_skip.dts')
         image_fname = tools.get_output_filename('image.bin')
         orig_image = control.images['image']
         image = Image.FromFile(image_fname)
@@ -5013,7 +5013,7 @@ class TestFunctional(unittest.TestCase):
 
     def testCollection(self):
         """Test a collection"""
-        data = self._DoReadFile('198_collection.dts')
+        data = self._DoReadFile('entry/collection.dts')
         self.assertEqual(U_BOOT_NODTB_DATA + U_BOOT_DTB_DATA +
                          tools.get_bytes(0xff, 2) + U_BOOT_NODTB_DATA +
                          tools.get_bytes(0xfe, 3) + U_BOOT_DTB_DATA,
@@ -5025,7 +5025,7 @@ class TestFunctional(unittest.TestCase):
         # BuildSectionData() is called with required=True, a section will force
         # building the contents, producing an error is anything is still
         # missing.
-        data = self._DoReadFile('199_collection_section.dts')
+        data = self._DoReadFile('entry/collection_section.dts')
         section = U_BOOT_NODTB_DATA + U_BOOT_DTB_DATA
         self.assertEqual(section + U_BOOT_DATA + tools.get_bytes(0xff, 2) +
                          section + tools.get_bytes(0xfe, 3) + U_BOOT_DATA,
@@ -5051,7 +5051,7 @@ class TestFunctional(unittest.TestCase):
 
     def testSectionsSingleThread(self):
         """Test sections without multithreading"""
-        data = self._DoReadFileDtb('055_sections.dts', threads=0)[0]
+        data = self._DoReadFileDtb('entry/sections.dts', threads=0)[0]
         expected = (U_BOOT_DATA + tools.get_bytes(ord('!'), 12) +
                     U_BOOT_DATA + tools.get_bytes(ord('a'), 12) +
                     U_BOOT_DATA + tools.get_bytes(ord('&'), 4))
@@ -5060,13 +5060,13 @@ class TestFunctional(unittest.TestCase):
     def testThreadTimeout(self):
         """Test handling a thread that takes too long"""
         with self.assertRaises(ValueError) as e:
-            self._DoTestFile('202_section_timeout.dts',
+            self._DoTestFile('entry/section_timeout.dts',
                              test_section_timeout=True)
         self.assertIn("Timed out obtaining contents", str(e.exception))
 
     def testTiming(self):
         """Test output of timing information"""
-        data = self._DoReadFile('055_sections.dts')
+        data = self._DoReadFile('entry/sections.dts')
         with terminal.capture() as (stdout, stderr):
             state.TimingShow()
         self.assertIn('read:', stdout.getvalue())
@@ -5573,7 +5573,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testPackTeeOs(self):
         """Test that an image with an TEE binary can be created"""
-        data = self._DoReadFile('222_tee_os.dts')
+        data = self._DoReadFile('entry/tee_os.dts')
         self.assertEqual(TEE_OS_DATA, data[:len(TEE_OS_DATA)])
 
     def testPackTiDm(self):
@@ -5907,7 +5907,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testSafeUniqueNames(self):
         """Test entry unique names are safe in single image configuration"""
-        data = self._DoReadFileRealDtb('237_unique_names.dts')
+        data = self._DoReadFileRealDtb('entry/unique_names.dts')
 
         orig_image = control.images['image']
         image_fname = tools.get_output_filename('image.bin')
@@ -5917,7 +5917,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testSafeUniqueNamesMulti(self):
         """Test entry unique names are safe with multiple images"""
-        data = self._DoReadFileRealDtb('238_unique_names_multi.dts')
+        data = self._DoReadFileRealDtb('entry/unique_names_multi.dts')
 
         orig_image = control.images['image']
         image_fname = tools.get_output_filename('image.bin')
@@ -5927,7 +5927,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testReplaceCmdWithBintool(self):
         """Test replacing an entry that needs a bintool to pack"""
-        data = self._DoReadFileRealDtb('239_replace_with_bintool.dts')
+        data = self._DoReadFileRealDtb('entry/replace_with_bintool.dts')
         expected = U_BOOT_DATA + b'aa'
         self.assertEqual(expected, data[:len(expected)])
 
@@ -5946,7 +5946,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testReplaceCmdOtherWithBintool(self):
         """Test replacing an entry when another needs a bintool to pack"""
-        data = self._DoReadFileRealDtb('239_replace_with_bintool.dts')
+        data = self._DoReadFileRealDtb('entry/replace_with_bintool.dts')
         expected = U_BOOT_DATA + b'aa'
         self.assertEqual(expected, data[:len(expected)])
 
@@ -6061,7 +6061,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test replacing a simple section with same-sized data"""
         new_data = b'w' * len(COMPRESS_DATA + U_BOOT_DATA)
         data, expected_fdtmap, image = self._RunReplaceCmd('section',
-            new_data, dts='241_replace_section_simple.dts')
+            new_data, dts='entry/replace_section_simple.dts')
         self.assertEqual(new_data, data)
 
         entries = image.GetEntries()
@@ -6073,7 +6073,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test replacing a simple section with larger data"""
         new_data = b'w' * (len(COMPRESS_DATA + U_BOOT_DATA) + 1)
         data, expected_fdtmap, image = self._RunReplaceCmd('section',
-            new_data, dts='241_replace_section_simple.dts')
+            new_data, dts='entry/replace_section_simple.dts')
         self.assertEqual(new_data, data)
 
         entries = image.GetEntries()
@@ -6087,7 +6087,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test replacing a simple section with smaller data"""
         new_data = b'w' * (len(COMPRESS_DATA + U_BOOT_DATA) - 1) + b'\0'
         data, expected_fdtmap, image = self._RunReplaceCmd('section',
-            new_data, dts='241_replace_section_simple.dts')
+            new_data, dts='entry/replace_section_simple.dts')
         self.assertEqual(new_data, data)
 
         # The new size is the same as the old, just with a pad byte at the end
@@ -6103,7 +6103,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             state.SetAllowEntryContraction(True)
             with self.assertRaises(ValueError) as exc:
                 self._RunReplaceCmd('section', new_data,
-                                    dts='241_replace_section_simple.dts')
+                                    dts='entry/replace_section_simple.dts')
         finally:
             state.SetAllowEntryContraction(False)
 
@@ -6172,7 +6172,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testCollectionOther(self):
         """Test a collection where the data comes from another section"""
-        data = self._DoReadFile('246_collection_other.dts')
+        data = self._DoReadFile('entry/collection_other.dts')
         self.assertEqual(U_BOOT_NODTB_DATA + U_BOOT_DTB_DATA +
                          tools.get_bytes(0xff, 2) + U_BOOT_NODTB_DATA +
                          tools.get_bytes(0xfe, 3) + U_BOOT_DTB_DATA,
@@ -6380,7 +6380,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testSymlink(self):
         """Test that image files can be symlinked"""
-        retcode = self._DoTestFile('259_symlink.dts', debug=True, map=True)
+        retcode = self._DoTestFile('entry/symlink.dts', debug=True, map=True)
         self.assertEqual(0, retcode)
         image = control.images['test_image']
         fname = tools.get_output_filename('test_image.bin')
@@ -6391,9 +6391,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testSymlinkOverwrite(self):
         """Test that symlinked images can be overwritten"""
         testdir = TestFunctional._MakeInputDir('symlinktest')
-        self._DoTestFile('259_symlink.dts', debug=True, map=True, output_dir=testdir)
+        self._DoTestFile('entry/symlink.dts', debug=True, map=True, output_dir=testdir)
         # build the same image again in the same directory so that existing symlink is present
-        self._DoTestFile('259_symlink.dts', debug=True, map=True, output_dir=testdir)
+        self._DoTestFile('entry/symlink.dts', debug=True, map=True, output_dir=testdir)
         fname = tools.get_output_filename('test_image.bin')
         sname = tools.get_output_filename('symlink_to_test.bin')
         self.assertTrue(os.path.islink(sname))
@@ -6459,7 +6459,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testSectionFilename(self):
         """Check writing of section contents to a file"""
-        data = self._DoReadFile('261_section_fname.dts')
+        data = self._DoReadFile('entry/section_fname.dts')
         expected = (b'&&' + U_BOOT_DATA + b'&&&' +
                     tools.get_bytes(ord('!'), 7) +
                     U_BOOT_DATA + tools.get_bytes(ord('&'), 12))
@@ -6472,7 +6472,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testAbsent(self):
         """Check handling of absent entries"""
-        data = self._DoReadFile('262_absent.dts')
+        data = self._DoReadFile('entry/absent.dts')
         self.assertEqual(U_BOOT_DATA + b'aa' + U_BOOT_IMG_DATA, data)
 
     def testPackTeeOsElf(self):
@@ -6481,7 +6481,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'tee-os-path': 'tee.elf',
         }
         tee_path = self.tee_elf_path
-        data = self._DoReadFileDtb('263_tee_os_opt.dts',
+        data = self._DoReadFileDtb('entry/tee_os_opt.dts',
                                    entry_args=entry_args)[0]
         self.assertEqual(U_BOOT_DATA + tools.read_file(tee_path) +
                          U_BOOT_IMG_DATA, data)
@@ -6586,12 +6586,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testNull(self):
         """Test an image with a null entry"""
-        data = self._DoReadFile('268_null.dts')
+        data = self._DoReadFile('entry/null.dts')
         self.assertEqual(U_BOOT_DATA + b'\xff\xff\xff\xff' + U_BOOT_IMG_DATA, data)
 
     def testOverlap(self):
         """Test an image with a overlapping entry"""
-        data = self._DoReadFile('269_overlap.dts')
+        data = self._DoReadFile('entry/overlap.dts')
         self.assertEqual(U_BOOT_DATA[:1] + b'aa' + U_BOOT_DATA[3:], data)
 
         image = control.images['image']
@@ -6605,7 +6605,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testOverlapNull(self):
         """Test an image with a null overlap"""
-        data = self._DoReadFile('270_overlap_null.dts')
+        data = self._DoReadFile('entry/overlap_null.dts')
         self.assertEqual(U_BOOT_DATA, data[:len(U_BOOT_DATA)])
 
         # Check the FMAP
@@ -6639,7 +6639,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testOverlapBad(self):
         """Test an image with a bad overlapping entry"""
         with self.assertRaises(ValueError) as exc:
-            self._DoReadFile('271_overlap_bad.dts')
+            self._DoReadFile('entry/overlap_bad.dts')
         self.assertIn(
             "Node '/binman/inset': Offset 0x10 (16) ending at 0x12 (18) must overlap with existing entries",
             str(exc.exception))
@@ -6647,7 +6647,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testOverlapNoOffset(self):
         """Test an image with a bad overlapping entry"""
         with self.assertRaises(ValueError) as exc:
-            self._DoReadFile('272_overlap_no_size.dts')
+            self._DoReadFile('entry/overlap_no_size.dts')
         self.assertIn(
             "Node '/binman/inset': 'fill' entry is missing properties: size",
             str(exc.exception))
@@ -6678,7 +6678,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         TestFunctional._MakeInputFile('blob_syms.bin',
             tools.read_file(self.ElfTestFile('blob_syms.bin')))
 
-        data = self._DoReadFile('274_offset_from_elf.dts')
+        data = self._DoReadFile('entry/offset_from_elf.dts')
 
         syms = elf.GetSymbols(elf_fname, ['binman', 'image'])
         base = elf.GetSymbolAddress(elf_fname, '__my_start_sym')
@@ -6781,7 +6781,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test replacing an entry in a section"""
         expect_data = b'w' * len(U_BOOT_DATA + COMPRESS_DATA)
         entry_data, expected_fdtmap, image = self._RunReplaceCmd('section/blob',
-            expect_data, dts='241_replace_section_simple.dts')
+            expect_data, dts='entry/replace_section_simple.dts')
         self.assertEqual(expect_data, entry_data)
 
         entries = image.GetEntries()
@@ -6808,7 +6808,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         expect_data = b'w' * len(U_BOOT_DATA + COMPRESS_DATA)
         entry_data, expected_fdtmap, image = self._RunReplaceCmd(
             'section/section/blob', expect_data,
-            dts='278_replace_section_deep.dts')
+            dts='entry/replace_section_deep.dts')
         self.assertEqual(expect_data, entry_data)
 
         entries = image.GetEntries()
@@ -7034,7 +7034,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testTemplate(self):
         """Test using a template"""
         TestFunctional._MakeInputFile('vga2.bin', b'#' + VGA_DATA)
-        data = self._DoReadFile('286_template.dts')
+        data = self._DoReadFile('entry/template.dts')
         first = U_BOOT_DATA + VGA_DATA + U_BOOT_DTB_DATA
         second = U_BOOT_DATA + b'#' + VGA_DATA + U_BOOT_DTB_DATA
         self.assertEqual(U_BOOT_IMG_DATA + first + second, data)
@@ -7059,7 +7059,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test using a template with 'multiple-images' enabled"""
         TestFunctional._MakeInputFile('my-blob.bin', b'blob')
         TestFunctional._MakeInputFile('my-blob2.bin', b'other')
-        retcode = self._DoTestFile('287_template_multi.dts')
+        retcode = self._DoTestFile('entry/template_multi.dts')
 
         self.assertEqual(0, retcode)
         image = control.images['image']
@@ -7077,7 +7077,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testTemplateSection(self):
         """Test using a template in a section (not at top level)"""
         TestFunctional._MakeInputFile('vga2.bin', b'#' + VGA_DATA)
-        data = self._DoReadFile('289_template_section.dts')
+        data = self._DoReadFile('entry/template_section.dts')
         first = U_BOOT_DATA + VGA_DATA + U_BOOT_DTB_DATA
         second = U_BOOT_DATA + b'#' + VGA_DATA + U_BOOT_DTB_DATA
         self.assertEqual(U_BOOT_IMG_DATA + first + second + first, data)
@@ -7151,7 +7151,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'atf-bl31-path': 'bl31.elf',
         }
-        data = self._DoReadFileDtb('309_template_phandle.dts',
+        data = self._DoReadFileDtb('entry/template_phandle.dts',
                                    entry_args=entry_args)
         fname = tools.get_output_filename('image.bin')
         out = tools.run('dumpimage', '-l', fname)
@@ -7167,7 +7167,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'atf-bl31-path': 'bl31.elf',
         }
         with self.assertRaises(ValueError) as e:
-            self._DoReadFileDtb('310_template_phandle_dup.dts',
+            self._DoReadFileDtb('entry/template_phandle_dup.dts',
                                 entry_args=entry_args)
         self.assertIn(
             'Duplicate phandle 1 in nodes /binman/image/fit/images/atf/atf-bl31 and /binman/image-2/fit/images/atf/atf-bl31',
@@ -8415,7 +8415,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         TestFunctional._MakeInputFile('my-blob.bin', b'blob')
         TestFunctional._MakeInputFile('my-blob2.bin', b'other')
         with terminal.capture() as (_, stderr):
-            self._DoTestFile('346_remove_template.dts',
+            self._DoTestFile('entry/remove_template.dts',
                              force_missing_bintools='openssl',)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'file2'.*missing bintools.*: openssl")
diff --git a/tools/binman/test/262_absent.dts b/tools/binman/test/entry/absent.dts
similarity index 100%
rename from tools/binman/test/262_absent.dts
rename to tools/binman/test/entry/absent.dts
diff --git a/tools/binman/test/198_collection.dts b/tools/binman/test/entry/collection.dts
similarity index 100%
rename from tools/binman/test/198_collection.dts
rename to tools/binman/test/entry/collection.dts
diff --git a/tools/binman/test/246_collection_other.dts b/tools/binman/test/entry/collection_other.dts
similarity index 100%
rename from tools/binman/test/246_collection_other.dts
rename to tools/binman/test/entry/collection_other.dts
diff --git a/tools/binman/test/199_collection_section.dts b/tools/binman/test/entry/collection_section.dts
similarity index 100%
rename from tools/binman/test/199_collection_section.dts
rename to tools/binman/test/entry/collection_section.dts
diff --git a/tools/binman/test/083_compress.dts b/tools/binman/test/entry/compress.dts
similarity index 100%
rename from tools/binman/test/083_compress.dts
rename to tools/binman/test/entry/compress.dts
diff --git a/tools/binman/test/186_compress_extra.dts b/tools/binman/test/entry/compress_extra.dts
similarity index 100%
rename from tools/binman/test/186_compress_extra.dts
rename to tools/binman/test/entry/compress_extra.dts
diff --git a/tools/binman/test/182_compress_image.dts b/tools/binman/test/entry/compress_image.dts
similarity index 100%
rename from tools/binman/test/182_compress_image.dts
rename to tools/binman/test/entry/compress_image.dts
diff --git a/tools/binman/test/183_compress_image_less.dts b/tools/binman/test/entry/compress_image_less.dts
similarity index 100%
rename from tools/binman/test/183_compress_image_less.dts
rename to tools/binman/test/entry/compress_image_less.dts
diff --git a/tools/binman/test/185_compress_section.dts b/tools/binman/test/entry/compress_section.dts
similarity index 100%
rename from tools/binman/test/185_compress_section.dts
rename to tools/binman/test/entry/compress_section.dts
diff --git a/tools/binman/test/184_compress_section_size.dts b/tools/binman/test/entry/compress_section_size.dts
similarity index 100%
rename from tools/binman/test/184_compress_section_size.dts
rename to tools/binman/test/entry/compress_section_size.dts
diff --git a/tools/binman/test/096_elf.dts b/tools/binman/test/entry/elf.dts
similarity index 100%
rename from tools/binman/test/096_elf.dts
rename to tools/binman/test/entry/elf.dts
diff --git a/tools/binman/test/097_elf_strip.dts b/tools/binman/test/entry/elf_strip.dts
similarity index 100%
rename from tools/binman/test/097_elf_strip.dts
rename to tools/binman/test/entry/elf_strip.dts
diff --git a/tools/binman/test/062_entry_args.dts b/tools/binman/test/entry/entry_args.dts
similarity index 100%
rename from tools/binman/test/062_entry_args.dts
rename to tools/binman/test/entry/entry_args.dts
diff --git a/tools/binman/test/063_entry_args_missing.dts b/tools/binman/test/entry/entry_args_missing.dts
similarity index 100%
rename from tools/binman/test/063_entry_args_missing.dts
rename to tools/binman/test/entry/entry_args_missing.dts
diff --git a/tools/binman/test/064_entry_args_required.dts b/tools/binman/test/entry/entry_args_required.dts
similarity index 100%
rename from tools/binman/test/064_entry_args_required.dts
rename to tools/binman/test/entry/entry_args_required.dts
diff --git a/tools/binman/test/065_entry_args_unknown_datatype.dts b/tools/binman/test/entry/entry_args_unknown_datatype.dts
similarity index 100%
rename from tools/binman/test/065_entry_args_unknown_datatype.dts
rename to tools/binman/test/entry/entry_args_unknown_datatype.dts
diff --git a/tools/binman/test/174_env.dts b/tools/binman/test/entry/env.dts
similarity index 100%
rename from tools/binman/test/174_env.dts
rename to tools/binman/test/entry/env.dts
diff --git a/tools/binman/test/175_env_no_size.dts b/tools/binman/test/entry/env_no_size.dts
similarity index 100%
rename from tools/binman/test/175_env_no_size.dts
rename to tools/binman/test/entry/env_no_size.dts
diff --git a/tools/binman/test/176_env_too_small.dts b/tools/binman/test/entry/env_too_small.dts
similarity index 100%
rename from tools/binman/test/176_env_too_small.dts
rename to tools/binman/test/entry/env_too_small.dts
diff --git a/tools/binman/test/084_files.dts b/tools/binman/test/entry/files.dts
similarity index 100%
rename from tools/binman/test/084_files.dts
rename to tools/binman/test/entry/files.dts
diff --git a/tools/binman/test/190_files_align.dts b/tools/binman/test/entry/files_align.dts
similarity index 100%
rename from tools/binman/test/190_files_align.dts
rename to tools/binman/test/entry/files_align.dts
diff --git a/tools/binman/test/085_files_compress.dts b/tools/binman/test/entry/files_compress.dts
similarity index 100%
rename from tools/binman/test/085_files_compress.dts
rename to tools/binman/test/entry/files_compress.dts
diff --git a/tools/binman/test/087_files_no_pattern.dts b/tools/binman/test/entry/files_no_pattern.dts
similarity index 100%
rename from tools/binman/test/087_files_no_pattern.dts
rename to tools/binman/test/entry/files_no_pattern.dts
diff --git a/tools/binman/test/086_files_none.dts b/tools/binman/test/entry/files_none.dts
similarity index 100%
rename from tools/binman/test/086_files_none.dts
rename to tools/binman/test/entry/files_none.dts
diff --git a/tools/binman/test/069_fill.dts b/tools/binman/test/entry/fill.dts
similarity index 100%
rename from tools/binman/test/069_fill.dts
rename to tools/binman/test/entry/fill.dts
diff --git a/tools/binman/test/080_fill_empty.dts b/tools/binman/test/entry/fill_empty.dts
similarity index 100%
rename from tools/binman/test/080_fill_empty.dts
rename to tools/binman/test/entry/fill_empty.dts
diff --git a/tools/binman/test/070_fill_no_size.dts b/tools/binman/test/entry/fill_no_size.dts
similarity index 100%
rename from tools/binman/test/070_fill_no_size.dts
rename to tools/binman/test/entry/fill_no_size.dts
diff --git a/tools/binman/test/188_image_entryarg.dts b/tools/binman/test/entry/image_entryarg.dts
similarity index 100%
rename from tools/binman/test/188_image_entryarg.dts
rename to tools/binman/test/entry/image_entryarg.dts
diff --git a/tools/binman/test/127_list.dts b/tools/binman/test/entry/list.dts
similarity index 100%
rename from tools/binman/test/127_list.dts
rename to tools/binman/test/entry/list.dts
diff --git a/tools/binman/test/056_name_prefix.dts b/tools/binman/test/entry/name_prefix.dts
similarity index 100%
rename from tools/binman/test/056_name_prefix.dts
rename to tools/binman/test/entry/name_prefix.dts
diff --git a/tools/binman/test/268_null.dts b/tools/binman/test/entry/null.dts
similarity index 100%
rename from tools/binman/test/268_null.dts
rename to tools/binman/test/entry/null.dts
diff --git a/tools/binman/test/274_offset_from_elf.dts b/tools/binman/test/entry/offset_from_elf.dts
similarity index 100%
rename from tools/binman/test/274_offset_from_elf.dts
rename to tools/binman/test/entry/offset_from_elf.dts
diff --git a/tools/binman/test/269_overlap.dts b/tools/binman/test/entry/overlap.dts
similarity index 100%
rename from tools/binman/test/269_overlap.dts
rename to tools/binman/test/entry/overlap.dts
diff --git a/tools/binman/test/271_overlap_bad.dts b/tools/binman/test/entry/overlap_bad.dts
similarity index 100%
rename from tools/binman/test/271_overlap_bad.dts
rename to tools/binman/test/entry/overlap_bad.dts
diff --git a/tools/binman/test/272_overlap_no_size.dts b/tools/binman/test/entry/overlap_no_size.dts
similarity index 100%
rename from tools/binman/test/272_overlap_no_size.dts
rename to tools/binman/test/entry/overlap_no_size.dts
diff --git a/tools/binman/test/270_overlap_null.dts b/tools/binman/test/entry/overlap_null.dts
similarity index 100%
rename from tools/binman/test/270_overlap_null.dts
rename to tools/binman/test/entry/overlap_null.dts
diff --git a/tools/binman/test/045_prop_test.dts b/tools/binman/test/entry/prop_test.dts
similarity index 100%
rename from tools/binman/test/045_prop_test.dts
rename to tools/binman/test/entry/prop_test.dts
diff --git a/tools/binman/test/191_read_image_skip.dts b/tools/binman/test/entry/read_image_skip.dts
similarity index 100%
rename from tools/binman/test/191_read_image_skip.dts
rename to tools/binman/test/entry/read_image_skip.dts
diff --git a/tools/binman/test/346_remove_template.dts b/tools/binman/test/entry/remove_template.dts
similarity index 100%
rename from tools/binman/test/346_remove_template.dts
rename to tools/binman/test/entry/remove_template.dts
diff --git a/tools/binman/test/132_replace.dts b/tools/binman/test/entry/replace.dts
similarity index 100%
rename from tools/binman/test/132_replace.dts
rename to tools/binman/test/entry/replace.dts
diff --git a/tools/binman/test/143_replace_all.dts b/tools/binman/test/entry/replace_all.dts
similarity index 100%
rename from tools/binman/test/143_replace_all.dts
rename to tools/binman/test/entry/replace_all.dts
diff --git a/tools/binman/test/133_replace_multi.dts b/tools/binman/test/entry/replace_multi.dts
similarity index 100%
rename from tools/binman/test/133_replace_multi.dts
rename to tools/binman/test/entry/replace_multi.dts
diff --git a/tools/binman/test/139_replace_repack.dts b/tools/binman/test/entry/replace_repack.dts
similarity index 100%
rename from tools/binman/test/139_replace_repack.dts
rename to tools/binman/test/entry/replace_repack.dts
diff --git a/tools/binman/test/278_replace_section_deep.dts b/tools/binman/test/entry/replace_section_deep.dts
similarity index 100%
rename from tools/binman/test/278_replace_section_deep.dts
rename to tools/binman/test/entry/replace_section_deep.dts
diff --git a/tools/binman/test/241_replace_section_simple.dts b/tools/binman/test/entry/replace_section_simple.dts
similarity index 100%
rename from tools/binman/test/241_replace_section_simple.dts
rename to tools/binman/test/entry/replace_section_simple.dts
diff --git a/tools/binman/test/239_replace_with_bintool.dts b/tools/binman/test/entry/replace_with_bintool.dts
similarity index 100%
rename from tools/binman/test/239_replace_with_bintool.dts
rename to tools/binman/test/entry/replace_with_bintool.dts
diff --git a/tools/binman/test/261_section_fname.dts b/tools/binman/test/entry/section_fname.dts
similarity index 100%
rename from tools/binman/test/261_section_fname.dts
rename to tools/binman/test/entry/section_fname.dts
diff --git a/tools/binman/test/202_section_timeout.dts b/tools/binman/test/entry/section_timeout.dts
similarity index 100%
rename from tools/binman/test/202_section_timeout.dts
rename to tools/binman/test/entry/section_timeout.dts
diff --git a/tools/binman/test/055_sections.dts b/tools/binman/test/entry/sections.dts
similarity index 100%
rename from tools/binman/test/055_sections.dts
rename to tools/binman/test/entry/sections.dts
diff --git a/tools/binman/test/259_symlink.dts b/tools/binman/test/entry/symlink.dts
similarity index 100%
rename from tools/binman/test/259_symlink.dts
rename to tools/binman/test/entry/symlink.dts
diff --git a/tools/binman/test/222_tee_os.dts b/tools/binman/test/entry/tee_os.dts
similarity index 100%
rename from tools/binman/test/222_tee_os.dts
rename to tools/binman/test/entry/tee_os.dts
diff --git a/tools/binman/test/263_tee_os_opt.dts b/tools/binman/test/entry/tee_os_opt.dts
similarity index 100%
rename from tools/binman/test/263_tee_os_opt.dts
rename to tools/binman/test/entry/tee_os_opt.dts
diff --git a/tools/binman/test/286_template.dts b/tools/binman/test/entry/template.dts
similarity index 100%
rename from tools/binman/test/286_template.dts
rename to tools/binman/test/entry/template.dts
diff --git a/tools/binman/test/287_template_multi.dts b/tools/binman/test/entry/template_multi.dts
similarity index 100%
rename from tools/binman/test/287_template_multi.dts
rename to tools/binman/test/entry/template_multi.dts
diff --git a/tools/binman/test/309_template_phandle.dts b/tools/binman/test/entry/template_phandle.dts
similarity index 100%
rename from tools/binman/test/309_template_phandle.dts
rename to tools/binman/test/entry/template_phandle.dts
diff --git a/tools/binman/test/310_template_phandle_dup.dts b/tools/binman/test/entry/template_phandle_dup.dts
similarity index 100%
rename from tools/binman/test/310_template_phandle_dup.dts
rename to tools/binman/test/entry/template_phandle_dup.dts
diff --git a/tools/binman/test/289_template_section.dts b/tools/binman/test/entry/template_section.dts
similarity index 100%
rename from tools/binman/test/289_template_section.dts
rename to tools/binman/test/entry/template_section.dts
diff --git a/tools/binman/test/066_text.dts b/tools/binman/test/entry/text.dts
similarity index 100%
rename from tools/binman/test/066_text.dts
rename to tools/binman/test/entry/text.dts
diff --git a/tools/binman/test/237_unique_names.dts b/tools/binman/test/entry/unique_names.dts
similarity index 100%
rename from tools/binman/test/237_unique_names.dts
rename to tools/binman/test/entry/unique_names.dts
diff --git a/tools/binman/test/238_unique_names_multi.dts b/tools/binman/test/entry/unique_names_multi.dts
similarity index 100%
rename from tools/binman/test/238_unique_names_multi.dts
rename to tools/binman/test/entry/unique_names_multi.dts
diff --git a/tools/binman/test/057_unknown_contents.dts b/tools/binman/test/entry/unknown_contents.dts
similarity index 100%
rename from tools/binman/test/057_unknown_contents.dts
rename to tools/binman/test/entry/unknown_contents.dts
diff --git a/tools/binman/test/041_unknown_pos_size.dts b/tools/binman/test/entry/unknown_pos_size.dts
similarity index 100%
rename from tools/binman/test/041_unknown_pos_size.dts
rename to tools/binman/test/entry/unknown_pos_size.dts
-- 
2.43.0

