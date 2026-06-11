Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F97CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 10:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56423839A8;
	Thu, 11 Jun 2026 12:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yRBfO21k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 796F083FEC; Thu, 11 Jun 2026 12:54:02 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1517D838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 12:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz4gEcnbJiQo9o4xKj4+88BkEZNrPxDdq5KdG/nMPYdebtAr9yBRIR/FFwS71qht+XrkVLKeUZrd1D/TesCXYUIUoECeNhjeL03X8Q77YIkev1FWJUzPi9aNvnPRxxr4Oi/t0zGJzmP3gEnwVZvzH8ZWjQarMrpIyG9jpD6URXTS6aV/FveaZiWyIA/iT7soz9jSo0VUf0mY8AFwLjC2kaeMqvVWzv2XdDs4HRT8fM27nfMUp1cnofnEN6YQDrlTVV74LO/PUgE0Lub6DsHjxEHVeXVfyYDGL7aVmAs0qu3nJZk0QdToJY2BngrWCsqBpOoVzweBL+5qtj3b5OMu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJNj3J/5KXExVEY9/GDhP/CRnl80j/kmjnNeW7HDo20=;
 b=Ke1X1FG5Njmg5sZnFjTwlFReMVgbVBtWwtyWCvN6AaR4u3AucwdI6edITanWFGZqu30uFs31XrzbqGSHSRC+XU2CEnMGEwWkhfzCFvg3nJ5POSabURdeYMWB3En3k5zCpTy51jXGG/knwThxSXINikIEVBOjTISCYwwYBrKF6y9jC0K5K7vhO4YLQMjCg6cmi4ey1sGIzyspisl+fnlJToqzb+LLX58YN5iDqHwnYF+VMT10cJEy4pQSWTLNIOBSWteV6l8nWPCDPfaHVzXBuz+9gYupn6f8pIxdOUKIZgpbYRvCDSu8nKr/+CXgi+8POY+xzivEMpd9crPekEjhhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJNj3J/5KXExVEY9/GDhP/CRnl80j/kmjnNeW7HDo20=;
 b=yRBfO21kE+Fnv1PJ2e/jvQFriIo72XOlAdDTH0dt7L6Pa32wCpWIn25miFa09h4O12oelOyukLsdca7MK+XSdiefkatac2NnEfUquOzmUsPBChVbSa6WQxpTPJ7EU4v+UwYjoaLtmnE9XwlyT79qm5q/6bWqZ88bdPAjqLi1JkQ=
Received: from MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 10:53:56 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:236:cafe::21) by MN2PR05CA0060.outlook.office365.com
 (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 10:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Thu, 11 Jun 2026 10:53:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 05:53:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 05:53:54 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 05:53:52 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: spi-nor: fix dummy buswidth to use data bus width
Date: Thu, 11 Jun 2026 16:22:48 +0530
Message-ID: <20260611105339.1595098-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 93dff845-d88b-457f-63d3-08dec7a7bb84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: u9/w2GQTjn8ZgGpEllcYdLzX4LrWN6BjGts3J28uJo9KCB8fw6dgqvNhBaxNlkDklAUzuORSN4xrOMw7jxP4Z91tU7xk8l6RgOR0lNU3okC5lAdQ0nC0Z27qsiSXP24tR5q806vNtwlo4LRZaflzqtQkt73/SmLBNTe74oBjY/g9ALXaybyLTXLSwxAhIyWv89onmcWXzIjp8oSuOn8U/p/DoXXMLOJvvMQycUH1+HjqeYpLvTktPIf5wOxXV9ZQYXA3Gnhob85bldFiSFbJaeEFceay88hIxO/ME8hPzwFY0+Hs1S+amT3KODHlP6T2UWzvJAFTAtkMqhRuIzdzJdAL1+lQSzcoD/OMx7ayqCwzsYpfLaMaQabDhKKXB4fN+J/sPLi4gBDS61KDYfcrM1wUE14i6Q342Lb01zuTM+JcJp4TdTilOdfO5xwdrSeUaeyrYUVPy+ew/A5YXp1GPSbfFyssKU2KpzQv9Mq9csi6PPF6Bv8hupB1LbqdI5bsV/lbp2epMYz5MUyiCvZkAwnyos/eAjOV0j0UbkvD7b2MxttzcrFMld9qisaCnZspYdAVcbzHFzybArXvOqcnEBI4m1YJbOT+ig75J6vMDxwljpRLAS4fXr9jIEljqXY0t24ekduxv4qdEKaji7anmhgQ1rJq/SzrmDQlfAdOPtYwgmVeV1wJe+SgqGNPYzfkLlTPuI1ACV9xaic7Zw5JAUQAM0ceEbJ/YRHvca9KRQs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(3023799007)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wbqJi+cHaFA98GpPA1ssFHEujwmBEpRglgFbyJUR+fVMohcSfJug24LBrCD932vgfh/TP48DQsmkyrbF+LoBEs1xJ4Y0O1Rlw4tscHXFjB9TdXp8aK+3W4Pq68impFecAl3Qcj8QQVpYdCorG3gCcDIb1KRA2k2ImdsvS1CqmguIyol8MkHLckP6O+sE+QA0Z+rimUEt6uuHK8eDwJ1a7XPRcXMVr9mD6q9d3CfsMTMCOycxdgyuqEKZpN9TSHQGQEiIJ4uKUkUqPJeevK5JDnrhfEDrl7XmavD/SFnRNy6Y87lev4BSehzbQbyDKkRof5CKqJFAWcnZq13phDLix9UoZ15j9uO5kpeDjWDXjRhs0lTp3g+tBtc4CgxastQrCzs2V3y3JFoqm1PBFemefX6HM1uxrzv9J0XVmCvEC5knULtO7znk4JTSL5T5BkZg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:53:55.2210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dff845-d88b-457f-63d3-08dec7a7bb84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093
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

In the current implementation, the dummy buswidth is set equal to the
address buswidth. In case of quad SPI (mode 1-1-4), where the address
width is 1, the dummy buswidth is also set to 1. Due to this, the
controller driver introduces 8 dummy cycles on the data line (D0) only
during a read operation.

Since 4 data lines are used in quad SPI mode, the dummy buswidth should
be set to 4. The controller driver computes the number of dummy clock
cycles as:

  dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;

With dummy.buswidth corrected to 4, the controller produces 2 clock
cycles of dummy spread across all 4 data lines (D0-D3), which is
equivalent to 8 dummy bit-times, the same as before. This fix applies
to all bus width configurations (single, dual, quad and octal).

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 937d79af64e..19446265cd5 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -264,7 +264,7 @@ void spi_nor_setup_op(const struct spi_nor *nor,
 		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->dummy.nbytes)
-		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
+		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
 
 	if (op->data.nbytes)
 		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
-- 
2.34.1

