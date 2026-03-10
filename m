Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769E1FD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AD428401F;
	Tue, 10 Mar 2026 14:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lqctNV1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B20183FBC; Tue, 10 Mar 2026 11:06:50 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D3AB83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 11:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TC0CNMMYQ8nZspI3nncAUH9tQjN5ZG+Lbk65f08HhYRe3t6iWh6HOFJXMA5vMEXvos4c6zebgHzFV/UGcxDULXZrIxXld6NbFyhd0NGZfzdIM1G5EpiV8voznUFn3BXo1CXV0Y3lKmNmUM1MUGXMOqhLWiANAx8YeZH+Cj6w1xSpUmzNxS2MET177uLuoj8Vao7RAwGKYSO7EF94c14Xe8/JGBJVw7fa6hT6HaWCDFle1IhadBDGGpVcRUxLCKyUd8R9pWyBRiVaHrvuFNMlpRcGRiY17A+iD8Dnb0yWnF+04d4o9B0hAw8I+shBHMXdXm+ubGtObY6OwlbDxPtaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g2c3wNcNikG/v7WBCpyrGMJYkAUINVIw3hGT9h6sXk=;
 b=yfMpgVTEsPnFVI93zJlS9q04eIhnU1CtPmTCSOoMyGXWvnQQ77njKs528Nt29rGlvk5SULM9iI97bwSOY1gb1fax9ocm0LusejvtJHRzQh2WRF+YHwC4FN57YfcIcNRBdz7ssV5QnzmLvPkfLNo6Htj8GvC3EHv3VhJxb2bfbyz7dEV2n2H5pAtc7EJY7/MbvSRJEdlNcM2ZdJ6BupAGEszALN8Ag7LrqREuRWGiPX37Ga0WpdRRn8jIhugN+j6oPMrMeQYx6e2OhOf8zB5mrtpUWAN5CPO+sHXBxBsYG4EbgeJ0qz5HZMOTf/qbccSril9mIfBnud+8gb4b4vlnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g2c3wNcNikG/v7WBCpyrGMJYkAUINVIw3hGT9h6sXk=;
 b=lqctNV1KE8ZXsYxR+jMM/9eJOz0viOotw6lHSbaHjno1pisqfSu49wZ8oRlyTlNNkNo7ciCHdzt7fb848H36hkWjMWaJbDStDOmS4ZIy3GmCEecJFBJvulmJvRZaIPPf2YEqJ1xgXiM8kiNnU3NiVxmz2Vwp6mBlyidwTXSwokc=
Received: from BLAP220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::34)
 by BL3PR10MB6212.namprd10.prod.outlook.com (2603:10b6:208:38c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 10:06:46 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::67) by BLAP220CA0029.outlook.office365.com
 (2603:10b6:208:32c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Tue,
 10 Mar 2026 10:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 10:06:45 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:06:40 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:06:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 05:06:40 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com
 (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62AA6Hr42355078;
 Tue, 10 Mar 2026 05:06:37 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <msp@baylibre.com>
CC: <u-boot@lists.denx.de>, <vishalm@ti.com>, <sebin.francis@ti.com>,
 <d-gole@ti.com>, <k-willis@ti.com>
Subject: [PATCH v2 4/4] mach-k3: am62ax: Enable 32kHz LFOSC during LPM resume
Date: Tue, 10 Mar 2026 15:36:14 +0530
Message-ID: <20260310100614.951573-5-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310100614.951573-1-a-kaur@ti.com>
References: <20260310100614.951573-1-a-kaur@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|BL3PR10MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: e3486ad8-2c8e-41f0-8d4d-08de7e8cbc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: F6O3zG/s/aSwLk26xf+k4xUtdTvfQ2tFWpIo5qCO3Fa0wmaSRuUcrHvof5TtripsfUL6t1HDPotTsycbeFChhNLw6sLB9vH6umCtaW5U2DwL7/fQTPl+M5MokR2kWzRyyTSX8TbwttkISLubrvCR1//Bii8aIVdjGMcoTe/gZL5NxWMyQaS7uKPwBxzY0DKMB6g3zg1v2DMzuclkRhMUbix1WHagLWagT91VxYygwpkVs6pl76zHFB0sC7r6/3M34ErnsX0L0DGcNt3g9LHI5E7so/u1i1FIYeMYST1hxoPMOTxKgafaiLe04DM4jSbsXERIWvL0NoXIkHuUTpcDW+4tYIoQMMhPnZ3o8P3bxkHaM2r9twz3PKYtg3l57flYdCJCAwzyDnw3OB9t8rHnSLNf7HxybUAf2qoxUrDgjlsvKMZb4BUde7SlmBQctDmtGVQgBKxv1Xom3NvF25bfmp4bssY+MaUXabXczkvFjLRWw2+nblVfcXgJ91+bMEBseDD1+1+PXgr/Fw3DDZyzJDZJNH4Chscrd/g+Uzl0INfbp0PMozVxUibMtbcXL39AmOGnaOgm6YmPJ9RUl7ViZkegu8EHOaH523K4SaXtIAgW6u5dTGyYnW/2f8iaHkWosfkfcJOLCv25hdhyZttY/ph2mJxFTc8G8lumodJ41xrfS91+RcFJQ7S/IbyHitxnC02tpGCY0vFYiF70kYMW3CrIjJyTgGNYCiKTsMybGYJG44S/cNeYcFysPeJeYDiQ0gQQkodjVV0o1/t9uKqi3g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 962ej7FPM6ZwiSxhJlSwJ8psZFpeSmG5zdYPJMRk1e2HBIIj9XbGUJ6Edzba5Zrmpix3ecfvCmrK8GFGlxOmr61evHzAKN/CuDm9FnrEgHVXvp4ajigVppQKpzc7ZWqGa5FJTbY62MdAD5HnnDOq0BjUWUS/6kgA72jkf1RjhP71dMBvrYrVeEPi8Oy04wpP6QoHyI6NGR+cw36wEFrWapTP3js+4zJbfh0ZkTqYl2oLEtMGKp0a1Jx9XRyLCB1d9BVTpE5JPGGmPBP9sojdUt2CIu7ueWO3dbJ3RSKljf2rntBUXhfwCEri3LidUN479eDuuKoARLKiisNXVreaUM0lekZWkdsUEVQlZBGZZN855pfqAwMqEMM3ebPiMe4xGOXRxs/XFdatA5pnm43FgdEwBHFvMkPTP68ngKu6Ccu2HNtTEGy+5bB89nnRwukp
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:06:45.5790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3486ad8-2c8e-41f0-8d4d-08de7e8cbc8b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6212
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:02 +0100
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

Enable the 32kHz low-frequency oscillator (LFOSC) during IO+DDR
low power mode resume for AM62A SoC by calling enable_32k_lfosc()
in the LPM resume path.

The 32kHz clock is required by the RTC to maintain timekeeping and
generate wakeup events during deep sleep. This ensures the clock is
available early in the resume sequence for proper RTC operation.

The function is conditionally enabled via CONFIG_TI_K3_BOARD_LFOSC
for boards with external 32.768kHz crystal oscillators.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 74e598d5242..99a705d0bf1 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -204,6 +204,9 @@ void board_init_f(ulong dummy)
 	if (wkup_ctrl_is_lpm_exit()) {
 		u64 meta_data_addr;
 
+		if (IS_ENABLED(CONFIG_TI_K3_BOARD_LFOSC))
+			enable_32k_lfosc();
+
 		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
 		if (ret)
 			panic("Failed to get LPM meta data address %d\n", ret);
-- 
2.34.1

