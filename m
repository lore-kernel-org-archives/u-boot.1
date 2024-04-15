Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A87C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 104C88814B;
	Mon, 15 Apr 2024 14:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tUkIy3Jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D56688189; Mon, 15 Apr 2024 14:46:04 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F082188089
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuXLFfiVgH/aVBEuBRokBB/OHEvzTqaOg4pfTIBovztSWXgRNxvGgCXpoayODVcaGcdCMjEB9U1d/xDsmAtCuCeT4kiD7RTt6BBnKWVZ+J0ppY6G6uDTs6CoP1pWiLCSzUf7vHuVn79s6E3es6TMxImnd7lcpV7TuD50U5kYtUM6bY8XUu08j4ngPR+50aaSwt2CAfpmseN21nD7AJm35Py6Fo0XnhdliSsocIQeNA5v2zG1Bvp7WNYoVFg9EI37Fuojk8/A8HHpl3ZT5+ScHE7KC57EENWEVt3QFzWyYdu/MchUk+hpnp968DzplUjLAVs6Rpg8Ypsk2dHXleEEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7hrdobd4y6h4Pf23px4A1h6adp/5qrZQl3O79MTy84=;
 b=XRdn03syEzB/pB1sLEjOWd8mG+B0W03Bo8P6oE/L4KCD4VAfFDFG0YF6vmrCJwNN2yKiG8dF8Gb0LdOtFkdI6P7enGoPDnPZMSu9wNNiZMx1WimoulTj5sw01i0RknO8mrkNZzkuKkhmHvfzsJ53msc5ZO3SHI/l70NOvU6DTITF/62qbQSYLWdyV53wRRSk0GFSB15NO4SYUCfGQBrxp4eCShCZoTgMd7QBlE/YzhW2YWqNvsMw79XLcXryu1rWzeo1UJk6GpdErHGEeUiUv4u8bnMrYCadlB+U/g6F0esH++uAGxqdexZek2zd8NwSyGPYmIDkpXb17O4/pRQRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7hrdobd4y6h4Pf23px4A1h6adp/5qrZQl3O79MTy84=;
 b=tUkIy3JlczZ5afYSCyL7bbGW0pNwbnVHIkCe2hU7ZEdywXfA16QRhLaivXgOScvSdJWbyNs6oooH7LA/jJcjnZGMOKmnt52Yyjg0N18D7tqrzaAExl/4HkJNXpavbcEC48tyaQFGfURH8bq2kD0GMOZP7USF5cAf8DToRjMPoi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:45:59 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.046; Mon, 15 Apr 2024
 12:45:59 +0000
Message-ID: <6ecd5cf3-f961-4a9b-a064-55648424780d@amd.com>
Date: Mon, 15 Apr 2024 14:45:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] Kconfig: Add missing quotes around source file
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>, Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jagan Teki
 <jagan@edgeble.ai>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tim Lunn <tim@feathertop.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, git@xilinx.com
