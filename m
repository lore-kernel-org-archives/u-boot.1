Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C7F103E177
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 13:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD3584222;
	Wed, 18 Mar 2026 14:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FYYVo/RI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C68F84238; Wed, 18 Mar 2026 14:24:46 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D93684222
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 14:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d756f2a06dso898955a34.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773840281; x=1774445081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVAikQLc5j1yTgj3lGi/oiIvzDkuA7qTat+HgEU3LZE=;
 b=FYYVo/RI4A/u9/0w5Cw0nrdGFiwfllOfEp73Hzi5w7X2aAHT4i0t2zFogZEZJ8s4RP
 AGUJuz9DRo/txdF2HMEL3bjZMQkVUWRmcMHi23Yo87S2zhpALETpqtySQ/4kxUtREifV
 YQyPUiLlMFXRmkEXdOVOGWUr1Ws+cDPdv50S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773840281; x=1774445081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CVAikQLc5j1yTgj3lGi/oiIvzDkuA7qTat+HgEU3LZE=;
 b=A4XvDJ8K4Retd8gOJ1AASa6Yq4lRTZqbsj1E75jz0C7GDNuWrScblk1Fa2egG4qY8b
 1tWYR6ykCiiQrOfq1EczsL6TZPQI0PDbgLaygKvRoTRQHpb6hPS1iqX3zKIC1MTPQVEo
 ZUDR28MHIjzPGrrQ6pXd5jzuT+8h+whr3yZXemUVy+nisaf2uzav17ozB/vAoshYMRQZ
 h+Ev5t4CGQMIfvi75Ajn0c0eaF3vAI8OJIK6odSsKwYDF4/qPQMygYXkPk8K9VnWqVsJ
 jfgpJ9FHCd7e233zy7xcnpk8a8WMwDj2TUfV6bFi9LG5LYzqrhxjFBB+EiLsPU9m1yoq
 t9Sw==
X-Gm-Message-State: AOJu0Ywk1KwYCOK0GgnqmGrc+CoTYewOuYTG5DSgZ9SQGD0SlX8SQ6b3
 BtdzQYjxcR5xY5vr/MU68lgX1wNM3bbhOgzqQk6l/5P3h3HYHLNfB241t+45z4837XPigLxTVW+
 woSpTKF5G
X-Gm-Gg: ATEYQzzlT00dq65FF7paXz0fci8vykuv8Rs10swjA9eenPx+hfCdGyHFhe29YrXY+/W
 k6OvRWnPsqbdxOq2TP4LJrN0ynLGzk1DrwX3xzoqvUXzoxMRCiFq0bVuqlhfcTaPmF+VNy8glFC
 J1me/H750kd0EcD9KDVlpF7VzwoY5t2D5ulekccoJex3vrII71v7ZEU2cSuWTt1cZjhtXDm7cnj
 uXr+zNqMlQn/Eza2TlWhzB0Z4zObqFgBZD5qoVgCv+M2wP/SOjhqFb+P8KIIags1IburqpIWhEI
 IeQdpct1XyEtoB4C8ouzrUNjwZzik8wa9pcOg/xD4qHfAVv2SUGsIZ6jyqjfqF+nog1L1R6tvMi
 Ieb3KHv2NdGSoiZHrxaaqy3O+frb4nsgVAy6qVCKxx5Oe2tg5fL8tAyfP3xO+m1dZHHEL+pXvQC
 jD5cvER4KB3tRU7On0gwO/kJ4dlQaR
X-Received: by 2002:a05:6830:6f84:b0:7d7:d2e2:9e7f with SMTP id
 46e09a7af769-7d7d2e2a435mr708654a34.16.1773840281352; 
 Wed, 18 Mar 2026 06:24:41 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9b38fbbsm2038492a34.13.2026.03.18.06.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 06:24:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] binman: Add Sphinx extension to auto-generate entry and
 bintool docs
Date: Wed, 18 Mar 2026 07:23:56 -0600
Message-ID: <20260318132400.1856600-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318132400.1856600-1-sjg@chromium.org>
References: <20260318132400.1856600-1-sjg@chromium.org>
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

