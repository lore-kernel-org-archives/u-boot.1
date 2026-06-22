Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D97CCDB46F
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 11:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB4AE84866;
	Mon, 22 Jun 2026 13:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fNtpszER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71219848DC; Mon, 22 Jun 2026 13:09:15 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5681784832
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 13:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wi6Z9Anj+9LNbPzUpurAktZCJcGzaHidECajiC7ybccx1oVOiJcpldq2xJwJ2krGUx8Tz/2mN6OafLkvrSL0L/k+wv/JD9U+vIkIgemZds/RaJuP8XFmCm6A1bsTjpFuaAm9+ubuS7EThCqXDT4vT5dBmeQq7NB6W63YBOMYGg6oOlgis0pPfRGrFvgKJAU3hvcDh8gWP5sMu7WVgUs47BtxVR5obTe3K+VN0bPo5kizltdULWtDcVOA1vUV5etZ2ptH3wG6MawpCnL6Ti6uIyUmsKpsGF+42C4OuM6z9IcgnhYSIcJFDafGcIIAC9FRCCaf0UJW/hIJLruGLxW8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DZchDr4640EvVULQcgMPCpEI9SQWo1/Ro6CAw4iW5E=;
 b=HtGyZhLbFiPEvvNTqQp+B9dLKrtr6UbDlX6iBEbdbzpHrVRL5q32kiMvInDpkODS2wZyyCeTyDmmKC0N9b9br9vKROO86HhUmlJzzMUdW6zAbz7OFiwzlYNq05S5mGq6UWGgBWGK8i1/shBhDRNcXB/Zez0hiXCEhzWX8dIrsP0B8wxQ/hKEq4A7Wam5o/WpHbAVvS8NAI9UqDHw302VV8U0nEpxBOzC7GUJzWYwM5C5dGZyNQLweF6/E27UjjOxgK6djjnKHzMglP1Av6VRiVVg8CwNAe1LVwMhSWgMqvCfMVU7b6ty9j3z/s239nkaqapeJz3zhiCBnFjLMM1Dsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DZchDr4640EvVULQcgMPCpEI9SQWo1/Ro6CAw4iW5E=;
 b=fNtpszERdtB725xpqyiJWZZ6ufAku4oFzB64F2N0d94Aun09am1lkZWVNLpKj8yBzOrjoCZ8wAMo4l1nem+sOt1H2SSOZb0x6fh68hoAQPxjcd93ZE/T6on/lB1mvQPNi/g9uM/YtSbsKMPbJcgb795UVCghyX0ZPQrL1f8JUG56nBk8PYmonfFZbImr20zNsVDz3SA/zGjwasQl8FfPQ1WlQqhKc6JTEW5iEzk5i3srFPihZcJ7auOYkVnxvD6KtEXR72Hw+XKUDJ3t5G4JmjypC6dwp6Q/PhkFWOZKq1iZDxx0Jbt6C1h8uGVF+WdjAtxuc1jv2wF76gyR4ukSyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SJ0PR03MB6927.namprd03.prod.outlook.com (2603:10b6:a03:43d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Mon, 22 Jun
 2026 11:09:09 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0113.013; Mon, 22 Jun 2026
 11:09:08 +0000
Message-ID: <7e026192-7939-4a89-9268-8d9bc7c1b7f8@altera.com>
Date: Mon, 22 Jun 2026 19:09:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: clk: n5x: Fix incorrect EMAC clock source
 selection
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260507090215.18074-1-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260507090215.18074-1-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SJ0PR03MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: a78ca062-6965-409e-645f-08ded04eae5f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|55112099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: CCH6YHinWJrwkaHDdIp8N2ZUDPeCAbQ65HeIbHhap5g7plnX1Pm2BH0edXMa0Uhr+XY4pHIeIMO+w2D+GZ+gTu4tE6fuOnhpAAsqc52Qz4h6TGbWt/o0u9f0D5rwkNVrXu624X8BIghyPbAU0TTBrsw7TkOCJggZnOnYZdcxKnDpkySBRXkFqws5aTvqQdIT04uhz86vjCCEggU8OjpYKA0VWxpkwilF2PmV8R4geOjZYkBOT+rjmj2Sb9I9xp4zlHXbdzD6/tyTmI3Eej8uAtrEICGMbxJ4wrNmrxy6dyEN5g8/XZJLo18SXU+dS61LSaxTnt8q5Wm9tkOF1FoVjwSOEgQ7zHbLH2ldpK/JSnSGeRD1xx5zNFNLDucZEpbHPeL/+pCUt8sHkH+QEyreuJExcIwbhHmmKH5nKZWi+zCDTgLgVqwaEq8F+VKkZMcIteFkMaYT2hfzlTqhBBA9V7hy62NcFW1ZGfjIQxvRsJELaSGWDfZ8SZ1lINMXDSGP/uNqiVBvfeDCebOtN7xbkQzxZBKKf26PKScHf9ouUPH8plA+96A7IInxDl7eR2bgByDH6vSFrB7KRC9vnGpJVuvh41Md5Yxau5RwH8C3Zky7i9gJ0Tu4XL3OS/ltjjciZkFTuAq2/7CBHEjkYz6nXuL1He7OjRPak46a4SxUrMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRRUjJYa1VDR2wreGloT1ArVnk4RktiNVNFZklZclBUKzl2OTVDbEU5c2lU?=
 =?utf-8?B?UC92YzRlVTJEdUNiUWg2TjNsaDVGS0lQY2ZMQTc3RWIzUGcxQkhhc3duK1VT?=
 =?utf-8?B?bmVjVGxtWXdGakdnZkRkdVFiSEJTaEt6b1lFWlhNU0FYdzI4YkZEdDFnTTJQ?=
 =?utf-8?B?QnRSOVRJaE5OYVZSNWJ2bkNPNkFubk0xRWRwTDZCV0k4WFRWdEJDU0dtcHdv?=
 =?utf-8?B?WDUwUER5SmxRbUpiNnpkR2Jab0F0KzlrdFY3bkx6eENydDQyVzdvckZjZEtT?=
 =?utf-8?B?dnhqaUxNZzhzTzFoa2Y1T0hTY2Q1UFdVV3AvaDJwdS9heVUvdEZxMTNzbGRo?=
 =?utf-8?B?azREeklwZUpCTTRYODJSdkk1YzgxSDdMVUNDaC9WWW1HY016SDdSa2ZXUWh0?=
 =?utf-8?B?L1dJZXJlZHJ6bm1TVXRNNWZlY3hJOFpuQjhsN0NySTZSTzhkRGtBeDJpKzJO?=
 =?utf-8?B?SjhvSURDRm85Tjh4SjlNTHYzUmlDT0ZCS1NtR1lQWitxUmJmRlZjTU4wWnR3?=
 =?utf-8?B?ckhUSDc2NWlQVkN5SVUyeEtzNVBZUGdhc1F0K2FrUHRTZHlidSt1d0FrNVRw?=
 =?utf-8?B?ZkhoN0kyMWJydFdYY0pLaXQvTFAxRWdjS2xDM3laSVZEcjNZaGNoK0VFTzFq?=
 =?utf-8?B?em9BNnZUTUU1NGQzdU93akhCSG1Qb1FUTVhwU0p2YWdydWFOdlAwczVTTUts?=
 =?utf-8?B?RkE1cnpEMS9JWXJOeHFXb2IrcVNFazVPaEc2WWRxZWNZNk5QdmFCZXZQaVJF?=
 =?utf-8?B?SlFZZHlLQkdWMjExWVg3c1YzTGpibXM4ajVCN3Q1cmhEUkx4WHl3RHljUVJl?=
 =?utf-8?B?bllHWUxsOGRvQjR1OXkxV1Rycmo0N3UyRWs0ZTVLMUNLMjdBNVVYZFdzTUZU?=
 =?utf-8?B?bGRFczQ2czJ1RjNxTWxyZVkrY29zRXo5WU9hSm5nM0RiaXIyakROWkNSeSs4?=
 =?utf-8?B?OEo2bzR0TU44SHpPaklSY1BWT1NPQWNuNEFCajhUaGRDTHhKNy9IQUI5VUpm?=
 =?utf-8?B?akJuVmRHWThxc09CSlVUS0dqazY5TzR4OGRYdmFHTXhCWitha3hndWpqQnY3?=
 =?utf-8?B?dUJUc1lUTnpIYlRWMVZWdWU1VlR3Zm5pdGNOOU1CVXk3Sjk1TzdLRHhEcEw1?=
 =?utf-8?B?VkFuVHdkbEFrUmtsOVFiM01QUFpDbllVMTY5Vkh4MG5FMFpKUlBiKzlrSjhs?=
 =?utf-8?B?QVBzUEF6bG9pY3pkZjhDSE5lc3ZYazducDR3Q2NJOXRRVlhCWUMxR0NueWxE?=
 =?utf-8?B?c1ZWS1U3QVQ1dHFTK0lPYUg5bk14cEo3WC8zNWZ1ZnRwREVtNnBWeHFoQllV?=
 =?utf-8?B?anBOTkpHaGUwazZMTWI4ZUxjSXNDNVkxdCt4bDFDNm14QUxjZ2NGa2ROVzd4?=
 =?utf-8?B?dTdiQ1ErRTY1L1BUUEFKTGkwdURNMnAwNWd6TDJRcEszcytoSUMzWHVLeE5j?=
 =?utf-8?B?SEl4aTVxWkoybmdSMDVGYk5QVzNBaVljS3hUNkhIRHVBa1lwNnZxZFV2dWZo?=
 =?utf-8?B?WmduaktHN0ZSWUNkT0lFa2JJVy9sWFJVMCtyNEVOSUtrQ3hJUjhZMGNwV3Br?=
 =?utf-8?B?bHV1ZnE0aFBSN0dOclg5UTFvTm90K0ltdUxOdFR4cUl6WEk2RWRoZ1RlVjJo?=
 =?utf-8?B?WFpNSVZWY09mZkorV3p5MWtGdnBXZU5HS3JUWlpaWHFCOU1VN0VmTHVuMmth?=
 =?utf-8?B?cHdHdUZVNTBWNjRpWjlNRkNLUzE5TUd0UGw2Mng3LytURmpmaFVrdkhjbGNt?=
 =?utf-8?B?VDRLYkZ2OUZvd2g2R0I3N3BBbktYbGIyNzA5Q0VrdTRNeTNnSmxqQ0dBVnBK?=
 =?utf-8?B?NjRrcnZ0eFRDWDFiQ0srVGcrRG9Nbnc3NHRFNmZaNVI5MFFpSml0RTIydTND?=
 =?utf-8?B?YW45NldxNXIvWSs1Z0hUcTlGN25VUFI1enV6cVNuNGY2WmlFY3V5V2xZK0cv?=
 =?utf-8?B?aXR6dlhpMFhXN1l0QXhPdmY2R2R5dUNMWC9hcjdES1QrMHIza0M4MnE0QnBP?=
 =?utf-8?B?OW1Jdi9lSjlXRjJyUkd2OHUvSnkvWlNZVjRHWGR1ZWJoZUJLWmFUSDVUSjgr?=
 =?utf-8?B?M0R6S1E3a0tob0VNZG0rRlU4YVBWT3IrUEZUenJLQ2N5NGxkM2x6Wjlrd1Nq?=
 =?utf-8?B?NTlSSGp6aElGMTRhMDZvMUVsV00rbmpVendQSW1rdmlDcXd2OTVLWTF2NVNq?=
 =?utf-8?B?Qy9GamczN0h6eTRPdHhybkhtS3dSSGZzYWhOMks5TFRsSmxHWWtaK0thS0ox?=
 =?utf-8?B?MWlFZ2tWMGFUeW1FZ3A2azMyTVhLMG54bHUwSUZQNHB4NkkvckNQUlNSTzlN?=
 =?utf-8?B?M0VlVFNOMktFQWExNFpxbVhaOTJMSmEyNzJ5UUs5R1RxVDlsbTkxVWc2d2Vu?=
 =?utf-8?Q?43ARVjM4rt4ylWjw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78ca062-6965-409e-645f-08ded04eae5f
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:09:08.7776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LDHFvnISjTAJxsuYe/mMsuMsbaEPlSv/IuwQpr3hPAoZBYVLAx+iB+4vJeywSRD9eggAcj8NWwGGsQLRqb5iJZNUSSvhg2E69GYWtu7RzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6927
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

Hi Lok,


On 7/5/2026 5:02 pm, Chen Huei Lok wrote:
> Fix the incorrect bit masking and bit shift that caused EMAC to always
> get the clock source from emaca_free_clk. The mask must be applied
> before shifting, not after.
>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   drivers/clk/altera/clk-n5x.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
> index 3495283407d..47a51bd5ace 100644
> --- a/drivers/clk/altera/clk-n5x.c
> +++ b/drivers/clk/altera/clk-n5x.c
> @@ -328,14 +328,14 @@ static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_id)
>   	/* Get EMAC clock source */
>   	ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
>   	if (emac_id == N5X_EMAC0_CLK)
> -		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
> +		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
> +		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
>   	else if (emac_id == N5X_EMAC1_CLK)
> -		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK;
> +		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK) >>
> +		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET;
>   	else if (emac_id == N5X_EMAC2_CLK)
> -		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK;
> +		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK) >>
> +		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET;
>   	else
>   		return 0;
>   


The fix is correct either way. Agilex uses FIELD_GET(); Agilex5 uses the 
same mask-then-shift this patch applies. FIELD_GET would be a minor 
consistency nit only.

ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK, ctl);

Add FIELD_GET in second commit and keep the current as first commit.


Best regards,

Tien Fong

