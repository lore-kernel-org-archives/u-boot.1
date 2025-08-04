Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081AFC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 445AF83DB3;
	Mon,  4 Aug 2025 03:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Ns+yLkZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95FF83B5A; Mon,  4 Aug 2025 03:25:23 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAFC683D8A
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw5ItgA2mp3uTyBrt3BFkX4RMgwWUzVFmr9tFBD5GQn5WmPELSqMxkDbQDsBMArHJHfOLPuojtVYEVJnuQrLlp15H5EmfXQg8NE4dbWn2AUQ6Dc+Rd+wN33QNBbdJLFdFlGQOyMWQgagO9nIsznF5nCAD+kCqTaKbJXk8+aUriVHspzpbHs7MJte+LN+k2aEa3hTgzFVaT+kc2ntGJUewHS6djNMd9A0JKyXNbgk87frCU4Ov6S6GY6fUHDuipClczG44HjkiNArPA1Jsuq1kGxEyeCYLqF01yQXpokPc4SDF4TRa3thoeYRHTrPKjpJI8AkgGOwRhyMPqxhGTJvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK3xpBRdL5WlhVDuOmf5O1ipbFV4RuvmYKNDclAZ9t0=;
 b=V5D+h2avMpcLJybyE4YHsQ3v5aYucdAQQDXs4ozwArIULI7cAJObQf1GzyPXjx930Ih5a6CEVczzDUlysuzu0w9Cof48/HESa14Zyn0yAQQDQJYctQM9NpEBlXXbR0SWMrJ+Qw2ZLbjCOFgf/65geZ/EyP4GfJfAaTE/bfkTld/sGnSsRf7tPEp0J3fR0sx+LGlb8uzfXfcVVxrYbIRuq6VE4nVoRdoRNTvoQc3gykhM3goRZKpORHSnVwcUrPRQ4QmMfbYtXItUuGcVZPXKInZa28h8s5Rko7aFFSf6oUGd0J3gFyU9FvWvRL4h0NXgPoipABYMl8jgz8sMIstojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK3xpBRdL5WlhVDuOmf5O1ipbFV4RuvmYKNDclAZ9t0=;
 b=Ns+yLkZJaYXwXXr8rWmOAOdybT1pfqt8xV4GzC9uZG/H4UtvRprtEdCtF7mjJh4hvIFMYPuGV+7CbpydXOZ6urx5xQAs+a6HlpTulcUQ19cqkybY0y6Lu4Sylca4rZaa3au/c2sTr5rNLXhRgKUZEswFFFpgUZisBUqrSox97gTceSZbhd/zmHml+QJzV7DVkqRjunwU8EAWdnhQQ3RrkvSQXf09I0uoaoXo+2w/bOJmExyt9wycriLrpk8XnSqJnaUUCs2Sp9YeJMQz7uaWpuOlkoHnpaJU1EFJi7qBhlUjV7Pz/wqbCFj2iXN3jDfOYe4H8poei3NZzwsOEAVbig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:25:16 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:16 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 03/34] arch: arm: dts: agilex: Update Agilex device tree
