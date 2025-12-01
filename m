Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7493D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C4D83B9D;
	Mon,  1 Dec 2025 12:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pV4WKnbB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C17A83B9D; Mon,  1 Dec 2025 12:01:52 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC2883AAC
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNJaedI5I0eNPtGU+GB0YG6BNxZQesHgCq1bMJSwp95DzMzR38ujiPLhwlaQ4WKvcaRnWLjlAyZ7hfC0Vf02dUcREPrBLfam2A4bN5BoAm2hfJb1IDC9Ny/cEb3CBOmSMrc00j7hMjv9W6vHFEq89FnUQfITyZXsNWw6qpYRewguFl6xg/iYppeYeMkBwPhSCIpCFwX1xIvrYsK9S0zga3DmSGZCQIU1pssuh7JZzvk5wauw3F1mp5oyIGSVSp54k21CAqA69rFdYZ4/ZQktthZ/imwi6e131OU4JdgUcJCJGRWCcucMTUQgy6m1MErFht45Eeknee8jIw6BMAAHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4E96brVQFxhKaechqBrjFzCFlTBuopPMq/Ar7WHjB4c=;
 b=TRVtKyRm+amOqqFoMuMNsQm5O7QQT9hf7qcs4yTmD9blOGJYw11odHYeAdi99ynqwCV0VM6QDLiWn+8f0YnsVgvIlKtDUM7RZuyOC8xbAQSDrJZSzFB6UN+b+58ZfuvwX6Nrub2xHcuZV+cgyoTLlmJ4kBqqodFXKjKkmPATHCRuujuREAS6xJcYFmZzk6nnZWZTpFOPZ+ikYAddgSn0rD/TISTzGSqAdXcPozeHlbeo+8YHr/Ck9NzCRIbKzXrjvzcSoDsQTcuUUbeT5XzjiSnl18fhhlu25q86Gdy/eLpFInNPvxddnWT+hmJfdoXdAlp1se94Bk/8yFW3ZPYxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E96brVQFxhKaechqBrjFzCFlTBuopPMq/Ar7WHjB4c=;
 b=pV4WKnbB4/uvIhXuEgcWpzAOghxmyeNG5SzfjwBBxiaUMVcyKOxXgc0uB2dRWFeYQ1px59RC9IMQEg1cdF7R/6XWAq1m+sdOnk33cV8G8Qybq6Mcwe/MH6i2eMUdoet4AxnQK6C8aIL7EQf9RyyjTUNo3XMz/IaQV0Oe7rbY+aU=
Received: from DM6PR03CA0027.namprd03.prod.outlook.com (2603:10b6:5:40::40) by
 DS0PR10MB7456.namprd10.prod.outlook.com (2603:10b6:8:160::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Mon, 1 Dec 2025 11:01:46 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::e2) by DM6PR03CA0027.outlook.office365.com
 (2603:10b6:5:40::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 11:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 11:01:45 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:42 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:41 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 05:01:41 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1B14qe306512;
 Mon, 1 Dec 2025 05:01:37 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <m-chawdhry@ti.com>,
 <c-vankar@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <jm@ti.com>,
 <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v4 07/10] configs: am69_sk_a72_defconfig: Disable PCIe boot
 configs
