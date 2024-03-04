Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EA0C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 03:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04AD787F92;
	Mon,  4 Mar 2024 04:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zykeVvCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C96BF87F70; Mon,  4 Mar 2024 04:11:20 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA6287F7E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 04:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/3O6eDFQulFMQD1mg3MZliE65iTtev6kZqasC7Z5lr0GpF6bq4WNvKh5Y7xR6IAONxiX0h2DstbekKovH8/pmew2RiiencBlwO01FAs/FsU2+7s6dE/UqX41v51jWV8OvaewEqFgnQnRiqrSc8COyE6fNXLElXMz7N74yTHdlSy/HwMRO14cn+WcZWSAHt9ZpYdFHh2YQCYwE9GHnr2fBgnqp8COhec1tJNWMbQMuf63mj7O6x2gReopkMeD0g8uMmbEnbo6wbArnYy1mkvOVjaUsp8nAUbVSBH1w67FxmL9xAkHtkzjrc9EgR3V46cAGOJ+kI+uHR1+12kRZqPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3uz1VnUvQnsbZ5CZ/RZGrVAZORhPuCsgrmq1tnNXNI=;
 b=hDz5kPJuDQcAppZBKyl0sx0pxCZwcgroAz/fFBv5EGxiplgbnk83NIpKS2/NwY6tJazwr2Fxj99LPuRURbRe2fcIz+rJw2L2w0hXGCZTcIr4Qm84kLMvo8oDAKKyIDFOV7cgZkNgg3I6/lIjYF9NCPCan5k0uIZnvQAZA7YfZB4AZ1n1wBN1jm3vmOyPrh+2rA0/xB07PcfPg5yaNROO85NuG9xb16ZLn9NTc2O+JoSXqorjF4olbIa+/VaHUSLu8/ydq6gqJ2KmDrFciqD9JvjFVnPeS8IG9F/SuXPxtjNxWd4p/Nz38FpbsD6732zS93Ta5wZZu+t4JpU8fUFnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3uz1VnUvQnsbZ5CZ/RZGrVAZORhPuCsgrmq1tnNXNI=;
 b=zykeVvCfkEpECptnZ6NoCfnzYEVhxXZyW4P87bj+DWP8VGTgaPKTcqzfZxFcb7uPK4IpPVCHpybM+hnhm4bDXeKiWKO7jqu+NwhCVAORHlHkBaxBoXejTe6nAVDT8MZTLYn0/gLU3c2lBvxz7B3WSaJ94dKTOoON6Rjb4z6fmto=
Received: from BYAPR02CA0018.namprd02.prod.outlook.com (2603:10b6:a02:ee::31)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Mon, 4 Mar
 2024 03:11:11 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::dd) by BYAPR02CA0018.outlook.office365.com
 (2603:10b6:a02:ee::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 03:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 03:11:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 3 Mar
 2024 21:11:09 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Sun, 3 Mar 2024 21:11:08 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@amd.com>
Subject: [PATCH v11 7/8] spi: Add the spi advance options for non SPL
Date: Mon, 4 Mar 2024 08:40:45 +0530
Message-ID: <20240304031046.25998-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
References: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e73294-24ad-4599-b93c-08dc3bf8be8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTJX3+XXTx3+UO1dk4ynmaFgOerBZrUAH/gWGyjouROvbX3Y6tc0KauTvcxJnLDvndQR1c77JIE4LealDa/Efv3Y8RFcFvIV8WVMJOssFVCno+ArnHmmB+nbVL+zWRWNxv1VAkyaci19TIlm/WfVzxRfVyDJUte95ujnoM69LWnxKGGTr04po4aeGb8JXpf8mtDOcCYoxSH043B8QgYOCnKPZEPIkwrKhs7gPCE36u6CtRSpdmN+G29yfiVEKXZ8YpEdxUXquP/5uADDK4crtyT4u7m73zYDJXkkIEk/i4hm2B9FghYVKwCQABg7SgmPv2Kb8kigQ9FaUefLBDmYbSesc+hcutCp8f3Nsd9Yi7thkxDDv9f/WgmQUgIN01rEqc5pQ7XqCP7y3vARZRvGarcG9ouXJ0X6boTWyqzTRNXXKq04QdS+Z7oy04crslcWYbAleQqZ0cses3Rw74I/+4Y/jAiPx5Fkh6HgN4TsJVCQaOE6STx91AuJexBfAelT7O0pxZgOEP8aO60Rw7Qv03KkObGI708zQP0f7CiA5fQ0NqWchIxwptEnQAKBxKv/p7ts36J00chTKFUqEHU+P5ksgsiItWzA2n4J6BvyxFaiYtWi83m+uqHFSi/sMvcZjQq8rvQPkwqpAAc88xnwbA4CcO2L94nZdOybuZWLaa0VvupWj+bjNbaR3TlG5VLB7ne/738EMZLEypwr+ACZkPsDVey3pyP8GuHcvd4vT6VoBQ9/YWoAnR885Fcn9Y8y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 03:11:11.3470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e73294-24ad-4599-b93c-08dc3bf8be8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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

Adding the config option SPI_ADVANCE for non SPL code.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/Kconfig      | 7 +++++++
 drivers/spi/spi-uclass.c | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 69b184b0d9..e5640bcbe4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -50,6 +50,13 @@ config SPI_DIRMAP
 	  improvements as it automates the whole process of sending SPI memory
 	  operations every time a new region is accessed.
 
+config SPI_ADVANCE
+	bool "Enable the advance feature"
+	default y
+	help
+	  Enable the SPI advance feature support. By default this is set to y.
+	  If you intend not to use the advance feature support you should say n here.
+
 if DM_SPI
 
 config ALTERA_SPI
diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 992394c295..736159aa47 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -447,11 +447,12 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 	slave = dev_get_parent_priv(dev);
 	bus_data = dev_get_uclass_priv(bus);
 
+#if CONFIG_IS_ENABLED(SPI_ADVANCE)
 	if ((dev_read_bool(dev, "parallel-memories")) && !slave->multi_cs_cap) {
 		dev_err(dev, "controller doesn't support multi CS\n");
 		return -EINVAL;
 	}
-
+#endif
 	/*
 	 * In case the operation speed is not yet established by
 	 * dm_spi_claim_bus() ensure the bus is configured properly.
-- 
2.17.1

