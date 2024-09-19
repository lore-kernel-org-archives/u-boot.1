Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBB4CF3942
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6974289191;
	Thu, 19 Sep 2024 16:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="gGhhf8OG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82D3089193; Thu, 19 Sep 2024 16:00:40 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639F789141
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infinera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Joakim.Tjernlund@infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYSUvc8XTI4eTL9J6NDRAYr95oRwFEUA0EMBO+JepLP3O5qvwj06fla5WSHiuvmbdftd6M6YqjtZR5qnI09J5P+sKF4mWEfmjLCkClMWYRQvk5LLy3zFA2aABLb7T7xodKFmo8WgkBlB8KA0DLIcZiaGN93QNIVqASq8+zsKzLpBbgmJdaeSMOzaoMasXblwstkX8WuvDlyKrawI61K6NQgE3anOkk3Z02KA8ybOkga9rXxNiOoZjLKmH+gX0OZ7TZCLcOuq8+lxTgaRfpCGKsNQoNQneRR95dvc9nQHZoQz02NZ5E/z1rZ1DH2uqc5oKreSLWNDRiTjj/GBHU3Q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR5/lNqeyCybQYJzXZWrLO8R+GH5bfoD6BPPOVKEMH4=;
 b=V9S4pbxslzud5SaMlKQCsdKiudMrDMifJv8zzOYyfpAPCml/24q5jYvPDeFEHW5TFydm4EZk9jKlpzZKJO9ON7KpSsxKo859Q+WOUriolUmTbhqg/u0255mht/WVwHpdOhohYqjJN+HoDrCS6Q0zNSNGF0npK1buZlK/oVEtar9l3meMBRTj3/1XD0NVgfUzyTvVbhoYG6v5sP6ZbaG8YoC6awtARL0YE/rLB13Gfsh3HfzIsFlqCY2sSUF/gnAvol4hdKs7Szg3mp3CQVKnH6D6LBF8iOMNWP04fbScyE80Rt05G7xjjlFniVeR0nSmM2IBiZst32i1jJe35FS6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR5/lNqeyCybQYJzXZWrLO8R+GH5bfoD6BPPOVKEMH4=;
 b=gGhhf8OGuRKL/LImXiuPwXYlnapEwuLF1EDip+LAeSRkSZRPg6dgm4y1S9EkfMRobyBtuvPImP+xGcwEgAkr4HEBTMdEwIoZjBncPOjvOGEPL3bbOjoVJeKQRifRQBvlsbNGFLyWUmv5DiuyuLmBlASUzEJdZiOmvnzf1aPn6z6GvPbHYDonueecLluhEZW2A7TKS+5hXza3mbGxbOkSTkhd9yJ0cvyTiyImyLIQYeM7lEubX9Eavo0NgSiJTgdzsbADXp6gzbG0YBnpEa2y2NOnEHGyiqt4yMVBOR+bI0osQRX10920M4FeFThRaLR5TnETieZe5o1UqUnwNccCSQ==
Received: from BL1PR13CA0086.namprd13.prod.outlook.com (2603:10b6:208:2b8::31)
 by IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 14:00:32 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:2b8:cafe::19) by BL1PR13CA0086.outlook.office365.com
 (2603:10b6:208:2b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18 via Frontend
 Transport; Thu, 19 Sep 2024 14:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com; 
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.1 via Frontend Transport; Thu, 19 Sep 2024 14:00:32 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 07:00:30 -0700
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 07:00:30 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by
 sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697); 
 Thu, 19 Sep 2024 07:00:29 -0700
Received: from se-jocke-lx.infinera.com (se-jocke-lx.infinera.com
 [10.210.73.28])
 by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 3128BF400FD
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:00:29 +0200 (CEST)
Received: by se-jocke-lx.infinera.com (Postfix, from userid 1001)
 id 241434012B1B; Thu, 19 Sep 2024 16:00:29 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: <u-boot@lists.denx.de>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH] FSL DDR: Errata A009942 clears board cpo_sample
