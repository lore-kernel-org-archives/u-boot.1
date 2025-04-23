Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7E4C369D1
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F0781B4B;
	Wed, 23 Apr 2025 14:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IsHgbiYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42AA681FC0; Wed, 23 Apr 2025 14:30:25 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00EA9809D4
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85e46f5c50fso202213639f.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745411421; x=1746016221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKy6a/r7OfywVFr7HcQRPXAXJDmI62eGd97/rThZGUk=;
 b=IsHgbiYsV4LGymgjW7JF7a3gDOQLz9wo64D/wNtkhtySW25L8iEKLgvBTHkvUa54fQ
 VXrE0CK9J+Jl1TpcO8bo+n3Z1Xnz4I/A5uxMLfU6peW4d+HwtbOlUUaIm9C4nJSZ3A/b
 G5B9FuGUQdzwQYd7Wx8ZsYRkc2iHgvQUQL6Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411421; x=1746016221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKy6a/r7OfywVFr7HcQRPXAXJDmI62eGd97/rThZGUk=;
 b=QK/kBKvt40C2ggoqNp7hcwJUrBke0aUCbg4HuxD/948OXk0UkrwE+bpn8Q5qYlmJF7
 gwTbg5/rwNcNDFEINp1Zm3WYZrgyP4Z5Z+1izR5GYTyScwDjluD4f0zohi8F0AGlrpf1
 3ZE4Gx+wA7Hq4vSKlCEiFLCKWgj4W3OhhtNAqy8+h4Xg5NAnW+a3bcktHKXsCSPUSSdq
 9/mNZGW+54n9zjHNdJpDX04lhCfx3hcT5JY1Kb+QgMvbL+nZ56/Qsstc6JBYmAwxvBVu
 JVA0WbddGOE2Imxh5R8/Ycj1N4EeeG51ei/KRCz8nVhMdOZ6XA+zU2acAC8zw6ghKfOg
 LVtA==
X-Gm-Message-State: AOJu0YwDQvXWGSPg6DG3iOG5TgbTkDi91Sx3Ty2PvbbG4vPJC3oCgUUH
 sXYt7WYClQDkNC6S8tSU1PmXqC05j2m9g8U0VCiQrsUeQGDbogMXoovH1fsn7PriZv0TNUdyTJ4
 =
X-Gm-Gg: ASbGncszO4qXk8Py8V7/Yy75UFSmsSo2XQsse1XBcCopTBRrIWueEb/lyqis39kUEsd
 RcWOMVj1PVCh8L4TwjPyetXwmvbEwS73dmw/XpIBO8PnC9jd/dt2OcRJLpVglzEHDS3Y6MM1gRx
 70JvUXfsHTsLsYEe7g1rrB7ZJRQIZRk3lpxit1Ne+jz+fIH4+Y0T+mAGqTdgZmsZ7Yj2I3Vkbyo
 EzyXfI7BEM3NYrINkJjgCNx5Y9YcZLbIM1Nb4t/xiK1EbKvPeptKB66Iy9JT/7GSDDEq5fpY0G0
 VJnv/DDk71qtp5xGe8XJQz6axy843PngDvb9sCAhltheHy7p3gfEwU48Ju1TGdhjAVkoNQajWol
 ziQ==
X-Google-Smtp-Source: AGHT+IEz3E6nIdFrp1LyLZcfP8OG4gIkspFATu/AzLGffPDWYlqHzEJgv9uTGE1BctDUNnUkP/nTbQ==
X-Received: by 2002:a05:6602:4893:b0:85b:3a51:2923 with SMTP id
 ca18e2360f4ac-861dbee016dmr2274553739f.14.1745411420719; 
 Wed, 23 Apr 2025 05:30:20 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864447402a9sm30086239f.15.2025.04.23.05.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 05:30:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Moteen Shah <m-shah@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] wip: binman: Move processing after templates
Date: Wed, 23 Apr 2025 06:29:34 -0600
Message-ID: <20250423123009.779628-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423123009.779628-1-sjg@chromium.org>
References: <20250423123009.779628-1-sjg@chromium.org>
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

