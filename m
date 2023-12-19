Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3355CC46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 19:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5C8877B0;
	Tue, 19 Dec 2023 20:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WRkiE94x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13094877A1; Tue, 19 Dec 2023 20:17:04 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 066A08779D
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJGhSZ108445;
 Tue, 19 Dec 2023 13:16:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703013403;
 bh=n8KV+pTw6iwdHBKuVbANahebThItaesgcF5EUGQmQJ4=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=WRkiE94xCNdNz80S4toVouAh7jUiLjb+ECUYoljgL1IIwJUkAwE1bO7amYnE7tDjf
 aA44G1eL1Fwospq/HshCoeVp2uzKXtaetlkKZB1zqvmtT07nkUMFotOmEsGN1D888G
 CInb0g1p5H8YOpRUFJoCBeSpbKvFzTAObPQbL18c=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJJGh5M012039
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 13:16:43 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 13:16:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 13:16:42 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.69.34] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJFcAI065909;
 Tue, 19 Dec 2023 13:16:36 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v7 09/17] board: ti: j748s4: Add board config yaml files
Date: Wed, 20 Dec 2023 00:45:29 +0530
Message-ID: <20231219191537.4039361-10-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191537.4039361-1-a-nandan@ti.com>
References: <20231219191537.4039361-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 19 Dec 2023 20:17:19 +0100
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

Add board-cfg, rm-cfg, pm-cfg, sec-cfg, tifs-rm-cfg yaml for buidling
u-boot sysfw data.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 board/ti/j784s4/board-cfg.yaml   |   37 +
 board/ti/j784s4/pm-cfg.yaml      |   13 +
 board/ti/j784s4/rm-cfg.yaml      | 3058 ++++++++++++++++++++++++++++++
 board/ti/j784s4/sec-cfg.yaml     |  380 ++++
 board/ti/j784s4/tifs-rm-cfg.yaml | 2656 ++++++++++++++++++++++++++
 5 files changed, 6144 insertions(+)
 create mode 100644 board/ti/j784s4/board-cfg.yaml
 create mode 100644 board/ti/j784s4/pm-cfg.yaml
 create mode 100644 board/ti/j784s4/rm-cfg.yaml
 create mode 100644 board/ti/j784s4/sec-cfg.yaml
 create mode 100644 board/ti/j784s4/tifs-rm-cfg.yaml

