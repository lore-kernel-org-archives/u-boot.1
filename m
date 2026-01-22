Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33B2D262BF
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 12:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F9608397D;
	Thu, 22 Jan 2026 13:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sxeLAy5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4353B839DF; Thu, 22 Jan 2026 13:50:50 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F0C80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 13:50:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxr/jcJ17T9rPZL7a2Ue4zdcm4MXytTxTRGum3vOKG0tQ5NrR9cqToTcyXx8eKkLqYmv+33/roM5GtPSZ+DagaQKrXPVDfElL3RvFmpPkVcSDV1mageJYHHcTDarET5Gz3/8mefIJozdgqXBcVFaevaczfWoQwu4DlD5gH/4hlGrlFpDYpxfxdhauaJTSP/XaW5CVvC5ExmHhu46Pd/fJFLY+R1R9SYTEhxVXLk4KhrfQcQP46lKdPk6snp889zi3hJFWSorZUHCF7gShNPgUXWkD2GDgvCeFhLjKNiH3jFPLuzj2dH05gp5ZWc+4+7JRXb+gKMVUGiPBh8NzsvduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bT4I0oS+4C6tHVSt1l0dLYdfmvvI6Loc/nfxzjYNSg=;
 b=m+zRcNoWKpOxlqs8DOJFfdS2SD37Su5LFiaTe+u/7E+nI7kWIj+HiyducE65R2YYsEyfahJ9X0/3vhUW5zYLXdImacUvv95WhGUryHijOZgsM+KfLIAuuZVka1mx0krZvd6ta1RWN02Sti7HLpa2jnyWnhRzREXLtuTfRGlJz+8cPzenXVELuaF67kh6fiL4V7OSsKS/NWFf5Ame7NVmoLxEHpbKsZ2eBZkN0U4QxHWDAT1mci9PeSWMjmCHCrsMl34SY/Abf7pgZFb7GxvRyzIhQdpWGsjJUbGzGZvKCu6nof6jbN9Lus+nj6Qu+4q4HxwbEMzVpzLGsxWecLseVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bT4I0oS+4C6tHVSt1l0dLYdfmvvI6Loc/nfxzjYNSg=;
 b=sxeLAy5DyMqTS8TG1ujCVEBlL/7s4eiUGBGpCJos1lRljju5+KZ5uY0FP+DBHCgdKcYI9xSoVGh8X2AmWnsvUghg9c67tiVb9qfXuWN4hEM0n0qOd6pDZfN7nUS4xFfZNL/yCiJzDK5Mp7Ou5QXyk47VHB7kpKkm3R5/1NIWHcM=
Received: from CH2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:610:50::32)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 12:50:44 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::56) by CH2PR16CA0022.outlook.office365.com
 (2603:10b6:610:50::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 12:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 12:50:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 06:50:42 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 22 Jan 2026 06:50:42 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Anshul Dalal <anshuld@ti.com>, Arturs Artamonovs
 <arturs.artamonovs@analog.com>, Eoin Dickson <eoin.dickson@microchip.com>,
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>, "Ian
 Roberts" <ian.roberts@timesys.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Nithish Kumar Naroju
 <nithishkumar.naroju@amd.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Rohit Visavalia <rohit.visavalia@amd.com>, 
 Simon Glass <sjg@chromium.org>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Tom Rini <trini@konsulko.com>, Utsav Agarwal
 <utsav.agarwal@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>, Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 0/3] gpio: Introduce gpio-delay driver and enable it on Kria
