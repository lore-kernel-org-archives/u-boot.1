Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07689C7EE2A
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A0582D88;
	Tue, 24 Jun 2025 10:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eQqtOtQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2AA82E26; Tue, 24 Jun 2025 10:47:07 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BACCB82D88
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7aTqUmS9hR2YzGye0h+dDFkQMUaUxozIRGwp+O3u1zri/F6J0EsjwBhYF8ki9DnOgHL1b4C4pYw1/A1NHkxrljzxLLLILLVd9s7iH6toaKM8ioo/8bz57LBuKEWPLzxaIeyk3qunDhcchYOoKII3RynQ8Eow+TGOulOQR0qoGcwPiKWcQREx4/U9YZWJ5gdEYoCy5kyTXf6c77nf3ax+osDVdIzgFNjQlnq+UI1i78IISwL80+/RBAkwtDOwP2a7JDSK7lxWAuLFhBmboeOwBeD+HXrpOJ4dUrgBDW3X6BQfByAYVRdraATABGymN5jouqiRPOeJWAinVHvzUaxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVlhOPq8dv7vKr25+6S7EmGMX7K3njzs6Jlv9JdfCwY=;
 b=Zrjh3wLFc/N6NxOrFNMxZ0Hi2maW8hOsqXC4D+752TfB7E1aNJOLMWz5rgpNXSickjvn2g+zX/OK6bef57w4fU28AoxIvF3PTVW7VTJFqRJ5rJc6CcmdsRURLgDryj/5MLgxZ9GbfwxnrIC1l9Jcsoevs1MtUPQQwhB7asWztM0+SPvSwnn+cDdZexp87OSbYaeQqETIS4gOxGLNjhUQeP6eWF9M0+7/kNhuVx2LdYP1QoixzsDBbWRA+66Wfz/6ffSTMbA62mn+loZj4UU978Hc7sQCnqx+k3iNKaYtGuHF1t2x1dAwz4XKBRlkYdTRzWcNgIPe+OyJsRclEjr5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVlhOPq8dv7vKr25+6S7EmGMX7K3njzs6Jlv9JdfCwY=;
 b=eQqtOtQXLxiLPkcR6BmBE/1AIr5EBMEo0SswhbDA8X7HJYACmOVqz3bnHEv5qdP+Uqf9oxPdHWH9UW8NwLy7ajxmLW3um9SEV0cMLf6V3NRSLeY6Ri0g7VA5O1CsVfFxjyUnagouw0Tvg9AmujxCb0wD7wBg6NOAy1d5usLstgw=
