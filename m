Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A619CCF9FE
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6ACF83885;
	Thu, 30 Oct 2025 14:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vBgm8z+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 847F0838AE; Thu, 30 Oct 2025 14:05:21 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 220F483710
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 14:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykH0Fl1AK70VcfZTOAjvbtBJrVroA6S8T71biIRsLdP4XEglkNaP6itr9I0eFm48NKu7kMy9Jl7AHDiDLme1fOi2nyTENEEQvojGHX11r9Kx1xHi+nySJvr9VFt3WKiVLdOf4NM1hTG35sYjhcpb3GcIRLbCvd3ZDe3ajlWUpQUmfa+1BDVcEDbRPexHcq4bh69cEMyzmKH1ELGx88rzIyi1FaULP+1y/cPbAqYmTA9b9C3yeha5ws8gYQHyXtX4K0sYubBH97VLfsW/dNGJRbDlusHwTPLoWEzb7OmzmT7yXEdnK6DYaR0rOS52FMqxUv3OHd13ZjQIfpou6o4qAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLy2svBfXdG9Ut736Fy+MZ4o5QPnVscLvorX/CxHFBw=;
 b=gycazk/ToXl0itVl9Lf27fp1qdsCz+EiMYxLHiqxfoMUhvYWCALBUOpD4XpjCzmHjVHi0wTIv/b1cnrxgxxKqDXBxngsr6M9UnmOKvkWZR/O7Hkt8bF0brnY3TC2jph5DrOgmPWdWZSwfZVk/+EAJ+Rs4T/UEhXthGqClG4kdD1n7gpHQ8VtArewbxIXdRn2nkAchKU1MnENw2k+FU6uSggfjrpfMaDV4AK0N19gxFILKYfMT405CbpF6K/yXq3PJ0xr/UogMCzoxMxpH8tVmhqJd6sKkgUzsr4Sbp51JCoZyPfV/EhaLZz26xQEqFcVFdgOWY9R7XfWpeOrwr+aEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLy2svBfXdG9Ut736Fy+MZ4o5QPnVscLvorX/CxHFBw=;
 b=vBgm8z+on1u0w+XxHupmuRoOiKDdqEGv5sWljwYE7Lef4pO9Zc7oLLkEdBdS1cazOoJ4VY8ZrXh1Z+ZSdVBNRZofcvpc73RhaMylbp47biaBmpDAB6ZppAjxCyf55sCAIDKF2vsUjY4XL4atjhrEdXsIWUgp96/26lCJw6muIs4=
Received: from DS0PR17CA0015.namprd17.prod.outlook.com (2603:10b6:8:191::23)
 by MW4PR10MB5882.namprd10.prod.outlook.com (2603:10b6:303:18f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 13:05:14 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::33) by DS0PR17CA0015.outlook.office365.com
 (2603:10b6:8:191::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 13:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 13:05:14 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:05:04 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:03:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 08:03:38 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UD3bbL2198410;
 Thu, 30 Oct 2025 08:03:38 -0500
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH 0/3] ti: add speed grades support for AM62a
Date: Thu, 30 Oct 2025 18:33:19 +0530
Message-ID: <20251030-ti_speed_grade_fix-v1-0-703e4189640a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdiA2kC/x2MQQqAIBQFrxJ/nWBGaV0lQiKf9jcVGhFId09az
 sBMpoTISDRWmSJuTnzsBZq6onVb9gDBrjApqbpGqkFcbNMJOBvi4mA9PwLat743sjfaUAnPiKL
 /6TS/7wfVwy65ZAAAAA==
