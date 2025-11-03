Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C00CCFA06
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 16:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 808F68391C;
	Mon,  3 Nov 2025 17:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AUVjDuIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 292C38331F; Mon,  3 Nov 2025 17:21:55 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71DF8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 17:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-63c0c9a408aso6710212a12.3
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 08:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762186912; x=1762791712; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fpng9rdt3DaXcT3av/6pwVcEq5dUtjMDxUwHKs1apN8=;
 b=AUVjDuIsM0DFj5Q5LMOW5qCiGvqTx9KQafYaL3NSPjyOGkAZ6BaCEq35lj84wI9Gje
 Np8g8JTOrVa2CUtQI3kblOPvTVlgpngavgZ1+k/uGOc7cGPFMQhaGFUYeCLSp0cFSptO
 JLdGXOrhzXbBiCSsyvxb/3/Mi2/w9dbq9VNotvBMvt5W8daJWkzPW2t9DYsERyRIZAiM
 r4eFqLo5/pwuDgTHlroioda2XA+c0ZQNUJ5huHUvvbWh1LIlsgisU6jugYyvKkPE5iJZ
 88xDoJgJTvVFC2Lbt9gC3PfWKBrAQzCpNaVf3MpOt+asfyj0oAxfGjN/9swaSh8De7W+
 St7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762186912; x=1762791712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fpng9rdt3DaXcT3av/6pwVcEq5dUtjMDxUwHKs1apN8=;
 b=mTzKjqxaCN3GDZayq7faUrEtO2+Ke21ovdJ2lFi3piKhGuYpkUgli9b/AcSw61YUHM
 rNywMVmEZHFYnsAQL4MhihlQOgkTV9Ct/CxTEycqpV+PWG4/HXhdrHws3ACtimhm3kiY
 wtg+DlORrBn4KaSlPQCMKbCphqUh/8McQYrTqnWCfy43I1NvJQeRiway5mVnwuD2TFE/
 lXdLJxN7rhFpxCFo7mYnusxKWXCCuFOQMm9q1MnFc3p880tdN54V8Ak1mQYUMOEK8D7f
 AyDOMx66YMd86m54/UqeT6xucOob8RGHfjlUKT1d8xvjb7p3/cSEmz7t3Pwbh7YG9Yrz
 Xjew==
X-Gm-Message-State: AOJu0YxLk8XtYoMA2zgyZrg0uJYiUU22DPAi9Pztr+bUwvBiPKWmUrnR
 mEqVqIiDygGuseJD5tEeeFoIb/s8gYI75+205RxNTVaugAprwlCKJqT0975C5W4g0zjT1o2w+GG
 SGQ/Y32k6tyvkdLkjeWxfO51MRQGW7Hw=
X-Gm-Gg: ASbGnctPlpVfNMmuPei3jiaRAHAK3nYbGhWLvCNEy342r96UzBbqAPgxvDbwMbTA6Ew
 ALZq43lTBQ0p7/PyDFoEi00eZ7tCFIwGjJuAQ+EDsFcqkiSlwviGH2Y2U44UJM32KX+I8yVbvDM
 p3Y/OtcG7bV53N2TF/02My9Ii41ZVlCU5W5z8vb+gLPfO0hQHrjsvshmrVJuyCNSMvB6o1SoCwb
 ITNFc1Zxw+foiTU/H4eB3qo4Vb0iIfUHdQr1jSua5sBhhpjPqqegh3MKBbC2mK8jtXlZicZpPl6
 5Bdj9W41VSOvmcYpV/StXi3afGmxyqGYNET0O457pUocaAvSaocOa1PrpDItVHNkU1GANqZF051
 sqjzr+L8KIhT+j7UwXoLpHwnVm+KM
X-Google-Smtp-Source: AGHT+IG7Bo1o3nOG4o2pEmLLtgeq+Hd7I8UQzdqhg3QghLtV8jd05St/4C3iOBtHU6P7Eki/jEji2NCOaBYcsZFEjLQ=
X-Received: by 2002:a05:6402:d0b:b0:640:9b62:a8bb with SMTP id
 4fb4d7f45d1cf-6409b62ca54mr6920158a12.22.1762186911735; Mon, 03 Nov 2025
 08:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-3-c13c1b5dac43@cherry.de>
