Return-Path: <u-boot-bounces@lists.denx.de>
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC3EC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659138796C;
	Thu,  4 Jan 2024 13:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="blorf4SM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3CB87917; Thu,  4 Jan 2024 08:54:13 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED3E878FC
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 08:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4047s7Bv037510;
 Thu, 4 Jan 2024 01:54:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704354847;
 bh=z5Jg+Xl1ib83aypzzW+KmgnpK/A9aVW2kCv2ui8Lv4M=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=blorf4SMvz6PFlQOVfaaQgOlauwH2H7PRLOZbw1Du47cPaHHTsgvnnzKnT+LO5Xeb
 uuLmBTf+B/iylNuxMaIeeQJLjS4SymkvHWJCUtrEXQwymei4/Vdho2daAYy3HUz7dr
 /ZqIW6EfjawBL4DLLgLeTHZIQLwtYxXtCvCE2w7E=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4047s7Qt009265
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jan 2024 01:54:07 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 01:54:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 01:54:06 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4047rvgW099627;
 Thu, 4 Jan 2024 01:54:02 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <sjg@chromium.org>, <vigneshr@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>,
 <alpernebiyasak@gmail.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vishalm@ti.com>, <jonas@kwiboo.se>,
 <sughosh.ganu@linaro.org>, <lukas.funke@weidmueller.com>,
 <fr0st61te@gmail.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 1/2] board: ti: *-cfg.yaml: Adhere to yamllint rules
Date: Thu, 4 Jan 2024 13:23:56 +0530
Message-ID: <20240104075357.638983-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104075357.638983-1-n-francis@ti.com>
References: <20240104075357.638983-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 04 Jan 2024 13:19:13 +0100
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

Clean up all configuration files to adhere to yamllint rules.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Suggested-by: Nishanth Menon <nm@ti.com>
---
 board/ti/am62ax/board-cfg.yaml      |   20 +-
 board/ti/am62ax/pm-cfg.yaml         |    4 +-
 board/ti/am62ax/rm-cfg.yaml         | 1664 +++++------
 board/ti/am62ax/sec-cfg.yaml        |  212 +-
 board/ti/am62ax/tifs-rm-cfg.yaml    | 1484 +++++-----
 board/ti/am62x/board-cfg.yaml       |   20 +-
 board/ti/am62x/pm-cfg.yaml          |    4 +-
 board/ti/am62x/rm-cfg.yaml          | 1532 +++++-----
 board/ti/am62x/sec-cfg.yaml         |  212 +-
 board/ti/am64x/board-cfg.yaml       |   20 +-
 board/ti/am64x/pm-cfg.yaml          |    4 +-
 board/ti/am64x/rm-cfg.yaml          | 2386 +++++++--------
 board/ti/am64x/sec-cfg.yaml         |  216 +-
 board/ti/am65x/board-cfg.yaml       |   20 +-
 board/ti/am65x/pm-cfg.yaml          |    4 +-
 board/ti/am65x/rm-cfg.yaml          | 2994 +++++++++----------
 board/ti/am65x/sec-cfg.yaml         |  212 +-
 board/ti/j721e/board-cfg_j7200.yaml |   20 +-
 board/ti/j721e/pm-cfg_j7200.yaml    |    4 +-
 board/ti/j721e/rm-cfg.yaml          |   64 +-
 board/ti/j721e/rm-cfg_j7200.yaml    |  134 +-
 board/ti/j721e/sec-cfg.yaml         |  192 +-
 board/ti/j721e/sec-cfg_j7200.yaml   |  216 +-
 board/ti/j721s2/board-cfg.yaml      |   20 +-
 board/ti/j721s2/pm-cfg.yaml         |    4 +-
 board/ti/j721s2/rm-cfg.yaml         | 4184 +++++++++++++--------------
 board/ti/j721s2/sec-cfg.yaml        |  212 +-
 27 files changed, 8029 insertions(+), 8029 deletions(-)

diff --git a/board/ti/am62ax/board-cfg.yaml b/board/ti/am62ax/board-cfg.yaml
index 4aa8ddd104..a0930d69b8 100644
--- a/board/ti/am62ax/board-cfg.yaml
+++ b/board/ti/am62ax/board-cfg.yaml
@@ -8,29 +8,29 @@
 
 board-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
     control:
         subhdr:
             magic: 0xC1D3
             size: 7
-        main_isolation_enable : 0x5A
-        main_isolation_hostid : 0x2
+        main_isolation_enable: 0x5A
+        main_isolation_hostid: 0x2
     secproxy:
         subhdr:
             magic: 0x1207
             size: 7
-        scaling_factor : 0x1
-        scaling_profile : 0x1
-        disable_main_nav_secure_proxy : 0
+        scaling_factor: 0x1
+        scaling_profile: 0x1
+        disable_main_nav_secure_proxy: 0
     msmc:
         subhdr:
             magic: 0xA5C3
             size: 5
-        msmc_cache_size : 0x10
+        msmc_cache_size: 0x10
     debug_cfg:
         subhdr:
             magic: 0x020C
             size: 8
-        trace_dst_enables : 0x00
-        trace_src_enables : 0x00
+        trace_dst_enables: 0x00
+        trace_src_enables: 0x00
diff --git a/board/ti/am62ax/pm-cfg.yaml b/board/ti/am62ax/pm-cfg.yaml
index 3ad182ae17..4031af2f4d 100644
--- a/board/ti/am62ax/pm-cfg.yaml
+++ b/board/ti/am62ax/pm-cfg.yaml
@@ -8,5 +8,5 @@
 
 pm-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
diff --git a/board/ti/am62ax/rm-cfg.yaml b/board/ti/am62ax/rm-cfg.yaml
index 1fb7d64cb8..73e8e15f66 100644
--- a/board/ti/am62ax/rm-cfg.yaml
+++ b/board/ti/am62ax/rm-cfg.yaml
@@ -9,231 +9,231 @@
 rm-cfg:
     rm_boardcfg:
         rev:
-            boardcfg_abi_maj : 0x0
-            boardcfg_abi_min : 0x1
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
         host_cfg:
             subhdr:
                 magic: 0x4C41
-                size : 356
+                size: 356
             host_cfg_entries:
-                - #1
+                -   #  1
                     host_id: 12
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #2
+                -   #  2
                     host_id: 20
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #3
+                -  # 3
                     host_id: 30
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #4
+                -  # 4
                     host_id: 36
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #5
+                -  # 5
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #6
+                -  # 6
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #7
+                -  # 7
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #8
+                -  # 8
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #9
+                -  # 9
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #10
+                -  # 10
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #11
+                -  # 11
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #12
+                -  # 12
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #13
+                -  # 13
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #14
+                -  # 14
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #15
+                -  # 15
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #16
+                -  # 16
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #17
+                -  # 17
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #18
+                -  # 18
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #19
+                -  # 19
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #20
+                -  # 20
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #21
+                -  # 21
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #22
+                -  # 22
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #23
+                -  # 23
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #24
+                -  # 24
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #25
+                -  # 25
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #26
+                -  # 26
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #27
+                -  # 27
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #28
+                -  # 28
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #29
+                -  # 29
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #30
+                -  # 30
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #31
+                -  # 31
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #32
+                -  # 32
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
@@ -248,800 +248,800 @@ rm-cfg:
             reserved: 0
     resasg_entries:
         -
-                start_resource: 0
-                num_resource: 16
-                type: 64
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 4
-                type: 64
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 4
-                type: 64
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 22
-                type: 64
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 16
-                type: 192
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 34
-                num_resource: 2
-                type: 192
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 2
-                type: 320
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 2
-                num_resource: 2
-                type: 320
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 2
-                num_resource: 2
-                type: 320
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 4
-                num_resource: 4
-                type: 320
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 26
-                type: 384
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 50176
-                num_resource: 164
-                type: 1666
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 1667
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 18
-                type: 1677
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1677
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1677
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1677
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 26
-                num_resource: 6
-                type: 1677
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 54
-                num_resource: 18
-                type: 1678
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 72
-                num_resource: 6
-                type: 1678
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 72
-                num_resource: 6
-                type: 1678
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 78
-                num_resource: 2
-                type: 1678
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 80
-                num_resource: 2
-                type: 1678
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 32
-                num_resource: 12
-                type: 1679
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 50
-                num_resource: 2
-                type: 1679
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 52
-                num_resource: 2
-                type: 1679
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 18
-                type: 1696
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1696
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1696
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1696
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 26
-                num_resource: 6
-                type: 1696
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 18
-                type: 1697
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1697
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1697
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1697
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 26
-                num_resource: 2
-                type: 1697
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 12
-                type: 1698
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 2
-                type: 1698
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 2
-                type: 1698
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 6
-                num_resource: 26
-                type: 1802
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 32
-                num_resource: 8
-                type: 1802
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 36
-                type: 1802
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 36
-                type: 1802
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 168
-                num_resource: 8
-                type: 1802
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 14
-                num_resource: 512
-                type: 1805
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 526
-                num_resource: 256
-                type: 1805
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 526
-                num_resource: 256
-                type: 1805
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 782
-                num_resource: 128
-                type: 1805
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 910
-                num_resource: 128
-                type: 1805
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 1038
-                num_resource: 498
-                type: 1805
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1024
-                type: 1807
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 4096
-                num_resource: 29
-                type: 1808
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 4608
-                num_resource: 99
-                type: 1809
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5120
-                num_resource: 24
-                type: 1810
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5632
-                num_resource: 51
-                type: 1811
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 6144
-                num_resource: 51
-                type: 1812
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 6656
-                num_resource: 51
-                type: 1813
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 8192
-                num_resource: 32
-                type: 1814
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 8704
-                num_resource: 32
-                type: 1815
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 9216
-                num_resource: 32
-                type: 1816
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 9728
-                num_resource: 22
-                type: 1817
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 10240
-                num_resource: 22
-                type: 1818
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 10752
-                num_resource: 22
-                type: 1819
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 11264
-                num_resource: 28
-                type: 1820
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 11776
-                num_resource: 28
-                type: 1821
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 12288
-                num_resource: 28
-                type: 1822
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 1923
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1936
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1936
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1936
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 64
-                type: 1937
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 64
-                type: 1937
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 83
-                num_resource: 8
-                type: 1938
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 91
-                num_resource: 8
-                type: 1939
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 99
-                num_resource: 10
-                type: 1942
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 112
-                num_resource: 3
-                type: 1942
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 115
-                num_resource: 3
-                type: 1942
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 118
-                num_resource: 16
-                type: 1943
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 118
-                num_resource: 16
-                type: 1943
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 134
-                num_resource: 8
-                type: 1944
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 134
-                num_resource: 8
-                type: 1945
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 142
-                num_resource: 8
-                type: 1946
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 142
-                num_resource: 8
-                type: 1947
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1955
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1955
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1955
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 8
-                type: 1956
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 8
-                type: 1956
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 27
-                num_resource: 1
-                type: 1957
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 28
-                num_resource: 1
-                type: 1958
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1961
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1961
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1961
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1962
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1962
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1962
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 16
-                type: 1964
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 16
-                type: 1964
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 1
-                type: 1965
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 35
-                num_resource: 8
-                type: 1966
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 21
-                num_resource: 1
-                type: 1967
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 35
-                num_resource: 8
-                type: 1968
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 22
-                num_resource: 1
-                type: 1969
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 43
-                num_resource: 8
-                type: 1970
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 1
-                type: 1971
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 43
-                num_resource: 8
-                type: 1972
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 2112
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 2
-                num_resource: 2
-                type: 2122
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 51200
-                num_resource: 12
-                type: 12738
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 12739
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 6
-                type: 12750
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 6
-                type: 12769
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 8
-                type: 12810
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 12288
-                num_resource: 128
-                type: 12813
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 3072
-                num_resource: 6
-                type: 12828
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 3584
-                num_resource: 6
-                type: 12829
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 4096
-                num_resource: 6
-                type: 12830
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 16
+            type: 64
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 64
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 64
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 22
+            type: 64
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 192
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 2
+            type: 192
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 320
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 320
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 26
+            type: 384
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 50176
+            num_resource: 164
+            type: 1666
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1667
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1677
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 18
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 78
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 12
+            type: 1679
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 2
+            type: 1679
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 2
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1696
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 2
+            type: 1697
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1698
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 2
+            type: 1698
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 26
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 8
+            type: 1802
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 8
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 512
+            type: 1805
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 526
+            num_resource: 256
+            type: 1805
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 526
+            num_resource: 256
+            type: 1805
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 782
+            num_resource: 128
+            type: 1805
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 910
+            num_resource: 128
+            type: 1805
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 1038
+            num_resource: 498
+            type: 1805
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1024
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 29
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 99
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 24
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 51
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6656
+            num_resource: 51
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 32
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 32
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 22
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 22
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 22
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 28
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 28
+            type: 1821
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 28
+            type: 1822
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1923
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1936
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1936
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1936
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 83
+            num_resource: 8
+            type: 1938
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 91
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 99
+            num_resource: 10
+            type: 1942
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 3
+            type: 1942
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 115
+            num_resource: 3
+            type: 1942
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1944
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1945
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1955
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1955
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1955
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1957
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1961
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1961
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1961
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1962
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1962
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1962
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 1
+            type: 1965
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1966
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 1
+            type: 1967
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1968
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 51200
+            num_resource: 12
+            type: 12738
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 12739
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12750
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12769
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12810
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 128
+            type: 12813
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3072
+            num_resource: 6
+            type: 12828
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 3584
+            num_resource: 6
+            type: 12829
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 6
+            type: 12830
+            host_id: 128
+            reserved: 0
diff --git a/board/ti/am62ax/sec-cfg.yaml b/board/ti/am62ax/sec-cfg.yaml
index f0ad20c5a6..ae6939eee9 100644
--- a/board/ti/am62ax/sec-cfg.yaml
+++ b/board/ti/am62ax/sec-cfg.yaml
@@ -8,138 +8,138 @@
 
 sec-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
     processor_acl_list:
         subhdr:
             magic: 0xF1EA
             size: 164
         proc_acl_entries:
-            - #1
+            -  # 1
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #2
+            -  # 2
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #3
+            -  # 3
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #4
+            -  # 4
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #5
+            -  # 5
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #6
+            -  # 6
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #7
+            -  # 7
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #8
+            -  # 8
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #9
+            -  # 9
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #10
+            -  # 10
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #11
+            -  # 11
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #12
+            -  # 12
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #13
+            -  # 13
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #14
+            -  # 14
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #15
+            -  # 15
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #16
+            -  # 16
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #17
+            -  # 17
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #18
+            -  # 18
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #19
+            -  # 19
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #20
+            -  # 20
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #21
+            -  # 21
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #22
+            -  # 22
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #23
+            -  # 23
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #24
+            -  # 24
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #25
+            -  # 25
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #26
+            -  # 26
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #27
+            -  # 27
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #28
+            -  # 28
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #29
+            -  # 29
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #30
+            -  # 30
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #31
+            -  # 31
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #32
+            -  # 32
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
@@ -148,202 +148,202 @@ sec-cfg:
             magic: 0x8D27
             size: 68
         host_hierarchy_entries:
-            - #1
+            -  # 1
                 host_id: 0
                 supervisor_host_id: 0
-            - #2
+            -  # 2
                 host_id: 0
                 supervisor_host_id: 0
-            - #3
+            -  # 3
                 host_id: 0
                 supervisor_host_id: 0
-            - #4
+            -  # 4
                 host_id: 0
                 supervisor_host_id: 0
-            - #5
+            -  # 5
                 host_id: 0
                 supervisor_host_id: 0
-            - #6
+            -  # 6
                 host_id: 0
                 supervisor_host_id: 0
-            - #7
+            -  # 7
                 host_id: 0
                 supervisor_host_id: 0
-            - #8
+            -  # 8
                 host_id: 0
                 supervisor_host_id: 0
-            - #9
+            -  # 9
                 host_id: 0
                 supervisor_host_id: 0
-            - #10
+            -  # 10
                 host_id: 0
                 supervisor_host_id: 0
-            - #11
+            -  # 11
                 host_id: 0
                 supervisor_host_id: 0
-            - #12
+            -  # 12
                 host_id: 0
                 supervisor_host_id: 0
-            - #13
+            -  # 13
                 host_id: 0
                 supervisor_host_id: 0
-            - #14
+            -  # 14
                 host_id: 0
                 supervisor_host_id: 0
-            - #15
+            -  # 15
                 host_id: 0
                 supervisor_host_id: 0
-            - #16
+            -  # 16
                 host_id: 0
                 supervisor_host_id: 0
-            - #17
+            -  # 17
                 host_id: 0
                 supervisor_host_id: 0
-            - #18
+            -  # 18
                 host_id: 0
                 supervisor_host_id: 0
-            - #19
+            -  # 19
                 host_id: 0
                 supervisor_host_id: 0
-            - #20
+            -  # 20
                 host_id: 0
                 supervisor_host_id: 0
-            - #21
+            -  # 21
                 host_id: 0
                 supervisor_host_id: 0
-            - #22
+            -  # 22
                 host_id: 0
                 supervisor_host_id: 0
-            - #23
+            -  # 23
                 host_id: 0
                 supervisor_host_id: 0
-            - #24
+            -  # 24
                 host_id: 0
                 supervisor_host_id: 0
-            - #25
+            -  # 25
                 host_id: 0
                 supervisor_host_id: 0
-            - #26
+            -  # 26
                 host_id: 0
                 supervisor_host_id: 0
-            - #27
+            -  # 27
                 host_id: 0
                 supervisor_host_id: 0
-            - #28
+            -  # 28
                 host_id: 0
                 supervisor_host_id: 0
-            - #29
+            -  # 29
                 host_id: 0
                 supervisor_host_id: 0
-            - #30
+            -  # 30
                 host_id: 0
                 supervisor_host_id: 0
-            - #31
+            -  # 31
                 host_id: 0
                 supervisor_host_id: 0
-            - #32
+            -  # 32
                 host_id: 0
                 supervisor_host_id: 0
     otp_config:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id : 0
+        write_host_id: 0
         otp_entry:
-            - #1
+            -  # 1
                 host_id: 0
                 host_perms: 0
-            - #2
+            -  # 2
                 host_id: 0
                 host_perms: 0
-            - #3
+            -  # 3
                 host_id: 0
                 host_perms: 0
-            - #4
+            -  # 4
                 host_id: 0
                 host_perms: 0
-            - #5
+            -  # 5
                 host_id: 0
                 host_perms: 0
-            - #6
+            -  # 6
                 host_id: 0
                 host_perms: 0
-            - #7
+            -  # 7
                 host_id: 0
                 host_perms: 0
-            - #8
+            -  # 8
                 host_id: 0
                 host_perms: 0
-            - #9
+            -  # 9
                 host_id: 0
                 host_perms: 0
-            - #10
+            -  # 10
                 host_id: 0
                 host_perms: 0
-            - #11
+            -  # 11
                 host_id: 0
                 host_perms: 0
-            - #12
+            -  # 12
                 host_id: 0
                 host_perms: 0
-            - #13
+            -  # 13
                 host_id: 0
                 host_perms: 0
-            - #14
+            -  # 14
                 host_id: 0
                 host_perms: 0
-            - #15
+            -  # 15
                 host_id: 0
                 host_perms: 0
-            - #16
+            -  # 16
                 host_id: 0
                 host_perms: 0
-            - #17
+            -  # 17
                 host_id: 0
                 host_perms: 0
-            - #18
+            -  # 18
                 host_id: 0
                 host_perms: 0
-            - #19
+            -  # 19
                 host_id: 0
                 host_perms: 0
-            - #20
+            -  # 20
                 host_id: 0
                 host_perms: 0
-            - #21
+            -  # 21
                 host_id: 0
                 host_perms: 0
-            - #22
+            -  # 22
                 host_id: 0
                 host_perms: 0
-            - #23
+            -  # 23
                 host_id: 0
                 host_perms: 0
-            - #24
+            -  # 24
                 host_id: 0
                 host_perms: 0
-            - #25
+            -  # 25
                 host_id: 0
                 host_perms: 0
-            - #26
+            -  # 26
                 host_id: 0
                 host_perms: 0
-            - #27
+            -  # 27
                 host_id: 0
                 host_perms: 0
-            - #28
+            -  # 28
                 host_id: 0
                 host_perms: 0
-            - #29
+            -  # 29
                 host_id: 0
                 host_perms: 0
-            - #30
+            -  # 30
                 host_id: 0
                 host_perms: 0
-            - #31
+            -  # 31
                 host_id: 0
                 host_perms: 0
-            - #32
+            -  # 32
                 host_id: 0
                 host_perms: 0
     dkek_config:
@@ -351,12 +351,12 @@ sec-cfg:
             magic: 0x5170
             size: 12
         allowed_hosts: [128, 0, 0, 0]
-        allow_dkek_export_tisci : 0x5A
+        allow_dkek_export_tisci: 0x5A
         rsvd: [0, 0, 0]
     sa2ul_cfg:
         subhdr:
             magic: 0x23BE
-            size : 0
+            size: 0
         auth_resource_owner: 0
         enable_saul_psil_global_config_writes: 0x5A
         rsvd: [0, 0]
@@ -364,16 +364,16 @@ sec-cfg:
         subhdr:
             magic: 0x42AF
             size: 16
-        allow_jtag_unlock : 0x5A
-        allow_wildcard_unlock : 0x5A
+        allow_jtag_unlock: 0x5A
+        allow_wildcard_unlock: 0x5A
         allowed_debug_level_rsvd: 0
         rsvd: 0
-        min_cert_rev : 0x0
+        min_cert_rev: 0x0
         jtag_unlock_hosts: [0, 0, 0, 0]
     sec_handover_cfg:
         subhdr:
             magic: 0x608F
             size: 10
-        handover_msg_sender : 0
-        handover_to_host_id : 0
+        handover_msg_sender: 0
+        handover_to_host_id: 0
         rsvd: [0, 0, 0, 0]
diff --git a/board/ti/am62ax/tifs-rm-cfg.yaml b/board/ti/am62ax/tifs-rm-cfg.yaml
index 0b1980eb7b..4081f9bca9 100644
--- a/board/ti/am62ax/tifs-rm-cfg.yaml
+++ b/board/ti/am62ax/tifs-rm-cfg.yaml
@@ -9,1003 +9,1003 @@
 tifs-rm-cfg:
     rm_boardcfg:
         rev:
-            boardcfg_abi_maj : 0x0
-            boardcfg_abi_min : 0x1
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
         host_cfg:
             subhdr:
                 magic: 0x4C41
-                size : 356
+                size: 356
             host_cfg_entries:
-                - #1
+                -  # 1
                     host_id: 12
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #2
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 2
                     host_id: 30
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #3
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
                     host_id: 36
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #4
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #5
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 5
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #6
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 6
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #7
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 7
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #8
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 8
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #9
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 9
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #10
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 10
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #11
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 11
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #12
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 12
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #13
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #14
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #15
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #16
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #17
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #18
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #19
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #20
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #21
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #22
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #23
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #24
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #25
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #26
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #27
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #28
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #29
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #30
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #31
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #32
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
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
             resasg_entries_size: 872
-            reserved : 0
+            reserved: 0
     resasg_entries:
         -
-                start_resource: 0
-                num_resource: 18
-                type: 1677
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 18
+            type: 1677
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 18
-                num_resource: 6
-                type: 1677
-                host_id: 35
-                reserved: 0
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 18
-                num_resource: 6
-                type: 1677
-                host_id: 36
-                reserved: 0
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 2
-                type: 1677
-                host_id: 30
-                reserved: 0
+            start_resource: 24
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 6
-                type: 1677
-                host_id: 128
-                reserved: 0
+            start_resource: 26
+            num_resource: 6
+            type: 1677
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 54
-                num_resource: 18
-                type: 1678
-                host_id: 12
-                reserved: 0
+            start_resource: 54
+            num_resource: 18
+            type: 1678
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 72
-                num_resource: 6
-                type: 1678
-                host_id: 35
-                reserved: 0
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 72
-                num_resource: 6
-                type: 1678
-                host_id: 36
-                reserved: 0
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 78
-                num_resource: 2
-                type: 1678
-                host_id: 30
-                reserved: 0
+            start_resource: 78
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 80
-                num_resource: 2
-                type: 1678
-                host_id: 128
-                reserved: 0
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 32
-                num_resource: 12
-                type: 1679
-                host_id: 12
-                reserved: 0
+            start_resource: 32
+            num_resource: 12
+            type: 1679
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 35
-                reserved: 0
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 36
-                reserved: 0
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 50
-                num_resource: 2
-                type: 1679
-                host_id: 30
-                reserved: 0
+            start_resource: 50
+            num_resource: 2
+            type: 1679
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 52
-                num_resource: 2
-                type: 1679
-                host_id: 128
-                reserved: 0
+            start_resource: 52
+            num_resource: 2
+            type: 1679
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 18
-                type: 1696
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 18
+            type: 1696
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 18
-                num_resource: 6
-                type: 1696
-                host_id: 35
-                reserved: 0
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 18
-                num_resource: 6
-                type: 1696
-                host_id: 36
-                reserved: 0
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 2
-                type: 1696
-                host_id: 30
-                reserved: 0
+            start_resource: 24
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 6
-                type: 1696
-                host_id: 128
-                reserved: 0
+            start_resource: 26
+            num_resource: 6
+            type: 1696
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 18
-                type: 1697
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 18
+            type: 1697
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 18
-                num_resource: 6
-                type: 1697
-                host_id: 35
-                reserved: 0
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 18
-                num_resource: 6
-                type: 1697
-                host_id: 36
-                reserved: 0
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 2
-                type: 1697
-                host_id: 30
-                reserved: 0
+            start_resource: 24
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 2
-                type: 1697
-                host_id: 128
-                reserved: 0
+            start_resource: 26
+            num_resource: 2
+            type: 1697
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 12
-                type: 1698
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 12
+            type: 1698
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 35
-                reserved: 0
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 36
-                reserved: 0
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 18
-                num_resource: 2
-                type: 1698
-                host_id: 30
-                reserved: 0
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 2
-                type: 1698
-                host_id: 128
-                reserved: 0
+            start_resource: 20
+            num_resource: 2
+            type: 1698
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 6
-                num_resource: 34
-                type: 1802
-                host_id: 12
-                reserved: 0
+            start_resource: 6
+            num_resource: 34
+            type: 1802
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 44
-                num_resource: 36
-                type: 1802
-                host_id: 35
-                reserved: 0
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 44
-                num_resource: 36
-                type: 1802
-                host_id: 36
-                reserved: 0
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 168
-                num_resource: 8
-                type: 1802
-                host_id: 30
-                reserved: 0
+            start_resource: 168
+            num_resource: 8
+            type: 1802
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1024
-                type: 1807
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1024
+            type: 1807
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 4096
-                num_resource: 29
-                type: 1808
-                host_id: 128
-                reserved: 0
+            start_resource: 4096
+            num_resource: 29
+            type: 1808
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 4608
-                num_resource: 99
-                type: 1809
-                host_id: 128
-                reserved: 0
+            start_resource: 4608
+            num_resource: 99
+            type: 1809
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 5120
-                num_resource: 24
-                type: 1810
-                host_id: 128
-                reserved: 0
+            start_resource: 5120
+            num_resource: 24
+            type: 1810
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 5632
-                num_resource: 51
-                type: 1811
-                host_id: 128
-                reserved: 0
+            start_resource: 5632
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 6144
-                num_resource: 51
-                type: 1812
-                host_id: 128
-                reserved: 0
+            start_resource: 6144
+            num_resource: 51
+            type: 1812
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 6656
-                num_resource: 51
-                type: 1813
-                host_id: 128
-                reserved: 0
+            start_resource: 6656
+            num_resource: 51
+            type: 1813
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 8192
-                num_resource: 32
-                type: 1814
-                host_id: 128
-                reserved: 0
+            start_resource: 8192
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 8704
-                num_resource: 32
-                type: 1815
-                host_id: 128
-                reserved: 0
+            start_resource: 8704
+            num_resource: 32
+            type: 1815
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 9216
-                num_resource: 32
-                type: 1816
-                host_id: 128
-                reserved: 0
+            start_resource: 9216
+            num_resource: 32
+            type: 1816
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 9728
-                num_resource: 22
-                type: 1817
-                host_id: 128
-                reserved: 0
+            start_resource: 9728
+            num_resource: 22
+            type: 1817
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 10240
-                num_resource: 22
-                type: 1818
-                host_id: 128
-                reserved: 0
+            start_resource: 10240
+            num_resource: 22
+            type: 1818
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 10752
-                num_resource: 22
-                type: 1819
-                host_id: 128
-                reserved: 0
+            start_resource: 10752
+            num_resource: 22
+            type: 1819
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 11264
-                num_resource: 28
-                type: 1820
-                host_id: 128
-                reserved: 0
+            start_resource: 11264
+            num_resource: 28
+            type: 1820
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 11776
-                num_resource: 28
-                type: 1821
-                host_id: 128
-                reserved: 0
+            start_resource: 11776
+            num_resource: 28
+            type: 1821
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 12288
-                num_resource: 28
-                type: 1822
-                host_id: 128
-                reserved: 0
+            start_resource: 12288
+            num_resource: 28
+            type: 1822
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 10
-                type: 1936
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 10
+            type: 1936
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 35
-                reserved: 0
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 36
-                reserved: 0
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 13
-                num_resource: 3
-                type: 1936
-                host_id: 30
-                reserved: 0
+            start_resource: 13
+            num_resource: 3
+            type: 1936
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 3
-                type: 1936
-                host_id: 128
-                reserved: 0
+            start_resource: 16
+            num_resource: 3
+            type: 1936
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 19
-                num_resource: 64
-                type: 1937
-                host_id: 12
-                reserved: 0
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 19
-                num_resource: 64
-                type: 1937
-                host_id: 30
-                reserved: 0
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 83
-                num_resource: 8
-                type: 1938
-                host_id: 12
-                reserved: 0
+            start_resource: 83
+            num_resource: 8
+            type: 1938
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 91
-                num_resource: 8
-                type: 1939
-                host_id: 12
-                reserved: 0
+            start_resource: 91
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 99
-                num_resource: 10
-                type: 1942
-                host_id: 12
-                reserved: 0
+            start_resource: 99
+            num_resource: 10
+            type: 1942
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 35
-                reserved: 0
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 36
-                reserved: 0
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 112
-                num_resource: 3
-                type: 1942
-                host_id: 30
-                reserved: 0
+            start_resource: 112
+            num_resource: 3
+            type: 1942
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 115
-                num_resource: 3
-                type: 1942
-                host_id: 128
-                reserved: 0
+            start_resource: 115
+            num_resource: 3
+            type: 1942
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 118
-                num_resource: 16
-                type: 1943
-                host_id: 12
-                reserved: 0
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 118
-                num_resource: 16
-                type: 1943
-                host_id: 30
-                reserved: 0
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 134
-                num_resource: 8
-                type: 1944
-                host_id: 12
-                reserved: 0
+            start_resource: 134
+            num_resource: 8
+            type: 1944
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 134
-                num_resource: 8
-                type: 1945
-                host_id: 12
-                reserved: 0
+            start_resource: 134
+            num_resource: 8
+            type: 1945
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 142
-                num_resource: 8
-                type: 1946
-                host_id: 12
-                reserved: 0
+            start_resource: 142
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 142
-                num_resource: 8
-                type: 1947
-                host_id: 12
-                reserved: 0
+            start_resource: 142
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 10
-                type: 1955
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 10
+            type: 1955
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 35
-                reserved: 0
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 36
-                reserved: 0
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 13
-                num_resource: 3
-                type: 1955
-                host_id: 30
-                reserved: 0
+            start_resource: 13
+            num_resource: 3
+            type: 1955
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 3
-                type: 1955
-                host_id: 128
-                reserved: 0
+            start_resource: 16
+            num_resource: 3
+            type: 1955
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 19
-                num_resource: 8
-                type: 1956
-                host_id: 12
-                reserved: 0
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 19
-                num_resource: 8
-                type: 1956
-                host_id: 30
-                reserved: 0
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 27
-                num_resource: 1
-                type: 1957
-                host_id: 12
-                reserved: 0
+            start_resource: 27
+            num_resource: 1
+            type: 1957
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 28
-                num_resource: 1
-                type: 1958
-                host_id: 12
-                reserved: 0
+            start_resource: 28
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 10
-                type: 1961
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 10
+            type: 1961
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 35
-                reserved: 0
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 36
-                reserved: 0
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 13
-                num_resource: 3
-                type: 1961
-                host_id: 30
-                reserved: 0
+            start_resource: 13
+            num_resource: 3
+            type: 1961
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 3
-                type: 1961
-                host_id: 128
-                reserved: 0
+            start_resource: 16
+            num_resource: 3
+            type: 1961
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 10
-                type: 1962
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 10
+            type: 1962
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 35
-                reserved: 0
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 36
-                reserved: 0
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
 
         -
