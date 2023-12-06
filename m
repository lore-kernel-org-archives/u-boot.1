Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F7AC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F8886F64;
	Wed,  6 Dec 2023 10:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ot3H/0C3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3928756E; Wed,  6 Dec 2023 10:32:12 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E454786F64
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQY/iK13M9SI+Nix8/y4feVSXzF3P0I9CcduP/fTuT6Dac57eXioXhouZ+zsXQbqBw+cAi5U1VvrITwavo7s++lu9GSaZtSnXaWil1q+k/Y4i8yOG6sUO6UUBPl0Vvyj4g73dhrgZc17bJcvZomXeNJ2+u1WF/nFAE+Tj5QP+UsWSYc9JrLZa/fXV6xk86pR1rxeOr7QaUVXo0NJ4U5eID2f6IluFixvlSdmjUfqa28Joxko0bRpzcNdD5hlFQggKNJhuPdHy0UlkqVWxNLXZCn+Gsh615oWHLka3lKU7YTyiZZ09zn+G3hxGGGYKaIgyeLGy3OoEhfK7Lhfe6F5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTMxzbWUFvz0qsB7IkJnou34n9auXirQqy5KtfSlb0w=;
 b=Axx1qW729cJLCgZTe+W1P2REuIzx5C8IVp60sbT8kUzcfyHqygAzzwEOAKfpIWGgQ3HN0T5bH4BbnMHpYxqI6Zt+O3+H054ehHLyo+wzhI6HeMrYRzPyUyEq2vsd7FDCJOnTE7BStmoWgHFmpdQpeaONxpYXs7HY8eWs2LswG5ylnLP6Mzyq7LYok/yegWP3GXXUsPv06cKzIMu4nrOAR/rupU3XX3Y6j28URI78S/EFMwwjbnsRsXIMzms+WcgW0ZS2n/8RFfJkvA0tbMvHgU0mBylM3jeDSc/TZhvIC2bpkZreqZPf+42agkD0iczdq1/EN/pHLC2hUKtA+oGlMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTMxzbWUFvz0qsB7IkJnou34n9auXirQqy5KtfSlb0w=;
 b=ot3H/0C38p9EEuydAbnRS6RS5Pir96CRHBKBNxH7fIm5DVtUVXELoe8jJIbMfRukQRA3WnOH/cvlMtQNXbebhKN3naMrRdgewch+XXIcS4HN+9tTSw9CkhNSTr5bwxwGfoJdO+vIbirv0Nkl6p/h6NMsf6FO/C1V0tN51mZAsFw=
Received: from BL1PR13CA0391.namprd13.prod.outlook.com (2603:10b6:208:2c2::6)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.36; Wed, 6 Dec
 2023 09:32:05 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::ea) by BL1PR13CA0391.outlook.office365.com
 (2603:10b6:208:2c2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:05 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 01:32:01 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:31:58 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@xilinx.com>
Subject: [PATCH v2 02/30] mtd: spi-nor-core: Set dummy buswidth equal to data
 buswidth
Date: Wed, 6 Dec 2023 15:01:13 +0530
Message-ID: <50ce979f7ac4859e36ae17b4a168f79fb1e2dc34.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fc2f8f-8321-4de1-ce49-08dbf63e35c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klOc2rZQaaqO/0laBiafkTxauxlftB1QBbb6HxzE0wwFGAXdZdeoUx9Us0NEPwIeo1KhJ4lV5c0H8DoXhbEhh2xkmHsAhYKmhfdQ6oj9DLhWxKv4aGTz1WbR0kM2YBtKTHourCMFTDXR+PrgYVo5foKtEo6e76tj/m1LoG3Lzu/lIkAHl2WGwi3pdbtwAw18qeyTIq2bMnr5ql5uFdnWOUkxxS6ugUL7b+CxdwvOnt0E5Dy3hnkiG5kD/s+pt31XFdHC5rq40vbe+EGUSOhmYPp0r3zlHjBpVF+W4S4W0SK/cgbW10x3zElMNrdNx5PoDQQbPAUYJiRdYW0GzzfeWQ1U872kv/e3Ry8no2BkfQ6dND91OfM55G8wh9M4e4DH1r9eze0DpkI2ATAIQGWv/uo2PH1LNY4yeHHA49i3td1v/sAHlWugM/xED+yV6e9aT4g//A9ULRp+qOe/TocmbBja3OHCqCU4C5LR8eDHwbf5NyuwQVxTFHCJI8z8U9j11srPE262paoUovXjZxPAWyyNRYhn+PM0NOv8Nrv4JdmrOXmsRupPNNKvq7Amrwwde+CCdCIQEfVqyQmBzhACQwD2YGAeMvECXjBOxDOAiH4I0Z88ni+eTIdzLe5K+jzv/dth3AltGxF87K8kU+3V92SeHPHl1zi6F46hWDb3aYhR/yTqKGfYIq+9wwO5HWNshZZFUfSk5le79heM7Z2o2IzLuCa2UORtFqvOuKfCG6+mHiOA6c73y9XhqGYGdX2gXzqElBSyEs7thc0VYekgxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(70586007)(70206006)(36860700001)(356005)(83380400001)(82740400003)(426003)(336012)(26005)(2616005)(6666004)(478600001)(316002)(6916009)(54906003)(86362001)(8676002)(4326008)(8936002)(5660300002)(2906002)(40480700001)(36756003)(41300700001)(47076005)(81166007)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:05.2574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fc2f8f-8321-4de1-ce49-08dbf63e35c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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

From: T Karthik Reddy <t.karthik.reddy@xilinx.com>

In current implementation dummy buswidth is set equal to address
buswidth. In case of quad spi (mode 1-1-4), where address width is 1
the dummy bytes will be calculated to 1(8 dummy cycles) and dummy
buswidth is set to 1. Due to this, the controller driver will introduce
8 dummy cycles on data line(D0) during read operation.

But since we are using 4 data lines in case of qspi, we need to change
this dummy bus width to 4. This will make dummy bytes to 4 inplace of 1.
This will be taken care in controller driver by dividing with dummy
buswidth again as in below code, which makes dummy cycles to 8 as
earlier.

dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;

So with this change dummy cycles will be on all data lines(D0-D3) and it
is taken care for all the configurations(single, dual, quad and octal).

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 473d9f41f3..8949dab548 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -260,7 +260,7 @@ void spi_nor_setup_op(const struct spi_nor *nor,
 		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->dummy.nbytes)
-		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
+		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
 
 	if (op->data.nbytes)
 		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
-- 
2.27.0

