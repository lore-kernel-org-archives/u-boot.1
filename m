Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED54AC021B3
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 02:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B5BA8056B;
	Sat, 22 Feb 2025 03:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kYMuYJDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28A2806FE; Sat, 22 Feb 2025 03:36:57 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7E4801B0
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 03:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51M2aatF472012
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2025 20:36:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740191796;
 bh=AmUN7vBzgV1Gc8aCVKEdW2u8WNJWA5iLxXyr4U87gPM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kYMuYJDYQeO6TTHfvlSjXJUbNuxqZa1yt0DqzNEiShsHAZZvN2Q6WR09LuJ6SoIeY
 NJxxA7PrpM4Bz2XWH4h8nyEO4J3ed3xcgNfaJQDsl4wHouuEeLY80fZ+IuCxEqalyX
 nM3+ORRqr2KpfI7SyaRatpp1EzzQTbPB7cJyHRBw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51M2aaYP026204
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Feb 2025 20:36:36 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Feb 2025 20:36:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Feb 2025 20:36:35 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51M2aRHF024364;
 Fri, 21 Feb 2025 20:36:28 -0600
Message-ID: <92c67015-dbd2-49c8-bcdd-703bd835a836@ti.com>
Date: Sat, 22 Feb 2025 08:06:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [UBOOT PATCH] spi: spi-uclass: Fix reduced read speed when
 parallel config is enabled
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>,
 <j-humphreys@ti.com>, <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <seanga2@gmail.com>, <caleb.connolly@linaro.org>,
 <sjg@chromium.org>, <william.zhang@broadcom.com>,
 <stefan_b@posteo.net>, <quentin.schulz@cherry.de>,
 <Takahiro.Kuwano@infineon.com>, <p-mantena@ti.com>, <git@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, <u-kumar1@ti.com>
References: <20250221095722.1932812-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250221095722.1932812-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Venkatesh

On 2/21/2025 3:27 PM, Venkatesh Yadav Abbarapu wrote:
> From: Prasad Kummari <prasad.kummari@amd.com>
>
> When SPI_STACKED_PARALLEL is enabled, the chip selects properties
> are read from the device tree using the reg property and stored in
> the plat->cs[] array. However, the function dev_read_u32_array()
> returns zero, causing the execution to enter the else block, print
> an error message, and return. As a result, the spi-max-frequency
> property is not read from the device tree, resulting in the use
> of the default frequency SPI_DEFAULT_SPEED_HZ (100,000). This leads
> to a lower spi->speed, reducing QSPI DMA read performance.
>
> To address this issue, an additional condition has been added to
> check the return value of reg. If it is nonzero, the function prints
> an error message and returns. Otherwise, it proceeds to read the
> spi-max-frequency property from the device tree.
>
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/spi-uclass.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
> index d6049753740..a7783b6b6dd 100644
> --- a/drivers/spi/spi-uclass.c
> +++ b/drivers/spi/spi-uclass.c
> @@ -523,8 +523,10 @@ int spi_slave_of_to_plat(struct udevice *dev, struct dm_spi_slave_plat *plat)
>   	if (ret == -EOVERFLOW || ret == -FDT_ERR_BADLAYOUT) {
>   		dev_read_u32(dev, "reg", &plat->cs[0]);

My comments are not directly related with this patch but , relates to 
your usages of above block of code

You want to treat error as no error.  Then I would request to fix device 
tree.

Also what if dev_read_u32 says, no reg property found ?

>   	} else {
> -		dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
> -		return ret;
> +		if (ret) {
> +			dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
> +			return ret;
> +		}
>   	}
>   #else
>   	plat->cs[0] = dev_read_u32_default(dev, "reg", -1);
