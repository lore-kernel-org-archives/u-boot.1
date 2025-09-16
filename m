Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4305CCAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A078B8309A;
	Tue, 16 Sep 2025 11:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MMiYPvTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 329EC8318E; Tue, 16 Sep 2025 11:26:25 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A27803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srDdxrfJ69lA40V06Wh8xbuPNNAfv3Z/CCXyyozJH+qnWEbF8jQcKyrdUYLuLfoslRIJ/PlJxSidMflcH1xoInx2D0laN0ZL1WrLvvhNrrpixVOJd5Zh7a5L7BcvHt5Phufo1xzH6wvZLl6CRmW6PzdS9c6hc9L7guplZvBfg+KjrzrladgSzNSCGFSYlUWqa9PEeoXbM/M7DBa8fOCd15agIqZp6//ry7jYihEHOZwVzxOKy9GzSYTOncsZpVLLvuu0bsL5pHkLOiSOGKDnf4T4iEmcCNcfogw1mqsB5PUzGKSY8Dj/M5Ylp/BIT0xyovvbBZbcoSPrP6ieONiHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auxyB/AUDzDQhHkM9SRjAH2/XLbW1YiIv4kU0J2xrrk=;
 b=XSY8tYdpXOWHZFsGtlGgIEtRAnLfmxfdHE8Ie2nF38B/SlkHbJf/QlZufX3tNbd49LJfDhOLw/71x9KKlFwos31vbPn+QZ6+Bg03SGRFOPoYhOqlYpweohQtmiyOsPbTUIamdGvSDay7+dMzec6fIEQHm+q7VqWd+gij3/5TeQ2ms8TKW2sWx01JMVhC+VwfP+wFFW7XArdPqi/3ITuIzniED7zg4PMgqv/i92sgdy5iGj4JRuNaOxEeQHDti4vxptZkOPMDRr7vCw7f5KWaHAPrnSS2ocDL3mI6mAygImRSc69JkE+iUn0fLXsIQVteuuuF0XJZXzss8/MPkP106Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auxyB/AUDzDQhHkM9SRjAH2/XLbW1YiIv4kU0J2xrrk=;
 b=MMiYPvTNB3nDvP9AXlmZ4XuWfPGf6G4Mp5lfpyHj6bqnmxTrqTnz7QAg9n2mKXf1j70bxxlgQ7fb2aBmE5HzHMUQUm/D55E3PSs2W87zf3R5PH7xoDqUWFPzl4CJ1Ii4n/Me6Nkr9AlODY7JtTIuzjlnxz2Q+w0hyVDazxvI20g=
Received: from CH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:610:32::8)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 09:26:17 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::c5) by CH0PR07CA0003.outlook.office365.com
 (2603:10b6:610:32::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 09:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 09:26:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 02:26:13 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 04:26:11 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 02:26:11 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <fabrice.gasnier@foss.st.com>
CC: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, Marek Vasut
 <marex@denx.de>, Padmarao Begari <padmarao.begari@amd.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, "Venkatesh Yadav
 Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] usb: onboard-hub: Make i2c-bus option
