Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BBAD12D55
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEE183FC5;
	Wed,  3 Dec 2025 13:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bum8AOhW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 343A683FC0; Wed,  3 Dec 2025 13:22:48 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1322E83F89
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpaNVJ4F1KYvzeA6/W+mxFeRytxL3WLBapvI2gIwvpf+tn0RBBhtoBnuRoavJ34QZUk2+/4o7yFyDndLcr0854Ts0+d5rrYvBUF01IFxJ5z4JK5CoHtzJu5M8Tf36qeCyzHG2Vh6F0Hd4/F0uz9lTxO9aEUDKPseA1IIev8ZsxW13TiRPTltrge00B5rBSLt1NO+muwEj00JBTUy0BD1DchG1UzGZ7lceNHRQzy0/4DH7+xZNZtm3cdS5wru5cGRorlOe4WlLJfkr8HJ2HJ//psdYnvMZWW4R6EOvWgL4xcR5p4hjkGOc0B8VRcHCVHNfJ4FSgr1Mj6OL24LZPonCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1If6xGK93AbNY6MK2P3LqypQnJFYLR1AJMRji7/RH3k=;
 b=EbHS9lHiHvS0H/A6A6jw90UWgF/ZzWSAyI7uMN2Jn9pmP6Puz7qsg3CTwVduHkIN4dEd09LgVJOAgoJ9DKF18Dp4h8ZiZY6jTkJUC0XaY/6KcLUJxlBd8VgPziknXd8FN295hOLk25EawjFadchAVQ7mpFKQaQHMN37AkDbJLO+ykv87cRITYfLQOTfL1PdLWuZxN/XDhjl22eYGEh/ethiNj7RIY9IQ93NoltLQtRzCFJU4UiztAOmwCdkhObQEf1ws/c2xAjJyLqXnOKALi5zpbb7f/Qz6Z6oRtLOD4UepcJQsRsBW96rmnzmljEXfolRKID1BuNkNzDgkWzXigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1If6xGK93AbNY6MK2P3LqypQnJFYLR1AJMRji7/RH3k=;
 b=bum8AOhWQ7dvPiFg9pBGruWF1ou4ZNRcsQGdqmhA97ILkO6Lv8OcOeEdr6UYZErehDi5wqKbbU9MjIXvTUKCOvn06NZexpIG6ReR3di8Y5Pe6LbR2djgj7SKiuj6FGsEar5RO7RceVnRJF1H42+nlYLvwJpBd8s3Ewy6YeOihfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by VI2PR04MB10833.eurprd04.prod.outlook.com (2603:10a6:800:27a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 12:22:42 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 12:22:42 +0000
Message-ID: <53b69ecc-0fa4-47e2-8a79-111b4b3a6b18@cherry.de>
Date: Wed, 3 Dec 2025 13:21:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] fit: print conf node compatibles + use property
 string constants
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
References: <20250409-fit-compat-v1-0-56df89ef486a@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250409-fit-compat-v1-0-56df89ef486a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|VI2PR04MB10833:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfaee04-53d8-412f-69e9-08de3266a83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3dvQVFZWHdpZmNaT29JWTNsU1haNHR6V2hNUnBjUG1Ubkw4K256eC9Gd1l1?=
 =?utf-8?B?dzFMNC9lSDB0aXJsWktnNWtNaldYUzRrQ2k4UDg5d05jdmFFVjVSQzUzMGJG?=
 =?utf-8?B?RGtHcmprRlYxOTMwZjkxNWVoSW1xajRDNDN2Y2p5dURKazY2eVdOVVdhdnN4?=
 =?utf-8?B?dExTd0xrK0VaUElmaVp2dDZkbmtTWksvQXRwVjF0SFBySEprMGZFY3JQN3Rp?=
 =?utf-8?B?MUtFU1FkUGhvNFZDSlZONkI4RTk4aTMrelB0SjFiY1Jpek9JSE1xdE0vRlZm?=
 =?utf-8?B?ME5JQjBvQ3M3VWtOckpla1hIVFZWcWEweGVIcVlLdDJoYXlXczZsRTFUbFJH?=
 =?utf-8?B?UnBwN3o3TGVmWndIdHozUDg0YU5LWTZOZHRiKzdnWGZrNmsrM2RDLzV3TnZE?=
 =?utf-8?B?aDVhNVhRRkFqMGFseXJpZjZuQytQakZZQlNEaUQ4dXNhMHk0bU5QODJ1NEJo?=
 =?utf-8?B?ZS83T0dPRXdUQTFxVEZTdFNBNTgvSlIwcVlWUFRqVUV1ajJoeFY4WXYxWHFm?=
 =?utf-8?B?VVNuRVlvdFJLYjN6VU82UWIwTlpRQTFZVnVDVUVyQWtKTkRoVlN5cU5sYk1z?=
 =?utf-8?B?ZjBWWC96a1huMGVTRThTdjRtVTNrUXBBWVloQ0V5VkY2UlplMW9oSmhKakJ4?=
 =?utf-8?B?ZnhnZUR1T2JNb2p4S0dmS3BwYWk1R2RDS1REdFBEOTE4a05FMTJwNGdFaDBT?=
 =?utf-8?B?TGJlemIzWEhjK2t4U0lCb2dNYUZScEN5UWxYVWZ4MExQM3B2SEM5YnJWTlZ5?=
 =?utf-8?B?OGllVkFvWTNQM2FSSjBiMU52aUI5aSsrdUVlM29WMjNBK2lVYkZLaUJGUDJh?=
 =?utf-8?B?VXplN2wrQmRSMHF1M0R3V0N1Z3IzT0NsNUViUkdHOExLcVlJODA1dTVTR3o2?=
 =?utf-8?B?bUtYWDV2WkUyYytadUN2c3ZKWXRTRytsWmp1aWFSb0phQkRmcVhUTnh6NCsy?=
 =?utf-8?B?cldMSFp4ZUVBYmtQc3pIM1pPRnZxSmN4bm4wTGxWdnNFeVlNVUFxUnAyTjRG?=
 =?utf-8?B?OXl5UC9haW1aYjhzallYT3FCUm5jM3BveHhseWVURTJTR3Y1di9qN1h0bkxG?=
 =?utf-8?B?R0pISUNJNE56cHc1QTM2Z2RVR3I2eXZwLzJsOWhxRXdqR0kvSTNRYlFUZEpp?=
 =?utf-8?B?N2VQaXl0M0hPNDRSNnNMTjhCeFV6NWtmR1ErUHdpaTM5NU1ES3EwQ0ZEc0NV?=
 =?utf-8?B?eCttalJicUtKUThDNjlJZmNpSEdxT2dlN0l2N1pvc01wZUpXc0hmWFJ1djlU?=
 =?utf-8?B?M3MzWjNwYUE0UEt1czViM2dBWk5LaHBkeDlmb2JVWkFROXgvcllKTDI2T3Bi?=
 =?utf-8?B?aHpKOC9sL0ZIZ24vZG5TQ1JiNGZtN3A4VHZ2amNVb2VIR1ZjRFVhdm9sOHY3?=
 =?utf-8?B?Q08xWXY4ZWZscVkvNWhqTFdqajZyQzBPM2IxeHRYWmtlUGM5YUxKQ290VDBz?=
 =?utf-8?B?TFhRNERGdGxJNFFWOGg0eWl6Zm5ZcXJuWHlNYk5sMjhUR2xkMUtYN1M4Q25v?=
 =?utf-8?B?TysybDBkWVpXK3hJelpMT0o1V1V0R2t6YXRNUjg5NXUyK3R5MkcrVGFXTTFm?=
 =?utf-8?B?MzhINnAwUGRQTENMUlA3MFpDMXhyYSsrZjkyVVN1MnlpeWZLenBXbERHTkZF?=
 =?utf-8?B?b1UrTEsxQkxEbTRqZC9aaHhpQllESm1MV1ZGS3plRmI4UWRVKy85bUg0L0s0?=
 =?utf-8?B?MWh0Mzlkc0FkYlhYY1FhblZmVkhGdmh4dytmUEVLUUVvUDNtanIzZWIzWVpI?=
 =?utf-8?B?clQvZjJVSmNoTmlWcS9pS014TkV4UnhxcGlhNkZRb0MrZUdSd3U0cUE3eks1?=
 =?utf-8?B?RzBEdVZVTUJFb1VQNEtJQ3BTOGdrb0p6NG1EaU5HY2pzaVlqckEvYUlCZ3dl?=
 =?utf-8?B?dG9zRWNBUlpQMmhoTGd3U0JpNXZRMUxCeWRXcnp3Tmh4Tmc4eWdBWmJ5b21s?=
 =?utf-8?Q?Zdf8XsVMe6isurOf6J0496d4N3GptdZE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEtrUFVkckY5V0tmSVRvTmlRYm5MekE0Z2hTYVJuT2NnN0tsWEVLUHYvNWNC?=
 =?utf-8?B?cHY1WTlXMEwrZXNrN1RmR1M0WWQ4V1pwR1N1cnBmTG9VdXEwM3BxY25sQXpp?=
 =?utf-8?B?SUdNOVRPYldBejdFUUsxbTBraDBqSU5ublU2cjd0cytldmRtdk1Zb3hvNjlK?=
 =?utf-8?B?Nng0T21LRlBJeEFTdzhWaytEMFo0RTlIM2VKR1ZqRytjZTlqRHNVK0NWL3kw?=
 =?utf-8?B?TEkya2IrVlRiUXJsbXNVWUhDRGdvQ29KZ053RUVqR3pDTll6WUU4OGtmM2l1?=
 =?utf-8?B?b2VoWWtCQmxjdnlTTW1tSDZhK1FoNlBieVJIbVZxdFJPV0JCNDJpeUU4VGRu?=
 =?utf-8?B?RWlFZTQyWFYrcmx2NzVaZWJLeDlGejdhOFBxVmM2ZWxpMnQrNmV2azYxckJ4?=
 =?utf-8?B?bjBQaXZDVkY0ZHo5SEFaVy9CNC9PT1NKZVBHQlBTR3ltUHFWZllHZ29zb3BD?=
 =?utf-8?B?MHlmZjQ2VDhaWDM1cURodFlERnNYY0JjTDU2OC9VYTVuWi9ldlg2ak9WYThy?=
 =?utf-8?B?M0hycDZLWE9KNWl6VVUwVHlWRzZDdTJudjlGOW05OG9KRjE3MjRaSW5HZHZ4?=
 =?utf-8?B?dDFjaXo0amZmMTBTbGZEdkppT3NOUnJ0SWhlZzcyazVBVVhJejltZWl4YzZW?=
 =?utf-8?B?OWsyaVBXRVVwY2lEVHZCMmJmYWxMQWRvMWl2MkVkWnNMQ0VHU3l1QWp5NDZV?=
 =?utf-8?B?ckUzcTRpM0R3OXRXMXNUTjhlQlNJd0JzTjdqL2szakU2ZFBKRFBTSGFaeUJ1?=
 =?utf-8?B?VWh4d0V6djE1a0xXYjhFSEw1Y1I0d2ZXd1JCZzhzTVVZeXA2UnZsRGNMSVhZ?=
 =?utf-8?B?SS9EMzErQzFUM0RjUktPS3JTc2JYbjVHLzJqdzg3dFVCNnJHR1JPUmdSalhW?=
 =?utf-8?B?OExFRnlGZ1ZCMFFpTWtDSzZFK0hhMmFoV1pLdU5UMXpEVnZSZnNYenNVYkxk?=
 =?utf-8?B?aEpkZEsrY0wxcVUxSEswb0VmRnNVKzZUeVM0djljSFh0bC9YYi9jbkRWOHdB?=
 =?utf-8?B?N0w4UzR5WEIySkNHNUM4ZXlma011MFFpVVhweE1aUExlTnNYS1VId1dmUGpk?=
 =?utf-8?B?M2VHNmVLZ0F1YWViWDlnbjFLZUZsSEFWNW5oRWZQMEFFL0t6S2FDZlBENEpY?=
 =?utf-8?B?Ly8xY0NONXN0T3hOYUZvVVI5SGplOEg1SUxaRWgyWk5FL1FUMFpWWGpXZzQ3?=
 =?utf-8?B?Uk9Ed1h3eFVoT2RKcE9DUDB2Q1JrNEhVVFB2Tmk1UjlpQkdFS3FwdTdDZGRo?=
 =?utf-8?B?dDRHU2x2bFB2MkpSUlBRMHRUb2lTUWxyMkk0TjVYRW5qdVoxK1VTeGFNY3lj?=
 =?utf-8?B?RElHUnBVS2lsUzlTMEhKUi9NTDhacHI0NXkycXJ0QzBBQi91M3VlclJoWFU0?=
 =?utf-8?B?aUF0bUwvaXJ3alh1QWI3MTBRWlNycWdaclVmZDlpNUVMZG5EUlJCNS9VbHB2?=
 =?utf-8?B?Y3dhUktWSVBFaVBZbU4rcjA0Z3dlUFNvbkUyL2N6MFZPdGljOXZaZVc3dWFC?=
 =?utf-8?B?cVpTUnBpTjJudlNNa1ZrYThQWGJuSFRmdGI5U0ttWjVPZ3R5Tk1MVVNtK2N3?=
 =?utf-8?B?QTE1L1M0NE1tY2dqb3NndFgvOGtYdnpqL1pEM0Z4Z3hGSkZhYldySjBia045?=
 =?utf-8?B?NW4yTG8wQUFUT2NLQVFLQ2N5cHJwNmMrdWcwRDlNdEQrUFhHQWlRTzBMZWJs?=
 =?utf-8?B?KzF2cXdxZnU3RGlQRmphOUpHWnRFWkR3U3E0Z2tRd28xSms2V3haalpISThP?=
 =?utf-8?B?c1gxWGlIc2xES0JmL0NYbXNjUHpyejgrcFc0MCtZUXhoQ0ltNEpLd0M4R0x2?=
 =?utf-8?B?SFJKeFhzYTFQbUlqWEcvVmFIdGovYXJtdXA3RENxVVhDek8zcjBXeDR0bjll?=
 =?utf-8?B?YzlLM1FMNVp0Ukh0ZzAvS21NQzl2b0VuYjZnY0lXSG50SEY2NHZHWHplOG1L?=
 =?utf-8?B?RU5PeDJQMEdZUnBoY3ExSTl3S0o2aEd6NTJlUFNoZXVBd2toRG45ZFVITmh4?=
 =?utf-8?B?ZHpvSnphdU9WVy9nOUcwZEROT0pMdFRPZXVOTHc0cXJ3TUZMcXQ1Q0VuWE14?=
 =?utf-8?B?VFBSNThMU2V0STJhL1l3T0toQ1VKTkpzazVHTmtwaDlYbHRaU3lTL2RNN2Vu?=
 =?utf-8?B?cmpJbWNmUFZZeUZFMkpDK1czNXhqblphSEtVcUJMVDBMdmUxcXRWbm9YMXJD?=
 =?utf-8?Q?NxmxTJRnn0lowcsZNHQyPBM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfaee04-53d8-412f-69e9-08de3266a83e
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:22:42.5673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyAh49IqJJk9EYdaa9DPiVJ9owB5nzSSzyqOVMM7CJeFW9bGwFjnWR0DFdbiriMFABqdzac9gQGg33uQiHRA/sWrFlEaHi7eYnID7eN594s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10833
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

Hi all,

On 4/9/25 5:10 PM, Quentin Schulz wrote:
> This does a bit of "cleanup" by reusing constants for some FIT
> properties instead of having the same string in multiple places.
> 
> Additionally, this adds a new constant for the compatible property in
> FIT configuration nodes[1] which is useful for FIT images with multiple
> FIT configuration nodes to support multiple devices in the same blob.
> U-Boot will try to figure out which node to select based on that
> compatible[2].
> 
> However, if this property is missing (and the first blob in the fdt
> property of the configuration node is uncompressed), the compatible from
> the root node of the associated kernel FDT will be used for the
> autoselection mechanism. For now, I only print the property if it
> exists, but maybe it'd make sense to expose the fallback one if it's
> missing, hence the RFC state for this series.
> 

Any feedback on this series?

It doesn't apply cleanly anymore but the conflict resolution is 
straightforward.

Cheers,
Quentin
