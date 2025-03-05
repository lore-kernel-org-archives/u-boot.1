Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2265DC282EC
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF13808A2;
	Wed,  5 Mar 2025 14:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5MefdtD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6978480E94; Wed,  5 Mar 2025 14:49:50 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C18807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUrl+pgaRc2DOUmu7pLjxqPJ7WhgrY0OR0P2OjAY8OGlc02SIluINi3ClQUhFUggUeDbqf9ENng6MNlfzPl2VNLUYeSxOnXjkFjSStthFyrS2q/VlAObx6JKWwK7Swfo0K4yBFyZz8IfpBJhUwDqBpjrz7n174d/MqSj8K6G/fAHMhuCN62O3Pw0yP7/ylr/ek5p9Ddy4cpg7n8xwIZ+6jJ+DwVoERwnbvb5SMLipKW3a7QtGjoAcE8NKE3ITuAXCaz2EQ0SMjcvhCZic1hiuZs6u2WvK8byOy+E5uh7terQnC1EFv1D36nXi8smf0F7ippce0EPv1ylZr/zmAJANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX8twCHkKw1Jhmy2yzYGTfke3AIMGgrh5wbKDfO0ll0=;
 b=KIakQDMbkok2xzZNBTCJcfX5h5FfFvEDdPZxbbZ3aPMTNV4IC/jCfjhTz3iQZJMV1QqvhG9i4KSgt8s48DqDFxDf0+hLX5+4KhW8LWDb3w3cGMe1PFLrNMwt5Kez8VuRXbz092FqOVN4tQsDx6Nd0yNy9ZHaiK212JI/sNwjRJgTjITRrwSmf+f6XTsZ2UoHwKPeRBdJuD7rL1dNYVfzJZE8XKxGwLhKzOk1k/A+lq9597ktVaI3z7AHPC0wXaVujPjTcAxC9FNLXrbMNM3NBjIvq4iYYe54kleZBnTD92Jtsz3dtUlBP5NpzNrpQ/HhOHkN6QAH1cprsxxWUkFEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX8twCHkKw1Jhmy2yzYGTfke3AIMGgrh5wbKDfO0ll0=;
 b=m5MefdtDHEyzY9ijSOTohcU6QlKOtV8U/RFASgYLBAQfqs6RCE1zqbmj7Iv6vTGHoJwWyASnz9UmnmMusLfOkfoGG0hJhzvd1ansMC7DhJXAe4Ax/CL3QLpMWw1A1VpiquCcdobaEKQo/XTkU1vzHQO4axdpKfU3uGuY6hJOkiw=
Received: from BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45) by
 LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 13:49:42 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::2f) by BYAPR01CA0068.outlook.office365.com
 (2603:10b6:a03:94::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 13:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 13:49:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 07:49:10 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 5 Mar 2025 07:49:08 -0600
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH] xilinx: versal: add firmware access to PMC multi Boot mode
 register
