Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C13CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 21:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3524584812;
	Fri, 15 May 2026 23:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="oQYzoSgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF5D8484C; Fri, 15 May 2026 22:35:09 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d20a::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ACD484713
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXS+mvxG9JsUWa9kXyjUrekGFONihlgzQZk0B6GpdSGyteYfxaUbejbES3BVjw89XRqmsuBJTSfBw7/bdIv5Q3DTJKdNyAVLMONnTzRH6deH/aMHZgp9yHsTmwSg1BaTQHSWhSiGjHKgeggr/9mgzgi8H1BnlgJS6SmHlSd/GUtCWND2lsdQ7+69ayv1g/GPeFPzuH0OZOKr6YEL41nB9PhAXedzmQKPeXCcFcHJAb+yqKDD8p/N+yHRvV4FfGt1U+a6bIq6UxMLNt1m9C7GctUN9FaqfEmlgEZIaYKGCw95K7uP1M1fIsBbFCKbUhFvnq1RRh/CbtPKqE4XMjA0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CfT1cVmSe9sdJLED7Vwi9d0KEfu9QP1YBpyEwSomDM=;
 b=eXhW3HPBe+D8CRJWlajPVf8vlebqAOOM6TmWXfKtIPf/5VPBSrtGk9IOyY4olEFv9u2wtLfw6WKhOAhDLF6XWQavQkO3+l1hcasabmcJQfy6pRWNxjt1Do16sT+zZTjtjDwz74PrQNJRAUbFl8PUoJ31Ar1A0/4ghZTSq2nFJPD+VK1hiWZPgmbUf802NLknWlATOs24vloN2JPnWIjYuhYVu3G63LocnZBsOs+Fnr3x0fOefOuGE05WdZC9o8UZ2o7qCGqWFBQPRUug02KwmH2NoG5BEtffK6zE0iIqERU5Bp5jS/EX95R/9MZb4q8/JaOFWXA5WPDLkJKqvXEORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CfT1cVmSe9sdJLED7Vwi9d0KEfu9QP1YBpyEwSomDM=;
 b=oQYzoSgyG3FCKgFDIt6W/oMcNRCFFfyR+1Rt6xCTi2EZ3YJNAMlVn2mGBk+HNytm2xoKzqKv7d3R2HWogrFa8jVwOAZbvD4FwOUfuN2lQy8xOy0KyyF1GyQ3epxU2hVUjsLqIhCzTaSiu/Kk4iXnkqOhkAZMTK2kBy7H/PNN/YVMd8SE4uoEwqNSheI1El4RW3yYnNGOvTKTFHOo4dwy+5xfpzPKlYuV3I10dUP3QYOJKBz6gTPRNMk7zbvCvTnAklWSFirY4p3r9+D2LiCgE3tP1HR2jzZM2aal7dPIOCc9QMHe1x2hYE0yDUFfuL2L4ZnpVM1WvLvTFG5j+12QlA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 PA4P194MB1101.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:c0::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.12; Fri, 15 May 2026 20:35:06 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 20:35:06 +0000
