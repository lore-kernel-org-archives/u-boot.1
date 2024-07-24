Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19335C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 08:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73BB288800;
	Wed, 24 Jul 2024 10:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qtprSIax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C309D88896; Wed, 24 Jul 2024 10:56:36 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D054887F6
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 10:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7a103ac7be3so984920a12.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721811386; x=1722416186; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9eSuAyqPyzz/Byk6WKc53HtdBYBvgdKVAfylPsflt24=;
 b=qtprSIaxqwbqolgusjTzmnyYTueoeem13iCHhAertKX0BWsZUeq420eh2j81vuNU8Q
 EKpoJAMMDifs2UIxGDAWIPUEVq1JA6my2vgt2cRTHTCOTdScYqIRFpx9TOVU8in9jae3
 vJZ5bgOd8BtXUhxalfOg8KuDq+Qrbaa56pq6c/dXAmprG5XUJdx422osf+fftpw6hd+6
 Kmr0wvuJPJrHY5QSoI3mHYF1N5Znj02MD8bs4hOH74cj9NZHZWGDHGRGjqBbS9qb0C0F
 bJunhzqKx3A30KAXYwLAdondHZMMnHA6xy04Q/eV9FD7w8LyhD1/JaEp2WIsZcAMBd9N
 Ww3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721811386; x=1722416186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9eSuAyqPyzz/Byk6WKc53HtdBYBvgdKVAfylPsflt24=;
 b=VJUyc0WEIirdxswKTEqnQ2qVmrHgKLKc91Lgiq7hKujutAvsZQCUoKB70cekegNC2o
 BHizOdwBeKxIQk66NrFTqV+xs+YeVJAsF3j1KR8YL1GNjrzzXHkq/roZW/st3bzWFTHz
 2oyuy1fryxUiDoMQyfHP7KsFKxH3a+HefK4LcdViMLo//gvuemwBQYfp9F8psep2xdKF
 0E5tX0eKj5CrnjCN9Fw+hvuYrcYmFg6Ugyb+LcLpgT2LC/G/I56B9ayxWG6zCoBAZGWe
 180t53EyWiBplFeF45Fm+ZRj9hPHq+8DIgUg5yVlSN/rcjlaDTMYxsto8hUcydwHKEfp
 pjdw==
X-Gm-Message-State: AOJu0YwIPVjq7/ftPhw+YnhJRnqiSKVdicN9jgV8NMkrg9TLMsSt4lk9
 Mbexv3NU9ysJSXUt645apY3lDUMAKZruAqrlOlSOkH+lBQyrPmuU9I0WoIb8uqIhltqlXJFfcRv
 FfpBfNo7b+tPQi7N+v3VuVvKiGROuvQWPC/v8sQ==
X-Google-Smtp-Source: AGHT+IGiu/6dPy0c6LcnshefaPr0pojx5jeNMlyh6tlwcO1V65f8uS8pdHtE45NVwLgRW9A5IxnJMCGJmSH2zaXJ5mI=
X-Received: by 2002:a17:90b:1090:b0:2c9:5f1e:1a62 with SMTP id
 98e67ed59e1d1-2cdaf779b22mr2425683a91.36.1721811386430; Wed, 24 Jul 2024
 01:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240724073448.710197-1-lukas.funke-oss@weidmueller.com>
 <20240724073448.710197-2-lukas.funke-oss@weidmueller.com>
In-Reply-To: <20240724073448.710197-2-lukas.funke-oss@weidmueller.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 24 Jul 2024 11:55:49 +0300
Message-ID: <CAC_iWjL1dE_KQRiz-3RwztZPt-C9V4=836obQ3PmkC1NrzgX6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tpm: call tpm_tis_wait_init() after tpm_tis_init()
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>
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

Thanks Lukas,

