Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4587910854BE
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 08:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 832178407F;
	Wed, 18 Mar 2026 09:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="E6olzyVH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E6olzyVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5AF84083; Wed, 18 Mar 2026 09:34:39 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D2B83FD9
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fwgKIfukP9LKpf9NJCBAfJM1AQX3Htd/bNbDmXhWp9TjtoWYxkyiifTZwIyk85ZHEPyTjVeRLtjEpRFnTXyqLbj5sEYJZGsbJ4DzG7VNfK9IhqsPUBBmgCwnCuZiHWbJwTZN4Hvo2NgQ70jj8ACKuMkxMkbnjPNOw5fYp1BAc0H/fGaQGCSOec44rYUtmnxzZHAet8X3JzKXHnzIqhG5Ag7BfgceS/cB1QUxK4vHGRRI+blgalQpnnzN00Jp68Hlr204UIkQgq/YJ7GSX8IhEksofs3ikmMA4C1WVMF+d5Iq94fHzAE4zgsiqLhhsMOP9TR97NbvgjbXO+WTCx7+Gg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVkCtx+JjhTHkt4MkcaFl9gZhnRcEt9p74rTc06/TCI=;
 b=E84mOiFRSWvIs5eUYEcaov96SyQEzoQvJRymeIaEpcL5tmbNnDRy5g0Rh+wqAQ3HVLDRoRIhrefqOAEmOqtrUfZ3lbF3cfOg/ho5xDvWKFRUDJEejl82Qd1xizu0aBSgve1LwV7qYM4iUn8psGoNDr1oTv0vRJpWkCJ/nj06wQy5qDRjHgX2iL7/DIX3Gsl0xV78gtMaJWstHEjBzvZ7gy0kAispAEvEPnswMsqTURbYh26JZEs1VGxJvQJRkzTx6fwNrCStSV3mjhg9Lj9V7YOEbXxt2WCiqtniTXf8LJ8997K8tHMRG2pAdAHf/kJQBjXDesMOaVA86sNA2gDF+Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVkCtx+JjhTHkt4MkcaFl9gZhnRcEt9p74rTc06/TCI=;
 b=E6olzyVHJc7NySxPsSzCQkGtbgSXnXiv4ruguDfmCr2OtUfRwLVvdH119PQXyYkAI3SOVg3QEaECZq3jsd+P1gEs4KFrA1xJ2nh0bxf5fe/dHYRoRTM2DJ4oZRR8Y8Yxv18l2jXSM2/s+MzH0c+I5ID7AN8iC8ndHrDoqi2F2Co=
