Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C9DC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 07:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C36C880DE;
	Thu, 28 Mar 2024 08:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I98T45Ml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27103880DB; Thu, 28 Mar 2024 08:09:17 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5AA9880C0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d68c6a4630so5893481fa.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711609754; x=1712214554; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UoJzO1kuV1kcvY2XIiS+XhU++UxFl8uAuHVxZKLYILk=;
 b=I98T45MlKIDFW5Pv8tPtggMj5ovHnB32u4T969KHiE1GCYlwOQL9v1p8RV76qaIrTs
 e+TRNFwOb7gxkzjQukDg+5gb+a5A133MvKZ5KCdpPJJsM0fVQ/YeIErg3dXnjGjZvTSr
 N/UIOb6SZsPweG/59s/3UrpRQCUjEs0DKrlvcg5MqTiMdxRArIGR4xR+YW5AJmCMwGlY
 L9Tg5dfXPfzofwx11ZCKLT1P9aAhtFRweqAciK+I3dqnKnUavb9sEEkURjxgB7MJYPpm
 RN42NoryzkJmifWd6+m4D/Tk8Er/OdnDgZ7r0wFHJhK2QzqCNGsCe6T+rpebL8Mfka7l
 xxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711609754; x=1712214554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UoJzO1kuV1kcvY2XIiS+XhU++UxFl8uAuHVxZKLYILk=;
 b=qyNI1pWYOsz+mcijvjHVgfsoWG5JzrcJc9Se35YOxdS0/JAi/tE5Hx8z4rXHBMM8SX
 OROAJa31feX0ammtOngcqbXtdfu7VWqApz0c8vGpTINm2kOPYRux9tlg8ByKR3c//Scv
 g3kh+1AezG9ISGDyjl7suIoA7rsgB6JOjkyiAIhFSbwL+iaVWqGCmV7Nku4iIOS14jA+
 7KE5OPe3TN20sACobDMoNG4HbDp3FkaG8JgIqNPrGlR9FGcaPhYxzb9Akg7B82B7uCyu
 jiclJ1KilrO8k3r2LwD4FnbF9zKrmogY5vgW6/S6ws/OYIketIWSY+m+YfOdwp3s1F2T
 070w==
X-Gm-Message-State: AOJu0YzkBf4toLwnY8Pj9FvKSOIvW8XeKtNi5j3QVY8LYr923TfHWR61
 sXLE2uUToCMLayeqcPUc3d3dyW2/gwfL6GBUtt72CiX3X9R1HB8R7l33UaBH+Mm2A1ERz6//pGe
 Jvu+BL6MMQhDczZKKny6AxOBDhEDVGS2NtjGyQw==
X-Google-Smtp-Source: AGHT+IEXBOT07a9i8bq2oq2Z5ondU+4kdtT4+o2OLSWFA+t6mvSMCB1r8WLzUw4wIIxTRcpnaj5DZaOTdi2f8uCant8=
X-Received: by 2002:a2e:960e:0:b0:2d6:e0a9:9981 with SMTP id
 v14-20020a2e960e000000b002d6e0a99981mr1532960ljh.9.1711609754150; Thu, 28 Mar
 2024 00:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240327221205.1871317-1-tharvey@gateworks.com>
In-Reply-To: <20240327221205.1871317-1-tharvey@gateworks.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Mar 2024 09:08:37 +0200
Message-ID: <CAC_iWjKFHnnFf1iHdH2xmSDZQi2D6iNxkO6dWWMhf+X1cDd7qQ@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: display warning if using gpio reset with TPM
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

Thanks Tim

On Thu, 28 Mar 2024 at 00:12, Tim Harvey <tharvey@gateworks.com> wrote:
>
> Instead of displaying what looks like an error message if a
> gpio-reset dt prop is missing for a TPM display a warning that
> having a gpio reset on a TPM should not be used for a secure production
> device.
>
> TCG TIS spec [1] says:
> "The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to the
> platform CPU Reset signal such that it complies with the requirements
> specified in section 1.2.7 HOST Platform Reset in the PC Client
> Implementation Specification for Conventional BIOS."
>
> The reasoning is that you should not be able to toggle a GPIO and reset
> the TPM without resetting the CPU as well because if an attacker can
> break into your OS via an OS level security flaw they can then reset the
> TPM via GPIO and replay the measurements required to unseal keys
> that you have otherwise protected.
>
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2: change the message to a warning and update commit desc/log
> ---
>  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> index de9cf8f21e07..c9c83f6f0fc8 100644
> --- a/drivers/tpm/tpm2_tis_spi.c
> +++ b/drivers/tpm/tpm2_tis_spi.c
> @@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct udevice *dev)
>                         /* legacy reset */
>                         ret = gpio_request_by_name(dev, "gpio-reset", 0,
>                                                    &reset_gpio, GPIOD_IS_OUT);
> -                       if (ret) {
> -                               log(LOGC_NONE, LOGL_NOTICE,
> -                                   "%s: missing reset GPIO\n", __func__);
> +                       if (ret)
>                                 goto init;
> -                       }
>                         log(LOGC_NONE, LOGL_NOTICE,
>                             "%s: gpio-reset is deprecated\n", __func__);
>                 }
> +               log(LOGC_NONE, LOGL_WARNING,
> +                   "%s: TPM gpio reset should not be used on secure production devices\n",
> +                   dev->name);
>                 dm_gpio_set_value(&reset_gpio, 1);
>                 mdelay(1);
>                 dm_gpio_set_value(&reset_gpio, 0);
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
