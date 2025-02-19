Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83653C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 15:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A8580F18;
	Wed, 19 Feb 2025 16:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hYMyJenR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD2380F32; Wed, 19 Feb 2025 16:11:28 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2F1801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 16:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-855b2a5ad32so32192639f.1
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 07:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739977884; x=1740582684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HCiMhcoQPfA3jFQ1nFCC2AZChSWuEgU/ZgvWlgD1fGs=;
 b=hYMyJenRcuwtFex4B7s+LRdqNiVhKUPjznNOHgDwQKpP6PiORmvLgW0jrYB/H9fhtq
 lnoIhHg+1CVctoIV1bY/tZEmlkzzGov/mrDuDghPIuUY58Xm9X6fdj1sntRuTWOfONtf
 dmNYc3RTkqPsFsrkffBdKBbLa6GIX42XlCLYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739977884; x=1740582684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HCiMhcoQPfA3jFQ1nFCC2AZChSWuEgU/ZgvWlgD1fGs=;
 b=F01pJZZQH16fGB53ZRwczoPbRw6Lv3ogKrbi559chzjzITfKCfg/gRiflxDVj462jy
 rPwaAw3RtuRujsLENPXljZnlBLEH45EqPgxU1+OoYCNcVyzLJvCA/zCgmRd1OpQozQKj
 5HuEK9kAmP4PpDsbUxyHEs5kZ4FmXmuQyxfJ+4MJ3P5x7MPFzyD0NeuMx6ppIB3iwphq
 jgUXszqUWHumW3EHizgjyjONr0t00tEZo2JSwk8em7mIEX8HowfSEwsBRgufsh6uvj5x
 khpyRPGaxANaDvCnPIP5HpJzL3TzEQZ4KHFoOudGrwehLIQ39VdxDqhzYIMA3K5Kmhfy
 dpLg==
X-Gm-Message-State: AOJu0Yw3neX4NVDTDINV8xdBh4Lys+inH6s9c/Cyv29VC9Q19iP0BOOE
 40NWJW3wYOr89kiq/ABzCj3ybbdIScwH7e2/jx9f0KMODHumxVwgbQ+tBaXVfBoUKYTAfl/kD5c
 =
X-Gm-Gg: ASbGncvwTfnDt4fByfZHZP1iEUFME5VR1tLYqG6K8Stdz7IetJDU9+lposgAaYijxEi
 D5+RoLUM07m5inzqwDlXJc96zRpsitSOrpum3EmJj8VBXylQT+IYI5kFlF/u0XMpfr3JPR7fi53
 lqtH+PFcm8wDDl9E7ecP/TVrQSeIfDbi6rHg/2t7jjm+gAzkjyk25aeyuRIfvQWjeOkHO/ZG3uc
 fdjmxy3Hx1uOHxkr0eTybstCjyw4fvDX39LFoU2EegM+XZ+9HMXv4tessW+ozysA0+/FDiXxWtM
 Td0jXkhqaiuc8Gn8ew6FPpgIEf8LqedgHPbb9vWzKEg=
X-Google-Smtp-Source: AGHT+IG7VahgS79r1I0sYxfiwYAiscqew/+Iw/SQF3+vT6L1QulayA/HyOCEtTPShFtbx57iWXMFcA==
X-Received: by 2002:a05:6e02:1cac:b0:3d0:4700:db0f with SMTP id
 e9e14a558f8ab-3d2b52b8683mr46120885ab.12.1739977883661; 
 Wed, 19 Feb 2025 07:11:23 -0800 (PST)
Received: from chromium.org (97-118-205-183.hlrn.qwest.net. [97.118.205.183])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d2af7f8371sm6693705ab.0.2025.02.19.07.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 07:11:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Michael Walle <mwalle@kernel.org>, Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH] tools: Fix pylint 3.3.4 errors
Date: Wed, 19 Feb 2025 08:11:16 -0700
Message-ID: <20250219151118.2345297-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

This newer pylint produces errors about variables possibly being used
before being set. Adjust the code to pass these checks.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Tom Rini <trini@konsulko.com>
---

 tools/binman/etype/fdtmap.py          | 5 +++--
 tools/binman/etype/image_header.py    | 1 +
 tools/binman/etype/pre_load.py        | 2 ++
 tools/binman/etype/ti_board_config.py | 1 +
 tools/binman/etype/x509_cert.py       | 1 +
 tools/binman/ftest.py                 | 1 +
 tools/binman/state.py                 | 3 +++
 tools/buildman/builder.py             | 6 +++---
 tools/microcode-tool.py               | 3 +++
 9 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/binman/etype/fdtmap.py b/tools/binman/etype/fdtmap.py