-                start_resource: 13
-                num_resource: 3
-                type: 1962
-                host_id: 30
-                reserved: 0
+            start_resource: 13
+            num_resource: 3
+            type: 1962
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 3
-                type: 1962
-                host_id: 128
-                reserved: 0
+            start_resource: 16
+            num_resource: 3
+            type: 1962
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 12
-                reserved: 0
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 30
-                reserved: 0
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 19
-                num_resource: 16
-                type: 1964
-                host_id: 12
-                reserved: 0
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 19
-                num_resource: 16
-                type: 1964
-                host_id: 30
-                reserved: 0
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 30
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 1
-                type: 1965
-                host_id: 12
-                reserved: 0
+            start_resource: 20
+            num_resource: 1
+            type: 1965
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 35
-                num_resource: 8
-                type: 1966
-                host_id: 12
-                reserved: 0
+            start_resource: 35
+            num_resource: 8
+            type: 1966
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 21
-                num_resource: 1
-                type: 1967
-                host_id: 12
-                reserved: 0
+            start_resource: 21
+            num_resource: 1
+            type: 1967
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 35
-                num_resource: 8
-                type: 1968
-                host_id: 12
-                reserved: 0
+            start_resource: 35
+            num_resource: 8
+            type: 1968
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 22
-                num_resource: 1
-                type: 1969
-                host_id: 12
-                reserved: 0
+            start_resource: 22
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 43
-                num_resource: 8
-                type: 1970
-                host_id: 12
-                reserved: 0
+            start_resource: 43
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 23
-                num_resource: 1
-                type: 1971
-                host_id: 12
-                reserved: 0
+            start_resource: 23
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 43
-                num_resource: 8
-                type: 1972
-                host_id: 12
-                reserved: 0
+            start_resource: 43
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 2112
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 2
-                type: 2122
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 6
-                type: 12750
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 6
+            type: 12750
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 6
-                type: 12769
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 6
+            type: 12769
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 8
-                type: 12810
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 8
+            type: 12810
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 3072
-                num_resource: 6
-                type: 12828
-                host_id: 128
-                reserved: 0
+            start_resource: 3072
+            num_resource: 6
+            type: 12828
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 3584
-                num_resource: 6
-                type: 12829
-                host_id: 128
-                reserved: 0
+            start_resource: 3584
+            num_resource: 6
+            type: 12829
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 4096
-                num_resource: 6
-                type: 12830
-                host_id: 128
-                reserved: 0
+            start_resource: 4096
+            num_resource: 6
+            type: 12830
+            host_id: 128
+            reserved: 0
diff --git a/board/ti/am62x/board-cfg.yaml b/board/ti/am62x/board-cfg.yaml
index 36cfb550ad..45c89dd15f 100644
--- a/board/ti/am62x/board-cfg.yaml
+++ b/board/ti/am62x/board-cfg.yaml
@@ -8,29 +8,29 @@
 
 board-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
     control:
         subhdr:
             magic: 0xC1D3
             size: 7
-        main_isolation_enable : 0x5A
-        main_isolation_hostid : 0x2
+        main_isolation_enable: 0x5A
+        main_isolation_hostid: 0x2
     secproxy:
         subhdr:
             magic: 0x1207
             size: 7
-        scaling_factor : 0x1
-        scaling_profile : 0x1
-        disable_main_nav_secure_proxy : 0
+        scaling_factor: 0x1
+        scaling_profile: 0x1
+        disable_main_nav_secure_proxy: 0
     msmc:
         subhdr:
             magic: 0xA5C3
             size: 5
-        msmc_cache_size : 0x0
+        msmc_cache_size: 0x0
     debug_cfg:
         subhdr:
             magic: 0x020C
             size: 8
-        trace_dst_enables : 0x00
-        trace_src_enables : 0x00
+        trace_dst_enables: 0x00
+        trace_src_enables: 0x00
diff --git a/board/ti/am62x/pm-cfg.yaml b/board/ti/am62x/pm-cfg.yaml
index 5d04cf82ef..9853a25eb8 100644
--- a/board/ti/am62x/pm-cfg.yaml
+++ b/board/ti/am62x/pm-cfg.yaml
@@ -8,5 +8,5 @@
 
 pm-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
diff --git a/board/ti/am62x/rm-cfg.yaml b/board/ti/am62x/rm-cfg.yaml
index 5a265ed1e8..725f7c83f0 100644
--- a/board/ti/am62x/rm-cfg.yaml
+++ b/board/ti/am62x/rm-cfg.yaml
@@ -9,231 +9,231 @@
 rm-cfg:
     rm_boardcfg:
         rev:
-            boardcfg_abi_maj : 0x0
-            boardcfg_abi_min : 0x1
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
         host_cfg:
             subhdr:
                 magic: 0x4C41
-                size : 356
+                size: 356
             host_cfg_entries:
-                - #1
+                -  # 1
                     host_id: 12
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #2
+                -  # 2
                     host_id: 30
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #3
+                -  # 3
                     host_id: 36
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #4
+                -  # 4
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #5
+                -  # 5
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #6
+                -  # 6
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #7
+                -  # 7
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #8
+                -  # 8
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #9
+                -  # 9
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #10
+                -  # 10
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #11
+                -  # 11
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #12
+                -  # 12
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #13
+                -  # 13
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #14
+                -  # 14
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #15
+                -  # 15
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #16
+                -  # 16
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #17
+                -  # 17
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #18
+                -  # 18
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #19
+                -  # 19
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #20
+                -  # 20
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #21
+                -  # 21
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #22
+                -  # 22
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #23
+                -  # 23
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #24
+                -  # 24
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #25
+                -  # 25
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #26
+                -  # 26
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #27
+                -  # 27
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #28
+                -  # 28
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #29
+                -  # 29
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #30
+                -  # 30
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #31
+                -  # 31
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #32
+                -  # 32
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
@@ -248,734 +248,734 @@ rm-cfg:
             reserved: 0
     resasg_entries:
         -
-                start_resource: 0
-                num_resource: 16
-                type: 64
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 4
-                type: 64
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 4
-                type: 64
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 22
-                type: 64
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 16
-                type: 192
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 34
-                num_resource: 2
-                type: 192
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 2
-                type: 320
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 2
-                num_resource: 2
-                type: 320
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 2
-                num_resource: 2
-                type: 320
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 4
-                num_resource: 4
-                type: 320
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 26
-                type: 384
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 50176
-                num_resource: 164
-                type: 1666
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 1667
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 18
-                type: 1677
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1677
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1677
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1677
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 26
-                num_resource: 6
-                type: 1677
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 54
-                num_resource: 18
-                type: 1678
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 72
-                num_resource: 6
-                type: 1678
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 72
-                num_resource: 6
-                type: 1678
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 78
-                num_resource: 2
-                type: 1678
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 80
-                num_resource: 2
-                type: 1678
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 32
-                num_resource: 12
-                type: 1679
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 50
-                num_resource: 2
-                type: 1679
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 52
-                num_resource: 2
-                type: 1679
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 18
-                type: 1696
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1696
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1696
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1696
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 26
-                num_resource: 6
-                type: 1696
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 18
-                type: 1697
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1697
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 6
-                type: 1697
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1697
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 26
-                num_resource: 2
-                type: 1697
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 12
-                type: 1698
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 2
-                type: 1698
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 2
-                type: 1698
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5
-                num_resource: 35
-                type: 1802
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 36
-                type: 1802
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 36
-                type: 1802
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 168
-                num_resource: 8
-                type: 1802
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 512
-                type: 1805
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 525
-                num_resource: 256
-                type: 1805
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 525
-                num_resource: 256
-                type: 1805
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 781
-                num_resource: 128
-                type: 1805
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 909
-                num_resource: 627
-                type: 1805
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1024
-                type: 1807
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 4096
-                num_resource: 29
-                type: 1808
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 4608
-                num_resource: 99
-                type: 1809
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5120
-                num_resource: 24
-                type: 1810
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5632
-                num_resource: 51
-                type: 1811
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 6144
-                num_resource: 51
-                type: 1812
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 6656
-                num_resource: 51
-                type: 1813
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 8192
-                num_resource: 32
-                type: 1814
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 8704
-                num_resource: 32
-                type: 1815
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 9216
-                num_resource: 32
-                type: 1816
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 9728
-                num_resource: 22
-                type: 1817
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 10240
-                num_resource: 22
-                type: 1818
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 10752
-                num_resource: 22
-                type: 1819
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 11264
-                num_resource: 28
-                type: 1820
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 11776
-                num_resource: 28
-                type: 1821
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 12288
-                num_resource: 28
-                type: 1822
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 1923
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1936
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1936
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1936
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 64
-                type: 1937
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 64
-                type: 1937
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 83
-                num_resource: 8
-                type: 1938
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 91
-                num_resource: 8
-                type: 1939
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 99
-                num_resource: 10
-                type: 1942
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 112
-                num_resource: 3
-                type: 1942
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 115
-                num_resource: 3
-                type: 1942
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 118
-                num_resource: 16
-                type: 1943
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 118
-                num_resource: 16
-                type: 1943
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 134
-                num_resource: 8
-                type: 1944
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 134
-                num_resource: 8
-                type: 1945
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 142
-                num_resource: 8
-                type: 1946
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 142
-                num_resource: 8
-                type: 1947
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1955
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1955
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1955
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 8
-                type: 1956
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 8
-                type: 1956
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 27
-                num_resource: 1
-                type: 1957
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 28
-                num_resource: 1
-                type: 1958
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1961
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1961
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1961
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1962
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1962
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1962
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 16
-                type: 1964
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 16
-                type: 1964
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 1
-                type: 1965
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 35
-                num_resource: 8
-                type: 1966
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 21
-                num_resource: 1
-                type: 1967
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 35
-                num_resource: 8
-                type: 1968
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 22
-                num_resource: 1
-                type: 1969
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 43
-                num_resource: 8
-                type: 1970
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 1
-                type: 1971
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 43
-                num_resource: 8
-                type: 1972
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 2112
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 2
-                num_resource: 2
-                type: 2122
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 16
+            type: 64
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 64
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 64
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 22
+            type: 64
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 192
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 2
+            type: 192
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 320
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 320
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 26
+            type: 384
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 50176
+            num_resource: 164
+            type: 1666
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1667
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1677
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 18
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 78
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 12
+            type: 1679
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 2
+            type: 1679
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 2
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1696
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 2
+            type: 1697
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1698
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 2
+            type: 1698
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 35
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 8
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 512
+            type: 1805
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 525
+            num_resource: 256
+            type: 1805
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 525
+            num_resource: 256
+            type: 1805
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 781
+            num_resource: 128
+            type: 1805
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 909
+            num_resource: 627
+            type: 1805
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1024
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 29
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 99
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 24
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 51
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6656
+            num_resource: 51
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 32
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 32
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 22
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 22
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 22
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 28
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 28
+            type: 1821
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 28
+            type: 1822
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1923
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1936
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1936
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1936
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 83
+            num_resource: 8
+            type: 1938
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 91
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 99
+            num_resource: 10
+            type: 1942
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 3
+            type: 1942
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 115
+            num_resource: 3
+            type: 1942
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1944
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1945
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1955
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1955
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1955
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1957
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1961
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1961
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1961
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1962
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1962
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1962
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 1
+            type: 1965
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1966
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 1
+            type: 1967
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1968
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
diff --git a/board/ti/am62x/sec-cfg.yaml b/board/ti/am62x/sec-cfg.yaml
index 07081ce06c..088b2dbaf1 100644
--- a/board/ti/am62x/sec-cfg.yaml
+++ b/board/ti/am62x/sec-cfg.yaml
@@ -8,138 +8,138 @@
 
 sec-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
     processor_acl_list:
         subhdr:
             magic: 0xF1EA
             size: 164
         proc_acl_entries:
-            - #1
+            -  # 1
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #2
+            -  # 2
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #3
+            -  # 3
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #4
+            -  # 4
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #5
+            -  # 5
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #6
+            -  # 6
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #7
+            -  # 7
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #8
+            -  # 8
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #9
+            -  # 9
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #10
+            -  # 10
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #11
+            -  # 11
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #12
+            -  # 12
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #13
+            -  # 13
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #14
+            -  # 14
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #15
+            -  # 15
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #16
+            -  # 16
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #17
+            -  # 17
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #18
+            -  # 18
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #19
+            -  # 19
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #20
+            -  # 20
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #21
+            -  # 21
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #22
+            -  # 22
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #23
+            -  # 23
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #24
+            -  # 24
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #25
+            -  # 25
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #26
+            -  # 26
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #27
+            -  # 27
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #28
+            -  # 28
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #29
+            -  # 29
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #30
+            -  # 30
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #31
+            -  # 31
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #32
+            -  # 32
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
@@ -148,202 +148,202 @@ sec-cfg:
             magic: 0x8D27
             size: 68
         host_hierarchy_entries:
-            - #1
+            -  # 1
                 host_id: 0
                 supervisor_host_id: 0
-            - #2
+            -  # 2
                 host_id: 0
                 supervisor_host_id: 0
-            - #3
+            -  # 3
                 host_id: 0
                 supervisor_host_id: 0
-            - #4
+            -  # 4
                 host_id: 0
                 supervisor_host_id: 0
-            - #5
+            -  # 5
                 host_id: 0
                 supervisor_host_id: 0
-            - #6
+            -  # 6
                 host_id: 0
                 supervisor_host_id: 0
-            - #7
+            -  # 7
                 host_id: 0
                 supervisor_host_id: 0
-            - #8
+            -  # 8
                 host_id: 0
                 supervisor_host_id: 0
-            - #9
+            -  # 9
                 host_id: 0
                 supervisor_host_id: 0
-            - #10
+            -  # 10
                 host_id: 0
                 supervisor_host_id: 0
-            - #11
+            -  # 11
                 host_id: 0
                 supervisor_host_id: 0
-            - #12
+            -  # 12
                 host_id: 0
                 supervisor_host_id: 0
-            - #13
+            -  # 13
                 host_id: 0
                 supervisor_host_id: 0
-            - #14
+            -  # 14
                 host_id: 0
                 supervisor_host_id: 0
-            - #15
+            -  # 15
                 host_id: 0
                 supervisor_host_id: 0
-            - #16
+            -  # 16
                 host_id: 0
                 supervisor_host_id: 0
-            - #17
+            -  # 17
                 host_id: 0
                 supervisor_host_id: 0
-            - #18
+            -  # 18
                 host_id: 0
                 supervisor_host_id: 0
-            - #19
+            -  # 19
                 host_id: 0
                 supervisor_host_id: 0
-            - #20
+            -  # 20
                 host_id: 0
                 supervisor_host_id: 0
-            - #21
+            -  # 21
                 host_id: 0
                 supervisor_host_id: 0
-            - #22
+            -  # 22
                 host_id: 0
                 supervisor_host_id: 0
-            - #23
+            -  # 23
                 host_id: 0
                 supervisor_host_id: 0
-            - #24
+            -  # 24
                 host_id: 0
                 supervisor_host_id: 0
-            - #25
+            -  # 25
                 host_id: 0
                 supervisor_host_id: 0
-            - #26
+            -  # 26
                 host_id: 0
                 supervisor_host_id: 0
-            - #27
+            -  # 27
                 host_id: 0
                 supervisor_host_id: 0
-            - #28
+            -  # 28
                 host_id: 0
                 supervisor_host_id: 0
-            - #29
+            -  # 29
                 host_id: 0
                 supervisor_host_id: 0
-            - #30
+            -  # 30
                 host_id: 0
                 supervisor_host_id: 0
-            - #31
+            -  # 31
                 host_id: 0
                 supervisor_host_id: 0
-            - #32
+            -  # 32
                 host_id: 0
                 supervisor_host_id: 0
     otp_config:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id : 0
+        write_host_id: 0
         otp_entry:
-            - #1
+            -  # 1
                 host_id: 0
                 host_perms: 0
-            - #2
+            -  # 2
                 host_id: 0
                 host_perms: 0
-            - #3
+            -  # 3
                 host_id: 0
                 host_perms: 0
-            - #4
+            -  # 4
                 host_id: 0
                 host_perms: 0
-            - #5
+            -  # 5
                 host_id: 0
                 host_perms: 0
-            - #6
+            -  # 6
                 host_id: 0
                 host_perms: 0
-            - #7
+            -  # 7
                 host_id: 0
                 host_perms: 0
-            - #8
+            -  # 8
                 host_id: 0
                 host_perms: 0
-            - #9
+            -  # 9
                 host_id: 0
                 host_perms: 0
-            - #10
+            -  # 10
                 host_id: 0
                 host_perms: 0
-            - #11
+            -  # 11
                 host_id: 0
                 host_perms: 0
-            - #12
+            -  # 12
                 host_id: 0
                 host_perms: 0
-            - #13
+            -  # 13
                 host_id: 0
                 host_perms: 0
-            - #14
+            -  # 14
                 host_id: 0
                 host_perms: 0
-            - #15
+            -  # 15
                 host_id: 0
                 host_perms: 0
-            - #16
+            -  # 16
                 host_id: 0
                 host_perms: 0
-            - #17
+            -  # 17
                 host_id: 0
                 host_perms: 0
-            - #18
+            -  # 18
                 host_id: 0
                 host_perms: 0
-            - #19
+            -  # 19
                 host_id: 0
                 host_perms: 0
-            - #20
+            -  # 20
                 host_id: 0
                 host_perms: 0
-            - #21
+            -  # 21
                 host_id: 0
                 host_perms: 0
-            - #22
+            -  # 22
                 host_id: 0
                 host_perms: 0
-            - #23
+            -  # 23
                 host_id: 0
                 host_perms: 0
-            - #24
+            -  # 24
                 host_id: 0
                 host_perms: 0
-            - #25
+            -  # 25
                 host_id: 0
                 host_perms: 0
-            - #26
+            -  # 26
                 host_id: 0
                 host_perms: 0
-            - #27
+            -  # 27
                 host_id: 0
                 host_perms: 0
-            - #28
+            -  # 28
                 host_id: 0
                 host_perms: 0
-            - #29
+            -  # 29
                 host_id: 0
                 host_perms: 0
-            - #30
+            -  # 30
                 host_id: 0
                 host_perms: 0
-            - #31
+            -  # 31
                 host_id: 0
                 host_perms: 0
-            - #32
+            -  # 32
                 host_id: 0
                 host_perms: 0
     dkek_config:
@@ -351,12 +351,12 @@ sec-cfg:
             magic: 0x5170
             size: 12
         allowed_hosts: [128, 0, 0, 0]
-        allow_dkek_export_tisci : 0x5A
+        allow_dkek_export_tisci: 0x5A
         rsvd: [0, 0, 0]
     sa2ul_cfg:
         subhdr:
             magic: 0x23BE
-            size : 0
+            size: 0
         auth_resource_owner: 0
         enable_saul_psil_global_config_writes: 0x5A
         rsvd: [0, 0]
@@ -364,16 +364,16 @@ sec-cfg:
         subhdr:
             magic: 0x42AF
             size: 16
-        allow_jtag_unlock : 0x5A
-        allow_wildcard_unlock : 0x5A
+        allow_jtag_unlock: 0x5A
+        allow_wildcard_unlock: 0x5A
         allowed_debug_level_rsvd: 0
         rsvd: 0
-        min_cert_rev : 0x0
+        min_cert_rev: 0x0
         jtag_unlock_hosts: [0, 0, 0, 0]
     sec_handover_cfg:
         subhdr:
             magic: 0x608F
             size: 10
-        handover_msg_sender : 0
-        handover_to_host_id : 0
+        handover_msg_sender: 0
+        handover_to_host_id: 0
         rsvd: [0, 0, 0, 0]
diff --git a/board/ti/am64x/board-cfg.yaml b/board/ti/am64x/board-cfg.yaml
index 62947c0820..8981b75caa 100644
--- a/board/ti/am64x/board-cfg.yaml
+++ b/board/ti/am64x/board-cfg.yaml
@@ -8,29 +8,29 @@
 
 board-cfg:
         rev:
-                boardcfg_abi_maj : 0x0
-                boardcfg_abi_min : 0x1
+                boardcfg_abi_maj: 0x0
+                boardcfg_abi_min: 0x1
         control:
                 subhdr:
                         magic: 0xC1D3
                         size: 7
-                main_isolation_enable : 0x5A
-                main_isolation_hostid : 0x2
+                main_isolation_enable: 0x5A
+                main_isolation_hostid: 0x2
         secproxy:
                 subhdr:
                         magic: 0x1207
                         size: 7
-                scaling_factor : 0x1
-                scaling_profile : 0x1
-                disable_main_nav_secure_proxy : 0
+                scaling_factor: 0x1
+                scaling_profile: 0x1
+                disable_main_nav_secure_proxy: 0
         msmc:
                 subhdr:
                         magic: 0xA5C3
                         size: 5
-                msmc_cache_size : 0x0
+                msmc_cache_size: 0x0
         debug_cfg:
                 subhdr:
                         magic: 0x020C
                         size: 8
-                trace_dst_enables : 0x00
-                trace_src_enables : 0x00
+                trace_dst_enables: 0x00
+                trace_src_enables: 0x00
diff --git a/board/ti/am64x/pm-cfg.yaml b/board/ti/am64x/pm-cfg.yaml
index 83c6a039f2..7afb296210 100644
--- a/board/ti/am64x/pm-cfg.yaml
+++ b/board/ti/am64x/pm-cfg.yaml
@@ -8,5 +8,5 @@
 
 pm-cfg:
         rev:
-                boardcfg_abi_maj : 0x0
-                boardcfg_abi_min : 0x1
+                boardcfg_abi_maj: 0x0
+                boardcfg_abi_min: 0x1
diff --git a/board/ti/am64x/rm-cfg.yaml b/board/ti/am64x/rm-cfg.yaml
index 1f4c6cf770..3e0c345763 100644
--- a/board/ti/am64x/rm-cfg.yaml
+++ b/board/ti/am64x/rm-cfg.yaml
@@ -9,56 +9,56 @@
 rm-cfg:
         rm_boardcfg:
                 rev:
-                        boardcfg_abi_maj : 0x0
-                        boardcfg_abi_min : 0x1
+                        boardcfg_abi_maj: 0x0
+                        boardcfg_abi_min: 0x1
                 host_cfg:
                         subhdr:
                                 magic: 0x4C41
-                                size : 356
+                                size: 356
                         host_cfg_entries:
-                                - #1
+                                -  # 1
                                         host_id: 12
-                                        allowed_atype : 0x2A
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #2
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 2
                                         host_id: 30
-                                        allowed_atype : 0x2A
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #3
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 3
                                         host_id: 36
-                                        allowed_atype : 0x2A
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #4
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 4
                                         host_id: 38
-                                        allowed_atype : 0x2A
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #5
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 5
                                         host_id: 41
-                                        allowed_atype : 0x2A
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #6
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 6
                                         host_id: 43
