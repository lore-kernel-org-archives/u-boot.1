Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842E1C9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E4383B23;
	Mon, 12 Jan 2026 14:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XltKN18K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CFA983CB9; Mon, 12 Jan 2026 10:38:43 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 274E683D7A
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqgaO3rs3Fj/StCgiKf0YU7nTpLZ06KRBFBTSfMMDxhVAjvNgscltuSDFc2af5ZYboA6gtEi+wMCZj4of9ar0Qc3Log+5DoTuVhozHl5molG/Pmh+MWqfoloZZZVJeXN+ZgiGl0kj0It7Tc5oRHidiZSm7APbu3vFZdzVecRoVSthaQ0E4A6FQ5frziXxsTIQUBhyKiiEW6zP4yO8ggqA5hixEFxFMDp1nguTLoUHfPJAQhDdZDfUwWWwHhD1TYa547uzuIttJwJpgYkYTTWh5vW9iZO4gPjB3TZ200eL7EuTYiUyG4HGtbVJFeirGSdQb6U8I9//bUq8oIGs7SrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cneR4JWCYwR4ycG/s3wJjwjB9Gig/1c7TJX8XSvvEM=;
 b=CBhPiuHxrf9/+sCVS32pHnU1S2qBl60Fn/1N6/c1FVCVcU0eJPosoBrm4mDk0gnybM/CYvQdDT+bBQW/8hEItw5Jnsi7bYv25eeDJe3A94jFnvmJA7PW8JUx56gT6nv2QID8niMJd7LeEoo7NxQxqCmms5gxXgCUPgy+HbGzGtsKYimuUStQgGYsTHvwxjWAFt2PMj/26xM0FigXt1wXgbAQNJNSBaOxTSiQbSrd8r4UtzmF26vfiz11wKraXEzgDfYjz/dGrR7hFaZHzzxaFAY10RWxcaS2gl2QvwtXSs6KeIZ2mZGXUDccSKrYM/BYq/QQv4ysi74+iqr/VlfljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cneR4JWCYwR4ycG/s3wJjwjB9Gig/1c7TJX8XSvvEM=;
 b=XltKN18KkoPBnZ1RjiEno2pW54WKxserf7onYbwWauPzoxyai3xE9LknKObHGmQF79lENxxoCMIPHpP+7XR5zd4jG23nWZv9+ChbW71cUyQcGo74FRIGKaojippxB4s9JNOkOon43rvDIf/tR8hKbCQLrsGnlJM2KIW5heTx2aA=
Received: from PH8PR02CA0012.namprd02.prod.outlook.com (2603:10b6:510:2d0::24)
 by SJ0PR10MB6374.namprd10.prod.outlook.com (2603:10b6:a03:47f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:38:38 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::14) by PH8PR02CA0012.outlook.office365.com
 (2603:10b6:510:2d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:38:36 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:36 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:36 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 03:38:36 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C9cY1e278800;
 Mon, 12 Jan 2026 03:38:35 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH 5/5] arm: dts: k3-am64x-binman: Configure firewall for
 ATF/OPTEE
