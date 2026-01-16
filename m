Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8F4D47CCD
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24227838BB;
	Fri, 16 Jan 2026 11:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R0YoUriq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679B08389A; Fri, 16 Jan 2026 11:30:42 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4830A830E4
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qxost5hOGErn3tnYnylWq0xX+2lP6QwTJvzlTqdlS+d2oAp8FA0CeVkC7KFb69a5UB0T+Ph38IWdYEi4vn4njwxy+7BIY860N0zg/v8NX37tmT8FwgIzoLw4/TJNg0fQd+1GjF/0GEtpUUDjq35a5EOdl9Z3WtyJFOqYr7OeO/iE8l71FHAvzc+MhXiWvL1QuN5aV1Xo+CiX1anJtAO+0zbW4P9Ih7gXGswuatMf228rH0/Px2ik7NGryOmGjO37zPTm6vtiyGKOn2VXb55wqlE/epynvNCdL+Kiut2YnfqEB/ESGa7FrSpRN54a6+giKKvTayiPoBz0u7ijn7Tbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXFl9oeerj+b/Iob3XMc5/k9dW4vdKDCkvjw+rMeeaE=;
 b=G7SNJIKpZvfWeq0YG7l6oGQNJq7iKe05lRD7WXqlU2PqKB6c6PraxSBSyVbPGMxxhJADnf8nbOjQ0ijCLsktBek7Y91YWdtTDZZItp14j6KHUqcLAU2vZxCGOxEFW9VdkjdEvVbIq8M2Lt5h3lB3D5r1l/JeHOkMXEATLA050qbu+EMg0enZxt4S0a4i+UApQMdHFCrlIxTBu73VP9kO4ZMk9qXRAXDgcqyBuSn4H2a2jXwExs6TEdP+uev4m+i+LdqYhHk6nBY2CL5ZAdu9wgfS6ZDhb+gG3s8DW/3svAas/2fC8ffvf+BaLWGHu/FA3Gm1Y/xznUTyhGAgHBfFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXFl9oeerj+b/Iob3XMc5/k9dW4vdKDCkvjw+rMeeaE=;
 b=R0YoUriq2cgbbK3GblnczEuzXTitxWkqrWvaqjn+cpJ0tb9hw/AYPeTeci3CtTW4kct8zP+GQJZ6eweeiHMGQmmTqXb4PjP6YT7ARFHg2Eld7Oq983joXLXxRRBKk7qUhuQZ9m1E9W/zNh6MzE1IjuiC7+2fXFYrdy5THgYicaM=
