Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5535FCFD368
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 11:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D4F183FF4;
	Tue, 25 Nov 2025 12:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HGzPk2Q/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12D4B83FF5; Tue, 25 Nov 2025 12:37:14 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B2C83FDF
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 12:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoRcZYGRyi/0QWmCQ/TGxnE+CrKEmpHHp2vi4VmqUA7j2hzfDJZ4cOxDxq3/Wyoic6LGBmHNTIaZ9csjaWQz4YXOiNscDft3OIiqmqGmKr/n0ardw81cPZSe9khNyjwn+XNDaudhpFSlJP2oh1Ig6MIYL+AbrxuJ/HoZH2iK4TO1CnudMnTsEscdXamYdAN1ZVWXlfkmbNP8wYZccbreALojeECMRu5bWSyif1mEjfrb4T/y7/AFQNeNvod7jF9ad+hAaVDaDjLXp3KMBuC214Ljp3jL3qCrgvpbFy/+BfQs+y9GVFyaHYb1Kt4uQn8aKL+Dk9gTI3xd6VqbETsTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mHUQLsRb1bO4rk2KU4NYrY/0Zvki04JOHAFV6mlZyM=;
 b=lWDHASgqrU+5oWzoqxfFgEqDHRJ9N//LQMMLT8PHwKVh+yzIXV5mWQTpB1GAirQ+UQ/5isyAahiJ2HAQMVjMeaU+wsztazhKX40/YNDW7clZk2HpbS/FG6urE6USzBeijpA3dLNyb1qCcaRI2ZxPyp0YKTMyiIt/RY+DG5yj/wTaUldrV3RqFTalfGqtqQTjmi/OMu3x/1gYSQqf+oBm3UFkRo1QpExZ5S2UKOtVDJ2VMw5eEQ0lOXR/xmaB9hTkX/KdpiqT4qaBMiWe5B+1QO4BytcQXqkFaxOrjMt5u8zFtSRSfZNyxkFfRvQQ9jyNNLLRGo725Y2i7SSkFWMDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mHUQLsRb1bO4rk2KU4NYrY/0Zvki04JOHAFV6mlZyM=;
 b=HGzPk2Q/zb6Rx3eM0BcsicPpK4Fv79gQrKIc2Em8Kz0CqzxTVx8oD/oPBeMXfWdFfY3qMzMu1m96qELg3wDYovgXcHa8zmr1ED4rg+YjESpTcyDEjgiwvRQUGSzdiCps9PGAC+kkj5n/XrDJ9xEHQyTgPympnOTwFq/59SgUxM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB8249.eurprd04.prod.outlook.com (2603:10a6:10:25c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 11:37:08 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 11:37:08 +0000
Message-ID: <006441da-83c5-4970-9e9a-93348126d43f@cherry.de>
Date: Tue, 25 Nov 2025 12:37:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mkimage: Add support for bundling TEE in mkimage
 -f auto
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
References: <20251124194201.83326-1-marek.vasut@mailbox.org>
 <20251124194201.83326-2-marek.vasut@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251124194201.83326-2-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::23) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: d80dc120-025c-4cfc-e5c1-08de2c16f722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2NRWnJacTRKT0pJRWJKREtJWENPZXpMUjNSYWJmOThOVEFTKzJYOGxaT1FL?=
 =?utf-8?B?dTYyazF3NHhsbll4UEZ2cUlJN01YRGdESUtZU0hxcUx1dlF3RHRlWFlDWDdk?=
 =?utf-8?B?a2QrekFXUGM5SzN3dVEzTFFybktnZ0pXYXVSKzBlb1ZreDArT1RMNmRQRWYv?=
 =?utf-8?B?MmpnUEQvNjYxeHpuemJHdE5FREovajM2angxYlVvclEyMEZDQSt5SEhCZDZ3?=
 =?utf-8?B?U2FSNEwwVkl1ZmdoZTk5N1kxUUFHNm0yK0hCcEhnbEs3YjNKOVF0cXE1cUxM?=
 =?utf-8?B?SFlrUFVZTEJ4dVlxUjFrS2NDWkRONDBjMXN4UjBkTk5COGtoaE1haXZzU2d5?=
 =?utf-8?B?bGlXUXkweU1JZWhxMUxreTJmMlhjdVV6ZkNUbytFbUhpbER5RFpvZzVleHZU?=
 =?utf-8?B?RjlWSVdOemxEd0plTVpJU3JaTGd3OVM5TThNOHZlUTBKaGdQdE1WSGM3WDR3?=
 =?utf-8?B?cm1YM2VzbHF5SFlBT1RQY3k5aEIxYi9tRW82dkVNNlFPMEtrUW55QlJJdFUv?=
 =?utf-8?B?OXc0Zi9UMFBZWWE5UHllZ1JsazQwcUVBMGF4cGcyQi8wY0NoajFQVVJ6QlpN?=
 =?utf-8?B?TTh1WVc0VDBMQ1RKOWJyc1lVYXBnanFoNU4yQVM1K2xjZ1poenhwZTg3dGJY?=
 =?utf-8?B?dFcwbEVBRUl3V0RsaVU5dmp0bmhYYnNYSXBsQmJsNTdTYURIM3dVVlQwZUJl?=
 =?utf-8?B?aHJHNHJYeUk4WEFwNjd4dmorTWMycm5qSTExV21Wczdxc1puU1NDdVBQeEp0?=
 =?utf-8?B?b2ErRHgyNDUyejBGWUowREhRY3loTm5DWVdIS1QwbXM3bjUvR0xIbTRPVE82?=
 =?utf-8?B?UDJDRUEyVmRkM1R3MkJJbEw0SmJxUkhLaFR1R3oyQnMwTml1WXZETklsbzFC?=
 =?utf-8?B?Q0FCRG1WK1ZaWmtaMGhiOGNQMUp5dnJsb1dqcThQV1FOZFVnTGIzV21KWC9t?=
 =?utf-8?B?SmVYL3Uvc1BxRkkzYVUvTzIwN2RGcllMQy9MYzRQNHA4TWV6bEtKTnQvN0hh?=
 =?utf-8?B?RVVxWkVVamNSenMzeGduQXhib1IwNVBTM0lKTS9hTFF3bGdKaVVwZXY0SWZw?=
 =?utf-8?B?M2hxNXNTMGdsZDc3bi80WmVsS291SjVITjJZTjRBTlE2Y3BKRkVzeUs0N3Ax?=
 =?utf-8?B?dEJGQ0FHa29RcFlHT3RhV1NMYTFkREpCYlR5bmhiU0hyZVNyNHlacCtGNlJv?=
 =?utf-8?B?YVBuOE8vbGo5RmxlU3V5Zkg0YXQ0ekx3R0VCcGdRMHBiMmErM3FQRnhQdXBk?=
 =?utf-8?B?Q0JIUmJWOTRnYmNJSmRpVHAvMkJvRUxSWTFQTzFYbFk3MUl3dWdqekl6dXND?=
 =?utf-8?B?Kzc3cTY2U0tUeThTTVo4NVRZc2ZvS3E5OG9vNG9uVktsaGdGZ1RneE1tNXl3?=
 =?utf-8?B?bkNjNkcyZ2lqNlV2QmVVL0t5RTZMZDJESG55a3NkSEREUUExRDYrWFlHdzBD?=
 =?utf-8?B?MzE2YkQvU0E1SVNFbEF5V2dZaDUxS2pZL21KVXA5OHZmL0VjS1c0MmJEVVZV?=
 =?utf-8?B?c1hPMjd3ZTllRHZlR0g2eFYvQzJxWVB6MXhmMVpOL1kvaUNacjhIOWlBVG9Z?=
 =?utf-8?B?cmRKVnpkL1NEVmQrbkk3Q0FINFhncUlicXVWRnNmRnIrRnppa1YxbThiaUZD?=
 =?utf-8?B?V21uWjhNWklXODJsM2N4T0F2WTZWekFENnVlNEMyZW9HQ29tQldPTHRZT0Vs?=
 =?utf-8?B?VHAwc05BNk9kK0lUOTZwQjNQWkJza2lHOU5JaXNEb0pMb1kvb3ljblpPbUNX?=
 =?utf-8?B?S3JqVnRhd1JjOERkZGpwczZkbDlzb1BNb2RmYy9iclJYUHlNNE5FMHJoVlpy?=
 =?utf-8?B?ZENnTVdINmlJMkt5MlRzRis0SXRhaDRYeXNBdk90bEwyVGZQUkJ4bUlZTHkw?=
 =?utf-8?B?QkMzNTVWK3RHUzhrdTFoNDJDZllZYlJENmQrODV0TXpwcy9MWmJHV3AxQm9X?=
 =?utf-8?Q?jWE2ukz/ZmcK+HgurgeGmLhkNnGmC7ey?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFMOE5wSTlTZFUyS29Rdm5KQ3pTbDFYWXlWR2VESWFlanlrbDUvUXRsOVBS?=
 =?utf-8?B?cGdGSjFVclNNMnVVM0lJd0xQQWdZVTllaU1VczFmSVdOYytrNFhuOVJNNDZK?=
 =?utf-8?B?SDlzRVFtRnNPaC9KaWJWTEl6TUlIaU9LQlE4azByUVdtTlJyUXVXaHNwbmtL?=
 =?utf-8?B?bVIvWEZQNlk4QXJ1RFJjSFV0RExhYmovc3ZRSkJlRzRMNVNvVS9nOGRZUGtz?=
 =?utf-8?B?MzlTT2VxV09iVTIxMnE5Z0g5djhIYkppelJibFpZMnZDKzFkVUI4TmlDdng1?=
 =?utf-8?B?dVNOL1lyK2JzbmY5R0czTi91dUNpa2lVUHpyUmN5S1dja01SVlZuVGRPUXE3?=
 =?utf-8?B?THYrMnJxQm1HdlVBeWJlUVNVY1U4Q1phMU9nTGtDbkVHWERjUkpFSXFKMXk5?=
 =?utf-8?B?VUlpWVJOVExPTHcvWEVodHpPNktCYVFTYndadXJhTmxVbFRJQlJ1bEVnV2Fw?=
 =?utf-8?B?T0hRVjZzRlNIQy8rSUdzN2dhSHRHNC9mSTB5NHhsWXdtaURGNmNwbFhJaUpt?=
 =?utf-8?B?RmhtSDJXRkdXaXp0bzJSUnlaaDZOYktTMHdtTnB2L3V4S2RVdFhVZGp5b2hJ?=
 =?utf-8?B?aXdFdnVFMW1wZ0FNR3o5MDQzaXRUaFlWMWk5Q0dWaWk4WTN4Y1ZSdXFHMXR6?=
 =?utf-8?B?eTc4NDJGTGRadVA3bmY3VGU4TmlDT1FudUQyeVVBRDFJSHJrS0dBMmRrWEZ0?=
 =?utf-8?B?NVNHSTAyakVLcnlPbmJQTERnbHBJY1R5Z3hXUnpXTUpqQjNSeGx1UHJpV1pH?=
 =?utf-8?B?V1ZiWXJzVVhyTjdqU3hoSkk4QTI5d1JES2x5c2k2VjNwVlJ1RER5WGY1b3Z4?=
 =?utf-8?B?WXpianE4SWZWQVh5eTdubDh6OXE1bmo5V3diRml0TjEwSHA2dHZoM1J3cEg3?=
 =?utf-8?B?aEVvODROeGVOcmFueXU1MUw2Q3lVSFlVUVJRc25tSytZTVBYTWdrMlFHVXNJ?=
 =?utf-8?B?emZwYUwyclU2Skw1WDdSeHFTTmd1N0FuVnNSYk9wT1JtWlNCaS90NmFEUzk4?=
 =?utf-8?B?MmNZaHhhSU0rcWpKdTF2SUhsUVUvZ2ZzZWZqVU0xS2p4R3NOMWs5bWFlSi9R?=
 =?utf-8?B?MVd5K1ZpbE1YKzZnV21aNUV2Rjg3M2s4aUpLdU1VL0Q2cSt5OTBFZ1dUMFRD?=
 =?utf-8?B?cG1EMDUwdUlKSFNENnFkQkVDQlBuck9NOXRrVG85Q2RZbG9obzFSVjhiSzhi?=
 =?utf-8?B?QWFDcmJUc1Vlc1RWV3J3SGExZVFSTTNXT3pQdmNmaXNwbmpBSENTMWVIcUVl?=
 =?utf-8?B?VWx4dllzcElHOVFXMFI0dHJBc3p6czFrSERBMFRQV3pjSUhBY0JDbG01akpz?=
 =?utf-8?B?Z0xLd3c1Nll3NFZUakJBNGVIUHBxdXI3NWx3emtzakNqV0VpOXhQVWFKbHZn?=
 =?utf-8?B?Tnd2eGxxTUdDS1VoK2hpVW1jeUFjejhKZGNzTnFWekdUTUpIRWtMek1iOXVa?=
 =?utf-8?B?V2FCNGhFeXhSMjJJalJlQlRpdEQ3ZWR3WmRKRWdFSmxyWk9pbTVoU1Q5VWFK?=
 =?utf-8?B?TFhOdXZqTXkyYUd6bjdxUTBkTXMzNUNkVGJXd2tmb0pNbll4cGlodjZoQ1hS?=
 =?utf-8?B?MUhqeS9TdkJoemxDQkltTzJLZkg0NjhzOW5naDE4a0RLQjZkWG01MHB3bzlW?=
 =?utf-8?B?WTZUQXc3cFpzcWU2dktwZjBZNkJTaVphTUE3TVBtVnM0dFNzcVpVdUtzTThH?=
 =?utf-8?B?eFZYK3RDemFMK2w4bmh3VmNESDBHamZHRVJUZjNrSms3cFNnRWZtU2tlUnps?=
 =?utf-8?B?U0pBMkFDaW4vTzlMMG1XVFd0S09tTmtKREZ6YldHTWI0NWRhTnpCY1V3WG13?=
 =?utf-8?B?R0o2eFJydk1QdE9vRVh2Tm8rUzBoSEp4bjFMMFh3ZFBCa2xKek1kcFJZbWZQ?=
 =?utf-8?B?Y1BGKzFlTkJybVlyMHp2Y0Npcyszd0kwOVl0ZzdrUGNIbVdIRWdrd05vVzB2?=
 =?utf-8?B?MGRZSS9jdWpSTnMyRVpzdy95L1Rha2VwSjc0c2pQZnVKN2ljUWhyWWV1ZjlK?=
 =?utf-8?B?b2Fqd3hMZU9BT2ZGdWE3L1JhRGd0TStHdVB0YnRPNzFYSzVJQmpIL3M1dDZm?=
 =?utf-8?B?ZWcwS2NreWozZVAvRTZkem1xeFJtMzRJd1RkbjdnREZFemEyQzM1UXpxMmYy?=
 =?utf-8?B?VE1NM1NRc1Zmb01pREJPdG40WmlkbUFBR0xjMDRGeVJxSFI1NjhVYkIyajlU?=
 =?utf-8?Q?OAmR3jkw4K36wIT6mGg3ySs=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d80dc120-025c-4cfc-e5c1-08de2c16f722
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 11:37:08.1518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oz9sEZHQQr2k5BtD8aDxin93h66J1K4dW4H1JrP07bJOUVFnAXJ0IB0fNQnoKzEYKhNtJyaDcOBMLqu5ImdheUSBzxjLUGCMeeRCyxR2NxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8249
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