On Wed, 24 Jul 2024 at 10:35, <lukas.funke-oss@weidmueller.com> wrote:
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
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>
> Changes in v2:
> - Call tpm_tis_wait_init() from tpm_tis_init()
> - Use phy_ops for bus access in tpm_tis_wait_init()
>
>  drivers/tpm/tpm2_tis_core.c | 28 ++++++++++++++++++++++++++++
>  drivers/tpm/tpm2_tis_spi.c  | 29 -----------------------------
>  2 files changed, 28 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/tpm/tpm2_tis_core.c b/drivers/tpm/tpm2_tis_core.c
> index 680a6409433..1fdf8cfa319 100644
> --- a/drivers/tpm/tpm2_tis_core.c
> +++ b/drivers/tpm/tpm2_tis_core.c
> @@ -419,6 +419,28 @@ static bool tis_check_ops(struct tpm_tis_phy_ops *phy_ops)
>         return true;
>  }
>
> +static int tpm_tis_wait_init(struct udevice *dev, int loc)
> +{
> +       struct tpm_chip *chip = dev_get_priv(dev);
> +       unsigned long start, stop;
> +       u8 status;
> +       int ret;
> +
> +       start = get_timer(0);
> +       stop = chip->timeout_b;
> +       do {
> +               mdelay(TPM_TIMEOUT_MS);
> +               ret = chip->phy_ops->read_bytes(dev, TPM_ACCESS(loc), 1, &status);
> +               if (ret)
> +                       break;
> +
> +               if (status & TPM_ACCESS_VALID)
> +                       return 0;
> +       } while (get_timer(start) < stop);
> +
> +       return -EIO;
> +}
> +
>  int tpm_tis_init(struct udevice *dev)
>  {
>         struct tpm_chip *chip = dev_get_priv(dev);
> @@ -436,6 +458,12 @@ int tpm_tis_init(struct udevice *dev)
>         chip->timeout_c = TIS_SHORT_TIMEOUT_MS;
>         chip->timeout_d = TIS_SHORT_TIMEOUT_MS;
>
> +       ret = tpm_tis_wait_init(dev, chip->locality);
> +       if (ret) {
> +               log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
> +               return ret;
> +       }
> +
>         ret = tpm_tis_request_locality(dev, 0);
>         if (ret)
>                 return ret;
> diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> index b0fe97ab1d0..7909a147c2d 100644
> --- a/drivers/tpm/tpm2_tis_spi.c
> +++ b/drivers/tpm/tpm2_tis_spi.c
> @@ -188,29 +188,6 @@ static int tpm_tis_spi_write32(struct udevice *dev, u32 addr, u32 value)
>         return tpm_tis_spi_write(dev, addr, sizeof(value), (u8 *)&value_le);
>  }
>
> -static int tpm_tis_wait_init(struct udevice *dev, int loc)
> -{
> -       struct tpm_chip *chip = dev_get_priv(dev);
> -       unsigned long start, stop;
> -       u8 status;
> -       int ret;
> -
> -       start = get_timer(0);
> -       stop = chip->timeout_b;
> -       do {
> -               mdelay(TPM_TIMEOUT_MS);
> -
> -               ret = tpm_tis_spi_read(dev, TPM_ACCESS(loc), 1, &status);
> -               if (ret)
> -                       break;
> -
> -               if (status & TPM_ACCESS_VALID)
> -                       return 0;
> -       } while (get_timer(start) < stop);
> -
> -       return -EIO;
> -}
> -
>  static struct tpm_tis_phy_ops phy_ops = {
>         .read_bytes = tpm_tis_spi_read,
>         .write_bytes = tpm_tis_spi_write,
> @@ -256,12 +233,6 @@ static int tpm_tis_spi_probe(struct udevice *dev)
>         /* Ensure a minimum amount of time elapsed since reset of the TPM */
>         mdelay(drv_data->time_before_first_cmd_ms);
>
> -       ret = tpm_tis_wait_init(dev, chip->locality);
> -       if (ret) {
> -               log(LOGC_DM, LOGL_ERR, "%s: no device found\n", __func__);
> -               return ret;
> -       }
> -
>         tpm_tis_ops_register(dev, &phy_ops);
>         ret = tpm_tis_init(dev);
>         if (ret)
> --
> 2.30.2
>

I'll manually add the fixes tag on merge. Other than that
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
