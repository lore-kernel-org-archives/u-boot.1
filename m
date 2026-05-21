Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CD8CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 19:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE3F8487F;
	Thu, 21 May 2026 21:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="covXDH6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61F728484C; Thu, 21 May 2026 20:38:29 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7216284825
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YV24Bsx9uEVMSsmFxWG45tkF1Q0Pi5IXo4C64bRNyIB9mJJso/b9qdGpbqhrxe+6L3/4RdPRQ8sewMOkzZMQLciT+f3zSZXoCLhB4JsS8bA13LKYsH/D1lmKr+RBymQ6DXgA1mX3Y4zQXgWrRavuTTBgw5jIUYfBorkBOu9SU8pHs4qkEbQ6IfQ+9g8YKGNY22JhvZjnW+8d4fx3I7pSIJ1WJWoXZzQPCa3LuSJHSzUvH33g1jTczstYAs4afY32RAMHA3Ktr0qYxts0AcAjg8pt68RkqYMADlLbzrZXQeCEZh3g26KH4Tcisca0nJxyJp77zXlAtMukJ6dAIYtS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViKdzuHe3ofY3pBmzE3gsUI1QvZ+aOfwlDGxHbcvakA=;
 b=DFhovuu+GELT5kYOZBqFFossz8ypdDrl0yQHHOl+Z6v31f69BxzqNNzIONu1UV/bCCEouhlT03quSM26ub+cNGWwgSiUsdyqUF/RRcE9fyZioLDHXeAa3UwL6vjK/rydTJuXDWqHqpRXWioE8LmZijrlaP37ROykq6J3hWWQjSC/bY+oD+Ktq+r+OZmm98BjfJsq04+kO5bmOPTFnyQnZrHOt334Zjjz7xcruTMDlIrLJ8IFcckMjYtNuwQOeASeHMM693PxCzFdwh8Ll+cfDESlYBQj+BTStKolabKdGcYXX9BlSUIRiYpYC6JIa6FL+I0Vi2U38opP/7MDnV5ncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViKdzuHe3ofY3pBmzE3gsUI1QvZ+aOfwlDGxHbcvakA=;
 b=covXDH6JZUT7msCK5ls5hVHJDvcDOJLzNcuVmGpd6k6yh6/rsNwgWTNlWGhH/MVqTihRnGRe0te+uJHVuc8RWyX2aWzcKjQHmnW1OPuuB2sHn00M+sk6tHtgz+fgrPUylQ+MIcWQcNUTP7eThIWrAMtDJNMUwqf8Ka9NMqODEaOAY3vRfSNc9kFv9JoNPKpdPKo/dOfWm5C1KNrzBKw2M8KjSArG5Ef3sbuSTU58osTJQ83mgwW9FWYi9T22fvyByeBlJIczuDVIyKvDuc6jEoUEavE8xWFpKRqKoGt4SEXopLxZyLcn5lOKjhSD5aE+Ov8OS2y81jcBbSFXVx9iAw==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 PAXP194MB1486.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:1a5::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Thu, 21 May 2026 18:38:26 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 18:38:26 +0000
