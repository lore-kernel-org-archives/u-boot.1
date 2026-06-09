Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10E8CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C55A8466E;
	Tue,  9 Jun 2026 09:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="O/sJAPjX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 734CD84878; Tue,  9 Jun 2026 09:51:28 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FF4B839A8
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaRnuXPVBJujkQTEYgAcTiNr6ged8dcSaRaaXb9grXYycDjG3SI6E8Fb8RmzqU85NRSlMAaM5N+2Ip8P5DOtMjSn2kLbogxxgF8xR5dkRyGECvV4XFojn8gR+VAHr/rMSEZoTUZvIBgkvvJ1oKcHNuDn3Z2/K+gMfqYZbBaEAybK3bWTPnrQnDmxOBLjzgB+WI/M8K9L8o7i3W46gUGvKPW9Z3I90FAgD5gTGzx028eeWTOdOa4ACFQuk6uuxoVQdLrnyzdM3GNlsiscvEkDKrdPZCiWlmhnlA31NWTRLHjyJcRuAb3izp7MU5DD5IgYRmhU+Vv19jBoEOSJXxyzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwzf0NzTc4KKUL4xzku7y0x/JWbl9nW6FeiVIOU13ww=;
 b=vRB9VVVtMCS533d0KUwpLQuJXeSNpu/3luNNKVHH6vh/6Bbq58NN1/MtbnEq7ZFR0LvRMjP+w2wvZ5U6jd4ZSs8USRz+wRLejU2i1q5ASdYGMDzxXWKW41neA/4FjK/q5qqn2HFYZ7SriBSfksJTFw9Kp6Nh/svavuEJ0f4K9A/zvm24UXGMxIT4s3TRe9V+yCTwvtqoKuGc+JIxmWxbZ3zMm8EdfjTMhC3gu/zI5mzlWoo6MY0SQglWXrbZIs5aggg6eRMxErwMEs3zVQqYxIszX28F25TMkH0pzn/m6d9PwG58S22U109i1FYFfzECyIYdr0nMiQI3Dp+dCkb71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gwzf0NzTc4KKUL4xzku7y0x/JWbl9nW6FeiVIOU13ww=;
 b=O/sJAPjXgP23THT80NvO40VdetwaIVjSNjNLF4IY+luKJGfJnzBacIZb3gbLVP8/pUnDOJYuP9H+LLBDv47TIGZrNCFUsxbLwb+NPu10/t3GIt3qUjLcA4KqN3EEv35eU9RCrTXU5lspc806LuUsHSnRqnqXcnnzLoKx6D/6Z92HorDmwAmZDAQcGF8Z5T/718zxYLurk0YTFkfCFyJdyU0pv5tjJ+Y4EMcF8xJe12rTfo0l165O9fGAj6Q9YJ+18upOH7XJJHzXCqkkE6Ua4PCNrZ6/cYS5N8jjTkK2gqb0ZBclqI7p8D0/K2LR26/drcZw2aYqbJD8psJwkM1wbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CY2PR03MB587508.namprd03.prod.outlook.com (2603:10b6:930:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 07:51:22 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 07:51:22 +0000
Message-ID: <9342cfa2-0196-4837-8090-1a97f78bf787@altera.com>
Date: Tue, 9 Jun 2026 13:21:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
To: Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, marex@denx.de, tien.fong.chee@altera.com
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
 <agg8f-Q_RnVI9Gyl@nxa18884-linux.ap.freescale.net>
 <f87d4c47-8675-4b43-b076-52325e2c00ca@altera.com>
 <96aa516d-9039-4b64-a779-3f16a9b9b816@ti.com>
 <2e75ec28-a3b0-4890-8e10-ea0459d6ff7d@altera.com>
 <2571b1a0-9395-40e7-a85e-4204c7543d39@ti.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <2571b1a0-9395-40e7-a85e-4204c7543d39@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CY2PR03MB587508:EE_
X-MS-Office365-Filtering-Correlation-Id: bc14a48b-70b6-4559-5983-08dec5fbe4d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|6133799003|3023799007|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: w25oYKsvfo+Zc5SYjashc332SXvMC3b0H5IU495JoII9O76nCn1UJX0Lv1IuSDFQlJuU6F+lSfQI49R4q6sO5iQHJMf27duyT8AlFZCE7E+MxHsLTLFEw9rkQhIHk3iCoCRA/6qlIdNJkr41mFmA/yzxA7NPwxRFNCQf0UlaIQEGmJAvh8UqbfKZXt2TSQgTWTDlXRITjynVpMMSFAPMiG0eSXt7Si6NWb1LBPmEyBwLYXjxCSeXEbEVt52TdBsCSlZU7D2nJneLrOpAujR0K/zb02w4g3Ro6EEJMePBESgz4PfRyJP8Lc2+1oLyrjQwOiaFMZPS4Ue1GoODGRUeSFH2A8xIBetfcTIygp5PWo2M6RYfvUEsseQM0fw3oiAR6nhDx8EjJ7IoRDKIMvcPNfpylPU+BSwY/8z7twYv2+moF025sPbYWRQx3UX+PoPJi2toLWKm0enxKnqO/J5bvxle0gldosEJnp3AsaXog2rigLdqb/7QCL9Rx8W6pkWXxhuMzkempMF0DIUw/yq1X9mjamv1OljRBEw/FHId7MgY25JSBmZ0G4z6t/BmexZcm3eH2Qj0eIppHu3sA3WYdP2oNoH7qKCYAZ5m+8OLDpCu98GgccVQwSoSRmJ0qQN0xBCwhwfeRor/2QSgm5YcIwj9pCKQluuMredg9wO/4TFw+nnMjCZp4vs/J8ialdkJeeD8Q1PFk1QMDTIbce/ztg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlgrL3g3N3hRdFVsQlRyVXhyaFNWWGY3cGdZSEg0SUV4azdYSytZcmNVUnJH?=
 =?utf-8?B?TUhZTmZWcnN2cnFwczdIbHM1RktEZ3BESGw2MUhNTVZDelg2SUF4WmJIZUpX?=
 =?utf-8?B?VEpSb2lqK2FVMFVOVjJ5Kzdld3pZM0RtYTR0M2t5QTYwcHU3Nm9EOHVsc25q?=
 =?utf-8?B?aU9oWVEwakx6bkpBd0NNMFoyUFlIR1NKVkE3NnBxd3RKQWJFK0V3czYzNUUv?=
 =?utf-8?B?ajJjNW5Ea3dwbWVPMDFyd2Rsbnk2Qnk0MWpXTGNXenloM212emN3MTlaSUor?=
 =?utf-8?B?YzBPMWlUTXJlTWp2VW1lMWFJc2V3Qm5mL3ZISXdVemN5Mms2OXRNc1l0U2Y4?=
 =?utf-8?B?cXUvWWVGM0lLU0IrdkdyYno3RUU0cjAweWJxTEdqWGx5bTU3MnRaYlFnWDhE?=
 =?utf-8?B?YkM3Q0padXMvWlhZTjJnKzE0L0VnOG5JMGdyR0hvekdZdC9lWnhHUDdvb1FD?=
 =?utf-8?B?NzVMc3NMQVdKNGZjR0dGdjZjZHJnUGJZOUdlYzVhV1hUZnRVK2ovNGpwQ2RF?=
 =?utf-8?B?QWdyUTRRVlpLSklZTFdHM3lUV2dpWkc2THA4aCtFTGQ2SFBxVEljMWo4UU5r?=
 =?utf-8?B?QjZUQjNsU0FwMVU3VSt5WVNlRzNaMEdldktHZ1IwZXlQMTdobjl2QzIrcFF4?=
 =?utf-8?B?dzBsbzFUZVIxUVlUTEZFaW1mdk1CSDZZRzdIaE5FRFQ5dnFmTHpBREh2elpy?=
 =?utf-8?B?UnpzSlZ0dnkxVER0b1hPSHcxNkxjcFVwRUR5M2lKdnlLM3dvRDcyYWRhVkJJ?=
 =?utf-8?B?a3haN3dYR0w2WUdjUElYTFhYUzdxVFpFb093U2V6VzVRYm5scCs5NlV6ck85?=
 =?utf-8?B?Tjh0WHlkZWhsYWw2RDNRVVdENy8yNTE4THM1WEI1N2J4MEt6bGR6N2dHTTBV?=
 =?utf-8?B?MklxU0xWR3hobC9OUzNXUzk0TzNVVkFjRGloVk4yNzZhT0FBYVpIMWhLaTlY?=
 =?utf-8?B?OTRWV0pib1Q3eXY1c1VYWDVXTzE0bHJpRzMrV1VTQ1JxNEFnNk9sa1Jobk9t?=
 =?utf-8?B?Q3FkWmQwRUV4a1RPck1mUGRLcmtIbktsZXRGUkhpNWpCcklUTkFLSVBMRXBT?=
 =?utf-8?B?TU1aQmtZVlJYd1gvaDdwcnFUeFIxY3VLUGcwZWJBMTVDQ0p0TnJseHRnT2pQ?=
 =?utf-8?B?ZU5WQm4rMmpsWUFFWkNERlNETlFoQTJtMURTVFY2RE9tQUFVcTFudnZUV3Zh?=
 =?utf-8?B?ZzlCZHlTNzNxZENuTEJUTVpXSCtYVVhSUER1MDdCZnJwblM1ZUFWSEwrYmdX?=
 =?utf-8?B?TThoTFA0THVGTkgvRmFYeEtWRTVraFlKUkdSM3JsYTR6a3BVQ1dhR0w0Zzdn?=
 =?utf-8?B?dVJVYnU3UjlObDlKTWtTTGo1NzNKY0FONkIrOVFLOGVpdzlYU25PdG9EeVVF?=
 =?utf-8?B?dXVpNHErbUhVUVE2czZ1aXVVZHpaVFRpeHBoNWxtaG9WeGpPUklYT2Y1OElZ?=
 =?utf-8?B?a0k0SWk1M2tzbDhEaElaQldJbVBxd3FueVRLc2FqMXFpUHlpeWxUdWExdC9I?=
 =?utf-8?B?Wlk1Y2o2NUlvSXUrOEpjeldKeXJzWjVoVmF0K0VxZWtCZ2lsV0pHTzhBVWxt?=
 =?utf-8?B?RHZvN3VIcThYYzVKaEdRbjR2L3drSUh5N00wcG16MzFCTGpoZ1AvaDVYaUNW?=
 =?utf-8?B?dFQvelFDWVdxWjM5ZEJkL1ZPQm9JaFFxYXcyRnJPV2VoT3l0aENYcktyZ1J1?=
 =?utf-8?B?c0JhRU9xdDQwVXo2ZFlmMyttMWpnYUN5a3czUUZ3WEo1VWFkc2UwWWZJNWpV?=
 =?utf-8?B?RnRtbUxDNlNqaHEySG8xNkFVYlZkYm0yVXMzdEprb0VFNjdaYzlMd08xMVJh?=
 =?utf-8?B?Q1ZJYTdYaFdVU1NZQlJlRkpLaDVNakFaVWUra0Y5OFZTZk8wTnlINTBBRE9m?=
 =?utf-8?B?RDhqdzN0dVZsREUrbDZOSjdUYjg4Ukh6ZVNMODJnMlloV1lFMi9jVzB2ZkFh?=
 =?utf-8?B?Z1k4akNvaWs3cmc4dW95d1lxZThZK0lSM1JHTk1BRmQxM0VhdkgwTVBZemEy?=
 =?utf-8?B?ZllYYWEyM0ExaVRWNkdHdjFXa3hXQnhHU25qSkpXcE1GODZCd1FmU3pEWUNo?=
 =?utf-8?B?NXdibUdKVUN4VGg4NGoxNTI5TXF6QUIxT2xZaHc5bVF1ZC9VbXNrc0ZicFMw?=
 =?utf-8?B?a1g3SXorM0Y0ak1VUkxkQWZyTE5QTlFJUzhVNHRpY3ByQjJVVmpyRjBvaG41?=
 =?utf-8?B?aFhLVWgwaEcyNDJsNDNYQUZzdlJLdUM2TGVNeEpOMEdnQ2FPVmRuSEE5SHRX?=
 =?utf-8?B?b0FoVjhvcVlrNFpOd3VFYXQ4b00yVWhZYVVwZ2h2UmdFaTVVem0yMkRLZzFs?=
 =?utf-8?B?ZkNNa0Y4TXlFZjloUnRFRGVqcjh3T29kUU9Qb0FUcnBlaUhaZWxLMFRWeWZJ?=
 =?utf-8?Q?3Fc+L3CPyS+BsP3U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc14a48b-70b6-4559-5983-08dec5fbe4d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:51:22.1681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Z0T3qlohHo7/owqKIzQopRAVmSLnd5YsMIaX0nnzXFBGqSsdqvAH+dkCTS5ylLbRrqtdO9NL6yPdwNvTWTQYFD2UBLsbzHRofqPTq8XcQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR03MB587508
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

Hi Judith,

Thank you for the update.

On 6/8/2026 8:49 PM, Judith Mendez wrote:
> Hi Tanmay,
>
> On 5/29/26 12:21 PM, Kathpalia, Tanmay wrote:
>> Hi Judith,
>>
>> Thank you for the information. Let me share my analysis based on
>> what you have described.
>>
>> On 5/28/2026 4:52 AM, Judith Mendez wrote:
>>> Hi Kathpalia,
>>>
>>> On 5/16/26 6:44 AM, Kathpalia, Tanmay wrote:
>>>> Hi Peng,
>>>> Thank you for reviewing and for the detailed feedback. Apologies for
>>>> the resend — my previous reply had an incorrect timestamp due to a
>>>> timezone misconfiguration, which caused it to appear out of order in
>>>> the thread.
>>>>
>>>> On 5/16/2026 3:14 PM, Peng Fan wrote:
>>>>> Revisit this patch, since it break one board [1].
>>>>>
>>>>> [1] https://lore.kernel.org/all/52ec8007-ce50-4f12- 
>>>>> b796-4b8c2aa1822e@ti.com/
>>>>>
>>>>> On Tue, Oct 21, 2025 at 01:45:26PM -0700, Tanmay Kathpalia wrote:
>>>>>> Some boards have SD card connectors where the power rail cannot 
>>>>>> be switched
>>>>>> off by the driver. However there are various circumstances when a 
>>>>>> card
>>>>>> might be re-initialized, such as after system resume, warm 
>>>>>> re-boot, or
>>>>>> error handling. However, a UHS card will continue to use 1.8V 
>>>>>> signaling
>>>>>> unless it is power cycled.
>>>>>>
>>>>>> If the card has not been power cycled, it may still be using 1.8V
>>>>>> signaling. According to the SD spec., the Bus Speed Mode 
>>>>>> (function group 1)
>>>>>> bits 2 to 4 are zero if the card is initialized at 3.3V signal 
>>>>>> level. Thus
>>>>>> they can be used to determine if the card has already switched to 
>>>>>> 1.8V
>>>>>> signaling. Detect that situation and try to initialize a UHS-I 
>>>>>> (1.8V)
>>>>>> transfer mode.
>>>>>>
>>>>>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>>>>> ---
>>>>>> drivers/mmc/mmc.c | 55 
>>>>>> ++++++++++++++++++++++++++++++++++++++---------
>>>>>> include/mmc.h     |  3 +++
>>>>>> 2 files changed, 48 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>>>>>> index ec61ed92e86..e1f62a5d0ad 100644
>>>>>> --- a/drivers/mmc/mmc.c
>>>>>> +++ b/drivers/mmc/mmc.c
>>>>>> @@ -643,6 +643,19 @@ static int mmc_switch_voltage(struct mmc 
>>>>>> *mmc, int signal_voltage)
>>>>>>
>>>>>>     return 0;
>>>>>> }
>>>>>> +
>>>>>> +static bool mmc_sd_card_using_v18(struct mmc *mmc)
>>>>>> +{
>>>>>> +    /*
>>>>>> +     * According to the SD spec., the Bus Speed Mode (function 
>>>>>> group 1) bits
>>>>>> +     * 2 to 4 are zero if the card is initialized at 3.3V signal 
>>>>>> level. Thus
>>>>>> +     * they can be used to determine if the card has already 
>>>>>> switched to
>>>>>> +     * 1.8V signaling.
>>>>>> +     */
>>>>>> +    bool volt = mmc->sd3_bus_mode &
>>>>>> +           (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | 
>>>>>> SD_MODE_UHS_DDR50);
>>>>> This is wrong.
>>>>> sd3_bus_mode is sd supported bits, not the current running bits.
>>>>>
>>>>> To detect the sd card running bits, need to use:
>>>>> (__be32_to_cpu(switch_status[4]) >> 24) & 0xF
>>>>
>>>> You are correct that sd3_bus_mode stores the supported bits - as 
>>>> can be
>>>> seen in sd_get_capabilities() where it is filled from the CMD6 status
>>>> response:
>>>>
>>>>      mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>>>>
>>>> However, the intent here is not to read the currently active function
>>>> code, but to use the supported bits as a proxy for the signaling 
>>>> voltage
>>>> level.
>>>>
>>>> According to the SD Physical Layer Simplified Specification v9.0,
>>>> Section 4.3.10.4 (Switch Function Command, CMD6): the UHS-I speed 
>>>> modes
>>>> SDR50, SDR104, and DDR50 (function group 1 bits 2–4) are only 
>>>> available
>>>> when the card is operating at 1.8V signaling. When the card is
>>>> initialized at 3.3V, those bits read as zero. Therefore, if any of 
>>>> bits
>>>> 2-4 are set in the supported field, we can safely infer the card is a
>>>> UHS-I card and, when not power cycled, retains 1.8V signaling.
>>>>
>>>> Using switch_status[4] to read the currently active function would
>>>> actually NOT work for this scenario. After a warm reboot, the card
>>>> receives CMD0 (GO_IDLE_STATE), which resets the card's selected 
>>>> function
>>>> back to 0 (SDR12/default) — even though the 1.8V signaling level is
>>>> retained. So switch_status[4] would always return 0 in this path,
>>>> making it unsuitable as a 1.8V indicator here.
>>>>
>>>>>> +    return volt;
>>>>>> +}
>>>>>> #endif
>>>>>>
>>>>>> static int sd_send_op_cond(struct mmc *mmc, bool uhs_en)
>>>>>> @@ -1369,9 +1382,6 @@ static int sd_get_capabilities(struct mmc 
>>>>>> *mmc)
>>>>>>     ALLOC_CACHE_ALIGN_BUFFER(__be32, switch_status, 16);
>>>>>>     struct mmc_data data;
>>>>>>     int timeout;
>>>>>> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>>>>> -    u32 sd3_bus_mode;
>>>>>> -#endif
>>>>>>
>>>>>>     mmc->card_caps = MMC_MODE_1BIT | MMC_CAP(MMC_LEGACY);
>>>>>>
>>>>>> @@ -1451,16 +1461,16 @@ static int sd_get_capabilities(struct mmc 
>>>>>> *mmc)
>>>>>>     if (mmc->version < SD_VERSION_3)
>>>>>>         return 0;
>>>>>>
>>>>>> -    sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>>>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR104)
>>>>>> +    mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 
>>>>>> 0x1f;
>>>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR104)
>>>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR104);
>>>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR50)
>>>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR50)
>>>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR50);
>>>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR25)
>>>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR25)
>>>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR25);
>>>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR12)
>>>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR12)
>>>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR12);
>>>>>> -    if (sd3_bus_mode & SD_MODE_UHS_DDR50)
>>>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_DDR50)
>>>>>>         mmc->card_caps |= MMC_CAP(UHS_DDR50);
>>>>>> #endif
>>>>>>
>>>>>> @@ -1830,7 +1840,11 @@ static int sd_select_mode_and_width(struct 
>>>>>> mmc *mmc, uint card_caps)
>>>>>>     uint widths[] = {MMC_MODE_4BIT, MMC_MODE_1BIT};
>>>>>>     const struct mode_width_tuning *mwt;
>>>>>> #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>>>>> -    bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false;
>>>>>> +    /*
>>>>>> +     * Enable UHS mode if the card advertises 1.8V support (S18R 
>>>>>> in OCR)
>>>>>> +     * or is already operating at 1.8V signaling.
>>>>>> +     */
>>>>>> +    bool uhs_en = (mmc->ocr & OCR_S18R) || 
>>>>>> mmc_sd_card_using_v18(mmc);
>>>>> In theory,
>>>>>
>>>>> bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false; is correct.
>>>>>
>>>>> OCR (including S18R/S18A) only reflects voltage switch negotiation
>>>>> capability and intent, not the current signaling voltage. So your 
>>>>> sd card
>>>>> should have OCR_S18R returned per my understanding.
>>>>
>>>> I think there is a gap in understanding here. The scenario this patch
>>>> targets is warm reboot or system resume - the card was never power 
>>>> cycled,
>>>> so it is still operating at 1.8V signaling.
>>>>
>>>> In that situation, when ACMD41 is re-issued, the card will NOT assert
>>>> S18A (Switching to 1.8V Accepted) in the OCR response, because the
>>>> voltage negotiation already happened in the previous session and 
>>>> the card
>>>> has no need to re-negotiate. Per the SD Physical Layer Simplified
>>>> Specification v9.0, S18A is set only during the initial 1.8V request
>>>> handshake. A card already running at 1.8V will not set S18A again on a
>>>> subsequent ACMD41 after warm reset.
>>>>
>>>> This is exactly the corner case: OCR_S18R/S18A will be zero, yet 
>>>> the card
>>>> is already at 1.8V. The existing code misses this entirely.
>>>>
>>>>>> #else
>>>>>>     bool uhs_en = false;
>>>>>> #endif
>>>>>> @@ -2701,6 +2715,27 @@ static int mmc_startup(struct mmc *mmc)
>>>>>>         err = sd_get_capabilities(mmc);
>>>>>>         if (err)
>>>>>>             return err;
>>>>>> +
>>>>>> +#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>>>>> +        /*
>>>>>> +         * If the card has already switched to 1.8V signaling, then
>>>>>> +         * set the signal voltage to 1.8V.
>>>>>> +         */
>>>>>> +        if (mmc_sd_card_using_v18(mmc)) {
>>>>> To switch voltage, ACMD41 is required, see mmc_switch_voltage.
>>>>> Forcing switch to 1.8 here has some risk.
>>>>
>>>> Agreed - ACMD41 is required to initiate a voltage switch on a card 
>>>> that is
>>>> currently at 3.3V. However, in this path the card has already 
>>>> completed
>>>> the voltage switch in a prior session and is still running at 1.8V. 
>>>> There
>>>> is no card-side voltage transition happening; only the host controller
>>>> needs to be reconfigured to match the 1.8V signaling level the card
>>>> retained. Sending ACMD41 again in this context would be incorrect, 
>>>> as the
>>>> card is not in a state to re-negotiate voltage.
>>>>
>>>>>> +            /*
>>>>>> +             * During a signal voltage level switch, the clock 
>>>>>> must be gated
>>>>>> +             * for 5 ms according to the SD spec.
>>>>>> +             */
>>>>>> +            mmc_set_clock(mmc, mmc->clock, MMC_CLK_DISABLE);
>>>>>> +            err = mmc_set_signal_voltage(mmc, 
>>>>>> MMC_SIGNAL_VOLTAGE_180);
>>>>>> +            if (err)
>>>>>> +                return err;
>>>>>> +            /* Keep clock gated for at least 10 ms, though spec 
>>>>>> only says 5 ms */
>>>>>> +            mdelay(10);
>>>>>> +            mmc_set_clock(mmc, mmc->clock, MMC_CLK_ENABLE);
>>>>>> +        }
>>>>>> +#endif
>>>>> A proper redesign is required. So I am going to revert this patch.
>>>>>
>>>>
>>>> I would respectfully ask to reconsider before reverting. This patch is
>>>> specifically targeted at the warm reboot / system resume / error 
>>>> recovery
>>>> scenario where the card is not power cycled. The check in
>>>> mmc_sd_card_using_v18() acts as a guard - it only triggers when the
>>>> card is already at 1.8V and the normal OCR path did not catch it. On
>>>> a cold boot with a fresh 3.3V card, the UHS supported bits will be 
>>>> zero
>>>> and this path is never entered, so it cannot regress cold-boot 
>>>> behavior
>>>> for any board.
>>>>
>>>> Regarding the reported regression [1], Judith mentioned that he will
>>>> debug once he is back. If possible, let us wait for him to conclude
>>>> before deciding to revert.
>>>
>>> So I started looking at this. So far, I have found that on AM65 u-boot,
>>> we had been enumerating to SDR104 mode once during boot and finally
>>> resolve to HS mode right before loading the kernel.
>>
>> This seems to be the root of the issue. Entering SDR104 mode transitions
>> the SD card, the IO signal lines, and the host controller all to 1.8V 
>> signaling.
>> Once that transition happens, attempting to switch back to HS mode 
>> (which
>> requires 3.3V) is not possible without a full power cycle of the card.
>>
>> This is explicitly stated in the SD Physical Layer Simplified 
>> Specification,
>> Section "UHS-I Bus Speed Modes Selection Sequence":
>>
>>    "Once the card enters 1.8V signaling mode, the card cannot be 
>> switched
>>     to SPI mode or 3.3V signaling without power cycle. If the card 
>> receives
>>     CMD0, card returns to Idle state but still works with SDR12 timing."
>>
>> So the failure you are seeing is not introduced by my patch — the card
>> was already non-recoverable to 3.3V from the moment it entered SDR104
>> earlier in the boot.
>
> I agree there is an issue with this board, but still this implementation
> breaks am65 further and causes mmc_init failure now.

