Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30138CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E1F848DA;
	Tue,  5 May 2026 14:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DFCGCEgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30206848B8; Tue,  5 May 2026 14:31:10 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80686848F0
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTc3zYutxlAbBCABNpx8+xuGBu3qLOS/MwOxJwjqb9+MIRxSSfVEWLS91G7STGmYlpuJ0dD9QURPzKAT46ycc4K0/5gjp769+xwVqDmrEKu3p7qV0zNJvxDvTvp6G8NuY6yvvZmtWag8x0iucxlQ4n7jLsglOrvu6aWbfOB2Cb2LaeFyqFvgSvnAwW1RpZ4rjDvmFXiWyQAWewNLVddbryQG+nJwzIWTvv/q9b3RpZvn2wX1zAXHq/C8RkYquOaVWPaLazXDMZdUKgCFoZBzDAySQ1Tp8QE9rNMpPseF63x6gH02GlxJHWLnPoxAhwMzaRMnylUTXGKLxvc9gi6/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8FNvPtB/VdvreB2yhfBbe2AclBTutklWd5kDd3Cae4=;
 b=gZDQ7vklP7TlO0AIgeIiyn1ZqkrFynafeLKp9n+AuIDkfR0iZsZXVt1BLM1biuTVh86ZtZQ217PVetKvj7WeLLigtVWiZOi6ipacc3v9q48jUF6u2ajkyx3GErfbi3WoHAuT4UUSjdPFqAt+MqA13CqjVR2AhhDmvE0VGkUamZ2vfa7iCLTHSMRn4+NmxvSQWx93DjVQRo4MLz3IErG3YuoOpHV1Xg94019cKlBJNaPEVoCVDU1bi+Wkgc63Q8WpPAIPROWCXC0p4bYDd8KCCBlemnkDvdktoYrQ4nHs1GVt0fvzAqv6X6u06IBO3H4U9xZ/sIthS48HoW0u6+n/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8FNvPtB/VdvreB2yhfBbe2AclBTutklWd5kDd3Cae4=;
 b=DFCGCEgKpeNEDsRt+Lnqdo8LQPVM9W3A3pjn1BsW5CoQVRQiJm6ASQtsBbIJpZAFLUOmIz3ekTHvYE98mH8rBCijzDyeVvdcaPROOdf88J3ov5DDP8d3UIJ+B7RQgEJSY6+HTH8DqueZmA7WaBn8m8XueYjFJhykJzfUisSe1oc=
Received: from CH0PR03CA0287.namprd03.prod.outlook.com (2603:10b6:610:e6::22)
 by DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:31:02 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::f) by CH0PR03CA0287.outlook.office365.com
 (2603:10b6:610:e6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 12:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 12:31:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 07:30:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 07:30:57 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 07:30:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 4/4] reset: zynqmp: Implement rst_reset using
 PM_RESET_ACTION_PULSE
