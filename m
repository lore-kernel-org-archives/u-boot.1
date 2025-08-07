Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06605C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 04:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D8583AFD;
	Thu,  7 Aug 2025 06:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zI97SEmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3335683BB1; Thu,  7 Aug 2025 06:58:16 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02EAE83AEA
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 06:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5774wBGk671925;
 Wed, 6 Aug 2025 23:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754542691;
 bh=nCB4W0ZnlXy2hdTgJlQXaHYcH6jkb9jci1Ba57FFUOM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=zI97SEmkxBJjVqyvIhyF0Jp+Fu1g62EG2JaUOQI+6dG5UeS0KBAq468GS1cSRvWkZ
 z/VsN7shpUSYmZ3Y1yZn3yH5CasfBof5MjhZqyU+7WkYbGZSIUaWgOe1kzOIp8vZt6
 eD21D8JNo9YCYimZ5vF30jzSs8NOR4FXwU2zybvQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5774wBGp547630
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 6 Aug 2025 23:58:11 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 23:58:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 23:58:11 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5774w8OH761926;
 Wed, 6 Aug 2025 23:58:09 -0500
Message-ID: <3c42e330-ae1c-44dc-a933-46260db5421d@ti.com>
Date: Thu, 7 Aug 2025 10:28:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] ram: k3-ddrss: Add support for partial inline ECC
 in multi-DDR systems
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>, <bb@ti.com>, 
 <w.egorov@phytec.de>, <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>
CC: <u-boot@lists.denx.de>
References: <20250730133720.3315478-1-n-francis@ti.com>
 <20250730133720.3315478-9-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250730133720.3315478-9-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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


On 7/30/2025 7:07 PM, Neha Malcom Francis wrote:
> The existing approach does not account for interleaving in the DDRs when
> setting up regions. There is support for MSMC to calculate the regions
> for each DDR, so modify k3_ddrss_probe to set the regions accordingly
> for multi-DDR systems.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 58 ++++++++++++++++++++++++++++-----
>   1 file changed, 50 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index 1c2e5e1835b..e00711a2235 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -828,11 +828,12 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
>   
>   static int k3_ddrss_probe(struct udevice *dev)
>   {
> -	u64 end;
> +	u64 end, bank0, bank1;
>   	int ret;
>   	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
> -	__maybe_unused u32 ddr_ram_size, ecc_res;
> +	__maybe_unused u32 inst, ddr_ram_size, ecc_res, st;

size of ddr may go above 4G


>   	__maybe_unused struct k3_ddrss_ecc_region *range = &ddrss->ecc_range;
> +	__maybe_unused struct k3_msmc *msmc_parent = NULL;
>   
>   	debug("%s(dev=%p)\n", __func__, dev);
>   
> @@ -873,26 +874,67 @@ static int k3_ddrss_probe(struct udevice *dev)
>   		k3_ddrss_ddr_inline_ecc_base_size_calc(range);
>   
>   		end = ddrss->ecc_range.start + ddrss->ecc_range.range;
> +		inst = ddrss->instance;
>   		ddr_ram_size = ddrss->ddr_ram_size;
>   		ecc_res = ddrss->ecc_reserved_space;
> +		bank0 = ddrss->ddr_bank_base[0];
> +		bank1 = ddrss->ddr_bank_base[1];
>   
>   		if (!range->range) {
>   			/* Configure entire DDR space by default */
>   			debug("%s: Defaulting to protecting entire DDR space using inline ECC\n",
>   			      __func__);
> -			ddrss->ecc_range.start = ddrss->ddr_bank_base[0];
> +			ddrss->ecc_range.start = bank0;
>   			ddrss->ecc_range.range = ddr_ram_size - ecc_res;
>   		} else {
>   			ddrss->ecc_range.start = range->start;
>   			ddrss->ecc_range.range = range->range;
>   		}
>   
> -		if (end > (ddr_ram_size - ecc_res))
> -			ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
> -		else
> -			ddrss->ecc_regions[0].range = ddrss->ecc_range.range;
> +		st = ddrss->ecc_range.start;
> +
> +		if (!CONFIG_IS_ENABLED(K3_MULTI_DDR)) {
> +			if (end > (ddr_ram_size - ecc_res))
> +				ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
> +			else
> +				ddrss->ecc_regions[0].range = ddrss->ecc_range.range;
>   
> -		ddrss->ecc_regions[0].start = ddrss->ecc_range.start - ddrss->ddr_bank_base[0];
> +			/* Check in which bank we are */
> +			if (st > bank1)
> +				ddrss->ecc_regions[0].start = st - bank1 + ddrss->ddr_bank_size[0];
> +			else
> +				ddrss->ecc_regions[0].start = st - bank0;
> +		} else {
> +			/* For multi-DDR, we rely on MSMC's calculation of regions for each DDR */
> +			msmc_parent = kzalloc(sizeof(msmc_parent), GFP_KERNEL);
> +			if (!msmc_parent)
> +				return -ENOMEM;
> +
> +			msmc_parent = dev_get_priv(dev->parent);
> +			if (!msmc_parent) {
> +				printf("%s: could not get MSMC parent to set up inline ECC regions\n",
> +				       __func__);
> +				kfree(msmc_parent);
> +				return -EINVAL;
> +			}
> +
> +			if (msmc_parent->R0[0].start < 0) {
> +				/* Configure entire DDR space by default */
> +				ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0];
> +				ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
> +			} else {
> +				end = msmc_parent->R0[inst].start + msmc_parent->R0[inst].range;
> +
> +				if (end > (ddr_ram_size - ecc_res))
> +					ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
> +				else
> +					ddrss->ecc_regions[0].range = msmc_parent->R0[inst].range;
> +
> +				ddrss->ecc_regions[0].start =  msmc_parent->R0[inst].start;
> +			}
> +
> +			kfree(msmc_parent);
> +		}
>   
>   		k3_ddrss_lpddr4_ecc_init(ddrss);
>   	}
