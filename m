Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D04D41D53
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 05:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EF5489393;
	Tue, 12 Nov 2024 06:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGnK9w/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 063A08888F; Tue, 12 Nov 2024 06:12:16 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0FEA893A5
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfeY4H743373fxbYxHEfR4JiRKHjGz4ZjAJQkTDZhF6ZUUAfg+Es1rPuai3RuIQoTrbY0eMlVyyc88lVDK+F+kJPh9o1xsk+gRsFwI1dxYmw9CiS4sDA/ncVOXeeeNK3pPH7tEzTlu8OdUY7TscAbvgcR8QmKDCBs2eLNgRpqDb6YZ2k9RTiArPH0LjJEAnFRiAYTB6/HtPebrj9KfyDCNWwen5KJcRNyzY7W6lC3507JRBidw6nRUf8Il0D0/YKS2UVKJAdmdcs2A5WDrdFcYn4l4uONQ2I4691Hf2xcAFWT0eQBQAgiyJapxH5k38dgEMbzjnHn6rHArIg7iMK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CPSTY6hPGfb1sbgYRaAW2wr07nN6WBQ4wAkrsH6+Y8=;
 b=WXn2dHnZtMuKw81ReHgkmukQ36pqKvwSZWVAc3GE0H/O3NNUEFh0kezlR+H5jkS1BruQTFN+/181z0496WJ5nt4Sv40uMizrRICTFEv0BH8P+UE7CM1jqgkdRHxy65yHYmuZvJQ6JpxjbqBzsRsLqHRgVtrgL41Fsycl19No7s0hjrgVYAv/9J+xqc8iBSq4CLBV6aTIOjM4tqotIzrcUkgjP5AuXRDppxdFPnPAajqbP4zy6k3vcu4BeWf679rjMe5xz+mkAwM0j8IfpLIs/bys9pGB33RD1VmDR2eX2HL/1Jd1rOrlyoVplXKUsyKvrWPg00ok7phH7Fj/FiTpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CPSTY6hPGfb1sbgYRaAW2wr07nN6WBQ4wAkrsH6+Y8=;
 b=ZGnK9w/fSEW1Y0Y0u2wbESjJrYghXHxUC8utVbB8DdQeJhh8Yu226+lr4VdCpmDwrDC77LeuRMZWRj++zlciI+aGXaR0T8r0mEoy1VwqrhEhVqzjLNf4Xm5NqtGZQMz9mPQflV1+becbWCO7Xk1fsqGWDHBJ3vY2m7ZXnWJK4gE=