Date: Mon, 1 Dec 2025 16:31:00 +0530
Message-ID: <20251201110103.845413-8-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201110103.845413-1-h-salunke@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DS0PR10MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c830082-956d-4723-4a90-08de30c9044f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1I4j23iIXUfV9723wfnMNw+23HqdBKWIhToiRLf3jZXxtZAI9j3EArcczlX6?=
 =?us-ascii?Q?ncxBHDByFzhnBVgkGnXMmbLZ7RXS3gd8lXefTY3oipEhAb4EmxiRzNZBdBmU?=
 =?us-ascii?Q?1YX733S7JyXkL75BPG9TwKkBqtb+Aif+PyRIe/F3HAH9cAoMLO8IDaLLrZiG?=
 =?us-ascii?Q?RBoshTnUXOi1lAy17QrHmOy0qe+ymy0bPJrfsnere6+1aCSpIzfW4R5+FdTl?=
 =?us-ascii?Q?uPL8eIYvBdMvCk73T++3P2+mwToL1SmgpafHktH4Jzo0gMzS6kBpm7Kp6Bf/?=
 =?us-ascii?Q?Rp2YJxps3YASn6MRN/JPg+KKaaAhuwohT/jSanLMnwXoGZJLsi7N2nOZxnN3?=
 =?us-ascii?Q?SoAx0+K07aq39BOFF+ER2oTreGzM+Krl3Vi4mOj0KU19xo2XXZafuVEzsAWX?=
 =?us-ascii?Q?8+8QV/QLfoDO65QPka+LwO6+/I6rNyBWKp2rAfRxUls3270zZF66qxTeFT76?=
 =?us-ascii?Q?RGk+aJ75w2M0T8D+zHabPYQtFBgvQru/0BQg0WXrIdWYj8i2tr5BkxsseHHM?=
 =?us-ascii?Q?SGGyxhNZpFsw+9aJoRroeZJqiWcIXjLspeo565mv/vQ9pLPX2yyFgAvjD6+V?=
 =?us-ascii?Q?ix9zBBflRBAy6kN1XAbTTIIeOjU/qstnbHiiABiXyrv2RBenSHtVKsegAvPT?=
 =?us-ascii?Q?8N4gYd27nnzjx/6UJi+WsyzE9wi67xah8v7pQ3cApXEUjhH7pAXjs0ufYws/?=
 =?us-ascii?Q?A4Jt5J1daarKTRnuwXpMmyqN/+DXZs3tdC7RwHIeMbGT3KN4RX4F2X4Qy4G4?=
 =?us-ascii?Q?AizATkhROBSw0Fg7CtZBPdcEBs04O/Y1fIjuqhLEaA0mnBX9Dz1yit9BQ/Vk?=
 =?us-ascii?Q?G6/Ws4Nf2IWbQEuIUdWyoQ7DOLJtSO55dxQEhrSlU2EJBX0WeDkPQG5wqMlK?=
 =?us-ascii?Q?GlpYwBpM7xlfB/l/dABljLGXq8vvI2JPWgJtzg97Es4yW2/v6Cmx3S8sKJut?=
 =?us-ascii?Q?GxpBVQLpW+MG37FwCN+huju5iNFzjT3TnXw2XLg/p/IOmgWM7n9Xx8JX6hci?=
 =?us-ascii?Q?14ZaowWf55si8U350adnQH+xj4RVqGcn6tyCY2PDhFkMR9J3SsglZ2ww+mmE?=
 =?us-ascii?Q?DiaQAabtSjlIlQfe4S1FrAsvMXVfUpoaunSk5Y5I00NAc34oLfRMPFuO3ub2?=
 =?us-ascii?Q?y4WzDhVrQAZtin8nQ5y9kpH8rQzM7ukKKmI90+OGQ1xD8REBcbrOA5tWiVFW?=
 =?us-ascii?Q?Rk1E1T/TB80zNo6s8IVC0G+Ugr8cR9rZtudJ3qTbiw/LGsIkGjAt+i80gTpF?=
 =?us-ascii?Q?qnGuv2GCvs2+6eJbMzxrBhwvOnx3qGqTUoAfytUH0Y9E1s9Jp8LY5pD/deao?=
 =?us-ascii?Q?B2Tuo1K4RSid41eQm+upL2LaBpOey2wcsUw1/0iK5Ioo8ItM1P4PeL5lQlIV?=
 =?us-ascii?Q?ANMY9TaWSmmUT6UpYwjjQYUkiUfj08fOosxjyBeW9pBc2hlpOGWO4qz24eh6?=
 =?us-ascii?Q?7SQwW8sIVUE4Bx0mio7k/m1DgIInaRr+isagdZcGwCbYs05egT+MreLeSy5w?=
 =?us-ascii?Q?J75E+YWTWSj/85ZM3DU+Awy1kZPaeQrPWKmQtHF7zvq61LepanfW2dFjSXe6?=
 =?us-ascii?Q?t3GfP6Cu9X8q5xSMHbn/wLil+DprJGah1EEYaD6k?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:45.1146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c830082-956d-4723-4a90-08de30c9044f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7456
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

AM69 SK does not support PCIe boot. Disable PCI boot related
configurations that are not applicable.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 configs/am69_sk_a72_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/am69_sk_a72_defconfig b/configs/am69_sk_a72_defconfig
index bd8aaf7f201..831fd974bab 100644
--- a/configs/am69_sk_a72_defconfig
+++ b/configs/am69_sk_a72_defconfig
@@ -9,6 +9,10 @@ CONFIG_CMD_UFS=n
 CONFIG_UFS=n
 CONFIG_CADENCE_UFS=n
 CONFIG_TI_J721E_UFS=n
+CONFIG_PCI_ENDPOINT=n
+CONFIG_PCIE_CDNS_TI_EP=n
+CONFIG_SPL_PCI_ENDPOINT=n
+CONFIG_SPL_PCI_DFU=n
 
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am69-sk"
 CONFIG_OF_LIST="ti/k3-am69-sk"
-- 
2.34.1