Received: from BYAPR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:e0::44)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 08:47:00 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::46) by BYAPR05CA0103.outlook.office365.com
 (2603:10b6:a03:e0::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 08:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:47:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:46:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:46:54 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 03:46:52 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: zynqmp: Enable xilinx ethernet phy
Date: Tue, 24 Jun 2025 14:16:45 +0530
Message-ID: <20250624084645.1185428-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 5566de38-18a5-469b-974e-08ddb2fbaf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gsGH5lec1GA0q+UszcxV0GJbyZjrFlKuAhZ6/81p6s7eO29TqM+xIlZtZg6d?=
 =?us-ascii?Q?2tSN7p1AFRPWmO/ZcBZz1wycm/IwaL2LeG3mZgbC1cM7vYKgEBpFWtYN4PdF?=
 =?us-ascii?Q?gOzTDJQGj48VUOPnZR6Q7K/Ma1VHjnkASDUEwtGdU+K8VZOVqgULynKTJbCL?=
 =?us-ascii?Q?EHCI2XAzZXCl+1IPkDxb7milMUGB4c9Ub8D7QDyCLA2HEDyi7EZxakka/WRr?=
 =?us-ascii?Q?9YOroMJjzYCsPMqOJ3Kbu+6hZKZ9K3Aq7PhDR1l1jnza729pIwEuC8f/4PM1?=
 =?us-ascii?Q?jvWdrN4L6EL3icY6q9XmXii7fhfW9ecZCFworRrg3SRZ3VQbEIYj1hNp9c03?=
 =?us-ascii?Q?uXVko7hVA/8nkd56gZGEiHsYGcJ1eB3HbNSb2DsFLgjFJ1QMhSbCI5zDPmjQ?=
 =?us-ascii?Q?CXb0aB0E1s+g+BLNhQ5X7z1B6Z7GAA3qQXVnVw5E4gQp45KoV2n8JvavmMJX?=
 =?us-ascii?Q?zcEMMGovQpU80f8SDnaPA27vPnQPfK3+gm2kC3D34wKGPMl4RT/AJa3zbsqq?=
 =?us-ascii?Q?wzOxZ7vjN7+4DTL+uYCUjlbgAicPuoS1xwybPGsvE+X3qJFwtoYRZdVhuCoZ?=
 =?us-ascii?Q?oIBy5hWM6Tu+Fiu36ECqBAbbN4w5kA+uOFiaINNugibh0wJsBNJ8lvFM6tI3?=
 =?us-ascii?Q?1TnuUNsx3fXPz8tBsq9c1sbYesUDca3A/8EKUXpjv6iLO5cGyI04gw3gNeAZ?=
 =?us-ascii?Q?xyunqjsN/QkJfYXX+oT0cqvb4Udpb3RgEFkMiDPqWcam2Hnbqhes8hvpY6Q2?=
 =?us-ascii?Q?wU7u46NavMPFdmTQncyC6SKvrwh0NxYToW4bfQLTcal5c9nQZgxEWxoX+qoJ?=
 =?us-ascii?Q?8soQNCmMiVDrbtGbGjsh21aJv0slY47UShY9eKd9jnywxAs48lHab8pIKr44?=
 =?us-ascii?Q?z5y5HvxwVgqzqiWg2cH7DM839911jUVOzNoiG/9/YgNZlyG8F5bMjUSCIuLT?=
 =?us-ascii?Q?gUwnT8eZN/+thWN2H33vRZgGPm53EXFnVp9ETc3DWiu3rz8CAoUz9ZJE9CSv?=
 =?us-ascii?Q?qLUjAzJLIfmNYV2FmTJ4P5wajM3mYFyG7IgV8xYCIg2/NfHFTnRJJunBlbn3?=
 =?us-ascii?Q?V8o5K1EyDYrDOpACtPS7xE1XVddiOc7b/9er5OJPXyZTo2YujV9ri8avmmdB?=
 =?us-ascii?Q?iHaUFOP+kT7wlHlyyACoB4lUnE/k/UvdMh/AVD9IofHYp2IXwnim/KjibYXj?=
 =?us-ascii?Q?xN278q/5epF7LAUWTeV/ZGYeAQEJEmbZcI7hjTt7dtT++1OJjX5Aon1gWAQq?=
 =?us-ascii?Q?7uK42vrmsDDxf0q5CwUtfnrU6tU2jbQlxJvioQj8YfGPflJdm+kzluWMyRl3?=
 =?us-ascii?Q?9dwNufKf+4qN9Nc267cHwvysyvi4T/G+7JD/sKHT8YCS+WwjU7V6PDAZh/nO?=
 =?us-ascii?Q?U30D05Xp2/8r8LsIqYOieHMsEQt3ri2gz0xk5eAkuVI/9lVv/R3bbjL5IMrD?=
 =?us-ascii?Q?Yf89PnydrZ+eOXwK1l6/7J0ZcE3VWVub6/r2ghiF3G4kLFEXgz5iPtJKNEYZ?=
 =?us-ascii?Q?3QtSUPqnDjfelNs8s966gnu4pPlDNSsxUe+r?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:47:00.1341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5566de38-18a5-469b-974e-08ddb2fbaf30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
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

Enable xilinx ethernet phy on ZynqMP by default.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 configs/xilinx_zynqmp_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 7807f6240e3..a6afcd00b5d 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -182,6 +182,7 @@ CONFIG_PHY_NATSEMI=y
 CONFIG_PHY_REALTEK=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_VITESSE=y
+CONFIG_PHY_XILINX=y
 CONFIG_PHY_XILINX_GMII2RGMII=y
 CONFIG_PHY_FIXED=y
 CONFIG_DM_ETH_PHY=y
-- 
2.25.1

