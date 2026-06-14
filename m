Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E05BCD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D9B83EEF;
	Sun, 14 Jun 2026 14:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gqh3K+G9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18178485F; Sun, 14 Jun 2026 14:19:12 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49261800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bf20f6be6bso17903115ad.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781439549; cv=none;
 d=google.com; s=arc-20240605;
 b=DUniQZrZeOWZDdv78aiB6ocwoqu2wTDcKvkKeGcPHR8LQA4HYgRqIeI+YZzNCnToOy
 uetbyCBxGFkFk931LtnVqreVqDVdA+/wBGNya4j+9kbeo4MGqyMpNKl5jlR/tDGc/Qgz
 8FU4rq5Sfl8rYOf6jj9sjou+rg0yJ9Z8j6Ihtreant5FSCqwC8tryVhn9pe69dJHwTzh
 pkb4IDir0xVnzjAZXC4seb7Jw4Sblj7RDgLWYc61n1erypL3iJKDEWknsI2F2sQFtUm2
 Wu0k7Zjnhea/ebVwnewBT0oRjSOtkYvkeNlwt/0IX03SmdZfbgnZIm1ZEOFrcHyOsPk/
 QKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dlCJrBFs+1Ep6UBfis97BBt4P1jAKfPy9Ob8JJgmB6c=;
 fh=T4bUy/TTPS14HEyYKT/aCjjeF4kgyKbNbU+y1TfseqA=;
 b=SOnjhAFoFUw6cBgnTbAAZtVLaIPxRKFChNvDGmZubU5WUH0k8NeRByqcY762jpbztv
 Z31MJGFP3zrvUSOvJnLJljaBPwriTaAVAPoRQNYqH+3DWlVAYjXpap3LyycBOcV1Vfe5
 tvh9mVd66ugylrj8f8yI+fP5XpsjAlLZPqTg1nj86QUkeSB04tMq3qfZ94UiXeVZH6z/
 lKETXwiLX1hQ+eQu+kZPfP5kCkBYV7wr09EihcRoN1mdAeRpNKqrCG2dvFuggQCB31rD
 JdeK5UFy+4mggRnWnyiG40GiYG6fB1ewZRecXwRKgLZagndgBfe5jzMiApU+mtOO+Sv+
 cTaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781439549; x=1782044349; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlCJrBFs+1Ep6UBfis97BBt4P1jAKfPy9Ob8JJgmB6c=;
 b=Gqh3K+G9oa8mEzO/CmmWBOI144CPl1oTAGsxTedcEisNmLDK7+ivAFrkk53xJGhJWW
 GKGJJpdogVFP/30NTyFci5J+ntacrC1KjS5iyY3KHnQZC44bttVBvCPvGNC+jzEq+aab
 OCYmK/m+G5hsjXqVr2GCIT740GEX4/Ti3KWOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781439549; x=1782044349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dlCJrBFs+1Ep6UBfis97BBt4P1jAKfPy9Ob8JJgmB6c=;
 b=Fnb3oiWAHkOn6hFR5l4n15hxq47iWtiRAaFp8jhjbaEnc4yPmbK2XmqdUNSvwy/r9g
 YTNEwUdNQ3scAXmNGpyiaeH5kP+/KSXtLjJ4ayOPwGMCoKmp9xpI02dwfi5JViAMEA1M
 KjxumI7MVevxlWv7prdW7P+6kHYJ7YJRMEA2C4YjC/h1vuoRxWhOu0vh3YNMQfDwgxLR
 ZjPVClkJSyuUCqxtYjf1Yi/LAes+wRZLfx6VC6256Nv4aJ80cQcCHRVHc3r38h/DVW6M
 eaWxgjLprrzZGJn6ydmuXp/hNJwvXdLBoSc9bZq08shRYeifZyjkonZWZfgCic5F3/7k
 +26A==
X-Gm-Message-State: AOJu0Yx+M21WdjfuCZrDtLsqLzRsR3SwPzFZeyGG8L9T6FW7Ch3eEgCz
 DHcPYkvFZriHQh16xC7hRfCOUYbeKmuOJg6x0JMrwoRjPJMal7iJHhziK8Z50mEHw7lRcxSmR5B
 MTdBLdpzw9XHGg44LAQSm7lMZUggvUx7unj6gFRpT
