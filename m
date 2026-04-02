Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B361112246
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E009183D8A;
	Thu,  2 Apr 2026 02:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sq8CE0fD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE7784011; Thu,  2 Apr 2026 02:36:37 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C5F283CE3
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 02:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVOEr1hsCQ95wTN3IqgkVhzRsQJXJYHrDhl/MgllZYYEczUwFyTAnmCPbp4JA3y1FxgrPUu4kQOWvqPyfan6X/PJATp2NRonWdgrBxipSk41ssU963psk53eA+XKmutto8N6jMdAa+xbZq8XGqtzBff0WWXWS2fjhiMXAdpLncNZQGO0MpQeFrpcazYwDLxaQ4AWYgucgDLN1lVXo2LItqu1rQBplKIqKOq1xvULLZ7tKBIAIFnuyXiczxAQvZev4raSmilJ4NrxUxGwicEilrZYvzp1HmE6xEIopEBDe1ri2NV5dYrn2y1Q4dM+Sv0ADdvghJWOeKcMBcWzoNmJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQe8LSusz5RoIJA9WbDRPHQKdooakzFBBietGrTdOh4=;
 b=bY0p9aYgqrNgnVtEp15+A5z3C+CNksKNv3jz1ApMF5Z1lLbrqut3uGIsfqvcWZd6VQpiJHtylsiIk2f121BZgkJtY+MPA0/cafITDLQ+wTawcTwnC1Iflz4f2lilDiwJIzKTPvMtIa4z0ueq7l8oP/jdwQKm1Sw2q2qZ69A8FPim8ovRqEdUwORg/WuXEK+FEtlH1ZH4DdQHHznJ7O1fhC+Eh+DDCmkBwzBKQhtf4dyriV5uI1uVTSesR0FlYc5p+ObwxfH+NuqEMypZDSSCUIJGBgEj7uAGOdQSgc/GE/vj1dKTLy+/fkWY1DyQO5qRE69A6L7nQUpLsyHeHGI6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQe8LSusz5RoIJA9WbDRPHQKdooakzFBBietGrTdOh4=;
 b=sq8CE0fD2gnjQUb2nJhw9QAs2PJiqYopScIAJKGKbGdKWc/ce8qxlqcBvS04+WMLsdI1rBzeL1+1ZGN1bn6BcelQyKi4PDYXf47GySzi6ypHIOcfCoB9rxd6Dp/NxALIHvrYw0U1QP5GN5R4PQMqCriV/M/Kl1SkjCrh3HlUSco=
