Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FC2CF649C
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 04:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5769C884DB;
	Mon, 30 Sep 2024 06:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1rTAzZWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E6D887D1; Mon, 30 Sep 2024 06:39:12 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5898A884DB
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlxTSKZchdgk+2WL4C4ZkDDwRIUUF9sI3/eTZsKYmmLt/bMQE8xlXohWEnjZS7e1nsgr3KoAns/iL43tLI9NlFeD1f0QeD8up9CirKqrqfCzb9LI2KDqwlj3x6qaXcw0ytA0AnFafgcdyISYIluqJgoWN+M+2J2J1qYOzaCuxgvAr5bEru2Mx5Wz1INkz4+53xmGvs5ezhzVDGY/JC3Fw9VK2MGBcfMGjmi+3wKj3l6siV08u4FTmplfxOmu0KkLFcI+Xy20TYQU+cuXc1KG8xzp0HQfTH9ImA3AGhKPj2YWqSy6yI1kksmJLWnL+OX08SoxgMwkI+odP4dPKhsSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJeIuqbgRUjdU2zzj4Q/QJzyTq8yCEhYhC3mZtwn1wE=;
 b=P0IDswRNvYNloYVDp4Go2azDEcLBbj6IrsfYa2/vbJDU32NJLrUprK+Omr9U4n2rLqbSkwndDHrzhIvDJ/2s2hKZ7yr/XyIEqCCmnsGDK1BUh9YYhzE3m9mqhA2MyM7uoDm13NO4TZB7jWNhWrb/G3aYlogbKAEQxlc8PoQP3PS7agaP1EmLWwuJwzLmYsCrgQIGgYjpDEcp+lZ5SdzYBAH7bappC3MCzme+mYIRjj8/X53l7mT0iUC2BpfcBWcAscEpOlcVMK7NBFqEo9TAGMmVrQEgkCAaQOns5S1a+EiiaQOrt5ylREROaZah0dSenSrUq37QulGVb+n8L0Bepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJeIuqbgRUjdU2zzj4Q/QJzyTq8yCEhYhC3mZtwn1wE=;
 b=1rTAzZWpema+2kEuPMzf7BlmRwWs23eOv2KMsrYZ3bicdQfUDn+fZzrWYbAcfSxnaYp8hlH902beTmDg9ndl1Ag03bmwlKFDvIbNOQvWlEakohO9qhZlzxhyosmqbqjOm6KLe6MbCdAs3UdLGHhZ5IN3Zf3gZyPfZtRAvzOuYmU=
Received: from PH0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::33)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 04:39:04 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::9c) by PH0P220CA0018.outlook.office365.com
 (2603:10b6:510:d3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 04:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 04:39:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 29 Sep
 2024 23:38:45 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 29 Sep 2024 23:38:21 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH v2 0/2] arm64: zynqmp: Update zynqmp tcminit mode
