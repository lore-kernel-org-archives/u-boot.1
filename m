Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0037C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 06:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3FC6882FE;
	Fri,  3 May 2024 08:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="1JmeX4IU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C4588321; Fri,  3 May 2024 08:10:09 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03AD882FA
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 08:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6VcsJEF0IefbJ+O4dNJQK2hrRBI4fI1KRFfMYo/ttkK5le3MKO/mnLyXNEmT7hSxhDb4PjzDEzSoELtyseSkhLOKYUhLF7ISYNMX8SfQkle1iH49j5rdJwADpWzEX62md7YiWOqth2FdEMc/I/SNfXZeq37LTrEttuRjrHumcwOoIku4EigqINZpQK2+YRX/K0ocSwr7WM9p/zLC4SxBNn/w4VtWaODsmkysEk5N8qJrV/Vz05L3M5d/0Daoz6f7BF1K3cRa+T8NM4IIDeCpSfjVO5P6dd2u0QjzpD4BJLoqq47yxmThs1h4aWtioF9LjO9EwBqCLW7XK/kL+895g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMD2FffkId1J4fGPgpRURuI/lzs6LbNEHPA9uo62GPk=;
 b=bAf/hapk2y2tPMdPCV7IkfIjypHpsFRIzhq86MWUNpYVqkOXcLgPg5e3MTU6L0URbhtlaaefZEg3E1ipZ9r58I8L0aB91roJiSP8HqNbWvAno7Qmr03ATxTxw0/IEHXQFtDMeE+4XnlfxKpSx7KR6R1m0i9iNsevY5bsRdfqwIZjffyS1OiH5VGlNpUdRg8aqQztBwo3krJ11LEeEGBWFkSx7RDn++3EFit6xnF0BuC1zCTFAVGWZO0LmXU86fu/xQIsoaM5Dqf1EMN3MsIImu2Md1emd99n/usbTOPaCdrpScltuMZMR16Y15fu+xujfHkU+SZGi+/3u5QvCW1XfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMD2FffkId1J4fGPgpRURuI/lzs6LbNEHPA9uo62GPk=;
 b=1JmeX4IUO27ScIRpLSLGcomicafIxbYSi+aKfyCWYCspI+xjMDRIs9srrjduQgVMX13fsH4xtRWqYKfCWleNGU4oGs/lM3BAPui/1ZV9EakZF5yWkORWmSF4LWk10ZN7pY47B5mSviHYVt77ny/yZn9+g1+tFEu4XsiJYBdF4t4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB6465.eurprd08.prod.outlook.com (2603:10a6:20b:365::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 06:10:05 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 06:10:05 +0000
Message-ID: <070937d2-ee25-4a63-a4fd-56a073353887@weidmueller.com>
Date: Fri, 3 May 2024 08:10:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Introduce spl_soc_init() for SoC specific
 initialization
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <20240327121153.2455126-1-lukas.funke-oss@weidmueller.com>
 <476510ce-8a1a-4ed1-ae98-04beb9c75607@amd.com>
 <3e51141e-6c0d-4955-a9dc-89d2c5e94279@amd.com>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <3e51141e-6c0d-4955-a9dc-89d2c5e94279@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::9) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 03171858-b360-4537-0b3f-08dc6b37ad48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWw4VHhmMzVHbzJEL2VuK0drNk94UTlsTHdpblBCTk5QbXNnemcvNnU3UWFG?=
 =?utf-8?B?cmNScXNOaUJaMXdkTzI1K1V5RkNibmJWWmtZQ2RKWEZNTkIraGdnb3pxK3VQ?=
 =?utf-8?B?UkIxeU5JcGpKNFAzclV6c3oyVWhPWjNEdnJVY2k2cHE5R1lBK2ZkS25zMGRi?=
 =?utf-8?B?UVhMZEJqdjJqa2MzTFl6dll3VnZwZHFEa3ptb3djTy9xNi8xYWFCblo5YTFk?=
 =?utf-8?B?VkFHWXlPRXdRUFNEZ1JLaHpvejdyMEk3NFRHVll5cWJkQUdZQllveDVTMit0?=
 =?utf-8?B?TnliM01POUxycjVPS2dzb3M2QS9tV1JtNnpHYW9ITVBsdHpuME9idTdscWRX?=
 =?utf-8?B?Q0FzeDF1QjBIclVjLzNzdGYyY3duUklkeC9IcjR6Ykp4RkRVdzdmdThBT2FI?=
 =?utf-8?B?SU4xN2ZCdkhTanRXdEpvdXliQlBpK09JclR2Mmc0OWVCSDBnd3hvdGhKcnVo?=
 =?utf-8?B?Qmx3Q3lEeUc3U3pHS0Zmbm5ObVZMTmVPTXQ3WmxxWFpHZUU5ZnhFL1I0ZnlG?=
 =?utf-8?B?cmgvNzdVbFh5TVFyczQ0NUlSNFRFZlJweUhtSENZMEVhaVF0YUpkRC9WZjUz?=
 =?utf-8?B?VFQ0RzMyRTdOekpuNkF5SlpDblJWcHR1bnBGNUtvYmc1eWhxNnJaMUV3TVhl?=
 =?utf-8?B?QmFzYnd1alJlNitpcURERitmbUM3ZnFPaXFuaXgxNFBpTXlqRFF6UStsaGtQ?=
 =?utf-8?B?RXExNThJendncTVnTWp4K3l6ODZaam9FNFRhQlVvTzFsRVJDQ1F3MElGcERo?=
 =?utf-8?B?SkhwbXliR1VwbUtFMFZuY1EzekhYYkM4RDM3ZStsNVVyK3N2bTVwZGtqVFhp?=
 =?utf-8?B?a3VlNmRnMk1xeUJIUWdBRWgwS3lzbWxJd2YxY3VDMStUb2x6VTl6WE5BK3RH?=
 =?utf-8?B?WnArdUY0OGxRbUNsaXVZODhZWUZVbnp2VGxkeTU4b2NMZDhscWVRT1Nma2VG?=
 =?utf-8?B?ZlBjY3dMTjZRT2E2alNLTWZQdStXekc3cjZHT2cvekxUZUIvYlA3MC85ODRq?=
 =?utf-8?B?Z0c4RkRhRGJTcnUwNDNtbWNFU3pwdzJRMC9kZ3h3ZzZkMi9OcWh3bjJSdmxK?=
 =?utf-8?B?RU9teGovRmtneU51emw4N3FyblVDbWdmMEhNeFRkNGxtaHdTMzhkRWdOWVlX?=
 =?utf-8?B?RzQyZUJ2UEorWnpLa1prc1hjaTc4VUxNWmdndTI4YmpKSGNJWkEzOXc1NzBM?=
 =?utf-8?B?Y2hZQ2FyNEo2K010aW1wVFhxK1dFbGR6dGtyTXJtM0dIblRQZWdzamd5VXlr?=
 =?utf-8?B?WkRudzU5d3BzU213S3dPVXNKbkRab3Y3b0J2dmR6b2tFaDdzODgyTTdBQ1FU?=
 =?utf-8?B?a3BEUjI4V2FZRG00VTVJeVVQZm13bmUzVGFVUTlpSms1ZkJSWDBWaE9Hdzho?=
 =?utf-8?B?bDVDSHFURXhBSkUvRjhTQ2hVVzd5SnNydTQwQzlFMlJtcmQ4bHlReHhlSFFZ?=
 =?utf-8?B?Y0Q2WWlzakNEY2c3RnBMcWd4aGtxeWh0VC9MT3YwOVpyK25pTmpHWTNWRElH?=
 =?utf-8?B?Q3NISG9qL3A1VlpqT3pXMGFnbXFjMXRHbkJ4aTBOMEpUcm1wMWhvWDRIR1p5?=
 =?utf-8?B?WHk3djY0Q3llUSttRTE2YXA1bldWWjdNK1FjYWpRM2JVOVdab3JDZjBFYjdV?=
 =?utf-8?B?S01FZkZhMXJnOVhJeldVNmRmTlMzcjVrM3BXYkUyU1JKOTJLbHdmNWkyTVI0?=
 =?utf-8?B?RzNjQXZyUjNPZ3pWcGc5KzJGY2p1OWt3OVZOcjVqVGJrcHhwck8yU29BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U043c3pVR1hjNVg0djg5a0RJeWZUditOaFJ5T3l2THlydFFRWkhuUGFMdmNN?=
 =?utf-8?B?cGtrenZkTm82c292SkxjNVd3eUJxZUsrUm45aFdVejg5aGVwZWVkQ0tCY2sz?=
 =?utf-8?B?eC95elRha1lVam1NY1VNcGg0dGkwYVJsck5ZSU1za0gxQzJYOVc0TUdPWHZn?=
 =?utf-8?B?WmhrSzBZUFY2V0laQmVkZWZLYThOcUVZMUJUZWRtR1grNzRGYjNJOHh6Rmd4?=
 =?utf-8?B?M3hVM3Uyb29BR0hzNVBYQ3I3OG9CeFFkNkp3ekdnUnFPdWl3ZlVRalhGL0pG?=
 =?utf-8?B?WnByNWxJdmxIUnQ5cHgxVmdyZG1ONmo1aDFQd3pDM21qYUJQa0czb1Fkbytv?=
 =?utf-8?B?Z0pQb2VYcVh1Z21nSlpCSzd0T1ZBd2dVZzFvLytNb2ZGWTloZ1FQdVVrOHpM?=
 =?utf-8?B?RjlXR3BEa2F4cnNjWWgwSHBGUTlLcHQrdzlUYS9mNHNXOXNweURHRWhyU1p0?=
 =?utf-8?B?M05MSzBCVnhlVDBGUDN5TTBFdEVraWV4ODdHMkhLRmMvZzVnQmFmQ2Z0U1Ru?=
 =?utf-8?B?SHdFVkhBQWJYQlhSVThPNm42d3c3cTg5OExwMnYrZmlJWGZTdzEzbDc5UEhj?=
 =?utf-8?B?b2xFdDlnTEgzci96Uk9pODJyY1hqVTJDd2tYcDcxbDNNTXBJQ3JLU0JqWkZz?=
 =?utf-8?B?ZFJKb0pWWjFtNHJHTGp0SHAvWEdjYkYxaFR0N1lMSGg2am5RaENOVVFSQy9G?=
 =?utf-8?B?YkJMRy9ZbkxvWnlyTkhVM2tlWjVLbERuZ0tzcnJ2UUI4RmhrMmV4cDRNREVp?=
 =?utf-8?B?VlVSZDhaenJrQjRBdFFuVlFSamtXcXBCaVdyTVVVbW5KdG5wQmY4VkZVTUVE?=
 =?utf-8?B?UWFpWlBQWXFZUkN2NlJQdEYydmFVOHNnWG5rb3lVLzJOeFQyMy9ESjdJL2hm?=
 =?utf-8?B?TzlXeUxVRS9MRU9wWVM5c1dkdU1vWEtuR3JFbEN2amk3ek8zSjdaaGRrSmd2?=
 =?utf-8?B?TUdsWS9rSUIvODhuTVlQaTdrb3NTMlExK2NSNkJBZ2JFZlBDN21FUkU0ZGxY?=
 =?utf-8?B?WEhGbTlzd1A3ckY4akxlenZhMGVRQjdKdHA1dElJWEsxRTdJeTR6UlJ4TC9h?=
 =?utf-8?B?UC8rRTlaY3Z0eTJhQjg2Qkd3elRvQUVBbWwwV2QvbjF6aDBZdE14V0RrOUY2?=
 =?utf-8?B?Mkx0WXkrdUFOYlpxeGhHd2xsZGNBMEJudEg5ODN2WlR4U2x6cGRnWFBEaGJ6?=
 =?utf-8?B?MlpMVmhaQWhiR3RpTVdzT1VPNE1CQTBxN1FldVNXMDN2MzZvVUpGVFRySXlq?=
 =?utf-8?B?bWlSLzFIMC9yc2VPTFltc0taUDB3TG9lUnZoYmpPcmFwMFNUYkNjajVDemMv?=
 =?utf-8?B?aW1ZMkZSdnd4N1Y0V3lzRGxyQTVJNVBkWjJ2emVMOFhHMU1BZjBUZkNrSnM0?=
 =?utf-8?B?NHZvZmtnWlNPUmxNYm9EeUJIT0Uzc3hKR2VIKzdhYTR1SG83T3BIazVWOFpo?=
 =?utf-8?B?K2x6RkkyTk5hVVZWOFdCZGpiek1ZeWpmRDUxRFE1V0FNOXdDcW5lNno0NnVj?=
 =?utf-8?B?NWkrYVZnYmR3SS9CVWxrclAyYWlJdFhtOUVYR2swQnFpZ052OFR3dkQ3MGdj?=
 =?utf-8?B?TEQyZEt4bklMdi9pYWx1QzRPWGpwOENqSEIvMkFMTXpTd3VvMXIvbEF2WVRK?=
 =?utf-8?B?VjFERVIvenFoRWNXQXlCdmZxYnZQU3Z0MU9nRWM5bnVXOWNFK1c5RzF5eDBo?=
 =?utf-8?B?My9GR3cvZ21KTyt0Ky90U3hlY1dDK2JsbkJwOVF0V1JkY01ibkYweVJTUzRL?=
 =?utf-8?B?UXNiS0l5Z1lwTUxNU2lVQ1dlL1FNMUNLbHJ2UXdkVlBkbnd0QTlDT01tdUNF?=
 =?utf-8?B?dUxnQmRHU3loV0QvUysweEtYSHVNT3JINmlkZFk1N3RmNWZYZWZUbTcwdUZC?=
 =?utf-8?B?OVZZYTQ2QmQxVmVWekIvZ1dFenIvem52UHNqbVdSMnFQdmlBUU5XNmxYaTFz?=
 =?utf-8?B?Y3cvNEozWWw5enZidEoyRS8xWG5aVVg2b2VrOU9iV2xjWExZTnBWcXlxTWl5?=
 =?utf-8?B?anZmenJCYy9mdjgvVjd5Q0lRN1BMWFJETW9veW8rR2U3QWxIdjJlbE82T2dS?=
 =?utf-8?B?a1E5Q1JBY1oxTnFyNElDeGZFVmtQdEF3cjYxL21GV0RjbHN0UHhCVmdranV6?=
 =?utf-8?B?VWpGZVlwYTJwRk9nbk5NU3ZZQXBQUkxkMzJwWjhLUHZZNDdRVEVJNXJXamlC?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03171858-b360-4537-0b3f-08dc6b37ad48
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 06:10:05.5279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXwrZtzHRsKveGz/XRFz0IeCbJFJkQp6j90FBIUdCDZdE6N7IhgtcHl3jprtkLB/B8AuZhcaxo45c+NMbRop3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6465
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

