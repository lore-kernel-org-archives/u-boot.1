Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EF3D5C0F2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 08:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F0BC838BB;
	Tue, 16 Dec 2025 09:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fM9wnS6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4469983642; Tue, 16 Dec 2025 09:46:35 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AEED83734
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCVeF0XXiWFWN9wRb+hM32dBaKPI9RUEQOavaaXh0/FTY896E+7YgTFNFtUqi1opPTIpzBw7VUrFjU958leEIqE5fgN5JjtDwc86DMnFyjKhs8UAt2BHW+/vMMB3KLzqmqGGo0aLfGbYR6XOCwRitMd452QeuFF4++XEsF/hz3+/qZjJQigoZfLUycTFbsQApH2W6I602ExR4gTPVpLFF3BItOyUHA1wl/41YcxGT+TwUO9PYqPCV2AeAW7slzEr7hnGwalWikl64VTI/YM03VEnpsKqDkmeqcqojyMwpf5sl0lqUbA7trhL+E1e2Az52oF3d/pcrj8Ab0cGIKZlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFwFobOLdtZ15pOoPPewu59ktqE9tQrMlyZOH2wFjiM=;
 b=Kj0Vx1JC8H+TJaZC4VmUpw6Oknnvv3PkUg2JQyyO7kDoOG620mIjQgqT5UKPoGfHstwdGxpI+ae+yIZFINqg9qHnJsp5rFyqmFR3gjGFQT5fptGJPybNtdrZWby5xkPA83iUPPGtR1IO9TtdXd5lcWQ0ItKSsp7PjEXbDB7rTpbrSdX2CDif2hyoBSFYPOVsd341cK5I/115DYKpR6MOsVWqxJ8ktX+rF3BbKpolATr++8TGorWWtG4PP3/R/TuJ9B5eLJ1u4/HWG5BS6ktLh6nJGhWz9e57gHnFAD/1H+9ctOkjop7CYS8OASgairHv5jT/Atct9u70UrHSQJ+U/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFwFobOLdtZ15pOoPPewu59ktqE9tQrMlyZOH2wFjiM=;
 b=fM9wnS6CPR/lH1it4wc8ha2BYtW4RzLm1+b4Cy3L3kIdaXg9x7md3bQjl/9lc7LreQVElXWlUKEWQqCm8/ripyXPO+HypQAxb2LMXZDB4POikMBo/0IpKhf03SjH7YmBT+bBunbIwahODZ7EhCiI49Fi30J+sucnZkAROxhxcCGa/JXxDNPd93lcEQ71XjIeEG8fddzTnwOXTNyetqCneqGot4XtkaVmgswBeXSyKRi+cGjczLxp7dZFLcI/eDWDmGHOY1/hqWBi4TQgK5R4oy3QTtUE+b2z/BHg3tzHsCJLDnX9+c0/3O3iH6eNHRdqv9TRtyHz+qKzqSSJEmwyGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DM6PR03MB5081.namprd03.prod.outlook.com (2603:10b6:5:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 08:46:30 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 08:46:30 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 5/5] arch: arm: socfpga: Assign unit address to memory node
