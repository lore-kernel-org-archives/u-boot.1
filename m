Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACA7E7BD89
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEBC83E36;
	Mon, 16 Feb 2026 11:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="whg6rTFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7ED7802C1; Mon, 16 Feb 2026 11:28:25 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99D183E0E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvKFtdY2QQJt57zCVZWhESd+5+i+68V80VPo43uFHb39FZHlyGA2sCQxoMLmgcl97PHZO944cL6l7vmJmaEMyFrKxCEZUh4wIRqGcqzzON+qBP+hBG5HEefLfJDyapeeZXJ8C6CEJnEM4zCRpvs14AK6IqhMcLY3ik1yLRhYnNRbS3oM2DUwxf3/51ka4+JpOfuGirALMtu1dCbGpoeLekhvLqx7jSVIUbE10F687/RI9kjaU+6TS5FmuP/YSM7dFbkygV2rlxc9VT7SoxWdvjQvaFMHxSA4GwKb7Fja3bkiuQTJsnX2NOEkyyOOXHEMQLKNdNNI6xYD3iNPwC1oTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFY845jvdi9voWjXTihf/xX5ycPuwEdCyTC83DmIERQ=;
 b=BsqL8LXs3cvc57s2/Y/mqD5s2T+jb6nUxxqmcDJbolNHr0dnGhD5r4JV7HX0tUuaVQvVwvYejkI4ubvst18PEx76obBDdaEAxNsueVvlLiv8IZM/tuJ2qk8MURcy6fA5kLhZ1iFROFsnCyUGNfzeJJEfu8RN9poWAXWMoQAzyzeKe9xP9YpSszd0JzTyrVi6VdRWCwaMNqJmymrV38PZCULoLXzXgdNuZq9MQ4fnIneFIdU1qv5SwgUVM/rjQeGuWd0SSZ6Q2WB5PcglVsw5rrQroYxlr+i62j5gw8eMiJ/kpCW+0gSVqk0SMTlJkGCTzl9E1Sbak6iY29UeIhrGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFY845jvdi9voWjXTihf/xX5ycPuwEdCyTC83DmIERQ=;
 b=whg6rTFvdZZV1H5SpWh33NaF+WK4UdwoKeYNY/Ar8vrye//CczWIe5uy4uswgtVdwafr4The+us5POIBvVyN0Cm6dABsYeowA31aShOZZOCBDLHQ32md0FXnP1NLcSPFMEGJmrZbzs2IGQhI7rYHSqYXJPedJyEzOzfgYO1eHXk=
Received: from BY3PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:217::10)
 by MN2PR10MB4381.namprd10.prod.outlook.com (2603:10b6:208:1d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 10:28:21 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::46) by BY3PR04CA0005.outlook.office365.com
 (2603:10b6:a03:217::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 10:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:28:18 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:28:18 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:28:18 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 04:28:18 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GARUHi1147835;
 Mon, 16 Feb 2026 04:28:13 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <afd@ti.com>, <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 09/10] configs: j742s2_evm_a72_defconfig: Disable PCIe boot
 configs