Hi Michal,

On 10.04.2024 09:06, Michal Simek wrote:
> Hi,
> 
> On 4/8/24 14:59, Michal Simek wrote:
>>
>>
>> On 3/27/24 13:11, lukas.funke-oss@weidmueller.com wrote:
>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>
>>>
>>> Currently some vendors use spl_board_init() for their SoC
>>> specific initialization. This prohibits board developers from adding
>>> board init code using said function. This series introduces a new
>>> function in order to separate SoC init code from board init code.
>>>
>>>
>>> Changes in v3:
>>>   - Rephrase Kconfig description and correct minor typo
>>>
>>> Changes in v2:
>>>   - Change spl_arch_init() to spl_soc_init()
>>>
>>> Lukas Funke (2):
>>>    spl: Introduce SoC specific init function
>>>    arm64: zynq(mp): Rename spl_board_init() to spl_soc_init()
>>>
>>>   arch/arm/Kconfig           | 4 ++--
>>>   arch/arm/mach-zynq/spl.c   | 4 ++--
>>>   arch/arm/mach-zynqmp/spl.c | 4 ++--
>>>   common/spl/Kconfig         | 7 +++++++
>>>   common/spl/spl.c           | 3 +++
>>>   include/spl.h              | 8 ++++++++
>>>   6 files changed, 24 insertions(+), 6 deletions(-)
>>>
>>
>> Applied.
> 
> Actually I need to drop these two patches.
> I pushed it to CI and got this error.
> 
> Building current source for 1 boards (1 thread, 32 jobs per thread)
>     riscv64:  +   sifive_unleashed
> +In file included from board/sifive/unleashed/spl.c:17:
> +include/asm/arch/spl.h:12:5: error: conflicting types for 
> 'spl_soc_init'; have 'int(void)'
> +   12 | int spl_soc_init(void);
> +      |     ^~~~~~~~~~~~
> +In file included from board/sifive/unleashed/spl.c:10:
> +include/spl.h:825:6: note: previous declaration of 'spl_soc_init' with 
> type 'void(void)'
> +  825 | void spl_soc_init(void);
> +      |      ^~~~~~~~~~~~
> +make[3]: *** [scripts/Makefile.build:257: 
> spl/board/sifive/unleashed/spl.o] Error 1
> +make[2]: *** [scripts/Makefile.spl:533: spl/board/sifive/unleashed] 
> Error 2
> +make[1]: *** [Makefile:2055: spl/u-boot-spl] Error 2
> +make: *** [Makefile:177: sub-make] Error 2
> 
> And it is valid because Risc-V guys are already using it.

