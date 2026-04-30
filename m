Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C5AFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 09:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01F78469D;
	Thu, 30 Apr 2026 11:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KrUt7HOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D756D8469D; Thu, 30 Apr 2026 11:34:46 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15E984668
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 11:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuIRP6X6inzhKl5ZVho+85K0FFu9TPjJXYnhrtD8m8zCrFEknlwlbxU68ixW8k/dru353nl+Bdvm6uqwyUVeoR/qh9c6xRStHY4MEZSN2HSC9yad0lqgTzwV7N4YRG0p2X/cqEWuAVicsO7xbdTnm9h3JOlBCgxT0uu12cE0+1h0nSfvXXhyrN+Hhvuv7fgGNcoDxNNkB8llMnrPzKfSPLN3C2jjChbLFcQK+FTk6ABzyg/Bn3n4tKbI2wUyh2Juwx1VGpmRPrUR+qHRfJIWqrllYS6UCVpVYbVVCIrITpejrBebfRmI8n3e72HaSIG4qetXlRf1gnra/MVz5SKP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnjG4cgEJaZSjqJ0HRILJiMgeQN/LUXQ8QX88rJhRfE=;
 b=TkEAKO/euhO4nAa3Gg1Ypr9zcassqDTz6azebYCnXykODgDq48peLZlvfCk5kbQ5gu17PYa86afRkCvCCQwm5+VU4iMee9X6LYIejsx2DcdLbZF7eZaGBYfHn8YlIAoajgv17a3jOWM+B3qRAts8Qald6lQoLGomm61BH3SB39+ngkOJdTj5qok74h3pujLcyDEYJ2pW6UjjPeJBoY9V4uzQgWflDplkP4xszKkhjZ5TgsepPiuMpsD4Ew2XvOxK0bsluuyH5Qs1h9CnwMnouL2lMLEaTGoZZHf6mqnnbtevIb7F7qmcYEXzfFUID4nZT4h6Tjbc1rYRAZ0AQuSQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnjG4cgEJaZSjqJ0HRILJiMgeQN/LUXQ8QX88rJhRfE=;
 b=KrUt7HOhvWmcNfljsfTuJPZx8i/30n8el8G8fIOuFgdzJ4RGEK7tWu6b0nAFbRIheYsUONzmn91/uhlz5rGei1V6o/GlTaE76h1ou4ToLW1/gApNoGkA1t79FcPmUtS4UVmRLgX+DT4fJSaHerZ6fpiDI+jXO3pLkKXhZ9UcVAk=
Received: from DS7PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:3bb::34)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 09:34:40 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::2) by DS7PR03CA0089.outlook.office365.com
 (2603:10b6:5:3bb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:34:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:34:37 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 04:34:36 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 1/2] configs: zynqmp: Enable USB gadget download support
Date: Thu, 30 Apr 2026 15:04:26 +0530
Message-ID: <20260430093427.1852145-2-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430093427.1852145-1-pranav.sanwal@amd.com>
References: <20260430093427.1852145-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: c46deaf8-d945-41eb-fd98-08dea69bb308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: PPYuKYFwZeCbWNvVe0LjpqI4EnzRz86NzDo8Nxb2FU6s3QKQXtrLs7KLdB0pWQNZnDkYoNBpUNhpV5d06NDt+bbemMwSV5k9G5mIaiucbQKX+P2iOhDHJAKv1lBxVP9NahZ9lQy9RWM8NOa+2aw9pYK0gG3wfmG+llTR04EIEEgHizh6yxNLS7LL5R4upbdxzi85yuBtthi6903VCXVs1iUEquoYhCLm2odq1h9nfHROBH9MCN0mjB78/bS7PYAWK9yncv8ZszgtmsvbSw6qKwrEwIOkhOML8ZxlVmNM+MOfXjcmzF8P3uU7WVMEZgCPuL0JM8CSLullGY9HT3pIr6Kta84H2nwiZVwwXWBaReMkCg2DO0dUzGjP2eR/NZgfNGX+r4MhysZW/D+PzvqgcgMRU484wjuS9aT0VakgqHNR3ANKrXNprovqUPU3ygewT4wqNYB/CHu91jrP5aG6L/myBPEMRZJ1XS8ikuNvkgJf0GcbKScqyVSHzTVlHGnKsQ25KL7dVYUiCsxMYvM8IVgkKOAVLkKMsdSXpMRwjiDo1cEptnhea9hGiutB4/Dtw+kGrxaf49LvRWi+uYASTfk7MgJ8Lox8A1NZjXUbHN9IIgqBTvruS3Jdn2xI/obC0I0x29CVw1WQU/w16gZBP114E+kr7RN7zJ+WhHlLOihhJrDJkYxZDX7+jXWbEEkeCVMyru2C1s8uAaaXUbtGGruKmKtf++DthIlOjx/IKv7eFnnEUpyEz4/mroJL3S7F/OmryMdM6JRLLqHqiJql9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AripxFXke/56SmSdc5VUSLJCyefk1/ccmrQYhLhfL5PhSTYqleHY9QkM9yRNXONaDNjzISbAXsD+a1G0nT7TQ2AeD6Shn41x4rzPfNiemW5fyABmu1oKcOj8/uQOkhhpaxoPsr6VO1mfyK0wi36nPzfivrowRJzsyzKsnpW/hpHjmnikg5HybnCvlZ+sbF399mv08ni+zVIMv280NTT5Rty/8r/E7jwumr4dT0DHd4BaVm371dIh3vua+cuXrY/6n6JfYhdYvcgPpGBjIw2XU0M4uQwSXsPMcGssC4YB/OnxQyrEDpg+cpN2MDLuxaXBPOPyWkAknjaxtj+NSGGmeg0JWdWVO5TCNh3sSnNcXgtNPJfqOVK+u20aA1CT6Clj88l06oRiY4ykOjXDcfmr6m10Xa4w1xNuNVMyut492vBMdUG59Hpwne9gwc/LcqOi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:34:38.6220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c46deaf8-d945-41eb-fd98-08dea69bb308
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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

USB_GADGET_DOWNLOAD enables the g_dnl composite gadget framework,
allowing other functions to operate over the USB peripheral
interface.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 configs/xilinx_zynqmp_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 2d85084814b..111eead51b1 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -220,6 +220,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Xilinx"
 CONFIG_USB_GADGET_VENDOR_NUM=0x03FD
 CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
+CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_ETHER=y
 CONFIG_USB_ETH_CDC=y
 CONFIG_VIDEO=y
-- 
2.34.1

