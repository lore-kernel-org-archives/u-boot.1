Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F72D74978
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 06:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 513B8891FA;
	Wed, 30 Oct 2024 07:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R2JIxnSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50EA9891E1; Wed, 30 Oct 2024 07:44:12 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6878A89206
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=He/Tr7Jlf3Q7D/IVrcNPq2B+mTjJ3eA/dv8fNW0bQb7YkT+yTbfwaDiLcMZwMXm9ywP8Ot/v0R2vNwSYEDTTdWEgD5JJHjPlhgrh9cgJHAk7xaW8FJE5J/F9h5N21jv1dhg4w6jrRUDhfWGT33lLynyJwGLPPASPl4Pl0voofujHtIF47GRDugsh532PC2QmS6GK/DUXq/FnhYkJ7aPxYqyQApMUY8wzgPPu3z2+Uf21ZyaI83uCbDJGNh+j5umGxR2pPa5+da/V0h3lS7T6HpQD3kZM+L3CDWbpzymaVOa6Ks4mn0yq32FXEEQ5yBVLdj871mjG8+eoPpJSN+e4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSTRpJuC6jBaweiXaO8gwYUYig3tjCD+xk9s+yV6LB4=;
 b=SXqLBUD1udAdc0I4lWH8GaFBEpPtuDds18OOuAipZrQAQdmKc7QKKygiNGtZGTwrBKWb1o1n9WmkUHkFZV+Gu0yBEwxGAR2O4Y1FDC0THHHP/4/AhSg5hqmOU9kS4CHnYnAnRuZQN0PWJmyoJJ31cjzljkTcKcTm/v7fuoZyYSQ3qsrUO0/9dHV/E/SP+wqZDvowkZkAiOS3N8qa/37MiIDU2anTv3Cz1qphxsXRiN/p/Wvvy8Ls4SuTz+O5aXAPCM0DVmIVlaAw++plCsNsEja7cMf6jB1nA2kxwCotg+V6Jk6rgHwCVWIWZ/XEeR2RacgsciQIpFLAAyX/b9lESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSTRpJuC6jBaweiXaO8gwYUYig3tjCD+xk9s+yV6LB4=;
 b=R2JIxnSeRgsHGQGWsTzV3HftyTM8y6szXpWfo3ifAR8Tw/AQt7YXsc6oI7R6zj5OphSQkW6VU+kCiPdjqLmo/6Ev98rv4yPVrwVKIRHIkQGjcCRm7VViiLIkbo/YGpQDipwmnCuY6pcL7LxQP+mD9Kki4hlwEYpz3AJxTqiAJtU=
Received: from MW4PR04CA0309.namprd04.prod.outlook.com (2603:10b6:303:82::14)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Wed, 30 Oct
 2024 06:44:00 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::f2) by MW4PR04CA0309.outlook.office365.com
 (2603:10b6:303:82::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 06:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:44:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:43:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:43:26 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 01:43:24 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v9 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Wed, 30 Oct 2024 12:13:09 +0530
Message-ID: <20241030064314.28604-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
References: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cafbb13-5c26-4638-3756-08dcf8ae3ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZpAvVUj4pL4dMJiG6GXHlDEwjnN8tHTFeEDuxyovjPUpqxvCJopS/RDGaSFm?=
 =?us-ascii?Q?Iz3PU1tMhrJcsNj+ik6d+VogVk1oDY+ZykqmRfxAMLlZ9HGR56gImqvXSO1W?=
 =?us-ascii?Q?lj57w39PVvXy+NXw3HNIRI3IawUvaE+wuxmCgfqHjxx1qXAdlx0TueKOK2kK?=
 =?us-ascii?Q?2Sq21XorxaFFs+l6CQ0lqm4BRmDh2DpvsSIuVXvakoIqF7tSt9+v0kQk2h0Z?=
 =?us-ascii?Q?Oq2YPGMPS9MW5f4jsYaNtGtCbHdTLrIe4HuNrxr54FVrbTwnx0gGiCY2RQaQ?=
 =?us-ascii?Q?KWxsEUpK4Z3UrgHmeA2Ae78ubT1vecgQYj3L2NKqpapUADu9qF7Dn+cFiLvO?=
 =?us-ascii?Q?YFWl6Eh9HltLUxdI+vjnYhQND8GvzREKU5oUFyzAHhJPgYSJgvhrJIVquV1d?=
 =?us-ascii?Q?8oiYJccny4tAQH98kjvaVxt8yf4QJGc3YYberK4HH77S+cfrcEHNae/8seg4?=
 =?us-ascii?Q?Xs1OJ5lO/DrINONT1Kf9QrXQFUIDsZa1YEJRuyDvZ0cya5dZvLwcyzXGptyN?=
 =?us-ascii?Q?wvw2dNy8vdJOiEcQrfP1xzENsT6agjpGxMpnvCLv86QQkyJqtvhCKN4OFTIQ?=
 =?us-ascii?Q?TBk1ztQTfQQIWlDVO2oJ48Q2kX6E8Ayc6wWI0790EFP+28t4L9iocx4cFFK7?=
 =?us-ascii?Q?xUTG5J8RItZOJgvp+0KJgQuxdeUTso5+OlfqBqkEP9W0x4VANEnXUgd1V36K?=
 =?us-ascii?Q?OKDq6Nu7BpgQ2MKBrex2v88l0RSvJTm24b7FnrBy67+N0X9E3GGq99tiRJ2P?=
 =?us-ascii?Q?udPis+6tks3PYu58vQfZgz4vPhYEyFj47RkFAdfgWa2HEliVfGLVtBr54uY/?=
 =?us-ascii?Q?R0yYzI5zQC1yAkmJZf1oTZirghNF/5sMA3vBK3X87KgYY9gIoq3/ZMuiR/kN?=
 =?us-ascii?Q?VEqmdh1rfKPtfTjcpRB/Jtv+5Ab91M24pXrI1Blz6lXbvMvXj/RvwJqaXsg6?=
 =?us-ascii?Q?x1O0OqKCPCrs9OJIlAK89Q67LzrKoVX8sIb7dZ9R4WJsquRJuKDDGoC/2rUv?=
 =?us-ascii?Q?1eI2JZEGwTqz2MIPvt0dwd+2YE9Rh24LHcUFHXtk6VOqjpg4ZLWnExBdlCJ5?=
 =?us-ascii?Q?CrtsGjVU8DMA6u5VLCHt47NH2ToL9ua8hYadTeu8H2Cov/P0UcqLoSPTFR0l?=
 =?us-ascii?Q?XCmeJ9ylJoD1W1YxV8ES+23PSG/BnFq3HgamU6WMNjPeZ1G0wAqXmmw7Ggj+?=
 =?us-ascii?Q?5dYudBBRhI5qo6kWurKc+Uh7Wvh1FTbQB/H+eTpxpzYFDnm8oIbQ+B+Ee79/?=
 =?us-ascii?Q?sRfn9gYu5H48j2qcrrH/UPE61oavusOB9XK0lDvbiBTVwp66hlrkWaSqizA7?=
 =?us-ascii?Q?zGdR6QC83Uhzwtbh4gM8elJV01qWY+Fydl0PztT/RSChlVHXn/hEHaiqwkzk?=
 =?us-ascii?Q?W+CFTVZEUQxWBd3koVJKlLShfAGpg2acW7vP3eJIAMXXrrv+JA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:44:00.4550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cafbb13-5c26-4638-3756-08dcf8ae3ca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
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