X-Change-ID: 20251029-ti_speed_grade_fix-e7f3f6806878
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aparna Patra <a-patra@ti.com>, "Bryan
 Brattlof" <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Judith Mendez <jm@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Andrew Davis <afd@ti.com>, Aniket Limaye <a-limaye@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761829417; l=1860;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=IQpIP73yMMPKUQpKNQRuHgmUxLZaIA8rd6p4YUU5NYc=;
 b=Edda3J8L6uf6XDA8mn/xYwHZtMl3QDb9ovujsW5JCV7PBkmwSBbycDZIsgtvpV2LyvVt3xsgc
 DizhXRJ5l8dCIVSmQU2BpMe35OsV3yDAUi2nZRZ+O92rvwoZNNPcNS+
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MW4PR10MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d995e58-7257-4d02-8cc3-08de17b4f790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2IzSE94RU11THpLOE1JbGRmNW13WGZnQ1JuUzU5QVl1UEUrRUVDa2FDMUI1?=
 =?utf-8?B?Mno4Z09BS0EvcWYzTzRXeVR4NHNacklwYWhsaFdETFY3Mm9ITGZGYzNWM2NN?=
 =?utf-8?B?REJFU2NjR2xmZDcrODNMNS80NVEvTW5VMDluYmFFS1BDUWsvVys5U29iRWtF?=
 =?utf-8?B?aTZNOGt4VXlIYVNFQXhhMFpObklkMzljMEF2azJJVDgveVdZNTFSL014b1pG?=
 =?utf-8?B?YjVEMnRiRzI1c2VVRHlEb0NhcndieXVZdHhkZExHVG0vU1M2cW1uM1YyNGtP?=
 =?utf-8?B?MHdkQ1c1V1R2UDZUdUlkUGY3TDRVeEtlbllrQnZiSVZ1cnV3dUxONGxaNm9J?=
 =?utf-8?B?QjYreDM1ZFd3SXZTNmlVNDFiOGRJcGJDNXlZRmZHM1NpNlJZUzJwbVBhS093?=
 =?utf-8?B?WXNoeHF2ellwUzhuWmQ3bFRlT1JxazkxRVgyU3RUajl3bVdFb2VlOTBBdU9L?=
 =?utf-8?B?bWtMKzFmKzVUb0pVQ0ppOXZqR1RQSGhsTk1QRmN5VzgrZTNLaDhNOWFUa21U?=
 =?utf-8?B?RFdpejRBeHRIeWxOejdra1I1b0VkTHJnRE5Ec1V6ZERxYkdZOC85ZVFQZmtz?=
 =?utf-8?B?VkdxMkdMWDA2cmRLSTczUHFzclJQaFpwNUozVmxCUVBRaThvVFlNOHRHUSth?=
 =?utf-8?B?WG5tenBJb3g2SVQxQTM4eXdJOG9uYVdqcklFS0FNNEN1SUlyRWZxSzNMWVhW?=
 =?utf-8?B?NXFFUDg4ZXgwNnR3T3NER2VtTUhvMW8rRWpQRjM3cEFNS2IxK2xMSktyQ0tw?=
 =?utf-8?B?R0Q1c0x2djBIWGNuVjJFY3lsUlQrak1pVnVtSThmSVlrTWVKb2hXcnhVZmJV?=
 =?utf-8?B?dTFZczhPWjBPQjRLZVZvTnlvUEZQMmI2WjhjNlpxMEVwSlpjQTMxRWVzTHRF?=
 =?utf-8?B?SndqOVk0MzBiVG9wVU14MmJseFFkSiswWWpnZWI5OVpiSDlwTk9ETW9kZVdu?=
 =?utf-8?B?cFJLUllqcGVJZVB3Z0ZyajRaMmsyYmFCM01DU2dQeWlkYlpIS3ZPOWgxWUlh?=
 =?utf-8?B?ZjVORFF0R1NCbzNBMnZoTVZZc2Z0NXg2aTUyVExNQVpHSXMvVXhFOXZWMjdh?=
 =?utf-8?B?Rm1LNEJxSDR0cTZERXVUUWVKSW40QlVqcHhUOWw3QjBkRU12VDIvekZ4cGVK?=
 =?utf-8?B?c0xkQUFpK1RNUTgyTnhCRjlWc0ZxR09oaWs0YmRDN0JzM2pFN2hSNVZ0cWEz?=
 =?utf-8?B?eXlicC9BalNMRXdxUlIwY3lVRFM5Q1VHeDdyaHlqTXZZMkloUnNFeGE1N1Nm?=
 =?utf-8?B?elVIUW05dUNpUkR0WVdGejNIQUZuNjRqWUplUXh6WWE2UWxPZnl4eERYNTVj?=
 =?utf-8?B?WFJvL0JpTFphYjNMNDVTY0pQNXR1NlE1VGo5QjlYRC9xNHdkbmtjS1FJSVB5?=
 =?utf-8?B?YmZCNDZHY1pzRE1EUlNPYk5jbTR6SHVZQktpeEVLSDF0WGJ1eThMOHBkRndx?=
 =?utf-8?B?ek9qMlh1QytpOFpVT3JsNUl6ZHY1NFB3VFJhNzFxalcxWWtvdytNcFdtLzkv?=
 =?utf-8?B?dXhoUys2UzFURG1oN0lWSlBXazB5blFFc1JzS0JmMTdRR0hUL0hkZ0JscXR6?=
 =?utf-8?B?eHpPenJOY0c1RitaYmxVcmloVDEveTZNZkd4SXJGKy8yMUdTVVNDZStYMGxV?=
 =?utf-8?B?RENmSWRhdDV2YTc4N09UUHkwY0Vub25nTENyMVNRc1lUSW1PckNWK3MxQzNy?=
 =?utf-8?B?R0xacGovZG1xVHVLNVBvWXZ2VUk0eEJkTXhMSDFvUUJBNDUvSFRhMStmemY3?=
 =?utf-8?B?R2lPUUc2Y0gvUWVmWVZob0lTOU9BaDlwYVNvM2FDWG1wdGxSWFV6djdwUHF2?=
 =?utf-8?B?NGk0VDZNMUdxK24rQU5jWkNkY1V2UmV0Z2p0MmFuUlErTzV5SEp3eDQ3VjhV?=
 =?utf-8?B?bUxvclh3dmgxSnNiVWVoQ2l3ZkJtVmw0Uy9DTXlEN2R4SnhVdFNHOUQ0eEtw?=
 =?utf-8?B?L1pNSC9Vd0ZCOWV4dEFUOHVzK3NDZ1hUS2hUejZYc1pMenVKNENVNS9Fb3g1?=
 =?utf-8?Q?jekc6/GHwn/itPcVGMqLQUtLum0Z2g=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:05:14.7106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d995e58-7257-4d02-8cc3-08de17b4f790
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5882
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