-                                        allowed_atype : 0x2A
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #7
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 7
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -66,7 +66,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #8
+                                -  # 8
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -74,7 +74,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #9
+                                -  # 9
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -82,7 +82,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #10
+                                -  # 10
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -90,7 +90,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #11
+                                -  # 11
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -98,7 +98,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #12
+                                -  # 12
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -106,7 +106,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #13
+                                -  # 13
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -114,7 +114,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #14
+                                -  # 14
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -122,7 +122,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #15
+                                -  # 15
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -130,7 +130,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #16
+                                -  # 16
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -138,7 +138,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #17
+                                -  # 17
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -146,7 +146,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #18
+                                -  # 18
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -154,7 +154,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #19
+                                -  # 19
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -162,7 +162,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #20
+                                -  # 20
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -170,7 +170,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #21
+                                -  # 21
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -178,7 +178,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #22
+                                -  # 22
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -186,7 +186,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #23
+                                -  # 23
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -194,7 +194,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #24
+                                -  # 24
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -202,7 +202,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #25
+                                -  # 25
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -210,7 +210,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #26
+                                -  # 26
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -218,7 +218,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #27
+                                -  # 27
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -226,7 +226,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #28
+                                -  # 28
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -234,7 +234,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #29
+                                -  # 29
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -242,7 +242,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #30
+                                -  # 30
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -250,7 +250,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #31
+                                -  # 31
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -258,7 +258,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #32
+                                -  # 32
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -268,1133 +268,1133 @@ rm-cfg:
                 resasg:
                         subhdr:
                                 magic: 0x7B25
-                                size : 8
+                                size: 8
                         resasg_entries_size: 1288
-                        reserved : 0
+                        reserved: 0
         resasg_entries:
-        -
-                start_resource: 0
-                num_resource: 16
-                type: 64
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 16
-                num_resource: 4
-                type: 64
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 16
-                num_resource: 4
-                type: 64
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 20
-                num_resource: 4
-                type: 64
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 24
-                num_resource: 4
-                type: 64
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 28
-                num_resource: 4
-                type: 64
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 32
-                num_resource: 8
-                type: 64
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 12
-                type: 192
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 12
-                num_resource: 2
-                type: 192
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 14
-                num_resource: 2
-                type: 192
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 4
-                type: 320
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 4
-                num_resource: 4
-                type: 320
-                host_id: 30
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 41
-                type: 384
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 50176
-                num_resource: 136
-                type: 1666
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 1667
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 12
-                type: 1677
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1677
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1677
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 18
-                num_resource: 2
-                type: 1677
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 20
-                num_resource: 4
-                type: 1677
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1677
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 26
-                num_resource: 1
-                type: 1677
-                host_id: 30
-                reserved: 0
-
-        -
-                start_resource: 27
-                num_resource: 1
-                type: 1677
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 48
-                num_resource: 6
-                type: 1678
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 54
-                num_resource: 6
-                type: 1678
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 54
-                num_resource: 6
-                type: 1678
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 60
-                num_resource: 2
-                type: 1678
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 62
-                num_resource: 4
-                type: 1678
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 66
-                num_resource: 2
-                type: 1678
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 28
-                num_resource: 6
-                type: 1679
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 34
-                num_resource: 6
-                type: 1679
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 34
-                num_resource: 6
-                type: 1679
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 40
-                num_resource: 2
-                type: 1679
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 42
-                num_resource: 4
-                type: 1679
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 46
-                num_resource: 2
-                type: 1679
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 12
-                type: 1696
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1696
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1696
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 18
-                num_resource: 2
-                type: 1696
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 20
-                num_resource: 4
-                type: 1696
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 1696
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 26
-                num_resource: 1
-                type: 1696
-                host_id: 30
-                reserved: 0
-
-        -
-                start_resource: 27
-                num_resource: 1
-                type: 1696
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 6
-                type: 1697
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 6
-                num_resource: 6
-                type: 1697
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 6
-                num_resource: 6
-                type: 1697
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 12
-                num_resource: 2
-                type: 1697
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 14
-                num_resource: 4
-                type: 1697
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 18
-                num_resource: 2
-                type: 1697
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 6
-                type: 1698
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 6
-                num_resource: 6
-                type: 1698
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 6
-                num_resource: 6
-                type: 1698
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 12
-                num_resource: 2
-                type: 1698
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 14
-                num_resource: 4
-                type: 1698
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 18
-                num_resource: 2
-                type: 1698
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 5
-                num_resource: 35
-                type: 1802
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 44
-                num_resource: 14
-                type: 1802
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 44
-                num_resource: 14
-                type: 1802
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 58
-                num_resource: 14
-                type: 1802
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 92
-                num_resource: 14
-                type: 1802
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 106
-                num_resource: 14
-                type: 1802
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 168
-                num_resource: 16
-                type: 1802
-                host_id: 30
-                reserved: 0
-
-        -
-                start_resource: 16
-                num_resource: 512
-                type: 1805
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 528
-                num_resource: 256
-                type: 1805
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 528
-                num_resource: 256
-                type: 1805
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 784
-                num_resource: 192
-                type: 1805
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 976
-                num_resource: 256
-                type: 1805
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 1232
-                num_resource: 192
-                type: 1805
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 1424
-                num_resource: 96
-                type: 1805
-                host_id: 30
-                reserved: 0
-
-        -
-                start_resource: 1520
-                num_resource: 16
-                type: 1805
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 1024
-                type: 1807
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 4096
-                num_resource: 42
-                type: 1808
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 4608
-                num_resource: 112
-                type: 1809
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 5120
-                num_resource: 29
-                type: 1810
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 5632
-                num_resource: 176
-                type: 1811
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 6144
-                num_resource: 176
-                type: 1812
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 6656
-                num_resource: 176
-                type: 1813
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 8192
-                num_resource: 28
-                type: 1814
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 8704
-                num_resource: 28
-                type: 1815
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 9216
-                num_resource: 28
-                type: 1816
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 9728
-                num_resource: 20
-                type: 1817
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 10240
-                num_resource: 20
-                type: 1818
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 10752
-                num_resource: 20
-                type: 1819
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 11264
-                num_resource: 20
-                type: 1820
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 11776
-                num_resource: 20
-                type: 1821
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 12288
-                num_resource: 20
-                type: 1822
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 1923
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 4
-                type: 1936
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 4
-                num_resource: 3
-                type: 1936
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 4
-                num_resource: 3
-                type: 1936
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 7
-                num_resource: 2
-                type: 1936
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 9
-                num_resource: 4
-                type: 1936
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 13
-                num_resource: 2
-                type: 1936
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 15
-                num_resource: 1
-                type: 1936
-                host_id: 30
-                reserved: 0
-
-        -
-                start_resource: 16
-                num_resource: 64
-                type: 1937
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 16
-                num_resource: 64
-                type: 1937
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 88
-                num_resource: 8
-                type: 1939
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 96
-                num_resource: 8
-                type: 1940
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 104
-                num_resource: 8
-                type: 1941
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 112
-                num_resource: 4
-                type: 1942
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 116
-                num_resource: 3
-                type: 1942
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 116
-                num_resource: 3
-                type: 1942
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 119
-                num_resource: 2
-                type: 1942
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 121
-                num_resource: 4
-                type: 1942
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 125
-                num_resource: 2
-                type: 1942
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 127
-                num_resource: 1
-                type: 1942
-                host_id: 30
-                reserved: 0
-
-        -
-                start_resource: 128
-                num_resource: 16
-                type: 1943
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 128
-                num_resource: 16
-                type: 1943
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 144
-                num_resource: 8
-                type: 1945
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 152
-                num_resource: 8
-                type: 1946
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 152
-                num_resource: 8
-                type: 1947
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 160
-                num_resource: 64
-                type: 1948
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 224
-                num_resource: 64
-                type: 1949
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 4
-                type: 1955
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 4
-                num_resource: 3
-                type: 1955
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 4
-                num_resource: 3
-                type: 1955
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 7
-                num_resource: 2
-                type: 1955
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 9
-                num_resource: 4
-                type: 1955
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 13
-                num_resource: 2
-                type: 1955
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 15
-                num_resource: 1
-                type: 1955
-                host_id: 30
-                reserved: 0
-
-        -
-                start_resource: 16
-                num_resource: 8
-                type: 1956
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 16
-                num_resource: 8
-                type: 1956
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 25
-                num_resource: 1
-                type: 1958
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 26
-                num_resource: 8
-                type: 1959
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 34
-                num_resource: 8
-                type: 1960
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 4
-                type: 1961
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 4
-                num_resource: 3
-                type: 1961
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 4
-                num_resource: 3
-                type: 1961
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 7
-                num_resource: 2
-                type: 1961
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 9
-                num_resource: 4
-                type: 1961
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 13
-                num_resource: 2
-                type: 1961
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 15
-                num_resource: 1
-                type: 1961
-                host_id: 30
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 4
-                type: 1962
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 4
-                num_resource: 3
-                type: 1962
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 4
-                num_resource: 3
-                type: 1962
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 7
-                num_resource: 2
-                type: 1962
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 9
-                num_resource: 4
-                type: 1962
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 13
-                num_resource: 2
-                type: 1962
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 15
-                num_resource: 1
-                type: 1962
-                host_id: 30
-                reserved: 0
-
-        -
-                start_resource: 16
-                num_resource: 1
-                type: 1963
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 16
-                num_resource: 1
-                type: 1963
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 16
-                num_resource: 16
-                type: 1964
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 16
-                num_resource: 16
-                type: 1964
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 32
-                num_resource: 8
-                type: 1966
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 32
-                num_resource: 8
-                type: 1968
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 19
-                num_resource: 1
-                type: 1969
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 40
-                num_resource: 8
-                type: 1970
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 20
-                num_resource: 1
-                type: 1971
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 40
-                num_resource: 8
-                type: 1972
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 21
-                num_resource: 4
-                type: 1973
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 48
-                num_resource: 64
-                type: 1974
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 25
-                num_resource: 4
-                type: 1975
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 112
-                num_resource: 64
-                type: 1976
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 2112
-                host_id: 128
-                reserved: 0
-
-        -
-                start_resource: 2
-                num_resource: 2
-                type: 2122
-                host_id: 12
-                reserved: 0
-
-        -
-                start_resource: 20
-                num_resource: 2
-                type: 2124
-                host_id: 35
-                reserved: 0
-
-        -
-                start_resource: 20
-                num_resource: 2
-                type: 2124
-                host_id: 36
-                reserved: 0
-
-        -
-                start_resource: 22
-                num_resource: 2
-                type: 2124
-                host_id: 38
-                reserved: 0
-
-        -
-                start_resource: 24
-                num_resource: 2
-                type: 2124
-                host_id: 41
-                reserved: 0
-
-        -
-                start_resource: 26
-                num_resource: 2
-                type: 2124
-                host_id: 43
-                reserved: 0
-
-        -
-                start_resource: 28
-                num_resource: 4
-                type: 2124
-                host_id: 128
-                reserved: 0
+                -
+                        start_resource: 0
+                        num_resource: 16
+                        type: 64
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 4
+                        type: 64
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 4
+                        type: 64
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 20
+                        num_resource: 4
+                        type: 64
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 4
+                        type: 64
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 28
+                        num_resource: 4
+                        type: 64
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 32
+                        num_resource: 8
+                        type: 64
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 12
+                        type: 192
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 2
+                        type: 192
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 14
+                        num_resource: 2
+                        type: 192
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 4
+                        type: 320
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 4
+                        type: 320
+                        host_id: 30
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 41
+                        type: 384
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 50176
+                        num_resource: 136
+                        type: 1666
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 1
+                        type: 1667
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 12
+                        type: 1677
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 6
+                        type: 1677
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 6
+                        type: 1677
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 18
+                        num_resource: 2
+                        type: 1677
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 20
+                        num_resource: 4
+                        type: 1677
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 2
+                        type: 1677
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 26
+                        num_resource: 1
+                        type: 1677
+                        host_id: 30
+                        reserved: 0
+
+                -
+                        start_resource: 27
+                        num_resource: 1
+                        type: 1677
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 48
+                        num_resource: 6
+                        type: 1678
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 54
+                        num_resource: 6
+                        type: 1678
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 54
+                        num_resource: 6
+                        type: 1678
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 60
+                        num_resource: 2
+                        type: 1678
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 62
+                        num_resource: 4
+                        type: 1678
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 66
+                        num_resource: 2
+                        type: 1678
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 28
+                        num_resource: 6
+                        type: 1679
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 34
+                        num_resource: 6
+                        type: 1679
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 34
+                        num_resource: 6
+                        type: 1679
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 40
+                        num_resource: 2
+                        type: 1679
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 42
+                        num_resource: 4
+                        type: 1679
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 46
+                        num_resource: 2
+                        type: 1679
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 12
+                        type: 1696
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 6
+                        type: 1696
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 6
+                        type: 1696
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 18
+                        num_resource: 2
+                        type: 1696
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 20
+                        num_resource: 4
+                        type: 1696
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 2
+                        type: 1696
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 26
+                        num_resource: 1
+                        type: 1696
+                        host_id: 30
+                        reserved: 0
+
+                -
+                        start_resource: 27
+                        num_resource: 1
+                        type: 1696
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 6
+                        type: 1697
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 6
+                        num_resource: 6
+                        type: 1697
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 6
+                        num_resource: 6
+                        type: 1697
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 2
+                        type: 1697
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 14
+                        num_resource: 4
+                        type: 1697
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 18
+                        num_resource: 2
+                        type: 1697
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 6
+                        type: 1698
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 6
+                        num_resource: 6
+                        type: 1698
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 6
+                        num_resource: 6
+                        type: 1698
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 2
+                        type: 1698
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 14
+                        num_resource: 4
+                        type: 1698
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 18
+                        num_resource: 2
+                        type: 1698
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 5
+                        num_resource: 35
+                        type: 1802
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 44
+                        num_resource: 14
+                        type: 1802
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 44
+                        num_resource: 14
+                        type: 1802
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 58
+                        num_resource: 14
+                        type: 1802
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 92
+                        num_resource: 14
+                        type: 1802
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 106
+                        num_resource: 14
+                        type: 1802
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 168
+                        num_resource: 16
+                        type: 1802
+                        host_id: 30
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 512
+                        type: 1805
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 528
+                        num_resource: 256
+                        type: 1805
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 528
+                        num_resource: 256
+                        type: 1805
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 784
+                        num_resource: 192
+                        type: 1805
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 976
+                        num_resource: 256
+                        type: 1805
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 1232
+                        num_resource: 192
+                        type: 1805
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 1424
+                        num_resource: 96
+                        type: 1805
+                        host_id: 30
+                        reserved: 0
+
+                -
+                        start_resource: 1520
+                        num_resource: 16
+                        type: 1805
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 1024
+                        type: 1807
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 4096
+                        num_resource: 42
+                        type: 1808
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 4608
+                        num_resource: 112
+                        type: 1809
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 5120
+                        num_resource: 29
+                        type: 1810
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 5632
+                        num_resource: 176
+                        type: 1811
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 6144
+                        num_resource: 176
+                        type: 1812
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 6656
+                        num_resource: 176
+                        type: 1813
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 8192
+                        num_resource: 28
+                        type: 1814
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 8704
+                        num_resource: 28
+                        type: 1815
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 9216
+                        num_resource: 28
+                        type: 1816
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 9728
+                        num_resource: 20
+                        type: 1817
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 10240
+                        num_resource: 20
+                        type: 1818
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 10752
+                        num_resource: 20
+                        type: 1819
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 11264
+                        num_resource: 20
+                        type: 1820
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 11776
+                        num_resource: 20
+                        type: 1821
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 12288
+                        num_resource: 20
+                        type: 1822
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 1
+                        type: 1923
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 4
+                        type: 1936
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 3
+                        type: 1936
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 3
+                        type: 1936
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 7
+                        num_resource: 2
+                        type: 1936
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 9
+                        num_resource: 4
+                        type: 1936
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 13
+                        num_resource: 2
+                        type: 1936
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 15
+                        num_resource: 1
+                        type: 1936
+                        host_id: 30
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 64
+                        type: 1937
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 64
+                        type: 1937
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 88
+                        num_resource: 8
+                        type: 1939
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 96
+                        num_resource: 8
+                        type: 1940
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 104
+                        num_resource: 8
+                        type: 1941
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 112
+                        num_resource: 4
+                        type: 1942
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 116
+                        num_resource: 3
+                        type: 1942
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 116
+                        num_resource: 3
+                        type: 1942
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 119
+                        num_resource: 2
+                        type: 1942
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 121
+                        num_resource: 4
+                        type: 1942
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 125
+                        num_resource: 2
+                        type: 1942
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 127
+                        num_resource: 1
+                        type: 1942
+                        host_id: 30
+                        reserved: 0
+
+                -
+                        start_resource: 128
+                        num_resource: 16
+                        type: 1943
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 128
+                        num_resource: 16
+                        type: 1943
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 144
+                        num_resource: 8
+                        type: 1945
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 152
+                        num_resource: 8
+                        type: 1946
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 152
+                        num_resource: 8
+                        type: 1947
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 160
+                        num_resource: 64
+                        type: 1948
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 224
+                        num_resource: 64
+                        type: 1949
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 4
+                        type: 1955
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 3
+                        type: 1955
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 3
+                        type: 1955
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 7
+                        num_resource: 2
+                        type: 1955
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 9
+                        num_resource: 4
+                        type: 1955
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 13
+                        num_resource: 2
+                        type: 1955
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 15
+                        num_resource: 1
+                        type: 1955
+                        host_id: 30
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 8
+                        type: 1956
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 8
+                        type: 1956
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 25
+                        num_resource: 1
+                        type: 1958
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 26
+                        num_resource: 8
+                        type: 1959
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 34
+                        num_resource: 8
+                        type: 1960
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 4
+                        type: 1961
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 3
+                        type: 1961
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 3
+                        type: 1961
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 7
+                        num_resource: 2
+                        type: 1961
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 9
+                        num_resource: 4
+                        type: 1961
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 13
+                        num_resource: 2
+                        type: 1961
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 15
+                        num_resource: 1
+                        type: 1961
+                        host_id: 30
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 4
+                        type: 1962
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 3
+                        type: 1962
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 3
+                        type: 1962
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 7
+                        num_resource: 2
+                        type: 1962
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 9
+                        num_resource: 4
+                        type: 1962
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 13
+                        num_resource: 2
+                        type: 1962
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 15
+                        num_resource: 1
+                        type: 1962
+                        host_id: 30
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 1
+                        type: 1963
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 1
+                        type: 1963
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 16
+                        type: 1964
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 16
+                        type: 1964
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 32
+                        num_resource: 8
+                        type: 1966
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 32
+                        num_resource: 8
+                        type: 1968
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 19
+                        num_resource: 1
+                        type: 1969
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 40
+                        num_resource: 8
+                        type: 1970
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 20
+                        num_resource: 1
+                        type: 1971
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 40
+                        num_resource: 8
+                        type: 1972
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 21
+                        num_resource: 4
+                        type: 1973
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 48
+                        num_resource: 64
+                        type: 1974
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 25
+                        num_resource: 4
+                        type: 1975
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 112
+                        num_resource: 64
+                        type: 1976
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 1
+                        type: 2112
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 2
+                        num_resource: 2
+                        type: 2122
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 20
+                        num_resource: 2
+                        type: 2124
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 20
+                        num_resource: 2
+                        type: 2124
+                        host_id: 36
+                        reserved: 0
+
+                -
+                        start_resource: 22
+                        num_resource: 2
+                        type: 2124
+                        host_id: 38
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 2
+                        type: 2124
+                        host_id: 41
+                        reserved: 0
+
+                -
+                        start_resource: 26
+                        num_resource: 2
+                        type: 2124
+                        host_id: 43
+                        reserved: 0
+
+                -
+                        start_resource: 28
+                        num_resource: 4
+                        type: 2124
+                        host_id: 128
+                        reserved: 0
diff --git a/board/ti/am64x/sec-cfg.yaml b/board/ti/am64x/sec-cfg.yaml
index 7c51fd3406..9b256740f3 100644
--- a/board/ti/am64x/sec-cfg.yaml
+++ b/board/ti/am64x/sec-cfg.yaml
@@ -8,138 +8,138 @@
 
 sec-cfg:
         rev:
-                boardcfg_abi_maj : 0x0
-                boardcfg_abi_min : 0x1
+                boardcfg_abi_maj: 0x0
+                boardcfg_abi_min: 0x1
         processor_acl_list:
                 subhdr:
                         magic: 0xF1EA
                         size: 164
                 proc_acl_entries:
-                        - #1
+                        -  # 1
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #2
+                        -  # 2
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #3
+                        -  # 3
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #4
+                        -  # 4
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #5
+                        -  # 5
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #6
+                        -  # 6
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #7
+                        -  # 7
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #8
+                        -  # 8
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #9
+                        -  # 9
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #10
+                        -  # 10
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #11
+                        -  # 11
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #12
+                        -  # 12
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #13
+                        -  # 13
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #14
+                        -  # 14
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #15
+                        -  # 15
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #16
+                        -  # 16
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #17
+                        -  # 17
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #18
+                        -  # 18
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #19
+                        -  # 19
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #20
+                        -  # 20
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #21
+                        -  # 21
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #22
+                        -  # 22
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #23
+                        -  # 23
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #24
+                        -  # 24
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #25
+                        -  # 25
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #26
+                        -  # 26
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #27
+                        -  # 27
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #28
+                        -  # 28
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #29
+                        -  # 29
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #30
+                        -  # 30
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #31
+                        -  # 31
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #32
+                        -  # 32
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
@@ -149,202 +149,202 @@ sec-cfg:
                         magic: 0x8D27
                         size: 68
                 host_hierarchy_entries:
-                        - #1
+                        -  # 1
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #2
+                        -  # 2
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #3
+                        -  # 3
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #4
+                        -  # 4
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #5
+                        -  # 5
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #6
+                        -  # 6
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #7
+                        -  # 7
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #8
+                        -  # 8
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #9
+                        -  # 9
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #10
+                        -  # 10
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #11
+                        -  # 11
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #12
+                        -  # 12
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #13
+                        -  # 13
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #14
+                        -  # 14
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #15
+                        -  # 15
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #16
+                        -  # 16
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #17
+                        -  # 17
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #18
+                        -  # 18
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #19
+                        -  # 19
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #20
+                        -  # 20
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #21
+                        -  # 21
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #22
+                        -  # 22
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #23
+                        -  # 23
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #24
+                        -  # 24
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #25
+                        -  # 25
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #26
+                        -  # 26
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #27
+                        -  # 27
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #28
+                        -  # 28
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #29
+                        -  # 29
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #30
+                        -  # 30
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #31
+                        -  # 31
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #32
+                        -  # 32
                                 host_id: 0
                                 supervisor_host_id: 0
         otp_config:
                 subhdr:
                         magic: 0x4081
                         size: 69
-                write_host_id : 0
+                write_host_id: 0
                 otp_entry:
-                        - #1
+                        -  # 1
                                 host_id: 0
                                 host_perms: 0
-                        - #2
+                        -  # 2
                                 host_id: 0
                                 host_perms: 0
-                        - #3
+                        -  # 3
                                 host_id: 0
                                 host_perms: 0
-                        - #4
+                        -  # 4
                                 host_id: 0
                                 host_perms: 0
-                        - #5
+                        -  # 5
                                 host_id: 0
                                 host_perms: 0
-                        - #6
+                        -  # 6
                                 host_id: 0
                                 host_perms: 0
-                        - #7
+                        -  # 7
                                 host_id: 0
                                 host_perms: 0
-                        - #8
+                        -  # 8
                                 host_id: 0
                                 host_perms: 0
-                        - #9
+                        -  # 9
                                 host_id: 0
                                 host_perms: 0
-                        - #10
+                        -  # 10
                                 host_id: 0
                                 host_perms: 0
-                        - #11
+                        -  # 11
                                 host_id: 0
                                 host_perms: 0
-                        - #12
+                        -  # 12
                                 host_id: 0
                                 host_perms: 0
-                        - #13
+                        -  # 13
                                 host_id: 0
                                 host_perms: 0
-                        - #14
+                        -  # 14
                                 host_id: 0
                                 host_perms: 0
-                        - #15
+                        -  # 15
                                 host_id: 0
                                 host_perms: 0
-                        - #16
+                        -  # 16
                                 host_id: 0
                                 host_perms: 0
-                        - #17
+                        -  # 17
                                 host_id: 0
                                 host_perms: 0
-                        - #18
+                        -  # 18
                                 host_id: 0
                                 host_perms: 0
-                        - #19
+                        -  # 19
                                 host_id: 0
                                 host_perms: 0
-                        - #20
+                        -  # 20
                                 host_id: 0
                                 host_perms: 0
-                        - #21
+                        -  # 21
                                 host_id: 0
                                 host_perms: 0
-                        - #22
+                        -  # 22
                                 host_id: 0
                                 host_perms: 0
-                        - #23
+                        -  # 23
                                 host_id: 0
                                 host_perms: 0
-                        - #24
+                        -  # 24
                                 host_id: 0
                                 host_perms: 0
-                        - #25
+                        -  # 25
                                 host_id: 0
                                 host_perms: 0
-                        - #26
+                        -  # 26
                                 host_id: 0
                                 host_perms: 0
-                        - #27
+                        -  # 27
                                 host_id: 0
                                 host_perms: 0
-                        - #28
+                        -  # 28
                                 host_id: 0
                                 host_perms: 0
-                        - #29
+                        -  # 29
                                 host_id: 0
                                 host_perms: 0
-                        - #30
+                        -  # 30
                                 host_id: 0
                                 host_perms: 0
-                        - #31
+                        -  # 31
                                 host_id: 0
                                 host_perms: 0
-                        - #32
+                        -  # 32
                                 host_id: 0
                                 host_perms: 0
         dkek_config:
@@ -352,12 +352,12 @@ sec-cfg:
                         magic: 0x5170
                         size: 12
                 allowed_hosts: [128, 0, 0, 0]
-                allow_dkek_export_tisci : 0x5A
+                allow_dkek_export_tisci: 0x5A
                 rsvd: [0, 0, 0]
         sa2ul_cfg:
                 subhdr:
                         magic: 0x23BE
-                        size : 0
+                        size: 0
                 auth_resource_owner: 0
                 enable_saul_psil_global_config_writes: 0
                 rsvd: [0, 0]
@@ -365,16 +365,16 @@ sec-cfg:
                 subhdr:
                         magic: 0x42AF
                         size: 16
-                allow_jtag_unlock : 0x5A
-                allow_wildcard_unlock : 0x5A
-                allowed_debug_level_rsvd : 0
-                rsvd : 0
-                min_cert_rev : 0x0
+                allow_jtag_unlock: 0x5A
+                allow_wildcard_unlock: 0x5A
+                allowed_debug_level_rsvd: 0
+                rsvd: 0
+                min_cert_rev: 0x0
                 jtag_unlock_hosts: [0, 0, 0, 0]
         sec_handover_cfg:
                 subhdr:
                         magic: 0x608F
                         size: 10
-                handover_msg_sender : 0
-                handover_to_host_id : 0
+                handover_msg_sender: 0
+                handover_to_host_id: 0
                 rsvd: [0, 0, 0, 0]
diff --git a/board/ti/am65x/board-cfg.yaml b/board/ti/am65x/board-cfg.yaml
index a8e06166d5..6fe66f11b2 100644
--- a/board/ti/am65x/board-cfg.yaml
+++ b/board/ti/am65x/board-cfg.yaml
@@ -8,29 +8,29 @@
 
 board-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
     control:
         subhdr:
             magic: 0xC1D3
             size: 7
-        main_isolation_enable : 0x5A
-        main_isolation_hostid : 0x2
+        main_isolation_enable: 0x5A
+        main_isolation_hostid: 0x2
     secproxy:
         subhdr:
             magic: 0x1207
             size: 7
-        scaling_factor : 0x1
-        scaling_profile : 0x1
-        disable_main_nav_secure_proxy : 0
+        scaling_factor: 0x1
+        scaling_profile: 0x1
+        disable_main_nav_secure_proxy: 0
     msmc:
         subhdr:
             magic: 0xA5C3
             size: 5
-        msmc_cache_size : 0x10
+        msmc_cache_size: 0x10
     debug_cfg:
         subhdr:
             magic: 0x020C
             size: 8
-        trace_dst_enables : 0x00
-        trace_src_enables : 0x00
+        trace_dst_enables: 0x00
+        trace_src_enables: 0x00
diff --git a/board/ti/am65x/pm-cfg.yaml b/board/ti/am65x/pm-cfg.yaml
index 73fe86c29a..ee0d1c67a7 100644
--- a/board/ti/am65x/pm-cfg.yaml
+++ b/board/ti/am65x/pm-cfg.yaml
@@ -8,5 +8,5 @@
 
 pm-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
