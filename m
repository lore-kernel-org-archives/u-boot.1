Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEC7CD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FF083FEE;
	Mon, 18 May 2026 10:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tyez7Tns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560E084119; Mon, 18 May 2026 10:55:50 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43CF83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNZwjKJg1yQjQ+hCD7Q57oCLKXIN7/QEyHeLG4qhGf9aCksJ2BbgURpiaIbn7zFtTW3+f1o7PX+OgN0r8Azlu3a88DNh8cF16Em/i3Fr7i1wU6SUgQ+jF7pnk8L8p/DK4Tj3sxadxxOndUM/LPSbWQRpL1yOrgNM6xonkZi+BMXZFkAX8oFdvpaIzpUvQh85NhOQxucND3Ufv4P2RAw/xw2ZeA2+Nv93PMOiYeBcyvLVajVVPzkA3EDA3I0x36KXs9A713f1DhBH/yEm9/FCLLVNUP7i9HMCflaeyU3yZ/ykA5m8HeAmVBRj5Z2llB9zz+nAgY5J9YEp5r9CcAwuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqo2UAxeOfILUnRMSUacR9sMATuqk0oV6KTCtFSl1iA=;
 b=ETsSxc+vdl1mVtfEwfOFyAUcKsYsr5TRj8gSLpHEgVIczSEMHeRyYYSPmzSs8DTc5SBTKOe7IKfFAkUrnynj+EK1QH3qqJ5iY5DFsgKZNVfkcQkfCZiBm0A0/gL+MDNRlOdEptvC9KWRxXGq/nx6vhcjdlSH9VWbUrl8W/VVs+Du/FoR0rFdvtGemxR2vK2CRGbibK3bLyEo3jI+QwKq8CNa8de9eGK9fxpL9WNnXVFoshwg6ekfla1S1739+OTGPxv9BaOtogcz9Te7QmJQUJj4IQ2+CaBFY5kb3c1+QvE7sw7pSIy2Q8ORM0BKpZH6xOLxKbRTBowo/SoSMihYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqo2UAxeOfILUnRMSUacR9sMATuqk0oV6KTCtFSl1iA=;
 b=Tyez7Tnsdsk5DhwfHN7+XkVOQQljBVaST8zT9qGBcersWjigbK9/ohmSG1w6IUmye7ChV0IlQ2DiC5x0zIL/Bpf5hmxt35+o6W2YYGEYV62gjoYN33FJW/lapSiiPrp3DWyv1aIivvyLggX0R+jEa+zLFECLAVo4Jsz55tF+Bnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Mon, 18 May
 2026 08:55:44 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 08:55:44 +0000
