Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AB5C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82E6680C8A;
	Thu, 20 Aug 2026 09:27:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xEvEPWE-oNRC; Thu, 20 Aug 2026 09:27:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787218022;
	bh=R6Fg1+iZ38KwDR1lU/PLcMxrzHCgUAGsCq271rkzd0I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ty3A6Qv6dJr6I1pifc59PzV+NBs0kQ51bqx2m4IQ2eddDOS8o4r/4aztONzhdo7Js
	 7nSvShJByn+oleeNDYIneUIUUY7HwQ3gXlS1CFjrbhi8Y3JwDPvkKjN5aHYGi91vvn
	 IfC4f2HRy9d6bXQ2dBFRIHQUmCnFIktN67tmsQZo6yQKqemKvug1W01W2r2QgzsuyB
	 pyhTv+FPYy31ask5NNoEqDsDC2ZhiU6fLay+7BFvpHsD/rjso+9s4xd+p5ODYVh9bN
	 Ub0ivAbV3xkCfSrUZIL+paxfCgGyYtlV9XEuRUw0A7M0lzoSVxFuXVVBomOgrAgkK7
	 V5t8lchvh7Cww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59BDB80C74;
	Thu, 20 Aug 2026 09:27:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D5DE39E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F515405AA
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4VmpfS5Ktm-I for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:27:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=M5bHqw5f
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 735954058F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvIgRmjyDpxwwfElE/f1UBO1h6b4awhgRZgvoOSIaJ7BK4uDlOC1v4G5ENvGSupwD4dpWbizbzPptNRiu+nZvPB5H08GluycXhkF6ZLUixov0CHMHFVvglFdIZ96D0ENrZjETQ+phZIj4wzLrCfIVhKUeGE2KaFvLS9qbgjyXK9zfHBrgf78IwnI51RqHJtJ9GR+zARsx1uT4P+40rYyz35ptyFZ095IChPYnakTzDbi1yHrHtbfboUAR/uVCTKuS3fNprRzsaa98crw6RQe0serFJIlmn8S523q1O/ZmdBihTzPycAEvXS1XoanySX0eMaAlYJfyxBCa48sYYDjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6Fg1+iZ38KwDR1lU/PLcMxrzHCgUAGsCq271rkzd0I=;
 b=N6Sw4YqyalJfWfEuOjtg5r44cmOa9UOmQJIJapJm43h9YsIzQNoqQGgNS+iOjAM9KFMmYQBUo71Y3hghVx/btlpVOwF9IywUONAAmHaGKH7gi/S6Nz83/wUsTF3pzE1nI66nBE6VpIwGrbHELWH3AuogpFHqZ/CseKHsp1GUICTs006pKL6dkyMBoGU3TebP2nILX2dy2ikOmaLATOrLV30QuO5S2I5kwEMhJAzPwhfnzcrxYgJjw9QwoVJfLl+mFsTi55OF2B+NQUvcI49GoCBf6Z9Xlgglk/7EcNfl2nsFHXRaK3uAxCLnHT1OgqqovKiddGqONcltuMlZozXftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6Fg1+iZ38KwDR1lU/PLcMxrzHCgUAGsCq271rkzd0I=;
 b=M5bHqw5fue7dWjy507+YNtMIPCtZiPVSKydjdvqwTbsGl7z6SOUisutu8H3S03oqKlW4REFRDN4LdDUvVbATAEoSs7QXFqsKpdixRbDPAlNT+xBpVc4KwpOLrb4UktABlZbc1pZi6WRv+NqS1XOWakwNfXx1UQOqjQ935LN97QA=
Received: from BN9PR03CA0380.namprd03.prod.outlook.com (2603:10b6:408:f7::25)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 09:26:52 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::59) by BN9PR03CA0380.outlook.office365.com
 (2603:10b6:408:f7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 09:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:26:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:26:50 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 04:26:49 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/8] net: mrmac: switch to max-speed property
