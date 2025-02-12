Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C7FC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA2A480207;
	Wed, 12 Feb 2025 23:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UNm8dnP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6CF8043C; Wed, 12 Feb 2025 23:23:05 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28EC8801DE
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7c0790bf26fso18298185a.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739398982; x=1740003782; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ooj59VO2rKSS7wLP//kCkgzBL59Cmx70r4UgOYnx7UE=;
 b=UNm8dnP60Hftl/fDv+11T26GQQXggEPqpuMQproBTBX+8wZWMrpE6Jzml/EqXbPu8C
 fe5g1iveHVXasuC2K+7EZyXxx2tnbL0hGk/xm9UF+yn6CYjY0xP7DUdCq2lMEhyfoXCP
 OABZHh8t4IDhs36toZEkFmKCQdaQD/dYHEO30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739398982; x=1740003782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ooj59VO2rKSS7wLP//kCkgzBL59Cmx70r4UgOYnx7UE=;
 b=oYIxk+hSIm9j65z4IjIy4rtgpdujOKM83ZvXjpJ1twwNL416TzZNBP+gef0ijfrjbN
 3aH8hbSuySPAx0ml/VVKLLZxVo+I7BXMB+MvW2hYyQgkxLE9uggQGq3GPG0neeqVagvU
 cPL0e9vZljgy31FcbRgizkrcPbF/9Y1rqpXoG6KHMeJWCIhTxgto3KMcY1Z0vIwXmb2G
 sPbGfnd5XPV05MBTNk81CWbl8lCROllMAbVkQISlE1BGmI8eb40YVUOwoIe1H3J8haOp
 fjnHm1RqHtpER60SVJBg8YdQI6ya51DwjwIpHYtvdXNk7PIo1aLTJn4231PJC7/DvMO/
 Gwkg==
X-Gm-Message-State: AOJu0Yz1m8qtyMJsTfKi0f1futqiXlxnxUnY9YhrhFp5/mwm+TOQssEK
 bo/11HmzGDF8SgS7Ftp3Ck8YNpLZG7EmK15E5iW+7tuy69jDbVr62LvYDeCNdtqBS2DZ9xRul2h
 t
X-Gm-Gg: ASbGncsTbwvTQYwnH/G7ocRAa49ZivxJcFULuA0DUVl1WWtbZ6p+YiNoePGeRD8WqXu
 9kl/Um8jTC2NlUPf5UloHGiPUkAOGhQZM/nGOcNUsdg+SQGvKHberDZwqqedHNKRA7CBnNmBvx3
 bEdpMKf8JGnJAYKC9Tkn+hl9j4p+1MS1C0Nem+uRTmoH7cqIUCB/9+yGBQTVZ8Zhv1ug9aZBVdP
 zwocicXsJPxUNoeBWqm2CCcemtZBewVXFh8qS/oD0ti0pLK1aUhAahif/t+0AbSliIeMZIoP88M
 /DFG7a80GWOQZYsCmg==
X-Google-Smtp-Source: AGHT+IFyonHmS9LlQQ/0AN/pxOAEvdNFpjxsS4dmrmjRSyTdjdcm+7eLUBfk7e1pGOcxhV26v/b/8g==
X-Received: by 2002:a05:620a:44d0:b0:7c0:5f6c:a33f with SMTP id
 af79cd13be357-7c06fc8889cmr894890885a.31.1739398981926; 
 Wed, 12 Feb 2025 14:23:01 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e452bebc45sm62723026d6.38.2025.02.12.14.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:23:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH RFC] binman: Handle some newer pylint warnings
Date: Wed, 12 Feb 2025 16:22:59 -0600
Message-ID: <20250212222259.684336-1-trini@konsulko.com>
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

With a newer pylint we have a few warnings show up now that are harder
to handle. The first problem is that when we call self.Raise(...) this
is no longer enough to have pylint see that we're now bailing out and
won't attempt to reference an unassigned variable. This is all of the
pylint disabling, with the exception of _AddNode.