References: <cover.1713180904.git.michal.simek@amd.com>
 <78064c48fd9297b43eae0abdec4783004ea74a07.1713180904.git.michal.simek@amd.com>
 <6812d5f7-54fb-459d-8fd1-d899af62d92d@gmx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6812d5f7-54fb-459d-8fd1-d899af62d92d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfdac76-c573-41cf-b6f5-08dc5d49ffe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSHnvQC2SSWOOYkGn0DIMnm9XDTzrpjON4xxdb435wTbKX6vWvA0AMWxQQ3nxuSTo8ozrLVImlGQC3NbISRou9DQn/DBxtPaoFICjSVAvVZ15FIdfq7x2PLLi57VOWp9a5QbduRtQXGI2PF7+j46hQDuOLFtR3An7SGRTpQRHykFdOPMxISr/p7jFDbxfD0WY3yZ8rlvVCiPL/OZ3tjPUdHOSGlkTUZn3kg/DnjehwQFwRy3zE26XkeSaXMpoUTPmulCqpUsh3Sn+cuBZIipBG7gLXCzvD19gD+Ei++k9dhdtLVEn6PuaOcs4tH2vY3kSRg9eIYonD/bhgLZVBxmUIhCZULLqQa/6Kdn8CSDF9u+Y4Jg0s0JUriu+jDP/Xgr4gF+MRgdO3Lzvg/G+GsyYlDvH2Zhksj++vcyfO6cdaWLeJMK7u2CbOIbGNO/wHxK06H8n09FlbTjHVeqw4vLKkZfsdvo3wutIXEiRFjAkY+XkxFLIF0piiejN/bQ+8YJ0pSXUX2GFa6ekldBTvgiEe1hfSCHlt3r3Wmop1/AhSk2Y8vtzQaD2mXqBdrHoKnFDsxF1BITUkaxKsiQWaY6jtOBErSXYxDy0rwxovlQ3rFsbvvupWgH+7ADxmBUyDoBWxH7AwN5RIET5+QOk3n8kiqPGcDGrz9yGkW/NS59QaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFneENLZjdXQnJubE1lRXZpU2JyWjBxWkZYaU05U3htcjl3bTRlQStKb0hV?=
 =?utf-8?B?TWt4MmtFb0ttUlF4WDdkT0pFclRhdmV6SFVGTWxNOXFUQWFyNWJNM0dQZVBs?=
 =?utf-8?B?QzNXeFE5Ry9NV05ZYUVpT3lyaUt4UVlPelhMdHYxcHhqb2pDT0VMdGpMN3Bi?=
 =?utf-8?B?dE9Ddi9DeEZWUngrSGlNRzVwU3RET1dFVmthK0lZZkRyZWwxcUxaWVJhTXdo?=
 =?utf-8?B?ZCtmN1pNbTdPN3hlcTlERDU5VllzbzRWZ0VIdWhSRmpVWXJHZ0FGdnNOQWZt?=
 =?utf-8?B?dTRralcrOUFKL3FOdmNTVkZpSU1FSzYrYWhaR040dVgveGcxb2IxdzdHZmV5?=
 =?utf-8?B?NGlYcFdUSllCbVpyUFFyYk0vRm5TcWt4UjdmQ2swVXRzVVNXM09nSXZaOXRm?=
 =?utf-8?B?cjdDY1FnTVV3VExBTkFMYkhMdEtWVkdIUGpSUC9KYno1VEFhUGxOaHRuc1lE?=
 =?utf-8?B?RjB4d3E3YnRNU2dxTHJUc0xualQ5K09WNm9YaEZQR2RKc29aNGZwN3pJNVdW?=
 =?utf-8?B?SlVKS2tJeUJBeGFQMmN3NFlyYUJxUzd5cVBPSjI4RkZTTGdKRkllOW1VcHVL?=
 =?utf-8?B?endpWlJoYUlSZFpEQlk4aVVKcjNtRjQ4QlBKZEpGS05DMkpqVlExc0MxUXRk?=
 =?utf-8?B?QlZOcC9hczhpM0NwU0FYbStqZ0trZWJ4ck9kNFUyTm9UM0QrczFFWGpoekds?=
 =?utf-8?B?KzBCNkF0SVRvQzE2N0tBRnRBRGlha0drSzVCTDV4bUp2dGhLenlQYmxYQ0d0?=
 =?utf-8?B?WjJ3bGE2NkJ4YVB1dHdUckJJeFRGWVd2eXk0R0V4TWNzTXJpN3R2TzhOU056?=
 =?utf-8?B?K2xna25reEowM0k2QlBxREVXU2M5Wi9JbDFsT08wTmtJTVZKOFEvdUlmVkRF?=
 =?utf-8?B?dWZmSTRaVnpZUmhSZjBCTDRKaDFBcmVOYTdmRDkzdEhzNFVmYjZKNE1TbzJK?=
 =?utf-8?B?SEthQzFaSC9wdlEzamM4YXBaMG1zY0w4SFJOMGthSW45NytKL3lIQ2lFVFZr?=
 =?utf-8?B?MERwbWxxZVM4UlhqTVRxdEdrbDZVR1lnN0RjdjlwYU9LcnN5Ri94ZHNsZ2I1?=
 =?utf-8?B?VWlDd1BhcnozL0FDRnB5RFV1MEE1QWFUb3F2N1BWL0VtOUp6WkdrdVFNQm1X?=
 =?utf-8?B?REorY3JRZFFsV29VYXZHdHpmaU5QTE5QTFVTQzZveHZRSURhZ0RmZ3VyQ2xx?=
 =?utf-8?B?SlZrMDFyeXpPSk13NG1VMnRkaEdvR0ZOTlltL2EvT2dHNzloOU8vTzQvdlE3?=
 =?utf-8?B?bjlhZXhlVmpTRVpGU09lUURnejFXTjN3RHQ2N2JuU05aSmFQV3ZMWFR3UHpm?=
 =?utf-8?B?cEZXaEl0Zi93UXdGSnlYTnl6ZTlLNVdHK0RrMVZHNlZXT20xU0NQVGg4a0tE?=
 =?utf-8?B?S0Q2bkVUOHdsT1VGTW1UdWpyOFE2VjdXUEFmRFJMZHJ4cDNRajR5VCtqNmlH?=
 =?utf-8?B?OUNZVWsxZ05VNXZKcjAwN1B5azVqV3huSXlHWGFobkxxTEVXTEJaeGQwTFFS?=
 =?utf-8?B?Ti9NL3Z5dURqMWY5a1VteG1ZQnRSRlB4a0N2bEo4SDF0dEgzRzMwWmFIVUNz?=
 =?utf-8?B?K0dNc05IbU5MYTJMOWR4NkdiMGt1Z3pOcXNxeWRBazZyOWJYbWxGV2MrWGMv?=
 =?utf-8?B?SmdaNVZIdGZaeE5YT3p5Tk5VbWRETlRBNUJET2cwcGJSaEVMcm9JM3YwY01S?=
 =?utf-8?B?R3duekppWnR6bHc0WFFTWFFOR1hCSlRqL2YydDQ2WE9VUXN4MTZKTkdBZ3d2?=
 =?utf-8?B?K0VhY3RteERDQ1ZaWWkranpXSW1xWjA0MjlNSitCNHBVSEs5MmcwckE4UzYw?=
 =?utf-8?B?YTdPUlFpdW8xamJUcUo5ZndkOFlMNE5rSWJ3cmxZUVF5OTZsWUtIa0g0bzlD?=
 =?utf-8?B?K09PVTRKSzBTRHZuRElwSTEwbHFIQ0w3bmRWNWU3OW5LeHJLUmRYZXN0dTRQ?=
 =?utf-8?B?YVlEL0MrTFI4bDRxMitlMlBtV0xFVUUyR3dQNHpJa0svcTVYZ0hqL1AyWWdr?=
 =?utf-8?B?OCtlMTJONGo2bWF1VkdGUS9rRHJjN0dDUGVVeTBncGRKQ3VLYlZBZXMvQTRz?=
 =?utf-8?B?RkViQ3N3Nlh3NzJVdGFXZ1UrSDI4b2krUWM3TWZwUUJwaW0yOFB4d1hjZ1RU?=
 =?utf-8?Q?e+06BbqnWKEGQ1DcKLIQsECSo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfdac76-c573-41cf-b6f5-08dc5d49ffe0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:45:58.9330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBfoj3dXX9MJRDeiBBspl0BsL5FznrlYkdvHYTpYcTb0Il+52/YqgUTQYxID9FIg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
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



On 4/15/24 14:44, Heinrich Schuchardt wrote:
> On 15.04.24 13:35, Michal Simek wrote:
>> All errors are generated by ./tools/qconfig.py -b -j8 -i whatever.
>> Error look like this:
>> drivers/crypto/Kconfig:9: warning: style: quotes recommended around
>> 'drivers/crypto/nuvoton/Kconfig' in 'source drivers/crypto/nuvoton/Kconfig'
> 
> Should we add a qconfig.py test to our CI?

When things are without warnings that would be the best.

M
