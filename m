Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E162C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C8A84ADF;
	Fri, 10 Jul 2026 14:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="djLwkyYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A4184BF6; Thu,  9 Jul 2026 20:37:08 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590CF84A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so201094a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:37:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783622226; cv=none;
 d=google.com; s=arc-20260327;
 b=rzBF9S3LWCp9vLw+X7IN/d3TZ7ojacXlbh4zPfhj0tDerH4hFKZ/jEQPWMYFBHEvxc
 7Fp97il5TPRlBN42YDAAnRT2GI08aXVgHMBLVWlqjwSvPxFkVlI2mj+hBR2HBcGI6GOh
 v/7khfgzDD3Eqv4kXeOPOp+A9xeEnxMvr99GNHCNU4sFbJH5jLHhzGCKTwn2gvAbSZAp
 JU3C7zq8DK8JPqyrikysnACCjnOemh3zHls177sby+9lZLy0QNxcAu/39TG1IqE1EGwh
 RXhUmae8An3gZjMEg1OgakjdL1R2kDiZwh0CA7OlQG6qtSx0YrfqkOH+XHk7Q5hSxGFu
 ilew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MxeFkMITtoFlH5xDGrH/otpNE7+PXB95WA4SWQfmqw0=;
 fh=syXcLE83OFDraqGbuQhMyZ13Rvk/iT7U0hwLRfOyT4s=;
 b=joyN6wVF1GbA9L8RLfTXIgLtARSTZ/irJ0uqh7QeCOP5IVVog2Vyw6HvFadK9YHUU7
 ux5SnbT948u/TEcegV0EbUAwIgbmrGuexD4n1IY3W3axWr4jb8e6L29S2Xn1dYxWtZjp
 ZI7C8l4mp67CBHaw2oLJ77nyk4rMBgCfkIC18hqi+Co4YLcwum/ipDKXaP6TU1jL6iGu
 XW7Ua7Kssg5p48E7HZaad/S7epxa+A89AyQZ0Vrw2t5moM7tWLfE99uAn8mxhA+2DOsZ
 d/suhIbMewR1mHN6cR/5pwOaFyJ+pY0HhJFTivGWWQXHJrdFRrFlxeqdMU2qo1nNMKNW
 LR7w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783622226; x=1784227026; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MxeFkMITtoFlH5xDGrH/otpNE7+PXB95WA4SWQfmqw0=;
 b=djLwkyYX5usslD67GTO2Nb3NdFRn8c6BWzR27phLCsE/JfBwTCaUWHwRoLxhq6cOcM
 Y6x/Fvvg2xSWDCorzP4b+xX19dRtcRgjKqzKiu6kPVJe35uhcrzaNtNHYBMhZXV/vgFl
 OWraNIiSdaOy79Sor/yMpBmFkjWmZ3+ZRX+LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622226; x=1784227026;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MxeFkMITtoFlH5xDGrH/otpNE7+PXB95WA4SWQfmqw0=;
 b=tSX5Ntj6bc9ncivsaow62MLtnj/TYU+eb7SeugK6qSIAHixu+QkcfqCYOp/5Pz5KI2
 6nHmirAACoxKyiCXp3LyjloC0IZ2uTuZCwqIA0V0jlXJ+tdp7odAuT8UyiRtsdEaVpIu
 +/oYWTFZuZGU/vneTGmrmrUVKcPii9cOGhH6Narg1IDYf7wIloqlMPe3X9HJDUZKbfBL
 6M6qqoppLtbHFVrxiPMasViiuUgj1AcK4goikYcJbqxT2M5/CrGDwsEcnOYNBzim9dbb
 3VKYwwJlUtCjhZh7kBTi+hMv+A1ymKPiAv9rACqMy6kM18V5bdDoXB1LcOfLYLM2XyF+
 vU+Q==
X-Gm-Message-State: AOJu0YxZQBfz91UuaGql25tpK3xAHkLGqCLuosbXiPHw1hA/fp9/vOZy
 ian+v2t696DXos0Q6hlloFMOB3/uZQZzl6C4zVXZIz1EdIIVpTO5sgSb9K4e+1CuIIBmRk9k5ZE
 SN0l6boIvUpj7FvoGyKALbCyyLB+fWUc047OrfV3Y
X-Gm-Gg: AfdE7clOCnYfEsa6GKI3SKin5K85ww5lRHsIKR/74CtTeDicNEXz0cFBWHw4kekI0IN
 2xvymS8/8ipo6BKDqkqoZHc5iYD+UmwBXKy59AZAyOOVLhRhM86zEApxzDvWK0fAA1fQdQTkyGe
 BMqtGjvevqLYr09Wa8N7SJTBAPF/rxbCH0xt2SBU7tGJ7FXIcn+Q0QGw9NA/CnysbjTKU1IXFNJ
 Y6396OVW5lhBho1h6DbC+H8TWOX1y73EEtJvv/4OMyyksJAPFGi01rcvYZ3r/o0WWa88TC71VNi
 f5V9Xw==
X-Received: by 2002:a05:6402:1f11:b0:698:3b7c:7e5c with SMTP id
 4fb4d7f45d1cf-69ab44c5870mr3080355a12.40.1783622225740; Thu, 09 Jul 2026
 11:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
 <20260702-submit-ce-series-v2-v2-3-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-3-ffda5bed58af@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 12:36:53 -0600
