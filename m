Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED97CF34AB
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A28B783F50;
	Wed, 19 Nov 2025 14:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ExUUAZd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47EC183F4E; Wed, 19 Nov 2025 14:17:01 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2347F83F50
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b735ce67d1dso881077066b.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763558218; x=1764163018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+60VscqDCzJAL7m3kpAef/M798M7XozjfZWg8Uphglk=;
 b=ExUUAZd32HugwvqBBGQtHFgoRf9MYJamnR+9xVe1DCbiE/oqTr9fyAy981DSOsiPJM
 cr2Al7Df/MdY9bKmnsK/NLzeGO+r0rfplBW0B0phwbr7SoKi5njJwGb+f+rCKtLw1e7H
 ohtz08UOwU7mt6JxA8V4zk5377eQp2/9WY5rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763558218; x=1764163018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+60VscqDCzJAL7m3kpAef/M798M7XozjfZWg8Uphglk=;
 b=DJWIhN10C04oTBxJHEINoojjvoIbX90/8lFKOxNuBDLcSDMqXom0NjxV9ARg47W1Km
 eFgJjXdpe1kezhMLYDvFZU0azXws+Ubffgj9klGTRJUC6P/CkHd61ZaJ/RSjKqCS+T5R
 /YE+J6pqm2oEo81DXe0YXjkb9XzlKYWv6JkFAPQWQQJp8WLi/wRTT1zhvu0NOCFkOodU
 4v86B4wwnv73RrHSgEISMGjFn2Tn2hqITf5/KSqKibUY33NACG8TtPmlZkgaE51DN0i8
 y5/aAW6eoq8kiq5NtCkRQph0woJOSh6GCXvMr/BVdwnIGEiTwr1wmlYZTAIUKPeRJ8Td
 Xqtg==
X-Gm-Message-State: AOJu0Yxmt7b87qR+gaFqX2onHiUyyqHtm9vVLJDArSFq+ybCEJx9OnIB
 oLRz8DzEElcAqR9L2glXvcBxVn+AKEchKQLGuE/YlraCQ0MUtRR/gcu5W4WAFlco4KUNJCnUzxZ
 Z6ysqFalV6HTTCAzgpTOj7aWq/FqSZPgVIxqmTPCS
X-Gm-Gg: ASbGncsA9BmaIDwFdm7oxYK3DLX0IW3jVmok8DMAfXsX9JaTPBl64Um6BJMjPZZfASc
 0Dl2yLKfY8ZU+8o95YJkWkxxgFsd9jpY3unNdLZSAM5AB2Ahd5GaPozHpOaQ1g0LvmXQLAkNeYS
 8sfQJJY6H2rQZvuzPXiiHmsTe2KaCdh4qtxIsPbXzxBcUe0KF3q+/7nUu/BsNsFvK4mWS/4LdP1
 gIQYvTpC/OkBb3m3tsIQaL53rg1O4t/9e1iCsWglpgD2zPrbiAJwsg3P9J0pkw4qyCqyXd3Pa0O
 4DttJ0toiCa2EcQ=
X-Google-Smtp-Source: AGHT+IHTR4NbKYVrKQBCiUCZ/Ajrj+zCOInzcXjW6y7oS1Z/COkcH+DPfHOuJt7YXFjT2VJgidiwUbsTFre4KfONC0E=
X-Received: by 2002:a17:907:2d06:b0:b73:806c:bab2 with SMTP id
 a640c23a62f3a-b73806cc1b6mr1707858766b.33.1763558215149; Wed, 19 Nov 2025
 05:16:55 -0800 (PST)
MIME-Version: 1.0
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
 <20251117-binman-engine-v2-3-e053f683c0b8@cherry.de>
