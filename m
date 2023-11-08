Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74030C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1105874E9;
	Wed,  8 Nov 2023 05:24:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YxwNpleW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE98874E9; Wed,  8 Nov 2023 05:24:27 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C948749D
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7dd65052aso79671067b3.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417464; x=1700022264; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=StGKYMJKqA6tE5H+ea2isZXsW0DTOern8E028su9Rvk=;
 b=YxwNpleWivu+imL4nSXoda8vo3RLdpw+ZY4MifiUivpCkMgz2jaBbQ8ASD8zBRQfvp
 s1BKP4hHt19tPMHVsx0OXcc4vyqzlDB0vAo+tppEd1791M9PK2l/1ShS56yl0I5jgiet
 0HhEiobzseyABWtm9GsimYtMioh4PF+f4wqJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417464; x=1700022264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=StGKYMJKqA6tE5H+ea2isZXsW0DTOern8E028su9Rvk=;
 b=e3PbKjEw5QOSQjf9BMAMD/R+0pq+cp8NMkh9xgO+KV3lJUzLe8IWD/1ocuJ/Su+a6k
 4VUV9zVMmUNq99T82Aup7hMCUERxMNf3o7xSL8okV8C6tDlYGzspYdPgIUWbn9WHvJXc
 kfVVjSHs6RJDj1Qit85+AAOsB65XT0B8DZ8YhWEmJYjmb9b+/IN8f12Wn4PLqGtoppRk
 HQFME4R4ct9VAwhZmH8pRzqDsVpGvgHyQZqWUh8fnmV9ZgVmKlY8IVpUX963qe1zPFQf
 MXfaiOzl7NCrXXC6puZCItDaZoUeFemckRKUIEPmkTdUZ6wdqSmIuVZjKGTJQiFf9XnT
 u7uw==
X-Gm-Message-State: AOJu0YyiJXV4II3jCNc42vknPdVV8qgoeXVnKP5ZddCHfsT+tyui0Wo8
 3lQgci/yApbu/BRN0Zy3S1z8Y34ES9sr1lzZzkJXjw==
X-Google-Smtp-Source: AGHT+IFJvPSBcRYSPzqTkoHbNdfCVAUSHjnnCNw/MdR+swqP2WJFtIAhXw8GKrbsuyeheWHbCuzFe0W5egvGMkmdyGs=
X-Received: by 2002:a0d:d904:0:b0:5a7:ba17:15ac with SMTP id
 b4-20020a0dd904000000b005a7ba1715acmr719184ywe.41.1699417463879; Tue, 07 Nov
 2023 20:24:23 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-7-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-7-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:38 -0700
Message-ID: <CAPnjgZ3Zja4vqdy=DKwEv42bkhqP=O8OwWzVCBg=RSYb6hCgBQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/25] spl: Remove dev from spl_load_info
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Sean,

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> dev and priv server the same purpose, and are never set at the same time.

serve

> Remove dev and convert all users to priv. While we're at it, reorder bl_len
> to be last for better alignment.

It's a bit unfortunate to drop the device, isn't it? But then, as
before, this is self-contained so Is suppose it doesn't matter what we
store.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon



