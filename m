Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4674FC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C175684B24;
	Mon, 13 Jul 2026 15:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ekEGYmqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D42A284B28; Mon, 13 Jul 2026 15:04:04 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC30E84AE7
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-699fbcd23ccso4364804a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 06:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783947841; cv=none;
 d=google.com; s=arc-20260327;
 b=cOKjTxkpnTZ3YFTazqqXC3/GVukSKkkx24aEPuln8SuDKt7PPHGIV8vRABc8FKRDmK
 YjtO69ZQCZyj+6lqCXhROBFc9/MYZlPKeYCACiiIC108F5QSPW/2stEHmpaXB7UIiXjU
 IN273JAxecVPyGRTqkxB2NQaJLnZuZf/a0Mo4pABivS3UICAHTPjSHO8x1e0ZSuAW3Lx
 5KQ4XGW8GLPPbZ/ZgIhXsxpm0I2CP27p3JLJVvju14CFHWKuAePmIjbGmL91jFh3YGbn
 yd3xn0dbvFwFwb0tD3OYgAw8Ga3JPoAYNiaKZ3fNdyCvoIf2ze/SKEH1e8rmr40zA3gf
 +aGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RewgqLI6YUeTPsCUP1buIs3Wut+R4qPAb0/kWHfTacI=;
 fh=T4bUy/TTPS14HEyYKT/aCjjeF4kgyKbNbU+y1TfseqA=;
 b=Sji9VojdZIZLjjGFqk4DG5wFi9qrbm8fYLkjEMK/TZZbCRieKeGMi/jyBPUW10J/Ou
 zzP+NCr5BnXSlgLosFAyq17aL5LH4hlI1WyLkMv4ffhvrecqX7KnstO9nDZsJZuZTCVc
 oUpfIaMwIf3aeo+qsGmaA1xsIZJDH0SoCFnvfAbCLF/Q+QkpM63eY2nQI530fuWbRdrD
 wmNe/G0lKrQkZZqTOLtb8E3L65Q1KGr3n73rHt++/5/aUvGvlILJ3bYDioIq6mF0Pyhi
 4IcM7x+bciOmWjTUI7OGjjDjnrQ8l9qdKkovFBUT/0uHWhLz3T08Rg5iJQbSXrUr4KRp
 k8Rw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783947841; x=1784552641; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RewgqLI6YUeTPsCUP1buIs3Wut+R4qPAb0/kWHfTacI=;
 b=ekEGYmqL/TlkHLL6KuzuMImA+zO+eBEGfVfOZ6jTOQg4s45oGntaskdrRnLaKRCZol
 wXI03mLzynEeyhQnT0jO+EQx9f/3hsCFI/RL6Ofa5EIv4MBUx8CZGKMfw2n9Vuyitdm7
 5WcBrmhpGql+sDLji0l2gcjAoj4AjpZyLAQr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947841; x=1784552641;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RewgqLI6YUeTPsCUP1buIs3Wut+R4qPAb0/kWHfTacI=;
 b=hqB87HZqcYto67K1G/sUDpn1rnUz7aDORLZcmQVdTpckww+WkuQSDFFAKXUZ5Lc2h6
 CMxWkCxwTXn4ea5YObagmab1z1QYz/dxiyfZ+ZcJC0nCtfvCxatHtHr/jZCP1pA/R3z9
 V8r2ObaWfNteRppbHevqjctSOvuyuvtFKXa8xBRFRcbVjflAE5aGWz2SIL3kfjxagwWG
 5pJNW2d9hdWCM94SsalvNbcdxm95FRY+9Z6cOpNmZb0opAlHui8TzP+MSAjhSj0SM5tf
 JrVPxH24jqkKkcIc4XCB0YrhjXubJpqc4iTBI1G4x8RGLbYQSY+MRGG7aSvSKEAHPdcd
 UB3A==
