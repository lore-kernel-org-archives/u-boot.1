Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA32D6552C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E46783AA0;
	Wed, 17 Dec 2025 13:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PyIMY4Aw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 291F283B21; Wed, 17 Dec 2025 13:08:11 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42576839FA
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 13:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0TSALcnX4CcnHR2JDiQO8PBwLj84/z9AIb+5iu7ptwOo+82kviLzhJMb9Wd/hpq7V2/q5u3xwGEMvurlNgMB+jazTtiVxKVk5fJTz5P0czKXKjTP3v6QICFR9cPkDDPoHl8zvb+X8ifev7PwlDP7lx4VpLIMh4qftqF1ZQLi58S5dQEUbZKUXMl0H4qT+j+qGppCv4GVolrnmt+RWvPxiW2Osiej4oAchNjEnAl3Eit1nPkGEY2LDPYSDgyvTq5uQ6p6yi1/cf7GRp/h/wSeT+gKylfRLv+2N388qU2l/ar/JUCCq1ZRAtz68uZI5QgTNPdywPE9/tYKIMmZQesuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb41ooGT+b8nbyV+Vt9xuK0A8c+nWv/GzjsQrn4/ptk=;
 b=KeBGccwgOEVxDK0XPrlFVRGqxVbWqtliUUcIj1gEVmvhOQXn3KaQfzzh8P7Tt3RAHBjE5X5fuPXmrmDdRojRZXLV6n0CH/CwFV/LstzstXjXX2glESOWRT6xQ5cQQjVlBfuDqwOONgw2hMp7DTeZjd50tAyfqUvfgmyTIpgM8HRsTtDcfp8I4V0I6g8dEztkMUqdkvwdgGVvKX2nkZerXPfHrDTA3KGvMuaP6n82NpIB/DVbVZxAaAThrhPvuENpBlSok99Ba5rXTOOs2l/nGuh1qJKWEqNVDVzlRfSIkcHidNiM2zfyq+IUmIdfYpWypvwTMQyTLqlmdPxBX2LjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb41ooGT+b8nbyV+Vt9xuK0A8c+nWv/GzjsQrn4/ptk=;
 b=PyIMY4AwLuUXsV8iXks7m17nRUermryEgFlwkdeBVSJzY8dflwjaUZIdsmKi+aUpJzGXiA/GtNxV9bI/+9zB4JaKO6k7D3yN8NxLQoXMEiK4j3QS+kKJCDQj+ZzJdQ13cXyzFlmvAVYY1uxokpCJY2DqEk5yFdOgYI+/aP3a7UM=
Received: from BLAPR03CA0100.namprd03.prod.outlook.com (2603:10b6:208:32a::15)
 by CH1PR12MB9694.namprd12.prod.outlook.com (2603:10b6:610:2af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 12:08:04 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::9a) by BLAPR03CA0100.outlook.office365.com
 (2603:10b6:208:32a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 12:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 12:08:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 17 Dec
 2025 06:07:57 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Dec
 2025 06:07:06 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 17 Dec 2025 06:07:06 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Bhupesh Sharma <bhupesh.linux@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] ufs: amd-versal2: Fix clock name with binding
