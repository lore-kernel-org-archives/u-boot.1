Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC6BC2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 08:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0490587FC7;
	Fri, 28 Jun 2024 10:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fMhcBNB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8516387F13; Fri, 28 Jun 2024 10:27:50 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA5187FC7
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOO/V1IgB42zI18MVZxgVAoTx0MDDHHfyxeWIyOaxQoOViAddTqUsQctVfkcZf7FW7VtvA0f5XDrzIlHLK/kzwKgseerfZ6VU7JFeivEOETjb4HuSDd/LUrV0OpKtZk9mNoObPIGcnnXzTY+aj8bDjXIbwx3NhcjdoK2RTuttHBe5MS8oDc9Kmc21JlO4vDdic52zN1tOQjwsz29zdGFxjNWx9uGX5C9cvYCbTiwb7SKiCycMlNHjH/iqEYmlYimfarkbrD7iE4yVEmz2p4aKXvXcpgIcZ0aVAlMtK8THYuaScQQpFZzLqoWzJCMjV3HWZ1nu2VpH2TSCo97UAGxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymbMkU80rEvYr+bq8Khff1cy0lhG9o005k+cnefqsUE=;
 b=UGRA7Ts9LB1ZhTUFjt48aCbpu3DN9ldIKxpHoIIPS3/pcUKlzq4e9As0Y03ce+U+EkF9p8zGPMeYnwKQlVVkNrc6d7aYYmD+tHO5aiAtYTQoRbIlKkXU7LQPhiB06eAB4MP1KJ/6/f/htoqiBbvbz4kwVdW3Oj1RkB+Ljq1XuplGHr3HYV1dCIV29skrHr99KTUEOMYb6+X2NGzaGuPjUGCsG5PSXC/rG5h5UpPg/tDMk7Wn4+bvj0ucBAH3AA/ZMrTMBCNGQtPXRbO0cCKOMVncnBXkeJ0O7VzL3koRp0dS2gwWDKLsx6z/DQyiFeRluu1HbECPHmp80jv9sikVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymbMkU80rEvYr+bq8Khff1cy0lhG9o005k+cnefqsUE=;
 b=fMhcBNB2eyMvQorDwYRUeUOBUS3AZwqT2q4sXAUSAJ+OLIWt6Ur6kNZGSFXa9JW9EBYyHxqEoDcYXH0+QDQHxDCb7bQ7OcNP6M0VxFOxQOGioXaOZ8XKIjdwFuKwY//uijfBIXQA/pCmI+zD8QdRWKnsz8Jycsn6aajp2sLYaN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA4PR04MB7840.eurprd04.prod.outlook.com (2603:10a6:102:ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 08:27:46 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 08:27:45 +0000
