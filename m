Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B80D4979A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9679E89628;
	Tue,  3 Dec 2024 10:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jxR0wSTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C7D8962A; Tue,  3 Dec 2024 10:46:35 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 913A4895EC
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a45f05feso65641635e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 01:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733219193; x=1733823993;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BVb3WOwzol2NQRxQOEUgBpdDfbZUUCUJEzX9V1aGVBI=;
 b=jxR0wSTwEGF3bFBArR+4BcIqvrO6J93tBxKdlOCZNBx78IMHYHe+q63jB1ZyB+HGy3
 JRNV17enOgbwJbIafrWM3Psz5NIozpcNraQWfyRHJKu5TYbnTZmcRb4UKDOoFtjheCYC
 EltDGTIpWSoF2zEmP2EFeyOVFjyzotT933mGuxpmX38e0BkskHu/lSWHXlsLmgtJb8dw
 s1HB61LV5WTjnYeYjSFpYknogtm1J+hJRfGc5URbdmAJkJDL++B4bGVz+kv4FXqyX+Rf
 XB4PQf0WRM5k9nOK4tLUpAdRDknTPn/GdzU5KmMAag+yKNZmwp9jPYg7fBsfG2HCaIAV
 Xa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733219193; x=1733823993;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BVb3WOwzol2NQRxQOEUgBpdDfbZUUCUJEzX9V1aGVBI=;
 b=MaxQFpAKirqknYdAgWfZ/wJKo/LdihKpoGKMwJCKMFgs4/jb4j+3Cd2K/9kRzbgmTz
 V9uL3B69/af2AYe5CIh/ikPk+/C5yGV4w4KRco4KFQJlNB7qg605hPYuWd/vYp/WhIsX
 EMSuMy5zKc+okRLmXJTBg6S20gGHn6Lo2GIx8XT+39LJi+z7Pm0z0UR/BAJ3mxDF5mCI
 5ktbORRqbypY38NIubDIPZSKgbsEZ2igr/8Rx4oZbbMFIp9Et/GmpJLcZSTlg8QDqsIM
 phihscZQGyRoCM6pchK8r0Wc7OyzCjgk8FtgKSaEvSZCcN1WZkN0cZUEcfClJYL/F/hQ
 jTMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQH6YUpu3kZRpDsmSzD6fL0k4/LzV4jEQQIGG+VzbbQgXI4ZPEYpmOxgbVgTv/TR5ksFFkiHg=@lists.denx.de
X-Gm-Message-State: AOJu0YzAr0svsC5yuBSeG88Y6w7bAvWC6mMfkuSGGrcxptZduMjITu2m
 LHHDwFV4FtZ0dcBD5S1zWTaXzF8cGAsLByOgucxeaHPy7GZ/BqOjnBaEJLndPNM=
X-Gm-Gg: ASbGncv+I5gLeLRfr5VOK9lOStV2Cody55vULu9rjSDxeDuII6JHuaDWuRzMV998Y31
 UhBS9RS7ZDzZZFpflo5dnhgJk4RK7NW+CtqQDk4ZS55BbCm3bBIOsZbO9ABLM+6BF47JjWogV5k
 Gdgy613hJenRL5tmM4J5tkiod1kaAhhGdUAudIk8nXivx349KU02ihNtPHMQ9EIuT9eh0sJjkVY
 gt/vUQoagN23QDAYXOXuZeZ1ujj2M+r6LsBfMmLB21XJ2HDboQ6Mg==
X-Google-Smtp-Source: AGHT+IEa9+h+gsjlKhvdkU0HudK3Gy/L6nsUiyg6VfVe77UBhteSbHnIo235weRKm2UYN9z/UrlRZA==
X-Received: by 2002:a05:6000:156c:b0:385:e88a:7037 with SMTP id
 ffacd0b85a97d-385fd3cd72emr1649253f8f.6.1733219193006; 
 Tue, 03 Dec 2024 01:46:33 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e17574ebsm10643853f8f.30.2024.12.03.01.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 01:46:32 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/6] fastboot: Fix warning when CONFIG_SYS_64BIT_LBA
 is enable
In-Reply-To: <20241129122711.411917-2-patrice.chotard@foss.st.com>
References: <20241129122711.411917-1-patrice.chotard@foss.st.com>
 <20241129122711.411917-2-patrice.chotard@foss.st.com>
Date: Tue, 03 Dec 2024 10:46:29 +0100
Message-ID: <8734j5p096.fsf@baylibre.com>
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

Hi Patrice,

Thank you for the patch.

On ven., nov. 29, 2024 at 13:27, Patrice Chotard <patrice.chotard@foss.st.com> wrote:

> If CONFIG_SYS_64BIT_LBA is enable, following compilation warning is
> triggered:
>
>  CC      drivers/fastboot/fb_mmc.o
> ../drivers/fastboot/fb_mmc.c: In function 'fb_mmc_erase_mmc_hwpart':
> ../drivers/fastboot/fb_mmc.c:215:35: warning: format '%lu' expects
> argument of type 'long unsigned int', but argument 2 has type
> 'long long unsigned int' [-Wformat=]
>   215 |         printf("........ erased %lu bytes from mmc hwpart[%u]\n",
>       |                                 ~~^
>       |                                   |
>       |                                   long unsigned int
>       |                                 %llu
>   216 |                dev_desc->lba * dev_desc->blksz, dev_desc->hwpart);
>       |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                              |
>       |                              long long unsigned int
> ../drivers/fastboot/fb_mmc.c: In function 'fb_mmc_boot_ops':
> ../drivers/fastboot/fb_mmc.c:261:42: warning: format '%lu' expects
> argument of type 'long unsigned int', but argument 2 has type
> 'long long unsigned int' [-Wformat=]
>   261 |                 printf("........ wrote %lu bytes to EMMC_BOOT%d\n",
>       |                                        ~~^
>       |                                          |
>       |                                          long unsigned int
>       |                                        %llu
>   262 |                        blkcnt * blksz, hwpart);
>       |                        ~~~~~~~~~~~~~~
>       |                               |
>       |                               long long unsigned int
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Please feel free to take this through your tree.

Acked-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  drivers/fastboot/fb_mmc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
> index f11eb66761b..dca7c222f35 100644
> --- a/drivers/fastboot/fb_mmc.c
> +++ b/drivers/fastboot/fb_mmc.c
> @@ -211,8 +211,8 @@ static int fb_mmc_erase_mmc_hwpart(struct blk_desc *dev_desc)
>  		return 1;
>  	}
>  
> -	printf("........ erased %lu bytes from mmc hwpart[%u]\n",
> -	       dev_desc->lba * dev_desc->blksz, dev_desc->hwpart);
> +	printf("........ erased %llu bytes from mmc hwpart[%u]\n",
> +	       (u64)(dev_desc->lba * dev_desc->blksz), dev_desc->hwpart);
>  
>  	return 0;
>  }
> @@ -257,8 +257,8 @@ static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
>  			return;
>  		}
>  
> -		printf("........ wrote %lu bytes to EMMC_BOOT%d\n",
> -		       blkcnt * blksz, hwpart);
> +		printf("........ wrote %llu bytes to EMMC_BOOT%d\n",
> +		       (u64)(blkcnt * blksz), hwpart);
>  	} else { /* erase */
>  		if (fb_mmc_erase_mmc_hwpart(dev_desc)) {
>  			pr_err("Failed to erase EMMC_BOOT%d\n", hwpart);
> -- 
> 2.25.1
