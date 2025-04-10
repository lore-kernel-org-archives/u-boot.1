Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E6FC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2548A83A48;
	Thu, 10 Apr 2025 10:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fmS9Y9Jx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 461BF83A4A; Thu, 10 Apr 2025 10:25:30 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E745283A47
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2mHOIdi9iHfpEjesScReIQ0TnqXfYShkVniFkNDVLtJN8T28aYWEbQsUcd2BStOvhTpeEchUYEirK++hdy8Uj9JJlT0+clbUV8rvuzW0+hudZCqJmMDFoUzjDI5WG+mLPhrvyajSd/svHsB6BATD79QwqhDb/nsSuZXD25MtVWzzcvGybFXzMxdMZAeKCvXP43c2GCgvpEIZJPK5htcnpu3nywSVY0fdOdXBkBM9xP7ehZuUzSC6wz5Pte5kq6H9m2IRYwRWXvs+gFFh54Mz7SWQPESs/shMdaOLYXdA8xD8Wdv0eYFKXojd9LVb7SpgRmHpzoOkqPvkwJzc7ZQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBWDZQ3dSG+ZGbU3Fb2HEA50DQcd0/bCMctaz7EtHfY=;
 b=ulDCb3wtALqkrL+AJKbpTKFDWMtMwfB9yJRZwpMA9ij7Ys+7eEiDSlGnymQdtLxnW1yQHNynnYdZM7NEbLhJhKCRBcY+5vGTKYgdA+xXjTl7QLca+tvSUvnsx4p/P1Jghl88DT7IzKWYXkuicM+HXziM4o0z3qlXZvLwTxguYkE2JW+QfzM/TtZ9K+e0lWuOken6H33KrwbpCJgSfAsNmA/c7mFYjstYvW/8LYrQVHkKflHdTzQaAD+3S9bwP51wd0WvZfk7PzxGXLM94qZXyd6cxUJj4tsAn+9xsLsQ8lEygUoxA7dKxTJHTg0BZBWuVm1K3rilqE8tkqrCsi/EpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBWDZQ3dSG+ZGbU3Fb2HEA50DQcd0/bCMctaz7EtHfY=;
 b=fmS9Y9JxzZc3kJbtVC1U3h8oJs3fBRrZ843ymcak86h5Az3h5TrMdcAYWucfHG3204NFlh9o3E5Ub4ePmzE9CWEbj01dsMswDAYAzEWLpje4sPzUYueXyNjAtIqsvevpAZ2J9L+ZLZ7Mag2EI60jDgD77Qm3vvyLXwYuXd6uQJM=
Received: from CH2PR12CA0013.namprd12.prod.outlook.com (2603:10b6:610:57::23)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 08:25:24 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::d1) by CH2PR12CA0013.outlook.office365.com
 (2603:10b6:610:57::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 08:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 08:25:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 03:25:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 03:25:20 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 03:25:19 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Heiko Schocher
 <hs@denx.de>, Nam Ian <ian.nam@amd.com>, Peter Robinson
 <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] gpio: zynq: Read using DATA register when direction is output
