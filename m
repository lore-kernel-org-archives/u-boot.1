Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D6ACCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 07:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD7F8393F;
	Mon,  3 Nov 2025 08:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j6OslnA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7121F838EE; Mon,  3 Nov 2025 08:11:10 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2774083959
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 08:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVx60pCP6kHLdgsDcR/t1FSHADLWL+KBtgRf/Fq5aB/9490n9F+QhGdJqlWQUIYOEgfwx8sZ/lunsBhOrX6ncN1hrerLy9HHlIjsyOvDn0uFlFYA7SihjdlFwB7njAiypUJaXp/EquGXtXqMyTb0QLUib0WKjN1lyhLOpvCJYNJaLxvfGxvZWKX0Jp7ExQCvsEpnMp23nOS1T7rIko2R8HXboCTHZPJePyPM7M+G14E8K1FY0VlesloulLGwr8z8DzYmMtBYazUGNOWj8w7G1x8B0O9khHfa6piGt2bcvIPTMw0WjcYR4COPLZH+UnkCE7uv0OEE1nCVtIyO3dvuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJRtYAl9MdrzWNiE3/s7K9V5xxDYytltYp6xMAwGgEQ=;
 b=mDIt6Rh/veG+iK5wo5K1FigPARDoP3z5AL/+RV3vdZjRTM86xMPlNGUWq7tmvr527IOXSvkZSGkoDmHa2j73yekzxoUZcq7sIDe1NQWAz3oO7m1L5UoLPdWY5kV2A6I/hX7z0dmeBekZvUa45ASYTvLZ14eLg97GbWlM9lJhLih/JfP9LQ/35O4zz4LZC5uAaU9RiOHUWk7vzeIjL1uKqr3Pia/6XTg8aoRdN9hhnGbcG1XncjKmObMkC1sK7Nv/Avb84SANtYgCluyxr/UfaAqB0DvcQfW+55ifcolrHMvYwluzhGkwT3B6wFso1f9/ABDDA3HEgvH57q016aBayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJRtYAl9MdrzWNiE3/s7K9V5xxDYytltYp6xMAwGgEQ=;
 b=j6OslnA7Nyfso6WiahVfRVhJghnhmpG0J92gVcegOtt7F/z02d+uNvUXBR8OVN4R+gWBpXW3fCnIomaPB+L98aURnk38/t667H9VVpvr3S8waYv+56ncrSnj/tooxZ5XJlAdaBnBS6OJ8o0RWv8bx+k9i6UXaxK496wnyYsEIOo=
