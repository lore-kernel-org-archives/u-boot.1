Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63225C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 11:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7B4829E4;
	Mon, 12 May 2025 13:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xQmOYYed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 502A3829E4; Mon, 12 May 2025 13:50:45 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B8CF826AA
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 13:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54CBoaRa1970505;
 Mon, 12 May 2025 06:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747050636;
 bh=nw3vS7ybUrT9koZm1/isD66LqMhVzQsjy3R20POTlLE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xQmOYYedbrMvANqzg7rgFV8Bq0hnnCgkUJjQ+zwAsAQfGRuaN5U4XY79/FFpJuv0M
 AS/hkNqyCyN0Tz1zsQ7AlbmPn9J5uyXgiBgLooIqFeu6Q9mlGpUMkVhyaGBr5m3RWX
 vseVKHwHtxJTnjAb1tafxXVatLE8kEE01uN+q3Kw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54CBoa1b1092435
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 12 May 2025 06:50:36 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 May 2025 06:50:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 May 2025 06:50:36 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54CBoTHR078360;
 Mon, 12 May 2025 06:50:33 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <quentin.schulz@cherry.de>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>
Subject: [PATCH 1/2] tools: binman: control.py: Propagate bootph-* properties
 to supernodes
Date: Mon, 12 May 2025 17:20:27 +0530
Message-ID: <20250512115028.1783305-2-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512115028.1783305-1-m-shah@ti.com>
References: <20250512115028.1783305-1-m-shah@ti.com>
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
for bootph-* property. If found, propagate it to all of its parent
nodes up the hierarchy.

Signed-off-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---
 tools/binman/control.py | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 81f61e3e152..ccf081cb686 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -530,6 +530,54 @@ def _RemoveTemplates(parent):
     for node in del_nodes:
         node.Delete()
 
+def propagate_bootph(node, prop):
+    """Propagate bootph-* property to all the parent nodes up the hierarchy
+
+    Args:
+        node (fdt.Node): Node to propagate the property to
+        prop (str): Property to propagate
+
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
+
+def scan_and_prop_bootph(node):
+    """Propagate bootph properties from children to parents
+
+    The bootph schema indicates that bootph nodes in children should be implied
+    in their parents, all the way up the hierarchy. This is expensive to
+    implement in U-Boot before relocation, so this function explicitly
+    propagates these bootph properties upwards.
+
+    This is used to set the bootph-* property in the parent node if a
+    "bootph-*" property is found in any of the parent's subnodes.
+
+    Args:
+        node (fdt.Node): Node to propagate the property to
+        prop (str): Property name to propagate
+
+    Return:
+        True if any change was made, else False
+
+    """
+    bootph_prop = ['bootph-all', 'bootph-some-ram']
+
+    changed = False
+    for prop in bootph_prop:
+        if prop in node.props:
+            changed |= propagate_bootph(node.parent, prop)
+
+    for subnode in node.subnodes:
+        changed |= scan_and_prop_bootph(subnode)
+    return changed
+
 def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
     """Prepare the images to be processed and select the device tree
 
@@ -589,6 +637,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
         fname = tools.get_output_filename('u-boot.dtb.tmpl2')
         tools.write_file(fname, dtb.GetContents())
 
+    if scan_and_prop_bootph(dtb.GetRoot()):
+        dtb.Sync(True)
+
     images = _ReadImageDesc(node, use_expanded)
 
     if select_images:
-- 
2.34.1

