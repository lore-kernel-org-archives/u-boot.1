Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FA1C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 13:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FA1881EC;
	Fri, 22 Mar 2024 14:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cyP8c+l2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DEB6881E2; Fri, 22 Mar 2024 14:10:35 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F140881D9
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 14:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42MDAQlM064664;
 Fri, 22 Mar 2024 08:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711113026;
 bh=QJFide4xxqZ2jKZfzrFj6/mZZ+X+uis589/b0xwd4PE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=cyP8c+l2DZxrJ+TVufoynGCUNF35Zv0NSuVWrol9a/5sGvQZBIL9tLYRkHX8veBgD
 D7XYocyqN34hb/B30RFazAgHFMQHGO10rKyDEj4ilmoZMynPqOjIN7qzi0xwVg/a3E
 GfAAOzirdiImDvqEIaam4/xmJdHmHonCe40N8dJE=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42MDAQJg080526
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Mar 2024 08:10:26 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Mar 2024 08:10:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Mar 2024 08:10:26 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42MDABZ9026606;
 Fri, 22 Mar 2024 08:10:21 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 2/4] tools: binman: control.py: Delete template nodes after
 parsing
Date: Fri, 22 Mar 2024 18:40:09 +0530
Message-ID: <20240322131011.1029620-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322131011.1029620-1-n-francis@ti.com>
References: <20240322131011.1029620-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Dynamically going through the subnode array and deleting leads to
templates being skipped from deletion when templates are consecutive in
the subnode list. Prevent this from happening by first parsing the DT
and then deleting the nodes.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 tools/binman/control.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 2f00279232b..1c4e6a581f9 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -522,9 +522,13 @@ def _ProcessTemplates(parent):
 def _RemoveTemplates(parent):
     """Remove any templates in the binman description
     """
+    del_nodes = []
     for node in parent.subnodes:
         if node.name.startswith('template'):
-            node.Delete()
+            del_nodes.append(node)
+
+    for node in del_nodes:
+        node.Delete()
 
 def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded):
     """Prepare the images to be processed and select the device tree
-- 
2.34.1

