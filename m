Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55099C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 19:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07DCA83A6A;
	Wed, 21 Jan 2026 20:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TfWhFM98";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF9E80077; Wed, 21 Jan 2026 20:53:53 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33882839DF
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 20:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlQD8hLbDSq4VsN4gtbrbCQ1s+K2MYumACgDkEndxYb6PSU2J8+hXtPv6NITRq3/biNBP3PBTOsu0lzRb2oJoAmsNI9TK0qTp4+kCcZKIAcGvJJQqAvF0a0hfxAmup5Vo9jaVlexLYkdfKzGaHwHbggnWV93MXVDyp9puRHwVU9NREZteRHo4St1cQSE6nTDvpHUgmVHOl3Coay3N1XCuxZMcwfu5wgrdnAHgDjwzpsl+xqnUNINUwx1bfJeFTe2+i4KgQg5CS9BG05dkiLdJyY/cCUxFYq0ZfpZ9MTwb37cGVBbZKNn5j0je4rgT/rgOzmEoVsmcor6a8fbTjanoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1AuaFqW3Z9nlD6iiXa5B+PUCE4S/XqRyLg+VtK8nC0=;
 b=dYfu2mkVOgCXuicIYbgrCne8JSRX5DidlutMAo0roOb19TVD44leUVo10ktdmlEQzhrhFQuh/f1t2f1fB6K4E5ghmmFcdfWoqVVldnjP8DZ4UhHlpkzsc/75oQsj5uKVJx/rYzhB6ettlBQCnEsnH6Qq52x07Zw791J9HwZaqnNGC/3YT+/r3SU+r7xbtkDImVWUBsT+QHnz2/ZY8/O9+6taltWZGLJrrYjJnYdP80lyRlSQBK1mgAOb6ZD9uPjJ5t7IlNwnr/wYQ9UfKvk0ypuY4HFokFoSu/OFrKmG9LjkwezAP0ZH5tYGABMreYaVKJTDyra4Ua2n7fm7uyvpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1AuaFqW3Z9nlD6iiXa5B+PUCE4S/XqRyLg+VtK8nC0=;
 b=TfWhFM985rNcAXvqCKYtKV2k4OgKy0AzhXoW5AouxRA/Dz9iTKsSR9HJh7YUFMyUekK2WbfqQcm3E+Wi+2lw+LnASrHlLRFa/TzDv3u06L5+NSJYkUjHNqiWlpgZ1gMw0j3lR61AO4zBUm3ic/kawH6OtlXgdA+FRhHh96/XzEA=
Received: from BL1PR13CA0292.namprd13.prod.outlook.com (2603:10b6:208:2bc::27)
 by CO1PR10MB4658.namprd10.prod.outlook.com (2603:10b6:303:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Wed, 21 Jan
 2026 19:53:46 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::3f) by BL1PR13CA0292.outlook.office365.com
 (2603:10b6:208:2bc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 19:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 19:53:44 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:53:41 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:53:41 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 13:53:41 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LJre8H3424431;
 Wed, 21 Jan 2026 13:53:41 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 4/4] board: ti: am62px: Enable 32k crystal on the board
