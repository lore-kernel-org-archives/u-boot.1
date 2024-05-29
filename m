Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C068C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED9C8861A;
	Wed, 29 May 2024 16:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hWI6EuhK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 575AD8860B; Wed, 29 May 2024 16:48:34 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45CB688621
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFrUfqwWZbIVIEjkU41PD1KtLLwHIuUeVWbJ+PMkFRbKkGJS8i8xGLNenTNZiySmpuc0o2RP8Eik4jhqr2Xkg0zS5E314P9GMcpdwHe/Kdi1IC1X7oq0KoZuors4wa0Rb34aMif+do+n4dVMEhPDRakIrSS4RRabsIYz5cBaNUSvK9Z6oeKGhILlMpwxfQga2KIfedrEpXXg+c6yOWQIwpt5FcRVGYpXuOm/gg3yfiISO4t4oSwOD3nPxElOZ5DSVPcqoK1yA4YBPfncUvNJule0jZzXML3npmsQlY491K7srqXDCP8Ry9rMl2GoKV7kFeQ154ValgpV6McglUXjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+jNMtQzIPUII7l0t97HLzJI0By+Ws+b+o5LtswD6n0=;
 b=ORkbyYA8WS3PZ/uVPXW5MIOPoEljE2a0VhnV7YcVPaJ2S6+fYITd0rYWmAnFu7gIt9IFhA1cZEnlrjpHeaGgpcFdykV6yZQY01QA9YqKmjm6YdVsV2fc2bbJvQMjJF01LO99UW1kCvQa1hHH0n4HoxQydjITZZmENrrJM+SBB9ELvJZPWaWBXPqIs8Wm+ty4YMh8r4qu3qYiSNQLzuVD2sDqTlbPPhcMk+HcRzQ2z5C/Zra/xPlzh2IyPOkn74HFjGDfetQlX/M73Zy2S5RHxBcoLLwrdlwvP9S22d98xY0aYG847Nq9WaJKP0M1wgQBG7vyx2mVCxjJZKcZf+fp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+jNMtQzIPUII7l0t97HLzJI0By+Ws+b+o5LtswD6n0=;
 b=hWI6EuhKz6RDSyVfZ9dNI7dRGqAUyUXaEok51ZU0duglsxG/rjbmro3hT2sQHDPX53TgmqBcWW+bJLeyfLy2fnvduJJ61A10M4PXjO1qmiqkwoYkYnHIEzkEdVTHeUpXVxrSrTH8flm3qPg9pj8X5jXFqw1za/GJ4iMStghvg60=
Received: from MN2PR14CA0011.namprd14.prod.outlook.com (2603:10b6:208:23e::16)
 by SN7PR12MB8433.namprd12.prod.outlook.com (2603:10b6:806:2e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 14:48:27 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::bf) by MN2PR14CA0011.outlook.office365.com
 (2603:10b6:208:23e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 14:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 14:48:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 09:48:26 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Angelo Dureghello <angelo@kernel-space.org>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Eugen Hristev
 <eugen.hristev@collabora.com>, Hai Pham <hai.pham.ud@renesas.com>, "Ibai
 Erkiaga" <ibai.erkiaga-elorza@amd.com>, Igor Prusov
 <IVPrusov@sberdevices.ru>, Jagan Teki <jagan@amarulasolutions.com>, Kongyang
 Liu <seashell11234455@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini
 <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 4/4] spi: versal2: Enable spi drivers for Versal Gen 2