Message-ID: <46705f94-6cef-4016-ab05-7839514e9257@amd.com>
Date: Mon, 18 May 2026 10:55:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: AI-assisted review
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAFLszTjnL6rn_mTA+jhcrRLF0yEtN4FVwTeGGy9GeGbgdB9fYw@mail.gmail.com>
 <20260515220758.GM1858239@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260515220758.GM1858239@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 514aba01-511c-4300-8199-08deb4bb3eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: lokdMzCPdjwh4+nrYUdX1gt3Dncueg8LNFiIwVia93qWQxeUIEXRIX2g9RSPHEM9RM89gA1Ddlm67ANfAEBNHu75ybx/GlsRE5sEUh+NRGcclQyPYvN9wNCCD82MDZ80sgTsZaT6ZV712314JSD2KQ/PFWkwekKO/wy+kwEFc+al9zQlMCFVnMKoZmHoSwD71JB+YuETvg5Pa6/alEqHDKE0gaUY/Eik8h/GoH1ABmSirUSZvp6EXa9hjdbbL9jkAFIUMVBGTt10yJxy/7/OO9wl7Y7Q0M7RrLTkEndlTBOouU9cZETH2TxBVCkoLIlXPaDUKjO9FpHE0Wq1ehYn2ETIDHjYn8/It+OsTTrNOBemo9nEZHgY/kzJbhmfa1+1WGNmRwibX1W8KLGNjRebjFZ0PLI3hGAVtayJBn3Scuw4du1nWLXNVT5TasAmqBPZ/lfKv877hC0SRfX8JjWBZG4gQhbwRrmbS43Oml5gJcqPC2rM+dnlz2p0S0D11ud0u/aqvz1/He1Xoto/O+8KNwJ3N80qSirx2KskNOQ/khH5XIYnYLIC1B/uby0gLwn1tjVDwCIDcF0ARmeas10vpGrTkR2HE53dU5Nfls9ub7WJ2ftZLR4gkMOn98C/cGVhifQLXzd29ivB2jEe2ckSL1Vrcj6A8vHUFVun2LgSyIaiwF/ERMgWxq5ECE7LTURCGDAOniNM5+vWLh1wumTB2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWdJWUFwdjVhY3poS1VoSG04OEpHK0NKSEs2ZGdBeG5RbWVvajRpbDBQZXBa?=
 =?utf-8?B?ZXpHakMzSDFCQXZOYlZUYisyNEJDSGlkVGhJQ0w2QTI3S3lGOC9qNDJueFFa?=
 =?utf-8?B?MndvVGFsT2ZpMmlYNXFVbmhpWTFMUEhtM2F5bG9hakM4OVZQYmM4ZWxLTDJ2?=
 =?utf-8?B?NDRobWpNUi9ReGgyaEw2OXE5RHpyRUJiclN3N3I5NVJ3ZVlvOUFROXowdE9B?=
 =?utf-8?B?UGRmTGlJb3QvRTh2MUpLQXpzdkdrcFZPNnBncjZaMnhvUG1zUmMrWjBsdGVZ?=
 =?utf-8?B?Q2pVcHEwTnZXVXBDanJBYUt3RXJlWjFLUjY3UGpCYjZrZEI5dmovM3NadEdr?=
 =?utf-8?B?L0ZLeGIrTzlvVHZPOVhSZmhBT3NlMS8wdHJhZUEzRVd1eFFsUWd6QXNGNnpL?=
 =?utf-8?B?WnI0dUdQL0FCd05tWmJicnptQ24vUDJlcEhYTC8rSzJZTWlsbUs5blpHT3l0?=
 =?utf-8?B?cUR0Tmw3Zmh3NTRWRHFZZ0JkbnNNNGZPdW5JcWtkakJ1QXMyMnRaY2hmdDFU?=
 =?utf-8?B?eXEzcnBiU05SWXBjWkh5YVRzRldxVEdtcWRkK3l0OXVTd3ovVVFYOG9rZjY0?=
 =?utf-8?B?T1JyWnJaWWhJRHlaSzVxYVhVWmRKajVnWmtRdE1GbEZKNlp1eVlXSm1IY1dW?=
 =?utf-8?B?NE5kaFdWb2hnd3ZqOFdEL1FwVGVQSG9zcnhNd1ZCSTdQcE11MTJ3cUZqY0d0?=
 =?utf-8?B?RUY1QVJLVnVMa1hVZWU0WEZGcXJKZ0M1cDRPaDd5dER4TGxWeXpFbENXSTRs?=
 =?utf-8?B?L0hHekM0anFHUGs3dGd4c3U4WFU5ZGpRdmZHeUk0WklHWWJZZUZCdzcxaXg3?=
 =?utf-8?B?SzdibzE5QkVqakFOY0VEMDA5TUNpNkZid2NNYnhMcUdqQmNiYzJxeVVmc0ZO?=
 =?utf-8?B?aG1pTmo5UktFVG42ZmZ3TjdHeTRLWFhYbDU0RFE3SUw2RDRKNWpwaUtORHYy?=
 =?utf-8?B?SUhadlc0U29tSXEvUTZwVUxoV2V4MWRqMHl5UU5SU3FyYUVsZk84WUlqS3VY?=
 =?utf-8?B?OGtFOXRocEg0RGZPN0RYK0lkV0JZbDZIWEUvTjVzZVFMeTI1UXV4cXZrNkJO?=
 =?utf-8?B?YVdlWTRJSVFueE81aHJHTHVpMHB2diswYm41QnFuRDhJM1ZQSXlGSDVNMCsr?=
 =?utf-8?B?T2YxWVlQaWxMU2VuS2dMTjkzdUVlbXBOKzg4aXQvTjVMV1B5YitqdU5SdFFv?=
 =?utf-8?B?TVo2N2dHL0xoVktxV2JWdUxQSTNEaVRsdVJEbUF2WUNsL3NVTUNzKzdlOWk2?=
 =?utf-8?B?ZGF6RmNNNnZRYUhGU3A3djQ2Q3NFdDRrdkU3ekZxdWJjOVlqVklmNmprTWRK?=
 =?utf-8?B?azJPaFE5RUlQM1JkVHA5blpQZmY1TWdXZ2loSnBRa1Y4TmpidWlEUG5WQ2x5?=
 =?utf-8?B?YWtiNkVOREpVUDJ2NUpXdXArQmEyN3R4aHVWR01ScXl2dmZTRG5sRnl2UWlk?=
 =?utf-8?B?NFU5M0hFT1dYVS9wS3FlR2hwcEVOcTlURGJxSEZzbWc0cTZTR3J1WDJLdnZW?=
 =?utf-8?B?VWY4VkdnSmVLL2xjb1hXUlpSRTkxbWZ5V2ZwcnE3c1hlTXZLa0R6YjlBN2Fm?=
 =?utf-8?B?b2JwQUcvQVhVb3hPbWxlZ0pjUHg4SUZaVkJZbWMwL21adHhhcjM4SmFqY0do?=
 =?utf-8?B?bzdNdGV2ZlhwZWowL0FLNWRvaURrTmhmc05WTFN0d3p5RHhEZGlpY01kQmtM?=
 =?utf-8?B?NkVtL2JoQnlFbFJvbmo4TlJpaFJGYVlUWWduK3NsN2RUM3NhMUN0dlU5SmdO?=
 =?utf-8?B?bEpxdWJSa3o4czc3U2N3U3JLVzRld2VUdUF6ZWdWbkhLNHdZNmVIeHR4bU9N?=
 =?utf-8?B?dkxXR2hUc04xVDhLNU9TbkxaMEI4dys2N1lxcmNqcDVjMmluQmsvL20rZEl2?=
 =?utf-8?B?YjJlbmE4Wjk3OEVEbTJFenRYcTJYbllSQkJiOE9WSW1Ndzhuajk5aVorMW1p?=
 =?utf-8?B?SzJzaTR2RGtqYzl1WGtYSlVwYjVhV2JNU3RPSzBrSi9XVC90SEFIK3BhUEN2?=
 =?utf-8?B?Sk5RTXBhMzcyc21xS1hXTUZxMW5uQ1VnbmZnNlBodms4WlFkWTdMaHNHVkRh?=
 =?utf-8?B?ZzNnbHJqcHc3aGcyRXVIcFgzazdsYWRUM3JXeHM3NFlJVlZ6MDk1OHdmRkpG?=
 =?utf-8?B?UnREWi8rNVVjdXJHUUF3OU52cmQ2SE81ZzYrQzJ6UDROR213a0VxNGRITlFt?=
 =?utf-8?B?Z3lRQzNhWUFiYmZHWUVOaEdWL3hhRmNVRjBaeVJSQmFmNWJBN2ZKMXM2VkV1?=
 =?utf-8?B?ZGRaL3NYVFJkRVdVbEIvb3RReEt0Nmszc1B5dzkxV29nTktnNHowcjMwVzRL?=
 =?utf-8?Q?V+8jYJvH76yRj+4L97?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514aba01-511c-4300-8199-08deb4bb3eea
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:55:44.1775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yInIEgDsObTVpNVg04mx61G6RleghdhAorYpPSbjWlfyBnftec3NL65AeeIaJu6t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461
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



