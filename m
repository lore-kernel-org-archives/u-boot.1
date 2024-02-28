Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AC2C54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1DA688084;
	Wed, 28 Feb 2024 12:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kVcmfkXN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 020778806F; Wed, 28 Feb 2024 12:21:07 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D9D8808B
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 12:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SBKvIT005791;
 Wed, 28 Feb 2024 05:20:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709119257;
 bh=QJFide4xxqZ2jKZfzrFj6/mZZ+X+uis589/b0xwd4PE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=kVcmfkXNyBhzTwQqVAfQcIH/3NXKbTd07IcJeno8VBYPO/4JUwb6m54do/jPgQ559
 q4jhP52q7WY/uq44PoCZxY6tPiVDKWbY+ZYMtWW9oMiyWkrA1FS1YuhUwpidnqPalT
 vC44brYlBVaPjUAbNXpeB9/Fc7Cl5gvC+d6F8GHY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SBKvTH067507
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Feb 2024 05:20:57 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 05:20:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 05:20:56 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SBKgNh027918;
 Wed, 28 Feb 2024 05:20:52 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [RFC PATCH 2/4] tools: binman: control.py: Delete template nodes
 after parsing
Date: Wed, 28 Feb 2024 16:50:40 +0530
Message-ID: <20240228112042.3437691-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228112042.3437691-1-n-francis@ti.com>
References: <20240228112042.3437691-1-n-francis@ti.com>
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