Date: Sun,  3 Aug 2025 18:24:30 -0700
Message-Id: <20250804012501.21811-4-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: b30a2c55-2828-4c0e-fb79-08ddd2f5c3cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BOerql3u9dsCP5V3WoTeFRbXzcwcIF1vuDPdqU2D/WGveebT6xwG8JEst2e1?=
 =?us-ascii?Q?tRMcDmDR0/gQFfxHt64p51jAAuxNYfRkWcQa9jo9V621cKD/+hNMzHEaLhLz?=
 =?us-ascii?Q?N0/UeOfUWBBQAsQgJ7CZ2sFM9IHzPAqMkVSMspsx28tQDlZJuP0f26b+PdST?=
 =?us-ascii?Q?tNU++xMQ6chby4plZB1paUJwkyUvzEUm0KVxjNnv1eGhcbg66C/giaC9TH6r?=
 =?us-ascii?Q?oncO7/k+ccwpfVDmsa11GE5le2mR4CTWYHceMaJB9qNwWUDEYPwl6YrOBszq?=
 =?us-ascii?Q?p7AekWKQmzEvt1VPATsOD57HBKno6JM5kRDOIFx9XtIJZ7kz5ak7ZWNpR28F?=
 =?us-ascii?Q?btUjkuU11rET6gdGACHNHONHf1f1aaeNaLq1gkj+jAAIChtS1ilpa2XU5/rB?=
 =?us-ascii?Q?flgIs1eqCeJEIMW9RNiP6OP/Nzxan0C8Ye8Cpi6jENhOpoGNk0khI+5kWO3C?=
 =?us-ascii?Q?G+7w1VJbEx+m2emdLGbvSNSHIkgYVjfF5ZxWZRjy7prS1Q5grONL+oIdL6xF?=
 =?us-ascii?Q?Wme/kxfheBICgE9G+fCBss5sOZ3KugR4K3IKN5DBk643pfG/7wCVk1yoWRO5?=
 =?us-ascii?Q?1gGYc1Sta4MFjilQgRYiv2mFsEgATV9hBWSjVi6GHYMLjn6460LEYKYj3pB3?=
 =?us-ascii?Q?hJueXCI98rmtVlQoO7HuBbBmOYh38vEo48gZK22S356bu9joIkTCOEDEaoQ7?=
 =?us-ascii?Q?mJ1SDtFNtN1jGc0roK/209ownTXcIMNv2hnywsFtmdyTOl1Fut1YwUULqIL3?=
 =?us-ascii?Q?6T+nXxoBmJfQF1PdyVoa7KV7ZsdBmUB0iCHkbVqWrCIw+P1iLD6mTpiMooBC?=
 =?us-ascii?Q?O6vA0lshsMHHNR1zcrDn8qwlCxiXiFqYl+rPbn/Ft1UGnmu3PtvSPymHw2j6?=
 =?us-ascii?Q?mZZtUfwPRtEAZX0fnQEzlNQZnkRXOgCtgAfpZh7V8N8INSFEnEfWwsCYhdGz?=
 =?us-ascii?Q?OY+m9rtyMaDiCxHMGRQozD5IzQ5fq6qF7dHuXZRjT4aTkUqzjby2Iu6TvPJi?=
 =?us-ascii?Q?kVLSE7ERjVo087VCyTsQT09TM2kUMhyk7HwsDkPqX+fLjDylEUEFujuNw43J?=
 =?us-ascii?Q?iEwIfW4Xb1zkebCBerRlIYGRw6EqNsosKk5adBMCk9NMs+syU38BU/Aprg0U?=
 =?us-ascii?Q?CJDvbtOmr58tp612mm+IrWTtLIzltTeuiyuZipJkmzuzRj6CYJSVYrLC82WJ?=
 =?us-ascii?Q?ULokGXFbJswqaxQPU7tx+7ZBMZZlgLBREEHkuuvlwlnMXhahSKzy2BFsY98v?=
 =?us-ascii?Q?zp5iuOhcAbaa7brKFB07blrvmkDA6fD8Z2Edk3NsvUO+4VLYl3IPfufmbKJD?=
 =?us-ascii?Q?7HmX+GwTPo4iV/96NQy2TQTsguy4CEUXk3Q6+uU8QF6ewqKWn8+hZbfsj3DB?=
 =?us-ascii?Q?qRjA92w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?asbzn+38r8QPtXfdiqz9tsDNu4JlAozZj2gCxuA6mxhpr/ql2QDqVC6JGMVd?=
 =?us-ascii?Q?F/lzDRwETigPWKzgwb4Stmyss1jCA5DEbSspJ9wv6vPBN6vknTi2f/4j7MG2?=
 =?us-ascii?Q?LKX+ITvidYQWKu+oJB/RC9egPFeTmW8fxuQv0aTjajar+m/2MSKpa7l3nNTi?=
 =?us-ascii?Q?9xxbNEHa9wkfjlV8pVSfANNogSr6tMIjY2/Y8Sq1Y+Qq4Svto5Vmx0RezFIX?=
 =?us-ascii?Q?Xb7idVWeRCA6Uya6ELIw7wMDu+09sDNiiBS8njEUtF7ULcetjjf7TW+9GFC/?=
 =?us-ascii?Q?kFDhBCWHDRK/DoqHep5KV8iF8PXD2r9rEMQbwxpMgx5r9H3M4REyAw8dV8IP?=
 =?us-ascii?Q?lO5JeV/cydc9FgyzP92WPGowwz8banYaeQcfbiR9qTEQCCUsVoSuqcAVx/y2?=
 =?us-ascii?Q?pMi2rMgYptnpnDbZfOJc3MhNfGFZY7OBy/dNRTHmliF0avP/QHubao/NIajL?=
 =?us-ascii?Q?G+3o03VfRPrCyMCO7SdsszHdBepcj4HBX1BoeDYPIKwFMtxc9fR9wlTlEw11?=
 =?us-ascii?Q?oBvETcjE6BQpyUxZjvUDTAJ9UH0037wgxjh1D7kGiesbCxT5itFZHHAOYwxS?=
 =?us-ascii?Q?yg8zS2l96KtPrhf223ExFA02rtqlPe58sf8bs3bL6s8OTmyDE0/uAkbRGKY7?=
 =?us-ascii?Q?ovC49vbrGQHTt3F8dngubQOg6B6c0LMSFAe5Oij0NzhuxHfMdl7SLMctOEIy?=
 =?us-ascii?Q?mKcWBUcSyjW1d8j4lL5KKp4LsL6it34SMAd57xQaKhz1AcAN/p8eBJE+Y6zn?=
 =?us-ascii?Q?qJNzNxjiQK3wkLDtYJZTEpFBU2DiHrnawKewWhc7hXgciDtfdi4tU/aLFdDQ?=
 =?us-ascii?Q?zVFIoKYMRjKSv5dQFR7tbOlPCgco649buAQSfryywpeuXPDMtR0gx1En2HBA?=
 =?us-ascii?Q?b4klh4u0qVCS5QSajNsMZ0IlM3jJWtheqYoO5C7PQ8ghsCW9i13gGSIz3f4f?=
 =?us-ascii?Q?3jb4x2CkB3vR/NBHM8SV9l2JqDBWRx3UHnpAY0bDa+bT+JlT9AwSfmZ9kI/s?=
 =?us-ascii?Q?mN/UzmMTBaxy57yNF2SV8mc8wPlZLPAUiM0Ip6YZz7XsvQYg6sMemMj4UetT?=
 =?us-ascii?Q?+tZDVdZHJG6pxK3SeXpLnzq9aJaHu/xTrw5PmlAAkfYehmSE0xOK2FysqVoU?=
 =?us-ascii?Q?VboUNpDAnGZRRkJALUJ8Fp5vHVpU3lqgRI02fdgtFkahp37FBCurJMhf7qp7?=
 =?us-ascii?Q?XqdRsohD4WO8HaVXhqgieRNjPgbuB3yF/mIWLHiYMp0pjTcGQmoe+B7oMAt9?=
 =?us-ascii?Q?9MGZVpaOWu+aZTtq+/Gp+0Vx4Xn9QVpcWpVsNMoRvh9nzuXRrEGTgOg1AQUb?=
 =?us-ascii?Q?APY51gGSQWOj9bHHCLEXoeXvZLi13C7QJn1uKvvKklKCUERCdlhxh50kjqom?=
 =?us-ascii?Q?xhcskoiJzCWx0wcyZKczKRVSz3CzsSy8oO4xcDvp2iOqL7veN5Uzyfoirt9u?=
 =?us-ascii?Q?6aZf06MDDrnSiAMg+DANtgyDllFQeDviadw3Cs+HNn3RkmJXMV6dLlE81TDb?=
 =?us-ascii?Q?ssRPWAjRq0JDvebFrUMcVX9OXAc2R2Cfr1AfkIuUQeNBQaYYnJQXlHkNoI58?=
 =?us-ascii?Q?Ek+7mmg3DjBAc+rH79uFbHX4LzC11a7XMFq630fuCRlRmLdGhpbRl/eD599C?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30a2c55-2828-4c0e-fb79-08ddd2f5c3cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:15.2836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6KxNEb4rAXth+6zjI3UF8HI7cAIr0qex26/byeCZoIcGiH9+iCqOEzJqy9aeo8g3HopLHkSAc1IGXAK1xbgx7QFD13jObaK4jFqrrdTlyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Update exisitng Agilex device tree to support multiple flashes boot
