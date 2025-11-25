Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CA0D10362
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 22:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 886BF8414B;
	Tue, 25 Nov 2025 23:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NeSn82ES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34249840E6; Tue, 25 Nov 2025 23:15:20 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008A88414B
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 23:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64166a57f3bso2408231a12.1
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1764108917; x=1764713717; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mp/6NCVjZlG/+lHINth+GQbiEdpeRRWs5iXakaoc92I=;
 b=NeSn82ES7ZfXzHc8tQHJefhvYOiwopOyv4DvlSVraBALMKZH0DTwM5POTUvXpZ2CC8
 aJn1Hpdf9Yz6lxg/oENl8uh9SV0ibyzJUwLpRH0X2mqLXXbvLTziOYY12QnaRKn4EUsF
 tbRVnk0MI+yejlJXy0FGgbC3yEaLObAXXQzAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764108917; x=1764713717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mp/6NCVjZlG/+lHINth+GQbiEdpeRRWs5iXakaoc92I=;
 b=BtgvTBsd4QG3GkjfIFJ10MVQP+tKBLrDLdlaFc5p6iCWdrjAlHIQDwAnUM3+JrlCud
 NOGLsEtSTO6sQ0A0POJlQVtSuC8uWhEpRqKljrBqQA/708zLtcaOo0xAY3wYmOaCUNGg
 WfEZHYTmUxU24lRAnNUCc0lKpPhbvBP9RvaLCrUCXxw52jg5HZtG0rvFU6uHOABbzLAK
 vdNU7cHa9iarsFrDeCdyAQqy9yRRaTUmkVO2/kyRlIfc4ByDUBEwOj5NBHkTc/Vt47Sg
 rLL6NL67jNKvebt78jW93kyp5zeFtTaC9tQ2/1fdzCHVQfV34dmMHS5VbhdYWeamlp23
 8H1w==
X-Gm-Message-State: AOJu0YzduRwOZTllFXI7jez/R6r4V37HS6NpMMbC059IKD7w1nV+i8Di
 dNqXflPk4k4QzRvNsdrKsHHDIpt4K4hP9o2Tss6AwRrmubCaP4H3VokN1NamD4EtLgskx7Whrf0
 Ix7vhO30mqOG3h+74CPXBTbdJMruIADy4Tn5Nad43bc6RLwIE0rA=
X-Gm-Gg: ASbGncs0jy2lsmaAEKm0E+DBZSr6D5ZcRZ5ETpuaRhW5M8Gs4xus7YD4C5bEgMgSOfG
 ab8UYaJLMM5X1AdQXbaVlXYM5caWeuqh+iVDArkI0KbmWqQjh7D+KjTEzGaP/kQBzqrH2Ez1R+C
 lMUYMnVGW2nxLKpawuCvDWI/hNan0X+K+BMZ0iHBLuusRUEjc7gz5ypmbFmuL1aZTqDyJTIeSO1
 f9uYjZfQfBZyo/kF5B/jkGnN2nWeHWlrGs9VMY6xmxlL/nPFJ7MwWbrznUVmnfFBy0swA==
X-Google-Smtp-Source: AGHT+IGjzCscNaryQT++32Su5/uF+dwn0nyau95iLl93w488WgPX98rkFxhGBVcKfVclEfPr2Rj1x8nNSa3BU2um3N4=
X-Received: by 2002:a17:906:730b:b0:b73:8b7f:8c51 with SMTP id
 a640c23a62f3a-b76c555d5f3mr465743766b.46.1764108917373; Tue, 25 Nov 2025
 14:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-3-b80180aaa783@cherry.de>
In-Reply-To: <20251121-binman-engine-v3-3-b80180aaa783@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Nov 2025 15:15:00 -0700
X-Gm-Features: AWmQ_bnkWxu2Ap81ouMxc3UbPkaV3_ib1n2WRlFgvkWVBHRgvBGL7R-ZItykqos
Message-ID: <CAFLszThFdfMeFTtvDyXfH1iO2zx5fe9rJJSz=MQBGJiXB4HG5w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] tools: binman: fit: add support for OpenSSL engines
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