Understood. To clarify my position: I believe what the patch has done is
surface a pre-existing condition - the card being at 1.8V signaling after
a prior boot - rather than introduce a new failure. The mmc_init failure
is a consequence of that state not being handled correctly downstream, not
of the 1.8V detection itself.

>
>>
>>>
>>> Also, sd3_bus_mode=0x1f at u-boot stage.
>>
>> This confirms the card was already operating in 1.8V signaling when your
>> debug point was reached. For reference, on a fresh cold boot at 3.3V, 
>> the
>> CMD6 available functions table shows sd3_bus_mode should read 0x07
>> (only SDR12/SDR25/HS bits set). The value 0x1f means bits for SDR50,
>> SDR104, and DDR50 are also set, which per the spec only happens when the
>> card is initialized at 1.8V signaling. This is exactly what
>> mmc_sd_card_using_v18() is designed to detect.
>>
>>>
>>> Something weird: from the schematics, its does not seem like the IOs 
>>> are
>>> switching to 1.8V with on board hardware PMIC.
>>
>> This is worth investigating further. If the IO lines are confirmed to be
>> stuck at 3.3V while the card is operating at 1.8V signaling, that would
>> itself be a pre-existing hardware or driver issue — the IO voltage 
>> and the
>> card signaling voltage must always be in sync. I would suggest:
>>
>> 1. Verify the voltage regulator driving the IO lines (Vccq) and confirm
>> whether am654_sdhci_set_ios_post correctly switches it to 1.8V when
>> UHS modes are selected. If Vccq is not switching, that is a separate
>> bug in the am654 driver or the regulator configuration.
>>
>> 2. Try using UHS_SDR12 or UHS_SDR25 as the operating mode instead
>> of HS. Since the card has already transitioned to 1.8V, the UHS-I modes
>> are the correct and spec-compliant modes to use. Running HS mode at
>> 1.8V is not a valid combination.
>
> Ok So, I dug further and found that AM65 also has an internal LDO, so
> Host side voltage switch happens with V1p8 bit. It switches voltage
> as expected.

