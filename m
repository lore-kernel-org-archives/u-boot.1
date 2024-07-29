Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCA8C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C4BB87F51;
	Mon, 29 Jul 2024 10:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l3ttF+tT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7600387F51; Mon, 29 Jul 2024 10:18:30 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F91487702
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buAwZZi0uAmTzKOmyZLAx01nTaPAit94r3JtSDcb8k8u8r3zyLR9Dky3yjs2IpfZgARaTGsnSe6hMNaZCvAFQ2+d759wOWJ3tGDUaMcBbsnd3n1pQuI4iNfck8V4NOv3YIIxoxD1xJdJ7eaOfahZIlr5EGpX3Flt4EmNHrR8Ovc6FB0Ehy8ObKnnzfub2JkTMnoXOCah0X91leHpQYXZuVp55hiEe6ANN1T7nd3j/mrHPGyDVSbKQtKf80FD/jGu0Tah9bXhqstuR+lD3As2TCEw9bX0EWPptopSzZPJs4rvbYYDgWjzab4+mzjCI7aooZm3oZdBYzz/eZbB9++O9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mSSu3fKoLJBZIssix3L3bff6H4gH/TDoQU5Rc/9e28=;
 b=YT/T41NUbT9F49y68hsrcd4/1jYnNh3FYrJEwNjH+knQ2GTmL6nBX4qH0Bldm5S/gbaAsI6gtrK5lcfjuFmcS+IQUzAKLR6p9Kqw9YChEOJcIQBaNbazraVinxHebAf5+4ahmOspoCTMbnwhQtrqVUSLx9BCOJtRn2k58+HVkzJEpv4hpisPCoyWMytSPnVwhSh4wuqNSel3iIV/RBG9uKSCY4J/6AFtSVyEUYYu28+imOa+FfQ6Os+0cUTpG4zQKXtaDs8pq7kGwBYM2FIXJuiGrYnmwXQWJp+htr8+4cJmDSsKfJibioBvhsLMvrV2eReLQcRH7Bk1HxBaL1dW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mSSu3fKoLJBZIssix3L3bff6H4gH/TDoQU5Rc/9e28=;
 b=l3ttF+tT4TFvXRPD6kh9+C3jTLvtBPn692yWvBKU0LEwCwNJ6eUEvIiPJIvFZ22PfTEftIsgBNhxSq6ESL6B2m0h+42JhwMrdUq24w3hXZTvtO8rNIzh8oOOLWYfm8mR/IA6AyDrOFxbF5D3xFJyoYFLPL3cGJN+/scekhwGRiU=
