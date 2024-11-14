Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C6FD41C3A
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 05:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F49895C1;
	Thu, 14 Nov 2024 06:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EORGVcdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D334895C2; Thu, 14 Nov 2024 06:11:06 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 337CE895C1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vu/eKfv8eyw4F54Jd5JWvIsyDbTmklkVdV0Ay8ss0aIiryx7WUhODV0alXpka4VsiH/p7gNlGqChz8uvSuu/VcWltyWethyTulqu7tEcAEhf/zcVoQ+ulrpGlDat5V5YPxJq6XDtm1sweS77KDOszvPIsx6pcT6Z2HfG9zUVwcKFVSfq5Aun/rY2GOtVBksE40o5PuUhAaUKt/MIVLjDy65/TdjDTFM7lK/EVa6qCLW79d9+wLiriJTa5Y4aArBVojWnXuJW2ElHZ3ALxdEJAARI/xUnByD7Qjs2OOGOXQwrt+tFjTjgRXN96sBTkK+MHOBFHnIDLeKOJHyXrfXd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxfwRUVwlTZ81loVEGfxB5s+Y/KtSigwjobCbNkL5x0=;
 b=Ck/m6TE6aOfxfpUIXlheeZCLeFuxsve2ylt0d3HX0i+VyghHzfXVKiWK/vZbNvsPP6z1dzHpmQWgwmbFxJZy6vDfmYwa2rK532c0YO8lRZybQhzP0IC1+p8odQSA4C3Tw+MI9w0MzjvtN4MQZnP11z+WvxUU9G/zKdwd3F2aDqbwxyfcnQgKjymKjN3iHAn9GPCvZIEe2ngtE71SdlmT3Pa8Pus6zIoeWLf/ObwipfBeTtquXpPUG9h8wGAVZtDxlhmdDkto2bLkt3PbE9ahHRysGoFZjlhGyN1959N7wdmhHo0xBPiU5DO+jgpjTseh8sb102s+U52OWMgZ64VIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxfwRUVwlTZ81loVEGfxB5s+Y/KtSigwjobCbNkL5x0=;
 b=EORGVcdFm8b4MlV6/Nlt0huiySZ+0FEiUgoQWtiZKjrI1ErDI/hGJGBbR3gQMyfMnPrCo+RQOHwN8ZL0n0DfrNmNzRj2l2kK/6AORhRiamI5bYpylYOt/BUO4++tsKg+YZWd/mUuy6PRKY+V6mV6gkFceyN6UxQzDOvsr02zq5w=
