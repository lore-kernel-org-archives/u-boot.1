Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584C0FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA7B384154;
	Sat, 25 Apr 2026 19:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hAZ9duNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7744843FB; Sat, 25 Apr 2026 19:12:41 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3324B84105
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from SA2PR10MB4476.namprd10.prod.outlook.com (2603:10b6:806:f9::16)
 by CH5PR10MB997742.namprd10.prod.outlook.com (2603:10b6:610:2f2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 14:39:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdTQn7anJtZG94MkBDkWpwVVIXToQ7r4HKW2NzylRFZcfDhGBcpmrj0WxKxISZrVioHX/W8NlKabxGEJIZKxB8FG513/YHAyRJnND5g5c6RaZXqn2ulNyTn1/5Dl6JH04giUVbIwSgzbJE45XvsA/r6LijI39UVIs1ILwRpV4XhEQFke9WGXw7YSHRq6/zdry2OXu5ozVI9Z3TNfuYETayu+C/ttjZNX6v+N0SmvfwSceIfioB8KgFflxkMZyOKY1q84GTjZd5/AzCGGjAOz+lgnpG09ciDMsUKyqnHpK0zlpgFMc+QBN19WCJ/mfSZTtpcf5rApgBl7QF/EwGGwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6CH7WGMrg1qJmzhHtfF5DDcMLRNgB6Rt3exsP3WKfo=;
 b=SDJL2D+eh8HvizWts2HskVbItAPtUH4iFWetmGRzCCe4pWnwz0diLzOpoRFWOEV4qdcoEPNwSz/BW02iIiTh1DXouayoM297DZswo38V7sW8BKTGCkS/l6FOlK7YXnaSv8e8jDktZi6iSkSt9n71uUhm9FdD67CrdhnWZOhx+L3tROIWEl1A4zD1RvSBtm7SHojSCkSJDbL5bedOFtokCEvN4HiG9CwPrHSxRzGna5yu8u21AuP0gba+25D4jDuHhDxX2KVId94crC+dnAICjeDk9mAHgPymUBdZGvEE0RRvDR0EDZ1P45LXP0NW5/I7gvxFrKs7xm6M3OMmk8+g0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6CH7WGMrg1qJmzhHtfF5DDcMLRNgB6Rt3exsP3WKfo=;
 b=hAZ9duNytpksxrUKuTYgf7NdaE/BtBp3qQZ6lznop530oQDm9bKppbhMDPmIABw7NdoLw8PIwaBaC849MW8rZf5x5ISk3Z/v0E8EIBI8yJFUd6hgPJFb3w//dCP6H4iWhb86UVWe3zLbet9WXQl2rcRPvym485JxHuDSI1oAPXI=
Received: from SN6PR01CA0010.prod.exchangelabs.com (2603:10b6:805:b6::23) by
 SA2PR10MB4476.namprd10.prod.outlook.com (2603:10b6:806:f9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.21; Sat, 25 Apr 2026 03:38:25 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::d0) by SN6PR01CA0010.outlook.office365.com
 (2603:10b6:805:b6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Sat,
 25 Apr 2026 03:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 03:38:25 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:24 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:38:24 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk882903263; Fri, 24 Apr 2026 22:38:21 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 09/11] arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable
 HSM core
Date: Sat, 25 Apr 2026 09:07:40 +0530
Message-ID: <20260425033742.1519298-10-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SA2PR10MB4476:EE_|CH5PR10MB997742:EE_
X-MS-Office365-Filtering-Correlation-Id: 6caa2331-9b11-4ee4-3573-08dea27c1b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z/3zZsuyUj6elBPMWAWeuy2EIoAzNS9Ac59S5sSIK2yz2XXdHhE+DgreWPROsC13oY468nsDI3Yo7vKg4pwhcSdbTrnE+1QQDS/PqyUrabnuvgBFMw4H5G/wqwW5BQwMatPQ1qbC0G/Ty+21j3q/qxr1hSp5Q8UA09QfAuJ75rkqamyzEOih3vpVht8sleR7IrhfpvWv5AoFKVjIuJ/AsQeG/uX/hWTG9M776CTt/ARM79jCitePGJJwHGUGJlgIZwYmxyj0nBG8Z8uMYo25FJGUGMygyN7P4p8TgL4ir8ZKnf1d8i4iMSrW85RQmecHs/u6UjamrrNxnrr+yLvV67SJFzxLZyt8+OnSOWPstCB3MknaLpwKSeWgiY/JRP+cmrWGb/YhHnj/hzwYKVSoqVhYfEZdZriYXDhX67aY0E5vLxscuFdAteeQPYMlRnMqYtY1Fx2fH0ZRYReswGS2wqWl+X1zT8cAB/mINrd9JAlfIa+Clbojh0LMfTeLj1sYMjrL9KBomhI2HU8Tp0j8p4OlpwpKg+C66D52IOoL1ZUdDRevmPrSKRh2LspVENXX+Yb0k0DvGL+IwS849u1y+CYlys5rr9cuR5N5tZQaPdTUaBryZ0gcBRaIDDBExOdrSV8edhyS/Or/B//gvV+VWQ8pNnOJgGYDtPSw34/hS/mj60qAUvRYK9ATcMrkQFXfMvQRZgF914eAWm49YJerif2fleFPwUMGJmiyURdANRkiI8LdAksPqDWCd93XNHuvncSqrhZW9IJ1V6LgtdZXJw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jvOD+mjA8iTVf/CompiAxgXnJqwmlcHIBvbmlZ+fnxMkUve4HoZ30aNe0kcoaT0kmRu+MCmVNDWhgNt3pPOkA0U8KlxFQNEnpuTR2Z9a8u0pffMaizIdcMigYCLB/+nIoeSxxjsbop/ZSWa5tSWDUnkSz9RrGypLZotUVu4cDLjAiBInx35e6968HlADCZd6WakjUMPqF3p7k04HBwufPo3Bo6j/RIce+MdUHc+mMLdtDrR2cZ9J20kp/jR8xjnW7ARSY+gSicyO7PpqIIna4LAgdA/6gZ9s7RHtacAhzV4/zh1XTQRYh+pCXTwfiKZOc3qaw2MowsbE9Nu9HIUxGCcp/l7yva9KCDu31mdMi6U/41xxO7h/EaEMWNjn1IRCoxACPE9j8P200Wr0LHtXuw9mWPnuLrRHdh0DdqoXdDfrEynBABnvJqkOtRh3g4o+
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:38:25.2038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6caa2331-9b11-4ee4-3573-08dea27c1b64
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4476
X-OriginatorOrg: ti.com
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

The HSM M4F node is disabled by default in the device tree. Enable the
node here as we have to load and boot the core in R5 SPL stage. Assign
the alias of 'remoteproc2' to the hsm node. This assigns the sequence
number '2' to HSM core which can be used during rproc_load() and
rproc_start() calls.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v4: Changelog:
1. Changed node labels from 'hsm_m4fss' to 'hsm' to match with device
   tree definition.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-9-b-padhi@ti.com/

v3: Changelog:
1. New patch. Enable HSM nodes from DT.

 arch/arm/dts/k3-j721s2-r5.dtsi | 5 +++++
 arch/arm/dts/k3-j722s-r5.dtsi  | 5 +++++
 arch/arm/dts/k3-j784s4-r5.dtsi | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
index 7d4a6dc5301..cba7bbb7c2d 100644
--- a/arch/arm/dts/k3-j721s2-r5.dtsi
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -11,6 +11,7 @@
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
+		remoteproc2 = &hsm;
 	};
 
 	a72_0: a72@0 {
@@ -102,3 +103,7 @@
 	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
 			 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
 };
+
+&hsm {
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-j722s-r5.dtsi b/arch/arm/dts/k3-j722s-r5.dtsi
index 06a63fb83ba..2133a083871 100644
--- a/arch/arm/dts/k3-j722s-r5.dtsi
+++ b/arch/arm/dts/k3-j722s-r5.dtsi
@@ -7,6 +7,7 @@
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
+		remoteproc2 = &hsm;
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
 	};
@@ -82,3 +83,7 @@
 	reg = <0x00 0x0fc40000 0x00 0x100>,
 	      <0x00 0x60000000 0x00 0x08000000>;
 };
+
+&hsm {
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-j784s4-r5.dtsi b/arch/arm/dts/k3-j784s4-r5.dtsi
index 78444dc4e14..ccdea7ab5b8 100644
--- a/arch/arm/dts/k3-j784s4-r5.dtsi
+++ b/arch/arm/dts/k3-j784s4-r5.dtsi
@@ -11,6 +11,7 @@
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
+		remoteproc2 = &hsm;
 	};
 
 	a72_0: a72@0 {
@@ -113,3 +114,6 @@
 	vdd-supply-2 = <&tps62873a>;
 };
 
+&hsm {
+	status = "okay";
+};
-- 
2.34.1

