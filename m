Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79760C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 14:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE04A875D6;
	Tue, 31 Oct 2023 15:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IXxF2mdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D024687B2D; Tue, 31 Oct 2023 15:47:16 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 995198750E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 15:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3296b3f03e5so3912982f8f.2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698763632; x=1699368432;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KsDO7mQH3jODmlexE0BKBEKGL9JwV5hBnUTVzEzFYus=;
 b=IXxF2mdrNjp5IEZ1xwFOOT7b/K8KN2QgdFaP5B2c5sb0fZSNjBH/8zTTUOtx54A9rB
 +pQLF8r3P6qeaH10lqn9cJ4ua2cB3YICrFgfjzweOOZQqE9gk1S9snEgek//TZ0u8TRn
 MMvhGwYpCQxDQ3yhIiHXw8aaMVrc5UTBWVMeN/aDJcGEDuRVJ6omp4/kwdQao6ewOZA6
 abYJra7fNzh75Ih1yLdfFksFMrmq4GLioE3GeaLtrCdKadvU3v1OuokEbB4dDDrNvhrf
 03Fw5/N2bBal6x3w+jaUt8G0oc7JGElNwDqFV8LXuJpPh5scLp0KlFs8TJozXAITNrTO
 bdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763632; x=1699368432;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KsDO7mQH3jODmlexE0BKBEKGL9JwV5hBnUTVzEzFYus=;
 b=pcAHICOxOtA5cgANCgFnZ8RaBZAfBuXqgojhYPgH12bw2PHWtgWQeI1Dx51tUeziLv
 QQvJk2whr45HQMa9x8vriiDdc5A1BNv3dHfOh+AmiRDoHj1PFjrePOXr2ZBkLNIsql89
 FXtrbW17ISLGReE0pOjPR2rkmHYpCTdRnV8/S2WXxQdxEbUjJR+1ekKctExqL0hTaSzD
 Lu8Z92hLP7djROzf0HCjbCV8XKuq6o093z+Mpa0UYdp1/9KfsiaZQOKzKQtKIhP8kDje
 FmPVPh613ZMeJ+f5k/oZ4QS3GldIZhf0pEbUfATYjfk7PR1J5GTuf6z9tr4f+oUqK5qQ
 PnBA==
X-Gm-Message-State: AOJu0YwM+XDieEe86yS3DUjaklojx+l19nTzCkqFURDjLtfl4KRk5IsO
 rFMxge8iSo5pbTqgHw0z1K7vFA==
X-Google-Smtp-Source: AGHT+IFG1G6Aw2MoKjxOWR3LsUnV8ZJokgXSBUJDfvh1AtJ62lZyhfN3MjRm4JuLrRu1YS/gLWE21A==
X-Received: by 2002:a5d:64ce:0:b0:32f:7d80:9c89 with SMTP id
 f14-20020a5d64ce000000b0032f7d809c89mr7081962wri.54.1698763631949; 
 Tue, 31 Oct 2023 07:47:11 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 i17-20020a5d6311000000b0031ad5fb5a0fsm1659704wru.58.2023.10.31.07.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:47:11 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: lukma@denx.de, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration
In-Reply-To: <20220620111354.448512-1-jh80.chung@samsung.com>
References: <CGME20220620111357epcas1p103474818319b5dc45260e043b4ffe3cc@epcas1p1.samsung.com>
 <20220620111354.448512-1-jh80.chung@samsung.com>
Date: Tue, 31 Oct 2023 15:47:10 +0100
Message-ID: <87y1fic0i9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Jaehoon,

Thank you for your patch.

On lun., juin 20, 2022 at 20:13, Jaehoon Chung <jh80.chung@samsung.com> wrote:

> Add CONFIG_DFU_NAME_MAX_SIZE to change the proper size.
> If name is longer than default size, it can do wrong behavior during updating
> image. So it need to change the proper maximum size.
>
> This patch is proviced the solution to change value with configuration.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

I could not find a maximum size in the DFU 1.1 spec [1] neither in the
dfu-util codebase.

[1] https://www.usb.org/sites/default/files/DFU_1.1.pdf

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/dfu/Kconfig | 9 +++++++++
>  include/dfu.h       | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
> index 8d7f13dcb0b5..a181f0b8d7ba 100644
> --- a/drivers/dfu/Kconfig
> +++ b/drivers/dfu/Kconfig
> @@ -111,5 +111,14 @@ config SYS_DFU_MAX_FILE_SIZE
>  	  the buffer once we've been given the whole file.  Define
>  	  this to the maximum filesize (in bytes) for the buffer.
>  	  If undefined it defaults to the CONFIG_SYS_DFU_DATA_BUF_SIZE.
> +
> +config DFU_NAME_MAX_SIZE
> +	int "Size of the name to be added in dfu entity"
> +	default 32
> +	depends on DFU
> +	help
> +	  This value is used to maximum size. If name is longer than default size,
> +	  we need to change the proper maximum size.
> +
>  endif
>  endmenu
> diff --git a/include/dfu.h b/include/dfu.h
> index dcb9cd9d799a..948596f367d9 100644
> --- a/include/dfu.h
> +++ b/include/dfu.h
> @@ -99,7 +99,7 @@ struct virt_internal_data {
>  	int dev_num;
>  };
>  
> -#define DFU_NAME_SIZE			32
> +#define DFU_NAME_SIZE			CONFIG_DFU_NAME_MAX_SIZE
>  #ifndef DFU_DEFAULT_POLL_TIMEOUT
>  #define DFU_DEFAULT_POLL_TIMEOUT 0
>  #endif
> -- 
> 2.25.1
