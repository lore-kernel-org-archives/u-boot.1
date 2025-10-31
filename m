Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197DCCCF9EB
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 05:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF8D838BB;
	Fri, 31 Oct 2025 06:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dTIRTBlE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C96C838AE; Fri, 31 Oct 2025 06:34:50 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 255688331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 06:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmH1UcfDCIigWCMZRJ1gXIPRdJsTk6kNlzJn3jVGMvNJdhC2O/CfTw444T0t8j/FYPhewOES/46EPNwbZ6/Wd/2d6zK76T4iDY86h5JA/QQd/LhNfxrW+TyL3DW/KDTNptzH+WvArx+h9/hYUDTiKs+qjBD0L3PI0dtgKsPoTQguPC+VlqDSQJGS+OeaP6/gf3ntV0/boFwA1xiiR7gV4NiRKY+v359XXSXJDGafPJBQDydusCyCX2GRHmjAtwTPPVNfOKfqgERgbOCSyr689TgV9jIRhrjkG5QbqPBPDgxzp+rMzNq8agx23tDtemyEfcidSGM9UGMJbr93QOSYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpMpRMfLZOHX+trNwQdh33yRtB7tzhMi2tanmE2ANv4=;
 b=Uw5UkjTSIT/NzCBP4JMrBkjOOq4jB5nXOfgVdfTqrpQQwofOUeHSEpmPyjRsvP3M4WmcHD281BDlNYnNIsZdBJ9ETStjH5eQ8Kgu8Lw+4YIKd6aPmE31JSWrBjW3Esk0HyJbkWZe4bFJpPtK1eanR2dUlvFvl9WBQJElsXaCxe9DK7wobgseVBUZvK30Z3FvMmv6/yEjTrUbqINEhwqs+wqr/M5CN1ZVJuEZ8VyNKP4jAOjtysbII/sr8mENOV46Xxh15X0zUU9Ekn9GrDzFmWyyNqDMTPA6W6y0ZFoGmOV9MjHEbKL69T4TCUhLS84BEOZMp/AkJHZPLqkS7zsVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpMpRMfLZOHX+trNwQdh33yRtB7tzhMi2tanmE2ANv4=;
 b=dTIRTBlEXJW+8E5ny8YL6+8RBUP/Do/GBFXXItTl0YJR3hNSI0uPp9pdOUtE0PyHTLU3DJaYoDjmLEDx0QMwVS018amyflgubplXg24lzK1rzMG/UrxDfqhPhFP8KUxcouoU6M/y5nwuSsmO3gtjTcVyGZlvctpoXLVwKsPzGJo=
