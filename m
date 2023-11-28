Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75365C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 19:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8FDB87779;
	Tue, 28 Nov 2023 20:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sesA07ZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E19A0876B5; Tue, 28 Nov 2023 20:40:32 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21AC28769A
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 20:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJePX0040274
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:40:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701200425;
 bh=XHrCZnZxFpJ3Fji8EfFs8Y9CkLiKETm67ekCmPJ8O60=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=sesA07ZBW8hCUQyIZXu646yPJQH9LRtphCUdIzNPpCD3YSYDz6Vy29+npWGFpXPqj
 kZ17OoS+xD7ThS3pvU0txKvYqtHGDXbacVEWNLvj9pO6Ji7b+Z/zEaQQFND1k+KTCZ
 kR9DD79CfHME86teQHhcmatmSWS8gE1GqJJm1a2I=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASJePPq011223
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:40:25 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 13:40:25 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 13:40:25 -0600
Received: from uda0271468c (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJePjJ008527;
 Tue, 28 Nov 2023 13:40:25 -0600
Received: from vishallocal by uda0271468c with local (Exim 4.90_1)
 (envelope-from <vishalm@ti.com>)
 id 1r83wX-0005Q3-8r; Tue, 28 Nov 2023 13:40:25 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan
 Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: [PATCH 2/4] board: ti: am62ax: Add C7x resource allocation entries to
 board config
Date: Tue, 28 Nov 2023 13:40:22 -0600
Message-ID: <20231128194024.20809-3-vishalm@ti.com>
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

Update am62ax rm-cfg with allocation entries for C7x core. Following
updates are added for C7x:
- Share split BCDMA tx and rx channels between DM R5 and C7x
- Share rings for split BCDMA tx and rx channels between DM R5 and C7x
- Add Global events and Virtual interrupts for C7x

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/am62ax/rm-cfg.yaml | 46 +++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/board/ti/am62ax/rm-cfg.yaml b/board/ti/am62ax/rm-cfg.yaml
index 422f6fef98..6e15366431 100644
--- a/board/ti/am62ax/rm-cfg.yaml
+++ b/board/ti/am62ax/rm-cfg.yaml
@@ -24,26 +24,26 @@ rm-cfg:
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
                 - #2
-                    host_id: 30
+                    host_id: 20
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
                 - #3
-                    host_id: 36
+                    host_id: 30
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
                 - #4
-                    host_id: 0
-                    allowed_atype: 0
-                    allowed_qos: 0
-                    allowed_orderid: 0
-                    allowed_priority: 0
-                    allowed_sched_priority: 0
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
                 - #5
                     host_id: 0
                     allowed_atype: 0
@@ -244,7 +244,7 @@ rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 1032
+            resasg_entries_size: 1048
             reserved: 0
     resasg_entries:
         -
@@ -323,7 +323,7 @@ rm-cfg:
                 start_resource: 18
                 num_resource: 6
                 type: 1677
-                host_id: 35
+                host_id: 20
                 reserved: 0
         -
                 start_resource: 18
@@ -353,7 +353,7 @@ rm-cfg:
                 start_resource: 72
                 num_resource: 6
                 type: 1678
-                host_id: 35
+                host_id: 20
                 reserved: 0
         -
                 start_resource: 72
@@ -383,7 +383,7 @@ rm-cfg:
                 start_resource: 44
                 num_resource: 6
                 type: 1679
-                host_id: 35
+                host_id: 20
                 reserved: 0
         -
                 start_resource: 44
@@ -413,7 +413,7 @@ rm-cfg:
                 start_resource: 18
                 num_resource: 6
                 type: 1696
-                host_id: 35
+                host_id: 20
                 reserved: 0
         -
                 start_resource: 18
@@ -443,7 +443,7 @@ rm-cfg:
                 start_resource: 18
                 num_resource: 6
                 type: 1697
-                host_id: 35
+                host_id: 20
                 reserved: 0
         -
                 start_resource: 18
@@ -473,7 +473,7 @@ rm-cfg:
                 start_resource: 12
                 num_resource: 6
                 type: 1698
-                host_id: 35
+                host_id: 20
                 reserved: 0
         -
                 start_resource: 12
@@ -495,10 +495,16 @@ rm-cfg:
                 reserved: 0
         -
                 start_resource: 6
-                num_resource: 34
+                num_resource: 26
                 type: 1802
                 host_id: 12
                 reserved: 0
+        -
+                start_resource: 32
+                num_resource: 8
+                type: 1802
+                host_id: 20
+                reserved: 0
         -
                 start_resource: 44
                 num_resource: 36
@@ -543,7 +549,13 @@ rm-cfg:
                 reserved: 0
         -
                 start_resource: 910
-                num_resource: 626
+                num_resource: 128
+                type: 1805
+                host_id: 20
+                reserved: 0
+        -
+                start_resource: 1038
+                num_resource: 498
                 type: 1805
                 host_id: 128
                 reserved: 0
-- 
2.36.1