The issue should be fixed on master. The function name was changed from 
spl_soc_init to spl_dram_init. The patch should apply now. Could you 
give it another try?


> 
> $ git grep spl_soc_init
> arch/arm/mach-zynq/spl.c:36:void spl_soc_init(void)
> arch/arm/mach-zynqmp/spl.c:61:void spl_soc_init(void)
> arch/riscv/cpu/fu540/spl.c:10:int spl_soc_init(void)
> arch/riscv/cpu/fu740/spl.c:13:int spl_soc_init(void)
> arch/riscv/cpu/jh7110/spl.c:31:int spl_soc_init(void)
> arch/riscv/include/asm/arch-fu540/spl.h:12:int spl_soc_init(void);
> arch/riscv/include/asm/arch-fu740/spl.h:12:int spl_soc_init(void);
> arch/riscv/include/asm/arch-jh7110/spl.h:10:int spl_soc_init(void);
> board/sifive/unleashed/spl.c:30:        ret = spl_soc_init();
> board/sifive/unmatched/spl.c:137:       ret = spl_soc_init();
> board/starfive/visionfive2/spl.c:214:   ret = spl_soc_init();
> common/spl/Kconfig:279:   spl_soc_init() from board_init_r(). This 
> function should be
> common/spl/spl.c:715:           spl_soc_init();
> include/spl.h:820: * spl_soc_init() - Do architecture-specific init in SPL
> include/spl.h:825:void spl_soc_init(void);
> 
> It means please take a look at it and send v4.
> 
> Thanks,
> Michal

Best regards
- Lukas


