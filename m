Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E7BD58CDC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 07:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 258A083FEC;
	Mon, 23 Mar 2026 08:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="JbtvsgU8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JbtvsgU8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BF484067; Mon, 23 Mar 2026 08:36:00 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27BA583FDC
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 08:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=szRCf9NG39pe0X4vePbMnbtAU000a+4JvlmoR0acpQtQ610jAkMI4kKfW6leXR8GyEeAxCE0o58tXAB6EjBv43b03dF5DCgvROq1s+gcHsENTs6pRQU8UNe9Dm/jlJIiR8Q07hOnvVT50wOyzsOJXbiJPcAcf/h9EXflGg65VA75hIJxlONpK4Y9fMISYtaAz3wJRsER0+wRanI5Z9OOeCuIjDoZY46WjOrI8vaJn9aANuOnyc3CsBkZSF3qQ+LZvAMf6xa8GDsyuvCJul3wyBD8CbwMTywf1ur0JHxCBnUYYazqFQbvVJ6aGSGhzyzb2N8uqz/e6z0/x4xvzM3kmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgozD7E+pGr73eIwnXtFaDBpkJqHvX8nUZH0GWezOqc=;
 b=gklsCOl/zF5klLt0lni0Jvg0vxsX3xn18aEzxUH3NqXWm2nY3x2dyoRA7eIZ5adjnC2qD+nexYoPbJdPRiHd0nbC8PRnRJ8c0KzwJhi/H0cSzJ3vtbaPRRjjZLLT7rvn+TUjxOZFYqM7GHit+98LL1LpdilMxxeGotrN18ePgEiBhkvHkCI6GcK++Lcx3gh8ZaUY7DuNuL3kvYEV63oikox7+ns2bDkhNAE3fjUdE7WJglrrV1MwgcsvSs7SbuVqjT/uzoA0oegIkGuKICRvZaEFR6ddkQ4akEHkp3eGbwOc4RL1HJ315HQlAXZBQ1ufL7BF5s3dqAVOkcU3paZvHA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgozD7E+pGr73eIwnXtFaDBpkJqHvX8nUZH0GWezOqc=;
 b=JbtvsgU8Ad88L5sV2CeARMCNACuLGhA0mYU8Gkpwn/B/uJurwtBPQYlklOg2b4I8F5nWFmzzw72EKLVecaZNehGg7jCMuAxEatkDFrL2JKjqeDcmB39LvswHcummD9Sq+17BIMSq1CbFk+HkQ5PhhLj8ZM6gl//uHfXWKqQAgec=
