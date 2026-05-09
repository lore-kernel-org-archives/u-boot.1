Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC343CD3447
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 01:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D77B684A20;
	Sun, 10 May 2026 03:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="meG3MKgA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7715784669; Sat,  9 May 2026 19:30:58 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d20a::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A2284374
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 19:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZvfFhMqPO7VHa+N2ff89e5yBzydV9A3COVE3BO54w/uJha+7yCV0WifS+5FE2rWCxhZTIdLo618C8pYT+zmTuNJINZKFRM4NGjE1uml4X+gk5nXd9AKe0teDF4vkAs521GMmS1pMLQWsfJRatXy5zNMK1kRH+RzHDN2VaxUsZPTcnTJkavp8wThb8Tn1DqxKfQm9Cs5ItZxa6Ros9h8mrLh043s1Lwh5aKFnUwqI96mI+w7zlcX13RaArDRrh6BcPwiPp+r0NkjE2tXKKEHYYv9ICUlXXrelUZ6vvhP1l433JMjIJH9LuONu9UTh9fWb9Ni6w0bQToAhrzteGlQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PlKtrtl/DV+ilrdgyq8CuwkY6QHwjmOz0YltWZ2jwk=;
 b=ok1BnbkhRNnIRtCD3Zdoz/Qwc5/OWzUvfPe1U6gCiNurLqwTXn5uYADhXhAeSgvWbav1uSF4Y7ORGi+qejhLkQRzRgInrwbgPqCCrb1BCikOceGhDjuPKSTL0LMu/j4Xdo724ELQDczVALDDFOnPfX0+lGj6O+VNo/dpIaAYQA6Tj9Gw2ZrOlVIoG1ulcyr4cuNqPZVjIDBw4zJy4KlAH6IaeTEKxuvcMjBYowyfTXgl8UAgoKlcQb3bdAQkXtgFir0mP1FhJhwsLnmj6od64rMuoEKUubC+Nop3XJYxuc7jD3eXeBDQRFHxIrxuCYjpzHFa461HCZfl81yN8AGV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PlKtrtl/DV+ilrdgyq8CuwkY6QHwjmOz0YltWZ2jwk=;
 b=meG3MKgA1drYvFNpDAdA+b2RveAo0WRrDbyDpUhRwyUSnPEGzz4LXGDPToINyQa6S5sPL5gv+8O1/BvX/EBFy4eEwvCJ9KdzXB1k+FryFXNZ69sa9642JV7H4maDpp1lGcwy++qOBOPr5aDV5N3LRlXHoQbfKwRYBfU/MBsK8WJcJ4ggtBW/05BcDpbfKK1vs+jUzRkjqHUnOyjTaMDMAuqobTA2zS/+di+TRuXkHilVsVXAPza6QLWtN7jRsqSgWsqFl245ClqkFMT/RjENxmHkG3OnZNQ6eXlT/iz8rXpUkQ1shxxe9Fsa59lX9aOYpUA+RUEFc1NmFiU20ypirA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AM7P194MB0772.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:14f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.21; Sat, 9 May 2026 17:30:55 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 17:30:55 +0000