Date: Mon, 16 Feb 2026 15:58:37 +0530
Message-ID: <20260216102858.2745657-10-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|MN2PR10MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d264ccb-47bf-456e-0f2f-08de6d461a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ww7HGVVqNaOaEGOhimRCxgzDbhEya3fSgf4AnMUS154mb2PAH3BwyFhETT/k?=
 =?us-ascii?Q?T1Kc/0g/MjdrD6It9rQH5PkamqwdrsqAP8/aP4Fkebv1EvFPfHS8xm8e+RJM?=
 =?us-ascii?Q?Nu9FiFPdenIYKzHqnJ4pgcw/tWe9FjwiQ+dce8E+jUAgTzcnPYMnYQFCORdK?=
 =?us-ascii?Q?d/OKrdilYP2NFKqou4uF9NqlagISRuKPEXsv+/NTttzo3H3n5b82XMp4NyvE?=
 =?us-ascii?Q?4vIo0AT6ROw32Eo9AYAJwaoyEVkujC1mb0+VGPb6P1li/BHa12pBWlD0+KL8?=
 =?us-ascii?Q?yliP4ptjrWBdlahS0fTzP+Bv0zOfRlf0Gzr8obdmnxotBe6gO8W1iknObS2J?=
 =?us-ascii?Q?PTS/GpoTbjNcX0OCTmYaRDk0RXHHvTdgerq21r+x5umLIoYqMUOp+GzMCH0J?=
 =?us-ascii?Q?t+da7b3sMe3pPXTimWYqzqqe5EEopRCMj/bYxecBxgtsOKPjS9N6vG5Z2udr?=
 =?us-ascii?Q?Cx0n4COjNqBjTIg4g3uTxuyUMvItu3wLhcmANPpcyZbZRyj9YAX9bqceMz7t?=
 =?us-ascii?Q?if31XJ7dfiwebicdNMb6VwesyITLhBjot3qYneztJC6Qhj+sRxwiCiHHAwY1?=
 =?us-ascii?Q?lwVnV8jKeAucEIOD9WJdSrhHyWEtourgpJi7a63iDh915WrC+M4O4mAv5HFV?=
 =?us-ascii?Q?z9Nm3/JH5hT7juh0xJnVJfkmf/U0z80cEu/7+Mv68ss4vtjexeESMTSHFusm?=
 =?us-ascii?Q?KSCrqaek4qzuIjn3HdtIt0SpUOygZvGX8ovPyQw8afb/YOMg5TdGcYAYKEw4?=
 =?us-ascii?Q?XnPKrtgb7QPFr0JSqKgk3/SW4VEkYZJcO4Lwh4+xfXML/kwNT1JQU8oDiDgD?=
 =?us-ascii?Q?Sf05RVExictQjaF5go7SSM4WNmUdvRzPyjex5/8ffCduCn6gu2ZSqDmKeGVU?=
 =?us-ascii?Q?n0Ir88kafilszH8C+jm7sZnxLGEkBlGudFZAshLhtkWaQH33Q/ATvRQiVNm9?=
 =?us-ascii?Q?BErxHM2QHhpdwh8w6mGsgQk7Ox2AfguVq4IIDwd6hKPFv+Qeo+7ye2435OUr?=
 =?us-ascii?Q?MrR7a2DCuePa20x6ORWgGYO/jk8G1LK8kEnNKF2S+HQEoVJ9Y2+JwpaoCXvK?=
 =?us-ascii?Q?X23muqiJW7ttIQAauIEzO8tLA+9JOBh3PEihTm1hrmEZ9rfuj8iMPmhE2Ibj?=
 =?us-ascii?Q?9BwMRwf9h7SpVtUvBvii2JUzI8HVoB1s0S71gp0irc/DTRuTN0QcukwfUwkZ?=
 =?us-ascii?Q?XT409Cemx6BJ7QaQC+cdtxwB8dnJ+zhf8pIxtTCrMfFz4q0C0ue3op9YdnGC?=
 =?us-ascii?Q?g3uaqQLAy1p6LKAsnVbGq1ePNWKrqYFzAYlMMqeyLHgDUN65f5LgeqptKEWT?=
 =?us-ascii?Q?WppvAo9WxMyI7EZIs5006R7b4/OYP59uTtrDxX4O0cCnTG/DwVCW5cFFukgb?=
 =?us-ascii?Q?swsWCXa/x6mlE3AEVEWynK/DO3BrE8+0WFR62EJ8H0bLnCEX1jQaiVstZxTa?=
 =?us-ascii?Q?dWbRHtjKOP5h/Y5tCMKeygyu8LxLbQK9F1S4utQhCyO6L7UNurD3O8j6bl7L?=
 =?us-ascii?Q?u7227uAJaUVGhzsCCFH+cImpSoaJi+ZDt4UgZ83pbZSPUdYtUIU+T3q8IVmO?=
 =?us-ascii?Q?ZDt2J2L8Ws6CmGuAq/xVf/AKDp8fsOG4zHDfs3TrA9tpUrfWTIwAO0rMXzgB?=
 =?us-ascii?Q?1P1nQMdus2xQa+brrTTJA3xEpdfVTgSs8IyV8mnk9bT2d5WkZjn7/Se4416u?=
 =?us-ascii?Q?13WOjv5W9m8sqgtnLJdmUVTorrE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QBduM4/e+n/H4j5imvYfgYwj5QOKp2AJnUdeCac25ZTww60kZfZT+vQ3D3eT0kA7nh3aNlVQaeuJ6YcpyrLLaRCEtUuT2Ajq+Rn/dO+DVD7GiE9szN/a7pdh+J+r77xH8CCpDJ7zBlhl4SyJFvKLwCKU/s8PH03noDiP5GvlmXSf46HaSlXamYw0Yx8qy0RnGqHagHxUfBD+C1CNxpFrAxOi0B6560WAI1p1DkqeolGyMysKhld1FqXP8r3sxehp6VtUYkdolANjxlLb/KWWccsSokJrEQsKGZDgGC+5l3VK0QwLzPTErMHPq6slBZ+IeV5ECZiH41yXeMtpJxBCgjCfsiucPBgyKopzRfa3WV1e/MXS7rVbu281iL79/bXc4PrRR+r92a0LHhE59i3I/CpNzq0+3pcIfw24YR+odeu4o2jcjY9Gr/DK3WYr0a+x
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:28:18.8593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d264ccb-47bf-456e-0f2f-08de6d461a52
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4381
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

From: Hrushikesh Salunke <h-salunke@ti.com>

Although the J742S2 EVM supports PCIe boot in Hardware, since it is not
enabled yet in Software, disable PCIe boot related configurations that are
not applicable.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/j742s2_evm_a72_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/j742s2_evm_a72_defconfig b/configs/j742s2_evm_a72_defconfig
index e534ce4c2e3..8263ab0bc4a 100644
--- a/configs/j742s2_evm_a72_defconfig
+++ b/configs/j742s2_evm_a72_defconfig
@@ -5,5 +5,9 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_J784S4=y
 CONFIG_TARGET_J742S2_A72_EVM=y
 
+CONFIG_PCI_ENDPOINT=n
+CONFIG_SPL_PCI_ENDPOINT=n
+CONFIG_SPL_PCI_DFU=n
+
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-j742s2-evm"
 CONFIG_SPL_OF_LIST="ti/k3-j742s2-evm"
-- 
2.51.1

