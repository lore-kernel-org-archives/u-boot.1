Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA41C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 04:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E00283AFD;
	Thu,  7 Aug 2025 06:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qXaQPrRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B7B83B8B; Thu,  7 Aug 2025 06:47:21 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2CD83AB9
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 06:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5774lHWf234717;
 Wed, 6 Aug 2025 23:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754542037;
 bh=VHlfjW5/TA9J4ur6J1Dytj3fOdkp2fisi7MQemQ5mRU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=qXaQPrRWAwP3D7BYT2ithlqwk35W1+JUe8hUyNV0hT1/plnmJSff1bUpQYugqlBoy
 vDn6miwhk06aS/b3R7wqz5cGD0NzrC+zUO6Cxo+LrOS1k4xaFdgleqBFIan6MJedxj
 URRzgSxL992jbP4jBCzcgNCvzoQfvstWLSk2+hp8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5774lHv54082234
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 6 Aug 2025 23:47:17 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 23:47:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 23:47:16 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5774lDL3751071;
 Wed, 6 Aug 2025 23:47:14 -0500
Message-ID: <acd11949-2957-4730-be6f-bb547abbb084@ti.com>
Date: Thu, 7 Aug 2025 10:17:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] ram: k3-ddrss: Add CONFIG_K3_MULTI_DDR
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>, <bb@ti.com>, 
 <w.egorov@phytec.de>, <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <sabiya.d@ti.com>
CC: <u-boot@lists.denx.de>
References: <20250730133720.3315478-1-n-francis@ti.com>
 <20250730133720.3315478-6-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250730133720.3315478-6-n-francis@ti.com>
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
> As we increase the functionalities that the K3 DDRSS sub-system support,
> it is becoming more evident that the same logic cannot apply to both
> single as well as multiple DDR controller devices. Add
> CONFIG_K3_MULTI_DDR to be used to differentiate between the two.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   drivers/ram/Kconfig | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
> index edb8e254d5b..5fc107e61b2 100644
> --- a/drivers/ram/Kconfig
> +++ b/drivers/ram/Kconfig
> @@ -128,6 +128,16 @@ config K3_INLINE_ECC
>   	  need to be primed with a predefined value prior to enabling ECC
>   	  check.
>   
> +config K3_MULTI_DDR
> +	bool "Enable support for multiple K3 DDRSS controllers"
> +	depends on K3_DDRSS
> +	help
> +	  Enabling this option adds support for configuring multiple DDR memory
> +	  controllers for K3 devices. The external memory interleave layer
> +	  present in the MSMC (Multicore Shared Memory Controller) is
> +	  responsible for interleaving between the controllers.
> +	default y if SOC_K3_J721S2 || SOC_K3_J784S4

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> +
>   source "drivers/ram/aspeed/Kconfig"
>   source "drivers/ram/cadence/Kconfig"
>   source "drivers/ram/octeon/Kconfig"