X-Gm-Features: AUfX_myChYZM1AvPN3WGlsGQ-unRP0len8ipIJsvjcPQ4Txiv4t9ni69nrUiV-U
Message-ID: <CAFLszTgnqk+fQbW1KXxTTZ3vjAq+mdHoKuHauZj6DQT4fyL5nA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] boot: image: add FIT decrypt-to-buffer helper
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ion Agorria <ion@agorria.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Randolph Sapp <rs@ti.com>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Michael Walle <mwalle@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

Hi James,

On 2026-07-03T01:49:45, James Hilliard <james.hilliard1@gmail.com> wrote:
> boot: image: add FIT decrypt-to-buffer helper
>
> FIT cipher support currently allocates the output buffer inside the AES
> helper. SPL often needs to decrypt directly into a caller-selected
> buffer, for example a load buffer or a scratch buffer used before
> decompression.
>
> Add a decrypt_to callback to the FIT cipher algorithm and wire it up for
> AES. The existing allocating decrypt path becomes a wrapper around the
> new helper.
>
> Validate the FIT cipher key length, IV length and unciphered-size
> property while preparing decryption, and build lib/aes/ by phase when
> FIT_CIPHER is enabled so the target-side decrypt helper is available to
> SPL builds.
>
> When DM_AES is enabled, try the first UCLASS_AES provider before using
> the software AES fallback in U-Boot proper. If a provider is present,
> ask the provider for the software-provided key slot before loading the
> FIT key, so hardware-specific reserved or preloaded slot policy stays in
> [...]
>
> boot/image-cipher.c              |  38 ++++++++++++--
>  boot/image-fit.c                 |  33 ++++++++++--
>  drivers/crypto/aes/aes-sw.c      |   6 +++
>  drivers/crypto/aes/aes-uclass.c  |  15 ++++++
>  drivers/crypto/tegra/tegra_aes.c |   7 +++
>  include/image.h                  |  39 ++++++++++++--
>  include/u-boot/aes.h             |  10 ++++
>  include/uboot_aes.h              |  38 ++++++++++++--
>  lib/Makefile                     |   2 +-
>  lib/aes/aes-decrypt.c            | 108 +++++++++++++++++++++++++++++++++------
>  10 files changed, 266 insertions(+), 30 deletions(-)

> diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
> @@ -4,37 +4,115 @@
> +int image_aes_decrypt_to(struct image_cipher_info *info,
> +                      const void *cipher, size_t cipher_len,
> +                      void *data, size_t *size)
> +{
> +#ifndef USE_HOSTCC
> +     unsigned int aes_blocks, key_len = info->cipher->key_len;
> +     int ret;

...
> +     return -ENOSYS;
> +#endif
> +
> +     return -ENOSYS;
> +}

Please flip this to '#ifdef USE_HOSTCC / return -ENOSYS; / #else ... /
#endif' with a single return. The double return either side of the
'#endif' is confusing since only one is ever reachable per build.

> diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
> @@ -4,37 +4,115 @@
> +             ret = uclass_first_device_err(UCLASS_AES, &dev);
> +             if (!ret) {
> +                     u8 slot;
> +
> +                     ret = dm_aes_get_software_key_slot(dev);
> +                     if (ret < 0)
> +                             return ret;
> +                     if (ret > 0xff)
> +                             return -ERANGE;
> +                     slot = ret;
> +
> +                     ret = dm_aes_set_key_for_key_slot(dev, key_len * 8,
> +                                                       (u8 *)info->key,
> +                                                       slot);

Since fit_image_uncipher() now hands in 'data == cipher' whenever the
payload sits in DRAM, every UCLASS_AES provider consumed here must
support in-place CBC decrypt with fully overlapping src and dst. The
software path in aes_cbc_decrypt_blocks() snapshots each block first,
so it copes, but the aes_ops contract does not spell this out. Please
document this on struct aes_ops (or on aes_cbc_decrypt()), otherwise
the sun8i-ce driver added later in the series becomes the de-facto
reference for an unwritten rule.

> diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
> @@ -4,37 +4,115 @@
> +     ret = image_aes_validate_lengths(info, cipher_len);
> +     if (ret)
> +             return ret;
> +
>       *data = malloc(cipher_len);
>       if (!*data) {
>               printf("Can't allocate memory to decrypt\n");
>               return -ENOMEM;
>       }
> -     *size = info->size_unciphered;
>
> -     memcpy(&key_exp[0], info->key, key_len);
> -
> -     /* First we expand the key. */
> -     aes_expand_key((u8 *)info->key, key_len, key_exp);
> -
> -     /* Calculate the number of AES blocks to encrypt. */
> -     aes_blocks = DIV_ROUND_UP(cipher_len, AES_BLOCK_LENGTH);
> +     ret = image_aes_decrypt_to(info, cipher, cipher_len, *data, size);

image_aes_decrypt() validates the lengths, then image_aes_decrypt_to()
validates them again. Please drop the outer call and let decrypt_to()
be the single point of validation, otherwise the two copies will
drift.

With those resolved:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
