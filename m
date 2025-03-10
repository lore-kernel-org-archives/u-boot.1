Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155D5C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 22:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7604680107;
	Mon, 10 Mar 2025 23:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g8AaBOJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D629811C1; Mon, 10 Mar 2025 23:03:03 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B331800C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 23:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52AM2vSR527743
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Mar 2025 17:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741644177;
 bh=C6z6LrkAW0gIJo+A6IdVqo7O2hh68lIE+7sN5rqCB0o=;
 h=From:To:CC:Subject:Date;
 b=g8AaBOJPrZ5GR3nejYWyts0Km3VXpvqQb32HILLuiPYXLcO1RsQIvCsX7l9MMI7Oi
 16iRTecrnDsW6m/Z+g3Mmb9D+1iDMbGSuBEDAltu9Tz0XtO+nXJVZ0RLu70i1RfuxW
 wSPvSLsPyvOHMikvjXzc2ExRD/PCvABUYozvz+HM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52AM2vS9056178;
 Mon, 10 Mar 2025 17:02:57 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Mar 2025 17:02:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Mar 2025 17:02:57 -0500
Received: from uda0271468c (uda0271468c.dhcp.ti.com [128.247.75.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52AM2vSt130202;
 Mon, 10 Mar 2025 17:02:57 -0500
Received: from vishallocal by uda0271468c with local (Exim 4.90_1)
 (envelope-from <vishalm@ti.com>)
 id 1trlD7-0006c3-3U; Mon, 10 Mar 2025 17:02:57 -0500
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>,
 <vigneshr@ti.com>
CC: Sebin Francis <sebin.francis@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>
Subject: [PATCH] board: ti: am62px: rm-cfg: Add support for HC BCDMA
Date: Mon, 10 Mar 2025 17:02:56 -0500
Message-ID: <20250310220257.25414-1-vishalm@ti.com>
X-Mailer: git-send-email 2.43.0
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

The first 4 block copy channels and rings on AM62P support
High Capacity Block Copy. These channels have approximately
3x improvement over the normal Block copy channels when doing
DDR-to-DDR copy.

Currently, during allocation these channels do not have a
separate interface and are allocated with normal BCDMA channels.

Latest TIFS and DM firmware adds support for differentiating these
High Capcity resources. This update is for allocating these new
resource type to different hosts with below mentioned scheme.

---------------------     ---------------   -------------  ----------------
    Resource                   A53_2           MCU_R5          WKUP_R5
---------------------     ---------------   -------------  ----------------
BCDMA HC CHAN [4]      =>   2 (Primary)     1 (Primary)      1 (Primary)
BCDMA HC CHAN RING [4] =>   2 (Primary)     1 (Primary)      1 (Primary)
BCDMA CHAN [4]         =>   18 (Primary)    2 (Primary)      6 (Primary)
BCDMA CHAN RING[4]     =>   18 (Primary)    2 (Primary)      6 (Primary)

Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
Signed-off-by: Sebin Francis <sebin.francis@ti.com>
Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---

This patch is based on commit 743c15b9fd (Merge patch series "This series
adds support for file renaming to EFI_FILE_PROTOCOL.SetInfo().") of the next
branch of U-Boot.

 board/ti/am62px/rm-cfg.yaml | 70 +++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/board/ti/am62px/rm-cfg.yaml b/board/ti/am62px/rm-cfg.yaml
index dc445a4b72f..73da85eeade 100644
--- a/board/ti/am62px/rm-cfg.yaml
+++ b/board/ti/am62px/rm-cfg.yaml
@@ -244,7 +244,7 @@ rm-cfg:
             subhdr:
                 magic: 0x7B25
                 size: 8
-            resasg_entries_size: 1048
+            resasg_entries_size: 1112
             reserved: 0
     resasg_entries:
         -
@@ -303,31 +303,55 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 0
+            num_resource: 2
+            type: 1676
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1676
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1676
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 1676
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 4
             num_resource: 18
             type: 1677
             host_id: 12
             reserved: 0
         -
-            start_resource: 18
+            start_resource: 22
             num_resource: 6
             type: 1677
             host_id: 35
             reserved: 0
         -
-            start_resource: 18
+            start_resource: 22
             num_resource: 6
             type: 1677
             host_id: 36
             reserved: 0
         -
-            start_resource: 24
+            start_resource: 28
             num_resource: 2
             type: 1677
             host_id: 30
             reserved: 0
         -
-            start_resource: 26
-            num_resource: 6
+            start_resource: 30
+            num_resource: 2
             type: 1677
             host_id: 128
             reserved: 0
@@ -387,31 +411,55 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 0
+            num_resource: 2
+            type: 1695
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1695
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1695
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 1695
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 4
             num_resource: 18
             type: 1696
             host_id: 12
             reserved: 0
         -
-            start_resource: 18
+            start_resource: 22
             num_resource: 6
             type: 1696
             host_id: 35
             reserved: 0
         -
-            start_resource: 18
+            start_resource: 22
             num_resource: 6
             type: 1696
             host_id: 36
             reserved: 0
         -
-            start_resource: 24
+            start_resource: 28
             num_resource: 2
             type: 1696
             host_id: 30
             reserved: 0
         -
-            start_resource: 26
-            num_resource: 6
+            start_resource: 30
+            num_resource: 2
             type: 1696
             host_id: 128
             reserved: 0
-- 
2.43.0