Date: Thu, 20 Aug 2026 14:55:49 +0530
Message-ID: <20260820092623.1647844-4-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820092623.1647844-1-padmarao.begari@amd.com>
References: <20260820092623.1647844-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: d138caca-ae47-469e-b48b-08defe9d2b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lggsLh9OS8klEG1VsaYQfKlUCnSRw8WsjvlcG7KzT89VLuBiVUJxr4q7ZDGa9a2bjY9An8e6uoSf3pGBZj2QHn2C8ngCOkaOQgf86iQgaijhAl/FbZRjeWeaKqUhtR18qlcLkrYz8kWOHs+8GniSo8aDX0KOPQZtaGezlBjhupCUKiGF3w5/G45RlwwKKq66iNilDiRFA6kEoc8p4zOF3lIphvJ8l1q0VQoopHFaIGfnJfEolIiklNbGdGYNYtrK2nxLbyHQOZLVxIrll/utJCbmrNCdrIlPjvKr4T2Jw4ThYdsBkcYqLhO0mac3Xsqhi/i2oY2q6+VqnVEKPxA+x4oF6OYRfPYvuZp9zLnJjHrqcT1n9woh6f1M1dVIwa1WoUB0XurOggbt7+v/5YCI7cUjWOim/8cVZwn1pck38rPq0ht9/T4R4t7npdJvkWrwG2XEIQbw3LnKJ7YBYO16tUKYFEEMUo+TgKd2BCC2xEbbRkug3+sPYH3uU9pWOEJH2W2rj8znRPzFE1KDZzR2VRRHJW67VZiyQCmtT+awZxlxEELmBex596Ltmw9qTtBAoB+o/5IOUaLWBzZ6OZpJ2kg/J0VlGk7tOeUa8BuT8eYgctHXOfLUeKD7s9sJLuOnQTGZDbH+fkWc4iy7ttzVfcX6HcwfvIZYx7g058ATjGzXY3O+1qCZoZkXkJHT62fabjSEQZR9gRwpXGD80KQX/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fULkueFRCYmAF+PZVSFD3E6Als/+a6VcEp87ZPDPU3bD6vGuS6OgXiH3wDZFE1r64fvK17mxaOQJmJ1VE+T6I8cQhfjGYFVb73NSaXwotLV3NKdQFWHNAEdNKFgg0ja5ZHb3ePwwVsjcXcgIJKmKnnpfw5eTPj6kYiEuwH3cF+oDhivx2UX+r9Ii/vuhxtm7LwDWw51Y47u1qk2kE0khhR1bopCiMeIYAgABjsJxXBnZtNmijAHCLV9yMNXe5hRxO3FGkMvUEEsncy/t87X7XblaW0ZK/pDYyFaTtNp49KQwJrazKty21xLNmNKYt60lTVI+yrTE2n+VyPnEfcYgVgADmNPZHxXGAvUfPNjiQLn4AhxR4WTxfRCsKKbGhZoofjE/F5pUZTqVkAGQTr3eeUKhP/LX684qsyufHYv150m8e3O+S1x8QUK1I4SSOWLV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:26:51.8564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d138caca-ae47-469e-b48b-08defe9d2b0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Read the link speed from the standard "max-speed" property instead
of the vendor-specific "xlnx,mrmac-rate".

Fall back to "xlnx,mrmac-rate" if "max-speed" is not present, and
default to 10000 (10G) if neither is set.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/net/xilinx_axi_mrmac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xilinx_axi_mrmac.c b/drivers/net/xilinx_axi_mrmac.c
index d9d4756d14f..8778ab1aaa9 100644
--- a/drivers/net/xilinx_axi_mrmac.c
+++ b/drivers/net/xilinx_axi_mrmac.c
@@ -547,8 +547,9 @@ static int axi_mrmac_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	/* Set default MRMAC rate to 10000 */
-	plat->mrmac_rate = dev_read_u32_default(dev, "xlnx,mrmac-rate", 10000);
+	if (dev_read_u32(dev, "max-speed", &plat->mrmac_rate))
+		/* Set default MRMAC rate to 10000 */
+		plat->mrmac_rate = dev_read_u32_default(dev, "xlnx,mrmac-rate", 10000);
 
 	return 0;
 }
-- 
2.34.1

