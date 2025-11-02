Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6377CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 19:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0C58391C;
	Sun,  2 Nov 2025 20:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FJu9sGKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F81838AE; Sun,  2 Nov 2025 20:54:43 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45DAC8393F
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 20:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b70406feed3so811077866b.3
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 11:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762113281; x=1762718081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fa1+DieywGMc7b1XzOBqwb3uDTE5/YOUXgeS0M4lwUw=;
 b=FJu9sGKesiH0QcEWj4RG+zZMQc9bW2xgMSTXebMLEg5EhS4koBAjwqrA4OH8aiHGcJ
 ni9ouNpLTA0kPgPyss69jWHgkDYdoBuHs4IX7Ey1Il80eESuP/y9E2pYlNfYAwMH8IyU
 +TRNQXIEuK6FQQaSauiJ23gN/1gEeRNYh3S9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762113281; x=1762718081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fa1+DieywGMc7b1XzOBqwb3uDTE5/YOUXgeS0M4lwUw=;
 b=EXMi2FgVziNNNYpc7t7XqL/rErC9JCXbr82vqS6Rtodiqh5y63s1ilWprzRH1CLYse
 17tBcxTkmQ9RG7NjXTFvfl3jfRln4sU222lC48UqFdYotcpCUEZZE7c42Mju+UBmWRJo
 ZbJtMGDyxazuNQqqogW5GLRnjH1vnGYgoiaYiGOaA48i2q6XtJSmqJ98FInscZETSkke
 pL2E6NXUlul9kM1jf9j/NNKWYnVuqVrSWOxesmR9WahT7Mj6i8Kaeyr2u/kVF2iEWL8P
 11fF1wSqAsawuy96O2PmIfTjn9nqUAKPrZIgJPAJzv9fKhkoet/crVd2ghBRjdzf7EaZ
 BhSg==
X-Gm-Message-State: AOJu0YwQ6klIoTQblOHC/Vcxx5zysbPG8/bkwDaFulHNowyR9gebEbAi
 NBH1ffAK7Tpai2ycc4PveVdpynCcF+XkwhRmxYip7oHFYJ/ldb0oQRM/ymj28g5EpO3dEfbTt7u
 i+g37QSZrLEOYCpR9pua3AHMwhhYtnfbeuRJmoarY
X-Gm-Gg: ASbGncvVkkTU0Ptov47cjaC1adJUQ8miYQeeVbAqylY3AvTnRfzuGGvHpeInER9ZpdI
 oEg7SiFb10bVKeLTba0qX7OP16J4W1me/TEwyHC06twXgRk+Zg6fZFIA3r42Kq8HBh2Us4YG6AA
 p8tHgutD+1Vlay2yqrABg9FN0oVS3XbLRi2OadAR56KjxhV+meUZ1JaZok4TJlx8FXoAWdfLQKV
 rK0OFpJDaoP1OHCQsvEbjBew6WiFhj4XP9WjBj05lVpdlGOO5Z6Jgy0MxvlwxA/BH/ceB4PKW+K
 3pYoepc=
X-Google-Smtp-Source: AGHT+IFwi1aev0Atj4jAyRpierehyjjuv2bUip+rLvj7bOUMUQ1fBDKd2wylW0fvFqHdctiBiSdST/ZdyczXuwCRAmg=
X-Received: by 2002:a17:907:2681:b0:b63:7cb3:4105 with SMTP id
 a640c23a62f3a-b7070831603mr1116625666b.52.1762113280626; Sun, 02 Nov 2025
 11:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-3-c13c1b5dac43@cherry.de>
In-Reply-To: <20251031-binman-engine-v1-3-c13c1b5dac43@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 2 Nov 2025 20:53:59 +0100
X-Gm-Features: AWmQ_blmlIFrqRsgmdtFDiw0qIJg8HiBEimiWKC2sbqwYyvejfN1XLOI-t-f0rI
Message-ID: <CAFLszTgdXonbu6MM92hwbLyRwwX9X_cPuhX=UJgR4L7wimkVBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools: binman: fit: add support for OpenSSL engines
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Quentin,

On Fri, 31 Oct 2025 at 16:23, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This adds support for using an OpenSSL engine for signing a FIT image.
> To use it, one should set the fit,sign-engine property at the FIT node
> level with the engine to use. This will in turn call mkimage with the -N
> option.
>
> The key-name-hint property in the signature node will be used verbatim
> as key_id in OpenSSL engine API.
>
> We could somehow still decide to pass some keys_dir to mkimage when
> signing with an engine is enabled (mkimage does support that!),
> unfortunately binman resolves key paths absolutely. I don't believe an
> OpenSSL engine will happen to have the exact same key_id than the path
> to the encryption key, so fit,encrypt and fit,sign-engine cannot
> cohabit.
>
> The public key (with .crt extension) is still required if it needs to be
> embedded in the SPL DTB for example.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/binman/entries.rst  | 22 +++++++++++++++++++---
>  tools/binman/etype/fit.py | 41 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 56 insertions(+), 7 deletions(-)
>

