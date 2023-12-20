Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57949C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 13:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA42C874B1;
	Wed, 20 Dec 2023 14:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JhIkK8YO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE08587646; Wed, 20 Dec 2023 14:09:03 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C72BA86CF4
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 14:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50e23c620e8so5768169e87.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703077741; x=1703682541; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DTsBwd44X974O1wzq1ZmhH/0O/ZfLzi8quNL6LU49D0=;
 b=JhIkK8YOmyuHZJj+4QNycz9CNh4F8ijOnJG5Ylv5WhE0XxnA8RMqGwdz4TyhzG0poH
 RaerVZRIQIuKiePZ4yT5gG6U8aJZqtN88AItYzPG45SX65zxijtJ6e6FbZcuR4mmf8Pc
 QSsD6E+C5+mcOS32V7bM6tFr1t/E19Lf+k0lX17+G8Chd/Asyviv/8tii+c4fwTfBUmC
 zhMz6DrhkVkf0Ebaf3vl+liQjlNwZvqF7F1JkXrUgYvv+eVf/GcQ0obGufcEX21LqMSX
 mP8YXABo4IoIkJGNqa0kwMP+NlwTUufae4fuS49gIsnzE59eeVmEAi1/HM75aL1is+8M
 etLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703077741; x=1703682541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTsBwd44X974O1wzq1ZmhH/0O/ZfLzi8quNL6LU49D0=;
 b=LUdBIvtDeVKiTo8+McvAKuRcuvHo+Tlt6QPiVrVYklDMgqltR+hbwt7VvTDZ+c6dZ/
 5sfa1Qwn7ePzY2kf/Mhh1F6LVxNe2ybj1XuyD7VGDx46LwNczSU49w1rstGoGknljMqr
 1c870/aGvk+QX1T+WZ8Bhevu/EEyEnbDXOr9mgSFqM/BoYh53vMrR7eMtMDNbb0wVriR
 3vHEYXO92hPslVTuxAET2+lPNpTwvD/PKKPnLDcF1bgvi6xIXVN9qfqrbwVqnfcy0if7
 opAJpehcYNziafAILRRnV7xQw22It+cZkS57Q/R7RVKRjGwubcPFrHRJedkcc5rYPv6Z
 j34w==
X-Gm-Message-State: AOJu0YyFfBueEPp+71H7obdH6FVd4UdCnK1EsSMjD9UsdCs0f2x4dCkw
 tyVz+Z/miu63QC3oDNKd1u07sw==
X-Google-Smtp-Source: AGHT+IHxuoVm45OnfpLlyKzzhwKW3nUjN6O+NU4eFpUcHhJiLIoSjuCG3utzS9AY3LRYe6jHM89Mug==
X-Received: by 2002:ac2:548c:0:b0:50e:3639:f88 with SMTP id
 t12-20020ac2548c000000b0050e36390f88mr2554058lfk.16.1703077740766; 
 Wed, 20 Dec 2023 05:09:00 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a056402110a00b00553a094dd5csm1676948edv.32.2023.12.20.05.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 05:09:00 -0800 (PST)
Date: Wed, 20 Dec 2023 15:08:57 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 5/5] qemu-arm: get FDT from bloblist
Message-ID: <ZYLnaUhGuR-X56fx@hera>
References: <20231219211114.393193-1-raymond.mao@linaro.org>
 <20231219211114.393193-6-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219211114.393193-6-raymond.mao@linaro.org>
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

On Tue, Dec 19, 2023 at 01:11:12PM -0800, Raymond Mao wrote:
> Get devicetree from a bloblist if it exists.
> If not, fallback to get FDT from the specified memory address.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  board/emulation/qemu-arm/qemu-arm.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> index 72e0a97567..455c042a9a 100644
> --- a/board/emulation/qemu-arm/qemu-arm.c
> +++ b/board/emulation/qemu-arm/qemu-arm.c
> @@ -148,9 +148,20 @@ int dram_init_banksize(void)
>
>  void *board_fdt_blob_setup(int *err)
>  {
> +	void *fdt = NULL;
>  	*err = 0;
> -	/* QEMU loads a generated DTB for us at the start of RAM. */
> -	return (void *)CFG_SYS_SDRAM_BASE;
> +
> +	/* Check if a DTB exists in bloblist */
> +	if (IS_ENABLED(CONFIG_BLOBLIST)) {
> +		if (bloblist_maybe_init())
> +			return (void *)CFG_SYS_SDRAM_BASE;
> +		fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);

if (!bloblist_maybe_init())
    fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);

and you wont need the explicit return, since the code below will catch it

> +	}
> +	if (!fdt)
> +		/* QEMU loads a generated DTB for us at the start of RAM. */
> +		return (void *)CFG_SYS_SDRAM_BASE;
> +	else

and you dont need the else here either

Thanks
/Ilias
> +		return fdt;
>  }
>
>  int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)
> --
> 2.25.1
>
