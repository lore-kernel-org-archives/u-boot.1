Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5E4C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 18:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C8C3807B1;
	Sat, 15 Mar 2025 19:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="biQNmCzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C51280C93; Sat, 15 Mar 2025 19:16:45 +0100 (CET)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn190110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d407::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 303C68058A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 19:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tianrui-wei@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsiTKd/W1j/0+Oywx3bXscyZYQUcPoGHfNS5w7YYneOCKPMRzeys5lMfWVUi4gt0FSBq+Nz//y0oWhz2mZrrv2qWyW648vAWFk/Iwp6gHNdkO7+o3h3Dyw9qRe+IbNdUM+9NkSAp+6m2dbEZufh3oOWs/uMynM7yODJuzkWD3Y46udm4W5dp28zjhqFUyCDuKHvjpJ0/Oq914SI77wJ5Vog5l7mr68/aczakmudFpGx3krrY2eI7L++PciTzQV0M9UCEUbI/nCSq/M6G/PH0MxkZbzv5ArMZOQZJHjbAXXMp+JsQHMeXWbaccXJoUMx7wYnHl937os1Z0rGzHFq0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkqBNVx1WnyD4AWCLkHH4U5Low4suxSRj5Gha9Irkrw=;
 b=p5sgjZ3PJxeq2kXprB5o/dpfkayCg6c8PcxDMP1ac2YO49S3igFbNpJ3DsU3+BHHzGmuaCK76ZfEyp1u7psAieP6laNulHnCwExs8GSHCjau49Q2fswl4I60sgWO9Jy7vFdLQ2YoPE/QlLL+FyBkBo+o1wyqFNCaiJZvaTmsVwMKyw0U9zysH4KGqdPGHIXCISWjyKz831cU5M6oRTL5jKi6hJBgr4eBd7WTpUPuRmtUgOdffLXjA73YI23Dg/J/2irWu1gqA8VGla22s06OhHNFkoQQk/s7Pzh58QD/xarX/J1GCAsv6eLbFlXfNJBs4D2ii31+JC3hLdKEkZoYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkqBNVx1WnyD4AWCLkHH4U5Low4suxSRj5Gha9Irkrw=;
 b=biQNmCzhmWoBRMjmSF0EKKoxgcz2JvsljrszSqzzjjN+iYAvPxxJWMurgBEcVQDnhjzQK/j2CSQcLIe2R0gCmfq3VimlUAYZ+0r47eaD3CkJpgagz6pTP490hC+4V+KwcuA4qbFGU3C8/iTv6WmzD4XOfKvyR1FgeTHyfKuZ5UiEYwg5Y8RCQiDbgj/U752XPlYerNabct9kga4bc9FWT8faHyb5uLhAhc0H3nqve0xgGgilr3j6iH56FkuMk7vToBrSLR9H6awONkTmbrdB5r2xlDY69wW0Lp1DUsLytmcGYWxJxtFQZeLgRtYz0jW1z4QRiuQes72Ks4YkXCoroQ==
