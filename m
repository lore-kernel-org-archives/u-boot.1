Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CB9CEBF65
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 07:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E90189027;
	Fri, 27 Sep 2024 09:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NUsNmWqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7048909B; Fri, 27 Sep 2024 09:01:56 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215B289099
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoDkqUozAOQH6kvgI88usfN+tYyfSKkwJSlHABkD0hau4iTCUfHNDkbIGTvxQ3nsIzk7Wb5Qm9ZCfv9aAnxfHIG4W+rilFjd1OT7Pur+SFDPXqq7+ZvGne3KKNO5no7HHErMrnh+yaqyJQSXPXpfVrKlD18CFmixzJYa2T3Uy7OYIvpbAOUgvkubt31v23NcMtajyl3Y+qbPsT6Oc9GLqTAnkKgjIRI21LxmUUCTcYIe774/2g04ue6IiYyvc7+mo3GxIkbrKD0Fx8XU4dxVhmMQQ/P6agbQOpA38RsM5Wr0VzoFuNZyhI/coSQJ1OpHEX3AN9ufJSlw9FCLNiWN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGSsCvi4eRFgOpeC6lLmBiaCjMwoHxEbZi7aMqJ/rJs=;
 b=e3LFGoV1Hc0wboFArpDzxKuimAVqnZJJPs9yH4CpS58KGEqi/q+92Yqu6tvtjCnMrL/QCuRLQzUtCzMq0TFxeQ454NY9UPLnbg5hPRNo1d/l1F4sw+nCXdvx46HehX63SEdbLf1dcRUGCljExLEpifQjvh4LLZ62VMbk1Hh13S6PjhIU7Qj0UfMfRz5ME6j8hzj/qmlkj9aCIcKVRJi446C0bLOErEqyK95S8+GlqPOCnMWSa+DO4V9epLj8XTXLSsM+60fM3eYCCfLVelK1zBPF7E8zoWG/3AB+VujP9Rjkk6uYusrnmbkitIEmuVZfElTqJyBwMPv+uCkjLof6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGSsCvi4eRFgOpeC6lLmBiaCjMwoHxEbZi7aMqJ/rJs=;
 b=NUsNmWqh6Vucd8ItskoW2mb0yIRF9OgNev8r/4XBOrDjRTvtpntu2m4H5caT7OkJfttjkpRxLONeN7I6hg6GBU4H9XFHIde+2FcPENjC0fPO6l3Pt9/XvRZ8K2VJB3h2OYKQDK442y9+oKn2VGqqU9h8vvt/Y4vHvxY9CgiKREo=
Received: from CH2PR18CA0003.namprd18.prod.outlook.com (2603:10b6:610:4f::13)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 07:01:49 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::21) by CH2PR18CA0003.outlook.office365.com
 (2603:10b6:610:4f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 07:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 07:01:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 02:01:47 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 02:01:45 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v2 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Fri, 27 Sep 2024 12:31:36 +0530
Message-ID: <20240927070137.21816-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: 549facee-49fc-40cc-d27b-08dcdec241d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ioj3eJxU4oxrsh0k36slmGp5RLXX4NgN41nSDACx8cScKM3IAKdMOx5Py/2L?=
 =?us-ascii?Q?VYb+b1oMJf4hyL60Ne0TBLzHpByaXwLcQtvBr569CJ88CGqsNcoLGfknRUeo?=
 =?us-ascii?Q?Zkb7kNWepB+cKJdLYINpkqId0qQ2AWAhpaTT7NWjKDv14ZnIuT9H7bsmQUJ8?=
 =?us-ascii?Q?Li3+HQEHPnGJJkb/V32uXu/+L7AwzLHwBDX0FRyn2eZknXG/8sBTuXmom2yM?=
 =?us-ascii?Q?Zo5fcaiMErYMuZkCjlHR1cK742hv4VrTtSM19yVjD18n5uhla4U4QFxA8Ro6?=
 =?us-ascii?Q?C1YRmpjAEiBJLoksSCIPH5RVkbt0qJRzF2gros79tyLdPbAJnAw7mtr0ktKD?=
 =?us-ascii?Q?DOJaz9r+tP9weQsBAO4Dnk8DoSjjylAGen9XNy2fUc+APG4QCmppXgoCJaMR?=
 =?us-ascii?Q?jZfYrifU+WidwwejksBq0n0BdY90UQlp0WtZan+yOC41j3T9hZCe58FKF2pO?=
 =?us-ascii?Q?fnSjdPdQTZoRZtRhYQPxvNpsgH4u59NAQDRKHlELgl9MRSv5SVapLWxYTOZN?=
 =?us-ascii?Q?5VKf13dWubRX1wqx1xZpuPBqJDDzp0FuSpsdV87vkqvuMUEl4ImCcfeCbfca?=
 =?us-ascii?Q?08LpQ7809tJa9oV2yF58lOJPsp2aQ7muqKCD7EjJZEeBsohnLDO0U/2g/Kkq?=
 =?us-ascii?Q?bCv32vW0Z6EptdrMTAysrbWvAq89Gxn7zZP8W3P9EB3Jr62F53NUbwNKgLKn?=
 =?us-ascii?Q?aXPL1JJYMqhwA6ywQ1y4NnRWbMeJTdJsU927B/2pPt8wVXUdXjG6eY6Cwxge?=
 =?us-ascii?Q?zgoN65r99uqGLLpWZYluOd8uy/GO5nub+FbHfXbh/TLe3N+oynEGNOODqtxZ?=
 =?us-ascii?Q?Yzfs3AQMlitfIxpkfJ79Wjubq6PRHhsQIaOXTBXQfjgSp5b93PePV+rhsLGr?=
 =?us-ascii?Q?fu6yi1wDnZ6AaBaIAwIIb7xZdiVkfNtSpxsxGkNiLiOgWL701gMrHbVNA7WV?=
 =?us-ascii?Q?X2W99Amk18EEv/31NqBgqS1ZRnU+Ecs5k4rqfunRbX0wYMYh/kBlwVH2Tycn?=
 =?us-ascii?Q?3Xesnb7XrjSd2fhG+/hL3aBYmA95aKKOb8MX9KctMDEcpvEmAcnKdDeeNMTM?=
 =?us-ascii?Q?DlK4DU693a94betK+KkYVTudkpD+HdQDqw7H1LDwLmfotd+dYatwKVnVFh6k?=
 =?us-ascii?Q?cV3iIZOgZjT30MDKh2TAyUyBk0nlvEUfbwWLhaC3aLz+zzmT6+h6C0Qh8mC8?=
 =?us-ascii?Q?gMidUu6jnVHSouvlZYq/IlGCR9P90QKsrUCT7yZtD06sRKhrfZKGi/kFFi7+?=
 =?us-ascii?Q?t9Zh7F/ROyhA56mhI2SoASvOebVYdwjVVKwKI6dsXn9Utbtb6E5dWsj6oNMv?=
 =?us-ascii?Q?vd3e+sGZyBuZEJcd1HDDw1YKo5fDTJ7Jw+vU1KdlhoRVYBn1JuBxIxfgA/VT?=
 =?us-ascii?Q?fXgTRq2qrNTFOs0vYb6ZANpmAepv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 07:01:48.8802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549facee-49fc-40cc-d27b-08dcdec241d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664
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