diff --git a/board/ti/am65x/rm-cfg.yaml b/board/ti/am65x/rm-cfg.yaml
index 5903773e81..b1e483a7be 100644
--- a/board/ti/am65x/rm-cfg.yaml
+++ b/board/ti/am65x/rm-cfg.yaml
@@ -9,2060 +9,2060 @@
 rm-cfg:
     rm_boardcfg:
         rev:
-            boardcfg_abi_maj : 0x0
-            boardcfg_abi_min : 0x1
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
         host_cfg:
             subhdr:
                 magic: 0x4C41
-                size : 356
+                size: 356
             host_cfg_entries:
-                - #1
+                -  # 1
                     host_id: 3
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #2
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 2
                     host_id: 5
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #3
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
                     host_id: 12
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #4
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
                     host_id: 13
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #5
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 5
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #6
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 6
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #7
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 7
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #8
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 8
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #9
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 9
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #10
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 10
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #11
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 11
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #12
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 12
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #13
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #14
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #15
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #16
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #17
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #18
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #19
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #20
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #21
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #22
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #23
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #24
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #25
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #26
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #27
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #28
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #29
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #30
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #31
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #32
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
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
             resasg_entries_size: 2080
-            reserved : 0
+            reserved: 0
     resasg_entries:
         -
-                start_resource: 0
-                num_resource: 12
-                type: 192
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 12
+            type: 192
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 4
-                type: 192
-                host_id: 13
-                reserved: 0
+            start_resource: 12
+            num_resource: 4
+            type: 192
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 8
-                type: 192
-                host_id: 3
-                reserved: 0
+            start_resource: 16
+            num_resource: 8
+            type: 192
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 8
-                type: 192
-                host_id: 4
-                reserved: 0
+            start_resource: 16
+            num_resource: 8
+            type: 192
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 8
-                type: 192
-                host_id: 5
-                reserved: 0
+            start_resource: 24
+            num_resource: 8
+            type: 192
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 32
-                type: 6208
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 32
+            type: 6208
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 32
-                type: 6208
-                host_id: 4
-                reserved: 0
+            start_resource: 0
+            num_resource: 32
+            type: 6208
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 32
-                num_resource: 32
-                type: 6208
-                host_id: 5
-                reserved: 0
+            start_resource: 32
+            num_resource: 32
+            type: 6208
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 24
-                type: 6272
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 24
+            type: 6272
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 24
-                type: 6272
-                host_id: 4
-                reserved: 0
+            start_resource: 0
+            num_resource: 24
+            type: 6272
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 24
-                type: 6272
-                host_id: 5
-                reserved: 0
+            start_resource: 24
+            num_resource: 24
+            type: 6272
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 20
-                type: 6400
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 20
+            type: 6400
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 4
-                type: 6400
-                host_id: 13
-                reserved: 0
+            start_resource: 20
+            num_resource: 4
+            type: 6400
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 4
-                type: 6400
-                host_id: 3
-                reserved: 0
+            start_resource: 24
+            num_resource: 4
+            type: 6400
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 4
-                type: 6400
-                host_id: 4
-                reserved: 0
+            start_resource: 24
+            num_resource: 4
+            type: 6400
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 28
-                num_resource: 4
-                type: 6400
-                host_id: 5
-                reserved: 0
+            start_resource: 28
+            num_resource: 4
+            type: 6400
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 16
-                type: 9280
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 16
+            type: 9280
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 16
-                type: 9280
-                host_id: 4
-                reserved: 0
+            start_resource: 0
+            num_resource: 16
+            type: 9280
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 16
-                type: 9280
-                host_id: 5
-                reserved: 0
+            start_resource: 16
+            num_resource: 16
+            type: 9280
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 32
-                num_resource: 8
-                type: 9280
-                host_id: 128
-                reserved: 0
+            start_resource: 32
+            num_resource: 8
+            type: 9280
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 4
-                type: 9984
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 4
+            type: 9984
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 4
-                type: 9984
-                host_id: 13
-                reserved: 0
+            start_resource: 4
+            num_resource: 4
+            type: 9984
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 4
-                type: 9984
-                host_id: 3
-                reserved: 0
+            start_resource: 8
+            num_resource: 4
+            type: 9984
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 4
-                type: 9984
-                host_id: 4
-                reserved: 0
+            start_resource: 8
+            num_resource: 4
+            type: 9984
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 4
-                type: 9984
-                host_id: 5
-                reserved: 0
+            start_resource: 12
+            num_resource: 4
+            type: 9984
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 80
-                type: 11466
-                host_id: 12
-                reserved: 0
+            start_resource: 16
+            num_resource: 80
+            type: 11466
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 96
-                num_resource: 30
-                type: 11466
-                host_id: 13
-                reserved: 0
+            start_resource: 96
+            num_resource: 30
+            type: 11466
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 126
-                num_resource: 50
-                type: 11466
-                host_id: 3
-                reserved: 0
+            start_resource: 126
+            num_resource: 50
+            type: 11466
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 126
-                num_resource: 50
-                type: 11466
-                host_id: 4
-                reserved: 0
+            start_resource: 126
+            num_resource: 50
+            type: 11466
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 176
-                num_resource: 50
-                type: 11466
-                host_id: 5
-                reserved: 0
+            start_resource: 176
+            num_resource: 50
+            type: 11466
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 226
-                num_resource: 30
-                type: 11466
-                host_id: 128
-                reserved: 0
+            start_resource: 226
+            num_resource: 30
+            type: 11466
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 1024
-                type: 11469
-                host_id: 12
-                reserved: 0
+            start_resource: 16
+            num_resource: 1024
+            type: 11469
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 1040
-                num_resource: 512
-                type: 11469
-                host_id: 13
-                reserved: 0
+            start_resource: 1040
+            num_resource: 512
+            type: 11469
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 1552
-                num_resource: 512
-                type: 11469
-                host_id: 3
-                reserved: 0
+            start_resource: 1552
+            num_resource: 512
+            type: 11469
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 1552
-                num_resource: 512
-                type: 11469
-                host_id: 4
-                reserved: 0
+            start_resource: 1552
+            num_resource: 512
+            type: 11469
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 2064
-                num_resource: 512
-                type: 11469
-                host_id: 5
-                reserved: 0
+            start_resource: 2064
+            num_resource: 512
+            type: 11469
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 2576
-                num_resource: 2032
-                type: 11469
-                host_id: 128
-                reserved: 0
+            start_resource: 2576
+            num_resource: 2032
+            type: 11469
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 64
-                type: 11530
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 64
+            type: 11530
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 20480
-                num_resource: 1024
-                type: 11533
-                host_id: 128
-                reserved: 0
+            start_resource: 20480
+            num_resource: 1024
+            type: 11533
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 64
-                type: 11594
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 64
+            type: 11594
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 22528
-                num_resource: 1024
-                type: 11597
-                host_id: 128
-                reserved: 0
+            start_resource: 22528
+            num_resource: 1024
+            type: 11597
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 64
-                type: 11648
-                host_id: 12
-                reserved: 0
+            start_resource: 16
+            num_resource: 64
+            type: 11648
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 80
-                num_resource: 40
-                type: 11648
-                host_id: 13
-                reserved: 0
+            start_resource: 80
+            num_resource: 40
+            type: 11648
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 120
-                num_resource: 4
-                type: 11648
-                host_id: 3
-                reserved: 0
+            start_resource: 120
+            num_resource: 4
+            type: 11648
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 120
-                num_resource: 4
-                type: 11648
-                host_id: 4
-                reserved: 0
+            start_resource: 120
+            num_resource: 4
+            type: 11648
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 124
-                num_resource: 4
-                type: 11648
-                host_id: 5
-                reserved: 0
+            start_resource: 124
+            num_resource: 4
+            type: 11648
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 128
-                num_resource: 24
-                type: 11648
-                host_id: 128
-                reserved: 0
+            start_resource: 128
+            num_resource: 24
+            type: 11648
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 12
-                type: 11840
-                host_id: 12
-                reserved: 0
+            start_resource: 1
+            num_resource: 12
+            type: 11840
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 13
-                num_resource: 4
-                type: 11840
-                host_id: 13
-                reserved: 0
+            start_resource: 13
+            num_resource: 4
+            type: 11840
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 17
-                num_resource: 16
-                type: 11840
-                host_id: 3
-                reserved: 0
+            start_resource: 17
+            num_resource: 16
+            type: 11840
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 17
-                num_resource: 16
-                type: 11840
-                host_id: 4
-                reserved: 0
+            start_resource: 17
+            num_resource: 16
+            type: 11840
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 33
-                num_resource: 16
-                type: 11840
-                host_id: 5
-                reserved: 0
+            start_resource: 33
+            num_resource: 16
+            type: 11840
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 49
-                num_resource: 15
-                type: 11840
-                host_id: 128
-                reserved: 0
+            start_resource: 49
+            num_resource: 15
+            type: 11840
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 11968
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 11968
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 304
-                num_resource: 100
-                type: 11969
-                host_id: 12
-                reserved: 0
+            start_resource: 304
+            num_resource: 100
+            type: 11969
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 404
-                num_resource: 50
-                type: 11969
-                host_id: 13
-                reserved: 0
+            start_resource: 404
+            num_resource: 50
+            type: 11969
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 454
-                num_resource: 256
-                type: 11969
-                host_id: 3
-                reserved: 0
+            start_resource: 454
+            num_resource: 256
+            type: 11969
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 454
-                num_resource: 256
-                type: 11969
-                host_id: 4
-                reserved: 0
+            start_resource: 454
+            num_resource: 256
+            type: 11969
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 710
-                num_resource: 32
-                type: 11969
-                host_id: 5
-                reserved: 0
+            start_resource: 710
+            num_resource: 32
+            type: 11969
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 742
-                num_resource: 26
-                type: 11969
-                host_id: 128
-                reserved: 0
+            start_resource: 742
+            num_resource: 26
+            type: 11969
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 160
-                num_resource: 12
-                type: 11970
-                host_id: 12
-                reserved: 0
+            start_resource: 160
+            num_resource: 12
+            type: 11970
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 172
-                num_resource: 4
-                type: 11970
-                host_id: 3
-                reserved: 0
+            start_resource: 172
+            num_resource: 4
+            type: 11970
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 172
-                num_resource: 4
-                type: 11970
-                host_id: 4
-                reserved: 0
+            start_resource: 172
+            num_resource: 4
+            type: 11970
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 172
-                num_resource: 0
-                type: 11970
-                host_id: 13
-                reserved: 0
+            start_resource: 172
+            num_resource: 0
+            type: 11970
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 176
-                num_resource: 2
-                type: 11970
-                host_id: 5
-                reserved: 0
+            start_resource: 176
+            num_resource: 2
+            type: 11970
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 178
-                num_resource: 52
-                type: 11970
-                host_id: 12
-                reserved: 0
+            start_resource: 178
+            num_resource: 52
+            type: 11970
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 230
-                num_resource: 8
-                type: 11970
-                host_id: 13
-                reserved: 0
+            start_resource: 230
+            num_resource: 8
+            type: 11970
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 238
-                num_resource: 32
-                type: 11970
-                host_id: 3
-                reserved: 0
+            start_resource: 238
+            num_resource: 32
+            type: 11970
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 238
-                num_resource: 32
-                type: 11970
-                host_id: 4
-                reserved: 0
+            start_resource: 238
+            num_resource: 32
+            type: 11970
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 270
-                num_resource: 14
-                type: 11970
-                host_id: 5
-                reserved: 0
+            start_resource: 270
+            num_resource: 14
+            type: 11970
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 284
-                num_resource: 18
-                type: 11970
-                host_id: 128
-                reserved: 0
+            start_resource: 284
+            num_resource: 18
+            type: 11970
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 12
-                type: 11971
-                host_id: 12
-                reserved: 0
+            start_resource: 8
+            num_resource: 12
+            type: 11971
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 4
-                type: 11971
-                host_id: 3
-                reserved: 0
+            start_resource: 20
+            num_resource: 4
+            type: 11971
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 4
-                type: 11971
-                host_id: 4
-                reserved: 0
+            start_resource: 20
+            num_resource: 4
+            type: 11971
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 0
-                type: 11971
-                host_id: 13
-                reserved: 0
+            start_resource: 20
+            num_resource: 0
+            type: 11971
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 2
-                type: 11971
-                host_id: 5
-                reserved: 0
+            start_resource: 24
+            num_resource: 2
+            type: 11971
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 38
-                type: 11971
-                host_id: 12
-                reserved: 0
+            start_resource: 26
+            num_resource: 38
+            type: 11971
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 64
-                num_resource: 8
-                type: 11971
-                host_id: 13
-                reserved: 0
+            start_resource: 64
+            num_resource: 8
+            type: 11971
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 72
-                num_resource: 32
-                type: 11971
-                host_id: 3
-                reserved: 0
+            start_resource: 72
+            num_resource: 32
+            type: 11971
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 72
-                num_resource: 32
-                type: 11971
-                host_id: 4
-                reserved: 0
+            start_resource: 72
+            num_resource: 32
+            type: 11971
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 104
-                num_resource: 14
-                type: 11971
-                host_id: 5
-                reserved: 0
+            start_resource: 104
+            num_resource: 14
+            type: 11971
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 118
-                num_resource: 2
-                type: 11971
-                host_id: 128
-                reserved: 0
+            start_resource: 118
+            num_resource: 2
+            type: 11971
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 120
-                num_resource: 4
-                type: 11972
-                host_id: 12
-                reserved: 0
+            start_resource: 120
+            num_resource: 4
+            type: 11972
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 124
-                num_resource: 4
-                type: 11972
-                host_id: 13
-                reserved: 0
+            start_resource: 124
+            num_resource: 4
+            type: 11972
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 128
-                num_resource: 12
-                type: 11972
-                host_id: 3
-                reserved: 0
+            start_resource: 128
+            num_resource: 12
+            type: 11972
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 128
-                num_resource: 12
-                type: 11972
-                host_id: 4
-                reserved: 0
+            start_resource: 128
+            num_resource: 12
+            type: 11972
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 140
-                num_resource: 12
-                type: 11972
-                host_id: 5
-                reserved: 0
+            start_resource: 140
+            num_resource: 12
+            type: 11972
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 154
-                num_resource: 0
-                type: 11973
-                host_id: 3
-                reserved: 0
+            start_resource: 154
+            num_resource: 0
+            type: 11973
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 154
-                num_resource: 0
-                type: 11973
-                host_id: 4
-                reserved: 0
+            start_resource: 154
+            num_resource: 0
+            type: 11973
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 154
-                num_resource: 0
-                type: 11973
-                host_id: 5
-                reserved: 0
+            start_resource: 154
+            num_resource: 0
+            type: 11973
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 154
-                num_resource: 0
-                type: 11973
-                host_id: 12
-                reserved: 0
+            start_resource: 154
+            num_resource: 0
+            type: 11973
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 154
-                num_resource: 2
-                type: 11973
-                host_id: 12
-                reserved: 0
+            start_resource: 154
+            num_resource: 2
+            type: 11973
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 156
-                num_resource: 2
-                type: 11973
-                host_id: 3
-                reserved: 0
+            start_resource: 156
+            num_resource: 2
+            type: 11973
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 156
-                num_resource: 2
-                type: 11973
-                host_id: 4
-                reserved: 0
+            start_resource: 156
+            num_resource: 2
+            type: 11973
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 158
-                num_resource: 2
-                type: 11973
-                host_id: 5
-                reserved: 0
+            start_resource: 158
+            num_resource: 2
+            type: 11973
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 0
-                type: 11975
-                host_id: 3
-                reserved: 0
+            start_resource: 1
+            num_resource: 0
+            type: 11975
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 0
-                type: 11975
-                host_id: 4
-                reserved: 0
+            start_resource: 1
+            num_resource: 0
+            type: 11975
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 0
-                type: 11975
-                host_id: 5
-                reserved: 0
+            start_resource: 1
+            num_resource: 0
+            type: 11975
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 0
-                type: 11975
-                host_id: 12
-                reserved: 0
+            start_resource: 1
+            num_resource: 0
+            type: 11975
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 3
-                type: 11975
-                host_id: 12
-                reserved: 0
+            start_resource: 1
+            num_resource: 3
+            type: 11975
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 2
-                type: 11975
-                host_id: 3
-                reserved: 0
+            start_resource: 4
+            num_resource: 2
+            type: 11975
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 2
-                type: 11975
-                host_id: 4
-                reserved: 0
+            start_resource: 4
+            num_resource: 2
+            type: 11975
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 6
-                num_resource: 2
-                type: 11975
-                host_id: 5
-                reserved: 0
+            start_resource: 6
+            num_resource: 2
+            type: 11975
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 1
-                type: 11978
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 1
+            type: 11978
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 3
-                num_resource: 1
-                type: 11978
-                host_id: 13
-                reserved: 0
+            start_resource: 3
+            num_resource: 1
+            type: 11978
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 8
-                type: 11979
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 8
+            type: 11979
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 8
-                type: 11979
-                host_id: 3
-                reserved: 0
+            start_resource: 8
+            num_resource: 8
+            type: 11979
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 8
-                type: 11979
-                host_id: 4
-                reserved: 0
+            start_resource: 8
+            num_resource: 8
+            type: 11979
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 8
-                type: 11979
-                host_id: 5
-                reserved: 0
+            start_resource: 16
+            num_resource: 8
+            type: 11979
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 8
-                type: 11979
-                host_id: 128
-                reserved: 0
+            start_resource: 24
+            num_resource: 8
+            type: 11979
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 150
-                num_resource: 64
-                type: 12032
-                host_id: 12
-                reserved: 0
+            start_resource: 150
+            num_resource: 64
+            type: 12032
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 214
-                num_resource: 8
-                type: 12032
-                host_id: 13
-                reserved: 0
+            start_resource: 214
+            num_resource: 8
+            type: 12032
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 222
-                num_resource: 64
-                type: 12032
-                host_id: 3
-                reserved: 0
+            start_resource: 222
+            num_resource: 64
+            type: 12032
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 222
-                num_resource: 64
-                type: 12032
-                host_id: 4
-                reserved: 0
+            start_resource: 222
+            num_resource: 64
+            type: 12032
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 286
-                num_resource: 8
-                type: 12032
-                host_id: 5
-                reserved: 0
+            start_resource: 286
+            num_resource: 8
+            type: 12032
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 294
-                num_resource: 6
-                type: 12032
-                host_id: 128
-                reserved: 0
+            start_resource: 294
+            num_resource: 6
+            type: 12032
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 12033
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 12033
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 49152
-                num_resource: 1024
-                type: 12034
-                host_id: 128
-                reserved: 0
+            start_resource: 49152
+            num_resource: 1024
+            type: 12034
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 12035
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 12035
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 12
-                type: 12042
-                host_id: 12
-                reserved: 0
+            start_resource: 8
+            num_resource: 12
+            type: 12042
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 4
-                type: 12042
-                host_id: 3
-                reserved: 0
+            start_resource: 20
+            num_resource: 4
+            type: 12042
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 4
-                type: 12042
-                host_id: 4
-                reserved: 0
+            start_resource: 20
+            num_resource: 4
+            type: 12042
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 0
-                type: 12042
-                host_id: 13
-                reserved: 0
+            start_resource: 20
+            num_resource: 0
+            type: 12042
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 2
-                type: 12042
-                host_id: 5
-                reserved: 0
+            start_resource: 24
+            num_resource: 2
+            type: 12042
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 52
-                type: 12042
-                host_id: 12
-                reserved: 0
+            start_resource: 26
+            num_resource: 52
+            type: 12042
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 78
-                num_resource: 8
-                type: 12042
-                host_id: 13
-                reserved: 0
+            start_resource: 78
+            num_resource: 8
+            type: 12042
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 86
-                num_resource: 32
-                type: 12042
-                host_id: 3
-                reserved: 0
+            start_resource: 86
+            num_resource: 32
+            type: 12042
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 86
-                num_resource: 32
-                type: 12042
-                host_id: 4
-                reserved: 0
+            start_resource: 86
+            num_resource: 32
+            type: 12042
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 118
-                num_resource: 14
-                type: 12042
-                host_id: 5
-                reserved: 0
+            start_resource: 118
+            num_resource: 14
+            type: 12042
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 132
-                num_resource: 18
-                type: 12042
-                host_id: 128
-                reserved: 0
+            start_resource: 132
+            num_resource: 18
+            type: 12042
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 0
-                type: 12043
-                host_id: 3
-                reserved: 0
+            start_resource: 2
+            num_resource: 0
+            type: 12043
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 0
-                type: 12043
-                host_id: 4
-                reserved: 0
+            start_resource: 2
+            num_resource: 0
+            type: 12043
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 0
-                type: 12043
-                host_id: 5
-                reserved: 0
+            start_resource: 2
+            num_resource: 0
+            type: 12043
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 0
-                type: 12043
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 0
+            type: 12043
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 2
-                type: 12043
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 2
+            type: 12043
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 2
-                type: 12043
-                host_id: 3
-                reserved: 0
+            start_resource: 4
+            num_resource: 2
+            type: 12043
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 2
-                type: 12043
-                host_id: 4
-                reserved: 0
+            start_resource: 4
+            num_resource: 2
+            type: 12043
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 6
-                num_resource: 2
-                type: 12043
-                host_id: 5
-                reserved: 0
+            start_resource: 6
+            num_resource: 2
+            type: 12043
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 12
-                type: 12045
-                host_id: 12
-                reserved: 0
+            start_resource: 8
+            num_resource: 12
+            type: 12045
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 4
-                type: 12045
-                host_id: 3
-                reserved: 0
+            start_resource: 20
+            num_resource: 4
+            type: 12045
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 4
-                type: 12045
-                host_id: 4
-                reserved: 0
+            start_resource: 20
+            num_resource: 4
+            type: 12045
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 0
-                type: 12045
-                host_id: 13
-                reserved: 0
+            start_resource: 20
+            num_resource: 0
+            type: 12045
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 2
-                type: 12045
-                host_id: 5
-                reserved: 0
+            start_resource: 24
+            num_resource: 2
+            type: 12045
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 38
-                type: 12045
-                host_id: 12
-                reserved: 0
+            start_resource: 26
+            num_resource: 38
+            type: 12045
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 64
-                num_resource: 8
-                type: 12045
-                host_id: 13
-                reserved: 0
+            start_resource: 64
+            num_resource: 8
+            type: 12045
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 72
-                num_resource: 32
-                type: 12045
-                host_id: 3
-                reserved: 0
+            start_resource: 72
+            num_resource: 32
+            type: 12045
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 72
-                num_resource: 32
-                type: 12045
-                host_id: 4
-                reserved: 0
+            start_resource: 72
+            num_resource: 32
+            type: 12045
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 104
-                num_resource: 14
-                type: 12045
-                host_id: 5
-                reserved: 0
+            start_resource: 104
+            num_resource: 14
+            type: 12045
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 118
-                num_resource: 2
-                type: 12045
-                host_id: 128
-                reserved: 0
+            start_resource: 118
+            num_resource: 2
+            type: 12045
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 120
-                num_resource: 4
-                type: 12046
-                host_id: 12
-                reserved: 0
+            start_resource: 120
+            num_resource: 4
+            type: 12046
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 124
-                num_resource: 4
-                type: 12046
-                host_id: 13
-                reserved: 0
+            start_resource: 124
+            num_resource: 4
+            type: 12046
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 128
-                num_resource: 12
-                type: 12046
-                host_id: 3
-                reserved: 0
+            start_resource: 128
+            num_resource: 12
+            type: 12046
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 128
-                num_resource: 12
-                type: 12046
-                host_id: 4
-                reserved: 0
+            start_resource: 128
+            num_resource: 12
+            type: 12046
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 140
-                num_resource: 12
-                type: 12046
-                host_id: 5
-                reserved: 0
+            start_resource: 140
+            num_resource: 12
+            type: 12046
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 0
-                type: 12047
-                host_id: 3
-                reserved: 0
+            start_resource: 1
+            num_resource: 0
+            type: 12047
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 0
-                type: 12047
-                host_id: 4
-                reserved: 0
+            start_resource: 1
+            num_resource: 0
+            type: 12047
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 0
-                type: 12047
-                host_id: 5
-                reserved: 0
+            start_resource: 1
+            num_resource: 0
+            type: 12047
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 0
-                type: 12047
-                host_id: 12
-                reserved: 0
+            start_resource: 1
+            num_resource: 0
+            type: 12047
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 3
-                type: 12047
-                host_id: 12
-                reserved: 0
+            start_resource: 1
+            num_resource: 3
+            type: 12047
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 2
-                type: 12047
-                host_id: 3
-                reserved: 0
+            start_resource: 4
+            num_resource: 2
+            type: 12047
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 2
-                type: 12047
-                host_id: 4
-                reserved: 0
+            start_resource: 4
+            num_resource: 2
+            type: 12047
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 6
-                num_resource: 2
-                type: 12047
-                host_id: 5
-                reserved: 0
+            start_resource: 6
+            num_resource: 2
+            type: 12047
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 80
-                type: 12106
-                host_id: 12
-                reserved: 0
+            start_resource: 8
+            num_resource: 80
+            type: 12106
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 88
-                num_resource: 30
-                type: 12106
-                host_id: 13
-                reserved: 0
+            start_resource: 88
+            num_resource: 30
+            type: 12106
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 118
-                num_resource: 50
-                type: 12106
-                host_id: 3
-                reserved: 0
+            start_resource: 118
+            num_resource: 50
+            type: 12106
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 118
-                num_resource: 50
-                type: 12106
-                host_id: 4
-                reserved: 0
+            start_resource: 118
+            num_resource: 50
+            type: 12106
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 168
-                num_resource: 50
-                type: 12106
-                host_id: 5
-                reserved: 0
+            start_resource: 168
+            num_resource: 50
+            type: 12106
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 218
-                num_resource: 38
-                type: 12106
-                host_id: 128
-                reserved: 0
+            start_resource: 218
+            num_resource: 38
+            type: 12106
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 16392
-                num_resource: 512
-                type: 12109
-                host_id: 12
-                reserved: 0
+            start_resource: 16392
+            num_resource: 512
+            type: 12109
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 16904
-                num_resource: 128
-                type: 12109
-                host_id: 13
-                reserved: 0
+            start_resource: 16904
+            num_resource: 128
+            type: 12109
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 17032
-                num_resource: 256
-                type: 12109
-                host_id: 3
-                reserved: 0
+            start_resource: 17032
+            num_resource: 256
+            type: 12109
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 17032
-                num_resource: 256
-                type: 12109
-                host_id: 4
-                reserved: 0
+            start_resource: 17032
+            num_resource: 256
+            type: 12109
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 17288
-                num_resource: 256
-                type: 12109
-                host_id: 5
-                reserved: 0
+            start_resource: 17288
+            num_resource: 256
+            type: 12109
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 17544
-                num_resource: 376
-                type: 12109
-                host_id: 128
-                reserved: 0
+            start_resource: 17544
+            num_resource: 376
+            type: 12109
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 28
-                type: 12160
-                host_id: 3
-                reserved: 0
+            start_resource: 4
+            num_resource: 28
+            type: 12160
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 28
-                type: 12160
-                host_id: 4
-                reserved: 0
+            start_resource: 4
+            num_resource: 28
+            type: 12160
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 36
-                num_resource: 28
-                type: 12160
-                host_id: 5
-                reserved: 0
+            start_resource: 36
+            num_resource: 28
+            type: 12160
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 12
-                type: 12224
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 12
+            type: 12224
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 4
-                type: 12224
-                host_id: 13
-                reserved: 0
+            start_resource: 12
+            num_resource: 4
+            type: 12224
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 24
-                type: 12224
-                host_id: 3
-                reserved: 0
+            start_resource: 16
+            num_resource: 24
+            type: 12224
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 24
-                type: 12224
-                host_id: 4
-                reserved: 0
+            start_resource: 16
+            num_resource: 24
+            type: 12224
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 40
-                num_resource: 24
-                type: 12224
-                host_id: 5
-                reserved: 0
+            start_resource: 40
+            num_resource: 24
+            type: 12224
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 48
-                num_resource: 16
-                type: 12416
-                host_id: 12
-                reserved: 0
+            start_resource: 48
+            num_resource: 16
+            type: 12416
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 64
-                num_resource: 4
-                type: 12416
-                host_id: 13
-                reserved: 0
+            start_resource: 64
+            num_resource: 4
+            type: 12416
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 68
-                num_resource: 16
-                type: 12416
-                host_id: 3
-                reserved: 0
+            start_resource: 68
+            num_resource: 16
+            type: 12416
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 68
-                num_resource: 16
-                type: 12416
-                host_id: 4
-                reserved: 0
+            start_resource: 68
+            num_resource: 16
+            type: 12416
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 84
-                num_resource: 8
-                type: 12416
-                host_id: 5
-                reserved: 0
+            start_resource: 84
+            num_resource: 8
+            type: 12416
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 92
-                num_resource: 4
-                type: 12416
-                host_id: 128
-                reserved: 0
+            start_resource: 92
+            num_resource: 4
+            type: 12416
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 12417
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 12417
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 56320
-                num_resource: 256
-                type: 12418
-                host_id: 128
-                reserved: 0
+            start_resource: 56320
+            num_resource: 256
+            type: 12418
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 12419
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 12419
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 2
-                type: 12426
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 2
+            type: 12426
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 4
-                type: 12426
-                host_id: 3
-                reserved: 0
+            start_resource: 4
+            num_resource: 4
+            type: 12426
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 4
-                type: 12426
-                host_id: 4
-                reserved: 0
+            start_resource: 4
+            num_resource: 4
+            type: 12426
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 0
-                type: 12426
-                host_id: 13
-                reserved: 0
+            start_resource: 4
+            num_resource: 0
+            type: 12426
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 2
-                type: 12426
-                host_id: 5
-                reserved: 0
+            start_resource: 8
+            num_resource: 2
+            type: 12426
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 12
-                type: 12426
-                host_id: 12
-                reserved: 0
+            start_resource: 10
+            num_resource: 12
+            type: 12426
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 22
-                num_resource: 4
-                type: 12426
-                host_id: 13
-                reserved: 0
+            start_resource: 22
+            num_resource: 4
+            type: 12426
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 10
-                type: 12426
-                host_id: 3
-                reserved: 0
+            start_resource: 26
+            num_resource: 10
+            type: 12426
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 10
-                type: 12426
-                host_id: 4
-                reserved: 0
+            start_resource: 26
+            num_resource: 10
+            type: 12426
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 36
-                num_resource: 12
-                type: 12426
-                host_id: 5
-                reserved: 0
+            start_resource: 36
+            num_resource: 12
+            type: 12426
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 0
-                type: 12427
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 0
+            type: 12427
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 2
-                type: 12427
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 2
+            type: 12427
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 0
-                type: 12427
-                host_id: 4
-                reserved: 0
+            start_resource: 0
+            num_resource: 0
+            type: 12427
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 2
-                type: 12427
-                host_id: 4
-                reserved: 0
+            start_resource: 0
+            num_resource: 2
+            type: 12427
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 2
-                type: 12429
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 2
+            type: 12429
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 4
-                type: 12429
-                host_id: 3
-                reserved: 0
+            start_resource: 4
+            num_resource: 4
+            type: 12429
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 4
-                type: 12429
-                host_id: 4
-                reserved: 0
+            start_resource: 4
+            num_resource: 4
+            type: 12429
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 0
-                type: 12429
-                host_id: 13
-                reserved: 0
+            start_resource: 4
+            num_resource: 0
+            type: 12429
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 2
-                type: 12429
-                host_id: 5
-                reserved: 0
+            start_resource: 8
+            num_resource: 2
+            type: 12429
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 12
-                type: 12429
-                host_id: 12
-                reserved: 0
+            start_resource: 10
+            num_resource: 12
+            type: 12429
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 22
-                num_resource: 4
-                type: 12429
-                host_id: 13
-                reserved: 0
+            start_resource: 22
+            num_resource: 4
+            type: 12429
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 10
-                type: 12429
-                host_id: 3
-                reserved: 0
+            start_resource: 26
+            num_resource: 10
+            type: 12429
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 10
-                type: 12429
-                host_id: 4
-                reserved: 0
+            start_resource: 26
+            num_resource: 10
+            type: 12429
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 36
-                num_resource: 12
-                type: 12429
-                host_id: 5
-                reserved: 0
+            start_resource: 36
+            num_resource: 12
+            type: 12429
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 0
-                type: 12431
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 0
+            type: 12431
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 2
-                type: 12431
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 2
+            type: 12431
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 0
-                type: 12431
-                host_id: 4
-                reserved: 0
+            start_resource: 0
+            num_resource: 0
+            type: 12431
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 2
-                type: 12431
-                host_id: 4
-                reserved: 0
+            start_resource: 0
+            num_resource: 2
+            type: 12431
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 12480
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 12480
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 96
-                num_resource: 32
-                type: 12481
-                host_id: 12
-                reserved: 0
+            start_resource: 96
+            num_resource: 32
+            type: 12481
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 128
-                num_resource: 8
-                type: 12481
-                host_id: 13
-                reserved: 0
+            start_resource: 128
+            num_resource: 8
+            type: 12481
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 136
-                num_resource: 60
-                type: 12481
-                host_id: 3
-                reserved: 0
+            start_resource: 136
+            num_resource: 60
+            type: 12481
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 136
-                num_resource: 60
-                type: 12481
-                host_id: 4
-                reserved: 0
+            start_resource: 136
+            num_resource: 60
+            type: 12481
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 196
-                num_resource: 60
-                type: 12481
-                host_id: 5
-                reserved: 0
+            start_resource: 196
+            num_resource: 60
+            type: 12481
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 50
-                num_resource: 2
-                type: 12482
-                host_id: 12
-                reserved: 0
+            start_resource: 50
+            num_resource: 2
+            type: 12482
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 52
-                num_resource: 4
-                type: 12482
-                host_id: 3
-                reserved: 0
+            start_resource: 52
+            num_resource: 4
+            type: 12482
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 52
-                num_resource: 4
-                type: 12482
-                host_id: 4
-                reserved: 0
+            start_resource: 52
+            num_resource: 4
+            type: 12482
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 52
-                num_resource: 0
-                type: 12482
-                host_id: 13
-                reserved: 0
+            start_resource: 52
+            num_resource: 0
+            type: 12482
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 56
-                num_resource: 2
-                type: 12482
-                host_id: 5
-                reserved: 0
+            start_resource: 56
+            num_resource: 2
+            type: 12482
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 58
-                num_resource: 12
-                type: 12482
-                host_id: 12
-                reserved: 0
+            start_resource: 58
+            num_resource: 12
+            type: 12482
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 70
-                num_resource: 4
-                type: 12482
-                host_id: 13
-                reserved: 0
+            start_resource: 70
+            num_resource: 4
+            type: 12482
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 74
-                num_resource: 10
-                type: 12482
-                host_id: 3
-                reserved: 0
+            start_resource: 74
+            num_resource: 10
+            type: 12482
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 74
-                num_resource: 10
-                type: 12482
-                host_id: 4
-                reserved: 0
+            start_resource: 74
+            num_resource: 10
+            type: 12482
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 84
-                num_resource: 12
-                type: 12482
-                host_id: 5
-                reserved: 0
+            start_resource: 84
+            num_resource: 12
+            type: 12482
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 2
-                type: 12483
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 2
+            type: 12483
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 4
-                type: 12483
-                host_id: 3
-                reserved: 0
+            start_resource: 4
+            num_resource: 4
+            type: 12483
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 4
-                type: 12483
-                host_id: 4
-                reserved: 0
+            start_resource: 4
+            num_resource: 4
+            type: 12483
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 0
-                type: 12483
-                host_id: 13
-                reserved: 0
+            start_resource: 4
+            num_resource: 0
+            type: 12483
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 2
-                type: 12483
-                host_id: 5
-                reserved: 0
+            start_resource: 8
+            num_resource: 2
+            type: 12483
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 12
-                type: 12483
-                host_id: 12
-                reserved: 0
+            start_resource: 10
+            num_resource: 12
+            type: 12483
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 22
-                num_resource: 4
-                type: 12483
-                host_id: 13
-                reserved: 0
+            start_resource: 22
+            num_resource: 4
+            type: 12483
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 10
-                type: 12483
-                host_id: 3
-                reserved: 0
+            start_resource: 26
+            num_resource: 10
+            type: 12483
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 10
-                type: 12483
-                host_id: 4
-                reserved: 0
+            start_resource: 26
+            num_resource: 10
+            type: 12483
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 36
-                num_resource: 12
-                type: 12483
-                host_id: 5
-                reserved: 0
+            start_resource: 36
+            num_resource: 12
+            type: 12483
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 48
-                num_resource: 0
-                type: 12485
-                host_id: 3
-                reserved: 0
+            start_resource: 48
+            num_resource: 0
+            type: 12485
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 48
-                num_resource: 2
-                type: 12485
-                host_id: 3
-                reserved: 0
+            start_resource: 48
+            num_resource: 2
+            type: 12485
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 48
-                num_resource: 0
-                type: 12485
-                host_id: 4
-                reserved: 0
+            start_resource: 48
+            num_resource: 0
+            type: 12485
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 48
-                num_resource: 2
-                type: 12485
-                host_id: 4
-                reserved: 0
+            start_resource: 48
+            num_resource: 2
+            type: 12485
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 0
-                type: 12487
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 0
+            type: 12487
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 2
-                type: 12487
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 2
+            type: 12487
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 0
-                type: 12487
-                host_id: 4
-                reserved: 0
+            start_resource: 0
+            num_resource: 0
+            type: 12487
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 2
-                type: 12487
-                host_id: 4
-                reserved: 0
+            start_resource: 0
+            num_resource: 2
+            type: 12487
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 1
-                type: 12490
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 1
+            type: 12490
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 3
-                num_resource: 1
-                type: 12490
-                host_id: 13
-                reserved: 0
+            start_resource: 3
+            num_resource: 1
+            type: 12490
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 8
-                type: 12491
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 8
+            type: 12491
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 8
-                type: 12491
-                host_id: 3
-                reserved: 0
+            start_resource: 8
+            num_resource: 8
+            type: 12491
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 8
-                type: 12491
-                host_id: 4
-                reserved: 0
+            start_resource: 8
+            num_resource: 8
+            type: 12491
+            host_id: 4
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 8
-                type: 12491
-                host_id: 5
-                reserved: 0
+            start_resource: 16
+            num_resource: 8
+            type: 12491
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 8
-                type: 12491
-                host_id: 128
-                reserved: 0
+            start_resource: 24
+            num_resource: 8
+            type: 12491
+            host_id: 128
+            reserved: 0
diff --git a/board/ti/am65x/sec-cfg.yaml b/board/ti/am65x/sec-cfg.yaml
index 7fa12f0bed..2ee503bace 100644
--- a/board/ti/am65x/sec-cfg.yaml
+++ b/board/ti/am65x/sec-cfg.yaml
@@ -8,138 +8,138 @@
 
 sec-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
     processor_acl_list:
         subhdr:
             magic: 0xF1EA
             size: 164
         proc_acl_entries:
-            - #1
+            -  # 1
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #2
+            -  # 2
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #3
+            -  # 3
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #4
+            -  # 4
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #5
+            -  # 5
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #6
+            -  # 6
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #7
+            -  # 7
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #8
+            -  # 8
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #9
+            -  # 9
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #10
+            -  # 10
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #11
+            -  # 11
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #12
+            -  # 12
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #13
+            -  # 13
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #14
+            -  # 14
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #15
+            -  # 15
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #16
+            -  # 16
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #17
+            -  # 17
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #18
+            -  # 18
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #19
+            -  # 19
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #20
+            -  # 20
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #21
+            -  # 21
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #22
+            -  # 22
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #23
+            -  # 23
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #24
+            -  # 24
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #25
+            -  # 25
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #26
+            -  # 26
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #27
+            -  # 27
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #28
+            -  # 28
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #29
+            -  # 29
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #30
+            -  # 30
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #31
+            -  # 31
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #32
+            -  # 32
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
@@ -148,202 +148,202 @@ sec-cfg:
             magic: 0x8D27
             size: 68
         host_hierarchy_entries:
-            - #1
+            -  # 1
                 host_id: 0
                 supervisor_host_id: 0
-            - #2
+            -  # 2
                 host_id: 0
                 supervisor_host_id: 0
-            - #3
+            -  # 3
                 host_id: 0
                 supervisor_host_id: 0
-            - #4
+            -  # 4
                 host_id: 0
                 supervisor_host_id: 0
-            - #5
+            -  # 5
                 host_id: 0
                 supervisor_host_id: 0
-            - #6
+            -  # 6
                 host_id: 0
                 supervisor_host_id: 0
-            - #7
+            -  # 7
                 host_id: 0
                 supervisor_host_id: 0
-            - #8
+            -  # 8
                 host_id: 0
                 supervisor_host_id: 0
-            - #9
+            -  # 9
                 host_id: 0
                 supervisor_host_id: 0
-            - #10
+            -  # 10
                 host_id: 0
                 supervisor_host_id: 0
-            - #11
+            -  # 11
                 host_id: 0
                 supervisor_host_id: 0
-            - #12
+            -  # 12
                 host_id: 0
                 supervisor_host_id: 0
-            - #13
+            -  # 13
                 host_id: 0
                 supervisor_host_id: 0
-            - #14
+            -  # 14
                 host_id: 0
                 supervisor_host_id: 0
-            - #15
+            -  # 15
                 host_id: 0
                 supervisor_host_id: 0
-            - #16
+            -  # 16
                 host_id: 0
                 supervisor_host_id: 0
-            - #17
+            -  # 17
                 host_id: 0
                 supervisor_host_id: 0
-            - #18
+            -  # 18
                 host_id: 0
                 supervisor_host_id: 0
-            - #19
+            -  # 19
                 host_id: 0
                 supervisor_host_id: 0
-            - #20
+            -  # 20
                 host_id: 0
                 supervisor_host_id: 0
-            - #21
+            -  # 21
                 host_id: 0
                 supervisor_host_id: 0
-            - #22
+            -  # 22
                 host_id: 0
                 supervisor_host_id: 0
-            - #23
+            -  # 23
                 host_id: 0
                 supervisor_host_id: 0
-            - #24
+            -  # 24
                 host_id: 0
                 supervisor_host_id: 0
-            - #25
+            -  # 25
                 host_id: 0
                 supervisor_host_id: 0
-            - #26
+            -  # 26
                 host_id: 0
                 supervisor_host_id: 0
-            - #27
+            -  # 27
                 host_id: 0
                 supervisor_host_id: 0
-            - #28
+            -  # 28
                 host_id: 0
                 supervisor_host_id: 0
-            - #29
+            -  # 29
                 host_id: 0
                 supervisor_host_id: 0
-            - #30
+            -  # 30
                 host_id: 0
                 supervisor_host_id: 0
-            - #31
+            -  # 31
                 host_id: 0
                 supervisor_host_id: 0
-            - #32
+            -  # 32
                 host_id: 0
                 supervisor_host_id: 0
     otp_config:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id : 0
+        write_host_id: 0
         otp_entry:
-            - #1
+            -  # 1
                 host_id: 0
                 host_perms: 0
-            - #2
+            -  # 2
                 host_id: 0
                 host_perms: 0
-            - #3
+            -  # 3
                 host_id: 0
                 host_perms: 0
-            - #4
+            -  # 4
                 host_id: 0
                 host_perms: 0
-            - #5
+            -  # 5
                 host_id: 0
                 host_perms: 0
-            - #6
+            -  # 6
                 host_id: 0
                 host_perms: 0
-            - #7
+            -  # 7
                 host_id: 0
                 host_perms: 0
-            - #8
+            -  # 8
                 host_id: 0
                 host_perms: 0
-            - #9
+            -  # 9
                 host_id: 0
                 host_perms: 0
-            - #10
+            -  # 10
                 host_id: 0
                 host_perms: 0
-            - #11
+            -  # 11
                 host_id: 0
                 host_perms: 0
-            - #12
+            -  # 12
                 host_id: 0
                 host_perms: 0
-            - #13
+            -  # 13
                 host_id: 0
                 host_perms: 0
-            - #14
+            -  # 14
                 host_id: 0
                 host_perms: 0
-            - #15
+            -  # 15
                 host_id: 0
                 host_perms: 0
-            - #16
+            -  # 16
                 host_id: 0
                 host_perms: 0
-            - #17
+            -  # 17
                 host_id: 0
                 host_perms: 0
-            - #18
+            -  # 18
                 host_id: 0
                 host_perms: 0
-            - #19
+            -  # 19
                 host_id: 0
                 host_perms: 0
-            - #20
+            -  # 20
                 host_id: 0
                 host_perms: 0
-            - #21
+            -  # 21
                 host_id: 0
                 host_perms: 0
-            - #22
+            -  # 22
                 host_id: 0
                 host_perms: 0
-            - #23
+            -  # 23
                 host_id: 0
                 host_perms: 0
-            - #24
+            -  # 24
                 host_id: 0
                 host_perms: 0
-            - #25
+            -  # 25
                 host_id: 0
                 host_perms: 0
-            - #26
+            -  # 26
                 host_id: 0
                 host_perms: 0
-            - #27
+            -  # 27
                 host_id: 0
                 host_perms: 0
-            - #28
+            -  # 28
                 host_id: 0
                 host_perms: 0
-            - #29
+            -  # 29
                 host_id: 0
                 host_perms: 0
-            - #30
+            -  # 30
                 host_id: 0
                 host_perms: 0
-            - #31
+            -  # 31
                 host_id: 0
                 host_perms: 0
-            - #32
+            -  # 32
                 host_id: 0
                 host_perms: 0
     dkek_config:
@@ -351,12 +351,12 @@ sec-cfg:
             magic: 0x5170
             size: 12
         allowed_hosts: [128, 0, 0, 0]
-        allow_dkek_export_tisci : 0x5A
+        allow_dkek_export_tisci: 0x5A
         rsvd: [0, 0, 0]
     sa2ul_cfg:
         subhdr:
             magic: 0x23BE
-            size : 0
+            size: 0
         auth_resource_owner: 0
         enable_saul_psil_global_config_writes: 0
         rsvd: [0, 0]
@@ -364,16 +364,16 @@ sec-cfg:
         subhdr:
             magic: 0x42AF
             size: 16
-        allow_jtag_unlock : 0x5A
-        allow_wildcard_unlock : 0x5A
+        allow_jtag_unlock: 0x5A
+        allow_wildcard_unlock: 0x5A
         allowed_debug_level_rsvd: 0
         rsvd: 0
-        min_cert_rev : 0x0
+        min_cert_rev: 0x0
         jtag_unlock_hosts: [0, 0, 0, 0]
     sec_handover_cfg:
         subhdr:
             magic: 0x608F
             size: 10
-        handover_msg_sender : 0
-        handover_to_host_id : 0
+        handover_msg_sender: 0
+        handover_to_host_id: 0
         rsvd: [0, 0, 0, 0]
diff --git a/board/ti/j721e/board-cfg_j7200.yaml b/board/ti/j721e/board-cfg_j7200.yaml
index 0ac1ae93fe..a1e55a26be 100644
--- a/board/ti/j721e/board-cfg_j7200.yaml
+++ b/board/ti/j721e/board-cfg_j7200.yaml
@@ -8,29 +8,29 @@
 
 board-cfg:
         rev:
-                boardcfg_abi_maj : 0x0
-                boardcfg_abi_min : 0x1
+                boardcfg_abi_maj: 0x0
+                boardcfg_abi_min: 0x1
         control:
                 subhdr:
                         magic: 0xC1D3
                         size: 7
-                main_isolation_enable : 0x5A
-                main_isolation_hostid : 0x2
+                main_isolation_enable: 0x5A
+                main_isolation_hostid: 0x2
         secproxy:
                 subhdr:
                         magic: 0x1207
                         size: 7
-                scaling_factor : 0x1
-                scaling_profile : 0x1
-                disable_main_nav_secure_proxy : 0
+                scaling_factor: 0x1
+                scaling_profile: 0x1
+                disable_main_nav_secure_proxy: 0
         msmc:
                 subhdr:
                         magic: 0xA5C3
                         size: 5
-                msmc_cache_size : 0x10
+                msmc_cache_size: 0x10
         debug_cfg:
                 subhdr:
                         magic: 0x020C
                         size: 8
-                trace_dst_enables : 0x00
-                trace_src_enables : 0x00
+                trace_dst_enables: 0x00
+                trace_src_enables: 0x00
diff --git a/board/ti/j721e/pm-cfg_j7200.yaml b/board/ti/j721e/pm-cfg_j7200.yaml
index daaefb1318..85cd2c9dbc 100644
--- a/board/ti/j721e/pm-cfg_j7200.yaml
+++ b/board/ti/j721e/pm-cfg_j7200.yaml
@@ -8,5 +8,5 @@
 
 pm-cfg:
         rev:
-                boardcfg_abi_maj : 0x0
-                boardcfg_abi_min : 0x1
+                boardcfg_abi_maj: 0x0
+                boardcfg_abi_min: 0x1
diff --git a/board/ti/j721e/rm-cfg.yaml b/board/ti/j721e/rm-cfg.yaml
index 9f604cf1aa..14ccb0f7c1 100644
--- a/board/ti/j721e/rm-cfg.yaml
+++ b/board/ti/j721e/rm-cfg.yaml
@@ -16,224 +16,224 @@ rm-cfg:
                                 magic: 0x4C41
                                 size: 356
                         host_cfg_entries:
-                                - #1
+                                -  # 1
                                         host_id: 3
                                         allowed_atype: 0x2A
                                         allowed_qos: 0xAAAA
                                         allowed_orderid: 0xAAAAAAAA
                                         allowed_priority: 0xAAAA
                                         allowed_sched_priority: 0xAA
-                                - #2
+                                -  # 2
                                         host_id: 5
                                         allowed_atype: 0x2A
                                         allowed_qos: 0xAAAA
                                         allowed_orderid: 0xAAAAAAAA
                                         allowed_priority: 0xAAAA
                                         allowed_sched_priority: 0xAA
-                                - #3
+                                -  # 3
                                         host_id: 12
                                         allowed_atype: 0x2A
                                         allowed_qos: 0xAAAA
                                         allowed_orderid: 0xAAAAAAAA
                                         allowed_priority: 0xAAAA
                                         allowed_sched_priority: 0xAA
-                                - #4
+                                -  # 4
                                         host_id: 13
                                         allowed_atype: 0x2A
                                         allowed_qos: 0xAAAA
                                         allowed_orderid: 0xAAAAAAAA
                                         allowed_priority: 0xAAAA
                                         allowed_sched_priority: 0xAA
-                                - #5
+                                -  # 5
                                         host_id: 21
                                         allowed_atype: 0x2A
                                         allowed_qos: 0xAAAA
                                         allowed_orderid: 0xAAAAAAAA
                                         allowed_priority: 0xAAAA
                                         allowed_sched_priority: 0xAA
-                                - #6
+                                -  # 6
                                         host_id: 26
                                         allowed_atype: 0x2A
                                         allowed_qos: 0xAAAA
                                         allowed_orderid: 0xAAAAAAAA
                                         allowed_priority: 0xAAAA
                                         allowed_sched_priority: 0xAA
-                                - #7
+                                -  # 7
                                         host_id: 28
                                         allowed_atype: 0x2A
                                         allowed_qos: 0xAAAA
                                         allowed_orderid: 0xAAAAAAAA
                                         allowed_priority: 0xAAAA
                                         allowed_sched_priority: 0xAA
-                                - #8
+                                -  # 8
                                         host_id: 35
                                         allowed_atype: 0x2A
                                         allowed_qos: 0xAAAA
                                         allowed_orderid: 0xAAAAAAAA
                                         allowed_priority: 0xAAAA
                                         allowed_sched_priority: 0xAA
-                                - #9
+                                -  # 9
                                         host_id: 37
                                         allowed_atype: 0x2A
                                         allowed_qos: 0xAAAA
                                         allowed_orderid: 0xAAAAAAAA
                                         allowed_priority: 0xAAAA
                                         allowed_sched_priority: 0xAA
-                                - #10
+                                -  # 10
                                         host_id: 40
                                         allowed_atype: 0x2A
                                         allowed_qos: 0xAAAA
                                         allowed_orderid: 0xAAAAAAAA
                                         allowed_priority: 0xAAAA
                                         allowed_sched_priority: 0xAA
-                                - #11
+                                -  # 11
                                         host_id: 42
                                         allowed_atype: 0x2A
                                         allowed_qos: 0xAAAA
                                         allowed_orderid: 0xAAAAAAAA
                                         allowed_priority: 0xAAAA
                                         allowed_sched_priority: 0xAA
-                                - #12
+                                -  # 12
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #13
+                                -  # 13
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #14
+                                -  # 14
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #15
+                                -  # 15
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #16
+                                -  # 16
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #17
+                                -  # 17
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #18
+                                -  # 18
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #19
+                                -  # 19
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #20
+                                -  # 20
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #21
+                                -  # 21
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #22
+                                -  # 22
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #23
+                                -  # 23
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #24
+                                -  # 24
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #25
+                                -  # 25
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #26
+                                -  # 26
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #27
+                                -  # 27
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #28
+                                -  # 28
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #29
+                                -  # 29
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #30
+                                -  # 30
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #31
+                                -  # 31
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
                                         allowed_orderid: 0
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
-                                - #32
+                                -  # 32
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
diff --git a/board/ti/j721e/rm-cfg_j7200.yaml b/board/ti/j721e/rm-cfg_j7200.yaml
index 263285ff42..149dfbd4b3 100644
--- a/board/ti/j721e/rm-cfg_j7200.yaml
+++ b/board/ti/j721e/rm-cfg_j7200.yaml
@@ -9,56 +9,56 @@
 rm-cfg:
         rm_boardcfg:
                 rev:
-                        boardcfg_abi_maj : 0x0
-                        boardcfg_abi_min : 0x1
+                        boardcfg_abi_maj: 0x0
+                        boardcfg_abi_min: 0x1
                 host_cfg:
                         subhdr:
                                 magic: 0x4C41
-                                size : 356
+                                size: 356
                         host_cfg_entries:
-                                - #1
+                                -  # 1
                                         host_id: 3
-                                        allowed_atype : 0b101010
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #2
+                                        allowed_atype: 0b101010
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 2
                                         host_id: 5
-                                        allowed_atype : 0b101010
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #3
+                                        allowed_atype: 0b101010
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 3
                                         host_id: 12
-                                        allowed_atype : 0b101010
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #4
+                                        allowed_atype: 0b101010
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 4
                                         host_id: 13
-                                        allowed_atype : 0b101010
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #5
+                                        allowed_atype: 0b101010
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 5
                                         host_id: 35
-                                        allowed_atype : 0b101010
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #6
+                                        allowed_atype: 0b101010
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 6
                                         host_id: 37
-                                        allowed_atype : 0b101010
-                                        allowed_qos : 0xAAAA
-                                        allowed_orderid : 0xAAAAAAAA
-                                        allowed_priority : 0xAAAA
-                                        allowed_sched_priority : 0xAA
-                                - #7
+                                        allowed_atype: 0b101010
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                -  # 7
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -66,7 +66,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #8
+                                -  # 8
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -74,7 +74,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #9
+                                -  # 9
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -82,7 +82,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #10
+                                -  # 10
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -90,7 +90,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #11
+                                -  # 11
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -98,7 +98,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #12
+                                -  # 12
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -106,7 +106,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #13
+                                -  # 13
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -114,7 +114,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #14
+                                -  # 14
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -122,7 +122,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #15
+                                -  # 15
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -130,7 +130,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #16
+                                -  # 16
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -138,7 +138,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #17
+                                -  # 17
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -146,7 +146,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #18
+                                -  # 18
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -154,7 +154,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #19
+                                -  # 19
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -162,7 +162,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #20
+                                -  # 20
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -170,7 +170,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #21
+                                -  # 21
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -178,7 +178,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #22
+                                -  # 22
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -186,7 +186,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #23
+                                -  # 23
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -194,7 +194,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #24
+                                -  # 24
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -202,7 +202,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #25
+                                -  # 25
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -210,7 +210,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #26
+                                -  # 26
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -218,7 +218,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #27
+                                -  # 27
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -226,7 +226,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #28
+                                -  # 28
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -234,7 +234,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #29
+                                -  # 29
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -242,7 +242,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #30
+                                -  # 30
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -250,7 +250,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #31
+                                -  # 31
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -258,7 +258,7 @@ rm-cfg:
                                         allowed_priority: 0
                                         allowed_sched_priority: 0
 