Message-ID: <274c876c-4d42-4af4-a68c-5b51c20bfdb8@cherry.de>
Date: Fri, 28 Jun 2024 10:27:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20240626235857.272264-1-marex@denx.de>
 <d31b4e88-a59c-4ec7-aa05-1293ab8139d9@cherry.de>
 <7c53dff2-9703-4a59-9a90-ec2d64cdb3fa@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7c53dff2-9703-4a59-9a90-ec2d64cdb3fa@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA4PR04MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: c43f8c52-37a7-40b3-f182-08dc974c2fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1A1cklPcmpKUi9HQU1DN24vNGpIcE1NTU9yK1FRV0t5TkhlbGo5ZE90NkYx?=
 =?utf-8?B?UHR6Lzk0TzJzWEtmaTgzUGQ2YXkzWHJOR01ZWEsrVWZSQit6K2xqWWRubDZD?=
 =?utf-8?B?djh2cmdselZmU1E0cndYbTNrUU96eXFPOGUva0hhcnl5WlErSFQvdjU4dUpE?=
 =?utf-8?B?cGFiRXFXTWZYbUR0UVJET3g0VkZyRU1XWDEvNXZMcExTaWwvTWRMQkdnZklX?=
 =?utf-8?B?bFdoZ0VRdkR6NGlLQU8zR2RWK0hFQWgxaWc2WWpwK1NlK21qRlo3YVNXdTV1?=
 =?utf-8?B?djZqMTRoemhUWXM3RlZFSmJCenB6MmF5aGpzcTZPc256Nm52cXY3dGY5eGp6?=
 =?utf-8?B?MnVqaGR5SkhaVzdBSjBqTksvS0V0SG9LdEtkdk5uYVRseGM1NlZ0ekIrVFRn?=
 =?utf-8?B?NHZ1N2ppbTJRcFk1M1FzZW5BTEdRZVdCS0RFL1Y1RHNYWjA5bUdPUjRNWGxw?=
 =?utf-8?B?YlE1ejUvNTQvQ0lNUGRZNEh0Smk4eGJTK1pDNGFOV1oyMlpweFh1REw0SmtK?=
 =?utf-8?B?YTczSkpjRGVTYXRTYWVyVEVhTk9EUEI4SEF3am9JSUVWcENNUHZURUoxRjlF?=
 =?utf-8?B?ck1zS0RWNnJ2aTdESk1sZHVROENhN1VJemcrWGdFTWpaamFkYXJ5OWNNYW4y?=
 =?utf-8?B?bjhzcnR4eTFSV1ZIZFo3VHJucnJnNUlEd0Q4Y0dWQUJhbmJXenZaN3EvMHpW?=
 =?utf-8?B?L0hMZmNSTkwwUEFwRGczczMybjdTZC8yTDhjOXZXKzhyakYyNUtrM3l5NWVJ?=
 =?utf-8?B?SkRlcTFiWVp5OTZib2RoUXBzWWk4SFhPODRyMDdxQmVOMFNpYjVvcWtpelg5?=
 =?utf-8?B?V2F4aE1rdS9TVVBkUFJkVmVqeEFtTFZ0Ky9hQ0FFbU9UK2paaVc0NFJnMll4?=
 =?utf-8?B?ZSt2Mk1rdjgvVndnNjJvUHBaRXBNSlBuWXNHUERmYzJRdU54Q0VWVUgwa0ZR?=
 =?utf-8?B?dkloMlg1Qyt6cW5YZ1prNjFNT0szcE1yQzlhc1I3VVJjM3JvdHF6V0pnVkUx?=
 =?utf-8?B?cmFEWHJBbVhqYmJRVUcxejZoMXAwdzNlRXVneUdHaDZwU3dnMGhRYjJmZlJQ?=
 =?utf-8?B?TC9BeERjN240R2xDcXhSb002d2ZXWnM4WHpXQXNvelNsb3dLR01VQ1ZwdW94?=
 =?utf-8?B?QVVzTTFyV2xFaTQ3UWRReGI2NUhUVkhsYU1DdWw5NCtIT3RuKytYcitBK08y?=
 =?utf-8?B?bTFpVHhVb3FzNmZSVlk0OGJqb2RtYWQ1ZFFPNktkQkVIeGkrR0padmkzaWN2?=
 =?utf-8?B?WEFMYkpGU2ZCS0tla0pWRkRQcUhEY1NqMVZPNjI2cU5kcjZzMVFmcytwV1gw?=
 =?utf-8?B?Qlh4NTcwbWZBZkIxT05PSkVrV05qamhqRzM1S1FHQWdyejJnVjRNV25BSFZC?=
 =?utf-8?B?VDhKTXdHQ01lQmgybE1TMHJHMDZ2YnlVR0haMUpaYnExVFljMXVzQTI1YVo2?=
 =?utf-8?B?NGZUM3R6eEFRK1RaWEhybGhGbjR3MkMzVlJTczgvamJxNzRZRDVTN0VFaTk2?=
 =?utf-8?B?SXpranI0M0ppSzRvVElObUJkN0lwdmljTjZZcEpVS1dtaFhMY0o2QWxMS3ZW?=
 =?utf-8?B?MXhkRnlqWGVGcmk3akxwZ09DMVl0UTdoL0V2V3FCYjRNT0dtVzlkQlcxYWlQ?=
 =?utf-8?B?SUFPdFJjUVIzKzBzNW1QQy91QkJyVkRvVmJIQzF2TkpJRmxVaVdpTnNJZHB3?=
 =?utf-8?B?S1cvamRwT0VHV0ozaXRnOXFWUTNZRGxodlduQVQ4cjhCSkgrQzBSM3VIUkpB?=
 =?utf-8?B?M1NrQmlBMmdsVndSRDdvUkhBandlYlQ1bUFTRXRacUo1WFZHZ0pUL3FESkpL?=
 =?utf-8?B?Q3ZtTjZQVmhpQWtKMjN0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjFsdFVEZzVNWDA3bU41aU9qSkE4cVVkU2thQUFiNVlVZ3BpVmxoRlFqV0Ri?=
 =?utf-8?B?TjU0ZXp4dzl3elpLN1FSb0JaTGVQYjJ0TWlkV2IyZFU5aUhxMVl2QU0rNk9I?=
 =?utf-8?B?WURDU3NGNm1tVGVJUVVOTk1GM2hmQVNMMVJGdXZjbUZ4UFMyM1UvcC9LbWNM?=
 =?utf-8?B?cG8zWjU1Y2dnMUtmU1VFTllkdlVvR05HZlN5Z0RSQ1RxSDJLSjdxWGNCMDlG?=
 =?utf-8?B?ZGg0bHJ4RXFCcHR5Umd4YUh3N3RCOFZyWmEyOG84TVJ1d0Rsd05WN2FiUFNI?=
 =?utf-8?B?R1Jhdyt4L1RtRGpEN29xV0pIcHdWbm93UFgvQmg0bFFJdFVhT3grTTFrVXlP?=
 =?utf-8?B?MUZGT3FwV3FKaWZOQUdvMm1XQW16ODZoUjRJQm1LTmlXOHVoYVhWeHB0WGN3?=
 =?utf-8?B?VzRJQTh0VGIyUnd2RURQbk9PY3h3KzJ2endZb1FNSktQWlM0blNsZEFHUFVQ?=
 =?utf-8?B?b0FBMGJrUjVxZ3k0OStsbCtkMnBmTTUzNGRTM0l6MGpVVHZaNW81UCsvcWt3?=
 =?utf-8?B?aTdVUUV0WHZGUkxiSmJpS2FJZTFxSHpXc0NRa2tXVUdncEpMWFpWMmdqcWVY?=
 =?utf-8?B?K2l5ZjNsMFFzU2RZUjN2Vk1DaEloQ2lpdWI1U3J1Z2ppYTRRWnJtMWhSSi9U?=
 =?utf-8?B?YmV5YUVGcXRBdzkrelZHMEt3UTd4dkdMSGg3RmNPbGZCZ2g3L2QwR0MwQ1Yv?=
 =?utf-8?B?bi94VVpUUStWZDU1QmpYYkRPT01SR0ZOWFRnbnFKenQySXZPUUhqK2EzYTli?=
 =?utf-8?B?Mk1nOEtMQ3VHL1ZNMWI1Wk5hQ0RYS1liV1RNay9oUG5CRyt0SFFiRVZMTE94?=
 =?utf-8?B?aU4xTG9NdSttZmlZNXNXRCt0VUF3Q2RCbVp3N2s2SkhrOVpqMnp6Q0dLWHRa?=
 =?utf-8?B?KzFKd290eDRaYXpkVDhmWW9yVmpVaWpmYmRyMUZLV1R1bjdlWC9vR0FGOFJ5?=
 =?utf-8?B?ZUhmQ2JLbHQxMWdGaHNvWkFxblVXa1hzTUlZSXNDK0hvQVdjeW9qQW1Rd3k1?=
 =?utf-8?B?ZnpMUHBqWHEvS2xvSWUybjQ0VzdMc0gvSnlPYlF2V3BKd0lJZFh0aTdQV1hs?=
 =?utf-8?B?ZFpYaFBQOXNXY2k2YXUrMXNIRWkwZU5iTVFYbmtjSFdQeG9FcEtOR0tuNVFo?=
 =?utf-8?B?RWZzK1ZTRDNIVU9GQW0xYWFSMWY4eGZ0Slhza0xWM2ZxK3lhejBGWnRUaVUz?=
 =?utf-8?B?TENTcGlLdUxWVWVjNlEwVGdsaklKQmxzU2JDZjZqSmsrZHk0Tk1USjhvWkpJ?=
 =?utf-8?B?OFd0dGprckxFK2JUV3Nzd0w0eWN5TUhDQStHSCtueGpvc3NSbE1qVG5UTWZx?=
 =?utf-8?B?K1Z6Nk82dGxENm80dUZBQlFMVUl6Ylg2cjdyUzM5Sy80MjR5N21UdTk0V3RB?=
 =?utf-8?B?WGZ6cE9QdjdpbDNvMVY5RjdKTGhyU3pBa0ovdnVuRy93U2N0aEtLS3hrZVJQ?=
 =?utf-8?B?ZzdlZzkweVVMNVBPR2VQRDZoQmtpT1lySEJKL0NnOVNaTVZmTVpTZ2lndkd2?=
 =?utf-8?B?WHp2ZUVFYW9KUmIvUjVIS1hENzlsNGdadHF1MjdidFBsM0FPZU5SQStaZDR2?=
 =?utf-8?B?eXVSZWJkUUhzSE1tenBJekFlb3FDanAzbElWVytJelMrWHJ4K0h0Tm9DY1hv?=
 =?utf-8?B?ZG1iRjdxQ0JrSnJRRUxKSnFvaUE5ZzV6ZW83WEtBZTRGWlhBbXRpTXF5L0xG?=
 =?utf-8?B?WWxuRkxjd0lIREx6MnJaY20yR0pSWExROUVENUFiQlVVSUxab3d3VDlKSDY0?=
 =?utf-8?B?Z0xwQjB1WWVjcjV2WmRvSzVBY0xXS1NIWkdKaTlNNUsvMHhCNEFLY1p0NlND?=
 =?utf-8?B?QkhBaUMrTHVMdFlBTUFFek82ZkZGZUJGb0JqZG4rUDUrRVM3REhvNE5DcGd2?=
 =?utf-8?B?NFhTK1J1Q05lV2JaWlBCNCtBMC8wa2Z0WUcxQ2FQRi9oOGtUR3hHL04rN0tC?=
 =?utf-8?B?SFdXUnJEYjFWTDMyeTdMYWp1RkZ5TnRtUS85SWNNSzA4c1BDM0c2eTJWRVpQ?=
 =?utf-8?B?Z3k5ZGQ3Z1dkYjJ6UVZ5U0c4RDRZdUdGeEY3RHJEMUhQdUdHTFNZT0EyeU9H?=
 =?utf-8?B?ZXF3RHpBNzVsNHU3ZFRSY1pyeWIxZHY2VXNLUHBVOTlEaGJHUHlmWW1jcjVO?=
 =?utf-8?B?OUJnUG5EZkNYLytuSjZzNTkzWkZvWWhyK3hZZGxjSVdCWmsreFdxTXV0TXho?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c43f8c52-37a7-40b3-f182-08dc974c2fff
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 08:27:45.9367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkR6ky/gfH2+E5+/5VMc6xxcH2mPCjAdVHzRqMVhd3850hivJRBjNdbV31pl7YStagrMnXKRhk42BPyL/jOqyf1NeNEcu5XkzRGJGvb55Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7840
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

