Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568C1C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB85871CD;
	Tue, 21 Nov 2023 15:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="Ye/EVae8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A84E87264; Tue, 21 Nov 2023 15:06:54 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC6E87197
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a00a9d677fcso191985566b.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 06:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1700575610; x=1701180410;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T9N6woi2lBUF05JPuZStIrA4o5vXSWb4rGlGL3Bxtys=;
 b=Ye/EVae8rGXHSCgj7P6KGSoJPjAbKflcuF7SslkGiKEq79Mrn7U+VKDRWSz4EQx+QF
 GZ/XrF8KP4f8m13vJgnqVXyGOj4wsc7hrYuyCaICvozqSEi2gRaRTlCVNpN3NodGkBpt
 tLKp1CQSnOMtRcvt68IhQJQ4wp1N9RikJFgUwa7FyKbKjLnMjHlFwin7YXJqMEtRnE+G
 MPGgjUwlGpIaBRMZ9+OCPeEpmZ1scs1q7iFnnFts05TPtengOdl/MtsH7wlw+GBaXgc3
 lbgoDn3a5Xz3EL6zDYQGb1oHyMO/L9Hf7+ZjncGlOfinHztjeuqSwn4Sf+V3yAOS1MY4
 XEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700575610; x=1701180410;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T9N6woi2lBUF05JPuZStIrA4o5vXSWb4rGlGL3Bxtys=;
 b=gxjXXcdaH3BRMpKPLoKm/wEDWBNcfy8BZyKKjcJ2Frkr4AbF051LLE3mzcAHXfvJE/
 UFURn1z/sM9geJ0/Is+6GgPdVB4Eb1sVW41jkJzCxSypEp+LEgevwSlBYd+fP845+vuP
 K/gp20yh7dk6N/lgpoGVmXOHZbZNx6kLXBU2WpgWcXnrctsbxjB6MEeglhZo7eWHq1Xl
 /KHRPUOhz46fyXXQF++JiqvpOxZhdNvgmOjkCUkcnViByxDMHGtKek3sd2cyli55BjKy
 boyoMsuPSd8VYp9k4bQ6oKaIOwvSgLiwyYwsab0ScqXssG5pUTuMv2i/h1LOn8gbGr4P
 03rA==
X-Gm-Message-State: AOJu0Yx37mj5fS6gYxnfXcJ+HFHzK15cS5/OPXTzw+D1xvtwpwFbv4R0
 WlOBFtNewqPS+ZEXXJ3ShzkJdw==
X-Google-Smtp-Source: AGHT+IEGNEPodRWWn/dhFgrllSXyO7gkWS6obPbGk9Ok4RDyXeCiwRRA5/CAXIofip7ycxDRMsQNsQ==
X-Received: by 2002:a17:907:1c12:b0:a01:7745:467a with SMTP id
 nc18-20020a1709071c1200b00a017745467amr2470265ejc.4.1700575610388; 
 Tue, 21 Nov 2023 06:06:50 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 gq16-20020a170906e25000b009fca9484a62sm3144410ejb.200.2023.11.21.06.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 06:06:49 -0800 (PST)
Message-ID: <02dae49c-a641-4182-9ebc-030948422055@monstr.eu>
Date: Tue, 21 Nov 2023 15:06:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] spi: zynqmp_gqspi: Add parallel memories support
 in GQSPI driver
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 git@xilinx.com, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
 <20231114045638.6463-6-venkatesh.abbarapu@amd.com>
From: Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzR9NaWNoYWwgU2lt
 ZWsgPG1vbnN0ckBtb25zdHIuZXU+wsGYBBMBCABCAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIe
 AQIXgAIZARYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VIBQkWf4AXAAoJEDd8fyH+PR+R
 Ad4P/inv1MRSEtdJdJQTnumy82UHj71JmSCaxkqE85mSh+8QJohTFTHL5nUsnwzLSbqaUZ/V
 8pinX+7WyfRtF1K8XVmJ2Hp5Ru98YoVqGWQg8l2BlaYi5bkGsJNN/QuD9vJQw+uVaCM3Oijn
 tXBbDYqFUE78Hk8UTbGytrLr/Kuo2jbTA300+DdPMUDaLiG53Eqgtj2+LeGkCarptBazyKsh
 IvfAO1HcabhUQrkiWge12syl/Fw/n8kcTrVqVJUjQ+nxErZ2zVePNMzOB6i29w8gXcl+pwHf
 khXSGlqCbGf9uwUKScVB0W87MwHzGUzznNCrhdmPy6oze9oo250a2dobCk+H7OmVEg6kvyvP
 LYSJdSr5j7k9Nzyk/MDFoEahLXYrOdLFU+wksuIo+iDhQqfPjLDJZltlxgesfcwh7+OLQaRG
 fYKiIxC432iO00WvqB8m090VDUlOl5gK3jU9uzr5PBXRIiY4bHW5pdVtvovmDSY1aSO/5B8/
 OoCPJ+czvcMVvpFx2L+/ZcSkYOg2DciwxCugfsCNr8cI1uw6/EeQG2z2mJFeMZf4yElXO1ys
 ycqIphZH+d/Gs7nJGoxkpB/MCcVAHRoCnyY7uVY3Dcpb616I/ZrOtpj7qG+x0aZJKVmkc4Mv
 yoTI81J+GLzoyu4Rt+v4TF5M7gUrEAfxrTJtdz2WzsFNBFFuvDEBEACXqiX5h4IA03fJOwh+
 82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iMfZA+DDPp
 vo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB5asad8Ux
 70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbBvEgh71V3
 NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtzIOBUMk7f
 jku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgPLu8TsP1m
 igoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/ZbyiVA7/EN5
 phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBnXxvvcjWI
 PnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKkOiCZ3E0J
 YDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg1vTEyK58
 Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/If49H5EF
 AmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFKeo/+4fF/
 KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJeHf4Ez3D
 71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGiepDwFUdf
 JLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIjS6nuJlvW
 j/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3zkXyouA6K
 f54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3YPi6o9Pw
 /IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8ywyA0qgv
 +Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/y7RkYPOp
 mElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+il2dpB2lx
 ha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+33i3l5DA=
