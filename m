Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7379EC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB1488C29;
	Mon, 26 Aug 2024 21:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RZke+u3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B3E888B78; Mon, 26 Aug 2024 21:12:10 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ECCB88C1C
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39d2ac2a9d9so15580245ab.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699526; x=1725304326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNx9sZl/yUBGURq14inZ/gFwcbdWjMbt7j0T+ApuBZk=;
 b=RZke+u3b87z7TVyztW7uq946wsjcl6C2A6s2jUx9as01jBMdSTVmnkkgDHhrGgNd3L
 MVp6wBMbVGQPzBiA5o0Ve3vFdsy7hrtaTMXEdrnNPdjkz5IVt80nkQcFuYrnwBwcRUT6
 IBNjKreoa+zR0vJvPFl8gEDSMSbl/C88Poc+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699526; x=1725304326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNx9sZl/yUBGURq14inZ/gFwcbdWjMbt7j0T+ApuBZk=;
 b=ueBKCgBKD03RZ19xmCi9orS/pW8HP8u/9Puv947OjIvAD4laESzhCv/wnYE05mzWe+
 8wMtxmwx43MtIbvFmi9d9EocDBm/uxbq5U63refntCFl4/iaOa4TwKJ+UG9fjyl5r+lW
 durNDlAIdKXeJl+YILZyybUj3OBfg9YR78xE45VfdIoO6fUkDZU8hhffXyEkOul9kw1O
 JRn1Hk/hoM0KW3so22ePMa3AtBDwKx5V4xcle65UGowaqFKH9dHftjPEXV7AAkLnteAJ
 9gwRGVRIbGT9zZNEG/4gs/AcYo3bwjcEyjVgSSFUN4QG5YvE5A9hiMskajrv/WsjhHSc
 DTaQ==
X-Gm-Message-State: AOJu0YxpvcUfOHyA5TX2lI93N0yEQuAhrl0Vln8yJePYqQx/8mayIyqx
 ATyansJpfojJmOhCgQc2AjlotVHzKq5kP0QUV16LS9DxDg3ymTD+z2pa7j5Jm7G7SN81DFPz0ec
 =
X-Google-Smtp-Source: AGHT+IGCMu62emh6F1BvaTyzW4RqFPjPbYOu6V7xVXliyFvYIzKejd0izsW/xqv83F5b8rMf8EEctg==
X-Received: by 2002:a05:6e02:1c47:b0:39a:ea86:d615 with SMTP id
 e9e14a558f8ab-39e63dd8dbdmr7819795ab.6.1724699526156; 
 Mon, 26 Aug 2024 12:12:06 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:12:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rong Tao <rongtao@cestc.cn>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/15] binman: Adjust naming for reading symbols
Date: Mon, 26 Aug 2024 13:11:38 -0600
Message-Id: <20240826191143.426387-11-sjg@chromium.org>
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

These functions get the value of a symbol. The reference to ELF files
is confusing since they are reading the position/size of entries, not
ELF symbols. Rename the functions and adjust the comments also.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/elf.py           |  4 ++--
 tools/binman/elf_test.py      |  4 ++--
 tools/binman/etype/section.py | 13 ++++++-------
 tools/binman/image.py         | 11 +++++------
 tools/binman/image_test.py    |  8 ++++----
 5 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/tools/binman/elf.py b/tools/binman/elf.py
