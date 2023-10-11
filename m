Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4EACD98E9
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 02:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0CB486C0B;
	Wed, 11 Oct 2023 04:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="d4+AD0m5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7925886B57; Wed, 11 Oct 2023 04:55:13 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AD3286A24
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 04:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4955D404A1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 02:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696992905;
 bh=ukdTZSRd0w0BSG8WV9a0Ml/7B2oopszs9FBigHNEU5I=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=d4+AD0m5XSeJ1Qm4IhGImz6tSfA7LUYEwrj0cke+8qmewn17lVoK4c7z4kdSl4X7/
 61MEb/KsfXG+Pz72ikt5Jptiob5VRYQ0mniees2geikwrVZ/9RNj8WH5ZFu0I7cuT2
 0j2lgwFrKeXbIUvF+w5XBJir8fag+Xj2NxT+Ha2wG7LJA54/dGBCLXffHTNCxCU1xz
 ZQvDm4fOp/15zaXcnbICpFb/KJ5TSgtNABk7rV98atbG6FnMlLuadPQb6CEutZNFZ4
 rdPjyVRKZpqdn4bpACPeGxs7c4BsJoBwg7L1QuZE2LJreHzgZsZ08LlLhWV6E0iHlW
 MUE/dynZhPGrA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3172a94b274so4326310f8f.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 19:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696992902; x=1697597702;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ukdTZSRd0w0BSG8WV9a0Ml/7B2oopszs9FBigHNEU5I=;
 b=s4r7Tj4UKbvlfttz4vsZwK6pXME05vOvy8tx8eVULwf/xFg6mOdo9+wsIM6ivCoTp3
 j4ofSufuQjnl2VlNuwbfZfqJFDwIfjBUPKjDMVh090NuNIcMkk8OeMrCqTrBwiwls3CM
 4VSU8qM0kgz2jwi3+DjWstBLta9HYRDUev8glLb0AAFFda6dSd3X9lONO0lbfOeREZTp
 P8UmlhE314Fl8kRi9rNCPbUI9rskGAM/gggiklm20Bz4aZV9PNZpXkTKGmkfj8tWHopY
 tGjQ7xfV8ySIGWarfDlWXsm8weRtLp/7EWDOM1k8EPDt5j/YFD5P5OqOfu5llBi2tuiq
 hyhQ==
X-Gm-Message-State: AOJu0YzwyoSLWyIHv8NCBnn1gn+9hzPG5rd/mTWeJM5AeqjnDlVLxrZX
 UhXgbuCnnuPiQtwmyYS1le9TfJVVi2/wSP6iET+v6n3UoxVManz3/w+dD3XtehXHwXT6/nDuXmu
 zememdhKLsZT46he29ItvxNcIJSThVdQ=
X-Received: by 2002:adf:f641:0:b0:31f:b6ea:af48 with SMTP id
 x1-20020adff641000000b0031fb6eaaf48mr17024988wrp.49.1696992902255; 
 Tue, 10 Oct 2023 19:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+ONsVADmQR9YwwEK/7aZXyYgjlDQN7o/vVb1hTkss6ggNAK46P73YLNLky326d1mqaw3oUg==
X-Received: by 2002:adf:f641:0:b0:31f:b6ea:af48 with SMTP id
 x1-20020adff641000000b0031fb6eaaf48mr17024974wrp.49.1696992901110; 
 Tue, 10 Oct 2023 19:55:01 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 h12-20020adff18c000000b003232380ffd7sm14090932wro.102.2023.10.10.19.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 19:55:00 -0700 (PDT)
Message-ID: <a62045f4-9f1e-4f53-82f7-587b36a037f7@canonical.com>
Date: Wed, 11 Oct 2023 04:54:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] ram: starfive: Read memory size information from
 EEPROM
Content-Language: en-US
To: Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230615093652.23161-11-yanhong.wang@starfivetech.com>
Cc: Ramon Fried <rfried.dev@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Shengyu Qu <wiagn233@outlook.com>, Shiji Yang <yangshiji66@outlook.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230615093652.23161-11-yanhong.wang@starfivetech.com>
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

On 15.06.23 11:36, Yanhong Wang wrote:
> StarFive VisionFive 2 has two versions, 1.2A and 1.3B, each version of
> DDR capacity includes 2G/4G/8G, a DT can not support multiple
> capacities, so the capacity size information is recorded to EEPROM, when
> DDR initialization required capacity size information is read from
> EEPROM.
> 
> If there is no information in EEPROM, it is initialized with the default
> size defined in DT.
> 
> Signed-off-by: Yanhong Wang <yanhong.wang@starfivetech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
>   arch/riscv/cpu/jh7110/spl.c         | 32 ++++++++++++++++++++++++++++-
>   drivers/ram/starfive/starfive_ddr.c |  2 --
>   2 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
> index 104f0fe949..72adcefa0e 100644
> --- a/arch/riscv/cpu/jh7110/spl.c
> +++ b/arch/riscv/cpu/jh7110/spl.c
> @@ -3,19 +3,49 @@
>    * Copyright (C) 2022 StarFive Technology Co., Ltd.
>    * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
>    */
> -
> +#include <common.h>
> +#include <asm/arch/eeprom.h>
>   #include <asm/csr.h>
>   #include <asm/sections.h>
>   #include <dm.h>
> +#include <linux/sizes.h>
>   #include <log.h>
> +#include <init.h>
>   
>   #define CSR_U74_FEATURE_DISABLE	0x7c1
>   #define L2_LIM_MEM_END	0x81FFFFFUL
>   
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static bool check_ddr_size(phys_size_t size)
> +{
> +	switch (size) {
> +	case SZ_2:
> +	case SZ_4:
> +	case SZ_8:
> +	case SZ_16:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   int spl_soc_init(void)
>   {
>   	int ret;
>   	struct udevice *dev;
> +	phys_size_t size;
> +
> +	ret = fdtdec_setup_mem_size_base();
> +	if (ret)
> +		return ret;
> +
> +	/* Read the definition of the DDR size from eeprom, and if not,
> +	 * use the definition in DT
> +	 */
> +	size = (get_ddr_size_from_eeprom() >> 16) & 0xFF;

On origin/master for a 4 GiB board with a serial number 
VF7110B1-2253-D004E000-4000xxxx this always fails. This results in 
memory reported as 8 GiB and Linux crashing.

i2c_get_chip_for_busnum() returns -EINVAL in read_eeprom() 
[board/starfive/visionfive2/visionfive2-i2c-eeprom.c:335].

Is the driver model really expected to be fully initialized before 
setting up memory?

Best regards

Heinrich

> +	if (check_ddr_size(size))
> +		gd->ram_size = size << 30;
>   
>   	/* DDR init */
>   	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/starfive/starfive_ddr.c
> index 553f2ce6f4..a0a3d6b33d 100644
> --- a/drivers/ram/starfive/starfive_ddr.c
> +++ b/drivers/ram/starfive/starfive_ddr.c
> @@ -72,8 +72,6 @@ static int starfive_ddr_probe(struct udevice *dev)
>   	u64 rate;
>   	int ret;
>   
> -	/* Read memory base and size from DT */
> -	fdtdec_setup_mem_size_base();
>   	priv->info.base = gd->ram_base;
>   	priv->info.size = gd->ram_size;
>   

