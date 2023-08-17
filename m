Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33DDC27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B22F86A7D;
	Thu, 17 Aug 2023 10:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="fVRpazW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B691986A68; Thu, 17 Aug 2023 10:46:21 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36E486A4F
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HavwV7oo2MKmR84qkQPMfs1OQdAay8OXTvkV9Ybth8MR3ebuvZgUq9mBn9lfFrj+/bZ76opJToNpFqvQwgjxU22WeplibAVZsY54G2W/TxM5of1JmLWKg+pFTVrRvgMFyRpJbUtbO2oXvwf8Sueul1YUdI6LhQHCLIoQZI4jPn8spMpWAxrCPNtcK+uKwLvLBMbexwV9vLIVsQP6cAb6YAP+4jq6uScXsdqLTb3P+tdU5iFhfqMiHD4dvjXHQV50Qx3AQ3VRjn4p1tgIlO2MO7Zr5zHGfvW4XZOt9kjoM35eumwjpuMm2miU761sH9swSsq17/DH44xjyfzSYIJoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbedduYIi1OV/d4vcnTE+Evo4evs8zP9ijEzXx7tH6k=;
 b=iQ+0+++4kWyaUuCvTVvohAT35+p1YgxzWDR3611bB6Z04m7/IGATF4x+o1qZf3bneiMIWjHB1AbWjthoqYQ/thnjaH1HfX165uotnll3PrV459Ly6E7hkb1+cGtUHWZ093hyvMW/fjzoulk8vwd4v8Rr94YRsF0daxMHlFzGsh0Mo8egixFXWRc3mkj69RT8zxDJ2JzSl8TNoMwLbLkRRp9yAcQKYOltCmlTBUkjEHOR2EkTw5X7SkvcvpTFVQsrbutq0Yc+MRtNMVHVz5lMjDlImiUuS3bB5s40aV04jpqHCfq0Vu465Mub5quAFIYYGHMjX9Vx9/JTrn6uVLZEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbedduYIi1OV/d4vcnTE+Evo4evs8zP9ijEzXx7tH6k=;
 b=fVRpazW52tHxk94tFTBU674wKrk6c3dU6p8jvUwj12cbjGOytjHRiIee2Ty1icVrG3/69mtHPSoakIQADj2hcHdwrfIeDduBZDxuzy7Pq3/S+pVmiQ6MrzY5mJJCFFf1F9T0Xx3lL8crIofXOLoyYqjMX5VkzOIm1gp4xmnTE5p8U7G5qm4iqaOKmk/zqTNRB7PwAVlM5+R6HD1RKCPIuPw8R3kmDXJB6VRkhxeonc1J9cFfH1lm2mMUat6Q4BDsEWVIKt/4EfB8d54j9TEuy90cs4ouzEI0G5UO7caGa3aGkqUij/hPm017YfASP4fMdLXiAF3hS4gnb3zTJafFkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8845.eurprd04.prod.outlook.com (2603:10a6:102:20c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 08:46:16 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::e14d:c030:8ad4:e916]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::e14d:c030:8ad4:e916%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 08:46:16 +0000