On 6/28/24 4:42 AM, Marek Vasut wrote:
> On 6/27/24 2:42 PM, Quentin Schulz wrote:
>> Hi Marek,
> 
> Hi,
> 
>> On 6/27/24 1:58 AM, Marek Vasut wrote:
>>> Insert /u-boot,<dto-name> = <index> property into the U-Boot control DT
>>> during SPL DTO application process. This can be used by user to inspect
>>> which DTOs got applied by the SPL and in which order from running 
>>> U-Boot.
>>>
>>> Example:
>>> ```
>>> u-boot=> fdt addr $fdtcontroladdr && fdt list /
>>> Working FDT set to aee9aeb0
>>> / {
>>>          u-boot,fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100 = <0x00000005>;
>>>          u-boot,fdt-dto-imx8mp-dhcom-som-overlay-rev100 = <0x00000004>;
>>>          u-boot,fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast = 
>>> <0x00000003>;
>>>          u-boot,fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast = 
>>> <0x00000002>;
>>> ...
>>> ```
>>>
>>
>> Shouldn't this rather be in /config node?
> 
> This is what I had there originally, but then I realized that some DTs 
> might not have the /config node in them (or am I mistaken?), so I moved 
> the new properties into the root node, which surely exists.
> 
> It also keeps the code simpler, as it doesn't have to fiddle with 
> creation of the /config node if it doesn't exist.
> 

