Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34CED35162
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 11:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3368183CF5;
	Wed,  1 Apr 2026 13:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HSoTzSTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D922F83F5B; Wed,  1 Apr 2026 13:18:33 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7947483CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 13:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPH1Mi6Wf+GZ2TpExIJ+fzPUBFKzTGK6G9N7/IhWLS7dtFHpJE1R1ZX2uh00A4DBzUsBmVVqhSE+kW3Lw9JB5bU3/usCwTaOSmrYl663+mSa8M6Siw+ru69KvN4kS2pqDpdwCFfad6xbFdeUG+ByLc15Zu8df6PllWA77bQoT0X3D1/BAXHAADaBwHL5DXQWe6UD+o1Oya/7yrNbaHcdT7A6m6LVgYXx0GLtw00fWah1sk+tKoLcQ47NvGi0G2/aYRhs8SJkx1AqSdzLXY/0aL/YJQqn/q3X03k5HiGnOdyMZMeHyjrviU4RkexgTsunsVhdJymUuAlah9ckwKvc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piB7PbbQkSEkJLk/QFGH7raIxiqgiPo2TH7Ju9goxUg=;
 b=iZgeOUNWMjwdCS199BgW1H8yLlAxU6iHAj45lzhUmqA40PXH9QucLB2tgobKZRZZO8urMAymUG40yT/2uSnIElPuSEbScO5xoFupT43cMiDEDoZDT9Bx9PzdU5I1u7v2wrBCuEba0yxkC+lqi4Shtr1CGDZgkksaBWc4v9oSKPodwyrRu6utj91zdbqfS6Y6wJ2p71Kdsl1eAz+Tv1HWP3j3tmf5AMFC6qs7KMwK4hcvvRBIYFRQYWLvqMwaSNcO3xVH3GMIQkvSOiHdRPofp61NwCBxKjUvyjlT9PF9JMZNI9n1oUPq/spWvfcfTqnbNWk2bwRK7Tedy4nAY/xtkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piB7PbbQkSEkJLk/QFGH7raIxiqgiPo2TH7Ju9goxUg=;
 b=HSoTzSTMWcxwxxr5K+3Bsl+6C0huF7+sA/6OxLtsuzZetwQG4qy9A8EKCr02XMcC/nb3K0iXeWla4qujhrsZccVlDNpnnUYZ9vZlijmTZZBHb/WTpH/yQOIvLOjCnb4M/SGdk55GdKqt2TVN+gxjN7Cva0DxxCb4qu09bJubAm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU6PR04MB11183.eurprd04.prod.outlook.com (2603:10a6:10:5c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 11:18:26 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9745.027; Wed, 1 Apr 2026
 11:18:26 +0000
Message-ID: <c9be55a1-39f4-43d3-8b5a-42da757a2d9d@cherry.de>
Date: Wed, 1 Apr 2026 13:18:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cli: flush stdin before enabling cli
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>
References: <20260331110413.1040527-1-gregor.herburger@linutronix.de>
 <d65423f2-9dae-4bf6-a1d4-fcaed430ac7d@cherry.de>
 <acz3iNHpmDrcv2gT@gregor-framework>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <acz3iNHpmDrcv2gT@gregor-framework>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU6PR04MB11183:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9307ca-860a-4fe4-5879-08de8fe064dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4N88K0AzmbEbAEVnQgxCfPrOVAtUl44Zpxpplc+w3T0BXkbZh8XoD4YyqZkddETXe0f85TTiOSvBch/UvJ/SQzyfS1amUbwLsG8uc4mS7M9kHiqU4ydwcVfGadmDdPShcqvjBwxgNAOMWO4eppSpxc2qChR47VCcx1+2dnoyn3xcBHDTyaiRt9qwycWTKq/2iSe3cKFEXo2ciXNWYfsOnB4ESy1IJCIZLcSBvDZVD9885WUo1Ji9h0DuKfa5srifvYeDqNSLK0I6+a58lhYOGyXH5wPjP9RZ+Qn/Fr8SmHvEt3augbI2wNl6rNEnTuqlg9vGGaa13OxoPN1gOpvjnTaTFI8v3umxgbFNtSjQ2iMc6SguOqlnbs0rrH4n7ta8eLI6Zskj8/ru2gN1e8MTRz6A3YK0j6+iW6N5nFHJdrtrQSdjTYzMaZnBnQ2OlQuLvzQbd/efwRj/8ClFS9W8NX59H0fPpC4Su1jJFI9fIcSlrVSEw5nnQSbE9nmn6/ddER8JAQ4NW62ZyycaiHpu8TyG/08hADF8r3cSRlEKsu+xcBhORiHhwocP07zrg5IvDFwKZMrQg6Xsq+pCx+r4PCXWFp4Ljyu2NA+3sl97fUyYKFtuYXuIH/A9aX55Ty8bRYwYENtcHtztWS9Gl4v3ok7OyHmf9gbsG8lpYC5BLKYqQ/C6P9oXUKmiWDmep1MB8+iNXnKm+bKehC6voyY+1m/66DDQ3Y8TKA4blIBER+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGEvZHNyYkw1ZE5LYkRVVWVQYU8zZ0tXVnd2RUVwc2xvUmIrYnhlWkhQM3p0?=
 =?utf-8?B?b1JHWjZSdE00L295OHlpR3VVRmRLYU1kRkdLVmlVdlJHbkJzNXp6U3BuUXRK?=
 =?utf-8?B?Z3RwdmtMamdEWmJhc3BWbHZ6cmtZQ3Y3R2xOTXhRVHlFR203TXVYU2ZqUTVX?=
 =?utf-8?B?OHZHRmtBVkc3U3c2OUZDL0dSNVNFMDJ3WmpQU1RGdjFRTlFBekdWUmdXQzJr?=
 =?utf-8?B?eWZFTWtieHJGTm5EQkNKRW9iSFNVMmVEeldrNUM0VkNmNEdpWDdjMVZteDRZ?=
 =?utf-8?B?b1pyQlkvdGJxTkZDYlZBQWE3YzEyeElRMVlua2JtMUpacklNbW94SG1KZElQ?=
 =?utf-8?B?R0RyempNUWxIOUlwbEk5RzBOQnpjQmhldHY4SllqMTBLdjVhNjVGa0FaVWpy?=
 =?utf-8?B?S2dJWURYbFNHWUVHWC9BdVhHZE85eWdJblpSeEtVR0tYamZDTU5hT3V1M2FX?=
 =?utf-8?B?SVZkV2RSMnlMTEE4d1E3aHpaaHV0MmVuaUF6TVhrU3o3SDNiUElJaXRVcDJU?=
 =?utf-8?B?eGhHMGk0L05yZ0V1ZHdySHlWaWlnZ2RLMmZ5WkpuQ3UvWlBnNzRLVDhUaUJU?=
 =?utf-8?B?eFJkaWFSSk9uRGIreHpFUUJubXNaZFJGand5eUJXczlOcTNtOVcwcExUNkhh?=
 =?utf-8?B?YTBVbWJTWUR1OWUzVGFqVE45MUFIdnM4dzQ0Mk8wNjhiamJuYlJuZjJxZWZX?=
 =?utf-8?B?UC9wbFJPMFovSnZLb2tpVWI4b2ptR3M3V0FHa2VRVm0wZkdKYXVoTmNjUTlG?=
 =?utf-8?B?U2ZRS0JtQ1J2OHZJK2ZWQnRwKzFxTHBDbi9tVTZrWHNqSVpjcVZJbU5MdW5T?=
 =?utf-8?B?ZWd1WjZHQzkxZHBKdFd4Z0l4a2Fhc1d6VWFaeGtkeWVCdW0xQWEwTFBNUVUy?=
 =?utf-8?B?TFRQd3RhZGVic2FMa01Fem5lSXNIemNiOUUyK3Q0dC9NVXdIck1zdmlDdVp2?=
 =?utf-8?B?WXJiaG1WQVN5YnIzT0Z3R0JsN2Vzd1dlMEpQdmFKc0IvTWJoZ1FlRUZFdEpj?=
 =?utf-8?B?Q0IyNjhSdnAvRkJGSXFpWlUzWm4vUlJQRVZES3pLS1RtZXBuYkdQS2ZzQkp6?=
 =?utf-8?B?UGk3b08vQTVXeFdYaWJFSFJxQXdPNTJGdnpINW1ScmZla1lpRlpVcHVNdmds?=
 =?utf-8?B?OXJrK3lFMTFNdHhVWXQ3ajFPT3k1c0c0L3FQcTdMYmVhemRNNXRkdWs2MWZq?=
 =?utf-8?B?SHNoRG1iVHVRWmFRUkpqSUtxYWR6OE9UM3BJbWx3QW1vbm5KQWM1NUNZRHJD?=
 =?utf-8?B?Wk4vaGtwRlV1RHpSdmlkVWs3d3dGeW1ncy95MTdzM3R3SllmQ2VPNFFPMEQy?=
 =?utf-8?B?Rjh2RFJRaFRKc2t5Vk1sVnRGTERVYjdVQmsvNUppN2lhSXE2eWN2ZDhsQUdu?=
 =?utf-8?B?enNLYTVUbk9YcnZoS3dxM3hDWHU2QUJDQ29rUXR0RUZiUi9VWk8rdlduSysv?=
 =?utf-8?B?WHAvMTJGMEFrMlZCd3hIYzk4VEtBL0dMUm41RVloUmRlZkx2NHVYWEJBaUJo?=
 =?utf-8?B?dzRvdnYydS93TVF5ODAwOW4wcUphRFlMdHNmVlU4bzQ0YkRva00zV3lQZk9R?=
 =?utf-8?B?eFlDVGhKdUtQalNDVzB3YWhjT1k3a3VZbGVFbU8zbzg0N0tCMFV6SkRMdlJ3?=
 =?utf-8?B?UGpEVlVkRm9qN1dRWGd0MEllQTNWLzE1YmlOMFJYRWVmcXF4VFl0dXJHRllC?=
 =?utf-8?B?VGRUbGlTMm5ZZTBvQzNlWmxIYVo0K2FCVUU3ZVQxNTMyT2NuMVRaWUQ0Y0hV?=
 =?utf-8?B?c011c3A2K2JCZ3ZPUzFVN1ZobXJ4VGFtQW1kZ0d0NmR0QkxndnZpUDB4cC9C?=
 =?utf-8?B?WGtsenJjNThKOHZmQ1hJOGxVQzhuVkdRTnVOanBLMEtyOEpkck0wTGRRbjB4?=
 =?utf-8?B?TDI2ZkM2dlhMTGIzdUY1dTE5bVYxSkhPb3RFV1RVeG9PcU5qT01mK3JDMnY0?=
 =?utf-8?B?eWJVcmRpb3Q4SmRINGVnTGRRdTlRbEZFSWJnbHczSVBFbkU0aFArY2hXQ0Qr?=
 =?utf-8?B?WTN2NGdtWUQ0cUU4elZaRk9Sd2NkbUViRzBmdkFwbk9NV0t3VkFlemlBR1F2?=
 =?utf-8?B?WEdhd2dobVF2Qm9uY09qSkJUNDhpcEFkSnIrLzEvNTVuemh1TnZqd2ZyWHV6?=
 =?utf-8?B?anF2WksvNnRYNnJsbVI2M1BVdE1rK25XSTZmNzhJZUFhczNDRHQyN1ZpazB6?=
 =?utf-8?B?cC92ZFJpaXQyUUxFUUk2UEM2c1ZhMTh5ODYwTCtZV202Wm9iSEEwRDRuSVJ3?=
 =?utf-8?B?VWdhRUU3U1RsWkVrdWhHdkRIajMrekZzaGNjajExaE82VTBaMzU2YlhoemY2?=
 =?utf-8?B?U1dFaURBOFl3eTE5NmROdElSR2FDYmIvOXZ3V3VmZXpKd3ozL1FKemwzVllu?=
 =?utf-8?Q?n7TUF7m4mIPTm1VrItVikJTx8NILA73EsBx7b?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9307ca-860a-4fe4-5879-08de8fe064dc
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 11:18:26.2080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayJspia4d/XjduytZEJYHek0tNryV+YAlDVw2hIQY4aaztpuLJwQHmZhDBpkKSWPUhMoT6Qa+9AUJ763tsMoU1+RykUp0k6gVpPHw3VV8yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11183
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

Hi Gregor,

On 4/1/26 12:46 PM, Gregor Herburger wrote:
> [You don't often get email from gregor.herburger@linutronix.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
>>> Currently there is no possibility to flush stdin after autocommands are
>>> executed. If in the bootcmd the stdin is changed, e.g. from nulldev to
>>> serial, it could happen that junk characters sit in the fifo and appear
>>> on the cli.
>>>
>>> Add a option to clear stdin before starting the CLI.
>>>
>>
>> Why does this need an option? I don't know enough (anything really) about
>> the cli in general but the wording seems to indicate this fixes an issue or
>> even a bug. Is there a case in which we wouldn't want to flush?
> 
> In our case the problem was in efi_console where query_console_serial
> sent the escape sequence to stdout and stdin was set to nulldev and
> therefore never received. In the bootcmd stdin was set to serial and the
> response was seen on the cli. Thats how it was in our case. My first
> approach was to check in efi_console to not send if stdin is nulldev.
> But after more thoughts I implemented the current approach which flushes
> stdin before starting cli. After all efi_console did exactly what was
> configured in the environment.
> 
> I can think of two cases where stdin shouldn't be flushed:
> * User typing commands before cli is reached.

I see we have flush_stdin() in common/autoboot.c already, with the same 
implementation. Guarded by CONFIG_AUTOBOOT_FLUSH_STDIN. So I guess if we 
have a knob for that, another knob for the cli_loop() part will at least 
be consistent so fine by me. I kinda fail to see why we would not want 
to flush, but /me shrugs.

Cheers,
Quentin