Currently entries.rst and bintools.rst are generated manually by running
'binman entry-docs' and 'binman bintool-docs', then committed to the
repo. This means the docs can drift out of date when docstrings are
updated but the RST files are not regenerated.

Add a Sphinx extension (binman_docs) that provides two custom
directives:

    .. binman-entry-docs::
    .. binman-bintool-docs::

These parse the etype and btool source files using the ast module to
extract class docstrings, then insert the documentation directly into
the document tree. This avoids the need to import binman modules (which
have dependencies like libfdt that are not available in the ReadTheDocs
build environment) and avoids writing any intermediate files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/.gitignore            |   2 +
 doc/conf.py               |   3 +-
 doc/sphinx/binman_docs.py | 207 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 doc/sphinx/binman_docs.py

diff --git a/doc/.gitignore b/doc/.gitignore
index 53752db253e..7eeafcbf9fd 100644
--- a/doc/.gitignore
+++ b/doc/.gitignore
@@ -1 +1,3 @@
 output
+develop/package/entries.rst
+develop/package/bintools.rst
diff --git a/doc/conf.py b/doc/conf.py
index 84d028feda8..dfe053b169e 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -48,7 +48,8 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
               'kernel_abi', 'kernel_feat', 'sphinx-prompt',
-              'sphinx_reredirects', 'sphinx.ext.autodoc' ]
+              'sphinx_reredirects', 'sphinx.ext.autodoc',
+              'binman_docs' ]
 
 #
 # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
