Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41169CEFC21
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C02DE88CA1;
	Tue,  8 Oct 2024 17:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H2qlxq+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B920788E31; Tue,  8 Oct 2024 17:56:36 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E9888C8F
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTbcm11ur61WL24cVTJ74cNW50eaV6u4DcFPcYNSVsH1kS8L8fmjyVcRdmA+lBVKW/PC1Z8+vjhp2z5DNeHeNX6ioWQmniTxBpxmLqY54cDL4uIxkOGSPFOrRk32Rf5mBx9V+rXN4gQ8PJLPL0jP3vR0sAJWmOV53GP24y11vD4wR5uvOK2fOhv5QzwwN7V6RBZ+ESvDnqvcEBq+d/Wcsnxwa0nTjBiBS6MPwj5Bwewx+eq2DJ4y7qIK6Z3/LuY8Pwi4Gpj1y6mI+yhzzgBDMlSOcXpS+K/jApw+24sW9Rsq+MW2rfdDV9uwd3b3nByN16LMHSjOy4LvWHaanSiarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=Ecb0ZsZm78Jw1C02ccvhXOdh+00YBPcN9bZae0b79RQl/lWG8J3VSVNrYg9fViqeWrX9mpGABKIEsR416ZEdF6WpqrEp0iA/umcIxBlPYZ+dmdkJC2P4ELBultH5aKBqCMS2eauQE3h5YLCB1XLJ2nPFGdnFu2BOvfjR/a2dVvdaqAsMb14ZZ3l0zQyKqwSZIwZb2JF9IkdeMFCeQzuKA0xEU1/slk6ehGMx0R95sXDbhMbzm89LFmA4phWtJoyEAZfqizUwFKuW+78XpLrS0Y2cROiZm4keyzT1rfPmcTCZ/a3YcnmOpoc7Hf1B7MS5MdJAdTttHAfbyyZdNIvn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FC8GqTYwYTqTbtYBxO04t9JHkZG1x95PgiWMoZpynk=;
 b=H2qlxq+BqyMHWAbP/IAA2zX3CN8k2DP9tOtpCfwMH6/T/CE2HqNtKN6wN6QleWkynZF3qvBICNVZ5hII7kNBQv8QFzW6b1ZepGvUDJh7W9A9ye3J9mrVEqxKdptEJ5Zko7sP5pkXr/st0A9gH4mtFpikgVagLdvT05KS/ZHnUXQ=
