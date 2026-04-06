Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71487FB5168
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 21:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 051C183EC6;
	Mon,  6 Apr 2026 23:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g8T/XJfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E79184034; Mon,  6 Apr 2026 23:37:34 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4248341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 23:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEdZDd0K6fidsUvw8QNtSfg5C306NZ+4MwgIDmRzrQEwF88k3VBPR2ivxcNRLEJoSNsXvNxo3yr/lA33BirT4oCzheXUSPrjejhIui3EVxgH5rboWTZe2hr1kZbNkcIhwFhpkLnToTU4OdE3mIac6Ri1FuOZFPsSXngWxNRFHIENknHLP1pPp1cz2kH/QEKKFLNr18tgUZ0CZlO3/mP8QADU2P4CWb8Z2v2ecXK1QRKf0onqdJqw4GVluNbZZFkstNumY0UO3CusXxE1GnJRqmOIahd2Yq5aRqRDSbyvhNmA5wcDCjuQXcECCrGtJzqpX7/87HjK1xNCGeuEh4sMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH60lmRfjoR7pkuzqFfhovmJJgU+FJwKw2gracvwZCw=;
 b=Yn6K15S1yB6AT0ILVVi+TVb/m8u+ofP2qxWiOcRwBotKl2ABSkR9wTZankr0VafH+LtOMG2mRmLWOZIHClbnx/Q/Ve7fVi0dhir01DiZz79Oa3iVhrkAcjg/fHkReTCLB/Ji8jizYp6veXhLQDcAdQnPYfhSo7kEjnY3bFRr2yUTMZWMmY8693v5HahWRpAClEQz0LK/eq6a+G852kyPS8Uzh0kQcqo3ga/rL7tAFrx545a0Msg4Wm3uixrIS5HbIQ4dVehdtLLlFqD1uUIY8gb5qXiiKlNrGS3gucTyIaVQaUQqfc34k5vZ6khOihtgYV8hKu8jmyDbg9DSzUwyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH60lmRfjoR7pkuzqFfhovmJJgU+FJwKw2gracvwZCw=;
 b=g8T/XJfMH9ACRExxs3nf5B3Z9qQDzF+jOi1Uhfo11KlwLKczEKcDOn9OYJNthlAx9IUjlZ6qusnSsK2c6ZXZj5Wjr21s+baTV/Im8vp3LViGfuxGwnNogOxykYALz6EJuAFLKhpnKtXOL88aXIqJtaV3gSoT65G0vmCij+mAK5E=
Received: from SA1PR03CA0014.namprd03.prod.outlook.com (2603:10b6:806:2d3::10)
 by DS0PR10MB8056.namprd10.prod.outlook.com (2603:10b6:8:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 21:37:28 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::e1) by SA1PR03CA0014.outlook.office365.com
 (2603:10b6:806:2d3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 21:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 21:37:26 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 16:37:26 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 16:37:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Apr 2026 16:37:26 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 636LbQ3r1842748;
 Mon, 6 Apr 2026 16:37:26 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 6 Apr 2026 16:37:26 -0500
Message-ID: <DHMEA20ALIVK.3HHE2Q6VZSGL7@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCHv2 1/5] lmb: add LMB_FDT for fdt reserved regions
From: Randolph Sapp <rs@ti.com>
To: <rs@ti.com>, <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260402205038.4005350-1-rs@ti.com>
 <20260402205038.4005350-2-rs@ti.com>
In-Reply-To: <20260402205038.4005350-2-rs@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DS0PR10MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d913ba-556c-4676-9f62-08de9424b27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XZu5hFgHPlHb8Ae3utBTDOUZ8kqX17tggUsGRTI4UNULbhN6WzQZUTK2/z3oCYguywfWt6gGBV2MJYzI3PVqHemBFbemigW9G8+PqW6cBX/q6ZlVV0SORVV1XngxLCyTBTt9fKE6io9iBPAhehclfmzBpptAXX3fyA3SOPRzYnQlkilj59vR5CDGe/tI9XIhe2sv9UDd/bUZtJnQjB9EB5s2PyOETceboRFoJXeTbbA09OOq/KoxgDMt3VXN7ecJCCG2H8QD5YNproxNqW2l8/dBiEnCHUc0MZet/vwzdDHNlGZAhEjlc4xxrFKLX6AMfy4UCgXzSghsPrxmu0cyWS82B69v4Mhpz3gyHqA7C3/XdizxJ8XNyFzxpDLhStUkbklGPPbw8MlYzy0QOTK9ZmcjRJ+SStCFX2JWvTD1TgC98PEEzBTGu5fbS5dE5/EUVWMpCcOGkVgYpiqIFgwIEiHZ+jsLzCXA5p8uwNFznuCGnUwdyvmbIbWhwKggG6GvDc1YnU4/aJzRmapbLKGeASmiZNMCYuNFL/ydP1m2+9LYIXx/1lKp+cAz8jArKkuw3p2iP8wlA6ze6JekP+sxkrh+VjggqQx0M7VePH/Ji+22Ixju1GePDD/nK0ibJcH0T71NNYlwyXmaSmHbmApMCE6m1sv8fATpTdVg9fVY/32JWUYXfgX7JedXkemx5mL+ksjAVFZJhP1PWVBVkSMKRFdtKhFA6cJpvwOazVkOOyN5JJ4zOqp+CQxvdvoQlZrahpgdJYUnSBcLsKWyDqLWyr9NBzTNX2v6/bvKLm6j7ZALqldNp4bbljkYvxceRnd6
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PjeGYbqUBAPd90UZ9j0pT0ts55CqjPLuoxfVpKk2KkCwKhiMRISvkXyaY0XRJ9Q9HAWhcZusTQqM5Fm3KCuzs5urtBgNiaI62Qwtyjv8q9uX+y3ggezvy8fmdYw1sklAL8Dpx2G2tupSJ0ua0wo83jKotfXa5DayIDUjsLXLURTgon+m702Cd2PwdHTzJDb6usD9QvPVEEODP82JXK7VK5basodTGDl1naJniG1lyytgmMLIlW1Q2OD0u3V+hPf7/bLsI7Hesj82x/mrC2LNKopg3zIFHmTr83Bgf+2GxGuBUC2DPKlMlCLX5vD8brEuvczuultUjv+FlWTdh1ZxeRzNGbnLh8cvnQhzXVfx7yae9wEcWmSqS9pDCuJm0i/Tsl9AcWxFbO08lYyq1/uBLrGG6Wu0yeiwS+3Wj+dzHoHI0rTYZ7UtUniIRotniBTZ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 21:37:26.6751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d913ba-556c-4676-9f62-08de9424b27d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8056
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