Received: from DUZPR01CA0344.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::9) by DU5PR08MB10636.eurprd08.prod.outlook.com
 (2603:10a6:10:523::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 07:35:51 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::82) by DUZPR01CA0344.outlook.office365.com
 (2603:10a6:10:4b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 07:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 07:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynoyDbx+btIQWfs1W94JY++f2KacAAooGxPGU8IavwUVmOAxCAQU1lsw5O5N9YtadiL2qGRyGKcxzIhUqcJXHLHxZ8pnHwM6vknooxjPSLQh01OjwoJDt1yPM6ITjhGhynt9O80histhoFGbIl6bt25/AazK6+YLLzJWQC0cCpF+IP7CPfz4EHmIAQGI6ABe3eeVJEIMMGmu06QNpJfN7skyWjCFjb2KTYYYk+kvpKhOlO1umXJtTC5WPW5eouViz1i8qiRo7nIQ36i3Eums6VE2SrQEPA4QIBstBF/j7fmapPvhsxBhpKL991iZg12vc7i/u9TIirVilJ0QpDGCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgozD7E+pGr73eIwnXtFaDBpkJqHvX8nUZH0GWezOqc=;
 b=DMJcBaUUfE5syiJhjGPI9rnO4rZyveWxtskp2wUNl/BPC/NhNaLJ18uF48erO99ilOLEAayiwmlyXO2HT5jFK55ppLIKVbcTVf2upWv01dXrbBoFzbVJXWrQgnbzl/MUofU6maMBdmtvaasS6FX2D703CGsRD4G1E8RlA2dCPXMnzQs/WI3wXEpd0GuMJBiWc5YVWINIxXPe2IgVBsD7wSSO7gDXfiBeIDesjV8uZcCsSHh7gilSndLuRKJXX0EkoI4WWlkLYrBpg9Lm10gNFIL6qK+uMwSY2rCSO9TN8hBT53NZxUcQJ0Znmc/wVTXgTX8aXxYLjKHrODJht269QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgozD7E+pGr73eIwnXtFaDBpkJqHvX8nUZH0GWezOqc=;
 b=JbtvsgU8Ad88L5sV2CeARMCNACuLGhA0mYU8Gkpwn/B/uJurwtBPQYlklOg2b4I8F5nWFmzzw72EKLVecaZNehGg7jCMuAxEatkDFrL2JKjqeDcmB39LvswHcummD9Sq+17BIMSq1CbFk+HkQ5PhhLj8ZM6gl//uHfXWKqQAgec=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DBBPR08MB10464.eurprd08.prod.outlook.com
 (2603:10a6:10:53a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 07:34:47 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 07:34:46 +0000
Message-ID: <1cf1d54b-09de-4feb-b71f-22f8d8afd8c3@arm.com>
Date: Mon, 23 Mar 2026 08:34:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Rework dependencies around NET/NET_LWIP and
 NETDEVICES
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260320205327.3788628-1-trini@konsulko.com>
Content-Language: en-US
Cc: nd@arm.com
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260320205327.3788628-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0498.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DBBPR08MB10464:EE_|DB1PEPF000509E9:EE_|DU5PR08MB10636:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd832c8-13d4-4549-c51b-08de88aecf2a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original: Chtqg6WQ03MmU+xCGWTDJJ09+vLSH8XYJsEz94zcoF2t8d2vx/fUDcKlmSdEn1Kl1B0nFY7rmlqq0Wotj1Jnb7gD3Qs0361SIhUp7/toax1RdhxEXPK1tZnM0+ttbERrqj5pd3OFXHFfSmXz/N02a3fqihreAO051R77w3rVUEYhVE7i1W5GvaO6H/M2NBYrlxUZoL+NCZ2VAK67MYdU0JshOa0i/z1o6pKhU6x1JMyNe6jKv3uBKkuLPdrKBYDAkgt5rx4N4okkDqkGnu1B9MMIT9tRbHNdxtULiPAmxQdWlFh5AKRBZ4jyWMasWS9ihteLyKcq0RUdf5r8HFaOVQJTS+wids+2zLwEYQ26wAx1wg3PzWqdAegHJxSjVIX4UsEhv72fHN67x9sgdCIHaa+PDp4hLbBFLp17agbxOPoRrD5SRQ2UsGK03dJy8HVnGWGZ87UeY1vHv28BGmyBrMSDfk9hwXhYJEqzW4knuI8fPZHAhQ7mB+mBDbAWuR4ACibiA+ug27xptcgpfxMN2R6U8ktWuwwYh6mhnuwhJ/h2Vue/rQy0DS488EqMcH42vouNp5viVCdcPrrbzBMd2Li7XseUB2m9LKM+U+/0AeGU1KZCzRtZwCuTKlyoL42uCMgNMywcsCzbMx3W8jzafc4Tn4T9u3P66lEpCxR8E5k9imobHShkTzpMg9HASeTC
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: VYgmtMaypZ9AW6uXkrYbAsvM65qXPMVn5VNHZiDCiB34u4txKgxhi1ts5QJvAwiOfkOVXcr1k3/1n5MC0lLVCs2TvEMU7MdNa66UMJ2IeSylVyuOsPKVWLy9M4n2BhF6uMiURwyWfpox8b8cBv2vCpthCbEpoAfCPHlxXkY2Xh6ysoDFJ9LqQQ9l5tUqAYcqIAwR/mBdykmNqenm+DfL5T0gxSMLn5F78NUEroNQIbwYybZlF7tleOXQ2FCa1IQ6qIf/56STYVI7VQ6KeS3D3MU0jm+v2LCUrblX7amxSphDCAcH8h701UyI61QsIP2mB3KnFKl3DKch1/PKQ/QNtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10464
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8b3fa7ae-d41c-45a2-c485-08de88aea883
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|36860700016|82310400026|35042699022|376014|22082099003|18002099003|56012099003|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: 9ZSVx3R6fv9zi+NqIZawu8lBQX9N+miznLhkblMIA1PfyEPDW6H0of/m5sXKEr5MRDXpiqy2GGboP4aTkP3X1qbTlmm5lAU43F5crvXTRCphui5beOTBUYrHVmj3VC48r/dE/kKY2c93oI5KAJ8qX3Rpa4CkMZ02JXUBqKVDfklEIGwh7OjweLx/fuKXBHavDuHNrXOzopuzR0nElSDGL7mIZHSx9QghoXA+Rc4By+OqIwU+c9XSsULlaQ27MRaAVQAG036QP9xZ5qjkBg0ungd1OkR2wjBFHsrUIeaLLC7U1gQvv7128BfRy7qSEK/iF8pM6pxKSKww5ZuS7b41uZhSZu0ECt7gcpqLk0jwNaARjb2vwSkXGEqGoZ6FPDSUE8fsqtk8bPJ+aPDPXDqNeALNoUmcV1tEtew4/Y8gB5CELTBSvfnCXnipGSEL2UswTy6CLk+Aw+4uI7B+Hu8WgsZL42YlmHV6oAumOC2ze5cdg6MhWf/d3L3fnZcIFcapnPQijgs6PV0ah9BRvIWTQF70XQ6AQezhi7TAr3ALl9ZHevXkvqW3I04UhCjTLxi4QpcLdBTs4RCj9ksFnm1bsS+F68pghAcf6NSLycinWr56GI5AGssGLdEroViyxitkw3T2CBC9VYa2T+TKXCy+K2id2W/AdXdpnrJM8fYOO2Gv7K+9CGYqNE3n5bdl+5NvihlJRc0WZ8QwbzqzwReE1Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(36860700016)(82310400026)(35042699022)(376014)(22082099003)(18002099003)(56012099003)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0GSCNGX2eKl7aImDtwffQZaHP5iG3QOXFilkO9IyLuwO37o0nwSPN+YzdcD7ySknCRDSgoljkveq5mEGCZqbXNFkC1lKh/OFsAXvKGKh7A9IuKpcAJxzyQPigWfk/frwgGgDn9eVlV8bCj+HUiH0La5SzJ5VmHU5UPXGRnsnQA4PNk2ufZ9QG29lDizDUe98bSwQm2x+xRVKJ4bXZlAd5GZh5iPiYnEeSjnEKg+bJRqE2BYlVjNJmmxRNUJIyqKzPraxylcvov5B8P5pwuPKzMLKw8PMFrBoR+q/LNX/7EYK6zHMbeLWZau7+EnFD26vAw2YObz93oJDLXp27e3OSlk0cESJYrM7RWw0vHM/mYqiEkRB+UOAdNDWG2nIMjnOzaoXxu7LV+A5WOTKZ/9/CNHAEjqK6Qe+wOtLcQRxh3qrTCMOUNzNo/DdH2Svskv/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:35:51.4107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd832c8-13d4-4549-c51b-08de88aecf2a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10636
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

On 20/03/2026 21:53, Tom Rini wrote:
> Functionally, both networking stacks require DM_ETH. This is because
> they both also require some networking devices to be enabled. Express
> this more correctly by having both NET and NET_LWIP select NETDEVICES.
> In turn NETDEVICES no longer depends on NET or NET_LWIP as it's not
> prompted anymore.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> ---
>  Kconfig             | 4 ++--
>  drivers/net/Kconfig | 9 ++++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome

> diff --git a/Kconfig b/Kconfig
> index b52331d6ff25..01708e80f476 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -787,14 +787,14 @@ config NO_NET
>  
>  config NET
>  	bool "Legacy U-Boot networking stack"
> -	imply NETDEVICES
> +	select NETDEVICES
>  	help
>  	  Include networking support with U-Boot's internal implementation of
>  	  the TCP/IP protocol stack.
>  
>  config NET_LWIP
>  	bool "Use lwIP for networking stack"
> -	imply NETDEVICES
> +	select NETDEVICES
>  	help
>  	  Include networking support based on the lwIP (lightweight IP)
>  	  TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 02063ce3aa91..9d4e9f069701 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -90,9 +90,10 @@ config DSA_SANDBOX
>  	  Ethernet device used as DSA master, to test DSA class code, including
>  	  exported DSA API and datapath processing of Ethernet traffic.
>  
> -menuconfig NETDEVICES
> -	bool "Network device support"
> -	depends on NET || NET_LWIP
> +menu "Network device support"
> +
> +config NETDEVICES
> +	bool
>  	select DM_ETH
>  	help
>  	  You must select Y to enable any network device support
> @@ -1106,3 +1107,5 @@ source "drivers/net/pfe_eth/Kconfig"
>  source "drivers/net/fsl-mc/Kconfig"
>  
>  endif # NETDEVICES
> +
> +endmenu

