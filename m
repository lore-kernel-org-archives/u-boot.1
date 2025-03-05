Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98D5C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 05:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF76814B6;
	Wed,  5 Mar 2025 05:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="fxaLiX6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C3581423; Wed,  5 Mar 2025 05:59:00 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::72a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954748129B
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2XslMCOTMsV9ilDfgyaM/cTjGdOjuZZ0/kafHa0/87a+vBaE9zV9IDcYVAnaN3S6TfS6O2iOidi18GDk/LIVJUd96FKtOHAAH2lqJHyTBSnMyrCHCpJ003fDW2P3VvffGOGHiB6g7z1ub5cU+d7aTdwJ/SAhHoMWVcxh29VKTJ/3+4xGvP0paHuR9D2+Sov9KFMyzSm4yWrbDWOgeGJeitG6N8w3K3puB9rHwG0ieNKqzIy/EvKsRatYBsuzTgB5INzbqxvY8/o9M8Aarsv8ScFShYY5eZjfdXp8IsDBHRS465+GIHl4YgElFESaDUgrevDZSzOprzb0xNT/UwHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsXJDBNmOHLTwdm93IqeTCOuzceOEaqFrZGp11D5tII=;
 b=AIbUw7wMISx3WqWVwh3lRBl6isE0366p7MlcDTeLlIo/mC/iRDgMyLh9h7eP1c8QCf2M+in3vpparqMvqUsGIQwuNbj6jtpvWWH/oU8irV4whvXa8sllgE8RHzF4+fdSSGoKoi8p6NI6nT57RgGQeCiF4XDKlY0e89YbYm+9UcP/s/XtQSqfYd3IO/abbgRSKv2mNGRfSDYvUHs9far/opVLSsjYahJhjf+HfpjYAbkC/2YfqivcM3rD+5wVVf6Ak8PMx2r82C2JoOVcTA3rCcvPGg5MQ4a1SyercuOv+wB7JkDg2j0Xq65Za3kKTAE2voRppBFZAkvly430zitX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsXJDBNmOHLTwdm93IqeTCOuzceOEaqFrZGp11D5tII=;
 b=fxaLiX6XwntErjfOZZjt8OM6ixN1CvIDPpe02/JQg04ZYjiI0mnlekOsCKtRCZUbhuzkExBhTz02JqUzmw7vRJpL47eOMfh5LxpTP3BrfkYkBahfd/AJEDZvL6bjanEHuWmDF7kSRfa5LjA/8OChsPk8eEZdt64GT8Y4QvyCeyQicPlfHowzn9TYkhd0rT6ltIqf2mAtDHGYjy8NO/kq9gspvjjQwBw8aNBJMG6RJ//UKQ6/4MBKT7VRlxxwUZ/Wh6QX2o+9pmbh9QdnOp1sUVawBM8K2yaJ0tZSbualAcm3tVNcdzGmPXGC+EYWWIkC1qXYpdBtb/XIcor3wbqnBg==
Received: from CWLP265CA0287.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::35)
 by AS4P195MB1814.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:51d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 04:58:53 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::a3) by CWLP265CA0287.outlook.office365.com
 (2603:10a6:401:5c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 04:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:52 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 09/13] arch: arm: dts: k3-am625-phyboard-lyra: Add missing
 boot phase tag
