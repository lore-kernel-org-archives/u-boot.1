Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72416F8FA6D
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 806088419C;
	Tue, 21 Apr 2026 14:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Pp7ESTf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3CBE83FFA; Tue, 21 Apr 2026 14:25:22 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 495B68422D
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2qs0SgnPNRILg7l/vpAsB6YnesawYOLqGRUGj2jsRrHeatQnHqa63BnVh0X9u5bkC+aFpzOesxhdVVocLPWJ/hdaoVi8NJehSzy6pDrEckWUzFNKvq1FH8U/zU84cvXkGDdFnDymOh4FM2V3zV5nDxMuZCvG9P1JGFtpn0nW0imgZoapnusrQn4MVvBFZeqJKw7COUi/wXuV6z1/lnstQRZc33xAwLWirPiVfeK9dqg5iMICQOqvoIrU9so76TYYFInY4Yb6xtTjBdYJxSzxuhT0kC9ymqHc8Djvuy6AVHyHsY+rxeSe2tCcm2rzyrzu324jAKlZfIpqxUbKt2C1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvHld+4dwk46MsUkf588bdXhIvYe/gHx72JN5B2oUPs=;
 b=CO668HEE1K0OhD9WyYkIKq9gBiTKY5D9qI3i8a7P/cG+Eivt4+HdbLUus0BkoLlLYpapum7Jmecb2D+F9bYrySW5QVmRW+d2GJHmf17Rn1j2OgbZMNkYqf1NgrnyxmgMvdoJWyes/pkWceTxMPcjNjiYRcT4Nu9/ZEOjethQOsygW9EDe4LRbVwHqubLGW/gRGOlnQ1nerDRc/2HTDS8CBvWc2fyBr0TjZF0x9XyZMWDJ1taH845PnYSNwDK6GNz91ZEsfyK/5kyBgWLCOKcBAWfjPHGOn9yMWxSQjBIAwF9FgfRSR/+AI7kIrL07ju3pL0kjUx/Vvbt4cXbkaeEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvHld+4dwk46MsUkf588bdXhIvYe/gHx72JN5B2oUPs=;
 b=Pp7ESTf7Oh+HAAU05zaym7uUWHo4LQXQ/sAMDBXkFPmoSlf+G4ZHeHHhcuSVOziLT2Pt2iKdHuxWpzm+ThatxrJWbXf8cYai9jJRZmKaEvW4frbMdK6Rgx1X2JRrQr7qc1IdVpV1l5BYiWnAFUDiZe+tZk/2HQeoTIcwTkb6a+aqX3AncFq/fpGu/rrW0wKWHGBJVlv8plavVPl1vBfrPxVvx54WD+NSmgTrhAoTaXhiCXF2fpr/P0Ye1vaI80mizuDnosFjUL6OCy/xfPvAlo93piOUsLVQRtJXIwnQBGcZuDl4Hrtz18hHVDTLmdoZFTbS8K+X127OoY80AGScMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUYPR04MB12667.eurprd04.prod.outlook.com (2603:10a6:10:65d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 12:25:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:25:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:16 +0800
Subject: [PATCH 04/15] imx8mq: reform2: drop redundant gd clearing in
 board_init_f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-4-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DUYPR04MB12667:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7e5500-a646-4eab-987c-08de9fa10be4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: XnfXGDkh+KjjziTdNN0FDo9qi8hu4DgrbpV3aEaT7bZPIyXfdm4W1T+txj6AB+v0rTklJRbuH90TRM7E5Y/jVjKm+nNzYKvWz1iOIlZ8gIpGYaWujMd6RZNqrg7rwdwvfnMu4dudGGq0xeOcdJinn0LYdxwlj3p56T/jm5ru2oCUquwLdOlGoPLKRbRMamYKT8j3m37j4BmL4rWxUjZpmFn+yOCb9BfBlXagagGNkwg/+sD79tPxpQxI6tLX8JvN345iJu7MBRCF0HxDysO8T7IQc+TS2A/DTBoI1g7kPB9uY4dvJ//Tpczeq2Q8lbfSc6C43CT2gLDDjFPfPm1nPQUXcn6kwb21ZsoUzs2aZbODHi1PI1Y0/tNWcQVBZvyKkM3XIVXNCaFuTpdZ9bVZKAIQD+2l/XOuyyHeAvPa3Jba8NV8Vn7kvdmvL6XRCrV6xRuFRIYE70cj/UA5DmQmy9V6FwG639e0+SRhVFyPIpQVKLjFhrtIbHWvgZ05Qr8S6p4XhR/pjfbDP1GK2lIewhpWxyKYIhUGNIjSG+J0Hh6+eCN7d7GefRl2n7n56oVEUsTQPRaYH8w7z0OZ989BysU/U8iYlq8h0WcFaBsea0IUJZwk8yhMRkJMVTDTebVu6mAGxv0VpFfYyQVxxkcMLI35hMFPU6abxDhkdqQsbTOFImH/3bZVrAll24iBRRn0hPizxJXqCVJEyWPCxsXrXw2V3Mu0Hb8nMoKuo5XnUTlHyMbdCwsiMf7THHIN910bJHhCPFoPJi8FvxBlhX5mSf7oJ7cDdmNmWbRJu9ziUtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnhlaFVEOUlQZ3lCM1JwUmxZeG96Y0wrRFlsS24rUStRRzBvb25wSEpaM0t0?=
 =?utf-8?B?bGVTbkRwcG8rWS9oUGZSajdHdWFDanhVRzBEa2xJdHZoVWZtSUhDSkJFa01G?=
 =?utf-8?B?ZjFuUi96MmVDSEQxVDJWMVcwK2VpZ29vK2IzTGRHSjRPdTZhdEx0amltZFVq?=
 =?utf-8?B?L0xaNXpiOGZyNnBJZEp5bXpsT3B5QUJ6WTd3aS9Ca1hUdDdwK0pEU256Y1Nz?=
 =?utf-8?B?Wm8rNS93aFVFeFE1MEo1bGpUVHVjOGlKY0dhRXV2YUpGV3d3RnRFUmpQZzhP?=
 =?utf-8?B?clVSUGNzSVpCcjI2aVl0eE1tdkFTRzJFM2R6ZkhRTkZROUxVVGo2RmhXT3NW?=
 =?utf-8?B?NWpKcE1wcmYwS25VemhYK1lVQkdKOEtpdW93SVdJd1Y1dm9xRFlYTGU1U3Zq?=
 =?utf-8?B?Q0VFc2hoQ2ViRTM4SmkrWjRGbVdYYUlGakpPWDhwbDRBRmlxTXpaRGFWdlA1?=
 =?utf-8?B?UzlzaW1UdmM4RGdvaGx4UTBaOG5sNUUyZzdDWUF2cXlLR2NQanlqZmxvMm9S?=
 =?utf-8?B?T29Rc1NRS0NkUmRPRzBBQzlhSzQzOC93VVhSbWE4QkNuSEZad2hVc3g5VDcx?=
 =?utf-8?B?RkJPSE5YVVlEZWJWdUlKODdxQnhxZkp5YTFqM1EreFp1ZHRkQXNydTBmeFR2?=
 =?utf-8?B?bUJ0VGRCNzljdXlOdEQ1NEVtM1haK0wrTlZ0ZkgwRk1jWnc3enBObFF2b28x?=
 =?utf-8?B?c1FWYVJWMW5MUEdZVWJ2VE5vNlFxVTFqeVhscnR5V1c2VFY1U1J0N05ES1U4?=
 =?utf-8?B?cVBzQmFGS1RkWDdZMU1uMmZZNDBqMjNGOU92MkJFZ3pDSHo1UCthNGxsaW9M?=
 =?utf-8?B?VXZyeWhTRVFXaW9zcW51UjZOM3JwdWszR0R3OVFvbk5jQWhZMUZ4ZzlScS9n?=
 =?utf-8?B?aEZwTUdKb01jMG9MOVowK3VOZ0pOU01WMWRLeXlaRVhNcEhIUXIzYW9PMTBU?=
 =?utf-8?B?bytxbnFWZGdCNitDajlIT1BTekJkckw3ZEMwd2ZlVVhvZjA1MnR2VjBSbVVz?=
 =?utf-8?B?cTcyL3RKNlIrRnc3Qkh0WjRBNmFhcm53UzV4VWF1bnpVcjhHVmt0OGJ2Zlly?=
 =?utf-8?B?V25Xbmt5S2l3VTlPNUxjbnU4ZXNvd3N6bGJnK09ndXNDMVJXWGNwTklRdDRE?=
 =?utf-8?B?RGQ5Z2IxVUNDMHFtQ3VmRTVoemZhai9KanpYcVIvRjBFQ2VGZ1k3dTZENndp?=
 =?utf-8?B?YUxLMzNUQlYzNGJxeWMyOTJZcWRrRjdibWZBbFU5ZmU2VGZZanZFcXhGbHk5?=
 =?utf-8?B?N2hEdTJMQ2JXR0c3aXMyb0F4azdUQ1NtcjZsRWRyMDNXcDJ5Wk1MZEIyYXJR?=
 =?utf-8?B?enlYUGNHaEQ1Z0Y5WU5nQTBCS1N6R2RlVVlLNWtpem81SmdJdzhja1RaWlg2?=
 =?utf-8?B?dnB1REEvdVl3bTNBdUNLNEZaUG9UcEw0UktIY2FaZEprbXB4Qk4zME1TaTdC?=
 =?utf-8?B?UTRyZndoVTJLamlKV1ZtTmU4bm5Qd2FuTnVlT2llTU0wREozNmxhb2tnTkRR?=
 =?utf-8?B?QmNMMHNUTUlWcUhWai9kVWVyZ0VoT21CdUprWmxrdXZ2bU8wRFhibC9JZ1Y1?=
 =?utf-8?B?QWdHWFBCaEl5dnEvTmhUQWVxY1g0Vjk5RFVUeCtJOG1QdW9WSGFTdFJMd2xN?=
 =?utf-8?B?VW9ib0s4VzM3ekEySUVjVDhWYlg5SkhscmZTMExQRzUrVm1hTGI4OWlkc09K?=
 =?utf-8?B?S094eml0UExLMU9ydzU0RnBwTHNsV2FFZnBCcnprblU4WE96NmpXTjFLR2c0?=
 =?utf-8?B?OWJXS2hSODNmTWc4NGE4L2RoN2kwUitMQStOZnRXanZGcUdkdlhQU2F2dDBK?=
 =?utf-8?B?a0dqeGk4VGlMazlqSU0ySTdPeXRWdDJ5L2ZpdkVCTFFDcE5XZDVXd2o5SGdH?=
 =?utf-8?B?L05xaXJLT3FuN0lEbDg1RHovSzYxWEcwUXRybUxrZStlRHNCWkFFcFVVQWtk?=
 =?utf-8?B?RHo5VzYxZWJNTnNBaFJMdkZZbEFwVk9HQVJIM2FEMkZreWhvNG5TU2tVTzJY?=
 =?utf-8?B?a2grS0pZWGQ2NGxFNm1zWWttdEVPbWpKZGZlaXJJc3lGa3VxejR3VGhZeWdi?=
 =?utf-8?B?YnY4ME1xOGQwbVF1dm8vMXJvaWk1am45em1ZdENmUTM4ODRYSmxYNXUraEVy?=
 =?utf-8?B?V1BmWjh4MWlYaHQ2UTJmZUovYUQzL0NyWjNiZDJiR3F5b2xIaEFBT1cxb01V?=
 =?utf-8?B?VUJ2a3k5VG9rSmllc3psWW5Cd0FyWkg3RnVFQjJYNllGU0MxdXNKQnNLRW1I?=
 =?utf-8?B?TU1DTTRQQ05IVEJ4S1p0ZU0reHd2ZStKWkJBdmN4aktheFlHbk9xem5Qakhv?=
 =?utf-8?B?dGU5akJzQlVwaWpJVHNoczEzZzZlVmJjbkY0U3pETFBhSDdhQWJYQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7e5500-a646-4eab-987c-08de9fa10be4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:25:17.4042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjGX4lJMhAW4ITXvrHyJjVwSi81Drqu8kGZYv4inMiEcGqKlzCb51Id3UDdA6IGEalTf/Z0Z0b7KhuO6JYmq6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12667
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

The global data (gd) area is already zeroed in
board_init_f_init_reserve() before board_init_f() is called.
Remove the duplicate gd clearing from board_init_f().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/mntre/imx8mq_reform2/spl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/board/mntre/imx8mq_reform2/spl.c b/board/mntre/imx8mq_reform2/spl.c
index 48a783593b6..aca0525c699 100644
--- a/board/mntre/imx8mq_reform2/spl.c
+++ b/board/mntre/imx8mq_reform2/spl.c
@@ -10,7 +10,6 @@
 #include <image.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <errno.h>
 #include <asm/io.h>
@@ -28,8 +27,6 @@
 #include <power/pmic.h>
 #include <spl.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 extern struct dram_timing_info dram_timing_ch2;
 
 static void spl_dram_init(void)
@@ -226,9 +223,6 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
-	/* Clear global data */
-	memset((void *)gd, 0, sizeof(gd_t));
-
 	arch_cpu_init();
 
 	init_uart_clk(0);

-- 
2.51.0

