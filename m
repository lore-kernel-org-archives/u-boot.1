Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388C3EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D8686E40;
	Mon, 11 Sep 2023 16:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kAh1VmuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DDDD86E3E; Mon, 11 Sep 2023 16:11:17 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D573586E37
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWeg5kGnSKyj0E1XLsOolTz3jy5dT2U/Hg6sFEvn2WlilgXUlcuXhwxTpjdurKs1HqCVv++6aR38ycu4dr6qvcG6ORZ77jz0TMNeewpnEbolja2H+31BVYc00FlX27H4YoKgCVAmOkjE9JT1D2xGkX+sa3h29/IIALFX/uqU9Ks2ucna8XzZo/u6LPXbffQWqMFBwl34hWNNQcaGaXhsS5w3e8hkDkVSb8Nis1rDbGKHoxXC8N1YvpcH31eqBW2lwt9b1MuXab1dbr51eLgWF0S3lFlK5/R9fsg8qqJ5WFQi4o7mP8LHsajH+zRcNZcSDNFFCj9+GtmD1vcOD+sRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs9ObctRAQr+eUKL2Y0EEisTMjbneW/8XkiTbTrCoek=;
 b=ezYWar+SQAXeZUI/IWM8coBVfcbDkiXlcNH3Xh/GLTY4njBs2ZyU0PWQlcac48F4qYvQuAoNCj8Wjjoq1iOW65HHcf2F6ikaaHV4UEuNA3yDNrc9wSyCZWoVgcXLOReAnmAUYpw0pHFY92KfvlL9k5gxmeDuzf1LCJc+H4sJEwdszY7rD2NcJT5FH4V8EOJL4wRJDPLwtcoiTDqr3u7wicygt+lxKdnhnbFteEBgyDZKgk+mA9SsRoX1DSV/GF17OUwB/lPAZkXUwWW+7WM0iclgS2ATHSSx+2LPCu4YzUihJUR3+Iu6gcvdWg9SPnl0T69yXXqg0QT6XqYD0XM9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs9ObctRAQr+eUKL2Y0EEisTMjbneW/8XkiTbTrCoek=;
 b=kAh1VmuVXZ//XKZFynHPzkur5Ti6xy6gdXVypz4Ej3rTnu4+ZE+ro1rSQ7wYM8aB4HFhINqas9y9bTsOqpTi9yVLOtY1oR7+ixgSvBUV0buTwBnkx9Z1fwVO31VhrKF2GPMVF2eCYRICkOyyEDL6nHu9i1zdf/achQIPsawbIFM=
Received: from PH0PR07CA0110.namprd07.prod.outlook.com (2603:10b6:510:4::25)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 14:11:11 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::38) by PH0PR07CA0110.outlook.office365.com
 (2603:10b6:510:4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 14:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Mon, 11 Sep 2023 14:11:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 09:11:00 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Saeed Nowshadi <saeed.nowshadi@amd.com>
Subject: [PATCH 3/5] arm64: zynqmp: Fix i2c address for si570_user1 clock
Date: Mon, 11 Sep 2023 16:10:48 +0200
Message-ID: <6f31881b0e2dd657f0d4ff0869c009c2e1224f22.1694441445.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1694441445.git.michal.simek@amd.com>
References: <cover.1694441445.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=zfyQmL0e8iEr2jI9bL0R/XoolHv1YXg32VTUe24wGXs=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT/8i/edTw6/2N/3wanKotTj7KOG0zN2hQXraXDsmnTt
 a62i9tyO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEOpUZFvQ8Wqxp5/5i2YYZ
 qyX/XtlYZfU52ZNhwfQHU5L/brjmZL/5uuN0538fXDif3gUA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 810a34f8-b620-4f26-cc1b-08dbb2d0f365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RF8ZRdpPhVIoEXA7h2t4qjbD+eVxhLTUNZdJ0ZGsuoXwV6Fq18DadAzf1mvkntC5sJxIFc0CPawZqh8V/AGnyzV+hceuAomYHkD4P6lr+PFprCghf8HKzQr1yninkONRb1MAkaAiiulH+G6maltX5H/PQQdKPLHz0exITTp2nsETzH1drNXyLufeMEzgPeTngl931+PVgvKQDNQiCewkJcv5wFv4mtYA2FxPkZFmwYphrXUCLeARzeZTxXsrK4MxaHFNwJArkaiV7KK6ZiM4Fk8xV8kDXJzk+kE6Xir0lod4ScnhBpRvtzcBokFXHd1ALRHbz2QtsfY4qCtFlhxmfmAVjroGZ8PhTlv3+mXv8ewiBDx/41oRUz/hS9y/t/6nudQvucGoXBQOOpo8/8OZFwOiNkA7kRBziT4uVwjn91RN8ggP2rlObL6HrHW5u6qqU4jKQH6pohcGbm5n9Nv6KwNreGyfqeEp5fcCLnBAP6xs1A04g/gX90PDCYVNenl2WZI3O5ayt1h9tG1MnPQkjd4TiEAJBJ/LbrzCaqRA/n068R1i1D+YhSLZ68sUec6J2DqJtJ7RwnaTdjWfKlO5/VikcoKCsY3UgD2MSrjyzxg2VMigbXyzSIRfksvJFZggoIucXS1w4RRAtGGnyFWjk2suNtqRWFKWdri3mM99b8fuWlTmc94eB5pkChVZt/T6qTCtjfgoI9bywggzoPQrFouABkAgY+FVOqMAvjDQN3gORxaEzFQjvReBo8kaOowvScwGUDOsd13bDtrL2sSBWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(81166007)(356005)(6666004)(86362001)(36756003)(36860700001)(40480700001)(82740400003)(40460700003)(47076005)(2616005)(26005)(41300700001)(426003)(2906002)(4326008)(16526019)(336012)(83380400001)(478600001)(70206006)(110136005)(8676002)(70586007)(8936002)(5660300002)(44832011)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 14:11:10.8908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810a34f8-b620-4f26-cc1b-08dbb2d0f365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
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

From: Saeed Nowshadi <saeed.nowshadi@amd.com>

Correct the i2c address for si570 oscillator that generates the si570_user1
clock. i2c address was changed by commit b6a8c603d680 ("arm64: zynqmp: Fix
i2c addresses for vck190 SC") because address in node name wasn't aligned
with reg property. But actual 0x5f address is correct which is quite rare
because all other si570s are at 0x5d.

Signed-off-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-e-a2197-00-revA.dts | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
index bf6ffb778b6a..bf7569c6dda5 100644
--- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
@@ -2,7 +2,8 @@
 /*
  * dts file for Xilinx Versal a2197 RevA System Controller
  *
- * (C) Copyright 2019 - 2021, Xilinx, Inc.
+ * (C) Copyright 2019 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -460,10 +461,10 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <6>;
-			si570_user1: clock-generator@5d { /* u205 */
+			si570_user1: clock-generator@5f { /* u205 */
 				#clock-cells = <0>;
 				compatible = "silabs,si570";
-				reg = <0x5d>;
+				reg = <0x5f>;
 				temperature-stability = <50>;
 				factory-fout = <100000000>;
 				clock-frequency = <100000000>;
-- 
2.36.1