Hi Marek,

On 11/24/25 8:40 PM, Marek Vasut wrote:
> Introduce two new parameters to be used with mkimage -f auto to bundle
> TEE image into fitImage, using auto-generated fitImage. Add -z to specify
> TEE file name and -Z to specify TEE load and entry point address. This is
> meant to be used with systems which boot all of TEE, Linux and its DT from
> a single fitImage, all booted by U-Boot.
> 
> Example invocation:
> "
> $ mkimage -E -A arm -C none -e 0xc0008000 -a 0xc0008000 -f auto \
>            -d arch/arm/boot/zImage \
>            -b arch/arm/boot/dts/st/stm32mp135f-dhcor-dhsbc.dtb \
>            -z ../optee_os/out/arm-plat-stm32mp1/core/tee-raw.bin \
> 	  -Z 0xde000000 \
>            /path/to/output/fitImage
> "
> 
> Documentation update and test are also included, the test validates
> both positive and negative test cases, where fitImage does not include
> TEE and does include TEE blobs.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: "Carlos López" <carlos.lopezr4096@gmail.com>
> Cc: Aristo Chen <jj251510319013@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Julien Masson <jmasson@baylibre.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Mayuresh Chitale <mchitale@ventanamicro.com>
> Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Rasmus Villemoes <ravi@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> Cc: u-boot@lists.denx.de
> Cc: u-boot@dh-electronics.com
> ---
> V2: - Update manpage to list --tee-* options instead of --optee-*
>      - Update comments in pytest test to reflect the TEE support
> ---
>   doc/mkimage.1                         | 12 +++++
>   include/image.h                       |  1 +
>   test/py/tests/test_fit_auto_signed.py | 65 ++++++++++++++++++++++++---
>   tools/fit_image.c                     | 55 ++++++++++++++++++++++-
>   tools/imagetool.h                     |  2 +
>   tools/mkimage.c                       | 17 ++++++-
>   6 files changed, 142 insertions(+), 10 deletions(-)
> 
> diff --git a/doc/mkimage.1 b/doc/mkimage.1
> index c705218d345..29df21440e7 100644
> --- a/doc/mkimage.1
> +++ b/doc/mkimage.1
> @@ -251,6 +251,18 @@ Append TFA BL31 file to the image.
>   .B \-\-tfa-bl31-addr
>   Set TFA BL31 file load and entry point address.
>   .
> +.TP
> +.B \-z
> +.TQ
> +.B \-\-tee-file
> +Append TEE file to the image.

