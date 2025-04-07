Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C5DC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 13:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E3E82D0C;
	Mon,  7 Apr 2025 15:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TPq+LNqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FEB382DB4; Mon,  7 Apr 2025 15:46:03 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0A9C82CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJcXJnr+K0iuF/gHXdw1nq8U9vE8eaaJ1COpkakvwwUepBi3BfbVyMrRj8F2OJI/rLpmk54bUKUT8sgT8I6QJazWAy2YVxVXsY+CsJuLdO0y0VdmWp4ZMXr5nBYNM4j+L/uiI4Pm/US93/dSDvP8/z54j6yqNiV5y2Zpv/dEhHdAGvhvIBt8bghRpO21BpfLOYKnlSvD3RH9ogXjrJwVTDad5DVD+pnYen8r5Wqk6d+C4g13GOPQ6Mj98xjOrVey1FpfGvsNlERHJOBNOAS2vTO4nilwMiTH+66iCttxPpeUQx5rnuO2wG29F7CPh2yg6ST/CzQMd1oGOAR7bGGMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYN2txmXI4/xA0eT9HY0M+eaaHLOxkvCrSjJw7bIW6Y=;
 b=Yvy2aJ7jKihkROCsN6OBregV1V8EHnXZ+zhSAzmrkjcw4CWasrYufy1clJ2aGRtwgVaTx75VqGNOK9dnHUmAR5+lESbllq9Mdmci9/Q9wohx1xvdVtZNF/Yh3WdT7maJLbARG47pFwMUINQnkB55Rc/SdhTdY1nTUKdCCTkZlF4KCPHyc6l8RcO69u7lnQI87extlFySNiTjQ0te1gxO+ptj4rIL8smW6hBIFeqbJqR7W3VKyyEb37ofYZIUZFTEyswZskAZuLBX99VfuKbkhDfRnxkSbSPGfJsJHiwZBXiAGjwlVNhzi2rVs5YGxBZeh82roFNczDz8RihdXunkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYN2txmXI4/xA0eT9HY0M+eaaHLOxkvCrSjJw7bIW6Y=;
 b=TPq+LNqNh/LyphKaiOCWiBxdIJafdlziPetSfUwmxjTqNmblc8NXuc7/9O+pPNOsXIWxFkBvKHOJQ0ayfXNpAg4EkhayDRvfdLrvGzsSH/tLWGOkrd6559VVsczEH6px5VNniKhaDVb7VGPD/sRNogITFH6e11LH9QaVP8meuzY=
