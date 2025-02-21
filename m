Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1259C021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 09:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3DA8056B;
	Fri, 21 Feb 2025 10:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sNm5MLFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1955806FE; Fri, 21 Feb 2025 10:23:06 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2708007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syq+A0UhtzBk+f4ktWai4Gjey47bsV75R8pRSIUoSnIPWwG9nFbFtTXZUVulPR68E6bh0NBTvo96uoqBtYPYQuCpIHwSF8smQIWESHhXXQUPUhTGQXM5bCBOHqf+C0hrYEDXocOH42mVgh/35xQSTytRl3Y/YKnGEac1XVGzKH0mHw9bBAJexqK17U4rLpt3TrOSDAImwLZS4aJowLLXDZrS5xuPu0Wc5Gw/uEdbifpB2p9c+ANe/7fukPByT9mfc6uaE8Z+jNHNMnEg9zbShnTluYcTQMicfT5G3hYrz1kzfGhX/NDXmhzJBRJ9VdtfKBk9UPq3dPqI+yIv7ViNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/KPr7mJ2DkcFm0eYDfYIvhGyrAQTcsRvCYMGnpsIAs=;
 b=VIJtdnF46/TKfq6xSYasfD+uwza9wHKg8IlFpBmUuAqpXMGPAFxCk29wCvK5DXTIAttCTkk9kUDWtInUrB32K1b/2XEUMYjVv0W81u/E3XGT442rJueFju4YF0jw46vwIehDgMA6z1DyvtU8+sJVsQvXkmcnXFZGD0OmPSNGogL3drmjXh2nTtpCxEHcoqptwjAxOIhmhWX4qPDddUD02g9CIJPlmuJ7kS4I4xUe2x/xlvauoAjva77U0wjlfdST6BDNWJ/GEyumCfEcVP9cwMpB0wkkkRP4BfN8arthrsLlMkDzmZmO6gtg6irAL00/vWyqDmCKdqUXO3Jt3kpBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/KPr7mJ2DkcFm0eYDfYIvhGyrAQTcsRvCYMGnpsIAs=;
 b=sNm5MLFA73gM0EQHcqAid/cXEFgJki9/eMm6TysFLALc0soUCS+Ra0IY840KFWe/vxFL+43EnYhtjK+SotCkAgrpMzLnvF29AvrGTjk3nmF7MX+5Bp3J7wufB6rGYJdtqkteHZgvCFJ/kLHQ0lz0YWpOp0MOv7dEzU/tNsES/8A=
Received: from PH1PEPF000132FC.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2d)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 09:22:59 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2a01:111:f403:c91d::1) by PH1PEPF000132FC.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 09:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 09:22:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 03:22:57 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 03:22:56 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Feb 2025 03:22:55 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>, Prasad Kummari
 <prasad.kummari@amd.com>
Subject: [UBOOT PATCH] xilinx: versal: Add firmware access to CRP Boot mode
 register