Date: Thu, 22 Jan 2026 13:50:32 +0100
Message-ID: <cover.1769086229.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=S75B9OXkwpqeTKPdLX2wunu1vvdieWS+aA6CLyvpB4Q=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQWyUpmB3G/zl0suW/x3Jn1TwRDz+17FShvlpFrtsO5z
 Ir9Y9vFjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjIiVKG/2EPbAomTv7QlZOp
 G3jgVPYaX+4jvpVq+dfZ5969XtuwrIORYUXxMqk993T7zF5cdLr322vqLJejwW8tFwhkzFfp8dV
 I4gMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS5PPF8B1E59479:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ace98f9-12d8-4229-7366-08de59b4db2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ftIMMxs7DVrpIk59nQRGSdca6bg4b5WEQsknFpxogSgfrJE1Bk30ugmP1/E+?=
 =?us-ascii?Q?xV5K01e6eGcynU7tKu8aUrkpw/K9VYC4CEifIdSE7zj056e7gmphZTkspZub?=
 =?us-ascii?Q?0Qq2Np91zMKyS/2jU85eCrOYVRk5Edih6kpOortRfVz0pM3G1FUDp/VsCd2V?=
 =?us-ascii?Q?WzY2DN10eeZPhf6+Q+2Dv2MNHBnb5WZqSVnCvncuYRSOucI/uiVPuxT9BEW0?=
 =?us-ascii?Q?zYhIqb5FhQIPdBiLlS+SaCYcOQbL34pGQUG6cisGoHvBz1QTIr+I6piBpj7j?=
 =?us-ascii?Q?HTKvwpCSFjbDFsESXcbWOs7EaDRYaAca79F4LCOkl8ejX9k0eo8tZdMB55TE?=
 =?us-ascii?Q?kk3vTJT3tzs1RCfkuyq2/bVLMWkpdm17TQ6vchELoDommXNA8N9a4Ajhjpoh?=
 =?us-ascii?Q?w6tPPxVujv4wqyNeH/25qw457JcgShgd+eQYuzf5viI6vs8AdXTrKxzQfFm6?=
 =?us-ascii?Q?ImOPKt0o6qAQkEqRoTaDc/zLzHFh2FI2FUdnv6Uw/ial3veI29U+0bP3+aMu?=
 =?us-ascii?Q?XfuX9x/+KIaRKmi/ll1rke5/2WV8ByxsbaKuZK3PBTaP931ahW7IfwAP/6X5?=
 =?us-ascii?Q?p0wGvbeiRT5gSuDSo+lTrPiTEwbumi8gRh3iTNV9H+ICz4fyg9zfOSuXFScB?=
 =?us-ascii?Q?TgkqW6ufGYFvkw98QjnlOJhE7MAha6xQv8Ln1TGd2cQ9UmjeA4I4D/vJwGAC?=
 =?us-ascii?Q?d8V1HJlEqohNET0cclLD63TYmPGRqe0PlYGDo0OkdiNnypQzCv2pj/vFp2F1?=
 =?us-ascii?Q?oiQ1ZE+AalqjfiFFzEgP2aLE+yMYB02FpN94jU8dHXfBesAE38wFB2/ARDJ0?=
 =?us-ascii?Q?aDoMlirwXVNpL+aYoIjMm7gLoeJsSaVYACEeSPFbVWR0fKaxo7DtiYV35eOB?=
 =?us-ascii?Q?aVdoGcdHCIijYGBcIX2MuBr6RnuyxAQ0Y1t1/+lXAToybpdPI4VGkGHrGymW?=
 =?us-ascii?Q?f+DvVzK2DHFpadPMT1tMbK7CMePzTOClQzujk7BHnX3BqX60xUnv5W4HdUnP?=
 =?us-ascii?Q?Kq68HnwTYKe23plzpUeyU/fbaJr7d1CG1/hOBicjrT++MV2rL2TCadrEi50G?=
 =?us-ascii?Q?NtQ4F67uKCOiHCKtORsRtjqAEo+cZBs9gzwiMBS+TExa1iojVXDHIrIj6s+m?=
 =?us-ascii?Q?xqP/bDdY1LV4xCm/hNDh6qYBJh4+e5x9EpbhxDK0Q5VDGVq2nOAxSM6YABK1?=
 =?us-ascii?Q?ZaS87LJeptkyYjkKNZ7J6wyJi4SKTqAfmEAI/hLwyt7aIcYpA6wVO7IumM3/?=
 =?us-ascii?Q?cOU2TBf1SYCOwg4VTTxQpT7mxJxPxoBR/kh48maqB5DoDsYltgKLsiZIFL3Q?=
 =?us-ascii?Q?JZagUUF3TNQX9UKWOGkzR2GuIYApZif5hN9yWRHXWV8UZSS8o0kAi+EW3N2v?=
 =?us-ascii?Q?pNKDNvWyXOVl1QVno7gIgMNQBEpuX/0/S0SqYPlxycgxok3bY6kN4eB0xjcd?=
 =?us-ascii?Q?Vv5opB4v6h5xSQlCsH2I6QQd/G4sI2p5VYZnvVWjIALM05sKfWxyK6jzs4oi?=
 =?us-ascii?Q?s5rcd/K46e4rYdlT+Chq7h8e0oErOPgChMMDByD0kKfAN1lNT+I6ycp6gbAP?=
 =?us-ascii?Q?E6Uild72Enhe8cmb90IVbnqn523eNp6H4nSm9sPPEeDeGa3Ot9FEsGlubJ9t?=
 =?us-ascii?Q?ZfgSFmxSYYZKoiWVft1/byRmIdUR3fM9wcruk6YYiJPuheWwb5jOkS6+BnJ3?=
 =?us-ascii?Q?rJq4pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:50:43.8692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ace98f9-12d8-4229-7366-08de59b4db2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8B1E59479
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

Hi,

we need to wait more time for getting USB hub out of reset to be able to do
initialiation over i2c that's why use gpio-delay driver instead of changing
waiting time in usb hub driver. Waiting time depends on gpio wiring on the
board which is in some of our case going via SLG programmable device.

Thanks,
Michal


Michal Simek (3):
  gpio: Add GPIO delay driver
  xilinx: Enable GPIO delay driver on Kria platforms
  arm64: zynqmp: Wire gpio-delay driver for USB hub reset

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso |  13 ++-
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso |  16 ++-
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso |  16 ++-
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso |  13 ++-
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso |  11 +-
 configs/xilinx_zynqmp_kria_defconfig   |   1 +
 drivers/gpio/Kconfig                   |   8 ++
 drivers/gpio/Makefile                  |   1 +
 drivers/gpio/gpio-delay.c              | 133 +++++++++++++++++++++++++
 9 files changed, 196 insertions(+), 16 deletions(-)
 create mode 100644 drivers/gpio/gpio-delay.c

-- 
2.43.0

base-commit: 1b94b48043bd77fcb837704cba4385e14a4a694e
branch: debian-sent3
