Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96382CD37AD
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D26B84D9A;
	Fri,  8 May 2026 18:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NOMsO9Y0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEDD084D9C; Fri,  8 May 2026 18:48:25 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A664C84D6D
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUWOJBVBWZo746zNjgfn46Vx/BVUgyM3982Ft6TG7/ja+YOx4DY/cdiRi4UfN1xzjM464eX0z9S2IZxn4C13JNnnjMXGkOXz+bHQDg/WZDpP5zVsylbpChOBSugcj6ZQGk7NVncDe+U/uAyg1F5dX5FZ8XywyA74sZl9cbmNDHno//yBIT2P6NBgetvKB/go4FGZ7MyJH1cmXVTn31/AkFJRnExLoJK/XIvhZt6rYvZjaatPLNUAWHaYGXxdSfnSumUQRHV1itvyN8T4xZQkWIF17SQdsDyYNQ4DIvLf/0jXCz8C3rDSPdjh1XjqlDUbi3pPeTJM0/lL/EudLWvsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9wTgUDFQdw49ADSJfDq/NA6fzAIv8GrahCw5lhjyfY=;
 b=s1bUfoRaqMGfOZnf441RyfLkQM7cuqppa0QzTnj6MO1RYXxgNMIzJCFOYCUpArB4JfBd13+uRRAMJIZfRkBqO+hOUMemj+OOLcIdltiEwVoNdkq9ZtqoguqJLM8Z4yM4VjFtXW8fDm95tITnGIYqi6kR/p5H3e2oB0kd9EFmqY1G9c+IKWaDnKwfetWGWhzNNiYhY0T3Vhl83iGmxYGDnM5CibO//qyZX7jBHlI8W55HUxo99kTcdLfWWaifl3x/2Ba2qou6glIiL2hSMHj7iG6h3vMXakQiTMVJTZQnP7v6WDDAfvXZVMNMCuSP57Yxi1M3wRGIhRf+DLI6uTpj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9wTgUDFQdw49ADSJfDq/NA6fzAIv8GrahCw5lhjyfY=;
 b=NOMsO9Y0SZNtyS0+ziccsMhRvORc+eoTQYy5n1H3by4VZiOmx2e7SVHA0RBhkUtEXQjC8JrrZj/ohPcaOAtBtJNyrte0R4J8vKV0AGFr+uplqyGkfIN32VNkZULn248vx1EbzxQvyWO7f9GXq1Nah+TFODTgQORFgULBqYaBJtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 16:48:21 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 16:48:21 +0000