Date: Mon, 12 Jan 2026 15:06:43 +0530
Message-ID: <20260112093643.885903-6-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112093643.885903-1-s-joshi@ti.com>
References: <20260112093643.885903-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SJ0PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6fd85f-9e18-4128-8e0e-08de51be5c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WiNC7wkpcgg9DObP3BQ3Oq1v6ZiCTl2NRKWqZEZyh0yzawPwBtNNQIHcA0mE?=
 =?us-ascii?Q?udoXbdsS6MZVlbMcFfOsvLfun7t+reAkIjUhxTroZubwo0fFhncJievZ3lcL?=
 =?us-ascii?Q?L1ZD9ONVuZzYwRciWAtfx114LPoy+1WG3Hs0+ZO/ba/aYfDUXvEKkD6mR8hI?=
 =?us-ascii?Q?QzXNldGxlzZv8Djh7a/LKvArrQxpAreK/Pm9wC3bKHaV9ogxsvenqrXv0KjG?=
 =?us-ascii?Q?Zj/SIbC+Q3zj+KbYgmkj2NPHEYTgSTONX3f5tJeX7I/TSjgXAxWLP70s6dyo?=
 =?us-ascii?Q?xjrR5EGkLAYQE6/xr5RNm9a2zqHTh/biUsm1WUSdFgsXhqNPuK4JfZA/X1OE?=
 =?us-ascii?Q?9hTUClBqLGM4lj7CWPdoH9weROepHaNc6hX2DWDUlnsDSHpRmr+EGoKUMUHl?=
 =?us-ascii?Q?zphkdft4oVlUO6knxm6hBC8YrXCN1HqSQs1mvuFkxwFxd6KgZhqbd4LolGNE?=
 =?us-ascii?Q?/9l+eRa4cwgxJaYX7tmwSf3d/jjwhQjeXGBxy4BGkC/0baTHT0Q0tsCGl0VG?=
 =?us-ascii?Q?j/Z4IXujQBSoUof1IrH5l9OhXplKZaqFlU9v95CGihejc38la0IYPHyMULsP?=
 =?us-ascii?Q?XKHZfZLK+w1gkkmITjhsJG//ALI2aMzG6MQ8ezgcMv9a5Z+6TkVWxK6OePsT?=
 =?us-ascii?Q?X9pMo+drL9AjATrYBreujbAUjpaomS50DbQREgx4em2Dqaaxm3HIbhOCnNRw?=
 =?us-ascii?Q?BjdEJRyYjc8OyzgU/26qQvmt1tWTS3q6E4t+n3chM5DFUR22Yp4H8Ogo4qDo?=
 =?us-ascii?Q?9RI8/KWZvoM+W2deFiiqjRLBy3M8fF/bAp3ntNpokjDZevZPk+r029YvoZSG?=
 =?us-ascii?Q?3RoNT9er5jZEoBqOPIU5zbwfG1VIHX5CfEnslga82VLRRCztRtMK/rFDbbNP?=
 =?us-ascii?Q?0TTPzf5yEbxatp3hgimBjA7D6FA1p0PprCFoz/hDLW9V3v3bVIPTruBItkn1?=
 =?us-ascii?Q?v8CSlVCjSTAi8oKds/CRCtaLqGR0gunaYOB8RMW1PjEyXKIrQdqNt6uytgsL?=
 =?us-ascii?Q?Axy5wKf+LjpY6tv+E9QdtJeg4p2fFp0YkbccjrWx+uw3hHwTjP3+LFdc2b7b?=
 =?us-ascii?Q?Sr74p9AgZDqwDt3upLuaiDcOH/0vqLPmXsRqkTkzD5gd+FcWPkXOK3W0Yh4R?=
 =?us-ascii?Q?bG99YgMIVs5O0E7oXWTjseG1JMmcnqACemzxIzdR4ZPirZpigA4GPofZc67v?=
 =?us-ascii?Q?a5c1tHBGGWqLqGFJH0vEI7OyI+gmSq2oAiNLHakLWToeN87XSQjpA34QpGOP?=
 =?us-ascii?Q?Fx75NijHNEO6qV/k6R9B7YxMFfAeSG9VyRynsNRWEUhLfk1NGC7o67bj2VWj?=
 =?us-ascii?Q?Fu2oB2CuGjEL3+tv+lByciuxKjkKqyiT/k2e1ZH6VlbGr5w4CP+k88x/mLUJ?=
 =?us-ascii?Q?ZaY7BUgnqo+TIzhrCzJ4Dk6K9Om6yDdKhL+5b8fmbYBKyAhXZb5DZJZUTp6I?=
 =?us-ascii?Q?baMwAx6r+WrFer2aauZgLjy2edSqFLVyBjN65zLu9lIM2SUO9gS3BZgAcRhb?=
 =?us-ascii?Q?+hOKRx/U9/XcOeVyU50zp2Eq2p2s22ICRyTujOMxOEYlj5r9DHoCsJfBgdI9?=
 =?us-ascii?Q?iS0IWjv/0z7If25Ezew=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:38:36.6218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6fd85f-9e18-4128-8e0e-08de51be5c4a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6374
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

Add firewall configurations to protect ATF and OP-TEE memory regions
from non-secure reads and writes in AM64x.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am64x-binman.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/dts/k3-am64x-binman.dtsi b/arch/arm/dts/k3-am64x-binman.dtsi
index 32e47a3f688..f3c7f2c939d 100644
--- a/arch/arm/dts/k3-am64x-binman.dtsi
+++ b/arch/arm/dts/k3-am64x-binman.dtsi
@@ -139,6 +139,37 @@
 			#address-cells = <1>;
 
 			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-24-5 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <24>;
+							region = <5>;
+						};
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+
+
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <1>;
+						};
+					};
+				};
+
 				dm {
 					blob-ext {
 						filename = "/dev/null";
-- 
2.34.1

