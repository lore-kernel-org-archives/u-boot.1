Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD57CC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 16:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09316881AA;
	Wed, 15 May 2024 18:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aNJPE0bp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC15D8824C; Wed, 15 May 2024 18:07:39 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B5918717A
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 18:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44FG7ZDt029710;
 Wed, 15 May 2024 11:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715789255;
 bh=9UHAjl0g6SzAw3dhkxvJJGZl9BytY+aobda0/l+vOf0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=aNJPE0bpJcpE0rd6Gw6S4Y3MlxcGxqqoBPAFAVnirk8/vjEaTyrZqfuuo4zSAbtz1
 zgeduz0H804HA1lGJm/WA0jZIJ5ULpBWMmOk1c2gKMFbH1vhuzdVDtpqU0pCpT/2b9
 OD8LSAHxhzRruYwsR+keSVcw6dCf5yOXv8+aP4sM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44FG7ZE8014319
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 May 2024 11:07:35 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 11:07:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 11:07:35 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44FG7YFZ006664;
 Wed, 15 May 2024 11:07:34 -0500
Message-ID: <e6387a6f-fe4b-4bff-99fd-1418b17aee78@ti.com>
Date: Wed, 15 May 2024 11:07:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
To: Santhosh Kumar K <s-k6@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>
References: <20240510084707.1903133-1-s-k6@ti.com>
 <20240510084707.1903133-6-s-k6@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240510084707.1903133-6-s-k6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 5/10/24 3:47 AM, Santhosh Kumar K wrote:
> From: Neha Malcom Francis <n-francis@ti.com>
> 
> Add CONFIG_K3_INLINE_ECC so that ECC functions can be compiled into R5 SPL
> only when the config has been enabled.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   drivers/ram/Kconfig | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
> index 9838a2798f92..9d1eee1d5cad 100644
> --- a/drivers/ram/Kconfig
> +++ b/drivers/ram/Kconfig
> @@ -107,6 +107,17 @@ config IMXRT_SDRAM
>   	  to support external memories like sdram, psram & nand.
>   	  This driver is for the sdram memory interface with the SEMC.
>   
> +config K3_INLINE_ECC
> +	bool "Enable TI Inline ECC support"
> +	depends on K3_DDRSS
> +	default n

n is already the default, this line is never needed.

Maybe we want this to be `default y` so that we do not change
current behavior and platforms can opt-out as needed instead.

Andrew

> +	help
> +	  Enable Inline ECC support on K3 platforms. 1/9th of the SDRAM space
> +	  is used for ECC storage and the rest 8/9th is available for system
> +	  use. Enabling ECC increases boot time as the ECC protected regions
> +	  need to be primed with a predefined value prior to enabling ECC
> +	  check.
> +
>   source "drivers/ram/aspeed/Kconfig"
>   source "drivers/ram/cadence/Kconfig"
>   source "drivers/ram/octeon/Kconfig"
