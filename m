Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03150C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0178E83394;
	Tue,  8 Jul 2025 15:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QmZRP1za";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A15B38331D; Tue,  8 Jul 2025 15:42:16 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F8D8334F
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEZgbRbRKPDb4J22Skfj+OI2ldmEZ/1yNmTvwEMtptTCzEW64yLFbg7A1wnJJefNRv/sZC1XCRNd/DWxWYq8RyY8A9YDPX0i2aTg8RwS/Wdqyqd2GKt3XuEXCifnBwtk32KnEklwjQuPGepqHqETu4rdiZtWrBEBoinClqXzo69CAn3czTpmUSm9K/U0ENaGVhJnGbB1fTzHg95vzvpkn4H27NNHrj+Yhsw3Z1vPsX/VOvSNUo41wub6asaOyGM790zgADvH1ZDv/Vdq146Sbwig7aLLQf7dbfpGMamBLCzBAhYFG/tJLbz40bliTenUbkBVK7BhnHuGPP9gySsa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fqsxwws9Jsz0DPBP+QVJUORCAL/kvo6rV6VBAPEbAs=;
 b=Gj4a4gmurEXuTeaDR1mKSGH362ZOIH+VSxOT6xUwSuePapkLcUadbZX0obYfv71HlXi0wkSf2iliCaE/VpgSZSmKycPeEakTnecCE1Xn6vdwyLSxtefx75ob5z5IcqkNDWcVeiP4hvRE+YWfCHprwH52CDseoD0hEW7Qd/NW9BjnbyhP9LXErchq0fOwlQPy/U+QA7SkKE6CWgH559QOc/MWgJOj9wHFqlLvrGhrntyJmcTEbVTbtU0/uBqX0I+dy/RlCA+25+fkkfbG9am9cJPeheicu4f7zO0gXJbeOsZBlMMYNFzHrgYDOkVXeCUrrR58+78fuzRam4sRCvmuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fqsxwws9Jsz0DPBP+QVJUORCAL/kvo6rV6VBAPEbAs=;
 b=QmZRP1za5CFETy0QdPzuKmvmt5tFKuPw7ue1A3fmUc3juHUMor2TCMk4t+5aJlye2XCigy9yJgy79wef1R76UO9T3IMwODzKOv596oavDSvv/nMlQNEwvs7gTI9BT+1R2FMJBUaepVoCGo7Yhl96/aUx39PfJQvzaDbsm7eCOQg=
Received: from BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::30)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 13:42:09 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::4c) by BL1P223CA0025.outlook.office365.com
 (2603:10b6:208:2c4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 13:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:42:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 08:41:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 08:41:57 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Jul 2025 08:41:56 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v3 1/2] FWU: Add platform hook support for fwu metata
