Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558F3D47CD0
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910F382BF2;
	Fri, 16 Jan 2026 11:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f6qNDJLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F084E8367F; Fri, 16 Jan 2026 11:30:37 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9734F80077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFK9XnmFVn1GRyc38vMC9hfEBB15KQUZekjr+YfHeSGu0O+2RdTYf2GRbMddPfjbXVsDeqbXdJF7pyD8dXWE0qJnc9dwDd82+UsBKRlHMty5pV6r+GCk4Xb/uvsIAo6OeZkSo+KIs5UwU2dxFURn6qDwltkKO3Y0O8WDIYoLbpmNY1e0lwnIuGOqpiq5/nXBs5hv17BO98o8AN6HPsSydZwr+E9c7jg4Jt5VckzCjrlMOXnUzP+ak01ILQD5cbsjCKD0RRUnTH8u6HWAhtvSBvPMD2OkMpnzNPxPIJUTWHfaPa60VAvFGsAvn5KzCg8OyUZTuVlVLRCLIIiCt+2+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1GT4hZAFfFCFV4lMxU3TvgtyhQgInq3G+HxU76X/Fg=;
 b=vvPLqR21Bf8Cl5MReKayACeEIfK4TYXrREdYTqxzhoEAMhGEjHZ+2SaCmfiU/EsgLQxKVxBHHDqtQwO6sfhyYUoEe1979kqc+KBWs/G/s6N7Pd0wmaTkCwgawtOIifeRhhYQZ9QLRqkq53klSvG+b/wIF15NHXHT9PlA0jli1vYqQIRCfGBzjhdiTQVndbITeYK+5Pc/jM3UwQD161vUenCtXW75nGp3CwPq7CSXuLXVrZWbS7h0Zybk86Gz9aPhvvhNWgKOvqolpLOmtuqOubiafX4at6hVfd40X2ECkx7RU3HtvgRYgZs2dzzTyaFSESvm+46klQJl9Y9JGErcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1GT4hZAFfFCFV4lMxU3TvgtyhQgInq3G+HxU76X/Fg=;
 b=f6qNDJLI0b4YWVUBh27pt6VU8/JzWWy3XKk2yVYMq3jxX5c++o18T/2xK1iQghe4D++lhTOlzvs0WFKGZcRVURTHbOHleSn+MdbPUzRfr6ZmKUFcKxAT/TO/IbXXAqaL3tszDs7wMglo1Xqiso8rM5QoJmXNeRuSGhFgi8lTFHw=
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 10:30:32 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::dd) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.9 via Frontend Transport; Fri,
 16 Jan 2026 10:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 10:30:31 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:30:29 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:30:29 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 04:30:29 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GAURHL3139048;
 Fri, 16 Jan 2026 04:30:28 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <khasim@ti.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <t-pratham@ti.com>, <nm@ti.com>,
 <v-singh1@ti.com>