Date: Mon, 30 Sep 2024 10:08:12 +0530
Message-ID: <20240930043814.530181-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a6f13d-96f5-4ea5-155f-08dce109cfb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y49WZJScksZfE+4AE1onb0z91OqcOb+KDswRTdQr9ZgTMemWhMact10MjNY2?=
 =?us-ascii?Q?QPD2jXxY8u96T4tL6lU5Uka1e+R66GRCStP70kDR25fdz7HunVgGxmoM5NYX?=
 =?us-ascii?Q?hL2+u+g5DH+FEGvxXgxVMW6uL1NIuRPvxw3WLTqwOGagAKKsYV9l/cdLhm4a?=
 =?us-ascii?Q?z1AWYcocfPyBqe9+X6C8G9wTExtl0yJ8TAuN2z4Gsyfn5mPlTOXx74999VHO?=
 =?us-ascii?Q?k0Ctf8ogCTQtU5O4ts5SbyAyMYFPyKjPC6UtI4VvibDrqcMua5V+oniKyRkI?=
 =?us-ascii?Q?lvomj5ncoNEqcfC60MLQk/M4jS+HvZczGZbFLw0ThfiyjNXKocxjV+30NtNK?=
 =?us-ascii?Q?UUzy6EQ/1TxQ3APWERC+WGZa8QS2T+FHqbh6IGWSWARto6QyhPSC0NBngm+p?=
 =?us-ascii?Q?huA81QQHNiDSpYTK37PWqsgKIfABstiROimx7zbsPV0nggzmAT8lOLu8ofEu?=
 =?us-ascii?Q?xDXTs07CrHsJvdMGa267sh99YnuFl1WIFuvMMTpapvZEArYNUuiLNENwdk5D?=
 =?us-ascii?Q?gS10xWdbe8wQ/8xcC3wmnxJY2VeGYSWEHu6T3ww5WuX9frErzpL+lGrW7i9g?=
 =?us-ascii?Q?JK9OHf+111wO0PxDIdGoLU0GzntR3VY9n6wJMSB/uxXa1jkAn06ORCuBHY/7?=
 =?us-ascii?Q?CO+aY5R9vWAWjcMU5YdvWDghopTiBrwAp7EHEhbwLqrnQrTCOr8o4CCE5+ep?=
 =?us-ascii?Q?fPtQbk7nM5j5gqyxGv+iwdiOuW1n7wgxJT9RU1+vQPxcwUR2LN56w3Af+Gem?=
 =?us-ascii?Q?tuJAA3vGc3Vhwx2Bui35Qr5dURVV6Ms9E4D1tE2BQcCAoqZ7kvA0HnZBX2x2?=
 =?us-ascii?Q?wV+SIn5+Nc2b2hYsNQXyV99o6w7WoVWQulWXc6fJzxskVVp6MYQfElByxfHT?=
 =?us-ascii?Q?ZUJcCJsExx6RmJzmxAstjOddfMY0Wa3WtLRq+SCyX9AeHcu92R9YnzCm/YKr?=
 =?us-ascii?Q?EvpSx+te523ZUwJraNXG2XtZV9TEJxiUigK805x4PDcrFnhOD5wy8hS3vEcU?=
 =?us-ascii?Q?522T7/4zEPQC++GiPWv1+fS1qnuxWfGzOrQbZTXTCllJdmuiUUTsdRC9VEMv?=
 =?us-ascii?Q?FR7QcjOyDG/UJ18+LvLy/t2qpsUjLFWWzs26RJVosaciZfFv0t/FOk8XkEUu?=
 =?us-ascii?Q?dB2aMyqY8xupwtCZHBeHNkjEiYDm+/tCGT8YL1pXFmOplhmWNwMWRK+sZoUU?=
 =?us-ascii?Q?KBZYz2MTM+jer9e0K9dBmaCEC82NriBXHAnM2PAYpnlGKOsyf51S2w3ffEy4?=
 =?us-ascii?Q?DOTY4m07L0pjXazNoShsuTm74z7KNNU3ZyAAB+AM9j520vYrjQf8M/vTTwmQ?=
 =?us-ascii?Q?1IXBjrrrAmcSbx5Pk5hY8KXBBRnH9We9PVA1Pwqm1urifAHiWwGUVe7FeHd2?=
 =?us-ascii?Q?ZDyqYGa15h5XxblkpCeZDefcrRkcPyNaSK9GRnbkS/mgs45NiTHXhTPmRhui?=
 =?us-ascii?Q?MB7z2Nv+323X7v2iDTYSbREOUy6qGwd5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 04:39:03.3392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a6f13d-96f5-4ea5-155f-08dce109cfb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
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

When cpu is enabled, the zynqmp tcminit throws an error message
when switching from r5-mode "split" to "lockstep". When cpu is
disabled, the zynqmp tcminit switch from r5-mode "split" to
"lockstep". The mode value is assigned based on string compare
for "lockstep", "0" or "split", "1".

Changes in v2:
- Update commit message of patch2

Padmarao Begari (2):
  arm64: zynqmp: Print an error for split to lock mode switch
  arm64: zynqmp: Fix tcminit mode value based on argv

 arch/arm/mach-zynqmp/cpu.c                    | 16 ++++++++++---
 arch/arm/mach-zynqmp/include/mach/sys_proto.h |  1 +
 arch/arm/mach-zynqmp/mp.c                     | 24 +++++++++++++++++++
 arch/arm/mach-zynqmp/zynqmp.c                 | 16 ++++++-------
 4 files changed, 45 insertions(+), 12 deletions(-)

-- 
2.25.1

