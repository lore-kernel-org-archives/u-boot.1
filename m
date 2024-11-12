Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21083D41D6F
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8821C8944F;
	Tue, 12 Nov 2024 09:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A6HhViN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13BA889451; Tue, 12 Nov 2024 09:50:59 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05CC38944E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 09:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTfPcH/iENqqTWjnSBpn50gKcX6uvQEPi3ubZc20qg6Brd/0uWmup9rJustEOnqNFAG/llfmvm8cZ8xvqjZUz6JsgliOfvdCfIomHKpS0oNHPvj8EmdVUXY5z93DTApuVzcmvmEs3QhWKKF5gl49My2+1+65L/MMW2ZqgRNllrPaTFbtrdSkhP0mfyv5gIjXfb8n02zCFEALq5Lfg2Tqx0enPQGaxQm1nHeFKYt7ZZsV7jdhOBDSskpTK9Tu8YkID89LHrDhS/oSfFuvY6qs4mDtG7O0Kiphtpd+IrQ/Vl4lU2062agd7T/44G8KrpwjlDs3pnVMY8PlHhJD3ZkVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E14I+3DKXHxigtV4WEeSoiqrnTGOqjxpxEYGBBMtmjw=;
 b=LwMq8x+Mo3bRdxErpoowMvpTyin18yVUA/joTKBY/5RNI4XIvBz/3US+9Lek2ubcWrEaQwVG7FJvyXy4NduldTPZyQDxxmMcbmwgCZmIz62c12AsjZx4tViayqkurpmaMuGyK5wDD2VBpZ0RBGl05/TsP7ZTZx70NJ5u7dyJ9e0z0SrBvF6Q62HvpJTMDo9b7plnQl7nj7F6oKUz0E01BLGj5EmclfxvIelYKUau/W78GNLDknS3YnLr/eIke88RcQUkGZ/XJhL4astHeoSfSY4mOs8VcwbO9Cu6ODzQ1Qx2pSnQ77A8gtCXem1pKuTGTsrPXcS310k88Kb4zJXFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E14I+3DKXHxigtV4WEeSoiqrnTGOqjxpxEYGBBMtmjw=;
 b=A6HhViN2clhYYslGskkr9Phc0bWVkGtt9AxIXsDtDoi+nzsCxETMA94hXtH1QXkXtpylrd5YZ7AkXhwp8S0kPNXvk/dT+UB//CmhK31zAC3w66iCJpQG16AvghxdAdu9r73PxWSjAK4UHQ16kONWjpp9ngv1bB9RQX0ONKymMUQ=
Received: from BL1PR13CA0080.namprd13.prod.outlook.com (2603:10b6:208:2b8::25)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 08:50:53 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::aa) by BL1PR13CA0080.outlook.office365.com
 (2603:10b6:208:2b8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Tue, 12 Nov 2024 08:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 08:50:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:50:49 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:50:47 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 02:50:46 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v12 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Tue, 12 Nov 2024 14:20:26 +0530
Message-ID: <20241112085027.21352-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
References: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 2414278d-3469-433f-be97-08dd02f71d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?96XiqSeNMUuedOgvhquL+HwFfIYXhXbOCZIjxT136WA4orG+Y+Q41+Cn+gxI?=
 =?us-ascii?Q?mQkDT7knLnbPmjmkvoUv8P4yA7OVZTkudLHDuTSkRxxrs1boY35kwSN7Ny+8?=
 =?us-ascii?Q?dlne9i4/TaxDTFLQzwPVj8xR1niUq3tV86iBVkERpLvWQoB+fCV1n/vWY8wR?=
 =?us-ascii?Q?YzT+J7unN8ZuYyN4wV+ArMn/ZIwJr1GjLGG7/+r0PbbyfWgjG+U12/OC2rbK?=
 =?us-ascii?Q?2IDdnrSv3jfiNJPKkdrf4H/8BQaFgVHhn4NKRH/FBW31raYEWYqj0BjFyCFS?=
 =?us-ascii?Q?JYof9b75Q7XaOwA7T8dZrMGX9K4PjiC0cCFNDQkj24W4vMQExiR0Cc1oJP16?=
 =?us-ascii?Q?esYDCb5OPCZ5hCV6C2ryBXpu67jD166V/PHQ7x5+sQL62KdTBeb0whFVGBkO?=
 =?us-ascii?Q?ZE7utZnVvoAu0b3dMeh9tnBRlD+c65V8V9KxFwSiFAMdN4xAsxq8BlWv2cMv?=
 =?us-ascii?Q?QkZAgXgVms9kVMWJw96SK/vPd/rdNA1LfVBS0IMrGh8kA1qAnmnU+FQuDffP?=
 =?us-ascii?Q?CHmak4zeB80GdnnkI+ahEUQb5rwf6U1KNuYAnUdu71TzphGBIfByYJtjQrIl?=
 =?us-ascii?Q?1HeEk+Knqtk7H5L6LYhl2pEfWxamGJcjwlm3kK0a1yaf6DPrn2nkJE1XQ8A1?=
 =?us-ascii?Q?EsWOesIdRey6WSZ+jF0AraNymc6JsiwUmrS9swaCR/0dnzt0BGqwSEw/5wmd?=
 =?us-ascii?Q?hiB8oYXfCp0xNulvv55vKoLjrX9X4xxX9/zgcHhe6973WHJFjIO/Vf7uAqOW?=
 =?us-ascii?Q?f1wOyQ9GfSV89uUGPnltDumI0tYPXKmDFYN1jn9vBbFQ+wVFhTVP6PjFCCOE?=
 =?us-ascii?Q?wPrVtr9uweZfak6psas+ghDdKa2JyuCKfByD42vUxG9nB7OsHITmiS15/O6D?=
 =?us-ascii?Q?1NhYdwdUHWDYC0OEuqGe3JImm0UM/3XGKNs/joBLO+4+E7rtIa+eCGe4CsJe?=
 =?us-ascii?Q?hqY77JcTZ3tuVr9/Tb6f3byNbLVCbS0kRKHOTHFauW4x7eZEGt97VwhvAShB?=
 =?us-ascii?Q?yi4V0Cc6+F+M0o0aKPo372VRS6Mv0mG4e76g4Op9h/nw/n7HcjCvcO/BuTOv?=
 =?us-ascii?Q?tk9CWINghJDY3/ZAWC6+xXkix3WFhQfYHJFLFRG7WoNNfMsosxDom0oNxLlX?=
 =?us-ascii?Q?gNMuuMoM5UOLRzj9130atRvmIzJ2GktElUpz8Nk3ooMbk/+9XR3M4xK3ShZB?=
 =?us-ascii?Q?02GF/qf9J4PU5jvEcMAaPbB+q7x12auvk2KMgR8z1l2iBtTI8HUPDkuO1iLP?=
 =?us-ascii?Q?+exx/H9k139x0dUCG1+OOYic9qOgvbTiupwFUAYROo0Vyj50mVCIK2nHs4/h?=
 =?us-ascii?Q?grsxxksIUjH+2LzVjPxEnL9Cqdumj1XGrE6qkJeYmdA61dcSd72DpU0+gpKV?=
 =?us-ascii?Q?/vLtydgZvxUQB+EXnRlu9k174sHQbYUuZFDP3gezBxq0rKOwBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:50:52.7509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2414278d-3469-433f-be97-08dd02f71d4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
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
 configs/xilinx_zynqmp_kria_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index dd4df0b2da..a1d9aaaeb3 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -117,9 +117,9 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART=":auto"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_SATA=y
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