-                                - #32
+                                -  # 32
                                         host_id: 0
                                         allowed_atype: 0
                                         allowed_qos: 0
@@ -268,9 +268,9 @@ rm-cfg:
                 resasg:
                         subhdr:
                                 magic: 0x7B25
-                                size : 8
+                                size: 8
                         resasg_entries_size: 2048
-                        reserved : 0
+                        reserved: 0
         resasg_entries:
                 -
                         start_resource: 0
diff --git a/board/ti/j721e/sec-cfg.yaml b/board/ti/j721e/sec-cfg.yaml
index 1eab5883a7..a1d0aff817 100644
--- a/board/ti/j721e/sec-cfg.yaml
+++ b/board/ti/j721e/sec-cfg.yaml
@@ -15,131 +15,131 @@ sec-cfg:
                         magic: 0xF1EA
                         size: 164
                 proc_acl_entries:
-                        - #1
+                        -  # 1
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #2
+                        -  # 2
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #3
+                        -  # 3
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #4
+                        -  # 4
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #5
+                        -  # 5
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #6
+                        -  # 6
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #7
+                        -  # 7
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #8
+                        -  # 8
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #9
+                        -  # 9
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #10
+                        -  # 10
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #11
+                        -  # 11
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #12
+                        -  # 12
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #13
+                        -  # 13
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #14
+                        -  # 14
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #15
+                        -  # 15
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #16
+                        -  # 16
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #17
+                        -  # 17
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #18
+                        -  # 18
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #19
+                        -  # 19
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #20
+                        -  # 20
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #21
+                        -  # 21
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #22
+                        -  # 22
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #23
+                        -  # 23
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #24
+                        -  # 24
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #25
+                        -  # 25
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #26
+                        -  # 26
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #27
+                        -  # 27
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #28
+                        -  # 28
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #29
+                        -  # 29
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #30
+                        -  # 30
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #31
+                        -  # 31
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #32
+                        -  # 32
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
@@ -149,100 +149,100 @@ sec-cfg:
                         magic: 0x8D27
                         size: 68
                 host_hierarchy_entries:
-                        - #1
+                        -  # 1
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #2
+                        -  # 2
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #3
+                        -  # 3
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #4
+                        -  # 4
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #5
+                        -  # 5
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #6
+                        -  # 6
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #7
+                        -  # 7
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #8
+                        -  # 8
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #9
+                        -  # 9
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #10
+                        -  # 10
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #11
+                        -  # 11
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #12
+                        -  # 12
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #13
+                        -  # 13
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #14
+                        -  # 14
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #15
+                        -  # 15
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #16
+                        -  # 16
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #17
+                        -  # 17
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #18
+                        -  # 18
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #19
+                        -  # 19
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #20
+                        -  # 20
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #21
+                        -  # 21
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #22
+                        -  # 22
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #23
+                        -  # 23
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #24
+                        -  # 24
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #25
+                        -  # 25
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #26
+                        -  # 26
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #27
+                        -  # 27
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #28
+                        -  # 28
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #29
+                        -  # 29
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #30
+                        -  # 30
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #31
+                        -  # 31
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #32
+                        -  # 32
                                 host_id: 0
                                 supervisor_host_id: 0
         otp_config:
@@ -250,100 +250,100 @@ sec-cfg:
                         magic: 0x4081
                         size: 69
                 otp_entry:
-                        - #1
+                        -  # 1
                                 host_id: 0
                                 host_perms: 0
-                        - #2
+                        -  # 2
                                 host_id: 0
                                 host_perms: 0
-                        - #3
+                        -  # 3
                                 host_id: 0
                                 host_perms: 0
-                        - #4
+                        -  # 4
                                 host_id: 0
                                 host_perms: 0
-                        - #5
+                        -  # 5
                                 host_id: 0
                                 host_perms: 0
-                        - #6
+                        -  # 6
                                 host_id: 0
                                 host_perms: 0
-                        - #7
+                        -  # 7
                                 host_id: 0
                                 host_perms: 0
-                        - #8
+                        -  # 8
                                 host_id: 0
                                 host_perms: 0
-                        - #9
+                        -  # 9
                                 host_id: 0
                                 host_perms: 0
-                        - #10
+                        -  # 10
                                 host_id: 0
                                 host_perms: 0
-                        - #11
+                        -  # 11
                                 host_id: 0
                                 host_perms: 0
-                        - #12
+                        -  # 12
                                 host_id: 0
                                 host_perms: 0
-                        - #13
+                        -  # 13
                                 host_id: 0
                                 host_perms: 0
-                        - #14
+                        -  # 14
                                 host_id: 0
                                 host_perms: 0
-                        - #15
+                        -  # 15
                                 host_id: 0
                                 host_perms: 0
-                        - #16
+                        -  # 16
                                 host_id: 0
                                 host_perms: 0
-                        - #17
+                        -  # 17
                                 host_id: 0
                                 host_perms: 0
-                        - #18
+                        -  # 18
                                 host_id: 0
                                 host_perms: 0
-                        - #19
+                        -  # 19
                                 host_id: 0
                                 host_perms: 0
-                        - #20
+                        -  # 20
                                 host_id: 0
                                 host_perms: 0
-                        - #21
+                        -  # 21
                                 host_id: 0
                                 host_perms: 0
-                        - #22
+                        -  # 22
                                 host_id: 0
                                 host_perms: 0
-                        - #23
+                        -  # 23
                                 host_id: 0
                                 host_perms: 0
-                        - #24
+                        -  # 24
                                 host_id: 0
                                 host_perms: 0
-                        - #25
+                        -  # 25
                                 host_id: 0
                                 host_perms: 0
-                        - #26
+                        -  # 26
                                 host_id: 0
                                 host_perms: 0
-                        - #27
+                        -  # 27
                                 host_id: 0
                                 host_perms: 0
-                        - #28
+                        -  # 28
                                 host_id: 0
                                 host_perms: 0
-                        - #29
+                        -  # 29
                                 host_id: 0
                                 host_perms: 0
-                        - #30
+                        -  # 30
                                 host_id: 0
                                 host_perms: 0
-                        - #31
+                        -  # 31
                                 host_id: 0
                                 host_perms: 0
-                        - #32
+                        -  # 32
                                 host_id: 0
                                 host_perms: 0
                 write_host_id: 0
diff --git a/board/ti/j721e/sec-cfg_j7200.yaml b/board/ti/j721e/sec-cfg_j7200.yaml
index c346087a81..caf0b62ff4 100644
--- a/board/ti/j721e/sec-cfg_j7200.yaml
+++ b/board/ti/j721e/sec-cfg_j7200.yaml
@@ -8,138 +8,138 @@
 
 sec-cfg:
         rev:
-                boardcfg_abi_maj : 0x0
-                boardcfg_abi_min : 0x1
+                boardcfg_abi_maj: 0x0
+                boardcfg_abi_min: 0x1
         processor_acl_list:
                 subhdr:
                         magic: 0xF1EA
                         size: 164
                 proc_acl_entries:
-                        - #1
+                        -  # 1
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #2
+                        -  # 2
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #3
+                        -  # 3
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #4
+                        -  # 4
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #5
+                        -  # 5
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #6
+                        -  # 6
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #7
+                        -  # 7
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #8
+                        -  # 8
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #9
+                        -  # 9
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #10
+                        -  # 10
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #11
+                        -  # 11
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #12
+                        -  # 12
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #13
+                        -  # 13
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #14
+                        -  # 14
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #15
+                        -  # 15
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #16
+                        -  # 16
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #17
+                        -  # 17
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #18
+                        -  # 18
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #19
+                        -  # 19
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #20
+                        -  # 20
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #21
+                        -  # 21
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #22
+                        -  # 22
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #23
+                        -  # 23
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #24
+                        -  # 24
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #25
+                        -  # 25
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #26
+                        -  # 26
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #27
+                        -  # 27
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #28
+                        -  # 28
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #29
+                        -  # 29
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #30
+                        -  # 30
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #31
+                        -  # 31
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
-                        - #32
+                        -  # 32
                                 processor_id: 0
                                 proc_access_master: 0
                                 proc_access_secondary: [0, 0, 0]
@@ -149,202 +149,202 @@ sec-cfg:
                         magic: 0x8D27
                         size: 68
                 host_hierarchy_entries:
-                        - #1
+                        -  # 1
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #2
+                        -  # 2
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #3
+                        -  # 3
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #4
+                        -  # 4
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #5
+                        -  # 5
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #6
+                        -  # 6
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #7
+                        -  # 7
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #8
+                        -  # 8
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #9
+                        -  # 9
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #10
+                        -  # 10
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #11
+                        -  # 11
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #12
+                        -  # 12
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #13
+                        -  # 13
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #14
+                        -  # 14
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #15
+                        -  # 15
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #16
+                        -  # 16
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #17
+                        -  # 17
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #18
+                        -  # 18
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #19
+                        -  # 19
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #20
+                        -  # 20
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #21
+                        -  # 21
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #22
+                        -  # 22
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #23
+                        -  # 23
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #24
+                        -  # 24
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #25
+                        -  # 25
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #26
+                        -  # 26
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #27
+                        -  # 27
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #28
+                        -  # 28
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #29
+                        -  # 29
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #30
+                        -  # 30
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #31
+                        -  # 31
                                 host_id: 0
                                 supervisor_host_id: 0
-                        - #32
+                        -  # 32
                                 host_id: 0
                                 supervisor_host_id: 0
         otp_config:
                 subhdr:
                         magic: 0x4081
                         size: 69
-                write_host_id : 0
+                write_host_id: 0
                 otp_entry:
-                        - #1
+                        -  # 1
                                 host_id: 0
                                 host_perms: 0
-                        - #2
+                        -  # 2
                                 host_id: 0
                                 host_perms: 0
-                        - #3
+                        -  # 3
                                 host_id: 0
                                 host_perms: 0
-                        - #4
+                        -  # 4
                                 host_id: 0
                                 host_perms: 0
-                        - #5
+                        -  # 5
                                 host_id: 0
                                 host_perms: 0
-                        - #6
+                        -  # 6
                                 host_id: 0
                                 host_perms: 0
-                        - #7
+                        -  # 7
                                 host_id: 0
                                 host_perms: 0
-                        - #8
+                        -  # 8
                                 host_id: 0
                                 host_perms: 0
-                        - #9
+                        -  # 9
                                 host_id: 0
                                 host_perms: 0
-                        - #10
+                        -  # 10
                                 host_id: 0
                                 host_perms: 0
-                        - #11
+                        -  # 11
                                 host_id: 0
                                 host_perms: 0
-                        - #12
+                        -  # 12
                                 host_id: 0
                                 host_perms: 0
-                        - #13
+                        -  # 13
                                 host_id: 0
                                 host_perms: 0
-                        - #14
+                        -  # 14
                                 host_id: 0
                                 host_perms: 0
-                        - #15
+                        -  # 15
                                 host_id: 0
                                 host_perms: 0
-                        - #16
+                        -  # 16
                                 host_id: 0
                                 host_perms: 0
-                        - #17
+                        -  # 17
                                 host_id: 0
                                 host_perms: 0
-                        - #18
+                        -  # 18
                                 host_id: 0
                                 host_perms: 0
-                        - #19
+                        -  # 19
                                 host_id: 0
                                 host_perms: 0
-                        - #20
+                        -  # 20
                                 host_id: 0
                                 host_perms: 0
-                        - #21
+                        -  # 21
                                 host_id: 0
                                 host_perms: 0
-                        - #22
+                        -  # 22
                                 host_id: 0
                                 host_perms: 0
-                        - #23
+                        -  # 23
                                 host_id: 0
                                 host_perms: 0
-                        - #24
+                        -  # 24
                                 host_id: 0
                                 host_perms: 0
-                        - #25
+                        -  # 25
                                 host_id: 0
                                 host_perms: 0
-                        - #26
+                        -  # 26
                                 host_id: 0
                                 host_perms: 0
-                        - #27
+                        -  # 27
                                 host_id: 0
                                 host_perms: 0
-                        - #28
+                        -  # 28
                                 host_id: 0
                                 host_perms: 0
-                        - #29
+                        -  # 29
                                 host_id: 0
                                 host_perms: 0
-                        - #30
+                        -  # 30
                                 host_id: 0
                                 host_perms: 0
-                        - #31
+                        -  # 31
                                 host_id: 0
                                 host_perms: 0
-                        - #32
+                        -  # 32
                                 host_id: 0
                                 host_perms: 0
         dkek_config:
@@ -352,12 +352,12 @@ sec-cfg:
                         magic: 0x5170
                         size: 12
                 allowed_hosts: [128, 0, 0, 0]
-                allow_dkek_export_tisci : 0x5A
+                allow_dkek_export_tisci: 0x5A
                 rsvd: [0, 0, 0]
         sa2ul_cfg:
                 subhdr:
                         magic: 0x23BE
-                        size : 0
+                        size: 0
                 auth_resource_owner: 0
                 enable_saul_psil_global_config_writes: 0
                 rsvd: [0, 0]
@@ -365,16 +365,16 @@ sec-cfg:
                 subhdr:
                         magic: 0x42AF
                         size: 16
-                allow_jtag_unlock : 0x5A
-                allow_wildcard_unlock : 0x5A
-                allowed_debug_level_rsvd : 0
-                rsvd : 0
-                min_cert_rev : 0x0
+                allow_jtag_unlock: 0x5A
+                allow_wildcard_unlock: 0x5A
+                allowed_debug_level_rsvd: 0
+                rsvd: 0
+                min_cert_rev: 0x0
                 jtag_unlock_hosts: [0, 0, 0, 0]
         sec_handover_cfg:
                 subhdr:
                         magic: 0x608F
                         size: 10
-                handover_msg_sender : 0
-                handover_to_host_id : 0
+                handover_msg_sender: 0
+                handover_to_host_id: 0
                 rsvd: [0, 0, 0, 0]
diff --git a/board/ti/j721s2/board-cfg.yaml b/board/ti/j721s2/board-cfg.yaml
index dd024110e7..94e61ab1dc 100644
--- a/board/ti/j721s2/board-cfg.yaml
+++ b/board/ti/j721s2/board-cfg.yaml
@@ -8,29 +8,29 @@
 
 board-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
     control:
         subhdr:
             magic: 0xC1D3
             size: 7
-        main_isolation_enable : 0x5A
-        main_isolation_hostid : 0x2
+        main_isolation_enable: 0x5A
+        main_isolation_hostid: 0x2
     secproxy:
         subhdr:
             magic: 0x1207
             size: 7
-        scaling_factor : 0x1
-        scaling_profile : 0x1
-        disable_main_nav_secure_proxy : 0
+        scaling_factor: 0x1
+        scaling_profile: 0x1
+        disable_main_nav_secure_proxy: 0
     msmc:
         subhdr:
             magic: 0xA5C3
             size: 5
-        msmc_cache_size : 0x0
+        msmc_cache_size: 0x0
     debug_cfg:
         subhdr:
             magic: 0x020C
             size: 8
-        trace_dst_enables : 0x00
-        trace_src_enables : 0x00
+        trace_dst_enables: 0x00
+        trace_src_enables: 0x00
diff --git a/board/ti/j721s2/pm-cfg.yaml b/board/ti/j721s2/pm-cfg.yaml
index a640460d30..e6496512b6 100644
--- a/board/ti/j721s2/pm-cfg.yaml
+++ b/board/ti/j721s2/pm-cfg.yaml
@@ -8,5 +8,5 @@
 
 pm-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
diff --git a/board/ti/j721s2/rm-cfg.yaml b/board/ti/j721s2/rm-cfg.yaml
index f772832f19..2c50cb8387 100644
--- a/board/ti/j721s2/rm-cfg.yaml
+++ b/board/ti/j721s2/rm-cfg.yaml
@@ -9,2893 +9,2893 @@
 rm-cfg:
     rm_boardcfg:
         rev:
-            boardcfg_abi_maj : 0x0
-            boardcfg_abi_min : 0x1
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
         host_cfg:
             subhdr:
                 magic: 0x4C41
-                size : 356
+                size: 356
             host_cfg_entries:
-                - #1
+                -  # 1
                     host_id: 3
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #2
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 2
                     host_id: 5
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #3
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
                     host_id: 12
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #4
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
                     host_id: 13
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #5
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 5
                     host_id: 21
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #6
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 6
                     host_id: 23
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #7
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 7
                     host_id: 35
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #8
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 8
                     host_id: 37
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #9
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 9
                     host_id: 40
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #10
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 10
                     host_id: 42
-                    allowed_atype : 0x2A
-                    allowed_qos : 0xAAAA
-                    allowed_orderid : 0xAAAAAAAA
-                    allowed_priority : 0xAAAA
-                    allowed_sched_priority : 0xAA
-                - #11
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 11
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #12
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 12
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #13
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #14
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #15
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #16
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #17
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #18
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #19
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #20
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #21
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #22
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #23
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #24
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #25
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #26
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #27
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #28
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #29
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #30
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #31
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
                     host_id: 0
-                    allowed_atype : 0
-                    allowed_qos : 0
-                    allowed_orderid : 0
-                    allowed_priority : 0
-                    allowed_sched_priority : 0
-                - #32
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
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
             resasg_entries_size: 3032
-            reserved : 0
+            reserved: 0
     resasg_entries:
         -