Date: Wed, 17 Dec 2025 13:07:03 +0100
Message-ID: <eadc8d159b6d822077549722c9ec5a96a4d16c2a.1765973221.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=SW+qCEnjgb62e3zRp4Qa+dTnOJRvR9rODnx/BLBESsc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ6zXmhzhHZnPF7N/vn79vaAzWysz8cWXPe685W74nbT
 PMu+Bh/6ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJBGxnZNh48+H/9fVmcmcf
 Cci/1292WZvcO2//vr8+Fm6CxXrpVtmMDNs2nI6S6FmuzLbG5k+1VdiaLXEyy/f/1ffbUPp1Q/C
 dRwwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|CH1PR12MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 74cdc836-2a57-47fb-898a-08de3d64ee75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rgODkDxSP6fbB/6OhAAjF7Rc56j+FyqAtlhelq0opYjYXQYlukFaAnVFr0z2?=
 =?us-ascii?Q?vm8XqLZu+jZGwKq+CViSDVRq1GuVRMoYZFsXqtqeqri7tJlD/7tumR5zqRaJ?=
 =?us-ascii?Q?qd0AMQdxzzvO3yE6bfgJMPIaeMY507eX/RMz4X/8sby87/pwt4OuEicyFGuv?=
 =?us-ascii?Q?G5h+zGUBRVVA5vY0cPF3xeUxHv40FL0DvMUtx1P4Tfvntk/o3FSi4Fx6SA5r?=
 =?us-ascii?Q?RdtFGG1t9oGwZGF/IWb+NhGFBPTCO7BTc0TFLIl9q5jQfaHaeHRqVDdTI5tI?=
 =?us-ascii?Q?ibE1x6qa6ekYEWiMEmHjXfz87tP54NFhbq0I/WjXMJgBjqS6X6py63MSajmd?=
 =?us-ascii?Q?O8UWEm9oJsLMRCfaTnCnSRkSaQrau29XHUlOkc2QEf/goi2X9+y6Cv5Z5i/l?=
 =?us-ascii?Q?Y2Z10+o4CKiun9wAbGdiutDjY0vKbIS1UEPHjjY7EHtoLk45AjsEm0L5Rdl6?=
 =?us-ascii?Q?7vGKCrrVDk7yEUL2jTqEmes3kR/S32zfFiGKQmxeM7gEbXaswA9lEdO9Rgrl?=
 =?us-ascii?Q?5BXW6rdS6qwpQuBu8sXg0wUbSkblxZc9vsgDZCrTSFB4viD45f+P4r1siJWX?=
 =?us-ascii?Q?K1HB+KtA8GCUTMSmYu3GV+EA0ye9qG/OEQH92EzZ7YbxnTQXhCdSqzVw+rdZ?=
 =?us-ascii?Q?FnZbegnHmkD1LbFbhGaAG3x4B45kLGunpc9Gp3GhIpta8q8oSejxTP575s9/?=
 =?us-ascii?Q?zVzAkd5WbOuuowBqFmKhwaFojwzE27N/frfTQGX8v9aefF3S8cVQUiiHlhuW?=
 =?us-ascii?Q?sDdhZoNRAb0ZGSkQJMjZklC9lT6Ix5Pw85CK00g2a+VUZwe6EhsEJK8MZJ3G?=
 =?us-ascii?Q?YEoZzgB0NAWFBRA0l1N+8gBFHz76bIS0p9d57HZk7mcav6tsyil89GWjxSJP?=
 =?us-ascii?Q?pe1hzr5/efkLzi0TFoEuvCT6QnLLEjax7xyTALvBa3kYaBo10MFXj7/t4bBa?=
 =?us-ascii?Q?TiWbEctBkU3viLcOWN/nHzOZvZMK6bNPqmJx2k1MuvEqabsVzlEQMq6N7dCZ?=
 =?us-ascii?Q?VeC0lRupZmnYXHux9eVOH5pNPSihfScUpV1eVNsluYmWID/szaom6LY+K8K5?=
 =?us-ascii?Q?SKNj2I8bLFUAwsu+YAZNJiJZ9xLitXVy2vgaJwyHpbA23MBhgM1gVWZv2phD?=
 =?us-ascii?Q?wHEXnOYMsdwpMSQp/K2+ZzGO53+AN7RNSAxCtj05h3zTn0Dl8U8bvgAKaupR?=
 =?us-ascii?Q?15+Vyw8xW8NNq01bpL4FExd0weSWcGqGTeoe3r3UMkw3PgB2HZ0fEFgG38Y6?=
 =?us-ascii?Q?wsaiBS8IuBNClbRHO2jnuPbmJpRSwzFHN7nn7UAuLdDa0hCsHAN3R2BcRaGt?=
 =?us-ascii?Q?zH3QZs4NJY7uUEOs+/K1DwmMPpZAsMC3uWVwcfQgmR4kSZ7IGddnz00d7+Vp?=
 =?us-ascii?Q?3I0nM1lPySxujQwseTFDfvyP/6k+D91R+LInaj1a6UDmrGYGMNX7yrojunNi?=
 =?us-ascii?Q?VfmBcSUO99azTPyI9C+/eYG5mMrXFLr5fakuJSrvN5fCIZWSvdodOiB6e98L?=
 =?us-ascii?Q?/rJWzAycG+PCP4o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 12:08:03.9552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cdc836-2a57-47fb-898a-08de3d64ee75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9694
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

Align clockt name with DT binding.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Binding is available here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml?h=v6.19-rc1
---
 drivers/ufs/ufs-amd-versal2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index 97de0756f70a..dd62c9819ba1 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -305,7 +305,7 @@ static int ufs_versal2_init(struct ufs_hba *hba)
 
 	priv->phy_mode = UFSHCD_DWC_PHY_MODE_ROM;
 
-	ret = clk_get_by_name(hba->dev, "core_clk", &clk);
+	ret = clk_get_by_name(hba->dev, "core", &clk);
 	if (ret) {
 		dev_err(hba->dev, "failed to get core_clk clock\n");
 		return ret;
-- 
2.43.0

base-commit: cb4ee3c0a81dda3cbad24ca4b6f69f8a20b29f53
branch: debian-sent3
