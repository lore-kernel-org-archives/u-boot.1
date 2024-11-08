Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03A7D5E124
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 04:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D720088E63;
	Fri,  8 Nov 2024 05:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k+wRrfNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B05ED89020; Fri,  8 Nov 2024 05:04:02 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7179E88E63
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 05:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqbELxO7VNBA5KZi58wD6jur2c96nDW6ApUsR2KmlJh8lA8LB0njSEEmuUmRJXJvEalTPXtemwtRtyKfUd7dndbXDUTI/Au/2Y+dwbrtwriLUtp/tHhFuk1IvVufj82Yvv4fTpkem1gEK1hfbkWA+JW3OW1K+8CgtWDODi0JEy3cPR37pl8gL9viTlfRaclQ9NjJTKVG7qdSWaHhlNp6NOAr2Vt6nTNdlYK9P7mrPD9R4wmOJ/M19E+pX0U60ob3ZytrVBdB0mveoJ9HL7tIBezN6RMA62dWBHUKT9uS2KNo/KOunuzXqDsw5wtkkbP+XE69G2tsEzfSf9TGOUSHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E14I+3DKXHxigtV4WEeSoiqrnTGOqjxpxEYGBBMtmjw=;
 b=tnMrS/cvctkS0BxvCbH8VdbzffaAG/F1lEUf9ENjR9A6MQVr7qkzsS5oQX1bcQQROcpOP9+4iyEo5AVeVoib2pFvpKbOjGIfatm7ODQGEG6w0LCLyQ7/dbtLhCXwveqzOQrkjrDOGKcbPreNf5nGq05rFHyNheqrS9kBHmPmKa5XE/PcdHqplQWWWYXctamiaVfUwk1O8TLN/mVHNG4r4M9086MnYxM7wBs26DZUsnNRnT7HYaYDcyXsQ9MmS0sJQkKu8QJTlL4cT11NK9BAnAedkZ1GsIk8olVudhXwhUUvmsdbcXxqCIcpV3rvMRteyyUNj6p5d+q5V4SmWPUnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E14I+3DKXHxigtV4WEeSoiqrnTGOqjxpxEYGBBMtmjw=;
 b=k+wRrfNeVyX4Wzc2T0gd1PWU0s/G/xh5cqhBYCYPN/RIUR76QxRv73ycYyVTJFBbvx4CuRpUl8eTKzor5rUe/85he21x+7t/ZCj60QCc0UjYKEtdWlX9vYrw8XyLlAlZwEP8gxax3+hUm6FVmGdk6jbHt2wRCvFSFx9uTJm+ywE=
Received: from SJ0PR05CA0200.namprd05.prod.outlook.com (2603:10b6:a03:330::25)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 04:03:57 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::f4) by SJ0PR05CA0200.outlook.office365.com
 (2603:10b6:a03:330::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 04:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 04:03:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:01:19 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 22:00:43 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v10 6/7] configs: zynqmp_kria: Enable the USB onboard hub
Date: Fri, 8 Nov 2024 09:29:58 +0530
Message-ID: <20241108035959.19970-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
References: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 9468a10d-b648-40e5-0a4d-08dcffaa5e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ign+mNBK6DF5KFod2T6lUTY8IcD8Z9QasZeSvTl8kh68CoOs+0hQnJZa42y3?=
 =?us-ascii?Q?MUUOmqmHm6wpF7DOKTl2YA4Jt79WSFX3V2cUz5Glv7AGF/lB36NBKYpRvGbV?=
 =?us-ascii?Q?95dTIDRNdBnqfCMWgcgo8r9yhqYo5A5o2JAi+rWGltNdouoB1MfOx54yoDLL?=
 =?us-ascii?Q?kUfU2mHm2yJsT2UV/RdfW4L84SzVqAZr7fDYq3ItwEBex6u9OknVzPsQzxSx?=
 =?us-ascii?Q?9Q1ror0Mmsco2N2MYKETVJOF5SnP6WFlzAQeb/T6TjtaDwp87q6Ef05c2/3m?=
 =?us-ascii?Q?HFpy1camf3b5rU7o+fDMH4pP36yeRI4X9SxDzcVmfFyWZ3pjL5N6Cn9fqAW+?=
 =?us-ascii?Q?beT+pxteL9qta3V2yxMTdMEnL/voFnsHywFn+6QaviywqXyTXRKb5p0Wh4ch?=
 =?us-ascii?Q?/1Sh3m6xK96CA8EAbuDVfejwuHQ6bBt/iPnWtofJRyn6J+ggQHSS/vqqmyC5?=
 =?us-ascii?Q?g3UnDO65rkzPZSMEVpjdKGfB6ClTJkO3Fq3QiFBoXfPzVM28PFhbMX4QKEfC?=
 =?us-ascii?Q?nRhXVLPo7raaYWqeBo3CcXs3E189QXJK+GoX98zZvndY/d17eXLKMRP6M54X?=
 =?us-ascii?Q?BGqdcq4XZz34TJ6VUniwnUCaebaZY1HVPZXhLvCKi4Y5sBmntfBKJaY57Rnr?=
 =?us-ascii?Q?TMRGiQk0LcbhvFXZpmbsOhK8Eq5iExZ2JCggo5B0+fSTFvaUti2vKjpF+7bj?=
 =?us-ascii?Q?H0uGykpXiQjVnroBgu4XrfhxRmQP7aWimbSIaE+877LcxG5t5cyAYWaeLIgB?=
 =?us-ascii?Q?6m5k2WK/RUMpS19ubY+sLBLalqM9ymYofnhEctdGHwGerQGgQbBxaiUJcuQD?=
 =?us-ascii?Q?8qJP87W2lLWs40EbNrkFtPfXwqLiEPoPIVoF7e2a1gXQTM1KZYfqQR00n2xO?=
 =?us-ascii?Q?WuG+UiXOdDEqLE/F95LtqdvFo6q+BeNa0aTXqGHfAwoWqoW5KY0nRzghANkj?=
 =?us-ascii?Q?TTaMNQrTvfuKvEfsZlUaBYYjVqHm119og3D9fKDnNlk/c4LzCEBZ2xrpc9QE?=
 =?us-ascii?Q?FHco5qa9ialq754aFJdGjM/hWTExvbJSIDznsYltTnpDPFZLRSuo8MBbHHHH?=
 =?us-ascii?Q?t9B+aN0/NHBWAg4QYu4xyVXaR6Mp2jpO/yqTeajK9foea3m+RaiM9ByG8Yn8?=
 =?us-ascii?Q?H/vcs4q0ukWSmIqFBORPhIe9uMKDcDGRgYFmue9cqcsIfJHSM2o0PEyOAnFF?=
 =?us-ascii?Q?TMjs8MDszkyY6O+kWiLlAAn6uO2lxSkcbSbSxU/qaWYRPOdRnEXUGY7+YYx2?=
 =?us-ascii?Q?XUgaYap9peuHnC+Cnn79ejjQ8wYvNnhUykqRJSp02Wsw33kYOp9U/BUnqnJN?=
 =?us-ascii?Q?a/JF7CQUzCeAncLzEApWkaGqvBBt5mGl5LN2P3x8LdXUJXWdl/pvxcECJfSx?=
 =?us-ascii?Q?WWM3YTZt9cS1BGHcjW6KE9E8F3+8h1Xw7Ht3XCZIeCc7JdyhEg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 04:03:56.9810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9468a10d-b648-40e5-0a4d-08dcffaa5e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
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

