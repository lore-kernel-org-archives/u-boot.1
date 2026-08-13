Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FA7C5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 07:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 590048117B;
	Thu, 13 Aug 2026 07:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OqUL-mQDi4t5; Thu, 13 Aug 2026 07:23:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30C2480EB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786605836;
	bh=JtrMY8/tFLqCtAcfGjuPO54NibdVc1/51TkMJUk8Aq8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zllk0KFdJBlsoUZ5NqKjldqsHZsfbxdP9kumqQo5RSrZ/Be8WqXqOsGTaFrBgowJT
	 SBocQLP7dO+2RE0F3KBQybr+YbHDRFBRb9e+2edcYTCpcH/rjubh6/rSKSrESDJzya
	 QIdr5FrKVHpwW5ewRtmYvmCerIidA0MHaVCml0kSZJIGZ3X6Hh62BMGyrskz7p86u/
	 MwZ4RxsTzvEKASCXeygtsMfWsxmh2QkGQAqor0cKm7dMBpOYkjX6B8UkepcUXG1PBI
	 wxgwtgM9uh95lqoyu2SDwezqaostZjUTBIQQfKRWfsgQOowPhqKuS63vY50vfiJOjS
	 O8LVYjDJaPqPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30C2480EB8;
	Thu, 13 Aug 2026 07:23:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA6022B2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC770608A1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:23:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w-fr9e8fNIq6 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 07:23:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DE579608BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE579608BD
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE579608BD
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IK/qpe+jEr1Dndk0tH52OYupBduZOVmlTvYCwYWpMorNdMjwRpPYz2hU9qrilhSo+jnJV/qHxDLXH1a998rmhDejMaMWgu/tCvevVS/DaoMbf5w078dPSIeMrcm6z5QnR+dwJI257TfjTqX0CS2a8zhowgv8YeMu4kErEB8Jx5rKIpAlNe9dQJVPn7imPAYpEWoWhojLFDnJEtM9YRI1u6Kpf+IFj7fWuacyVJQ2+r0MLA4pspvTuP7nGzegLsKVdEBJOKhUKd73SbhhyJberWA07wl40hR8vaTHcFGnQ9Yxmmc/q9cHqcvVNcuq9PMDPwRPNgsVSXVwjSCUpWke3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtrMY8/tFLqCtAcfGjuPO54NibdVc1/51TkMJUk8Aq8=;
 b=UX5ItMIrlkeR6UJEdQaXy3qkNnaZcbtM9yiGmsNurQGtp4FKnDozutALtVA8c0cBxX47Sfsd7Jt8BQQG96Qt4BX/dj6Hf2GIn2FU0S39EjHHA0hh5aXrZ6AESbKWULKLbR282sp3JWvF63yuhFXGuuOrfcrCVlrd0ASf33Gt06RxlJkH9mXFVbauDA8SeW1tT+U6LCR3d7JTEbXy3s7NcxfCjQLE+740hs5Xj4JlYZM2NmcjJHFZ4B3vqTSDutKckAfvr9onGfZ1escf0rgx99xk2M9hOl6KVs3V1fATmZWwrvfHeAwmm5TDTw7tfsldbyDsUPMbS5DBiIfK8WZvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH2PR10CA0010.namprd10.prod.outlook.com (2603:10b6:610:4c::20)
 by SA1PR12MB9548.namprd12.prod.outlook.com (2603:10b6:806:458::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 07:23:48 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::6e) by CH2PR10CA0010.outlook.office365.com
 (2603:10b6:610:4c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 07:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 07:23:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 02:23:46 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 02:23:46 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, Marek Vasut
 <marex@denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] MAINTAINERS: Put together AMD/XILINX platforms to one
 fragment
