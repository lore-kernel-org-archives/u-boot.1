Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D75CE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D98805DF;
	Mon,  6 Jan 2025 10:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BVuWS6Zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB5A805DF; Mon,  6 Jan 2025 10:35:39 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F26C801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5069ZSwi2468132
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jan 2025 03:35:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736156129;
 bh=iKJN9W5U99E9gIPT+6TCenrfv82kU45r7IS68MFA4Aw=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=BVuWS6ZxJkoUnQgbhh5z11Rmnwz4mA8QiUP8G9FO9ZgidLu81vXcmblTd4Chft6dU
 YCi9P5uQgomIZlhxGtlFyTkViAABlKk7qlyAS8I1+O9ZnaYRJWDONa6b5DU/i+Fr88
 My4+7wvO8Hs8k4Fh0fB66pPxx+hvq4/4C2aK5Gf0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5069ZSp3003674
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Jan 2025 03:35:28 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 03:35:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 03:35:28 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.160])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5069ZJEx028930;
 Mon, 6 Jan 2025 03:35:24 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 6 Jan 2025 15:04:57 +0530
Subject: [PATCH RFC v2 1/8] tools: binman: control.py: Delete template
 nodes after parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250106-b4-upstream-j742s2-v2-1-42d6129ce333@ti.com>
References: <20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com>
In-Reply-To: <20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736156119; l=1210;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=g7bAa6UcPpqZuYP8z9v/PIeOY1hIUrxeVJZw6VvoADE=;
 b=QP3cvvqplNC2xjftmtleAJs5KmCvqGe0qASio0tgsn+gaUNfkBw+GbX7by8N4V2ifjL2DFuo+
 wyKjZVAsCPgAt7ZhXoFhBw+jOk/yCJfuECPRNC0gjj7t4PxXKwh+wVn
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 tools/binman/control.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index e73c598298cef76cfdf4f0f8a021feac1e7b825a..81f61e3e152a9eab558cfc9667131a38082b61a1 100644
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
 
 def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
     """Prepare the images to be processed and select the device tree

-- 
2.34.1

