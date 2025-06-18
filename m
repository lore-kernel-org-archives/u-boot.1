Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AEFC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 09:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0850B82C2F;
	Wed, 18 Jun 2025 11:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FdIBtdmH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA9E82C55; Wed, 18 Jun 2025 11:43:45 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC1C82BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkgdjaZPtLec7OISbBbqAYIxmDg6eUVb4DFWbl7PjzRFsxH0L4apJQZ91hGg9ok+S0+pUjhAg/iza3zoyPHzBc9Oe3t2h7CvCNMSX+Im5Qm0/faSZWkLtie7dpc9P7oUimWiU0epc6FRt2iG/L4e3CEy2gVRzgSLBWZxDBdEkASkh2R6uUTMPQ76DSDv015rrEwKBBx1Fggw6JiUVTI8TJFtL+xs0hCFWSSzsVVfYpa6+FUuu+uVCgLJ2hIDYl2drVrfefMKY0yUUc++fcsV23aLjhPz/cOH9wSbQsekUE5XK05vxu68gvVPU4AwBmtwlKc30jkwXGxnsufbQZv2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1k2JibWLZnxifOU3hyTxuaFUX4PlYPyNUdTcm1wRy0=;
 b=IuUnDncwQ21zDQ+4K39AQbM0F1nRePIs031Qi7Cztl1zX2OF2svD8A05i6th6tdJeDOkSOaolPNCoEMSulEzPaH9KBKAbup4wgQ8z28sS3BUoYsidcEvkVW2BGz6vCygWzKgo6i7AjEtfZ2J+GL3ng+jRLdKtBpHtaH1OlHXqpsoTTZ+pgND844Vfm2eqChoGRaZCek3VJw73VFAOhjlsLwOGxZiFjaOsA6egv8XvhU23FJeOLS+/W1w8YlVWncrTKVBbZaR2kqrA9CagdaBnn687OFeOjKnMRQQU60wddhq2oGqjqOUwfp4+eGHg9MlHKpcLTja64SCM6W6vT0TDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1k2JibWLZnxifOU3hyTxuaFUX4PlYPyNUdTcm1wRy0=;
 b=FdIBtdmHdLMoC4nHiv0BnyCNRmGmC0ev4xf/BZRCA1CUsgyqyBQXQfBPpK3uHuoFtuJzsxdCJLL70Em/bRFSO7wkz+Y1n29wExayxwwiehrUFVWPa/gasbsYrt4hWn5W6/pBf9EJ7PGaXjwiYONDe/gXRkBAvZ/nJqbz5U4o8kc=
Received: from BN9PR03CA0416.namprd03.prod.outlook.com (2603:10b6:408:111::31)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 09:43:39 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::41) by BN9PR03CA0416.outlook.office365.com
 (2603:10b6:408:111::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Wed,
 18 Jun 2025 09:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 09:43:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 04:43:37 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 04:43:36 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH] clk: zynqmp: Add support for dpll clock source
