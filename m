Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B7DCD128A
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 08:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0209087F70;
	Thu, 11 Apr 2024 10:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="O8DJOPQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392CB87FA0; Thu, 11 Apr 2024 10:10:53 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E54B87F52
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 10:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVagfOWc8rODhXcjEvkRmwah/CQjVF9apVfLR2kwn6MBLfJcQ3+XgNuXFZyyjaVmta8H7yTaHr1RApOUL8ZnyDOLw4yvAjtnvAZdsY09LtNaIuqyUeBDW8QUqFRRiTjSTQXAvprHQG0N4jEF5CDhoVMWZAZxOJ+PV7EiwvWpbgobwY7+O98a2QdNnI4BAEWyXfAopScK42EcD2QMml3Hx7lYT1WhAkXV+nHJ8Mj0deHxDQq4vKbVv11DGfrL4J7C0o8DVo8Yzpu95Q+UqTCWokoEFc6ety+uBz8jSicj8sdre1L/b47dv3AiC/UIUSfXkMH7Wo4UHvhMkWMzeK2mZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/cECzum2I85wJmTb8HHObbyyLaC7Np2cSVd5QXYESg=;
 b=TtefeJNlCx8ljp722KTT7QHKF/Urb71Ok8ESAUm3l8Q5+yyiPJAmAGmAsIYxSZ+R33SfRBePQIDz6Won2bAmRz1c+OhyWBJmqe8TN9iZGY7Lm68WlhisV/jOIVmhu9jq/vz1GGEZA0QRJLMli7BZUZdjZihti33O4mf3chIzwvhqeVx/L+VqOeizHTkSz5jTEgoL/UScN3VAT9RvwM652+doxHVKlebDYLSpUUD7HWL+u1kt94swzzhc4eg7mCg1X5iGXkmd9kBRtVPQgJuZ08FQLQ/KIO8cpjK+08ONbUngUivPHq3iB0c5pz97/V2VsbnAp6cDuxBmkZm/hMFoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/cECzum2I85wJmTb8HHObbyyLaC7Np2cSVd5QXYESg=;
 b=O8DJOPQoeB7NMiG+3lu7+ADlZLaJlNoScLy9TEALQ+hlMSK19i+rLBGPTq8/PYI+dJ74yVhwGhge+s3nTYksyTOWyPIgU6qQTZ1yF/U5ywA9rSGMX24GE5feFoSZdMBxqmCFxcjY2Koh6qswsaMIYa2Pkp46F/DIi+7Zazjb67/8j+iai1fmrzsBbgZR7EaCNH0C3pMb8HLFNdpkHnuRS8TUrs9pVOdI1nTf4Ibh86pRUG4llCbLB8ZqI8oGtcr9bqVBDn0CyvNeInw2zax50TcUUBZ8O+gb4fB792Q/ZWCry3sC1x3B38FuIONnoXYvlKHzukyNOoDr2HqskF1nlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AM7PR04MB7063.eurprd04.prod.outlook.com (2603:10a6:20b:11e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 08:10:48 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 08:10:48 +0000
Message-ID: <a87a142c-0511-4fa2-adc2-c0bb254a55d6@theobroma-systems.com>
Date: Thu, 11 Apr 2024 10:10:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: bootm: add ELF file support
To: Maxim Moskalets <maximmosk4@gmail.com>, marek.vasut+renesas@mailbox.org,
 mkorpershoek@baylibre.com, ralph.siemsen@linaro.org, sean.anderson@seco.com,
 sjg@chromium.org, souajih@baylibre.com, takahiro.akashi@linaro.org,
 trini@konsulko.com, u-boot@lists.denx.de, xypron.glpk@gmx.de
Cc: Maxim.Moskalets@kaspersky.com
References: <20240410212153.6854-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240410212153.6854-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AM7PR04MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 2796b06a-d023-4867-ac74-08dc59fee53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oauTXaUrby6ssDNnM7oa9kMn2ax1N5hnz/ui6v9URzSe89sqsGDU26Ha2B+J5I+qPhgan7c2f+glt5DnFz4zHEsl56Ot9aw61/8Y3e0bAnpTmwb7pk4vE6taVTnMq1jMIjExSmfyXXyBk1mjyo74yuWYOR3rkhl1mftQXyGi19UgwUqEQuqLHca7A4+7WIVrRg21Kq6nBEANPfVeVkyyf6OBWQMzI6UHiY7Dy9p2TLLOa7aUa8vQ1I9YYMYbzgFxSsuPvllozwDx8iToIUn+a7RWLdeSV5llqEq2POI4+Mx1CN2Pwa2nHCAv1WzFfQoG5dC20Nw6IqkRLYnmTfVUsdTQzwJul020ArsEk1mDCCMikK4TPgzm4pZWp45EayJsrNKpTphpypkgDTm8vv6YxoD0Dvwy7+FFazMciaxuUs/EWKycanaZDdoV/09vcM8VY/u8trfNeA+yMTZjGdyR4bj6VawhxOEPYNXmVdXSfQ4H9D33TdocDm70N+G8P6jM8oGjZKuKJUINsG/MM+EQn8Q4gUlitMVGbFnbCosbPj4oKRdoOu9i33uld8acSeAnMuCHY5C3rwueRPF3IV/+rq1LhNUhfMc+UWKVZ6JXWUv4CFKumVgp9yobqRwOH5dTjtC0DRwqgNYLqp4oIq1EUZGlAY2vVfzEieVTD7TJ0refbFzfFBCB+fy1Ek7oX5tAfANPo02FZra0kTeMQ7agOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0lPWVNteXBtK3pjd2llREhFYWFBcGdkQ2RhUWRkNHJPU3FjRkxHa2QrZDRO?=
 =?utf-8?B?RXhFcnl2SEIxV0E1WTNydkhsZHpoYk9rMzVxU0k2UGdsdWdtZzdMS3E2V21Y?=
 =?utf-8?B?SkpTVWt5S0h2L0c0eVpIMzZHQ0U1Wm5yWTRWNHpUUG5KTGRBWlJCdk5sYUto?=
 =?utf-8?B?cFlzeWJqQ3JjejZPaUxwbHE5ci90SmlCelk1azJmYk43Wm5qZzFweGVCRTI1?=
 =?utf-8?B?YmZwcXBkUjkwN3lQWFBTaDJrOG9DYzE1U3cyZURqeU1lRjk3WTJnZHUwaGRt?=
 =?utf-8?B?Y0dIcCt5dDlhTHFwVjl5aGNUNDVsVzdLQVJ1ZGkwVldESFc3L3lMUUlBQWdV?=
 =?utf-8?B?bjU3UVo1V3dVY1N1cDNBNW9MaUY3K1lMVUhMZFI5UFJpaGF2S2dnVXhaYVpx?=
 =?utf-8?B?LzVYSDE1RDFwUkpaWlpPVGhjWWtOa3k1T2xJVmRTbGZHUUNMQmdJVkVyd1hN?=
 =?utf-8?B?cG9RTko1aFRHMjBHWlVUc3Z1TFZPejltZ21aM3E4QURaY0JHR2RxNWU1bFJK?=
 =?utf-8?B?Yjcxd3BRd0w5bGxlZERoS2xIVGhmRmNTVGFEam9YM0lWNDBDVDJ5Y1RRUEtK?=
 =?utf-8?B?VzZ4RndwTzd5K0NaVHhkQmtUSVBKVFNpa2k5MmtzTzdKZy9DWEJlaUZ2c1k5?=
 =?utf-8?B?Y1NycDNwN2ZldnBYeWZCM2Y1bVRSM3Z6VUxRMmRaV09WV1hscnhXUXdxaFhB?=
 =?utf-8?B?SFdSWnFpYXBpWnA2VmVibmdEK1NsdytncFhzUmF6dVpRQ05QbnlKUEt4STJX?=
 =?utf-8?B?MlVEUHI1bEZtazZWL20xejFUcktMVll0ek12eENrTlRySlJQcCtjYjJqZG4y?=
 =?utf-8?B?WFhyeU9WWUcrK3ZMOUJSdnBWSmQvbEtidk0xL3o2eXpNa1EvdnpqclFvMTd4?=
 =?utf-8?B?NWdQa1pLVGJvQis3bzZqQzJrQVB0VzFvVGsvbU1CSHFNUXNqTG1scXVZY0Zj?=
 =?utf-8?B?RGJWdUpWLzhjODF4WTg1a1dJMmpZY2hnWjgydmI2ZEVodjJZMmJ0b280UHFj?=
 =?utf-8?B?Z2ZHT25qQ2kvaGlSYXg1U3k3eEhJSEtPelJrbjRteGpGb1MwNlFQcUI5eDVI?=
 =?utf-8?B?VWhpNmFUclI2U0RlWmJjcnZIUEJoeHJuRnFvUjdpdDRMd1FzLzh0RVd5eTRs?=
 =?utf-8?B?OE1jTDgyR0trTkpocDNUNVg1ckljcXBDdE16cy81M0N6VXFCbFdsV0ZjZWFJ?=
 =?utf-8?B?bEZrbjIrMzFJZm1kMFRmbjBZSDdPM1gwY1NNVURESWFHaiswZnhJRnRkWGdK?=
 =?utf-8?B?NDRxMytJWUYyN3BTMW9PUG03L2laaVBsdkc5MzlFSkpkVnFKNEp5VitCZEFw?=
 =?utf-8?B?K3Z0THFmb0hDRE1ZQ3E3Q2FkMEhJS3dvbFduYUNTL0U4YUVVUzlPeldzWE9C?=
 =?utf-8?B?UGIyYTFGcWNHYzdIQ3FMNi83djdmZzRMZldFQUtJS2ZVUWc3R3lSUTIrdkhM?=
 =?utf-8?B?K3NIK0pqLzd4Rmtxb3dQaFRzbU1FbFRVc1NWVzkrZndBd21pN3RlN2ZIdlla?=
 =?utf-8?B?amlIMW1MNWU4cHo1bks1RWV0RGRpRzk1OWhYQ2pKMDRHdjZCTEU4ODFLSFZy?=
 =?utf-8?B?cTVIelFDeHBnUU0xbHFhcHB2Y1VkT2JZbkdGeW1lNzBZdklibEFYZ1BVS05Z?=
 =?utf-8?B?WnMxZGNCb3I5SkcxSCtpTjZMRG54S29yVHRDY0p1U3g1dGVJS3BXUTR3T3FW?=
 =?utf-8?B?WjYrbTkwNXZHSGMyUUI3Q3RUbW9LQXd3cGNaWW9naGpLUFVRVXVNK0M2MUZI?=
 =?utf-8?B?RHZpQzU2NHJtMlhieTV3dTMxdFRHWTJkNUFUdVNjb21pNGl1OEo5VTNhSGdj?=
 =?utf-8?B?eSsxMUw0aEJsb2lmRFVFOWN1NWZMS2duM0R3TDdXdU9ybkZuQjRvczF3ZmV1?=
 =?utf-8?B?VDlJV2pXWVBpSng4NjE3Z1U3VzFqbW1yRTV5VnBJNGUrS3F5YzkvV29mOGtH?=
 =?utf-8?B?VkZZMFVyc3lqQnNQUzVqaHh3L1VLZUZ5aVE5OWsvWEc4eG52ZG5pQVdSMTV5?=
 =?utf-8?B?RWdSMmZjSlZzS0FBUXNWbE1wbnhMaHpkVTJUWkVCVlpNWVJWYU0wQWtuZ25s?=
 =?utf-8?B?c09lS3JiTFFkN2JYMmJyVitnbXN0d0pwNnlvaU1tajdweGtwdlQzOGt0cTFz?=
 =?utf-8?B?MjB0aUlqeDF1MlhiNXFOWXJOWFBxRys4MGlFTUw3NjBsKytWei9lYk9UQXhM?=
 =?utf-8?B?NkdkbXRzeUlQVlkyaUNMbFBGdHlGcEh6Wi95MHVBdjVnVTY5R0VBZ2ZtTzFP?=
 =?utf-8?B?bGZKb1VNckdSZFdQaWE2OGpGSGh3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2796b06a-d023-4867-ac74-08dc59fee53e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 08:10:48.5485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxHL59E+7k+tjVe6VLFQ07jzOwrvWsmtYxoe/taAw4oFbBhCR+KVmhOqlHOYjOFyc2uJBZyyFiKiGQvU/7uHClXQCFXUziAbgwKkpxxvdgsusMTAN1RBzqqJPwQbjthp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7063
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

Hi Maxim,

On 4/10/24 23:21, Maxim Moskalets wrote:
> From: Maxim Moskalets <maximmosk4@gmail.com>
> 
> Some operating systems (e.g. seL4) and embedded applications are ELF
> images. It is convenient to use FIT-images to implement trusted boot.
> Added "elf" image type for booting using bootm command.
> 
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>   boot/bootm_os.c  | 24 ++++++++++++++++++++++++
>   boot/image-fit.c |  3 ++-
>   boot/image.c     |  3 +++
>   include/image.h  |  1 +
>   4 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index ccde72d22c..1c92b8149c 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -395,6 +395,27 @@ static int do_bootm_qnxelf(int flag, struct bootm_info *bmi)
>   }
>   #endif
>   
> +#if defined(CONFIG_CMD_ELF)
> +static int do_bootm_elf(int flag, struct bootm_info *bmi)
> +{
> +	struct bootm_headers *images = bmi->images;
> +	char *local_args[2] = {NULL};
> +	char str[19] = ""; /* "0x" + 16 digits + "\0" */
> +
> +	if (flag != BOOTM_STATE_OS_GO)
> +		return 0;
> +
> +	sprintf(str, "0x%lx", images->ep); /* write entry-point into string */
> +	str[18] = '\0';

This does seem like snprintf would be useful here?

"""
snprintf(str, 19, "0x%lx", images-ep);
"""

safest and also merges the two instructions in one.

Also, have another question, do we want to 0-left-pad the value so that 
it's always a 16 hex-digit number?

e.g. 0x%016lx

Cheers,
Quentin