Received: from MW4PR03CA0224.namprd03.prod.outlook.com (2603:10b6:303:b9::19)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 13:45:54 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::cb) by MW4PR03CA0224.outlook.office365.com
 (2603:10b6:303:b9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Mon,
 7 Apr 2025 13:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 13:45:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 08:45:52 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Apr 2025 08:45:51 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>
Subject: [PATCH] configs: versal: Fix initial stack pointer
Date: Mon, 7 Apr 2025 19:15:44 +0530
Message-ID: <20250407134544.3951763-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e312e6-e3f8-4b29-909d-08dd75da84cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+ybahjW9+KeYkrhQjli++gIRLW9MHM3hu1NxviQDekoPDsSenmejRCS1zEB2?=
 =?us-ascii?Q?cDTdoqFTIrmZr/tXNnb+QD8+B6ZoZUb67AmC6v46fRic4GFHT5gu4sWEfmow?=
 =?us-ascii?Q?oYe2fCpm/s8u+OYybNedJyfOg90fIWlOooXNTOuX9GB+XVn5amDnPbw39Xj6?=
 =?us-ascii?Q?m9KoyiwXLFKDI1th6Yy31I6TxV0+w3MoZ5FAd7fhayIIRudFIa1N3SrT3kLW?=
 =?us-ascii?Q?nI2DAJOF+1bq7ZBxdkVvH/v4PVQksHzsazN6+zI7fp/zj74i4sR4nK966k06?=
 =?us-ascii?Q?60qMFKHpfoEllVXIlaVrg8TP9A3CaBEMafLPpHT8Fw4vN3TQrVYU4Li2p5cL?=
 =?us-ascii?Q?Zl15P1yKeROQa7UAsRV+uLCGg4QwUFc0IPbuz5VuFwvkEPm3O3I38MomqFza?=
 =?us-ascii?Q?8YBywiHZQCWg1YSddOJeS8i+UQaa/rOvY15hzfDC5cARYN2dE6HCmV6qE7yl?=
 =?us-ascii?Q?Vy+50FLjGjexwFy/BFhZUosAEtQCjNfrBYbD3JpBVQoVa9CdvX7loj0x6L3W?=
 =?us-ascii?Q?BVkweh+VQfHUIkRk86Nf9qLhwFRJiRJwHu77ai3HeV7CE6ZGkaeLkC01olko?=
 =?us-ascii?Q?cUjLGZDwU90A0FBkh2MKeQeZArUoQl5MSblw2VLATg5gBlLCmzq2JDD0sISN?=
 =?us-ascii?Q?ocp9xOJHfrw7/fvdXejwLoWm4EYbFW54XYy79qEflGk+r/6Sj6vQQ9CqW6UO?=
 =?us-ascii?Q?neY5JzoRIe+N3xscRGnWdfEgjok/VIkwmnLjwnRcw40i8KBmJaOPYZ8OvmLf?=
 =?us-ascii?Q?PlC9Bw1HaFRVqjO1B6/WnDd6l8HdrouoHgNXUA6LP33UDli/+jcOt/vblKrx?=
 =?us-ascii?Q?8AJ/lKDTB0Ps80KT5VY4ERcsEEtPK9s73xntCuKeTVwu7TqAiT40vORSUyWV?=
 =?us-ascii?Q?J5PMbX2gtlHBrS0qgvWF9OAVHqu60o52lyJy6M09eAdgBlTQAQHlubymdYiA?=
 =?us-ascii?Q?lsrkOQqOA285KIzPEfpqXKePIx4yv5gYyglo4KaCFtjhNrmk8a22wSSY0kor?=
 =?us-ascii?Q?Naj2RtXvk6eexJSW2GlW+1vWU+6/HndkUXgh99MdpXT1WebvU2prijwvi6Zd?=
 =?us-ascii?Q?U/mfI3Mo4mfbwnlNUhxtnCw/jDmh85hnn758PHtuEG69ruF4suM0MEuArWlo?=
 =?us-ascii?Q?S56sl6nZNDwvi8Ml0BcnZH/BBv2gosZAmeCp8ovrrjzKfyo2MvJWkrEDWonF?=
 =?us-ascii?Q?z7vFw22eHAbElIJDPVxQMm4oKhPj/ExMBS+vcFO6bOYta1t27DOwAvYPGKEk?=
 =?us-ascii?Q?ZparM2caxoC5XiY+N2jWjKSEWcC47XPVwnATF7BYx5O0w5iJxQKYQk93F3TO?=
 =?us-ascii?Q?oYb7yqCWEOBo/hXtPpIrpXlkrqb2l+HUyEdbsbjgpyAcQN4ObVCcmMlKiBpF?=
 =?us-ascii?Q?nULDZ0g1yR1JSL2BL20wq13hBKzXtMEBouhe5EuNa2tE7V6tksjTFqG6jOhW?=
 =?us-ascii?Q?74baEYxrnZXqKAJXYfzWtScl1SR2zfPisiNgD1Xd/+Kgo9RLpK9yoT2Yd+u7?=
 =?us-ascii?Q?7StCyc74zLpm2C6jpc6cEZc6Qod25Ossgrta?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:45:54.6391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e312e6-e3f8-4b29-909d-08dd75da84cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
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

The mini u-boot is getting exception because of an initial
stack pointer address is used at near the top of memory,
and while executing u-boot is assigned pre-malloc and
global_data memory after initial stack pointer and updated
the stack pointer. Serial driver is used pre-malloc area
for serial operations before relocation. But pre-malloc area
is cleared while doing BSS at relocation time. The u-boot is
called board_init() function and doing printf, relocation serial
driver is not initialized yet, so it is using before relocation
serial operations but it is cleared by BSS and got the exception.
To fix, change an initial stack pointer address from near the
top of memory to near the relocation memory.

Fixes: 685874939a5e ("configs: versal: update initial stack pointer")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 configs/xilinx_versal_mini_ospi_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index e1cdc186fb4..af9ce499169 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000
 CONFIG_SYS_MALLOC_F_LEN=0x500
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFFFE00
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFE1000
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 # CONFIG_DM_GPIO is not set
-- 
2.25.1