Message-ID: <733a9219-5d7e-41ea-997c-9e73322d215e@cherry.de>
Date: Fri, 8 May 2026 18:48:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cmd: boot: fix edl being shown when not supported
To: Simon Glass <sjg@chromium.org>, foss+uboot@0leil.net
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260507-doc-sysreset-qcom-v2-0-37fef7a9cf92@cherry.de>
 <20260507-doc-sysreset-qcom-v2-1-37fef7a9cf92@cherry.de>
 <CAFLszTjqrfQiNGjk7JodYz-6XTk-sC8reDUKg+g2a+YRJQkr2w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTjqrfQiNGjk7JodYz-6XTk-sC8reDUKg+g2a+YRJQkr2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM0PR04MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: f240e294-cff7-45f6-c9c7-08dead219d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: ZTGT0owUOkl1eZrAZSlPfhWqvIGXi3CCv5U3ApT5A9vmThgc2TTeatM2PJevRtQTReBfmmJgzP1yKBpsrW2iSWupGR38ISKUdEsrZyeK5jLf0A5wBJTvePE4qYTbf5LastWHB5yRoF/7G4zlhIUJfviq7grB+YYSfObIUKf78aKoQIQHEYXC4OjPJo/YuPm1o2U6n50sGwyMl6Ta1zdqT3gecnnqNHqpeXZTnAfly6aVfAm6Q/7AfPGyX6oih6d/vEz5Ra/lrseALu8tR4uEE9lQWnihpyydlRVlUzdrRKKTSaw4rw3rR+opbgpUfdh7A1LitIM7ZO+pjbYtSjfyHOyGMYnKgQRJ5J11Hkt25+zEn31DtxEGOttE28rG9yMj5lZKsEU/Tvu6Qi28O1xPxWBvX2IFk87VZdEEK/2bP0IbcucJH20k1D3f6zaKSufIkiYSyaf7JFdZulJX8K+qh/jzyYD3TV/frOGawtmg6PF3bDooQtiCeZy89Ci7GFS9gGpzdjhViot4I0K9ErrIghJuxI0n6/C0aeXVPbR6+eE3V4CeZVZLs0R8wa94O1tPV3a/110sw3kKwrTJa5FkrmJC3mjEUbLKpJkQb+Ekei42645q2IwyKrwV8j/343haVZrTVq5q2mcDcuy0QAIm6NyYR5hCawJ3GQL30OVhafGXiFhlUAYkxm5Ny1+wHAud
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHFpSW5MRW4xYzQzM01MbENxcnVudE9FQ3pqVVRRRks3NjZ1S1gwRUFHVTN1?=
 =?utf-8?B?K0hvQmZ2RmZiTmdSMTE4VFZNbmNkNGlLdEdST1BRaHFDWlpFS3JGN3hrZnJO?=
 =?utf-8?B?LzJzNVluTXJIUHBJVzB4WVFwU3RnU0t2WVJtVmpGdnNpVkMra1VCOVRVSzND?=
 =?utf-8?B?REpLMy9RUG1GSVpKUU1yaEJCN1JYNU1SOUd5QmRWMEhaVU9RQTgveW9jaFZJ?=
 =?utf-8?B?RFJkNVovc0YrOFk0eEhXbERvQVJ0MUxDVXFKVXRkNklLRWhOUmZsbWZNdlBs?=
 =?utf-8?B?QktjclVmai9vWWlyVE5OWFRCdGsyVFQrM2xtQ0Q4bkJuT2QzVC9mN2lETnlo?=
 =?utf-8?B?K3lVcTNkZ1lDQmRBMnZxZk4rN1VJUmVVWkRZcjBvQWNJU0pjSTFwMFBvWWw2?=
 =?utf-8?B?WUpxZkNONkdIU0dPaU9ZMlUrU0tUM0VWa1Qyd281M3pEY2hXUGVXR01LclhC?=
 =?utf-8?B?bXpPakxsa0VuTjIra015dHNZVGpsOS9pQzhVcDNDa0hCKzZCY3J0OGJPMkNS?=
 =?utf-8?B?ems3UDRMQ0lLaDhIK0FiRmlNaW9VODFsR2E1RlpkUnZZRXVkbXk1OGZlemgy?=
 =?utf-8?B?NE9RUkZ2RWRJYTVDVnNueXNkRDF2RmZFdHNpbmEzTXhCREtaK05wT0tuM1ll?=
 =?utf-8?B?VVhxWWJyWnNMSnp1UTVEcDZMTEpsV1pDVkd6MnpZOXQrNHh6N1BzdUk1VWdR?=
 =?utf-8?B?cE1WYVkwV2ZZZWVrdU1WSGh4Y0FnVy84c09NZDR0aUVXV1JtRkdtUFBvb21P?=
 =?utf-8?B?RzBweXpac3Q2bWV5Q2lpbzVzd29ROFd0NmYzN1FieVY1eVNSN3YvbmcyZ0Na?=
 =?utf-8?B?dzRndGFoOElqUFR1SmY4UU1XTmNtS2NJc2dCaWFETXVTN3Iwa1dsb0RzSXZ4?=
 =?utf-8?B?NGZqRUN6dk0yWlNSaEpwMndKelRNWVQ2djRvMkRxVlNuVE9nTWRpUEdIVUZU?=
 =?utf-8?B?b0J1VWRLRG1Sam12V3pIVTU4U3o1RTA3V04zT3A1aTlSbVlOeno4bitRU0FI?=
 =?utf-8?B?RWtXaHVya1gzVmVGcjgwd1pEQjEvMkNFaFVHQllSYkdrOFl4WitLWmFWT2Ji?=
 =?utf-8?B?MXIwR2NYMVJ6eGdmdzFZYW95THNnOWJOZnk3NHNPcVpoTzJGd0dybjJGZkN4?=
 =?utf-8?B?S0tjT1E0QU5pcEVUVjZtYlJBTDlBc3o0VjE2QlB3Z1F1bE0wTy9NVkhkYlJZ?=
 =?utf-8?B?cjg5NmY5alphMEVKZ1k1Q0dqZ25RL3FLeWtFU0grM25CUW9qS2h2UWZVMjB5?=
 =?utf-8?B?dGFLYzlBMGpKa3BwcVFXN1d4TmR5SERLMFlBUlA1ZzFkOWZ0ZzdyRTA2RHRl?=
 =?utf-8?B?N3RjWXBiOG1wajlveENiVFdDaHZaSExSeDdjQnlWRnA3RkVwRjVnKzlzZU1V?=
 =?utf-8?B?TG85Mk4yVEZTR1B5dE9BaXFPNGhXaEdFUzY3dENQbGNuQ0xYRXVOd2U2YlJ1?=
 =?utf-8?B?TjBRU21KWjNjRG02UVYzcjRoblpoTDZJSUViMXhEQXlkWmhKK0NKeUY3b29z?=
 =?utf-8?B?RXA0eUpGS2Y2QjlVOGRWaE1ITS9Gc2ZJYjZuR0hxa0lqRUJMbE14cXFwL2Rt?=
 =?utf-8?B?akhCamZLOXRHUlhNelpxQ1pUZXliM0dlbktHdjlLdGdMK29icDVLcllxQko0?=
 =?utf-8?B?RE44NjFWK0lkT3B4WkpHVzdtM1JHRTNsTGxpR3Z5UWFlYU9wZWthcDkrdmls?=
 =?utf-8?B?Tm9PYWhCU3pPZStCSzNiQ2hDSHhCSG5mWFk4dWZGQXVRLzIrWThCT05uRzVq?=
 =?utf-8?B?WjJuc0hHRjJGeFhWNWRuRkdyWGlnUHltK3FJUTNJMUQwVHBsaktoOWRaZmEx?=
 =?utf-8?B?Q3lXUU5GVk14QTRacVg0U1ppU0pGYU5jYUdUTGp2M0l5dmV2VWNDN2dKdHMz?=
 =?utf-8?B?VWdQYmxxVmxQTFk0RTkvREZ1bis0c1kxWVFVUWNqTVJZdHJpa2R2Rk9xRVFh?=
 =?utf-8?B?Q0FXdi9JN0pENVRlRXowUmR5ak5TdmZzL2Y0d3RSbStyTzVacXFtSTFNUktB?=
 =?utf-8?B?VW5IODQrNUREY2pMTDNIenhqSm9saEVEMm0zdVRBWFAxRUs1NVA4NDFuNXQv?=
 =?utf-8?B?S2FNcnhkNHJWUC91bUZLQmQ2VjZ5TzQxajNMOTJqS0NHcFZFNHk5ZXdyYlUx?=
 =?utf-8?B?bjdRcWk1M041ZFZaUWpDZXlQR2dLL2JFenZHZkczNUx3VmkrUlQ0YkttWmN1?=
 =?utf-8?B?MFk4SCtNMWpjYTFjL25vWGRNeHpyeEJNMkpRTVN6MlRTOUZQbTZxQ3hUQSt2?=
 =?utf-8?B?NEdackhwNjFIY2U3bmhROGVqNlUrUU5KbE9RWmFDYVduY0ZYcjBGZXlseGhl?=
 =?utf-8?B?dzBjc09reFhTUW5OVUZidE85S3ZRQ05VWkdVRlBBMGlicUh2bWVLUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f240e294-cff7-45f6-c9c7-08dead219d0e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 16:48:21.4800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOeWmcxzm5/Rwd7Tr6GJxlXlq68paOKeM/hWeHX3PxlYQkeFhOxnFzfqsAQAJd9lr01deR84X1eeRJWxBfDHhg8acdi7HQMrczwJbdwyZJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7044
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

