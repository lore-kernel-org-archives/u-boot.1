Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA6CC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 13:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF556875EA;
	Mon, 15 Jan 2024 14:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Ai8010T9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B765875EA; Mon, 15 Jan 2024 14:09:19 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9589186FC6
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 14:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d49635=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40F8hru0016501; Mon, 15 Jan 2024 14:09:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=wf24OsI9KM9DFsGfB9hTG2CyL/1Baa0CZx7YSbB7ZD8=; b=Ai
 8010T9HJ0sQ+DBUfM2SzCnCm1sldL/SqHgGDTZAQk8w9uD42livFr7YrjeULWtQp
 9VPDDELyjXzCob7B9ET1Ggg4bQ2XPos+PJWOPMf1WNuE9KJXHBSK0FiE7V9OjbVm
 R5o18Xk6j0EroJneU9OigXtdKw7PprC56c4KKFIU6lnUGQHF3Ptp+bCutNh2dkMG
 DZSnM6CbJhQ2CnpjfHSwFE2d3M8pn6mz5ECgo8iDSkOXdCV5YxKXHdYxZdqK5Zuf
 x0wtYDGby6yFHKkU2m1yKjlxCu17vFW84WgKuGGLmLVZ3C8UwPAYyY7Q+t0byv4k
 915IevBrXqPqZbSBzWtA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkma5rpvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 14:09:17 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D3F5F100059;
 Mon, 15 Jan 2024 14:08:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CCDE02815EF;
 Mon, 15 Jan 2024 14:08:57 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 14:08:57 +0100
Message-ID: <99a46145-e6d9-48c9-9740-226166a64704@foss.st.com>
Date: Mon, 15 Jan 2024 14:08:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] board: st: stm32mp2: display the board
 identification
Content-Language: en-US
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240115124657.39109-1-patrick.delaunay@foss.st.com>
 <20240115134642.12.I23dadcfeb0941c41ad9d8dabeb6c70a0bb9a7b56@changeid>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240115134642.12.I23dadcfeb0941c41ad9d8dabeb6c70a0bb9a7b56@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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



On 1/15/24 13:46, Patrick Delaunay wrote:
> Add the display of the STMicroelectronics board identification saved in OTP
> in stm32mp2 checkboard function.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  board/st/stm32mp2/stm32mp2.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
> index 9a881583d904..aa7dd31996ea 100644
> --- a/board/st/stm32mp2/stm32mp2.c
> +++ b/board/st/stm32mp2/stm32mp2.c
> @@ -9,9 +9,12 @@
>  #include <env.h>
>  #include <fdt_support.h>
>  #include <log.h>
> +#include <misc.h>
>  #include <asm/global_data.h>
>  #include <asm/arch/sys_proto.h>
> +#include <dm/device.h>
>  #include <dm/ofnode.h>
> +#include <dm/uclass.h>
>  
>  /*
>   * Get a global data pointer
> @@ -20,6 +23,9 @@ DECLARE_GLOBAL_DATA_PTR;
>  
>  int checkboard(void)
>  {
> +	int ret;
> +	u32 otp;
> +	struct udevice *dev;
>  	const char *fdt_compat;
>  	int fdt_compat_len;
>  
> @@ -27,6 +33,23 @@ int checkboard(void)
>  
>  	log_info("Board: stm32mp2 (%s)\n", fdt_compat && fdt_compat_len ? fdt_compat : "");
>  
> +	/* display the STMicroelectronics board identification */
> +	if (CONFIG_IS_ENABLED(CMD_STBOARD)) {
> +		ret = uclass_get_device_by_driver(UCLASS_MISC,
> +						  DM_DRIVER_GET(stm32mp_bsec),
> +						  &dev);
> +		if (!ret)
> +			ret = misc_read(dev, STM32_BSEC_SHADOW(BSEC_OTP_BOARD),
> +					&otp, sizeof(otp));
> +		if (ret > 0 && otp)
> +			log_info("Board: MB%04x Var%d.%d Rev.%c-%02d\n",
> +				 otp >> 16,
> +				 (otp >> 12) & 0xF,
> +				 (otp >> 4) & 0xF,
> +				 ((otp >> 8) & 0xF) - 1 + 'A',
> +				 otp & 0xF);
> +	}
> +
>  	return 0;
>  }
>  
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
