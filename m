Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763CBCF649D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 11:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A767888E07;
	Mon, 30 Sep 2024 13:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J330WDZj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6776A88E12; Mon, 30 Sep 2024 13:05:40 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B5D8843A
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 13:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpUOd+HXnm6bYb0JTFywo0WTB0pf3qwcEQbUX5a2oyxjGf6OOEmjSl2JKLVi9FbiUWQRE1vhF8tN6dBaIP4jzuDl49MMeHwD0+eXqEB9ZmHEGJltAfofJHF8NaKZGjwDTAPFkYegH6zxNA6mf8y5u99LWzqcuV0YKMYsJLDe2FMIguNNfbKwqu4E/wk/jh+S6aQwL/5MnmY0dPtlgu4TZKB25hne12x/PBC39X1mpC7d8CaZ+2WpCk6nfho91UA+a9q1388VAH+iRcxY/0I9Pkyhl/WZJ3JDMtflFcZnAmTeAftrM+EQs3BQlxhs6nL7WcNaQmJR6h3c72RWj3mUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyCnd81QCDxOFpqotxal7VpPAz5bSx5s4oLwbacBTCw=;
 b=OJMaxbUBwvmbX5N1FiSkvxG3eiP+ASgxiOhRyZMn9LpK51LT2zbQXmF5sd6pc4brRQz34UL71ZjvirIoKujYJE5RpzPqVOKHatxxfw+7lZym+E+4YS66WdhJ4ce93VrnDMRqMd6fPkqcBHdzlP94Kk9Fl7QpugE5XoNCDyzK933lwiOzmAj5g/p9wDNMdyuGY/iEed7uu37D1aKMUV1NhqTUI8N1k5pe8wQ9BYieA4+OZpUyy+yzemQaVbYV7Rd2Lr2pe7kPpwxFp7nGbGRr2appUZbQakapLWEIty66PJIAH31UwwhxNoNWe8MHYMnieqq9zrOwbDIloKAcg6O1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyCnd81QCDxOFpqotxal7VpPAz5bSx5s4oLwbacBTCw=;
 b=J330WDZjiPS5F1cFjGJRHA0wg8qE7JGiQPHs1VxwEA+PvuAJXEE43D5/dm0g9fmzTHOZyxv3vj7qg9xfGvaMrfx4X3xp9U6v20BQ0+dqtV47+MTdB7TUEAWkTRq7f4RVaLWIH2oD05BkSSToF9LkQb6P0pIjVJQ32sC0Uybe31U=
Received: from BN0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:e5::7)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 11:05:33 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::c9) by BN0PR02CA0032.outlook.office365.com
 (2603:10b6:408:e5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 11:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 11:05:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 06:04:14 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 1/2] arm64: versal: Remove description for USB1