index f1f6217940f..2259404180c 100644
--- a/tools/binman/etype/fdtmap.py
+++ b/tools/binman/etype/fdtmap.py
@@ -106,6 +106,9 @@ class Entry_fdtmap(Entry):
         Returns:
             FDT map binary data
         """
+        fsw = libfdt.FdtSw()
+        fsw.finish_reservemap()
+
         def _AddNode(node):
             """Add a node to the FDT map"""
             for pname, prop in node.props.items():
@@ -134,8 +137,6 @@ class Entry_fdtmap(Entry):
 
             # Build a new tree with all nodes and properties starting from that
             # node
-            fsw = libfdt.FdtSw()
-            fsw.finish_reservemap()
             with fsw.add_node(''):
                 fsw.property_string('image-node', node.name)
                 _AddNode(node)
diff --git a/tools/binman/etype/image_header.py b/tools/binman/etype/image_header.py
index 24011884958..2114df8159f 100644
--- a/tools/binman/etype/image_header.py
+++ b/tools/binman/etype/image_header.py
@@ -62,6 +62,7 @@ class Entry_image_header(Entry):
 
     def _GetHeader(self):
         image_pos = self.GetSiblingImagePos('fdtmap')
+        offset = None
         if image_pos == False:
             self.Raise("'image_header' section must have an 'fdtmap' sibling")
         elif image_pos is None:
diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 2e4c72359ff..00f1a896767 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -112,6 +112,8 @@ class Entry_pre_load(Entry_collection):
         # Compute the signature
         if padding_name is None:
             padding_name = "pkcs-1.5"
+        padding = None
+        padding_args = None
         if padding_name == "pss":
             salt_len = key.size_in_bytes() - hash_image.digest_size - 2
             padding = pss
diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
index c10d66edcb1..c7e165ef96a 100644
--- a/tools/binman/etype/ti_board_config.py
+++ b/tools/binman/etype/ti_board_config.py
@@ -125,6 +125,7 @@ class Entry_ti_board_config(Entry_section):
             size = 2
         else:
             size = 4
+        br = None
         if type(val) == int:
             br = val.to_bytes(size, byteorder='little')
         return br
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index 29630d1b86c..25e6808b7f9 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -84,6 +84,7 @@ class Entry_x509_cert(Entry_collection):
         input_fname = tools.get_output_filename('input.%s' % uniq)
         config_fname = tools.get_output_filename('config.%s' % uniq)
         tools.write_file(input_fname, input_data)
+        stdout = None
         if type == 'generic':
             stdout = self.openssl.x509_cert(
                 cert_fname=output_fname,
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 867cb2a52d2..32b1f0e89ff 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6362,6 +6362,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                     ename, prop = entry_m.group(1), entry_m.group(3)
                 entry, entry_name, prop_name = image.LookupEntry(entries,
                                                                  name, msg)
+                expect_val = None
                 if prop_name == 'offset':
                     expect_val = entry.offset
                 elif prop_name == 'image_pos':
diff --git a/tools/binman/state.py b/tools/binman/state.py
index 45bae40c525..6772d3678fe 100644
--- a/tools/binman/state.py
+++ b/tools/binman/state.py
@@ -406,10 +406,13 @@ def CheckSetHashValue(node, get_data_func):
     hash_node = node.FindNode('hash')
     if hash_node:
         algo = hash_node.props.get('algo').value
+        data = None
         if algo == 'sha256':
             m = hashlib.sha256()
             m.update(get_data_func())
             data = m.digest()
+        if data is None:
+            raise ValueError(f"Node '{node.path}': Unknown hash algorithm '{algo}'")
         for n in GetUpdateNodes(hash_node):
             n.SetData('value', data)
 
diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index 3f5ddd8e722..8b98e040463 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -1098,14 +1098,13 @@ class Builder:
                 diff = result[name]
                 if name.startswith('_'):
                     continue
-                if diff != 0:
-                    color = self.col.RED if diff > 0 else self.col.GREEN
+                colour = self.col.RED if diff > 0 else self.col.GREEN
                 msg = ' %s %+d' % (name, diff)
                 if not printed_target:
                     tprint('%10s  %-15s:' % ('', result['_target']),
                           newline=False)
                     printed_target = True
-                tprint(msg, colour=color, newline=False)
+                tprint(msg, colour=colour, newline=False)
             if printed_target:
                 tprint()
                 if show_bloat:
@@ -1356,6 +1355,7 @@ class Builder:
             for line in lines:
                 if not line:
                     continue
+                col = None
                 if line[0] == '+':
                     col = self.col.GREEN
                 elif line[0] == '-':
diff --git a/tools/microcode-tool.py b/tools/microcode-tool.py
index 24c02c4fca1..b726794751a 100755
--- a/tools/microcode-tool.py
+++ b/tools/microcode-tool.py
@@ -279,6 +279,9 @@ def MicrocodeTool():
 
     if (not not options.mcfile) != (not not options.mcfile):
         parser.error("You must specify either header files or a microcode file, not both")
+    date = None
+    microcodes = None
+    license_text = None
     if options.headerfile:
         date, license_text, microcodes = ParseHeaderFiles(options.headerfile)
     elif options.mcfile:
-- 
2.43.0