Message-ID: <BESP194MB2805FFE6CC316B1923542634DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sat, 9 May 2026 19:30:53 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] led: Fix toggling LED on initial SW blink
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::17) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <6149cd32-7ec1-4d5b-97ff-0c3ed7c9e094@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AM7P194MB0772:EE_
X-MS-Office365-Filtering-Correlation-Id: 42362825-dfa7-438b-3d21-08deadf0b9c4
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|37011999003|51005399006|24021099003|41001999006|23021999003|19110799012|8060799015|5072599009|5062599005|6090799003|15080799012|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2w4UXlnd3hQUDRCM0gxRDc2M3h5WFlmamp1SzFtbmsxYkJJa09Sc2VIa1ky?=
 =?utf-8?B?WXIrSHZpMEl1bzZIeTg2aTFESThKY2F3dUkvTjd6OGdpcFN0NVdvVDNDZVdU?=
 =?utf-8?B?VGVqVmw1OEMweWtCZU9yV0hVVlJjK3ZhWEhmb015SVdibkhlRlg1cWVSSDhV?=
 =?utf-8?B?TkFxTHJncTlxVjRtZjFTckRzMDkvSkRDd0tvZ0NkUVJjaHNHZWlOMHlTSGUw?=
 =?utf-8?B?NXBuTUNJOXVzM0N2N1h3Qk1NTzFzbWdtV1dtcWlrOGN4YW14OURtL2YwVlI2?=
 =?utf-8?B?VUZvSDlZdjFRZ3UvR25ic1FMQnFScUZhMTlRcW5jN0M2aHpuaDBpUUo4c0JK?=
 =?utf-8?B?b3lIc1ZrVU9BakplV0p3VGg1WFpzZ3RFdS9CS29pRnA5bVdkUEhMa1FXWGRv?=
 =?utf-8?B?aUtkZ2lXSjJtUGZUanZBdzZOUU0wV3p6YmlsY1JHd29od0F6cW9YTmoxZC9a?=
 =?utf-8?B?UFo3OWJjTEVpTi9yTVExRGtqU2wwY2Z6TVFycWMrWkVTY2tjN1VqMVc4VlRH?=
 =?utf-8?B?Z3JYOEJSdnpMNUJFK2JGRWsvS3hQMWl3Y1ZUWUFWbFhwclp1emhtQ080Tzdh?=
 =?utf-8?B?Y2JBMWxmQnN4cWgzOUVDbU5ObTRUdS82OS8rNzFOVUVIVjgxbkZoa2ZWWTcz?=
 =?utf-8?B?ZUw5VkdLNlRYQU5uakVRT1pFNjkzMCs5WVMxT2pQOTJPdXNBRGhlYllFWG1i?=
 =?utf-8?B?MkFabXhjVDhmdmM1cElNTHhLenk2K1BVWUFJMUUxOS9LRWJIcWxMeCtzZ0t2?=
 =?utf-8?B?Mk5sZ2Fpb3YySVhpaHk5NDZWV1VaOUZCYVhpMHRyOENjUWRUQUhMUXFJampl?=
 =?utf-8?B?K2JQeWxoNVdqQzhtQnhiM1ZMaXc3d3JuaTZWbm9QVUZFbjRzNmI0V1BiRTl3?=
 =?utf-8?B?UHA2NDVySWs0NUdPYmJHMjMvbEU3WmpSeVAzR25QK2liZVcxaWxVVStOalV0?=
 =?utf-8?B?cDRxS2xYTldERVBVdWRaQTNIMHlPb00xcXlQTkdnN1ZIeVR3MUZZTW9qdE1U?=
 =?utf-8?B?L21xQXVlVUFuMmF3L1NweStNblhpMjh3b3ZGNnZaOHQxa2RYRDZGU2ZabVpB?=
 =?utf-8?B?MG91K29heGdmblJvZ0JJZnYwbWQ0VTQwVi9TWmE3TkhCRlRndDUyYjZGaWd3?=
 =?utf-8?B?eFE1aHhmdVNjTEZsWmo4eHVmaHA4cU55RFF1Y0V4Z083Y3dYd1FtRVpFRW15?=
 =?utf-8?B?MzFrMzMwcXpQVVBQVUtSMDcwVk45RkFOeTJiVjZib1AweDIweDhEbjlrZWJp?=
 =?utf-8?B?SE54dHdETkhDdXRuUnk5Rzd6TzB1dGVMcmpsb0g4aVk0OHV1RnpMdlp1S3hL?=
 =?utf-8?B?V2c0clUrLzVZZCt6Mlk1UFNXcHN0Z2lqWGdtMEJxZ0RIUXVRTW1YZlBSbUIz?=
 =?utf-8?B?aDFINWlHbXh0SmxKRHhaVndLWDVaSmoxVGZ1c1hvZzQ4WVpGKy92a2lCdEdI?=
 =?utf-8?Q?Dj6not1y?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW5RRitOV3dEYlFLVzlJYVIzUHVQeHkydkMvVVNGU01XQnk1V04vVmRXakJX?=
 =?utf-8?B?aU4wRGt6YnA3TUlCTjM1SzNmOFUvMERRWVFUOTUwNlVWK2hxcThneHpTaFhm?=
 =?utf-8?B?anVCMW9uVHVmUitwWWNGT245aVRNdFp3a3FCTWNNZ0Q2SFB3czhYYVVkR3h0?=
 =?utf-8?B?SHFLaE1WQ2sydU1xM1Y0NFlxREZNcCtTVGhURE9aVGhHdE5jelhSajlQNXRB?=
 =?utf-8?B?ZmJDQzZRNGlSQkdlcEp5TFd2N2thMkN0VG8xbFZ0MitaZXJSWHlkNFpGbWR2?=
 =?utf-8?B?ZHpNbjZ4RkdsdTVteDNwalpkdmVrWmZmUUxFc1ZndVNwUzVXbS9TVEFLREt5?=
 =?utf-8?B?T3F0OHRVQi9oK2FOTkJjY2xpUXpxRHlxOUVnb1lCSnRGbGRSaEdITFJhL09p?=
 =?utf-8?B?WVV4bS90L0wzcDgxTnBXR2p4akFpMUc3S1hoNXpPSzcvUEdEUHN3dWY0Qzl5?=
 =?utf-8?B?RmRjQXhZeEdFTXV1Ny9PSCtsME56RXdCUkhzZC9YUGhrY1JhZ3FWZnVNckNV?=
 =?utf-8?B?MUlXZzlBUHBPNE9oSFBqNVV2cjA2M1IxWnB3b0JaaHk3NnpmRCtic2Q5eE1i?=
 =?utf-8?B?OU55ayttQkxvU3ZHbjliL05xa25FNUlGYXFCTXlNNnZpb21CdE1hcUpVK1RF?=
 =?utf-8?B?WTdpWERqL0l6Q1lncExyaGZ3RkJZTVBaZHRkWm9NN1NjWUl0MDk5RTZpc3JK?=
 =?utf-8?B?cGozdVAyNGFOd3ZCYUJmVE5iY2tVWXVaSnFjcTRnb0N1OTJ5OWgyeXc5azJr?=
 =?utf-8?B?VXlEQnlmNTFLNTh0UkROeWxad0ViYVJzWDRrN0h1M3Y4MGQrUGo4Q2VlNTl6?=
 =?utf-8?B?TVd5ZzY1dFFIZWd4eEZidHlQTmduYjBWMVFqWGkyUi9lcHE0WkI3Z3hBZlpu?=
 =?utf-8?B?MTFVVVphbDhYODRRazMvUFlWSUpCTWJZdCtMYVc2QXJjV0xkMzBFa2ZROGlG?=
 =?utf-8?B?NFJYR1M3RUowbXJsVFNERm5ta0VWbjd6aSs5TmdiN1dTZzNOMFlIdXFYZjIv?=
 =?utf-8?B?OUI4Q3Nsa0VzeXZWdGwzS05Gdk5IZ2dBK1dCTkVyT0daNGFFeXJxMUtVTGVO?=
 =?utf-8?B?VVd5R0docU4xaGdxN2JWTkpwa2JnRTlTTUxjazgyellWVXd2NmpRUWJLZi9p?=
 =?utf-8?B?M29ZTEt6QS84Zm9yL0ZxK284UGlDVDVHVTVPK2JiejRjRy9FQTQ0YVQ3b2pq?=
 =?utf-8?B?U2wwV0R5YXpjdklEK2pqRDJzaFBZcVdFRDJ3MkhubGhIcDkwenpkYWRRVW9P?=
 =?utf-8?B?M1c5Ly9iVjl1Vmp1UkhlcUFkL2NucGxOcnRiN1RLZzVCd2k4Qy9kMVRVNHVs?=
 =?utf-8?B?UlRJclAwT1NoUTNyM3l1dEVEYkI0ZkQvMnM3SVYyeDJ0TGVBYWpGKytxeFM4?=
 =?utf-8?B?bFVtdEx3YW92Wm42cW5BcThNYlN5WU1zV0wwT05xYVFybEt6MFJkcnpjWnBK?=
 =?utf-8?B?R1d4THBMMHhKSWxYdlc1U3ZUM1l6bm10ZkdnNWk5YW5oSWxvcTNpN09XZ1B0?=
 =?utf-8?B?c2VzZmUzVlBiVEsyYmtSY0hqckh3czI3ajd2UXk1QkdORzUxQ29VZVphcTly?=
 =?utf-8?B?b29kU1labzZUYmx0UjZmSHB3YUY2Y3I4ZHJKQTkrWjF5SmgwZ0lKek1vaGps?=
 =?utf-8?B?cCtNTGNpaEREQXFJSTdYM0xveGc1MUYvVm1Wbkx1SlFhTUFNNklIY3JacGZH?=
 =?utf-8?B?YzJ6UjExQ3dQK0x3cHlQaDBjR3pwUkFJcXZVY090eUdvYVVIZy9pNUhQUEpM?=
 =?utf-8?B?QUFLVWdkUi9ENWRUTFQ4eEM5bCt4bTRMMWQzNERUZk9nYkV1K1lpd04rMURs?=
 =?utf-8?B?Z3BhWlEvd2pYdnhJMW5jZ2VmRVg5VHFvVFEwS2tpanBDTEVNdDc1ZmZqUXZX?=
 =?utf-8?Q?yjLCvgOzmKagP?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 42362825-dfa7-438b-3d21-08deadf0b9c4
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 17:30:55.4988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P194MB0772
X-Mailman-Approved-At: Sun, 10 May 2026 03:41:44 +0200
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

If the LED is in the ON state, it is briefly set to OFF
then to ON immediately due to falling-through in the default
case.
This commit ensures that no fall-through occurs and thus
a LED initially in the ON state is turned off before blinking.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/led/led_sw_blink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
index ee1546d02d4..4190fde8f0f 100644
--- a/drivers/led/led_sw_blink.c
+++ b/drivers/led/led_sw_blink.c
@@ -114,9 +114,11 @@ bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
 		case LEDST_ON:
 			ops->set_state(dev, LEDST_OFF);
 			sw_blink->state = LED_SW_BLINK_ST_OFF;
+			break;
 		default:
 			ops->set_state(dev, LEDST_ON);
 			sw_blink->state = LED_SW_BLINK_ST_ON;
+			break;
 		}
 
 		return true;
-- 
2.43.0