Date: Tue, 5 May 2026 14:30:32 +0200
Message-ID: <0daf9f917c0b9d7b34f69c4841d56ac5c3bc9c0d.1777984225.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777984225.git.michal.simek@amd.com>
References: <cover.1777984225.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=lcdM9YtyBLlDQoE59m726Ju03m3PFEFYPGTOSMBSa34=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT+fPTmnugS99c5/AlV3pNe9yfcCHsuOD1f1U4zcT/P3
 K1/Aj74d5SyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEzIMY/leyBp+q77hTONsx
 81jTFX+GkztWsWXc2ruJpeBStPaaQ+sZ/uffi4vcIX/2i9O0iva/8zKct+Qv0771f1NmqP66Bbv
 DSlkB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: 29df12dd-a2ce-4c43-a1eb-08deaaa22b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: rFmkif13BRHm8MAo5roops0cC/IE44ImZD6u86K5aB7NsQ/JiWRhCbLvVOOeuvEfTFNexSoGwsIjQiCtwVzbYzwU6IVHK5zNMrCRbIpFYBdfoqZeZolq9j9a2aXJ5q8J1OOD1fGn5Z92HmUVo95W7HUoaTywCTithGZnI10UJC2W3fcVUl1D0wgmROfsKN4FsALc0TB3XogRMnwbnoYO8XlOJb305Co5kFtaVTGcaElBsX5Ox5yCJz5HbUAQJy/AIHb2wZKnB+Tva5Sc7iG3TAqAAjbvoYBpC8FIgWVAr8DaE2CHrxKVMjy1HOxCGdYaxLlfXZnDVcySq0ju4zjhZuYJkDcn8+SMXIWrZ+6im0rOnrSwdCpYT6df4dox+0jCOZur4OX7TvcUBFm3HtGA+OMOVyYwi/euC9FG5sP71isY00dYQIpKkQdW2NXT9ZS+y2O6PiqKOE0sepo5A3x2qRAdQ/9Ns7t5o9ThuB0IfuQtNyHwBbXc3ZhTIWXZjAHIGmhC0c5PwlKL/GoOHAgeOsm4YfGplZXRvkf8Jp77fj3B1EuPgwPS0p71A/K/sfIxTNNvEr4qwpJqLLqjyjSM4Qd9/dm9UBizfs4dMLpQjHMYeGJujZ1P2sRFkOjZPnf5UDjbheIhlMwp61NwA96vgmpq4RQU/1HoGhrrhjGWALb7FvLzZgZDjCcznQI84sB1qRs/GohooXOCZGj1zTj3HpaoqXjIAAfPZrCromQuHT0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ju/KpAsaBzLvhgYXfPzJvR+s+xeKZlaquVIf7LdqtrnohmrviGzbiXaI0S4ZPySxtIDh6YGyZAB41f81GqT5RvtYS1hBZ1ch280Vg06Z/pwaUuXjbXdCmlzi0jQyWWtIhyvD0N4yBSqny8XWdQtbq57TIcvAc76tvXtxUl4XVRBdLjRtIulPnNIcUhQH3hzkECQ9nZowmfaY6xKD4qIN8FiwezW/CFCN/UAhrAV8UxfeETjTljzYR4Ht3IrZ2DJupsfVMs/Nr+1WCONXPZL1df3uLHV+bbRd42jess1YQ/MwhXjZIV65wsO5qQ23TX8YqPyqQKN4jkgwxgIXEgHRnwvUaVGRDdNONEhTGoSUaNFjjNMry9vsGoKLj+5dTq+kOJ/PraqtcEFlolJzRt2L6NEcY+714BOWYcP9HSlwAte0q1l6dAZ9TlProCm/T1yS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:31:01.6516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29df12dd-a2ce-4c43-a1eb-08deaaa22b0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551
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

Implement the rst_reset operation in the ZynqMP reset driver to use
PM_RESET_ACTION_PULSE. This allows the reset controller to perform
a reset pulse in a single firmware call instead of separate assert
and deassert calls.

This matches the Linux kernel implementation of zynqmp_reset_reset().

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/reset/reset-zynqmp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index d04e8eef3bb4..2b58f3a75b42 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -45,6 +45,16 @@ static int zynqmp_reset_deassert(struct reset_ctl *rst)
 				      PM_RESET_ACTION_RELEASE);
 }
 
+static int zynqmp_reset_reset(struct reset_ctl *rst, ulong delay_us)
+{
+	struct zynqmp_reset_priv *priv = dev_get_priv(rst->dev);
+
+	dev_dbg(rst->dev, "%s(rst=%p) (id=%lu)\n", __func__, rst, rst->id);
+
+	return zynqmp_pm_reset_assert(priv->reset_id + rst->id,
+				      PM_RESET_ACTION_PULSE);
+}
+
 static int zynqmp_reset_request(struct reset_ctl *rst)
 {
 	struct zynqmp_reset_priv *priv = dev_get_priv(rst->dev);
@@ -74,6 +84,7 @@ const struct reset_ops zynqmp_reset_ops = {
 	.request = zynqmp_reset_request,
 	.rst_assert = zynqmp_reset_assert,
 	.rst_deassert = zynqmp_reset_deassert,
+	.rst_reset = zynqmp_reset_reset,
 };
 
 static const struct udevice_id zynqmp_reset_ids[] = {
-- 
2.43.0

