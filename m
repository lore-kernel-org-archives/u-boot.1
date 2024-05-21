Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3758C25B78
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 19:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21A7A8836D;
	Tue, 21 May 2024 21:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QhQXEbWs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3408C88381; Tue, 21 May 2024 21:01:42 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3CDA8828E
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 21:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-523b20e2615so6713562e87.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716318099; x=1716922899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dQadEUZilxpMMeuuP51NsfGZLnUSMZOa8S0bbZ8CbDI=;
 b=QhQXEbWsfvANqfHfHy5HyG8FlDpbC1TT93xyKJuvsbi2OFNMvbCCUGLN/osLsQn1XA
 s5V5FqZ1qySL58jGxlt3uoq867x+UUXZNQaFIPt+3K6JcTHczWL1iE7lAzueNBkfXRe5
 nUnQiva0H9MLDgjLQKnADfqGYt+McMqdn5uF3LHDA+kRm2KSULuJvtESS8u9URWLla4p
 H+0FmVrXTwcpL7z1Vj4YifdhY7xq2/mAJISJtKfRZ34BZmrdLsrQaSXhbkHppJ/B3IPc
 p97V+RykzJP1SCrJu2iFGf40TOTbdBiPztdr0kwarR7OAHKPgLg614DX5h3SQbZqWG8E
 1m5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716318099; x=1716922899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dQadEUZilxpMMeuuP51NsfGZLnUSMZOa8S0bbZ8CbDI=;
 b=fgoILgyriZQ1uth8EP7urJuzTVEth5Djt3cCWjc3uP0j+2TmyhcKLf4WXLYlbibhFO
 0BFuizTQj4INw0zrAJdmC4/56ekNTaWe5P45FwhCxKmVFu3KRK+SkLUoUVyYae2VU2tp
 TvNxK/+JpZz15j3jKAGRvtsq5pnuqfVLtb2DhSXZrVYwUfkuc7QDhVekBA/jnfFY4iyx
 O/grByqoGLtOixZD4Vzj9tf5IEmj2AqJGKMSstVfHOPDv/yx7gFCd/cRwsp4eC1ShDUw
 /GUX7G1uveA8EkhI4hoREw7i4Rj8IhEDD/Hp2EXWhe4AN6UAUyeqSwYwp1fzbiaxckLa
 2ZnQ==
X-Gm-Message-State: AOJu0YwQzZX1H2SkqJel/o2FnrbMo6Q+gRrSg5mfClIjf0s9PQUJJe8N
 jl9FktOCn4a8D+mhRzTv9bN+9No+vSctEh+dlJuaEXqLeNRpm79njIC8xgWFxBIT9LnPsTsadPU
 X45dAk3f653PcGlqVuQT49+zNi9AoYIZXlhMrBg==
X-Google-Smtp-Source: AGHT+IGl1mqq/AWPDB+5wA+JFxQ7v2rRtW59goME2vvIo8WCzIsWyEPyGOMYVoqDOanBJPz35h+1SJzVEFTgW/HByWc=
X-Received: by 2002:a05:6512:3d87:b0:523:a89f:aa64 with SMTP id
 2adb3069b0e04-523a89fab47mr14773556e87.20.1716318099092; Tue, 21 May 2024
 12:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240515232138.3065987-1-tharvey@gateworks.com>
In-Reply-To: <20240515232138.3065987-1-tharvey@gateworks.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 May 2024 22:01:03 +0300
Message-ID: <CAC_iWjLkiAY6BabjmTJ7Vv7OHGfhbmKWKUfv5gpvF1wQDwjVeQ@mail.gmail.com>
Subject: Re: [PATCH v3] tpm: display warning if using gpio reset with TPM
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

On Thu, 16 May 2024 at 02:21, Tim Harvey <tharvey@gateworks.com> wrote:
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
> Additionally restructure the code for improved readability allowing for
> removal of the init label.
>
> Before:
>  - board with no reset gpio
> u-boot=> tpm init && tpm info
> tpm_tis_spi_probe: missing reset GPIO
> tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
>  - board with a reset gpio
> u-boot=> tpm init && tpm info
> tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
>
> After:
>  - board with no reset gpio
> u-boot=> tpm init && tpm info
> tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
>  - board with a reset gpio
> u-boot=> tpm init && tpm info
> tpm@1: TPM gpio reset should not be used on secure production devices
> tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
>
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v3: restructure code for improved readability (recommended by Miquel)
> v2: change the message to a warning
> ---
>  drivers/tpm/tpm2_tis_spi.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> index 28079b5039a3..b0fe97ab1d08 100644
> --- a/drivers/tpm/tpm2_tis_spi.c
> +++ b/drivers/tpm/tpm2_tis_spi.c
> @@ -237,19 +237,22 @@ static int tpm_tis_spi_probe(struct udevice *dev)
>                         /* legacy reset */
>                         ret = gpio_request_by_name(dev, "gpio-reset", 0,
>                                                    &reset_gpio, GPIOD_IS_OUT);
> -                       if (ret) {
> +                       if (!ret) {
>                                 log(LOGC_NONE, LOGL_NOTICE,
> -                                   "%s: missing reset GPIO\n", __func__);
> -                               goto init;
> +                                   "%s: gpio-reset is deprecated\n", __func__);
>                         }
> -                       log(LOGC_NONE, LOGL_NOTICE,
> -                           "%s: gpio-reset is deprecated\n", __func__);
>                 }
> -               dm_gpio_set_value(&reset_gpio, 1);
> -               mdelay(1);
> -               dm_gpio_set_value(&reset_gpio, 0);
> +
> +               if (!ret) {
> +                       log(LOGC_NONE, LOGL_WARNING,
> +                           "%s: TPM gpio reset should not be used on secure production devices\n",
> +                           dev->name);
> +                       dm_gpio_set_value(&reset_gpio, 1);
> +                       mdelay(1);
> +                       dm_gpio_set_value(&reset_gpio, 0);
> +               }
>         }
> -init:
> +
>         /* Ensure a minimum amount of time elapsed since reset of the TPM */
>         mdelay(drv_data->time_before_first_cmd_ms);
>
> --
> 2.25.1
>
Thanks Tim!

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
