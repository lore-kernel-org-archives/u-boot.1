Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06648CCF9EE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 07:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F11883946;
	Fri, 31 Oct 2025 08:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d7FDhxyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0070E8331F; Fri, 31 Oct 2025 08:38:31 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8ECF8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=up8UEPB+m8BDrX60Oi8fTvRIUrZ+A98fyuytpNCtKuViIBluSE/eZ/IudJXqzEMuTaa1GWWcBRF3/JLExr6rKSIz3O7JrDaVARVLtPmKQD1HmymMEZWj0BeWZkrFSQtM3FAdjU/hEiu+1WxJwzII5ajPWeVD8MepWLAFybNfH1bSTwaV1Wqe/yclX8rVKY84FJq8hb+rV2T8ZtOZ+IBcqF9bNarhD2PnhJPMfmUgsE/s72NPrpfWV8nC9zVHS698PzQXwla27IshA9piunjuAGsi2HVQzRLEhFblGcB7107U/mKKduCr8W/Zu0vPpJ5bI7WzvlELzzyPGuma6mZNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQHBvHjh+t9ipCsT+NDy/08s4y8c4jOJ1HZyYcMXVxo=;
 b=AghHCYFdWz5xLC2ipqQYDodj08d2ioII9KfnnCnckVOYefAo9Loh0Dm8eECMEtsUVdAo1rRzxpGsnU6TjlkfCsyE8ZcNxw08caxaDeUa21wJ4NmVJ/d3eUV672C4oGXz3NTwBGSgtp468Sm/DHjmmG00YR6PPqyKrexU3aJiZP/WDzPrl1SA5EJ/jEQKin33izqfzH9JNqmbk0lTdym9IRWtJEIk+b8BX90XO/K9oc7oLrC5+zEd7vrpAQ54C4td/ub3/dPqWUnBOdj5YLvxA4G2ReV05a0dPhjBvluyHELcVc3dhv9rbPu5BgpBdNwKjtXGhBLpP5bhwrxX/OzZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQHBvHjh+t9ipCsT+NDy/08s4y8c4jOJ1HZyYcMXVxo=;
 b=d7FDhxyCaBKy5UUSpucFgbLr3Kt/4GgQQTotkgXZdIMaNFNoaLtazVLEPVPmqVQhvnSW8+4JcWZROobBzLYHerjiZ0M5psHCP5S3WBL+kJqv1WjUjKFclLZZMsZ7NEcQULWWLlyc1hl+6gpTXxb1xj86AhRZZN7GEvN6NiaDoP0=
Received: from PH8P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::29)
 by SJ5PPF07759F8B1.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::787) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 07:38:26 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::e8) by PH8P220CA0023.outlook.office365.com
 (2603:10b6:510:345::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:38:25 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:15 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 02:38:15 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V7cEtv3500822;
 Fri, 31 Oct 2025 02:38:15 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v10 5/7] mach-k3: r5: common: add fdt fixups for falcon mode
