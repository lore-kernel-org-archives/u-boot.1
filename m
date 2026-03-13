Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6132A105F7AE
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B7E84347;
	Fri, 13 Mar 2026 14:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="phQDAf+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D4488432F; Fri, 13 Mar 2026 14:59:41 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC91C8433B
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfCmF6nGngNvZ1SSfBx+CwlKCVXoi3XzufJsIxmEpj7Y0mB0Cw8lUi1zNeAYLEKyzDOyFLCqV4CptUIshurnt2cgODBa8zKgQKRZ+MqtZaR98ZVScfqz9choEfR0xoNRBTNClDLT18BE4eKn06hoK+ooe/KFrHuYIo7HJL4MRi50lmzR78KD81ss4luiX/26vxDhDHdFP4chX6qL8Q7RfhMKT2DiFiFiWsMBdVFQT7ifIAi92XSlXDClnXW0ao/omOWske7WL5mWujr7MnTk0pYaLcZ3HkRitG87jxRXn+5xt7IAAJhj/ndyYYXViOGqejJMTK10bdTXmOpv5ganQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhwUdtBltXLoJzJ9GjDMeDNfxDz6X8443TbmU7zJhXs=;
 b=fRibUcyjpCljYvp4iCLpMmDLv2anJih2Lf8sK5dnGltGaMh8J4waxlgL6CG32mWkaDG6aQtti+GliFBekKTgbIrp39BYqLQiQAjwirbTn/d0pT/dyq0cETnpjcL+AQKM4X4ulhu25lf2d+Smcr7euvzctGybkWvbl4s5NBBWtJbj2OBBX30xqeuu5TcZqOKUtYTGPjjggHeIaF88c3uJ9MPV9/jsupmE1APMqQSQ2bP0kKnYhEpgb4jUmJkmc/08TPPTsbk/u4EdR31PvvpSUnL6hBEjWaFjedrFxzpVIrlBcttXTxdwhh+j31AbTVUlqUrV4AmBu5YpFeJENvapnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhwUdtBltXLoJzJ9GjDMeDNfxDz6X8443TbmU7zJhXs=;
 b=phQDAf+E2vbMJ70pzFx/rrqIaCqUhQpzTD8zQgr/Cih5snZE1RgWxXtgAbv/fNuLcYfXaqasJyZvHMa5QL4BEnCkwb6IBHQCs82JOdxMQCY60t92gBzDVz3+8asdcbZcRPaiLM8zp+jGi5UNHVAQa4lKKKqttMaSf0fEQaniVdM=
Received: from SJ2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:a03:505::24)
 by SJ2PR10MB7015.namprd10.prod.outlook.com (2603:10b6:a03:4c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 13:59:35 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::d2) by SJ2PR07CA0022.outlook.office365.com
 (2603:10b6:a03:505::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 13:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:35 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:35 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:34 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jh638000;
 Fri, 13 Mar 2026 08:59:33 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 11/19] board: ti: Update pm-boardcfg for all k3 platforms
