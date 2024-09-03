Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE24CD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 11:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0361C88BC6;
	Tue,  3 Sep 2024 13:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0l6NZI/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F152A88C53; Tue,  3 Sep 2024 13:52:48 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD64A88A0A
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 13:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcCyjBK0gM3+b9dDjKKik3YFiRU7MaJRo6OuUYG4CxbvQg64h9cOk8qDeTT1Ijkz1zS6QNhr/uq03rW+TSAz4+Ft5Dx8FpwTZJq3cQuUL5+hWC4KD8ZoNKKJQk83c5Ne2hgXCpvGRZr9hzVfwtSvwAqxHeBL6OumC+why3Kj0Blg+ICAwgeG9d5TccgkCmUTKxZhuNi13Roc/XSECed1TQUbiKvkDTCoyEsc0lJfcf924kkHPrYiTTX6m9ZIg79JAv6K88mWsGFbn1MXQnCX1FZjVXlWcZNRrMhfzwnOv9HgSjpnc0vEJiYoT66kmHZhkS9T2BKqhF3XHTUhVWeexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjPPOAkBuM0klSWyrFyGETCn3RHcEWe/cWTTh5FKMt8=;
 b=KareZs2I99VSJshWO1vJNECC1ojkMEDzI8qZfqaMIs/KNbzBhfGRF2K6BhZxCi20CTlr30xOxx4r/fyFqBubRd8bYFcuXMdejM3ZeZDtxjXN5bwLAKDI/iZm4pCCmn9PZK1arkOb6EN4958hwbSrvvwPR8vfoCyaTqSxLK4eq1E5S+Z+4XS4rrcHCgPTV0bf65zKMnpxXHgkqsMa5ouidxch4j3rpITuzVVrYHQpDm7X+8Y6SGijoAQLZaJdZ+5ZR6drNYbix9SM4pqp9XE4ktrdAqwCRARBAAY6MleNrm3abga4pKTI2s6+KRHlvnpVyXN/gehz2g749PfUOCdpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjPPOAkBuM0klSWyrFyGETCn3RHcEWe/cWTTh5FKMt8=;
 b=0l6NZI/amtSjw8xcjabkGwdCETEH0J3FIgaUFdFRUuURLdVyZRpLldSYnYFGG56g+mfO7fDFQe7xbltubooSiBxoD4hy7q8/ZA8cPVV++i9zWnPFR5LC84OqOKC5lkjBqjim5tda0TmoMZOq10sZGYEyp0rZzqspkwwZ6JSF9IA=
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 11:52:43 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::27) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12 via Frontend
 Transport; Tue, 3 Sep 2024 11:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 11:52:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:52:41 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 06:52:38 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH 2/2] arm64: zynqmp: Remove overlays and add new dtb entries
 for ZynqMP
Date: Tue, 3 Sep 2024 17:21:52 +0530
Message-ID: <20240903115152.430335-3-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903115152.430335-1-prasad.kummari@amd.com>
References: <20240903115152.430335-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: acf85073-4394-4d90-83ee-08dccc0eeb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NuNussfmQhCQIoEGPWb7Cb0NYNvY8V8VTejJYqy8THPkUA4AMWvDRcmQwaAx?=
 =?us-ascii?Q?tDb7cGTTdfS8UPK1RiDGOtTla/8Cu33ucLB2qFF07TkBMPaKSCYlXqIHtHwX?=
 =?us-ascii?Q?5kPokSn7VD8VZeL5BBri6vMRrYSEptAAD3EztLUyXuU1D+ZCZiiA6aixXtzC?=
 =?us-ascii?Q?8twNvAQ9C3kcVgMMvIj/ZpJELnoXcXCApCk4BHTQcfT6tWJWBJFFAWILICwD?=
 =?us-ascii?Q?cp7LOA7Ag7c/6E+EtFlLW5UoIog9xQSuSRiUa2LhenYPpS6Wmc3oHn2D9Zf2?=
 =?us-ascii?Q?/xUuZ4TB0tt8IcTUBfKoB+0jLImtlOlIkbHnArLw41GETPRbGLSVFwJAwZSq?=
 =?us-ascii?Q?j+Z9UPu67I/4PCygtMynmMFdjabvA7kx0Yvkrvku419XdNHorw5LwbpU1AQj?=
 =?us-ascii?Q?KuxmgnNL4Tnh5eSGt8pNkOVRCRUMSwco5o1GAEhdtrUmRoLZP49ARt94Sgry?=
 =?us-ascii?Q?s71KzUn8SwPxfU73J0McA7ac0SYkcoQGXT/09JJhW1GBNrD0Wp39EVnWvclM?=
 =?us-ascii?Q?/FwzAPTLu/ghpJI7EYbBCcDPk12XvNkhod+e9hP7D65OXt/UgNVFbgl4UKwD?=
 =?us-ascii?Q?5sN/qn3fjWkvtuazctyb9EW/NQK3pJfc6OMQF6w7CPSPlvOe5EXW2u6Odcdw?=
 =?us-ascii?Q?eAbtaLeBFXI2ztkvC89h+7j5zMdMM8+5RP8aaZd2SIvJ1AwbMJ+JajZWfed+?=
 =?us-ascii?Q?oM/fvf/tqA55X1D9fVUhG3WG1Pxi30Wqdwl4toiORYPdVbHq3gGuvZjZBwCe?=
 =?us-ascii?Q?ME8je3fIpK7oqxf0L+5IjmF3OcJMDuDOpmPt6SMkaW+ctxPHZVN0eYpxCmnr?=
 =?us-ascii?Q?EaReV6mfnWQbkWSrCYj6ULCHeaPs0EDu/aucleuxpYlvhVQxapFWP3JspL5P?=
 =?us-ascii?Q?FmcIpou9Q4CkloI3FZni6MLcuFJ0wD5RDJG00sHRfLMzlvVMZDEoPq2VNevB?=
 =?us-ascii?Q?bQcI6LlztJbYDIqCMQp/KsD4Bi5nV99uJRX/nWUSVb5VOqmc565A97audk5+?=
 =?us-ascii?Q?L9hTkfmo+/FM8omcHouDrdu3ybM7vscIXOxAPbWnPqrpgbaLwjf0K+5XM68l?=
 =?us-ascii?Q?FDqnD+0OHauoBLFjspii/E5Kvo43NIehFxThze+pjlVlCReRvHPzORygoMS0?=
 =?us-ascii?Q?2EWw4UriKdHXybiMB8xxBHaNMfv8AoI2JalksRfqq+W/Zpi4EH1WuueTu+tz?=
 =?us-ascii?Q?UV50i5bZJ+yRYRb4gVDUg9Hh2V8irwXBlDZsk2bzhhN/9ONO8Sm0uhulyWOs?=
 =?us-ascii?Q?cdRlRJaNX8cf6Gr9xj0vcYQ8aMK/NTrbUJcmwGjw8O4PF7AC5EYlEDZ9r4Jv?=
 =?us-ascii?Q?zohQyHJN7gOaYucNKIqkPjMq5UvWB9o5dBRwxQwzj3+h4AA26wNpNz4D8yLv?=
 =?us-ascii?Q?6BGK53DwIjEV8BTJmvG+f/imbBZudglULQCSmThnKLhOOIlptmukFZnyKvL5?=
 =?us-ascii?Q?Cjr/5KF8esJR+hAtZqAJWjKPy0Xgrt/E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 11:52:42.7433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf85073-4394-4d90-83ee-08dccc0eeb49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802
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

