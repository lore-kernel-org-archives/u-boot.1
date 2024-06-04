Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D34EC27C53
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 15:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D93DA88494;
	Tue,  4 Jun 2024 17:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YKFQKZa5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 719A088418; Tue,  4 Jun 2024 17:26:02 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2428788494
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 17:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NABg1IMY2+fA5+IqXEWzfN+6ZQt1xMzAusrO07lXAAOf2vUwU8kyywldzRAmRMQQLWzY5cyIlMS5hlWLuRJlBh6VKALz40HRJL5qNsbdsIyMTefIfQHlhih7vSotRyO3e/xq3XPbKj8rVeeXfLAVRJfCJpzXPoHlPrf8jdzbR8LkPRvJBkbArc2VThE+eXF7gxQ1LnOlM98GcPN5uUGJWhQa/eszHVqBqWX/HKaEKocgLuOqvff/JTS/UKdI69JbbwcG3joXJOrrZ9fYSA/caV8HDrLPam0oeMwuWEQQmtzgsi0GPvEVuqePWqX6B/gsPVPMyR7SDuRQI8Ef1AF3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvzFbl1kBMI3iS63F9sD5t+FJOsgyQLSVl6bvrYzVC8=;
 b=oAVaV7ZEPBdE4OeKjLXDvNvjAL15HcocViSalSd4mAV3uN1caQh870BxLYKpEVDsStv9O2e8Clo3jJhnO3O81dKCr8LpXZGEL4Uwp43E9YN1rcTSSdFBM49pqi5GNnIr+dBHjfGBs+tMVvgvVmLr1aTPSMNULwYGctTedBms1TO6xToSCJkGSxE9xA/z0EnAQPkR6XiJF6IILk4XoLFfPiVYHm2ujfF6DePZ/J8bB6U5vMxl36C3JseRPp/sU+JpDC68TnbwuOVGEPhjjiJm3Jfh2BG+vXa2Ex5wmBIBaJpJ6mLyMHY9l07NBVaUNXuULBUCFqB/hNFcL2spuOkBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvzFbl1kBMI3iS63F9sD5t+FJOsgyQLSVl6bvrYzVC8=;
 b=YKFQKZa54GZzGiuYHhd45WbS/dFIR2RppBUOUgbUmyo4t7rq+d0f1V1gxIQFiEobJgmW4nAmJto684HDgxM4bbaJZAu7KOhtHwheYIPqNZyMHq/sV2SLJbnU/Lb+i/dmPAdwvhmGUpwynUIdAPISqd/QeX/rEaUaVCxwSRpEheI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA1PR04MB10324.eurprd04.prod.outlook.com (2603:10a6:102:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 4 Jun
 2024 15:25:55 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 15:25:55 +0000
Message-ID: <09afc533-681d-41ce-aa3e-5cbcb0469b21@cherry.de>
Date: Tue, 4 Jun 2024 17:25:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] bootstd: Replace bootmethod(s) -> bootmeth(s)
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de
References: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
 <20240604-bootmeth-typos-v2-2-821683a95aaf@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240604-bootmeth-typos-v2-2-821683a95aaf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA2P291CA0037.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::17) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA1PR04MB10324:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f65b46-ee98-479e-537c-08dc84aaa075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TURsVjZyMkNrbndwK1NXZG9lRlhnaVBJYW1ZYXJ2U0E3b3lJb1BBU0ZJdUVl?=
 =?utf-8?B?NWpXekRSUktIcVdycVJzVnJCSStvSDY1aWFCSUgrbzIyR0wwU2dUSE1RUzN6?=
 =?utf-8?B?b0xvem5BZUNrSDJnd29vNVU1Tlp0aytsczNka1ozcXY4d3Y3a29TSVFZdmFJ?=
 =?utf-8?B?RTZtcGtOZUx1SWFjSGVEUlFjZVhnSnJjVytiaXl3ZHQrN1NjTTBkQm1KVmZ0?=
 =?utf-8?B?cUwvVXZYbHE4UVZUMkdJbUFyUUxmQUcrSkpEb1FyNCt0TFA4Q0ZJd0RNUUFJ?=
 =?utf-8?B?WmMxQnFhSWZWZlVtQ1JEOXB1RHNsclRRVlZVWmErL0trUk5ITmxBWUFmYmZH?=
 =?utf-8?B?WVl5TDFlalJuVWhpbjNGZ08vUzNDUjZBT1RMSEFnelBqU2QvdmxlYkhHMDZG?=
 =?utf-8?B?dWoyMjBUaWpJQTJHUGVuM1JFNlBqeFB5cGpBMWZLYTRJQ2p0UkRxb1ZaaFF4?=
 =?utf-8?B?ZFZxQ1ZKZm5oREt5aWlIZWttTzM4QlRDQkJIZjZKY1dzL2g4Nkxma3UySy9W?=
 =?utf-8?B?aStPNkFSL1dBMUlYVFVnZ3M0ZTZZcnFsVkhuYitIcml0NkkyRW9vVWRRelNQ?=
 =?utf-8?B?cVdyeVV5a2VheTNJQzVDd29TVzc1Sm9VSDFzTXRhY0pTaHRhb1d0R0JlVjFM?=
 =?utf-8?B?OC9RQkhXRlBHU056ZU9adUc4ZGlVUEdua0tZSmNjSWkxZUs0TmFEREFZTlNq?=
 =?utf-8?B?dW96Sy9JTFBYVkZ0VEkrc1Y1OGlEZC9Kam9yeVpWTk0xaGYzcW05ZzRpWWdp?=
 =?utf-8?B?NkkyNEMxMTVFNnZGalFZVlJtcUt1QS83TUZ4MUFVMUVoRTV1L2tXc2N3VUg4?=
 =?utf-8?B?blFnUzFacjVVeWtQUkdXdm5ZQlU1aWhwWGVkNEs4TkRGQ29TdXNBbG9BZlpt?=
 =?utf-8?B?dHMzYndiaGQ0R2xPTkxzTHpWQWZhSVlVQWtqWlRPcmE3cXIwZEViWHU2TFVn?=
 =?utf-8?B?U3BWa3lJU0pjYXkwQ1FRemh4MzNoRzVzRC9CWnlEYmlNVXVyV0l4cEFBUTdv?=
 =?utf-8?B?Vmk1cHZmWmJiQVZqR3ZwMTNqeTJwZDhuU0g3OXVNQXlFR21EenVOKzlKNVo4?=
 =?utf-8?B?RFplMnJSYTFkU09KWDZlY2xBZ3BzMUFYck5SR2wzQjBJeEhma2N6Y3dkMzU2?=
 =?utf-8?B?OXJlWU1Gd1psRVRWZjNkazhKSEc2OGp2WjFuZ0pEaVBsSjZTOWYzMjFFVXd6?=
 =?utf-8?B?UUlpOUd1STZ5cHI2VVNBLzRLQ0dJbEJvVmtrZWh6VWpzUi9LUkJSOWlGK3BI?=
 =?utf-8?B?YXBuV2Z4ZE1TdTBwS3JIcmx2ZXJNWEFEUzhvL0lRNTI5U2k0L1I4bEtnc0Ix?=
 =?utf-8?B?Y2VERmUxL2pzZE1jN1RuVEFXcWVEalNBSGJoUWk1bGJaWkR2SnlvMWs5ampD?=
 =?utf-8?B?TmdSRE03Q0dCTDUwaFdONTF6VFRzeWcxZ2xrRVdzeXBCOUpXSFpEUUFHNUJK?=
 =?utf-8?B?Tm1Wd2lBd05zMmpQTGtPYnBvWndtLzZEYnY1OXhZaEFnQzVhM3ZQMDhkbWFZ?=
 =?utf-8?B?R0tUZVRONHAyWGNLQzl3VXN2aXF0OTZrSU8zSWZkZnNQTkxaSVcwMGZmUlZT?=
 =?utf-8?B?VjJuUkttWmR5KzAxYzRndUQ3b05oa01QU3ZIamhMR3RwcDN6TmtMUTFNSWJk?=
 =?utf-8?B?YWwyUkExQzREek5oSnVjZElYT3RhZTlZZzV0WGRyQzZwTU8vS2FSZFQ0di9i?=
 =?utf-8?B?Y2ZtYmQ5TDVlWVRyL0dxRG5IZ2IxaXFkOHFFekdoWEdCZFUxOU16a1lBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEZjb1VjeVptWlJiWmNIRmluelg2SWpaM3V6MkFGdW9hMWd5aXJhNTlaMkpV?=
 =?utf-8?B?eEZRRjVVK09yUVZQVjFhZUFJZ3R3cGNwcnRUWm81R1ZFMlIvckRQdFZyZElS?=
 =?utf-8?B?bkVseVJzTkZBTmwvUlhvcmt0S3ptN2t5QzJkaSs4NHZ4c3QyN1F3MVlrSUU4?=
 =?utf-8?B?T1ZzeUxXelpIZVhZcHVYWjliT2Vlb1FnT0ttaHQ5UXlVNnd1dklTMEZuYjF6?=
 =?utf-8?B?aTRQZlJvenNSSmtqdVkvUVQxUmRSRDAra1ZaTXZrcU1mOVBDYjdqKzUrQmY2?=
 =?utf-8?B?UVl1aCtBM0ZEeHNtaFlRS0xaWWVKWjJPcmVvakNyYTRCVWJMbmZEWlhpd2gw?=
 =?utf-8?B?RVc4cCtLdFM5bEZaOVRoYk9kTFltWXhjQ3ZudW5SNEFManovQ1BESDR0d2J1?=
 =?utf-8?B?MDZuUGc2b3AzSGNxMkU3eUczS1U5eUI1S1c4bkJaNHpzakNTbUJQTWRvWkUy?=
 =?utf-8?B?SHFKTkFzWlpndUtya1NKaEtTVVd2Z2RaN1hWeUdNdVZtWEl0YS9DbTRxaGdw?=
 =?utf-8?B?bkdMLzJzZk5iMDRNN01kK0kzb21TYkp2L0VHblBWZktoL284RHYxYS9IaUYy?=
 =?utf-8?B?c0xETm5sSlk5bkFZU0U5cUNKTkQxWDQ1azEyQm92Mml5Q0JpSFRhOHVrTVpG?=
 =?utf-8?B?VC9tVFZTeFYxM1gvbDU5K09SYm03MzZ0WkdTa0U2TjI0dEIxTlk4MVYrbjZ6?=
 =?utf-8?B?dk8wQmtZV2k4ZlpabzVMZlVjQlk5U2N3M21seGkzT1JMQ001VDdXZGl6dWJj?=
 =?utf-8?B?RFhNdmtzOVpiOHBhdVA1aU80WGtGb3R6aDZyTk4xUUtYL2tFSXVhSjRUWTh6?=
 =?utf-8?B?QnZITVFISnpJa2M0TWp6VjN1WGd0RDczWVhadjdYM2psUUdHcm11N3QvZXJO?=
 =?utf-8?B?TGw1TjhYekJIdzdKWXRUL1dGRHBScEh2SmptbVZZcU1ZNVJWeGZtcEhHY016?=
 =?utf-8?B?K1B2RmphdFlVaTZGT2YvQmFueDU2emxlRVBjL251OVFaeXZsQVl0QTk0am9N?=
 =?utf-8?B?THJDL3hjNWJkWERuWVNqRDAyMmFhZS9uYk1BVlczQjNtNE1hUzkvVXVxZ0Ir?=
 =?utf-8?B?bW10c1AwcFNuK1lJek94OGxYM0pRd2U1ZXM0MS9FMmNmaG1nV2tRZ1hzcExo?=
 =?utf-8?B?dFR5a0Z5OWN5RUJpZW9JMzM2b3NaTlVHbEszSVE5aE5zcFdNbFNjaXFOSDhT?=
 =?utf-8?B?dW1sOVlKa0IxVUkyc2FHbHVjSko3REpocjkwczNBM0NPZWdjaDVtYjMwN2ZG?=
 =?utf-8?B?SDlONnR4d3VPVTRsd1JvbFBvT0VmRVUxOVdEYUlXUWtpaDFRVkZZQjN6dFpQ?=
 =?utf-8?B?WkJVVEZWU1dtLys2RmVUcHdRK1JxckwvWHNuWktwMitUQ1BpaUY1M2EyWnJk?=
 =?utf-8?B?djhmUmYrVHVWY3gyMSs1cnA1aFEydDRHUFJ3T3VpYWpuR25OQWlldnczNTZ0?=
 =?utf-8?B?amdGaDZrVkJtYVpweVB1MXJRRnBvU2RlMGhTMElaeEJQTHA2cjB2V0JiaWVE?=
 =?utf-8?B?Skt5d1NWMzFtQ0VsbGJ6a0JZWjNCNmRhR0E1VU9Ydk94SThMTEUxWXI2NXU3?=
 =?utf-8?B?aWViK1BIelM5cGFBR0NWSlN2QlU0YjJoTllDbHRzaG5Nc1JzZ1JWRGxlRU1X?=
 =?utf-8?B?Y3hOMGN2YmtBVWlLYlNqUEdwUDJRVnpXdFEyN29oallub0JtdUg4dEtBMzI0?=
 =?utf-8?B?aUFnWURLSXhCUXo0RlU5cEhpQmp1K05DaU0wSzFHa2UvcjhJUXFoTjNvYlRi?=
 =?utf-8?B?UGsvenVvMlJFT1FFekRPZ0xwN0o0VFdzODJJSGVhNDNvb05qbnlJVmQydUFQ?=
 =?utf-8?B?QVRTYm1LSkJrNDhFelRoTjBpbzdpZy91bytiQ0p0V21jclY4cVIrZmN5SGhN?=
 =?utf-8?B?UThvcGNLOFlTQjZwdUQ1elZsOEhiYU9mRW1vaVJ3TXhsc3RmY2R0ZldHU2Rq?=
 =?utf-8?B?S2ZhYkFUblN1MFlTUVE0d2dYVGxBcmpHWDJYWjYwaWsyN0VpZlRtczkweUJY?=
 =?utf-8?B?ckEyTWlSU1FMUnloOVNwNi9VWjNod0FPMXhDeVorR3BVeHlYdklDQTNtay9J?=
 =?utf-8?B?VEg2T3BQZi9WMVF6SjM2OTlqQWVDTzZTME5xT21UelkwMkx4U1JISjlxVzRP?=
 =?utf-8?B?cXpnWVJFYjQ4NitpcEUxdmlnQ256S3RvVGRxNDhuaWQ1MHBHNmtxNGx5VU5m?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f65b46-ee98-479e-537c-08dc84aaa075
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 15:25:55.3264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryNJAAxUpMdYCIcTbM/6N8CiaPmdWPKp8+E32KEwQw9rBdsPgZavt9YdPLblGmDy0SNnQ1wC4mR/bz6QsPUFcpyCXzj8vcvYxYF2AKKaExs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10324
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

Hi Mattijs,

On 6/4/24 5:15 PM, Mattijs Korpershoek wrote:
> According to [1], we should use bootmeth when describing the
> struct bootmeth:
> 
> """
> For version 2, a new naming scheme is used as above:
> 
>      - bootdev is used instead of bootdevice, because 'device' is overused,
>          is everywhere in U-Boot, can be confused with udevice
>      - bootmeth - because 'method' is too vanilla, appears 1300 times in
>          U-Boot
> """
> 
> Replace all occurences in various comments for consistency.
> 

s/occurences/occurrences/

Sorry, was too tempting to highlight a typo in a commit that fixes typos :)

(Don't send a v3 for this please :) )

> [1] https://lore.kernel.org/u-boot/20211023232635.9195-1-sjg@chromium.org/

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
