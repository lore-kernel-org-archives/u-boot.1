Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A07E6BF00
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 11:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0979484301;
	Fri, 30 Jan 2026 12:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cmgqsY+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C92184301; Fri, 30 Jan 2026 12:42:07 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED0A7842FE
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 12:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK8A50m/FcrhTWCSym+0ie9KZ/KuMbYxTg3EAzW3GtTz2SxGF1eOWhsFZy/JaqPGSL7lpWVa338+aILpf+VT3VVzPWjmQBLHACdDzgweqwmu6Y14HxIggSmui3AlBz919ouP4o03A3FaSpo0Mk+V6gw2SYUJhSRoc+RWLEsIaaw98rGY2ZiCLuGJthZJeMg7WV5rNlQzb4FbOTPlMyu9ktA/MhpYEWBNmWYmucdJCfmNmFDVF3IgP9KriA5g890nI2WFEx/0NASog2/I5YEsCZVrOSFYTjQd31e6/m//UZlDhXyEkokd6RRTH84w/0WoJtejju2Cjb8iIytExoDIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hObo5eaG7JtdmDk3hv1ADEQCcvyygNPL8eQaExZRJ8=;
 b=SA6/gjbkRb12dvYt0cTFDxLYmW1QXPgggR/1GJFm+L/KHZkiOIf3ZZzvMN5eteJwbpG0Qu1qXOi4TRtkD9ACGWbGjvx0Rb23N56fNsgo6wYt5WIvQeS+0ssPEsrDUa2oKhDzQKm0utPpDsXz6PbDeR/az7WbxT2rLl6def73lktR41wr/8rnQ2Z9zSKVuwlCZyG5oRzt7smRkwkcD+e2GEv0b7PdknZ5Y/O47SPMc9zuaRtOytHlWq84MjKfPUvglF7NUMkCOLc1+U7GLcixlSh4LJfxdlM3xaaOpoaVRRtnFjQ1/tWeMDCTRZ31Ax7oll46mtAN/uaNfZvXo34GIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hObo5eaG7JtdmDk3hv1ADEQCcvyygNPL8eQaExZRJ8=;
 b=cmgqsY+D4rwzzofkNBkBRyvxJoSFNgYqtPg16IvVU+WjPEJ54owzjYLmer6QpFy5wRysSbUfE6M6tycv1oOomB0m6XFgoKmssAQbrdkeY1wlc31NcrHbV9SitborGgkFBlGKSesUtXK1UrUEC7kGNxK9Yqy/t/yKlHJOD1O0vek=
