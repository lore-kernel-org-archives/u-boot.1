Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B4ACED62A
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 08:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1C6E8916D;
	Wed,  9 Oct 2024 10:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U+entRaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F12698917E; Wed,  9 Oct 2024 10:33:11 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 075098916C
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjJAXtbegjnbBmjCy0sj/ld9Af9uuLW35+kN7gFTiVNNrgkE7Q1VGiG0FLkdYv1FWOHaEg+H6Ujl16wInIeU8YSKtrmgpluc6YzX9ZzRHVqypmluugUdjBXtCKBq9IP6gCwwZTu5hXzC4LphWpu4kto0ugvUKVm5VvPTLyCmT9j6Tu+KbmUhHkKb6PRcFf2r81FphbJE8wbC1/uR86jIuTrCAJiVoVTJ/TcKGdJvclIV67np5cYdXHFyc9vWjhzqxeumSxp5pL9metn7xw3tqTPB0+gEQX92t9oB7h1kcH7nujemz4tZ6nqW/bSWmyPIq26qMKD+g550Vd/BVHthgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEWfDrzX4HNSSElOy7xJxX84iDGLt0xPYM6TEabRDlM=;
 b=skbdIHFL0LDicW+9b6YgPfNeamzp1mYuDcXlb7TzlENudM8XRLyzY0jRVnu8/XqrlW8+rQZcPBa6Kk1ufOaLe69Et3Cfy3mIsdeqqrJ1GrCfMsfrhj4nbXNqJo/b85w9AYQFk992IN9XIHtwIW+4mu650e/xgXQDh5gQ1ltK5ADdDWUDPzgZZ250DkIornV6wSB/I6SbCsW7rgLcRwfD3KLQLnWw/6+zjs2b7yS60FS2G3UfgR/BHepTSAhQSAQTl4dJDwPX8yCnfWWTISEnNbVVheM4EKDg1qjO06dT7r7w152iQ53s3GaYshPqRqe5l1kn4Rv7nZONf69pijHXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEWfDrzX4HNSSElOy7xJxX84iDGLt0xPYM6TEabRDlM=;
 b=U+entRaHxsbqsRtBAZmvCK59ZzYFSGGga5VjocG7fLqPkOwddYRz/KbEPrQr58FsitMun7PexId76Xaqt+TWlcXurxO5UcZ9+OwKScav8p1ZGhMimI2Gzz6h6wdHEPEL5jETAEVNzC5ARyqkwc2+hBP6//G7ifBWPJinAIXed1Q=
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 08:33:05 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::8b) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 08:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 08:33:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 03:32:59 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 <neal.frager@amd.com>
CC: Charlie Johnston <charlie.johnston@loftorbital.com>, Jonas Karlman
 <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, Oliver Gaskell
 <Oliver.Gaskell@analog.com>, Prasad Kummari <prasad.kummari@amd.com>, "Sumit
 Garg" <sumit.garg@linaro.org>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [RFC PATCH] zynqmp: Add binman description for SOM
