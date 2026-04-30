Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7320EFF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 04:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F80A803C6;
	Thu, 30 Apr 2026 06:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="JvhbG8Pf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D128183693; Thu, 30 Apr 2026 06:38:09 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA3D80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 06:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLpEXX0PiLaOxutYZll45/y+WmqGdv6omvb6CfjXWV9fELLXsa/J9M1CMDvyuVZdtmPhocpE26pYU3FySxY2lfejSrYsCk62dNbFmRcOpKllhTlU28CYfVePCVBFL0IHbPM4xAtNyLecga1HXmQ+6xtUkD6LVgmQw8rn19faGK7114YalooZz1eIsrsptPJ2fmvbNrMpV0gPXP4s/0c4whf/Z0ZxbuFajUMbIFsTKVthaXYtENhziNaqzxCDG4X6j+zWGgfCJszpqMQP953p4bYTlkz9RHxpHoetdmHEMuDSJGPoX9Eec1kMz2N+K3ReiuR1RO+1Ohj9ddnh0c44Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtvaZg3zI72tMlo6iEDe3opuFkbUhKn5m8wSBCKCF1E=;
 b=sRY/KSSoOcXil53lH0Fo9CvmVAXCVShVXqrq4thtkfjarAQ3uxLvtWkX4eUVsz1rDkn5cKEoAREMoUkES8wB053PmpqUMHJVZcCdc/ehU9GK7Xdn/oE9owq/PW0wj0a3DvJHS8hZQA26mmzIZpW728ZDrmqZzTmhTTHr6sV27Ff8jo6m702nMnz6cL0/rwRgmADzr40bxMsnpjdmvUMqPa3mdoqOxsWjIg/bWSStIHd4NZuQ6DpmuAmLvJC4tMbYlTEWHExHr4t7Ehhczh5H/MiunDKj3EmbMnFSkSw633A7ip729ylp2U3y4pVlOwTliYdZsk+G+cCzLGQk7CONeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtvaZg3zI72tMlo6iEDe3opuFkbUhKn5m8wSBCKCF1E=;
 b=JvhbG8PfVeA8lQCSdsA6rXV/A9FzHVTKQsVo+g7pD2gilNWph78gjqETE+Kxf5yEguo4CAa94kjfeixeke/aorI2mAo/NIzNR18UFXhX3q4f1NnLI+R/4JmTkNRYIQagcK+Fe8UzilbiM51EmLRQ7ZtxoKjoHgQNm90/nRYNCpwZ6Js5SUe/OjR3gSvyjko+sW+yxcJDOFPH4Kwa+6d1k1hr5kWQY3tViwRjZr8Qk8LxJttKYY2kQpnynXFyrQMzk2ap8hPmLooHnA+O8vl5IuMlLG5mK2O8HDrMuIFrU1qaAFoUsPunDfBivsVnL9FfmyvZL86tB03u9APhdGX/+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DSSPR03MB989188.namprd03.prod.outlook.com (2603:10b6:8:375::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 04:38:04 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9846.021; Thu, 30 Apr 2026
 04:38:04 +0000
Message-ID: <04a7b150-5277-4afa-bf36-7eba103d4a5e@altera.com>
Date: Thu, 30 Apr 2026 12:37:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: fpga: arria10: Remove unreachable code.
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260415051720.9679-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260415051720.9679-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|DSSPR03MB989188:EE_
X-MS-Office365-Filtering-Correlation-Id: 20067e08-6d6a-4df9-f23a-08dea67244ef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 4Y4oDgPUnQx30rRmp2FX6aJawxk/Ib+Wacz5GGWSzvbHq5EZirr7pjXylQYQyZJqrA4MPF7/2nq2mlR72Co86Yz4CX+Q4Z3fC1b72TbdNKEW64zOZx95W+urUuQp0GfxEVgaQ/XTWTErcTnwBvZhoozoWDkEKRJIdc/8Q9TvQw8zHG//CHgiW6BrpcE4BLKJbXP2Wgv1KlQ9TbkFW/P0VmCNDxDAnqqIFxHNKqJ5Xbt7Jl2aJ1kCu5PPX4AQ7XN2+lBf1wPfVxDDi/dNxUf/F7DwDwSxhfNp+VgIvdtP+baPcWX8YDPg9NLkvbYp+LdZl9jtlpeU6ewyE/WjXgCR+4BQlg4FoGpPrLcZWWpytQYD1d5vtDryyGOuXR7cB99pTzOwlso/iV5mzq+4YGJoILmByAQxzi1Jm43jfNGhMvnzRZdrqQBc83IlTwGfS9XIhVLwcbGhXC2yPXjb2u41kR6hyqklgfDRxJm4KtjWar0ssq7FVdSK+r+cqtBoNsk0TOrm2rh7XTF13QmS/juF6sXhikibi4GH0epucTMtQgVTq0rGuXPNoWjtrSqcQAVpAbn1dRx1e+1WNfGJsknOtAlnoEoeJgukhOUUoux4STw7I3gh7x2UQv2cw2/v3lskGaSTTSSjKwDeN2LJEDL0AKSixgswgKvvjBE9uhb6rrppeUhpuUM8/MgoLcQeQFA/P0CBKKrqXynIl0i2QgMP465SrpT3e6BV8gzwZ7sxjtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFNRcUpEaTNVdTh2V043TkxySWNCWXlOZFJCMlR2Z1ZFVXBzZk13QUxIdHVR?=
 =?utf-8?B?Z1BOM1JFNzVGMzRTK3hFTlZWWTljRUFZdm55bmNUREp5QTdVTENZYTF0YW5i?=
 =?utf-8?B?RHFhZVNoUi83K3NSSWY5dXNLd0J3eDJQekZhVXJFMmpDK3ZqSlFybUtkVW1t?=
 =?utf-8?B?ci9zVlJZK3dFVzRNZHFuTnJPaEtLc1o1WS8yb2JJSFg0NjArb1phemNKZXpu?=
 =?utf-8?B?K1Z3TFdhdjlGYWl1REdkNUJFQ3V5ZXJnNGdYSmN0ZThTU3VFVEl2R2xYb1FH?=
 =?utf-8?B?RHl1RHluNXp6bDNLRUQ3RjBLeVFrQUd0K09Wbzc4Y2FpVjNtRWxPU3p0dk12?=
 =?utf-8?B?c2pPZXFKbjJpQitxVmhXVVJ5eWRuNXpqNWFXZnowUEVPajlaUERJNVJWZkZ1?=
 =?utf-8?B?STRCbDgzYXZvWGxQZzlURDBNQStWUWNVamgwcjlqcWVvZHl3L3dxSk1QNjBt?=
 =?utf-8?B?anQ1eSt1YTRVd1UrUms4c1BnY3ArQ1p5Um9wQU5xVkpMNkJGc3RobEJ4Tjhz?=
 =?utf-8?B?cWFVejE1S2VGVkRteXpWMkpKTVFVMW52cGkyTTVIaEtjN0l4V0VaMzhnWHo4?=
 =?utf-8?B?eG5ubzJRUEluNVg3UDJJNzdlcVFwdXBCRVY0dDE2dmhxdmpUdHEyV0VaZjB0?=
 =?utf-8?B?K1dkdnlmSnNneVZtYlU1ZVZPbGNkSUtNazlHNW1Hdy9jekswbUd3ZVhIMGxM?=
 =?utf-8?B?aEhudDNBOGw0V0dSR2UwUUQrblNsSGRodFREcmM2ODFlSXBuTkZCc3ZqcVp2?=
 =?utf-8?B?NktpS0U5N2pUV2VwZnZyaURnMDNGenlSYzhIUGxHMWR3Q05odHlML3NFK2l6?=
 =?utf-8?B?YnNLelNEaWVqcWcwRm9yRENyQVpMZUtqbHJrUDdtWkMyM3h4NjFsMnplaWlQ?=
 =?utf-8?B?Z1FVcUtwWDlqSzdvdVVIVkVLNE9mYms5SzlFYTE5T2Q1TWlxZmdUaGkvMmxC?=
 =?utf-8?B?UWo0R25jc3NSV3JoUmxESEJSTmJXSU9IbGRRRHVVbEFRUHgxSC80L0Nma2dQ?=
 =?utf-8?B?cHhXUWV5a2phdzI2UUFWKzNUbFVXM3NoQ3ZIZkw5NUxjd0FtdG5YbjA5QWN6?=
 =?utf-8?B?cU5mVGRScUJyRUIwTk1zQzdnc1dVbzZZWkpsV0VHNmRDTWFPaStCakFadzNE?=
 =?utf-8?B?ZnJ4WC9ocnAvbE1NMWNDd0RleFpxdnRXaVpqcmFFUGVkV0cyU21XSVVBRW5n?=
 =?utf-8?B?UXRRK1BtZVROSEpUSThHckZOdndpRGI5VVJxWHpSdDhPaE90aWo3UE8yZTc2?=
 =?utf-8?B?cGxtOEFjWmpOZGk1SHRYNlZNSjZFVnhINlI1bUpVVW54L0U4L1h2SGJmVnBh?=
 =?utf-8?B?QUswNmo1REdRYmlkZk5uQ0lJMTNQN2VRTDRDRitKRGdCNDBSYzdpajZGM0FQ?=
 =?utf-8?B?SW1VblNyTHY4K2huVEgvSUJsSWlSY2dWYjFoRzBmemR1WVdjSkZpL3J6VHhG?=
 =?utf-8?B?WTJHTCtabmthclVlOHVIVlJFYkgwSWx1M3JnT0JVZGtWOWFOMThyMlBLdnNw?=
 =?utf-8?B?QmVBc2xHMVVneFMyTEJ4YVBYeGN3a3RrZVZMc00vREZadzJxcUJlWWZvVVBt?=
 =?utf-8?B?alQ4cklHcHlrQWhySlB6cVFiUmk5WUoyY1djWXFndnlZejNQcnJ0WGhYMWNv?=
 =?utf-8?B?UjVvd2RDQkg0anczbjlDZjFlMlpEU0w1eEFWTDFNUGprQkVIUkxocWd5UFpY?=
 =?utf-8?B?cjFlK3VDMmtvWEZsLzRiUHhuSEwxbGpMbHUxWGVmYUxDVEIyemRqOUppVHRW?=
 =?utf-8?B?ZHNaUjdWTGxpdEEyblhDMm5BRkR2VG9BNkNSejN5VDJRQnhNMVIzNTZGaFJn?=
 =?utf-8?B?RWs3TDh4ZjRDcUZPTWovc3lrTkl0ODFMK2ViRnBPbElaeWtWMWp0UThWVDI2?=
 =?utf-8?B?WDY1RGR5L2UxY1dlM010aGYyWCtxb05aZ09teWVXZkF1L1I1NDJIMyt3Tld2?=
 =?utf-8?B?RFdybFI1eUJsQldud1NOcjlZTSs4WnFLMm02VXJXaEhWL0tqbU1KQWZuN2xQ?=
 =?utf-8?B?TE9Nc1BnekNYM1dkM3RTVDVacmdFazlrNGJ4THRmT2dIeXNPbmY2KytabUhV?=
 =?utf-8?B?WnBOYUszUktLNjQrM3ozNkhiK3FQZTlxSjZaYm5ISjlRc1Fvekc3VFE2SmNo?=
 =?utf-8?B?dmdablVMQmsvMXlmWHo1NUQwV0tUbXNDYnRvM0ZQS09GZmVXRDVvazc1SHAr?=
 =?utf-8?B?eHZ0ejMvQ2VVY0lneUdqbG5HUEtROVl1c0txRnZOQjg1N0NaTGlNeXpldGV6?=
 =?utf-8?B?amI1WStiTUZ0MnVWZjVlY3U3a1hmZW1VTjVZZkNoSkNwYXQ3SEgxa1QveE5J?=
 =?utf-8?B?aEQyYnRzMEFmQ2g3N2NNWUNodXoyYmMzUnhFcm5QTGVySVVNVVdKL3pFUlNz?=
 =?utf-8?Q?BhTTAgUMiiyNiU+k=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20067e08-6d6a-4df9-f23a-08dea67244ef
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 04:38:04.8021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvgG8vwjtLV0dHEvXxbVNr5zqZLUOjpGW1Etmjm3ezuwY89QJK14gpLc3V5QTa81FglAtTIWb6BSB8/PuXib7MttSKBeFND++/CCCUJ+dlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR03MB989188
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

On 15/4/2026 1:17 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> The schedule() call after the break statement is unreachable.
> Remove the dead code as it has no functional impact.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   drivers/fpga/socfpga_arria10.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/fpga/socfpga_arria10.c b/drivers/fpga/socfpga_arria10.c
> index e9822b2bb0e..b85cc3e076d 100644
> --- a/drivers/fpga/socfpga_arria10.c
> +++ b/drivers/fpga/socfpga_arria10.c
> @@ -532,8 +532,6 @@ static void get_rbf_image_info(struct rbf_info *rbf, u16 *buffer)
>   
>   		rbf->section = unknown;
>   		break;
> -
> -		schedule();
>   	}
>   }
>   


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>


Best regards,
Tien Fong

