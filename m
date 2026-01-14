Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F6ED37E39
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FB982C7F;
	Wed, 14 Jan 2026 15:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kjZD9aJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648CF830A0; Wed, 14 Jan 2026 15:45:44 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B108063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6qAcqoRmThDnWIV1lb9WIVVtsM3oI/jNFNZUuhS2MVquVd1zvARKUngsNpBGtH81rAOha1QAlhtsSytC1V8bV8ltyvwakMBx1hM4LVXDNh1RQ+5d3qIxWPNBvPlYYs8sM2XeOwNBGNUkAmgXaJ4aZjHRrQ8Y0SXOE99GVC9YkeLZzPQLNUPE0RnwI9ERCm2nngOQ1gsiUICTc+z6DLHAqej1mdmcJ21wxu5oEnSY46yXphhitUOn4W9XPJJ+n2Dv+0zyKQKUCZr3gEUvP5J9kz2dOh9juDEHnHy6N6L2yCgy3HgBQl6TYeyLnXFL99DUFLWmYsBRKMH0wkux/WYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFThBi6huHtUusu3dXvt9nvS5Eb21XFypPutDlsiwCw=;
 b=f+RdQ+e2A5tHfX0cS4gUTMnlIhdIaKUbBVJ8vLgt/pDTFeUHI5bQnYxl9UTZQgY1xk4KKEYlmQrxF034jnixBMOhL5z9kvOeQGbzoveXKsG/b1GfJY9m9ZaZVSmsDElPOYl/matSpVts5OeXuJuXpPfWbkQ0cbIiSt23RWVw2wSMsn43JwRaaNZvNHcbGwFdzN0VIjSiaR+zUrcm1FVSAyJeCztHPwr0XGmmGLqJgEFBKKrVhleXfS6ol2zEJTaAivtpCtyB1SK7U3QzslgbhI/3B00bDRXyckrOg1dIuCLi9I7NRvx3EgajONftEVjQzIGUv5g2rbrX3wgIKLXzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFThBi6huHtUusu3dXvt9nvS5Eb21XFypPutDlsiwCw=;
 b=kjZD9aJR3TC9ZQUNSTIZHgYKQshtSv5ZMcBZ1uSFBjs9F2fCKe+Sv+QicK8dxQY7KI7OtzNaONGxmrwHoCNb7REjBI1g2r1ZEkD8K6ou3v7DAJDrmM2Pw8SR84gJUJz4dvPTVPZ3pTlwcMSdZUlVrmcFrvvXZfCSpcAQV3teIhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by DBAPR04MB7335.eurprd04.prod.outlook.com (2603:10a6:10:1b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 14:45:37 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 14:45:37 +0000
Message-ID: <4db65094-3055-4364-828b-8e7fe68f40b9@cherry.de>
Date: Wed, 14 Jan 2026 15:45:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] test: binman: Add test for pkcs11 signed capsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: trini@konsulko.com
References: <20260106111034.889964-1-Wojciech.Dubowik@mt.com>
 <20260106111034.889964-4-Wojciech.Dubowik@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260106111034.889964-4-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::20) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|DBAPR04MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa8f2ef-0063-4d8c-6c9c-08de537b94de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|7142099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm1aRDVEYjd6TzRzRHRBbzUyNWF5cG9vd1EvdWdwZVdOMi9waG12VnY0eVJ4?=
 =?utf-8?B?U2FtZWlMRlpkRDl3Qkd1S2R2SUJDNVdENkZ6T00zRWdVR2JOZFFvWG0xY3Zi?=
 =?utf-8?B?WGtDRFV0TjJJK3ZFRlNMMFFha0ExS1NTbDFmU0dxOE1IcnVhdFdzRHhBTlov?=
 =?utf-8?B?b0F4VXJyTC9pYVpCbkV5UHRRTHdqdExqTmd6K3VseGNFVHFwck5PaHlaYnNR?=
 =?utf-8?B?RUk4ZTg2SXlHd0NUT0FCZU5MOUNLck16R2NhR0tpaEgwMHVQS3N6OWF1b2Vx?=
 =?utf-8?B?VXkrMmtPS1JZbWoxMjN1SEgydnc5a0lqMzJEMGtjUkxjYWdvTVk2YjBtMEVS?=
 =?utf-8?B?d3RacjI2b3lDZmdhUDJEYkc0b3BuSlY5SW9WaDJ2eU5sQ3BON2VmaWhnMFlG?=
 =?utf-8?B?aE13S29LNnZqTHFRWlhGT1p4V1RuSW1udWpoQ29uVlUzT2xyZUkzY2Y5NTZE?=
 =?utf-8?B?cHp3UHdhaDIvcVFoSzA1c3lHbGUzOVhxbWNwamxBbGwxNk81NjdkZWlzQkor?=
 =?utf-8?B?Qmw3eUFLR3RLVzlpSThabFJYZ05aaFp5N25QU0pydS8vK1IzMlVFOVo5cVYx?=
 =?utf-8?B?RTlINnhINTkzcTMraWc2Q0JVZ0lLcHdKK0VJRlBTNWZ1eUVkR2wrUXUwcE5L?=
 =?utf-8?B?ZUM5UUd4NndlN0lSMTNIM0w0blFrSFJ6L0J3ZlpUUEwrYStkZ1ArQzNXQzVM?=
 =?utf-8?B?TnBwd2xMTXlySWdPcVFNbzA1ZzdsZ3N6THpYK0cvWC9xUzMrQkdjeTg5Rmht?=
 =?utf-8?B?eTU1Q3cvd3lZRVh0cTBpZWFUZUttbUVSU0FURDVBRGNYbllFWG80N1ozS01E?=
 =?utf-8?B?NTI0Rm85OGVyVEltK0hvUE05YzV3RFdrd3kxMGdrVkdaVU9pbU1xUkN0Vnkv?=
 =?utf-8?B?QmMrZzM5SWgxNkNmWXg0dUtUWDV1YlN0OUl2R0xmK0wxS0VBRjJhb1VxbFp6?=
 =?utf-8?B?ZkJNaGRTeFFPREduZjFuU0Q5YlBzaUQxOSt6UDRGV0RNS2IwYmxqWmJ5cmU1?=
 =?utf-8?B?eE1oYnlFYWlRVHlxUXNHMHk1d2R4TG0vQWRHUlltNkNDR1hqWUZxckt2VTBi?=
 =?utf-8?B?ak81MmlqMysyenhmRE5QaDcwZldjelZPQmt0NlhyVzRHZnFkSkIzcDJocGk1?=
 =?utf-8?B?bDIzZFZOamJxSlVQSDRsVENXWUNlaTV0anprMm1ZdjRLZUw5S28wbGxKbm1w?=
 =?utf-8?B?NUNybHBHVWMyeXhVZDhYK3VIMmM5REJ4NDBialRlN00rVXZYanJtWDV5UE04?=
 =?utf-8?B?cCtyVFJ2b0tSeEtRNkYxc2lwUEpyK2VYdWdSRzg2U0F0TnhzcmVzL1Z4SjFq?=
 =?utf-8?B?TGdZRVZsVTd5RXFYVUh6UXorb2V4dTFaR1FkbkdXR3VwbVB0clkwazM3RmFM?=
 =?utf-8?B?M3Z2SDRFRktnY2l1TFdMZG9RUDlLMUo2QlhiaU5IZU8zVTlaWVhEdHdsbUp4?=
 =?utf-8?B?TEVEU25hNnFHMFVyZzZWeTBYSWJockcvT0s0S3A0SWU4OUMvb2tPTVdVdFV1?=
 =?utf-8?B?ZktiYUxmbmxrVU1jaG1xYXBCZ1ZBN3NqQ3dDNldMZXlTc2pQRk1ka25GbG44?=
 =?utf-8?B?MHc4cEh6UTZUSy9jZVFxWmIwWUowRGNGMlBiQXBIWUs4RGxaelFJTFhOWXpF?=
 =?utf-8?B?YUc3bTN2bG5DZ202NlZacjJBazBkLzFwejFYQTc4L09pVlA1dVV2VEY5REIx?=
 =?utf-8?B?QXE4U28rbWZiYU0rUFZGRWJPa0VJQ1gzMEJ1R0lOS2Vnb21oblhidExoSXFB?=
 =?utf-8?B?SWU2anlvbWdCSEFYT3oyMTIvOE5PazkyZFRSVW5LMFlJM1BjY0l4UUdPMHJO?=
 =?utf-8?B?TlE4WExhdnZ0YXcrZnRlT0pvM1NUS2cwS1VkM0RHQ1ZGZWhiUXE1Q2JpcnRy?=
 =?utf-8?B?S2F0a0JESU5jMUl0ZjV5MGU0dCtTdEM1ZzhJYTJVZGpxNk54K2V6bW8zMUJQ?=
 =?utf-8?B?L3VlNnUzR2Jpc1VBNzBhV2tlb2w1NTZQcW9PVnRoazl5VGVENElyQWhRaEpv?=
 =?utf-8?B?M1dqajRybDVEREJpdXpxZ3ZsRkFEb0kyY2J3ekI3Q2IrUTlHbWhxQUdzNWhV?=
 =?utf-8?B?MEZuM0ZJRkdhQS9GbEJuZVU0cUc4NzRHOER5QlE4QTB2eXJNRHNqTk1waGQv?=
 =?utf-8?Q?43QQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(7142099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTB6QXFud05RRlVRRDFyZjJCdjhuOUJaS0pvbldkQzl5NnUxY3hISVNSdDdj?=
 =?utf-8?B?NCthZmV4UFhZK05EM3VhamgrRVg2VTZMZDIyUklKb0xjdkpaUVducTVvQWQv?=
 =?utf-8?B?ZCt1RC81eUQxcW5yN0RBOXVkYkVHN2o1YjlaR3dlSFZGTEpKcFpxdGJrMlZj?=
 =?utf-8?B?aGVhYTdQOGFCL3IyYUl2aVExb1cxMGdKcU9PWU1kSVJPc2gzQUszeXRjTTdx?=
 =?utf-8?B?SVVpZzRvZmFWU1Y0Wk8yMVdYeHVOMSswZGU5VDBTT09LOWVaTGV6M1JxQlFw?=
 =?utf-8?B?cDVuQ0xRR2hid3RwandscTRWTStpM3d3MWZUQ0xvOG5iMHNJVEt3SldDSDQy?=
 =?utf-8?B?MWhoaWtJU1B0anlyVkNpbmdyWWlNNTEwMVhoNk4xMW4zdkZ3dlExdkVDMUlD?=
 =?utf-8?B?NkF1dTUvR1ppRXBhN2tzbDViSTJzdTJma3V6VGltREZJL05qLzVLRUErdTlG?=
 =?utf-8?B?M2hqejI4R2RaOWhVRlBJQTlqd0NkaHdVU3dsSCszN2FYRnN3OUJ1cmlhV3Fs?=
 =?utf-8?B?aVhtRVhTYUgxS2gyak5HcFZYeFlxOWQvMFRCb0pvdGFOQktrU3g1UWlXN2Fm?=
 =?utf-8?B?dWk1OWhPdmxEMGdBU1BHYlRHY3BrenIvNis4M0N0cXpHYzV3SmR3MjB6RHZW?=
 =?utf-8?B?SEpkdVJjOVNId2pTQm0rdnJ4NkFKZER6aXFkL0JlM1RQTTU0SkxubzBuNU02?=
 =?utf-8?B?TmxnRGx1NUJFV0JiZzhPSFIwM0xycUN4VU1FcVVPekxCUmhsOGVYNGVkNFhS?=
 =?utf-8?B?bW8vK3J3djVDUmEwNHdVVHRnSXVLaU9RZUo4Mm1MQWtkUVovR2dMQlMvVU1M?=
 =?utf-8?B?QU4xYmZxVFhYWjFray9ZcU9jaXJjbnAra2tHQ3dydTU1eUpjWkY5UktwUlBS?=
 =?utf-8?B?QXNwTXFmelo0QTZteHdCb1FCWUgvNytEa0ZONHpmWHM0OHhPaXFoU1YzNHA1?=
 =?utf-8?B?T1BscGxRZmxlQXZXdXhxa3hXRnM5RFhsaVFVbnFxSXkvSmdYN00yMU9COW9o?=
 =?utf-8?B?L3QwMk9DaXlrakZMd0xkTloxT0hwNnozUElDd2Y3WGx1c0NkTzV0WXN5T2d3?=
 =?utf-8?B?cVhZd2Rxc2g3U2hxVkxIcnhNTmtPK2RIdkxUWGxZLytWci8yMjV6TlpmWmRL?=
 =?utf-8?B?Vm5wTU9XRC9QWkMybFUvZU9aaUpZNU8xQ0hhaEh3TTFxeURTaGYvOHZxcndB?=
 =?utf-8?B?SFcyZUZDZWxla3NSSWJqcnF2SXNJWVIvd2NhZDU0d3BUcit6akIrSktVTS9T?=
 =?utf-8?B?L0hQV3huaXpvYmk4QkRDOEhJcXJ4cFMvSGZ0Z1ZZaDFSM1RhaVllSDNrem9r?=
 =?utf-8?B?d1VoTkgzVFpjbjdtVHJtdXBORnJ6R2FJaUZON1JWVHBQU3N5Z25iV0VYOHVu?=
 =?utf-8?B?SUFJalZwR29NZ1YxOHpObS9NSWhIT0twdWo0VUJ1OEVaOUtkRjlwQWJsdk80?=
 =?utf-8?B?UEtjWDZJQUxETm42aTlOMnpBZldZNGxDZjlVaEdKcTVyMnJaRGFvRmN6TFhD?=
 =?utf-8?B?czIyQXhSQUZIRS8yVHVQa1R6cTBFQlJINlVxcE4wRDVBc2JSZ3l0TlNRYnc3?=
 =?utf-8?B?V0I4ZWRKZXREdk12aEwxN25Xb010eWNwWnNhbmtSd20rM1JxYmRqMDJ2NFNL?=
 =?utf-8?B?L3pCdXVJelFoS2tVbEwxTEdRRkhUNG5YQWFodHZGR2o5SGxTUnRtNDVOazFa?=
 =?utf-8?B?aFQvcEM2S2M5eWVnZ3dnWFhleXZaenNtTmVkc3dqbHhvRThHVmVhQ0lpVnVp?=
 =?utf-8?B?c1NRUmtSMEZ3LzlLUjV2RTJ5RDBieE02bVBKd0lxUW1nZFRHME01RVVISXpl?=
 =?utf-8?B?aDZmVU1PN1VIMzQ1RXdBMUtXSk9YY1lTNUZQdjdxbHlIaFo3enBaVVRXODhp?=
 =?utf-8?B?RmlveExDVkdtUHhPYnBJdTV1L3RtN3JvN1J2RzljQmJIbW1Bby96aHUybHND?=
 =?utf-8?B?TzBETGFyL0RCdjFMZkpNWkVuN2hxanpGTmhvR1FEanFVSDQreUtGRVgzaThH?=
 =?utf-8?B?Z0ZjQ21JNTBqdVg1NmxRb1poc0wxUDlPdzd5NDY1VjYrcUhJbXZLUHNDemYr?=
 =?utf-8?B?VWEyMFM2MEN3bW5seGhDUnkrR09BT1ZJdVo2TXJWWnQ0ZU5tdUhRa2J4NU9m?=
 =?utf-8?B?clZiblQ4NVJsbXlvd2RSUGkxKzMzRE5CNWs1ZitJdmlmTUp2N1p3UWNUcVRW?=
 =?utf-8?B?RUg0U2J2ZGdEcDZBWGF4NzJrNTcvQWNNSzNKUnp4ZjFXMVBZNG5LQk1nUFdp?=
 =?utf-8?B?Z2RXcUhiZnVmRStJRkJ4dW9wOVgxVWljMTFNbGFXbWJYRnpTSnlFbGlOaWxl?=
 =?utf-8?B?bDZGcFRUVjQ0OTdVa05PUDJPTnNkc1ZDZHpLRHBiOFQ0WUFXRjVwZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa8f2ef-0063-4d8c-6c9c-08de537b94de
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 14:45:37.7632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyAiilY74K4ESfcdYw8k1A6lqkflHoKa1yi7ji6WnIQd0sYIV7JB7o+vJkLJW5xKohWVJAoajNEGSxXAPo5au4UlUCALbA5qZbgDfqxqFGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7335
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

Hi Wojciech,

On 1/6/26 12:09 PM, Wojciech Dubowik wrote:
> Test pkcs11 URI support for UEFI capsule generation. For
> simplicity only private key is defined in binman section
> as softhsm tool doesn't support certificate import (yet).
> 
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
>   tools/binman/ftest.py                         | 46 +++++++++++++++++++
>   .../binman/test/351_capsule_signed_pkcs11.dts | 20 ++++++++
>   2 files changed, 66 insertions(+)
>   create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
> 
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 21ec48d86fd1..cb5d69982772 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7532,6 +7532,52 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>   
>           self._CheckCapsule(data, signed_capsule=True)
>   
> +    def testPkcs11SignedCapsuleGen(self):
> +        """Test generation of EFI capsule (with PKCS11)"""
> +        data = tools.read_file(self.TestFile("key.key"))
> +        private_key = self._MakeInputFile("key.key", data)
> +        data = tools.read_file(self.TestFile("key.pem"))
> +        self._MakeInputFile("key.crt", data)
> +
> +        softhsm2_util = bintool.Bintool.create('softhsm2_util')
> +        self._CheckBintool(softhsm2_util)
> +
> +        prefix = "testPkcs11SignedCapsuleGen."
> +        # Configure SoftHSMv2
> +        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
> +        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
> +        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
> +
> +        softhsm_paths="/usr/local/lib/softhsm/libsofthsm2.so \
> +                /usr/lib/softhsm/libsofthsm2.so \
> +                /usr/lib64/pkcs11/libsofthsm2.so \
> +                /usr/lib/i386-linux-gnu/softhsm/libsofthsm2.so \
> +                /usr/lib/x86_64-linux-gnu/softhsm/libsofthsm2.so"> +
> +        for softhsm2_lib_loc in softhsm_paths.split():
> +                if os.path.exists(softhsm2_lib_loc):
> +                        softhsm2_lib = softhsm2_lib_loc
> +

This seems brittle, isn't there a better mechanism than this that can be 
offered by distros? For openssl, installing libengine-pkcs11-openssl 
(and setting the provider in the OPENSSL_CONF env variable) was enough. 
Is there something similar to that for gnutls?

I don't think this will work on arm64 hosts, c.f. 
https://debian.pkgs.org/13/debian-main-arm64/libsofthsm2_2.6.1-3_arm64.deb.html

> +        with open(softhsm2_conf, 'a') as f:
> +            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
> +
> +        with unittest.mock.patch.dict('os.environ',
> +                                      {'SOFTHSM2_CONF': softhsm2_conf}):
> +            tools.run('softhsm2-util', '--init-token', '--free', '--label',
> +                      'U-Boot token', '--pin', '1111', '--so-pin',
> +                      '222222')
> +            tools.run('softhsm2-util', '--import', private_key, '--token',
> +                      'U-Boot token', '--label', 'test_key', '--id', '999999',
> +                      '--pin', '1111')
> +
> +        with unittest.mock.patch.dict('os.environ',
> +                                      {'PKCS11_MODULE_PATH': softhsm2_lib,
> +                                       'SOFTHSM2_CONF': softhsm2_conf}):
> +                data = self._DoReadFile('351_capsule_signed_pkcs11.dts')
> +
> +
> +        self._CheckCapsule(data, signed_capsule=True)
> +

Don't you want to validate it's properly signed?

Cheers,
Quentin
