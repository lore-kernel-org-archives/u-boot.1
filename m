Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99A3C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 19:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC5A58779A;
	Tue, 28 Nov 2023 20:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m/fywMnV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A4A87561; Tue, 28 Nov 2023 20:40:32 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507E0876D0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 20:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJeP48027857
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:40:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701200425;
 bh=MVQGdC6A4siUVrV1kikfYi14wY7qlMfPAK/btTL0Ph8=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=m/fywMnVMe+d5tev0Ewt2q39OGEsPyu0j7Jvp4qEMuzC/U1jXhr9zS+2QZ9l2qDoG
 LbNeB8xWtA8L2ZAYQZee9X2p2AJE1Z3OkEG1TX15J72r6cddJBBt5Y2BlyGfTCps8h
 rB98VGfkv683ZII1Wq20h+cceAmUWfg2hSpwxng8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASJePNk092201
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:40:25 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 13:40:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 13:40:25 -0600
Received: from uda0271468c (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJePhF127894;
 Tue, 28 Nov 2023 13:40:25 -0600
Received: from vishallocal by uda0271468c with local (Exim 4.90_1)
 (envelope-from <vishalm@ti.com>)
 id 1r83wX-0005QA-Cg; Tue, 28 Nov 2023 13:40:25 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan
 Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: [PATCH 3/4] board: ti: am62x/am62ax: Update MCU GPIO interrupt
 allocation in board config
Date: Tue, 28 Nov 2023 13:40:23 -0600
Message-ID: <20231128194024.20809-4-vishalm@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231128194024.20809-1-vishalm@ti.com>
References: <20231128194024.20809-1-vishalm@ti.com>
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

Share the MCU GPIO interrupts between A53 core and DM R5 core. Allocating
2 instances each to A53 and DM R5.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/am62ax/rm-cfg.yaml | 16 ++++++++++++++--
 board/ti/am62x/rm-cfg.yaml  | 16 ++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/board/ti/am62ax/rm-cfg.yaml b/board/ti/am62ax/rm-cfg.yaml
index 6e15366431..1fb7d64cb8 100644
--- a/board/ti/am62ax/rm-cfg.yaml
+++ b/board/ti/am62ax/rm-cfg.yaml
@@ -244,7 +244,7 @@ rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 1048
+            resasg_entries_size: 1064
             reserved: 0
     resasg_entries:
         -
@@ -285,10 +285,22 @@ rm-cfg:
                 reserved: 0
         -
                 start_resource: 0
-                num_resource: 4
+                num_resource: 2
                 type: 320
                 host_id: 12
                 reserved: 0
+        -
+                start_resource: 2
+                num_resource: 2
+                type: 320
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 2
+                type: 320
+                host_id: 36
+                reserved: 0
         -
                 start_resource: 4
                 num_resource: 4
diff --git a/board/ti/am62x/rm-cfg.yaml b/board/ti/am62x/rm-cfg.yaml
index a278675475..5a265ed1e8 100644
--- a/board/ti/am62x/rm-cfg.yaml
+++ b/board/ti/am62x/rm-cfg.yaml
@@ -244,7 +244,7 @@ rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 960
+            resasg_entries_size: 976
             reserved: 0
     resasg_entries:
         -
@@ -285,10 +285,22 @@ rm-cfg:
                 reserved: 0
         -
                 start_resource: 0
-                num_resource: 4
+                num_resource: 2
                 type: 320
                 host_id: 12
                 reserved: 0
+        -
+                start_resource: 2
+                num_resource: 2
+                type: 320
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 2
+                type: 320
+                host_id: 36
+                reserved: 0
         -
                 start_resource: 4
                 num_resource: 4
-- 
2.36.1

