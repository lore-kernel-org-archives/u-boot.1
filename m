Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58755C021A0
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 06:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB9B805D7;
	Tue, 11 Feb 2025 07:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="G92y8naO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 873BF80815; Tue, 11 Feb 2025 07:42:28 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D866803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 07:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIaLWkiNaqsav3Y02KzdehzBsWxlv8N7QcRS+14RDdyihNJ/LnNp3sTOLjSDHZdLRLhOxnTvXrZSYiRbDsdUmSHcvF4w4HYM3E6Z/a7nOv3yYiO17JnyViCI36bcXDquYVoYEq84zdYIIWQDMa1tSwr9W9JyYqF3pfLRSwA9dtXoDEsnfjX4LaR9nhQ76o7vsvWUcY2ySvmMRkUj+ctc6es2WdwIZrWiqvEFJtjPpWZqylCLg4kffOK93+805Sw/3UK+qbFDbRy0tcMFb5fcVDj3J97jRvTp1DLHYmFuWKquQjWq43gjuskggMhPry6Y1LdN1tI9c0z0DQQy4/xOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRuNLH/5KmZ2utTxH2aBONHZrJcHPdS7LoFCwtiPs0I=;
 b=MPTcSCOd6hfg9MnscWXQvO3VVcyigfNsMFaja2gOF0kH4qcojV8axarZI6ZxPUdye/oRNcp69Dxosg5ooOoXlD6+dyN5qetqtYIKWQR63929md+DPfYwc+WDtpLmOOU3h9HlttBW0GbWjnC2bsoNhRauka9rkY16NqtWgoQix44azXlzzo7ko9CdSLmIA6q9gCsuIDplW6ea1LJwyL2e9mssTSSUAyy/VcFbIqsH+TMTRmAox6WxDkURGt3TcQaOn306ezHuhfj6kcuF5oOQWxDJDGmAyhTX94obFgF0ayWDlRRIdeEXjLVqHKM1gTuN3L++1fZWJV6AV0n7TNL+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRuNLH/5KmZ2utTxH2aBONHZrJcHPdS7LoFCwtiPs0I=;
 b=G92y8naOZQSIyS7Bnj5jbiY50t509bzLZhe0WOzqRgxmLvn6eL2CNQ0tGA1xq/9HmBiBiIDBxYLjaW8r54zbw5OHhtCv3g8d1lcwEte0bQy5ZYtmGruTnahW2iFOrgDCZRA047oXzn89v61QLLJSXUgCdNO82yBCzCbR7svMsgqpJwh2laqbxWoej/xaw5adu74E27n1sZQJtfYtDV+MhJH6YDfRs9oX/BeOxUveej+9z+NSzvk1XEE075vYxqp8xfVlHZJH/V2HnWtbiveoApwyc/5XGi3P4QZyfjSyZ/Hyr1/aBHqrcdT7WumyVKWwrd7ye6w1f0e26E1wwddhNg==
Received: from AM8P251CA0007.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::12)
 by AS4P195MB1624.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:507::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 06:42:22 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::55) by AM8P251CA0007.outlook.office365.com
 (2603:10a6:20b:21b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 06:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 06:42:22 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 11 Feb
 2025 07:42:22 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 11 Feb
 2025 07:42:20 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <n-francis@ti.com>, <d-gole@ti.com>,
 <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 2/2] arch: arm: dts: k3-am642-phycore-som-binman: Add
 custMpk to overlays