Date: Wed, 18 Jun 2025 15:13:29 +0530
Message-ID: <20250618094329.296731-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 329771d4-9418-462f-3d8a-08ddae4c9adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kXKUFEwTxDVTzdbrLk0jFhnGzYjG+It5a+g4ATCMcK4k+mjdWr534eQoAJyf?=
 =?us-ascii?Q?ZZDBmP9FoK8ujgYmynN04plI59dIOP10J+KZ0qFEg04kQUfmt3UNE+Dkt0Dk?=
 =?us-ascii?Q?hyrM9rDIKGy5tSDcz9kvI9ZZKMP/i+tIyJncO2XKuUHlwECjtA9iq3HAUEZ3?=
 =?us-ascii?Q?OTyysjgNjCdDgfghxHqhOz0OJlLfrS7DvpABe/E5AeSWWT/l+BA6/TYAH/wZ?=
 =?us-ascii?Q?nK46Op0Ihma222kazBs0Yw20O3hnrZWEa36rUMEqhevZITXexb0RsZ1MhSbi?=
 =?us-ascii?Q?nTqbnDSXvLRS9Nu+bhSXMkWiJeNllwG0iLyrhziVNHJdcyfohcBvVRMnjRRE?=
 =?us-ascii?Q?ola89COMveDp3dF+vRvkulKS0TPDNkjMkAs7E7j+gJ65WRklujbzN8dIe7mc?=
 =?us-ascii?Q?K95KAOphl8TG13YRhRWzhpaU4ry45tk/ws5SvtBI1RH7YMQeEkP/vh3tO1i+?=
 =?us-ascii?Q?BiVzUGWw5wtcMHeZNgRXjvzqBUdykjJMdUkKu7zVemzuaZBbjtSV5KyOEGUA?=
 =?us-ascii?Q?4JAj0vjduEblgLzqrlZhRPXSOojECDRCACE0ExjGdSvzHKWX0egETPIAq6n3?=
 =?us-ascii?Q?xDSS5RSXMA0EX7bFe22zryxqcIP3fwrO6jMQAH07HqWi7CpwcxQ5dvsBib1v?=
 =?us-ascii?Q?XUCQsq/IJTWpkwRkS8J8PSOkReWS3D30Rer+txC93hjdCDf29pQQP1PEaDEN?=
 =?us-ascii?Q?0OHRc/dUkjexl9aOxHArjBwDxvb0AxXqC0d4RymxcQK51jYtEPBn1cGxT8NH?=
 =?us-ascii?Q?4KKeyDjNCqt0twVoZslZ5SNMO/IrCV/vuxp2idvAZRnpsY2jz3ysdurqYHdK?=
 =?us-ascii?Q?O3lkazKBuKdQGbOGMYQT0AkYgEpzEilaap1sMWc7FR/B0K7V0Xpu+QpLXTAI?=
 =?us-ascii?Q?M67B8Iwnm/yGEHaWaQe+XVZYXfoLg1TAdqAqtznc8v8u6mQSGIRhCITOcMxc?=
 =?us-ascii?Q?z+3APnjDz8GcKmdH0V49iRqQcediYwXSmWo9w3/cWcfJb5lug7MQAv4nDSI0?=
 =?us-ascii?Q?5DlPxH89+k7OII+KdC6cthiIgZ1K/DoFIsacx9U+m4p2qZWM/wYARyM5tTPD?=
 =?us-ascii?Q?IxJVZhyqrWBE0/XC/bU7G8gf6+YTU1KEm9ojVh0b4cbpJERFqO8jXHCA3/94?=
 =?us-ascii?Q?xB3HniDxK8zg+sksYzbMXgx6jcUJuBEPV0nYsW0mpACGWj43jGbOVjWm2n2O?=
 =?us-ascii?Q?ERJPHnEvj0FJ+nSFys283nN8tRpI2N6pzq4X4+lEg63u5gjLdveq30w3mTRo?=
 =?us-ascii?Q?wi4kyelFmZ8E6mpz8R5LQbtV/A4Ztt5ubgEmLbxgqGYnrXYGxjZLciujZXA5?=
 =?us-ascii?Q?+c4/lOIOveCQaqPJ59F5ihG1dhRMhPkifvtnjRv9Uwlzr/ge8l8tZCGtNucA?=
 =?us-ascii?Q?u+ZotNzCnfOFcXqvfmPo6ZWcGp3bS+t/KQhLrftSxez5hfCneTpnIp0IyAbt?=
 =?us-ascii?Q?6xbDI2PqDWt+anRTIVRY38zCjUTsq5KDQen6eoN0BIWhgflgqFHlsOyP4DVQ?=
 =?us-ascii?Q?qfT3p1NspCqGGSsydKSPZD2uoK2JiBN2tUVB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 09:43:39.4852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 329771d4-9418-462f-3d8a-08ddae4c9adb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538
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

The clock driver fails to correctly calculate the PLL clock
rate for peripherals when using the DPLL as the clock source.
The DPLL operates within the full power domain, while peripheral
clocks reside in the low power domain. To ensure accurate PLL
clock rate computation when the peripheral clock source is set
to DPLL, the DPLL-to-LPD cross divisor is used.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/clk/clk_zynqmp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
index a8239e228cf..4f67c958d0f 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -108,6 +108,8 @@ static const resource_size_t zynqmp_crl_apb_clkc_base = 0xff5e0020;
 #define PLLCTRL_POST_SRC_MASK	(0x7 << PLLCTRL_POST_SRC_SHFT)
 #define PLLCTRL_PRE_SRC_SHFT	20
 #define PLLCTRL_PRE_SRC_MASK	(0x7 << PLLCTRL_PRE_SRC_SHFT)
+#define PLL_TO_LPD_DIV_SHIFT	8
+#define PLL_TO_LPD_DIV_MASK	(0x3f << PLL_TO_LPD_DIV_SHIFT)
 
 #define NUM_MIO_PINS	77
 
@@ -334,6 +336,8 @@ static u32 zynqmp_clk_get_register(enum zynqmp_clk id)
 		return CRF_APB_TOPSW_LSBUS_CTRL;
 	case iopll_to_fpd:
 		return CRL_APB_IOPLL_TO_FPD_CTRL;
+	case dpll_to_lpd:
+		return CRF_APB_DPLL_TO_LPD_CTRL;
 	default:
 		debug("Invalid clk id%d\n", id);
 	}
@@ -397,6 +401,22 @@ static ulong zynqmp_clk_get_pll_rate(struct zynqmp_clk_priv *priv,
 	if (clk_ctrl & (1 << 16))
 		freq /= 2;
 
+	if (id == dpll) {
+		u32 dpll_lpd_reg, cross_div;
+
+		dpll_lpd_reg = zynqmp_clk_get_register(dpll_to_lpd);
+
+		ret = zynqmp_mmio_read(dpll_lpd_reg, &cross_div);
+		if (ret) {
+			printf("%s mio read fail\n", __func__);
+			return -EIO;
+		}
+
+		cross_div = (cross_div & PLL_TO_LPD_DIV_MASK) >>
+			     PLL_TO_LPD_DIV_SHIFT;
+		freq /= cross_div;
+	}
+
 	return freq;
 }
 
-- 
2.25.1