Hi all,

TI offers SoCs in various speed grades, each speed grade specifies a
certain maximum operating frequency of the clocks for each core.

In K3's boot flow, the R5 SPL starts the A53 or A72 core and configures
the correct clocks and power using the K3 ARM64 rproc driver
(compatible: ti,am654-rproc). However, the driver expects the dt node
for the ARM64 core to be set with a correct "assigned-clock-rates"
value.

Currently the dt has a value of 1.2GHz for the A53 core on AM62a, this
is incorrect for lower speed grades. Therefore this patch set adds
support for fixing this value at runtime based on the detected speed
grade from the efuse MMR.

For the speed grade table, refer to Table 6-1 of the AM62a datasheet[1].

[1]: https://www.ti.com/lit/ds/symlink/am62a7.pdf

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Anshul Dalal (3):
      mach-k3: am62px: remove fdt_fixup_cpu_freq_nodes_am62p
      mach-k3: refactor A53 speed grade clock-rate fixup
      mach-k3: am62a: add support for speed grades

 arch/arm/mach-k3/am62ax/am62a7_init.c          |  39 +++++++++
 arch/arm/mach-k3/am62px/am62p5_fdt.c           |  12 ---
 arch/arm/mach-k3/am62px/am62p5_init.c          |  87 ++++++--------------
 arch/arm/mach-k3/am62x/am625_init.c            |  84 ++++++-------------
 arch/arm/mach-k3/common.c                      | 108 +++++++++++++++++++++++++
 arch/arm/mach-k3/common.h                      |  11 ++-
 arch/arm/mach-k3/include/mach/am62_hardware.h  |  24 ------
 arch/arm/mach-k3/include/mach/am62a_hardware.h |   4 +
 arch/arm/mach-k3/include/mach/am62p_hardware.h |  17 ----
 9 files changed, 208 insertions(+), 178 deletions(-)
---
base-commit: e34d01d23e45e007368685ffa6dfd674b6dd7b17
change-id: 20251029-ti_speed_grade_fix-e7f3f6806878

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

