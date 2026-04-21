Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87668F8FA90
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 212AF84359;
	Tue, 21 Apr 2026 17:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RAq0CJFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DDCA83A91; Tue, 21 Apr 2026 15:59:42 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922AB83693
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dV4X+8aOHwsi3e5laUeM/JLvT1hJqrAnc46Skh13IX3Eawb8ZGSL/iITDnv6bc8IR35l835YvniWHvIGdkB1Rim3JP0mxXGVg93/TgKMetQccWvliyRr1yfJuQsrTj9E3otSmJmEASZcs4qfYIPcVNJ/B8C4njTXA73ou4Agj/qtUt2UX9PjrlPYYpAQqu76VkV7SsubRASSbo6whob7SgPanITuy/0a15jD6TzS5Lxs1CC+EkPHg52HU1Gesm2Ug4vx73frlJbkSTJprY1DLnEDXDANXBT33wChor2GR/6QtWFXrFRBnmW8a/UXXktwSam3HkP86KB343JkNBvfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJkttQ9OcJ8Guh8DO5cwD3fs9qE0b5S8pYBF9EGQN0o=;
 b=sbx8wvyfkvzrPgLAqoMRk8MkF11c1XFl2WBB3yFeUzr0SeAWOGwcm0OwYNLz44SIqn7/dQPFyw82qFInmDLumqB7Kb1YeDmihxbvnMDXxKNeH+EacicuuhF6/KQhZa+aOsqXCW+67z5UUBkfxDhbXQaN91d8jlwmsm/egcjAQEe60qrtz+rtq3i3k5MXW6r/K88cU/I7YS7uzIcGSNt1Fi74wiuzwGPnViGEbVd/8+9tAcjzgwCAsgyc1WKt03MGvS8Zlm8u9yYNnR3dHj8NTTM2kFrW6tzGZuWDZym7CdOSGzMZ/Ffa0NNdD+N7v71wniIyyK/xlLUY3mPb9GucdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJkttQ9OcJ8Guh8DO5cwD3fs9qE0b5S8pYBF9EGQN0o=;
 b=RAq0CJFUT3VQwyCC+DQSTFpcFPyjtsXR2B9egs87pvd1CljRmueb6T15Z0fQerxaNz2L38i9/hC/4K+ctgmZ7C8JUVWwUBYWOX4hH5IpzazQ/eG3P3MIN9/VEI5Fe/9vu8PVNLrSbRcEFMLkPalrG5smCM1CKR/W6/49egh84FZUb0Uop+VklZ7f/W9kyNUaZDjtoeI8+KPDjS5lcqXJxEaT0MSX3If4RD98txZJTHrEC8N19GTnjenZhq3fZsDZddbE6+7kVf4DvEm0LkWFwFFR82I3MXPJQV4WwjYbrRmpOjXZDMN8L/kEVwinSS0RAlEYCOxgLI0EsKx+kkPrcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10426.eurprd04.prod.outlook.com (2603:10a6:150:1cc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 13:59:36 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9818.031; Tue, 21 Apr 2026
 13:59:36 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 21 Apr 2026 22:01:29 +0800
Subject: [PATCH v2 3/5] watchdog: ulp_wdog: Use driver model for
 reset_cpu()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-wdt-v1-3-0bd01ec6a7c4@nxp.com>
References: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
In-Reply-To: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anshul Dalal <anshuld@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Joseph Guo <qijian.guo@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0088.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10426:EE_
X-MS-Office365-Filtering-Correlation-Id: 066f7344-3edf-49ac-1eed-08de9fae3915
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: b7mdmanYJoZ3bLClIFrNCgn1v3aVfY4CdgXsQdYeRqSNO6i+6bqUmgXTkhnRkZJuhkOLrtAUirqb6ZcqJFt7xMO7DQ+f4q5cA5nmyyl1JHbvgrtWXZiROABMfgPkkshu4RGUPwpHAtGw6ZdwYmQtXT8qORa3VqANCsA6RLdlJbChu0X5AWtS9n9eoZThsti1pUiCyMj2EkVFxxX7aCYCpV6DXmSr4hOcKtFcrGfWUXe4gVY0CDLlTKK41R9xNEt4EMZ6QEOSD1votq+QBved+aKrx+PsrY3KJsqh8k5tAPI6caQYY25ecpKnJPX7YnLuTaCAVC0PPyWCTkDImw2Un5f44NtpSNwb2KyXan5YfBMyHzb2E13DuugQjuhySO/E+sM5C2q7DrqeaeksDtmuC9GZTYwvISeuMBoJ49kepJzPFmRlYkPFAvm5TJ8xtM57leQRoKaiKwyknW+yEbDAiOGSvlvs3SFv4Ezdq8Sx9p128PnIsweP/n62JuD5HlZwR+mM0OEYt9uncuPxpYN6NBpx//rodAJuNw8HFLRWmZIvYqo0ONGH0IwSQA0unBl1Mc2CpC/fXowdDmcml3jEsyUMQL+struS8gwDqxWDwL5dVIxor0UZD+3fYJ64Iy9QZhncZkm74PK3sr5nrRjltjANyrdaI6n1jel17P4U/BB+89ZwcDRlXvwT1uC8ZEbmIlv0H1IhOghYPaaTH2Qr8onwNov2ZSb6HqyPUUKRs270sYo+4+LSaKPSQ/tLerkm0bBrS8pTSrC4YCxYNorT5MkD7SKjrJPTgTC0XbNp1TU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2xRMFBicDllbUF4d1R3aWsyZGRodUoyVy96VDdPYytSVXJiYmFPY2RCNFVJ?=
 =?utf-8?B?TjdsUGMvQ3ZjYXp3djdlQTVmWU4rU2UrVittV0lZNUdrOFZ6RUdqMEUwdzVi?=
 =?utf-8?B?N2Q0cDBieVRyQ2RwWnRoRWJOVmE3Y1pmUjF0YjJpOU1WQTQwUUlCd1B5WEtw?=
 =?utf-8?B?VE51TUg1S2JSNkQ3UzIreW5QZUN3UHBwY0ZLc1NwVTFHQ1dmZzlTeHRFU0Vv?=
 =?utf-8?B?bFlKSE1aWmp4NkVIc1diSXdZTjdqd2pCZUpRN1V3VUdQMEZ0ZitjZkl6K0pS?=
 =?utf-8?B?ZEJVVDFZRTJFVDZQSHRWR24yd0FOZ1hManpXaEo4V01MVE9RZUErRklFMUFw?=
 =?utf-8?B?d0lYRjI5cERiZElRdStCUStWbE9lQU1wemZZOXkxQ2hCZmJ6cDdOdGdpdFZB?=
 =?utf-8?B?T1h2YmN5Tjd5UUMvTUxQR1NSWVB4aDZCcHhCMFRhWUdsUmlvSmcyRGRMWnFk?=
 =?utf-8?B?bFdjOWFwVDBJYlR2M3d0N2Ixd3lldktJYTFPOHpxek96Z3FCL1hnR1BtbDRz?=
 =?utf-8?B?Tis1U3NnbU0zenlxVXRxckRTajVpRHVrVUJNaUVwbDY2Y2lPNDI2UDVleTJt?=
 =?utf-8?B?eVNFSzBEd3BRRzVuYUoyWmwrTnBPa203dWpna04xYTVVMEh3N0R5RkFGSVk5?=
 =?utf-8?B?by9hRmFZcjE1SGYrSDZEMHJVZEdsTGpaVFlaVVd6MXlCN3RkUzFjajAzMkdC?=
 =?utf-8?B?WitxL2pSbUVCYnBJQjlkRTFrZXI1VVkwaEtLblBTdi9DZlhSRFk4bFdyU3Nl?=
 =?utf-8?B?R3l0QnVPeGtpYlBXVGV3MHhURjE4TEN5YWdsRGJGWG0vd0UrTWlLcGxOYWFX?=
 =?utf-8?B?Y3BQV1BHMDdhS2FpL2h0UW5hSmpIaTdUSGtBVXgxOWMwN2MwOXpTMmUxUlJP?=
 =?utf-8?B?RFFES2lmczBac3FKaDZmSzhGbVY5M1V2d1E5KyszZVZneXdMNzQycG1uRVdI?=
 =?utf-8?B?MGRjRDBCNTNWNmZUeWs0VWlxdFpTenZLazJCZ2FvTmt1cmMwNVBsRFJNTS9q?=
 =?utf-8?B?S21zaC9vcU5OcUc1Y055LzlYM3lKbEI1V090bC9LUGdFaTBNd09KOVBRSGh2?=
 =?utf-8?B?eFlUTkJXdnRzRjRFUkRNQ01FS1dUMG9QSG02TndMOVhyZ3c1dGc4cjdoQVp0?=
 =?utf-8?B?b0cwdWFvTktzSDFJMEFMQ2c0UmRNdXBQRDRaRTN0eXVHOHVFYlJUeCs4VW1k?=
 =?utf-8?B?UWNhNjV0eUQwL3NpanZtcVRLd3g0YnU5bGpUYWFIQ1JLbDBJaFpWSUgzWEtT?=
 =?utf-8?B?Sm15c3NpbU15MzRQd3FsN0FCdm1TbmFrVkdsWmNIMlo1MzYrVTExWVV2UGNm?=
 =?utf-8?B?ZEtmNDYzeSticUJkMkgvYU5WTFcwaEFRTDFmbFVVZ2lVVU41bHFtUnFlUUVv?=
 =?utf-8?B?Qy9DUGhvazV3aTRscEhRUE83cFRxcnpEN1RJcmRaWXhnVEZmYkVoTnBsSUtN?=
 =?utf-8?B?bDV4VWs3dndRVE5ZUmtxN2dORFRuZlYzdFBsR21QWWRyaTF3ODZPSWlzenVk?=
 =?utf-8?B?d09lQURrTTZJTHJ4ZllLWlM4THJmSmROWkhmd1JMVTcweXNsYWg0dUUyeHZx?=
 =?utf-8?B?SlVMRWV0aFhUWTlQcFgwdFhGc3NiWExzd2VjNmFXQUp2RndZdC8waUM5SlpW?=
 =?utf-8?B?NU1IZXA3b1RYdWxyUnFtSFRUWGt4U0FabEVtZTZBV0pOT0dESHBBMS92bVNl?=
 =?utf-8?B?TVpmNytzU2N0RjNPK0dKUDhVK2Z6dmlCOGZMWTNNMmszc2RaaGJVOElxbDB0?=
 =?utf-8?B?QUVaZlphZktoWG5yVEQwSnlVL1VXV1Q4SDhwWjBSREdCVVNUazJ4elNpVjl4?=
 =?utf-8?B?cDJMUzJzVXloYlFMRDdLNGtTZ1h3Ym96VkhTMnF3aDM3VGQwT0dMNVdXZHFG?=
 =?utf-8?B?SWs4cVRlS05oQXFTaUMzQ0tiTy9iTjRpUkpHWWN1bmE0ekRsMGxhMks3WnVx?=
 =?utf-8?B?VndncElOSlpTbmwwakJ0QzBsYUovcVlvU0JPcnpSMUhqMXFKUVFqeGhmZTNC?=
 =?utf-8?B?UGVpeTR1MnpQOStHT1NDM25OK3czelQvSzl4RWFKRjcrc1NUWGZoblhUMys2?=
 =?utf-8?B?RExyY0lHdDdmdmhlM0FyNlU2N3RMOUdOMFJxbkNBd2dPSnNnclFXcWQrV056?=
 =?utf-8?B?R2JCWnprM2l4VmVtNmo1RFcvYzliSC9Hekl4S3FkNElQemc4dWQ3V2FRLzVB?=
 =?utf-8?B?Z2t3NjNLSWdwVnJyMHNqVm1DaXN2NGdldlNnd1l6NVp5NnYweEFDY0xSWE9N?=
 =?utf-8?B?NDR3UlhHT25zblU5NHFEMG83ZGx5dmdRZFNKSFlWRWJROEtsTTV6SjJpVkg2?=
 =?utf-8?B?OHFJM0p4ek4wUHo1d1FicUNvSHlZN2xNeTJpc0pTditiMHI1c1BrZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066f7344-3edf-49ac-1eed-08de9fae3915
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 13:59:36.5394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYM99yZwIc8N7m/oQkhVon0KJ8nwQztMK+STptexY401Kssuslm9ROszL5oQMAZAlDOczuuYxPe3yb5rcESDwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10426
X-Mailman-Approved-At: Tue, 21 Apr 2026 17:12:16 +0200
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

From: Alice Guo <alice.guo@nxp.com>

Replace hardcoded WDOG_BASE_ADDR with driver model based dynamic address
lookup from device tree.

- Remove hardcoded WDOG_BASE_ADDR from hw_watchdog_* functions
- Reimplement reset_cpu() using UCLASS_WDT device iteration
- Add ulp_wdt_expire_now() callback for standard WDT interface
- Pass wdog register pointer to hw_watchdog_set_timeout()

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/watchdog/ulp_wdog.c | 79 ++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 51 deletions(-)

diff --git a/drivers/watchdog/ulp_wdog.c b/drivers/watchdog/ulp_wdog.c
index 83f19dc0e86..e3a89031c44 100644
--- a/drivers/watchdog/ulp_wdog.c
+++ b/drivers/watchdog/ulp_wdog.c
@@ -7,6 +7,7 @@
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
 #include <dm.h>
+#include <linux/delay.h>
 #include <wdt.h>
 
 /*
@@ -51,11 +52,9 @@ struct ulp_wdt_priv {
 #define CLK_RATE_1KHZ			1000
 #define CLK_RATE_32KHZ			125
 
-void hw_watchdog_set_timeout(u16 val)
+void hw_watchdog_set_timeout(struct wdog_regs *wdog, u16 val)
 {
 	/* setting timeout value */
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-
 	writel(val, &wdog->toval);
 }
 
