Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4C2C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 13:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 798DA8756F;
	Tue,  2 Jan 2024 14:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KN7LVOhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 952438776E; Tue,  2 Jan 2024 14:00:56 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B888747A
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 14:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so53351615e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 05:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704200454; x=1704805254;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vIESVkrqiFw1BW4xKZ/rlRyuhuyUb+HZN+bwUTpZ9io=;
 b=KN7LVOhQsdj+6vg6pYP7rwwUTHlFWlT29hZ+xo1pvgDS/sNOAH0UGkqlDb2gBmKp1U
 eO0H5tfrV511si+fK3oDFNi5zrKz9qMxtg3tN1TJwFIW3u7PX6IYb2n4aTWPtjOjZrB2
 1tkVhq0E5nYOGARWvKT5KuHP4OWMuRbPC9/qNwuObAQ3WQBcbG+tY2WqQrlaah/3D2EX
 kTdIsOjReYiqpGAs0ijS7dl3IP+e/upKBhK9NFxBMbZwugIqBRthMpGmv0gOUjmol/MC
 Fply/2bHN9tunabyatZJi0WiMZ9syFA6QLbt59IFPHIjcgykWx4FB+Kls7zntIYtxirU
 7WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704200454; x=1704805254;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vIESVkrqiFw1BW4xKZ/rlRyuhuyUb+HZN+bwUTpZ9io=;
 b=Afngd+IDG+9NSDouQHI5xg+jj0dp/KeEgffp/5awRGTUyfW2gqbDNfGe+XJnNzTR5e
 XGk+qGJaHZZYHg97+7LnmaUBZ1Syq+xuC2VEUVg9EM7ujBdZhXdWssY8vKzzsnLELKF/
 qn8+Oh1QVqxzKQ/hha8majDsJeHHKKihkubqctY/D5bbhs5sLgbmDBg/bbZqQi/IvmJO
 R6nbhrU/01SzEwobX+rc0QSvpGyufEFdNWEgQz9IkuGHoC8QXFXtUR/DglrEl3FxRSVs
 0twlEsYJEXe/vRBpTuCrWGhmuo8Dt5t0Z4mF6ByfogwJ2BxTPMOqvoV9Bt2yVp64gB+c
 mjug==
X-Gm-Message-State: AOJu0Yz3MLlEgfyVvkeMYojxO+0P0Ul/lbXFgPM4eY0fNQ69WW6MHX1N
 X9XZ2pG/AQ2mUZfglTuIWXE5OPekB52fgQ==
X-Google-Smtp-Source: AGHT+IHZHlo4SjkjXfGgvSYJ75CSm2tjdzHXhXG0zifj6BV7fkoQ5FQHj+J9qDZXLxKNrA6Mz7KmLQ==
X-Received: by 2002:a05:600c:8515:b0:40c:2e0b:f41b with SMTP id
 gw21-20020a05600c851500b0040c2e0bf41bmr9453754wmb.14.1704200453931; 
 Tue, 02 Jan 2024 05:00:53 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 e25-20020adfa459000000b003365951cef9sm28614772wra.55.2024.01.02.05.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 05:00:53 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>, michal.simek@amd.com,
 marex@denx.de, michael@walle.cc, stcarlso@linux.microsoft.com,
 tobias@waldekranz.com, seanedmond@microsoft.com,
 abdellatif.elkhlifi@arm.com, neil.armstrong@linaro.org, n-jain1@ti.com,
 xypron.glpk@gmx.de, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, frieder.schrempf@kontron.de,
 sjg@chromium.org, hs@denx.de, sean.anderson@seco.com,
 dimorinny@google.com, patrick.delaunay@foss.st.com
Cc: u-boot@lists.denx.de, kernel@salutedevices.com, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: Re: [PATCH v1 11/12] fastboot: enable FASTBOOT_FLASH option for SPI
 NAND devices
In-Reply-To: <20231228153922.84323-12-avromanov@salutedevices.com>
References: <20231228153922.84323-1-avromanov@salutedevices.com>
 <20231228153922.84323-12-avromanov@salutedevices.com>
Date: Tue, 02 Jan 2024 14:00:52 +0100
Message-ID: <87ttnv51q3.fsf@baylibre.com>
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

Hi Alexey,

Thank you for the patch.

On Thu, Dec 28, 2023 at 18:39, Alexey Romanov <avromanov@salutedevices.com> wrote:

> From now we can use FASTBOOT_FLASH_NAND option for SPI NAND.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/fastboot/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index a3df9aa3d0..3cfeea4837 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -86,7 +86,7 @@ config FASTBOOT_USB_DEV
>  config FASTBOOT_FLASH
>  	bool "Enable FASTBOOT FLASH command"
>  	default y if ARCH_SUNXI || ARCH_ROCKCHIP
> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
> +	depends on MMC || ((MTD_RAW_NAND || MTD_SPI_NAND) && CMD_MTDPARTS)
>  	select IMAGE_SPARSE
>  	help
>  	  The fastboot protocol includes a "flash" command for writing
> @@ -112,7 +112,7 @@ config FASTBOOT_FLASH_MMC
>  
>  config FASTBOOT_FLASH_NAND
>  	bool "FASTBOOT on NAND"
> -	depends on MTD_RAW_NAND && CMD_MTDPARTS
> +	depends on (MTD_RAW_NAND || MTD_SPI_NAND) && CMD_MTDPARTS
>  
>  endchoice
>  
> -- 
> 2.30.1