On Thu Apr 2, 2026 at 3:50 PM CDT, rs wrote:
> From: Randolph Sapp <rs@ti.com>
>
> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
> parsing a new device tree and properly warn people when a reservation
> overlaps with an existing allocation.
>
> If we don't at least warn the user of these reservation failures,
> there's a chance that this region could be freed and reallocated for
> something important later.
>
> This useful warning mechanism was broken in:
> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reser=
ve_region()")
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  boot/image-fdt.c |  5 ++++-
>  include/lmb.h    |  7 +++++++
>  lib/lmb.c        | 25 +++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index a3a4fb8b558..0f5857f24d2 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -73,6 +73,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size,=
 u32 flags)
>  {
>  	long ret;
>  	phys_addr_t rsv_addr;
> +	flags |=3D LMB_FDT;
> =20
>  	rsv_addr =3D (phys_addr_t)addr;
>  	ret =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &rsv_addr, size, flags);
> @@ -80,7 +81,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size,=
 u32 flags)
>  		debug("   reserving fdt memory region: addr=3D%llx size=3D%llx flags=
=3D%x\n",
>  		      (unsigned long long)addr,
>  		      (unsigned long long)size, flags);
> -	} else if (ret !=3D -EEXIST && ret !=3D -EINVAL) {
> +	} else if (ret !=3D -EINVAL) {
>  		puts("ERROR: reserving fdt memory region failed ");
>  		printf("(addr=3D%llx size=3D%llx flags=3D%x)\n",
>  		       (unsigned long long)addr,
> @@ -108,6 +109,8 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
>  	if (fdt_check_header(fdt_blob) !=3D 0)
>  		return;
> =20
> +	lmb_free_fdt_regions();
> +
>  	/* process memreserve sections */
>  	total =3D fdt_num_mem_rsv(fdt_blob);
>  	for (i =3D 0; i < total; i++) {
> diff --git a/include/lmb.h b/include/lmb.h
> index 5d5f037ccb9..1b59a63f61d 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -25,11 +25,13 @@
>   * %LMB_NOMAP: Don't add to MMU configuration
>   * %LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
>   * %LMB_NONOTIFY: Do not notify other modules of changes to this memory =
region
> + * %LMB_FDT: A FDT reserved region that can be reclaimed if the FDT chan=
ges
>   */
>  #define LMB_NONE 0
>  #define LMB_NOMAP BIT(1)
>  #define LMB_NOOVERWRITE BIT(2)
>  #define LMB_NONOTIFY BIT(3)
> +#define LMB_FDT BIT(4)
> =20
>  /**
>   * enum lmb_mem_type - type of memory allocation request
> @@ -215,6 +217,11 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_si=
ze_t size, ulong align);
>   */
>  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)=
;
> =20
> +/**
> + * lmb_free_fdt_regions() - Reclaim all LMB_FDT tagged reserved regions
> + */
> +void lmb_free_fdt_regions(void);
> +
>  #endif /* __KERNEL__ */
> =20
>  #endif /* _LINUX_LMB_H */
> diff --git a/lib/lmb.c b/lib/lmb.c
> index e2d9fe86c14..18703212afb 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -669,6 +669,31 @@ long lmb_free(phys_addr_t base, phys_size_t size, u3=
2 flags)
>  	return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
>  }
> =20
> +void lmb_free_fdt_regions(void)
> +{
> +	struct alist *lmb_rgn_lst =3D &lmb.used_mem;
> +	struct lmb_region *rgn =3D lmb_rgn_lst->data;
> +	long ret;
> +	int i =3D 0;
> +
> +	while (i < lmb_rgn_lst->count) {
> +		phys_addr_t base =3D rgn[i].base;
> +		phys_size_t size =3D rgn[i].size;
> +		u32 flags =3D rgn[i].flags;
> +
> +		if (flags & LMB_FDT) {
> +			ret =3D lmb_free(base, size, flags);
> +			if (ret < 0) {
> +				printf("Unable to free FDT memory at 0x%08lx",
> +				       (ulong)base);

Forgot to add a newline character here.

> +				i++;
> +			}
> +		} else {
> +			i++;
> +		}
> +	}
> +}
> +
>  static int _lmb_alloc_base(phys_size_t size, ulong align,
>  			   phys_addr_t *addr, u32 flags)
>  {

Ah, forgot to update the lmb_print_region_flags function. Sorry about that.