Date: Fri, 13 Mar 2026 19:28:52 +0530
Message-ID: <20260313135900.3430264-12-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SJ2PR10MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e551fd5-7f32-402e-32dc-08de8108c2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: WE6AqmpZVpJ7WZIv1GdYGmOsnNeRm1d/r9wuMVO4t3kzpp/OS+y+Fg3CpwN/vdlUV7Bsr33bYpMSkZVEuiTktlPaJNPK/iARlNwAvumyRflKMnYoXzIvNEQIr0rAl/9vfU44PCCNK8sUhss1XlEd2DC0oq6h1xcYZZX5N+WpnrrZMwBrylXQqe/Tkc6D081VqIff07pIolQ4k3cGcq4CwVP9sSYc0pRxvnsfH9YIsQIc+4i3RpbrKcMByWXpfkkz/Tj7BgCZAJFnLikFt2qvcJ4qsoQzjKKf6XeL7SUYXFcH4WzATGj2Hy0TVeqILOKzH4kzqyMzhC+98hJn6Y5PjccP9Dnz7wXrtCpH12FFgAg7WP+lL30Oh32qxELrzlnxTs33Xce8NunoF3x6l+gTZ87Hg2EfiYfqvhhTVjiRHcOWKtUEuvl1pR4q28qf6D5cOy9/zdmb8U9ysBh2VjyUJbgm8RjeGmpiVOiPwgK8EoJA+Fh4Wd3U51vfxDqSmSrUSJh3aRr3zm+2W6yY6PvGlMoiIqQ66xgMXLMTJ6qiwu585mNkiaJYzhPsEHTSN7TKM0JMG2cVpddu8WwDDZJohZfouaLfUl6Ch0MeS9JE6/0Az40MOCmITIdLFluXq+Q/ZTKHQ6hWx/CxrmCHynrav9PsxUP807iUXSpZMMU28EQRywz3IFB2cbSN2Qf5FAvfKe/sTy+j64spPj1sqv9FzBzwGvgf2Cj1EgEfEFFkHvjVsxiFu+XjhO/N+oHIPNfXRwC5feLL7cvb1dc397t2RQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I0R0B2GLiWbU2LWqkz4SvaojS0fD8V7CiOuYlEmKDWMQqpZXku3IMAqXb4TFjJ9+E6PEBhXkACgETRT7cRNTLz5O2mZPqbZIepDz4LSxrrh2fjXaBYtINPNxINTlh3fON13j9EF1HFZfQikzKIrUFj4UM3nZSmytDXxXlltieXt/nIGQY3UGm3lBVzKWPOEDTWYGe6vK6OJRZZalw3s1XTDIoHbuFAQ/4sIGt5yMGcHN1L4uIJFOsky9vsYSYkkjADNx68TDntDUDZHjrUJQJPUt3nGpPuQyx+8vtR56+CbnIq6DEjeR6pfC82N4yf1gtaGscaQsW5NVoGqlKC+e5bNDbLQhEBH1CWdcb/u9A/QV895Ga2/jfbFHjl5GmzAwloHk5UYU1UfoD8GnJzKB37ew+ZZZVrG5wU8s566yH7d+ju2AKi1U45w0r5sT7mcw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:35.7244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e551fd5-7f32-402e-32dc-08de8108c2a6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7015
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

From: Abhash Kumar Jha <a-kumar2@ti.com>

Update the pm-cfg and schema to a new version. The new pm-boardcfg has the
following substructures

- lpm_cfg : Low Power Mode configuration

- pll_cfg : PLL configuration

- dev_cfg : Device Power configuration

- rsvd_pmic_cfg : Reserved PMIC configuration

- rsvd_cfg : Reserved cofiguration containing the size for the flexible
    array appended at the end of pm-boardcfg

The ABI revision for pm-cfg is also changed from 0:1 to 1:1

Modify the pm-cfg for am62ax, am62dx, am62px, am62x, am64x, am65x,
j721s2, j722s to change the hierarchy from "pm-cfg -> rev" to
"pm-cfg -> pm-boardcfg -> rev".

This change only adds a new 'pm-boardcfg' property as a parent of the
'rev' property, this does not affect the generated pm-cfg binary.

Add u64 type in schema and update the boardcfg script to deal with u64 types.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/schema.yaml            | 181 ++++++++++++++++++++----
 board/phytec/phycore_am62ax/pm-cfg.yaml |   7 +-
 board/ti/am62ax/pm-cfg.yaml             |   7 +-
 board/ti/am62px/pm-cfg.yaml             |   7 +-
 board/ti/am62x/pm-cfg.yaml              |   7 +-
 board/ti/am64x/pm-cfg.yaml              |   7 +-
 board/ti/am65x/pm-cfg.yaml              |   7 +-
 board/ti/j7200/pm-cfg.yaml              |  94 +++++++++++-
 board/ti/j721e/pm-cfg.yaml              |  94 +++++++++++-
 board/ti/j721s2/pm-cfg.yaml             |   7 +-
 board/ti/j722s/pm-cfg.yaml              |   7 +-
 board/ti/j784s4/pm-cfg.yaml             |  94 +++++++++++-
 tools/binman/etype/ti_board_config.py   |   4 +-
 13 files changed, 461 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-k3/schema.yaml b/arch/arm/mach-k3/schema.yaml
index 8c4691f24ed..dbd11b6c864 100644
--- a/arch/arm/mach-k3/schema.yaml
+++ b/arch/arm/mach-k3/schema.yaml
@@ -19,21 +19,15 @@ definitions:
         type: integer
         minimum: 0
         maximum: 0xffffffff