Remove device tree overlay (DTBO) entries for the ZynqMP target
from the Makefile. Add new device tree binaries (DTBs) for the
zynqmp-sm-k24-revA and zynqmp-smk-k24-revA configurations.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 arch/arm/dts/Makefile | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index c82fbeb1e1..9ed0c2487d 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -262,11 +262,6 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-m-a2197-02-revA.dtb		\
 	zynqmp-m-a2197-03-revA.dtb		\
 	zynqmp-p-a2197-00-revA.dtb		\
-	zynqmp-p-a2197-00-revA-x-prc-01-revA.dtbo	\
-	zynqmp-p-a2197-00-revA-x-prc-02-revA.dtbo	\
-	zynqmp-p-a2197-00-revA-x-prc-03-revA.dtbo	\
-	zynqmp-p-a2197-00-revA-x-prc-04-revA.dtbo	\
-	zynqmp-p-a2197-00-revA-x-prc-05-revA.dtbo	\
 	zynqmp-mini.dtb				\
 	zynqmp-mini-emmc0.dtb			\
 	zynqmp-mini-emmc1.dtb			\
@@ -281,22 +276,10 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-mini-qspi-x2-stacked.dtb		\
 	zynqmp-sc-revB.dtb			\
 	zynqmp-sc-revC.dtb			\
-	zynqmp-sc-vek280-revA.dtbo		\
-	zynqmp-sc-vek280-revB.dtbo		\
-	zynqmp-sc-vhk158-revA.dtbo		\
-	zynqmp-sc-vpk120-revB.dtbo		\
-	zynqmp-sc-vpk180-revA.dtbo		\
-	zynqmp-sc-vpk180-revB.dtbo		\
-	zynqmp-sc-vn-p-b2197-00-revA.dtbo	\
 	zynqmp-sm-k24-revA.dtb			\
 	zynqmp-smk-k24-revA.dtb			\
 	zynqmp-sm-k26-revA.dtb			\
 	zynqmp-smk-k26-revA.dtb			\
-	zynqmp-sck-kd-g-revA.dtbo		\
-	zynqmp-sck-kr-g-revA.dtbo		\
-	zynqmp-sck-kr-g-revB.dtbo		\
-	zynqmp-sck-kv-g-revA.dtbo		\
-	zynqmp-sck-kv-g-revB.dtbo		\
 	zynqmp-topic-miamimp-xilinx-xdp-v1r1.dtb	\
 	zynqmp-vpk120-revA.dtb			\
 	zynqmp-vp-x-a2785-00-revA.dtb		\
@@ -367,6 +350,8 @@ zynqmp-sm-k24-revA-sck-kd-g-revA-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kd-g-
 zynqmp-smk-k24-revA-sck-kd-g-revA-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kd-g-revA.dtbo
 zynqmp-sm-k24-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kv-g-revB.dtbo
 zynqmp-smk-k24-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+zynqmp-sm-k24-revA-sck-kr-g-revB-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kr-g-revB.dtbo
+zynqmp-smk-k24-revA-sck-kr-g-revB-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kr-g-revB.dtbo
 
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kv-g-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kv-g-revB.dtb
@@ -380,6 +365,8 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kd-g-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kd-g-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kv-g-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kr-g-revB.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kr-g-revB.dtb
 
 dtb-$(CONFIG_ARCH_VERSAL) += \
 	versal-mini.dtb \
-- 
2.25.1

