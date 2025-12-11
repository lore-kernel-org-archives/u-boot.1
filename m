Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B2DD41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 09:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6454583655;
	Thu, 11 Dec 2025 10:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s5hZMBBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7B3D839DE; Thu, 11 Dec 2025 10:32:48 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5EDF83642
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNu8kHfGbiQxdbvNAfhEdtjG8xX4Bj+LwZMzB7qvhvbxd3S5Yo3znZqk9+vNTL7WyBGBc3ahrTVuvfUyYEY4EuEfMRFT21C/o9a5NxLUvOZ+FHoucx2chyVg8MMoFFF0y7rGCQujC6uNH0CFG9OF7/Qxb0UOiQ1Rmy7Al0Fi60a8WH+tNbOPzHYbRKXSjOO1PdPVwGQRe4cOCMzByQUA30CeWTm1HBe0i/xZDH2lTCfVb6M8IG+8pSiECJ62Gz+Jjwmru2Gy8ggju9JCqLMtNDWl9URy9sZ4+p8J4iMUrZQ/Qr0xHYJ2VbfTmDdvfJzLLThWs+jjh71DXu8lMmCU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpcojoiFNkBXBNE61Px+XPPjOKbnYXxcZl/WODhVZGc=;
 b=KNiajuz+FCvrBhabIKX9h55FCaSRXLRvawFkZGRdGy2h+i3EmOL3YBKZqtaAYZVJAE+r1rTQ4kwNsTq2ljTltBc9YOjci5Zu2CdjK8xIZPuvzb1SyYjzRKLxK7Lqikf4NxYzv+Wjxxil3SCI4EXjBlaA9QTUGycTYVyU+tpmmMd/vCr8yOVvZrBJUbHWlLZSkAWYJMhssf39Ad5WjBEa1PI/EefJFZ+0qcU/n7fP+ymP660FjMkQJ5Wxg7FmrXtyCzgQK3p9Cz/2Fj7ekG4J50NgWn65UDcZO4yQtCDXXj2a/0W02D1s1yx//l73JmwPY1BA/RpeqgwdQZIsdaUxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpcojoiFNkBXBNE61Px+XPPjOKbnYXxcZl/WODhVZGc=;
 b=s5hZMBBIzpeb/NR8m5RNmoMPn9JjfCe6D8IoXo09vrUwdfFok6xbp576Y0pL7kmnKvsj0pHqT49tiL13AgbEeZLMcfAKsqpx1CIrLVHtlmArEYjtjHv2yVAyAgqKT2lbGEHQQIcni6VVjG+i0Ju5Tsko1yfQ/U3tWWbi1v9ADxg=