Date: Thu, 13 Aug 2026 09:23:23 +0200
Message-ID: <7aa39a1a4f0394179b91efd6cc1c5d395b725f0f.1786605799.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786605799.git.michal.simek@amd.com>
References: <cover.1786605799.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3620; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=TDoo91IowPkkqTEXic2x7zuefnS5pVe1abKiDV944SI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTVFnzZM+/Y4rj602l35d+blBfK9wgtUqy4eVx2y9vXp
 bNYEj6HdJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBETP0YGe5nzz7s8Mskgsng
 0WMNY22GtT0HJ57bF9tuIPti+XLtNkdGhlPfv3+5Gnxyxzm+jv3v5qgwS3B7Mc8JdmprTJ2f4WG
 kxQIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SA1PR12MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c4fa9e-4079-40aa-e585-08def90bd10b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|13003099007|22082099003;
X-Microsoft-Antispam-Message-Info: IXkmoCf//vP/aXw57BdurSN7PuXKUpKX/wvwCujEFEB/SpfLzY2ATx9+Zz0OoWpLFfq1C5t+k8QS8vkz5hUCOGaFz7/qJY9b5mhxUt092cBDIE6KUMG/VqsRmuCF17qYfCQfxbCJ93zftzipLEUTL+JDLGFLSa/ENohBPdURmlzVA57+xMpO1FznCxyIgfi+/6F3+WGt7MgGK/2mLN3d7TUffyV4vbrlett1SRNHL3DNPlx95UB7BWYC2ccYkXTMDYvo9C7mPINbwoyxNJ2mQ4aVBMM96TUZfVqGzSluMUzu3B2e3OUUhMojqlNlGk9VyXUe6F8cRPSGtcdA1IO8pVITcTk5SwZzZRV4xljCdkmMBUlIJze7aMCM1svvfLjmiVY7rq4ozSYkG5wXYrNgGug5p6ZSIZwbkRrUX5aDuFEOMnKaTJTMooCG3VQtnq/bnvIKjFFyBTAt+mFkSvHhX8a99lzWdJyAZnxdQYgTub/1qcjkJy2ItcYRzxIo3nXJCSGx1pkWiXkMcqvtyod8C7lcwzq5826or9ZXyWmR28qxgjWywIeEJzAAGLKxl1DQI9hDa0SH2XuJmq48AzsUr3+WkWU6dwGxPpEJ4LgX5smq5Jdu7Bcw/ZOJcBWowBTM0g2DKvpbKp6lGwJxCbGsAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(13003099007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tlAi9L7hC01bOlTp+tPCuW07GmJFZAv5kaJtRE+me2w9lQu+bcR3QTO2E7GDfJPvh/CPDzDrDUqgtPf9tAqybTBgQC2DOTtyrq41fzi8y5JzojNAqI0Z8uA9MASj84n9qEnFjxxvSW4+4+RI9J7ry00wMgOyOF+MNI0DUtMk+lklPvJUbWh/EibfTvubhsRdR9ZTXKhXh5MR/EMVf32mPkGvOlgJJdETtZwhAuphnmOmahuZhF0UMffzRm9W4V6TDMuhBsfBZ+sgAN5eRjtTuMJSYWSZJSupUnnZ0UfAyNlCMYUBf7LIAp86qLb4lxKIx22AA6K6HCscijNyw1DN/htGKnJymM08HK3JaHZlcC3i+qgP8XIhH+gHfQwSZZM7UksCWeIQgCaODfY9UGsu4edyyZ1z5FfAQSjzymmKqYsaAUSdhE2lAfXgZVTT5dC4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:23:47.9804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c4fa9e-4079-40aa-e585-08def90bd10b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9548
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtrMY8/tFLqCtAcfGjuPO54NibdVc1/51TkMJUk8Aq8=;
 b=Ddun7taIUWPC8MlMKse81IY9iexAT7gtsAnG01X+CXCnwzxztM27FSE1CsCK5epLQqKshz6aKrSeDmHaBEY6ukfMooQvJgbSNoQev+WVluhOOjBSyYS5jpe2ZdZvsMJOmDHr78OVLBwP26UlFOBCV4RFrVdFknXOozQr4u1NVWI=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Ddun7taI
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Put together multiple SOCs fragment under the same umbrella to cover all
ARM based AMD/Xilinx platforms. Also use this oportunity to simplify
description and remove files are already covered by N:.
Also move N: xilinx from Microblaze because multiple files have been added
over years which belong to ARM SOCs instead of Microblaze.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 MAINTAINERS | 70 +++++++++++++++--------------------------------------
 1 file changed, 19 insertions(+), 51 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b07ab6656a9..e1171f4d01b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -181,6 +181,25 @@ F:	drivers/ddr/altera/
 F:	drivers/power/domain/altr-pmgr-agilex5.c
 F:	drivers/sysreset/sysreset_socfpga*
 