Date: Fri, 21 Feb 2025 14:52:48 +0530
Message-ID: <20250221092248.1731965-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: a2558beb-4423-45a3-208f-08dd52595561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ICVKm+Fpxpbj8J8G4juv5LRtwetYx0a8snkHHk3BOzBgO6Oed91KI9hrIwuH?=
 =?us-ascii?Q?QLzvxUKzvn7j+uz1ETtTyCxOov4teGu1mOBoDK22K7kr4ZIIAtBqDmr4fwg4?=
 =?us-ascii?Q?V6/WTDgHz2Jl2KD0S24XCz6O5FwOYAvKzhHHRmIPLcQL7B24Z43TFjZ+9IyK?=
 =?us-ascii?Q?O9byxJWWNa2XXoCLUM6ZYGs9DZBoHRQRueBoeOqXGhWtx4fq3VabT7SWNKo3?=
 =?us-ascii?Q?lKM6VcMOcXIPtCvp4zYYtM75ad92s9KNu86BT3u1plDmFxRe3ifvxo0mNguR?=
 =?us-ascii?Q?ZXAa51HdwB4gaL6fQm7Q+gQX1Ap6tOhHnwZ4JT9SW2ETQMBKDKPS8R7NqNbI?=
 =?us-ascii?Q?q5/UXhV4Gk75QUQuxVQthz2ZcmCXAV5v/0O3A5jPlile6GZzVXxzJMnjXAXY?=
 =?us-ascii?Q?HO1G9N8cKpFv+oJ/8q0XpLHkodpAKtL+ucaroB6F8WkpMAnBMG9adLnkeQnX?=
 =?us-ascii?Q?i6iEepJoyZshO5xBnSKweoMzTPMFg9qDrEAYRfLZFjSfwlaJNi2mhxIAQGaS?=
 =?us-ascii?Q?bafzdmRQG5H3X+27sF2KDnM4Gak9xbJPurY4x/5pmPYce/NdCIIqqNUj8npg?=
 =?us-ascii?Q?Wvs6tJJthU5AKt6zjwLcMXjJWFEqHMjToYPJHQc9jNkKzIBfvxalGqJT4tEn?=
 =?us-ascii?Q?+3fV/Kf1ZXFFl3CIB7an3M0PJss4NYn/XW3lScq83cMa2XmTI6agpbUbx3Kq?=
 =?us-ascii?Q?350CS7nvlnwVlmhZm3GCnC+Rs36ax9+0dSL4n0SjSH1MOT/pVTgIn7qMu7SK?=
 =?us-ascii?Q?hxHifrisMsjY7a2yiEmMvdw4KGvnNBJ1WNKm3FYI5bKR1Bs/4P/LSoR+2cJV?=
 =?us-ascii?Q?D/FzWHxzs0OIJCIbzRXz2QyZxJY7+P6kLmE1fmUygi7hf8Z2rKAAGeY/eT4s?=
 =?us-ascii?Q?qXdlVmNMFxsDVrLsekAE+IP4eVuaS9mXCptt43gIzakJow3FjoNq8maOl2LT?=
 =?us-ascii?Q?fPCKiNVZBzi39yMMXBqmX/EZTqunzgYcJKCuG0CZr+UyzXtuhG70RCGC7o4O?=
 =?us-ascii?Q?Q6PlClXHFfViZRK2FeY4XdYT+yQLJWunaZzyPqnAEflq9irMdrMYdw1OUlvu?=
 =?us-ascii?Q?JLpE/FVw3SnERt3Vluxg0ncv4d7x2bDo3wGtRmdQXWw2BNQ23tjbFgdmzZyA?=
 =?us-ascii?Q?9beRdPvp1vMVGg0pzkvOcSSu5DbCpErSA9MAs/GlhOAxTgvAlcaniXkg9MCu?=
 =?us-ascii?Q?fWhgMbvDU/Syxs8EFo2joLSFXU4ZUvNCcMxJ7HCjV9X3UyYjyvmdXpp7EzWx?=
 =?us-ascii?Q?Nh/08RXK0vGcbEp3sMOIdYMJOmfQXp55+lCbg27Y9zAJrql34rgQpp5AvnlS?=
 =?us-ascii?Q?QjGzvK11/Ip/02p/gXiLQjh101yJKNF8RsZOgOoWhx12WvVz4to3vHZlJb7a?=
 =?us-ascii?Q?CIPEpGoeoA/MPmSpG1D5ELcveMumHhKeox3RldDcdCnlDLeY7EsGNYtjEzib?=
 =?us-ascii?Q?Y9Dylv4NRtpV2J3mXRIMObimVGXKliX+hA+mQdSwuhrWtvgl+wAfumsKlbXo?=
 =?us-ascii?Q?3m3J35tzXP5jciE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:22:59.2911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2558beb-4423-45a3-208f-08dd52595561
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955
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

From: Prasad Kummari <prasad.kummari@amd.com>

