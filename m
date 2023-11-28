Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E009DC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 19:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76BFC87784;
	Tue, 28 Nov 2023 20:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xXH0e/TM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE4B787561; Tue, 28 Nov 2023 20:40:33 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63D048776D
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 20:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJePuW105844
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:40:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701200425;
 bh=yF0OPdZiRLiCMJSd55MNGnnU6XaxKzeMxoP2SyCZjjQ=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=xXH0e/TMx39j9uwM4uFC0xtRU4zSW1tL/yfji3HQKEJxOfnuabt2ZheaqQRhBIB2k
 V4d6HB2hERZ4Hfa3RuhirOZc+int1MAvUhvG9G5lNNAZuGmJ+kIHTI+DSUTq13ntt4
 GJt7xmhRYvbgcJOtvO+F7yDbtLRCH9F61kj4Szmo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASJePj9025701
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:40:25 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 13:40:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 13:40:25 -0600
Received: from uda0271468c (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASJePfH015215;
 Tue, 28 Nov 2023 13:40:25 -0600
Received: from vishallocal by uda0271468c with local (Exim 4.90_1)
 (envelope-from <vishalm@ti.com>)
 id 1r83wX-0005Pw-3Z; Tue, 28 Nov 2023 13:40:25 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan
 Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: [PATCH 1/4] board: ti: am62x/am62ax: Formatting updates to board
 config files
Date: Tue, 28 Nov 2023 13:40:21 -0600
Message-ID: <20231128194024.20809-2-vishalm@ti.com>
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

Minor formatting updates to the rm board configuration file for
am62x and am62ax boards.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/am62ax/rm-cfg.yaml | 454 +++++++++++++-----------------------
 board/ti/am62x/rm-cfg.yaml  | 445 +++++++++++++----------------------
 2 files changed, 326 insertions(+), 573 deletions(-)

diff --git a/board/ti/am62ax/rm-cfg.yaml b/board/ti/am62ax/rm-cfg.yaml
index 15c4017bda..422f6fef98 100644
--- a/board/ti/am62ax/rm-cfg.yaml
+++ b/board/ti/am62ax/rm-cfg.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
 #
-# Resource management configuration for AM62ax
+# Resource management configuration for AM62A
 #
 
 ---
@@ -18,234 +18,234 @@ rm-cfg:
             host_cfg_entries:
                 - #1
                     host_id: 12
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
                 - #2
                     host_id: 30
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
                 - #3
                     host_id: 36
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
                 - #4
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #5
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #6
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #7
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #8
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #9
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #10
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #11
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #12
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #13
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #14
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #15
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #16
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #17
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #18
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #19
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #20
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #21
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #22
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #23
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #24
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #25
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #26
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #27
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #28
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #29
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #30
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #31
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #32
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
         resasg:
             subhdr:
                 magic: 0x7B25
-                size : 8
+                size: 8
             resasg_entries_size: 1032
-            reserved : 0
+            reserved: 0
     resasg_entries:
         -
                 start_resource: 0
@@ -253,896 +253,768 @@ rm-cfg:
                 type: 64
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 4
                 type: 64
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 4
                 type: 64
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 20
                 num_resource: 22
                 type: 64
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 16
                 type: 192
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 34
                 num_resource: 2
                 type: 192
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 4
                 type: 320
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 4
                 num_resource: 4
                 type: 320
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 26
                 type: 384
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 50176
                 num_resource: 164
                 type: 1666
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 1
                 type: 1667
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 18
                 type: 1677
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1677
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1677
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 24
                 num_resource: 2
                 type: 1677
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 26
                 num_resource: 6
                 type: 1677
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 54
                 num_resource: 18
                 type: 1678
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 72
                 num_resource: 6
                 type: 1678
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 72
                 num_resource: 6
                 type: 1678
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 78
                 num_resource: 2
                 type: 1678
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 80
                 num_resource: 2
                 type: 1678
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 32
                 num_resource: 12
                 type: 1679
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 44
                 num_resource: 6
                 type: 1679
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 44
                 num_resource: 6
                 type: 1679
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 50
                 num_resource: 2
                 type: 1679
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 52
                 num_resource: 2
                 type: 1679
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 18
                 type: 1696
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1696
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1696
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 24
                 num_resource: 2
                 type: 1696
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 26
                 num_resource: 6
                 type: 1696
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 18
                 type: 1697
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1697
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1697
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 24
                 num_resource: 2
                 type: 1697
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 26
                 num_resource: 2
                 type: 1697
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 12
                 type: 1698
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 12
                 num_resource: 6
                 type: 1698
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 12
                 num_resource: 6
                 type: 1698
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 2
                 type: 1698
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 20
                 num_resource: 2
                 type: 1698
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 6
                 num_resource: 34
                 type: 1802
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 44
                 num_resource: 36
                 type: 1802
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 44
                 num_resource: 36
                 type: 1802
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 168
                 num_resource: 8
                 type: 1802
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 14
                 num_resource: 512
                 type: 1805
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 526
                 num_resource: 256
                 type: 1805
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 526
                 num_resource: 256
                 type: 1805
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 782
                 num_resource: 128
                 type: 1805
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 910
                 num_resource: 626
                 type: 1805
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 1024
                 type: 1807
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 4096
                 num_resource: 29
                 type: 1808
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 4608
                 num_resource: 99
                 type: 1809
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 5120
                 num_resource: 24
                 type: 1810
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 5632
                 num_resource: 51
                 type: 1811
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 6144
                 num_resource: 51
                 type: 1812
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 6656
                 num_resource: 51
                 type: 1813
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 8192
                 num_resource: 32
                 type: 1814
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 8704
                 num_resource: 32
                 type: 1815
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 9216
                 num_resource: 32
                 type: 1816
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 9728
                 num_resource: 22
                 type: 1817
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 10240
                 num_resource: 22
                 type: 1818
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 10752
                 num_resource: 22
                 type: 1819
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 11264
                 num_resource: 28
                 type: 1820
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 11776
                 num_resource: 28
                 type: 1821
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 12288
                 num_resource: 28
                 type: 1822
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 1
                 type: 1923
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 10
                 type: 1936
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1936
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1936
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 13
                 num_resource: 3
                 type: 1936
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 3
                 type: 1936
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 64
                 type: 1937
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 64
                 type: 1937
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 83
                 num_resource: 8
                 type: 1938
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 91
                 num_resource: 8
                 type: 1939
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 99
                 num_resource: 10
                 type: 1942
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 109
                 num_resource: 3
                 type: 1942
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 109
                 num_resource: 3
                 type: 1942
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 112
                 num_resource: 3
                 type: 1942
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 115
                 num_resource: 3
                 type: 1942
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 118
                 num_resource: 16
                 type: 1943
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 118
                 num_resource: 16
                 type: 1943
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 134
                 num_resource: 8
                 type: 1944
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 134
                 num_resource: 8
                 type: 1945
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 142
                 num_resource: 8
                 type: 1946
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 142
                 num_resource: 8
                 type: 1947
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 10
                 type: 1955
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1955
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1955
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 13
                 num_resource: 3
                 type: 1955
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 3
                 type: 1955
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 8
                 type: 1956
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 8
                 type: 1956
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 27
                 num_resource: 1
                 type: 1957
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 28
                 num_resource: 1
                 type: 1958
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 10
                 type: 1961
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1961
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1961
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 13
                 num_resource: 3
                 type: 1961
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 3
                 type: 1961
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 10
                 type: 1962
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1962
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1962
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 13
                 num_resource: 3
                 type: 1962
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 3
                 type: 1962
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 1
                 type: 1963
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 1
                 type: 1963
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 16
                 type: 1964
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 16
                 type: 1964
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 20
                 num_resource: 1
                 type: 1965
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 35
                 num_resource: 8
                 type: 1966
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 21
                 num_resource: 1
                 type: 1967
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 35
                 num_resource: 8
                 type: 1968
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 22
                 num_resource: 1
                 type: 1969
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 43
                 num_resource: 8
                 type: 1970
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 23
                 num_resource: 1
                 type: 1971
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 43
                 num_resource: 8
                 type: 1972
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 1
                 type: 2112
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 2
                 num_resource: 2
                 type: 2122
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 51200
                 num_resource: 12
                 type: 12738
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 1
                 type: 12739
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 6
                 type: 12750
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 6
                 type: 12769
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 8
                 type: 12810
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 12288
                 num_resource: 128
                 type: 12813
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 3072
                 num_resource: 6
                 type: 12828
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 3584
                 num_resource: 6
                 type: 12829
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 4096
                 num_resource: 6
diff --git a/board/ti/am62x/rm-cfg.yaml b/board/ti/am62x/rm-cfg.yaml
index c28707be8e..a278675475 100644
--- a/board/ti/am62x/rm-cfg.yaml
+++ b/board/ti/am62x/rm-cfg.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
 #
-# Resource management configuration for AM62
+# Resource management configuration for AM62X
 #
 
 ---
@@ -18,234 +18,234 @@ rm-cfg:
             host_cfg_entries:
                 - #1
                     host_id: 12
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
                 - #2
                     host_id: 30
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
                 - #3
                     host_id: 36
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
                 - #4
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #5
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #6
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #7
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #8
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #9
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #10
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #11
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #12
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #13
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #14
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #15
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #16
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #17
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #18
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #19
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #20
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #21
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #22
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #23
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #24
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #25
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #26
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #27
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #28
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #29
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #30
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #31
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
                 - #32
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
         resasg:
             subhdr:
                 magic: 0x7B25
-                size : 8
+                size: 8
             resasg_entries_size: 960
-            reserved : 0
+            reserved: 0
     resasg_entries:
         -
                 start_resource: 0
@@ -253,833 +253,714 @@ rm-cfg:
                 type: 64
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 4
                 type: 64
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 4
                 type: 64
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 20
                 num_resource: 22
                 type: 64
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 16
                 type: 192
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 34
                 num_resource: 2
                 type: 192
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 4
                 type: 320
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 4
                 num_resource: 4
                 type: 320
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 26
                 type: 384
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 50176
                 num_resource: 164
                 type: 1666
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 1
                 type: 1667
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 18
                 type: 1677
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1677
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1677
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 24
                 num_resource: 2
                 type: 1677
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 26
                 num_resource: 6
                 type: 1677
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 54
                 num_resource: 18
                 type: 1678
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 72
                 num_resource: 6
                 type: 1678
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 72
                 num_resource: 6
                 type: 1678
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 78
                 num_resource: 2
                 type: 1678
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 80
                 num_resource: 2
                 type: 1678
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 32
                 num_resource: 12
                 type: 1679
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 44
                 num_resource: 6
                 type: 1679
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 44
                 num_resource: 6
                 type: 1679
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 50
                 num_resource: 2
                 type: 1679
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 52
                 num_resource: 2
                 type: 1679
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 18
                 type: 1696
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1696
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1696
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 24
                 num_resource: 2
                 type: 1696
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 26
                 num_resource: 6
                 type: 1696
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 18
                 type: 1697
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1697
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 6
                 type: 1697
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 24
                 num_resource: 2
                 type: 1697
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 26
                 num_resource: 2
                 type: 1697
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 12
                 type: 1698
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 12
                 num_resource: 6
                 type: 1698
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 12
                 num_resource: 6
                 type: 1698
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 18
                 num_resource: 2
                 type: 1698
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 20
                 num_resource: 2
                 type: 1698
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 5
                 num_resource: 35
                 type: 1802
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 44
                 num_resource: 36
                 type: 1802
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 44
                 num_resource: 36
                 type: 1802
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 168
                 num_resource: 8
                 type: 1802
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 13
                 num_resource: 512
                 type: 1805
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 525
                 num_resource: 256
                 type: 1805
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 525
                 num_resource: 256
                 type: 1805
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 781
                 num_resource: 128
                 type: 1805
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 909
                 num_resource: 627
                 type: 1805
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 1024
                 type: 1807
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 4096
                 num_resource: 29
                 type: 1808
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 4608
                 num_resource: 99
                 type: 1809
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 5120
                 num_resource: 24
                 type: 1810
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 5632
                 num_resource: 51
                 type: 1811
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 6144
                 num_resource: 51
                 type: 1812
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 6656
                 num_resource: 51
                 type: 1813
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 8192
                 num_resource: 32
                 type: 1814
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 8704
                 num_resource: 32
                 type: 1815
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 9216
                 num_resource: 32
                 type: 1816
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 9728
                 num_resource: 22
                 type: 1817
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 10240
                 num_resource: 22
                 type: 1818
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 10752
                 num_resource: 22
                 type: 1819
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 11264
                 num_resource: 28
                 type: 1820
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 11776
                 num_resource: 28
                 type: 1821
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 12288
                 num_resource: 28
                 type: 1822
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 1
                 type: 1923
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 10
                 type: 1936
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1936
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1936
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 13
                 num_resource: 3
                 type: 1936
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 3
                 type: 1936
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 64
                 type: 1937
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 64
                 type: 1937
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 83
                 num_resource: 8
                 type: 1938
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 91
                 num_resource: 8
                 type: 1939
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 99
                 num_resource: 10
                 type: 1942
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 109
                 num_resource: 3
                 type: 1942
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 109
                 num_resource: 3
                 type: 1942
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 112
                 num_resource: 3
                 type: 1942
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 115
                 num_resource: 3
                 type: 1942
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 118
                 num_resource: 16
                 type: 1943
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 118
                 num_resource: 16
                 type: 1943
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 134
                 num_resource: 8
                 type: 1944
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 134
                 num_resource: 8
                 type: 1945
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 142
                 num_resource: 8
                 type: 1946
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 142
                 num_resource: 8
                 type: 1947
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 10
                 type: 1955
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1955
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1955
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 13
                 num_resource: 3
                 type: 1955
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 3
                 type: 1955
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 8
                 type: 1956
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 8
                 type: 1956
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 27
                 num_resource: 1
                 type: 1957
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 28
                 num_resource: 1
                 type: 1958
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 10
                 type: 1961
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1961
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1961
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 13
                 num_resource: 3
                 type: 1961
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 3
                 type: 1961
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 10
                 type: 1962
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1962
                 host_id: 35
                 reserved: 0
-
         -
                 start_resource: 10
                 num_resource: 3
                 type: 1962
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 13
                 num_resource: 3
                 type: 1962
                 host_id: 30
                 reserved: 0
-
         -
                 start_resource: 16
                 num_resource: 3
                 type: 1962
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 1
                 type: 1963
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 1
                 type: 1963
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 16
                 type: 1964
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 19
                 num_resource: 16
                 type: 1964
                 host_id: 36
                 reserved: 0
-
         -
                 start_resource: 20
                 num_resource: 1
                 type: 1965
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 35
                 num_resource: 8
                 type: 1966
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 21
                 num_resource: 1
                 type: 1967
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 35
                 num_resource: 8
                 type: 1968
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 22
                 num_resource: 1
                 type: 1969
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 43
                 num_resource: 8
                 type: 1970
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 23
                 num_resource: 1
                 type: 1971
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 43
                 num_resource: 8
                 type: 1972
                 host_id: 12
                 reserved: 0
-
         -
                 start_resource: 0
                 num_resource: 1
                 type: 2112
                 host_id: 128
                 reserved: 0
-
         -
                 start_resource: 2
                 num_resource: 2
-- 
2.36.1