Hi Simon,

On 5/8/26 6:33 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On 2026-05-07T15:04:04, Quentin Schulz <foss+uboot@0leil.net> wrote:
>> cmd: boot: fix edl being shown when not supported
>>
>> edl is implemented in the sysreset_ops.request_arg callback of the
>> qcom-psci sysreset driver. That callback is only called from
>> sysreset_request_arg() which is compiled only when
>> CONFIG_SYSRESET_CMD_RESET_ARGS=y.
>>
>> Therefore, only show the edl option if that symbol is enabled.
>>
>> It is in a separate if block because any option but -w will only be
>> handled when CONFIG_SYSRESET_CMD_RESET_ARGS=y as seen with the
>> implementation in do_reset() in drivers/sysreset/sysreset-uclass.c.
>>
>> Fixes: ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command documentation")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> cmd/boot.c | 3 +++
>>   1 file changed, 3 insertions(+)
> 
>> diff --git a/cmd/boot.c b/cmd/boot.c
>> @@ -60,8 +60,11 @@ U_BOOT_CMD(
>>        reset, 2, 0,    do_reset,
>>        "Perform RESET of the CPU",
>>        "- cold boot without level specifier\n"
>> +#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
>> +// All options handled by sysreset drivers via their sysreset_ops.request_arg callback
>>   #ifdef CONFIG_SYSRESET_QCOM_PSCI
>>        "reset -edl - Boot to Emergency DownLoad mode\n"
>> +#endif
>>   #endif
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Should SYSRESET_QCOM_PSCI select SYSRESET_CMD_RESET_ARGS ?
> 

I don't think so, it can work without? But that's up to 
Varadarajan/Casey to tell us.

Cheers,
Quentin
