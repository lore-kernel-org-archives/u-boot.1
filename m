Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CCCD49208
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8CC58946A;
	Mon, 18 Nov 2024 11:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xhcMshWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A216A89464; Mon, 18 Nov 2024 11:11:57 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC7D8946B
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PF6jIttpGT07kC9tyGKFZDuFlMENf3h/by15YfHSWxXOLXqJFsezgjqIzV83YB+I//bX7O08D1nHiHT9DjENJoVZcClqpTuntlgipSXZIIl9ow22toGfNIjILp9Bj0SepulAXLjbqB1zEasgGOaQF78tu9xU9yZ0LPAladFZ7gjHHzF9xwoQY6u9N1a4hlG5nrBfCEPEuXH2Ab+jPgzRIR0e6w6z8AlwA6Sx87yXrqBbAA51L1e+DIyGrAkCtr8hrqWLIACfVeOwcn2FUWENVotBExRzwaTLPT2Ip72aPICZwLc7ylHP1Oxdcx/J38wi1lXeZu0aw25D0zgy73dawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAdZ6s7m3L+xuphyNG5y2yMvwoRaNlSMSTLdzz6K5Fk=;
 b=LqPmbnfe+YYoRUtX1pVA76Gug/qbAqvAuqtKNT6NO7/V+JPw0meSd3SOfMRJV0XhXtft5e0qwzHhvPvH12EGAhIv009WDgF5OGWRf8CrxKzslovZB+jSidMI8x3AnYannY7G3EShHmFVI+GTUbAhdH+5G6DdT5z1GI93NljNELj0ke70rHXoDY+3JI04qtcIoK0YJgJyLyPVuoauBQWYTvzywZIet/idtXbwXf37krT6MwmF9ax0HQO05a+SGm6xFTjEOoFLGY2qt6jRfRAS564lO0Zbf0H0HpJVfaaJdIOKtAXPIuiXkWkYH0N1tTsvTMfvgt6IfWmpHAiSj+CFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAdZ6s7m3L+xuphyNG5y2yMvwoRaNlSMSTLdzz6K5Fk=;
 b=xhcMshWOm+lRuY+RrCYHyx9N3D5Ynx5va/14UQl5Wj8gRxyuvvo6gbfarcUHRX/+rPU8GKucuauEThvI3SZHB5mcKYEEm7rSlXClIAoH60xvRSvLjVmvYvrgvAeK4RyEkSidzGMRbH1vjY27ay0X4s8TF4z/+Bg4ECmWMW0alA4=
Received: from CH0P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::32)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 10:11:47 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::5) by CH0P223CA0001.outlook.office365.com
 (2603:10b6:610:116::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 10:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 10:11:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 04:08:07 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 04:08:05 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v13 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Mon, 18 Nov 2024 15:37:46 +0530
Message-ID: <20241118100747.30121-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
References: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 439afb44-a37f-47f0-38e1-08dd07b9697c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pM/xJrpAxeE/TMXoOZHt7KZo2l7x9BQLH5B2yI/U/+IinKWqRUjg5frPOpl4?=
 =?us-ascii?Q?3HqoxCyJHOMwKXQhElE1aC9LGNEont7tS4uycoKV1J+W6+Hih7tQngfwSWxY?=
 =?us-ascii?Q?eJ7s9W9f9gZ63/CsBLo/JF35d+5eIJUdxBvvX/31Bes7/JMtSB0bswI7zYNS?=
 =?us-ascii?Q?Z1t/MTcSAotqG6m0dSlsZ9G8nj62PAqCVn9a6Vo8asKVDq9qHkVKC8N60HA6?=
 =?us-ascii?Q?taX4K+KVnZOVHxA7R0LuuCLkVpBdR6WOkW8HMe78FZm5dj2zmaYphCr1d/2d?=
 =?us-ascii?Q?5lcfpw0jTKAefEkO9IrJUC8XlcXFGLPSjEFs8a37Zen7SVT9fQutUixKZybJ?=
 =?us-ascii?Q?TN6u4m2JhJH/tA5qLdG9yNugZFiJ19a5NgKHaZi80P5LmQEad7p5ITb39m2m?=
 =?us-ascii?Q?aRa7vsf5D/ak1aOUPXBR3/u3WlZBUB7UQ3NgmrMEVrjB+Lw7/cmtAWCesV+t?=
 =?us-ascii?Q?zC3raxrZtCQFDzet/LWprZsKF8/C14/Dcl40+16gHA4hAYJD55X5K81NnNF5?=
 =?us-ascii?Q?323QG9yd693b+LJG+cOPfBZEpTbB1uy9fVAf+8yE+ROaEvvpZGipMceoTdeG?=
 =?us-ascii?Q?+e9otwka2RhKkm2Uho0FXHJ+gIPJh+kpprL71WJWULiZytS0YIe520RWUHqX?=
 =?us-ascii?Q?IM7uGd1szmpS0CoPmcK9wwLVN+UiwCobFGGZ6CCANtTM4JR2gu1A4jfuZQ4o?=
 =?us-ascii?Q?iaf8eJLpIb5TU+e1/J9X3Z7u9Lxqq4gs9s+m2EM6qlAgMMHZ8SqXjt4r+5kk?=
 =?us-ascii?Q?UedZLxWgngSZD5rSc9ubJXHdUj0d13saICbiGUL6RI4rpxWz/ilDF5MiAa9b?=
 =?us-ascii?Q?Hyqc1B3hVPuxVY6hKCHv3NZi79KT01i8/trRrgmzbolPsgVdqK888wI8CV/q?=
 =?us-ascii?Q?4+7r/yTMkOUm/kB/MiZRAC1W8Q5NegVFCcZS8VkuYXrL5QONsx9EtBu7FzX3?=
 =?us-ascii?Q?UmLEjIl6O1HpsHY+xipoIH1EBYX5Duds8QzWJFXhG5HLFsKT/YgjwEfPQyRi?=
 =?us-ascii?Q?Ce2usnK//8hgsJlWU70MjEJ4uia4rYAsHt+0f4aoFqhywIEwXc1F+9v8FpMG?=
 =?us-ascii?Q?R/G+1qOJBUvmNYkzLK+nMLS6t1AtcmFElH8a0D6MqcaSvv6xsJvgxNF57ibP?=
 =?us-ascii?Q?txSeFqZqQcDwO8RL5JXN1vG+8zgRfkH85NT1wzKUCtMYMFYCYqeWfRgl1ruW?=
 =?us-ascii?Q?OXa/mqM7EX3UCvrPa5dgVMD3JieP4BnQxclbhcXoxxqDKGR7qWMUNldj4171?=
 =?us-ascii?Q?wpMZ0tLkxJC9e2k7WwQlHifPMHCgpgYWCJOxY1/jGw+KwbARHGcj8lW65fly?=
 =?us-ascii?Q?DSVExKwgHy9379RNqEU2/8vHxrYXP7fiOvFXsyRximThgcYCCjPm9ca1HAYU?=
 =?us-ascii?Q?1sfwwYet6iK78bvSXfDY0NMmv7wCQu4mYezZSGfmuCXKhH/zDw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:11:47.5790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 439afb44-a37f-47f0-38e1-08dd07b9697c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
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

USB host support on ZYNQMP KRIA SOM needs onboard USB
hub driver for handling reset GPIO and for i2c initialization
sequence.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 configs/xilinx_zynqmp_kria_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 5757a0c9be..a1d9aaaeb3 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -208,6 +208,7 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_ULPI_VIEWPORT=y
 CONFIG_USB_ULPI=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_GADGET=y
-- 
2.17.1