Message-ID: <BESP194MB28052BDFBF18D3094BC9E598DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 21 May 2026 20:38:24 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] drivers: watchdog: Fix dev_read_addr error check
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0027.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::32) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <2ab3188f-97ee-4c59-8984-3186940adf37@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|PAXP194MB1486:EE_
X-MS-Office365-Filtering-Correlation-Id: 500dc8e0-0826-4719-f1b1-08deb768251d
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|19110799012|8060799015|15080799012|41001999006|5072599009|6090799003|37011999003|5062599005|55001999006|24021099003|440099028|3412199025|52005399003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1RSTTNCZm8yS2JIT1h1RWFiS0JQU3dQcnp0a3dFaUU3bEZtbm0zdEVJQkRK?=
 =?utf-8?B?Tnh3Tlk2YXhmeTUrbS9VQXp4V1NJOGtrcVlTT2lKdGFCSWhOR1oxVTYxeEFh?=
 =?utf-8?B?VnY1MjQvR1p6OWdrQzA1RE53OHVRZUttWEh6eE9UOG45TEFzSXcyZ21LZG4x?=
 =?utf-8?B?YnhlVkhvN3RBWmhjeVhoZk1OK1pzalZXUElEQU80MUZtOVlMeitsOGtocTJJ?=
 =?utf-8?B?Nm53U2lUSmRoUWJnR0tkRW9SR0FBNnd6emdSQlJUbWljSEhlNmZWbXYrSXo1?=
 =?utf-8?B?Ry9iQkExNlh0TXYzRkZYcml1Uk5hWGlxV0luUnBaU0c5V2pPM1FtT3JCZVdV?=
 =?utf-8?B?c2JIMElLOFc2bXV5K1NvOTJXRE96UHlOZUNaU1pwdERsaUZ4QVhhY2ZYU2tW?=
 =?utf-8?B?RE1PUWRqUWRCeWZJNjUxeUJybHNjSFM1MDhENHBibWtxSUV0WkFnOVZZZVBG?=
 =?utf-8?B?YjY0bXFZV01SdWhhaG9lb1VTejA3alk0RUJzY3lNKzIycTRod2JLRDRGaEFP?=
 =?utf-8?B?ZDA1S0huSzhSQUVId3liOFcrOHJIS283NUp6eUZxK3hZQlpVeEtSSTFOZzFE?=
 =?utf-8?B?V0pyWDR0NThhOVVmYWhEZVExa21ZZTN2cThMcEM1ZjcrZ3RnNGcxTnYwQ3Zw?=
 =?utf-8?B?a0xxSnZPUE9HK3Q4R2V4eUJkYk16cS9pelBlZWZLRTNDd0l1ZEdvM1djY1g0?=
 =?utf-8?B?NXI5bWZLT0lBVFd2ZWR1NkR2VnplOTZMS1g5NjdVaTJETXM3RWRXeVJYK0I4?=
 =?utf-8?B?RkdTVHdDVThINWIwbGw4b0tnK1NDOStnYUFwbURzTDV6bTJqRzlkMTJiZUJJ?=
 =?utf-8?B?YVcwaWxHNHFnUmUyZXBpUlR5d0Y0UGNvcFV5cHRoWEFRVmRZR2ZhM2l6S2c4?=
 =?utf-8?B?ak8vM2ZYSmIwRG1Kdk5JOVVGa24zR0RNdDlNZzlNL3d6SkRYckVERkh5K0c3?=
 =?utf-8?B?NW1yRkN3Nk05SHAxSDZrdzhnd01BZHJONkxDc1h0VEJvVjA4UldNd1dPWTJj?=
 =?utf-8?B?RVA5ZGdWU3F2OXI4Vk54ZkM4ZHN3MDl0VHZOLzAySVMySjlGVzQ1QVVYOGZ2?=
 =?utf-8?B?TjY5Snh5eVdjM09yS3RFb2FZdlJEaU1kNDdpc1g2RFQwa25INHcyb1RPL0Ju?=
 =?utf-8?B?S1ZPWnV2T0FaUmoyaURESlZQalMwZk1Pd0tKSURzNEdOUmd4czdCb3BWTVly?=
 =?utf-8?B?U3pJTzVoU2NLZ1Q0dFFmcFUwamd3L0V1SXRra3VYQkM0Zis3TEFRQkVSQ0dF?=
 =?utf-8?B?WHNJQUlOclNjMzFibnF3bkhiWEZxOGhmYzZmRVNOeUx3N0VlNE1IUUs4VFV1?=
 =?utf-8?B?RlRQVTVUUXJXUWFJbVhwU3V1cXY2d0p6enVHVFF2QUJaNUZOb2k0anV0VUtn?=
 =?utf-8?B?UkRzRndQTVdNS1cyYzd0WlZzanZMNnRyNEJzU0JGQWtiWVNzd09GVSttbng2?=
 =?utf-8?B?RkN2SldzVzkxYUphL2kzcDhwQWpHMWNEMmZqWDB3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUtaczFrenpubkZBdHVvRWt3L0tEelhBazB2YmlYbnNNT0JOTkVUY0RWK3BF?=
 =?utf-8?B?ZnBOcy9Ua0FGMFltOGxuajJKOFVpWUhnNSt6aHlxSm1PeGc3UzQvdno5N3Jx?=
 =?utf-8?B?Z2tRbTNnczNPczdUYTRRNStLSEFrV05jVG9qNnJOZUhKQlpVSVR0cExEU2FF?=
 =?utf-8?B?T3VZRzdoNS9xZXh6L2UyR2dWVXVENGxTUmJVeEEwRVBDSW5FSjVpb0NFcWNT?=
 =?utf-8?B?SUdFWmRYd2hodVJiOXFSaDN1Q0FxTDhDZHhEckV4TWFYTkhhTVBtV3pqdXND?=
 =?utf-8?B?QmVKMHVxdU1PSUFvUDg5Z2p1b1A2d2dCSSsrVFFOZ1ZjR0NiZk5rUWhhWGRa?=
 =?utf-8?B?THVKSDNFaHBmK3BRNHh0dmJnNjdBc2NKaWtuNmVJRktTZDY2a09sVDlHREpW?=
 =?utf-8?B?QlZWYWs3eGlIc2JYaEFzRC82UFpFWWhEU0d0WVpxY3UrbFZ5Q3MyMTdleXRs?=
 =?utf-8?B?bm9kcGhQVlVZREFqdUhjTFlZQ1U3SjA0Vmw1TldkVVVQNzNUb3h4UlZoZFFa?=
 =?utf-8?B?S3RlaHUyVlFiZFhQaGVsY3dSZDFVNmVSQS9jQUgwMzdFdHVyQjRSQVFjL3Jj?=
 =?utf-8?B?TUlpQWFRQ2s1V2xDWkVoSTNUbi9WUmkwTEFVUzdpTTZwR3RxR1A5Z0NONnF3?=
 =?utf-8?B?dHBqNnlnWU9oeUs1aVdxcW9ITnh2U2JMS3FGSnRYRmVFbnlWbnFzQzAvQnhh?=
 =?utf-8?B?S3AxVWVQRmFKMi9YSmc5citDN24wNDE2UHdOems1MXlCYnhHMkh3anhuaGhV?=
 =?utf-8?B?ZDF2Ky8vOEZJemkvUzRHbWQwNGcyNjA1dE5EVEdsMDVsYkdWbmpSSk5QVGk3?=
 =?utf-8?B?aDVHNFhhdWwrZEgzRUh5OE4yOGZ5UGxObHVtR0F0VXpjYXBlYUZnd3kvWWpZ?=
 =?utf-8?B?Q09HcVR6T2tMYW51bzA1REw3NmsrZW9uZTRacmY2eDhYVW9BaGFnWlk0YklB?=
 =?utf-8?B?Yjg2WjdVWUVyak1tNHUrdjFCR0c3UkhZQXB4S0xsdkFCQVlUK3JKS3FGMTQv?=
 =?utf-8?B?MS84R1VIUFVMRDNCS3BRRzA1Nit1SmpJb2poU2hOTzRteFRJWUwwWUVjbmFl?=
 =?utf-8?B?U2NCcVlnNUtTS3RWNGhUT01FMVBZVDRuQ3l1VUw2ak9ZbUlKdWIzK3QrTXRL?=
 =?utf-8?B?MlhPdGhoN3BSc24zcGQ5VncyQkpSWFNQd1NzaGxqczFSYkoySllmR3BBWFNa?=
 =?utf-8?B?S3BvQnkrSysrbUJocDlEZDlOa1FJZlZwTFpPUUd5Y01ydGFhZVdDYkMzeTVJ?=
 =?utf-8?B?M3N4dERpVlpqM09VNzNTWkhGYmhLUkJITVB3UzMyZ3VVSWpObGgvbUJjWVdh?=
 =?utf-8?B?TkN1MUxjdmhHTzVqSGhmd29pYTBxdDR0ZjBOV0d1TSt4d0pEL2xMVFpZWnV4?=
 =?utf-8?B?aDVYUW0zU0ZmV0g3c0NxbDY1WHVsVFVjeTZNTVYzTFFUMFhwT2J6clhBMFAy?=
 =?utf-8?B?LzBPOW1GbGFnZDd3NThJT3RQRmhPa201V0sxNnZtZCtxUjhtSzVrMkFtQkhR?=
 =?utf-8?B?Yms2djZUdU8wbEhCZnRIUDRTWGlvNXBjS2s4SUhrVFUyeHRwSWsxK2tqWUx0?=
 =?utf-8?B?YU5xM0trUnUwTXQ3RE9WM093azdCaURFZEl1SDhWRWNxZ1hiTmhiZ3J2UXpy?=
 =?utf-8?B?eXhIWTRQR1BvZW1CSFZ0ejFsWHNRNmxVRng2VldTQ0lHNlJ4V3YzZlNQcS9F?=
 =?utf-8?B?UXdGbEs3ZHp0YWU1QklyOVYzdDZpeDB1eFRyM3pFTWpVRzdaVlcrTVNlNVNT?=
 =?utf-8?B?NVY1RmNJYzFDWUJPNVBNOFJpSHd3R0NUSTIydE5tejRWWDBMQW0veEUzVC8z?=
 =?utf-8?B?NFFyMGxqczlDMkhxazV3Y2ZSSTFnMkVSQlM0elluNGpKc1VZeWdmaDZpMFIy?=
 =?utf-8?Q?ChsSqgxiZzrRm?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 500dc8e0-0826-4719-f1b1-08deb768251d
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 18:38:26.2346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP194MB1486
X-Mailman-Approved-At: Thu, 21 May 2026 21:11:12 +0200
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

dev_read_addr returns FDT_ADDR_T_NONE (-1) in case of error
and not 0.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/watchdog/starfive_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/starfive_wdt.c b/drivers/watchdog/starfive_wdt.c
index ee9ec4cdc3a..e0b46d146a9 100644
--- a/drivers/watchdog/starfive_wdt.c
+++ b/drivers/watchdog/starfive_wdt.c
@@ -291,7 +291,7 @@ static int starfive_wdt_of_to_plat(struct udevice *dev)
 	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
 
 	wdt->base = (void *)dev_read_addr(dev);
-	if (!wdt->base)
+	if (wdt->base == (void *)FDT_ADDR_T_NONE)
 		return -ENODEV;
 
 	wdt->apb_clk = devm_clk_get(dev, "apb");
-- 
2.43.0