Date: Fri, 31 Oct 2025 13:07:55 +0530
Message-ID: <20251031073800.344500-6-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031073800.344500-1-anshuld@ti.com>
References: <20251031073800.344500-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SJ5PPF07759F8B1:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b58914-6afe-413a-2785-08de185079de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|34020700016|36860700013|82310400026|376014|3122999009;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dsuM1SLUwt13U/y0QHDgANlBnQyDyj8sQ7EyXmCQLGpL4op43uulqli7Efda?=
 =?us-ascii?Q?IuajIz0hgAgzXolbXndk+t6/5guAwT73vCuWfsp6FEqkuBuj9cWUQccyEnMW?=
 =?us-ascii?Q?tyJVGQHOv8z4KRiXc2mWZ3B1Bl0Oy/Sy7jjuFbAUW28qh5o8Y+Da4NddkAXr?=
 =?us-ascii?Q?V3d2DbVgY+ZsXM6yzEmZH93bZE57sgOXGwCfrY4LkoHQe33arYsp7mIfMfhq?=
 =?us-ascii?Q?eQaSYp1nf/qbn1LmsmZz8XVvwl89XlZhRmD9oJTZadAZKZ/sOltZznRaLS8b?=
 =?us-ascii?Q?AUneqPRTVt6kN16+45YbJFXjmcyzWRW3pusFX3ypjXKXiQXfghV/D5nUJl0u?=
 =?us-ascii?Q?fCa2GyuLAAaFGvgvRDSrwPPu7RiCTFRpdMiynd60T13LxadBBbe8KkGPz6ru?=
 =?us-ascii?Q?MaATB91qR52G/HcoVNCxHJtyO31Ff8ox0d4x4l35ZdlIUunJuw4UcB/TkUc3?=
 =?us-ascii?Q?qCKxLuOzsxrTfzzD+fslHXaNakmPBtt99U1yaaM3i4B5Q2trvy5bOG7h/f75?=
 =?us-ascii?Q?GfJYbNRCr4GVRnKu/xsv7zzEwNv6qjRsXnL+FY3pzfXiRVMQtKN+41ZbQFYZ?=
 =?us-ascii?Q?vFPRmLshcezjNMu1UeTU5m090uCd0c4hGQRaksGtq+3wZPWa2akjxjb5TxPu?=
 =?us-ascii?Q?lESDW4VuoB48f3i9/yp41Btn29dZ3ZKsfhnDWp82XYujjvmDrir5hgXhG4Q8?=
 =?us-ascii?Q?FkSt7bfU/uEFkZZCi19MUVhK5hbZqpkc4XkRMGAd/431IfZqQHGgn5B/Rh3V?=
 =?us-ascii?Q?4YE3n3o5KR+AmuHc31a3xnmdW3impH03Tpc0PWikMNHNn2gCVPdgCVAw16S/?=
 =?us-ascii?Q?d+MuffjQdBqk3UOsaarXYlx/OKI+/Oxf+9le0uTKTCighlS+dFzRV31LzQGc?=
 =?us-ascii?Q?epqEBVXj0+FTBBnS1ArJAf6tUlTnYqUVQecdB6gtFCFwUDFolVpvPq33+oY8?=
 =?us-ascii?Q?XuFROM2+TRxJBHiKMZfVRKHuNe7qDX+gbP4aI3s+Nb9u8MX24YxbGINxKXuQ?=
 =?us-ascii?Q?pCeNEcq/9wOs8aYsPdQki7aAAR6YC1Eq7I0pc14qNSkcDX/esnnb5MFL+++6?=
 =?us-ascii?Q?dYZcqJEKgQwwymrpzXPZDnuUdgwQ6f4KIlpM3pxF7xrOzdmWFt4gN7C+7c03?=
 =?us-ascii?Q?rE7QU1Q932hwidOc3DfI3meoJiZ/UDhLgGPXSOuUhoc6W9J3DC5CyDDnTlXp?=
 =?us-ascii?Q?3tuFCsT2L5JgMOOLvCNLfpfIIOcrAZe7ZnV99TaboibxoxyfQJYJUzR4CvPT?=
 =?us-ascii?Q?dcUsNXlpdMIb5Jru3rff7L4WC5zFrXeSDXND8X6+wNgC24hHM5iQIvJSoqc4?=
 =?us-ascii?Q?ICS21XhS6o3YPSGGFzsFAxl/PtStcw8ptxu+7rtkzEclLu+oUoSrSZ9ur1di?=
 =?us-ascii?Q?LU6QQDDJcOwz5PF5b6WnoQos7KJYMBS+W6VaDQ5ujRH5+enMZrT0io47Q87u?=
 =?us-ascii?Q?QNmClhIFkYmnYzCVh2SNRh9+Y6/zpniAMQal86nocw7sKyC771FnUi5eFTZ8?=
 =?us-ascii?Q?lhIM3VIL+DV5iPLRoYgpzh0iaYRDc7BmEoCP5qQz7r4KzRLFGodyvjTH7m62?=
 =?us-ascii?Q?WBm0C8/6xX5mEBv7R0I=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(34020700016)(36860700013)(82310400026)(376014)(3122999009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:38:25.3940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b58914-6afe-413a-2785-08de185079de
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF07759F8B1
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

This patch adds fdt fixups to the kernel device-tree in R5 falcon mode,
these fixups include fixing up the core-count, reserved-memory etc.

The users can opt out by disabling the respective CONFIG_OF_*_SETUP
config options.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/r5/common.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index bf5e7903dcb..8e002504897 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -406,12 +406,43 @@ int k3_r5_falcon_bootmode(void)
 		return BOOT_DEVICE_NOBOOT;
 }
 
+static int k3_falcon_fdt_fixup(void *fdt)
+{
+	int ret;
+
+	if (!fdt)
+		return -EINVAL;
+
+	fdt_set_totalsize(fdt, fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
+
+	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
+		ret = ft_board_setup(fdt, gd->bd);
+		if (ret) {
+			printf("%s: Failed in board setup: %s\n", __func__,
+			       fdt_strerror(ret));
+			return ret;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)) {
+		ret = ft_system_setup(fdt, gd->bd);
+		if (ret) {
+			printf("%s: Failed in system setup: %s\n", __func__,
+			       fdt_strerror(ret));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int k3_r5_falcon_prep(void)
 {
 	struct spl_image_loader *loader, *drv;
 	struct spl_image_info kernel_image;
 	struct spl_boot_device bootdev;
 	int ret = -ENXIO, n_ents;
+	void *fdt;
 
 	tifalcon_loaded = true;
 	memset(&kernel_image, '\0', sizeof(kernel_image));
@@ -428,6 +459,13 @@ int k3_r5_falcon_prep(void)
 		if (ret)
 			continue;
 
+		fdt = spl_image_fdt_addr(&kernel_image);
+		ret = k3_falcon_fdt_fixup(fdt);
+		if (ret) {
+			printf("Failed to fixup fdt in falcon mode: %d\n", ret);
+			return ret;
+		}
+
 		return 0;
 	}
 
-- 
2.51.0