Date: Tue, 16 Dec 2025 00:46:23 -0800
Message-ID: <20251216084623.19589-6-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DM6PR03MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 09468797-026e-415d-f637-08de3c7f9b7e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q8JHMW1TkQkF9yS4LVeumZcUZpAbxVKuNSKO8jYSmP35EPgn9JzeKd2kU8ud?=
 =?us-ascii?Q?aFLSTK7L6MMGi3Vt341uCuI3we0vtv1X4oLSFCpFtHWUQt/vwx4t9cSWQw4K?=
 =?us-ascii?Q?I3V4p70gYsoDY0P944vy5IJbi3PEI8smUOKGailssw3NUFb33cHsKZlp3GP2?=
 =?us-ascii?Q?OcHe6nH224gguC97FkfWXekZ7R7UUIKHDtlwlwjsQqArtkr3GxDwBwb+SE1h?=
 =?us-ascii?Q?ZHFRtM1HbEaba1za9dgPEBAjabnV7QbqyYDc4V3EtDfTg5xX77zYpZDu3Ed6?=
 =?us-ascii?Q?aQ/dwayN2YGToZXyzBwgcibnaXYlA+ebXAKLEpfJxquCRrO+xuSGWv4L5pWX?=
 =?us-ascii?Q?Q1X0s3Tr+k/OXg4pNfEg9SvqUeWdt52V/zbeH/R9czYg0Fs8hvbcck8bCQgt?=
 =?us-ascii?Q?H9RkZyet/EeGDivlll85sHIjyds9dSrPfKg7kdImKUvKUBX4eoHQf8p4v4uN?=
 =?us-ascii?Q?djjxx3OU4fVzF2PFpzYh910IPaCKwwcA3VO3oqjAaJ3tGQLTRBWgMXMVmf69?=
 =?us-ascii?Q?M3rjBNYKfjjVcG2D/4HPW9ifYGfm0JoiswnUvFPaLo5OAwgwTg1EYdzHSPZN?=
 =?us-ascii?Q?vxbX+gPCEC+DGV5A+Qfs3zutDNDK2TtI6VWqK0FHZPTbtPApvESzhT8IXOxl?=
 =?us-ascii?Q?vWMKuTDlBRaOVHRiUi5aF2eGY1qjgS/NhKUd3jF4uV7CAa2D9zY/F+vPLcdH?=
 =?us-ascii?Q?5xRsnN4oR+OpKtiSbvn2rVefUJo8OHQwkOw3jSRAU91SK3bGCDlB9YS1OcdU?=
 =?us-ascii?Q?KB6YkgmW7kWU5lMJTMCVzASVEO8/BseuKWZaFmqMD2nvH/My3UXijdzBdx5n?=
 =?us-ascii?Q?Y3i63aS/CghnRwKxhDtxsRAJ057gcsFA7nqahCt06Tnr5sHLGcBTIlEqv9K1?=
 =?us-ascii?Q?5BGha7QKDBqqKA+au1W1qpEUbyT/YNy1LS3K5KIslSNsPJ+zJ+cdLGYWxJDa?=
 =?us-ascii?Q?ySaws/yTKA85/hUcqwuq7VbYcresRJ94GPdX4++ymSco7sFTQS40Qsgdysgf?=
 =?us-ascii?Q?fgXv9859tTa3flLtm05n/xPOnaLW3QcsjTOJA8WapcyS1jkdMFuj7mcpKJNc?=
 =?us-ascii?Q?7aXLQt/b0cYNTUdsa3n+M3HVMdxw5bq1VJHugbD/diYlcXhh4JaVTcDcjsC9?=
 =?us-ascii?Q?6v+ijxAXl5WRJlVQzIm5FZgz/Bkn1w/wg8Pyh2IAPNKEgUkiGSkpXnRqVMjU?=
 =?us-ascii?Q?Jg7CQcE5vZC290hWHKWpJ4RxE77JQlRnMT/uEitsoRwFTAh5pHWUpwmG4yU9?=
 =?us-ascii?Q?qpdz9fqlrgIhsMHdWQFAAyLfHTZDXE6wqV0N64k66iO0Ej5gc62xIfQ5sJSA?=
 =?us-ascii?Q?tbfFjy+I9BGrV/q3RMqglTkdxSQSCRQJ2EyKXIDDjkoRJFzZM+LuKHIGon0M?=
 =?us-ascii?Q?Pd8A6P5aVg+WLMB2nWSkQ09uLrQERu2SQUsB5sLmN87uPZLCIo6GlwkuTwZx?=
 =?us-ascii?Q?F2lDrokjZu27BjdOwm7gUnvmWU2xITIo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZnzfSXXaEQgYU2hpY/BQbE1e4Gmu9l/KasBH3XFSi/AJv9vcNqQrx9bSgtgM?=
 =?us-ascii?Q?mApiRotgU9+/ZMYRGtIfnAuA+5mziWLrGy0HOxaUtFcvBzbUastNHLaB58WV?=
 =?us-ascii?Q?WX/Ft+bNLyBdpgsx/WV1UTls5OaNw8B8eskdqmDvetB/xcuCzn1SdVZeTK6V?=
 =?us-ascii?Q?7FQ1A2tAZAqxUF/EvbmUwHqBPgUvhziElI4riwtzR7nhGQtGSCJwyS5I/BoO?=
 =?us-ascii?Q?UbzOVsZQEZrdFwhHj+jCorhb3ammCoVcKg0pSbZj8iJxH2d5STH7CnqZF60Q?=
 =?us-ascii?Q?KlZBoMaDDbE33DxS71u4eB6MTwTFUdZB6TOvWnV72tzmTagqc3vor1buUYN2?=
 =?us-ascii?Q?4tXLQDxEsBVbo0Xmv3pfEnWE9Yu/DmaSoAtKraxJLiZlR7LIWnzeMMLkXFF+?=
 =?us-ascii?Q?HNVZwmffjUpnbRwyRK/4+VNt5OlqHHX9/bM41rtZL5N5HZpiKjqNgVDdk21T?=
 =?us-ascii?Q?fRytyZBeh1u3ZmsfzzFTamH5yk+fx/drTm+pSTqbTdRCVJn+pLqK6ShfEUer?=
 =?us-ascii?Q?2qGK+8xBEcAvfMBjbTqBwWCYt0Xn1J0lPJH4bZRAJ+r4nAgXDC5zrYhJTZiX?=
 =?us-ascii?Q?Ixm34JoIGVhuCxKnQw/LlP1CJ0z+7q862OaesovWZhg58yINbkgpC+rlJSMk?=
 =?us-ascii?Q?Gw+yjVaI7lYrq4iRIsB8CKwV9Eun6fSIlJlCssFF3WohNPUPY9uSPdl5rAQB?=
 =?us-ascii?Q?x+Aiav9XYdoGg3v+tO/RBMu9z24dsj06H9H0iU9wqGhQgjiqzP0rW256X8nO?=
 =?us-ascii?Q?zUcZIIhBUmGI3hKIay237LlpMv5gghfsiM4dEFBpl8qkax3ICQZf9j+5ThwU?=
 =?us-ascii?Q?Pfem3oUT1PzW2/4Ila9xNphHnwbcm0lnkWcnMjQw2RtYay9tXQnlIYpQpXLN?=
 =?us-ascii?Q?2B/9BdDN6/yVFMiLnRDwyTIfyE7ncKwUSAYEt5brMMdHWJXCrvAUAzW9k0aB?=
 =?us-ascii?Q?K2uYiMH2D1SdSSGCFhJEX9fnqRyWuMgl7/lgD8RDxTUBJv7OmbSdAbt/XFlB?=
 =?us-ascii?Q?0n2ePKlsZTTnmEazNSG072i1VoV7lYsA3kchDvW+A438Bx6zNesfkMHj2EXl?=
 =?us-ascii?Q?FXYD939S5SfLSKHTbfR1WI+RXl6Kr+ynS5kW8tz+3rLrJaLisn86ts8LUMWt?=
 =?us-ascii?Q?kuFRllx4KYovD9eZpyFkOZFS5hP08Ql28u0Dia6C0U1qIhnlitMhL0gNoOfh?=
 =?us-ascii?Q?kdhOZUU/SAqIDd9rb1EnCmoTF0FivwsBvfRln2j3umtEDIvANxcOUX0vc2Jl?=
 =?us-ascii?Q?sKwmQ70LkHJPwkGH6D0W8CdiKCMuLAER7z82UhVk0W/PQIege4OtA2L1/Sd6?=
 =?us-ascii?Q?grJBRFh6ZJorrPL/ixhnKQiw8I22x0vyDHEs7zhhmG1v6xTiY4We0SSRbhtY?=
 =?us-ascii?Q?4QF49ejw1c+JCXDHQecUa7MemvGcP+vcMwE8bhOz93/NB3TPwuPIgyOG/Ia7?=
 =?us-ascii?Q?AlQBAp5KSqOjHQNGDphgPL1qhKT2jG8Rf8NhfUf8eV09OvCXvz6jiiWqkzlH?=
 =?us-ascii?Q?yIOwW+gmEGuP6JQvKb/gO5rfM52F8G+wLzzmy+4BKoIs0aIihiAXBiqzYD5P?=
 =?us-ascii?Q?uGdT3f4DwDqqJ5Dvbcq6J4jS/UsE3E0yCk+DHzfYLQEJeWKx2x811Wrfwkj2?=
 =?us-ascii?Q?73STL7cpXeToYIUlvQ5xFhTn09VblSQRIn5caefHGwXKKt9uMYHO0CMBdEy+?=
 =?us-ascii?Q?uiFjlEqfCjrFLalsNo7YAScMYtRLY80vXN7FaRCFpLz8qS/uhR2Y6RAp2TmS?=
 =?us-ascii?Q?SkkYXAXK2nfUvL8GQnjs9ce3GIUww7s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09468797-026e-415d-f637-08de3c7f9b7e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:46:30.1646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6/dcsUdfEBwRU5mNQhVD0qRtT4xNvGyj62yMh9UyUY2UE/PC2m3HRwMRHpMa9a9RcYjSaft4JL+T3jeCzrJhl06uqxx9faas2OS2Xqwkoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5081
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

