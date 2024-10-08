Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C41CEFC26
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A4D688DFB;
	Tue,  8 Oct 2024 17:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="axYmT+Ad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C2088ECD; Tue,  8 Oct 2024 17:42:13 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76E8488ECB
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb/kLYL732g1bb5Mo9+j8oRj5DO6cP+RsAgky2oy19Owl01nib1Zi9RAQGYcQu0IARVoeVLMlnu2azcNvGXPTLFu2ZKVhQwOcC1wLCCF83JVmewytiy5XRWfN3WTVivlCYKPi/gXxrS92FHIJ/JTY4b6YjGlhtZb4j1gK+YAfMTWQhU0kXjfpEVLLAAsLGt44zFHxlboa6kB9UcLWOWWdf+sYnpKvAOV+ybqMGVeksAvvV7UWAYUyxK3ANetXlBWQJM14kO1QBtfMu3MDx74FWAyArR7AdFFJEroB0z276O3Knbm76nXoenouw3z8Nr3vcsOBPTLfztbbNacGuLG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSTRpJuC6jBaweiXaO8gwYUYig3tjCD+xk9s+yV6LB4=;
 b=bjqtY5R1zLPnwU0jSddFMQ0C2m+z+HzxdwwnIZN7feXKJrKDfgxDBpYB0PJE/25sb7iFPBSlCr96p0ta7YhdTeMbtISZ820L3LdwCwA891vHu1HzM+okoPRiuvsEpFIdL6pTN2AD3n+aM9ovX8K+EcYbcE9GFC39DHFMQMztmS3FCgc9EyXlYSr4M07XhEvJPM9Z7zv8MZqfgcILgPqBMIRYAS1BSamlmBMOXp0ZDe67D6YMzgZxDUl1MZi7/HqeUTEsSdmpWnyjfPB1Z/zI/yF6h/7THPN7gEIIGW+tk9MP2EHOQhEgnIKhA+112yj0JaRDxXf02Ly62EJ5B3wkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSTRpJuC6jBaweiXaO8gwYUYig3tjCD+xk9s+yV6LB4=;
 b=axYmT+AdYk2KUU6Cf4ujuRpTpk3/92y7CR8qfcmwj/FTfx5QKvLZ+Q3gBfn3P2Vwo2rKb/bQjnKG5oGmDtDpTr4dnUFeKFjhlyCdAflUUbnLuRN5kpu3RGWWDEBpmhhgnXPZelCPu597hTzsDWTGgcaIEBKtKw2tJd3UopnAi5g=
Received: from SJ0PR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:334::23)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 15:42:05 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::3) by SJ0PR05CA0108.outlook.office365.com
 (2603:10b6:a03:334::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Tue, 8 Oct 2024 15:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 15:42:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 10:42:02 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Oct 2024 10:42:01 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v7 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Tue, 8 Oct 2024 21:11:34 +0530
Message-ID: <20241008154139.31204-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
References: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d8bf4e-4c4f-492e-4228-08dce7afc274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AmMf9+mUwk1QNGazkam1WLKCcuvaszZuf86BkefGjsOc1JxxpdXzC7SdMtFo?=
 =?us-ascii?Q?TrpEAqIEFXUMH+iC6XMk5E+nAFRuNrLZIz9gdNHxQW89NoBClaUlIqPgMlnw?=
 =?us-ascii?Q?DOsvwU29gWlR0CRbXHNXySrnHTu/jkEjOALTvn48ZoW+rHT7Y2CEud7cCMN0?=
 =?us-ascii?Q?HvS2/xYWyzyi0neV+bBlinVQhh/+TyBIKBqPW10hGDRvyxc9aIJBaw1UWeh7?=
 =?us-ascii?Q?FjqM4thDdKb7kwk+LiPMvPnEKjE6lxxWz0mjCqABp7/fZCLMW6pNcfTdratM?=
 =?us-ascii?Q?l5UiWu+nDhdj6khr0V9HB2394Nj45+pbCd+o5htGJklxuF49pK1LJDsz9ECE?=
 =?us-ascii?Q?+t1Qq4lRgcbCCPVFvbdbbdiljEcpugHWmNrx+OnMYS5R70cVQimkVDoTdCJQ?=
 =?us-ascii?Q?OSYsmILrwKqQuMLPT9T9BBYXu2fqgmEXwdPguU1+ustUNMXlMK5APE/en9iQ?=
 =?us-ascii?Q?9tm/VCk1QiQKP9x3q/usgquwYt9BQBJ1dAt14wq1jGpqf89DFme1jW8ULkLG?=
 =?us-ascii?Q?+ppb5FQNBC8RPmUbq5Hy/pNcZ2kUE15oeTMd3AcEDZNEwBrfVwwUyayQAglf?=
 =?us-ascii?Q?Y67KFP/wutwPnt/fz2OisKpUZ5nJ01ZO9MQRWDKFmYlWA6BeLuAHmG2PGYuv?=
 =?us-ascii?Q?B5HfFHB3ZxQgSGtmhh3olc2DMEDCrzrpRx2uZ7xv8BMp9n40L+ebzTMcFcem?=
 =?us-ascii?Q?wkGsWUlZFDRlgj+YNg04Md0yFK+4ctPrZRWvelkOkByIc7Pl/dFo22thdfvn?=
 =?us-ascii?Q?GVRM9HZp2jZ5OdSfvYACE1ePbG5th45ta6SIZPH3DfNHM9cwE41Yyy/TqmXx?=
 =?us-ascii?Q?wjgPTZD0f+/Nv2F6+IjhQqNgvljZdmHicc1BryOCD0TjwfyFI2ccVONAwB9l?=
 =?us-ascii?Q?BnlBpswPJOSO6G/cspe1Jz6t4lMGvAAhT3NCLfbkkOKsq2Avdq1XIwO33czF?=
 =?us-ascii?Q?jbqBv2OGGLhvqYV/By70k4e2O4Ld/We7NzHTinIpHWoG16gnGHwStTW55w3D?=
 =?us-ascii?Q?iLcNQkdjS91+GQqsfS1RYz/u7XrMo/QkD+ZbUTDxXkjkgNYALsgDJ+ML77QH?=
 =?us-ascii?Q?p7AwTvSKqcaE/597iukPB/t2MJbuMFYMweFFVIx65OLu1ikURowAZx7hbeCq?=
 =?us-ascii?Q?e0ru2v4DgLQoyNQdqqLD2wr7+UJb86MSzf9KY3HQzXQVn9dTvFb6MAE8Qctw?=
 =?us-ascii?Q?27rkV0mACJdwv9jz+XYxDpS4fLAvI9hqBUUhgv+lIeQKr4Vt9HJi72XTMHp/?=
 =?us-ascii?Q?r0FKuUfwWXrppIB1rpqm/XzC3GaiGIXhpxRSvqmq2ISFoRDadHbFT4oUkc/F?=
 =?us-ascii?Q?vPcpCXtfIZn0bMdgT6c+mjWAm+5Hz/zNLve0Ix2Z9jtcZojtyVsvLKUl9ItL?=
 =?us-ascii?Q?1eBK0zahfLdpc/krTk8sYmOcGtZ/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:42:04.6053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d8bf4e-4c4f-492e-4228-08dce7afc274
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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
index 4174575893..6ef9c87fc9 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -58,14 +58,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
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

