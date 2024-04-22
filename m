Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38745C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 09:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ADA2883A5;
	Mon, 22 Apr 2024 11:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="XlPpsm5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB2B883E0; Mon, 22 Apr 2024 11:38:16 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0703.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::703])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8932088380
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 11:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/3xPinnu8Z7hGT29PDZyfT8JN8U3pni5w5e2C0nXUPTaCT4Svsty0Kb1yLsHXo5DeiKDJtiaB9E+9lcJ5TfwNUbkyT9we+XQABnF4wQc+iefpkhSOrIpwNwtPRl1SjvOQUWpIBj3n5xkzu7NYYJfTGxnAtqxLKW97rpoO+NRVHQ0UxLMMAm4lAVigVGW0fF/E/rgJnwVP0VW2mCm0ro9DOxAEyxvkZxsbG+RWuNOlRd5H1JkuX1aDdFCb1la4dFYPHArbwNfTodlfdNxy+A+uu2fPUw1Cf6Q4lV0f/n+ACddSIRtgSaY53xC0P52GRWJMIKmGLqjEiCHH6XODbjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMmNmw0BdM8e7t2dGsTCjebzhUzlJ9KcwIUBkZk6uiE=;
 b=l85osdLqaBcA4qW7TjOl+dlBNOOmhr7ncup3IWlbZwfC9OEVRAS/oegJ7T6SLrAJyTvg5kWWyVzJT4Dn7wm+LOwtlH3ltwtN083ygYimbIp89gA/7bCnUkk3XbdRU6KTNR19+ZqfkpI9gDcSqLZ0j//muXLaGvMyXZrR5RP2sYHEiCpnwxod/pcJE8+jXhh8YT56cjRBf/dDfbGuzKsl/L3tL/p4j42V5WTXvQ0/yG/CMQOXMjfM2vOQvf7oj3AiuWvax09asqA8bm9FJU2c78Qa6xb1UlwIs6bVMrJbW1Eri4xfHmrQHKZ/GO2RyubYdinZKJmqMg2kvZD2xUTpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMmNmw0BdM8e7t2dGsTCjebzhUzlJ9KcwIUBkZk6uiE=;
 b=XlPpsm5POb2gfl7qlU0hVMq/ed4/97Mzt4m9t6J0Jy+/CUshMPUpHef6qaKxkvl+JpFBxGEPIKYG281Yj9nuGYMIZDtykSRC8xuAfjnhq+wVpEmw859N9POrXeDw2FH5ehznOX1B907UVjUUxOwMzjlaf+CAw1lohOgqgLzs/CI5wbSY9dKZRF2ua+KEsC4O8BN17/bOsR76I8uv0RXQpNHhP/KnRC7mGXlLqaGFXfqu3GBxZJUg0rYaf17xJQBYHYC2hy3SJTojzLm0fyKIGg9WooMWADgQlCsmHwPm5KpUn71uS4twja40gTQUSmnEBmXqtEq7gK6e8GkQmLj1Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by PA4PR04MB7535.eurprd04.prod.outlook.com (2603:10a6:102:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:38:11 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:38:11 +0000
Message-ID: <14bc9ddb-c80d-4ec0-b719-19f87a8e99ea@theobroma-systems.com>
Date: Mon, 22 Apr 2024 11:38:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Makefile: don't add -Wno-maybe-uninitialized twice
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>, u-boot@lists.denx.de
References: <20240416073524.25764-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240416073524.25764-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::18) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|PA4PR04MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: ade34724-0a3a-4808-ffbc-08dc62afece4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWUrMENDaGFsTlFFOXJpNXBOWlg1MldWVGhDSXBoMGF3Wmo3Mzg2U1I2YWF6?=
 =?utf-8?B?QUFYMnRMemRKQ0Vsak15ZWlESHc4WVhjNUxvL0R4dmVpQjdBSHhxa2pKNkZl?=
 =?utf-8?B?T2VDQnV5S1hkQ0MwaVJXZEo1ZjVIeE5QRHNKbldRNnI0bVNya1JrQ2FQa3hI?=
 =?utf-8?B?WXpqL293SUxPRXl0VlVQdFpYWlZVMjR5YWdyT1VUelcvZWt4NFhHVjVnNE5T?=
 =?utf-8?B?WGVYaHBMdjVYWkUvVmJHM2tKOFZiOTNMWDg4UTIzazBvVDlHYWNZV3JaQ2NK?=
 =?utf-8?B?RzE5alZ6Q1I2ZzVraUtIZGoyT082c0M4ODEyL1pvbVVidzRKOU9UbkFUalZI?=
 =?utf-8?B?SXRDYWN1ODh4cGpUV2s3RHRjZ0xxMDNYUUdvMzJIeUc1a2V2SmlwVHY4cjNH?=
 =?utf-8?B?dXR3bzEwV3lMMVpMOFY3aTlzcnFjYkxkWDllNWR0VzZWdkxOeXZMQU1aZkhv?=
 =?utf-8?B?MzlTV0Q2bFFWRDQyaDNacEl6dC9qNUdwR2dYOHVIZ3dqRXNQeElLck53eGNu?=
 =?utf-8?B?bDVoTFNHTjZSdVA0R3pWUC9QdElDS3N5Mm1kZGFSUW5CYWxvbzRYT1dTNWVY?=
 =?utf-8?B?bGJyMHJtMHB3YWhKc092dEJNNDlUaTdNVVFZcnkyRXQwYVVvSlVRWDBtWmZB?=
 =?utf-8?B?RFVSa3JDZitybU9nR0ttYzEyalZadGFIUHFvSkZWblJwS3NkV3V6TWdHK09Z?=
 =?utf-8?B?RXA0d01GaXlTQ0pSTlpIeDlOWmlyWVFzelpyVWRSVUN5eFE2KzFIdHFmUWhN?=
 =?utf-8?B?c1pHaFdvTFNQWjVTS0prL09sRGFYdWZJNUV5b1IzTDVnWWJPbzk0L3Q5OGZL?=
 =?utf-8?B?ZUhnR0ZDcU5id3FkbEkwYm44dFo3elU1WE1jcW1nQ2lGeVJkUjNUNGZTS3A0?=
 =?utf-8?B?MmFPMzlNN1pXK24zZEZEY3VQV2I0ZklmK1hSVTFiS01uVlVCSVM1SDNxVzdq?=
 =?utf-8?B?d2JMbjNUL3NCZVkzekxjdkJsSmhaR1RPaER5a3E5ZTNJUnAxR2YxMmp6U0FJ?=
 =?utf-8?B?WDBLQXdwZmFIaVVkTU9IQWFTWHdFU1h6dktFZ2R1aGNJK0NuSkt6MHB1ZWFq?=
 =?utf-8?B?OFJ1UTUva0JqVGNuNTlpNktCc09mQVZsbW1XZFpaeWtkYWlHZjAvTUtxdHRj?=
 =?utf-8?B?K3pEMW9JaGlVOThXcEl5UDdPeHVoNVNjVjFLTGNRbW5aMDhnMDFzYU1uVk95?=
 =?utf-8?B?TGJKaUgxKzIyZDlzbmJRb2cyN2gzd01yN0NOcnpBZnVVc1RJSVhKZGMwUFFP?=
 =?utf-8?B?MjE2YXcyOWVNY3ZlNStNWFArQXdraVpkSnczbU5rQmpJZkJIVG04KzIwY0Zp?=
 =?utf-8?B?ZkJqdkZYMncra2d4QjBTeDJuNVEyZVNtNW5jbTZpTUd1cC9CQlpOcThGakpN?=
 =?utf-8?B?Z3FRek9zbzRPQXppWll2SVRMcnplMCsvNU9BSUNUY2t2YzB0bFJLMXJZWndz?=
 =?utf-8?B?SlBUbS9HQnFHa1VxL0JUYXY3TW1nZHVlR3pzWG55bDYzSXJYcUo0WU80R0xO?=
 =?utf-8?B?MnlMcnVGUWxEQ0RyUVdLT3ZjMTRwL1dIS1FzVVcvcHcxK0RmV3NtWXJ2aTFV?=
 =?utf-8?B?SEpNS1ZmWXh2ZENERGJPUDVWdGZnNkFXc2RQMEhub3dHQUo1bkNuSkNVeEJG?=
 =?utf-8?B?ZzlGMXlZZUs0QTkwYkl0OHo4RTUvUDNyYzlHb2dyZmxxQ3lCeW45TU9zaldw?=
 =?utf-8?B?aGxaeTFCYzRpSFdhOUFrb284b1FPQ0U2UHRXRjQrWjBWVG5hQUxqa0ZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGdZZk5HR0VXNkc5d21waVVZNkxxMXB3ZndEaWw2N2FwSjJ0MEpoaWcvVExj?=
 =?utf-8?B?YlB6Z3VKYWw3eTA4VVB0akV0QlJndktINmdlZFp1WEFPd2NsN0czbDJwdVZr?=
 =?utf-8?B?bVdyZGF3Mnp4ZXgxMkJKOVByVHpPMVBkUndqN01zUmxXT28wM1BVU29sa2FY?=
 =?utf-8?B?cy93eDZ2VFBHUnpmMHlkOFladDU4WWUyeW04R0JVRm1XckQ3QWR6dzBlTzlw?=
 =?utf-8?B?YUh2d3h4bHYxWWg1dzRWbE9uZzRKTVlURm5BZzNlK0JxajZBMXZndi9VYmFF?=
 =?utf-8?B?MlVHMjlZU2hhcGFURGFhaTBoUGxaSWhvWVVSYVBuN01EL1lYMVc0ckFjYXUy?=
 =?utf-8?B?UTBIWFVLL20vdyswY1g1RmlvV25ScjNyOVd1OUZscFpjNThSN1RqUFVoTWhm?=
 =?utf-8?B?NGZzbGV3VEJZM2JZNDN1eFVkeS9zUzJaeklobndYS0ZvZFhGdWJVTG9JUGxH?=
 =?utf-8?B?M0ZDUDJtTHZDT3NHclJsS1hjanNHNXBMTGM3ajZ2ZjdQS1MzbU5vVkdlQWcr?=
 =?utf-8?B?TlNqTTNwODRpejIxVXl1OTJVcmd5RE1HOTdrRVBIaFB2MFQwMmI5ZGI5Zm5s?=
 =?utf-8?B?UmlrVzVEcnRiQWJWQ0U0aEZ5QzFOL3IvWmNVQ0F6QnRTK1hxS1hPOG53Sm54?=
 =?utf-8?B?SHUvTmtjQ1FEc0dOcVI3dnBoSTBqUTFabFlWc3RiZ0JES3o1SDhzSDE0MFQ0?=
 =?utf-8?B?ZGJTUUtsYURTeXNhNGwxOTRtQVlvZFQ2OFN3YlFXYVk2Z281K2hUdWRUSW1K?=
 =?utf-8?B?bFB4MkpqM3VUOWt5RHVEQTllcjVUUm9QRkgyL0lDb2pQZlBGZlFRSEJwV2Z1?=
 =?utf-8?B?K25HbHhiUi92RWt0TGs5UkRsb0xWa0xzdzI1bXNuMUdOWXl0MngzNkw2c2Qx?=
 =?utf-8?B?bXArOGFzc1RHdWViRkkvMEhNZlVVSlMzYzR0czBhUFlOUXJPL0lLdUJXS1hk?=
 =?utf-8?B?YTVPUGUvREovcWVVeXZOV2hNdmIvTkVET2RkQm5KYjNrVUxMWEVvV2F1UnR6?=
 =?utf-8?B?N2hDWGlKUDVoNkMrcFlXRkh2RmdrS2NiY29OY3psMVgzZElycExobW1WOXND?=
 =?utf-8?B?TC92RUM2YmtFa1kxVWN5aE1qYVk4RzJMV0tEcUNEWUk0Rm9WcHJ2UWxETnZU?=
 =?utf-8?B?TUkwaHFGRVNYbzdrT09Xb21QZHlONFJ1UDY5WkJvR0JGV2pqMzBFMEFVelgy?=
 =?utf-8?B?a3kzS2kwejd0UFYzY0VnZXJpTlBzNDY2ZlhNOStNaTdDUC81UjNRYUNXS3g4?=
 =?utf-8?B?TzU1b29pSnoxRmJhY2l6VjhtODdEMjFwbWUxS0p6RkxYWjQ0cEhYbzZZYjBR?=
 =?utf-8?B?L1lHdjU0Y1ZsSlJaMUw2Rmc1RXQ0VmsvSEYxdVZDUlpuYklEbU93MXZMYXpT?=
 =?utf-8?B?R29sTkxaYUp1VTlLM3dpVWRrZzN4MVZ6MVB0eWNtMUNNcUVxc085cUdpaXNo?=
 =?utf-8?B?Wi8xa0FIZk1iUVdKbHg0TEVuUXNQbXlEZ215TXlpZ3haOUZES0lmQU5WNXZ3?=
 =?utf-8?B?ZVR5dVhwUDJESmoyRmFZait3aW5Kc0Zibm56dFZOOHFQNGxRRHBadmJtNjJM?=
 =?utf-8?B?MEk2aExHdEtrcktNcGt0dFNGVDRIQmVMYTU0akVwaTFueTdCbFFYOGJIVFQ2?=
 =?utf-8?B?RHg0b1FLUnAzS3pRQU02VzVHSEN4L2ZRSkc4ekMvU1kwcHgyWU9ZWnhBbkY5?=
 =?utf-8?B?S2pRK1hpTDIrRDBaU01jNXo1VytnS1czdzNQNjltUDJsYTh0OG84dzNMWXNV?=
 =?utf-8?B?MzRUTks5WU5FY0NVSVVTRUZ6eFFyZm81aEQxOU1Db25kQUZXTVk1M2Q5Z1h6?=
 =?utf-8?B?Vlh3Sk5obnNVMGlLRThpQmgwb3VBWEdDTlRJbm5tWmlMMDdEeGJSdWFUVlJY?=
 =?utf-8?B?NnRRRVJFcDdlRWxRdkkrTUhPSjJjY1kvVjZMRVZ6VkRidkhiUUpycnJHeGc0?=
 =?utf-8?B?VEc2YTZlNWU5ZG9YcDhFNUxLdE5qTDVLMGxrVWY2Z29jQlU0c2lsRFYvaDdU?=
 =?utf-8?B?bFdjNTJ0QmdobFQ2ZG5ORWQvb3BDMFk1T3FQU3B5MmFiY1RLQ1d1SzNJL3Ez?=
 =?utf-8?B?RmNDRlFFaDRLcWRmWENiWk9QTFFQRXdYN2JiZE1uVTRNWjNhdlJGRm9rWVZK?=
 =?utf-8?B?Wjc2cWY1U3pkNDI3TFU5eUFvVkduY2tjOThGeDFUaUVtVXVTeWlaNHJ2ZEEr?=
 =?utf-8?Q?1+5xBl4iTFcBF5MLNsmQBjQ=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade34724-0a3a-4808-ffbc-08dc62afece4
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:38:11.6004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5Ol2tgWCiyex5rdhFnY5/ATmLx734zKowjM2T7rKkbpVsFbBh3jAGcsLVRxLZN4UWixo+JBwWOJa2ctxEXhQMPJ7oolXVlUkRLdqFzqB2eFpiaUXQ4QQJqkK7U3mgY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7535
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

Hi Heinrich,

On 4/16/24 09:35, Heinrich Schuchardt wrote:
> Avoid adding the same flag to KBUILD_CFLAGS twice.
> 
> Fixes: 8602d97ca2cf ("Makefile: avoid false positive -Wmaybe-uninitialized")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
