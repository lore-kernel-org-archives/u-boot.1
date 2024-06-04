Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D09C27C52
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 19:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 372A687ECD;
	Tue,  4 Jun 2024 21:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NzThwxbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2865787D43; Tue,  4 Jun 2024 21:53:39 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00999878E2
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 21:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoKgLdmYjVjPNi9zQItHGdZtDrpO/wcn91TZLTV5nfzjHET+KQMEuXTlUSMD0Y4VgLLhrY8DBljyWIOUj/fnBFsd2oKXXczgKrT/ds3JtU1n+F8OP/nQtv0svgc7JyHHKfcvybMKVc09hPB0V56v0NE3vOMcuBsRUr4xYr1anY8WOxpZOBez4vD4HBZED8SHdYD9NJtQDoTcrY4nunCZSebLnSXqJq4UjNPq52MnNBd6hgTGO5FSnKKgwntATgBPPOR/NeQR289RQ7igegE3w576LVSfJpj32+DdulK54NTnOOYRfc9BOVd6bzvU2Ectg1X/PfVWWqxlTbTcLI9Klg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC9hXsxyP+wxzDl6be14lmqrZaLE9rMSRaQN7nTIjQU=;
 b=MmZ/m/fR/1WDiQUmxO6raGgfWNXoQHRQt6P052Fbfm+f9IxAjFLC843UJTYEfdPjLdqwLti13ErMe3UA1MVsYRW9WXaAym2/+E1zF+F8yMFijrN9fZwP5MGJJR9F2q9UfPm8sqdL34/PJ02Dz9NIeiWKGhAb+Hbsqc0dDETgdSxKO+4y7HcT1s5ZGzEh9FmBA7fkPSOnUi3+9yx65zsKntT/70Ss9UwKRgMuavSLkfaYPJ/n5ZHl/+xAidLRcoUCOlcv7HtRw6zZsjolKGRHehvITO3/7m6ZDMQUAZo828ujaCrfZjlEtc3yW2Sc2zHJxoCDBBYHfuO6CR+Mg3G6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC9hXsxyP+wxzDl6be14lmqrZaLE9rMSRaQN7nTIjQU=;
 b=NzThwxbn4kV+cTyXR3b5bHJE95g7/LQsWjQ9GhxRktuxhfaQb8gS+uQDrPlFJNjQf3tKV6RD+4Ja8tBedzmNyv/gfE4nPwdoHitF9nr+8kZcrHjguK1pKO4ZsQDmdkPTAjQsz/hKdyApe/+w10hpUo44OtoSPAEmtfL6fRo6L0U=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 19:53:33 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::c2) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Tue, 4 Jun 2024 19:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 19:53:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 14:53:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 14:53:31 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 4 Jun 2024 14:53:31 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, Sam Povilus <sam.povilus@amd.com>
Subject: [PATCH 1/2] doc: Remove extraneous curly braces
Date: Tue, 4 Jun 2024 13:52:55 -0600
Message-ID: <20240604195256.1820285-2-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604195256.1820285-1-sam.povilus@amd.com>
References: <20240604195256.1820285-1-sam.povilus@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: b9204e0e-b1ad-4a1e-4d04-08dc84d003ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iLdAxZs65qyj+blU1K5BYhWCrGQS3oi60uP8mURr8im2BqTaWU/swYapBMCF?=
 =?us-ascii?Q?kCybpWGxVQNBR5S2idpmgT4Nat2nuGjekXv8iV6LyzREDnMxMLcDQyWDRVTr?=
 =?us-ascii?Q?WYGk+Ka6jMbBe+uU8s5fcrCG2eJPBTTyRxWMAi4tb0Yt+zfxC0DPEFyOI5w9?=
 =?us-ascii?Q?2hYrj08KdZvNW+9CNYQROQpZ16dicr5FPtWDxQmUSfZtOnSxwaUjhgOsBykT?=
 =?us-ascii?Q?RojrfWf51EMvredDXG+9w0qI6tMHAeb18omY4F/bLDo/xZZTeKUmOllagHJ4?=
 =?us-ascii?Q?130tJP6cJqWS+tRFERfzJxdtqnQb0yKKehD+WgLrQX8e2y1cZzjoE9ny6MIR?=
 =?us-ascii?Q?fZIuq7bPQFOJWSOLgJp8BdpZpejKGJrPery9J7KIHvAoT4yJuO4ht+zt9Aq+?=
 =?us-ascii?Q?dodu1coGY3WE3Wp8fAztZFgdi7fvyAfX3AAoS0fPe1bfLt0zFeV1TIPQGaAA?=
 =?us-ascii?Q?kyn9IEiNxHyDLr6TpfaiBsXbdy2RYbF2vXd4hqHh8XkAhKZ/x6m4Zz4rpH4i?=
 =?us-ascii?Q?oe0bCR7OtBdoFOIb0M+jVZZ2wLM1xy5nYsRclHipGXHAQAA0mMgWkrKq2Ht5?=
 =?us-ascii?Q?GXU5gYgw9MU2ZaCrsNpSoMRooxpCdgFRGhB6hw0PmWWvKgqVBvhmFk48roGw?=
 =?us-ascii?Q?P2DSvmIRwkPHY0EwPSM8peFa2Q/5L7kHakI8mLAWEQJiLLg2eGDA5G7nk9kw?=
 =?us-ascii?Q?CKAVb0YlNGSeuvzV3Jpz/AyaOBISVJft6WOvyC4zA+3edp1oSPJEZNN678hz?=
 =?us-ascii?Q?GAd12f4UD9Ekm6+xBZGiMVb0Y7ZHePE5dP9YjJHAJXZxojHxCxBSAX1+k7Jp?=
 =?us-ascii?Q?g95Hn9OqhtFwDVIG0AglmJu4tb+2EdkJEvuOhJH0m/Z3R4w+qDn6wbWbpdCn?=
 =?us-ascii?Q?OeQ5cAXFVbx6L8R/AotHw0ZTB7TIUY7P2+7wbInCIe6Cba1IKql/exPvdupI?=
 =?us-ascii?Q?0Gj8Rz1xlnDEuB1UrqiB8v7YzFtxAxHP0vZLhDdtecfKq4wgmPKPSC9nlSPV?=
 =?us-ascii?Q?r3TGVs5a4WAamo/NPQjPTY45vxoAL+5NmKkv1/wdWTNUGF7Wcd+mxklKqg0p?=
 =?us-ascii?Q?QMuMiglbe9jTwVXA9hHgKg3VNmyhPmvWXTXnLe1Lapn+ZHCHo1G4dG7FeXkE?=
 =?us-ascii?Q?0kE8+uVLXQcP0uDCeL/H0h5yefq/BpkTNfK11pVaWJK3GUwEWSxPqSBEThQ3?=
 =?us-ascii?Q?OfXTkuOXz3IHGmwvdMth8WlpSesxISTdzVJjla4jOMZAp+nmciSMd8OIOdAK?=
 =?us-ascii?Q?+8D4edpPuOjCSLU7C605BGwNKXZil2Zcae8+bpRXL78EGJi5IhiTWu8qUfvA?=
 =?us-ascii?Q?gehpJJx23yCkC/xpSiH0YsgyWPAvrRzz+CInl0wJcXkBl0IPX4H7c4W22U30?=
 =?us-ascii?Q?IkDdDOBE2baE67f3GF/emhv03UmF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 19:53:32.8023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9204e0e-b1ad-4a1e-4d04-08dc84d003ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