The problem with _AddNode is that before we call this function we set
fsw as libfdt.FdtSw() and I'm unsure how best to rework the code.

The final problem is in CheckSetHashValue() where the function only
handles one algorithm but the intention is to handle others as well.
Once another algorithm is added and then also error handling for no
algorithm is added, we would not attempt to use data before it's been
assigned.

As I'm not confident all of these are the right way to handle the
problem I've marked this as RFC and not split the changes up more.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 tools/binman/etype/fdtmap.py       | 1 +
 tools/binman/etype/image_header.py | 1 +
 tools/binman/etype/pre_load.py     | 1 +
 tools/binman/etype/x509_cert.py    | 1 +
 tools/binman/ftest.py              | 1 +
 tools/binman/state.py              | 4 ++--
 6 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/binman/etype/fdtmap.py b/tools/binman/etype/fdtmap.py
index f1f6217940f2..a2b0d27fcc5f 100644
--- a/tools/binman/etype/fdtmap.py
+++ b/tools/binman/etype/fdtmap.py
@@ -109,6 +109,7 @@ class Entry_fdtmap(Entry):
         def _AddNode(node):
             """Add a node to the FDT map"""
             for pname, prop in node.props.items():
+                # pylint: disable=locally-disabled, possibly-used-before-assignment
                 fsw.property(pname, prop.bytes)
             for subnode in node.subnodes:
                 with fsw.add_node(subnode.name):
diff --git a/tools/binman/etype/image_header.py b/tools/binman/etype/image_header.py
index 240118849580..6d8db9eed564 100644
--- a/tools/binman/etype/image_header.py
+++ b/tools/binman/etype/image_header.py
@@ -72,6 +72,7 @@ class Entry_image_header(Entry):
             image_size = self.section.GetImageSize() or 0
             base = (0 if self.location != 'end' else image_size)
             offset = (image_pos - base) & 0xffffffff
+        # pylint: disable=locally-disabled, possibly-used-before-assignment
         data = IMAGE_HEADER_MAGIC + struct.pack('<I', offset)
         return data
 
diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 2e4c72359ff3..e2615e1c7d1b 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -122,6 +122,7 @@ class Entry_pre_load(Entry_collection):
         else:
             self.Raise(padding_name + " is not supported")
 
+        # pylint: disable=locally-disabled, possibly-used-before-assignment
         sig = padding.new(key, **padding_args).sign(hash_image)
 
         hash_sig = SHA256.new()
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index 29630d1b86c8..15d0766051c2 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -141,6 +141,7 @@ class Entry_x509_cert(Entry_collection):
                 dm_data_ext_boot_block=self.dm_data_ext_boot_block,
                 bootcore_opts=self.bootcore_opts
             )
+        # pylint: disable=locally-disabled, possibly-used-before-assignment
         if stdout is not None:
             data = tools.read_file(output_fname)
         else:
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a553ca9e5642..b6e58decb008 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6387,6 +6387,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                     expect_val = entry.image_pos
                 elif prop_name == 'size':
                     expect_val = entry.size
+                # pylint: disable=locally-disabled, possibly-used-before-assignment
                 self.assertEqual(expect_val, val)
 
     def testSymbolsElfBad(self):
diff --git a/tools/binman/state.py b/tools/binman/state.py
index 45bae40c525a..ca3f857f1943 100644
--- a/tools/binman/state.py
+++ b/tools/binman/state.py
@@ -410,8 +410,8 @@ def CheckSetHashValue(node, get_data_func):
             m = hashlib.sha256()
             m.update(get_data_func())
             data = m.digest()
-        for n in GetUpdateNodes(hash_node):
-            n.SetData('value', data)
+            for n in GetUpdateNodes(hash_node):
+                n.SetData('value', data)
 
 def SetAllowEntryExpansion(allow):
     """Set whether post-pack expansion of entries is allowed
-- 
2.43.0