X-Gm-Message-State: AOJu0YwANtlFAE4/UBFZpBjseG7mG5OfH4v0BhgTxglrR3zEH0z3VAm5
 ukst783h7kSgqXm5YN8kKlFeJIRb7xhxXdbNgIumRzCWmwuEfNkOgRxatuoj081g2KIpfZdoOO/
 ODS0YYUw2lKBLTTDsChik9HdsK4DeNX8YGfghx4ln
X-Gm-Gg: AfdE7ckx9n1rne8uQvB6kOwrw866BaKq7NxwhT3vcGBN6NKalB48RdEvDve3FesgiSf
 y4V713ipZ/hFZ5D+ZHlzG07B32XB9DMWbqEVX2fzViRV7Y3sRrORtRcQHIAYCYs5A/gLfug2p4c
 kg7VZR0hfVUE0UfVSETXRNp2uXXJygX7orJAEk2g9ctY2BSyREB1irC/4N9Nr13WBD17EXWA7FU
 vruK5lAUa1yER9t/IAPYqrNbCnPQXoVyD6LXDjF/CeGNpAsV+2qmbHAUL0cmqYTtHsidIA=
X-Received: by 2002:a05:6402:146a:b0:699:2448:be5a with SMTP id
 4fb4d7f45d1cf-69c5f1028e7mr3929645a12.26.1783947841061; Mon, 13 Jul 2026
 06:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260610221200.167711-1-joaofl@gmail.com>
 <20260615175118.53720-1-joaofl@gmail.com>
 <20260615175118.53720-2-joaofl@gmail.com>
In-Reply-To: <20260615175118.53720-2-joaofl@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 07:03:49 -0600
X-Gm-Features: AUfX_mxKkwvPcREVZXffOjr6TjmwPNFyfGkG-MRnG2wnOD9zi87iZdv---5kwjo
Message-ID: <CAFLszTiPQriMWYNzDtfvPyoctVjQLagXFQVp7kVixrv2_oAPcg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] spi: Introduce initial EEPROM driver mode support
To: joaofl@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Jo=C3=A3o,

On 2026-06-15T17:51:16, Jo=C3=A3o Loureiro <joaofl@gmail.com> wrote:
> spi: Introduce initial EEPROM driver mode support
>
> This patch introduces the initial SPI EEPROM driver mode support
> analogous to the I2C EEPROM driver mode support. The SPI EEPROM
> driver mode support is enabled by default in the sandbox_defconfig.
>
> Signed-off-by: Jo=C3=A3o Loureiro <joaofl@gmail.com>
>
> MAINTAINERS               |   6 ++
>  configs/sandbox_defconfig |   1 +
>  drivers/misc/Kconfig      |   6 ++
>  drivers/misc/Makefile     |   1 +
>  drivers/misc/spi_eeprom.c | 185 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/dm/uclass-id.h    |   1 +
>  include/spi_eeprom.h      |  91 +++++++++++++++++++++++
>  7 files changed, 291 insertions(+)

Sorry I didn't notice the earlier versions of this patch, but I do
have a few comments.

> This patch introduces the initial SPI EEPROM driver mode support
> analogous to the I2C EEPROM driver mode support. The SPI EEPROM
> driver mode support is enabled by default in the sandbox_defconfig.

'driver model', not 'driver mode' - three times. Please also use the
imperative: 'Introduce initial driver-model support for SPI EEPROMs,
analogous to ...' matches the subject and U-Boot convention.

Please explain the motivation briefly (why now, what will consume it)
before your current commit msg.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> @@ -567,6 +567,12 @@ config I2C_EEPROM
> +config SPI_EEPROM
> +     bool "SPI EEPROM support"
> +     depends on MISC
> +     help
> +       Enable support for SPI EEPROM devices.
> +       Currently with only read access.

Please expand the help text - mention that this provides a uclass with
a small AT25-style driver, that only 16-bit-addressed parts are
handled, and that only read is implemented.

Does this really need 'depends on MISC'? The driver does not use the
misc uclass; it sits on its own UCLASS_SPI_EEPROM. i2c_eeprom does not
depend on MISC either.