Date: Mon, 10 Feb 2025 22:42:05 -0800
Message-ID: <20250211064205.45087-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250211064205.45087-1-d.schultz@phytec.de>
References: <20250211064205.45087-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|AS4P195MB1624:EE_
X-MS-Office365-Filtering-Correlation-Id: 47426657-b450-446d-df76-08dd4a673d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6ScsY9j9ChUU+ZYmAURAmqKWVDomL63EMY3QjDaWYHlMT7ZjSSUsdpMOOCZb?=
 =?us-ascii?Q?dUQed7+/Vm7DAyPBGys5Bar8LoL+XKN8IaDcX7dE/Slu9cDBOSo8RJw7BJU3?=
 =?us-ascii?Q?F2OSSqvfrNdQq3XARacTok//HY5vUNdzpht/D5DXKbOuK3VgcBnKGdr+kmBL?=
 =?us-ascii?Q?8vd6y4phdvSuRDpuzqW8QZKIOBcgdOvKXwTAi3I2+9atlOBzRYZpI3UxrUbg?=
 =?us-ascii?Q?Y6mz0WNQm48V3T+Jb8wTU0FetsagyHQlLAstcjGX1RghplqKy58hu1+CLh7e?=
 =?us-ascii?Q?DSGboIu5UbdqKBim6y6bhhjsWyEJUMo63jPpo/qsGNEbid4/eSF3M4gHHj8i?=
 =?us-ascii?Q?Nn9nYLL89bcOvnsnfUwi07hbr7Egf7QCEO0CURsgurIf+LIr+jCiau3L/vtw?=
 =?us-ascii?Q?fLqlgtRmgA0NddyN/YSwVTjmRMiv8IutGvrws+u0VC9xnipW5pCRZ3aqB/1Y?=
 =?us-ascii?Q?SbJ49BDcUlrJSHxTspmApNKwr7sUvy+YgxVEoticfSiPyqgOWjg7enARV0zB?=
 =?us-ascii?Q?+ffVpsb5BJL9JDM8CR7fcYWtqDrE0EvXg51uu1wYJ+DcCZ6TZ9w/KQLKuH4b?=
 =?us-ascii?Q?Iw/MRMPTf4NYlyysn1BVWG45cV/b3GM0G/Tk97lqgvkdXZQP0zObjsI+0c3g?=
 =?us-ascii?Q?/zdzmrkeGbZ/hSfdYN2EiXrEER7CEpJCX5tUgfWeF31TJ2mZP92FlAhLhluU?=
 =?us-ascii?Q?B5i6qw9sFoucXkPzch7ZFE3IHoTq9DHvuECsulq6dAwKougzdH2CIExvlwpO?=
 =?us-ascii?Q?kIwp5qNsZreIeMiEqKNfvx6VSedCWu8WGfjFxHh1l/c0uQ7j5fQnfwKwQHyW?=
 =?us-ascii?Q?kzc/hGY4YaKtDOGA0Uc/wzHCvj0H7YQccbRVn3fQj0ecTUb1M0uZb90Eie4p?=
 =?us-ascii?Q?o2fU/FErZNexb70g6ANYrJ5ajovYkgwBJo971zuqwhcCj/OFCOiTuzTw1Mjh?=
 =?us-ascii?Q?RixGtfWD8J4CSkfOlUfbXOB6uubgkoZo2PlBzzhsRWiIfe3XXLfxOR8a/6f4?=
 =?us-ascii?Q?sou4ELP5EHU8GfhuqsO6iwITQ0tcR2inUfooaYqygzTmv1Y9bGkLdbGFl2ZF?=
 =?us-ascii?Q?VuLxkZC1SKbnt8rH/gCX4BhyHPLi++5gH4R+MKGPN8LMHOIZ01nmsfW7jdfB?=
 =?us-ascii?Q?sGg34mBV6aB/Fzok+gClJOibCEKt2AK0FwcJzQXhQLCv2nHBVP/xcwbV7EdX?=
 =?us-ascii?Q?88eUTulkAUlWBXF9wnb4DEe/myghwu6R7GWfNU5slz4BQwdhV9U29EblMtLP?=
 =?us-ascii?Q?fpDRCxp5u1Wt+0RQEu1zv7AkuqCn/4ABtH4L7t5uH2hT0imsWgW3ie3OyF0T?=
 =?us-ascii?Q?PyxgXZbmN8O4oQeUXsieCavuOo5s+BV4hOfYJzdZzTlu3SUGv0HFh5CM3BZT?=
 =?us-ascii?Q?kS6GqNjSHgb5cQCw78U7TAGKNyok6Oha20ALx3+UYkP96uf8I+kc4cmLLfsE?=
 =?us-ascii?Q?RkFWLuOitEncolLujPFxeBDbZlYNX3XN4xZzgFfrp8ZGBIy6TXXZ71l67+Mv?=
 =?us-ascii?Q?yFkK0bPVU8str6I=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:42:22.4447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47426657-b450-446d-df76-08dd4a673d2c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1624
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

There are some device-tree overlays with missing entries for the
keyfile. Add them to sign all images in the U-Boot FIT image.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
Changes:
  v2: Removed keyfile definitions which are already defined in k3-binman.dtsi

 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index 3710564cd4a..5228eed19bf 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -363,8 +363,11 @@
 					compression = "none";
 					load = <0x8F000000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_rtc_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_rtc_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtbo";
 					};
 				};
@@ -375,8 +378,11 @@
 					compression = "none";
 					load = <0x8F001000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_spi_not_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_spi_not_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtbo";
 					};
 				};
@@ -387,8 +393,11 @@
 					compression = "none";
 					load = <0x8F002000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_eth_phy_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtbo";
 					};
 				};
@@ -399,8 +408,11 @@
 					compression = "none";
 					load = <0x8F003000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_qspi_nor_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtbo";
 					};
 				};
-- 
2.25.1