In-Reply-To: <20251117-binman-engine-v2-3-e053f683c0b8@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 06:16:28 -0700
X-Gm-Features: AWmQ_bmjf_uDUPibrOXKErVh6KpDSGSgMdL9es5dbxEpBE4d1PRJTW30QMY4IN0
Message-ID: <CAFLszTi3X94VynU5Uh5s8iCy+i21ZSWm4ocdX_Mcz=+1TNFy7w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] tools: binman: fit: add support for OpenSSL engines
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Yannic Moog <y.moog@phytec.de>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On Mon, 17 Nov 2025 at 12:43, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This adds support for using an OpenSSL engine for signing a FIT image.
> To use it, one should set the fit,engine property at the FIT node level
> with the engine to use. This will in turn call mkimage with the -N
> option.
>
> The -k argument to mkimage can be specified via fit,engine-keydir. This
> is especially useful for pkcs11 engine to specify slots, token label,
> etc...
>
> The -k argument to mkimage can be specified by setting fit,engine-keydir
> property, if missing no -k argument will be passed.
>
> As far as I could tell, mkimage encrypts and signs a FIT in one go, thus
> the -k argument applies to both signing and encrypting. Considering we
> reuse the -k argument for two different meanings (info to pass to the
> engine when using an engine otherwise the directory where keys are
> stored), we cannot reasonably encrypt using local keys and signing with
> an engine, hence the enforced check. I believe it should be possible to
> support encrypting and signing with the same engine (using different
> key pairs of course, via different key-name-hint likely), but this is
> left for the next person to implement.
> This is why the property is named fit,engine and not fit,sign-engine.
> Ditto for fit,engine-keydir.
>
> The public key (with .crt extension) is still required if it needs to be
> embedded in the SPL DTB for example. We could probably support
> retrieving the public key from an engine, but this is a change to make
> to fdt_add_pubkey.c.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/binman/entries.rst  | 45 +++++++++++++++++++++++++++++++---
>  tools/binman/etype/fit.py | 61 +++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 99 insertions(+), 7 deletions(-)
>
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index 8922d6cd070..fb17157cd79 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -885,9 +885,10 @@ The top-level 'fit' node supports the following special properties:
>
>      fit,sign
>          Enable signing FIT images via mkimage as described in
> -        verified-boot.rst. If the property is found, the private keys path
> -        is detected among binman include directories and passed to mkimage
> -        via  -k flag. All the keys required for signing FIT must be
> +        verified-boot.rst.
> +        If the property is found and fit,engine is not set, the private
> +        keys path is detected among binman include directories and passed to
> +        mkimage via -k flag. All the keys required for signing FIT must be
>          available at time of signing and must be located in single include
>          directory.
>
> @@ -898,6 +899,44 @@ The top-level 'fit' node supports the following special properties:
>          required for encrypting the FIT must be available at the time of
>          encrypting and must be located in a single include directory.
>
> +        Incompatible with fit,engine.
> +
> +    fit,engine
> +        Indicates the OpenSSL engine to use for signing the FIT image. This
> +        is passed to mkimage via the `-N` flag. Example::
> +
> +            fit,engine = "my-engine";
> +
> +        A `-k` argument for mkimage may be passed via `fit,engine-keydir`.
> +
> +        When `fit,engine` is set to `pkcs11`, the value of
> +        `fit,engine-keydir` (if present) is concatenated with `;object=` and
> +        the value of `key-name-hint`, and passed as-is to the OpenSSL engine
> +        API. If the value of `fit,engine-keydir` contains `object=` or
> +        `id=`, only the value of `fit,engine-keydir` is passed as-is to the
> +        OpenSSL engine API. If no `fit,engine-keydir` is present,
> +        `pkcs11:object=` is concatenated with the value of `key-name-hint`,
> +        and passed as-is to the OpenSSL engine API.
> +
> +        For all other values of `fit,engine`, the value of
> +        `fit,engine-keydir` (if present) is concatenated with the value of
> +        `key-name-hint` and passed as-is to the OpenSSL engine API.
> +
> +        Depends on fit,sign.
> +
> +        Incompatible with fit,encrypt.
> +
> +    fit,engine-keydir
> +        Indicates the `-k` argument to pass to mkimage if an OpenSSL engine
> +        is to be used for signing the FIT image. Example::
> +
> +            fit,engine-keydir = "pkcs11:model=xxx;manufacturer=xxx";
> +
> +        Read `fit,engine` documentation for more info on special cases when
> +        using `pkcs11` as engine.
> +
> +        Depends on fit,engine.
> +
>  Substitutions
>  ~~~~~~~~~~~~~
>
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index db40479d30e..6547d0314b9 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -104,9 +104,10 @@ class Entry_fit(Entry_section):
>
>          fit,sign
>              Enable signing FIT images via mkimage as described in
> -            verified-boot.rst. If the property is found, the private keys path
> -            is detected among binman include directories and passed to mkimage
> -            via  -k flag. All the keys required for signing FIT must be
> +            verified-boot.rst.
> +            If the property is found and fit,engine is not set, the private
> +            keys path is detected among binman include directories and passed to
> +            mkimage via -k flag. All the keys required for signing FIT must be
>              available at time of signing and must be located in single include
>              directory.
>
> @@ -117,6 +118,44 @@ class Entry_fit(Entry_section):
>              required for encrypting the FIT must be available at the time of
>              encrypting and must be located in a single include directory.
>
> +            Incompatible with fit,engine.
> +
> +        fit,engine
> +            Indicates the OpenSSL engine to use for signing the FIT image. This
> +            is passed to mkimage via the `-N` flag. Example::
> +
> +                fit,engine = "my-engine";
> +
> +            A `-k` argument for mkimage may be passed via `fit,engine-keydir`.
> +
> +            When `fit,engine` is set to `pkcs11`, the value of
> +            `fit,engine-keydir` (if present) is concatenated with `;object=` and
> +            the value of `key-name-hint`, and passed as-is to the OpenSSL engine
> +            API. If the value of `fit,engine-keydir` contains `object=` or
> +            `id=`, only the value of `fit,engine-keydir` is passed as-is to the
> +            OpenSSL engine API. If no `fit,engine-keydir` is present,
> +            `pkcs11:object=` is concatenated with the value of `key-name-hint`,
> +            and passed as-is to the OpenSSL engine API.
> +
> +            For all other values of `fit,engine`, the value of
> +            `fit,engine-keydir` (if present) is concatenated with the value of
> +            `key-name-hint` and passed as-is to the OpenSSL engine API.
> +
> +            Depends on fit,sign.
> +
> +            Incompatible with fit,encrypt.
> +
> +        fit,engine-keydir
> +            Indicates the `-k` argument to pass to mkimage if an OpenSSL engine
> +            is to be used for signing the FIT image. Example::
> +
> +                fit,engine-keydir = "pkcs11:model=xxx;manufacturer=xxx";
> +
> +            Read `fit,engine` documentation for more info on special cases when
> +            using `pkcs11` as engine.
> +
> +            Depends on fit,engine.
> +
>      Substitutions
>      ~~~~~~~~~~~~~
>
> @@ -620,7 +659,21 @@ class Entry_fit(Entry_section):
>              args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
>          if (self._fit_props.get('fit,sign') is not None or
>              self._fit_props.get('fit,encrypt') is not None):
> -            args.update({'keys_dir': self._get_keys_dir(data)})
> +            engine = None
> +            if self._fit_props.get('fit,sign') is not None:
> +                engine_prop = self._fit_props.get('fit,engine')
> +                if engine_prop is not None:
> +                    engine = engine_prop.value
> +                    args.update({'engine': engine})
> +                engine_keydir_prop = self._fit_props.get('fit,engine-keydir')
> +                if engine_keydir_prop is not None:
> +                    engine_keydir = engine_keydir_prop.value
> +                    if engine_keydir:
> +                        args.update({'keys_dir': engine_keydir})
> +            if engine is None:
> +                args.update({'keys_dir': self._get_keys_dir(data)})
> +            elif self._fit_props.get('fit,encrypt') is not None:
> +                self.Raise('fit,engine currently does not support encryption')

The added code above would be better in a separate function.

>          if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
>                              **args) is None:
>              if not self.GetAllowMissing():
>
> --
> 2.51.1
>

For the code parts:

Reviewed-by: Simon Glass <sjg@chromium.org>
