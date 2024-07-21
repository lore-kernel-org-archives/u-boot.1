Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D188C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A99A7880A5;
	Sun, 21 Jul 2024 12:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gOMFH784";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2A5987FC7; Sun, 21 Jul 2024 12:08:46 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA0487B8D
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70361c6fd50so1682855a34.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556523; x=1722161323; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T9FLvzxbxaOQPeZeouKhFfIpw1o/qp9F6k5NfVIpUTI=;
 b=gOMFH7846zyToKgUBVHabviWN5kqxAWtiwfujPspabz463QnJzXETWO2jKPnILqVRK
 yga/aVkf/FS/EcPIj/4LkX2Ch4KUT7/UiZ2GuyeO25JfN9ZoFfxIZOpV1Nin+GHf0pBe
 DSTcAwaMNyuk0i4IF1dzkvDQl64dqLnxwpN+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556523; x=1722161323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T9FLvzxbxaOQPeZeouKhFfIpw1o/qp9F6k5NfVIpUTI=;
 b=SdMT/ZSFkWfwvklXn30vAW0bVNZg/QgBSpsIEg2dODr/PGZAoPtJ+fGqwGrc+tPpJx
 2b1L/lUTsYQ2exgQpLmIzwpQaAYbsA8yVrpxLcakUSkeVm0+h0VYCPRRVoU46nX6v+Iz
 5Sd3Oj7d+gALVyKTzrCa1FJ1v6orPrR4X0OYK/imcr90RvTZ74Vim6tcGkBGpEgSHFYW
 kZDfNXiO3CxVNuip3351HuntwkESWe8Fzb0L9QHsu7SUgp59LPdvLkb8tAm9FflcLuUy
 shJ7W2wxNu5jRXz7c6kFt3WRSNxAlhvSA6jAfMpKYLXgkpJlkO2nBQ3gYHrRFB4hymt9
 t87A==
X-Gm-Message-State: AOJu0YyrzRE3eSkdxJ4fjIYGH9f9IWoRuJLXvxH3a5gj1SrtISZHDMpq
 zbGE7z8vQi+n+ksdcM5ZNnZNC+XQZAHBYXlKqQ22ETdy0M44JQVvqQh/ioC/ROHITli1T6ZYX1G
 r7k/e9wzvoLAEMWnQaJICeffegbo+7sbjcvE0
X-Google-Smtp-Source: AGHT+IHrb+r4UouNLSUvQi6Nly1KTMCACmIXRT/I0EuEfyBJfB2inOHd5ERkXrVP2ODNL8btVGwLNGx9+KvM/NjRSvM=
X-Received: by 2002:a05:6830:3886:b0:707:a4f3:e134 with SMTP id
 46e09a7af769-708fdaf8f9emr8328009a34.19.1721556523516; Sun, 21 Jul 2024
 03:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240715112302.652527-1-lukas.funke-oss@weidmueller.com>
 <20240715112302.652527-2-lukas.funke-oss@weidmueller.com>
In-Reply-To: <20240715112302.652527-2-lukas.funke-oss@weidmueller.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Jul 2024 11:08:32 +0100
Message-ID: <CAFLszTgX8Tfn=qC_ZBMR2M+iwFAOLKQhGQg8w42F1saAmZq4Eg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: call tpm_tis_wait_init() after tpm_tis_init()
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Lukas Funke <lukas.funke@weidmueller.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

Hi,

On Mon, 15 Jul 2024 at 12:23, <lukas.funke-oss@weidmueller.com> wrote:
>
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> tpm_tis_wait_init() is using the 'chip->timeout_b' field which is
> initialized in tpm_tis_init(). However, the init-function is called
> *after* tpm_tis_wait_init() introducing an uninitalized field access.
>
> This commit switches both routines.
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>
>  drivers/tpm/tpm2_tis_spi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> index b0fe97ab1d0..5a4dbfd3ccb 100644
> --- a/drivers/tpm/tpm2_tis_spi.c
> +++ b/drivers/tpm/tpm2_tis_spi.c
> @@ -256,17 +256,17 @@ static int tpm_tis_spi_probe(struct udevice *dev)
>         /* Ensure a minimum amount of time elapsed since reset of the TPM */
>         mdelay(drv_data->time_before_first_cmd_ms);
>
> +       tpm_tis_ops_register(dev, &phy_ops);
> +       ret = tpm_tis_init(dev);
> +       if (ret)
> +               goto err;
> +
>         ret = tpm_tis_wait_init(dev, chip->locality);
>         if (ret) {
>                 log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
>                 return ret;
>         }
>
> -       tpm_tis_ops_register(dev, &phy_ops);
> -       ret = tpm_tis_init(dev);
> -       if (ret)
> -               goto err;
> -
>         priv->pcr_count = drv_data->pcr_count;
>         priv->pcr_select_min = drv_data->pcr_select_min;
>         priv->version = TPM_V2;
> --
> 2.30.2
>

This needs a Fixes tag for a5c30c26b28 (HEAD) tpm: Use the new API on
tpm2 spi driver

The old code set up the timeouts first, then did the wait_init.
Presumably the point of wait_init is to wait before doing the init, so
we should try to keep that behaviour, unless it is actually wrong.

So my thought would be to move the setup of the required timeout into
tpm_tis_ops_register(), instead.

Regards,
Simon