Received: from CYXPR02CA0086.namprd02.prod.outlook.com (2603:10b6:930:ce::23)
 by SJ0PR10MB4461.namprd10.prod.outlook.com (2603:10b6:a03:2d8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 10:30:37 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::b7) by CYXPR02CA0086.outlook.office365.com
 (2603:10b6:930:ce::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 10:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 10:30:36 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:30:36 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:30:35 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 04:30:36 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GAUYON3004384;
 Fri, 16 Jan 2026 04:30:35 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <khasim@ti.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <t-pratham@ti.com>, <nm@ti.com>,
 <v-singh1@ti.com>
Subject: [PATCH 2/3] arm: dts: k3-am62a-sk-binman: Add labels to tiboot3
 binary nodes
Date: Fri, 16 Jan 2026 16:00:09 +0530
Message-ID: <20260116103010.3947922-3-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116103010.3947922-1-p-bhagat@ti.com>
References: <20260116103010.3947922-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ0PR10MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3522c532-841a-4638-5521-08de54ea49a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|34020700016|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q4ndOZB+UDgkYiO0J5qsSjL7WWLXDC0mT7qHkiPgy6vjb2qnnQ8AObirW/SV?=
 =?us-ascii?Q?s+vEFqnKbreyVkGxXbH//T7M961RdG7t+RRzyLihjAon1/lSaiA78bu4WECi?=
 =?us-ascii?Q?8VSVo76vGGUEIJ2S6JZupUL7qOP0JJOBodL4TAsc6lLUobaBaRO5rqk+2PsU?=
 =?us-ascii?Q?HP8YKb5j7HvFws9crEd9eppjEJ6uW+rFLobdNCpXl74lvZeS4ZWd/i+QsH7K?=
 =?us-ascii?Q?MMjSYP7BMDSybfnZOiaFDaXogJEPzw3zylalxRZv6V++C+IqKWvsXPOyGd6G?=
 =?us-ascii?Q?GjkJ6pdcMjLvB+5dkFPb6TvHcyBkyS0AXW7/MmnYY/TB7zcTx3aAxaMDDHac?=
 =?us-ascii?Q?4iiXJLOEWi9ApOGuOxbKtxP3aRKu6hNbjsNp6OG1dAr6/8swOQUNPDCyCl34?=
 =?us-ascii?Q?Wkv0a+sU8lDNY7no6CX97OfUy8ohXLUG4MrhjKBQn1j4Btd/8hQVx1o21T4P?=
 =?us-ascii?Q?8COJOOXRwb+Nj3WtBxvC85XfUAdUUiiCltOfEgiPm6c9dydsI3SkHWWdBlja?=
 =?us-ascii?Q?Z1Oe5vY0uUSfSDO0rhDJB5xjELpiSqkh+P4RmtUN+F9CDa4sr9DFXjjQ3XFM?=
 =?us-ascii?Q?UR3yf4dy8yLdn89dAX6hG3iFy45etWCZJmrEFzSJvfz96PlHezUYgk4JOOxt?=
 =?us-ascii?Q?e1bin5O/JbTY66spFmoWRwAplJjJYGVURaOBW8WBiNYs9Tw7WKQdCX0FOh/I?=
 =?us-ascii?Q?2z/aCbh21XsVHf2S2TFBxhXwhuCX7XDtDYHOe+2GyEfWJGad2tKQHpgsVQEy?=
 =?us-ascii?Q?Hbb4oixnaPkwL8U4RFlWU9/3Q5O55UjixQcOwISv6Y6m9UJAH864LTn1ctaB?=
 =?us-ascii?Q?Yj9yGAoHLIbt84zdgzvDV1GsFRlegiT5z+G6aHUlIt5HYpKaFWOHRbnUX7Lk?=
 =?us-ascii?Q?LhuHlX6VRuhv16EnGgFvi5czC0YPpONnbYP3iJIyBgm0Z16AX7F87v310zE3?=
 =?us-ascii?Q?q4PU0g1d/hfi/tQlh+7kKmZZ43AOHCXzUI5yf5kObF1EsjgxMpZ0f6n8k0bd?=
 =?us-ascii?Q?GwSMkbKx1CMFmVb6D9JsmW428NtLdxGHWgimX1a2GFepyjUss1QyfInNw414?=
 =?us-ascii?Q?CyPFywCslcAN9OI5zwKaI4ZiTuMvv//WgAUfBg9/uLUpSao/4fOUSxo72ETI?=
 =?us-ascii?Q?bJXguoWRqrSHgXkcmpKBLeVHJA15XAlJSRUbEbzw+qxUuQ5SceuJBgICUYzd?=
 =?us-ascii?Q?19yv4gvh6OorKrOJHugeiQ+zlF3oIXfcVl78SdwashRBIbs45r/fJU/SUpaY?=
 =?us-ascii?Q?/adsmZenSToXE7cxLhY3MyOZTUrmdFBZDE1tTIw+I7PfMU2YLg1XBb4k6hXx?=
 =?us-ascii?Q?udYmQrs+dkiwB+pX21FqShTN/1joe1wGUii1DcdNpVJjHvuBacc6JagTuZIi?=
 =?us-ascii?Q?E7CIdmyrdboMUxp64OeBXWsoyv/UZb6f+v3vI8bSn4m3MTwnUbVKJ+c+OsLb?=
 =?us-ascii?Q?w4JjynjXsot9+VKx3E5gE7Y5icv2Ov6JEBwLFnii+bWO2eUHoy/sdIoTkvTs?=
 =?us-ascii?Q?sm8ikLJoJiMUkCYeav1XJ2MBs+CkgiK+AdjVa/us8SuQiQg25ORZnRAzZb02?=
 =?us-ascii?Q?61owWZMT2C55emIerbgpNthOTBssuWYQ/A9z8TNFiaxA6p1gPRoVq6tUPy5U?=
 =?us-ascii?Q?eKx3lf9YD9XcNlvbLUauTvxbGb5dPa9rPBiJNQvQ2gpY?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(34020700016)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:30:36.7016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3522c532-841a-4638-5521-08de54ea49a6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4461
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

Add labels tiboot3_am62ax_hs_evm and tiboot3_am62ax_hs_fs_evm to the
tiboot3.bin binary to enable referencing from AM62d binman dtsi.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/dts/k3-am62a-sk-binman.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index cb9a56b8c37..78342e70fc1 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -12,7 +12,7 @@
 };
 
 &binman {
-	tiboot3-am62ax-hs-evm.bin {
+	tiboot3_am62ax_hs_evm: tiboot3-am62ax-hs-evm.bin {
 		filename = "tiboot3-am62ax-hs-evm.bin";
 		ti-secure-rom {
 			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
@@ -55,7 +55,7 @@
 };
 
 &binman {
-	tiboot3-am62ax-hs-fs-evm.bin {
+	tiboot3_am62ax_hs_fs_evm: tiboot3-am62ax-hs-fs-evm.bin {
 		filename = "tiboot3-am62ax-hs-fs-evm.bin";
 		symlink = "tiboot3.bin";
 		ti-secure-rom {
-- 
2.34.1