Received: from BYAPR21CA0009.namprd21.prod.outlook.com (2603:10b6:a03:114::19)
 by CH4PR10MB8226.namprd10.prod.outlook.com (2603:10b6:610:1f6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 05:34:43 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::45) by BYAPR21CA0009.outlook.office365.com
 (2603:10b6:a03:114::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Fri,
 31 Oct 2025 05:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 05:34:41 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 00:34:28 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 00:34:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 00:34:28 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V5YPvG3386115;
 Fri, 31 Oct 2025 00:34:26 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <s-k6@ti.com>, <bb@ti.com>
CC: <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <gehariprasath@ti.com>, <n-francis@ti.com>
Subject: [PATCH 0/6] ti: j7: Update to v0.12.0 of DDR config tool
Date: Fri, 31 Oct 2025 11:04:19 +0530
Message-ID: <20251031053425.3960963-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|CH4PR10MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5d1651-db29-4bc2-3a53-08de183f30f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|34020700016|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ErfaK7KpFksLC4rz6Ve+i8JnUPcuKuYN6UZanZJsYxCa8twqs0QH240GIJB8?=
 =?us-ascii?Q?g6XJG+eUQtUBd0gkrVc3TfmZ3PPY2s30AVWvL+RXgqGAFPE4fXepmCnj9Gzi?=
 =?us-ascii?Q?u/bzN4R9HnnY+xy9oL36Mp/4saB16053/yLbTJTr6uXEDsSIt/yMNOQO/y4J?=
 =?us-ascii?Q?gxvIxnDy7HsQcvi/mVsHp7OtPfPr4mXwVN4HQyAK0dfMlnzz5JL88myCSmPW?=
 =?us-ascii?Q?ile2KGMqgf7VIuKmw/O51pandu4JxKP/uk44AdtzE5SXKzJvjCDw+8XVzro7?=
 =?us-ascii?Q?ArvBPCIaSQPFBEiPusOPwVbZDYCZYHZoR9rg4amS/arLmhg7wcYm6GfuZe4Q?=
 =?us-ascii?Q?37cjq5Iq1GEUHNtrFb9GTzZxiipRpOY4V7A5X7QRhJYSauSFiOGrJSfOBwlB?=
 =?us-ascii?Q?Jzd/Km1W4pRhpPubgH1Q7k1yV7OoVQVqw5OGqkdI2xkL2/9c0XLNQtbyzeHX?=
 =?us-ascii?Q?KYe51nlfYTDWxWdmXQC2rOuUnm0BZZywN6MB+QbUN/8EUniu+ZlhIQUTIfZZ?=
 =?us-ascii?Q?Iu94dYpM9z22OB2bYvJ6tlnkDqaX1J5g2yDkMR2O0YSR6lbx0NlmyV88KLaR?=
 =?us-ascii?Q?BFojt83lSDrgkLiO+8OeT+2UZQ130TwctV2Uxm+xvvaz+o4xs3chM59nfRk4?=
 =?us-ascii?Q?2UxmUL93FNqxWemFEUmvrMcsue9Z4kY9O5+DM2lyShiABfX6rt41pwxf3skm?=
 =?us-ascii?Q?QNdsRJ19fjVhkbHEtaJbMX/dd3WrLrSTi1Kqe4sc3R752OX8mC1DS9G8lx5q?=
 =?us-ascii?Q?zaVZ+viccSOOQZetQZi+4fqZ8DZQIHZP7i8X1rqHQpyARVuTW7Zx/Dju4gny?=
 =?us-ascii?Q?f3kDWq8ZIU/Wd1oEa12jZ4pvzuFBY69sXLj2aKiOgOYXsFoB16Op3jA3KZOd?=
 =?us-ascii?Q?M/pR0Kmoqt+INm3GIfox4ywTiA0G+g92CVpUlfZeLNrmUbIGIM0H6g3NSGLb?=
 =?us-ascii?Q?xbc1YfNWN6Qb0v94eUSfEN0HHlPrC493aabfecqQ1cA7o3Hbp35I3qSZ7PC6?=
 =?us-ascii?Q?i94Ccv9Z+7YB0oWw8gBajv/oBzJn83Vleqiis4zxdLpEmPVyySgIkHT/yMvG?=
 =?us-ascii?Q?8mxsUlJwZfswwCzUBOZCI23lLrabK0nHRWUORNC0rYG2L1YfBrzFi40sZFAg?=
 =?us-ascii?Q?wuuL27WEs5h3BMEwovvuwC4QPO7D2RRjEbuG+wmCfjA/OdY+/ZZdHkUYtM79?=
 =?us-ascii?Q?hIvgvYnPI0vLg9Ndf6Hkx8bLXeYYOV+eBiMXIFSJvG37SaPOFjYLy3M42u9p?=
 =?us-ascii?Q?GOe+97bwYmUP8wWAciD/lHCuaYMMmb40vExoLbPDDhVgo8TXQDC+LVOxGH2v?=
 =?us-ascii?Q?EwgYpmZRNuuhgD9xQXOQmMpZdXYGPbDzyW2D1V4ZmzeHQi6/HmhDeA31+MJZ?=
 =?us-ascii?Q?+iCYWxlqWrb9aJfy9CJ5Hu3pfV54ZfuQYvf/RiZdAZL5Ao9P6HI1i8rBF1Gs?=
 =?us-ascii?Q?7wrn/5ztsz8YvVf7xgclca2PafhByfQCthsrCPzf7VQUBxgOXIZa7qJJc+TS?=
 =?us-ascii?Q?Kssc9lPRVLPTkZR7F2OK2jDsOP8HRh+XzAmOOqT/kgn3YG/NOmfV/uSzw8QM?=
 =?us-ascii?Q?rQUKxXGgVUCHSwugWU0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(34020700016)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 05:34:41.5250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5d1651-db29-4bc2-3a53-08de183f30f5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8226
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

Update all DDR configuration DTSIs to the latest auto-generated output of
the Sysconfig Tool (DDR Configuration for TDA4x, DRA8x, AM67x, AM68x,
AM69x (0.12.00.0000)) [0]

The auto-generated files must not be modified, but effort will be taken to
change the tool output to adhere to the latest checkpatch.pl rules. J722S
and J721E will also be updated in a subsequent series.

All the changes have been kernel boot tested and memtester has passed.

[0] https://dev.ti.com/sysconfig/#/start

Neha Malcom Francis (6):
  arm: dts: k3-j7200: ddr: Update to v0.12.0 of DDR config tool
  arm: dts: k3-j721s2: ddr: Update to v0.12.0 of DDR config tool
  arm: dts: k3-am68: ddr: Update to v0.12.0 of DDR config tool
  arm: dts: k3-j784s4: ddr: Update to v0.12.0 of DDR config tool
  arm: dts: k3-am69: ddr: Update to v0.12.0 of DDR config tool
  arm: dts: k3-j742s2: ddr: Update to v0.12.0 of DDR config tool

 arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi     | 4410 +++++++++
 arch/arm/dts/k3-am68-sk-r5-base-board.dts     |    2 +-
 arch/arm/dts/k3-am69-ddr-sk-lp4-4266.dtsi     | 8786 +++++++++++++++++
 arch/arm/dts/k3-am69-r5-sk.dts                |    2 +-
 arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi   | 2207 +++++
 .../arm/dts/k3-j7200-r5-common-proc-board.dts |    2 +-
 arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi  |  591 +-
 arch/arm/dts/k3-j742s2-ddr-evm-lp4-4266.dtsi  | 4872 +--------
 arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi  |  653 +-
 9 files changed, 16317 insertions(+), 5208 deletions(-)
 create mode 100644 arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi
 create mode 100644 arch/arm/dts/k3-am69-ddr-sk-lp4-4266.dtsi
 create mode 100644 arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi

-- 
2.34.1