Received: from TYVPR01MB10830.jpnprd01.prod.outlook.com
 (2603:1096:400:298::13) by OS0PR01MB5748.jpnprd01.prod.outlook.com
 (2603:1096:604:ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Sat, 15 Mar
 2025 18:16:39 +0000
Received: from TYVPR01MB10830.jpnprd01.prod.outlook.com
 ([fe80::7b6a:854d:9bd7:b84f]) by TYVPR01MB10830.jpnprd01.prod.outlook.com
 ([fe80::7b6a:854d:9bd7:b84f%6]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 18:16:39 +0000
X-ME-Sender: <xms:_cPVZw385h7NUXs5nCLaSbty6qF8NqAgCn1v2KrimqkwWioW8wyjAw>
 <xme:_cPVZ7Ebv5i1qu2PvUhVgbuLg2NL8Guh3C-mH7WPd9ucAWj-j-4kkWUyGonbBQVR3
 O4ZAwvxCsypGHiJxCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeeggedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
 tdenucfhrhhomhepfdfvihgrnhhruhhiucghvghifdcuoehtihgrnhhruhhiqdifvghise
 houhhtlhhoohhkrdgtohhmqeenucggtffrrghtthgvrhhnpeehteevfedtffevudeuheei
 ledtheekhfevteekfeehtdekvdehkeevtdeutedvgeenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihgrnhhruhhifigvihdomhgvshhmthhp
 rghuthhhphgvrhhsohhnrghlihhthidquddvvdehheeiieegtddqvdejieeifeegkeekqd
 htihgrnhhruhhiqdifvghipeepohhuthhlohhokhdrtghomhesfhgrshhtmhgrihhlrdgt
 ohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
 htrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhi
 shhtshdruggvnhigrdguvg
X-ME-Proxy: <xmx:_cPVZ44ozLjSQgOp6RtLvI93QEyFVdcCfLik3crNJ0B1cSlytjFuuA>
 <xmx:_cPVZ51EKOc9DyP7Ssa3-pZAmbxbUZovoCji75p8L_aUmg7JcMe26w>
 <xmx:_cPVZzEJyjyFB_iRQIpK6ofzZ51aPtdTfY5_85vu0jmJ0dpACtu0mQ>
 <xmx:_cPVZy-MWt7cHB2rAe5wK1YNlExDNVhbKbhtmDsLJWgG7lbNct3wSQ>
 <xmx:_cPVZ4l7cXaPNQKdxLwSLCsICF-wMRJGUn7l_ggNqEs4YZjw_amvanKL>
Feedback-ID: i253946e0:Fastmail
X-Mailer: MessagingEngine.com Webmail Interface
Date: Sat, 15 Mar 2025 11:16:09 -0700
From: "Tianrui Wei" <tianrui-wei@outlook.com>
To: "Tom Rini" <trini@konsulko.com>, u-boot@lists.denx.de
Message-ID: <TYCPR01MB1082503276FC147D9C6C06720F6DD2@TYCPR01MB10825.jpnprd01.prod.outlook.com>
In-Reply-To: <20250315012838.399290-1-trini@konsulko.com>
References: <20250315012838.399290-1-trini@konsulko.com>
Subject: Re: [PATCH] openpiton: riscv64: Drop unnecessary 'imply
 SPL_RISCV_MMODE'
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:91::22) To TYCPR01MB10825.jpnprd01.prod.outlook.com
 (2603:1096:400:296::10)
X-Microsoft-Original-Message-ID: <3e11ffdf-8d79-445a-9ce3-f6510ddb4a30@app.fastmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYVPR01MB10830:EE_|OS0PR01MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ea711f-0497-4a18-95cf-08dd63ed8717
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|8060799006|5072599009|15080799006|19110799003|7092599003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v+7i08pMnNRHvbloWdzrMQeHFy+iPcgOr/VtWkGf2GxsCOUmJcycd60QKjAw?=
 =?us-ascii?Q?AubDZctj92iWRemoeeN03NPCt6ykO25d27KX0OSAVmyL/he7gymb5XckksQm?=
 =?us-ascii?Q?iNjG2IuPfn+fKFGcnp8y1x6ttHvCJ/Dpe3azW2ufIf3thrV1vEb//hpBx1sY?=
 =?us-ascii?Q?BrxYYd2vdhrILu9iUD0bZY0PZ4DuA/1eJZDax81XTUyfe8S041DeNuA49wii?=
 =?us-ascii?Q?WQRYRTo0qrB+bUFvwo4ZD6Z3H9vKzMO7J1YkAGWMcfQlqThpnAejRUz3C88Y?=
 =?us-ascii?Q?/qvn0pMtqFAkMbiUZVdUa/rLB/syfWlaiygjOUDDLlIB/QQKw/DynUz37lao?=
 =?us-ascii?Q?YomaswlOesv79XFGONoe5mvMV43TSlIu/1M16kXbh1v0H04dIKiQmuLBxVFV?=
 =?us-ascii?Q?zqx+heETOBPD6i0/gkP06SeJvY59tooxpIsOv8BYZi8RAyslw8zCNO/A8n3V?=
 =?us-ascii?Q?Do5fbPEU98BP2xXXC8M0AJxoT6mjNKyLP112AZ5CymDcfEC7+l2h/W3QkwNS?=
 =?us-ascii?Q?zwrHwK30S1omNSh+uZTL1VvCpH6P8MNIC/NS7APEe8tXtw1MH7ZbFOyStYqb?=
 =?us-ascii?Q?kCQv3lBYnSeArsP6YHm4O7IiiC8+lwgy9I0SiZp0NoZcbEQfTJe+GInd25ck?=
 =?us-ascii?Q?9ouvUAo2AZixsRqTmDvAya+rKREe40Q2pbTXxQ3nAr5QEyGNGQUpYT9+zIz+?=
 =?us-ascii?Q?VCwARNl+AmtnKw0ZOQZ3UIGF/m7nVPDcjX6sEuoV3he9qtpi35um78D3vkdd?=
 =?us-ascii?Q?Y/lh9dljUf9eABxkV++DSzljyzjGmVuiqwmru77edWFev48wd2VWN+9v1epz?=
 =?us-ascii?Q?uGJwFpnpIxIPQpXilKuiTbvBmhfzg1E4RPTrdhkE8fu4E4Gdw4shHp8uHWwC?=
 =?us-ascii?Q?gsavctqY7OjRqjqfvdzYVwPPyqOXLG0BPhC318y4rbLNCN7V7uGdhWlC1pma?=
 =?us-ascii?Q?l3WXohjBvBRvFfmuI4jeCsZzzkb0ZcI/P1jAl8iB85H+y5++6mycWJKJitDg?=
 =?us-ascii?Q?ovOBzWW8pmaiDFvCd/DP2CitbdLYfVBrV7h58YPP1Z/ed9XOWExJuieIuk9D?=
 =?us-ascii?Q?QOmTR00RD7J/Tzip/KWOTHzFFUOoEL+D1VLPjgeQ3AowPEL3m+M=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yHuWxve0OZJ4HuTPs0GYcDeFygsK0579/Knc1SPVXYpU6R5JccEljxMEh4T2?=
 =?us-ascii?Q?5PApL+ruz59EcWJ7//IQHw9kKxA+XD0umxiXyYGwaWmI1tXmbfCFkAccCvJX?=
 =?us-ascii?Q?trqz1sny5J2yY5zV8YGdXaSBCmEIVkjaCD/Ds1j+ulNxsGPZ9j9HOfvxasAY?=
 =?us-ascii?Q?/3Ls8oNzhCvhzAo8o/F1TbzmW9AUPHoqigsAeXArDs83d3hmdBL4J2plZ9Mg?=
 =?us-ascii?Q?qvBRAy33BrGXeqJ4yykO/CMuIcINa2EXBdjA3gJioFVKqrFRgRLYDSulGkKh?=
 =?us-ascii?Q?WEkvXnJGsEfebIhDXxP+SbKZHOsqZb30hzmS4V5dAECVeJBvjqHJQFNhox2R?=
 =?us-ascii?Q?NJB4x+hC4owPhlPsdEFz21tMBrLs5XCp47i4LtlKq1C4j6YxfMHDSsoPV0uU?=
 =?us-ascii?Q?OwiIXXPZpG5Js2uQ/ZB0B4Hp52WPgAgi4RfROH51wICHo++QZ+RrDmEcOatm?=
 =?us-ascii?Q?u5CwoAiJWkOnyuI5kKRcBIepCeuZ93TGbsnDl5ICKMalwk5pJrlkZ8ggjQYP?=
 =?us-ascii?Q?+atDh1rCboa9BEvaIPFv7b/8cvIlwx+Bg6xsPtlrzLzNRbd99pPF4wRe86sJ?=
 =?us-ascii?Q?zERLduehGf5y9UX3OO3lYUx3VkhhzZ6u5fg1snW4ayFj9WOGi17Ii0qsHQEq?=
 =?us-ascii?Q?ajBEj1MVqYCXDxBMLmJj+LMyQm9HlZ1FLqnXerxBUr4CVk86qnESj+h2Tue7?=
 =?us-ascii?Q?+fKDqMka6bHTxjSFcrX5h2IL4vYsSbyvw1F771OMrJIScGyK4Ym5wD12pRjd?=
 =?us-ascii?Q?WDIsyowqcOuwSfP/EclvpNgyRG0rNO5ViMghgeC5UmOdjfTI4Y2UDN7/C4Rh?=
 =?us-ascii?Q?Kl70XD9YWUg+tmzYYwnfmh5z1B5yzFr5+XD5IFQ3I1Ef+tG16CMjryfieZay?=
 =?us-ascii?Q?0O/E8otAtPl6mw2HcTRrCxBrdAE+ABEOmptREFFDYQjYczhtiRWMizhDiVjJ?=
 =?us-ascii?Q?EMqOHSfnXjSKLULMK/eaeusTLUlry7micpci8Jj5oRI2rD5E4WY4agTMhGO+?=
 =?us-ascii?Q?e+JVU0laOsQ57NtWFHMveoEX/KACopOhLd3ki15WNMM9M2gArxiq4uENXrAX?=
 =?us-ascii?Q?US8blidMCbgZhfg3HWCY4e692J4k2pij0u74Hox4oFUFXpH+6CC7yAtnOg4+?=
 =?us-ascii?Q?Lyj/K3Tpc1VG+YxFqxwrlxKw/HmGFV3C7bXfnYPyInGLGSrFRddEiTiSJgvs?=
 =?us-ascii?Q?360qsSYbDEbaCQwIatE9QLIDKM7fUDUT31Wxmq5FlLBv8GO66VeX0DplARSI?=
 =?us-ascii?Q?HS1Bzc9azxTNZZZ2LsVT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ea711f-0497-4a18-95cf-08dd63ed8717
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10825.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 18:16:39.8203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5748
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

On Fri, Mar 14, 2025, at 6:28 PM, Tom Rini wrote:
> As the code is today, we get a warning about "select" statements on
> "choice" options not doing anything. In this case, the option
> SPL_RISCV_MMODE is the default.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tianrui Wei <tianrui-wei@outlook.com>
> ---
>  board/openpiton/riscv64/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/board/openpiton/riscv64/Kconfig b/board/openpiton/riscv64/Kconfig
> index 21da1dc346dd..e4bd8903aab9 100644
> --- a/board/openpiton/riscv64/Kconfig
> +++ b/board/openpiton/riscv64/Kconfig
> @@ -35,6 +35,5 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>  	imply SPL_SMP
>  	imply SPL_MMC
>  	imply SMP
> -	imply SPL_RISCV_MMODE
> 
>  endif
> -- 
> 2.43.0

Reviewed-by: Tianrui Wei <tianrui-wei@outlook.com>