Added extended support for retrieving the boot mode register
via the firmware interface, which is preferred when U-Boot
runs in EL2 and cannot directly access CRP registers via raw
reads. Ideally, all secure registers should be accessed via
xilinx_pm_request(). Introduced the secure zynqmp_pm_get_bootmode_reg()
call, which uses xilinx_pm_request() to read the boot mode register.

When CONFIG_ZYNQMP_FIRMWARE is enabled, the secure
zynqmp_pm_get_bootmode_reg() call is used; otherwise,
direct raw reads are performed in the case of mini U-Boot.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/xilinx/versal-net/board.c    |  7 ++++++-
 board/xilinx/versal/board.c        |  7 ++++++-
 drivers/firmware/firmware-zynqmp.c | 23 +++++++++++++++++++++++
 include/zynqmp_firmware.h          |  4 ++++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 4d5913cff1d..f8ac54e35a8 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -21,6 +21,7 @@
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <zynqmp_firmware.h>
 #include "../common/board.h"
 
 #include <linux/bitfield.h>
@@ -184,7 +185,11 @@ static u8 versal_net_get_bootmode(void)
 	u8 bootmode;
 	u32 reg = 0;
 
-	reg = readl(&crp_base->boot_mode_usr);
+	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && current_el() != 3) {
+		reg = zynqmp_pm_get_bootmode_reg();
+	} else {
+		reg = readl(&crp_base->boot_mode_usr);
+	}
 
 	if (reg >> BOOT_MODE_ALT_SHIFT)
 		reg >>= BOOT_MODE_ALT_SHIFT;
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index b4483d00ad1..3046fd7e5f0 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -26,6 +26,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <versalpl.h>
+#include <zynqmp_firmware.h>
 #include "../common/board.h"
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -42,7 +43,11 @@ static u8 versal_get_bootmode(void)
 	u8 bootmode;
 	u32 reg = 0;
 
-	reg = readl(&crp_base->boot_mode_usr);
+	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && current_el() != 3) {
+		reg = zynqmp_pm_get_bootmode_reg();
+	} else {
+		reg = readl(&crp_base->boot_mode_usr);
+	}
 
 	if (reg >> BOOT_MODE_ALT_SHIFT)
 		reg >>= BOOT_MODE_ALT_SHIFT;
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 4b1b80d7abe..2adc132b4cc 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -195,6 +195,29 @@ int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value)
 	return ret;
 }
 
+u32 zynqmp_pm_get_bootmode_reg(void)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_READ_REG);
+	if (ret) {
+		printf("%s: IOCTL_READ_REG is not supported failed with error code: %d\n"
+		       , __func__, ret);
+		return 0;
+	}
+
+	ret = xilinx_pm_request(PM_IOCTL, CRP_BOOT_MODE_REG_NODE, IOCTL_READ_REG,
+				CRP_BOOT_MODE_REG_OFFSET, 0, ret_payload);
+	if (ret) {
+		printf("%s: node 0x%x: get_bootmode 0x%x failed\n",
+		       __func__, CRP_BOOT_MODE_REG_NODE, CRP_BOOT_MODE_REG_OFFSET);
+		return 0;
+	}
+
+	return ret_payload[1];
+}
+
 int zynqmp_pm_feature(const u32 api_id)
 {
 	int ret;
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 73198a6a6ea..e7275f72fac 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -457,6 +457,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_mmio_read(const u32 address, u32 *value);
 int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
 int zynqmp_pm_feature(const u32 api_id);
+u32 zynqmp_pm_get_bootmode_reg(void);
 
 /* Type of Config Object */
 #define PM_CONFIG_OBJECT_TYPE_BASE	0x1U
@@ -500,4 +501,7 @@ struct zynqmp_ipi_msg {
 	u32 *buf;
 };
 
+#define CRP_BOOT_MODE_REG_NODE		0x30000001
+#define CRP_BOOT_MODE_REG_OFFSET	0x200
+
 #endif /* _ZYNQMP_FIRMWARE_H_ */
-- 
2.25.1