Received: from DS7PR03CA0338.namprd03.prod.outlook.com (2603:10b6:8:55::31) by
 SJ5PPF2C6461432.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::799)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 2 Apr
 2026 00:36:31 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::28) by DS7PR03CA0338.outlook.office365.com
 (2603:10b6:8:55::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 00:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 00:36:29 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:36:28 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 19:36:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 19:36:28 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6320aSVX1503945;
 Wed, 1 Apr 2026 19:36:28 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 1 Apr 2026 19:36:28 -0500
Message-ID: <DHI8YEZ8H34N.IE14OR83IVW7@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/6] lmb: add LMB_FDT for fdt reserved regions
From: Randolph Sapp <rs@ti.com>
To: <rs@ti.com>, <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-2-rs@ti.com>
In-Reply-To: <20260402001410.3736815-2-rs@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|SJ5PPF2C6461432:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebfc058-8012-4ace-baae-08de904fe17f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: p+den0CtuOAcw8nAxpJ23fjks85a6HX5DMxO0OCW9tFddrU/vEh9us17bZM8bRSDYg8LT07KY6+4XGbmHsddlphr0eCybn8rC6C5SiKFFJsa61yEO/oFprjan0W6Y2XeGYR2Q3xiiK1Q3y+9RNIH8O+v52qS00JRUe4yJ0V3qNBoudROiUWUbE6TUaqvdY5lVI62DqY959bM1k/0uWbqHbMe48dJO/3Z0iU6GJlEVa9HpooaGSJdJtmHBpTSKFGSIdn2slgK+WrFjZ3W3C/hIIzEE8GR54yIvXnTrfEBup6xepXvxJQ77QO8uHbBTHOyU+pEdrewY24zzjiXF5rlCnFpfIj7GSienTwwF0IK2lgO2Yjcj6yOvCidxpnCtjCwU/KL75tYsopPG5AuwTjp4A8is7Dy3X1MdR0iRxD5E3iQqRXfMDCYbJo5teLrw7rnts38e2JsvhlfjvEZ+ipDXYcPe3EJza8cP1xeThk4O2yIvJdBGYTVgFx4QL2xRGhKhpbhtciNxeyy7AGq4NxO80G76FkeDWvhIavJiELkWrM06S0tIke3tV4zvz+kxTFfWVIjLxosaHWxzPnx8cSWauPfNwQ/W6aY6Os4tq8ZqP9wa1ASmv8vgZAQIDTgRbpj3piEuTSs8jeZ52G3oJFhgdWBxNp1Lu9AHeaHjAdJXtTE9XyHN2/6MmxTIXQKfPAsgQxv8JQLojcVym5UNZJzW0DrO9oGb/peA4NWvIW9yOOtWLo+sgHFSlV3VlkvF55stVJ74YlovtDnW5hsAl+m4Vett2MLafARCKF9tOFZtELLjo1N4cnhUnRjNW43yRcO
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3W4zXyV5nqXmKoHWWQhDLqsKhQNkh+M6JwUwv02/ue5/1Hvw1wK/X90dPp0PFqZ5uxjvZjrltAiMDH863BxLid4RPhETkaCtlfgZ/4G3x938WM/ay8Dk8rZ3xmGCeINpnNHUuqU6XBQMle3CNznw+yqTolNpQJUPqDYx3Y2wiyk2CSeRy+XeQRNcy/QM8/9Eby1Zdi3DbVGkxPgHFTsFjd2ZZM4qBv2tcKuFW653tNARufSr5a3dIzm9YADz8cRj5pAn025T50WMdlJT1+zQ0Yi8GDAU1aDCmPdE0bN5MBN43UCuaU1V1dM6PphMIFHAGahxVfyRwpoxnxKvCyB7Tob7lhFdiRSQG1u5GEKeltkRH/w+H0tiH+zMIvj4YNFQhtvn20Aacue66ZYMKu7qgodd1rkQHvay/JV1GMAyaqbq2HC6ARzZLKUovp+HZZfv
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 00:36:29.2272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebfc058-8012-4ace-baae-08de904fe17f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2C6461432
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

On Wed Apr 1, 2026 at 7:14 PM CDT, rs wrote:
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
>  lib/lmb.c        | 23 +++++++++++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
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
> index e2d9fe86c14..542bb11dcf5 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -669,6 +669,29 @@ long lmb_free(phys_addr_t base, phys_size_t size, u3=
2 flags)
>  	return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
>  }
> =20
> +void lmb_free_fdt_regions(void)
> +{
> +	struct alist *lmb_rgn_lst =3D &lmb.used_mem;
> +	struct lmb_region *rgn =3D lmb_rgn_lst->data;
> +	long ret;
> +
> +	for (int i =3D 0; i < lmb_rgn_lst->count; i++) {
> +		phys_addr_t base =3D rgn[i].base;
> +		phys_size_t size =3D rgn[i].size;
> +		u32 flags =3D rgn[i].flags;
> +
> +		if (flags & LMB_FDT) {
> +			ret =3D lmb_free(base, size, flags);
> +			if (ret < 0) {
> +				printf("Unable to free FDT memory at 0x%08lx",
> +				       (ulong)base);
> +				continue;
> +			}
> +			i--;
> +		}
> +	}
> +}
> +
>  static int _lmb_alloc_base(phys_size_t size, ulong align,
>  			   phys_addr_t *addr, u32 flags)
>  {

Ugh. Looking at that loop in lmb_free_fdt_regions more I really should have
written it differently to avoid the additional increments and decrements. I=
'll
fix that in v2.