On 5/16/26 00:07, Tom Rini wrote:
> On Fri, May 15, 2026 at 03:03:21PM -0600, Simon Glass wrote:
> 
>> Hi,
>>
>> There was a query on the call this week about whether I am doing
>> AI-assisted code review. As I said on the call: yes. Here is a brief
>> description of how it works.
>>
>> It is built into Patman (on the Concept tree) with a new 'patman
>> review' command. You give it the series name / number, or perhaps a
>> patch name/number and it applies the patches to a new branch, does a
>> review then adds its comments to its database.
>>
>> A '-d' flag can be used to create draft emails in Gmail (sorry, it
>> doesn't support other email programs yet). You then check and update
>> the emails and send them (or delete them). I am not an expert in
>> handling the 'user voice' part of AI, but have made an attempt to make
>> it follow any provided configuration, as well as to scan recent
>> reviews to actually create to create a voice.
>>
>> Obviously this is very rudimentary and could be expanded considerably.
>> But the mere fact that it creates draft emails is a win for me, even
>> if I ultimately delete or rewrite most of the comments. I can imagine
>> 10 different ways to improve it to be more useful.
>>
>> I wrote a blog post about it if you want more details, or you can ask me here.
>>
>> I am very interested in hearing how others are using these new tools
>> for code review.
> 
> And the big thing for now is that since we as a project do not yet have
> an AI policy aside from "please don't". One of the points I was making
> on the call is that there's a difference in value between "Human
> reviewed it, looks fine" and "Human spent some tokens, agent didn't see
> any problems".
> 
> And I know several other people have been doing at least first pass
> reviews with various agent-tools, it's just no one else has been posting
> reviews at your scale. And lessons learned from other projects is that
> the prompts are more important than whatever wrapper around the agent
> one is using.
> 

Don't think scale is the problem. Tool and integration is another topic.
I think at the end of day it is about rules and creating u-boot specific
review prompts as it is done for Linux.
https://github.com/masoncl/review-prompts

I don't think that make sense to host it out of u-boot repo because even
we have some rules written in documentation. And it is up to everybody if they 
want to use this agent/model or at the end if this is something what should run
as the part of CI or so. It is just about rules and extending that rules to 
cover common mistakes.
Because truth is that after that years with project we see the same issues again 
and again. Formatting issues, broken kernel-doc, headers, etc.

The first pass can be simply read current documentation and covert it to new 
U-Boot rules and start with it. This should generated solid base for start.

Thanks,
Michal
