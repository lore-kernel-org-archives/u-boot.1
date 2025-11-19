Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F277CF2582
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 05:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8717483A8C;
	Wed, 19 Nov 2025 06:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rhDUi9M/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F09783A9F; Wed, 19 Nov 2025 06:01:00 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75AE48397A
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1ftRXQHFS6D2yfbpQFhyq6EYST3PswARHWyNfdaB1bpTNwzp+eYSMFT39io8i1rVo8aXv6MS8uO+9JxpN59a0zCBAbX7ARm8Ufo+6suHolMspGd6cjmED7+NET9Qu2lW9KGQPcLSUsvbv2dZdIcUTAomJG/z+kAa7rAiVZqMgZ6bHA/dpB0vpjygpDeiOKJPjw3UiHpTFP+MkTv7g8iYK0YsKGomwtU3y0csSsOa3f9PuHlwWdLVAALLSIilJMf9tq21rKlG/TJchT8fjdS5lsXqNPpemdG6DzRAkNegX37lYpBxC71wT9Kkky+6sFhKDloWn6LXAzGs1YB3NM8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dnno5f5rVeFXY8byA1WAfYhrNQZaPQMp4VOYxlZ4nMw=;
 b=f/I5S/PL13zfyKAVJk5pF5IYVn5dc7PNkwV4emLUtMWcAKYlsmSEcjA1098Ssud+lqr9OV/9tm9gYFHjONGQT33BKEviJNGUJvaG9gEpBAo3KQgKCu6mz2YIiy8CP82N0kuB0lYkoPe/WKlqTqiZZl5sxyJLeyiwtb85MrYJi2CNzSADdxMWboJP6T6yYI5bCLrUvzhwqHiOhnc329eMEjRP9n6Gw2ViCnULaGcHSWimaD+SOGkYCLvmFWXy7/j2ZzQJ08yPDpKNK4T4KKAqd4NcR3JIXZF19g0etJnfciMGBrPQWK4Nev7l7WPgTr1soqTzyw/VfvNIZkeDkVctrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dnno5f5rVeFXY8byA1WAfYhrNQZaPQMp4VOYxlZ4nMw=;
 b=rhDUi9M/JeUYDBnMoNc0XoCHUU/ePF4MB9tIUvhmi9vr29nD2PhEmyWKQFZCBf132OA8DcAnbRNM2h20KqktAa6w4NuHLmVlkOf++1S5uY/Em3073sbkrcv97SzcFI5+D4NAAau5JOtsrIlVZ2o9g5tJURhoYj3oKO9dja3DfSQ=
