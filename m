Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFA0C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 08:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAD281951;
	Thu, 27 Mar 2025 09:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UxFqNZbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA37C81CFD; Thu, 27 Mar 2025 09:06:58 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DF2806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52R86otl2424327
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 03:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743062810;
 bh=zuyNaz1dqNaLT2yQxjEHj4f/AWK32gg+dSDGBsKmMGY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UxFqNZbhFroKtnFm0108T/KyepckwxXiICUVp1FYQD24Yg4SMvrMnC6gHvHPMhKUn
 aopVB21pGb3BRmczGpHoFtIQsvKgqW2vtl0fDTbbQ8A8UtJFglI7dSME/cYWs06onn
 bwPliLy7E+IGAkmBFV61oiT27cZRnXxjGy4A5+hU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52R86oH3008765
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Mar 2025 03:06:50 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Mar 2025 03:06:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Mar 2025 03:06:50 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52R86g7w078860;
 Thu, 27 Mar 2025 03:06:46 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <quentin.schulz@cherry.de>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>, <m-shah@ti.com>
Subject: [RFC PATCH 1/2 v2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
Date: Thu, 27 Mar 2025 13:36:41 +0530
Message-ID: <20250327080642.2269856-2-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327080642.2269856-1-m-shah@ti.com>
References: <20250327080642.2269856-1-m-shah@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Add a function to scan through all the nodes in the device-tree
recusively for bootph-* property. If found, propagate it to all
of its parent nodes up the hierarchy.

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 tools/binman/control.py | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index e73c598298c..e739949d366 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -526,6 +526,35 @@ def _RemoveTemplates(parent):
         if node.name.startswith('template'):
             node.Delete()
 
+def prop_bootph_to_parent(node, prop, dtb):
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
+def scan_and_prop_bootph(node, dtb):
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
+            prop_bootph_to_parent(node, props, dtb)
+
+    for subnode in node.subnodes:
+       scan_and_prop_bootph(subnode, dtb)
+
 def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
     """Prepare the images to be processed and select the device tree
 
@@ -563,7 +592,11 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
         indir = []
     dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
     fname = tools.get_output_filename('u-boot.dtb.out')
-    tools.write_file(fname, tools.read_file(dtb_fname))
+    dtb = fdt.FdtScan(dtb_fname)
+    scan_and_prop_bootph(dtb.GetRoot(), dtb)
+    dtb.Sync(True)
+    tools.write_file(dtb_fname, dtb.GetContents())
+    tools.write_file(fname, dtb.GetContents())
     dtb = fdt.FdtScan(fname)
 
     node = _FindBinmanNode(dtb)
-- 
2.34.1