Message-ID: <BESP194MB28054DAF4BE907B3744B9919DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Fri, 15 May 2026 22:35:03 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] boot: pxe_utils: Fix potential initrd_filesize buffer overflow
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0261.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375::12) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <9292cbeb-610c-4866-8b58-7fe3260a88d9@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|PA4P194MB1101:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2ae130-b31f-46bd-371c-08deb2c172c1
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|24021099003|8060799015|37011999003|55001999006|5062599005|6090799003|23021999003|19110799012|15080799012|41001999006|5072599009|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N01udzBpbmZaRzNPMVFIRFBQbXB4c3FNclo5UVlvNVlpQml2YmdoanFDQk9s?=
 =?utf-8?B?VnE4K3BNTGI5SnVBaU9kNFdmeDhUMDZOb1kxMjkzWEVUOVorb3RrRng2bUVE?=
 =?utf-8?B?VFNIaEdaajdvR1RqM25vK0dTU0tCc1oybzBUcEN0TEl3dmJ4cHpseW1IcWh5?=
 =?utf-8?B?MlR6L0Y0Y0g0VXp3UTF0Y3Y4VnBEZ01wSE9DUEY4Nm5OUDZhcS8rSUpuQzdP?=
 =?utf-8?B?aUd6QUV6eWN1QUd5Vys3czZyaWpPcTNMYVBjS0wvZmdsTXovL1hDQm15Nm9K?=
 =?utf-8?B?S0s3Y3BxdE1xeEpCZFJrNi9aV2w3N0toMjJZU3YycGJ5Rkk2aEYwK3RocXdS?=
 =?utf-8?B?YnpUUi9MWEdJUXVaYXBSUlpjZllCTDg3S3JUZ3pPRDdENGFpNFdPZTBiQWVC?=
 =?utf-8?B?dmF3cXhnMEFjQndFa0ZGdGxkUDlMOThyTk04T3cxR2RZSm5xdWh0KzdjcWlj?=
 =?utf-8?B?YmNsRUg0YVczUGZyZnZrN2hwdkFIemlpMmNUeGZZTCtGOFA1bzZiTjZNN0U0?=
 =?utf-8?B?cGZvRVlkTDdSbkpLS05NaUFqamtZSUppUjJiclVrQ0pqM1lBQ0ZlVGowSXY2?=
 =?utf-8?B?NThrWHJMbjZTQ0c5bk5ZUGVFK2grOXNMSVU3VmpPSElhYWlBcnNjdjk3ZVJa?=
 =?utf-8?B?OGFBaVVTSDBiUnRNa0dYZWxYTkQra3RJK2hrTTczSngyM0pLME1qTlFpM1dL?=
 =?utf-8?B?RnRQYjlBR0JOVDF0MFVHYXg0VnFmRUk2b3hFNWJ4Nk53WHlzZEFsd2FQRzFk?=
 =?utf-8?B?NVhOY3ZPS1d2eE9rRnVqZ3Jsc3V6Y21QdnVUUzFwOWNFTmQzOGRYWnBOQmhp?=
 =?utf-8?B?bkhVSHRQWmtha1lERlVML00zV09xQnVJd0NZbFZkSlNHVGpFd0kvRkJ1T0Vv?=
 =?utf-8?B?NWhxTW1vWmxaMjdxVEsyUWNNYlRScjh3NUo4SjhNUTBhY2E1QWdaenNsazJh?=
 =?utf-8?B?Vk8vaDU5YndUU2t1eGQzTXFkYjV6WTl1aGxmeEJpWkFwWmx3NEhvZnJQaGFt?=
 =?utf-8?B?S3c3eTlEVzZ5TllSR0wydFovUEFSZzE4b0tyc05EZ2xwbDduTEFJSEoyeUNr?=
 =?utf-8?B?YWNMcVByeGpTckJzWWE1WVdGS1ZhQXlYaUt1Tk1IK09hVTY3MmkzcGtUK2RU?=
 =?utf-8?B?b1FFcXhjdG8xOWgzR0xORk5aVW9NOXJFTXRJYTV2WC9QeXdab3ZHWm1mWUIy?=
 =?utf-8?B?L3BQN1Npc09TTW1PNE5LU01OWWhEOWk5WDdpTElxaXprYWM1Ym5HUW9vcWlJ?=
 =?utf-8?B?cU5nSTk5L01wQ3p2eG5ZeFYwMzZSbVNTNlhwMTNKTU52MmNFZ2p0WTh5aHpm?=
 =?utf-8?B?Ri9HVWhWbHZ2aEVUeDNldTBwcnlDUmJPSFU5emo5Ni91cFZsZUNteWx0VXF1?=
 =?utf-8?B?M2JrZmJkeURnQno5cVYyWC9mekM3cFpIcEJlV0NkWWFwZThQSHM1MVhpb2lY?=
 =?utf-8?B?bk1uMHJ1alYvaUwzMVV5aHNSV1g0aS9aVHZCMzhnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnFndjJucUIwakFuU0JFSEdxU2Rha2pnSGVidkU2K010UjZFWFRUak40TndE?=
 =?utf-8?B?NnlzNzYyVTNmcWJoUS9na05odU1RZHZwcWhhSis4SWcyTVlFT01tNjVacDl3?=
 =?utf-8?B?SW1ORFpIejlXdytuWGU0ZEh4MTU1cmVNRlNZRDZjeTRLRElrUDB1SFJSd1Vo?=
 =?utf-8?B?ZngzTTM1OHJDdElWOUtySVZoMU12aDdCYU55OTFjQnNzM0J5WnE2R1VXSnVF?=
 =?utf-8?B?TC9lNERrUm9FeDVmNTFtYlBsbGtQZ0NMRnJuUmtSODJkZ1p6SUxub0tuNnhm?=
 =?utf-8?B?RkEzbDRPNXRvQ05JaXZOK3Z1Nm41VDdNZkpQV1FYUGVuOTBqM0ZQU1RYL1c3?=
 =?utf-8?B?eXpLbW52NDJ6YnJFd3c3YnZRbUFxVUtXaHlvSC82SmpIZWFWVGxUOTI5MjVv?=
 =?utf-8?B?UXpNRjE1bUlHWk1uMWFYM0VhWXJrTzFwSWJYL3lNamJ3d0ZoZno0MFloYzBF?=
 =?utf-8?B?TWc1cEVORy9ibTd5UVZsMTM2clVxaXVkcXhFLzlWUXhoQ1c5ME4zRkx3cmR5?=
 =?utf-8?B?a3lqRUpGV053blYza1JTSkk0eEpqTmozYzhTNGZzcmJwQ2ZHbXBRTnZTY2Fn?=
 =?utf-8?B?OVc0ZXViL0RRa3NSYkxvZytwKyt6MmEwTWxQQ01xcGxOQTJGYTZLQkM4QURC?=
 =?utf-8?B?WTM2VU5vdkZlWWc5UW8wVFNrUGlJK2RFdUR0bjlsUjc5a1JBcElXS3JrM0VI?=
 =?utf-8?B?clV4NGg5T0k3d0RVWnRiQ0xqZFN0bWFxcjIwL2F4OGk2N2V5NTQvQ0dHZzhL?=
 =?utf-8?B?UEYwb1FINm9CanozVEkvc2V6bjIzVXZleGN3QUh3c1Z6UXpSaldEajNuOXlv?=
 =?utf-8?B?cGdPeFNsc09aRHYrQmNJc2Q2ZmJyVHBUWlZSSHZHdzl3QXluZ3M3T3BtU0Zo?=
 =?utf-8?B?WjMvWmZMNUczVkpWTXl6N3FUcjh3dDBzL0d4RG5uNnFvYm01UjNEV2hremlm?=
 =?utf-8?B?UDFqbFRBeDV6UTljbnB2blZuWHpaMWtibGFHckoxMXlabHhCVkxuOVJPRDZV?=
 =?utf-8?B?SVV1TElhanBXbzJiRjVCYXdjZ0RXbTk5RS9FNXBUSFVBWWVrdFhnT3pKMTgr?=
 =?utf-8?B?aFlRRFl5V0pjWEVwSWhHa3JWZUp0SlFXM2xMV010WG5yeTBUT3NCS0FOQVJx?=
 =?utf-8?B?eWtCVzVKWGl3T255R3JMRlBIODcrNWJTK253TkkvcDU3bWFTUG41K0poVkNQ?=
 =?utf-8?B?ZE5Ob0dJaVh1RFpQQVZYb2ZWVXZ1VmlmTkFiRDFoTjJQZkVPZHZlaUZXN01J?=
 =?utf-8?B?a0t4V0gzNFQ0elBrTHdCb2tyWVBtc3phYlUxZ2xzK0RGTkxzZVpsVEdVUlBS?=
 =?utf-8?B?ajluNEJxd0p4SDVmS1p3cFJwTHk2UDZhWDFjeUZLSXVrSFZTMGgvRm9sWVpQ?=
 =?utf-8?B?K0lSSUtNSFdBY2d5bXpYSHBycnYvaVVFVmR1Wk5UTzRMMzl3NVd5WkxMK0Ri?=
 =?utf-8?B?RHp2SnVMcEVoNmhab0FTeEE3Rk9WUS9NS3BGdFhQZXBveWZ5QWxFTTl5RkI1?=
 =?utf-8?B?TEtjeFd3emdjbTV1WVhvZnpJV2RQdmJYYjB1VG1EZjc5MmUwa1orN0R0eDBq?=
 =?utf-8?B?TXRVNGZ3UGM0Mi8wNzJCOW5DZVIzcnpndzBNYUNPZFZrZGxDMXpvWWNIckYz?=
 =?utf-8?B?c2lONmlNUHFqOVJsa1RXT2M5bGIvdStnUGdaalRmbGhQYUU0Si9LaEZUVC9N?=
 =?utf-8?B?MlpTZFVxWmI1Vnh2VGhwSmlLdmhFdlMrWDlSSUh2UCtrY1VqQ0lwWTZaK0xY?=
 =?utf-8?B?bzY1dTBGdHVraC9pM3l2THNlcUpKdHR1bXpiNWNxcXhRWmczUThvZ3NnQ1pR?=
 =?utf-8?B?b0V1QjIyWjAvOUM0ZU1YUUh3cTEzdjVRNDl1MUluV0dzcWo5bkVjM3FJSnh5?=
 =?utf-8?Q?lrYl3+S+QVWcz?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2ae130-b31f-46bd-371c-08deb2c172c1
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 20:35:05.9906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P194MB1101
X-Mailman-Approved-At: Fri, 15 May 2026 23:29:57 +0200
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

ulong is 64 bits on 64-bit platforms. Hence, simple_xtoa can
produce up to 16 hex characters + NULL byte. The initrd_filesize
buffer is only 10 bytes which can cause a buffer overflow on
every PXE boot that loads an initrd on an address greater than
4GB.

Increase buffer size to 17 bytes to hold the maximum hex
representation of a 64-bit address.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 boot/pxe_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 419ab1f1b0e..8c1310dabeb 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -546,7 +546,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
 	char *kernel_addr = NULL;
 	char *initrd_addr_str = NULL;
-	char initrd_filesize[10];
+	char initrd_filesize[17];
 	char initrd_str[28];
 	char mac_str[29] = "";
 	char ip_str[68] = "";
-- 
2.43.0