Date: Mon, 30 Sep 2024 13:03:52 +0200
Message-ID: <f148161ee489d19d708df1b4fa7477821e06bb55.1727694230.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=3PoNCrydrSWYjBToTFICVCRde/HmfWR+ujSR8YUGkuI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRfrTPW1sbqeYQzOhTmOR57k8wwd6ZChrfhK5NpWys1r
 qzU5TvSEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACayK4Fhvl+zzo7NKcHX5kSt
 KYzJOOg+xSDRlGGe/tKZZrE3IiS/zo/pXzvl4qMJi0oPAAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: b5857052-38e1-44bb-73a4-08dce13fce1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dZ0SgQKM4ZzgNqboAB26wmDA9l5WDYMjHxrKIozzcEq/c26q7VpntS6rUds/?=
 =?us-ascii?Q?EtHsKhi3OOR/Efrx5VYHm8wvDjb+9RtHeFZzgTnsatd7B9S4tofKuZeef6XP?=
 =?us-ascii?Q?++xLW6iE/YGFHHFDHgns6f99ijUMcM4GpC2iWE0teZr6XSFTWFm0KwRzDpM+?=
 =?us-ascii?Q?MUPxEBIJIR5+BQSHI8tHsH7h2T+sCV/wqkb2XperkFrlIF4hagIHTUclj++v?=
 =?us-ascii?Q?avBpBMFOawSo9xUy4W47Jht5cf84GW8dfF8N2Dm+hVtqxqU9IXlz9cwMTEyf?=
 =?us-ascii?Q?a/ogU9vGn2KTlH0kGtwP7yWUhKivtG6cDR+jYpPeYO4zQ9x/aCfuhiM1fwxl?=
 =?us-ascii?Q?vtsJSj5d4inmJsJBlwHOVG4xW75coK3guU/3C3Hk+QfvkdIh2Swi1WylYUFg?=
 =?us-ascii?Q?H+YoM/aekSRXGoAX1PRk2nqXslusyQV/8RYBmuKuxjd7HyQhYAIdzzQIAsC9?=
 =?us-ascii?Q?RrS3Sm0NbHacuUGdHvvU4FIAgsERsFqmiMP8oSVPsPKBjw1hNm8prhzjfoVB?=
 =?us-ascii?Q?lgd2OQIvqDyD+SCqlEu+z+zwMLWJ4zIifr5m1sXiN4K544iQMV+rVdedmNIs?=
 =?us-ascii?Q?wum+PNR27Feub45kB6BMTtTKbO89XwuxJIArS+Ten9J8PO6sArdTpHZ6I63a?=
 =?us-ascii?Q?EBOdhiYxISM7bgPGJ/4fGYSQvoQ51m2MUu6JbJ5zHzlmdpSuIu9Z8VeR7jAj?=
 =?us-ascii?Q?f6Y857ZgbwPQ/RVNkrodm7Te4B0o4xifxA07M6lnvyoxODp6vKJa+tWQ9LP4?=
 =?us-ascii?Q?rzaG8psI2N/sNjt9ruLfReXjLLayoMXcvD6ele0zuzUQ+EeNycR/dX/3D6Py?=
 =?us-ascii?Q?FxBRTy4+Xcavol+OJNkDNlXaAMiXnDxJMH8Ps7Pn8CY37sMJhkeAwS7RXKnC?=
 =?us-ascii?Q?BVhQPoqqQMk0/TX2phiV9v1wKzd+zJhfkZoFKCJaJhnIdYKmOC8ZwNoMyMaS?=
 =?us-ascii?Q?GOKP4jW/Ux7UQjTpYW7H+MlhVAwRiUaPCRgXpyLQFxPjnnAYyuX/qIcjZNlg?=
 =?us-ascii?Q?8DxalLUtAiT7n6kGyeRcxsdHm5O21zkNrd8eLVsLhI5nAxLBOl+SdFhnxIwZ?=
 =?us-ascii?Q?cBtuExaCoexEFXMzi5vXu0npWIhPgVkB6BfT4DlZorYl6cI5hR6CQVTQJxga?=
 =?us-ascii?Q?x0ELzZ04QFmRc1ykBThDD4fxn/GVAgDM+BCZQTFYnROgZ0QWJhoMyU+dxPBE?=
 =?us-ascii?Q?7dLLjR2yOYx283qJKW9TUEo8eV4Q1a6tHS4GtT8IsygWAELnFplqLfzVAmO0?=
 =?us-ascii?Q?30Fl768c2W7zNaQA5iGNxk4i3j6+LJ/xXdb2VYS/qZy8Dx91/x2YTjie/4W2?=
 =?us-ascii?Q?5UMPdkW1JP/TryXKc5IceDyseIIfIaNbn9ZxRHMs84SpueR6elMxtuzkJqhD?=
 =?us-ascii?Q?QRxFP7glHpzvBAvb0ykOsONX3jE1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 11:05:33.5405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5857052-38e1-44bb-73a4-08dce13fce1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
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

There is only one USB controller that's why remove description for USB1.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/configs/xilinx_versal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/xilinx_versal.h b/include/configs/xilinx_versal.h
index dc3f41b94a29..212dc9df2a2e 100644
--- a/include/configs/xilinx_versal.h
+++ b/include/configs/xilinx_versal.h
@@ -85,7 +85,7 @@
 	"jtag "
 
 #define BOOT_TARGET_DEVICES_USB_DFU(func) \
-	func(USB_DFU, usb_dfu, 0) func(USB_DFU, usb_dfu, 1)
+	func(USB_DFU, usb_dfu, 0)
 
 #define BOOTENV_DEV_USB_DFU(devtypeu, devtypel, instance) \
 	"bootcmd_" #devtypel #instance "=setenv dfu_alt_info boot.scr ram " \
@@ -99,7 +99,7 @@
 	""
 
 #define BOOT_TARGET_DEVICES_USB_THOR(func) \
-	func(USB_THOR, usb_thor, 0) func(USB_THOR, usb_thor, 1)
+	func(USB_THOR, usb_thor, 0)
 
 #define BOOTENV_DEV_USB_THOR(devtypeu, devtypel, instance) \
 	"bootcmd_" #devtypel #instance "=setenv dfu_alt_info boot.scr ram " \
-- 
2.43.0