Received: from CH0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:610:b0::13)
 by PH3PPF077CE0592.namprd10.prod.outlook.com (2603:10b6:518:1::785)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Thu, 11 Dec
 2025 09:32:41 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::44) by CH0PR03CA0008.outlook.office365.com
 (2603:10b6:610:b0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Thu,
 11 Dec 2025 09:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 09:32:40 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 03:32:39 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 03:32:39 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Dec 2025 03:32:39 -0600
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com
 (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BB9WaWV278766;
 Thu, 11 Dec 2025 03:32:36 -0600
From: Akashdeep Kaur <a-kaur@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <msp@baylibre.com>
CC: <u-boot@lists.denx.de>, <vishalm@ti.com>, <sebin.francis@ti.com>,
 <d-gole@ti.com>, <k-willis@ti.com>
Subject: [PATCH] ram: ti: k3-ddrss: Add workaround sequence for errata i2487
Date: Thu, 11 Dec 2025 15:02:32 +0530
Message-ID: <20251211093232.3706673-1-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|PH3PPF077CE0592:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9fd7e1-44fe-4876-4de0-08de38983ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8xP6wLyav5mw+el2hVTuVS02UUTHfhzGj6GNWRj2k1Z5e/0XtN/nHRufZJFT?=
 =?us-ascii?Q?fLdFNgZGdbXSEaQta2lmfywsWJadLPgAwIZwEkuuwFRnuTxZwruQ6Rw+IFlw?=
 =?us-ascii?Q?ngmkuc9sEP+eEem/m6I+64f5Bq4M/yVXUKBYc7JRLvc8+GbNA4wqwkDMdLmg?=
 =?us-ascii?Q?KLkcKXCm3H9ghwGmUfV1TfCx6bnEfDvwCbCJDKaOHAcWvWNxWtod8n9veWGF?=
 =?us-ascii?Q?9e3tycOYhVG9Fo16bakBH1wPV75ahQjrdd1nvXNNN1atmKHc4/W0j0Yr3Sbq?=
 =?us-ascii?Q?AuVW6yFnWEuTGB6igOPy5J/JZStNKE5Mwu7YH+NqPfsZEOrj0m45x/xoIohL?=
 =?us-ascii?Q?UGYPzRqB+vW7yUV0F4h+rHvoZs2Gi34ojgPDfLnyddL/bsqKOVTjWxkBlCkU?=
 =?us-ascii?Q?DZFH64IGaU1i+yd5d9Qf06xdjNUk9H/vJ48GETu1bcohaPrh+BzaIdHCJNko?=
 =?us-ascii?Q?93NU2wKQIALSkRB4VLbMUUkwzCXJu9JiIsdpqSmfRXihoH5kHF5x1DuC8SlH?=
 =?us-ascii?Q?WvaIw28KfAWsp98xmzsLEAEEaOR+XaKWkZG3+OOwlDcPnMXWzqfvUpJbF5qz?=
 =?us-ascii?Q?Zl+g+nF+y5KYRI5mYYjCH5OJ2F9IR72FaHCyC/xHY/rz/fsyZ4zdiHmF6Kpc?=
 =?us-ascii?Q?E0ei6YFLGa+tSUZfzUHkUpRUVpJE/S2qk1tj+hM5zSdRqeyophdwyds76Nti?=
 =?us-ascii?Q?/NblcHe3ETC5mBJOs6i5IQ8O8GUYedTyjpthM81OUwh9GyH5ORtM6bzl0grH?=
 =?us-ascii?Q?0dTJ/GMf0r0KM4GQ1568Gg+kTlYYy0y7nSV4oeLzPT2qIPQvm7uBlmcg2Yj2?=
 =?us-ascii?Q?CGjKVBmyRpH7p95P6zzz/XWBuooSBgPDmOg6A+TdXTuQ1uyQHOGgBkzfsTzt?=
 =?us-ascii?Q?C24uNyuePZXRIhTlpfoBF+lkue1n/n+MTcQ5hh033fmHEsDNlUEaifbWeZjz?=
 =?us-ascii?Q?4+TLZYw9frXPZh+m4FWqgT57Y9e8Td7atLn7FWadIgx0oDDj1k8X8LJxSGiD?=
 =?us-ascii?Q?4NhV7QUwLeKkjCZUn4syN9fxcCf09DJUN3yjKyqbZVuDaANkRKSStOjkr4gW?=
 =?us-ascii?Q?QcZU7mHTGkXeXMy3unnfoDjLDKSJ4asgEZ8QZg5VmUK3HGqVcoqfqhGc2SMf?=
 =?us-ascii?Q?gfgaAozqBIFekPQQHueF75x/WHWjfjoyy32X0QhzEaR3jY/IBA7/I3mM3J/n?=
 =?us-ascii?Q?3p/+ivgCHCf8yalSvyymzByjCzW+259OiJyjkVX36f2AT/S/G2b3KZI5zWLk?=
 =?us-ascii?Q?UAy0l/MKB8MyuXSIsHHcQ4/gOVZgkJXKQ4QP/7+ig8ClD8ZmtllGG0qmyi3n?=
 =?us-ascii?Q?K2IXKLXMnOhOIE0DBaTQlB3k+dqHq5WMq4KkGLJ8HguVqusfHgYDot3bh2lO?=
 =?us-ascii?Q?h/yePApKQP/SsFVCM1aTVDj0KGuVxxU4hmXfdSJHlwL/tfmF13r/1090mqa4?=
 =?us-ascii?Q?/erethIuYoyxZrgPl6yTYKeYY5mvVY/+bxj3Mbila+6qTOca9ibSfLtB0Exl?=
 =?us-ascii?Q?jBgL9EKMzfiVq8MmpItdya1aLeGs4MtkXC8W0ybUWpbPtllfxt/RX2f7xT+M?=
 =?us-ascii?Q?rQ9YF/O7envTvpc8HLeZIh6faicJ69sVobwiBY45?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:32:40.2502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9fd7e1-44fe-4876-4de0-08de38983ab0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF077CE0592
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

As per errata
i2487: "the low power modes may inadvertently corrupt DDR contents"
for AM62AX[0] and AM62PX[1].

Based on the recommendation, add SW workaround sequence to
clear data retention latch on every boot and/or abort scenarios to
make sure that latch is initialized to zero rather than unknown value.

Executing this sequence during boot helps to successfully resume the SoCs
from IO+DDR low power mode.
This sequence is executed in partial I/O resume as well as all the
other conditions when reset is issued during low power mode entry/exit
or when the SoC is in idle mode.

The sequence should be executed for SoCs that support IO+DDR mode, that
is AM62AX and AM62PX.

[0]: https://www.ti.com/lit/er/sprz544c/sprz544c.pdf
[1]: https://www.ti.com/lit/er/sprz574b/sprz574b.pdf

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---

Depends-On: https://lore.kernel.org/all/20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com/

---
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c | 78 +++++++++++++++++++++++++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h |  1 +
 drivers/ram/k3-ddrss/k3-ddrss.c     |  3 ++
 3 files changed, 82 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
index 2556632df88..523f0cb6219 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
@@ -19,8 +19,18 @@
 #define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x43018318
 #define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
 
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL			0x43018300
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD	BIT(0)
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW		0x55555554
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK	GENMASK(31, 1)
+
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE			0x43018310
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW		0xDD555555
+#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK	GENMASK(31, 0)
+
 #define K3_DDRSS_LPM_TIMEOUT_MS 5000
 #define K3_DDRSS_RETENTION_TIMEOUT_MS 5000
+#define K3_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS 500
 
 #define K3_DDRSS_CFG_DENALI_CTL_20				0x0050
 #define K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE		BIT(24)
@@ -149,6 +159,61 @@ void k3_ddrss_deassert_retention(void)
 				 0);
 }
 