+    u64:
+        type: integer
+        minimum: 0
+        maximum: 0xffffffffffffffff
 
 
 
 type: object
 properties:
-    pm-cfg:
-        type: object
-        properties:
-            rev:
-                type: object
-                properties:
-                    boardcfg_abi_maj:
-                        $ref: "#/definitions/u8"
-                    boardcfg_abi_min:
-                        $ref: "#/definitions/u8"
     board-cfg:
         type: object
         properties:
@@ -283,10 +277,10 @@ properties:
                         items:
                             $ref: "#/definitions/u8"
 
-    rm-cfg:
+    pm-cfg:
         type: object
         properties:
-            rm_boardcfg:
+            pm_boardcfg:
                 type: object
                 properties:
                     rev:
@@ -297,7 +291,7 @@ properties:
                             boardcfg_abi_min:
                                 $ref: "#/definitions/u8"
 
-                    host_cfg:
+                    lpm_cfg:
                         type: object
                         properties:
                             subhdr:
@@ -307,25 +301,156 @@ properties:
                                         $ref: "#/definitions/u16"
                                     size:
                                         $ref: "#/definitions/u16"
-                            host_cfg_entries:
-                                type: array
-                                minItems: 0
-                                maxItems: 32
-                                items:
+                            suspend_initiator:
+                                $ref: "#/definitions/u8"
+                            lpm_mode:
+                                $ref: "#/definitions/u8"
+                            lpm_rsvd1:
+                                $ref: "#/definitions/u16"
+                            lpm_rsvd2:
+                                $ref: "#/definitions/u32"
+
+                    pll_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            pll_cfg_entries:
+                                        type: array
+                                        minItems: 0
+                                        maxItems: 5
+                                        items:
+                                            type: object
+                                            properties:
+                                                dev_id:
+                                                    $ref: "#/definitions/u32"
+                                                clk_id:
+                                                    $ref: "#/definitions/u32"
+                                                pll_freq:
+                                                    $ref: "#/definitions/u64"
+                    dev_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            dev_cfg_entries:
+                                        type: array
+                                        minItems: 0
+                                        maxItems: 5
+                                        items:
+                                            type: object
+                                            properties:
+                                                dev_id:
+                                                    $ref: "#/definitions/u32"
+                                                state:
+                                                    $ref: "#/definitions/u32"
+                                                flag:
+                                                    $ref: "#/definitions/u32"
+                    rsvd_pmic_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            pmic_rsvd1:
+                                $ref: "#/definitions/u32"
+                            pmic_rsvd2:
+                                $ref: "#/definitions/u32"
+                            pmic_rsvd3:
+                                $ref: "#/definitions/u32"
+                    rsvd_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            rsvd1:
+                                $ref: "#/definitions/u32"
+                            rsvd2:
+                                $ref: "#/definitions/u32"
+                            rsvd3:
+                                $ref: "#/definitions/u32"
+                            reserved_entry_size:
+                                $ref: "#/definitions/u16"
+
+            reserved_entries:
+                type: array
+                minItems: 0
+                maxItems: 2
+                items:
+                    type: object
+                    properties:
+                        reserved1:
+                            $ref: "#/definitions/u16"
+                        reserved2:
+                            $ref: "#/definitions/u16"
+                        reserved3:
+                            $ref: "#/definitions/u16"
+                        reserved4:
+                            $ref: "#/definitions/u8"
+                        reserved5:
+                            $ref: "#/definitions/u8"
+
+    rm-cfg:
+        type: object
+        properties:
+            rm_boardcfg:
+                type: object
+                properties:
+                    rev:
+                        type: object
+                        properties:
+                            boardcfg_abi_maj:
+                                $ref: "#/definitions/u8"
+                            boardcfg_abi_min:
+                                $ref: "#/definitions/u8"
+                    host_cfg:
+                            type: object
+                            properties:
+                                subhdr:
                                     type: object
                                     properties:
-                                        host_id:
-                                            $ref: "#/definitions/u8"
-                                        allowed_atype:
-                                            $ref: "#/definitions/u8"
-                                        allowed_qos:
+                                        magic:
                                             $ref: "#/definitions/u16"