So to confirm my understanding: you have verified both (1)
the IO signal lines are switching to 1.8V via the internal LDO, and (2)
the host controller registers are being configured for 1.8V signaling.
With both of those confirmed, the next question would be whether the mode
selected after the voltage switch is a valid UHS-I mode - as running
MMC_LEGACY at 1.8V is not a legal combination and would explain the
subsequent failure.

>
>>
>>>
>>> It seems like the call stack has changed where previously
>>> uhs_en=0 in u-boot and now with your commit uhs_en=1, right before
>>> loading the kernel. 
>>
>> Correct. Previously, even though the card was operating at 1.8V (as
>> evidenced by sd3_bus_mode=0x1f), the code was not checking the card's
>> function group 1 to detect this. So the host stayed at 3.3V while the
>> card was at 1.8V — an incorrect but silently failing combination on
>> platforms where the mismatch happens to be tolerated.
>>
>> With the patch, we correctly detect the 1.8V state and instruct the host
>> to match. The subsequent failure you observe is because the host-side
>> IO voltage switch (Vccq) appears to not be working.
>
> Wrong info here from my part, voltage switch does happen.
>
>>
>>> After this, we call am654_sdhci_set_ios_post
>>> multiple times at mode=0 & signal_voltage=0x2 until mmc_init failure.
>>
>> mode=0 corresponds to MMC_LEGACY, which is a 3.3V mode. Having
>> signal_voltage=0x2 (1.8V) alongside MMC_LEGACY is not a valid
>> combination. This suggests the mode selection logic is landing on
>> MMC_LEGACY while the voltage has already been switched to 1.8V, which
>> will always fail. The fix should be to ensure the card operates in a
>> UHS-I mode when at 1.8V, not fall back to MMC_LEGACY.
>>
>>>
>>> I realize this is not the most stable platform and there could
>>> be hardware issues for SD. Perhaps it is a good idea to create
>>> a quirk to skip over this section for these kinds of platforms?
>>
>> I would prefer to avoid a quirk at this stage, as the underlying 
>> behavior
>> — the card being at 1.8V after a prior boot — is spec-compliant and
>> real. A quirk would just mask the issue on AM65 rather than fix the 
>> actual
>> IO voltage switching problem.
>>
>>>
>>> What are your thoughts? I will continue on this debug
>>> and come back if I find more useful information.
>>>
>>> ~ Judith
>>>
>>
>> Hope this helps, looking forward to your further findings.
>>
>
> Sorry for my late response, I had to drop this debug for a while and
> actually will not be able to return to this debug in a week or two.
>
> I found something interesting while debugging on SD card reset line,
> but I am tracking down different am65 board versions to further
> investigate this. Ill let you know if I find anything. Meanwhile,
> if you would like to sync offline on anything, feel free to ping my
> email address.

No worries at all - priorities shift and that is completely understood.
Testing across different AM65 board versions sounds like a right step
and could help isolate whether this is board-revision-specific. I agree
syncing offline would be the most efficient way to root cause this together
rather than going back and forth over email. Let us plan a sync once you
are back on this debug.

Regards,
Tanmay

