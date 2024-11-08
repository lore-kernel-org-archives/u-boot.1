Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401D1D5C0CF
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 14:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D53A890FC;
	Fri,  8 Nov 2024 15:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="FqwUydKx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A119A88DF1; Fri,  8 Nov 2024 15:04:29 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32D38904E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 15:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tc/z7Tj8N6KgMXwIvheitxvdAnHhmaHTP+y/zcArnB1aa5bUxoyoydED1+nGvqPB/3ZVZ3c0D60XSFEh6YC8AUOjZ7eUlvR3Zk05bzGc3sZ81CQJIhqmaKpdGjBLlachfW4pUqzR00xGKGIozhe2ne60xs8YUjqRKH7l0+pAXrA53+0a2cnOyH+qGni0EMLswhECccMuihBvuuu+xO3DXwwagAfw7wW12c799zrKYvxrXKgtvQBWeeMbJiz7boux7NRzTrU8lMa9tUv/EKs4dX8tTjX1YYH20+MK9H13QrjOvBQ7FkcL89M6Y/lQk1qNXYy/ImvQ8zHZXM9S++88Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HJx4uAxK1rahMjvTbm6bpn0OCNWYGERR2w13/UOg4k=;
 b=OQxT7svZ22BjMyt7TepL+xQTMsgm/MKPPrex7PvP2slF+XDB5yQIUVj1+vMssVPnuXvcb6IcZ+v9PmHYctgPBxYCJFS9MgGCEismo+Kki3H+S+8YtAZKFhjRLbKu1YPs/dBX8IyJfWvqth5bqQUVkHDNMcMqRIMYP8gvEpRJVAi7AbjgBwUcBspVAV1ouc7zdffZEHB8sKlEBiG1ep/LsqA/Xz/hKJSv4l+dKbTKn762Eyous2nbvHVtFStM97vW2wNjOjjjIKTolNHNjlWA10uLEHlk56a08AUopnpkX69lqhIygl3+hqSvippZypRNQB0PnRRN4AenSzzi6l72QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HJx4uAxK1rahMjvTbm6bpn0OCNWYGERR2w13/UOg4k=;
 b=FqwUydKxQX+XzrlYAQWGFPThgY70fZhIrUNAq76AbVUnOg3RxudYgvGji4O86d2wry4FKjdXqxdxFLw0tIN2tO1HOLSyouG5/5vGK22cI41nDjQHGLXk68cB1SVJTaxf0WU+EroYVa8cV8iqFQxCC+Q0LZVK0VOlfKrwUI4DT8RGF70ozwjGzuwUTGWDJl+halZm1scZi/CAHbHiINTy8kLuUMswC38BE4RhtBR03U2CHZCGzE3hvSvVy9eAQtwwSDvLb+jyK0x7hd7bWME668SOWXe5oLy7AU9jC5J3yHZiESD3rsaJEAoFimdXYxbvf/p+yBrFFCNrU5Bmz4/qhg==