+ARM AMD/XILINX
+M:	Michal Simek <monstr@monstr.eu>
+M:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
+F:	doc/device-tree-bindings/video/syncoam,seps525.txt
+F:	drivers/gpio/gpio_slg7xl45106.c
+F:	drivers/i2c/i2c-cdns.c
+F:	drivers/i2c/muxes/pca954x.c
+F:	drivers/net/phy/ethernet_id.c
+F:	drivers/pwm/pwm-cadence-ttc.c
+F:	drivers/timer/cadence-ttc.c
+F:	drivers/video/seps525.c
+F:	drivers/watchdog/cdns_wdt.c
+N:	(?<!uni)versal
+N:	ultra96
+N:	zynq
+N:	xilinx
+
 ARM AMLOGIC SOC SUPPORT
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
@@ -802,31 +821,6 @@ F:	arch/arm/mach-uniphier/
 F:	configs/uniphier_*_defconfig
 N:	uniphier
 
-ARM VERSAL NET
-M:	Michal Simek <michal.simek@amd.com>
-S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
-F:	arch/arm/mach-versal-net/
-F:	drivers/soc/soc_xilinx_versal_net.c
-N:	(?<!uni)versal-net
-
-ARM VERSAL
-M:	Michal Simek <michal.simek@amd.com>
-S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
-F:	arch/arm/mach-versal/
-F:	drivers/net/xilinx_axi_mrmac.*
-F:	drivers/soc/soc_xilinx_versal.c
-F:	drivers/spi/cadence_ospi_versal.c
-F:	drivers/watchdog/xilinx_wwdt.c
-N:	(?<!uni)versal
-
-ARM VERSAL GEN 2
-M:	Michal Simek <michal.simek@amd.com>
-S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
-F:	arch/arm/mach-versal2/
-
 ARM VERSATILE EXPRESS DRIVERS
 M:	Liviu Dudau <liviu.dudau@foss.arm.com>
 S:	Maintained
@@ -834,31 +828,6 @@ T:	git git://github.com/ARM-software/u-boot.git
 F:	drivers/misc/vexpress_config.c
 N:	vexpress
 
-ARM ZYNQ and ZYNQMP
-M:	Michal Simek <monstr@monstr.eu>
-M:	Michal Simek <michal.simek@amd.com>
-S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
-F:	doc/board/xilinx/
-F:	doc/device-tree-bindings/video/syncoam,seps525.txt
-F:	drivers/gpio/gpio_slg7xl45106.c
-F:	drivers/i2c/i2c-cdns.c
-F:	drivers/i2c/muxes/pca954x.c
-F:	drivers/net/phy/ethernet_id.c
-F:	drivers/net/phy/xilinx_phy.c
-F:	drivers/pwm/pwm-cadence-ttc.c
-F:	drivers/timer/cadence-ttc.c
-F:	drivers/video/seps525.c
-F:	drivers/watchdog/cdns_wdt.c
-N:	ultra96
-N:	zynq
-
-ARM ZYNQMP R5
-M:	Michal Simek <michal.simek@amd.com>
-S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
-F:	arch/arm/mach-zynqmp-r5/
-
 ARM PHYTIUM
 M:	liuhao <liuhao@phytium.com.cn>
 M:	shuyiqi <shuyiqi@phytium.com.cn>
@@ -1285,7 +1254,6 @@ F:	drivers/spi/xilinx_spi.c
 F:	drivers/sysreset/sysreset_gpio.c
 F:	drivers/timer/xilinx-timer.c
 F:	drivers/watchdog/xilinx_tb_wdt.c
-N:	xilinx
 
 MIPS
 M:	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
-- 
2.43.0