Received: from DM6PR07CA0112.namprd07.prod.outlook.com (2603:10b6:5:330::27)
 by SN7PR10MB6665.namprd10.prod.outlook.com (2603:10b6:806:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 3 Nov
 2025 07:11:05 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::e) by DM6PR07CA0112.outlook.office365.com
 (2603:10b6:5:330::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 07:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 07:11:04 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 01:10:59 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 01:10:59 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 01:10:59 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A37AZZ23684702;
 Mon, 3 Nov 2025 01:10:56 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <s-k6@ti.com>, <bb@ti.com>
CC: <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <gehariprasath@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2 7/7] doc: ti: k3: Add section for DDR configuration
Date: Mon, 3 Nov 2025 12:40:35 +0530
Message-ID: <20251103071035.674604-8-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103071035.674604-1-n-francis@ti.com>
References: <20251103071035.674604-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SN7PR10MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 5406017b-98d4-4716-c05b-08de1aa8274a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|34020700016|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sb8cTrmUwQwo0FZiR1lu7pgxdpN54xkj65KYN2yRZ7/gounFxgo0AloCkYH1?=
 =?us-ascii?Q?kIRRArtaMeS8RXdI/Qpo5ePZzqkCe7QdxdfYPNO5Pn6qsACRRntzjDMHyAO9?=
 =?us-ascii?Q?X0+R0M0EopmKuVkAN8j8dqa7i1SbGmBym+otiYvWJFVHvaTih7cb2yzB0lJk?=
 =?us-ascii?Q?DNfpwJpGTzgnz7UwbwzZbR7C1rWHOene7J+cjzdfzxeXT7GAFoUJGXfQhyWb?=
 =?us-ascii?Q?hgNA2HQ40Wnp3txuihBjSa1NrrAzEyPQa0Kx0y2QcHayf85f37/ep+hIs5Ch?=
 =?us-ascii?Q?m0Dz/TyZ7okzRiVCICjCd1iD6rCO46KrK5jlFXXotxUf26LLcMw/ESdoNCq/?=
 =?us-ascii?Q?TjoPNutt5LkDpjW1/DQXtXDVpee1p9EGhAR7S/1nx3RUC2sPwkbp727T+LnO?=
 =?us-ascii?Q?vLZMWRWpmgVnMhjncV7eqgN9gv/sKwexIHr4jgaShe1DQwMctUW2czmrb8n/?=
 =?us-ascii?Q?j3Ovdh19EzvMd6X6Ku2NV0+rFsqcUioFUITzj1Px888x2jS5Ra2NTpXx5ZTq?=
 =?us-ascii?Q?puMFzZ/Ys9FJ8uGHO7lg6GQIYwyAN1YXZ02Yy/qDtwBIOTMP41l3h2aLmq8k?=
 =?us-ascii?Q?ETa5CaaRSFO9saZZk2dP6Fi9xOl2PNzf83LDwpD0TCwipwVuAenI0LRb7baX?=
 =?us-ascii?Q?1yFYMORfYQvWjD7qql3WiluFqfBKFr9Z/tSpZegn75fI6zgmvY2tqgKoPQ3l?=
 =?us-ascii?Q?RNoRUUoiErGdt1SmIgz8bv9riaiegI06txWUth9Rm1m8WwWZAaMUNXK7yY24?=
 =?us-ascii?Q?Iu+AjZ4IgVwAxiC0/J5B6nPUOX9ZSznz8jgqwtP42McgZgR7zucmtJ37YOGc?=
 =?us-ascii?Q?X7KzQiXX5scw6kOE98yXwMb1AyQUzA+6Llz1XtRGHSOdVlfJUbdVs6Ib4Mpu?=
 =?us-ascii?Q?5Qn+OXS+spyZJIFVAS/RsVEmp8hu+KDAiepCp9ceR47zTapJvcA/hYUiHp8A?=
 =?us-ascii?Q?w4Z6S+T9a+SWjBQ5q8E/AB1gkWyyGZrAQTrQfLR9vLy+fgSQv+C43HZQ6fre?=
 =?us-ascii?Q?rEEBWjeEDZNr6QYIRDeRQGvTmGyZIFMo0Lmk+6Pu9dFLcv1/LM7R412Gvaz0?=
 =?us-ascii?Q?AyVJFgttWVH+ITc/MqV6S5EzN8cGtvbCRPCw5US580glxHyJYf8IM/70cnNv?=
 =?us-ascii?Q?w3G3s5alkjfQcjuOH05o84j0Z8ba+T1Av9KS51GE20cpDwkJDkRGZyECkGDg?=
 =?us-ascii?Q?NzVz1DDd605SmR45aj6u29rMCYNCAqEpjXzNWnkVWWu6a1PZKkWriiAa09XH?=
 =?us-ascii?Q?d56jOn59doMnKIqUT/XWvuj24QfWp/oSXHqyTLCY4HJHEY8tF22Ei0FCNIr+?=
 =?us-ascii?Q?bOIaqVosFy08ZcwVcGcV4TlDDiGCSH4OcfGDCRlXHVY/jmoWk4rIp4YbyOpe?=
 =?us-ascii?Q?Y2dV+yuvtUtrgM7gYUeiKMS+M8TPyQy8yG+9UlrlYLfNPWDFfaK+aDijSa2/?=
 =?us-ascii?Q?MWJgyHHWC6uvoUCy5K2c2kzpi4cESuqHVyb5j44C6A57arPy3DY+l5Tj3//D?=
 =?us-ascii?Q?zrWa/dtguu8C9A/9+NMo7YBzSEejNp6BJte63NNRv9cfGx3l3EuDiCV2myKw?=
 =?us-ascii?Q?sVaTDjFX7cOctSt4vUs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(34020700016)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 07:11:04.8017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5406017b-98d4-4716-c05b-08de1aa8274a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6665
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

Add a concise section for DDR configuration pointing to the public tool
that can be used to generate the configuration DTSI.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Changes since v1:
- new patch

 doc/board/ti/k3.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 01fb9411688..de66b830703 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -649,6 +649,17 @@ Refer (:ref:`U-boot ARMV8 build <k3_rst_include_start_build_steps_uboot>`)
    This will need to be explicitly disabled by changing the boot_targets to
    disallow fallback during testing.
 
+DDR Configuration
+-----------------
+
+The K3 DDRSS driver (drivers/ram/k3-ddrss/k3-ddrss.c) configures the DDR during
+the R5 SPL stage. The driver utilizes an auto-generated configuration file
+containing necessary settings for the DDR. It configures the frequency, timing
+parameters, training algorithms etc. for DDR initialization. The configuration
+DTSI can be generated using the `Sysconfig tool <https://dev.ti.com/sysconfig>`_
+and selecting the software product as "DDR Configuration for \*" as well as the
+required device.
+
 Saving environment
 ------------------
 
-- 
2.34.1

