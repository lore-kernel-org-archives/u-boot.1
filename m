Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F74EE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 12:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0917086E44;
	Mon, 21 Aug 2023 14:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wdW9U+Rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5F08704F; Mon, 21 Aug 2023 14:45:15 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770408522C
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 14:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3s3clKc0hMh06OCenFf6w3bV8o2oF/eEJOrDgYZ2RthuhvdjW3dcUM1PZgylEg1HuDmFB61xajJhf17fowGU3dDPZAYNSTzotLvEsH/K0UGSMQQt1bzZSYq56uzZPGbpT2mNNMM8dZHHo9VsP2+5blLb6GvnjvVtbGXCM/Tsjyt7A0CoN/jFa5qj2F5gP4A27fQkrwArDKhS5uKAWENiL2usz918B5q+2tHFbzYMlyBFjIax3HWCNMgktN6jqfXqXEBbg4Fc+zzOrflV9AzmKxGP4uLku6YB34WRTBtTHLf+YFGmlX8dzDs2T6NB9u4TneYeBWa0LQIOV67vwDWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLopDnz2EXyYsygeIoeH0oB5wgSGnA8+26jXlklFihU=;
 b=bNVidMqVxS9PvrXr7Ezhc9jw5XAT/R9YSMtedyoeP3q3hCPdOpDdFPQGSsDlI/HVbNywtqna+QmBYVVffh3fxl5vYj5ZgqX7WkZLJkm9Pu1A+bVYOT5/o/5oVN6Sx9VadyRd5vWMYbtFjXNYktx/v/4Y4IHuNT3z2h+e4u2xN7cQYkf9vzfJIzvhpdBioFvifbG3bnI24dRvItDuY0yCYEZyHEg9vsJaxEDwbcAx4CGNo4m1yH05oOdjgNh0ZvvhI/HdUveCldfT4mwokuWhe/kh2uztw3J3A3riLUdtMzUPG1LeGPp1U07jSvgx13lA6I5JDumAMJCSxLLygQA16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLopDnz2EXyYsygeIoeH0oB5wgSGnA8+26jXlklFihU=;
 b=wdW9U+Rq20/AeH8nuJv3lF5xFJ5I7/H+2dtC7dMO2oBzgi6gktPN5jR2Lnz/oadP7AHYJj/3S7CtYv2Jq+kZi7svEN9zE0lwAOn6pooYMkumU5Pnn2MGlL9LUCN8lc6WhlZ823NHHz5Jf8u5KdlseAd242SaR4rOc26wWtOFmTw=
Received: from MW4PR03CA0040.namprd03.prod.outlook.com (2603:10b6:303:8e::15)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:45:07 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::50) by MW4PR03CA0040.outlook.office365.com
 (2603:10b6:303:8e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 12:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 12:45:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 07:45:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 07:45:05 -0500
Received: from xirengwts09.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 21 Aug 2023 07:45:04 -0500
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <ashok.reddy.soma@amd.com>, Neal Frager
 <neal.frager@amd.com>
Subject: [PATCH v1 1/1] drivers/mtd/spi/spi-nor-ids.c: add mx25u25635f support
Date: Mon, 21 Aug 2023 13:45:02 +0100
Message-ID: <20230821124502.3308208-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 713194e5-d284-421a-552b-08dba24472b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozzp/aT7TMIrLNhgFFQYBXAIyAlaFTwl6FF29W41Ur0gcwF4KRYN+NQ0ZOeTm6WVS8rYi53V6/BSdPHDslUiLsvpKqIrQSUPLVZzyO3osaE16h5UQBJfbkgR1vAhYVbYWdZXGGkoZd+lDDkRnBwrrac7Xn+dAwnaIanOWsgOlMt9SqzZOdRgavBBWhbe1twL1sQrztZt/vjhrNa+r5zbWIrx5WaUijFN96oEUOf/p3J22D1EF7bP8HkEjvW5jp79OXMoalUnnoDd+K822D9qEkH/vwV5zwPvtxVrXCSoODN8PqaVqvSMXRgbyru/SgZQVUUd9jwyTwNPs/qFMsZGw+xjCCJ8UB33Se9Lf7ehxbYevDlLPtxaGbS25Hn02QbRnOzunHJf2t9yu7adjYMs4I6Qon1Uo39q0kelRjA28D/9iClzh9cfw8E/U/I5BAPLKVnfje/uPe6WHDOcBgLtMNh21B5Z/gjNAbrlSo9kfamHJssBBwwvEIthmycb4ZYOg+24LxCALqU79Yne6xoAcXfe9BwN45Wt1UhiQGIyJvrmnHcwJJNTT7dY/l2Iu7VDnCc5WFLBqIcW0kMJOtzxF3gl2MQt2RyGyuiYxoRbzz3Lg/Fy6xWD81oA/HnUqW/9Rh1D7ILbGyM/Ys5KkMYb/Ef+wOLMKF+FWQ+LJSINi3KHTrLowTK6s2P2K1Gacb/Fxe3qT0ocTtaL0OSTJUD+v8rD5poRE++ZNif71pGytA4nxW7ubH1rpxo0K78OtDz7sdcKHtnUS7WDAotpLmznlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(6916009)(54906003)(70586007)(70206006)(316002)(8936002)(8676002)(2616005)(4326008)(1076003)(41300700001)(40460700003)(36756003)(82740400003)(356005)(81166007)(478600001)(40480700001)(4744005)(2906002)(86362001)(36860700001)(47076005)(336012)(44832011)(426003)(5660300002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:45:06.7325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713194e5-d284-421a-552b-08dba24472b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
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

This patch adds support for the MX25U25635F QSPI Flash Memory.

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index d0b49c4cf6..7534af684e 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -249,6 +249,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mx25u6435f",  0xc22537, 0, 64 * 1024, 128, SECT_4K) },
 	{ INFO("mx25l12805d", 0xc22018, 0, 64 * 1024, 256, SECT_4K) },
 	{ INFO("mx25u12835f", 0xc22538, 0, 64 * 1024, 256, SECT_4K) },
+	{ INFO("mx25u25635f", 0xc22539, 0, 64 * 1024, 512, SECT_4K) },
 	{ INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K |
 	       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },
-- 
2.25.1