Do the bootph processing after templates are handled, since templates
can change the tree structure quite a bit.

Also avoid changing the u-boot.dtb file since that is an input to Binman

Add some other suggested code tweaks:
- Only sync the dtb if something changed
- add more comments

Note: This patch is just for illustration; please just combine it into
your existing work.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/control.py | 70 +++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index b703bdf482e..6b7c5507513 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -530,34 +530,55 @@ def _RemoveTemplates(parent):
     for node in del_nodes:
         node.Delete()
 
-def prop_bootph_to_parent(node, prop):
-    """Propagates bootph-* property to all the parent
-    nodes up the hierarchy
-    """
-    parent = node.parent
-    if parent == None or parent.props.get(prop):
-       return
+def propagate_bootph(node, prop):
+    """Propagate bootph-* property to all the parent nodes up the hierarchy
+
+    Args:
+        node (fdt.Node): Node to propagate the property to
+        prop (str): Property to propagate
 
-    while parent:
-        parent.AddEmptyProp(prop, 0)
-        parent = parent.parent
+    Return:
+        True if any change was made, else False
+    """
+    changed = False
+    while node:
+        if prop not in node.props:
+            node.AddEmptyProp(prop, 0)
+            changed = True
+        node = node.parent
+    return changed
 
 def scan_and_prop_bootph(node):
-    """Scan the device tree and set the bootph-* property if its present
-    in subnode
+    """Propagate bootph properties from children to parents
+
+    The bootph schema indicates that bootph nodes in children should be implied
+    in their parents, all the way up the hierarchy. This is expensive to
+    implement in U-Boot before relocation, so this function explicitly
+    propagates these bootph properties upwards.
 
     This is used to set the bootph-* property in the parent node if a
-    "bootph-*" property is found in any of the subnodes of the parent
-    node.
+    "bootph-*" property is found in any of the parent's subnodes.
+
+    Args:
+        node (fdt.Node): Node to propagate the property to
+        prop (str): Property name to propagate
+
+    Return:
+        True if any change was made, else False
+
     """
-    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram', 'bootph-pre-sram']
+    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram',
+                   'bootph-pre-sram']
 
-    for props in bootph_prop:
-        if node.props.get(props):
-            prop_bootph_to_parent(node, props)
+    changed = False
+    for prop in bootph_prop:
+        if prop in node.props:
+            changed |= propagate_bootph(node.parent, prop)
 
     for subnode in node.subnodes:
-       scan_and_prop_bootph(subnode)
+        changed |= scan_and_prop_bootph(subnode)
+    return changed
+
 
 def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
     """Prepare the images to be processed and select the device tree
@@ -573,7 +594,7 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
         dtb_fname: Filename of the device tree file to use (.dts or .dtb)
         selected_images: List of images to output, or None for all
         update_fdt: True to update the FDT wth entry offsets, etc.
-        use_expanded: True to use expanded versions of entries, if available.
+        use_expanded: True to use expanded versions osf entries, if available.
             So if 'u-boot' is called for, we use 'u-boot-expanded' instead. This
             is needed if update_fdt is True (although tests may disable it)
         indir: List of directories where input files can be found
@@ -596,10 +617,8 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
         indir = []
     dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
     fname = tools.get_output_filename('u-boot.dtb.out')
-    dtb = fdt.FdtScan(dtb_fname)
-    scan_and_prop_bootph(dtb.GetRoot())
-    dtb.Sync(True)
-    tools.write_file(dtb_fname, dtb.GetContents())
+    tools.write_file(fname, tools.read_file(dtb_fname))
+    dtb = fdt.FdtScan(fname)
 
     node = _FindBinmanNode(dtb)
     if not node:
@@ -620,6 +639,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
         fname = tools.get_output_filename('u-boot.dtb.tmpl2')
         tools.write_file(fname, dtb.GetContents())
 
+    if scan_and_prop_bootph(dtb.GetRoot()):
+        dtb.Sync(True)
+
     images = _ReadImageDesc(node, use_expanded)
 
     if select_images:
-- 
2.43.0

base-commit: 4446bc331c65d3efb8a9321d6368c61edb56479b
branch: try-ti2