Date: Tue, 8 Jul 2025 19:11:41 +0530
Message-ID: <20250708134142.327224-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250708134142.327224-1-padmarao.begari@amd.com>
References: <20250708134142.327224-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6775cf89-c863-4bde-4c11-08ddbe253c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?luMEe9zPK7007eXuTf1gARidUc+wIdkOh7j19ZuaecvCiot+tQ3qWRWmIOIt?=
 =?us-ascii?Q?ae//xkceXZax8gljil5WxLLV/uwdfyvEYrH0cRDWh6aYUMnniFELmOeZzMC7?=
 =?us-ascii?Q?zj9sO/FpA9T5JG8cgFLTRxL+iJ3Ohra7Pf0L/6qvIsTW4p0GroD9y6AXlxKH?=
 =?us-ascii?Q?Olir9qlv0unFHeVBcpOaNuHF+e6vn1DWwUEDmWOKDRmJnx8L/0gESutj8DA5?=
 =?us-ascii?Q?USPcPUWdthBNSQ9ESjMEewMfJ7o+TLmvJS5IJMtw+hXI9a+jVj7TGUhiFDIp?=
 =?us-ascii?Q?+/tSkfJ9Y0fccheKnR19PMWEX10u+nZtSwA8xmuVU5jrFd3jOIvKW07Iyzjt?=
 =?us-ascii?Q?ymbrkYMmOCXY2mJIoPyhtpvZ5t90VzgcazQQCPOHs9pjLEcd2HGUErO0L2Nn?=
 =?us-ascii?Q?4KJBhfkqS7uDfzuHo0NguucVwgQ185TUeyakstr9gilsn3KhXuCscwetiLTy?=
 =?us-ascii?Q?kQOZaQjmWEQXiHncj5odKvEb0XHNvxY087qCx9FWwSFzTio8syKzAuzwhE2D?=
 =?us-ascii?Q?JsDtqXcw7vFTdkBv5ufiNTd3vGrg/6rWHQbGDquzpSAsFliQTlnX0aZa42gC?=
 =?us-ascii?Q?FNbPUOEKEnZeG/ncw8ALWx+dcZaUi0AKvWaX5TEuDSCotCCBB+NLXGqTLdqq?=
 =?us-ascii?Q?dYJUb6FjT6oyXArKNn6YMFSPGJZMlogIxnLDAZ91mdz3bQ4t8dtf4uKPBUig?=
 =?us-ascii?Q?JM4+y5iUKuaZ+Y1v0adD72tF3yfJIsfh3DVpwbOZqeDry+h1QgxnqZdllueA?=
 =?us-ascii?Q?RBbcWSGImwUnR7P50xRzYYwK4ihQJrs6JRkqFF6+n5geNiX3aWZ8KZgmpw7+?=
 =?us-ascii?Q?Z9PNgoJpYZqKlc6A6y5/Lvwd2tlFO2VIm8lKlZEMPN/kLFuNDIltsu29rKJu?=
 =?us-ascii?Q?Shmr3FfusBWfY8dbyUwvVR4sKTOO7uxTlGr7Png2SeYG3oG/fi4Zp0JhBWh9?=
 =?us-ascii?Q?MktCrNbOYfYVtAZhzlwoCSaxmkO1J41DJb/KdcCa9FwgQHxAhK0kZWx7MZ0e?=
 =?us-ascii?Q?gXc+L3T5fyocynd/9JZNArWN5nSE6+w1GKXl7yh4ieiE76RDtkEQEtU2MIkC?=
 =?us-ascii?Q?KDhrNy+thDbXthplF3VSXyBgqmnpoJdmI2iCnubWFtyPT+qvoInuFMPcmmlE?=
 =?us-ascii?Q?bdm55VEwPpSWQQj9IpdD/ezBvjgl+jgybG0tgCIwo3XW7FsXPyBKkzllTk4K?=
 =?us-ascii?Q?J5PfxOWGhhYkFPY0qTWo+8nzIGo4rvsHaS/92fJTDXq9hgxCxfLsjKQftsyg?=
 =?us-ascii?Q?gztt8P5V97NgHxIWkJqK1rOJihFHYf1O8hTFvZeewgv0hmIxFgXJEynUjs78?=
 =?us-ascii?Q?eb7yr4JqZYARLZscryiyRZa0/EUn+G/bvLfe8LZdDJf8oeqzptkadT7N8LSp?=
 =?us-ascii?Q?wyZPax8f9vdKOugCnl7t+33Sbq+YZXSZHU5IzYKUy0B85Vv9XhTMElCvx6wT?=
 =?us-ascii?Q?eIAvvVSSwjIpnq6rU2ZdXNc0yVfLPwPQTqMT7qL4knZPbnlmpVv0OGcLlzHS?=
 =?us-ascii?Q?Z3zYo6ugp2xqoZD/MIU0/QuyyacY1XmxyVxB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:42:08.6612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6775cf89-c863-4bde-4c11-08ddbe253c0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863
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

FWU metadata information is unavailable for platform-specific
operations since FWU initialization has not yet occurred.
The initialization function is invoked as part of the main
loop event. To address this, the FWU platform hook function
is introduced during FWU initialization, allowing metadata
processing with platform-specific operations.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 include/fwu.h         | 11 +++++++++++
 lib/fwu_updates/fwu.c | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/fwu.h b/include/fwu.h
index 77e60167fc7..e7bd1d492af 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -128,6 +128,17 @@ int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata,
 int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
 		    bool primary, uint32_t size);
 
+/**
+ * fwu_platform_hook() - Platform specific processing with FWU metadata
+ * @dev: FWU metadata device
+ * @data: FWU metadata
+ *
+ * Provide a platform specific function for processing with the FWU metadata.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_platform_hook(struct udevice *dev, struct fwu_data *data);
+
 /**
  * fwu_get_mdata() - Read, verify and return the FWU metadata
  *
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 7f085a0211f..0f5ef2ba515 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -655,6 +655,16 @@ __weak void fwu_plat_get_bootidx(uint *boot_idx)
 		*boot_idx = 0; /* Dummy value */
 }
 
+/**
+ * fwu_platform_hook() - Platform specific processing with FWU metadata
+ *
+ * Return: 0 if OK, -ve on error
+ */
+__weak int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
+{
+	return 0;
+}
+
 /**
  * fwu_update_checks_pass() - Check if FWU update can be done
  *
@@ -712,6 +722,7 @@ static int fwu_boottime_checks(void)
 {
 	int ret;
 	u32 boot_idx, active_idx;
+	struct fwu_data *data;
 
 	ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
 	if (ret) {
@@ -770,6 +781,13 @@ static int fwu_boottime_checks(void)
 	if (!ret)
 		boottime_check = 1;
 
+	data = fwu_get_data();
+	ret = fwu_platform_hook(g_dev, data);
+	if (ret) {
+		log_err("fwu_platform_hook() failed\n");
+		return ret;
+	}
+
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
-- 
2.25.1

