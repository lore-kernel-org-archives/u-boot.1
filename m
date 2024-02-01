Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090B7C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 10:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FF0C874BA;
	Thu,  1 Feb 2024 11:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="MGD+l3qg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC3587C1F; Thu,  1 Feb 2024 11:18:14 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97093862DA
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 11:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPwKigGIE4A1zj2OUKyrz2spoGDkrw5kDbjd2LWJdhkUYsoC2rBEr5uz0srbKjWRqb5KAjTRqvT4psd7Dli8kVVm22nzzv7MBPJeQjU6Vv5TRpY2Q1qDVpZzgDX/cpdodiG1NyEKhUnA1w+TBXAFzaJXAHKlcupS+NccZw/w1xTIZ8DTuqlKIF0fGcWpcDxlAfCJcxxNTpK6YGQ/UqvwFueckDQLti31SctE+d3+bbAKJfTPOFPOsjYpsk3XjnLVfEY7Ix1eDyJpJqT+TnepusURs3G2EV1zJG5jCt4RNuomKiqCzK8pmfOM9L2Qp9EknJ+AQ0Q551LyfLqfhPFeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmPwRJjJ08UvQDcaJnF2qBxGfCkTQkkqDpTwIyth87E=;
 b=KAClkSpDtLPnDUpIIwS3VQcLMPpvS1PHD6dja1vIHBU1eN49fcfhXgOSIYUEw8FbF8D3zaDA4cRxQy4zZ9/xttscEsWr451wqGYemYAjVQsR/0ZQzFZdvs7EzEA5BZW14QN1MaESvZwlJgZR3Y1lyKFZWWFZhORGfFWvxxz6f2SYS/p3Wyp93Gg+vRkKg1i+VnkPzPUdPHH7aUimhf/GqetMfaMGyR63PxhrxDcnn5EAjZkGz9nQcU+7DiLedAgkl7WMHZNjZjkvjfkFuRZvHzykZD5/hS5XJvRwO9qj9C8Czaxyy4D6LJ38Kdw+LrAYl37/bcbWeheXlW/8qBo4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmPwRJjJ08UvQDcaJnF2qBxGfCkTQkkqDpTwIyth87E=;
 b=MGD+l3qg8gHSFj6PvjHx5AYnDs/lzhj38awF/NzbxLYHSZwxqANye1+UHaYR3/zdCVBoFY3zD9D+rHWdAjxk6QY7wrQWYBPeOMgNC+puYGDY4EztFd7/2hEZA+cbauHjPJcTgj0V0t3uHdLZPBKel4TLlhpX4elwLuPv4E/XCbvnVAnnNcqhRNcLVWqg/n7aNocTbM3Xl4tmy57V3G4+n4QUpSAHE6rXDQ2BSeng4J0hvoHm4f22+hU6uSovgCkPi6r3PhvLNkflEQsvWeIcM/OIzTOzxsiC9Y2+WkPLg98/D4hhkyZp+l2X6nl5rpn87zJxx5Edp4ZbxwdEYx6eqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB9929.eurprd04.prod.outlook.com (2603:10a6:800:1dc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Thu, 1 Feb
 2024 10:18:08 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.027; Thu, 1 Feb 2024
 10:18:08 +0000
Message-ID: <23d7337a-88b7-4dcb-be08-c42b21e9dbd1@theobroma-systems.com>
Date: Thu, 1 Feb 2024 11:18:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Andy Yan <andyshrk@163.com>,
 Tianling Shen <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Joshua Riek <jjriek@verizon.net>
References: <20240126232615.6826-1-jonas@kwiboo.se>
 <20240126232615.6826-2-jonas@kwiboo.se>
 <515157a9-8d19-42f9-ae6d-914aaea8a3ba@collabora.com>
 <e1417a87-15ee-4e1b-9513-c101a02118d4@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <e1417a87-15ee-4e1b-9513-c101a02118d4@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::7) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB9929:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b4d47e-0ab0-463c-6394-08dc230f1638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +okQYST9w8W/0BxYlETa11KOQVe1dygxOJMTM3nd1p0Q4GSZZKrd+mL9ueaoVCl52t/vbVMYDZN/B81T8JTEV6BxHQPxQHtGtnQILdwD05N7St/fDKzafTnAt07BxvmbD2OA4hsSkyzLxSxRBgMamu9vCVbBK3p3eVPLoz92cL8A0UmUZh+BVMEFDdfgocCoRcrKPL33IuS8Q3SJ40QNDpWehR1Uv+Ls/zjzHjxXqDQvaPvsS/dOGR4P1MfnOM4aDaj+FADWExNpBNUBrieqe3BTaoXV9z28DWJsPYgr3Y/12J/wW9RJKWnRcyjSmRP6Q8FgsEW8I36HnaEPbKr16DDeV1GI/f+hZWFQudpbNnvAHxlq454BXkFvSW/cQQ3Bct5VvEgoqhir6RMo3TH3Z5p9vGo7HOTUkC4c894OvxN93pYBUq7+OI4TZFQtIcSAzYysiQ+/WW1Fem/zIucng023vjgKN3roiZHIKSrAQq3/hVdny9FSO4GPWcmsCJVTDawU1GXsTKjQ1qjOeF8weS3LgrYcZ8pbP5cxutHQ6AY6fyqQxCChNJm9r+PPDtx7w0fUqF4n0CjSqoDThp0foWnVz+/fzQdWesnfEmvMNyC7xIf3O3jLVigiGieDs0kaH9q7WE+oggF+o0IK2tTk9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(366004)(396003)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(31696002)(36756003)(86362001)(6512007)(26005)(38100700002)(2616005)(53546011)(6486002)(2906002)(6506007)(478600001)(316002)(110136005)(4326008)(66476007)(54906003)(5660300002)(8676002)(66556008)(7416002)(44832011)(8936002)(6666004)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vy8vR3hPNHhDR0R1UG5XYTZhTVdlVDV1Qys1TDVXV0RxSEpzRUFrTDJ2VXRF?=
 =?utf-8?B?Q3VBallyTmxMRytoRnR3ZDhVWUVwTTdCbVhoKzRseGFhelczd0Nkc1I1ZExG?=
 =?utf-8?B?aG9zaDloUmNCVHZEdDZpWDZmMXJ6bHd2L2RuZDI1dXdRWEFMNG14WVA0ZVAv?=
 =?utf-8?B?RHVMRVd4a096RGs0RnNPcDE1bWhrRFcvRjJmaWY2dEg3MVBRamQxVjJDMVhs?=
 =?utf-8?B?VUFRcnpnaVo0Z0U0RUhqbEZObFNyQzJQU0x0RjZlSkk2Rm0rNU1XOVI5TDZP?=
 =?utf-8?B?MXVReDFRZVpEdHFGcWVGN1loRlVIR2NrWTc4dS9YUFpwNENNVG1wWUNPUWRl?=
 =?utf-8?B?b3h1bzd2WTJOaWRabGNKNmtWYTF5NWRVSU0ydkNoR1pIL1AxT080WjN3SW9s?=
 =?utf-8?B?eUVBVjJzV0xDVHRIUDFLQXJuK3VvdUNVK011clIvL3NJdXZ2eE1jaThJRjVL?=
 =?utf-8?B?Y2liVkdkdnFTeWNSUUxZeWFicFFadmozZmtzTnUxUWdPQ1JpNzhoTjZMZitY?=
 =?utf-8?B?d21WNUZjaE1LZHJ1N1JXRnBDRTltTW1Bd1NuZUNTcGdET21XVmhJTklCZnNH?=
 =?utf-8?B?alpsWjljOUtacHRVM1ZBVDg3cnZOdnhucysvdmNuNHRneFJ3TGpVSDJSN1Vv?=
 =?utf-8?B?ako4QUVZc04vOUwzb0FjZmJtN21pUkg0TTBGeGFXbUR5ZXBmR2x1NGpicTN2?=
 =?utf-8?B?ckkvUTFxUWtvSDlvUWpoZEZpV3VxejZpaVJkcmxsQUtLNFVRcVV4Q3JjRjhz?=
 =?utf-8?B?TUhJMFpxYkFoMHdJdUxKN1NiVlREWS93UTRVUFlCam9GNTVNZzhuNmNrVitL?=
 =?utf-8?B?L3JRUEpscTR1YWdnZTJYM2wrd0x5MHVXNEJTVC9vYnl3Rmh4TzBaQk5CQml1?=
 =?utf-8?B?YldyMkxha1BkK2ZYK2V0N0VXLzJIbVpkTWl1ZzVZM2ZwQnlsTzFwMkFkRlJF?=
 =?utf-8?B?ZHhkNmNFWi9GYnZsbzZFT2w3b2dxU25qZ0UwbWdOblRienNBbi9YenQrMnNH?=
 =?utf-8?B?ZHFCZUJxTnFrQlE4R1NSUVBqYVJXRldwS2w3ejh2WEEzWXUrejloSzhjZWxN?=
 =?utf-8?B?MFhmdTFKSWNVTkc4Z3ptZmFDb2poTUJxK2QzZUJnSXdQOWJUeHBlcU5jb0VJ?=
 =?utf-8?B?ZU5vU041Z3kycU1GUWtPcHBaVXNLUDhkZGJpekJQUStmT0FtT096QXFWQ1Fa?=
 =?utf-8?B?MDNMcGQwclN6NGdyWUJibDNXcmFMQXZjc2RkdkNab1pPbHdURW1hSTZNblF4?=
 =?utf-8?B?SGlraWpsQ3B1dW83Y0VsSVdDd0N4RkE5YVJ4OFlDNmZsWmdnM1JFTUF3MDNy?=
 =?utf-8?B?dmVxc21obURlUDVCQ21pcDF3dy9DaGpNbUwzSUY4alkxQ3BrQmlrMmtsZEtk?=
 =?utf-8?B?dUpRQjQranZ1cGNsY0VNOXdjN0c4WjN5c3QreElBR2RRYXZTa3RYU0N0eDhp?=
 =?utf-8?B?cmRRSytTOVRJK1F5MVR4dkJyNXVRM0xpMHZRamd4UVFOUlpSVVFIeU9QeGps?=
 =?utf-8?B?UjR1bWtEaHBPemt1bk00bjFMYjhGL214V0dDcVlEUVVFb2d6bmdLT3RYSkc1?=
 =?utf-8?B?RkRVRVpua25qUGVmaVBXMFNRaEwvUnZzWDJBMXNNdEpOMXc3ZGFkNk9BQ3pt?=
 =?utf-8?B?TmtweXBQWEFWdnJzSk9NTUs0TU1sQU9UbnBKS3N4SkpIa2MvRm1ZZ29zb2xG?=
 =?utf-8?B?UDFwNkdkQzgwa1JMWWtoZ0RHVEtSeTNTVkhtVGhhenJ4S1Y3bVNNOGJFQThT?=
 =?utf-8?B?bFQrY1ZxaFVQVTFxd1E5cVlSZU9kQkRBaHhka3FiejBxck16RjgvVXh6bXFI?=
 =?utf-8?B?NllKUXVkS2dwem1la2U4SzlsOGwzSWdHUkE2bDlPUmY3QkU2ck1sVzhZUi9S?=
 =?utf-8?B?M1cyVWJBbjd6WHJiNkVzenlBV1VGMzl1UlBIMVY2dm56MlYzd1JTaktDb0ZW?=
 =?utf-8?B?bTRLZGhMT2FNcHNRNFBndjBocTZuYUhYS1hGNFBCa3N3Q1JKSUpOUDdwcU54?=
 =?utf-8?B?d2RaTVFaakozZzBFK2FsS0xoanNQT1ZrbjMvTHlKMVhTRnBKMkxJaUp3UHk0?=
 =?utf-8?B?S2NoeXlTYTlTWi9rcVVXNlIweEFkZ1l3L0dlTVpYL2txbWJHWDNrbzR1VldL?=
 =?utf-8?B?RDZXWHozVG9ZdWhiait5T1dUK0VoakpPQ0FiWWMwcFRIVTd1N052Q0xYSzMr?=
 =?utf-8?Q?k7zCrv3C60+TVMbpaJqFLQY=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b4d47e-0ab0-463c-6394-08dc230f1638
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 10:18:08.5403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AS7KY6dSf1G/rl8Ogt9H+g61l+Ghwe0gXC3TRdkO/jo0ciitVMMDHnzTn+KR7G4Nx398b7kaf81VhMuNk1RJiAUJSC5pe+eD2izCv1LpUfUC7WeMhM/RdQDOYEp+OLWk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9929
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

