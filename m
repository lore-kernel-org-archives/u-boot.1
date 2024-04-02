Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6E1CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 14:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8731C88374;
	Tue,  2 Apr 2024 16:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="HnvrjQkU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC10288377; Tue,  2 Apr 2024 16:23:23 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B240E8811A
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 16:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpmjnnGty7cNJX2Fa7F6wn42LDv6vFlvK1/9wZ6KNIdKR53fnXLe3GRa41UU9axTjtdF733TrgZrw63EP8OmlRzEmrzp3pmnYp0k4RfGcZpl62+1tEI0/HrHnMqgud6hDQm53O0HtDjTtXv0XAAk56MQe4XcmlsllD2SkHLpT0wTcmnSXv3vG7B+9DjCxHG9u+Bfu2bUvpkwyh8AnEGEPBqjHJRVufuKT3C2p7OHV6T34/eT8olZFdTeTHe1j99HfEaqZv0jzrtzIFFWQFbtaGHO6GnzP7A5lLcu0zq0V6dagn71VXYzStqiutidORuUwmd/2tynCupnqb6o+kqgEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4eUr+N177zzMB8fMSrQu3Z734CRxVmsNuFBtpC0wqo=;
 b=YTcAop7qJJ9Ym8hQlJb/MLwniESek6UILOCxRIhOe/J/gHmLtu1jcFygYZ0/Qo8EEYXOzH9Csdjp5AdqaQKWqBUnIgy+NmX4GCSnTR3ciJuTXEFemkwv7NL2qww1GqkWz0UUMEcn2jICIuKycMT28PdVRbbtkRvABH79iOTI4Cn+4DlxE3oay1YGR+tCtImT8XD9jMwBSTQYgbkDX3jUaY7f2QyBgsg0C4UqhfXDfmc/k9mSrZXX8m29fnGdVzPedr2QQvyq5qVJvPxU6155LNqBZzYymopzV9SQGbaGPMMSlyA86VyAWcm64tzbSfywBtiS+V7ReVFtT4hrHiV+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4eUr+N177zzMB8fMSrQu3Z734CRxVmsNuFBtpC0wqo=;
 b=HnvrjQkUNf0E/NQNEkTMgfUawu219p4xVqj4k/Ve/Yxr+Ylou05rBDj3EqIUtc0KYG5znAFeedIw+51TrH4dPEe+7y77/XTSEGRPzghI3BogLjpr2SH9X1tpCTwp5243czqPj5YhKVNvHBHHxtusIu76o0ccsxVo5Zt4ipYlNgRXF5dhsRwErjNG3vcOBRCNMo5mcFL6RjR1O56s/q07BiEp/HOcYF75rdsInRPycfSBIRy1ooBqLPsMPEiCxh9DtLjegpSaZYhYtLa8vu46y7bqlF/clYc8A12KQ1Hhzpg9D7l+KaoVxM3CwMYSLe91Cvjto4kbiaukai43UBtGwQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:23:17 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:23:17 +0000