@@ -89,7 +88,7 @@ void ulp_watchdog_init(struct wdog_regs *wdog, u16 timeout)
 	while (!(readl(&wdog->cs) & WDGCS_ULK))
 		;
 
-	hw_watchdog_set_timeout(timeout);
+	hw_watchdog_set_timeout(wdog, timeout);
 	writel(0, &wdog->win);
 
 	/* setting 1-kHz clock source, enable counter running, and clear interrupt */
@@ -107,57 +106,20 @@ void ulp_watchdog_init(struct wdog_regs *wdog, u16 timeout)
 	ulp_watchdog_reset(wdog);
 }
 
-void hw_watchdog_reset(void)
-{
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-
-	ulp_watchdog_reset(wdog);
-}
-
-void hw_watchdog_init(void)
-{
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-
-	ulp_watchdog_init(wdog, CONFIG_WATCHDOG_TIMEOUT_MSECS);
-}
-
-#if !CONFIG_IS_ENABLED(SYSRESET)
+#if !CONFIG_IS_ENABLED(SYSRESET) && CONFIG_IS_ENABLED(WDT)
 void reset_cpu(void)
 {
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-	u32 cmd32 = 0;
-
-	if (readl(&wdog->cs) & WDGCS_CMD32EN) {
-		writel(UNLOCK_WORD, &wdog->cnt);
-		cmd32 = WDGCS_CMD32EN;
-	} else {
-		dmb();
-		__raw_writel(UNLOCK_WORD0, &wdog->cnt);
-		__raw_writel(UNLOCK_WORD1, &wdog->cnt);
-		dmb();
-	}
+	struct udevice *wdt;
 
-	/* Wait WDOG Unlock */
-	while (!(readl(&wdog->cs) & WDGCS_ULK))
-		;
+	for (uclass_first_device(UCLASS_WDT, &wdt);
+	     wdt;
+	     uclass_next_device(&wdt)) {
+		if (!dev_read_enabled(wdt))
+			continue;
 
-	hw_watchdog_set_timeout(5); /* 5ms timeout for general; 40ms timeout for imx93 */
-	writel(0, &wdog->win);
-
-	/* enable counter running */
-	if (IS_ENABLED(CONFIG_ARCH_IMX9))
-		writel((cmd32 | WDGCS_WDGE | (WDG_LPO_CLK << 8) | WDOG_CS_PRES |
-		       WDGCS_INT), &wdog->cs);
-	else
-		writel((cmd32 | WDGCS_WDGE | (WDG_LPO_CLK << 8)), &wdog->cs);
-
-	/* Wait WDOG reconfiguration */
-	while (!(readl(&wdog->cs) & WDGCS_RCS))
-		;
-
-	hw_watchdog_reset();
-
-	while (1);
+		wdt_expire_now(wdt, 0);
+		break;
+	}
 }
 #endif
 
@@ -184,6 +146,20 @@ static int ulp_wdt_reset(struct udevice *dev)
 	return 0;
 }
 
+static int ulp_wdt_expire_now(struct udevice *dev, ulong flags)
+{
+	int ret;
+
+	/* 5ms timeout for all others; 40ms timeout for "fsl,imx93-wdt" */
+	ret = ulp_wdt_start(dev, 5, flags);
+	if (ret)
+		return ret;
+
+	mdelay(50);
+
+	return 0;
+}
+
 static int ulp_wdt_probe(struct udevice *dev)
 {
 	struct ulp_wdt_priv *priv = dev_get_priv(dev);
@@ -202,6 +178,7 @@ static int ulp_wdt_probe(struct udevice *dev)
 static const struct wdt_ops ulp_wdt_ops = {
 	.start = ulp_wdt_start,
 	.reset = ulp_wdt_reset,
+	.expire_now = ulp_wdt_expire_now,
 };
 
 static const struct udevice_id ulp_wdt_ids[] = {

-- 
2.34.1