Subject: [PATCH 0/3] arm: dts: k3-am62d-evm-binman updates
Date: Fri, 16 Jan 2026 16:00:07 +0530
Message-ID: <20260116103010.3947922-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: dd516cce-0c2d-4acd-d9a7-08de54ea46de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|34020700016|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WdB2+pUB5SKMg62z8bhWXAqfum4PWtF/JgIvgC7Z6YMssC7kCCbjJLviib27?=
 =?us-ascii?Q?bHHE7RXclq6RnREHQa3/4XYe/zPmc1m9g+0fGQrjbvwaRRedVswpWKx27ljI?=
 =?us-ascii?Q?u148fhdO9/WRsHy9G/runF4b5RGr67/xTTqn8PB+pW0n7AXzrMPnA0J8BplO?=
 =?us-ascii?Q?L4ZH2hV9npdxru1k6B7pM2o65tA4Lj//sPSy+rYjWR2S31FmkPA7YTTkgdpp?=
 =?us-ascii?Q?ebG79/fzj4L8m/gLH1yn6ADh63m9VPqqdUldMFbU/CjrpXSu8LEKIpWcqpDR?=
 =?us-ascii?Q?orEZ5Ihrs+em19vy+QgM4s/rbVKLru1CFZsR41DLFXty74cyDEm3W3A39q3O?=
 =?us-ascii?Q?DZDkT3KNKUBqdbx7OZ+Ln4vMn0JloU2Wud7laiPeUTRWoIWwpnZb/gmUdNVV?=
 =?us-ascii?Q?sb+RK+8rH7KnYijK/rd6Ngr5AItH4cg7NCaa6Kvg/+88lkfsv6cwXRAbKocC?=
 =?us-ascii?Q?N2XONqGvMd0F9VrzkMSGYaGecOQ3P+OgPU6QzsRLsFQkWyV+0NaDklAgIrND?=
 =?us-ascii?Q?xz5p3TgEYL8SuBWrxfrljZJrHnGqV3QunJDhWZ/tpbfIR/+U7lYcZPueB5Sp?=
 =?us-ascii?Q?NYxEYTZImYPtMWo3xVegREgTFXMqan+OciWtS7ora1SEehvneLquW10EeQgR?=
 =?us-ascii?Q?O+tulMS1bHpYSwt2d1el3rJ9QP5EFHKyyhF3X/zEW0oohaji8PWOLNrjk7Ii?=
 =?us-ascii?Q?SuxkDSswtv6uxug0f1jCZE48mzTCMEPHwfUVw5Zh0ru1dq0JPIADAFnoRaXg?=
 =?us-ascii?Q?Vzm2S2PmMdQKtXFV43l9LzobtQSd6q5j3HoIIsED4l3cqavISwsBeavf1QLx?=
 =?us-ascii?Q?+vS/uPWCq5kv+SHawAOAJqfgpF/lo/0CMLFUO7uacvz67en35iCZTbMAKuTB?=
 =?us-ascii?Q?QN2bpSariPpExgElWanCPzporkavI6FtnbPqSnHMdBgFSAHwtYA9H6cfHFzG?=
 =?us-ascii?Q?NPEWKV+Z4h9wjb8sZPnF+qwcKhGSSU++tt3KmaGGsCB6VaxVqHMQeSVDg24N?=
 =?us-ascii?Q?oaIxpMPAXDu3KP3i9/JjGZPvYJgD0gSFR/74k3HWu3UsVqRYsjZnP1R3Vb/O?=
 =?us-ascii?Q?HTQbhGG9cCuBKyeosRusKw4b70CBc99GbQmjpJJ+5TDKCunt5r8f3DM12kSt?=
 =?us-ascii?Q?hA4sMCk+L3on9D1DsntMfAoWCOSyDfAVEFjij7jcGVk2UdBMyuUnws7m78nd?=
 =?us-ascii?Q?uTQE+zEAW1HDvGFxfNO7Jw0hX5kNuZdckEGSiCnkJ7z3o1srFddUVUqrq7pH?=
 =?us-ascii?Q?SmgA/Ii6tEcAwx6HyPa1Q2s7QAigtMg2l/nUbqm4QVdzzQkgZkd2pu0tT4o7?=
 =?us-ascii?Q?E2Iin5JGoUwk0UUaVHtqIEvbDsPNIEqMsjQhBKnDVZquwinhNhqZdojYeQZn?=
 =?us-ascii?Q?wUhTuN1XFKyqNsNXyd7uQw3e/jQpt26Mft+5fmGKn8Om1T7kQDJO4err6uFX?=
 =?us-ascii?Q?s6YEKCNOGaANbaklCz0iQP0rtbdWV1A5nJtrjH/lEMPrkGHw24fRqIzab8tx?=
 =?us-ascii?Q?kias+J268vLyOyKhR+tbcNtdxGqHsi0ThZoRLD7uH8WpMZ9GRPDakop2Eiq7?=
 =?us-ascii?Q?McWs+PipIFEI1hbHdhuZxcZYB4t9FP4uMh7EwZIXL58hbQlWR8ah9SXrIuFG?=
 =?us-ascii?Q?PlIYj+49tPN0gnsO6zuCaYne7IFPSFVgD21Ej59JEBFZ7o7+i7ft9ScZK3ff?=
 =?us-ascii?Q?foYhGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(34020700016)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:30:31.9970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd516cce-0c2d-4acd-d9a7-08de54ea46de
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
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

This patch series updates the AM62D EVM binman device tree configuration
by fixing references and tiboot3 binary name handling.

The series does the following:
- Corrects device tree reference to use AM62D-specific DTB instead of AM62A.
- Adds labels to tiboot3 nodes in AM62A binman to enable cross-referencing.
- Implements proper tiboot3 filename overrides for AM62D-specific binaries.

These changes ensure that the AM62D EVM uses the correct device tree
binaries and boot images name.

Paresh Bhagat (3):
  arm: dts: k3-am62d-evm-binman: Fix device tree reference
  arm: dts: k3-am62a-sk-binman: Add labels to tiboot3 binary nodes
  arm: dts: k3-am62d-evm-binman: Override tiboot3 filenames for AM62D

 arch/arm/dts/k3-am62a-sk-binman.dtsi  |  4 ++--
 arch/arm/dts/k3-am62d-evm-binman.dtsi | 11 +++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.34.1