-                                        allowed_orderid:
-                                            $ref: "#/definitions/u32"
-                                        allowed_priority:
+                                        size:
                                             $ref: "#/definitions/u16"
-                                        allowed_sched_priority:
-                                            $ref: "#/definitions/u8"
+                                host_cfg_entries:
+                                    type: array
+                                    minItems: 0
+                                    maxItems: 32
+                                    items:
+                                        type: object
+                                        properties:
+                                            host_id:
+                                                $ref: "#/definitions/u8"
+                                            allowed_atype:
+                                                $ref: "#/definitions/u8"
+                                            allowed_qos:
+                                                $ref: "#/definitions/u16"
+                                            allowed_orderid:
+                                                $ref: "#/definitions/u32"
+                                            allowed_priority:
+                                                $ref: "#/definitions/u16"
+                                            allowed_sched_priority:
+                                                $ref: "#/definitions/u8"
                     resasg:
                         type: object
                         properties:
diff --git a/board/phytec/phycore_am62ax/pm-cfg.yaml b/board/phytec/phycore_am62ax/pm-cfg.yaml
index 4031af2f4d3..5a8ed081118 100644
--- a/board/phytec/phycore_am62ax/pm-cfg.yaml
+++ b/board/phytec/phycore_am62ax/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+        pm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x0
+                        boardcfg_abi_min: 0x1
diff --git a/board/ti/am62ax/pm-cfg.yaml b/board/ti/am62ax/pm-cfg.yaml
index 4031af2f4d3..5a8ed081118 100644
--- a/board/ti/am62ax/pm-cfg.yaml
+++ b/board/ti/am62ax/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+        pm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x0
+                        boardcfg_abi_min: 0x1
diff --git a/board/ti/am62px/pm-cfg.yaml b/board/ti/am62px/pm-cfg.yaml
index 3ff27ce702c..e24668f0c32 100644
--- a/board/ti/am62px/pm-cfg.yaml
+++ b/board/ti/am62px/pm-cfg.yaml
@@ -7,6 +7,7 @@
 #
 ---
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+        pm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x0
+                        boardcfg_abi_min: 0x1
diff --git a/board/ti/am62x/pm-cfg.yaml b/board/ti/am62x/pm-cfg.yaml
index 9853a25eb85..6657504a5e5 100644
--- a/board/ti/am62x/pm-cfg.yaml
+++ b/board/ti/am62x/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+        pm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x0
+                        boardcfg_abi_min: 0x1
diff --git a/board/ti/am64x/pm-cfg.yaml b/board/ti/am64x/pm-cfg.yaml
index 7afb2962108..6ed7736154b 100644
--- a/board/ti/am64x/pm-cfg.yaml
+++ b/board/ti/am64x/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-        rev:
-                boardcfg_abi_maj: 0x0
-                boardcfg_abi_min: 0x1
+        pm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x0
+                        boardcfg_abi_min: 0x1
diff --git a/board/ti/am65x/pm-cfg.yaml b/board/ti/am65x/pm-cfg.yaml
index ee0d1c67a71..561eaf014aa 100644
--- a/board/ti/am65x/pm-cfg.yaml
+++ b/board/ti/am65x/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+        pm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x0
+                        boardcfg_abi_min: 0x1
diff --git a/board/ti/j7200/pm-cfg.yaml b/board/ti/j7200/pm-cfg.yaml
index 85cd2c9dbca..920d2024f23 100644
--- a/board/ti/j7200/pm-cfg.yaml
+++ b/board/ti/j7200/pm-cfg.yaml
@@ -7,6 +7,94 @@
 ---
 
 pm-cfg:
-        rev:
-                boardcfg_abi_maj: 0x0
-                boardcfg_abi_min: 0x1
+        pm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x1
+                        boardcfg_abi_min: 0x1
+                lpm_cfg:
+                        subhdr:
+                                magic: 0x4C41
+                                size: 0x0C
+                        suspend_initiator: 0xA
+                        lpm_mode: 0x5
+                        lpm_rsvd1: 0x0
+                        lpm_rsvd2: 0x0
+                pll_cfg:
+                        subhdr:
+                                magic: 0xC31E
+                                size: 0x54
+                        pll_cfg_entries:
+                                -  # 1
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 2
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 3
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 4
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 5
+                                        dev_id: 0x6
+                                        clk_id: 0x7
+                                        pll_freq: 0x8
+                dev_cfg:
+                        subhdr:
+                                magic: 0x74B1
+                                size: 0x40
+                        dev_cfg_entries:
+                                -  # 1
+                                        dev_id: 0xB
+                                        state: 0xD
+                                        flag: 0xE
+                                -  # 2
+                                        dev_id: 0xCC
+                                        state: 0xA
+                                        flag: 0xA
+                                -  # 3
+                                        dev_id: 0xA
+                                        state: 0xA
+                                        flag: 0xA
+                                -  # 4
+                                        dev_id: 0xCC
+                                        state: 0xA
+                                        flag: 0xA
+                                -  # 5
+                                        dev_id: 0xA
+                                        state: 0xA
+                                        flag: 0xCC
+                rsvd_pmic_cfg:
+                        subhdr:
+                                magic: 0x8A1D
+                                size: 0x10
+                        pmic_rsvd1: 0xA
+                        pmic_rsvd2: 0xA
+                        pmic_rsvd3: 0xDD
+                rsvd_cfg:
+                        subhdr:
+                                magic: 0x3CFA
+                                size: 0x12
+                        rsvd1: 0x0
+                        rsvd2: 0x0
+                        rsvd3: 0x0
+                        reserved_entry_size: 0x10
+
+        reserved_entries:
+                -
+                        reserved1: 4
+                        reserved2: 93
+                        reserved3: 77
+                        reserved4: 26
+                        reserved5: 0
+                -
+                        reserved1: 4
+                        reserved2: 93
+                        reserved3: 77
+                        reserved4: 26
+                        reserved5: 0
diff --git a/board/ti/j721e/pm-cfg.yaml b/board/ti/j721e/pm-cfg.yaml
index 7ae52b3358e..87e2a22373e 100644
--- a/board/ti/j721e/pm-cfg.yaml
+++ b/board/ti/j721e/pm-cfg.yaml
@@ -7,6 +7,94 @@
 ---
 
 pm-cfg:
-        rev:
-                boardcfg_abi_maj: 0x0
-                boardcfg_abi_min: 0x1
+        pm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x1
+                        boardcfg_abi_min: 0x1
+                lpm_cfg:
+                        subhdr:
+                                magic: 0x4C41
+                                size: 0x0C
+                        suspend_initiator: 0xA
+                        lpm_mode: 0x5
+                        lpm_rsvd1: 0x0
+                        lpm_rsvd2: 0x0
+                pll_cfg:
+                        subhdr:
+                                magic: 0xC31E
+                                size: 0x54
+                        pll_cfg_entries:
+                                -  # 1
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 2
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 3
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 4
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 5
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                dev_cfg:
+                        subhdr:
+                                magic: 0x74B1
+                                size: 0x40
+                        dev_cfg_entries:
+                                -  # 1
+                                        dev_id: 0xA
+                                        state: 0xA
+                                        flag: 0xA
+                                -  # 2
+                                        dev_id: 0xA
+                                        state: 0xA
+                                        flag: 0xA
+                                -  # 3
+                                        dev_id: 0xA
+                                        state: 0xA
+                                        flag: 0xA
+                                -  # 4
+                                        dev_id: 0xA
+                                        state: 0xA
+                                        flag: 0xA
+                                -  # 5
+                                        dev_id: 0xA
+                                        state: 0xA
+                                        flag: 0xA
+                rsvd_pmic_cfg:
+                        subhdr:
+                                magic: 0x8A1D
+                                size: 0x10
+                        pmic_rsvd1: 0xA
+                        pmic_rsvd2: 0xA
+                        pmic_rsvd3: 0xA
+                rsvd_cfg:
+                        subhdr:
+                                magic: 0x3CFA
+                                size: 0x12
+                        rsvd1: 0x0
+                        rsvd2: 0x0
+                        rsvd3: 0x0
+                        reserved_entry_size: 0x10
+
+        reserved_entries:
+                -
+                        reserved1: 4
+                        reserved2: 93
+                        reserved3: 7744
+                        reserved4: 26
+                        reserved5: 0
+                -
+                        reserved1: 4
+                        reserved2: 93
+                        reserved3: 7744
+                        reserved4: 26
+                        reserved5: 0
diff --git a/board/ti/j721s2/pm-cfg.yaml b/board/ti/j721s2/pm-cfg.yaml
index e6496512b6b..ba4aa643798 100644
--- a/board/ti/j721s2/pm-cfg.yaml
+++ b/board/ti/j721s2/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+        pm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x0
+                        boardcfg_abi_min: 0x1
diff --git a/board/ti/j722s/pm-cfg.yaml b/board/ti/j722s/pm-cfg.yaml
index 46b3ad20109..b62657160e7 100644
--- a/board/ti/j722s/pm-cfg.yaml
+++ b/board/ti/j722s/pm-cfg.yaml
@@ -7,6 +7,7 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+        pm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x0
+                        boardcfg_abi_min: 0x1
diff --git a/board/ti/j784s4/pm-cfg.yaml b/board/ti/j784s4/pm-cfg.yaml
index a36b8609899..ce72969717d 100644
--- a/board/ti/j784s4/pm-cfg.yaml
+++ b/board/ti/j784s4/pm-cfg.yaml
@@ -8,6 +8,94 @@
 ---
 
 pm-cfg:
-    rev:
-        boardcfg_abi_maj: 0x0
-        boardcfg_abi_min: 0x1
+        pm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x1
+                        boardcfg_abi_min: 0x1
+                lpm_cfg:
+                        subhdr:
+                                magic: 0x4C41
+                                size: 0x0C
+                        suspend_initiator: 0xA
+                        lpm_mode: 0x5
+                        lpm_rsvd1: 0x0
+                        lpm_rsvd2: 0x0
+                pll_cfg:
+                        subhdr:
+                                magic: 0xC31E
+                                size: 0x54
+                        pll_cfg_entries:
+                                -  # 1
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 2
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 3
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 4
+                                        dev_id: 0xA
+                                        clk_id: 0xA
+                                        pll_freq: 0xA
+                                -  # 5
+                                        dev_id: 0x6
+                                        clk_id: 0x7
+                                        pll_freq: 0x8
+                dev_cfg:
+                        subhdr:
+                                magic: 0x74B1
+                                size: 0x40
+                        dev_cfg_entries:
+                                -  # 1
+                                        dev_id: 0xB
+                                        state: 0xD
+                                        flag: 0xE
+                                -  # 2
+                                        dev_id: 0xCC
+                                        state: 0xA
+                                        flag: 0xA
+                                -  # 3
+                                        dev_id: 0xA
+                                        state: 0xA
+                                        flag: 0xA
+                                -  # 4
+                                        dev_id: 0xCC
+                                        state: 0xA
+                                        flag: 0xA
+                                -  # 5
+                                        dev_id: 0xA
+                                        state: 0xA
+                                        flag: 0xCC
+                rsvd_pmic_cfg:
+                        subhdr:
+                                magic: 0x8A1D
+                                size: 0x10
+                        pmic_rsvd1: 0xA
+                        pmic_rsvd2: 0xA
+                        pmic_rsvd3: 0xDD
+                rsvd_cfg:
+                        subhdr:
+                                magic: 0x3CFA
+                                size: 0x12
+                        rsvd1: 0x0
+                        rsvd2: 0x0
+                        rsvd3: 0x0
+                        reserved_entry_size: 0x10
+
+        reserved_entries:
+                -
+                        reserved1: 4
+                        reserved2: 93
+                        reserved3: 77
+                        reserved4: 26
+                        reserved5: 0
+                -
+                        reserved1: 4
+                        reserved2: 93
+                        reserved3: 77
+                        reserved4: 26
+                        reserved5: 0
diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
index 7c6773ac7bc..b0cd055bf53 100644
--- a/tools/binman/etype/ti_board_config.py
+++ b/tools/binman/etype/ti_board_config.py
@@ -124,8 +124,10 @@ class Entry_ti_board_config(Entry_section):
             size = 1
         elif (data_type == '#/definitions/u16'):
             size = 2
-        else:
+        elif (data_type == '#/definitions/u32'):
             size = 4
+        else:
+            size = 8
         br = None
         if type(val) == int:
             br = val.to_bytes(size, byteorder='little')
-- 
2.34.1

