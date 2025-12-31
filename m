Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3981EEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EEA984137;
	Wed, 31 Dec 2025 18:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oWn2etLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E63A884133; Wed, 31 Dec 2025 18:37:06 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E9184127
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFgn+PxXn0FAS42fnjmn171AiZOMgC/loOZOXS9jSqSkSmH2l6o5g/NQxvih6pM1F7JTjulA/c2wkjtmbp4xgWrBdfp40yfvM9a2zhBNrTIuOlHaphWM7PP6yp0VGox/i+EMGxZ9LVwTlkjNacyO38FyPcpWMqwnIVH3Fh8F2ElMpLQjPV67iTf+NRB+hOk/X2q4WDXtFTHlK3tqWZFAlRoq6lbCGKKKFWfvBfToJT6fetWJ+sOqIswQAq32vnMq77sPxlqXV5sQePDgfPVD/3AcrnwawVh6fLcMr50w20RTIu+zyEjCusoLIFxxsGd0qx/AdLf5paN9ZRN6WkL85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE4m8WG4k+o4A6z+DqCCZ2+dklb1F31Irr5nQWgAJcY=;
 b=Y/Z4f/zUawyVmAwo/qiXtpdpMN+FzFSQjwphG4r5acY+Q2qofCHWmr9H0Se5D2/PC3dR15LRJrIPaP7ILTc50q6J8X27c+dVWxsKP37fEQ47FaoJxoEbwE8DNhdXkaDH3/P6LFrbqPOsvtvWvngsMEO9TBlum0rmLlrH06TUUJi7Mz4DIxLUCqNDRYfVyo7UtrJyZmofLXy9kB/9I/aNskK/roB2CjJe1fixQmMXVETu3nbwWXvUFdO+0G4w50dK0KdoPmoCZ3dhBrPEO5VRF6yshDpI5ZA49CUITy3oCiiTIu7e+SI+jg0WgqvPDWlo3wYJlfiChV/9gJINdGgWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE4m8WG4k+o4A6z+DqCCZ2+dklb1F31Irr5nQWgAJcY=;
 b=oWn2etLg6RAl1vb0hZIckNIwSNj1FsFf4S1dJ9wa5z0GIDdv6ZT+Al0TWlUgmmb+dAc0dP89e6DCKCR/I5NZdTXNiwGpYFmYQ4NDEphflv1qQBykhi6DLn7kfn1TSCOdWfJCTIXOhA9vQlWXPuDDDhp1F8QaB5r6h30sZVHGTA0=
Received: from BN9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::9)
 by PH7PR10MB6334.namprd10.prod.outlook.com (2603:10b6:510:1b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 31 Dec
 2025 17:37:01 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::ab) by BN9P223CA0004.outlook.office365.com
 (2603:10b6:408:10b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 17:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:37:01 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:56 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:56 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:36:56 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOqx2541396;
 Wed, 31 Dec 2025 11:36:53 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 08/11] arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable
 HSM core