Message-ID: <706cc408-97d3-4c3c-94d8-cef44ad733fe@theobroma-systems.com>
Date: Tue, 2 Apr 2024 16:23:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/31] rockchip: rk3399: Remove use of xPL_MISC_DRIVERS
 options
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-9-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::26) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB6941:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +t8S4FuDfYwnR+/pxh8EwIP19d7SwFnlbQnKv5jU2xqCOsU7JJEC8NYm2Kao0rd5UayIOnwHqT3MCfJr/Tousd52OdBJagD19k0gb5h8tk8n88N4tZcDTeBmWgcLcLZvXmd4V7FRjmhBHJYFI4yF6yHLUbdPHxEbv6gfQr/eRlnKDaJFxpbeKWRYfsoIGH2ST3g2PfH1zizHZMot2QXtlwZyqhNICxJASVToVGD9uQSP78c98lj0OOGeXDEYcxW8IduHrWvZ9LSeyai4pXSGuD/53ilXbTAWkxWD9oJ87WazO5YD/7xE9QWMPw2WblBdTHzEHXwmDJksC8DKux2SRBdFpValVkJaRKgaO3bSo26m+EtOJ8Ymy5CTyZcu6+btxXrDXHD6LdbbfCm3CSGZ62YasY+EBqPXSMKo4nBQRUJq+XvPHJIft4rBtBzrWCXUV5LYccLFQGJuYy4f1uYGPxP7rx9RDGGWJ4yOYRc3vt7D3Axn2Jtd8QyU/cOd87RgnjVmB0dSgGOqPJoPvr6FKWuwBZ68koN5G5wauQGeqUkVNANxdd36y7VsVTH36mD0+B0u+slG0UdDB+uJUd9IYWvZv49WAhYW7gTB0FT71mbbhA04k6J3oojCDMhrgyKARORJs9jp+Te32/Lh8rg9hZK23UiEJG9qTIo5nLocTg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUpFWlRLdks3aFM5U05qcVA5Q0R4Qy9FVENWYzV2a2puaXdrNVJZRlFjZlJY?=
 =?utf-8?B?RDBlYzFyZHJqUXJTckFEMi94M2FGVnVkaGd1alFFREFxK1FOSmMwYzRjbHEz?=
 =?utf-8?B?RDQ2ekdlZmRzWDJSbEprbWNMK2pqNWpiaWwzcVRwY3BISm1sU25sOGUzV1pF?=
 =?utf-8?B?QS85RkoxeW5ld2JLZ0ROUWpCUHVxWWp3S01ER09WT1kxdFJFNWh5MHZ4cVQx?=
 =?utf-8?B?blFOWEtRanFHL1RaZXloOWxVT3B1QlI2VVhyUklZWFNnVGpLK3pJQk1nNkgw?=
 =?utf-8?B?aWhVektrRmVjTVRuV0xEU21sNkM5YkFnSWdQZmNuMENUb0ZCbWVsZFFQakxi?=
 =?utf-8?B?OGNjLzVsaUt5RGVSYVFST3VvTnROdVRWcjVrY3hKYzg2R25nNzNwVlU4cXl6?=
 =?utf-8?B?TEhpbnJMM242cnBFRzgwZ0wrUUNvZFRjQzNuSlZ2UXlqcFM5enpsMGFqT1BN?=
 =?utf-8?B?ZlBwYjhMd0ZRaUpqZ1BTaUtnZkxsMk8wN3BPbHdnMFdtVlVjNHRZcnhSNGh5?=
 =?utf-8?B?eHRFQ0VGN3luZmFqVWpUZnpGZzFlcUcyelgzU3Vvdm16dHlBRlIzTitJOWtJ?=
 =?utf-8?B?RHVBa1F5aG41TzNKb3N6bUVQTHZ0ZGRqdnNlYzA1dFVONkM3TUZQWjVvVDBB?=
 =?utf-8?B?TjhDRzNzRGdYdEYrSmhYODlTSk56UXNObkZGSjVlVlhhdWk1eHhjUGI1OGpU?=
 =?utf-8?B?TzZGVDQrbkk1VUJ0eXlhSXN6RHk4bFFGb25kS1U5VnA2ZUdNWVF6YXVjTko3?=
 =?utf-8?B?VmpiaTRka3BDMUhERHlYTGFKbkEwL0tvb2RnSndXc2VmWS8vdzh0OHZtOUZi?=
 =?utf-8?B?QmFrVm90cjNsemYxb1hPZi8wcjdDT3RFNnBTcFMrbnJEanViaTFWZHVrMVVh?=
 =?utf-8?B?aUZkRmUxZHBuSTdzTnAycmFJbHZmMFBEMDhqOENpeFZGbFNLdUl3YWJyMll6?=
 =?utf-8?B?czg1VnNDNFhJTHVBRHVlWnd0OGRKN21FancwVThzWHZCdThiRnppTkNlN1k2?=
 =?utf-8?B?OU5PbnY2bFRac25odXF0bmd6dVo5WTJ5OVNJL0g2U1ZvTDFhK3FqS2VzdDVY?=
 =?utf-8?B?NXRRUXBqVU90V2tEOHJpYUN3bUFORHRZck04dW83TURTTVduL1MwVHE3cVNv?=
 =?utf-8?B?R1lwVERqNVJuU1grTlIyV0g0bmFhNkkwdzlhTXdzbFNuZ2hyd0lOYmRFS3ND?=
 =?utf-8?B?T3FpTmk3ajNEcUpzSmt1VEtDcjZXTzJma2JNdkNJd2duUkxzWTFwQWVOM2Nr?=
 =?utf-8?B?bnltb2ZWVHFvNTdrc2JSWDgxVFYrc1hIVFhjRmZYY3phVkw1eWQ4SFY3Vm1y?=
 =?utf-8?B?WlhxUTltR0p6VjZqaXcwa3RiSkE4VjN4V3VUU0VjK0xLKzEzN21GeXVncDhr?=
 =?utf-8?B?UTJMU3pLczFSeWcwaE5GVlR1RTNSWlVHeWVhbXlKZ3hhK21KMVhCanhaMDdF?=
 =?utf-8?B?dDJ0UjMraEp4dEJoWEducElKa3JHYkV5RDJCUnZWOUZYMHZBRExWTUozSFFO?=
 =?utf-8?B?RVMzNHdhdmhacmg3MC9jQWdVUlk0U0RrSGszcXh0SWUyaEpOL0pIYXJzMmdW?=
 =?utf-8?B?UjlqWDZtVlNaVnpoOU9sckYwZUVmMHBXZjZ6UU1zMmV5aDFxOG5uTmF1c1Bj?=
 =?utf-8?B?Uzg5cTM5NkpJZGc0V0JtYS91d1ZDRkdsOEhKZHhQUFNwK2hndGF1cDVja2Js?=
 =?utf-8?B?VktCLzBteUJaSTRKcG9JSjJkWjEyS0lTcml4cFJpWTlsZkVwNlBFSHlLa2lM?=
 =?utf-8?B?VFdKZFVRL1d4NHVtUzRhOWNSbVNRWGo4SmdYYmJUQmMrREVqQ0pjai9qTExY?=
 =?utf-8?B?eStSOVVrV3lWTDg4NnY1TzhJSHIwdVpYR2QwRXlZZzlkOTNaZGx1UHFLLzc0?=
 =?utf-8?B?a25Db0xzV3pzTGxLdUY2Q2txQ1BqdFNIWGJUaGVreXNHQVVwKzdoODBNYTBl?=
 =?utf-8?B?MkNqWUlmT0V5bFRxaFB2NTI5RzlPZTlybERFR0hSQzhZZGt2WC94bEFHMUQ5?=
 =?utf-8?B?bDBHME0xbFBKR21rSDNQRERGOSs0TzhWblRtU2pLNS9DT3dIZ3oxU0VEUGwy?=
 =?utf-8?B?clZqSmQ3cm5TMU9oclZiU2Q4aHYwR2lrRzNwTHFNZmxHU29USy9XRHNqaXdw?=
 =?utf-8?B?VGtIdzBxYjhnMlpQaThwVTU0LzhSaEdYQ3ovRFJvVks5T2Jxc0lDczYwZXEw?=
 =?utf-8?Q?yZPjN/Ufa7Vqq5eU+WdwFSM=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab6ddb5-8605-46d8-f975-08dc53207049
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:23:16.9945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJFvHS6da8gus+qqVmwntyhsCAmG8SGI2Mij8XBRbJG8wKiU842XTbJkyzHSyqmC2rxpANTcwx60w/ZRKK2AoRRmddjW0faotm0yJKWBHp2MMWLF4lmD3bW1jo09BOHI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6941
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

Hi Jonas,

On 3/31/24 22:28, Jonas Karlman wrote:
> The TPL and/or SPL control FDT on RK3399 boards does not contain any
> node with a compatible that is supported by driver/misc/ drivers.
> 
> Remove use of xPL_MISC_DRIVERS options to stop including e.g an unused
> efuse driver in TPL and/or SPL.
> 

This also makes each board maintainer responsible for enabling CrOS EC 
(Embedded Controller on Chromebooks) and/or IO domain if they need it in 
TPL/SPL. But considering Gru Bob and Kevin don't seem to be enabling EC 
support in TPL/SPL and that IO domain isn't enabled for any board in 
TPL/SPL,

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