Date: Wed, 5 Mar 2025 19:18:46 +0530
Message-ID: <20250305134845.3182193-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: e045aec6-bf07-4031-369c-08dd5bec945b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5649/6g1OO89MFuZF1690sL4UveMgoZMkYqEIvzZqDTYmfGM419wUSl7hy1B?=
 =?us-ascii?Q?jITgdKq47Qt9NjKYnGF0e5OQgqthzcoMAah5ET8HHVDyRjh7/cGElHZ4Bwfn?=
 =?us-ascii?Q?EEFl87rR9A8xulxBPr7qCeSsN7DwtpGy7dzdb1uqkPbKgAnib5pAJGo3dCnw?=
 =?us-ascii?Q?Uf22ZxeIBbEFmEJL1EOWU8dl9k+btv5KSVl8Pq2eHGlFPHKbJedlezQS2zLf?=
 =?us-ascii?Q?A3hDuPsV751X7oB1Dn8ccBUEkb+aIyWHS0Sv/vSqGb2iedFPqphHeiTV6ruR?=
 =?us-ascii?Q?98NiLIHwPVIlMiI2FbyLb44rjAQDDVUEjv5rpb0/5M8otAXBCY30M1EUtrNH?=
 =?us-ascii?Q?g/0XCFkjtQl3brV7lBMeSdydFrN8b3lTigCzLKrFv6j11oeaIAmrqsRy9Gvt?=
 =?us-ascii?Q?knGYqio2A+8J8RfFgZM3+Me2f6GlWdAvI1ve9u8BWD77bUIbxVvj9VHfakPl?=
 =?us-ascii?Q?FaWS4DW2IwAzOJppYyljkC4EoVA20vyPu3k7NkF6LIuuybLz8OAPF+zeZwok?=
 =?us-ascii?Q?lXBZDXbxMPKB+jb8oGQdpV4X0i/0Zv3rz87osb3LRJnTo3Z1+g+Wguomjha7?=
 =?us-ascii?Q?IrbtgKggNQDW0J7AsKNxbp+t7k49V0sk66/rAbi0YGXTy3hZ9qx8wGN63N9Y?=
 =?us-ascii?Q?+WQ3maKPC+GeLUBD467QO1SFEqL4EyU81UtwAkbQ6OQnfQkB5e869dPhCGIF?=
 =?us-ascii?Q?av6GlmySrNf4sNVaqKIgcDlaInF217IzjuXRHy37jsx8edvHPKyCyUaR51Cf?=
 =?us-ascii?Q?jEmhHjBw4q+hGUgjGsSLfTIIiMq/lz2a7EtpbvwW4yMo+Zh+6Q0cj4J3ky/j?=
 =?us-ascii?Q?WeW27p7Hl/jbxR4otgcvVAYb+ZuXhfDFSrMtnt2PVPIpVF1Lh2mq+mcnJN4V?=
 =?us-ascii?Q?8qFE/byrnUj3G8rvtWakQZKCz0eQN66bnPz+I1co7LSrLmrPhgX2Zo/Qf9cg?=
 =?us-ascii?Q?J9JWxAUyWum204sYvob8cq0LdeZ8uY9khT5sz9pQfKp1TO6t5/bOduNpSNe8?=
 =?us-ascii?Q?zU4eXvunj0ZHvqxBRRAPJ9ELk2C78FnmVuqxci/mRprFcjy8imJkC72Q8X3s?=
 =?us-ascii?Q?IW9+CU4U3GorIUbL1xqKZcrSQ6+LLowMkldpFEROMBmA6Aci/cpxDGL9La3T?=
 =?us-ascii?Q?IcrlacH7emzt8jWEIJRkKeQeWO6/E9Ia0KwTZPQhpHfQKscAhiqUdsLkelr5?=
 =?us-ascii?Q?KFwxGuN7sm1I61DZnu6b73K7MUOK3ZmfYCQx5v3tEJSqAYDHngFhALezawqs?=
 =?us-ascii?Q?fgQhwQGKehmtX/9MtlDrPqwWrhuT6Zs908g34OaRKYXShYPqbOe3edZDLhB0?=
 =?us-ascii?Q?FqCjPZMpqi/EHGSxZ7/GeF3tQD/rF63Yb1TgIy9X+LNXrPY9X/Dw9WaPy2WH?=
 =?us-ascii?Q?8UGoGHjHCf9BlOcS4Ej9/y487fn9t5nAE+7O8WpOsjGXgNvvL56MOoTl+pe3?=
 =?us-ascii?Q?C+oODB8FvdMm90CW17ZSNWDFT3XjS3YHFH1QGxYg6x7N6309YzSrULIO+udO?=
 =?us-ascii?Q?Msb7udi2BTET1Yc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:49:41.4174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e045aec6-bf07-4031-369c-08dd5bec945b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
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

Added extended support for retrieving the PMC muti boot mode
register via the firmware interface, which is preferred when
U-Boot runs in EL2 and cannot directly access PMC registers
via raw reads. Ideally, all secure registers should be accessed
via xilinx_pm_request(). Introduced the secure
zynqmp_pm_get_pmc_multi_boot_reg() call, which uses
xilinx_pm_request() to read the PMC multi boot mode register.