Date: Wed, 21 Jan 2026 13:53:40 -0600
Message-ID: <20260121195340.3041549-5-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121195340.3041549-1-vishalm@ti.com>
References: <20260121195340.3041549-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CO1PR10MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 30248c32-f8e0-492b-b095-08de5926c8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KpMa6OqQ9sfWyVWbcOZnGWlemM1YDE5+baysz4zJHEaBuqVmNxWGOG9yArr9?=
 =?us-ascii?Q?Q0pl86kW3uM7BTBMJcP7bF1XZVG2V6redAVA2CgK5rNGyMIpSFqitcfxqemq?=
 =?us-ascii?Q?QJrCZunEedKj+rOmoikUE+B15Ox/niwvKccSLToFvcZ2J7matdCMfT2FJaqD?=
 =?us-ascii?Q?5Ljza7m4mUMDFIoHrQjgm12qyrBWf4eBE4jBPhZvN74ouKJvzngw7ADRGQU4?=
 =?us-ascii?Q?d4q48aumg1hW79kuoDwuMSmYJHuFNGRKF6EFm5Pmtqf9eSdmm/QPrl0itmF+?=
 =?us-ascii?Q?FTkavEOYGuM5EyvNTeGWC4LGqnPE6D9tHg+e6aRJASPg3+JPvWQ/8pEhjyv8?=
 =?us-ascii?Q?auwN3Z2vB9xRco2hrMpMW2hySTd1g6F9RJIMwmo7KMeQDzg9jvFHO/Up9EOX?=
 =?us-ascii?Q?Ul6UCLzwpjU2GezeDKgMAVtI6kjewtySNrrUNh8G7sS3jnkPkMDkB+IG8KmU?=
 =?us-ascii?Q?GJMse+tsjv4I5pnU+Iostog6XL8RAX2zFag6Vn3p1yxljP6Oq7T15T2TFshU?=
 =?us-ascii?Q?ACdKaI00amVJ6LU3AqoQlOtqTEcXzRQRBOZc2QuEQ0oCMH4NNwdt/pv+joEh?=
 =?us-ascii?Q?P6MedjFhGJTgApGPXQp/AJhzRcuJCohYc1q0eFM0mb09SB0mIyurxpTcGv6b?=
 =?us-ascii?Q?8TVQwkarCv+cSS3zXVOmiOQmIlKuuAU1vRvv4bUq0WrW5QWUil2FAAmje32N?=
 =?us-ascii?Q?32d9ZCvuqT9kIvl0pH7ZUzVvolxU4oHjovnu+gpGhH3VCPRuMwXCk5c3xcuL?=
 =?us-ascii?Q?rSSXEF/B+iMP+m+AV5+fKCUFUsNnsYGDVAN5TQiJqgbs/PTXoU0nwHvHkDlC?=
 =?us-ascii?Q?R3gjfqcBaxAegEbXiqmrMH/cX/swWe/fx+In91XjANWtmng6zXJGvwPVPz07?=
 =?us-ascii?Q?Y6wph6SgOSMh4H0suPzuCjXKXnTLGix9P8X0p14yR1MjCYF4K2glzaEQcDst?=
 =?us-ascii?Q?wrv50Nwb5C2KiJEWdtIjFuOF8BsVgylxTWpbbyCH71hgqM5PRfYCwwGxZeFp?=
 =?us-ascii?Q?3lFWvKszcJMEFQVzBdG/VogVoah9hJsHfz92TcTi6RicwHfzfoD/IiY79GEj?=
 =?us-ascii?Q?Y4beXjUS5Az4gE4g205Heplmu3ScSdLiXVTxpa9wThr6nFcwAo7FnQUBwHmj?=
 =?us-ascii?Q?OlH1gt8TR4z6h4NUSpit/D9UZqzxReFubQpiXXprS4+Lz7LrTAg9YQ3l1GLo?=
 =?us-ascii?Q?N152B8fCkDrjCf/FyS0KemabNDmzqtHzWt0k/1MIBXQ/llM0mBga+xbROpcF?=
 =?us-ascii?Q?UBg9+abKHct/kPTiOjIr7QbKqRMLO3q5nLdP4xTXrGEYQOAOIG2OlGQbEaAR?=
 =?us-ascii?Q?y0Kd3/9J7BFQOf7NssBKAN0LBTUaj2ybQnF1dly2A/gA93X5n3a/5r09yXKS?=
 =?us-ascii?Q?e7ZGFclYD6BVc/G0eYLUh1uhn+h5fOPpjjXm6+qztUWpHe6ZGn4mne13fhJi?=
 =?us-ascii?Q?ot5KmfZr4Poa/xG8Bx0W2m5CxOoLKz2oZ/KfJl9xC88kJO0/cmHoylcO8v/8?=
 =?us-ascii?Q?zzxtXNOXRf4veKnzI6kdfde8VuvmsAHnt3ReDuEgeGJixcDKfcZjVeKFGjv2?=
 =?us-ascii?Q?uhHGXz5pfNs0e75SpO6lS/ofcyrOsgx8nhDTlUtMJ8jIYvQPZ6OvYL769cZg?=
 =?us-ascii?Q?URKiGpIr3duJFwb+uEtH2kl529Or9PQ8aoFIZRQYZcjBQpRzhvKmnz3cJ8Jn?=
 =?us-ascii?Q?CXahIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 19:53:44.6759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30248c32-f8e0-492b-b095-08de5926c8ef
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
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

Enable 32k crystal on the board. If external 32k source is not
used, 32k rc-osc comes into play, which is accurate to +-20%.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 board/ti/am62px/evm.c           | 4 ++++
 configs/am62px_evm_r5_defconfig | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
index 85c332b9339..8fde47fb1be 100644
--- a/board/ti/am62px/evm.c
+++ b/board/ti/am62px/evm.c
@@ -16,6 +16,7 @@
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
 #include "../common/fdt_ops.h"
+#include "../common/k3_32k_lfosc.h"
 
 struct efi_fw_image fw_images[] = {
 	{
@@ -45,6 +46,9 @@ struct efi_capsule_update_info update_info = {
 #if IS_ENABLED(CONFIG_SPL_BUILD)
 void spl_board_init(void)
 {
+	if (IS_ENABLED(CONFIG_TI_K3_BOARD_LFOSC))
+		enable_32k_lfosc();
+
 	enable_caches();
 }
 #endif
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index 378ba21137e..f1b3687786f 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -122,3 +122,5 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_TI_K3_BOARD_LFOSC=y
-- 
2.34.1

