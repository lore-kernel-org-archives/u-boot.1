Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61359E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 11:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75ECC80283;
	Tue, 17 Dec 2024 12:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FL028Poa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF112801CF; Tue, 17 Dec 2024 12:07:53 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6B980243
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHB7gMM3466748
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2024 05:07:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734433662;
 bh=D+tQpyVSxnV9Y48qckkxPNBbCYSV7GeSQAvMV9+0C9I=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=FL028Poa8cCdRZyeHh/v7cOVarKh51yjTVHXai3XhYn6UorpzSpkyH8iMCU867IvJ
 Cv7F+l3lIGZP9RmZlfiZZnWaf7RYMMKQlrJZ0lLNWOnAeNPTARAGiXpo3VQbdc6Cbq
 HdGvDPHqNe+YY7Tz46PFEDSgxtXchOZsy01QzsdM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHB7g70018313
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Dec 2024 05:07:42 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 05:07:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 05:07:41 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.160])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BHB7Wba013855;
 Tue, 17 Dec 2024 05:07:37 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 17 Dec 2024 16:37:18 +0530
Subject: [PATCH RFC 1/8] tools: binman: control.py: Delete template nodes
 after parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241217-b4-upstream-j742s2-v1-1-13a6a127b344@ti.com>
References: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
In-Reply-To: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734433652; l=1158;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=kS5w2H7PIi73rQuVWejO2XK8Aeg7BKISWeZYY0dk4h8=;
 b=iMP2w3RIEgkRUDs5wuihm1IOpqY6I4C3i4AqmNd79cCytg3ZXTbejk9Y4vjBtHlAd0i8cDvkB
 4iNLrGubn8UC5xNgmZOJPzMcUbMOlN9jrNrC0wG2pEy2O9AgVEpwVZw
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

From: Neha Malcom Francis <n-francis@ti.com>

Dynamically going through the subnode array and deleting leads to
templates being skipped from deletion when templates are consecutive in
the subnode list. Prevent this from happening by first parsing the DT
and then deleting the nodes.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 tools/binman/control.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 542c2b456449a9b1135a6c969984ace099ab8792..5b33c488f33b6a3593ff7e6c5f9a7065f54ae169 100644
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

