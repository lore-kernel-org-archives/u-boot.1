Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FB2C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABCC680FF7;
	Wed, 23 Apr 2025 14:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fih0N7Ia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC65580F9C; Wed, 23 Apr 2025 14:30:19 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69FCA809D4
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85e73562577so602593839f.0
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745411415; x=1746016215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tOOdxXRem7JBVZ7vr7TC92xzz/faXsWqWj8y1ZBVOLs=;
 b=Fih0N7IaBys0fNNOLcKnGw6JmYtu3CIZZgUiqz0JBEyufR8Io/AUG4V9weVTz+yk/2
 aFvIlGp3aSZy2ee3RnU3AFxXnzZ1syeAArXn/JaoYoboyKdr9GDC1WmVcIj0oz0Gg6Hu
 Xml/qcgv0g6UHdea0qsj8dsfHKzyXhFfbkY3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411415; x=1746016215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tOOdxXRem7JBVZ7vr7TC92xzz/faXsWqWj8y1ZBVOLs=;
 b=wL2UlgwDnM89tLVVCCqrNjhmO5OGuO1SVsrIL3l0leySk7ffNO2pT3ITGCkvROCmPi
 Jp7AkrjK8pyrMpZjRrc0g9JL0EZDIG8rp50mRYQoPXgAaf+MCE5X/SoNqaMRQ/qIjgrx
 0oUMWFOnOXZBd2d+DOzHFeFoR7odCXRI/KoZCq1xUS6WEJJcqKXqPcXuzl35Lpkf0bBS
 xt6HmzT2WH7HwVUAVpFd1S4cXQonhuPea3lI55n9b/j+AmmoMUxV3xuWCbeGxtbB1CN3
 TQLXV17QubnsJIiGFdpOzwREruhh7c+Lbt0fcji5DGUvFqMKHi1+5J2XpDMJa6ifFyXd
 vgdQ==
X-Gm-Message-State: AOJu0Ywvv7+dPB7mp1ILfhELsAwhvxMeniszwMLKhQDNCBPBMwXd/aG8
 lrD8C7cBln6164PyV8QWpTnRI8HIe7T2xWnimpWhj2VEcl+kXusEr0VKNF2Hm+Ip2C7Byf9kJh0
 =
X-Gm-Gg: ASbGncvhJQoRYj5FNPPl7iyuNw0iPS+gGWLbTtE4O5fJHsL4kps05dBVDIUXlueo7KC
 FBTYrGDL6z35IJBFXqj+sYIw4fas1LCT5Cpcj+eusnccm/9lraOxVj0Bg+JM49t36CAbqVKd8Zs
 jqK0p0jITDY7hbBjuVmd/e3+I2jI3KGhaCyQNooFIwOz1O2O8ak5hUii5nQCsNdyt8cGl7piX8z
 Wjc6hzn5bQEWwhyfM66T0VPFa2ByiYaY4ciKbe24jMjOiBnzbwDzupxmfnln1jy5k/JbxTGPQpp
 6vJlzhkpzVHWDrXq23+ApMgYZHtYn4qsPyQnpRaLBIQf88d7V9M19ZWb6W3UzVpuJUNy6DgIBr6
 25g==
X-Google-Smtp-Source: AGHT+IFvvPZ4kenvplA/q9k9z6f+uJqtK0IHWKSNUKpTRY9uhpZRNHOk9PI9R+u7V0OHa/VdKekSIQ==
X-Received: by 2002:a05:6602:388f:b0:85b:5564:2d51 with SMTP id
 ca18e2360f4ac-861dbea5d98mr1962696439f.11.1745411415194; 
 Wed, 23 Apr 2025 05:30:15 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864447402a9sm30086239f.15.2025.04.23.05.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 05:30:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Moteen Shah <m-shah@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] tools: binman: control.py: Propagate bootph-* properties
 to supernodes
Date: Wed, 23 Apr 2025 06:29:32 -0600
Message-ID: <20250423123009.779628-1-sjg@chromium.org>
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

From: Moteen Shah <m-shah@ti.com>

Add a function to scan through all the nodes in the device-tree
recusively for bootph-* property. If found, propagate it to all
of its parent nodes up the hierarchy.

Signed-off-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/control.py | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 81f61e3e152..b703bdf482e 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -530,6 +530,35 @@ def _RemoveTemplates(parent):
     for node in del_nodes:
         node.Delete()
 
+def prop_bootph_to_parent(node, prop):
+    """Propagates bootph-* property to all the parent
+    nodes up the hierarchy
+    """
+    parent = node.parent
+    if parent == None or parent.props.get(prop):
+       return
+
+    while parent:
+        parent.AddEmptyProp(prop, 0)
+        parent = parent.parent
+
+def scan_and_prop_bootph(node):
+    """Scan the device tree and set the bootph-* property if its present
+    in subnode
+
+    This is used to set the bootph-* property in the parent node if a
+    "bootph-*" property is found in any of the subnodes of the parent
+    node.
+    """
+    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram', 'bootph-pre-sram']
+
+    for props in bootph_prop:
+        if node.props.get(props):
+            prop_bootph_to_parent(node, props)
+
+    for subnode in node.subnodes:
+       scan_and_prop_bootph(subnode)
+
 def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
     """Prepare the images to be processed and select the device tree
 
@@ -567,8 +596,10 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
         indir = []
     dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
     fname = tools.get_output_filename('u-boot.dtb.out')
-    tools.write_file(fname, tools.read_file(dtb_fname))
-    dtb = fdt.FdtScan(fname)
+    dtb = fdt.FdtScan(dtb_fname)
+    scan_and_prop_bootph(dtb.GetRoot())
+    dtb.Sync(True)
+    tools.write_file(dtb_fname, dtb.GetContents())
 
     node = _FindBinmanNode(dtb)
     if not node:
-- 
2.43.0

base-commit: 4446bc331c65d3efb8a9321d6368c61edb56479b
branch: try-ti2
