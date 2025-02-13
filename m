Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F40C021A8
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 07:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DF2880EAF;
	Thu, 13 Feb 2025 08:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d09/Yupy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687D3806FE; Thu, 13 Feb 2025 08:37:07 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35A2A80C96
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 08:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51D7apHl598235
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Feb 2025 01:36:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739432211;
 bh=iKJN9W5U99E9gIPT+6TCenrfv82kU45r7IS68MFA4Aw=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=d09/Yupy51k+SMLDYsV1mFY4nQo5IG3zRpDBMenJJbLjlNnEinVdgQrDpC0lKNQ3E
 kGqYNKKqswyyKGo7vXiEtWv60g6UL7jqg5lIckdB+3eUys4Sof5tzRl4RLRr+H4Tjk
 HU3IKzmizeeI5P82BFKM3VXSZPY3rRk4aI+stQx0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51D7apgb105855;
 Thu, 13 Feb 2025 01:36:51 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 01:36:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 01:36:51 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51D7agtQ101327;
 Thu, 13 Feb 2025 01:36:47 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 13 Feb 2025 13:06:38 +0530
Subject: [PATCH v3 1/8] tools: binman: control.py: Delete template nodes
 after parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-b4-upstream-j742s2-v3-1-e00f2a73efb0@ti.com>
References: <20250213-b4-upstream-j742s2-v3-0-e00f2a73efb0@ti.com>
In-Reply-To: <20250213-b4-upstream-j742s2-v3-0-e00f2a73efb0@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739432202; l=1210;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=g7bAa6UcPpqZuYP8z9v/PIeOY1hIUrxeVJZw6VvoADE=;
 b=wSsR3FfPcCFa/ijjcKIAo5rnwH8aCdZCUuKlpd01QNGwg2lqJVRKRmwTRnGDtlgYuswFCM05h
 R09x3sOCEumDWKVpSok2xw2LQO6f0YWn2qQAdJnJQQQLT9COc7DVzv8
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

