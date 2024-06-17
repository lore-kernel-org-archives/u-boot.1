Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B298AC2BA18
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 09:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE79E87D70;
	Mon, 17 Jun 2024 11:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ih1DShAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A44FF88167; Mon, 17 Jun 2024 11:44:25 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2600::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BBD387CDA
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 11:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJZtBjgOHrPiuqueU0jxEC5L07uaDStWf3/YmK3+7WPrCpXh5862YqRjxQ2Fu+HChMEODKqt1IYqNwT8SxJrX1Zk4Yxb29s5IWw9f4YhUM76QF58cOK4YfwhmRz7MF0Eh+PhrRUMxqAWjv/Ap4xABt1WZYa+77ttegBRpKqTbC7jjZOQpnhRJfhI+Rxgn9mVzzTZrbKC0+Umf8yrsgL7k8jz3Als8xZ70fuS5U1G/J/ZmIM3nIh52OHYLZaz/qPdHRB5NfCGwxIUtx1IPIha51p8q8xtaR6alGk5PQo2qXWKz+Pn/sfqyACUGzx7CaUxp4pMud09+D0ybTmpL25EGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo6NBLEdwYNle2YcQDEfNjcwSXNnN/bRoy0pYKKkQLk=;
 b=QymjaVJfhFHraLgKMJPM2KGJjTfOWRmEXWU6msm87ohNn2in7lStfTQPfEMEbVk/oZ83E60KzjxQVmZ3uFfvNQqjfy244hgG9q1G4RvqX5vcQBrSky6dI9XOSXqC8x37NBdX3v/GDAp1TfXJd8hScTKXUE9SlIcClS5wZSo73MCAO9VWAFYRP1UpqA/W47tXTmQiISjU+WmMaaSKP2s2nQ3x9g2XPqQW9Ts6zqs4jYQfoIwCfGtg/JuFv7IVwB+cNAexKwMPMlBNlmZB5rAmRym4eI3KjaVOHjn0phL2TcL607D18iwJGJsQ1LhLFWtA+VjOBBouKXPZRGXDCsgxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo6NBLEdwYNle2YcQDEfNjcwSXNnN/bRoy0pYKKkQLk=;
 b=Ih1DShAQXQ8ohHxHgSOzpbELqQIPFFZKeoVj/STSb8on8ifVtyXlS3Cyu/00tMtk9oOS/NqVJdhgjY/ce9SAxyQMQo7Lby6T8bv9+1srawwZaE0RUnF2O8+TeNMo8zbXYdVk/n5MrsNmFEFGyuMHrcIdHaIPn273sFH2gs0OrV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA2PR04MB10213.eurprd04.prod.outlook.com (2603:10a6:102:401::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 09:44:20 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 09:44:20 +0000
Message-ID: <407cd11c-fcf5-4fc0-8015-f156ec183f79@cherry.de>
Date: Mon, 17 Jun 2024 11:44:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] bootstd: Replace bootmethod(s) -> bootmeth(s)
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
 <20240604-bootmeth-typos-v2-2-821683a95aaf@baylibre.com>
 <a7410171-c413-4815-8187-606d32b0c5b3@gmx.de> <87r0cwaxn2.fsf@baylibre.com>
 <cee89831-9ece-4dd7-b021-538c6fcacfae@cherry.de>
 <f7ef89cb-7753-4cc3-a287-aab1ee097e60@gmx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <f7ef89cb-7753-4cc3-a287-aab1ee097e60@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0033.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::13) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA2PR04MB10213:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f1f6e4-02f7-496f-217f-08dc8eb21033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ykl1aVhWa08wdytxZkw5ZVJkL3dDbk5EeDVOYlI4TTNrNjV6R0pjK09lVHB2?=
 =?utf-8?B?c3ExL2s3d1FVMmVBdFF5aktwV3BOVWh0dW9OcHVTM3VCOG1iN3RwazBEMjRE?=
 =?utf-8?B?WkZHY0ZwYlJOS2ZQMUlsbWlZbTFLdG8ydUR5dWVIVEc3MUdldkkvZ2Y1eUM1?=
 =?utf-8?B?elV6R3dHVy96WXRQUzYrZG5NVnRwdzBnVnNjNEJpbEFFRktxYVVGeVVtZjFB?=
 =?utf-8?B?dmlJeVM0SG1jK0pHQTU4ZU1PT01iV0FKbkhRQ014YXdFNmRLd1hUdVR0Y2ht?=
 =?utf-8?B?Vi9vUGJyT0EvVG5xR3dTQWZDV2FCbmRRVEVzSy9Ud1VBOFFmQ1E5RW9YaEtz?=
 =?utf-8?B?bnJacnhOekpFQmJlZDdIL0F2aGJySWNMQjBHOFZITEV4UkFmMUFsbi9nY25a?=
 =?utf-8?B?azhaVjAyOFlKVmdibGVlSTdpa1lEb3hYdDMxSkluMzNPVy9hUEpCaitTbFBN?=
 =?utf-8?B?VmVzZDdZY0VaV1ZxT3FQTmltUTgzTGYyZHdxVjZZZzhZNVdGVWFOZmY1WS9D?=
 =?utf-8?B?MzV2MDZYbXA0L0cwcHRIMCtoYTZWeXFEZ2phcGZ4MmovTHVqOEF1MWYzbVNJ?=
 =?utf-8?B?dUN5NzJKUkgwZUtuYTNiMk1IOWh6QVZ5YUk5blB0ZkFaN0VWS0NIb0lQcjdO?=
 =?utf-8?B?MDE0QnJYVFQwaE80czQ2eWE4N3FybjZDS1Q5LzNDc21QVnU1TXVBSDB2WlRC?=
 =?utf-8?B?L2hOdFpwU2piZHpPc3ZZRkxWU1lFTkNpZWYrQjZ1R29aN3QxLzZhVFhBQzYy?=
 =?utf-8?B?elZ5WnFQMG53ZnNlOWJSVWxtK0RxUjN0UUVaSmZweStySHhFanNjNU5sSDBu?=
 =?utf-8?B?Q0JrOElDNmh3bExhSCszeUZVK3VhT2QvWlBtMk9PMEFGTk5xcEcwa1lIQTJ6?=
 =?utf-8?B?UGdxN3RKSFlQVVBKZ2NMVzlNYjR6bzNxM2Zoejl5dHZDclBienhWY2h2ZnM0?=
 =?utf-8?B?R2tHTEliUlE2b2FCQmtOZHV2M2gyeEt3cjN6SzROV1ZqTmI5V1ZQZGdYZWJy?=
 =?utf-8?B?RmVoVTJiK2FtR3QxT0ppYUFzcXlZbXZqYi9kWTd1UDRTSG5SL1JyZGNsUWtn?=
 =?utf-8?B?SWpRNUxHSGJRTnRCQmJJZTRkOVpBNmE4Y3BvVFJiR2RCNmVmcDhxWXRVdVg1?=
 =?utf-8?B?ZVlreHhPTWtJVzZabU4yWE50ZEV2bS9mbjNtRjAreEhZNHJnMUp1L1prZ0xk?=
 =?utf-8?B?N0RSNUYxUVZBeVBhc2p6MzNEbnIxSW1UK2V3RFM1Sm5BYVFJdjc5U3hNQW9t?=
 =?utf-8?B?Tm5QZVdJZlJrOEE5ZUt3Wk1icGpEVkFGd2xCTVEyQjMzK0RGYzRFdlBLSXRq?=
 =?utf-8?B?dXRMUCtsTVB6eTFpaTFXNXZUOTRhWjRCZ3ByV0VvNUR0ME1UN2xVRU9Pd3pn?=
 =?utf-8?B?R1cvWmhDbEZFU0s5RHBZQWZFakJRaWRQdEthVEVnWkMyU3JpOW96cmhhZG9Z?=
 =?utf-8?B?cForQzh6Nm5nVG1FVzluK2YvK0tGWlZOdWFTaE5TUW5IYTVGeENYRks2OGxv?=
 =?utf-8?B?czdzNUxXdkNrR2svaThRNXVMNVVyaXNueFFWTElCeGdzOWx4MkNuRnUvUnFL?=
 =?utf-8?B?aE5iZncvWFcxK1lsQ0pEVXdLeXc2ejlOckhMYUwxamdqbWtzSzM3QXQxQnJ4?=
 =?utf-8?B?Qm50UnhGc2JodlVYRjQ3NnJDb2dHUnVpWi8xL0svdWJaYlZzU09TV0kvTHVj?=
 =?utf-8?Q?7CFQW1jwF3USwk3QDb34?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0RVa0hoVVZwTlNQWVJMZFdYNmkrRGhFT240NDBQVno4Y25UWjFsT0ZjWmxG?=
 =?utf-8?B?djczeERVMzRJUTBHMFV4K2MyVlhsS1Y1elY1TlhXUlBOS2I1Q3V3bzgwb0Y0?=
 =?utf-8?B?cmFWa09QQnRZcURzN281U1YzRWpuQnM4MWUxOTlxNTNKeGJWQ1YwL09UOHpx?=
 =?utf-8?B?NDJUZmRndEh6ajFTcTg4bk1pZVM1R1dYYkh2RUpZWGphV1kzT0dvRXVHUFVE?=
 =?utf-8?B?YVBWVVBhOHVwNFdZQk9WdkcxcEFsb0tKMlRCc1dEZDlQa1VZd2pKZWNpNFIv?=
 =?utf-8?B?Rkw1NDl0dm44U0RGYzZtRWZTbktQUkNwandDSWRkYnVRdk1hWTdKMDN2Q0c3?=
 =?utf-8?B?cGYvb1NrRTk0b2RkRllqdUJPUm1yTmYxQnF5NG81Qk0vWXlGZ0FMVHFjaXFG?=
 =?utf-8?B?NCtzZWpEaHFoSWpES3Y5QnRsNmxiK2w0ZDRPYlk4ZW5oaXlCc1ltYVdENUZh?=
 =?utf-8?B?bkZtblRaa0I3RHU4S1hhWU9CSzFDK0xsYjhNVFVDY044WjJnVUw5NUtvUzBY?=
 =?utf-8?B?dTdMSUR1ZGQ0d21INFQxY1gydHZMT2FXN1FDVXRmMmIzdVJscHRJeWF5L3hQ?=
 =?utf-8?B?eWNYanNtcnNWSlpxRm9ZalROZTJLaWZKZVc3L1R5YkVmVFZTL2FpWjFQZGlo?=
 =?utf-8?B?NUx4d0s3NlJzTFVNZmgreTJCTHlMckYxL3JFdEZnQmR0ckJ1S0dvTUx1Y0ts?=
 =?utf-8?B?dUJsT25Sck1leGx5Nk5DQjNCRzV3ZnJxRFFsUHY0dUtXeElrdU80QlVzN1Jp?=
 =?utf-8?B?OEZEMW1wZ1ZjQkVaVHNsQ2hKWTFrODBsckMrWjRGRk1ISkMzV2JSdlpwazBp?=
 =?utf-8?B?TXM5OFF4elRNWU5yQTZFdmRuTUtXdExFNFNYTXJkN0FlcEZGY1l1ZU9kSXY2?=
 =?utf-8?B?ZGZjTFJEMDdWWjdTeXQyL2podE1rWWR0VHloTC9rZ2ZzWUptUnVRT29oakor?=
 =?utf-8?B?eEdYRVlGQ0g0NDZkTWZ1R3VvSWxsY2RTQ2VsT3RESmFwbllhbkJkM2xlNmVZ?=
 =?utf-8?B?M0grelNJL2MydHFHb3NaYkVSSEFiWitaeVY5alN2dXRKWjk1NTdpRjdHT2c2?=
 =?utf-8?B?OXhUWUJrTWdqRWNad1ppQzBPVnR1T2xuQzExQ1dPSWpSNGxXRVFyRjl1Y1lz?=
 =?utf-8?B?bjBZUXVuRk9nY3BKMUY0UlN0WTFpdnIvOEdublM4Y09La2dCRU15UDZLZ0NC?=
 =?utf-8?B?SmRYZmw0bzNDZTVWRklEckpsN0RkVjdNajRpNG5qamxWVGltYkEvTmp3cDND?=
 =?utf-8?B?UXBYSE5Xem85MUVveW96azM3SitscHUwYUI2Y0xUeVV1Y2t0b24yR2lVa1hC?=
 =?utf-8?B?aFdrdUxWYzdEcklDSnJhTlYyNFYxL1B4UUtlWEhEdk5HMEE5bkFOMGlZS0xE?=
 =?utf-8?B?RWp4TEdML3NRVVVuWFVxaFpoKzdqR28zUTZtNWFHeHBPemZLdzNGbEsxTG13?=
 =?utf-8?B?dmZPcm1Cb1VkVkwxWWx4R2VtaUZKR2NLU1hvWjZKK05vRHpaZGJnTUp0YTlt?=
 =?utf-8?B?TjVzdWgwVUZqWG1jWWZFQVdqMmh1Zy9nbnphbVpUQy8zcHJ6UHp0TzdKakQ2?=
 =?utf-8?B?NkxwWnVXS05nTGNrNW1kK3lsUTB5S3dTLzdwSDZQaTl5dStBT1IzbWppREtz?=
 =?utf-8?B?S09PRTVKWkhDdWJaMG82TSt0d3UxN3kwSngzQW8yVkFnNnFsZ0FCdDFhY3dG?=
 =?utf-8?B?ZFpOQkVlMkZ0SHMwTzY2T21JTUZFN1hPL3NKdHF2VUcreFFDcHQ5VnBoMk1z?=
 =?utf-8?B?ZU5TckFTOE9qdmhvZ2svZFJkWnQzTzVYT2RqNHJYdUxMdmlCQzhlVHc0VlBk?=
 =?utf-8?B?SW5hb0xtMCtLZndVZlRCeXV2VGxkcEM4SVY4ZmxqM1VFeXl2THpSbitXZWtS?=
 =?utf-8?B?QXRqUS8zU1NBUmp1UEVneVZsdHNMWjdsTlVEUy92bjJvNnpLT1BuMVJLY2dn?=
 =?utf-8?B?ck16Wlc4SzcyNVR0QXNpd3V3K1k1d0dac0tFR3hQMGl0U3grRDd2WEJDUTBl?=
 =?utf-8?B?MVYvZDlMbXpLYXUyMUloWWcvdnNOZXJhZUhlOGliTXlLaGFPalFRWmp5WnRs?=
 =?utf-8?B?bzZKRThzZThKMzN0NVRLZFhGUElBMXFEenRDWlpPV0ZFZ1YyNFY0OTIwSGpC?=
 =?utf-8?B?TUMwemZQbWFRUVZnRzY3aU8rK01neHNnUC9nbnRGOTVqN2tpcVlCY2lQWlBB?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f1f6e4-02f7-496f-217f-08dc8eb21033
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 09:44:20.8290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfFAJ3OpHA0EXwqFi3wS6Vv/KnLkEbMBCm9hxllUHCnbvMWqg2JK82sD8UgE2nqJX6perXaYpFQymNdoE8ygRjoIKY3wKTZVooV9S/1AwYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10213
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