Date: Thu, 19 Sep 2024 16:00:16 +0200
Message-ID: <20240919140027.409614-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Sep 2024 14:00:30.0172 (UTC)
 FILETIME=[497DD1C0:01DB0A9C]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|IA1PR10MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc96f40-fdd5-40f6-9017-08dcd8b36d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AEZgoyP0covKXuGdJgIj/cCP7h9OyQH/pFReMxp/8l1E78mOl+GwoQ1/uk5K?=
 =?us-ascii?Q?aE3Vy+3NnCiVvuMEdMZ4bi58xlKR23lxyiCVGuawsQrx54XIEMYDO/kmpXl+?=
 =?us-ascii?Q?pnHAzOW9/im5npTKgveemUYjgFrmVSMZ1dV58JjRRtSzoWaT3xWJpbe9aoWd?=
 =?us-ascii?Q?5FJa0D3gY/sZ3Bl9u8KnhSpQ8ZIrDbErbzwFC9ZSCa1MZEopGddaR0k04YwY?=
 =?us-ascii?Q?vNZcXdA/twG9pj0bvYf9LtyMmEITLXiZH4b34oTKWR4OCxtybpqD6ENv98s7?=
 =?us-ascii?Q?tzYruSUxJg+QyuAm278utHbu/yft0Xh4S8FDh9GpS8ZPbCRbuCy1lclV4AQu?=
 =?us-ascii?Q?tenek/4zL05eg6OUPgskzOz80HQZKYkgyjABDmH1P0h8NZSepAo+HGhEUvvy?=
 =?us-ascii?Q?WywbdR2oExahf4HOakfNWN0z6YetjLVeTZc9MqM+73uZFf0CaBSy50EgIgpy?=
 =?us-ascii?Q?cSIY4aANX8oIH3xjMbXeD3FNhcWojmrNHSk6jnlHblJVo2BAOGABs82NLoqd?=
 =?us-ascii?Q?uyCRXY6HKX+yaWME2DzTOYgtbhnEXhupS3oiqPfzCvdbEpRnjVVX7mwYaqBg?=
 =?us-ascii?Q?b9i7kceG0n6VSg6HhVSZq2YYWDZ1gsFaOQjmI/eQ08bfVd1MI7oNRm/Te36p?=
 =?us-ascii?Q?S4astVPqxeUwcK4mY6tzeNsEBibvfU1tfgxXaQ/tWeWcyiB9YJg9ShWubdgU?=
 =?us-ascii?Q?p7E4NdhdnwF1HruVY41+EPrmGMGD83X2iPyrKys6EdASZAEh1FYhbEwdcKvl?=
 =?us-ascii?Q?QPZOrIj7v4PoQSR/7lX17z8l2FitI7TWda6mRuFg/QNNxLZi2RMnz0AEJVda?=
 =?us-ascii?Q?0GVfATsx9LOg48V5Sk4u06v+VXAAJRrJY9oDZ8aRzqZhfYG3Zweo2C7IB5LD?=
 =?us-ascii?Q?VNLM2j7Si/NlBoJshipB0gARGn4wihLc2QuICMj1xwiPmea95uXnG0hPr5mk?=
 =?us-ascii?Q?MV9MwXnAReJWz37MLFXpXYb7m7EZ22W7ZJv1uAfybXz2KdFG/JdJHCI49ZDa?=
 =?us-ascii?Q?EPPwB/gr8b8+L1EGdr7TKvDavJRqsvp5+bOQLF+kCMK0Q3Y+UglyLg1SRsXd?=
 =?us-ascii?Q?rUO0wYIva7AvFEZzECvjIP4HCGg3XxYu/8yes34hRIcwIOt1TJOVUH/uyYGO?=
 =?us-ascii?Q?Vr5TB5D/g20MbYLEFPQxdbVbBT2fgNYz81rOG7yhyRK2ZiRw8R8PtKd6b8pm?=
 =?us-ascii?Q?wC0pOkmxSSs7aCKMr1NTKr8eRxcVdN+yNT0iN4HRHQYr8uLuKBfNrEBoPWCK?=
 =?us-ascii?Q?Ubrl1dHW9K7mUBm+ycxWK945cNWAg+2odWac0qhpWbjdmyivol5wwtJ50xz0?=
 =?us-ascii?Q?zILRGUXLyq5zw8PlTjHK380AtziuO9avJ6wAAgeXsBl27LQJfy0oecDvRVaf?=
 =?us-ascii?Q?RTjgvZ/A+g4FeWmMy8oJfC9rwyR9re0EcHvZFS1yNN3YDFKmNKNrMK0N2GsS?=
 =?us-ascii?Q?jM4tbxkU0icpUIRqCzq2oFlvmEeTqVGL?=
X-Forefront-Antispam-Report: CIP:8.4.225.30; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:owa.infinera.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 14:00:32.3053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc96f40-fdd5-40f6-9017-08dcd8b36d54
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77; Ip=[8.4.225.30];
 Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7447
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

LSB in debug_28 register is cleared here so
previous setting by errata A009942 is lost.
Save and restore LSB in debug_28

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 drivers/ddr/fsl/fsl_ddr_gen4.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ddr/fsl/fsl_ddr_gen4.c b/drivers/ddr/fsl/fsl_ddr_gen4.c
index 31c58d9a8e..1f8ff87a8b 100644
--- a/drivers/ddr/fsl/fsl_ddr_gen4.c
+++ b/drivers/ddr/fsl/fsl_ddr_gen4.c
@@ -477,6 +477,8 @@ step2:
 #ifdef CONFIG_SYS_FSL_ERRATUM_A009942
 	ddr_freq = get_ddr_freq(ctrl_num) / 1000000;
 	val32 = ddr_in32(&ddr->debug[28]);
+	temp32 = val32 & 0xff;
+	debug("cpo_sample:%x\n", temp32);
 	val32 &= 0xff0fff00;
 	if (ddr_freq <= 1333)
 		val32 |= 0x0080006a;
@@ -487,6 +489,8 @@ step2:
 	else if (ddr_freq <= 2133)
 		val32 |= 0x0060007b;
 
+	if (temp32)
+		val32 = (val32 & ~0xff) | temp32;
 	ddr_out32(&ddr->debug[28], val32);
 	debug("Applied errata CONFIG_SYS_FSL_ERRATUM_A009942\n");
 #endif
-- 
2.43.2

