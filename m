Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D8FCD8CA7
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181DD839A8;
	Tue,  9 Jun 2026 09:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wNueqyBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FFCA84704; Tue,  9 Jun 2026 09:19:22 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A234838BB
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXIM1sTpKUXVVaqZSv0s4l9+XCCC1Pw8VqNu5/9JzZR1Qsc23Zj88DooSraWoUD8NeX6uEOqijoC3L63v/WqLgLwySHU1sUXTCY5idhX6l95U+kw80frYILQH8ajfpvu7UHgFyamHjTruw0SfL8miVBMiV8oz6Rir2zNNnrAxVu+FBRhDPvaKc5yboTwhGtcvRRYibyNuyy2VsFPHK8LLsjebAaHHAlSQh6KC1B5I5M6y5urK+qfQhrVJj53izgqwJ4vFtcIiHdO7MgHl30eJ324ww45K0tS/FzlHBNVnKeeYSQq8Al/bLf0/iHKg8sGOTHkAXEKrUnWJ/eS6w/qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83jIiytp6ft54jachNDIh8rmc/MEIhq2J67hunMtDts=;
 b=J3Unqhz0MCbEmtm1x+nHPlJdGBH4g9z/ktEH8xOwF0A9kZJ/ff+AIel3UvRj8q2WcOVED5z81Euk5AdXr0U6LYc0QnxfEYkPgmCG+X9Ms1JegjCSpBfwEGC2LlB3jo7pDgTpNPNS6HGgkHKA3OrIMGgB8PkxrJzKamIc3JKc+U7mYCAcsjRXW7EeS9uhVxzBi0TbpEvXptX2vqsbLlXdvx/OyX6ZxGgL2XDWEhKSVUf6tCGhLzOb4IpvXFQwRXX/rpMAD9k1gu/VjSrQk1MuBLF3G9Xaxmux3xaaFr1GQTP5W7bXNlf8U9RC5AvYDR6K3HnjtcdITycZOt1t70hqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83jIiytp6ft54jachNDIh8rmc/MEIhq2J67hunMtDts=;
 b=wNueqyBEktg7lqXmLJlKDyNoW+v0fmRxLNuHUEpkET7iY7uXMZJUa5FNr1Pr3TOTSbJK4YFX9ZLkwC+zuDAJK5Iunx0zQQvaJKRLLMkiIjF4r55CzH8bVjJbI6gxRDrLmHR6DiAh3DJ+JSL8Nkf197FgsEdmd6H0XJo/e8ttHprN0FchcWWUCzwEGCFb9849rIyRb/omTzZZBRiR8JChGjRikkrRhUp5d2jP0/nfYRIFbO5xJHx/GtH+lhL4dhVIYJYa1CpJHfCJ3y+cYyozMeYIRh0uEDHruOZNkBDsOMqwTiHdnT7zkASsrO1vKfL7yjYoox9Ytxp2Wi0AxRw19Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI2PR04MB11148.eurprd04.prod.outlook.com (2603:10a6:800:293::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:19:17 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:19 +0800
Subject: [PATCH v2 02/13] imx952: Update gpio node regs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-2-58e1665d55ae@nxp.com>
References: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
In-Reply-To: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI2PR04MB11148:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ca273b-2e99-40cf-cc52-08dec5f76acd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|22082099003|18002099003|38350700014|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: VgQkg58brtDJueYJONgoXh6qGRsDFlLnp/rZs0STMMEXwQVdSaqp6w8IYVT1J9KlJXW0pyDhThNZWIaFzNQDn3v576KXUZfv3Ifx6QwkobPf3VPcgGRpCIH/0esABLsSaFHWLRaecqD+GD7siH3gseHeC8rTgmiwzj0bDZf3WbEJf2jcB6OV2gNgFfHFlWMgqGsPICkzVWKJKiPJH7oxeq9EqGMNU+192GM4nB9jkoK6G1mo2/FvwCXLhKaPvlExxyWYMFLzD/3c9HG5AHBHaIDy78Ks6L9vZY//7CdJ1SmKDx6Q2kxZZQ1Pzv7xcLExk8p/TU0AlxdaDGUethhMZDI2Y6LBFsvee1It6UoVaVYbZJNGudc4rkOOfsWOLWPN0MYurRw55jdfqlfunBMBQaU6eUUPSi6XJVwfdmUQvOvsul4X1TbiOHsFji4OEPgtMc9g53C6097181hFqkR62uhHr/RVVzch9fUKutrNBWpbUfeerP99m5nZ0rcP5Na+95U3uj6gCM9ewEXw232ybgqsXBj6DNdcJ2bnj3xSHKuNLVqVipR/4qgctgAXh5bqsrrQ9fdH0uQ+hgG2uCRhJ0UNGaTG184Z4in/yrnXSzL4kz+07Qs/6RqEC5jfikTq5LYwgLGWAWASeVZ8Ie5sqJODXbcVAb5937P5uJESQa6jpXWiKzBPK3bx85mVPN3iSN4uDIZWb/oEp95PSmhEQBpxvvNrsZ8+MVsyn23uYodS+Cu6nspWXS3qqyw9H5Gs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(22082099003)(18002099003)(38350700014)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNNNXNSRUs2WmNpVFJIcEFTWVQ1ektmMXJCS2N4UDRuWjZqcWpTSmNXNk1n?=
 =?utf-8?B?MWFXUEZhOFpZRFozYk1tQytucWpkWWd5Z0tGeWRZc3FTdG40ZzZBMVVJOVBQ?=
 =?utf-8?B?YUpGWi9ZRjNnN2p0K3FIZ1VwM2pibEhuZU9XNHhmSU9XOTZHZ2RLSUNJLy9t?=
 =?utf-8?B?ZldRRml1ZHR4dGREUWZMeXgxa2dYZUwra2x3YmRHWTZad3dnL0ozYWRvYzZy?=
 =?utf-8?B?bDczdkdBRU96aEgzNFN3Nlp3Z3VURUVYZU5pNFFJNlVsT1FuQmprSTJ6dUJX?=
 =?utf-8?B?L0tEdUpnbGM5QWQxam9vZ0diMFNVUVhIYnNYMDU1U0xNODZaR2xxbUtkVG5h?=
 =?utf-8?B?OEs0YmxJVjNTdnB3eUIweERsSnk5QlluQ2orS3U1REtXZUxjVXRidWN3T2xW?=
 =?utf-8?B?VmFsRitwRnR3RDFWSmxPY2JhZVMzdHZFZzhLZ0xvcVZ5Qk1OVUVRMTFaQlZ4?=
 =?utf-8?B?Zyt0MVd1Ly9FQlp2dFo1N2lwTXp5SUFhU1cxTmNEb210Rjh1bDNUempJMGJy?=
 =?utf-8?B?K2NkUFQzNzV6aVJlK0I2a3hrRU5VekxmOXpMS0lzOXIxRDdvL1BTaWpLb1Nn?=
 =?utf-8?B?NUVMQ3BGOXFWbVk5Yis2ajFIMjhNYzNLVm95WkJ1eHQwL3NqOVVNQ3YwK1lQ?=
 =?utf-8?B?UENpNXFNWmtlV0tDTzArSEZsZWhKLzlaUy9DUDNJdXhMdHBuMStmS0RJaklX?=
 =?utf-8?B?Ymw5ZGlxaDUyNFJWT2N5dW5GSVEzY1BlODB2bitDVHdob0d5Z1NwYUluK3Bp?=
 =?utf-8?B?U3cyOTBUZUVJNk5jVm1YdDl0TnNXQXRKdGtXcER6a1ZSVGN0R1ZNaGZoMFQz?=
 =?utf-8?B?SWtJeXFvQXRJNUZvYW4vSHhjRVZzOTFBMzBxZEh2bDBPd3d2S1loTGhnWFFw?=
 =?utf-8?B?d1dQWVBBT0w5ZFo5UWVWRFBtSzBxZVJNWXV4QUVkOUtTeHpMdmU3VWRseldk?=
 =?utf-8?B?RUFVZ3p2VWJNK1QrOFFwVDB5cy9xQk93ZjhPbmRuWndmL2dsdElveFU2N1FS?=
 =?utf-8?B?MWpmclgwVmRsSWIxRkxTRlRLNHNiOEpLS0laN0RUQTIyTUYwMVdGcnNIeVV4?=
 =?utf-8?B?ZlpRZnRDZkUydDNjVWtERXE5OEVocmJFT3VtaCtZRUtkMDhTdEJiUk1yRGpK?=
 =?utf-8?B?ZjJHVFo5aU02WVVkMnZpVjZ1ZTlZNkRVOCs4R2pueWJpQldoMGgxK01WWEFy?=
 =?utf-8?B?N3d4enR5NnVReTFIL0FESUZWblM3c3NvTzMwbW1iZnJYakVlei9sSW0reVdK?=
 =?utf-8?B?VVVQeXM3REV2d0s3Y2JGVG5pT3ljaUFkVWxSSkVNKzhndGNMVEdXTHZ6WVYr?=
 =?utf-8?B?T3g0TU5pWEQxUG9RYXhibHBBdGtnOFdPbUphZW8zU0gyZGlab0JHNkt4c0x0?=
 =?utf-8?B?cG9ZSVhTaHY0WnlVQnB2NjdmdFNBOEFCYVhmYVNsK3B2Wk5iSjlhOHR4RS9Q?=
 =?utf-8?B?VFdFTTBOQk45SWs5VDJsdWlnWVFnVlNXUFBnMkxuMG5wZk5qTVZicFoxM2hN?=
 =?utf-8?B?WFNJMGEvdHFKSlQvM0djeWwxbHRDei9ZSHljc0phbjcvanBJZVZtYmUyWVpP?=
 =?utf-8?B?czc5M05oSXU2ZllNUnVzWVY2U085aVowSHFNSkhBUEZGdnFHTUUwMFNnN1Fr?=
 =?utf-8?B?QW9GclhKWjF3UTE4aW1DN3dPcVFyRVRXMXRwVDBicC9PNnBxS2xRVEgvU21O?=
 =?utf-8?B?NGdrZ3VxVUtuQUFzRTBQSm9SS3B3VU5tMm5SZ2w3VGV6Q3lJUThLZTkyb3h0?=
 =?utf-8?B?TXptZmM0K1RCUjZUWWxjOVpFUlF6eHhQMnlNdGd1TTk1MlQ5a0xVVGR5bW1x?=
 =?utf-8?B?Z0J2UFNLWjZXSmh4TEhPMlRmYWhROXVNTkpEa3VRUnlIaHA2a21SRVkxTWJ2?=
 =?utf-8?B?bytML3h3UEJoYkhuRVkxSkREN0lWclVUaTFIcTU1S3hyRGxEVmVuK0taS1VI?=
 =?utf-8?B?NitVc2krY3V5dE1sU0NPRTBiSS9sRkNnVmNMVHk3TCtjdzRCbTVSditWak9O?=
 =?utf-8?B?alA1eFBxelB2T0Q4SDZGcFdyR3F5TmU2UUZzUmlIUEFSNC93SFgzSXNkZlVE?=
 =?utf-8?B?Z3dySlF4WGlFNkdLWHgrRzBiTno2eW5ERG5zSFBvL2tQaFBVOG1aNEpwWXZH?=
 =?utf-8?B?N1VRcjlmcTNHTEp1bWlxcjVuczNiSDlzbkYzbnhXT1lEbXdSYUJmUGY2dkR3?=
 =?utf-8?B?OWpuN05kV1N4M3lObWtkOHg1aTlFYkxBVmFWVkJIbmI0Um14Z1ZoNVhYbExt?=
 =?utf-8?B?OUpZOGxVTHRnZUl0T0FUSE5pS3RkbGhiQ1ZIblVVMXczdlpTLzI5SGtSMTg4?=
 =?utf-8?B?M0k3dk1IODBSRTBYVXo3V0hnOHN3bGpMc0c0T3AzK1F3Y0ovZEF6UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ca273b-2e99-40cf-cc52-08dec5f76acd
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:17.3276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbPmiTygfRzj8pAPWPt3m7cpvpeXEVKTyUUa/3Tcb8QtvM3QubzzsP8RwjQcmEVLWV8Ynx7LH8IMh94HdXIWTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11148
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

From: Peng Fan <peng.fan@nxp.com>

Same to 85319b2e672 ("board: toradex: smarc-imx95: remove gpio1 reg"),
there is no need to use dual base for i.MX952 gpio, so drop the U-Boot
specific reg changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx952-u-boot.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/dts/imx952-u-boot.dtsi b/arch/arm/dts/imx952-u-boot.dtsi
index 28f47244356..80399e6ff2a 100644
--- a/arch/arm/dts/imx952-u-boot.dtsi
+++ b/arch/arm/dts/imx952-u-boot.dtsi
@@ -181,12 +181,7 @@
 	bootph-all;
 };
 
-&gpio1 {
-	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
-};
-
 &gpio2 {
-	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
 	bootph-pre-ram;
 	/*
 	 * Use one SPL/U-Boot for mx952evk and mx952evkrpmsg, since GPIO2
@@ -196,17 +191,14 @@
 };
 
 &gpio3 {
-	reg = <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
 	bootph-pre-ram;
 };
 
 &gpio4 {
-	reg = <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
 	bootph-pre-ram;
 };
 
 &gpio5 {
-	reg = <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
 	bootph-pre-ram;
 };
 

-- 
2.51.0