> diff --git a/drivers/misc/spi_eeprom.c b/drivers/misc/spi_eeprom.c
> @@ -0,0 +1,185 @@
> +/* 1 command byte followed by a 16-bit address */
> +#define SPI_EEPROM_CMD_SIZE  3

This lives in the public header and hard-codes a 16-bit address, but
the uclass is presented as generic. Anything larger than 64 KiB
(AT25M02, AT25512, most 24-bit-addressed parts) will not work. Please
either:

  - move SPI_EEPROM_CMD_SIZE into spi_eeprom.c and derive the address
length from driver-data (an addr_len field), so growing the compatible
list later does not need an ABI change; or
  - state explicitly in the commit message and Kconfig help that
initial support is limited to 16-bit-addressed AT25-style parts.

I'd prefer the first.

> +     if (offset < 0 || size < 0 || offset + size > priv->size) {
> +             log_err("Read out of bounds (offset %d, size %d, max %lu)\n=
",
> +                     offset, size, priv->size);
> +             return -EINVAL;
> +     }

offset + size is an int and can overflow before the comparison against
the unsigned long priv->size. Please check the two ranges
independently:

    if (offset < 0 || size < 0 || offset >=3D priv->size ||
        size > priv->size - offset)

> +     cmd[0] =3D data->cmd_read_data;
> +     cmd[1] =3D (offset >> 8) & 0xff;
> +     cmd[2] =3D offset & 0xff;

If you keep the 16-bit assumption, please reject offsets that don't
fit in 16 bits rather than silently truncating. priv->size can be
overridden from DT via the 'size' property with any value.

> +static int spi_eeprom_std_of_to_plat(struct udevice *dev)
> +{
> +     const struct spi_eeprom_drv_data *data =3D
> +             (const struct spi_eeprom_drv_data *)dev_get_driver_data(dev=
);
> +     struct spi_eeprom *priv =3D dev_get_priv(dev);
> +
> +     priv->size =3D dev_read_u32_default(dev, 'size', data->size);
> +     priv->pagesize =3D dev_read_u32_default(dev, 'pagesize', data->page=
size);

Two things:

'size' and 'pagesize' don't seem to be standard bindings for SPI
EEPROM nodes - the size is normally determined by the compatible.
Please either drop these overrides or point at a binding that
documents them.

Also, this writes into priv from of_to_plat(). Per driver-model
convention, of_to_plat() should populate plat data (auto_plat) and
probe() should use plat or can put a few things in priv if it likes.
Since there is no write path using pagesize yet, the simpler fix is to
move this into spi_eeprom_std_probe()

> +static const struct udevice_id spi_eeprom_std_ids[] =3D {
> +     { .compatible =3D 'microchip,at25160bn', .data =3D (ulong)&atmel25_=
data },
> +     { }
> +};

Only one compatible for a generic driver feels thin - any reason not
to add the rest of the AT25 family that shares this command set
(at25010b, at25020b, at25040b, at25080b, at2532b, at25640b etc)? Each
just needs a drv_data entry.

> diff --git a/include/spi_eeprom.h b/include/spi_eeprom.h
> @@ -0,0 +1,91 @@
> +/* AT25-style command set */
> +#define AT25_CMD_READ_DATA   0x03    /* Read data from memory array */
> +#define AT25_CMD_READ_STATUS 0x05    /* Read status register */
> +
> +/* 1 command byte followed by a 16-bit address */
> +#define SPI_EEPROM_CMD_SIZE  3

These are only used by drivers/misc/spi_eeprom.c and
drivers/misc/spi_eeprom_emul.c - implementation details rather than
uclass API. Please move them into a private header shared by the
driver and emulator, or duplicate the two opcodes locally.

> +#if CONFIG_IS_ENABLED(SPI_EEPROM)
> +/*
> + * spi_eeprom_read() - read bytes from an SPI EEPROM chip

Please switch to kerneldoc (/** rather than /*) - new code should
carry proper kerneldoc even where i2c_eeprom.h has not been updated.

> +#endif /* SPI_EEPROM */
> +
> +#endif

Please add /* __SPI_EEPROM */ after the outer #endif to match the inner one=
.

Regards,
Simon
