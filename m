Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3449D10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 15:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED68683C53;
	Wed, 26 Nov 2025 16:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HOhNdiia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8D1784239; Wed, 26 Nov 2025 16:24:05 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D41F583BF1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 16:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDM4J84E5uvbNN3JQDnZhkG9Zl+77LWjVmC3BXALMNXkm/5ON0h5TqJMwmvOa2hmT0+nCY3gCbNYmOpUHvRUWUT7nhyeaPVenRGmdawvJ8VjLcsp/tcZsedYwHD7IQNoRKbtzbdpGIRBkfOkQM28jPhb/VlVh6QFxEFoN6PJnHpWibjPdsGSI1GgbSb0Ac6TIHWBij4bXmGFXXIMg13euVADrFIfVbE3gPNoPU+RZ1wNclDnvUAah6bjL8Ql0wv5RITzFdb69yPXIIB3z3jxM50cYt14Z31s2oL/H8qcDoOzKFyV3P9UzpGnyGBStBgMHcT37QNvic1/sOfaGa2R5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR0IZas3PO5mg/GY4uzWN5L0wk/TQyPyzDW0lC8/fNY=;
 b=nfcoFE3pfwpexdRhZ1RwduDN15WZSFAB7MCCa+cJ7TiRRNSbGtnKuMysQmy1aK/GsXkzB4G0r0Xh75Im6n5dDDdjo165KtF8ev6kxpTHFY/fpd/cAFQXzevt/8HGjnQirnVB8Qtw+7P06W75Zd9wYHoKgwmV8YGzOyRlLCRw4ZMcT/N6x3Gap/t47AaHWvsx53WQtu3WijTKpO5yakpO4rg6emWKYEzgdielfpiZQLkCYa+m6qeAK5ok+ErbMwEWpJLXVoA4DoQeeub/EDOSlbdfpMlsLIvq01LRjvyTJwIH7vzIA4hj2XglLSCNmxCB8hNepe7+0HUk+qCAmhJ5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aR0IZas3PO5mg/GY4uzWN5L0wk/TQyPyzDW0lC8/fNY=;
 b=HOhNdiiaVwKYRjamKaK/clZ+i8hG5aQ1r06AgSOeM6cAMEhT7uV9xk3cOG5EGd4vwLgALnPOO1LOz4i7nsTu2hsxDNfad0MWVe3AQLnCphFjbJkBmW8B2mE9dr+K0p1vvTm6SO19BpZMJClhzvYle1mdIzM8Gy6cXSn234u1IeM=
Received: from PH8PR02CA0019.namprd02.prod.outlook.com (2603:10b6:510:2d0::27)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 15:23:57 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::fc) by PH8PR02CA0019.outlook.office365.com
 (2603:10b6:510:2d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Wed,
 26 Nov 2025 15:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 15:23:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 26 Nov
 2025 09:23:56 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Nov
 2025 09:23:55 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 07:23:55 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Prasad Kummari
 <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/4] xilinx: amd: Enable the PCA9541 I2C Bus arbiter