In-Reply-To: <20251031-binman-engine-v1-3-c13c1b5dac43@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 3 Nov 2025 16:21:40 +0000
X-Gm-Features: AWmQ_bl2_0bqDToM4qLIu24BilI_tYAY0M2jP95qIafmCUJ7E4_EJ21slKflhHU
Message-ID: <CALeDE9MYi2+u_ek1Rapmzx2_T9uE_cQcH8paKgxKwZjtGJ2gzg@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools: binman: fit: add support for OpenSSL engines
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hey Quentin,

> This adds support for using an OpenSSL engine for signing a FIT image.
> To use it, one should set the fit,sign-engine property at the FIT node
> level with the engine to use. This will in turn call mkimage with the -N
> option.

Just to be aware this should likely be a OpenSSL provider, engines in
OpenSSL are deprecated and due to be removed in 4.0. A lot of distros
are already dropping support for engines. There's a patch [1] adding
support for Providers support to U-Boot, I suspect we shouldn't be
adding more deps on the Engine support. OpenSSL 4 is due in March.

[1] https://lists.denx.de/pipermail/u-boot/2025-October/601616.html
[2] https://openssl-library.org/roadmap/index.html

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
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index 8922d6cd070..7b162a3edb8 100644
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
> +        If the property is found and fit,sign-engine is not set, the private
> +        keys path is detected among binman include directories and passed to
> +        mkimage via -k flag. All the keys required for signing FIT must be
>          available at time of signing and must be located in single include
>          directory.
>
> @@ -898,6 +899,21 @@ The top-level 'fit' node supports the following special properties:
>          required for encrypting the FIT must be available at the time of
>          encrypting and must be located in a single include directory.
>
> +        Incompatible with fit,sign-engine.
> +
> +    fit,sign-engine
> +        Indicates the OpenSSL engine to use for signing the FIT image. This
> +        is passed to mkimage via the `-N` flag. Example::
> +
> +            fit,sign-engine = "my-engine";
> +
> +        No `-k` argument will be passed to mkimage. The key_id passed to the
> +        OpenSSL engine API is the verbatim value of the key-name-hint property.
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
> -            verified-boot.rst. If the property is found, the private keys path
> -            is detected among binman include directories and passed to mkimage
> -            via  -k flag. All the keys required for signing FIT must be
> +            verified-boot.rst.
> +            If the property is found and fit,sign-engine is not set, the private
> +            keys path is detected among binman include directories and passed to
> +            mkimage via -k flag. All the keys required for signing FIT must be
>              available at time of signing and must be located in single include
>              directory.
>
> @@ -117,6 +118,21 @@ class Entry_fit(Entry_section):
>              required for encrypting the FIT must be available at the time of
>              encrypting and must be located in a single include directory.
>
> +            Incompatible with fit,sign-engine.
> +
> +        fit,sign-engine
> +            Indicates the OpenSSL engine to use for signing the FIT image. This
> +            is passed to mkimage via the `-N` flag. Example::
> +
> +                fit,sign-engine = "my-engine";
> +
> +            No `-k` argument will be passed to mkimage. The key_id passed to the
> +            OpenSSL engine API is the verbatim value of the key-name-hint property.
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
> +            # Don't pass a key-dir to mkimage in case an engine is used to sign
> +            # as we don't need a private key on storage anyway.
> +            # Additionally, binman pass an absolute path as keys_dir which is
> +            # highly unlikely to actually make sense for engines.
> +            # Because of that limitation, we currently cannot support at the
> +            # same time fit,encrypt and fit,sign-engine.
> +            # mkimage will read key-name-hint and pass it verbatim to the engine
> +            # as key_id in the OpenSSL engine API instead.
> +            if engine is None:
> +                args.update({'keys_dir': self._get_keys_dir(data)})
> +            elif self._fit_props.get('fit,encrypt') is not None:
> +                self.Raise('Cannot have both fit,encrypt and fit,sign-engine')
>          if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
>                              **args) is None:
>              if not self.GetAllowMissing():
>
> --
> 2.51.0
>