I don't think we should pollute the root node with this. If we want to 
be able to expose this in a proper binding to the upstream DT binding 
repo, I'm not sure this is going to fly :/

>> Also, I am highly suggesting to have an additional prefix aside from 
>> u-boot to avoid unfortunate name clashes between DTO and existing 
>> properties.
> 
> OK, fixed in V2.
> 
>> Or could be in its own child node of /config ?
> 
> Please see above.
> 
>> In any case, can you please add or edit a file somewhere to define 
>> this new dt-binding.
> 
> Done in V2
> 
>> Additional question, what is this index for?
> 
> To indicate in which order the DTOs were applied by the SPL. It matches 
> the order in which the the DTOs are stored in the fitImage and the order 
> in which SPL iterates over them. In case the SPL skips a DTO using 
> board_spl_fit_append_fdt_skip(), the integer sequence might have gaps.
> 
>> I am wondering if we cannot simply have a string array with overlays 
>> applied left-to-right or right-to-left instead? Or u-boot,fdt-dto-N = 
>> "imx8mp-dhcom-pdk3-overlay-rev100";
> 
> We can, but that is much harder to test for presence of specific DTO on 
> U-Boot command line. It is easy to test for presence of boolean or 
> integer DT property using 'fdt' command.
> 

Not sure dt-bindings people would love to hear that we adapt the fdt to 
be easier to work with from the U-Boot CLI :)

In any case, another few thoughts that popped up overnight:
1- do we want to have this for SPL DTB modified by TPL? If so, I'm sure 
we want it different from the one passed from SPL to U-Boot proper IFF 
we start from a clean sheet (new DTB) and/or add the DTBO we applied on 
top the DTBOs already applied by the TPL to the SPL DTB before passing 
it to proper
2- Add info about which DTBOs were applied to the kernel DTB?

Cheers,
Quentin