Date: Wed, 5 Mar 2025 05:58:34 +0100
Message-ID: <20250305045838.3614661-10-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AS4P195MB1814:EE_
X-MS-Office365-Filtering-Correlation-Id: b3dcb33f-8de7-4d7b-02ea-08dd5ba26d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mWkFboMc02QmSyJ8iy4cXqwPI9sq1/B3VjHJpO/EVd6lyOwm4DA8XJVl/DMA?=
 =?us-ascii?Q?BGpwPBhqtP11V87qc7z8S2yUyVZ/KGnES4B6aHT56AtD2zJHXmfLIw7ojxHJ?=
 =?us-ascii?Q?cO/oGVnNSwFv+ThODAz/4ey8Q+tP3W4lussCzBoqFxPg8pzD2TeB93L3D1GU?=
 =?us-ascii?Q?LXVwyMnTJSj8MGVHd44KUsfAaRanyXcQm8Bm5+aOTBqTFeafHdLTwsoEfnBu?=
 =?us-ascii?Q?Hx6SstkETbF7d5o3ofXYJJGJUNfxh/+1LPFUphUqDxCmr/K5BbNHYBVmZT91?=
 =?us-ascii?Q?LGRHHYlxEHxIBxANXxptxPAoJv0mIGP8JfJ1hfzMLK+HtTUGVdAXmQtwfU5r?=
 =?us-ascii?Q?IJeN2dLwmEriTml8Mp/1cUq5mMgVMUKUxgK2cmCxjYKQvnWDTCYgMJBO5bBo?=
 =?us-ascii?Q?GU6Lli2kuzsSImWEi8OSyp1eia/1FYs3cPmxRkuyOtgbu6eR06VeXK+3hfWI?=
 =?us-ascii?Q?tkhlpoAOcK3AAZ4tCEDjkwWMFvSVN38V29K8KWiDlxZSbouK3BhD//EHTUYS?=
 =?us-ascii?Q?ETR8Het4PDaS/8puwRCaDhqriMqkLe9wiWoj8Br7WDngg2mm96FaNM3X1leo?=
 =?us-ascii?Q?X+c1aA7Zl/dHBUxi8gtjZ/ztcdqeIn2ZbmfSJ6v3wI+mZj/bAgrlWgNhnV9G?=
 =?us-ascii?Q?cV/z1Cos1Br0hNYgsKOj5m099tqTwL3NJ2xPc3o5jyBsghPnlA184ruFtcRs?=
 =?us-ascii?Q?KZ8YlBr8c8lzKD8uGAp00yGksiDGA1C4LkbvyErnSSvovoTpsMkg4aGBhl2W?=
 =?us-ascii?Q?xdCB2w3ibhZJKsH5MrCkb+eRkLx3y0ng5u0I3JQp5yFSIAS1SXZqkzp+/YQ0?=
 =?us-ascii?Q?olJ24YK8U7P2P6F7V6EnUMwx2fZXc42UXSOC0uvEf57dxJw5hjjZvClMKteB?=
 =?us-ascii?Q?a08Cmxe9srFLFD5GyFZFM5uAWA1J1EapBzfMhh/5BLePo0THhz1CU8vGZJ9N?=
 =?us-ascii?Q?BRZ6WePIWQHVLmW2zygqfwmgzYX1LIZGBEZd49GaSszzcbfqTaujS5BVGXT2?=
 =?us-ascii?Q?3WVnU3Sv8Pn02qI0CJL7H89K+AkcIG+i/XFDcZgB4gLKwuF3Zceacj/y5OAr?=
 =?us-ascii?Q?/mQ6zGeSDHlwpNsVIOtYtIE9OvXt88600hADBfOL/cWAhO9mlM+BdDJMCb/d?=
 =?us-ascii?Q?tMjQo1EMK0qjfyh30Un9CArEN5sNO5Y23Osgf4hWIYP0zUnMJGHqCDENnSP/?=
 =?us-ascii?Q?AKRwH95QR0vBJTaZp6ImG/Cb4jIUUhmOps9BH2aUJv+uhG7+bqir0R4TVVSP?=
 =?us-ascii?Q?B8omDlhENi9u5rlYijfpZIdf5HoC6hJ6+pYh5SPQ5d/fNyELgJCsC1iV2VY/?=
 =?us-ascii?Q?xiFV1q4bhvPJTbeNwzu3dhak7VY/3C7BUDfFUROHbA4hOPNvPykYH3xVZU0Y?=
 =?us-ascii?Q?dTgZs8mLOkQOl2KbnrX4AiKnhiJRO5FGsq5HcjxG1rjLC04AKx09pl/U4nXj?=
 =?us-ascii?Q?ikxEDgqZu98qCTpgcQ3akgActA3oCFvmKvrsWI8WXxvOtaQJ1+lDyGHpjIAx?=
 =?us-ascii?Q?UHI1z5oXQMi6POg=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:52.9850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dcb33f-8de7-4d7b-02ea-08dd5ba26d23
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1814
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

Add the bootph-all tag to usb0_phy_ctrl node to ensure it is
properly initialized during the boot process. This fixes the
following issue:

  dwc3-am62 dwc3-usb@f900000: unable to get ti,syscon-phy-pll-refclk regmap

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
index 2bc5acbec23..52c9cafe992 100644
--- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
@@ -177,6 +177,10 @@
 	bootph-all;
 };
 
+&usb0_phy_ctrl {
+	bootph-all;
+};
+
 &vcc_3v3_mmc {
 	bootph-all;
 };
-- 
2.34.1