- MMC, QSPI and NAND.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 MAINTAINERS                                   |  3 ++-
 arch/arm/dts/socfpga_agilex.dtsi              |  4 ++++
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 19 +++++++++++++++++++
 arch/arm/dts/socfpga_agilex_socdk.dts         | 15 ++++++---------
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e730f94481..0d03a3a2199 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -155,9 +155,10 @@ M:	Tien Fong Chee <tien.fong.chee@altera.com>
 M:	Tingting Meng <tingting.meng@altera.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
+F:	arch/arm/dts/socfpga_*
+F:	arch/arm/mach-socfpga/
 F:	configs/socfpga_*
 F:	drivers/ddr/altera/
-F:	arch/arm/mach-socfpga/
 F:	drivers/sysreset/sysreset_socfpga*
 
 ARM AMLOGIC SOC SUPPORT
diff --git a/arch/arm/dts/socfpga_agilex.dtsi b/arch/arm/dts/socfpga_agilex.dtsi
index 712304d07a4..be5100aea98 100644
--- a/arch/arm/dts/socfpga_agilex.dtsi
+++ b/arch/arm/dts/socfpga_agilex.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier:     GPL-2.0
 /*
  * Copyright (C) 2019-2023 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 /dts-v1/;
@@ -308,6 +309,9 @@
 			      <0xffb80000 0x1000>;
 			reg-names = "nand_data", "denali_reg";
 			interrupts = <0 97 4>;
+			clocks = <&clkmgr AGILEX_NAND_CLK>,
+				 <&clkmgr AGILEX_NAND_X_CLK>;
+			clock-names = "nand", "nand_x";
 			resets = <&rst NAND_RESET>, <&rst NAND_OCP_RESET>;
 			status = "disabled";
 		};
diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
index 63df28e8364..f9491d57068 100644
--- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
@@ -3,11 +3,17 @@
  * U-Boot additions
  *
  * Copyright (C) 2019-2022 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include "socfpga_agilex-u-boot.dtsi"
 
 /{
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand;
+	};
+
 	aliases {
 		spi0 = &qspi;
 		i2c0 = &i2c1;
@@ -34,12 +40,19 @@
 	spi-tx-bus-width = <4>;
 	spi-rx-bus-width = <4>;
 	bootph-all;
+	/delete-property/ cdns,read-delay;
 };
 
 &i2c1 {
 	status = "okay";
 };
 
+&nand {
+	status = "okay";
+	nand-bus-width = <16>;
+	bootph-all;
+};
+
 &mmc {
 	drvsel = <3>;
 	smplsel = <0>;
@@ -53,3 +66,9 @@
 &watchdog0 {
 	bootph-all;
 };
+
+#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
+&binman {
+	/delete-node/ kernel;
+};
+#endif
diff --git a/arch/arm/dts/socfpga_agilex_socdk.dts b/arch/arm/dts/socfpga_agilex_socdk.dts
index bcdeecc0e02..9cb9ff9fbc0 100644
--- a/arch/arm/dts/socfpga_agilex_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex_socdk.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier:     GPL-2.0
 /*
  * Copyright (C) 2019, Intel Corporation
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 #include "socfpga_agilex.dtsi"
 
@@ -14,10 +15,6 @@
 		ethernet2 = &gmac2;
 	};
 
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		hps0 {
@@ -128,13 +125,13 @@
 			#size-cells = <1>;
 
 			qspi_boot: partition@0 {
-				label = "Boot and fpga data";
-				reg = <0x0 0x034B0000>;
+				label = "u-boot";
+				reg = <0x0 0x04200000>;
 			};
 
-			qspi_rootfs: partition@34B0000 {
-				label = "Root Filesystem - JFFS2";
-				reg = <0x034B0000 0x0EB50000>;
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x04200000 0x0BE00000>;
 			};
 		};
 	};
-- 
2.35.3

