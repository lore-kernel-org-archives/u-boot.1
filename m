Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EB4CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 06:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69EC487F6E;
	Thu, 11 Apr 2024 08:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XZTpoP/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB62A8701E; Thu, 11 Apr 2024 08:04:30 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 737DB8701E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 08:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBkmFamHag4I6obGFCG/ONml3Q3dto+tp1HVwIgR8yfSQf+DeImvBkBkt3PFS+KIYx9D6Z+kuYm/tVmouIjLFUFVUCr3iLUrQBieCov6ahWbfEUJUVPKFMyBVh8CHhkPVQ972BFuH9leUR/q5GXAXh/wgrez0yb0jzVlxfBefk/B7/SK1NKom8/2rNXBIht1STXtx6BG3ugkqo/INUTk7qOcQJCbeElhFCy/f8joMEFp5MYrDX9yLqSVm//I26KQTZ8zQ1k7TYjHuN6dcyOWAYC3gO9RzHgZ+8w0PJNdeHX0tStALXur0rP5Lx7Ly7tC7JcmHVL25MxkvGMLVbCMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nnhgjKi/5g9nofBA3SfPpCofp6lcdaz0JT2AarhIJg=;
 b=eH6cEGI4giLU1278HgpoMqM3JrX2Bkh8W8Cs8uA/wXhWbwC7SgES9M4fKksT4vhRO05aj5q+z3nEHec53JF03ZflfGfbLLC4CYy8BpFBj7b6+dk+ZwEN/Cdd6WEJnyGezuOWyS/G+Os8VvJmLa3FiZIdwePo1HJzMniPQKwIsyaVmJhpryNNtaED8ZI3U+A1fLSfVWuBGmVrKkg8tPOOPVO334pdcs6qOfYrT/PYYXugxo89NprDanwUtVfAmKa3pDFQoxKyY3RjeVkZ7KB7+BTDe43JHroTuiwW/8qHN+uDJIHjvzPzruC1Pvl8dkpQnic0pvnFxvTLVpBAR/a1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nnhgjKi/5g9nofBA3SfPpCofp6lcdaz0JT2AarhIJg=;
 b=XZTpoP/BH++2EGKP4x/T86s8MRa+0IUlvwTcLO/HbTg4GgIwNEQ4WnmiSUFcx6D6qZ8pO/L7py511+fPlZS/Wl3t0jeonSVtaBAt6eSe0qg2+87WTixfJe62sihFnBOYB3mgGeuwJApnA9d3Hk/J6Z/P+5gkrJXf0kkR3XiW3qw=
Received: from SA9PR13CA0135.namprd13.prod.outlook.com (2603:10b6:806:27::20)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 06:04:26 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::a4) by SA9PR13CA0135.outlook.office365.com
 (2603:10b6:806:27::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.9 via Frontend
 Transport; Thu, 11 Apr 2024 06:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 06:04:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Apr
 2024 01:04:24 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Martyn Welch <martyn.welch@collabora.com>,
 Raju Kumar Pothuraju <rajukumar.pothuraju@amd.com>, Simon Glass
 <sjg@chromium.org>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Enable NVMEM framework for all platforms
Date: Thu, 11 Apr 2024 08:04:16 +0200
Message-ID: <9c8ee7a4c7a16367438a92a4c9581bac9d968f84.1712815454.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2492; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=86GAyGgxpfI4LLv1rarkfYIysnCzF0vpE38sgLHN1Ok=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjTx2kTJt1q7vYqX9s3VucoxYe+7Iy4LhfncWE63ifBdP
 BcRxGjYEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACayTodhFtOqbNNbUdzXDcTP
 TOsv+edzd1dzFcP8oM8d5813Ghkm7VHULrhl3PSqfG8nAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e01031-688d-4631-2ee5-08dc59ed3d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPsTuqPwGqv3U4P5bguz7XYHP6WC9z4k2a7QYL6QGx3T9Z4h+tcEmPDsmWFbNJgWTTpo7T/kUgCCkRO2dGcU68qjJMrJTKiWV/iidJYFLvi2tEOA24AVi+4DLM93aYfJZTebE1NUywZPSEANix7aDC9AQeWzxasvqaB6iteEGwlLilxoAgxpi2TTl9hHNotdHmSWBxoyw62nuj+/T7w8vSIjvpo0wbSFNaPI1nq9tviKK90fIg65rDVmQ4jwin+hP8vj7KN1gruXUYahchl1AufenosUbGpng4OGKFxX7iIrzTjzrJTTm0rY16lNcW6uUeIquWY9OAwDP+zP4uhiSFNRWAgRGlkEOdDSckTy2DL43zfjWwB2SqEn0j4YsRHY/p3bxLvzQZg1WW4qgJZoQPlXFihXLHlg3DqsiLo9eG00bBmq45ij0A1WyNvxMEGkSOwI68piUngnJKP4UfBdswIR92NpMPCFvmU8n/J5IEEpWbVADZYVVIUvia7NAfJwt7FFOuCNZI/Fxzs13D3J9kwatMfm5VXBoPpZHUlBzReEXfQCya7eWB9QD0nkIbRLvT2ZlN+SFCsCY5T5UikvYausJXrTVz5+kFrIbsk7RjrxQ4ZkH9yrSb7hB1PK7vI8YopcgfiKvgdnFL0iQouGEMwdStbyDIu3R5Ls3OZDPw0x3WL/jojI0hxdelOV8uqtkyNbT7KNWmBXBuC7b2CZqMLtM6r1FvVJwQ5B58ACQqKu9C+mhFClqjPNMSzQBQ7w
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 06:04:25.4451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e01031-688d-4631-2ee5-08dc59ed3d95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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

Boards which have for example MAC address in eeprom but not in Xilinx
format (legacy or FRU) could reference it via nvmem cells.
For example:

&gem0 {
	nvmem-cells = <&mac>;
	nvmem-cell-names = "mac-address";
};

&eeprom {
	#address-cells = <1>;
	#size-cells = <1>;
	mac: mac-address@f0 {
		reg = <0xf0 6>;
	};
};

For getting it work above DT changes are required but also CONFIG_NVMEM
should be enabled. That's why enable it by default in generic defconfigs
to be able to use it directly by changing DT only.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 configs/xilinx_zynq_virt_defconfig       | 1 +
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 40c6a29a16e3..d9e2e050ceb6 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -80,6 +80,7 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_DM_MAILBOX=y
 CONFIG_ZYNQMP_IPI=y
 CONFIG_MISC=y
+CONFIG_NVMEM=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index c9b8a6de0133..95a671db363e 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -83,6 +83,7 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_DM_MAILBOX=y
 CONFIG_ZYNQMP_IPI=y
 CONFIG_MISC=y
+CONFIG_NVMEM=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 708cfe96b63b..e025256dc561 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -107,6 +107,7 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
+CONFIG_NVMEM=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 18931cffbbd6..296adf066b10 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -147,6 +147,7 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
+CONFIG_NVMEM=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
-- 
2.44.0