>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  common/spl/spl_mmc.c       | 6 +++---
>  common/spl/spl_spi.c       | 6 +++---
>  drivers/usb/gadget/f_sdp.c | 6 +++---
>  include/spl.h              | 4 +---
>  4 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 6d9137c32e0..3d7551a7dae 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -65,7 +65,7 @@ static int mmc_load_legacy(struct spl_image_info *spl_image,
>  static ulong h_spl_load_read(struct spl_load_info *load, ulong sector,
>                              ulong count, void *buf)
>  {
> -       struct mmc *mmc = load->dev;
> +       struct mmc *mmc = load->priv;
>
>         return blk_dread(mmc_get_blk_desc(mmc), sector, count, buf);
>  }
> @@ -105,7 +105,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
>                 struct spl_load_info load;
>
>                 debug("Found FIT\n");
> -               load.dev = mmc;
> +               load.priv = mmc;
>                 load.filename = NULL;
>                 load.bl_len = mmc->read_bl_len;
>                 load.read = h_spl_load_read;
> @@ -114,7 +114,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
>                    valid_container_hdr((void *)header)) {
>                 struct spl_load_info load;
>
> -               load.dev = mmc;
> +               load.priv = mmc;
>                 load.filename = NULL;
>                 load.bl_len = mmc->read_bl_len;
>                 load.read = h_spl_load_read;
> diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
> index d83d70f2f33..af7a28e7c25 100644
> --- a/common/spl/spl_spi.c
> +++ b/common/spl/spl_spi.c
> @@ -59,7 +59,7 @@ static int spi_load_image_os(struct spl_image_info *spl_image,
>  static ulong spl_spi_fit_read(struct spl_load_info *load, ulong sector,
>                               ulong count, void *buf)
>  {
> -       struct spi_flash *flash = load->dev;
> +       struct spi_flash *flash = load->priv;
>         ulong ret;
>
>         ret = spi_flash_read(flash, sector, count, buf);
> @@ -151,7 +151,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
>                         struct spl_load_info load;
>
>                         debug("Found FIT\n");
> -                       load.dev = flash;
> +                       load.priv = flash;
>                         load.filename = NULL;
>                         load.bl_len = 1;
>                         load.read = spl_spi_fit_read;
> @@ -162,7 +162,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
>                            valid_container_hdr((void *)header)) {
>                         struct spl_load_info load;
>
> -                       load.dev = flash;
> +                       load.priv = flash;
>                         load.filename = NULL;
>                         load.bl_len = 1;
>                         load.read = spl_spi_fit_read;
> diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
> index ee9384fb37e..1b16b7eb452 100644
> --- a/drivers/usb/gadget/f_sdp.c
> +++ b/drivers/usb/gadget/f_sdp.c
> @@ -744,7 +744,7 @@ static ulong sdp_load_read(struct spl_load_info *load, ulong sector,
>  {
>         debug("%s: sector %lx, count %lx, buf %lx\n",
>               __func__, sector, count, (ulong)buf);
> -       memcpy(buf, (void *)(load->dev + sector), count);
> +       memcpy(buf, (void *)(load->priv + sector), count);
>         return count;
>  }
>
> @@ -844,7 +844,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
>                                 struct spl_load_info load;
>
>                                 debug("Found FIT\n");
> -                               load.dev = header;
> +                               load.priv = header;
>                                 load.bl_len = 1;
>                                 load.read = sdp_load_read;
>                                 spl_load_simple_fit(spl_image, &load, 0,
> @@ -857,7 +857,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
>                             valid_container_hdr((void *)header)) {
>                                 struct spl_load_info load;
>
> -                               load.dev = header;
> +                               load.priv = header;
>                                 load.bl_len = 1;
>                                 load.read = sdp_load_read;
>                                 spl_load_imx_container(spl_image, &load, 0);
> diff --git a/include/spl.h b/include/spl.h
> index 8ff20adc28e..951e136b9ea 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -285,16 +285,13 @@ static inline void *spl_image_fdt_addr(struct spl_image_info *info)
>  /**
>   * Information required to load data from a device
>   *
> - * @dev: Pointer to the device, e.g. struct mmc *
>   * @priv: Private data for the device
>   * @bl_len: Block length for reading in bytes
>   * @filename: Name of the fit image file.
>   * @read: Function to call to read from the device
>   */
>  struct spl_load_info {
> -       void *dev;
>         void *priv;
> -       int bl_len;
>         const char *filename;
>         /**
>          * read() - Read from device
> @@ -307,6 +304,7 @@ struct spl_load_info {
>          */
>         ulong (*read)(struct spl_load_info *load, ulong sector, ulong count,
>                       void *buf);
> +       int bl_len;
>  };
>
>  /*
> --
> 2.37.1
>
