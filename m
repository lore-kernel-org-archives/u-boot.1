Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B858C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 05:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4249681FEE;
	Wed,  2 Jul 2025 07:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dLSKqcDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D527982103; Wed,  2 Jul 2025 07:00:24 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 866D981E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 07:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUGmbcy38UkwnsBjvObtSj1mFIeAJdSLFAt1+Cegl4F/HzDZsfEpmhlDfh/hKYEfklhD/JXN+kMVVquMJd3ozfiMlJku49MnLpvuch77/1E4KUHX0SiTKxTqEzO5GoiWe0xeXMVt7EkVlarAQMfG7ARPvT78LdiJfzwnvII6DY1rtgseJVitYTT+DR5zuTuNgKuw5cqj8QISnILqOrttbAohUDarmn2VRabdWCInIAS4Psqox7FSWiOe+JHdYLPy56o/k6SwoS6DEbfC8i5thvgJqFjWIVmb2pqAPXRtXU5e4z3QtVNYxfvGTK6h0UgVeL9hTDxr0t2Gd/7z2Hq93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3G18Jg4e8/Qsv2qk9XrS8bopaISgvBub7Iv1rxPl8Sg=;
 b=uNlrG3DmjeVXnTW1UeLztXyRGWyvkKUH2KW8a85DaMcFkskfkclDeKZ0sFbYr4laW6zzPobdL330p3QcN2I4DNPgKCMG4m6CczOdiluLiJUFtAsVGdRY09o15k9468jHNrX+/E0oRVOp+16Z0XZ6fyGNv7dPSPero7RBfVgrakpXI1THj4chL3Z+qDrJZcP3bLCjgFEVYwjW8jkgDNOWWz5WQKIL7sznq4ZH5G6PtkIJ/YJwccr647qIamMRE48ajSVCLSU18GlBSG6idFQ6JbT6srSbu1aLbNU/HCMGlWukt3xJ8rZNYz55mcfjEPR0rtr5ErCgBPsvuOxvdNskhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G18Jg4e8/Qsv2qk9XrS8bopaISgvBub7Iv1rxPl8Sg=;
 b=dLSKqcDOHda1xIXRZBQVHzGxxi11AiVK4xGVCwS2noHHMTkKOAbB8NJKZ+FLm6frm0zR5Fvk5Nha5NXy6xp5EZzef2CNUn/L76vW9OxyokB9jTz78ntWUDqaz6Af9I3QU2vvHXhX8ffi6GkaIlAjbNra2UU9EhUg9x2Tf6W8OP4=