Please specify which format is supported here if only select ones are.

> +.
> +.TP
> +.B \-Z
> +.TQ
> +.B \-\-tee-addr
> +Set TEE file load and entry point address, in hexadecimal.

s/address/addresses/ ?

[...]
> @@ -239,3 +251,42 @@ def test_fit_auto_signed(ubman):
>       generate_and_check_fit_image(' -fauto-conf' + b_args + s_args + " " + fit_file,
>                                    scfgs=True, bl31present=True,
>                                    key_name=key_name, sign_algo=sign_algo)
> +
> +    # Run the same tests as 1/2/3 above, but this time with TEE
> +    # options -z tee.bin -Z 0x56780000 to cover both mkimage with
> +    # and without TEE use cases.
> +    b_args = " -d" + kernel_file + " -b" + dt1_file + " -b" + dt2_file + " -z" + tee_file + " -Z 0x56780000"
> +

General remark but using f-string may improve readability:

b_args = f'-d {kernel_file} -b {dt1_file} -b {dt2_file} -z {tee_file} -Z 
0x56780000'

[...]

> @@ -473,10 +504,20 @@ static void fit_write_configs(struct image_tool_params *params, char *fdt)
>   		len = strlen(str);
>   		fdt_property_string(fdt, typename, str);
>   
> -		if (params->fit_tfa_bl31) {
> +		if (params->fit_tfa_bl31 && params->fit_tee) {
> +			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1." FIT_TEE_PROP "-1", typename);
> +			str[len] = 0;
> +			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
> +			str[len] = 0;
> +			len += strlen(FIT_TEE_PROP "-1") + 1;
> +		} else if (params->fit_tfa_bl31) {
>   			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1", typename);
>   			str[len] = 0;
>   			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
> +		} else if (params->fit_tee) {
> +			snprintf(str, sizeof(str), "%s-1." FIT_TEE_PROP "-1", typename);
> +			str[len] = 0;
> +			len += strlen(FIT_TEE_PROP "-1") + 1;

It actually took me a while to figure out that we are reusing len from 
outside of the if block because the loadables property starts with kernel-1.

I'm wondering if it would make it more readable to do the following

if (params->fit_tfa_bl31) {
     snprintf(&str[len + 1], sizeof(str) - (len + 1), FIT_TFA_BL31_PROP 
"-1");
     len += strlen(&str[len + 1]) + 1;
}

if (params->fit_tee) {
     snprintf(&str[len + 1], sizeof(str) - (len + 1), FIT_TEE_PROP "-1");
     len += strlen(&str[len + 1]) + 1;
}

(NOT TESTED!)

(snprintf apparently adds the trailing NUL character so no need to 
str[len] = 0 as far as I could tell, c.f. 
https://cplusplus.com/reference/cstdio/snprintf/ though that is c++ and 
the manpage of snprintf(3) isn't clear enough).

The issue is that we're now making access to an array and have to deal 
with possible out-of-bounds, as opposed to snprintf on str which handles 
this by itself by simply truncating safely. Not sure it's worth it.

>   		}
>   
>   		fdt_property(fdt, FIT_LOADABLE_PROP, str, len + 1);
> @@ -498,10 +539,20 @@ static void fit_write_configs(struct image_tool_params *params, char *fdt)
>   		len = strlen(str);
>   		fdt_property_string(fdt, typename, str);
>   
> -		if (params->fit_tfa_bl31) {
> +		if (params->fit_tfa_bl31 && params->fit_tee) {
> +			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1." FIT_TEE_PROP "-1", typename);
> +			str[len] = 0;
> +			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
> +			str[len] = 0;
> +			len += strlen(FIT_TEE_PROP "-1") + 1;
> +		} else if (params->fit_tfa_bl31) {
>   			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1", typename);
>   			str[len] = 0;
>   			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
> +		} else if (params->fit_tee) {
> +			snprintf(str, sizeof(str), "%s-1." FIT_TEE_PROP "-1", typename);
> +			str[len] = 0;
> +			len += strlen(FIT_TEE_PROP "-1") + 1;
>   		}
>   
>   		fdt_property(fdt, FIT_LOADABLE_PROP, str, len + 1);
> diff --git a/tools/imagetool.h b/tools/imagetool.h
> index 866b8834fd7..d0e7d6d56e3 100644
> --- a/tools/imagetool.h
> +++ b/tools/imagetool.h
> @@ -101,6 +101,8 @@ struct image_tool_params {
>   	struct image_summary summary;	/* results of signing process */
>   	char *fit_tfa_bl31;	/* TFA BL31 file to include */
>   	unsigned int fit_tfa_bl31_addr;	/* TFA BL31 load and entry point address */
> +	char *fit_tee;		/* TEE file to include */
> +	unsigned int fit_tee_addr;	/* TEE load and entry point address */
>   };
>   
>   /*
> diff --git a/tools/mkimage.c b/tools/mkimage.c
> index a800f9507bf..139d1bece2c 100644
> --- a/tools/mkimage.c
> +++ b/tools/mkimage.c
> @@ -103,6 +103,8 @@ static void usage(const char *msg)
>   		"          -s ==> create an image with no data\n"
>   		"          -y ==> append TFA BL31 file to the image\n"
>   		"          -Y ==> set TFA BL31 file load and entry point address\n"
> +		"          -z ==> append TEE file to the image\n"
> +		"          -Z ==> set TEE file load and entry point address\n"

s/address/addresses/ ?

Looks ok to me, so

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