index a4694056391..1c3b1e225f4 100644
--- a/tools/binman/elf.py
+++ b/tools/binman/elf.py
@@ -301,8 +301,8 @@ def LookupAndWriteSymbols(elf_fname, entry, section, is_elf=False,
                 value = BINMAN_SYM_MAGIC_VALUE
             else:
                 # Look up the symbol in our entry tables.
-                value = section.GetImage().LookupImageSymbol(name, sym.weak,
-                                                             msg, base_addr)
+                value = section.GetImage().GetImageSymbolValue(name, sym.weak,
+                                                               msg, base_addr)
             if value is None:
                 value = -1
                 pack_string = pack_string.lower()
diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
index b64134123c1..2f22639dffc 100644
--- a/tools/binman/elf_test.py
+++ b/tools/binman/elf_test.py
@@ -37,7 +37,7 @@ class FakeSection:
     """A fake Section object, used for testing
 
     This has the minimum feature set needed to support testing elf functions.
-    A LookupSymbol() function is provided which returns a fake value for amu
+    A GetSymbolValue() function is provided which returns a fake value for any
     symbol requested.
     """
     def __init__(self, sym_value=1):
@@ -46,7 +46,7 @@ class FakeSection:
     def GetPath(self):
         return 'section_path'
 
-    def LookupImageSymbol(self, name, weak, msg, base_addr):
+    def GetImageSymbolValue(self, name, weak, msg, base_addr):
         """Fake implementation which returns the same value for all symbols"""
         return self.sym_value
 
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 30c1041c7e8..6c181531b8b 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -563,13 +563,13 @@ class Entry_section(Entry):
         return entry.GetData(required)
 
     def LookupEntry(self, entries, sym_name, msg):
-        """Look up the entry for an ENF  symbol
+        """Look up the entry for a binman symbol
 
         Args:
             entries (dict): entries to search:
                 key: entry name
                 value: Entry object
-            sym_name: Symbol name in the ELF file to look up in the format
+            sym_name: Symbol name to look up in the format
                 _binman_<entry>_prop_<property> where <entry> is the name of
                 the entry and <property> is the property to find (e.g.
                 _binman_u_boot_prop_offset). As a special case, you can append
@@ -606,11 +606,10 @@ class Entry_section(Entry):
                             entry = entries[name]
         return entry, entry_name, prop_name
 
-    def LookupSymbol(self, sym_name, optional, msg, base_addr, entries=None):
-        """Look up a symbol in an ELF file
+    def GetSymbolValue(self, sym_name, optional, msg, base_addr, entries=None):
+        """Get the value of a Binman symbol
 
-        Looks up a symbol in an ELF file. Only entry types which come from an
-        ELF image can be used by this function.
+        Look up a Binman symbol and obtain its value.
 
         At present the only entry properties supported are:
             offset
@@ -618,7 +617,7 @@ class Entry_section(Entry):
             size
 
         Args:
-            sym_name: Symbol name in the ELF file to look up in the format
+            sym_name: Symbol name to look up in the format
                 _binman_<entry>_prop_<property> where <entry> is the name of
                 the entry and <property> is the property to find (e.g.
                 _binman_u_boot_prop_offset). As a special case, you can append
diff --git a/tools/binman/image.py b/tools/binman/image.py
index 702c9055585..c667f583db6 100644
--- a/tools/binman/image.py
+++ b/tools/binman/image.py
@@ -381,11 +381,10 @@ class Image(section.Entry_section):
             selected_entries.append(entry)
         return selected_entries, lines, widths
 
-    def LookupImageSymbol(self, sym_name, optional, msg, base_addr):
-        """Look up a symbol in an ELF file
+    def GetImageSymbolValue(self, sym_name, optional, msg, base_addr):
+        """Get the value of a Binman symbol
 
-        Looks up a symbol in an ELF file. Only entry types which come from an
-        ELF image can be used by this function.
+        Look up a Binman symbol and obtain its value.
 
         This searches through this image including all of its subsections.
 
@@ -423,8 +422,8 @@ class Image(section.Entry_section):
         entries = OrderedDict()
         entries_by_name = {}
         self._CollectEntries(entries, entries_by_name, self)
-        return self.LookupSymbol(sym_name, optional, msg, base_addr,
-                                 entries_by_name)
+        return self.GetSymbolValue(sym_name, optional, msg, base_addr,
+                                   entries_by_name)
 
     def CollectBintools(self):
         """Collect all the bintools used by this image
diff --git a/tools/binman/image_test.py b/tools/binman/image_test.py
index bd51c1e55d1..7d65e2d589a 100644
--- a/tools/binman/image_test.py
+++ b/tools/binman/image_test.py
@@ -13,7 +13,7 @@ class TestImage(unittest.TestCase):
     def testInvalidFormat(self):
         image = Image('name', 'node', test=True)
         with self.assertRaises(ValueError) as e:
-            image.LookupSymbol('_binman_something_prop_', False, 'msg', 0)
+            image.GetSymbolValue('_binman_something_prop_', False, 'msg', 0)
         self.assertIn(
             "msg: Symbol '_binman_something_prop_' has invalid format",
             str(e.exception))
@@ -22,7 +22,7 @@ class TestImage(unittest.TestCase):
         image = Image('name', 'node', test=True)
         image._entries = {}
         with self.assertRaises(ValueError) as e:
-            image.LookupSymbol('_binman_type_prop_pname', False, 'msg', 0)
+            image.GetSymbolValue('_binman_type_prop_pname', False, 'msg', 0)
         self.assertIn("msg: Entry 'type' not found in list ()",
                       str(e.exception))
 
@@ -30,7 +30,7 @@ class TestImage(unittest.TestCase):
         image = Image('name', 'node', test=True)
         image._entries = {}
         with capture_sys_output() as (stdout, stderr):
-            val = image.LookupSymbol('_binman_type_prop_pname', True, 'msg', 0)
+            val = image.GetSymbolValue('_binman_type_prop_pname', True, 'msg', 0)
         self.assertEqual(val, None)
         self.assertEqual("Warning: msg: Entry 'type' not found in list ()\n",
                          stderr.getvalue())
@@ -40,5 +40,5 @@ class TestImage(unittest.TestCase):
         image = Image('name', 'node', test=True)
         image._entries = {'u-boot': 1}
         with self.assertRaises(ValueError) as e:
-            image.LookupSymbol('_binman_u_boot_prop_bad', False, 'msg', 0)
+            image.GetSymbolValue('_binman_u_boot_prop_bad', False, 'msg', 0)
         self.assertIn("msg: No such property 'bad", str(e.exception))
-- 
2.34.1