-                start_resource: 0
-                num_resource: 32
-                type: 7744
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 32
+            type: 7744
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 32
-                num_resource: 24
-                type: 7744
-                host_id: 5
-                reserved: 0
+            start_resource: 32
+            num_resource: 24
+            type: 7744
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 24
-                type: 7808
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 24
+            type: 7808
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 16
-                type: 7808
-                host_id: 5
-                reserved: 0
+            start_resource: 24
+            num_resource: 16
+            type: 7808
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 48
-                type: 7936
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 48
+            type: 7936
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 8
-                type: 8000
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 8
+            type: 8000
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 8
-                type: 8000
-                host_id: 5
-                reserved: 0
+            start_resource: 8
+            num_resource: 8
+            type: 8000
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 6
-                type: 8000
-                host_id: 12
-                reserved: 0
+            start_resource: 16
+            num_resource: 6
+            type: 8000
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 22
-                num_resource: 6
-                type: 8000
-                host_id: 13
-                reserved: 0
+            start_resource: 22
+            num_resource: 6
+            type: 8000
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 28
-                num_resource: 2
-                type: 8000
-                host_id: 35
-                reserved: 0
+            start_resource: 28
+            num_resource: 2
+            type: 8000
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 30
-                num_resource: 2
-                type: 8000
-                host_id: 37
-                reserved: 0
+            start_resource: 30
+            num_resource: 2
+            type: 8000
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 4
-                type: 9472
-                host_id: 35
-                reserved: 0
+            start_resource: 0
+            num_resource: 4
+            type: 9472
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 4
-                type: 9472
-                host_id: 37
-                reserved: 0
+            start_resource: 4
+            num_resource: 4
+            type: 9472
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 4
-                type: 9472
-                host_id: 40
-                reserved: 0
+            start_resource: 8
+            num_resource: 4
+            type: 9472
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 4
-                type: 9472
-                host_id: 42
-                reserved: 0
+            start_resource: 12
+            num_resource: 4
+            type: 9472
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 8
-                type: 9472
-                host_id: 3
-                reserved: 0
+            start_resource: 16
+            num_resource: 8
+            type: 9472
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 24
-                num_resource: 8
-                type: 9472
-                host_id: 5
-                reserved: 0
+            start_resource: 24
+            num_resource: 8
+            type: 9472
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 32
-                num_resource: 12
-                type: 9472
-                host_id: 12
-                reserved: 0
+            start_resource: 32
+            num_resource: 12
+            type: 9472
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 44
-                num_resource: 12
-                type: 9472
-                host_id: 13
-                reserved: 0
+            start_resource: 44
+            num_resource: 12
+            type: 9472
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 16
-                type: 9600
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 16
+            type: 9600
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 50176
-                num_resource: 96
-                type: 14402
-                host_id: 128
-                reserved: 0
+            start_resource: 50176
+            num_resource: 96
+            type: 14402
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 14403
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 14403
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 16
-                type: 14414
-                host_id: 12
-                reserved: 0
+            start_resource: 16
+            num_resource: 16
+            type: 14414
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 32
-                num_resource: 16
-                type: 14414
-                host_id: 35
-                reserved: 0
+            start_resource: 32
+            num_resource: 16
+            type: 14414
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 8
-                type: 14415
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 8
+            type: 14415
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 8
-                type: 14415
-                host_id: 35
-                reserved: 0
+            start_resource: 8
+            num_resource: 8
+            type: 14415
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 16
-                type: 14433
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 16
+            type: 14433
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 16
-                type: 14433
-                host_id: 35
-                reserved: 0
+            start_resource: 16
+            num_resource: 16
+            type: 14433
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 8
-                type: 14434
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 8
+            type: 14434
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 8
-                type: 14434
-                host_id: 35
-                reserved: 0
+            start_resource: 8
+            num_resource: 8
+            type: 14434
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 100
-                type: 14528
-                host_id: 12
-                reserved: 0
+            start_resource: 10
+            num_resource: 100
+            type: 14528
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 110
-                num_resource: 32
-                type: 14528
-                host_id: 13
-                reserved: 0
+            start_resource: 110
+            num_resource: 32
+            type: 14528
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 142
-                num_resource: 21
-                type: 14528
-                host_id: 21
-                reserved: 0
+            start_resource: 142
+            num_resource: 21
+            type: 14528
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 163
-                num_resource: 21
-                type: 14528
-                host_id: 23
-                reserved: 0
+            start_resource: 163
+            num_resource: 21
+            type: 14528
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 196
-                num_resource: 28
-                type: 14528
-                host_id: 35
-                reserved: 0
+            start_resource: 196
+            num_resource: 28
+            type: 14528
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 228
-                num_resource: 28
-                type: 14528
-                host_id: 37
-                reserved: 0
+            start_resource: 228
+            num_resource: 28
+            type: 14528
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 260
-                num_resource: 28
-                type: 14528
-                host_id: 40
-                reserved: 0
+            start_resource: 260
+            num_resource: 28
+            type: 14528
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 292
-                num_resource: 28
-                type: 14528
-                host_id: 42
-                reserved: 0
+            start_resource: 292
+            num_resource: 28
+            type: 14528
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 400
-                num_resource: 4
-                type: 14528
-                host_id: 3
-                reserved: 0
+            start_resource: 400
+            num_resource: 4
+            type: 14528
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 404
-                num_resource: 4
-                type: 14528
-                host_id: 5
-                reserved: 0
+            start_resource: 404
+            num_resource: 4
+            type: 14528
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 64
-                type: 16266
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 64
+            type: 16266
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 20480
-                num_resource: 1024
-                type: 16269
-                host_id: 128
-                reserved: 0
+            start_resource: 20480
+            num_resource: 1024
+            type: 16269
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 64
-                type: 16330
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 64
+            type: 16330
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 22528
-                num_resource: 1024
-                type: 16333
-                host_id: 128
-                reserved: 0
+            start_resource: 22528
+            num_resource: 1024
+            type: 16333
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 4
-                type: 16384
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 4
+            type: 16384
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 4
-                type: 16384
-                host_id: 13
-                reserved: 0
+            start_resource: 4
+            num_resource: 4
+            type: 16384
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 4
-                type: 16384
-                host_id: 21
-                reserved: 0
+            start_resource: 8
+            num_resource: 4
+            type: 16384
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 4
-                type: 16384
-                host_id: 23
-                reserved: 0
+            start_resource: 12
+            num_resource: 4
+            type: 16384
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 16
-                num_resource: 12
-                type: 16384
-                host_id: 35
-                reserved: 0
+            start_resource: 16
+            num_resource: 12
+            type: 16384
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 28
-                num_resource: 4
-                type: 16384
-                host_id: 37
-                reserved: 0
+            start_resource: 28
+            num_resource: 4
+            type: 16384
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 32
-                num_resource: 4
-                type: 16384
-                host_id: 40
-                reserved: 0
+            start_resource: 32
+            num_resource: 4
+            type: 16384
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 36
-                num_resource: 4
-                type: 16384
-                host_id: 42
-                reserved: 0
+            start_resource: 36
+            num_resource: 4
+            type: 16384
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 40
-                num_resource: 4
-                type: 16384
-                host_id: 3
-                reserved: 0
+            start_resource: 40
+            num_resource: 4
+            type: 16384
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 44
-                num_resource: 4
-                type: 16384
-                host_id: 5
-                reserved: 0
+            start_resource: 44
+            num_resource: 4
+            type: 16384
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 48
-                num_resource: 16
-                type: 16384
-                host_id: 128
-                reserved: 0
+            start_resource: 48
+            num_resource: 16
+            type: 16384
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 16576
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 16576
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 423
-                num_resource: 32
-                type: 16577
-                host_id: 21
-                reserved: 0
+            start_resource: 423
+            num_resource: 32
+            type: 16577
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 455
-                num_resource: 32
-                type: 16577
-                host_id: 23
-                reserved: 0
+            start_resource: 455
+            num_resource: 32
+            type: 16577
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 487
-                num_resource: 182
-                type: 16577
-                host_id: 35
-                reserved: 0
+            start_resource: 487
+            num_resource: 182
+            type: 16577
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 669
-                num_resource: 40
-                type: 16577
-                host_id: 37
-                reserved: 0
+            start_resource: 669
+            num_resource: 40
+            type: 16577
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 709
-                num_resource: 10
-                type: 16577
-                host_id: 40
-                reserved: 0
+            start_resource: 709
+            num_resource: 10
+            type: 16577
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 719
-                num_resource: 10
-                type: 16577
-                host_id: 42
-                reserved: 0
+            start_resource: 719
+            num_resource: 10
+            type: 16577
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 729
-                num_resource: 6
-                type: 16577
-                host_id: 3
-                reserved: 0
+            start_resource: 729
+            num_resource: 6
+            type: 16577
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 735
-                num_resource: 6
-                type: 16577
-                host_id: 5
-                reserved: 0
+            start_resource: 735
+            num_resource: 6
+            type: 16577
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 878
-                num_resource: 128
-                type: 16577
-                host_id: 12
-                reserved: 0
+            start_resource: 878
+            num_resource: 128
+            type: 16577
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 1006
-                num_resource: 10
-                type: 16577
-                host_id: 13
-                reserved: 0
+            start_resource: 1006
+            num_resource: 10
+            type: 16577
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 345
-                num_resource: 6
-                type: 16578
-                host_id: 12
-                reserved: 0
+            start_resource: 345
+            num_resource: 6
+            type: 16578
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 351
-                num_resource: 0
-                type: 16578
-                host_id: 13
-                reserved: 0
+            start_resource: 351
+            num_resource: 0
+            type: 16578
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 351
-                num_resource: 2
-                type: 16578
-                host_id: 21
-                reserved: 0
+            start_resource: 351
+            num_resource: 2
+            type: 16578
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 353
-                num_resource: 2
-                type: 16578
-                host_id: 23
-                reserved: 0
+            start_resource: 353
+            num_resource: 2
+            type: 16578
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 355
-                num_resource: 6
-                type: 16578
-                host_id: 35
-                reserved: 0
+            start_resource: 355
+            num_resource: 6
+            type: 16578
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 361
-                num_resource: 1
-                type: 16578
-                host_id: 37
-                reserved: 0
+            start_resource: 361
+            num_resource: 1
+            type: 16578
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 362
-                num_resource: 1
-                type: 16578
-                host_id: 40
-                reserved: 0
+            start_resource: 362
+            num_resource: 1
+            type: 16578
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 363
-                num_resource: 1
-                type: 16578
-                host_id: 42
-                reserved: 0
+            start_resource: 363
+            num_resource: 1
+            type: 16578
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 364
-                num_resource: 2
-                type: 16578
-                host_id: 3
-                reserved: 0
+            start_resource: 364
+            num_resource: 2
+            type: 16578
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 366
-                num_resource: 2
-                type: 16578
-                host_id: 5
-                reserved: 0
+            start_resource: 366
+            num_resource: 2
+            type: 16578
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 368
-                num_resource: 22
-                type: 16578
-                host_id: 12
-                reserved: 0
+            start_resource: 368
+            num_resource: 22
+            type: 16578
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 390
-                num_resource: 6
-                type: 16578
-                host_id: 13
-                reserved: 0
+            start_resource: 390
+            num_resource: 6
+            type: 16578
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 396
-                num_resource: 4
-                type: 16578
-                host_id: 21
-                reserved: 0
+            start_resource: 396
+            num_resource: 4
+            type: 16578
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 400
-                num_resource: 4
-                type: 16578
-                host_id: 23
-                reserved: 0
+            start_resource: 400
+            num_resource: 4
+            type: 16578
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 404
-                num_resource: 12
-                type: 16578
-                host_id: 35
-                reserved: 0
+            start_resource: 404
+            num_resource: 12
+            type: 16578
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 416
-                num_resource: 1
-                type: 16578
-                host_id: 37
-                reserved: 0
+            start_resource: 416
+            num_resource: 1
+            type: 16578
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 417
-                num_resource: 2
-                type: 16578
-                host_id: 40
-                reserved: 0
+            start_resource: 417
+            num_resource: 2
+            type: 16578
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 419
-                num_resource: 2
-                type: 16578
-                host_id: 42
-                reserved: 0
+            start_resource: 419
+            num_resource: 2
+            type: 16578
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 421
-                num_resource: 2
-                type: 16578
-                host_id: 128
-                reserved: 0
+            start_resource: 421
+            num_resource: 2
+            type: 16578
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 6
-                type: 16579
-                host_id: 12
-                reserved: 0
+            start_resource: 4
+            num_resource: 6
+            type: 16579
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 0
-                type: 16579
-                host_id: 13
-                reserved: 0
+            start_resource: 10
+            num_resource: 0
+            type: 16579
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 2
-                type: 16579
-                host_id: 21
-                reserved: 0
+            start_resource: 10
+            num_resource: 2
+            type: 16579
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 2
-                type: 16579
-                host_id: 23
-                reserved: 0
+            start_resource: 12
+            num_resource: 2
+            type: 16579
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 14
-                num_resource: 6
-                type: 16579
-                host_id: 35
-                reserved: 0
+            start_resource: 14
+            num_resource: 6
+            type: 16579
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 1
-                type: 16579
-                host_id: 37
-                reserved: 0
+            start_resource: 20
+            num_resource: 1
+            type: 16579
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 21
-                num_resource: 1
-                type: 16579
-                host_id: 40
-                reserved: 0
+            start_resource: 21
+            num_resource: 1
+            type: 16579
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 22
-                num_resource: 1
-                type: 16579
-                host_id: 42
-                reserved: 0
+            start_resource: 22
+            num_resource: 1
+            type: 16579
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 23
-                num_resource: 2
-                type: 16579
-                host_id: 3
-                reserved: 0
+            start_resource: 23
+            num_resource: 2
+            type: 16579
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 25
-                num_resource: 2
-                type: 16579
-                host_id: 5
-                reserved: 0
+            start_resource: 25
+            num_resource: 2
+            type: 16579
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 27
-                num_resource: 22
-                type: 16579
-                host_id: 12
-                reserved: 0
+            start_resource: 27
+            num_resource: 22
+            type: 16579
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 49
-                num_resource: 6
-                type: 16579
-                host_id: 13
-                reserved: 0
+            start_resource: 49
+            num_resource: 6
+            type: 16579
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 55
-                num_resource: 4
-                type: 16579
-                host_id: 21
-                reserved: 0
+            start_resource: 55
+            num_resource: 4
+            type: 16579
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 59
-                num_resource: 4
-                type: 16579
-                host_id: 23
-                reserved: 0
+            start_resource: 59
+            num_resource: 4
+            type: 16579
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 63
-                num_resource: 12
-                type: 16579
-                host_id: 35
-                reserved: 0
+            start_resource: 63
+            num_resource: 12
+            type: 16579
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 75
-                num_resource: 4
-                type: 16579
-                host_id: 37
-                reserved: 0
+            start_resource: 75
+            num_resource: 4
+            type: 16579
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 79
-                num_resource: 2
-                type: 16579
-                host_id: 40
-                reserved: 0
+            start_resource: 79
+            num_resource: 2
+            type: 16579
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 81
-                num_resource: 2
-                type: 16579
-                host_id: 42
-                reserved: 0
+            start_resource: 81
+            num_resource: 2
+            type: 16579
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 83
-                num_resource: 2
-                type: 16579
-                host_id: 128
-                reserved: 0
+            start_resource: 83
+            num_resource: 2
+            type: 16579
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 85
-                num_resource: 16
-                type: 16580
-                host_id: 21
-                reserved: 0
+            start_resource: 85
+            num_resource: 16
+            type: 16580
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 101
-                num_resource: 12
-                type: 16580
-                host_id: 23
-                reserved: 0
+            start_resource: 101
+            num_resource: 12
+            type: 16580
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 113
-                num_resource: 2
-                type: 16580
-                host_id: 35
-                reserved: 0
+            start_resource: 113
+            num_resource: 2
+            type: 16580
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 115
-                num_resource: 2
-                type: 16580
-                host_id: 37
-                reserved: 0
+            start_resource: 115
+            num_resource: 2
+            type: 16580
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 117
-                num_resource: 96
-                type: 16580
-                host_id: 35
-                reserved: 0
+            start_resource: 117
+            num_resource: 96
+            type: 16580
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 309
-                num_resource: 32
-                type: 16580
-                host_id: 37
-                reserved: 0
+            start_resource: 309
+            num_resource: 32
+            type: 16580
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 343
-                num_resource: 1
-                type: 16581
-                host_id: 12
-                reserved: 0
+            start_resource: 343
+            num_resource: 1
+            type: 16581
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 344
-                num_resource: 1
-                type: 16581
-                host_id: 35
-                reserved: 0
+            start_resource: 344
+            num_resource: 1
+            type: 16581
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 341
-                num_resource: 1
-                type: 16582
-                host_id: 12
-                reserved: 0
+            start_resource: 341
+            num_resource: 1
+            type: 16582
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 342
-                num_resource: 1
-                type: 16582
-                host_id: 35
-                reserved: 0
+            start_resource: 342
+            num_resource: 1
+            type: 16582
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 1
-                type: 16583
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 1
+            type: 16583
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 3
-                num_resource: 1
-                type: 16583
-                host_id: 35
-                reserved: 0
+            start_resource: 3
+            num_resource: 1
+            type: 16583
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 16584
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 16584
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 1
-                type: 16584
-                host_id: 35
-                reserved: 0
+            start_resource: 1
+            num_resource: 1
+            type: 16584
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 5
-                type: 16586
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 5
+            type: 16586
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 7
-                num_resource: 1
-                type: 16586
-                host_id: 13
-                reserved: 0
+            start_resource: 7
+            num_resource: 1
+            type: 16586
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 3
-                type: 16587
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 3
+            type: 16587
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 3
-                num_resource: 2
-                type: 16587
-                host_id: 13
-                reserved: 0
+            start_resource: 3
+            num_resource: 2
+            type: 16587
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 5
-                num_resource: 3
-                type: 16587
-                host_id: 21
-                reserved: 0
+            start_resource: 5
+            num_resource: 3
+            type: 16587
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 3
-                type: 16587
-                host_id: 23
-                reserved: 0
+            start_resource: 8
+            num_resource: 3
+            type: 16587
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 11
-                num_resource: 6
-                type: 16587
-                host_id: 35
-                reserved: 0
+            start_resource: 11
+            num_resource: 6
+            type: 16587
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 17
-                num_resource: 3
-                type: 16587
-                host_id: 37
-                reserved: 0
+            start_resource: 17
+            num_resource: 3
+            type: 16587
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 3
-                type: 16587
-                host_id: 40
-                reserved: 0
+            start_resource: 20
+            num_resource: 3
+            type: 16587
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 23
-                num_resource: 3
-                type: 16587
-                host_id: 42
-                reserved: 0
+            start_resource: 23
+            num_resource: 3
+            type: 16587
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 1
-                type: 16587
-                host_id: 3
-                reserved: 0
+            start_resource: 26
+            num_resource: 1
+            type: 16587
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 27
-                num_resource: 1
-                type: 16587
-                host_id: 5
-                reserved: 0
+            start_resource: 27
+            num_resource: 1
+            type: 16587
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 28
-                num_resource: 4
-                type: 16587
-                host_id: 128
-                reserved: 0
+            start_resource: 28
+            num_resource: 4
+            type: 16587
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 82
-                num_resource: 16
-                type: 16832
-                host_id: 12
-                reserved: 0
+            start_resource: 82
+            num_resource: 16
+            type: 16832
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 98
-                num_resource: 16
-                type: 16832
-                host_id: 13
-                reserved: 0
+            start_resource: 98
+            num_resource: 16
+            type: 16832
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 114
-                num_resource: 110
-                type: 16832
-                host_id: 128
-                reserved: 0
+            start_resource: 114
+            num_resource: 110
+            type: 16832
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 16833
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 16833
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 49152
-                num_resource: 1024
-                type: 16834
-                host_id: 128
-                reserved: 0
+            start_resource: 49152
+            num_resource: 1024
+            type: 16834
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 16835
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 16835
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 6
-                type: 16842
-                host_id: 12
-                reserved: 0
+            start_resource: 4
+            num_resource: 6
+            type: 16842
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 0
-                type: 16842
-                host_id: 13
-                reserved: 0
+            start_resource: 10
+            num_resource: 0
+            type: 16842
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 2
-                type: 16842
-                host_id: 21
-                reserved: 0
+            start_resource: 10
+            num_resource: 2
+            type: 16842
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 2
-                type: 16842
-                host_id: 23
-                reserved: 0
+            start_resource: 12
+            num_resource: 2
+            type: 16842
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 14
-                num_resource: 6
-                type: 16842
-                host_id: 35
-                reserved: 0
+            start_resource: 14
+            num_resource: 6
+            type: 16842
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 1
-                type: 16842
-                host_id: 37
-                reserved: 0
+            start_resource: 20
+            num_resource: 1
+            type: 16842
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 21
-                num_resource: 1
-                type: 16842
-                host_id: 40
-                reserved: 0
+            start_resource: 21
+            num_resource: 1
+            type: 16842
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 22
-                num_resource: 1
-                type: 16842
-                host_id: 42
-                reserved: 0
+            start_resource: 22
+            num_resource: 1
+            type: 16842
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 23
-                num_resource: 2
-                type: 16842
-                host_id: 3
-                reserved: 0
+            start_resource: 23
+            num_resource: 2
+            type: 16842
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 25
-                num_resource: 2
-                type: 16842
-                host_id: 5
-                reserved: 0
+            start_resource: 25
+            num_resource: 2
+            type: 16842
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 27
-                num_resource: 22
-                type: 16842
-                host_id: 12
-                reserved: 0
+            start_resource: 27
+            num_resource: 22
+            type: 16842
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 49
-                num_resource: 6
-                type: 16842
-                host_id: 13
-                reserved: 0
+            start_resource: 49
+            num_resource: 6
+            type: 16842
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 55
-                num_resource: 4
-                type: 16842
-                host_id: 21
-                reserved: 0
+            start_resource: 55
+            num_resource: 4
+            type: 16842
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 59
-                num_resource: 4
-                type: 16842
-                host_id: 23
-                reserved: 0
+            start_resource: 59
+            num_resource: 4
+            type: 16842
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 63
-                num_resource: 12
-                type: 16842
-                host_id: 35
-                reserved: 0
+            start_resource: 63
+            num_resource: 12
+            type: 16842
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 75
-                num_resource: 1
-                type: 16842
-                host_id: 37
-                reserved: 0
+            start_resource: 75
+            num_resource: 1
+            type: 16842
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 76
-                num_resource: 2
-                type: 16842
-                host_id: 40
-                reserved: 0
+            start_resource: 76
+            num_resource: 2
+            type: 16842
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 78
-                num_resource: 2
-                type: 16842
-                host_id: 42
-                reserved: 0
+            start_resource: 78
+            num_resource: 2
+            type: 16842
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 80
-                num_resource: 2
-                type: 16842
-                host_id: 128
-                reserved: 0
+            start_resource: 80
+            num_resource: 2
+            type: 16842
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 1
-                type: 16843
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 1
+            type: 16843
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 3
-                num_resource: 1
-                type: 16843
-                host_id: 35
-                reserved: 0
+            start_resource: 3
+            num_resource: 1
+            type: 16843
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 16844
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 16844
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 1
-                type: 16844
-                host_id: 35
-                reserved: 0
+            start_resource: 1
+            num_resource: 1
+            type: 16844
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 4
-                num_resource: 6
-                type: 16845
-                host_id: 12
-                reserved: 0
+            start_resource: 4
+            num_resource: 6
+            type: 16845
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 0
-                type: 16845
-                host_id: 13
-                reserved: 0
+            start_resource: 10
+            num_resource: 0
+            type: 16845
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 2
-                type: 16845
-                host_id: 21
-                reserved: 0
+            start_resource: 10
+            num_resource: 2
+            type: 16845
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 2
-                type: 16845
-                host_id: 23
-                reserved: 0
+            start_resource: 12
+            num_resource: 2
+            type: 16845
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 14
-                num_resource: 6
-                type: 16845
-                host_id: 35
-                reserved: 0
+            start_resource: 14
+            num_resource: 6
+            type: 16845
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 1
-                type: 16845
-                host_id: 37
-                reserved: 0
+            start_resource: 20
+            num_resource: 1
+            type: 16845
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 21
-                num_resource: 1
-                type: 16845
-                host_id: 40
-                reserved: 0
+            start_resource: 21
+            num_resource: 1
+            type: 16845
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 22
-                num_resource: 1
-                type: 16845
-                host_id: 42
-                reserved: 0
+            start_resource: 22
+            num_resource: 1
+            type: 16845
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 23
-                num_resource: 2
-                type: 16845
-                host_id: 3
-                reserved: 0
+            start_resource: 23
+            num_resource: 2
+            type: 16845
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 25
-                num_resource: 2
-                type: 16845
-                host_id: 5
-                reserved: 0
+            start_resource: 25
+            num_resource: 2
+            type: 16845
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 27
-                num_resource: 22
-                type: 16845
-                host_id: 12
-                reserved: 0
+            start_resource: 27
+            num_resource: 22
+            type: 16845
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 49
-                num_resource: 6
-                type: 16845
-                host_id: 13
-                reserved: 0
+            start_resource: 49
+            num_resource: 6
+            type: 16845
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 55
-                num_resource: 4
-                type: 16845
-                host_id: 21
-                reserved: 0
+            start_resource: 55
+            num_resource: 4
+            type: 16845
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 59
-                num_resource: 4
-                type: 16845
-                host_id: 23
-                reserved: 0
+            start_resource: 59
+            num_resource: 4
+            type: 16845
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 63
-                num_resource: 12
-                type: 16845
-                host_id: 35
-                reserved: 0
+            start_resource: 63
+            num_resource: 12
+            type: 16845
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 75
-                num_resource: 4
-                type: 16845
-                host_id: 37
-                reserved: 0
+            start_resource: 75
+            num_resource: 4
+            type: 16845
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 79
-                num_resource: 2
-                type: 16845
-                host_id: 40
-                reserved: 0
+            start_resource: 79
+            num_resource: 2
+            type: 16845
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 81
-                num_resource: 2
-                type: 16845
-                host_id: 42
-                reserved: 0
+            start_resource: 81
+            num_resource: 2
+            type: 16845
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 83
-                num_resource: 2
-                type: 16845
-                host_id: 128
-                reserved: 0
+            start_resource: 83
+            num_resource: 2
+            type: 16845
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 85
-                num_resource: 16
-                type: 16846
-                host_id: 21
-                reserved: 0
+            start_resource: 85
+            num_resource: 16
+            type: 16846
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 101
-                num_resource: 12
-                type: 16846
-                host_id: 23
-                reserved: 0
+            start_resource: 101
+            num_resource: 12
+            type: 16846
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 113
-                num_resource: 2
-                type: 16846
-                host_id: 35
-                reserved: 0
+            start_resource: 113
+            num_resource: 2
+            type: 16846
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 115
-                num_resource: 2
-                type: 16846
-                host_id: 37
-                reserved: 0
+            start_resource: 115
+            num_resource: 2
+            type: 16846
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 117
-                num_resource: 96
-                type: 16846
-                host_id: 35
-                reserved: 0
+            start_resource: 117
+            num_resource: 96
+            type: 16846
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 309
-                num_resource: 32
-                type: 16846
-                host_id: 37
-                reserved: 0
+            start_resource: 309
+            num_resource: 32
+            type: 16846
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 1
-                type: 16847
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 1
+            type: 16847
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 3
-                num_resource: 1
-                type: 16847
-                host_id: 35
-                reserved: 0
+            start_resource: 3
+            num_resource: 1
+            type: 16847
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 16848
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 16848
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 1
-                type: 16848
-                host_id: 35
-                reserved: 0
+            start_resource: 1
+            num_resource: 1
+            type: 16848
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 34
-                num_resource: 86
-                type: 16970
-                host_id: 12
-                reserved: 0
+            start_resource: 34
+            num_resource: 86
+            type: 16970
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 120
-                num_resource: 32
-                type: 16970
-                host_id: 13
-                reserved: 0
+            start_resource: 120
+            num_resource: 32
+            type: 16970
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 152
-                num_resource: 12
-                type: 16970
-                host_id: 21
-                reserved: 0
+            start_resource: 152
+            num_resource: 12
+            type: 16970
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 164
-                num_resource: 12
-                type: 16970
-                host_id: 23
-                reserved: 0
+            start_resource: 164
+            num_resource: 12
+            type: 16970
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 176
-                num_resource: 28
-                type: 16970
-                host_id: 35
-                reserved: 0
+            start_resource: 176
+            num_resource: 28
+            type: 16970
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 204
-                num_resource: 8
-                type: 16970
-                host_id: 37
-                reserved: 0
+            start_resource: 204
+            num_resource: 8
+            type: 16970
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 212
-                num_resource: 12
-                type: 16970
-                host_id: 40
-                reserved: 0
+            start_resource: 212
+            num_resource: 12
+            type: 16970
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 224
-                num_resource: 12
-                type: 16970
-                host_id: 42
-                reserved: 0
+            start_resource: 224
+            num_resource: 12
+            type: 16970
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 236
-                num_resource: 20
-                type: 16970
-                host_id: 128
-                reserved: 0
+            start_resource: 236
+            num_resource: 20
+            type: 16970
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 34
-                num_resource: 1024
-                type: 16973
-                host_id: 12
-                reserved: 0
+            start_resource: 34
+            num_resource: 1024
+            type: 16973
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 1058
-                num_resource: 512
-                type: 16973
-                host_id: 13
-                reserved: 0
+            start_resource: 1058
+            num_resource: 512
+            type: 16973
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 1570
-                num_resource: 256
-                type: 16973
-                host_id: 21
-                reserved: 0
+            start_resource: 1570
+            num_resource: 256
+            type: 16973
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 1826
-                num_resource: 256
-                type: 16973
-                host_id: 23
-                reserved: 0
+            start_resource: 1826
+            num_resource: 256
+            type: 16973
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 2082
-                num_resource: 512
-                type: 16973
-                host_id: 35
-                reserved: 0
+            start_resource: 2082
+            num_resource: 512
+            type: 16973
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 2594
-                num_resource: 256
-                type: 16973
-                host_id: 37
-                reserved: 0
+            start_resource: 2594
+            num_resource: 256
+            type: 16973
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 2850
-                num_resource: 256
-                type: 16973
-                host_id: 40
-                reserved: 0
+            start_resource: 2850
+            num_resource: 256
+            type: 16973
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 3106
-                num_resource: 256
-                type: 16973
-                host_id: 42
-                reserved: 0
+            start_resource: 3106
+            num_resource: 256
+            type: 16973
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 3362
-                num_resource: 32
-                type: 16973
-                host_id: 3
-                reserved: 0
+            start_resource: 3362
+            num_resource: 32
+            type: 16973
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 3394
-                num_resource: 32
-                type: 16973
-                host_id: 5
-                reserved: 0
+            start_resource: 3394
+            num_resource: 32
+            type: 16973
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 3426
-                num_resource: 1182
-                type: 16973
-                host_id: 128
-                reserved: 0
+            start_resource: 3426
+            num_resource: 1182
+            type: 16973
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 1536
-                num_resource: 16
-                type: 16975
-                host_id: 128
-                reserved: 0
+            start_resource: 1536
+            num_resource: 16
+            type: 16975
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 2048
-                num_resource: 16
-                type: 16976
-                host_id: 128
-                reserved: 0
+            start_resource: 2048
+            num_resource: 16
+            type: 16976
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 2560
-                num_resource: 16
-                type: 16977
-                host_id: 128
-                reserved: 0
+            start_resource: 2560
+            num_resource: 16
+            type: 16977
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 3072
-                num_resource: 32
-                type: 16978
-                host_id: 128
-                reserved: 0
+            start_resource: 3072
+            num_resource: 32
+            type: 16978
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 3584
-                num_resource: 32
-                type: 16979
-                host_id: 128
-                reserved: 0
+            start_resource: 3584
+            num_resource: 32
+            type: 16979
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 4096
-                num_resource: 32
-                type: 16980
-                host_id: 128
-                reserved: 0
+            start_resource: 4096
+            num_resource: 32
+            type: 16980
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 12
-                type: 17152
-                host_id: 3
-                reserved: 0
+            start_resource: 12
+            num_resource: 12
+            type: 17152
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 36
-                num_resource: 20
-                type: 17152
-                host_id: 5
-                reserved: 0
+            start_resource: 36
+            num_resource: 20
+            type: 17152
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 1
-                num_resource: 4
-                type: 17344
-                host_id: 12
-                reserved: 0
+            start_resource: 1
+            num_resource: 4
+            type: 17344
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 5
-                num_resource: 4
-                type: 17344
-                host_id: 13
-                reserved: 0
+            start_resource: 5
+            num_resource: 4
+            type: 17344
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 9
-                num_resource: 4
-                type: 17344
-                host_id: 21
-                reserved: 0
+            start_resource: 9
+            num_resource: 4
+            type: 17344
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 13
-                num_resource: 4
-                type: 17344
-                host_id: 23
-                reserved: 0
+            start_resource: 13
+            num_resource: 4
+            type: 17344
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 17
-                num_resource: 16
-                type: 17344
-                host_id: 35
-                reserved: 0
+            start_resource: 17
+            num_resource: 16
+            type: 17344
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 33
-                num_resource: 4
-                type: 17344
-                host_id: 37
-                reserved: 0
+            start_resource: 33
+            num_resource: 4
+            type: 17344
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 37
-                num_resource: 4
-                type: 17344
-                host_id: 40
-                reserved: 0
+            start_resource: 37
+            num_resource: 4
+            type: 17344
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 41
-                num_resource: 4
-                type: 17344
-                host_id: 42
-                reserved: 0
+            start_resource: 41
+            num_resource: 4
+            type: 17344
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 45
-                num_resource: 4
-                type: 17344
-                host_id: 3
-                reserved: 0
+            start_resource: 45
+            num_resource: 4
+            type: 17344
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 49
-                num_resource: 4
-                type: 17344
-                host_id: 5
-                reserved: 0
+            start_resource: 49
+            num_resource: 4
+            type: 17344
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 53
-                num_resource: 11
-                type: 17344
-                host_id: 128
-                reserved: 0
+            start_resource: 53
+            num_resource: 11
+            type: 17344
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 17408
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 17408
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 96
-                num_resource: 20
-                type: 17409
-                host_id: 12
-                reserved: 0
+            start_resource: 96
+            num_resource: 20
+            type: 17409
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 116
-                num_resource: 8
-                type: 17409
-                host_id: 13
-                reserved: 0
+            start_resource: 116
+            num_resource: 8
+            type: 17409
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 124
-                num_resource: 8
-                type: 17409
-                host_id: 21
-                reserved: 0
+            start_resource: 124
+            num_resource: 8
+            type: 17409
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 132
-                num_resource: 8
-                type: 17409
-                host_id: 23
-                reserved: 0
+            start_resource: 132
+            num_resource: 8
+            type: 17409
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 140
-                num_resource: 16
-                type: 17409
-                host_id: 35
-                reserved: 0
+            start_resource: 140
+            num_resource: 16
+            type: 17409
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 156
-                num_resource: 8
-                type: 17409
-                host_id: 37
-                reserved: 0
+            start_resource: 156
+            num_resource: 8
+            type: 17409
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 164
-                num_resource: 8
-                type: 17409
-                host_id: 40
-                reserved: 0
+            start_resource: 164
+            num_resource: 8
+            type: 17409
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 172
-                num_resource: 8
-                type: 17409
-                host_id: 42
-                reserved: 0
+            start_resource: 172
+            num_resource: 8
+            type: 17409
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 180
-                num_resource: 32
-                type: 17409
-                host_id: 3
-                reserved: 0
+            start_resource: 180
+            num_resource: 32
+            type: 17409
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 212
-                num_resource: 12
-                type: 17409
-                host_id: 5
-                reserved: 0
+            start_resource: 212
+            num_resource: 12
+            type: 17409
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 224
-                num_resource: 28
-                type: 17409
-                host_id: 128
-                reserved: 0
+            start_resource: 224
+            num_resource: 28
+            type: 17409
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 50
-                num_resource: 4
-                type: 17410
-                host_id: 12
-                reserved: 0
+            start_resource: 50
+            num_resource: 4
+            type: 17410
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 54
-                num_resource: 0
-                type: 17410
-                host_id: 13
-                reserved: 0
+            start_resource: 54
+            num_resource: 0
+            type: 17410
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 54
-                num_resource: 1
-                type: 17410
-                host_id: 21
-                reserved: 0
+            start_resource: 54
+            num_resource: 1
+            type: 17410
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 55
-                num_resource: 1
-                type: 17410
-                host_id: 23
-                reserved: 0
+            start_resource: 55
+            num_resource: 1
+            type: 17410
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 56
-                num_resource: 1
-                type: 17410
-                host_id: 35
-                reserved: 0
+            start_resource: 56
+            num_resource: 1
+            type: 17410
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 57
-                num_resource: 1
-                type: 17410
-                host_id: 37
-                reserved: 0
+            start_resource: 57
+            num_resource: 1
+            type: 17410
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 58
-                num_resource: 1
-                type: 17410
-                host_id: 40
-                reserved: 0
+            start_resource: 58
+            num_resource: 1
+            type: 17410
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 59
-                num_resource: 1
-                type: 17410
-                host_id: 42
-                reserved: 0
+            start_resource: 59
+            num_resource: 1
+            type: 17410
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 60
-                num_resource: 2
-                type: 17410
-                host_id: 3
-                reserved: 0
+            start_resource: 60
+            num_resource: 2
+            type: 17410
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 62
-                num_resource: 0
-                type: 17410
-                host_id: 5
-                reserved: 0
+            start_resource: 62
+            num_resource: 0
+            type: 17410
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 62
-                num_resource: 9
-                type: 17410
-                host_id: 12
-                reserved: 0
+            start_resource: 62
+            num_resource: 9
+            type: 17410
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 71
-                num_resource: 6
-                type: 17410
-                host_id: 13
-                reserved: 0
+            start_resource: 71
+            num_resource: 6
+            type: 17410
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 77
-                num_resource: 1
-                type: 17410
-                host_id: 21
-                reserved: 0
+            start_resource: 77
+            num_resource: 1
+            type: 17410
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 78
-                num_resource: 1
-                type: 17410
-                host_id: 23
-                reserved: 0
+            start_resource: 78
+            num_resource: 1
+            type: 17410
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 79
-                num_resource: 2
-                type: 17410
-                host_id: 35
-                reserved: 0
+            start_resource: 79
+            num_resource: 2
+            type: 17410
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 81
-                num_resource: 1
-                type: 17410
-                host_id: 37
-                reserved: 0
+            start_resource: 81
+            num_resource: 1
+            type: 17410
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 82
-                num_resource: 1
-                type: 17410
-                host_id: 40
-                reserved: 0
+            start_resource: 82
+            num_resource: 1
+            type: 17410
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 83
-                num_resource: 1
-                type: 17410
-                host_id: 42
-                reserved: 0
+            start_resource: 83
+            num_resource: 1
+            type: 17410
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 84
-                num_resource: 3
-                type: 17410
-                host_id: 3
-                reserved: 0
+            start_resource: 84
+            num_resource: 3
+            type: 17410
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 87
-                num_resource: 2
-                type: 17410
-                host_id: 5
-                reserved: 0
+            start_resource: 87
+            num_resource: 2
+            type: 17410
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 89
-                num_resource: 4
-                type: 17410
-                host_id: 128
-                reserved: 0
+            start_resource: 89
+            num_resource: 4
+            type: 17410
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 4
-                type: 17411
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 4
+            type: 17411
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 6
-                num_resource: 0
-                type: 17411
-                host_id: 13
-                reserved: 0
+            start_resource: 6
+            num_resource: 0
+            type: 17411
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 6
-                num_resource: 1
-                type: 17411
-                host_id: 21
-                reserved: 0
+            start_resource: 6
+            num_resource: 1
+            type: 17411
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 7
-                num_resource: 1
-                type: 17411
-                host_id: 23
-                reserved: 0
+            start_resource: 7
+            num_resource: 1
+            type: 17411
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 1
-                type: 17411
-                host_id: 35
-                reserved: 0
+            start_resource: 8
+            num_resource: 1
+            type: 17411
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 9
-                num_resource: 1
-                type: 17411
-                host_id: 37
-                reserved: 0
+            start_resource: 9
+            num_resource: 1
+            type: 17411
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 1
-                type: 17411
-                host_id: 40
-                reserved: 0
+            start_resource: 10
+            num_resource: 1
+            type: 17411
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 11
-                num_resource: 1
-                type: 17411
-                host_id: 42
-                reserved: 0
+            start_resource: 11
+            num_resource: 1
+            type: 17411
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 2
-                type: 17411
-                host_id: 3
-                reserved: 0
+            start_resource: 12
+            num_resource: 2
+            type: 17411
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 14
-                num_resource: 0
-                type: 17411
-                host_id: 5
-                reserved: 0
+            start_resource: 14
+            num_resource: 0
+            type: 17411
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 14
-                num_resource: 9
-                type: 17411
-                host_id: 12
-                reserved: 0
+            start_resource: 14
+            num_resource: 9
+            type: 17411
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 23
-                num_resource: 6
-                type: 17411
-                host_id: 13
-                reserved: 0
+            start_resource: 23
+            num_resource: 6
+            type: 17411
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 29
-                num_resource: 1
-                type: 17411
-                host_id: 21
-                reserved: 0
+            start_resource: 29
+            num_resource: 1
+            type: 17411
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 30
-                num_resource: 1
-                type: 17411
-                host_id: 23
-                reserved: 0
+            start_resource: 30
+            num_resource: 1
+            type: 17411
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 31
-                num_resource: 2
-                type: 17411
-                host_id: 35
-                reserved: 0
+            start_resource: 31
+            num_resource: 2
+            type: 17411
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 33
-                num_resource: 1
-                type: 17411
-                host_id: 37
-                reserved: 0
+            start_resource: 33
+            num_resource: 1
+            type: 17411
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 34
-                num_resource: 1
-                type: 17411
-                host_id: 40
-                reserved: 0
+            start_resource: 34
+            num_resource: 1
+            type: 17411
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 35
-                num_resource: 1
-                type: 17411
-                host_id: 42
-                reserved: 0
+            start_resource: 35
+            num_resource: 1
+            type: 17411
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 36
-                num_resource: 3
-                type: 17411
-                host_id: 3
-                reserved: 0
+            start_resource: 36
+            num_resource: 3
+            type: 17411
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 39
-                num_resource: 2
-                type: 17411
-                host_id: 5
-                reserved: 0
+            start_resource: 39
+            num_resource: 2
+            type: 17411
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 41
-                num_resource: 5
-                type: 17411
-                host_id: 128
-                reserved: 0
+            start_resource: 41
+            num_resource: 5
+            type: 17411
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 48
-                num_resource: 0
-                type: 17413
-                host_id: 3
-                reserved: 0
+            start_resource: 48
+            num_resource: 0
+            type: 17413
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 48
-                num_resource: 2
-                type: 17413
-                host_id: 3
-                reserved: 0
+            start_resource: 48
+            num_resource: 2
+            type: 17413
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 0
-                type: 17415
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 0
+            type: 17415
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 2
-                type: 17415
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 2
+            type: 17415
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 5
-                type: 17418
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 5
+            type: 17418
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 7
-                num_resource: 1
-                type: 17418
-                host_id: 13
-                reserved: 0
+            start_resource: 7
+            num_resource: 1
+            type: 17418
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 3
-                type: 17419
-                host_id: 12
-                reserved: 0
+            start_resource: 0
+            num_resource: 3
+            type: 17419
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 3
-                num_resource: 2
-                type: 17419
-                host_id: 13
-                reserved: 0
+            start_resource: 3
+            num_resource: 2
+            type: 17419
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 5
-                num_resource: 3
-                type: 17419
-                host_id: 21
-                reserved: 0
+            start_resource: 5
+            num_resource: 3
+            type: 17419
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 3
-                type: 17419
-                host_id: 23
-                reserved: 0
+            start_resource: 8
+            num_resource: 3
+            type: 17419
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 11
-                num_resource: 3
-                type: 17419
-                host_id: 35
-                reserved: 0
+            start_resource: 11
+            num_resource: 3
+            type: 17419
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 14
-                num_resource: 3
-                type: 17419
-                host_id: 37
-                reserved: 0
+            start_resource: 14
+            num_resource: 3
+            type: 17419
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 17
-                num_resource: 3
-                type: 17419
-                host_id: 40
-                reserved: 0
+            start_resource: 17
+            num_resource: 3
+            type: 17419
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 20
-                num_resource: 3
-                type: 17419
-                host_id: 42
-                reserved: 0
+            start_resource: 20
+            num_resource: 3
+            type: 17419
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 23
-                num_resource: 3
-                type: 17419
-                host_id: 3
-                reserved: 0
+            start_resource: 23
+            num_resource: 3
+            type: 17419
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 26
-                num_resource: 3
-                type: 17419
-                host_id: 5
-                reserved: 0
+            start_resource: 26
+            num_resource: 3
+            type: 17419
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 29
-                num_resource: 3
-                type: 17419
-                host_id: 128
-                reserved: 0
+            start_resource: 29
+            num_resource: 3
+            type: 17419
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 48
-                num_resource: 8
-                type: 17472
-                host_id: 12
-                reserved: 0
+            start_resource: 48
+            num_resource: 8
+            type: 17472
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 56
-                num_resource: 4
-                type: 17472
-                host_id: 13
-                reserved: 0
+            start_resource: 56
+            num_resource: 4
+            type: 17472
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 60
-                num_resource: 8
-                type: 17472
-                host_id: 35
-                reserved: 0
+            start_resource: 60
+            num_resource: 8
+            type: 17472
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 68
-                num_resource: 4
-                type: 17472
-                host_id: 37
-                reserved: 0
+            start_resource: 68
+            num_resource: 4
+            type: 17472
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 72
-                num_resource: 4
-                type: 17472
-                host_id: 40
-                reserved: 0
+            start_resource: 72
+            num_resource: 4
+            type: 17472
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 76
-                num_resource: 4
-                type: 17472
-                host_id: 42
-                reserved: 0
+            start_resource: 76
+            num_resource: 4
+            type: 17472
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 80
-                num_resource: 8
-                type: 17472
-                host_id: 3
-                reserved: 0
+            start_resource: 80
+            num_resource: 8
+            type: 17472
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 88
-                num_resource: 4
-                type: 17472
-                host_id: 5
-                reserved: 0
+            start_resource: 88
+            num_resource: 4
+            type: 17472
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 92
-                num_resource: 4
-                type: 17472
-                host_id: 128
-                reserved: 0
+            start_resource: 92
+            num_resource: 4
+            type: 17472
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 17473
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 17473
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 56320
-                num_resource: 256
-                type: 17474
-                host_id: 128
-                reserved: 0
+            start_resource: 56320
+            num_resource: 256
+            type: 17474
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 1
-                type: 17475
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 1
+            type: 17475
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 4
-                type: 17482
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 4
+            type: 17482
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 6
-                num_resource: 0
-                type: 17482
-                host_id: 13
-                reserved: 0
+            start_resource: 6
+            num_resource: 0
+            type: 17482
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 6
-                num_resource: 1
-                type: 17482
-                host_id: 21
-                reserved: 0
+            start_resource: 6
+            num_resource: 1
+            type: 17482
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 7
-                num_resource: 1
-                type: 17482
-                host_id: 23
-                reserved: 0
+            start_resource: 7
+            num_resource: 1
+            type: 17482
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 1
-                type: 17482
-                host_id: 35
-                reserved: 0
+            start_resource: 8
+            num_resource: 1
+            type: 17482
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 9
-                num_resource: 1
-                type: 17482
-                host_id: 37
-                reserved: 0
+            start_resource: 9
+            num_resource: 1
+            type: 17482
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 1
-                type: 17482
-                host_id: 40
-                reserved: 0
+            start_resource: 10
+            num_resource: 1
+            type: 17482
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 11
-                num_resource: 1
-                type: 17482
-                host_id: 42
-                reserved: 0
+            start_resource: 11
+            num_resource: 1
+            type: 17482
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 2
-                type: 17482
-                host_id: 3
-                reserved: 0
+            start_resource: 12
+            num_resource: 2
+            type: 17482
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 14
-                num_resource: 0
-                type: 17482
-                host_id: 5
-                reserved: 0
+            start_resource: 14
+            num_resource: 0
+            type: 17482
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 14
-                num_resource: 9
-                type: 17482
-                host_id: 12
-                reserved: 0
+            start_resource: 14
+            num_resource: 9
+            type: 17482
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 23
-                num_resource: 6
-                type: 17482
-                host_id: 13
-                reserved: 0
+            start_resource: 23
+            num_resource: 6
+            type: 17482
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 29
-                num_resource: 1
-                type: 17482
-                host_id: 21
-                reserved: 0
+            start_resource: 29
+            num_resource: 1
+            type: 17482
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 30
-                num_resource: 1
-                type: 17482
-                host_id: 23
-                reserved: 0
+            start_resource: 30
+            num_resource: 1
+            type: 17482
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 31
-                num_resource: 2
-                type: 17482
-                host_id: 35
-                reserved: 0
+            start_resource: 31
+            num_resource: 2
+            type: 17482
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 33
-                num_resource: 1
-                type: 17482
-                host_id: 37
-                reserved: 0
+            start_resource: 33
+            num_resource: 1
+            type: 17482
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 34
-                num_resource: 1
-                type: 17482
-                host_id: 40
-                reserved: 0
+            start_resource: 34
+            num_resource: 1
+            type: 17482
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 35
-                num_resource: 1
-                type: 17482
-                host_id: 42
-                reserved: 0
+            start_resource: 35
+            num_resource: 1
+            type: 17482
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 36
-                num_resource: 3
-                type: 17482
-                host_id: 3
-                reserved: 0
+            start_resource: 36
+            num_resource: 3
+            type: 17482
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 39
-                num_resource: 2
-                type: 17482
-                host_id: 5
-                reserved: 0
+            start_resource: 39
+            num_resource: 2
+            type: 17482
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 41
-                num_resource: 4
-                type: 17482
-                host_id: 128
-                reserved: 0
+            start_resource: 41
+            num_resource: 4
+            type: 17482
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 0
-                type: 17483
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 0
+            type: 17483
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 2
-                type: 17483
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 2
+            type: 17483
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 2
-                num_resource: 4
-                type: 17485
-                host_id: 12
-                reserved: 0
+            start_resource: 2
+            num_resource: 4
+            type: 17485
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 6
-                num_resource: 0
-                type: 17485
-                host_id: 13
-                reserved: 0
+            start_resource: 6
+            num_resource: 0
+            type: 17485
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 6
-                num_resource: 1
-                type: 17485
-                host_id: 21
-                reserved: 0
+            start_resource: 6
+            num_resource: 1
+            type: 17485
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 7
-                num_resource: 1
-                type: 17485
-                host_id: 23
-                reserved: 0
+            start_resource: 7
+            num_resource: 1
+            type: 17485
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 8
-                num_resource: 1
-                type: 17485
-                host_id: 35
-                reserved: 0
+            start_resource: 8
+            num_resource: 1
+            type: 17485
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 9
-                num_resource: 1
-                type: 17485
-                host_id: 37
-                reserved: 0
+            start_resource: 9
+            num_resource: 1
+            type: 17485
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 10
-                num_resource: 1
-                type: 17485
-                host_id: 40
-                reserved: 0
+            start_resource: 10
+            num_resource: 1
+            type: 17485
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 11
-                num_resource: 1
-                type: 17485
-                host_id: 42
-                reserved: 0
+            start_resource: 11
+            num_resource: 1
+            type: 17485
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 12
-                num_resource: 2
-                type: 17485
-                host_id: 3
-                reserved: 0
+            start_resource: 12
+            num_resource: 2
+            type: 17485
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 14
-                num_resource: 0
-                type: 17485
-                host_id: 5
-                reserved: 0
+            start_resource: 14
+            num_resource: 0
+            type: 17485
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 14
-                num_resource: 9
-                type: 17485
-                host_id: 12
-                reserved: 0
+            start_resource: 14
+            num_resource: 9
+            type: 17485
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 23
-                num_resource: 6
-                type: 17485
-                host_id: 13
-                reserved: 0
+            start_resource: 23
+            num_resource: 6
+            type: 17485
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 29
-                num_resource: 1
-                type: 17485
-                host_id: 21
-                reserved: 0
+            start_resource: 29
+            num_resource: 1
+            type: 17485
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 30
-                num_resource: 1
-                type: 17485
-                host_id: 23
-                reserved: 0
+            start_resource: 30
+            num_resource: 1
+            type: 17485
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 31
-                num_resource: 2
-                type: 17485
-                host_id: 35
-                reserved: 0
+            start_resource: 31
+            num_resource: 2
+            type: 17485
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 33
-                num_resource: 1
-                type: 17485
-                host_id: 37
-                reserved: 0
+            start_resource: 33
+            num_resource: 1
+            type: 17485
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 34
-                num_resource: 1
-                type: 17485
-                host_id: 40
-                reserved: 0
+            start_resource: 34
+            num_resource: 1
+            type: 17485
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 35
-                num_resource: 1
-                type: 17485
-                host_id: 42
-                reserved: 0
+            start_resource: 35
+            num_resource: 1
+            type: 17485
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 36
-                num_resource: 3
-                type: 17485
-                host_id: 3
-                reserved: 0
+            start_resource: 36
+            num_resource: 3
+            type: 17485
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 39
-                num_resource: 2
-                type: 17485
-                host_id: 5
-                reserved: 0
+            start_resource: 39
+            num_resource: 2
+            type: 17485
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 41
-                num_resource: 5
-                type: 17485
-                host_id: 128
-                reserved: 0
+            start_resource: 41
+            num_resource: 5
+            type: 17485
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 0
-                type: 17487
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 0
+            type: 17487
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 0
-                num_resource: 2
-                type: 17487
-                host_id: 3
-                reserved: 0
+            start_resource: 0
+            num_resource: 2
+            type: 17487
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 22
-                num_resource: 32
-                type: 17610
-                host_id: 12
-                reserved: 0
+            start_resource: 22
+            num_resource: 32
+            type: 17610
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 54
-                num_resource: 16
-                type: 17610
-                host_id: 13
-                reserved: 0
+            start_resource: 54
+            num_resource: 16
+            type: 17610
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 70
-                num_resource: 8
-                type: 17610
-                host_id: 21
-                reserved: 0
+            start_resource: 70
+            num_resource: 8
+            type: 17610
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 78
-                num_resource: 8
-                type: 17610
-                host_id: 23
-                reserved: 0
+            start_resource: 78
+            num_resource: 8
+            type: 17610
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 86
-                num_resource: 24
-                type: 17610
-                host_id: 35
-                reserved: 0
+            start_resource: 86
+            num_resource: 24
+            type: 17610
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 110
-                num_resource: 8
-                type: 17610
-                host_id: 37
-                reserved: 0
+            start_resource: 110
+            num_resource: 8
+            type: 17610
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 118
-                num_resource: 16
-                type: 17610
-                host_id: 40
-                reserved: 0
+            start_resource: 118
+            num_resource: 16
+            type: 17610
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 134
-                num_resource: 16
-                type: 17610
-                host_id: 42
-                reserved: 0
+            start_resource: 134
+            num_resource: 16
+            type: 17610
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 150
-                num_resource: 64
-                type: 17610
-                host_id: 3
-                reserved: 0
+            start_resource: 150
+            num_resource: 64
+            type: 17610
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 214
-                num_resource: 4
-                type: 17610
-                host_id: 5
-                reserved: 0
+            start_resource: 214
+            num_resource: 4
+            type: 17610
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 218
-                num_resource: 38
-                type: 17610
-                host_id: 128
-                reserved: 0
+            start_resource: 218
+            num_resource: 38
+            type: 17610
+            host_id: 128
+            reserved: 0
 
         -