X-Gm-Gg: Acq92OFmyXEgXqG2kMQIQcfqyBzV47Tgzz4csjWaH6lnfbSE5lzb58Iyu0nfIvYC/c1
 A96/SfQRrzTIuD7C5ChF2PB+EnTL+KodVNAcP1ynDm342vc43tDq6TdHvjWA5TXNVtd0lZwmic/
 i0hwDeogdd/Ul55br6ZiHdGZsffk9jY5NcNvIfRFBFM++2fFWUgD/T/pE4MwlJIzEnKzxOxDMQA
 ij+FgFQvBflUd26W1LngGSXXYAQjyisr0fweek1+IZ/8E7QDk3V3/vjUK1waFgDUDiZr47779F0
 k0niTA==
X-Received: by 2002:a17:902:ccc8:b0:2c6:6424:c79f with SMTP id
 d9443c01a7336-2c66424cc24mr76948135ad.8.1781439548753; Sun, 14 Jun 2026
 05:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <AM9P122MB0281B24BE5B8A8E6A3F2D343F2CB2@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
 <20260610221200.167711-1-joaofl@gmail.com>
 <20260610221200.167711-3-joaofl@gmail.com>
In-Reply-To: <20260610221200.167711-3-joaofl@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:18:51 -0600
X-Gm-Features: AVVi8CdyvX1kS1qW8K3nbl8uyHsHmL5cnmBuxttpA1fnnXLj8CrI-lJneuBbuz4
Message-ID: <CAFLszThzQX8myaVZA1x9yT9rcbpY=aA6uVigaJGpxAqwBXY-Sg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] sandbox: spi: Add SPI EEPROM emulator and DM test
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

On 2026-06-10T22:11:58, Jo=C3=A3o Loureiro <joaofl@gmail.com> wrote:
> sandbox: spi: Add SPI EEPROM emulator and DM test
>
> Add a sandbox emulator for an AT25-style SPI EEPROM so the new SPI
> EEPROM uclass can be exercised without real hardware.
>
> The sandbox SPI controller previously always bound the SPI flash
> emulator for every chip select. Allow a slave node to select its own
> emulator through a sandbox,emul phandle (mirroring the sandbox I2C
> bus), falling back to the SPI flash emulator when none is given so that
> existing behaviour is preserved.
>
> A test EEPROM is wired up on chip select 3 of the sandbox SPI bus and a
> test/dm test verifies size reporting, patterned reads, out-of-bounds
> rejection and the unimplemented write path.
>
> Signed-off-by: Jo=C3=A3o Loureiro <joaofl@gmail.com>
>
> MAINTAINERS                    |   2 +
>  arch/sandbox/dts/test.dts      |  13 ++++-
>  drivers/misc/Makefile          |   1 +
>  drivers/misc/spi_eeprom_emul.c | 118 +++++++++++++++++++++++++++++++++++=
++++++
>  drivers/spi/sandbox_spi.c      |  31 ++++++++++-
>  test/dm/Makefile               |   1 +
>  test/dm/spi_eeprom.c           |  45 ++++++++++++++++
>  7 files changed, 209 insertions(+), 2 deletions(-)

> diff --git a/drivers/spi/sandbox_spi.c b/drivers/spi/sandbox_spi.c
> @@ -77,6 +77,35 @@ static int sandbox_spi_set_wordlen(struct udevice *dev=
, unsigned int wordlen)
> +/**
> + * sandbox_spi_emul_get() - find the emulator for a SPI slave
> + *
> + * A slave can name a dedicated emulator through a 'sandbox,emul' phandl=
e (for
> + * example an SPI EEPROM). When no such phandle is present we fall back =
to the
> + * built-in SPI flash emulator, preserving the previous behaviour.
> + */
> +static int sandbox_spi_emul_get(struct sandbox_state *state, struct udev=
ice *bus,
> +                             struct udevice *slave, struct udevice **emu=
lp)

Can you please add rull kerneldoc for @state, @bus, @slave, @emulp and
a Return: line. Try to wrap to 80 columns.

> diff --git a/drivers/misc/spi_eeprom_emul.c b/drivers/misc/spi_eeprom_emu=
l.c
> @@ -0,0 +1,118 @@
> +     priv->data =3D calloc(1, priv->size);
> +     if (!priv->data)
> +             return -ENOMEM;

This is never freed, so each probe/remove cycle in the tests leaks the
backing store. Please can you add a remove method that frees
priv->data, as sandbox_i2c_eeprom_remove() does in i2c_eeprom_emul.c

With those fixed:
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>  # sandbox

Regards,
Simon