On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This adds support for using an OpenSSL engine for signing a FIT image.
> To use it, one should set the fit,engine property at the FIT node level
> with the engine to use. This will in turn call mkimage with the -N
> option.
>
> The -k argument to mkimage can be specified via fit,engine-keydir. If
> not specified, -k is not passed to mkimage. This property is especially
> useful for pkcs11 engine to specify slots, token label, etc...
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
>  tools/binman/entries.rst  | 54 +++++++++++++++++++++++++--
>  tools/binman/etype/fit.py | 93 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 140 insertions(+), 7 deletions(-)
>
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index 8922d6cd070..a81fcbd3891 100644
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
> @@ -898,6 +899,53 @@ The top-level 'fit' node supports the following special properties:
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
> +        When `fit,engine` is set to `pkcs11`, the following applies:
> +
> +        - If `fit,engine-keydir` is absent, the value of `key-name-hint` is
> +          prefixed with `pkcs11:object=` before being passed to the OpenSSL
> +          engine API::
> +
> +              pkcs11:object=<key-name-hint>
> +
> +        - If `fit,engine-keydir` contains either `object=` or `id=`, its
> +          value is passed verbatim to the OpenSSL engine API,
> +
> +        - Otherwise, the value of `fit,engine-keydir` is followed by
> +          `;object=` and the value of `key-name-hint` before being passed
> +          to the OpenSSL engine API::
> +
> +              <fit,engine-keydir>;object=<key-name-hint>
> +
> +        If `fit,engine` is set to something different than `pkcs11`, the
> +        value of `key-name-hint` (prefixed with the value of
> +        `fit,engine-keydir` if present) and passed verbatim to the OpenSSL
> +        engine API.
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
> index db40479d30e..f28b1e6b4cb 100644
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
> @@ -117,6 +118,53 @@ class Entry_fit(Entry_section):
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
> +            When `fit,engine` is set to `pkcs11`, the following applies:
> +
> +            - If `fit,engine-keydir` is absent, the value of `key-name-hint` is
> +              prefixed with `pkcs11:object=` before being passed to the OpenSSL
> +              engine API::
> +
> +                  pkcs11:object=<key-name-hint>
> +
> +            - If `fit,engine-keydir` contains either `object=` or `id=`, its
> +              value is passed verbatim to the OpenSSL engine API,
> +
> +            - Otherwise, the value of `fit,engine-keydir` is followed by
> +              `;object=` and the value of `key-name-hint` before being passed to
> +              the OpenSSL engine API::
> +
> +                  <fit,engine-keydir>;object=<key-name-hint>
> +
> +            If `fit,engine` is set to something different than `pkcs11`, the
> +            value of `key-name-hint` (prefixed with the value of
> +            `fit,engine-keydir` if present) and passed verbatim to the OpenSSL
> +            engine API.
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
> @@ -588,6 +636,29 @@ class Entry_fit(Entry_section):
>
>          return paths[0] if len(paths) else None
>
> +    def _get_fit_engine(self):
> +        """Detect whether an OpenSSL engine is to be used for the FIT
> +
> +        Returns:
> +            Tuple(str, str): Name of the engine to use, as first element of the
> +                             Tuple. None if no engine to use.
> +                             keydir arguments to pass with the engine to the
> +                             OpenSSL API, as second element of the Tuple. None
> +                             if no keydir to pass.
> +        """
> +        engine = None
> +        engine_keydir = None
> +
> +        prop = self._fit_props.get('fit,engine')
> +        if prop is not None:
> +            engine = prop.value
> +
> +            prop = self._fit_props.get('fit,engine-keydir')
> +            if prop is not None:
> +                engine_keydir = prop.value
> +
> +        return engine, engine_keydir
> +
>      def BuildSectionData(self, required):
>          """Build FIT entry contents
>
> @@ -620,7 +691,21 @@ class Entry_fit(Entry_section):
>              args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
>          if (self._fit_props.get('fit,sign') is not None or
>              self._fit_props.get('fit,encrypt') is not None):
> -            args.update({'keys_dir': self._get_keys_dir(data)})
> +            engine = None
> +            keydir = None
> +
> +            # Engine only supported for signing for now
> +            if self._fit_props.get('fit,sign') is not None:
> +                engine, keydir = self._get_fit_engine()
> +
> +            args.update({'engine': engine})
> +            # If no engine, keys must exist locally, find them
> +            if engine is None:
> +                keydir = self._get_keys_dir(data)
> +            elif self._fit_props.get('fit,encrypt') is not None:
> +                self.Raise('fit,engine currently does not support encryption')
> +
> +            args.update({'keys_dir': keydir})
>          if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
>                              **args) is None:
>              if not self.GetAllowMissing():
>
> --
> 2.51.1
>

Were there any changes on this one? It looks OK to me.

You should be able to do: if 'fit,sign' not in self._fit_props

Regards,
Simon