BootROM increments the MultiBoot register (PMC_MULTI_BOOT) read
address offset by 32 KB and retries. For SD and eMMC boot modes,
it can search up to 8191 FAT files for the identification string.
A 13-bit mask (0x1FFF) is applied to PMC_MULTI_BOOT_MASK to obtain
the correct values in BootROM.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 arch/arm/mach-versal/include/mach/hardware.h |  2 ++
 board/xilinx/versal/board.c                  |  8 ++++++-
 drivers/firmware/firmware-zynqmp.c           | 23 ++++++++++++++++++++
 include/zynqmp_firmware.h                    |  4 ++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-versal/include/mach/hardware.h b/arch/arm/mach-versal/include/mach/hardware.h
index 9d1c2f0dcfc..b5f80a8e3a9 100644
--- a/arch/arm/mach-versal/include/mach/hardware.h
+++ b/arch/arm/mach-versal/include/mach/hardware.h
@@ -87,6 +87,8 @@ struct crp_regs {
 #define JTAG_MODE	0x00000000
 #define BOOT_MODE_USE_ALT	0x100
 #define BOOT_MODE_ALT_SHIFT	12
+#define PMC_MULTI_BOOT_REG	0xF1110004
+#define PMC_MULTI_BOOT_MASK	0x1FFF
 
 #define FLASH_RESET_GPIO	0xc
 #define WPROT_CRP	0xF126001C
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 3046fd7e5f0..6c4a2f5ead6 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -60,12 +60,18 @@ static u8 versal_get_bootmode(void)
 static u32 versal_multi_boot(void)
 {
 	u8 bootmode = versal_get_bootmode();
+	u32 reg = 0;
 
 	/* Mostly workaround for QEMU CI pipeline */
 	if (bootmode == JTAG_MODE)
 		return 0;
 
-	return readl(0xF1110004);
+	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && current_el() != 3)
+		reg = zynqmp_pm_get_pmc_multi_boot_reg();
+	else
+		reg = readl(PMC_MULTI_BOOT_REG);
+
+	return reg & PMC_MULTI_BOOT_MASK;
 }
 
 int board_init(void)
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 2adc132b4cc..584397ba29a 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -218,6 +218,29 @@ u32 zynqmp_pm_get_bootmode_reg(void)
 	return ret_payload[1];
 }
 
+u32 zynqmp_pm_get_pmc_multi_boot_reg(void)
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
+	ret = xilinx_pm_request(PM_IOCTL, PM_REG_PMC_GLOBAL_NODE, IOCTL_READ_REG,
+				PMC_MULTI_BOOT_MODE_REG_OFFSET, 0, ret_payload);
+	if (ret) {
+		printf("%s: node 0x%x: get_bootmode 0x%x failed\n",
+		       __func__, PM_REG_PMC_GLOBAL_NODE, PMC_MULTI_BOOT_MODE_REG_OFFSET);
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
index e7275f72fac..5474f66078c 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -458,6 +458,7 @@ int zynqmp_mmio_read(const u32 address, u32 *value);
 int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
 int zynqmp_pm_feature(const u32 api_id);
 u32 zynqmp_pm_get_bootmode_reg(void);
+u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
 
 /* Type of Config Object */
 #define PM_CONFIG_OBJECT_TYPE_BASE	0x1U
@@ -504,4 +505,7 @@ struct zynqmp_ipi_msg {
 #define CRP_BOOT_MODE_REG_NODE		0x30000001
 #define CRP_BOOT_MODE_REG_OFFSET	0x200
 
+#define PM_REG_PMC_GLOBAL_NODE	0x30000004
+#define PMC_MULTI_BOOT_MODE_REG_OFFSET	0x4
+
 #endif /* _ZYNQMP_FIRMWARE_H_ */
-- 
2.25.1