Received: from MW2PR16CA0070.namprd16.prod.outlook.com (2603:10b6:907:1::47)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 15:42:14 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::99) by MW2PR16CA0070.outlook.office365.com
 (2603:10b6:907:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Tue, 8 Oct 2024 15:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 15:42:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 10:42:11 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Oct 2024 10:42:09 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v7 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Tue, 8 Oct 2024 21:11:38 +0530
Message-ID: <20241008154139.31204-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
References: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca2493c-f96a-4fc8-fafc-08dce7afc842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RqIqFU+zTGd/WvRZH3SvYRVLIHlu84T8SIsp1xTo8/+1SHV7PBGzGJNxodam?=
 =?us-ascii?Q?czkM4+k7kVh7rbkcjaKEEVdJrvJ3jO34ztz5TPt84jNSDQZcn6cPIEA8JRd7?=
 =?us-ascii?Q?7hovGj3tKCEDvsR/5KzCVAGRNYNfTsQ9qrRxioV3hskANsTHNAnOw0tfOTJN?=
 =?us-ascii?Q?5mYlNyqAHpgEoeQI6mQqXbuPIjOJA/29hTgYQUnFiMNcRni9hRLsIc2E0FXH?=
 =?us-ascii?Q?2IiFfOblxT3hvHFobmTImINXmampgg8s9f1M24B1bN3UxQqc5pJMeo0tgKlv?=
 =?us-ascii?Q?qhIPPoLHVlEhO0E5ULBgES9jkA7NlJbUQiMCeQK2nBUmbKRM5LgHsXD0HFzz?=
 =?us-ascii?Q?iy9JqBvv9jZc6kyJmHbtZlZ8wR7u4j/KyhOMKEfYo5znaVn8TuqUviDXzeZj?=
 =?us-ascii?Q?mZKXhjIpgbaoTiYvTdb1C148k3F4c6CWDKzoNmtht4QdzAPbaihkC68W/rea?=
 =?us-ascii?Q?a+7FQ9FCBSXRe572hCjs+iN4daGR74OQemZm/DwgX+T/m/IIBI0vF9H3rhYR?=
 =?us-ascii?Q?4fWLAKrkjEqqHgEm7s/UsDZYBUiDT/O5Zf/l/uWF/dRGkkF3F0bvqPWVNDeE?=
 =?us-ascii?Q?ewIrTAu0Wnw1IuQnbkcggWvaYn2XrI9QxlNZ6McvN40lkSF9jOuCp32RM8Pv?=
 =?us-ascii?Q?wnGJJ50jjrK/rusyKBeoFaqUsTQiPee+nUY5nPtXRMiy8V9JydWpnNnDKfXC?=
 =?us-ascii?Q?Rbuy1Z0RA/I9NO7Dz6ou+Fkn0WfBQ30oWAeNkm/3qK7W7cEWNXnI6bbKxEZ6?=
 =?us-ascii?Q?tY1vgfM0IvqNtWM3rlWqqSx0xX5BY3OAxW5xREkXMKkx/2+zFU//DOsFphqC?=
 =?us-ascii?Q?h3iq9WjBe9byY2UXomiGAxjVe7p6Z4jKtCikzLL4l+J/KtMNAqE7s2NgC/ds?=
 =?us-ascii?Q?74r2pk2JNpCUqHBD3fn0r3gMzOkj+IJsTzkn6kR1hX+XhWB8bs69gTM8SheV?=
 =?us-ascii?Q?yRfrK6B7TuTsO8Lm9Q5Ig6Z0SPQp3wMNPJXkdg/iOJMIxfzXB5RNFJs//RVb?=
 =?us-ascii?Q?NZnLyCex5KOdhzT9/glrqbfvyM8zYrJU6tyNIcwiFoPJPhB+2TSKEUtjmDHN?=
 =?us-ascii?Q?VODnnYu4IdwwewyKO0tq+XTpR14y2cLmC9FSk6hJZRSMiatlcF1ITonvJ1hH?=
 =?us-ascii?Q?i3gRi5YDIwcILXj9rin+Spt5w7r/WLAJ2GeOmHtb++WfaUC3AX0m65Knqc7s?=
 =?us-ascii?Q?y6Hk4cvNm5SnQJ5AQcPdNpwLW+ZaxQhKYL1fnwogPDPLXvurzb+2vXVu9ICV?=
 =?us-ascii?Q?sSmvQ/a9kFFMonGaomY/cMlST1xh9QgT2Yh7T3jM5iwlZ1mX3xvvHBbvD+rz?=
 =?us-ascii?Q?67VN/if8H3qbuUubfU95VIyPlA9HFS53J0CjmjG7h6A5ECkAiBO4AhFRDE78?=
 =?us-ascii?Q?F0cguLkE6cXRYIzq0pLmd3zHlDzM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:42:14.3487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca2493c-f96a-4fc8-fafc-08dce7afc842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
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
 configs/xilinx_zynqmp_kria_defconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 5a07edf5cd..4f0199f099 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -29,6 +29,11 @@ CONFIG_AHCI=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
@@ -204,6 +209,7 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_ULPI_VIEWPORT=y
 CONFIG_USB_ULPI=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_GADGET=y
@@ -223,8 +229,3 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_PANIC_HANG=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
-CONFIG_EFI_SET_TIME=y
-CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
-CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-CONFIG_EFI_HTTP_BOOT=y
-- 
2.17.1

