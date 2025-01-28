Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDF9C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 05:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DCA18197D;
	Tue, 28 Jan 2025 06:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kUSsjAQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B6F819B1; Tue, 28 Jan 2025 06:46:23 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFFD281951
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50S5kIte1102143
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 23:46:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738043178;
 bh=fgJ5FBXriUIWPahzNo3swHe41khwlrKM+69HECAkz54=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kUSsjAQctfTce6V8innCZm7o4WpgZqPHS9cys5grXYjEEegqR+ZKr7ZrsEkc6qW1s
 3tlyLgpeF0Gst0wzVceBTq6I5vAF+O1YU30buc3HIAiDu1mFvPtlz2uvmJRDMdzrd0
 N4RzUKyHDoXjcmt1Z8Sdh3YW7kSExQLGEfbAM6I4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50S5kI3x055518
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 23:46:18 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 23:46:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 23:46:18 -0600
Received: from [172.24.17.105] (lt5cd2489kgj.dhcp.ti.com [172.24.17.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50S5kFYa033187;
 Mon, 27 Jan 2025 23:46:15 -0600
Message-ID: <824fba8d-b231-449f-aebb-cd28ff47504f@ti.com>
Date: Tue, 28 Jan 2025 11:16:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] ram: k3-ddrss: Use DDR address instead of system
 address for ecc_regions
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>, <bb@ti.com>, 
 <w.egorov@phytec.de>, <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <sabiya.d@ti.com>
CC: <u-boot@lists.denx.de>
References: <20250127142217.1757300-1-n-francis@ti.com>
 <20250127142217.1757300-3-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250127142217.1757300-3-n-francis@ti.com>
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


On 1/27/2025 7:52 PM, Neha Malcom Francis wrote:
> Let ecc_regions[x].start reflect the start of the ECC region in terms of
> DDR addressing rather than system addressing. This will make it easier
> to extend the usage of the same ecc_regions structure for multi-DDR
> systems as well.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index 05ea61bbfe9..24932cd837c 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -730,7 +730,7 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
>   	u32 val;
>   
>   	/* Only Program region 0 which covers full ddr space */
> -	k3_ddrss_set_ecc_range_r0(base, ecc_region_start - ddrss->ddr_bank_base[0], ecc_range);
> +	k3_ddrss_set_ecc_range_r0(base, ecc_region_start, ecc_range);
>   
>   	/* Enable ECC, RMW, WR_ALLOC */
>   	writel(DDRSS_ECC_CTRL_REG_ECC_EN | DDRSS_ECC_CTRL_REG_RMW_EN |
> @@ -799,7 +799,7 @@ static int k3_ddrss_probe(struct udevice *dev)
>   		k3_ddrss_lpddr4_ecc_calc_reserved_mem(ddrss);
>   
>   		/* Always configure one region that covers full DDR space */
> -		ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0];
> +		ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0] - ddrss->ddr_bank_base[0];

you will get start as zero, here , if this is what you need just set to 
zero


>   		ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - ddrss->ecc_reserved_space;
>   		k3_ddrss_lpddr4_ecc_init(ddrss);
>   	}