Date: Wed, 9 Oct 2024 10:32:51 +0200
Message-ID: <de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10552; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=EBdp4YzlJHJTYXYb7ioOFOUENK8pPK0cTFBjtd2Eaz0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnQ2+62tvnWV4kai5s/jMnan3zY5c087Uj8+z9sri1U/a
 8VyxksdsSwMgkwMsmKKLNI2V87srZwxRfjiYTmYOaxMIEMYuDgFYCLKVgwLGrsuyhy3O1cuECE5
 58b5IKs5Vx/tYVjQ/kd+VuzdhNci5todvxeseP/0QNs7AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8d54aa-82de-47ca-b80e-08dce83cfe88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C4gJiD/QKvTM8EeGRFuG47wv7B9TENW01jt+M5lqtXXL1pR0e4p2XHhxN97/?=
 =?us-ascii?Q?bDpYdBXDZdpRPlWU69t00smpvN68YZh/FKX5pjMWWUeqqsrFiaD5x67obAQN?=
 =?us-ascii?Q?AFf+/1lgCYxZ7v12diHM2pkk+o11vdeQFBbjIINYNyUCAhrpU1iaf9tTw6x4?=
 =?us-ascii?Q?2Bh1du3O0dLaD9fDVmPy0JHvzEzfM7OKLpHf/6Lq8GLxHjs7+tiXtQwRAHda?=
 =?us-ascii?Q?llCw6PXkH4DlUpCLS5LEAGEYUMiPE7b8mrOkDkgXsLwFlyBtJ0bzzxcg/k//?=
 =?us-ascii?Q?jiX8jZfuVbQPm8xzqtBuAu1gy2I9K3TNdqcFboXpTKLOmFqfaSj7CFibaF0g?=
 =?us-ascii?Q?AxQJ3TEChAUJqgVo9jVmAdlx3v1XRQixH8j4K49C7YzfucbkYXWyuqQLGVp8?=
 =?us-ascii?Q?O6inBFoFQYUTKflXKKNH8wnVZ/FA9yaoyoWN/cwyUYovkGeHicE2Z4E3kF+7?=
 =?us-ascii?Q?XqdeE5nZ3OjNatTNUomdatoJ+H5mXGWfHZZvbzvdPkmaAImM3fNJ9tW/nlWl?=
 =?us-ascii?Q?EnEacmd/RCPmMUoA+FCrEYLA91tTjSKLIHfI5GHn1pKAEFFV3Wm0sB6FZ1Ga?=
 =?us-ascii?Q?ZhQ3lRPqOdCVm6y7xHHVFYWYt9LHb34f+j4QGzhOq41rdsTTCibZFHs72U8Y?=
 =?us-ascii?Q?Z/C6HiX8x4ZvaQTiInSlBWiqzLhJwhSs6w+0NSwzVsRk9/5HyNAecQu2L9o3?=
 =?us-ascii?Q?AApWilKyuqRdhJ04U6KYMrRFVsZKzGKGJmzKHr9ylBreYo6A0snn+wLie69o?=
 =?us-ascii?Q?g8wQxp6Qa1Q2maQ0mwYFy6/8Wp8ZQbMmzm8BGwhS6mr94ImwgUj0pKPFXAyP?=
 =?us-ascii?Q?+m/z0mUw+2XpPhz35ujUeGvjAAziQN/d0izYwhihI799QM4GjRc7L6p0epNU?=
 =?us-ascii?Q?5tW1oHZ7byZhcG2V0/O421W5d1vbivtltPQBN7pPDhfkImvyIf5taOwtUgfZ?=
 =?us-ascii?Q?W9UUJ6EL2Jeli7fwUTJvu3kNxA39p/rRA/0hqVZjCzf/L6BH8tI90Y1q6Cue?=
 =?us-ascii?Q?Tms3dt8dfFIUDqcL5M9KMRIP01Xxpdjc0+A3xcJB8Z54NPWTH9H5I2aXp9yO?=
 =?us-ascii?Q?yLKpUnkGCMr2JMHNOgksOl6+buSuzp8D/IbpXROv2Yr7Q9X523QjS8NEFNqP?=
 =?us-ascii?Q?unXCJ4Vrr9V0AKB3d8vBwACZsDt8ov5JQMgHeA9guiEv5mx5UiuGXSNXfkuk?=
 =?us-ascii?Q?V5djVEQDCzaKE6O4EkAjEnPIX0wcMdxKP3QujEQJerw0OJvd4KeluMtEb+80?=
 =?us-ascii?Q?bWKu+FKzJQ5PEmcSdRTpNpzLxRb5GqcS7siOVKN9iBi9QguLh6Fy+/hWIqPY?=
 =?us-ascii?Q?nhybNxfCS5NqxVC/CB+aIqyuGaQWzJgj9L60LuohIbcOzwlDCyFWpKp7UPZ2?=
 =?us-ascii?Q?2DL5NXQ1cNGFgvI/4CbLXpMwLTI2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 08:33:04.4103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8d54aa-82de-47ca-b80e-08dce83cfe88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779
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