Date: Wed, 29 May 2024 16:48:01 +0200
Message-ID: <691782470f56f7d49a3204f6757296f2752d4156.1716994063.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716994063.git.michal.simek@amd.com>
References: <cover.1716994063.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3237; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=mZY1b/QoFgoUu59Gjk5KLzZyVWEGgrAgONibiYZqb4M=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRwB7kDgUGpt989uPug9cl2gfKEZ3e/LXkcq7vHhXvXf
 oZXLQVWHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAifv0M82y+eN0+05VQZvY1
 s39B87H8H+orvzPMr534tXKHuf3NN8/uHvJVqTApP56/BgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SN7PR12MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a1afef-9592-4295-b452-08dc7fee667f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|7416005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RaTF1fcDOvXVzBUB5Tbj6ETmZlsNZC0WQGX4buVRJ07211tWgHIn6iv4hRiH?=
 =?us-ascii?Q?+Mx7x8eJG01tLYD5huLvrZJ0VFg4s278iBZfKoadN4r5WGfUn67vlyPdkSck?=
 =?us-ascii?Q?Dn76sTvhmShuiIhwopKyuOxx+jEjHk1A266pSePVkVV1oG5VWYOaLRJrLF0N?=
 =?us-ascii?Q?4u/NAIHVRLvVouVs7NlJhkt8hs1x53cSN2+XLzXravZhRLZQx2KY4ceLutqv?=
 =?us-ascii?Q?Q+f385wwZusjN6YERCHmrAB5fyf/VEgaWTOnElFngo/BYS5qdn93Og8RnBn8?=
 =?us-ascii?Q?Feta5kWi9gtJXNNzDQCSiz1+V+YTF8fQLxTI8gjiMoQJ03Jjzw9VI6g9eqme?=
 =?us-ascii?Q?R1cvRkSUiA5M2Jmf4nhzmyMEOwveHAyxLz6ZM1SZ1fDIYyFVxJnW+uTi8CRv?=
 =?us-ascii?Q?0Wou/WLZ1SXcLb5DjsKpmHAG2qN1cLX9Lkl8hzn2RzmXXaggw1rqiaosvWzc?=
 =?us-ascii?Q?u6Rc1uU4NP3RXcua6QRySaFPJjQGBQrggwOT4yiSbUsPW8Z1WUcxfU6TDUZe?=
 =?us-ascii?Q?vIdRPkRRC0nFdKhKpLQh8EjTbQGhhysI0TjQECXPE8shNlqwIqRrgRmRTFsE?=
 =?us-ascii?Q?i5mxSgFc1AUifowCAPFQMk+7AQQU4oTqnT1vz6AYKFMTT0jLNJm/xUckzRm6?=
 =?us-ascii?Q?Yku4EV2EJl384kniJVzyW5zPbXvt0L7cvFy2WZMGHJsIqp/Vo/7OoCsyQSId?=
 =?us-ascii?Q?U0QJPlc671ERMLbu96Y85k47MwxwVwPN0Y9lRvHZiqB41jPuXVcU4L2BAiuN?=
 =?us-ascii?Q?BP2DE6Ze7rmwWCCFGhmvQ86dDY3nC18wJmoZkKb+tDuZnHI5hq20VgKEhDfO?=
 =?us-ascii?Q?kTLP2eru5yI33KewaG9wtoYwA5DDLznhku0L12cSlE36zL8kSDwT/QeoO0xZ?=
 =?us-ascii?Q?98Af6i89dUPaP3yudk0duYRvftKfcxIaiXSIwICBJEF5d7cchbnkcxq+XcQH?=
 =?us-ascii?Q?KAj3sAljKtfhd5z40QjYF9Z9nJ+GNaGRdy5Jpr+b0fWzXzHeTXwE9oAzAYZa?=
 =?us-ascii?Q?TC93t3ROkLtk5us2BzH9d9NctkbmWIH0/lK6kIISv6UVGYrhruCvuZWpk3Ch?=
 =?us-ascii?Q?yJj2AmMaezuz3RnnGpxDRxrnk67nJe4QThANW5r+InunO5bhRJeLiLEj/Fvu?=
 =?us-ascii?Q?O6bC/ym3SQjBYH/EiuMAUF0N2F7suRStewPTSZkFfcyUj4hSIWeWGL7sHmqm?=
 =?us-ascii?Q?KawwYXKs+g4eMwXhUbPLskq5uMNUON0jbtFwE5AX+vqQXomRiU2C3E9g5l2M?=
 =?us-ascii?Q?Kl1aMIksjZ7igXewyNsfdQsxlFzRCPrPFwtKjeMbGG/+ryXIHWbwNuWe2pis?=
 =?us-ascii?Q?7r45A9wHMIxGEfoLzrRiiUgd9oeSFwX6pdHhgOH5JUcTltodMM0ol2in2Od7?=
 =?us-ascii?Q?MfzpwUa3gE7Kw21dnO1/NbOlCppZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(7416005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 14:48:27.7888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a1afef-9592-4295-b452-08dc7fee667f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8433
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

Enable and update OSPI/QSPI/GQSPI drivers to support Versal Gen 2 SoCs.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 4 +++-
 drivers/spi/Kconfig                | 2 +-
 drivers/spi/cadence_qspi.c         | 3 ++-
 drivers/spi/zynqmp_gqspi.c         | 6 ++++--
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index b74e69be28c4..6e4adddf2c02 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_VERSAL2=y
 CONFIG_TEXT_BASE=0x8000000
 CONFIG_SYS_MALLOC_F_LEN=0x100000
-CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-virt"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
@@ -124,7 +123,10 @@ CONFIG_SOC_DEVICE=y
 CONFIG_SOC_AMD_VERSAL2=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_CADENCE_OSPI_VERSAL=y
 CONFIG_ZYNQ_SPI=y
+CONFIG_ZYNQMP_GQSPI=y
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 35030ab35561..cd785aefd56e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -156,7 +156,7 @@ config CQSPI_REF_CLK
 
 config CADENCE_OSPI_VERSAL
 	bool "Configure Versal OSPI"
-	depends on (ARCH_VERSAL || ARCH_VERSAL_NET) && CADENCE_QSPI
+	depends on (ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2) && CADENCE_QSPI
 	imply DM_GPIO
 	help
 	  This option is used to enable Versal OSPI DMA operations which
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 75e522320101..9c466f8695e2 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -253,7 +253,8 @@ static int cadence_spi_probe(struct udevice *bus)
 
 	/* Versal and Versal-NET use spi calibration to set read delay */
 	if (CONFIG_IS_ENABLED(ARCH_VERSAL) ||
-	    CONFIG_IS_ENABLED(ARCH_VERSAL_NET))
+	    CONFIG_IS_ENABLED(ARCH_VERSAL_NET) ||
+	    CONFIG_IS_ENABLED(ARCH_VERSAL2))
 		if (priv->read_delay >= 0)
 			priv->read_delay = -1;
 
diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index 61349a4da53f..ae795e50b0a5 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -106,7 +106,8 @@
 #define TAP_DLY_BYPASS_LQSPI_RX_SHIFT	2
 #define GQSPI_DATA_DLY_ADJ_OFST		0x000001F8
 #define IOU_TAPDLY_BYPASS_OFST !(IS_ENABLED(CONFIG_ARCH_VERSAL) || \
-				 IS_ENABLED(CONFIG_ARCH_VERSAL_NET)) ? \
+				 IS_ENABLED(CONFIG_ARCH_VERSAL_NET) || \
+				 IS_ENABLED(CONFIG_ARCH_VERSAL2)) ? \
 				0xFF180390 : 0xF103003C
 #define GQSPI_LPBK_DLY_ADJ_LPBK_MASK	0x00000020
 #define GQSPI_FREQ_37_5MHZ		37500000
@@ -316,7 +317,8 @@ static void zynqmp_qspi_set_tapdelay(struct udevice *bus, u32 baudrateval)
 		  __func__, clk_rate, baudrateval, reqhz);
 
 	if (!(IS_ENABLED(CONFIG_ARCH_VERSAL) ||
-	      IS_ENABLED(CONFIG_ARCH_VERSAL_NET))) {
+	      IS_ENABLED(CONFIG_ARCH_VERSAL_NET) ||
+	      IS_ENABLED(CONFIG_ARCH_VERSAL2))) {
 		if (reqhz <= GQSPI_FREQ_40MHZ) {
 			tapdlybypass = TAP_DLY_BYPASS_LQSPI_RX_VALUE <<
 					TAP_DLY_BYPASS_LQSPI_RX_SHIFT;
-- 
2.40.1

