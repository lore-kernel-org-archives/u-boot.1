Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259CEC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 05:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C768083E;
	Fri, 28 Feb 2025 06:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J8/LyF3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17BE480BA4; Fri, 28 Feb 2025 06:42:31 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2CF2801FB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 06:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51S5gPNq1965394
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 27 Feb 2025 23:42:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740721345;
 bh=G7H0gG//yIStercl6E4/PbQtvDfjxE2K0WwWxjE0z0U=;
 h=From:To:CC:Subject:Date;
 b=J8/LyF3QFdv6EHm77C45WHa0IvdTbvo9D8J26WoGTrcb89SF4gZuTYH6plYk5opNx
 86fkpGVk5bf1ae5GIc1oHp9bFQ/LSSK4rNYPEnFhL+FD2akMND6e9f/B5V7Zws3V0f
 2BMX+DsL+rvWsL0HSS3gaUUtyFa6uCCP+Age3sP4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51S5gP4o062732;
 Thu, 27 Feb 2025 23:42:25 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 23:42:25 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 23:42:25 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51S5gM7a072353;
 Thu, 27 Feb 2025 23:42:23 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2] board: ti: j784s4: Update Resource Management configs
Date: Fri, 28 Feb 2025 11:12:22 +0530
Message-ID: <20250228054222.2852694-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
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

From: Vaishnav Achath <vaishnav.a@ti.com>

Update rm-cfg.yaml and tifs-rm-cfg.yaml to account for the
changes added in the K3 Resource Partitioning Tool v1.18

The change enables resource sharing between A72_2 and MAIN_0_R5_0
for the BCDMA CSI RX and TX channels, J784S4 supports upto 12
CSI cameras and 16 channels would not be enough for all such use
cases for RTOS and Linux, thus sharing of resources in needed. Resource
sharing between A72 and R5 for BCDMA CSI channels allow Linux to use 32
channels at a time.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
[n-francis@ti.com: rebased and sent on behalf]
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Sanity boot log:
https://gist.github.com/nehamalcom/ef40be06080cb5bc4d1be881690aaebb

Changes since v1:
- updated commit message with version and explanation
- added sanity boot log

 board/ti/j784s4/rm-cfg.yaml      | 24 ++++++++++++------------
 board/ti/j784s4/tifs-rm-cfg.yaml | 24 ++++++++++++------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/board/ti/j784s4/rm-cfg.yaml b/board/ti/j784s4/rm-cfg.yaml
index a448bd2e1e0..6968d317522 100644
--- a/board/ti/j784s4/rm-cfg.yaml
+++ b/board/ti/j784s4/rm-cfg.yaml
@@ -406,49 +406,49 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 16
-            num_resource: 16
+            num_resource: 32
             type: 17998
             host_id: 12
             reserved: 0
         -
-            start_resource: 32
-            num_resource: 16
+            start_resource: 16
+            num_resource: 32
             type: 17998
             host_id: 35
             reserved: 0
         -
             start_resource: 0
-            num_resource: 8
+            num_resource: 16
             type: 17999
             host_id: 12
             reserved: 0
         -
-            start_resource: 8
-            num_resource: 8
+            start_resource: 0
+            num_resource: 16
             type: 17999
             host_id: 35
             reserved: 0
         -
             start_resource: 0
-            num_resource: 16
+            num_resource: 32
             type: 18017
             host_id: 12
             reserved: 0
         -
-            start_resource: 16
-            num_resource: 16
+            start_resource: 0
+            num_resource: 32
             type: 18017
             host_id: 35
             reserved: 0
         -
             start_resource: 0
-            num_resource: 8
+            num_resource: 16
             type: 18018
             host_id: 12
             reserved: 0
         -
-            start_resource: 8
-            num_resource: 8
+            start_resource: 0
+            num_resource: 16
             type: 18018
             host_id: 35
             reserved: 0
diff --git a/board/ti/j784s4/tifs-rm-cfg.yaml b/board/ti/j784s4/tifs-rm-cfg.yaml
index 1c5faffb8e9..992ea23155a 100644
--- a/board/ti/j784s4/tifs-rm-cfg.yaml
+++ b/board/ti/j784s4/tifs-rm-cfg.yaml
@@ -250,49 +250,49 @@ tifs-rm-cfg:
     resasg_entries:
         -
             start_resource: 16
-            num_resource: 16
+            num_resource: 32
             type: 17998
             host_id: 12
             reserved: 0
         -
-            start_resource: 32
-            num_resource: 16
+            start_resource: 16
+            num_resource: 32
             type: 17998
             host_id: 35
             reserved: 0
         -
             start_resource: 0
-            num_resource: 8
+            num_resource: 16
             type: 17999
             host_id: 12
             reserved: 0
         -
-            start_resource: 8
-            num_resource: 8
+            start_resource: 0
+            num_resource: 16
             type: 17999
             host_id: 35
             reserved: 0
         -
             start_resource: 0
-            num_resource: 16
+            num_resource: 32
             type: 18017
             host_id: 12
             reserved: 0
         -
-            start_resource: 16
-            num_resource: 16
+            start_resource: 0
+            num_resource: 32
             type: 18017
             host_id: 35
             reserved: 0
         -
             start_resource: 0
-            num_resource: 8
+            num_resource: 16
             type: 18018
             host_id: 12
             reserved: 0
         -
-            start_resource: 8
-            num_resource: 8
+            start_resource: 0
+            num_resource: 16
             type: 18018
             host_id: 35
             reserved: 0
-- 
2.34.1