diff --git a/board/ti/j784s4/board-cfg.yaml b/board/ti/j784s4/board-cfg.yaml
new file mode 100644
index 0000000000..3760f51073
--- /dev/null
+++ b/board/ti/j784s4/board-cfg.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for J784S4
+#
+
+---
+
+board-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+    control:
+        subhdr:
+            magic: 0xC1D3
+            size: 7
+        main_isolation_enable: 0x5A
+        main_isolation_hostid: 0x2
+    secproxy:
+        subhdr:
+            magic: 0x1207
+            size: 7
+        scaling_factor: 0x1
+        scaling_profile: 0x1
+        disable_main_nav_secure_proxy: 0
+    msmc:
+        subhdr:
+            magic: 0xA5C3
+            size: 5
+        msmc_cache_size: 0x8
+    debug_cfg:
+        subhdr:
+            magic: 0x020C
+            size: 8
+        trace_dst_enables: 0x00
+        trace_src_enables: 0x00
diff --git a/board/ti/j784s4/pm-cfg.yaml b/board/ti/j784s4/pm-cfg.yaml
new file mode 100644
index 0000000000..6720b26dd5
--- /dev/null
+++ b/board/ti/j784s4/pm-cfg.yaml
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Power management configuration for J784S4
+#
+
+---
+
+pm-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
diff --git a/board/ti/j784s4/rm-cfg.yaml b/board/ti/j784s4/rm-cfg.yaml
new file mode 100644
index 0000000000..26f44bd537
--- /dev/null
+++ b/board/ti/j784s4/rm-cfg.yaml
@@ -0,0 +1,3058 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for J784S4
+#
+
+---
+
+rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj : 0x0
+            boardcfg_abi_min : 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size : 356
+            host_cfg_entries:
+                - #1
+                    host_id: 3
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #2
+                    host_id: 5
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #3
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #4
+                    host_id: 13
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #5
+                    host_id: 21
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #6
+                    host_id: 23
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #7
+                    host_id: 25
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #8
+                    host_id: 27
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #9
+                    host_id: 35
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #10
+                    host_id: 37
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #11
+                    host_id: 40
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #12
+                    host_id: 42
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #13
+                    host_id: 45
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #14
+                    host_id: 47
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 3744
+            reserved: 0
+    resasg_entries:
+        -
+                start_resource: 0
+                num_resource: 4
+                type: 640
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 4
+                type: 640
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 4
+                type: 640
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 4
+                type: 640
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 4
+                type: 640
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 4
+                type: 640
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 4
+                type: 640
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 4
+                type: 640
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 12
+                type: 640
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 12
+                type: 640
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 16
+                type: 704
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 32
+                type: 11072
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 24
+                type: 11072
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 8
+                type: 11072
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 24
+                type: 11136
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 16
+                type: 11136
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 8
+                type: 11136
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 48
+                type: 11264
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 11328
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 8
+                type: 11328
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 6
+                type: 11328
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 6
+                type: 11328
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 2
+                type: 11328
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 2
+                type: 11328
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 50176
+                num_resource: 96
+                type: 17986
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 17987
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 16
+                type: 17998
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 16
+                type: 17998
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 17999
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 8
+                type: 17999
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 16
+                type: 18017
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 16
+                type: 18017
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 18018
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 8
+                type: 18018
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 80
+                type: 18112
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 96
+                num_resource: 14
+                type: 18112
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 110
+                num_resource: 21
+                type: 18112
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 131
+                num_resource: 21
+                type: 18112
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 152
+                num_resource: 12
+                type: 18112
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 164
+                num_resource: 12
+                type: 18112
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 196
+                num_resource: 28
+                type: 18112
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 228
+                num_resource: 28
+                type: 18112
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 260
+                num_resource: 28
+                type: 18112
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 292
+                num_resource: 28
+                type: 18112
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 324
+                num_resource: 28
+                type: 18112
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 356
+                num_resource: 28
+                type: 18112
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 400
+                num_resource: 4
+                type: 18112
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 404
+                num_resource: 4
+                type: 18112
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 64
+                type: 19850
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 20480
+                num_resource: 1024
+                type: 19853
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 64
+                type: 19914
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 22528
+                num_resource: 1024
+                type: 19917
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 4
+                type: 19968
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 4
+                type: 19968
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 4
+                type: 19968
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 4
+                type: 19968
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 4
+                type: 19968
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 4
+                type: 19968
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 12
+                type: 19968
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 4
+                type: 19968
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 4
+                type: 19968
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 4
+                type: 19968
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 4
+                type: 19968
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 4
+                type: 19968
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 19968
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 4
+                type: 19968
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20160
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 423
+                num_resource: 10
+                type: 20161
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 433
+                num_resource: 20
+                type: 20161
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 453
+                num_resource: 16
+                type: 20161
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 469
+                num_resource: 13
+                type: 20161
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 482
+                num_resource: 128
+                type: 20161
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 610
+                num_resource: 46
+                type: 20161
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 656
+                num_resource: 10
+                type: 20161
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 666
+                num_resource: 20
+                type: 20161
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 686
+                num_resource: 64
+                type: 20161
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 750
+                num_resource: 10
+                type: 20161
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 760
+                num_resource: 4
+                type: 20161
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 764
+                num_resource: 4
+                type: 20161
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 878
+                num_resource: 128
+                type: 20161
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1006
+                num_resource: 10
+                type: 20161
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 345
+                num_resource: 6
+                type: 20162
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 351
+                num_resource: 0
+                type: 20162
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 351
+                num_resource: 1
+                type: 20162
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 352
+                num_resource: 1
+                type: 20162
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 353
+                num_resource: 1
+                type: 20162
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 354
+                num_resource: 1
+                type: 20162
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 355
+                num_resource: 4
+                type: 20162
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 359
+                num_resource: 1
+                type: 20162
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 360
+                num_resource: 1
+                type: 20162
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 361
+                num_resource: 1
+                type: 20162
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 362
+                num_resource: 3
+                type: 20162
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 365
+                num_resource: 1
+                type: 20162
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 366
+                num_resource: 1
+                type: 20162
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 367
+                num_resource: 1
+                type: 20162
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 368
+                num_resource: 25
+                type: 20162
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 393
+                num_resource: 1
+                type: 20162
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 394
+                num_resource: 2
+                type: 20162
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 396
+                num_resource: 2
+                type: 20162
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 398
+                num_resource: 2
+                type: 20162
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 400
+                num_resource: 2
+                type: 20162
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 402
+                num_resource: 12
+                type: 20162
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 414
+                num_resource: 1
+                type: 20162
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 415
+                num_resource: 2
+                type: 20162
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 417
+                num_resource: 2
+                type: 20162
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 419
+                num_resource: 2
+                type: 20162
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 421
+                num_resource: 2
+                type: 20162
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20163
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20163
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20163
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20163
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20163
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20163
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20163
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20163
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20163
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20163
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20163
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20163
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20163
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20163
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20163
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20163
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20163
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20163
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20163
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20163
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20163
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20163
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 2
+                type: 20163
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 2
+                type: 20163
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20163
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 2
+                type: 20163
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 8
+                type: 20164
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 93
+                num_resource: 8
+                type: 20164
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 101
+                num_resource: 6
+                type: 20164
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 107
+                num_resource: 4
+                type: 20164
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 111
+                num_resource: 2
+                type: 20164
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 113
+                num_resource: 2
+                type: 20164
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 0
+                type: 20164
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 2
+                type: 20164
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 117
+                num_resource: 96
+                type: 20164
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 213
+                num_resource: 96
+                type: 20164
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 309
+                num_resource: 32
+                type: 20164
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 343
+                num_resource: 1
+                type: 20165
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 344
+                num_resource: 1
+                type: 20165
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 341
+                num_resource: 1
+                type: 20166
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 342
+                num_resource: 1
+                type: 20166
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20167
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20167
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20168
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20168
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 5
+                type: 20170
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 20170
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 3
+                type: 20171
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 2
+                type: 20171
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 3
+                type: 20171
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 3
+                type: 20171
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20171
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20171
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 6
+                type: 20171
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 3
+                type: 20171
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 3
+                type: 20171
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 3
+                type: 20171
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 1
+                type: 20171
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 20171
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 20171
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 20171
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 82
+                num_resource: 16
+                type: 20416
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 98
+                num_resource: 16
+                type: 20416
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 114
+                num_resource: 110
+                type: 20416
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20417
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 49152
+                num_resource: 1024
+                type: 20418
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20419
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20426
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20426
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20426
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20426
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20426
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20426
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20426
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20426
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20426
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20426
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20426
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20426
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20426
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20426
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20426
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20426
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20426
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20426
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20426
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20426
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20426
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 1
+                type: 20426
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 74
+                num_resource: 2
+                type: 20426
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 76
+                num_resource: 2
+                type: 20426
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 78
+                num_resource: 2
+                type: 20426
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 20426
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20427
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20427
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20428
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20428
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20429
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20429
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20429
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20429
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20429
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20429
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20429
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20429
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20429
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20429
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20429
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20429
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20429
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20429
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20429
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20429
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20429
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20429
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20429
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20429
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20429
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20429
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 2
+                type: 20429
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 2
+                type: 20429
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20429
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 2
+                type: 20429
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 8
+                type: 20430
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 93
+                num_resource: 8
+                type: 20430
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 101
+                num_resource: 6
+                type: 20430
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 107
+                num_resource: 4
+                type: 20430
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 111
+                num_resource: 2
+                type: 20430
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 113
+                num_resource: 2
+                type: 20430
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 0
+                type: 20430
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 2
+                type: 20430
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 117
+                num_resource: 96
+                type: 20430
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 213
+                num_resource: 96
+                type: 20430
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 309
+                num_resource: 32
+                type: 20430
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20431
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20431
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20432
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20432
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 56
+                type: 20554
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 112
+                num_resource: 24
+                type: 20554
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 136
+                num_resource: 12
+                type: 20554
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 148
+                num_resource: 12
+                type: 20554
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 160
+                num_resource: 10
+                type: 20554
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 170
+                num_resource: 10
+                type: 20554
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 180
+                num_resource: 28
+                type: 20554
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 208
+                num_resource: 8
+                type: 20554
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 216
+                num_resource: 12
+                type: 20554
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 228
+                num_resource: 8
+                type: 20554
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 236
+                num_resource: 10
+                type: 20554
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 246
+                num_resource: 10
+                type: 20554
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 1024
+                type: 20557
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1080
+                num_resource: 512
+                type: 20557
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 1592
+                num_resource: 256
+                type: 20557
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 1848
+                num_resource: 256
+                type: 20557
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 2104
+                num_resource: 256
+                type: 20557
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 2360
+                num_resource: 256
+                type: 20557
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 2616
+                num_resource: 512
+                type: 20557
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 3128
+                num_resource: 256
+                type: 20557
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 3384
+                num_resource: 256
+                type: 20557
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 3640
+                num_resource: 256
+                type: 20557
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 3896
+                num_resource: 256
+                type: 20557
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 4152
+                num_resource: 256
+                type: 20557
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 4408
+                num_resource: 32
+                type: 20557
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 4440
+                num_resource: 32
+                type: 20557
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 4472
+                num_resource: 136
+                type: 20557
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 1536
+                num_resource: 16
+                type: 20559
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2048
+                num_resource: 16
+                type: 20560
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2560
+                num_resource: 16
+                type: 20561
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3072
+                num_resource: 32
+                type: 20562
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3584
+                num_resource: 32
+                type: 20563
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4096
+                num_resource: 32
+                type: 20564
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 12
+                type: 20736
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 20
+                type: 20736
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 2
+                type: 20928
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 4
+                type: 20928
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 4
+                type: 20928
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 4
+                type: 20928
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 4
+                type: 20928
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 4
+                type: 20928
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 16
+                type: 20928
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 4
+                type: 20928
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 4
+                type: 20928
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 47
+                num_resource: 4
+                type: 20928
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 51
+                num_resource: 3
+                type: 20928
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 2
+                type: 20928
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 20928
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 4
+                type: 20928
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20992
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 96
+                num_resource: 20
+                type: 20993
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 116
+                num_resource: 8
+                type: 20993
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 124
+                num_resource: 8
+                type: 20993
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 132
+                num_resource: 8
+                type: 20993
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 140
+                num_resource: 8
+                type: 20993
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 148
+                num_resource: 8
+                type: 20993
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 156
+                num_resource: 16
+                type: 20993
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 172
+                num_resource: 8
+                type: 20993
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 180
+                num_resource: 8
+                type: 20993
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 188
+                num_resource: 8
+                type: 20993
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 196
+                num_resource: 8
+                type: 20993
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 204
+                num_resource: 4
+                type: 20993
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 208
+                num_resource: 32
+                type: 20993
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 240
+                num_resource: 12
+                type: 20993
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 50
+                num_resource: 3
+                type: 20994
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 0
+                type: 20994
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 1
+                type: 20994
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 1
+                type: 20994
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 1
+                type: 20994
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 1
+                type: 20994
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 1
+                type: 20994
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 58
+                num_resource: 1
+                type: 20994
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 1
+                type: 20994
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 1
+                type: 20994
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 1
+                type: 20994
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 62
+                num_resource: 1
+                type: 20994
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 63
+                num_resource: 2
+                type: 20994
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 65
+                num_resource: 0
+                type: 20994
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 65
+                num_resource: 8
+                type: 20994
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20994
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 1
+                type: 20994
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 78
+                num_resource: 1
+                type: 20994
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 1
+                type: 20994
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 1
+                type: 20994
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20994
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 1
+                type: 20994
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 84
+                num_resource: 1
+                type: 20994
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 1
+                type: 20994
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 86
+                num_resource: 1
+                type: 20994
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 87
+                num_resource: 1
+                type: 20994
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 88
+                num_resource: 3
+                type: 20994
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 91
+                num_resource: 2
+                type: 20994
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 20995
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 20995
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 20995
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 20995
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 20995
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 20995
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 20995
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20995
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20995
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20995
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20995
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 20995
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 20995
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 20995
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 20995
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 20995
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 20995
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 20995
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 20995
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 20995
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 20995
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 20995
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 20995
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 20995
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 20995
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 20995
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 20995
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 20995
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 45
+                num_resource: 1
+                type: 20995
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 0
+                type: 20997
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 2
+                type: 20997
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 20999
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 20999
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 5
+                type: 21002
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21002
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 3
+                type: 21003
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 2
+                type: 21003
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 2
+                type: 21003
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 2
+                type: 21003
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 2
+                type: 21003
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 2
+                type: 21003
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 21003
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 2
+                type: 21003
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 2
+                type: 21003
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 2
+                type: 21003
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 2
+                type: 21003
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 21003
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 3
+                type: 21003
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 3
+                type: 21003
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 8
+                type: 21056
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 21056
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 8
+                type: 21056
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 68
+                num_resource: 4
+                type: 21056
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 72
+                num_resource: 4
+                type: 21056
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 76
+                num_resource: 4
+                type: 21056
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 21056
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 82
+                num_resource: 2
+                type: 21056
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 84
+                num_resource: 8
+                type: 21056
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 92
+                num_resource: 4
+                type: 21056
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 21057
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 56320
+                num_resource: 256
+                type: 21058
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 21059
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 21066
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 21066
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21066
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 21066
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 21066
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 21066
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 21066
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 21066
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 21066
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 21066
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 21066
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 21066
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 21066
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 21066
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 21066
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 21066
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 21066
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 21066
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 21066
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 21066
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 21066
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 21066
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 21066
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 21066
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 21066
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 21066
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 21066
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 21066
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 21067
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 21067
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 21069
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 21069
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21069
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 21069
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 21069
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 21069
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 21069
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 21069
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 21069
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 21069
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 21069
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 21069
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 21069
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 21069
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 21069
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 21069
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 21069
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 21069
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 21069
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 21069
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 21069
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 21069
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 21069
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 21069
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 21069
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 21069
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 21069
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 21069
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 45
+                num_resource: 1
+                type: 21069
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 21071
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 21071
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 32
+                type: 21194
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 64
+                type: 21194
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 118
+                num_resource: 4
+                type: 21194
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 122
+                num_resource: 134
+                type: 21194
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 16406
+                num_resource: 128
+                type: 21197
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 16534
+                num_resource: 256
+                type: 21197
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 16790
+                num_resource: 64
+                type: 21197
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 16854
+                num_resource: 1066
+                type: 21197
+                host_id: 128
+                reserved: 0
diff --git a/board/ti/j784s4/sec-cfg.yaml b/board/ti/j784s4/sec-cfg.yaml
new file mode 100644
index 0000000000..b14db36eed
--- /dev/null
+++ b/board/ti/j784s4/sec-cfg.yaml
@@ -0,0 +1,380 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security management configuration for J784S4
+#
+
+---
+
+sec-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+    processor_acl_list:
+        subhdr:
+            magic: 0xF1EA
+            size: 164
+        proc_acl_entries:
+            - #1
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #2
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #3
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #4
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #5
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #6
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #7
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #8
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #9
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #10
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #11
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #12
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #13
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #14
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #15
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #16
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #17
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #18
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #19
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #20
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #21
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #22
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #23
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #24
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #25
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #26
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #27
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #28
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #29
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #30
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #31
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #32
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+    host_hierarchy:
+        subhdr:
+            magic: 0x8D27
+            size: 68
+        host_hierarchy_entries:
+            - #1
+                host_id: 0
+                supervisor_host_id: 0
+            - #2
+                host_id: 0
+                supervisor_host_id: 0
+            - #3
+                host_id: 0
+                supervisor_host_id: 0
+            - #4
+                host_id: 0
+                supervisor_host_id: 0
+            - #5
+                host_id: 0
+                supervisor_host_id: 0
+            - #6
+                host_id: 0
+                supervisor_host_id: 0
+            - #7
+                host_id: 0
+                supervisor_host_id: 0
+            - #8
+                host_id: 0
+                supervisor_host_id: 0
+            - #9
+                host_id: 0
+                supervisor_host_id: 0
+            - #10
+                host_id: 0
+                supervisor_host_id: 0
+            - #11
+                host_id: 0
+                supervisor_host_id: 0
+            - #12
+                host_id: 0
+                supervisor_host_id: 0
+            - #13
+                host_id: 0
+                supervisor_host_id: 0
+            - #14
+                host_id: 0
+                supervisor_host_id: 0
+            - #15
+                host_id: 0
+                supervisor_host_id: 0
+            - #16
+                host_id: 0
+                supervisor_host_id: 0
+            - #17
+                host_id: 0
+                supervisor_host_id: 0
+            - #18
+                host_id: 0
+                supervisor_host_id: 0
+            - #19
+                host_id: 0
+                supervisor_host_id: 0
+            - #20
+                host_id: 0
+                supervisor_host_id: 0
+            - #21
+                host_id: 0
+                supervisor_host_id: 0
+            - #22
+                host_id: 0
+                supervisor_host_id: 0
+            - #23
+                host_id: 0
+                supervisor_host_id: 0
+            - #24
+                host_id: 0
+                supervisor_host_id: 0
+            - #25
+                host_id: 0
+                supervisor_host_id: 0
+            - #26
+                host_id: 0
+                supervisor_host_id: 0
+            - #27
+                host_id: 0
+                supervisor_host_id: 0
+            - #28
+                host_id: 0
+                supervisor_host_id: 0
+            - #29
+                host_id: 0
+                supervisor_host_id: 0
+            - #30
+                host_id: 0
+                supervisor_host_id: 0
+            - #31
+                host_id: 0
+                supervisor_host_id: 0
+            - #32
+                host_id: 0
+                supervisor_host_id: 0
+    otp_config:
+        subhdr:
+            magic: 0x4081
+            size: 69
+        write_host_id: 0
+        otp_entry:
+            - #1
+                host_id: 0
+                host_perms: 0
+            - #2
+                host_id: 0
+                host_perms: 0
+            - #3
+                host_id: 0
+                host_perms: 0
+            - #4
+                host_id: 0
+                host_perms: 0
+            - #5
+                host_id: 0
+                host_perms: 0
+            - #6
+                host_id: 0
+                host_perms: 0
+            - #7
+                host_id: 0
+                host_perms: 0
+            - #8
+                host_id: 0
+                host_perms: 0
+            - #9
+                host_id: 0
+                host_perms: 0
+            - #10
+                host_id: 0
+                host_perms: 0
+            - #11
+                host_id: 0
+                host_perms: 0
+            - #12
+                host_id: 0
+                host_perms: 0
+            - #13
+                host_id: 0
+                host_perms: 0
+            - #14
+                host_id: 0
+                host_perms: 0
+            - #15
+                host_id: 0
+                host_perms: 0
+            - #16
+                host_id: 0
+                host_perms: 0
+            - #17
+                host_id: 0
+                host_perms: 0
+            - #18
+                host_id: 0
+                host_perms: 0
+            - #19
+                host_id: 0
+                host_perms: 0
+            - #20
+                host_id: 0
+                host_perms: 0
+            - #21
+                host_id: 0
+                host_perms: 0
+            - #22
+                host_id: 0
+                host_perms: 0
+            - #23
+                host_id: 0
+                host_perms: 0
+            - #24
+                host_id: 0
+                host_perms: 0
+            - #25
+                host_id: 0
+                host_perms: 0
+            - #26
+                host_id: 0
+                host_perms: 0
+            - #27
+                host_id: 0
+                host_perms: 0
+            - #28
+                host_id: 0
+                host_perms: 0
+            - #29
+                host_id: 0
+                host_perms: 0
+            - #30
+                host_id: 0
+                host_perms: 0
+            - #31
+                host_id: 0
+                host_perms: 0
+            - #32
+                host_id: 0
+                host_perms: 0
+    dkek_config:
+        subhdr:
+            magic: 0x5170
+            size: 12
+        allowed_hosts: [128, 0, 0, 0]
+        allow_dkek_export_tisci : 0x5A
+        rsvd: [0, 0, 0]
+    sa2ul_cfg:
+        subhdr:
+            magic: 0x23BE
+            size : 0
+        auth_resource_owner: 0
+        enable_saul_psil_global_config_writes: 0
+        rsvd: [0, 0]
+    sec_dbg_config:
+        subhdr:
+            magic: 0x42AF
+            size: 16
+        allow_jtag_unlock : 0x0
+        allow_wildcard_unlock : 0x0
+        allowed_debug_level_rsvd: 0
+        rsvd: 0
+        min_cert_rev : 0x0
+        jtag_unlock_hosts: [0, 0, 0, 0]
+    sec_handover_cfg:
+        subhdr:
+            magic: 0x608F
+            size: 10
+        handover_msg_sender : 0
+        handover_to_host_id : 0
+        rsvd: [0, 0, 0, 0]
diff --git a/board/ti/j784s4/tifs-rm-cfg.yaml b/board/ti/j784s4/tifs-rm-cfg.yaml
new file mode 100644
index 0000000000..fc4a7fbaf8
--- /dev/null
+++ b/board/ti/j784s4/tifs-rm-cfg.yaml
@@ -0,0 +1,2656 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for J784S4
+#
+
+---
+
+tifs-rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj : 0x0
+            boardcfg_abi_min : 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size : 356
+            host_cfg_entries:
+                - #1
+                    host_id: 3
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #2
+                    host_id: 5
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #3
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #4
+                    host_id: 13
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #5
+                    host_id: 21
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #6
+                    host_id: 23
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #7
+                    host_id: 25
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #8
+                    host_id: 27
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #9
+                    host_id: 35
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #10
+                    host_id: 37
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #11
+                    host_id: 40
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #12
+                    host_id: 42
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #13
+                    host_id: 45
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #14
+                    host_id: 47
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 3208
+            reserved: 0
+    resasg_entries:
+        -
+                start_resource: 16
+                num_resource: 16
+                type: 17998
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 16
+                type: 17998
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 17999
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 8
+                type: 17999
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 16
+                type: 18017
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 16
+                type: 18017
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 18018
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 8
+                type: 18018
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 64
+                type: 19850
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 64
+                type: 19914
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 4
+                type: 19968
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 4
+                type: 19968
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 4
+                type: 19968
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 4
+                type: 19968
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 4
+                type: 19968
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 4
+                type: 19968
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 12
+                type: 19968
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 4
+                type: 19968
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 4
+                type: 19968
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 4
+                type: 19968
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 4
+                type: 19968
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 4
+                type: 19968
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 19968
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 4
+                type: 19968
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20160
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 423
+                num_resource: 10
+                type: 20161
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 433
+                num_resource: 20
+                type: 20161
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 453
+                num_resource: 16
+                type: 20161
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 469
+                num_resource: 13
+                type: 20161
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 482
+                num_resource: 128
+                type: 20161
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 610
+                num_resource: 46
+                type: 20161
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 656
+                num_resource: 10
+                type: 20161
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 666
+                num_resource: 20
+                type: 20161
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 686
+                num_resource: 64
+                type: 20161
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 750
+                num_resource: 10
+                type: 20161
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 760
+                num_resource: 4
+                type: 20161
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 764
+                num_resource: 4
+                type: 20161
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 878
+                num_resource: 128
+                type: 20161
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1006
+                num_resource: 10
+                type: 20161
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 345
+                num_resource: 6
+                type: 20162
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 351
+                num_resource: 0
+                type: 20162
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 351
+                num_resource: 1
+                type: 20162
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 352
+                num_resource: 1
+                type: 20162
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 353
+                num_resource: 1
+                type: 20162
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 354
+                num_resource: 1
+                type: 20162
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 355
+                num_resource: 4
+                type: 20162
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 359
+                num_resource: 1
+                type: 20162
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 360
+                num_resource: 1
+                type: 20162
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 361
+                num_resource: 1
+                type: 20162
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 362
+                num_resource: 3
+                type: 20162
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 365
+                num_resource: 1
+                type: 20162
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 366
+                num_resource: 1
+                type: 20162
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 367
+                num_resource: 1
+                type: 20162
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 368
+                num_resource: 25
+                type: 20162
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 393
+                num_resource: 1
+                type: 20162
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 394
+                num_resource: 2
+                type: 20162
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 396
+                num_resource: 2
+                type: 20162
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 398
+                num_resource: 2
+                type: 20162
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 400
+                num_resource: 2
+                type: 20162
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 402
+                num_resource: 12
+                type: 20162
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 414
+                num_resource: 1
+                type: 20162
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 415
+                num_resource: 2
+                type: 20162
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 417
+                num_resource: 2
+                type: 20162
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 419
+                num_resource: 2
+                type: 20162
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 421
+                num_resource: 2
+                type: 20162
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20163
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20163
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20163
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20163
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20163
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20163
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20163
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20163
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20163
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20163
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20163
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20163
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20163
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20163
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20163
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20163
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20163
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20163
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20163
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20163
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20163
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20163
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 2
+                type: 20163
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 2
+                type: 20163
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20163
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 2
+                type: 20163
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 8
+                type: 20164
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 93
+                num_resource: 8
+                type: 20164
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 101
+                num_resource: 6
+                type: 20164
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 107
+                num_resource: 4
+                type: 20164
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 111
+                num_resource: 2
+                type: 20164
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 113
+                num_resource: 2
+                type: 20164
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 0
+                type: 20164
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 2
+                type: 20164
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 117
+                num_resource: 96
+                type: 20164
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 213
+                num_resource: 96
+                type: 20164
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 309
+                num_resource: 32
+                type: 20164
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 343
+                num_resource: 1
+                type: 20165
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 344
+                num_resource: 1
+                type: 20165
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 341
+                num_resource: 1
+                type: 20166
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 342
+                num_resource: 1
+                type: 20166
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20167
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20167
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20168
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20168
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 5
+                type: 20170
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 20170
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 3
+                type: 20171
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 2
+                type: 20171
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 3
+                type: 20171
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 3
+                type: 20171
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20171
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20171
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 6
+                type: 20171
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 3
+                type: 20171
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 3
+                type: 20171
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 3
+                type: 20171
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 1
+                type: 20171
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 20171
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 20171
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 20171
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 82
+                num_resource: 16
+                type: 20416
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 98
+                num_resource: 16
+                type: 20416
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 114
+                num_resource: 110
+                type: 20416
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20417
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20426
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20426
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20426
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20426
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20426
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20426
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20426
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20426
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20426
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20426
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20426
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20426
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20426
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20426
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20426
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20426
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20426
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20426
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20426
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20426
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20426
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 1
+                type: 20426
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 74
+                num_resource: 2
+                type: 20426
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 76
+                num_resource: 2
+                type: 20426
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 78
+                num_resource: 2
+                type: 20426
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 20426
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20427
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20427
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20428
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20428
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20429
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20429
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20429
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20429
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20429
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20429
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20429
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20429
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20429
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20429
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20429
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20429
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20429
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20429
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20429
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20429
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20429
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20429
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20429
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20429
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20429
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20429
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 2
+                type: 20429
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 2
+                type: 20429
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20429
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 2
+                type: 20429
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 8
+                type: 20430
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 93
+                num_resource: 8
+                type: 20430
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 101
+                num_resource: 6
+                type: 20430
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 107
+                num_resource: 4
+                type: 20430
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 111
+                num_resource: 2
+                type: 20430
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 113
+                num_resource: 2
+                type: 20430
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 0
+                type: 20430
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 2
+                type: 20430
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 117
+                num_resource: 96
+                type: 20430
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 213
+                num_resource: 96
+                type: 20430
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 309
+                num_resource: 32
+                type: 20430
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20431
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20431
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20432
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20432
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 56
+                type: 20554
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 112
+                num_resource: 24
+                type: 20554
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 136
+                num_resource: 12
+                type: 20554
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 148
+                num_resource: 12
+                type: 20554
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 160
+                num_resource: 10
+                type: 20554
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 170
+                num_resource: 10
+                type: 20554
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 180
+                num_resource: 28
+                type: 20554
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 208
+                num_resource: 8
+                type: 20554
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 216
+                num_resource: 12
+                type: 20554
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 228
+                num_resource: 8
+                type: 20554
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 236
+                num_resource: 10
+                type: 20554
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 246
+                num_resource: 10
+                type: 20554
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 1536
+                num_resource: 16
+                type: 20559
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2048
+                num_resource: 16
+                type: 20560
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2560
+                num_resource: 16
+                type: 20561
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3072
+                num_resource: 32
+                type: 20562
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3584
+                num_resource: 32
+                type: 20563
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4096
+                num_resource: 32
+                type: 20564
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 2
+                type: 20928
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 4
+                type: 20928
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 4
+                type: 20928
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 4
+                type: 20928
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 4
+                type: 20928
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 4
+                type: 20928
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 16
+                type: 20928
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 4
+                type: 20928
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 4
+                type: 20928
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 47
+                num_resource: 4
+                type: 20928
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 51
+                num_resource: 3
+                type: 20928
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 2
+                type: 20928
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 20928
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 4
+                type: 20928
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20992
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 96
+                num_resource: 20
+                type: 20993
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 116
+                num_resource: 8
+                type: 20993
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 124
+                num_resource: 8
+                type: 20993
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 132
+                num_resource: 8
+                type: 20993
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 140
+                num_resource: 8
+                type: 20993
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 148
+                num_resource: 8
+                type: 20993
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 156
+                num_resource: 16
+                type: 20993
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 172
+                num_resource: 8
+                type: 20993
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 180
+                num_resource: 8
+                type: 20993
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 188
+                num_resource: 8
+                type: 20993
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 196
+                num_resource: 8
+                type: 20993
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 204
+                num_resource: 4
+                type: 20993
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 208
+                num_resource: 32
+                type: 20993
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 240
+                num_resource: 12
+                type: 20993
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 50
+                num_resource: 3
+                type: 20994
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 0
+                type: 20994
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 1
+                type: 20994
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 1
+                type: 20994
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 1
+                type: 20994
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 1
+                type: 20994
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 1
+                type: 20994
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 58
+                num_resource: 1
+                type: 20994
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 1
+                type: 20994
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 1
+                type: 20994
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 1
+                type: 20994
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 62
+                num_resource: 1
+                type: 20994
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 63
+                num_resource: 2
+                type: 20994
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 65
+                num_resource: 0
+                type: 20994
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 65
+                num_resource: 8
+                type: 20994
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20994
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 1
+                type: 20994
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 78
+                num_resource: 1
+                type: 20994
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 1
+                type: 20994
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 1
+                type: 20994
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20994
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 1
+                type: 20994
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 84
+                num_resource: 1
+                type: 20994
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 1
+                type: 20994
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 86
+                num_resource: 1
+                type: 20994
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 87
+                num_resource: 1
+                type: 20994
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 88
+                num_resource: 3
+                type: 20994
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 91
+                num_resource: 2
+                type: 20994
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 20995
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 20995
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 20995
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 20995
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 20995
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 20995
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 20995
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20995
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20995
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20995
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20995
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 20995
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 20995
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 20995
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 20995
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 20995
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 20995
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 20995
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 20995
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 20995
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 20995
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 20995
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 20995
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 20995
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 20995
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 20995
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 20995
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 20995
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 45
+                num_resource: 1
+                type: 20995
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 0
+                type: 20997
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 2
+                type: 20997
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 20999
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 20999
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 5
+                type: 21002
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21002
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 3
+                type: 21003
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 2
+                type: 21003
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 2
+                type: 21003
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 2
+                type: 21003
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 2
+                type: 21003
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 2
+                type: 21003
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 21003
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 2
+                type: 21003
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 2
+                type: 21003
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 2
+                type: 21003
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 2
+                type: 21003
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 21003
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 3
+                type: 21003
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 3
+                type: 21003
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 8
+                type: 21056
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 21056
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 8
+                type: 21056
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 68
+                num_resource: 4
+                type: 21056
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 72
+                num_resource: 4
+                type: 21056
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 76
+                num_resource: 4
+                type: 21056
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 21056
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 82
+                num_resource: 2
+                type: 21056
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 84
+                num_resource: 8
+                type: 21056
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 92
+                num_resource: 4
+                type: 21056
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 21057
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 21066
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 21066
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21066
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 21066
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 21066
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 21066
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 21066
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 21066
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 21066
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 21066
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 21066
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 21066
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 21066
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 21066
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 21066
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 21066
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 21066
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 21066
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 21066
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 21066
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 21066
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 21066
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 21066
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 21066
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 21066
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 21066
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 21066
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 21066
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 21067
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 21067
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 21069
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 21069
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21069
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 21069
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 21069
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 21069
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 21069
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 21069
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 21069
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 21069
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 21069
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 21069
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 21069
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 21069
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 21069
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 21069
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 21069
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 21069
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 21069
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 21069
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 21069
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 21069
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 21069
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 21069
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 21069
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 21069
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 21069
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 21069
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 45
+                num_resource: 1
+                type: 21069
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 21071
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 21071
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 32
+                type: 21194
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 64
+                type: 21194
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 118
+                num_resource: 4
+                type: 21194
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 122
+                num_resource: 134
+                type: 21194
+                host_id: 128
+                reserved: 0
-- 
2.34.1

