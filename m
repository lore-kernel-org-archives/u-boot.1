Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE29C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 19:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82EBA80F92;
	Fri, 21 Feb 2025 20:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740166896;
	bh=0f71Biq7tu63NIpQ3ZE7PTDD3NipFcn78fKfYV4HgJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MNEEzkK5rR9cChNMPdFH+XpxjYRfH/+F9n9APwSeoWrR2CpuvWcdWO9NDUceeVt4H
	 cxnFR/0lHnP34eLdcP3Ju0p44ebphYcSWwjfnTgdlazdT6Wn1MrIXf5pgRse2ilmW8
	 V2JZi4b/3zk326sKLtPbHsEei1n6ViPnTh0Yj+57hTKs+W0jWKt2eLkuJ34Hp/vy0V
	 hchdEF8SUsx2vML372LcxwZe3lHwuSPnOPYWJ8kcio4LGOt7/RKI3EJxqyHfPAvcgJ
	 TfRs0hLVdCuixPzsIxkVZ/DKf9gNppAKSfP6Dl5U3SiMC82h/krwG5QEjEy4v/mlxV
	 6YlwHaBfGHqnw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA1780F98; Fri, 21 Feb 2025 20:41:35 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A200580FAC
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 20:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VqfAQUFt"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C342910382D37; Fri, 21 Feb 2025 20:41:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740166890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0f71Biq7tu63NIpQ3ZE7PTDD3NipFcn78fKfYV4HgJs=;
 b=VqfAQUFtFEGdAK5wBjdIvt061gdyxVakAJF29CECe/hZQW+/kvWMk6VVX69Nd74u7xDBV8
 P+4nGDUzMycQKTm4m3iBN89kIzNAORR8i6/fs/znQe6ZmlHaJBRD/0g/b7a00wo99yaWPN
 vSOPlBXDSjCJoNsVSL81I1kRFdDOa/qTc2Jj/wpQsc9OfTdl4GXqz02JLeD9tIeHqZ+oe9
 EhCC6LNEfb835rCfIx38/kmPkS0daTPJHUfKwmQ55sxo37P6tp9aZDP+GH0wKXFDnGTQhJ
 aTvmqxYRWgi5nlI8rrZYzB0g6iJT9ECjcTHAoyclIG39UE2wbcQtGgtQb9CxaQ==
Message-ID: <e4258db2-d236-447d-93aa-70444b722b62@denx.de>
Date: Fri, 21 Feb 2025 18:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [UBOOT PATCH] spi: spi-uclass: Fix reduced read speed when
 parallel config is enabled
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 p-mantena@ti.com, git@amd.com, Prasad Kummari <prasad.kummari@amd.com>
References: <20250221095722.1932812-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250221095722.1932812-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 2/21/25 10:57 AM, Venkatesh Yadav Abbarapu wrote:
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

Why not simply do this?

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index d6049753740..4d9376dbdca 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -522,7 +522,7 @@ int spi_slave_of_to_plat(struct udevice *dev, struct 
dm_spi_slave_plat *plat)

         if (ret == -EOVERFLOW || ret == -FDT_ERR_BADLAYOUT) {
                 dev_read_u32(dev, "reg", &plat->cs[0]);
-       } else {
+       } else if (ret) {
                 dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
                 return ret;
         }