Date: Wed, 26 Nov 2025 16:23:43 +0100
Message-ID: <edfb7e7a6e800484d3ac3bf45a4f83adfcdd1754.1764170621.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=xwoGDv883EB3comHvqgDh0SurmQlXq1ZX0R1LoJKwh4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSqS7flnljxxfCbgnTsUoZpnTGxPHdSL0ZOvH4patk3j
 k/5lcfOdJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBE+JwYGU6+eRKbuzTituat
 +KAdr+dN39349NuBvBCHJ9XM9cdb/nIxMrznYet6x5H8ee3mU9m/+xvYW2WfBOt/ZvF506/zMun
 SLD4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f92990-b37e-41de-69ce-08de2cffd15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DDikoLsGW4Vw/71eHmTyBT33W0lhHse+bPEfnbMyPedVT+IyvUlPCUmeSLkK?=
 =?us-ascii?Q?o+wLZiz1tAdM2z4jzQh3i1NtwBMBuw6wARTTGunVU4ER/Wu2t24/WnBQ1GwE?=
 =?us-ascii?Q?1f0rHILYZSX8As8e7qQuUf64hXdj29xeXQnqZXd21tF3PCX3iCVKY97W1+jm?=
 =?us-ascii?Q?7k7kPbPkPzvoHJgJvMbzydk/2NVOiAlE4Dz7W825sPgsH9yUw6YR6e6mNOV7?=
 =?us-ascii?Q?QgVOyd7P2wm9SF6bUhQtDdGk+bwR4y9KLCcQEGoZkmKeIyXcL85aMGYeIFv+?=
 =?us-ascii?Q?F2jCv/CIczulINnOfbJ9WplarG2MuS6P514dsNMSJFr/oRUXrihGcvjlypV/?=
 =?us-ascii?Q?NGCip+j650POBmuNmm7rAi+u/dZRf5+u0bYFumjaFa06XEKYpEnUJzF3mOvs?=
 =?us-ascii?Q?gt5I/1lsPZ4WueCMsrGRvtSL+VeX/kH1NoPQIngmlp07/GawiaIgAMUA9nyg?=
 =?us-ascii?Q?u+X3dj2ZSyGxAclyma/liwBaTZwhk97s1eAScKJMccSxkHTY2fSV7V2BZNJw?=
 =?us-ascii?Q?xQDBLi90mliWKSxkFEqOPVPSvXABWV6ZVdRX+JtzbnnDBhVWKBNN1mD0aE9F?=
 =?us-ascii?Q?OS6/XyU8b7/GmrUolKVgboMfW06yNRlFAl0d6Pz2UmFn0lv/KBxnGdjGKSAD?=
 =?us-ascii?Q?wKsIV6mCJY06jS0rge5BlhrSJTKNwdWp6DFKVMn/oeeqX3XQJr+875vMoGhK?=
 =?us-ascii?Q?mw7S7rLuqZHmw0q7rmUM0ihGEuIBTlB6vAQC1eNfQI+vTjW3nP40IpGM5rNX?=
 =?us-ascii?Q?EKQqk7t9FW7JMHzPceufEHUqoUAd/4AMCFquiJDiCCz8zYVyrokilf2utk66?=
 =?us-ascii?Q?bSN1B9E1GnopmdWt/NfCZUZERo8yRUwBQUZcQ32mBU4AfjwNFpEWBQVFbHge?=
 =?us-ascii?Q?8qL7sUzEBes3gkYaeY4PIoIGjTrI/vTZDWYqQcTY6Ad9fzI/FQXCv0Dlig4W?=
 =?us-ascii?Q?tVNkeE0S1+POOrsi6WlO/8Y2eULLYEu4p0KDZ5siCI28dr/WkqGvWJQRBFjT?=
 =?us-ascii?Q?RYxAM7AjltbdkGO4oIdbli8wvql4IsUdUjxXWBfSGu1AdAomJGHIFl3NlAC1?=
 =?us-ascii?Q?ebZD5+BDA7EekXMTIStH6TrSR4WUql7GxVPuzqp4OKFQLdk20wPbFZXv5FPk?=
 =?us-ascii?Q?VIuMVz080z14N8hS5LhIstjkiyiK+ctcwTSn2FqA2o0te0nsHVawTDTR84IK?=
 =?us-ascii?Q?MvULG9/ym91a0hnrrqXewaUtaKBBxR7FBVSjNFsTzrMduIR/BoSuo8GLIvVs?=
 =?us-ascii?Q?aNFP1FNjCOhBK1S8EeZLBrWB4oAt9gldpdwLFr0U96QSFFgXHNm2Z8I4ZtjW?=
 =?us-ascii?Q?VDKDQyOUCHBBNQ7S85noMMjUisRbXQElewq3GyQKeW20qjRwSehV15vKo90C?=
 =?us-ascii?Q?YI7Dtp4l6SlbbEcC6R1Vku1YA0JqVidFk8QvRk+y+sESjISCnJ4SYi4yEjkZ?=
 =?us-ascii?Q?oWzaQ9HUpQPCDCwK9LnjE8YZOGbmJxsFKvt3tThMwnlXShzcegfjz+SqMu6R?=
 =?us-ascii?Q?k3x21zgrLSSWTRuc4q88GU0lR90OlFvhFJ6KGa/0WrQUXTnzjw8RUFMMBZpx?=
 =?us-ascii?Q?xvJdPo8sHdhDF5K2hnM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:23:57.3293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f92990-b37e-41de-69ce-08de2cffd15f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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

Enable the new PCA9541 i2c bus arbiter on AMD/Xilinx SOCs by default.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig   | 1 +
 configs/xilinx_versal_virt_defconfig | 1 +
 configs/xilinx_zynqmp_virt_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 4f0c4ba5c967..416128fa937f 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -83,6 +83,7 @@ CONFIG_FPGA_VERSALPL=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_CADENCE=y
 CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA9541=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_DM_MAILBOX=y
 CONFIG_ZYNQMP_IPI=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index bd6bfb7deacd..652121e27a0c 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -89,6 +89,7 @@ CONFIG_FPGA_VERSALPL=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_CADENCE=y
 CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA9541=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_DM_MAILBOX=y
 CONFIG_ZYNQMP_IPI=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 525744b0f61e..fc610fd4af5f 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -140,6 +140,7 @@ CONFIG_SLG7XL45106_I2C_GPO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_CADENCE=y
 CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA9541=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-- 
2.43.0

base-commit: ba53d57c179f3390b32bc6094f3ffb5f4cde931e
branch: debian-sent3