Received: from SJ0PR03CA0254.namprd03.prod.outlook.com (2603:10b6:a03:3a0::19)
 by LV3PR22MB5691.namprd22.prod.outlook.com (2603:10b6:408:276::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 14:04:21 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::1) by SJ0PR03CA0254.outlook.office365.com
 (2603:10b6:a03:3a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 14:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Fri, 8 Nov 2024 14:04:18 +0000
Received: from 0e263a2c6991.em.health.ge.com (unknown [10.168.174.111])
 by builder1.em.health.ge.com (Postfix) with ESMTP id 85228613D;
 Fri,  8 Nov 2024 16:04:16 +0200 (EET)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	u-boot@lists.denx.de
Subject: [PATCH V2 1/2] arm: mach-imx: move snvs module
Date: Fri,  8 Nov 2024 16:03:54 +0200
Message-Id: <20241108140356.483-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|LV3PR22MB5691:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 76188529-18c8-4dba-7f11-08dcfffe3d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iqI6gajbHBOqIRWxWjifIbMf4x8tDnx6OJq1hfom+h1nDZUFDPjZ2cEHmf07?=
 =?us-ascii?Q?0gdPxLPhmmY7MFSbcsJ6U6ELkGhhUjuAtN8EeVbt9ZWc0g3+9hvfPk7kBNsd?=
 =?us-ascii?Q?gYxiqlFmCSM4vMQO0XUmTWkdIwHOXw6kYYDVHSB35w1hA1GxFfC3WPGgk3sv?=
 =?us-ascii?Q?j3VYoy0nRCDP7vius9VDCmGkxg+Xro6oFRsZbK/ZsJv0Zkujo0T3DxSElXr4?=
 =?us-ascii?Q?PnNBErr22fqoo592Lh17A7k855EPxNVfGyU1nMaO3csSMbUsyBwmMxI/+Dyk?=
 =?us-ascii?Q?7PWYlK4V+exarHafPiZa5UgCzdpogqz6MbzgYUNnozCFl7YqGvYihBF3xuIp?=
 =?us-ascii?Q?xUTTnuLbi5uSZyxi6SpEecTRzCPtIEndI525V1hBHbkyxakZQf0k9MQLL4sq?=
 =?us-ascii?Q?GucKG4rZM9ykgRcUCV9fOsSEg4xhNGzPkwTKPl9c5ueCOp8r0xJnM2U4hsxC?=
 =?us-ascii?Q?LcnOgjk07tbtrMFzS/nCU6pYBjOFqmhslgh58QJoDocngXE6vEe6hyB68q25?=
 =?us-ascii?Q?EsB2rLh0GOgRMOVpS+J/JfrsNytrHgLROdRBJnz+4bLkg7yUmTCUbx/Lomlk?=
 =?us-ascii?Q?Qug2TNAcaok82FNJachY6topMX9+BqvcJg/87GyecgPkLPIMnx1xDC/67JDi?=
 =?us-ascii?Q?uZlwjvnvu9a14ogm4Xjunx9fcyWy7+mYESppgqn+Ecv+5BOqbqKi/XgPTLb8?=
 =?us-ascii?Q?hQuWEw+k2vY/BZgGRGt6XsFlhw93UmOaJq3cJiR4ruCY2sN1whf1RtUB/Vd3?=
 =?us-ascii?Q?RhGRhz5+KScDSLR3Nlln48qJOcEuzSKGqaQCl7M4l0Avg+ThCHvZJJMbvMPF?=
 =?us-ascii?Q?0z/HJJszaeArx3Y6JZKgiebh6/ld6XDHJzHyeqKXqP7Sh4Y+c16rxneok6tW?=
 =?us-ascii?Q?bNnvVPOtwmAE/Ldqn5Z4kUTZF2yWNuEpQtGmyUKDDV90bitkj6f+C844RD2/?=
 =?us-ascii?Q?B9/X91gIK0NdUkwgOel5eu/6Rygf0sCcV8GLsyaNV+2Ynn0Vv0/S+dj6/ZJA?=
 =?us-ascii?Q?/bHU5nf16lr/XjjThcGGXZKWMiMNN0q9i65kTvp4aFMkf7ftXJPQlZS7Xrhb?=
 =?us-ascii?Q?nbde8rMZBdsiQCKyrI8VjHIRjv3Hw5w3QHItI4iq66QT5yacNh/zjUj+dC+7?=
 =?us-ascii?Q?rtyzsSUzBsC+g+6i9quP8H/lJ2n2i2qTBcSr/gj+u5NVugDcSHbORnFrwCuS?=
 =?us-ascii?Q?5Y1yjeiFZvEB2IX/pLarRXgpZSTk1PFoy+B0T4HADKb73858A63Yh6DudqOt?=
 =?us-ascii?Q?PSLP/EAvxdeW66Rzz9tWfwXCYXGgryH0J4yFxUbWbaCKpuPeMrRUaAcWnUw3?=
 =?us-ascii?Q?xVIZE+vMgOrdmCIcDlx7mnGV/SQdZVPhFtJrDzlRAbUFQCVxGSnt7ha46KhO?=
 =?us-ascii?Q?+e3gtDA=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 14:04:18.9034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76188529-18c8-4dba-7f11-08dcfffe3d1a
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5691
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

Commit 723f8359c1 ("imx: mx7: snvs: Add an SNVS init routine") noted
that the init_snvs() call likely applies to other i.MX processors, and
this has been found to be true for i.MX8MP.

Move snvs module for future re-use.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 arch/arm/mach-imx/Makefile         | 2 ++
 arch/arm/mach-imx/mx7/Makefile     | 2 +-
 arch/arm/mach-imx/{mx7 => }/snvs.c | 0
 arch/arm/mach-imx/snvs.h           | 6 ++++++
 4 files changed, 9 insertions(+), 1 deletion(-)
 rename arch/arm/mach-imx/{mx7 => }/snvs.c (100%)
 create mode 100644 arch/arm/mach-imx/snvs.h

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 21d955b4ae..0de207c068 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -293,3 +293,5 @@ obj-$(CONFIG_ARCH_IMXRT) += imxrt/
 
 obj-$(CONFIG_SPL_BOOTROM_SUPPORT) += spl_imx_romapi.o
 obj-$(CONFIG_IMX8_ROMAPI) += romapi.o
+
+obj-$(CONFIG_MX7) += snvs.o
diff --git a/arch/arm/mach-imx/mx7/Makefile b/arch/arm/mach-imx/mx7/Makefile
index f1436e2d0d..fec228a616 100644
--- a/arch/arm/mach-imx/mx7/Makefile
+++ b/arch/arm/mach-imx/mx7/Makefile
@@ -3,5 +3,5 @@
 # (C) Copyright 2015 Freescale Semiconductor, Inc.
 #
 
-obj-y	:= soc.o clock.o clock_slice.o ddr.o snvs.o
+obj-y	:= soc.o clock.o clock_slice.o ddr.o
 obj-$(CONFIG_ARMV7_PSCI)  += psci-mx7.o psci-suspend.o
diff --git a/arch/arm/mach-imx/mx7/snvs.c b/arch/arm/mach-imx/snvs.c
similarity index 100%
rename from arch/arm/mach-imx/mx7/snvs.c
rename to arch/arm/mach-imx/snvs.c
diff --git a/arch/arm/mach-imx/snvs.h b/arch/arm/mach-imx/snvs.h
new file mode 100644
index 0000000000..4ce9781ca6
--- /dev/null
+++ b/arch/arm/mach-imx/snvs.h
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 Linaro
+ */
+
+void init_snvs(void);
-- 
2.39.5

