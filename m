Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC96C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 04:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C75083AFD;
	Thu,  7 Aug 2025 06:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KJauWmFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C560C83B1A; Thu,  7 Aug 2025 06:30:17 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF73083AB9
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 06:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5774UEYp276147;
 Wed, 6 Aug 2025 23:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754541014;
 bh=CaWKZ5Yg2h9OdJccoEmwgXIlZNpKHYFZg6lU35uwEX4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KJauWmFHstqAs5i1+8JzWnAH79Zp1Vz9hAlhnqCBk5EUR4Zcx9zRm67kaQEdOq27P
 oWgBzx9hnbqO8Lmee275ZZn/Rw2hzBu7YxdXV2ZP1DKbCrBJQ23ztlJNutn++GGlJk
 Iy9vfZ15V157Y5J3uD0Ghosf6GW3Nw28lkpAZoCQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5774UEwm616349
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 6 Aug 2025 23:30:14 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 23:30:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 23:30:13 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5774UBjs732842;
 Wed, 6 Aug 2025 23:30:11 -0500
Message-ID: <890e70ae-13cb-4f6b-8222-bc25bb1fafad@ti.com>
Date: Thu, 7 Aug 2025 10:00:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] ram: k3-ddrss: Add comment about ecc_reserved_space
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>, <bb@ti.com>, 
 <w.egorov@phytec.de>, <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>
CC: <u-boot@lists.denx.de>
References: <20250730133720.3315478-1-n-francis@ti.com>
 <20250730133720.3315478-4-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250730133720.3315478-4-n-francis@ti.com>
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
> The reserved space needed for storing the parity remains the same no
> matter the size of the region that is being protected. Add this as a
> comment for better code understanding.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index ee1d9b5998f..a94755c3542 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -737,6 +737,11 @@ static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
>   {
>   	fdtdec_setup_mem_size_base_lowest();
>   
> +	/*
> +	 * For every 512-byte data block, 64 bytes of ECC is stored inline and
> +	 * is a reserved region. It remains 1/9th of the total DDR size
> +	 * irrespective of the size of the region under protection.
> +	 */
>   	ddrss->ecc_reserved_space = ddrss->ddr_ram_size;

For every 512-byte data block, 64 bytes of ECC is stored inline and is a reserved region

to
For every 512-bytes data block, 64 bytes are used to store inline ECC information into reserved region


with little update in comments above, please use

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   	do_div(ddrss->ecc_reserved_space, 9);
>   