Received: from MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25)
 by BN7PPF0FD1DEA27.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 30 Jan
 2026 11:42:01 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::59) by MN2PR03CA0020.outlook.office365.com
 (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Fri,
 30 Jan 2026 11:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:42:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 05:42:00 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 03:41:59 -0800
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 03:41:57 -0800
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <Padmarao.Begari@amd.com>, "Pranav
 Tilak" <pranav.vinaytilak@amd.com>
Subject: [PATCH] xilinx: Enable NFS support for all Xilinx platforms
Date: Fri, 30 Jan 2026 17:11:48 +0530
Message-ID: <20260130114148.1817379-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|BN7PPF0FD1DEA27:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9e6848-447f-4f44-71ef-08de5ff494db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S3gicWiYV/K834m6nc/gpvC9qYmpvmrW0G8Bi0qFfUDSC7NN8FiGXAQdfrk3?=
 =?us-ascii?Q?JHZNQgUkMQBbhCKkPzgd+TyFgcIxKqOpXKsqqODUuHa5ywP0sBhrZvBWcf5s?=
 =?us-ascii?Q?iK0yOhKXkeEz9ZYt9H8eTF3T+6ltV1xBTSl8p8eZPf7liotLac6SuE9WFcV6?=
 =?us-ascii?Q?KSp54j9TPln59z0V9ShdRiQqWcsNWE3HhNES5cdRq7w4/7O1oOHQTTI+oH/5?=
 =?us-ascii?Q?O8PlLU/Gm8PChHIZkzC6r6r9tlmo/rXEYRE/ILUwNVqlqXKdkegtMtKo2/Fv?=
 =?us-ascii?Q?6mdUZ244lMTxlFg48Lg0+3WGDUXf9O6v1HzTldUjW8I38ld6/1tJ+VEEP72D?=
 =?us-ascii?Q?McTdprmXERKnPO0+AbEwmIortekx43yuIbS3H94NGtbvu4jKMqcUL2h8W13D?=
 =?us-ascii?Q?AZ03JZevVIV3rAU3IZ4OAZX38I2RXv3UE/LrCQylttvXyMmjxYINhOn9vK5q?=
 =?us-ascii?Q?zFH6ejVOa4WVbRTjmNyrZr+hsjgeEv5rTjTg0an6MaysymWenyNqsHucuzOU?=
 =?us-ascii?Q?q13A28KUcTglyPbSdsN41NuT2rLF9jaVtcr/qKe7pc6/gQ7F1K5m3uA8vxdK?=
 =?us-ascii?Q?vjKeWjm4hxlqrvQ/FLFUiKhzOsIN1RuqlaOZ+SX+shbrdnOYi3TRqm5+NZBR?=
 =?us-ascii?Q?/xgNPc9j5orB50wozYZVfaabpa3lQEnfauAeJxYIM7KysIH5lfjPpn31OMza?=
 =?us-ascii?Q?xVTQL7cL02DPCeMSVG5JXyCTXHfkhvueYDmpG597oyOxxfifXpqHl0IfsIPs?=
 =?us-ascii?Q?0Ouf2alstALv931ddEDo+dklmYUT/RXI2tSTeFqHvg+RPW4XvG6U0I8fkHI/?=
 =?us-ascii?Q?R2gVDpoJ5xW1Q0oNESAgK2aJSjItzp+AOSNdSp0jMKYFS1uNvOhDMfpR3NvH?=
 =?us-ascii?Q?aC2DtNtfo+qijWV50XWvd22Zj0mADwXE8j7rga2boaAqOsNQn2LGkNEQiTWv?=
 =?us-ascii?Q?AGii9A/iov+MhDUTjqluW+t3FtOK+RoRXnGR+6yGWaiwHmYvyxrCjr4wbm11?=
 =?us-ascii?Q?rF52apcaVoO6kEiOpTsPLdSa7m0co+pzSMVkUTZUFWgqcmgr4qPngyIRthjy?=
 =?us-ascii?Q?PRxgK8QN5GmdJwKymUeTYWPJvY5F9711B6vmP5AKMTLRW1KWbWm1TV/eRADs?=
 =?us-ascii?Q?rEu0zQfkBvjjM5lYIvZtjWDg1rX+KN8MaUVeZw406CI2WBBkQtCmc8FvL/Cn?=
 =?us-ascii?Q?aqbp3nYLMaYWK1m6V+Qu1HGBDEfseCII7EtpEl4hhV+Qqio5GmK9CabhfYan?=
 =?us-ascii?Q?Zt0j1I3dXreaQSSveVvgTOUFEJZn97RaJlB9LujZSIptcWlOr8ZdhgepHMZ0?=
 =?us-ascii?Q?HAtSW8NoouiuC0/82lakNwaR3XyCgwzbisjdEXtT0Cfgh16sHFa7a0JNj5Vj?=
 =?us-ascii?Q?yIgoo9I9YLLGCNLrhGWXohNKRTswTH5Qc3KcgW5njnmlmbgSL5NU5aFdVrsx?=
 =?us-ascii?Q?BaRqx2W+Drj2VFB/fjFDB2uDMbvNdCT9cf3nQH+zfBNAjtpogQ/zX/oFHY2f?=
 =?us-ascii?Q?jDRu7+qZGn1CHM4BynVNVJtAC3VDPyWsYZG9mqOnT8DcjKJB3YOC7Z9hYeYh?=
 =?us-ascii?Q?eV7YJ3Gwk/aXIBdEsWLegR0oIKsnKg4saQ9saKAKwU6U3QyXGIkpvldEK2y/?=
 =?us-ascii?Q?qKo7w2eZPfehkP3z6VLtKMsHc0VaLT6pE6ufqH+N51ZW4v1C8Kv6fEhXHNTP?=
 =?us-ascii?Q?rWcVhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7JIxNmwni7U+VtKnajzJv3AZPGpbHrJ96FiYunMUd972YpRyg8Erxdw34L9b/A/pGbNU64WjxCWWsrul94jRIPg+XkMqBYKbwS9wKsmFOfgq1Il39S2OW+MY/JmO522J7/OppHIV5/krjVvO2LhgKXnJO76m6TVxgUiXSXtYc1RhcLT2fsB/jsLXBzEs3PMTnj6fxOUg7kP7qsb2DeH7H/Jc0fNc7+Pz0jNsl6Q+X/w4ThtnMSneX4lbVqCPBfg+TPDNnNv2IO13qqTBAItJuiF6+bIDfxE1t2c0WCIXMfGIuT27A5UZY0K7UTdvogp+RFllB6bSgGNi7PBQRC8gQ6O1td5GyHUogG1Yvt3Y/cVXzYNPA+dkOFOao2l78Lte6MIzUilnfYaD6yp20dzLIjOkHWCEqP/aMozciW/5zsLAlAFD8sfLOnAtjBSbv+iU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:42:00.6715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9e6848-447f-4f44-71ef-08de5ff494db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0FD1DEA27
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

Enabled the default utilization of the NFS command on all Xilinx
platforms to facilitate booting images through the network using
the NFS protocol.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 configs/amd_versal2_virt_defconfig       | 1 +
 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 0344089030c..94dce5c191c 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -49,6 +49,7 @@ CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 323b5606566..3410b874a04 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -46,6 +46,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 652121e27a0..e8d6f4cf6d6 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -52,6 +52,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index bb79ddf989e..a00000be224 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -83,6 +83,7 @@ CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BMP=y
-- 
2.34.1