Received: from SJ0PR13CA0205.namprd13.prod.outlook.com (2603:10b6:a03:2c3::30)
 by SN4PR10MB5639.namprd10.prod.outlook.com (2603:10b6:806:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 05:00:54 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::40) by SJ0PR13CA0205.outlook.office365.com
 (2603:10b6:a03:2c3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 05:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 05:00:54 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 23:00:50 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 23:00:49 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 23:00:49 -0600
Received: from [172.24.231.157] (hp-z2-tower.dhcp.ti.com [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AJ50j8Z1252731;
 Tue, 18 Nov 2025 23:00:46 -0600
Message-ID: <28d2895c-e6fd-4ca9-a5b9-bd14b9058720@ti.com>
Date: Wed, 19 Nov 2025 10:30:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] power: domain: ti: fix ti_pd_get() to return after
 verifying transition
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <jh80.chung@samsung.com>,
 <peng.fan@nxp.com>, <trini@konsulko.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <t-kristo@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>
References: <20251118122055.1972591-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <20251118122055.1972591-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SN4PR10MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7c4146-dd09-4190-b0d7-08de27289e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUY1cFBDNFhheXhTeFNoWnMyWkR4RmNNaFhZUjhhNXJwS3k0T2R5cndCRnBo?=
 =?utf-8?B?V3RLUDhySWkyUlJZenhGVzJwYVRkRGJGRG9lMVhTRVdIZWtyTm53Z2YrdXVj?=
 =?utf-8?B?VWdTRnY3WmloOE1zeGZtTFBmeWlzR0hKWG5vdk1nV0VDaStxb1JESGMvandP?=
 =?utf-8?B?WVB3SU1uU1M0ZGRKdlg2UVRhVTVyVCtLMllQdmh3WlJqRzFZRzF1R0htSE9N?=
 =?utf-8?B?b25VMFVsZFNTMG1yOWJIeUxkRUd3VzduN2VVcnVPWG5FanllTEx2WEZIQUpC?=
 =?utf-8?B?L083MHA3a3FjUy9JaEMzMitkM2RJMFNMZlphN1M3NmpJcWFmclZIZWtZMnFh?=
 =?utf-8?B?QTk4alVScUVyR2Q0VEovajFBSUJpMm0raTZkRVNQYW9RaC9mYlJKN21wUDhB?=
 =?utf-8?B?bTZVTDhNYTA4MmFTazNVaUhacWY4MEZpYnB0d3k1LzRmNlZwS1B3SG84ckFP?=
 =?utf-8?B?a0xldm1TNWtXN0xCOFlHandqMlF2MjcrMjNCUHYvM1FPUlp6em9pVHFvek1s?=
 =?utf-8?B?U2hYZ2ExVm5rS2EvZ0Y4VnhKZExzVXhrSkFsd2t0NmFQZzlIcnlXc0pKRjc0?=
 =?utf-8?B?aDB3L1F5ZDhTbi82MVRpTkgwZDJydWpOWk1LeW5GUHpObDNPS2dRV3IxbUlK?=
 =?utf-8?B?TWFEVHdiWXQ1emFubEFQdTFvSWNQQm1NWHd0YUN0ZEFrN2RzMmNqZk4yNmk2?=
 =?utf-8?B?VzROQkpZbkVDbHBvUmhMSWNyUzJLUTVLWUhhSHBCUGZVZ3pqT1ZvekFUOXhV?=
 =?utf-8?B?QlBGMXdxMGRHaXFubE5RTmpDUStSYW5rYnU3cklsVmZMeWUvSWhWU1NQL1J2?=
 =?utf-8?B?UFpaZk1oWWxIWGtVdFVGOVBra1VEbDBiTVREUzhubnBSVXZhaDl6QWZyaTl1?=
 =?utf-8?B?VTRQQnlBU0dYTUtWVTAvWW5uQ2tjTVNiUURqR1gzOEM2RmRML3ZIaXkxR1Jp?=
 =?utf-8?B?NnY3RHhTc0twUi9pUDZWMGJFaXVzcUptL0IwVFJuZ3duZmE2UHBTK3pINFpG?=
 =?utf-8?B?UUxvcHFETGJKSm05VmFxZUlxZ29kQmp5dTlHdzNVeVJVWkJ4NkMyeGt0dStY?=
 =?utf-8?B?ZEFlRmViQkQ5Y1RKNzZQWUJKbExHUFVQUXVSc2Rta2dpcllCazhRcXhneE8v?=
 =?utf-8?B?RUZvQWdWa203SklEMmExY2FFUXpaalVEUkthUi9kVDJTa0E5aStzZEoyYU53?=
 =?utf-8?B?NlBwcGJ2S2Q3SHFZVVBla2FZMzhjWG9wMVpYRS9OeXVSQ3NSdGl6UGVYQmlB?=
 =?utf-8?B?dEppTGNCcEs4NHBTK3pjQkVHZXJoTExzYzZZTjZKS3R5RzVYL3p2bHJ3OHM0?=
 =?utf-8?B?eEtIR01QUm9vcHltVUtzTnZUcnFwSENiYjUyakZtQ2UzKzc1TlRaaXVDY1VK?=
 =?utf-8?B?aXJDM2pvREtaTlNmN0E3c2pKQXIrcStGaTJmZkZoMlNqYUMwOHhwV3R1ZHVs?=
 =?utf-8?B?bnV2MUlycjNKaW9LSjdrbS9wU2RDYnpyWERiVW9XdUlmZG1yL1NqQmZrOU5j?=
 =?utf-8?B?M21aczZyQnlXL2pWd3NHVFlVYk5LSUF0M2pGRHFpMDk5WU13aGd5UjZ0Mjdx?=
 =?utf-8?B?eXRqSnVqbjFVRmZzSWtyYnhGVjlQS2UzVXJaMGNsV0FsWG41MFYybjJmd1dq?=
 =?utf-8?B?N3RGR2x6WHlZZ2JVU1p3Q0UxMVBPTTdTclFGWjhNY00rNmRDMVRYeDRvYSt3?=
 =?utf-8?B?Y0t1NDFUSlJXbGxJV3BydmUyaDJxSWVkSzlHV0J3Uk56YTRHeVdPOHZNdFpz?=
 =?utf-8?B?U1dCVmd6TmdyMklzL09PNFR3VnZCeFl3MkRJUDZnTFNHK0xVWlphaU9LNTlR?=
 =?utf-8?B?VTFZRGdndnI0dmF5RFZLeHJIM1A2T2srTUllUE5jcGxDVmxmb0p5bjlUY09i?=
 =?utf-8?B?cEhiZnV6OVlNOVhYTUdySytrSFJnOUZxdHJucTVmYnlvZGhqL1BYUFJxWVFC?=
 =?utf-8?B?N3R2RkxhKzE1dzM3QW9yU1Y0dS8vSGVDd1o0UEFaOXBqT2YzbjdYY0I5Tity?=
 =?utf-8?B?YXJWb3l2R01hY3JiQ1VCV1Y0bFBuc1lCeXEzY1kzcVR6TGdOdlNJN0IyYm5v?=
 =?utf-8?Q?ZnmgOz?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 05:00:54.1828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7c4146-dd09-4190-b0d7-08de27289e5f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5639
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



On 18/11/25 17:50, Siddharth Vadapalli wrote:
> The helper function "ti_pd_get()" is responsible for powering on a
> domain if it is powered off. In the current implementation, if a power
> domain is determined to be powered off - no prior users and the PDCTL
> register indicates that the user desired state is OFF, then powering on
> the domain constitutes setting 'PDCTL_STATE_ON' field of the PDCTL
> register.
> 
> While the current implementation indeed requests the power domain to be
> transition to the ON state, the helper function "ti_pd_get()" doesn't
> verify that the power domain has 'transitioned' to the ON state before
> returning to its caller. As a result, it is possible that the device(s)
> belonging to the power domain may be accessed before it is truly powered
> on, leading to a bus abort.
> 
> Fix this by waiting for the power domain to transition to the ON state
> by using "ti_pd_wait()" before returning from "ti_pd_get()".
> 
> Fixes: 144464bd2c67 ("power: domain: Introduce driver for raw TI K3 PDs")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 91861e5a30d Merge tag 'u-boot-stm32-20251117' of https://source.denx.de/u-boot/custodians/u-boot-stm
> of the master branch of U-Boot.
> 
> v2 of this patch is at:
> https://lore.kernel.org/r/20251114150243.96429-1-s-vadapalli@ti.com/
> Changes since v2:
> - Rebased patch on latest master.
> - Fixed the parameter passed to ti_pd_wait().
> 
> Patch has been tested for PCIe Boot on J784S4 SoC and the 1 millisecond
> delay is no longer required in the pcie_cdns_ti_ep.c driver with this
> patch.

Tested the patch on J784s4. Following are the test logs.

Logs : 
https://gist.github.com/hrushikesh221/d21c33bcb88f7a271ae5aba66954cdb2

Tested-by: Hrushikesh Salunke <h-salunke@ti.com>

> 
> Regards,
> Siddharth.
> 
>   drivers/power/domain/ti-power-domain.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
> index c3519307340..a554e659392 100644
> --- a/drivers/power/domain/ti-power-domain.c
> +++ b/drivers/power/domain/ti-power-domain.c
> @@ -227,7 +227,7 @@ static int ti_pd_get(struct ti_pd *pd)
>   
>   	pd_write(pdctl, pd, PSC_PDCTL);
>   
> -	return 0;
> +	return ti_pd_wait(pd);
>   }
>   
>   static int ti_pd_put(struct ti_pd *pd)

