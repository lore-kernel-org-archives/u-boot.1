Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5885C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 13:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4D287823;
	Tue,  2 Jan 2024 14:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uscjR9bM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D554877B3; Tue,  2 Jan 2024 14:01:31 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E1D98747A
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 14:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33687627ad0so8779173f8f.2
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 05:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704200489; x=1704805289;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pOT624vsm8ozhR1bpqPmIkQLXpH5BMEXLmPOC9WRT3E=;
 b=uscjR9bMro2Pp+cwzfBELiB9OXMlntCZTW37NYIdvTB1s/Ce5s2hTEjrukTDZHr2+z
 /Qkcl3HAAcPv+JA75FDT6dfZgBSjlcl/pjdyuGtpsDZapAS1PcBtTfjQm5VZnc1S9x7A
 p9+b5FPuRlmLu/n3V4sQj6vbmIELq3lC9wyv4CxZc36uq6qCQzewjG0e48fo10lsJAOJ
 RiMlIW7B6RwS1d6eiuQhf3eJgKt2WfoEm7yRnLppF9ZyQgWct1aL31W69zEcUx5NWr3I
 0pl1bRIvYjmO9fh2S77kvtsrEv8qAVdt+v5xqXIQscaDNWMiY2C6bYZbSW/39pjLHXJC
 LZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704200489; x=1704805289;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pOT624vsm8ozhR1bpqPmIkQLXpH5BMEXLmPOC9WRT3E=;
 b=FZsSf+4kvI9dwXfNXnHL42OgmwTectKFlNUEGVqt7DTPFkiHAGnTJptVdPFrHo2r4Z
 gQgBC8boRiRXNVJ/kbb1SFghFwKlaiuz6pXhslDuJoiXa2HxW+Svyoq/OliohKKP+0r0
 h1SdZWCgEr6I5vgVRQB2OCX6/UI0VZE/ZSGJnwm2Ty4Y/BdBH1ysjMswRVMCeM1pe6xQ
 b619JQAfVbVZY9eEarndFw56e5pHmGOHKZ9Trqc3Wv+JPJEWeZv8b4hFDbL4axwLh9FZ
 qrq9i/otBg6tyCaWTKi8YS8v6fv7e5Gpfz0IDXGZVIPndFFYf1UOsiLN86OcI5nYh/Yi
 ZseQ==
X-Gm-Message-State: AOJu0Yzw3pP/u3s9D5DDQnlfv4tJ6u4BZdQWD32QjA3wYiNi1OyKZJuv
 W0OLK5cAEbE+6sD/FFwamwxFJDKvkpnwnw==
X-Google-Smtp-Source: AGHT+IHk7Upi0jEXcBuKxzKEXcuPpbqiStAq/2VpmbZo3nbUkt7H6hbIMixtteTZNLNXFzEMQ05gqg==
X-Received: by 2002:adf:f745:0:b0:336:d9ca:5c6c with SMTP id
 z5-20020adff745000000b00336d9ca5c6cmr5956419wrp.137.1704200489176; 
 Tue, 02 Jan 2024 05:01:29 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 a1-20020adfed01000000b0033748f5600csm1335506wro.108.2024.01.02.05.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 05:01:28 -0800 (PST)
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
Subject: Re: [PATCH v1 12/12] fastboot: fb_nand: add missing newlines in
 pr_err() macro
In-Reply-To: <20231228153922.84323-13-avromanov@salutedevices.com>
References: <20231228153922.84323-1-avromanov@salutedevices.com>
 <20231228153922.84323-13-avromanov@salutedevices.com>
Date: Tue, 02 Jan 2024 14:01:28 +0100
Message-ID: <87r0iz51p3.fsf@baylibre.com>
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

> pr_err() doesn't add an newline symbol when printing.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/fastboot/fb_nand.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
> index 39d888301f..9db1903e41 100644
> --- a/drivers/fastboot/fb_nand.c
> +++ b/drivers/fastboot/fb_nand.c
> @@ -48,13 +48,13 @@ static int fb_nand_lookup(const char *partname,
>  
>  	ret = find_dev_and_part(partname, &dev, &pnum, part);
>  	if (ret) {
> -		pr_err("cannot find partition: '%s'", partname);
> +		pr_err("cannot find partition: '%s'\n", partname);
>  		fastboot_fail("cannot find partition", response);
>  		return ret;
>  	}
>  
>  	if (dev->id->type != MTD_DEV_TYPE_NAND && dev->id->type != MTD_DEV_TYPE_SPINAND) {
> -		pr_err("partition '%s' is not stored on a NAND device",
> +		pr_err("partition '%s' is not stored on a NAND device\n",
>  		      partname);
>  		fastboot_fail("not a NAND device", response);
>  		return -EINVAL;
> @@ -178,7 +178,7 @@ void fastboot_nand_flash_write(const char *cmd, void *download_buffer,
>  
>  	ret = fb_nand_lookup(cmd, &mtd, &part, response);
>  	if (ret) {
> -		pr_err("invalid NAND device");
> +		pr_err("invalid NAND device\n");
>  		fastboot_fail("invalid NAND device", response);
>  		return;
>  	}
> @@ -242,7 +242,7 @@ void fastboot_nand_erase(const char *cmd, char *response)
>  
>  	ret = fb_nand_lookup(cmd, &mtd, &part, response);
>  	if (ret) {
> -		pr_err("invalid NAND device");
> +		pr_err("invalid NAND device\n");
>  		fastboot_fail("invalid NAND device", response);
>  		return;
>  	}
> @@ -253,7 +253,7 @@ void fastboot_nand_erase(const char *cmd, char *response)
>  
>  	ret = _fb_nand_erase(mtd, part);
>  	if (ret) {
> -		pr_err("failed erasing from device %s", mtd->name);
> +		pr_err("failed erasing from device %s\n", mtd->name);
>  		fastboot_fail("failed erasing from device", response);
>  		return;
>  	}
> -- 
> 2.30.1