In-Reply-To: <20231114045638.6463-6-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 11/14/23 05:56, Venkatesh Yadav Abbarapu wrote:
> Add support for parallel memories in zynqmp_gqspi.c driver. In case of
> parallel memories STRIPE bit is set and sent to the qspi ip, which will
> send data bits to both the flashes in parallel. However for few commands
> we should not use stripe, instead send same data to both the flashes.
> Those commands are exclueded by using zynqmp_qspi_update_stripe().
> 
> Also update copyright info for this file.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/zynqmp_gqspi.c | 140 ++++++++++++++++++++++++++++++++-----
>   include/spi.h              |  12 ++++
>   2 files changed, 136 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
> index a323994fb2..7e90a989dd 100644
> --- a/drivers/spi/zynqmp_gqspi.c
> +++ b/drivers/spi/zynqmp_gqspi.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * (C) Copyright 2018 Xilinx
> + * (C) Copyright 2013 - 2022, Xilinx, Inc.
> + * (C) Copyright 2023, Advanced Micro Devices, Inc.
>    *
>    * Xilinx ZynqMP Generic Quad-SPI(QSPI) controller driver(master mode only)
>    */
> @@ -25,6 +26,8 @@
>   #include <linux/bitops.h>
>   #include <linux/err.h>
>   #include <linux/sizes.h>
> +#include <linux/mtd/spi-nor.h>
> +#include "../mtd/spi/sf_internal.h"
>   #include <zynqmp_firmware.h>
>   
>   #define GQSPI_GFIFO_STRT_MODE_MASK	BIT(29)
> @@ -88,6 +91,9 @@
>   #define SPI_XFER_ON_LOWER		1
>   #define SPI_XFER_ON_UPPER		2
>   
> +#define GQSPI_SELECT_LOWER_CS          BIT(0)
> +#define GQSPI_SELECT_UPPER_CS          BIT(1)
> +
>   #define GQSPI_DMA_ALIGN			0x4
>   #define GQSPI_MAX_BAUD_RATE_VAL		7
>   #define GQSPI_DFLT_BAUD_RATE_VAL	2
> @@ -183,13 +189,14 @@ struct zynqmp_qspi_priv {
>   	int bytes_to_transfer;
>   	int bytes_to_receive;
>   	const struct spi_mem_op *op;
> +	unsigned int is_parallel;
> +	unsigned int u_page;
> +	unsigned int bus;
> +	unsigned int stripe;
> +	unsigned int flags;
> +	u32 max_hz;
>   };
>   
> -__weak int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value)
> -{
> -	return 0;
> -}
> -
>   static int zynqmp_qspi_of_to_plat(struct udevice *bus)
>   {
>   	struct zynqmp_qspi_plat *plat = dev_get_plat(bus);
> @@ -234,9 +241,30 @@ static u32 zynqmp_qspi_bus_select(struct zynqmp_qspi_priv *priv)
>   {
>   	u32 gqspi_fifo_reg = 0;
>   
> -	gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
> -			 GQSPI_GFIFO_CS_LOWER;
> -
> +	if (priv->is_parallel) {
> +		if (priv->bus == SPI_XFER_ON_BOTH)
> +			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
> +					 GQSPI_GFIFO_UP_BUS |
> +					 GQSPI_GFIFO_CS_UPPER |
> +					 GQSPI_GFIFO_CS_LOWER;
> +		else if (priv->bus == SPI_XFER_ON_LOWER)
> +			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
> +					 GQSPI_GFIFO_CS_UPPER |
> +					 GQSPI_GFIFO_CS_LOWER;
> +		else if (priv->bus == SPI_XFER_ON_UPPER)
> +			gqspi_fifo_reg = GQSPI_GFIFO_UP_BUS |
> +					 GQSPI_GFIFO_CS_LOWER |
> +					 GQSPI_GFIFO_CS_UPPER;
> +		else
> +			debug("Wrong Bus selection:0x%x\n", priv->bus);
> +	} else {
> +		if (priv->u_page)
> +			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
> +					 GQSPI_GFIFO_CS_UPPER;
> +		else
> +			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
> +					 GQSPI_GFIFO_CS_LOWER;
> +	}
>   	return gqspi_fifo_reg;
>   }
>   
> @@ -295,8 +323,14 @@ static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
>   		gqspi_fifo_reg |= GQSPI_SPI_MODE_SPI |
>   				  GQSPI_IMD_DATA_CS_ASSERT;
>   	} else {
> -		gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS;
> -		gqspi_fifo_reg |= GQSPI_IMD_DATA_CS_DEASSERT;
> +		if (priv->is_parallel)
> +			gqspi_fifo_reg = GQSPI_GFIFO_UP_BUS |
> +					 GQSPI_GFIFO_LOW_BUS;
> +		else if (priv->u_page)
> +			gqspi_fifo_reg = GQSPI_GFIFO_UP_BUS;
> +		else
> +			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS;
> +			gqspi_fifo_reg |= GQSPI_IMD_DATA_CS_DEASSERT;


Here you have bug. If it is the part of else there should be {} around.

If it is valid for all then indentation is not correct.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