Message-ID: <374a63d7-096a-e3a0-807b-c69112d8c46d@theobroma-systems.com>
Date: Thu, 17 Aug 2023 10:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] board: rockchip: rk35xx: Add device tree files to
 MAINTAINERS
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Chris Morgan <macromorgan@hotmail.com>, Jagan Teki <jagan@edgeble.ai>,
 Joseph Chen <chenjh@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20230817060422.477759-1-jonas@kwiboo.se>
 <20230817060422.477759-3-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20230817060422.477759-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: ee978cad-6e06-4ebc-e027-08db9efe6b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rz6z0NK/CR1LjoJqrcXP+ZwWuR4Dt96yUJBqibvdZw6QqPIfdeTlVtlLwt4k+Sokcb5PIHgkMMk8poAXsKn897hYaFoR4OTYR1b3hWrjXYiXAH/pJsNOsXGR5kjim9WNMfx6RQRarnshK78LF6otuMqfE7JWhhPBqC2L3KoHKM6x0NnQoHXMNKcWE2Gfw2DMeIQ1DmEM5hKRfSkuEZxiqIR1VfH/10YcDMygeqgB550gPYHM0W8/ifRpYoAzaTXPoJvwBpMRJpfQnw0hd994htQddMJKOMMwgGHdL+L4fOZkzTWgKfeF61shuIiM2BbCxoY7SZmxan2Z3T+Y9s4xJSSAwET3tayX7kGD1f/lJsPzgmALAuBJ49b2oUzUaQsMe2SpzaooRQW9hMgyCCs41zsWW+5SOXwnbVShUsNJJPfTNzSfbDQfh15osfJIlYPpFdJw46TTUkJankIbCAV5M8h45gXB1QMMXW1oKO6V9h3R1ogXug+LzW3on+1BRbXD2iSqX6jfHGEPEDoyzWE9hBegGwM7tV2moyZqOBa1VjyH837Qwgf7sCBMhRLHXYY5vgeBKKhdQu9GJn87UkrD2yxcRGSYy3HliIfZlwLActQ72aRbEOYAoYC5YiOi4As3ebIpAEJ4m2/weQ4iCEGMjCqGSed+hcaG1+vGXZMcHzY1CtuPLnfL9jnY/gpXTYw9ebZNs3aXwD4O6xEQ8eGqZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39850400004)(186009)(1800799009)(451199024)(8936002)(7416002)(921005)(478600001)(86362001)(41300700001)(4326008)(8676002)(38100700002)(66899024)(5660300002)(316002)(66556008)(66946007)(66476007)(110136005)(31696002)(44832011)(26005)(2906002)(36756003)(2616005)(83380400001)(31686004)(6512007)(6486002)(6506007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0hjN3hnK0YzaDFXaE5UUXhZaTZ2NWFUL0tyWHhobDh1aWgremlKdWNVekFN?=
 =?utf-8?B?dC9BWm5XUWJXNVI1dkJYSTMrTFRpcDJEUFBXSDF2UmU4UlBhVkcvcGY0ZGYx?=
 =?utf-8?B?VFY3MnVvSXh3dHZ4RkZNNXpFd2x2ZXNEOGliUlBlTDdxOGJDTXAxM0lpZ2Ux?=
 =?utf-8?B?UGdPUkp1WTArb0VlbWpVa0dCU1QycndtTXVqb2ZDRHZLOExvQmUyODdXYUxy?=
 =?utf-8?B?YnJoU1kzM1BJR1RUeEQ1ajhHU2RzQ0hLUHBWaUI0M3ExUEtFTjQ5M1BEZVk4?=
 =?utf-8?B?c2ZHRGJQT3dKdDJsSzV3a2Rjd0EzSzZYTUY0U0k3bjZhb3ZET09uZFZaVzJ2?=
 =?utf-8?B?bDBjclVpSFkxazFDc3lRK0lZNUY0Uy9QbUNBeGNIRVpEalpZOGJRZ1AvVFFy?=
 =?utf-8?B?Qmt0dFpiYW9WdkxTRExPY1hlT2ZETDhiSHhmTU91ODZmRXNXQWV0T2RVZ21V?=
 =?utf-8?B?cHU5ZWFOVk0ySjdaTkZlaTlpZDBSRytTN2VUYjJaVWxyMEluVVk0UTlwN1o3?=
 =?utf-8?B?R2dDOEQxUmFTcDc5MjREQnFkaS9HWnJ3TjZDOWhyWFlOMlcxSGlLWndnRURH?=
 =?utf-8?B?NGlOWnlxSGJpYVFFZTdSS3lSTE5jY2lsWFAzaEZCVytpTUxsYnY3SmpBTnZt?=
 =?utf-8?B?NUtZWmdBWVNHUGpIVkV4TzFWNVpxVnFFOFMwMDljb2Vxd0NrdnBCYUw5RE8r?=
 =?utf-8?B?Wm5MYzNNVGFOUFA3L1ZxKzZIOElEMjlsa3JNQ1ovRFpvL2RqaFlVdGkrSEhC?=
 =?utf-8?B?bVhFV2lDWmt4aEcyYlhDQWpPbEYveFRDUDRtN2l4UytIMjd3cHFHRFZQQmRN?=
 =?utf-8?B?bjRzd1ViMWwwRHlDdGNlN1Z5d0dXUXJCV01TQ240VEN6SHBvVmhDYmQyWGJC?=
 =?utf-8?B?blNsQ0U1aUl4WW8xWk40dlZ5UGloVFBENWd3ZldyZ0tFNkdyMVVZZ2NaWHN6?=
 =?utf-8?B?ZXJmYmgvRFFmM1JSM0xpM3lCYWpPdmRodmRlb01LaDg3Um84NWhrTGxIMHdJ?=
 =?utf-8?B?REhtem0vdWw4eE5kWE1vcm9Rei9PQVZPV0JnMjYwU1M1MkphdkpBcGYvOUQ3?=
 =?utf-8?B?NlprSzJuajhtZFZDTHg0QW9IaytOYTZvODlPQks5Mk1wUmQ2WUY4U1pUbWN6?=
 =?utf-8?B?NnZqOGZPVk5JdFJNREtPNlpkK0lma1dRYTMwdTFSc3lJQzdXb1F5Y1c2QzFz?=
 =?utf-8?B?VE9oNzI5NTIraDRSRnM1TFZrMXlCbEtweDg1dVkwbkFZdW9rMTVCRjdTeUlV?=
 =?utf-8?B?RUpUS20wVzhNT05NTE1WWWJGRFR2S0x4WXFyTmx6Sm44VVF1WEhoVmkwb05r?=
 =?utf-8?B?R3hocjcvcFNlV2x0NWttd1dkL08zRG1hUnJmVjVOazFhYkErMmJYQkpZcFFz?=
 =?utf-8?B?WVdxWlYreHBtYXVUN0pSR2pSdzAweGJ2aDU5RXlJYVN0cHdDM2FGWG9pM0Ri?=
 =?utf-8?B?eDRnSkZ2bW5BTkpuOTRnVUh2VjVjVDhDbUVZYWRWY2xnbGpmNHBYZUtXWVkx?=
 =?utf-8?B?WHdnMENwRVNiMlJ0Y1QyOEtpYXJvckNxekpWcEMzYWJvcGgxbitZd1lHRFda?=
 =?utf-8?B?eGVBT0ZxL3VPRkRZYzluU2RwNVozMVdrWU5ZR0d6d25kSmZ6VEdib3pLaHZu?=
 =?utf-8?B?NHc4VEhjUnJidU1rcnFUTXJyd3BDWW01T3NHeEZ2WW1kZEJZaVB4bTVHRkxr?=
 =?utf-8?B?SlZpdFhsNHlOajIwVm9iN1kreDlRQ0VVdHFYSzZ4ZHhsZmc4RVhTVDhJZUl1?=
 =?utf-8?B?Mi9wdVppK2hRMUZlZ2xTZ3ZmZ3FEMWswZGlScm8rRjlzNEU0ZTdub0tUQXJy?=
 =?utf-8?B?eXBEMWZScWN3SkUrUjVNbCtkalRMdmV0RTh0QnNZRXhlSWJUa3dpM2ZHUlVq?=
 =?utf-8?B?clltbExkVEFSTkF1b21qSHJFYi9hOVI0TTV1SmRST0VZUFVaazMvdDlaSG5P?=
 =?utf-8?B?bXlFcWpFUno1eGdhUkROcXlLWE1talFHdG5jKzM5NlU3TDZaTnN4N0ZVZ0RT?=
 =?utf-8?B?eG83cUVibjJDbEJvSjc3SnB2SnBoSWxFcXBEWnNQY01LRGtPYjRPOWZ2UjZk?=
 =?utf-8?B?UkJhS1I1ekd3N2tsOXUzRnVyVExaY1VlNDBjTjlaSlpHZy9qbnV4YkdVTWJp?=
 =?utf-8?B?VGlkQkRSeFJnT1F5RnhIWWl1ZjFCNmsyd25na3R6NkNEUTB0QUFTcjdKUURE?=
 =?utf-8?Q?QKLLKD5nFkmsAN5tv/jR31M=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee978cad-6e06-4ebc-e027-08db9efe6b63
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 08:46:16.5803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVbIfJo4/i7Qgvmnr8p4FiJZBlorTcAi5UlOKtxpkthyRs+pQE6jzGLqfoU89PX3Q3UVoLks+YuzQbGwSbYtko5ud5JRowrF9zwl/is6Gb9rKMw6QzYcVTQsZefGSYO2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8845
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

On 8/17/23 08:04, Jonas Karlman wrote:
> Update MAINTAINERS files for RK3566/RK3568/RK3588 boards to include
> related device tree files. Also replace space with tabs.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   board/anbernic/rgxx3_rk3566/MAINTAINERS       |  3 ++
>   .../neural-compute-module-6/MAINTAINERS       |  6 +++
>   board/radxa/rock5a-rk3588s/MAINTAINERS        |  2 +
>   board/radxa/rock5b-rk3588/MAINTAINERS         |  4 +-
>   board/rockchip/evb_rk3568/MAINTAINERS         | 51 ++++++++++---------
>   board/rockchip/evb_rk3588/MAINTAINERS         |  3 +-
>   6 files changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/board/anbernic/rgxx3_rk3566/MAINTAINERS b/board/anbernic/rgxx3_rk3566/MAINTAINERS
> index 1c0d3fe7b5bf..6be16a47e8eb 100644
> --- a/board/anbernic/rgxx3_rk3566/MAINTAINERS
> +++ b/board/anbernic/rgxx3_rk3566/MAINTAINERS
> @@ -4,3 +4,6 @@ S:	Maintained
>   F:	board/anbernic/rgxx3_rk3566
>   F:	include/configs/anbernic-rgxx3-rk3566.h
>   F:	configs/anbernic-rgxx3_defconfig
> +F:	arch/arm/dts/rk3566-anbernic-rgxx3.dts
> +F:	arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
> +F:	arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi

An easier way to deal with this is to use the "*" character since it's 
supported in MAINTAINERS file apparently (ag -Q "*" **/MAINTAINERS 
returns multiple matches in multiple files). So maybe replace it with 
something like

F: arch/arm/dts/rk3566-anbernic-rgxx3*

?

That way if the files eventually get split into multiple ones, get 
renamed, have one created (e.g. -u-boot.dtsi), they are all matched by 
that same line. Less maintenance here (and hopefully precise enough that 
we don't have false positives).

Just a suggestion,

Cheers,
Quentin

> diff --git a/board/edgeble/neural-compute-module-6/MAINTAINERS b/board/edgeble/neural-compute-module-6/MAINTAINERS
> index bc7f9b0e680d..42e5df506bf3 100644
> --- a/board/edgeble/neural-compute-module-6/MAINTAINERS
> +++ b/board/edgeble/neural-compute-module-6/MAINTAINERS
> @@ -5,3 +5,9 @@ F:	board/edgeble/neural-compute-module-6
>   F:	include/configs/neural-compute-module-6.h
>   F:	configs/neu6a-io-rk3588_defconfig
>   F:	configs/neu6b-io-rk3588_defconfig
> +F:	arch/arm/dts/rk3588-edgeble-neu6a.dtsi
> +F:	arch/arm/dts/rk3588-edgeble-neu6a-io.dts
> +F:	arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-edgeble-neu6b.dtsi
> +F:	arch/arm/dts/rk3588-edgeble-neu6b-io.dts
> +F:	arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS b/board/radxa/rock5a-rk3588s/MAINTAINERS
> index 62fb6b4c0eea..05750269b8dd 100644
> --- a/board/radxa/rock5a-rk3588s/MAINTAINERS
> +++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
> @@ -4,3 +4,5 @@ S:	Maintained
>   F:	board/radxa/rock5a-rk3588s
>   F:	include/configs/rock5a-rk3588s.h
>   F:	configs/rock5a-rk3588s_defconfig
> +F:	arch/arm/dts/rk3588s-rock-5a.dts
> +F:	arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> diff --git a/board/radxa/rock5b-rk3588/MAINTAINERS b/board/radxa/rock5b-rk3588/MAINTAINERS
> index 693751e583d9..734115a4a3dc 100644
> --- a/board/radxa/rock5b-rk3588/MAINTAINERS
> +++ b/board/radxa/rock5b-rk3588/MAINTAINERS
> @@ -2,5 +2,7 @@ ROCK5B-RK3588
>   M:	Eugen Hristev <eugen.hristev@collabora.com>
>   S:	Maintained
>   F:	board/radxa/rock5b-rk3588
> -F:	include/configs/rock5b-rk3588
> +F:	include/configs/rock5b-rk3588.h
>   F:	configs/rock5b-rk3588_defconfig
> +F:	arch/arm/dts/rk3588-rock-5b.dts
> +F:	arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index 1cdeafcf79b2..5a2ec13e21ee 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -1,13 +1,13 @@
>   EVB-RK3568
> -M:      Joseph Chen <chenjh@rock-chips.com>
> -S:      Maintained
> -F:      board/rockchip/evb_rk3568
> -F:      include/configs/evb_rk3568.h
> -F:      configs/evb-rk3568_defconfig
> -F:	arch/arm/dts/rk3568-evb-boot.dtsi
> +M:	Joseph Chen <chenjh@rock-chips.com>
> +S:	Maintained
> +F:	board/rockchip/evb_rk3568
> +F:	include/configs/evb_rk3568.h
> +F:	configs/evb-rk3568_defconfig
> +F:	arch/arm/dts/rk3568-evb-u-boot.dtsi
>   F:	arch/arm/dts/rk3568-evb.dts
>   
> -Lubancat-2
> +LUBANCAT-2
>   M:	Andy Yan <andyshrk@163.com>
>   S:	Maintained
>   F:	configs/lubancat-2-rk3568_defconfig
> @@ -15,24 +15,27 @@ F:	arch/arm/dts/rk3568-lubancat-2.dts
>   F:	arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
>   
>   NANOPI-R5C
> -M:      Tianling Shen <cnsztl@gmail.com>
> -S:      Maintained
> -F:      configs/nanopi-r5c-rk3568_defconfig
> -F:      arch/arm/dts/rk3568-nanopi-r5c.dts
> -F:      arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi
> +M:	Tianling Shen <cnsztl@gmail.com>
> +S:	Maintained
> +F:	configs/nanopi-r5c-rk3568_defconfig
> +F:	arch/arm/dts/rk3568-nanopi-r5c.dts
> +F:	arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi
>   
>   NANOPI-R5S
> -M:      Tianling Shen <cnsztl@gmail.com>
> -S:      Maintained
> -F:      configs/nanopi-r5s-rk3568_defconfig
> -F:      arch/arm/dts/rk3568-nanopi-r5s.dts
> -F:      arch/arm/dts/rk3568-nanopi-r5s.dtsi
> -F:      arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +M:	Tianling Shen <cnsztl@gmail.com>
> +S:	Maintained
> +F:	configs/nanopi-r5s-rk3568_defconfig
> +F:	arch/arm/dts/rk3568-nanopi-r5s.dts
> +F:	arch/arm/dts/rk3568-nanopi-r5s.dtsi
> +F:	arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
>   
> -RADXA-CM3
> +RADXA-CM3-IO
>   M:	Jagan Teki <jagan@amarulasolutions.com>
>   S:	Maintained
>   F:	configs/radxa-cm3-io-rk3566_defconfig
> +F:	arch/arm/dts/rk3566-radxa-cm3.dtsi
> +F:	arch/arm/dts/rk3566-radxa-cm3-io.dts
> +F:	arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
>   
>   RADXA-E25
>   M:	Jonas Karlman <jonas@kwiboo.se>
> @@ -43,8 +46,8 @@ F:	arch/arm/dts/rk3568-radxa-e25.dts
>   F:	arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
>   
>   ROCK-3A
> -M:      Akash Gajjar <gajjar04akash@gmail.com>
> -S:      Maintained
> -F:      configs/rock-3a-rk3568_defconfig
> -F:      arch/arm/dts/rk3568-rock-3a.dts
> -F:      arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +M:	Akash Gajjar <gajjar04akash@gmail.com>
> +S:	Maintained
> +F:	configs/rock-3a-rk3568_defconfig
> +F:	arch/arm/dts/rk3568-rock-3a.dts
> +F:	arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
> index 7b7df3c5a8ac..6b2c257a1705 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -4,4 +4,5 @@ S:	Maintained
>   F:	board/rockchip/evb_rk3588
>   F:	include/configs/evb_rk3588.h
>   F:	configs/evb-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-evb-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-evb1-v10.dts
> +F:	arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
