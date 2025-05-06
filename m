Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB075C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 11:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F7C6820F6;
	Tue,  6 May 2025 13:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y1XRnYUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F27D78210D; Tue,  6 May 2025 13:44:17 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B064B80C83
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 13:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso34804385e9.1
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 04:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746531855; x=1747136655; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=njsK8es+byAkVSrpH/SshWUYOxN83OEWJ+D1Fb2Qe5Q=;
 b=Y1XRnYUqEqhSKIyJhrkIlOgqwjJRHBr0E0xVB36HrEzvRshH6Av5P8ps5Q/3x5CV05
 63xJDN4LWtigM8YRE34iHRAO5j3asb9DQTcDLU7LD8AHGOMWaEmeVAa2+Hmvk4noNlK/
 9eLCzJU9dY4gVo/YhvHgDPqTftaib6cRykzCSe5quX1UnpasVWDQDu5If2hSDq9V7hQB
 N+JEOS7/nqwtADhz4CL9kTkKAQB7YSGhuiw+qaMZYQA0UKBIu+pHcJgAkCmdLcVi2haa
 XLDnhi4uUG2raoemVse+P67Xl3Me8NxQ+oxkG/J8oBpN+IMhSzwjt0bUFMMKMXjbFQYK
 JkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746531855; x=1747136655;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njsK8es+byAkVSrpH/SshWUYOxN83OEWJ+D1Fb2Qe5Q=;
 b=GBvofRFveMlag7t9dqagrzbfEO+Pc28CzWBj7hHVg0r3FKIb9+bqQP2tjMw3lHzWGW
 chNqR59lLzKTK/IbKQ2qgqyVAey2CzfH7TCWcT7W9Pt4tYiowwz7pAdyBeiI9jsqxHEI
 jxJpJ4TtFYl9iNcqE+yn8/L4pg+qn8FUrKl+REmOVl8OgdrEk2eLt10AH/kwF3ExDn4j
 lNvAkO7SqgYvaRCG05F3nwFCRIJ8OPfKllF8hKA9YX6IYGAUANaowG1KdOuDFvmymxHX
 m/9UPoiwBBZ2kQA7GXBkCP6VJTIeIrTSfE5CrEQNtYsDbCKWn5TqxVomC1/M5q0q1qVM
 /REQ==
X-Gm-Message-State: AOJu0Yx0sxcW4UtrxLfTuz6fXxZt+UxBc/s59b6flAYRKbg589hpcs/m
 /50e+pi1MvZ7WWd2PdlI6VHtNVPpN5OiTGIFd5CmO0TlQKLCLuzo
X-Gm-Gg: ASbGncuLpTk5rfQeC2faN2BelI/PT/TQsmMZu5LdVMbvjV3tDar6fBCfk/WIEDIaevd
 wN3DwFfvb0e00n/RN2EcN71S4nAxw4eg7JNv9HkZgqCwcYYuzfkugulzBynpzzrEihfw1EP6d2U
 o4INgRKNH/fV1ZX/b9GcNhD7SpJxz0NvtXyXmgvTbZqyvD+BmRRnNuqpIQ+fyN0syNk7M81lSwW
 lZXCktLigFcTpdJqto2fI0WcdIIUVmxuQfNjlsO/LHsFeVW4wMW2PbYn1Eso7Q7b3HEjuklb981
 oAIWvEapqDEBqah0xHeEtlvF1HloBCMHBIk5GI0wMoMIpVj9NNi0x5aeiVPZxAm6hSDDYgkhtm/
 KcFBC7fU=
X-Google-Smtp-Source: AGHT+IGh2j6LvJCRSAFe8Aub0q+34rVXXLg5aQc3SdQKlyi1s0Dlq4mookXR8TFj0Fv8mF2rDbAYlQ==
X-Received: by 2002:a05:600c:8519:b0:43c:fe15:41dd with SMTP id
 5b1f17b1804b1-441c48b0248mr96076865e9.6.1746531854743; 
 Tue, 06 May 2025 04:44:14 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-21-27-29.retail.telecomitalia.it.
 [87.21.27.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a31576sm166412325e9.37.2025.05.06.04.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 04:44:14 -0700 (PDT)
Message-ID: <6819f60e.050a0220.2e9b7e.67d0@mx.google.com>
X-Google-Original-Message-ID: <aBn2C0o7s5lABZdt@Ansuel-XPS.>
Date: Tue, 6 May 2025 13:44:11 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] env: mtd: fix usability with NAND flashes
References: <20250506071501.28253-1-weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506071501.28253-1-weijie.gao@mediatek.com>
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

On Tue, May 06, 2025 at 03:15:01PM +0800, Weijie Gao wrote:
> 1. As this is for MTD-based devices, the Kconfig dependency should be MTD
>    instead of only spi-nor flashes
> 2. Initialize saved_buf to avoid crash on free()
> 3. Remaining size shoule be set correctly to write_size
> 
> Fixes: 03fb08d4aef (env: Introduce support for MTD)
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

> ---
>  env/Kconfig | 2 +-
>  env/mtd.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/env/Kconfig b/env/Kconfig
> index 1e876c6fa85..ce869a24d46 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -404,7 +404,7 @@ config ENV_IS_IN_SPI_FLASH
>  
>  config ENV_IS_IN_MTD
>  	bool "Environment is in MTD flash"
> -	depends on !CHAIN_OF_TRUST && (SPI_FLASH || DM_SPI_FLASH)
> +	depends on !CHAIN_OF_TRUST && MTD
>  	default y if ARCH_AIROHA
>  	help
>  	  Define this if you have a MTD Flash memory device which you
> diff --git a/env/mtd.c b/env/mtd.c
> index 721faebd8f2..d7ec30e183a 100644
> --- a/env/mtd.c
> +++ b/env/mtd.c
> @@ -32,7 +32,7 @@ static int setup_mtd_device(struct mtd_info **mtd_env)
>  
>  static int env_mtd_save(void)
>  {
> -	char *saved_buf, *write_buf, *tmp;
> +	char *saved_buf = NULL, *write_buf, *tmp;
>  	struct erase_info ei = { };
>  	struct mtd_info *mtd_env;
>  	u32 sect_size, sect_num;
> @@ -105,7 +105,7 @@ static int env_mtd_save(void)
>  	}
>  
>  	offset = CONFIG_ENV_OFFSET;
> -	remaining = sect_size;
> +	remaining = write_size;
>  	tmp = write_buf;
>  
>  	puts("Writing to MTD...");
> -- 
> 2.34.1
> 

-- 
	Ansuel