Received: from DU2PR04CA0037.eurprd04.prod.outlook.com (2603:10a6:10:234::12)
 by AS2PR08MB8926.eurprd08.prod.outlook.com (2603:10a6:20b:5f9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:34:33 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::5b) by DU2PR04CA0037.outlook.office365.com
 (2603:10a6:10:234::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Wed,
 18 Mar 2026 08:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Wed, 18 Mar 2026 08:34:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBHi7x+Es+byhirAtnMhXqsW63djl/GFmVwH0QcB7sr7fpte1GDuylANufMBSVMd9+3CC0A6A2GYKD2WxWUQjjgRBOe+oA8iuhpMlx2FnyLcvkEtOC9YemYi8T+Nb49Wx4pAL5ERzrqu/2X6R49Ey8miVaRqtebCf4g+pfkTRDP+gwPFtGsJDUmzL/jSKEWV6eg1f8BrjUHsnbPkTqFB1DB6gWHfN4mSP2zaA/5gPi64oRTY/vC0SpJoASARCjLRHGq9sLWT9jihNurqfItrbztGRNJ0qfhUAz3TENeNH5RS1/YUwY3DWYnw/18TPt8rQG4Q9Li2ob8tQSBnP08WKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVkCtx+JjhTHkt4MkcaFl9gZhnRcEt9p74rTc06/TCI=;
 b=cKz+xfZyAU/aRHlvc6vxlKx7zYGfyb3Dma5pIEItPBpCe5if+WwfNLjYiy+3btk7+HBjl6eQ9W8bYMQWARzx+aFQiIxWQw70F7RpY1QrTPvxvs1rm99B75ka8yJPJjqqsKACn+s2767IAUiGrjnmuYH9U989c9+LGlz87GNDebEpHN+F5CvYXfR9QaK5Mv6My4BmSai2gmHUqgfb5X0zi0rs/I7eilVU2T8mjTdkeEdhVNOJPYXPLIZplr6IyJICwhKPwv1YpsifFB5Sn19zznfoq4EWeMxi/V/O+cEdJW0bbz/zIVLekpYokA7hv5j0+jwd/DI2/aU45Ap3RIYjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVkCtx+JjhTHkt4MkcaFl9gZhnRcEt9p74rTc06/TCI=;
 b=E6olzyVHJc7NySxPsSzCQkGtbgSXnXiv4ruguDfmCr2OtUfRwLVvdH119PQXyYkAI3SOVg3QEaECZq3jsd+P1gEs4KFrA1xJ2nh0bxf5fe/dHYRoRTM2DJ4oZRR8Y8Yxv18l2jXSM2/s+MzH0c+I5ID7AN8iC8ndHrDoqi2F2Co=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AMDPR08MB11333.eurprd08.prod.outlook.com
 (2603:10a6:20b:71c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:33:31 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9700.025; Wed, 18 Mar 2026
 08:33:31 +0000
Message-ID: <fa849a97-83a6-4895-8723-1f96a4292a6d@arm.com>
Date: Wed, 18 Mar 2026 09:33:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Rework some symbol dependencies
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260317012423.4162427-1-trini@konsulko.com>
Content-Language: en-US
Cc: nd@arm.com
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260317012423.4162427-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0673.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::8) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AMDPR08MB11333:EE_|DU2PEPF00028D08:EE_|AS2PR08MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 214a38ab-015e-4312-e22a-08de84c92e5b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info-Original: kHCrvqfu8PDxyWkEQceQVnoFTXD7uEEAMwC+Jbv19bAtzmlJruys7+syHHrlGFlEnMKokOTeqmCljeMwhzxevCmyEfO7b0nSzg3LG83XXe4+Dvhc95QncFU2d4ybFAo8SokXEFT4v49M8uqugfRxVoNN+ezDT+WUNzdNzYU9wwu+J3LQrSIKCcpKHVcTPlLCr1CCIPtw7dP9Q9hx7gLrUGEKNvpOkeSxszFC55R5UFOx4Nbo8WVZUb2G7pi+gRXFh2WhmzUlMoJlYNq2GXoYAZBWRFgRQ06a3G0I2VHa3tLauBuUuFmnhn+DYR7O+3zB5zSvBR2Fqx1thEPgf10HfU6uPitYX+T/k41ntrpJzo+UmP/YCu7WQJsf3HmkGM6m6XRz4WcllqISvImQccTpvu4jMvtt88Tz/3f0YkRROD+9Zua2IkQt6+d96t+VNPtmaNiUMU7SIoWI9wmNO9bIlEEFdOy9DodPCxCSjIGH4x0CiDok1ZHyhHdAPgnSEscjQ6ziiqB64jLda8gDdTBHkoSDN4ojOekch55HxsIwU2OJYk5jZf4nxht50bUfdYFHGdYAx0h9KkQQg7tOIBZxIY1pi2cL87zNM4ia7q6gEKpNIqB4+778Vx7zbcnWX8M7ZycHkXr2TPhcBf8u/8Q6oQggPygXkr2gGV0xViiLyR+UBM7wsXY4DPhUGHGMXFMMSQkQXiv+iFRl/crRoA8TeqdX/DB+WT5ZpxdtBHHhqWY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: HXpQDtx6Ra12dpwh0tUreWzMTN7yN2W9F4vO5ylWz9hnqsBCT1O9UOuFSDnxzXewtDEFe+NLq/zs9At62YEe0mB89iMTpBGDN2w+1rY4kuP0mRJMFoiRhzlhjQ1GY9u9JftdjSqmOROgIPBbpUvZxjl7PTWp4GPvmr7dW9OpCb1CGh98PSmPGUds6BZxVn8/t97WVhOI2ageCmq8+I3XLDUCjeXnCn25Yt8Um6pMUEOcnpOaoTOGCXzPeFloKuxn4Vp31QSPtmQcKqDt/Y23nG5kqzOs9eA1yoDbt8cLq0nwzLir53DSglydZvBULUyuw8s7K0licvct5WJ+lOZ65g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11333
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 15643959-ef87-4d3e-7d9e-08de84c90927
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|14060799003|82310400026|36860700016|376014|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: u/mweo+AWKuZdAIowMKXI9Ia5ECk44FqlldKQ+qToH6uIDslImZ27s4iOy4RDSuQK3IW7+y4pB0sPyolsseuTVbdWS2qjPHlHjUc5L2dWflaxPb/uVHrn/TGYk4pY27QUBF1LGLxmgMnx5Tb+s5sjIhLs1X3EjMYpguh8bG+jKnKpypGdp1D2rA/H9SjErhUH2+6u8sFo16RTULCvc7lUynJrqPjCMicrU1bxGBLtIqDt6hGt1ITZI5kUrPWFM4qTjq/3zjSq3GW5yjXxi5x3WA/pvH/YKquNwcQiiv6qiqRZGGwrHiLTf2YYgQZQhvxQjVum2oqzvLUw5JIluJUcJvFj/JcyOiWzDlOEyqrJnRjHLucz/qJ1xuxGRjrZ6LEHFKJEWbMrtdNmljcUxBSVLOQEYxt6DJd08j+nJ0SmI0I1fmQnMkb4xouHKcKp6VWFYIguEbTpDE8E04M9KNAdqL1lDGJc3TdzCQmScgDXzg2wH7x/JZBnOV+/09+3mumOiYIJlga9RNEqNkFTvV8gOkRPTN7NK7HOMrJvM1nPf14DfNKtJJCy6FsKlA57xF0nzYt1rFDVZbiXOpLPzHiZK1/whln97QWu9p2mGN+3axSKmr+e89Ipr7IHUjAx7Fq/gCu2RHteyF3dMMlVxOvvWRrv+ttZdxePlGfhDvfYTFSmx19uOJezHtvFD4hBR377vSclPFQQMpyiKAs+MrZYlpacnHVtCtVM7scoAyZicr2LoYsdDdd3HSC5aon+0r7wtLK6A2SR/D+emxgWrP82g==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(14060799003)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lX8OWJ8g+UHtAeem5cBqtQrBpfAEulEpCjGolKSLyjtTKLfxCJIeuZvn8iRkJRh1MQzd6NMtNeNMeyk+JEvktXBI5pl6twag9fXvsKq3RGDPekL8B4hxQUBnx16deRskoWlm1eKvbCmC9TrDeKgCfmNcLagpw8j+4+caif71nLzc7QRmN2Rqqc+N71zAVmVtQJ+HKuC3qJsFRmfr/TQ/KJV3pGZcazmM4OEjHCr18WPJgbMUG5kfl94x3goq64j59GI2BLpQU80/INvJqFP9tQgmOqJKApnoCjVsO2g79q7jKSk7S4sZpluUsND1Q9oyVf1lHgsy6nH8i4cVrUSOs4676prI5NOZChn+g1/xTvnHwJcCGX/+Y0fMiGIRoJWCwGlvhb/9kO7AkZuEmNFhlKvvZ8Q9dF8IUbhKaN7vJnJe3/e5OdBYmTO+owT1cbne
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:34:33.3801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214a38ab-015e-4312-e22a-08de84c92e5b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8926
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

On 17/03/2026 02:24, Tom Rini wrote:
> As exposed by "make randconfig", we have a few dependency issues with
> some network drivers:
> - Both HIFEMAC_ETH and HIGMACV300_ETH functionally require both DM and
>   OF_CONTROL. Further, HIFEMAC_ETH needs DM_CLK not just CLK to be
>   selected.
> - BNXT_ETH deals with it's PCI requirement in a backwards way. The
>   symbol PCI_INIT_R is board specific, PCI alone is required to build.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> ---
>  drivers/net/Kconfig      | 3 +++
>  drivers/net/bnxt/Kconfig | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index cd07b117a5f0..02063ce3aa91 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -979,7 +979,9 @@ source "drivers/net/mtk_eth/Kconfig"
>  
>  config HIFEMAC_ETH
>  	bool "HiSilicon Fast Ethernet Controller"
> +	depends on DM && OF_CONTROL
>  	select CLK
> +	select DM_CLK
>  	select DM_RESET
>  	select PHYLIB
>  	help
> @@ -996,6 +998,7 @@ config HIFEMAC_MDIO
>  
>  config HIGMACV300_ETH
>  	bool "HiSilicon Gigabit Ethernet Controller"
> +	depends on DM && OF_CONTROL
>  	select DM_RESET
>  	select PHYLIB
>  	help
> diff --git a/drivers/net/bnxt/Kconfig b/drivers/net/bnxt/Kconfig
> index 6ff3ffa137be..e25ed479678e 100644
> --- a/drivers/net/bnxt/Kconfig
> +++ b/drivers/net/bnxt/Kconfig
> @@ -1,6 +1,6 @@
>  config BNXT_ETH
>  	bool "BNXT PCI support"
> -	select PCI_INIT_R
> +	depends on PCI
>  	help
>  	  This driver implements support for bnxt pci controller
>  	  driver of ethernet class.

Queued for net-next, thanks!

-- 
Jerome
