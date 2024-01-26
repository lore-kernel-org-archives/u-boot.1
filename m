Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A656AC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 08:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E9C587BC4;
	Fri, 26 Jan 2024 09:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HhG1bdhJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB3E87BC9; Fri, 26 Jan 2024 09:09:34 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A61187BAD
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 09:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRs/wgM6+ao2SHXyhm11a5F7jT+h/ikVldk59nzirhky/9Dw/3ksjIioiSvQX3LV2LipzFD+OxAlVMBdBG5Q6YRBdN2B/+RwyN3Ttqna5lAqSGrCc8O/7pgc3Zr3RGzoRhq4LCL9ISe37wkB/VgMhUDLsjT3iHTEERK/fNnQdvV+RtmNJZ5hO10rW0N9E52vvOMdHd1hFn11epEjVlItcG26Kdr0NqcK/3xtOi+s5g1VnpGWKPjCLzOXLyGMz1lSuG1+OeTj6GgzZEqyMhm2VNQ8rFZORYcsdzlxNObk/NMZZwn3j2jl2lHRl1xZc5zk1FD+/P3vwQTcRk77R4DLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93rUSsfTQl43W8c9E/2zwLFovfEoB+M8qOaEH0g3U3o=;
 b=ffmHzwOFJsvsbN2V9AqdiAYlZ4WTGnJdeOMwGrMIjXfwb9rA7I52gEYfa5UoT5PFQcR+Q4ZyDyj/X5nrAnC90US/iHzXQ/Xu7jQvwJZ2cRJ09eHdCdTI3eG4rL05rUoLBYYYiLWYiNfFPiIi55tqqJEn/z3A7a9HznoM2la1+hwlArB4J8LWbmg7LgdhV93SzBr08yVJV6+KH/OnuHv8/l5LZh4giyQUbsiS2ebz6RV2M7FD8kcFZmSR+98pM2wCTHy4Nc42Z8FFhIij5MOcplD9FrPBsO/6OrwudJEI9CF0aXEwtIpVHcLlEsdgdTbkf4Lyvdd8KeG+WLqK+opBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93rUSsfTQl43W8c9E/2zwLFovfEoB+M8qOaEH0g3U3o=;
 b=HhG1bdhJMq7gVuBufQyA1+LPH7bvWbrAVIY+NzoQvGOSspiXWEl9AqJrM2rrYAyeiDtNZo4sA/VmXgRqIWecPqeUXUl2zzS+WZaLLZq7faWAe2Kj/nchNcehwK5JVxorBbb2JG6g+OSoSkhqzDVDq8LuTRFnl8ETuUIyy7aSnfg=
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 08:09:29 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::22) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Fri, 26 Jan 2024 08:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 08:09:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 02:09:13 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 02:09:13 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Fri, 26 Jan 2024 02:09:12 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] configs: versal: Enable CONFIG_LTO for mini qspi/ospi
Date: Fri, 26 Jan 2024 13:39:00 +0530
Message-ID: <20240126080900.3209323-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|MN2PR12MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: c75cfa0a-835f-46e5-b1b7-08dc1e461e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGC63fgaWqLj8LFmTrgPkJ/ygpu+1Qdz+VyZPfj4LTK6yLzaJUTwkcejFlqqmjY0Jys+Qhje3rbVYZLu9Lzx00TfcrA5R78K7UsJZLQ73zZ8EAQZhBRtIguawp/CvADgmg8nq7bUNQLU3IQfQYEhd2zkL7hGeU1myvXwSyBom+YMrJb+N5lRK342KcL0g9ztW3K67YJ9tdS3mOslWxBuz3mNFAFIxVQdXxWioywJbslrXzQwqSMTLQnS9zHwHurSDJNYtFlrG0e3PXBou5UlF0Orft+mYf8lOm3weCoMsZ3JaOsr2e4Kw4iYg1QEWuYnobYDxdl742b7dtB0zMdyzMGpjbc2L+rkotSkaxkDGfbC4+hvvlanbFilYG/oc83cHZGCbSCnAG37bYjs+QdP0F+TdIvUF+vO+q6H+JmsGJuvrYEl7K2O+UrnJcUG92xOAqXGz/gvU1EcVlQf1NuDcind2dwwH8JmaXCjdNemKRXgCizgTaTQ0Wygil/IZc3jHxguK3g9+s9CSbIaffY7h2FWcmQYb8qzd8Few083iugIrCASy2bko0hCvQr8lBLAhB7HU6RZbN9H2loAektezHKy+mz+F2QJVdgKUY90pxwHx8kCLBSK7ThY1Nhe7GPKuCvNj/KfXb96w1NfAuINdxFxinMTNWBTyczzfsOMURMWwSWtrf+KbeaGJSJCFy4rtQpOAPy4L0xIdG3g0vTI0ueVt1VIiFwQrMoOjmUv6UiSYJOAaLZ8ezovYDRSAC4XWU1g71e3tbTPvSeUUbnN4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(40470700004)(36840700001)(46966006)(336012)(6666004)(1076003)(26005)(2616005)(426003)(47076005)(5660300002)(2906002)(316002)(4326008)(8936002)(70206006)(478600001)(54906003)(6916009)(70586007)(8676002)(41300700001)(86362001)(36756003)(356005)(81166007)(82740400003)(36860700001)(107886003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 08:09:28.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75cfa0a-835f-46e5-b1b7-08dc1e461e90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551
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

Adding a tiny bit more code for mini u-boot leads to a OCM
image overflow. Fix this by enabling LTO for this board, so that such
changes still can be made to the common U-Boot code.

Enable building mini u-boot image with LTO, which results in about 8KB
reduction in size.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_mini_ospi_defconfig | 1 +
 configs/xilinx_versal_mini_qspi_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index 72a123d965..7a110350c2 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -16,6 +16,7 @@ CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_VERSAL_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_LTO=y
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_AUTOBOOT is not set
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index d9fbac986c..58945a1cac 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -14,6 +14,7 @@ CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_VERSAL_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_LTO=y
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_AUTOBOOT is not set
-- 
2.25.1

