Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAE1C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 19:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659798769A;
	Tue, 28 Nov 2023 20:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="waCEgnlX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E32987792; Tue, 28 Nov 2023 20:40:32 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F3387701
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 20:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJePLP105848
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:40:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701200426;
 bh=JNlC3hLZdhUy0YIS/tWxnmjn6fUFGLjV2uIfcH/3oKk=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=waCEgnlX79125jh8pZ/raeLMTOVdgHeyUYtUJR0x2Lh4CkK6QSBOsCKv5PNkwCIIn
 00Xryx3/S0zsaIuzyded8LRpONv27WleXDdWAiAZP7mJ7+7LGbZRgQEoZ1i+IUVz0B
 5ryHVm//yOOEpXpgUboHp/bQn2+xeC8F3LjeB87U=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASJePUe039919
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:40:25 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 13:40:25 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 13:40:25 -0600
Received: from uda0271468c (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJePp6087746;
 Tue, 28 Nov 2023 13:40:25 -0600
Received: from vishallocal by uda0271468c with local (Exim 4.90_1)
 (envelope-from <vishalm@ti.com>)
 id 1r83wX-0005QH-Gl; Tue, 28 Nov 2023 13:40:25 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan
 Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: [PATCH 4/4] board: ti: am62x/am62ax: Update virtual interrupt
 allocations in board config
Date: Tue, 28 Nov 2023 13:40:24 -0600
Message-ID: <20231128194024.20809-5-vishalm@ti.com>
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

Updates as a result of TIFS core now reserving a virtual interrupt
for enabling interrupts between DM to TIFS core. Because of this
change other virtual interrupt counts decrease by one.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/am62ax/rm-cfg.yaml | 22 +++++++++++-----------
 board/ti/am62x/rm-cfg.yaml  | 20 ++++++++++----------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/board/ti/am62ax/rm-cfg.yaml b/board/ti/am62ax/rm-cfg.yaml
index 1fb7d64cb8..b9f3668c07 100644
--- a/board/ti/am62ax/rm-cfg.yaml
+++ b/board/ti/am62ax/rm-cfg.yaml
@@ -518,14 +518,14 @@ rm-cfg:
                 host_id: 20
                 reserved: 0
         -
-                start_resource: 44
-                num_resource: 36
+                start_resource: 45
+                num_resource: 35
                 type: 1802
                 host_id: 35
                 reserved: 0
         -
-                start_resource: 44
-                num_resource: 36
+                start_resource: 45
+                num_resource: 35
                 type: 1802
                 host_id: 36
                 reserved: 0
@@ -536,38 +536,38 @@ rm-cfg:
                 host_id: 30
                 reserved: 0
         -
-                start_resource: 14
+                start_resource: 15
                 num_resource: 512
                 type: 1805
                 host_id: 12
                 reserved: 0
         -
-                start_resource: 526
+                start_resource: 527
                 num_resource: 256
                 type: 1805
                 host_id: 35
                 reserved: 0
         -
-                start_resource: 526
+                start_resource: 527
                 num_resource: 256
                 type: 1805
                 host_id: 36
                 reserved: 0
         -
-                start_resource: 782
+                start_resource: 783
                 num_resource: 128
                 type: 1805
                 host_id: 30
                 reserved: 0
         -
-                start_resource: 910
+                start_resource: 911
                 num_resource: 128
                 type: 1805
                 host_id: 20
                 reserved: 0
         -
-                start_resource: 1038
-                num_resource: 498
+                start_resource: 1039
+                num_resource: 497
                 type: 1805
                 host_id: 128
                 reserved: 0
diff --git a/board/ti/am62x/rm-cfg.yaml b/board/ti/am62x/rm-cfg.yaml
index 5a265ed1e8..c06232f6dd 100644
--- a/board/ti/am62x/rm-cfg.yaml
+++ b/board/ti/am62x/rm-cfg.yaml
@@ -512,14 +512,14 @@ rm-cfg:
                 host_id: 12
                 reserved: 0
         -
-                start_resource: 44
-                num_resource: 36
+                start_resource: 45
+                num_resource: 35
                 type: 1802
                 host_id: 35
                 reserved: 0
         -
-                start_resource: 44
-                num_resource: 36
+                start_resource: 45
+                num_resource: 35
                 type: 1802
                 host_id: 36
                 reserved: 0
@@ -530,32 +530,32 @@ rm-cfg:
                 host_id: 30
                 reserved: 0
         -
-                start_resource: 13
+                start_resource: 14
                 num_resource: 512
                 type: 1805
                 host_id: 12
                 reserved: 0
         -
-                start_resource: 525
+                start_resource: 526
                 num_resource: 256
                 type: 1805
                 host_id: 35
                 reserved: 0
         -
-                start_resource: 525
+                start_resource: 526
                 num_resource: 256
                 type: 1805
                 host_id: 36
                 reserved: 0
         -
-                start_resource: 781
+                start_resource: 782
                 num_resource: 128
                 type: 1805
                 host_id: 30
                 reserved: 0
         -
-                start_resource: 909
-                num_resource: 627
+                start_resource: 910
+                num_resource: 626
                 type: 1805
                 host_id: 128
                 reserved: 0
-- 
2.36.1