diff --git a/doc/sphinx/binman_docs.py b/doc/sphinx/binman_docs.py
new file mode 100644
index 00000000000..34d12f1b7d5
--- /dev/null
+++ b/doc/sphinx/binman_docs.py
@@ -0,0 +1,207 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2026 Simon Glass <sjg@chromium.org>
+#
+"""Sphinx extension to auto-generate binman entry and bintool documentation.
+
+This parses etype and btool source files using the ast module to extract
+class docstrings, avoiding the need to import binman modules (which have
+dependencies like libfdt that may not be available in the doc-build
+environment).
+
+The generated files are written to doc/develop/package/ (alongside
+binman.rst) and included via toctree directives. They are .gitignore'd
+since they are always regenerated during the build.
+
+To use, add 'binman_docs' to the extensions list in conf.py.
+"""
+
+import ast
+import os
+
+
+def get_entry_docstring(source_file):
+    """Extract the Entry_ class docstring from an etype source file.
+
+    Some files contain helper classes before the Entry_ class, so we look
+    specifically for a class whose name starts with 'Entry_'.
+
+    Args:
+        source_file: Path to the source file
+
+    Returns:
+        The docstring of the Entry_ class, or None
+    """
+    with open(source_file) as inf:
+        tree = ast.parse(inf.read())
+    for node in ast.iter_child_nodes(tree):
+        if isinstance(node, ast.ClassDef) and node.name.startswith('Entry_'):
+            return ast.get_docstring(node, clean=False)
+    return None
+
+
+def get_bintool_docstring(source_file):
+    """Extract the Bintool class docstring from a btool source file.
+
+    Args:
+        source_file: Path to the source file
+
+    Returns:
+        The docstring of the Bintool class, or None
+    """
+    with open(source_file) as inf:
+        tree = ast.parse(inf.read())
+    for node in ast.iter_child_nodes(tree):
+        if isinstance(node, ast.ClassDef) and node.name.startswith('Bintool'):
+            return ast.get_docstring(node, clean=False)
+    return None
+
+
+def generate_entry_docs(srcdir):
+    """Generate entries.rst content from etype source files.
+
+    Args:
+        srcdir: Root of the U-Boot source tree
+
+    Returns:
+        String containing RST content
+    """
+    etype_dir = os.path.join(srcdir, 'tools', 'binman', 'etype')
+    modules = sorted([
+        os.path.splitext(f)[0] for f in os.listdir(etype_dir)
+        if f.endswith('.py') and not f.startswith('_') and f != '__init__.py'
+    ])
+
+    parts = ['''\
+Binman Entry Documentation
+==========================
+
+This file describes the entry types supported by binman. These entry types can
+be placed in an image one by one to build up a final firmware image. It is
+fairly easy to create new entry types. Just add a new file to the 'etype'
+directory. You can use the existing entries as examples.
+
+Note that some entries are subclasses of others, using and extending their
+features to produce new behaviours.
+
+
+''']
+
+    missing = []
+    for name in modules:
+        source = os.path.join(etype_dir, name + '.py')
+        docs = get_entry_docstring(source)
+        if docs:
+            lines = docs.splitlines()
+            first_line = lines[0]
+            rest = [line[4:] for line in lines[1:]]
+            hdr = 'Entry: %s: %s' % (name.replace('_', '-'), first_line)
+
+            ref_name = 'etype_%s' % name
+            parts.append('.. _%s:' % ref_name)
+            parts.append('')
+            parts.append(hdr)
+            parts.append('-' * len(hdr))
+            parts.append('\n'.join(rest))
+            parts.append('')
+            parts.append('')
+        else:
+            missing.append(name)
+
+    if missing:
+        raise ValueError('Documentation is missing for modules: %s' %
+                         ', '.join(missing))
+
+    return '\n'.join(parts)
+
+
+def generate_bintool_docs(srcdir):
+    """Generate bintools.rst content from btool source files.
+
+    Args:
+        srcdir: Root of the U-Boot source tree
+
+    Returns:
+        String containing RST content
+    """
+    btool_dir = os.path.join(srcdir, 'tools', 'binman', 'btool')
+    fnames = [
+        f for f in os.listdir(btool_dir)
+        if f.endswith('.py') and not f.startswith('_') and f != '__init__.py'
+    ]
+
+    def tool_sort_name(fname):
+        name = os.path.splitext(fname)[0]
+        if name.startswith('btool_'):
+            name = name[6:]
+        return name
+
+    fnames.sort(key=tool_sort_name)
+
+    parts = ['''\
+.. SPDX-License-Identifier: GPL-2.0+
+
+Binman bintool Documentation
+============================
+
+This file describes the bintools (binary tools) supported by binman. Bintools
+are binman's name for external executables that it runs to generate or process
+binaries. It is fairly easy to create new bintools. Just add a new file to the
+'btool' directory. You can use existing bintools as examples.
+
+
+''']
+
+    missing = []
+    for fname in fnames:
+        name = os.path.splitext(fname)[0]
+        # Strip btool_ prefix used for modules that conflict with Python libs
+        if name.startswith('btool_'):
+            name = name[6:]
+        source = os.path.join(btool_dir, fname)
+        docs = get_bintool_docstring(source)
+        if docs:
+            lines = docs.splitlines()
+            first_line = lines[0]
+            rest = [line[4:] for line in lines[1:]]
+            hdr = 'Bintool: %s: %s' % (name, first_line)
+            parts.append(hdr)
+            parts.append('-' * len(hdr))
+            parts.append('\n'.join(rest))
+            parts.append('')
+            parts.append('')
+        else:
+            missing.append(name)
+
+    if missing:
+        raise ValueError('Documentation is missing for modules: %s' %
+                         ', '.join(missing))
+
+    return '\n'.join(parts)
+
+
+def generate_docs(app):
+    """Generate binman documentation RST files.
+
+    Called by Sphinx during the builder-inited event, before any RST files
+    are read.
+
+    Args:
+        app: The Sphinx application object
+    """
+    srcdir = os.path.abspath(os.path.join(app.srcdir, '..'))
+    outdir = os.path.join(app.srcdir, 'develop', 'package')
+
+    entries_rst = os.path.join(outdir, 'entries.rst')
+    content = generate_entry_docs(srcdir)
+    with open(entries_rst, 'w') as outf:
+        outf.write(content)
+
+    bintools_rst = os.path.join(outdir, 'bintools.rst')
+    content = generate_bintool_docs(srcdir)
+    with open(bintools_rst, 'w') as outf:
+        outf.write(content)
+
+
+def setup(app):
+    app.connect('builder-inited', generate_docs)
+    return {'version': '1.0', 'parallel_read_safe': True}
-- 
2.43.0