X-Mailman-Approved-At: Tue, 04 Jun 2024 21:57:40 +0200
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

Update documentation to remove un-needed curly braces.

Signed-off-by: Sam Povilus <sam.povilus@amd.com>
---
 doc/usage/fit/source_file_format.rst | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/doc/usage/fit/source_file_format.rst b/doc/usage/fit/source_file_format.rst
index b2b1e42bd7..310225d839 100644
--- a/doc/usage/fit/source_file_format.rst
+++ b/doc/usage/fit/source_file_format.rst
@@ -192,13 +192,13 @@ type
     invalid               Invalid Image
     aisimage              Davinci AIS image
     atmelimage            ATMEL ROM-Boot Image
-    copro                 Coprocessor Image}
+    copro                 Coprocessor Image
     fdt_legacy            legacy Image with Flat Device Tree
     filesystem            Filesystem Image
     firmware              Firmware
-    firmware_ivt          Firmware with HABv4 IVT }
+    firmware_ivt          Firmware with HABv4 IVT
     flat_dt               Flat Device Tree
-    fpga                  FPGA Image }
+    fpga                  FPGA Image
     gpimage               TI Keystone SPL Image
     imx8image             NXP i.MX8 Boot Image
     imx8mimage            NXP i.MX8M Boot Image
@@ -207,31 +207,31 @@ type
     kernel_noload         Kernel Image (no loading done)
     kwbimage              Kirkwood Boot Image
     lpc32xximage          LPC32XX Boot Image
-    mtk_image             MediaTek BootROM loadable Image }
+    mtk_image             MediaTek BootROM loadable Image
     multi                 Multi-File Image
     mxsimage              Freescale MXS Boot Image
     omapimage             TI OMAP SPL With GP CH
     pblimage              Freescale PBL Boot Image
     pmmc                  TI Power Management Micro-Controller Firmware
     ramdisk               RAMDisk Image
-    rkimage               Rockchip Boot Image }
-    rksd                  Rockchip SD Boot Image }
-    rkspi                 Rockchip SPI Boot Image }
+    rkimage               Rockchip Boot Image
+    rksd                  Rockchip SD Boot Image
+    rkspi                 Rockchip SPI Boot Image
     script                Script
     socfpgaimage          Altera SoCFPGA CV/AV preloader
     socfpgaimage_v1       Altera SoCFPGA A10 preloader
-    spkgimage             Renesas SPKG Image }
+    spkgimage             Renesas SPKG Image
     standalone            Standalone Program
-    stm32image            STMicroelectronics STM32 Image }
-    sunxi_egon            Allwinner eGON Boot Image }
-    sunxi_toc0            Allwinner TOC0 Boot Image }
+    stm32image            STMicroelectronics STM32 Image
+    sunxi_egon            Allwinner eGON Boot Image
+    sunxi_toc0            Allwinner TOC0 Boot Image
     tee                   Trusted Execution Environment Image
     ublimage              Davinci UBL image
     vybridimage           Vybrid Boot Image
     x86_setup             x86 setup.bin
-    zynqimage             Xilinx Zynq Boot Image }
-    zynqmpbif             Xilinx ZynqMP Boot Image (bif) }
-    zynqmpimage           Xilinx ZynqMP Boot Image }
+    zynqimage             Xilinx Zynq Boot Image
+    zynqmpbif             Xilinx ZynqMP Boot Image (bif)
+    zynqmpimage           Xilinx ZynqMP Boot Image
     ====================  ==================
 
 compression
-- 
2.34.1