+static void k3_ddrss_clear_retention_latch_and_magic_words(void)
+{
+	int ret;
+
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE,
+				 0,
+			   K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK,
+			   K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW);
+
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
+				 0,
+			   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK |
+				   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD,
+			   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW |
+				   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD);
+
+	ret = wait_for_bit_32((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1,
+			      K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE,
+			      true, K3_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS, false);
+	if (ret)
+		panic("Timeout during latch clearing sequence %d\n", ret);
+
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0,
+			   K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
+			   K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
+			   K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
+
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0,
+			   K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+			   0);
+
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
+				 0,
+			   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD,
+			   0);
+
+	ret = wait_for_bit_32((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1,
+			      K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE,
+			      false, K3_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS, false);
+	if (ret)
+		panic("Timeout during latch clearing sequence %d\n", ret);
+
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE,
+				 0,
+			   K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK,
+			   0);
+
+	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
+				 0,
+			   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK,
+			   0);
+}
+
 static bool k3_ddrss_wkup_conf_canuart_wakeup_active(void)
 {
 	u32 active;
@@ -173,3 +238,16 @@ bool k3_ddrss_wkup_conf_boot_is_resume(void)
 		k3_ddrss_wkup_conf_canuart_wakeup_active() &&
 		k3_ddrss_wkup_conf_canuart_magic_word_set();
 }
+
+void k3_ddrss_run_retention_latch_clear_sequence(void)
+{
+	/*
+	 * Workaround of errata i12487
+	 * Errata states that During entry to the Deep Sleep or RTC+IO+DDR
+	 * low-power modes, SoC may not properly transition the attached
+	 * DDR into retention mode, which will lead to corruption of the DDR
+	 * data.
+	 */
+	if (IS_ENABLED(CONFIG_K3_IODDR))
+		k3_ddrss_clear_retention_latch_and_magic_words();
+}
diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
index cb2c270b7b2..1c2343924fb 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
@@ -7,3 +7,4 @@ void k3_ddrss_self_refresh_exit(void __iomem *ddrss_ctl_cfg);
 void k3_ddrss_lpm_resume(void __iomem *ddrss_ctl_cfg);
 void k3_ddrss_deassert_retention(void);
 bool k3_ddrss_wkup_conf_boot_is_resume(void);
+void k3_ddrss_run_retention_latch_clear_sequence(void);
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index cedec616e23..ebe56da72cf 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -886,6 +886,9 @@ static int k3_ddrss_probe(struct udevice *dev)
 
 	if (is_lpm_resume)
 		dev_info(dev, "Detected IO+DDR resume\n");
+	else
+		/* Clear the latch after any reset or partial I/O exit */
+		k3_ddrss_run_retention_latch_clear_sequence();
 
 	ddrss->dev = dev;
 	ret = k3_ddrss_power_on(ddrss);
-- 
2.34.1