Assign unit address of 0 to memory node following latest Linux convention.

Without this unit address, SPL will not be able to retrieve proper memory
node values set from the device tree.

Update all dts files which includes the common .dtsi to add unit address
as well.

Fixes: e291277689f6 ("sync socfpga common u-boot dts")

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/socfpga-common-u-boot.dtsi         | 2 +-
 arch/arm/dts/socfpga_arria5_secu1.dts           | 2 +-
 arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts      | 2 +-
 arch/arm/dts/socfpga_cyclone5_de10_nano.dts     | 2 +-
 arch/arm/dts/socfpga_cyclone5_de10_standard.dts | 2 +-
 arch/arm/dts/socfpga_cyclone5_de1_soc.dts       | 2 +-
 arch/arm/dts/socfpga_cyclone5_is1.dts           | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/socfpga-common-u-boot.dtsi b/arch/arm/dts/socfpga-common-u-boot.dtsi
index 695242bec21..ddef9a2896d 100644
--- a/arch/arm/dts/socfpga-common-u-boot.dtsi
+++ b/arch/arm/dts/socfpga-common-u-boot.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2019 Simon Goldschmidt
  */
 /{
-	memory {
+	memory@0 {
 		bootph-all;
 	};
 
diff --git a/arch/arm/dts/socfpga_arria5_secu1.dts b/arch/arm/dts/socfpga_arria5_secu1.dts
index 8e9c3bbdf9d..dfc04cc2d7a 100644
--- a/arch/arm/dts/socfpga_arria5_secu1.dts
+++ b/arch/arm/dts/socfpga_arria5_secu1.dts
@@ -16,7 +16,7 @@
 		bootargs = "console=ttyS0,115200";
 	};
 
-	memory {
+	memory@0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x20000000>; /* 512MB */
diff --git a/arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts b/arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts
index ca030c8c41b..094db1cb7d4 100644
--- a/arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts
+++ b/arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts
@@ -20,7 +20,7 @@
 		udc0 = &usb1;
 	};
 
-	memory {
+	memory@0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
diff --git a/arch/arm/dts/socfpga_cyclone5_de10_nano.dts b/arch/arm/dts/socfpga_cyclone5_de10_nano.dts
index 34886ec1ad8..346b2ef9e2d 100644
--- a/arch/arm/dts/socfpga_cyclone5_de10_nano.dts
+++ b/arch/arm/dts/socfpga_cyclone5_de10_nano.dts
@@ -22,7 +22,7 @@
 		udc0 = &usb1;
 	};
 
-	memory {
+	memory@0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
diff --git a/arch/arm/dts/socfpga_cyclone5_de10_standard.dts b/arch/arm/dts/socfpga_cyclone5_de10_standard.dts
index b38f0723823..37203b63410 100644
--- a/arch/arm/dts/socfpga_cyclone5_de10_standard.dts
+++ b/arch/arm/dts/socfpga_cyclone5_de10_standard.dts
@@ -22,7 +22,7 @@
 		udc0 = &usb1;
 	};
 
-	memory {
+	memory@0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
diff --git a/arch/arm/dts/socfpga_cyclone5_de1_soc.dts b/arch/arm/dts/socfpga_cyclone5_de1_soc.dts
index e9de72429f2..264ca3dd53f 100644
--- a/arch/arm/dts/socfpga_cyclone5_de1_soc.dts
+++ b/arch/arm/dts/socfpga_cyclone5_de1_soc.dts
@@ -20,7 +20,7 @@
 		udc0 = &usb1;
 	};
 
-	memory {
+	memory@0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1GB */
diff --git a/arch/arm/dts/socfpga_cyclone5_is1.dts b/arch/arm/dts/socfpga_cyclone5_is1.dts
index 58a5faf6ea2..b26248b023e 100644
--- a/arch/arm/dts/socfpga_cyclone5_is1.dts
+++ b/arch/arm/dts/socfpga_cyclone5_is1.dts
@@ -15,7 +15,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		name = "memory";
 		device_type = "memory";
 		reg = <0x0 0x10000000>;
-- 
2.43.7