Received: from SN7PR04CA0095.namprd04.prod.outlook.com (2603:10b6:806:122::10)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 05:10:57 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::fc) by SN7PR04CA0095.outlook.office365.com
 (2603:10b6:806:122::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 05:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 05:10:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 23:10:55 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 23:10:54 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>
Subject: [PATCH] arm64: versal: Enable defconfig for Micron octal flashes
Date: Thu, 14 Nov 2024 10:40:47 +0530
Message-ID: <20241114051047.13700-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2d7c6a-3a01-4586-170b-08dd046ab8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n8KYBQ5l11243sLMFjAWoLWjpb2EWAOYt9HE0ZXnPwcxFiNU6j8axZKV7uqk?=
 =?us-ascii?Q?3B7jsxgqbhSOEDxCE0LGomwYq8TrgZ1vydX3FTFyu2cTGmBgha0N74pfONQ7?=
 =?us-ascii?Q?0md9bwGQDgnpbuj8UC7H5ERosCNbcs8JT7Frp/+3aR5GYwJrVZwx/nh/yVQR?=
 =?us-ascii?Q?5b7bR9g7tBwK2GwkXyINw2xFbDetgmBABeJtwNCCZsdcFeqG9yqLgJHfVN2A?=
 =?us-ascii?Q?QsvxoLQWRzaEDDURbr12hA+zflVzNUHjCFPXFJ5xPMetX5SqXQezrs0l8dHq?=
 =?us-ascii?Q?jkb7UlYpkobKOrm/n5+d7JCN1kUTtgGq8g052wm6qAvBpOXJNQurcZZ6iIKa?=
 =?us-ascii?Q?iBH4BHZFGIvoql/fOQEBFrNvC5UBaP9OCRPx9inzYLaeS7tdXeWEqN8fHNQZ?=
 =?us-ascii?Q?bX0EbpklnBUuZhJS9UQk6d41Br3kNH6x7VXvXQgTYk6qO4i0GpsmSeSyD3OJ?=
 =?us-ascii?Q?6qVECGNPMksMJWGIi0kKUJxdkEPLJr9MlwedWK5b6o3cP3rpGACktAArBo/n?=
 =?us-ascii?Q?tMm6+1+phalAVOFkbMEUhNgHy4YbBtKvPLE61TMYbMQ9paL/GniYzfRk/zt1?=
 =?us-ascii?Q?GrUwJNEFtr9Fq3bLwi+CqUxjtHCneZXo+xyueqyyoBOKOgraoGnLYr6ZwYwI?=
 =?us-ascii?Q?eY72V97rLW4XRpzn1/jytU1+TZCPTMbu04idJu1esPSl+6KomOQ5jRt/ZqmT?=
 =?us-ascii?Q?JGy+Rbn+XDjKLPTBTvOFAWKPh/SoqalO5jYYcSNttXfJOIz4ur9RrJZ69+Qe?=
 =?us-ascii?Q?2gID9Fe4FZu6uZRw2vbwMigW8EsoSzy0mr6nVxjqzC1LMc5hxYhDdhoVRyyl?=
 =?us-ascii?Q?KkhtbXWrvq5663e3MjHdxtPyuRXPKW+inVor6HQY15cgcSCSuWcI2fLvs+Vu?=
 =?us-ascii?Q?EC5EmPMVL5vhaB8nOO0vXaEQfztnbqji4J8Mxe/nE96i+RTR9WH7vs9UvfvW?=
 =?us-ascii?Q?4mgstZbeEg4bmDsk9vN1DINu+R4y6NRl4bAHvLnRNypeG3hMv4nnlBNriv5k?=
 =?us-ascii?Q?Oxo+n0DayG15aG8TKgOHDg0/xxacDMIiH39rBxfjum3IB1wTxwND2W+n+m9x?=
 =?us-ascii?Q?ADFeA8hI32Hwt9wrbRKhaXTDkXzznJeQvjG1DtW/nUBXhCu41LTZPAnp1b6Y?=
 =?us-ascii?Q?fRawGc4sxLb6bU4r7Qb7APE7Md427Tgz/KDbVZJv8MvJA98fXO4Z7+dbUfu2?=
 =?us-ascii?Q?zyIoD/3J/fD+SKr+VDfqCbWs70qOUiidtAK25CEmS+6DNBZqsdNFH9jmIXUX?=
 =?us-ascii?Q?X4Hjh2Osjw1tIun94dkutmLNUeWbMGE7NHwOYh5WqbcDo90Px7xMe/zgPE19?=
 =?us-ascii?Q?gQIhkDP4/gtybiEm8QjrNo+SBlMLjDAYBjkdXjPg7AW+F/zT8IkEPnxHX0F+?=
 =?us-ascii?Q?3GByPCy9+7mbabH/c9VyHJfqCZ+9WP+1zuNGhaVhee9S6SABAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 05:10:57.1317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2d7c6a-3a01-4586-170b-08dd046ab8f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
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

The Micron MT35 series octal flashes can be activated
through the configuration option CONFIG_SPI_FLASH_MT35XU.
To ensure their detection, enable this option in the
default defconfig for octal flashes.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index f220cc0254..fe25b518de 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -104,6 +104,7 @@ CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_SPI_FLASH_SST=y
 CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-- 
2.17.1