There is necessary to do some steps to compose boot images. These steps
were in scripts in layers for a while. That's why introduce description via
binman to simplify wiring and remove all scripting around.
This should make sure that everybody is up2date with the latest versions.

The first step is to create fit image with DTBs with descriptions in
configuration node which is written as regular expression to match all SOM
versions.
Description is there for k24 and k26 in spite of low level psu_init
configuration is different. The reason is that it goes to u-boot.itb image
which is the same for k24 and k26.
u-boot.itb is another image which is generated. It is normally generated
via arch/arm/mach-zynqmp/mkimage_fit_atf.sh but this script is supposed to
be deprecated.
FIT image by purpose is using 64bit addresses to have default option to
move images to high DDR (above 4GB). TF-A and TEE are optional components
but in the most cases TF-A is present all the time and TEE(OP-TEE) is used
by some configurations too.

3rd generated image is boot.bin with updated user field which contains
version number. This image can be used with updated Image Selector
which supports A/B update mechanisms with rollback protection.

4th image is image.bin which binary file which contains boot.bin and
u-boot.itb together and can be programmed via origin Image Selector.
This image can be also used for creating one capsule which contains both
boot images (in SPL boot flow).

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Currently I have this for testing purpose only to find missing bits and
pieces in binman for cases I want to support.

This patch depends on
https://lore.kernel.org/r/fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com

---
 arch/arm/dts/Makefile                |   1 +
 arch/arm/dts/zynqmp-som-binman.dts   | 224 +++++++++++++++++++++++++++
 arch/arm/mach-zynqmp/Kconfig         |  17 ++
 configs/xilinx_zynqmp_kria_defconfig |   2 +
 4 files changed, 244 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-som-binman.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 65176c8fb836..df340cc30701 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -367,6 +367,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kv-g-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kr-g-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kr-g-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-som-binman.dtb
 
 dtb-$(CONFIG_ARCH_VERSAL) += \
 	versal-mini.dtb \