Date: Wed, 31 Dec 2025 23:06:18 +0530
Message-ID: <20251231173621.1069988-9-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251231173621.1069988-1-b-padhi@ti.com>
References: <20251231173621.1069988-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|PH7PR10MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9b77a6-9ae3-4646-68b5-08de48933485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CSFfeWNjEXPobGwBUtfi2MSbuuvHKc6fuMCS5WNNz3wk62+lH9Qjb0eZFgV0?=
 =?us-ascii?Q?XTyJK43rq3zOUm8ltonft71jASKm750ljG+tOCnhyCoZjlgM/ZxgagR6ZZg6?=
 =?us-ascii?Q?PksoyDBsLZMQWV4xBgBKKU2I2iBjYY4bV/YpPZdTHmODrAUZaY3xDAhaz+OD?=
 =?us-ascii?Q?ODuh+R0jjIXb0ejSobsfKPCPsA6qK2XCwYceN6yPyM3rZ4Nv6ta1Wmufq4ie?=
 =?us-ascii?Q?BsUjZJcNwmyd0OX7Llx9AMYkMDqTN3i3ggJIoV/2wMwcl1L+jdIsW3eSvcO5?=
 =?us-ascii?Q?DtVsENXafqgGV2X477/OaxG5oxbYACSt0zmsyipUEkwOp7bx2CIJaHjZyXb4?=
 =?us-ascii?Q?I2j2oIq8hNZp5/NAYC2cVZ0HURWVN9R+MnFsEpAY2/61lt3Gpz8dkPAdfyWA?=
 =?us-ascii?Q?TzmEwzT3dspgUEQftxkZ7KnArrvHvrLOdTOKHTAFILiEcMouoi5D34K8xzty?=
 =?us-ascii?Q?MbFJOhGBTLuyieNWBtpBE47i0u3Pl36y++fJ1TCMAnuHFp8rhnPOFtXajh8z?=
 =?us-ascii?Q?YLYt0k0stpZZwSM6oFSRTb7so6T52Jrzl7uQQ5rcKxseKyzopxxW314zCeMF?=
 =?us-ascii?Q?EOCXLXQuRLxprB7At1rrKzku2+qjtGA5szjtlFJw+e7HLxGpJiySjCLMQsfx?=
 =?us-ascii?Q?U4nimZFBfoLbWqJYWoBicRfN1NRv4kaNGWIoORFSf4O2dhqwO16bwMYLADHm?=
 =?us-ascii?Q?P7r5/I73iCAxrqNyqVkcdyjPe+RwsudzVnH7NltMqpWEHxHSiLeQ0AKmF3ua?=
 =?us-ascii?Q?9AwPhGddt0++LtombSi6qyBIO8XLHoRtJU3NHP4S7jp+NJ6t7g4tVSwV/DMs?=
 =?us-ascii?Q?OQU/aMEAJwwfJPr0gRsnS0yjtw8YY9Wa/O+ENJIrYz++di1RfTnrknVTPMJB?=
 =?us-ascii?Q?wvtNhO2i4OISr5eueWWBR5Qe4eCzZdPDeNyKRn3jIICDWf4Am2zIF8DLkp45?=
 =?us-ascii?Q?zfSCm+Nb08H5WDurlD2t+tuUo0l1bhmVFSOG8c43g1alANU4VdDrAKkECVyr?=
 =?us-ascii?Q?GNAO45phCY4qP0OFxR7R7/gWg0n2JRWtL5nNkREQ+2sRkaMlEP2jbS26rMHu?=
 =?us-ascii?Q?6G0EdefU6ACiXvW5z7GfNPkTzdhBSGrhaqyItVZQP5jqHcLlS7MnsNk6AoQA?=
 =?us-ascii?Q?osSTeukaiTd+92SsF7tqjMXMCB1psldSUcew8CYc5YFyRYcAsOq2KAM7WX9C?=
 =?us-ascii?Q?ocv8b6SAOI7Xf9DK+SMkqV44pnue1RCgpwjl5tLYjhedeY5UDkn7OC56GHHh?=
 =?us-ascii?Q?KVfmimWQfZMAd2j8vDxGJ9nzAksEpIE7G9ZmbAVTs6OlU3AmJxb2ZTQeQrM+?=
 =?us-ascii?Q?QLu0bldMtBbN7jNEhooIe2A6nnnxL2nLi1TYE7k95n163e94I8h+awSoizVj?=
 =?us-ascii?Q?oT0A5KFpKvU9XeSUqsofWYb8YtmaAERMAjNQLZ0cs+MayyNbVY1C6D2JLq+0?=
 =?us-ascii?Q?b9deBLz/qMOxSUyJ+6OzO/Ls75B1JVf74kG2RDtM4nZLfZWGQE7jezohGOQ9?=
 =?us-ascii?Q?6e9p31HWoh1a+SdBildTdf0B8XD+pBEwdVS02f8QT6giN5RkGlwjapMEofgy?=
 =?us-ascii?Q?FCBiCF4lQ5sxK3H6w/I=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:37:01.0506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9b77a6-9ae3-4646-68b5-08de48933485
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6334
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
v3: Changelog:
1. New patch. Enable HSM nodes from DT.

 arch/arm/dts/k3-j721s2-r5.dtsi   | 5 +++++
 arch/arm/dts/k3-j722s-r5-evm.dts | 5 +++++
 arch/arm/dts/k3-j784s4-r5.dtsi   | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
index c1c12e217d2..141a748bc76 100644
--- a/arch/arm/dts/k3-j721s2-r5.dtsi
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -11,6 +11,7 @@
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
+		remoteproc2 = &hsm_m4fss;
 	};
 
 	a72_0: a72@0 {
@@ -97,3 +98,7 @@
 	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
 			 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
 };
+
+&hsm_m4fss {
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
index 02a3494a877..3f3f17af83b 100644
--- a/arch/arm/dts/k3-j722s-r5-evm.dts
+++ b/arch/arm/dts/k3-j722s-r5-evm.dts
@@ -14,6 +14,7 @@
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a53_0;
+		remoteproc2 = &hsm_m4fss;
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
 	};
@@ -102,3 +103,7 @@
 &main_pktdma {
 	ti,sci = <&dm_tifs>;
 };
+
+&hsm_m4fss {
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-j784s4-r5.dtsi b/arch/arm/dts/k3-j784s4-r5.dtsi
index 78444dc4e14..34fd2fc2fee 100644
--- a/arch/arm/dts/k3-j784s4-r5.dtsi
+++ b/arch/arm/dts/k3-j784s4-r5.dtsi
@@ -11,6 +11,7 @@
 	aliases {
 		remoteproc0 = &sysctrler;
 		remoteproc1 = &a72_0;
+		remoteproc2 = &hsm_m4fss;
 	};
 
 	a72_0: a72@0 {
@@ -113,3 +114,6 @@
 	vdd-supply-2 = <&tps62873a>;
 };
 
+&hsm_m4fss {
+	status = "okay";
+};
-- 
2.34.1