Date: Thu, 10 Apr 2025 10:25:15 +0200
Message-ID: <8067946288c687c323403857aff01e3074bcaeca.1744273514.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: c976b40f-3608-4dd0-1000-08dd78093dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?na/X7susE5d435QzWUBim2b/Tb5MEw79VSwR3JZ+r21QDAYLHgVbc5nnZTrN?=
 =?us-ascii?Q?qunIH7oS4MA5BpFixwz8J48WnIfmYXyoYf0SYqcw//mMEpxLDr8YHDcjI10v?=
 =?us-ascii?Q?1jw2OS2ynU8kYmirPcqx+N15z4/KudH1vTyX/3X1Ke0SMdijSJ0P4jFzVDUV?=
 =?us-ascii?Q?0LHqjOUfxdviirty4O5IY5eeGegFvq3WVFoGIhTYKODdUXKjJJotnnu6pci/?=
 =?us-ascii?Q?4OUZxabj+bamaGC4FCrEty5LcPLJVQndgmbsUf32VEERPPP2rqinpM7TwnWy?=
 =?us-ascii?Q?5UrploJ7u4wXaluQziDX6bdX34Y9eKOOQ8pAPMUhdUWyuifoU56d5Yuy3auq?=
 =?us-ascii?Q?KxzvNXbZ9axZ4V/UBElicz5YZ7tUNIrBkZ5lCxkR+eoLFLfKMgEkJAu22xBd?=
 =?us-ascii?Q?LZtUca0PB5Y7RSm7ySAKRDoI05156bfCGSg73jF3SFUBsDF2Xkbq0maPC0Zh?=
 =?us-ascii?Q?LMh2ljgsV6Y+yzaGNFv1y5pJUqhEumhfgincHM3J+Yejoyj7HpW2X43PMznK?=
 =?us-ascii?Q?5kU1+nf1kce8q5tOcJqMHlBky9bAATRvC3tgTFGxQNmO41C9HaQjB/HZ/E9q?=
 =?us-ascii?Q?G3NvquZ5hD3wgxgLbzZxMpkrJII61JxBoe1sXpcPtnUl0eDLk4Lnqrxzsfje?=
 =?us-ascii?Q?6I4+g1jNXf4E1wT+kZOhrsA3N73xw4dtXtAMq6OgJZdvWR58R71VFa7rOWyE?=
 =?us-ascii?Q?e5Z2p5lUxSKEy+7chDqrMrSeRMM26C+BkFbGtFi7MuC5Z0ORuOQ20+XFUsgb?=
 =?us-ascii?Q?yn48Qmnlex5qYLPQKamNJ2YcWV7i0SIEK/yzND83kGKALkCYKqsewcFHNy61?=
 =?us-ascii?Q?tNMPVtvXiZBrv79zjKz5WOeUK1OkU7oXfcRJC3SGN/dQ7j4+7BCHfMmgeuH8?=
 =?us-ascii?Q?sElLP98RtF98duZH19DRHWbWHYGYsRImoiTVbCV5K5RfsKfyOIy1dxXvstzG?=
 =?us-ascii?Q?Q8Im3j15jJHjiF6ngPGfCajWWucBHZf/sam1wkA/X+lA9GYKyYDpcwEktXZ6?=
 =?us-ascii?Q?GGQ4z/9N85zyVCr1q5sA7u8Dc7qXdMp6GFIo9fNGgWlFP8vJoiSlTrASKROf?=
 =?us-ascii?Q?fG2tiqNDK8IC2wcphw19QICD8bFQfDlgfr56Z8ktkFa5EGvgjWBRsfjtwpMj?=
 =?us-ascii?Q?dNdSCZEB36R6sJaWOOSF5dXiOltSStjFOLeUxgE+2IwSapEElM2EqtYh85DJ?=
 =?us-ascii?Q?QfzeufbF2I2hvoZ7ZuqAIqgXknM2UeSOZ34hQX953XGQ753sMAhxTx2OQv/w?=
 =?us-ascii?Q?L6+da96LE4w4rk8VpRqyRLHDe3/6iimtnkf1RsAmx+wa8ql6qSlY4puHIi6K?=
 =?us-ascii?Q?+uSRjlDH+my8o0O2NA960Bx8qsj5M3boEMKfoktTi5R9MF8U6cPJ7/ra1bJX?=
 =?us-ascii?Q?H8DuMtXUVYQ5Ag7gz0e8md7whqu85Y14pLr11Z7jR3Q+j7CwsVU2GHTCImxS?=
 =?us-ascii?Q?y0S7zTNlHef1sfM4mD2qFgd910rWCs1K+PC49q0CuyJ2eM/mM/3a7Jnab6kp?=
 =?us-ascii?Q?UG+TUUH0UNzh1OU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:25:24.0266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c976b40f-3608-4dd0-1000-08dd78093dac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Gpio status command reads the DATA_RO register rather than
DATA registers even when the direction is "output", fix this
by reading from DATA register when direction is "output".

Signed-off-by: Nam Ian <ian.nam@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/gpio/zynq_gpio.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/zynq_gpio.c b/drivers/gpio/zynq_gpio.c
index 7db58c70663e..4fdce39d91b6 100644
--- a/drivers/gpio/zynq_gpio.c
+++ b/drivers/gpio/zynq_gpio.c
@@ -64,6 +64,7 @@
 /* MSW Mask & Data -WO */
 #define ZYNQ_GPIO_DATA_MSW_OFFSET(BANK)	(0x004 + (8 * BANK))
 /* Data Register-RW */
+#define ZYNQ_GPIO_DATA_OFFSET(BANK)	(0x040 + (4 * BANK))
 #define ZYNQ_GPIO_DATA_RO_OFFSET(BANK)	(0x060 + (4 * BANK))
 /* Direction mode reg-RW */
 #define ZYNQ_GPIO_DIRM_OFFSET(BANK)	(0x204 + (0x40 * BANK))
@@ -230,7 +231,7 @@ static int check_gpio(unsigned gpio, struct udevice *dev)
 
 static int zynq_gpio_get_value(struct udevice *dev, unsigned gpio)
 {
-	u32 data;
+	u32 data, reg;
 	unsigned int bank_num, bank_pin_num;
 	struct zynq_gpio_plat *plat = dev_get_plat(dev);
 
@@ -239,9 +240,15 @@ static int zynq_gpio_get_value(struct udevice *dev, unsigned gpio)
 
 	zynq_gpio_get_bank_pin(gpio, &bank_num, &bank_pin_num, dev);
 
-	data = readl(plat->base +
-			     ZYNQ_GPIO_DATA_RO_OFFSET(bank_num));
-
+	reg = readl(plat->base + ZYNQ_GPIO_DIRM_OFFSET(bank_num));
+	reg &= BIT(bank_pin_num);
+	if (reg != GPIOF_INPUT) {
+		data = readl(plat->base +
+					ZYNQ_GPIO_DATA_OFFSET(bank_num));
+	} else {
+		data = readl(plat->base +
+					ZYNQ_GPIO_DATA_RO_OFFSET(bank_num));
+	}
 	return (data >> bank_pin_num) & 1;
 }
 
-- 
2.43.0

