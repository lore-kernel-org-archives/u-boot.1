Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4FCC5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B8988B86;
	Mon, 26 Aug 2024 21:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AYX1pK4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F055B880DB; Mon, 26 Aug 2024 21:12:01 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B49EE88A3A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-39d740b06b4so14238335ab.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699518; x=1725304318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNdmZ38QV/LKrCri72iN30NgX1K95dDSWjqtG+dqFqk=;
 b=AYX1pK4XUGDLTTC67LMts9xF515MNvWKP3V1PYIroPTM+QVN8iia/tWOGwIGPsrODH
 t8XEV2znAvRZ2QGV5IGJNEU5S45kDI2AlgYBrJmv+9v6l7b2pajoofmVTVuUx7psQCa/
 9TYPYsMi61cYc+NZrjczOqOiLEtUasrQBCQjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699518; x=1725304318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNdmZ38QV/LKrCri72iN30NgX1K95dDSWjqtG+dqFqk=;
 b=KpqZY45X9/dDOYYNwfu7UysmNfM1szfDikMN5TI3CBFmU241DJTM6xlkcTkOoiNlwE
 NRKli+VNSNvCzjaQqEkyW/CdprtcVLTmsHmZnJBjCycAr+BILaWtAS4Qc5u5TeHUEKj/
 nWeZSwGeUYFzBviU4asVMZwjo27DGEoK+q5ObCpz6TeJS1KGbsv79m3i066KlyfQapLH
 w2ZpbncFsyd6JuV2JNepBE5DtZNxvk2Xk6hLkToXmkcyBwYb/VPsv0IZUKVklPAU1NHE
 ZU/IZIDzR18GZVzM2IVeGqjyQ9bC5PA7gJWbQ166H1/y/760ucW9oc/5OxhDwChWaRDu
 AtxA==
X-Gm-Message-State: AOJu0Yy05ke4LBO/ulcbo39QVSWVLeONLnJllehPZ4Bpug6jzKmaaYv3
 s90aO0AmWoTououv8LL6ZHyMBAHcQ5BD9C2WVuLS+4iT3E52SHZHyP1P+7GjbBIXbAWFwwvyW7A
 =
X-Google-Smtp-Source: AGHT+IFPKhrpTICJkdStddHtRdcTYwdedrgksx36vNuVoXsUNpGK9pY5YvsXJB14oBdGPpW40zJUVg==
X-Received: by 2002:a05:6e02:13aa:b0:39b:3244:a355 with SMTP id
 e9e14a558f8ab-39e640059e0mr5452965ab.11.1724699518007; 
 Mon, 26 Aug 2024 12:11:58 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:11:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/15] binman: Tidy up comments and pylint warnings in fit
Date: Mon, 26 Aug 2024 13:11:32 -0600
Message-Id: <20240826191143.426387-5-sjg@chromium.org>
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

Update this entry type to resolve some pylint warnings and make sure
that functions and members are fully commented.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/fit.py | 73 ++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index b957df54548..f25226d3a73 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -6,9 +6,10 @@
 """Entry-type module for producing a FIT"""
 
 import glob
-import libfdt
 import os
 
+import libfdt
+
 from binman.entry import Entry, EntryArg
 from binman.etype.section import Entry_section
 from binman import elf
@@ -23,6 +24,7 @@ OPERATIONS = {
     'split-elf': OP_SPLIT_ELF,
     }
 
+# pylint: disable=invalid-name
 class Entry_fit(Entry_section):
 
     """Flat Image Tree (FIT)
@@ -381,31 +383,46 @@ class Entry_fit(Entry_section):
     def __init__(self, section, etype, node):
         """
         Members:
-            _fit: FIT file being built
-            _entries: dict from Entry_section:
+            _fit (str): FIT file being built
+            _fit_props (list of str): 'fit,...' properties found in the
+                top-level node
+            _fdts (list of str): Filenames of .dtb files to process
+            _fdt_dir (str): Directory to scan to find .dtb files, or None
+            _fit_list_prop (str): Name of the EntryArg containing a list of .dtb
+                files
+            _fit_default_dt (str): Name of the EntryArg containing the default
+                .dtb file
+            _entries (dict of entries): from Entry_section:
                 key: relative path to entry Node (from the base of the FIT)
                 value: Entry_section object comprising the contents of this
                     node
-            _priv_entries: Internal copy of _entries which includes 'generator'
-                entries which are used to create the FIT, but should not be
-                processed as real entries. This is set up once we have the
-                entries
-            _loadables: List of generated split-elf nodes, each a node name
+            _priv_entries (dict of entries): Internal copy of _entries which
+                includes 'generator' entries which are used to create the FIT,
+                but should not be processed as real entries. This is set up once
+                we have the entries
+            _loadables (list of str): List of generated split-elf nodes, each
+                a node name
+            _remove_props (list of str): Value of of-spl-remove-props EntryArg,
+                the list of properties to remove with fdtgrep
+            mkimage (Bintool): mkimage tool
+            fdtgrep (Bintool): fdtgrep tool
         """
         super().__init__(section, etype, node)
         self._fit = None
         self._fit_props = {}
         self._fdts = None
         self._fdt_dir = None
-        self.mkimage = None
-        self.fdtgrep = None
+        self._fit_list_prop = None
+        self._fit_default_dt = None
         self._priv_entries = {}
         self._loadables = []
         self._remove_props = []
-        props, = self.GetEntryArgsOrProps(
-            [EntryArg('of-spl-remove-props', str)], required=False)
+        props = self.GetEntryArgsOrProps(
+            [EntryArg('of-spl-remove-props', str)], required=False)[0]
         if props:
             self._remove_props = props.split()
+        self.mkimage = None
+        self.fdtgrep = None
 
     def ReadNode(self):
         super().ReadNode()
@@ -414,8 +431,8 @@ class Entry_fit(Entry_section):
                 self._fit_props[pname] = prop
         self._fit_list_prop = self._fit_props.get('fit,fdt-list')
         if self._fit_list_prop:
-            fdts, = self.GetEntryArgsOrProps(
-                [EntryArg(self._fit_list_prop.value, str)])
+            fdts = self.GetEntryArgsOrProps(
+                [EntryArg(self._fit_list_prop.value, str)])[0]
             if fdts is not None:
                 self._fdts = fdts.split()
         else:
@@ -431,7 +448,7 @@ class Entry_fit(Entry_section):
         self._fit_default_dt = self.GetEntryArgsOrProps([EntryArg('default-dt',
                                                                   str)])[0]
 
-    def _get_operation(self, base_node, node):
+    def _get_operation(self, node):
         """Get the operation referenced by a subnode
 
         Args:
@@ -560,9 +577,6 @@ class Entry_fit(Entry_section):
     def _build_input(self):
         """Finish the FIT by adding the 'data' properties to it
 
-        Arguments:
-            fdt: FIT to update
-
         Returns:
             bytes: New fdt contents
         """
@@ -637,7 +651,7 @@ class Entry_fit(Entry_section):
                     result.append(name)
             return firmware, result
 
-        def _gen_fdt_nodes(base_node, node, depth, in_images):
+        def _gen_fdt_nodes(node, depth, in_images):
             """Generate FDT nodes
 
             This creates one node for each member of self._fdts using the
@@ -710,11 +724,10 @@ class Entry_fit(Entry_section):
                     else:
                         self.Raise("Generator node requires 'fit,fdt-list' property")
 
-        def _gen_split_elf(base_node, node, depth, segments, entry_addr):
+        def _gen_split_elf(node, depth, segments, entry_addr):
             """Add nodes for the ELF file, one per group of contiguous segments
 
             Args:
-                base_node (Node): Template node from the binman definition
                 node (Node): Node to replace (in the FIT being built)
                 depth: Current node depth (0 is the base 'fit' node)
                 segments (list): list of segments, each:
@@ -745,7 +758,7 @@ class Entry_fit(Entry_section):
                         with fsw.add_node(subnode.name):
                             _add_node(node, depth + 1, subnode)
 
-        def _gen_node(base_node, node, depth, in_images, entry):
+        def _gen_node(node, depth, in_images, entry):
             """Generate nodes from a template
 
             This creates one or more nodes depending on the fit,operation being
@@ -761,8 +774,6 @@ class Entry_fit(Entry_section):
             If the file is missing, nothing is generated.
 
             Args:
-                base_node (Node): Base Node of the FIT (with 'description'
-                    property)
                 node (Node): Generator node to process
                 depth (int): Current node depth (0 is the base 'fit' node)
                 in_images (bool): True if this is inside the 'images' node, so
@@ -770,13 +781,12 @@ class Entry_fit(Entry_section):
                 entry (entry_Section): Entry for the section containing the
                     contents of this node
             """
-            oper = self._get_operation(base_node, node)
+            oper = self._get_operation(node)
             if oper == OP_GEN_FDT_NODES:
-                _gen_fdt_nodes(base_node, node, depth, in_images)
+                _gen_fdt_nodes(node, depth, in_images)
             elif oper == OP_SPLIT_ELF:
                 # Entry_section.ObtainContents() either returns True or
                 # raises an exception.
-                data = None
                 missing_opt_list = []
                 entry.ObtainContents()
                 entry.Pack(0)
@@ -798,7 +808,7 @@ class Entry_fit(Entry_section):
                             self._raise_subnode(
                                 node, f'Failed to read ELF file: {str(exc)}')
 
-                    _gen_split_elf(base_node, node, depth, segments, entry_addr)
+                    _gen_split_elf(node, depth, segments, entry_addr)
 
         def _add_node(base_node, depth, node):
             """Add nodes to the output FIT
@@ -829,7 +839,6 @@ class Entry_fit(Entry_section):
                 fsw.property('data', bytes(data))
 
             for subnode in node.subnodes:
-                subnode_path = f'{rel_path}/{subnode.name}'
                 if has_images and not self.IsSpecialSubnode(subnode):
                     # This subnode is a content node not meant to appear in
                     # the FIT (e.g. "/images/kernel/u-boot"), so don't call
@@ -837,7 +846,7 @@ class Entry_fit(Entry_section):
                     pass
                 elif self.GetImage().generate and subnode.name.startswith('@'):
                     entry = self._priv_entries.get(subnode.name)
-                    _gen_node(base_node, subnode, depth, in_images, entry)
+                    _gen_node(subnode, depth, in_images, entry)
                     # This is a generator (template) entry, so remove it from
                     # the list of entries used by PackEntries(), etc. Otherwise
                     # it will appear in the binman output
@@ -917,6 +926,8 @@ class Entry_fit(Entry_section):
 
             # This should never happen
             else: # pragma: no cover
+                offset = None
+                size = None
                 self.Raise(f'{path}: missing data properties')
 
             section.SetOffsetSize(offset, size)
@@ -950,7 +961,7 @@ class Entry_fit(Entry_section):
         if input_fname:
             fname = input_fname
         else:
-            fname = tools.get_output_filename('%s.fit' % uniq)
+            fname = tools.get_output_filename(f'{uniq}.fit')
             tools.write_file(fname, self.GetData())
         args.append(fname)
 
-- 
2.34.1

