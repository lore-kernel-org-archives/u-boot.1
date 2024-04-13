Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749C8C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 08:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C548801F;
	Sat, 13 Apr 2024 10:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="27hoRQS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE63881C8; Sat, 13 Apr 2024 10:25:21 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882F987F13
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 10:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=483321939c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43D4sZrk022743; Sat, 13 Apr 2024 10:25:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=8cvxoaRTX3Vtk62kpoWoTFV9AIXTZWepCM8v3rKRAK8=; b=27
 hoRQS0XG+w6ShGAvXxZjprogoshFNm02JDgkCBwlpjyp/rg/aaQvdZvpl6MpCPSY
 jQGwj6AsMtZwjnfKxBxcrZ6DwX4+GGl7BL5Gupjh21K7T4hFrjmEOWO2+Qx+NwnO
 Ij8mwX9kWjJEVIpSKZt73ZtstJkhIfciZxlYvqwAcjKiCHvVLIwc0bDdZ092O/HL
 GXW4/VYFkZ2sKaOGbQ8OQMqNnWy4xvdkmx/HPq5o0GBhcLy/7dGqn2o21hF0wav5
 w7PIuLtzxF9aegz0FNV3dy4hdaqWiRjzGm+iRNvMD30DoPes3j7yc5uw+vRl3HR6
 fjGD91C8vHxAr61Cnu8w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xff640q05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Apr 2024 10:25:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 52BF44002D;
 Sat, 13 Apr 2024 10:25:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0BCF320FA58;
 Sat, 13 Apr 2024 10:24:42 +0200 (CEST)
Received: from [10.252.5.56] (10.252.5.56) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 13 Apr
 2024 10:24:41 +0200
Message-ID: <fc509f7b-78ba-425b-8a33-7768a4f58bd0@foss.st.com>
Date: Sat, 13 Apr 2024 10:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] lmb: Fix adjacent region merge in
 lmb_add_region_flags()
Content-Language: en-US
To: <u-boot@lists.denx.de>, tom Rini <trini@konsulko.com>, "Kumar, Udit"
 <u-kumar1@ti.com>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Kumar Gala
 <galak@kernel.crashing.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
References: <20240412155307.735631-1-patrice.chotard@foss.st.com>
 <20240412155307.735631-2-patrice.chotard@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240412155307.735631-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.5.56]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_18,2024-04-09_01,2023-05-22_02
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



On 4/12/24 17:53, Patrice Chotard wrote:
> In case a new region is adjacent to a previous region with
> similar flag, this region is merged with its predecessor, but no
> check are done if this new added region is overlapping another region
> present in lmb (see reserved[3] which overlaps reserved[4]).
> 
> This occurs when the LMB [0xdaafd000-0xddb18000] is added and overlaps
> the LMB [0xdbaf4380-0xddffffff].
> 
> Call lmb_overlaps_region() before merging the new region with the
> adjacent region already present in lmb.
> 
> In case of adjacent region found, code is 90% similar in case
> adjacent region is located before/after the new region.
> Factorize adjacent region management in lmb_add_region_flags().
> 
> Issue reproduced on STM32MP157-DK2 with SCMI DT, bdinfo command's output
> shows:
> 
> before this patch:
> ...
> lmb_dump_all:
>  memory.cnt = 0x1 / max = 0x2
>  memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
>  reserved.cnt = 0x5 / max = 0x10
>  reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
>  reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
>  reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
>  reserved[3]    [0xdaae1000-0xdfffffff], 0x0551f000 bytes flags: 0
>  reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
> ...
> 
> after this patch:
> 
> ...
> lmb_dump_all:
>  memory.cnt = 0x1 / max = 0x2
>  memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
>  reserved.cnt = 0x5 / max = 0x10
>  reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
>  reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
>  reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
>  reserved[3]    [0xdaae1000-0xddffffff], 0x0351f000 bytes flags: 0
>  reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
> ...
> 
> Fixes: 4ed6552f7159 ("[new uImage] Introduce lmb from linux kernel for memory mgmt of boot images")
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
> Changes in v2:
>   _ Fix lmb_add_region_flags() by updating test which leads to
>     extend an existing region
> 
>  lib/lmb.c | 57 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 27 deletions(-)
> 
> diff --git a/lib/lmb.c b/lib/lmb.c
> index b6afb731440..4ed60f4a843 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -130,6 +130,22 @@ static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned long r1,
>  	lmb_remove_region(rgn, r2);
>  }
>  
> +static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
> +				phys_size_t size)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < rgn->cnt; i++) {
> +		phys_addr_t rgnbase = rgn->region[i].base;
> +		phys_size_t rgnsize = rgn->region[i].size;
> +
> +		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
> +			break;
> +	}
> +
> +	return (i < rgn->cnt) ? i : -1;
> +}
> +
>  void lmb_init(struct lmb *lmb)
>  {
>  #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> @@ -257,7 +273,7 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
>  				 phys_size_t size, enum lmb_flags flags)
>  {
>  	unsigned long coalesced = 0;
> -	long adjacent, i;
> +	long adjacent, i, overlap;
>  
>  	if (rgn->cnt == 0) {
>  		rgn->region[0].base = base;
> @@ -283,19 +299,21 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
>  		}
>  
>  		adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> -		if (adjacent > 0) {
> -			if (flags != rgnflags)
> -				continue;
> -			rgn->region[i].base -= size;
> -			rgn->region[i].size += size;
> -			coalesced++;
> -			break;
> -		} else if (adjacent < 0) {
> +		if (adjacent != 0) {
>  			if (flags != rgnflags)
>  				continue;
> -			rgn->region[i].size += size;
> -			coalesced++;
> -			break;
> +			overlap = lmb_overlaps_region(rgn, base, size);
> +			if (overlap < 0 || flags == rgn->region[overlap].flags) {
> +				/*
> +				 * no overlap detected or overlap with same flags detected,
> +				 * extend region
> +				 */
> +				if  (adjacent > 0)
> +					rgn->region[i].base -= size;
> +				rgn->region[i].size += size;
> +				coalesced++;
> +				break;
> +			}
>  		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
>  			/* regions overlap */
>  			return -1;
> @@ -420,21 +438,6 @@ long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
>  	return lmb_reserve_flags(lmb, base, size, LMB_NONE);
>  }
>  
> -static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
> -				phys_size_t size)
> -{
> -	unsigned long i;
> -
> -	for (i = 0; i < rgn->cnt; i++) {
> -		phys_addr_t rgnbase = rgn->region[i].base;
> -		phys_size_t rgnsize = rgn->region[i].size;
> -		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
> -			break;
> -	}
> -
> -	return (i < rgn->cnt) ? i : -1;
> -}
> -
>  phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
>  {
>  	return lmb_alloc_base(lmb, size, align, LMB_ALLOC_ANYWHERE);


I think this series (v2) is not correct even if now the CI tests are OK.
After re-reading carefully the lib_test_lmb_overlapping_reserve() test 
it appears to me there is a contradiction.

It's indicating that "check that calling lmb_reserve with overlapping regions fails" 

but the very last test of lib_test_lmb_overlapping_reserve() has this comment :
/* allocate 3rd region, coalesce with first and overlap with second */
and this test allows this overlap case.

It's not clear if LMB region can overlap each other or not ?

Udit, your patch edb5824be17f ("lmb: remove overlapping region with next range")
is authorizing LMB overlapping right ? 

Patrice