Received: from BN9PR03CA0364.namprd03.prod.outlook.com (2603:10b6:408:f7::9)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Tue, 12 Nov
 2024 05:12:10 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::eb) by BN9PR03CA0364.outlook.office365.com
 (2603:10b6:408:f7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 05:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 05:12:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:12:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:08:43 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 23:08:42 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v11 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Tue, 12 Nov 2024 10:37:35 +0530
Message-ID: <20241112050740.15343-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f2ed37-c9f2-4de5-f719-08dd02d88f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?btieaVo/2osfIh3XlrWPXUHOV/bOZBjxsEXDbKGkCnqHnPhRHqFspifsF3MA?=
 =?us-ascii?Q?9Em4YhpBbLYIL7okcHlRcDDU1ow2rOfKMwFeVN0Oxeq1Qw9qBpuiqQjn1jw8?=
 =?us-ascii?Q?1zllR2KQU5D9RBQinZGo2CUw0o7ENFBxvjF5Q90UKKYPneFQOTN+w4RjOcCY?=
 =?us-ascii?Q?XQ0teYtQko8cXTSevYkm2JrZitm9oa8iCS63R5V1wPeJKGsA2jSFpYQeGDdi?=
 =?us-ascii?Q?vdvnqjhHQMRQZr1Acs1H6Xtu73m74Vz/pEspHEz8PnLYkskbWlavxkzQk5hG?=
 =?us-ascii?Q?sBx7+I+Lfrat7pRyjXQ1I3BkVYeYzcyZ4ZZ9mKBNX9bKrN8hQWLxzq/wCaJ1?=
 =?us-ascii?Q?mc2OVsGRhKTgzpk+rf5QSdiGMH1EKaOShmnhge8ZDQPXae8bcESyyagz4V5w?=
 =?us-ascii?Q?S8JjL9PXnU9uPWpyHAzm8FvHvPGrz3GGr09UC6rTqyqE7zH7m8wQolY0CF6h?=
 =?us-ascii?Q?sRrPAiXSp2hmcT8dEgnBxK2lZ60CRg4FOfiDMxd3utUHEr8W8cj2wy9jKf/B?=
 =?us-ascii?Q?k3l2K8393EJqZ1JQm4o9ECIfJzurVm73BORkLWQgZU1HO63FtGNUBoM1bJhV?=
 =?us-ascii?Q?EolS4vVkoxKNjHErwNgDo7bLZ540CtqAm+NbyEm2RqYBCWMYNkcKWcj4QJyK?=
 =?us-ascii?Q?u1jzHTOnvBMN73zcDefD21rv6qXd7cb5OvFMlUobQtjGAr6uhP8m+SOjQJaJ?=
 =?us-ascii?Q?5GFvvT5daiZk1tqION44fSqiSYLDWwpJBFxawKP6Lxp/YHEudxkH6gHVpOgW?=
 =?us-ascii?Q?CPTlJ7XzydQXNBmVTrWOPlUaknFnfMItxMKalTs04XMwBuOQE9QYWYk1MMj7?=
 =?us-ascii?Q?/f4nDqILuDJUVU5Q4kKsQYiLp+5l4idTy3EEt+amLOKT0n7T8pYzZsLWIvSw?=
 =?us-ascii?Q?l2ICfJpL2H5HIIxVU0xgTus+0vYB/m0HvmQrG3KUtzai6CE2XvH7k4oEgATS?=
 =?us-ascii?Q?TYXCskDBMureTuTl529FxXPC0wRyXqG/Fy3xD1CJxFSfJvItx/hQe7qxbNbL?=
 =?us-ascii?Q?m1CafzmC83icinJMTmK4WlU3B8PmFw+7SvJNQEmPJ+Q9PVR54b0gOl7ibrPU?=
 =?us-ascii?Q?MP432g9v/uAhr1s6gbKkcaCvQXhrrJKFBFhkhLLgrDybJf4w6c2zdBiQBfgu?=
 =?us-ascii?Q?6YNQ9FalFSN+jCJctr5f2y9S51CuEwWXWKYRhFOOm78aquMaADK7Gith5vBI?=
 =?us-ascii?Q?wnIoNBsdASdFh389Y27orZ6ZbgtGuZm45NqG4+huHyZCmRIcNuKfw5/sPjyq?=
 =?us-ascii?Q?iKw69jqyW/2k8IRvuIixwS2mRNjC2KSdsm90s1wWmToTYrkaLDDMU9d4lyyS?=
 =?us-ascii?Q?le5jQdo5dWSJANsooXe8ZvaCx5zJ3hYTaT80vS9UfqNSEeXQFg4ttoLpmuPs?=
 =?us-ascii?Q?XuMSC8MpHdppHVUsLhvrm5LuwVdUNCDIWW/Ci58ioMZRhq45bw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 05:12:10.0465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f2ed37-c9f2-4de5-f719-08dd02d88f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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

Don't error out if there is no vdd regulator supply, as these are
optional properties.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 43f4cee40b..827ecf9b02 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -57,14 +57,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
-	if (ret) {
+	if (ret && ret != -ENOENT) {
 		dev_err(dev, "can't get vdd-supply: %d\n", ret);
 		return ret;
 	}
 
-	ret = regulator_set_enable_if_allowed(hub->vdd, true);
-	if (ret)
-		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
+	if (hub->vdd) {
+		ret = regulator_set_enable_if_allowed(hub->vdd, true);
+		if (ret && ret != -ENOSYS) {
+			dev_err(dev, "can't enable vdd-supply: %d\n", ret);
+			return ret;
+		}
+	}
 
 	return usb_onboard_hub_reset(dev);
 }
-- 
2.17.1