Received: from BL1PR13CA0210.namprd13.prod.outlook.com (2603:10b6:208:2be::35)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 08:18:25 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:2be:cafe::42) by BL1PR13CA0210.outlook.office365.com
 (2603:10b6:208:2be::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.17 via Frontend
 Transport; Mon, 29 Jul 2024 08:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.11 via Frontend Transport; Mon, 29 Jul 2024 08:18:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 03:18:23 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Vishal Patel <vishal.patel@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Fix pwm-fan polarity
Date: Mon, 29 Jul 2024 10:18:18 +0200
Message-ID: <4658ae8576882f5d28ad57ca74a7b798a546ec37.1722241096.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/hxmtsTQI8MnZtaUsVLMLgS+kpLM9GP78lgo7zRCKkY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTlAd7xkvaRDOUnTMOmLjx3M+tEwM+7AovLZjrzJ1x70
 3reS7uzI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwkPJFhfoDDD5Pat9Oy1zg0
 3NV8fPWdo+yyXIZZTCd4t22496XK/UD3gV9uDcIVf//OBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f2bd5d-185a-4688-3867-08dcafa7045f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ccDf+EWqoOpxc1HkvaslACyhrwGUhYv5Xh1NHpvIzdbU+ci2+tt1YCy5WspA?=
 =?us-ascii?Q?8j96XYBrRU6FgCmcEFV4F+q675dMo/I75b6bFtvKsLGnKLePWqVKzQGXwv6Y?=
 =?us-ascii?Q?YndX8i+6m7Z+wzzCr2l9e9ZwzyaiTvdAbiWyatYIsGhFt4i8lcMlbmMugyTY?=
 =?us-ascii?Q?v8oxdjnSlfdx3Uxtxot92DfiWiDCLQ7Ox+HwBNx6G8bO64FUasVAbNXHbZHD?=
 =?us-ascii?Q?c9dm10X2SCLqZarK5RBfmiGkVZjAAY0Z5Z811CxO0Q5Ox0lHgi6xu/tHYqy+?=
 =?us-ascii?Q?wCuToKHw6qnbeDvEEoy8N8tdvSBN9eUQrTFOQG6mvLSvKAVJ8SnyCA7yFmu2?=
 =?us-ascii?Q?nZuqB+/HzkZnpIpfdS4GtCKDO8fdpUU2bgj6a9+NZ18tGqShLl+WZDpi3SGE?=
 =?us-ascii?Q?ajyURhk4eYsKY5CRngxOOi9VWUP7AGYgmBk+Xtoce7kqGY9qpxOPEofW28PK?=
 =?us-ascii?Q?CM/A2XXO3E7Jy5VaaFkxCimTC2dCDdWX0Xcwr3IqpqMWYX4GOsLT84FmKyP/?=
 =?us-ascii?Q?88/DCq39l/qlwEBsJsvGGcuMvq5m4MbJCqgqDZ1HoOdr979DkJQ3RfBAD58e?=
 =?us-ascii?Q?nkUJc19KIDjO7OJFXm0TXoK+NdNsZo4P/BhW5o6nfmNYuyDzm31ANWFhq/Uq?=
 =?us-ascii?Q?7qcWn47Bpp3YxUlX+i9wtU+PGDViwX07r5I5sNfkwLaIGHwu01frB+3RcBU9?=
 =?us-ascii?Q?clSCSSUOmLjH3i829kD3mdd4jfukSZE/fHyu/SICQEXUupp76xvLXuKViRiP?=
 =?us-ascii?Q?/nXPWKHw9wVjv+UA1Ii/4+2lnIGgjGwPjSno/gaTNusfNhk2sq4Q+gicof+a?=
 =?us-ascii?Q?swKCWCEm9h1kdHiSZSH3jM0DBvqMD7V0FAyBP9Ko3OnIgdNMspx772UzAZhO?=
 =?us-ascii?Q?v/qo9rBrkxrhlMmiHtzMgKZxSiZBlcq3mEFDlRZruDh9Bamt16M2O0I61yR4?=
 =?us-ascii?Q?QTjP7L9AT6kgNKyg9SDa7/intXy0sonXDuI1uQRPWaWW4mMGj5+iCDR1PkIm?=
 =?us-ascii?Q?vtGH3eSAyD8hA4LuxkEBCnIxfVvwf2W06UWy7cDrpVLzt8ZqH8vd+W+kjUr+?=
 =?us-ascii?Q?KaFmtsLY+d8jD2KEDqKljPvbecBExw/obTkeQ2+N1hZoXOj+0gftud93o6gm?=
 =?us-ascii?Q?XF16LfXwA5aZgF4Ph667iMzywPdyMep6nAsNBoPyEGsVzERJfXW6428Vw9yb?=
 =?us-ascii?Q?EF6BfGwNkl9EkI5zMpSjzGvO7APV0qkfwTMfAaTEB7XND9U43nCagHOUcLDH?=
 =?us-ascii?Q?MH2lO9bBq8WHgd47BbsrbiwIb2BNMDHgIE4hJBZ5iWnq2GSvtSyjo1OwMb7m?=
 =?us-ascii?Q?gjdqnrs2+4wJqVBswYhxyhESwK0jSjBaMTHkgXJOhejDbUZg1pmjcDbNpSDo?=
 =?us-ascii?Q?z48jPe7K19diiGcXMMegA0xuYHA6Ly2NZCWOypgYF1M6FiJ4bHn8/1MVHbkb?=
 =?us-ascii?Q?p295TN63LHsLDbHUIPy7U9mHJm8KCUJM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 08:18:24.6735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f2bd5d-185a-4688-3867-08dcafa7045f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
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

From: Vishal Patel <vishal.patel@amd.com>

The correct operating mode for the fan is inversed (1). The
previous pwm driver implementation had a bug and the polarity
information was propagated incorrectly to the kernel. The normal (0)
polarity specified in the device tree was incorrectly clearing the
polarity bit in the counter control register. After the bug fix,
setting the polarity to inversed (1) in the device tree will clear
the polarity bit.

Signed-off-by: Vishal Patel <vishal.patel@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sm-k26-revA.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index 5859e6cd8c23..d95a05e21592 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -107,7 +107,7 @@
 	pwm-fan {
 		compatible = "pwm-fan";
 		status = "okay";
-		pwms = <&ttc0 2 40000 0>;
+		pwms = <&ttc0 2 40000 1>;
 	};
 };
 
-- 
2.43.0