Date: Tue, 16 Sep 2025 11:26:01 +0200
Message-ID: <68478821d089fcf68a841dff4b0e303721442e70.1758014760.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=eQaOl0mzcnE17G1utpZThqM+stTRZiEaIJaKXlAWurY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSc1NVe6rZ87l2JW8ePde7qMG0rUVYNXx/Vcs0yagrbr
 ndM+8yWdZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEvnMzMrw9a/dgxg4Ztcia
 JVcE088/fM9yKHa56Qdp08VBYklyCyUZGTqK9t7m38Qm9aWbe/90Fx3rqk8vfjx//dlK5MtLhs9
 vXfgA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: a861d581-d154-4dd1-c21a-08ddf5031701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n847unWc+v+IYhrBAbvzRoNW+AJMbmVsNObnoTuMosdvFnAu03qmlUMSa957?=
 =?us-ascii?Q?fdMwhepVEWTE1eNKXFTNI9gG7+r4/lmTafAFTdhlCK5UY5h4rycLvOeu6bRq?=
 =?us-ascii?Q?S9MVrydCxnHMww7ebJ5Cb1LgQg2fPHbaN3c9xWEM0kTeLa2cHowtJ+0jR67E?=
 =?us-ascii?Q?cT5EioybwMRTywmRs6hYr6K/VOnuVeKTJoVps4sQH2JYMyARChcbuLYyXLzR?=
 =?us-ascii?Q?ehw5mT8hy4fKC02RLqCugW3gs/Xn9dnRBPzJrbrSQ/fo5zpnqN+rwhQstR4C?=
 =?us-ascii?Q?UMgqIBnniF6LoVzOGVqh92DJGaVsQxGZjecLjaW7sUD1PdMFOwhCuIDpDPg3?=
 =?us-ascii?Q?uuyx8Ya+WqKEhUH8GS4W26DKAujxD6kzntlthKJF+POlVnmgTxh/pn6PxeeC?=
 =?us-ascii?Q?eNL/gZdJmXzbHVzloD7YAjaIYJ3v4UmfwbHfnmMC8RhqsABAIn1F1LZxdM29?=
 =?us-ascii?Q?88W9NcxFsxB8j1Wxcwr4MtL+blVzPQKgEnxfeSBHW/oeVw6kXlr/ZpfdC0KN?=
 =?us-ascii?Q?x1QbGAVrTLcOqz4Di7X5V4MudPmCkGvV62DS2hGPb/wg6VXS3E0f+ouf4vEp?=
 =?us-ascii?Q?j7tfDW/yG/BH2nrUiXPwOwe88x0BBeaZVNYUruHhI9ajQmKq1MbrkRL/lbHR?=
 =?us-ascii?Q?HxzTX5P00/ffcGgfWvD0k/C+ljhzx5eKov2rmkHhZk9iFcEFyL1RU4roXoFA?=
 =?us-ascii?Q?g5NjPMzjkj7ubiILWwKYHHgrcaCr+4wcjnIwbckc2ZJk1YnUKfe+0GnwVL9x?=
 =?us-ascii?Q?CLqR4t5QGTQJZVblelAcbEeGU/ov4BYtO0y3CMMy8rvdWvYNufinA6mRhIr5?=
 =?us-ascii?Q?tnMI0hSZX9FX0QOQYMkFL3WeCjxD6v7r5WqMeCWV7h2NxwHvjah6auFAIq29?=
 =?us-ascii?Q?VDQHzjuPkD2cTKNC4CEbhb45FY2hOM9KRGx1eEthq6hBCklEx+m6A75iTUY6?=
 =?us-ascii?Q?MkXMUXUrlRjLDYi6Au+bA0XvwHpYyHU428gv1DK9j/2jiIGEooHNm9TiGoMd?=
 =?us-ascii?Q?+kW63ZX/WT5tXbVFRGc2aUkn2CuV6RJlrIbtbXcByCga42WT3omLbrh+ZTVj?=
 =?us-ascii?Q?rUpu/d/vQ5a1eKV6jKJWPek2b4ypSyssYJITmXojFnhfxr6MSgFuntkvIDgU?=
 =?us-ascii?Q?2IGo38qbi9wmNsvLRFy+fEkbmaJmtpLGpGsXcNtRqkkLWWZIxfLMJiQqA1ia?=
 =?us-ascii?Q?vaday3hG1cpUQbEg8GMxBb2RBOsCfLKV99zStqp3Lj+AZPNtMgrSoVwjRGz+?=
 =?us-ascii?Q?XYd7RIhpl8+JTR8Mdg0F4GN0FKqujwTL+i0KPgFMtz5vXh2Ximw4k8sDx1Km?=
 =?us-ascii?Q?a5epREyoVQtctdcZqthr0iZZDcwI8mwruw2DRje54vjGL0c33mdP7jpg5yZo?=
 =?us-ascii?Q?RRL+7kxaY7jxm2JDssngjocfC318V+0EWi6W6Bph0ZpZ3LHRXhi7cl08UFG4?=
 =?us-ascii?Q?64lTOcLhU5B5hEk6M9BuE3OTSRmI4rAgu/QiYFdPvvzQlOOOCSDakT65lVVM?=
 =?us-ascii?Q?P5Kp/Sb8w7JAfWZL6lreE1b0LUOrdA16Y6bn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:26:17.5620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a861d581-d154-4dd1-c21a-08ddf5031701
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435
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

DT binding doesn't mandate i2c-bus as required property because hub itself
doesn't need to have i2c connected.
It can be in standalone mode that only power regulator and reset should be
handled.
Or hub should be configured via spi interface.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Handle -ENOENT separately

 common/usb_onboard_hub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 70fa349a8817..b265321c42ef 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -61,8 +61,13 @@ static int usb5744_i2c_init(struct udevice *dev)
 	int ret, slave_addr;
 
 	ret = dev_read_phandle_with_args(dev, "i2c-bus", NULL, 0, 0, &phandle);
+	if (ret == -ENOENT) {
+		dev_dbg(dev, "i2c-bus not specified\n");
+		return 0;
+	}
+
 	if (ret) {
-		dev_err(dev, "i2c-bus not specified\n");
+		dev_err(dev, "i2c-bus read failed\n");
 		return ret;
 	}
 
-- 
2.43.0

base-commit: 07c9cf2778d9859ada8cb4733b64ff707f992b4f
branch: debian-sent3