-                start_resource: 16406
-                num_resource: 128
-                type: 17613
-                host_id: 12
-                reserved: 0
+            start_resource: 16406
+            num_resource: 128
+            type: 17613
+            host_id: 12
+            reserved: 0
 
         -
-                start_resource: 16534
-                num_resource: 128
-                type: 17613
-                host_id: 13
-                reserved: 0
+            start_resource: 16534
+            num_resource: 128
+            type: 17613
+            host_id: 13
+            reserved: 0
 
         -
-                start_resource: 16662
-                num_resource: 64
-                type: 17613
-                host_id: 21
-                reserved: 0
+            start_resource: 16662
+            num_resource: 64
+            type: 17613
+            host_id: 21
+            reserved: 0
 
         -
-                start_resource: 16726
-                num_resource: 64
-                type: 17613
-                host_id: 23
-                reserved: 0
+            start_resource: 16726
+            num_resource: 64
+            type: 17613
+            host_id: 23
+            reserved: 0
 
         -
-                start_resource: 16790
-                num_resource: 128
-                type: 17613
-                host_id: 35
-                reserved: 0
+            start_resource: 16790
+            num_resource: 128
+            type: 17613
+            host_id: 35
+            reserved: 0
 
         -
-                start_resource: 16918
-                num_resource: 128
-                type: 17613
-                host_id: 37
-                reserved: 0
+            start_resource: 16918
+            num_resource: 128
+            type: 17613
+            host_id: 37
+            reserved: 0
 
         -
-                start_resource: 17046
-                num_resource: 128
-                type: 17613
-                host_id: 40
-                reserved: 0
+            start_resource: 17046
+            num_resource: 128
+            type: 17613
+            host_id: 40
+            reserved: 0
 
         -
-                start_resource: 17174
-                num_resource: 128
-                type: 17613
-                host_id: 42
-                reserved: 0
+            start_resource: 17174
+            num_resource: 128
+            type: 17613
+            host_id: 42
+            reserved: 0
 
         -
-                start_resource: 17302
-                num_resource: 256
-                type: 17613
-                host_id: 3
-                reserved: 0
+            start_resource: 17302
+            num_resource: 256
+            type: 17613
+            host_id: 3
+            reserved: 0
 
         -
-                start_resource: 17558
-                num_resource: 64
-                type: 17613
-                host_id: 5
-                reserved: 0
+            start_resource: 17558
+            num_resource: 64
+            type: 17613
+            host_id: 5
+            reserved: 0
 
         -
-                start_resource: 17622
-                num_resource: 298
-                type: 17613
-                host_id: 128
-                reserved: 0
+            start_resource: 17622
+            num_resource: 298
+            type: 17613
+            host_id: 128
+            reserved: 0
diff --git a/board/ti/j721s2/sec-cfg.yaml b/board/ti/j721s2/sec-cfg.yaml
index b3601d2a1c..d0f3a161a7 100644
--- a/board/ti/j721s2/sec-cfg.yaml
+++ b/board/ti/j721s2/sec-cfg.yaml
@@ -8,138 +8,138 @@
 
 sec-cfg:
     rev:
-        boardcfg_abi_maj : 0x0
-        boardcfg_abi_min : 0x1
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
     processor_acl_list:
         subhdr:
             magic: 0xF1EA
             size: 164
         proc_acl_entries:
-            - #1
+            -  # 1
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #2
+            -  # 2
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #3
+            -  # 3
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #4
+            -  # 4
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #5
+            -  # 5
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #6
+            -  # 6
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #7
+            -  # 7
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #8
+            -  # 8
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #9
+            -  # 9
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #10
+            -  # 10
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #11
+            -  # 11
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #12
+            -  # 12
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #13
+            -  # 13
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #14
+            -  # 14
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #15
+            -  # 15
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #16
+            -  # 16
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #17
+            -  # 17
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #18
+            -  # 18
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #19
+            -  # 19
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #20
+            -  # 20
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #21
+            -  # 21
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #22
+            -  # 22
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #23
+            -  # 23
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #24
+            -  # 24
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #25
+            -  # 25
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #26
+            -  # 26
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #27
+            -  # 27
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #28
+            -  # 28
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #29
+            -  # 29
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #30
+            -  # 30
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #31
+            -  # 31
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
-            - #32
+            -  # 32
                 processor_id: 0
                 proc_access_master: 0
                 proc_access_secondary: [0, 0, 0]
@@ -148,202 +148,202 @@ sec-cfg:
             magic: 0x8D27
             size: 68
         host_hierarchy_entries:
-            - #1
+            -  # 1
                 host_id: 0
                 supervisor_host_id: 0
-            - #2
+            -  # 2
                 host_id: 0
                 supervisor_host_id: 0
-            - #3
+            -  # 3
                 host_id: 0
                 supervisor_host_id: 0
-            - #4
+            -  # 4
                 host_id: 0
                 supervisor_host_id: 0
-            - #5
+            -  # 5
                 host_id: 0
                 supervisor_host_id: 0
-            - #6
+            -  # 6
                 host_id: 0
                 supervisor_host_id: 0
-            - #7
+            -  # 7
                 host_id: 0
                 supervisor_host_id: 0
-            - #8
+            -  # 8
                 host_id: 0
                 supervisor_host_id: 0
-            - #9
+            -  # 9
                 host_id: 0
                 supervisor_host_id: 0
-            - #10
+            -  # 10
                 host_id: 0
                 supervisor_host_id: 0
-            - #11
+            -  # 11
                 host_id: 0
                 supervisor_host_id: 0
-            - #12
+            -  # 12
                 host_id: 0
                 supervisor_host_id: 0
-            - #13
+            -  # 13
                 host_id: 0
                 supervisor_host_id: 0
-            - #14
+            -  # 14
                 host_id: 0
                 supervisor_host_id: 0
-            - #15
+            -  # 15
                 host_id: 0
                 supervisor_host_id: 0
-            - #16
+            -  # 16
                 host_id: 0
                 supervisor_host_id: 0
-            - #17
+            -  # 17
                 host_id: 0
                 supervisor_host_id: 0
-            - #18
+            -  # 18
                 host_id: 0
                 supervisor_host_id: 0
-            - #19
+            -  # 19
                 host_id: 0
                 supervisor_host_id: 0
-            - #20
+            -  # 20
                 host_id: 0
                 supervisor_host_id: 0
-            - #21
+            -  # 21
                 host_id: 0
                 supervisor_host_id: 0
-            - #22
+            -  # 22
                 host_id: 0
                 supervisor_host_id: 0
-            - #23
+            -  # 23
                 host_id: 0
                 supervisor_host_id: 0
-            - #24
+            -  # 24
                 host_id: 0
                 supervisor_host_id: 0
-            - #25
+            -  # 25
                 host_id: 0
                 supervisor_host_id: 0
-            - #26
+            -  # 26
                 host_id: 0
                 supervisor_host_id: 0
-            - #27
+            -  # 27
                 host_id: 0
                 supervisor_host_id: 0
-            - #28
+            -  # 28
                 host_id: 0
                 supervisor_host_id: 0
-            - #29
+            -  # 29
                 host_id: 0
                 supervisor_host_id: 0
-            - #30
+            -  # 30
                 host_id: 0
                 supervisor_host_id: 0
-            - #31
+            -  # 31
                 host_id: 0
                 supervisor_host_id: 0
-            - #32
+            -  # 32
                 host_id: 0
                 supervisor_host_id: 0
     otp_config:
         subhdr:
             magic: 0x4081
             size: 69
-        write_host_id : 0
+        write_host_id: 0
         otp_entry:
-            - #1
+            -  # 1
                 host_id: 0
                 host_perms: 0
-            - #2
+            -  # 2
                 host_id: 0
                 host_perms: 0
-            - #3
+            -  # 3
                 host_id: 0
                 host_perms: 0
-            - #4
+            -  # 4
                 host_id: 0
                 host_perms: 0
-            - #5
+            -  # 5
                 host_id: 0
                 host_perms: 0
-            - #6
+            -  # 6
                 host_id: 0
                 host_perms: 0
-            - #7
+            -  # 7
                 host_id: 0
                 host_perms: 0
-            - #8
+            -  # 8
                 host_id: 0
                 host_perms: 0
-            - #9
+            -  # 9
                 host_id: 0
                 host_perms: 0
-            - #10
+            -  # 10
                 host_id: 0
                 host_perms: 0
-            - #11
+            -  # 11
                 host_id: 0
                 host_perms: 0
-            - #12
+            -  # 12
                 host_id: 0
                 host_perms: 0
-            - #13
+            -  # 13
                 host_id: 0
                 host_perms: 0
-            - #14
+            -  # 14
                 host_id: 0
                 host_perms: 0
-            - #15
+            -  # 15
                 host_id: 0
                 host_perms: 0
-            - #16
+            -  # 16
                 host_id: 0
                 host_perms: 0
-            - #17
+            -  # 17
                 host_id: 0
                 host_perms: 0
-            - #18
+            -  # 18
                 host_id: 0
                 host_perms: 0
-            - #19
+            -  # 19
                 host_id: 0
                 host_perms: 0
-            - #20
+            -  # 20
                 host_id: 0
                 host_perms: 0
-            - #21
+            -  # 21
                 host_id: 0
                 host_perms: 0
-            - #22
+            -  # 22
                 host_id: 0
                 host_perms: 0
-            - #23
+            -  # 23
                 host_id: 0
                 host_perms: 0
-            - #24
+            -  # 24
                 host_id: 0
                 host_perms: 0
-            - #25
+            -  # 25
                 host_id: 0
                 host_perms: 0
-            - #26
+            -  # 26
                 host_id: 0
                 host_perms: 0
-            - #27
+            -  # 27
                 host_id: 0
                 host_perms: 0
-            - #28
+            -  # 28
                 host_id: 0
                 host_perms: 0
-            - #29
+            -  # 29
                 host_id: 0
                 host_perms: 0
-            - #30
+            -  # 30
                 host_id: 0
                 host_perms: 0
-            - #31
+            -  # 31
                 host_id: 0
                 host_perms: 0
-            - #32
+            -  # 32
                 host_id: 0
                 host_perms: 0
     dkek_config:
@@ -351,12 +351,12 @@ sec-cfg:
             magic: 0x5170
             size: 12
         allowed_hosts: [128, 0, 0, 0]
-        allow_dkek_export_tisci : 0x5A
+        allow_dkek_export_tisci: 0x5A
         rsvd: [0, 0, 0]
     sa2ul_cfg:
         subhdr:
             magic: 0x23BE
-            size : 0
+            size: 0
         auth_resource_owner: 0
         enable_saul_psil_global_config_writes: 0
         rsvd: [0, 0]
@@ -364,16 +364,16 @@ sec-cfg:
         subhdr:
             magic: 0x42AF
             size: 16
-        allow_jtag_unlock : 0x0
-        allow_wildcard_unlock : 0x0
+        allow_jtag_unlock: 0x0
+        allow_wildcard_unlock: 0x0
         allowed_debug_level_rsvd: 0
         rsvd: 0
-        min_cert_rev : 0x0
+        min_cert_rev: 0x0
         jtag_unlock_hosts: [0, 0, 0, 0]
     sec_handover_cfg:
         subhdr:
             magic: 0x608F
             size: 10
-        handover_msg_sender : 0
-        handover_to_host_id : 0
+        handover_msg_sender: 0
+        handover_to_host_id: 0
         rsvd: [0, 0, 0, 0]
-- 
2.34.1