This will need a test.

> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index 8922d6cd070..7b162a3edb8 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -885,9 +885,10 @@ The top-level 'fit' node supports the following
special properties:
>
>      fit,sign
>          Enable signing FIT images via mkimage as described in
> -        verified-boot.rst. If the property is found, the private keys
path
> -        is detected among binman include directories and passed to
mkimage
> -        via  -k flag. All the keys required for signing FIT must be
> +        verified-boot.rst.
> +        If the property is found and fit,sign-engine is not set, the
private
> +        keys path is detected among binman include directories and
passed to
> +        mkimage via -k flag. All the keys required for signing FIT must
be
>          available at time of signing and must be located in single
include
>          directory.
>
> @@ -898,6 +899,21 @@ The top-level 'fit' node supports the following
special properties:
>          required for encrypting the FIT must be available at the time of
>          encrypting and must be located in a single include directory.
>
> +        Incompatible with fit,sign-engine.
> +
> +    fit,sign-engine
> +        Indicates the OpenSSL engine to use for signing the FIT image.
This
> +        is passed to mkimage via the `-N` flag. Example::
> +
> +            fit,sign-engine = "my-engine";
> +
> +        No `-k` argument will be passed to mkimage. The key_id passed to
the
> +        OpenSSL engine API is the verbatim value of the key-name-hint
property.
> +
> +        Depends on fit,sign.
> +
> +        Incompatible with fit,encrypt.
> +
>  Substitutions
>  ~~~~~~~~~~~~~
>
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index db40479d30e..df4cc9b749c 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -104,9 +104,10 @@ class Entry_fit(Entry_section):
>
>          fit,sign
>              Enable signing FIT images via mkimage as described in
> -            verified-boot.rst. If the property is found, the private
keys path
> -            is detected among binman include directories and passed to
mkimage
> -            via  -k flag. All the keys required for signing FIT must be
> +            verified-boot.rst.
> +            If the property is found and fit,sign-engine is not set, the
private
> +            keys path is detected among binman include directories and
passed to
> +            mkimage via -k flag. All the keys required for signing FIT
must be
>              available at time of signing and must be located in single
include
>              directory.
>
> @@ -117,6 +118,21 @@ class Entry_fit(Entry_section):
>              required for encrypting the FIT must be available at the
time of
>              encrypting and must be located in a single include directory.
>
> +            Incompatible with fit,sign-engine.
> +
> +        fit,sign-engine
> +            Indicates the OpenSSL engine to use for signing the FIT
image. This
> +            is passed to mkimage via the `-N` flag. Example::
> +
> +                fit,sign-engine = "my-engine";
> +
> +            No `-k` argument will be passed to mkimage. The key_id
passed to the
> +            OpenSSL engine API is the verbatim value of the
key-name-hint property.
> +
> +            Depends on fit,sign.
> +
> +            Incompatible with fit,encrypt.
> +
>      Substitutions
>      ~~~~~~~~~~~~~
>
> @@ -620,7 +636,24 @@ class Entry_fit(Entry_section):
>              args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
>          if (self._fit_props.get('fit,sign') is not None or
>              self._fit_props.get('fit,encrypt') is not None):
> -            args.update({'keys_dir': self._get_keys_dir(data)})
> +            engine = None
> +            if self._fit_props.get('fit,sign') is not None:
> +                engine_prop = self._fit_props.get('fit,sign-engine')
> +                if engine_prop is not None:
> +                    engine = engine_prop.value
> +                    args.update({'engine': engine})
> +            # Don't pass a key-dir to mkimage in case an engine is used
to sign
> +            # as we don't need a private key on storage anyway.
> +            # Additionally, binman pass an absolute path as keys_dir
which is
> +            # highly unlikely to actually make sense for engines.
> +            # Because of that limitation, we currently cannot support at
the
> +            # same time fit,encrypt and fit,sign-engine.
> +            # mkimage will read key-name-hint and pass it verbatim to
the engine
> +            # as key_id in the OpenSSL engine API instead.
> +            if engine is None:
> +                args.update({'keys_dir': self._get_keys_dir(data)})
> +            elif self._fit_props.get('fit,encrypt') is not None:
> +                self.Raise('Cannot have both fit,encrypt and
fit,sign-engine')

Put all that in a function? Then your comment could be in the function
comment.

>          if self.mkimage.run(reset_timestamp=True,
output_fname=output_fname,
>                              **args) is None:
>              if not self.GetAllowMissing():
>
> --
> 2.51.0
>

Regards,
Simon