On 6/17/24 11:24 AM, Heinrich Schuchardt wrote:
> On 17.06.24 11:00, Quentin Schulz wrote:
>> Hi all,
>>
>> On 6/17/24 8:31 AM, Mattijs Korpershoek wrote:
>>> Hi Heinrich,
>>>
>>> Thank you for your review.
>>>
>>> On dim., juin 16, 2024 at 09:38, Heinrich Schuchardt
>>> <xypron.glpk@gmx.de> wrote:
>>>
>>>> On 6/4/24 17:15, Mattijs Korpershoek wrote:
>>>>> According to [1], we should use bootmeth when describing the
>>>>> struct bootmeth:
>>>>>
>>>>> """
>>>>> For version 2, a new naming scheme is used as above:
>>>>>
>>>>>       - bootdev is used instead of bootdevice, because 'device' is
>>>>> overused,
>>>>>           is everywhere in U-Boot, can be confused with udevice
>>>>
>>>> Boot devices are udevices though they don't relate to hardware but 
>>>> to an
>>>> abstract concept.
>>>>
>>>> bootdev is just an abbreviation. This does not make the meaning any
>>>> clearer.
>>>
>>> Per my understanding, the name for this concept is "bootdev", not
>>> "boot device", see:
>>>
>>> https://docs.u-boot.org/en/latest/develop/bootstd.html#introduction
>>>
>>>>
>>>>>       - bootmeth - because 'method' is too vanilla, appears 1300
>>>>> times in
>>>>>           U-Boot
>>>>> """
>>>>
>>>> Avoiding abbreviations like bootdev and bootmeth improved readability.
>>>
>>> The above paragraph is quoted from email [1].
>>> In this email, Simon made the choice to use bootmeth and bootdev
>>> when pushing the initial implementation.
>>>
>>> This patch just corrects the places where the older terminology
>>> (bootmethod, bootdevice) was still used.
>>>
>>
>> The current wording is just incorrect, so it needs to be fixed. We have
>> two choices: use the struct/abbreviated name (bootdevice -> bootdev;
>> bootmethod -> bootmeth) or the full name (bootdevice -> boot device;
>> bootmethod -> boot method).
> 
> The English languages has three types of compound words: solid,
> hyphenated, open. bootmethod, boot-method, boot method all mean the same.
> 
> According to 
> https://www.merriam-webster.com/help/faq-compound-words:
> "Compound nouns are usually written as one word."
> 
> See also "U.S. Government Publishing Office Style Manual", chapter 6,
> "COMPOUNDING RULES",
> https://www.govinfo.gov/content/pkg/GPO-STYLEMANUAL-2000/pdf/GPO-STYLEMANUAL-2000.pdf
> 
> We should avoid unnecessary abbreviations.
> 

It's too late, the abbreviations are used in code already.

For documentation:
https://docs.u-boot.org/en/latest/search.html?q=bootmethod&check_keywords=yes&area=default#

bootmethod returns no match.

https://docs.u-boot.org/en/latest/develop/bootstd.html#bootmeth
https://docs.u-boot.org/en/latest/develop/expo.html#motivation
https://docs.u-boot.org/en/latest/usage/cmd/bootflow.html#bootflow-list
use "boot method"

all other instances are of bootmeth/bootmeths instead. A little 
consistency here wouldn't hurt. I don't think the current wording is 
consistent. I am non-native, if I read bootmethod, I assume it is used 
with this wording in the code, but it actually isn't, it's called 
bootmeth. If I read "boot method" I understand a way of booting, and I 
will likely not grep in the source code to find how that works.

If it's a NACK, please say so. Otherwise please provide clear 
instructions so we know the wording we should be using for this to be 
accepted.

Cheers,
Quentin