Received: from CH5P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::14)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 2 Jul
 2025 05:00:17 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::12) by CH5P221CA0009.outlook.office365.com
 (2603:10b6:610:1f2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 05:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 05:00:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 00:00:02 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Jul 2025 23:59:58 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, <marex@denx.de>,
 <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>
Subject: [PATCH] spi: cadence_qspi: Fix odd byte write issue in STIG mode
Date: Wed, 2 Jul 2025 10:29:51 +0530
Message-ID: <20250702045951.637071-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 8855ea49-3578-481b-289f-08ddb925563e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ev5jHdA3JaiVFnv0tcqvb8Jz9vphJuoBMrboSK9UkJppZk0pNpPuVx4d+4tn?=
 =?us-ascii?Q?K8Vq4BaA+NfLfsmta5kPhPfR9PHTcXE+8KqI38X74S5oVwEvlLIqrFsgPeyl?=
 =?us-ascii?Q?uqRNXnKC5xNbybdYXjRnKsl5Ji04jb4GGqhZ/gC4JwPZJ/2QPZkP20gKtTd3?=
 =?us-ascii?Q?gn8eZxtbtevxorg1EG95cENDDfVL6UYOb2BM8n5vSduZPuwp8hcKijUZutCy?=
 =?us-ascii?Q?NOEdVDbz8//P2oN+3jwT8H/97VWnhkukR9ZqUsks621BPn8rgZq1u+b6Cij7?=
 =?us-ascii?Q?yakFBUFE46/PBjHmC3fSkPoxk91Nqa682mEGJoYnRdi/ca24TwFKZwOtd6Ix?=
 =?us-ascii?Q?UcbkUy823EBs4Yy2wV/clbBMBT1qrvUpL9+tMhKbWvil7K3wnfd2JDkY94pE?=
 =?us-ascii?Q?ZUh8GZjL0NmEzq1GePakfeAdOFi9HCGOh/D90VUVG9nXiEOB/FNeca6XDKN3?=
 =?us-ascii?Q?7fIF2xwaqEATDFBh7tC9EM9gtM6+av1xZvoiVvX3j7GK6u5fCFykf93ITdZ2?=
 =?us-ascii?Q?VkkaL7piVe+B29ZLLoUcEoN9tb7fVncLFRZOszfTDOL4LX2CpGnnWzZjE8cK?=
 =?us-ascii?Q?HJ+v8nIZb3+Dpk8pTL8Gq6Arwe1cLbDcMEBzlZbUwfIeWk0Fe/xi2RpnHeOY?=
 =?us-ascii?Q?+sHZloHyVih0taTjLle1GUpZj6PaO1qvmOzs9rkN7+6tpotJnUCGNu4+3FGf?=
 =?us-ascii?Q?x/Qvf6YuaeD8n7QnyLevfK9hJqtWBWKCDuoa44QRWrCq5QQaKmpoJpwlO29Z?=
 =?us-ascii?Q?nzGBJ7rImel4mq2XfHdZgU21YD8KDb0Shb1YdXCNQdLTQ+IaOn57DRY8oJq4?=
 =?us-ascii?Q?/1VdnncNB/dcWu73Fl7t0lU5EH6Wu4Kt8WkaxWM0hQQNhiYFulOf/GRkzoM8?=
 =?us-ascii?Q?DcP3xO+q4nWnYxXxyPk6Uy//kNPw0X3iQls+0icx9fFQRnIa6CwpSXAGrPbz?=
 =?us-ascii?Q?+qy5LEh2PF2eGrntZ9uSW5XEtfaBB+Xpvcha2ez6f3rNnsmtkVPRUyuYWL2V?=
 =?us-ascii?Q?1z9PeQEfVJWWOEpetSgi/Juu+efxg5g5+K+DktF0vMt9eGuRNLCT6pPCJlb3?=
 =?us-ascii?Q?d4c/Yu7l9aJRixd+q/hlJ74IKR4Le9fMBuLp0jfKIdhqXv7E2EKyr5kYJfX/?=
 =?us-ascii?Q?9Lk+FG/NCNABoaN51dkGlxHNR6tOFBW7xfUkl3Sc/YoZoWedubaDaaykjts/?=
 =?us-ascii?Q?MR/5p66/bfcwzfd5A2gCpyDU/ZmZiD5BlTZjI8lGprwhZaSN76Z8v1BABqe6?=
 =?us-ascii?Q?p1pHzuRFPt2BaJfsJ6fIWwXefVWYE7GNNgG0CLeGPqmsAYMyAxUWy6KFGRj8?=
 =?us-ascii?Q?X+WO+clmV0OBDoN2Ku4mMJXJeYVnifMVMzaqp0blDowrs4cBFobnj8fGsY93?=
 =?us-ascii?Q?Asnkf32CTgQmuHLj+O28oM3DdrpjDqjapbY5suhV6NyToyiCoxe8Q9qffuLn?=
 =?us-ascii?Q?fhbxVseEEaglVPrNksJYuc7CBDG4Otvk4oI0rBzIiVhjPc0V5XkBrS0A0Ecj?=
 =?us-ascii?Q?FuYXeWj249e5pi2108lDFrbYtOYbR2rIdevv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 05:00:16.7797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8855ea49-3578-481b-289f-08ddb925563e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
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

Starting from 'commit <8077d296adff> ("spi: cadence-quadspi: Use STIG
mode for all ops with small payload") the utilization of STIG mode
has been implemented for read and write operations involving less
than 8 bytes of data.

However, following this commit, encountering timeout issues occurs when
writing odd bytes of data in DDR mode, as indicated below:
"jedec_spi_nor flash@0: flash operation timed out
SF: 3 bytes @ 0x0 Written: ERROR -110"

To resolve this issue, the number of bytes to write has been updated
specifically for DDR mode.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index b579699d2eb..c38bb523806 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -554,6 +554,9 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 	void *reg_base = priv->regbase;
 	u8 opcode;
 
+	if (priv->dtr)
+		txlen = ((txlen % 2) != 0) ? (txlen + 1) : txlen;
+
 	if (priv->dtr)
 		opcode = op->cmd.opcode >> 8;
 	else
-- 
2.34.1