diff --git a/arch/arm/dts/zynqmp-som-binman.dts b/arch/arm/dts/zynqmp-som-binman.dts
new file mode 100644
index 000000000000..7f9333b02023
--- /dev/null
+++ b/arch/arm/dts/zynqmp-som-binman.dts
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP SOMs (k24/k26)
+ *
+ * (C) Copyright 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <config.h>
+
+/dts-v1/;
+/ {
+	binman: binman {
+		multiple-images;
+		fit-dtb.blob {
+			filename = "fit-dtb.blob";
+			pad-byte = <0>;
+			fit {
+				fit,align = <0x8>;
+				fit,external-offset = <0x0>;
+				description = "DTBs for SOMs+CCs";
+				fit,fdt-list-val = "zynqmp-smk-k26-revA", "zynqmp-smk-k26-revA-sck-kr-g-revA",  "zynqmp-smk-k26-revA-sck-kr-g-revB", "zynqmp-smk-k26-revA-sck-kv-g-revA",  "zynqmp-smk-k26-revA-sck-kv-g-revB", "zynqmp-sm-k26-revA-sck-kv-g-revA", "zynqmp-sm-k26-revA-sck-kv-g-revB", "zynqmp-sm-k26-revA-sck-kr-g-revB", "zynqmp-smk-k24-revA-sck-kd-g-revA", "zynqmp-smk-k24-revA-sck-kv-g-revB", "zynqmp-smk-k24-revA-sck-kr-g-revB", "zynqmp-sm-k24-revA-sck-kd-g-revA", "zynqmp-sm-k24-revA-sck-kv-g-revB", "zynqmp-sm-k24-revA-sck-kr-g-revB";
+
+				images {
+					@fdt-SEQ {
+						description = "NAME";
+						type = "flat_dt";
+						arch = "arm64";
+						compression = "none";
+						hash-1 {
+							algo = "md5";
+						};
+					};
+				};
+				configurations {
+					default = "config-1";
+					config-1 {
+						description = "SOM itself";
+						fdt = "fdt-1";
+					};
+					config-2 {
+						description = "zynqmp-smk-k26-.*-sck-kr-g-revA";
+						fdt = "fdt-2";
+					};
+					config-3 {
+						description = "zynqmp-smk-k26-.*-sck-kr-g-.*";
+						fdt = "fdt-3";
+					};
+					config-4 {
+						description = "zynqmp-smk-k26-.*-sck-kv-g-rev[AZ]";
+						fdt = "fdt-4";
+					};
+					config-5 {
+						description = "zynqmp-smk-k26-.*-sck-kv-g-.*";
+						fdt = "fdt-5";
+					};
+					config-6 {
+						description = "zynqmp-sm-k26-.*-sck-kv-g-rev[AZ]";
+						fdt = "fdt-6";
+					};
+					config-7 {
+						description = "zynqmp-sm-k26-.*-sck-kv-g-.*";
+						fdt = "fdt-7";
+					};
+					config-8 {
+						description = "zynqmp-sm-k26-.*-sck-kr-g-.*";
+						fdt = "fdt-8";
+					};
+					config-9 {
+						description = "zynqmp-smk-k24-.*-sck-kd-g-.*";
+						fdt = "fdt-9";
+					};
+					config-10 {
+						description = "zynqmp-smk-k24-.*-sck-kv-g-.*";
+						fdt = "fdt-10";
+					};
+					config-11 {
+						description = "zynqmp-smk-k24-.*-sck-kr-g-.*";
+						fdt = "fdt-11";
+					};
+					config-12 {
+						description = "zynqmp-sm-k24-.*-sck-kd-g-.*";
+						fdt = "fdt-12";
+					};
+					config-13 {
+						description = "zynqmp-sm-k24-.*-sck-kv-g-.*";
+						fdt = "fdt-13";
+					};
+					config-14 {
+						description = "zynqmp-sm-k24-.*-sck-kr-g-.*";
+						fdt = "fdt-14";
+					};
+				};
+			};
+		};
+
+		/* u-boot.itb generation in a static way */
+#define TEXT_BASE_DOWN (CONFIG_TEXT_BASE & 0xffffffff)
+#define TEXT_BASE_UP   ((CONFIG_TEXT_BASE >> 32) & 0xffffffff)
+
+#define BL31_BASE_DOWN (CONFIG_BL31_LOAD_ADDR & 0xffffffff)
+#define BL31_BASE_UP   ((CONFIG_BL31_LOAD_ADDR >> 32) & 0xffffffff)
+
+#define BL32_BASE_DOWN (CONFIG_BL32_LOAD_ADDR & 0xffffffff)
+#define BL32_BASE_UP   ((CONFIG_BL32_LOAD_ADDR >> 32) & 0xffffffff)
+
+		itb {
+			filename = "u-boot.itb";
+			pad-byte = <0>;
+
+			fit {
+				description = "Configuration for Xilinx ZynqMP SoC";
+				fit,align = <0x8>;
+				fit,external-offset = <0x0>;
+				images {
+					uboot {
+						description = "U-Boot (64-bit)";
+						type = "firmware";
+						os = "u-boot";
+						arch = "arm64";
+						compression = "none";
+						load = <(TEXT_BASE_UP) (TEXT_BASE_DOWN)>;
+						entry = <(TEXT_BASE_UP) (TEXT_BASE_DOWN)>;
+						hash {
+							algo = "md5";
+						};
+						u-boot-nodtb {
+						};
+					};
+					atf {
+						description = "Trusted Firmware-A";
+						type = "firmware";
+						os = "arm-trusted-firmware";
+						arch = "arm64";
+						compression = "none";
+						load = <(BL31_BASE_UP) (BL31_BASE_DOWN)>;
+						entry = <(BL31_BASE_UP) (BL31_BASE_DOWN)>;
+						hash {
+							algo = "md5";
+						};
+						atf-bl31 {
+							optional;
+						};
+					};
+					tee {
+						description = "OP-TEE";
+						type = "tee";
+						arch = "arm64";
+						compression = "none";
+						os = "tee";
+						load = <(BL32_BASE_UP) (BL32_BASE_DOWN)>;
+						entry = <(BL32_BASE_UP) (BL32_BASE_DOWN)>;
+						tee-os {
+							optional;
+						};
+					};
+					fdt {
+						description = "Multi DTB fit image";
+						type = "flat_dt";
+						arch = "arm64";
+						compression = "none";
+						load = <0x0 0x100000>;
+						hash {
+							algo = "md5";
+						};
+						fdt-blob {
+							filename = "fit-dtb.blob";
+							type = "blob-ext";
+						};
+					};
+				};
+				configurations {
+					default = "config-1";
+					config-1 {
+						description = "Multi DTB with TF-A";
+						firmware = "atf";
+						loadables = "tee", "uboot", "fdt";
+					};
+				};
+			};
+		};
+
+		/* boot.bin generated with version string inside */
+		bootimage {
+			filename = "boot.bin";
+			pad-byte = <0>;
+
+			blob-ext@1 {
+				offset = <0x0>;
+				filename = "spl/boot.bin";
+			};
+			/* Optional version string at offset 0x70 */
+			blob-ext@2 {
+				offset = <0x70>;
+				filename = "version.bin";
+				overlap;
+				optional;
+			};
+			/* Optional version string at offset 0x94 */
+			blob-ext@3 {
+				offset = <0x94>;
+				filename = "version.bin";
+				overlap;
+				optional;
+			};
+		};
+
+		/* Full QSPI image for recovery app */
+		image {
+			filename = "image.bin";
+			pad-byte = <0>;
+
+			blob-ext@1 {
+				offset = <0x0>;
+				filename = "boot.bin";
+			};
+			blob-ext@2 {
+				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
+				filename = "u-boot.itb";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index aea13622b68a..a74de68c0181 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -11,6 +11,9 @@ config SYS_VENDOR
 config SYS_SOC
 	default "zynqmp"
 
+config BINMAN
+	default y
+
 config SYS_MEM_RSVD_FOR_MMU
 	bool "Reserve memory for MMU Table"
 	help
@@ -132,6 +135,20 @@ config SPL_ZYNQMP_RESTORE_JTAG
 	  even if no eFuses were burnt. This option restores the interface if
 	  possible.
 
+config BL31_LOAD_ADDR
+	hex "Load address of BL31 image (mostly TF-A)"
+	default 0xfffe5000
+	help
+	  The load address for the BL31 image. This value is used to build the
+	  FIT image header that places BL31 in memory where it will run.
+
+config BL32_LOAD_ADDR
+	hex "Load address of BL32 image (mostly secure OS)"
+	default 0x60000000
+	help
+	  The load address for the BL32 image. This value is used to build the
+	  FIT image header that places BL32 in memory where it will run.
+
 config ZYNQ_SDHCI_MAX_FREQ
 	default 200000000
 
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 2eff9f35c0f4..1b4c33d2974e 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -53,6 +53,7 @@ CONFIG_SYS_PBSIZE=2073
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_CLOCKS=y
 CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_FS_LOAD_KERNEL_NAME=""
 CONFIG_SPL_FS_LOAD_ARGS_NAME=""
@@ -233,6 +234,7 @@ CONFIG_VIDEO_ZYNQMP_DPSUB=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
+# CONFIG_BINMAN_FDT is not set
 CONFIG_PANIC_HANG=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
-- 
2.43.0