On 1/27/24 12:15, Jonas Karlman wrote:
> Hi Eugen,
> 
> On 2024-01-27 04:48, Eugen Hristev wrote:
>> Hi Jonas,
>>
>>
>> On 1/27/24 01:26, Jonas Karlman wrote:
>>> Writing to eMMC using DDR52 mode does not work reliably or at all on
>>> RK356x and RK3588 boards.
>>>
>>
>>
>> This is related to the old issue I encountered last year with mmc write?
> 
> Yes, I think it is.
> 
> I did some testing on RK3566/RK3568/RK3588S/RK3588 boards with different
> eMMC modules with following result:
> 
> Read seem to work with all enabled modes:
> RK3566: MMC legacy, MMC High Speed (26MHz), MMC High Speed (52MHz),
>          MMC DDR52 (52MHz) and HS200 (200MHz)
> RK3568/RK3588S/RK3588: all above + HS400 (200MHz) and HS400ES (200MHz)
> 
> However, write had issues with some of the modes:
> MMC DDR52 (52MHz): all RK35xx
> HS400/HS400ES: only on RK3568 after changing hs400_txclk_tapnum to 8
> 
> HS200 seem to be the most stable write speed that worked on all SoCs.
> 
> So, dropping MMC DDR52 (52MHz) and enable use of HS200 (200MHz) seem to
> be the best option to get speedy and working read and write eMMC.
> 

1) we have this enabled on RK3588 Jaguar in upstream Linux... I may have 
improperly tested it then, would you mind sharing how you tested this 
mode on RK3588 so I can reproduce this and fix it on our product if 
we're impacted? I assume because we have HS200/HS400/HS400-ES enabled, 
DDR52 would never be used? (our eMMC is soldered and support the former 
modes).

2) Why are we not enabling HS400/HS400-ES for RK3588 boards? You seem to 
be saying there are issues with HS400/HS400-ES on RK3568 but you didn't 
mention the status for RK3588. Did I misunderstand the last sentence? 
Can you please rephrase in that case?

Cheers,
Quentin
