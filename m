Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801D7C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 05:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0969C8197D;
	Tue, 28 Jan 2025 06:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GC/XoWSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AEDD819B1; Tue, 28 Jan 2025 06:47:49 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E277681951
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50S5liP91913898
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 23:47:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738043264;
 bh=YVteja5IyY5VHn4zSufF/QNrP1wb3hBoYsb34WRrRMk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=GC/XoWSSSgu4N663ooLssRW0mW3YTfVrSOa5HQXHR8+yhNbhhh+G4wPh39l3DAEjD
 3y7DSORk0XgLcDjLXtuTpdoCGKpI290IWq67XGj5F9dciyijIt/x4fZJtI0AVpF0IV
 dDKzhZp0NoTPQJ8/Of56Fhekov40bW8RMJ+EVhn8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50S5lirr055977
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 23:47:44 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 23:47:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 23:47:44 -0600
Received: from [172.24.17.105] (lt5cd2489kgj.dhcp.ti.com [172.24.17.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50S5lfrE034462;
 Mon, 27 Jan 2025 23:47:42 -0600
Message-ID: <4656da90-2fc7-459f-b6c3-872964afa8c4@ti.com>
Date: Tue, 28 Jan 2025 11:17:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] ram: k3-ddrss: Add comment about ecc_reserved_space
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>, <bb@ti.com>, 
 <w.egorov@phytec.de>, <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>
CC: <u-boot@lists.denx.de>
References: <20250127142217.1757300-1-n-francis@ti.com>
 <20250127142217.1757300-4-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250127142217.1757300-4-n-francis@ti.com>
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
> The reserved space needed for storing the parity remains the same no
> matter the size of the region that is being protected. Add this as a
> comment for better code understanding.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index 24932cd837c..ab46098adbf 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -715,6 +715,10 @@ static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
>   {
>   	fdtdec_setup_mem_size_base_lowest();
>   
> +	/*
> +	 * Reserved region remains 1/9th of the total DDR available no matter the
> +	 * size of the region under protection
> +	 */

Please add why , you need 1/9th of DDR


>   	ddrss->ecc_reserved_space = ddrss->ddr_ram_size;
>   	do_div(ddrss->ecc_reserved_space, 9);
>   
