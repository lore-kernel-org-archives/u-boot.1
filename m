Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0300FC30658
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 00:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA4D886A4;
	Wed,  3 Jul 2024 02:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uZc3DdwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE5A188771; Wed,  3 Jul 2024 02:02:52 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11B0688548
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 02:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c7dff0f4e4so3281681a91.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 17:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719964968; x=1720569768; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RoPvNz3WgwXS1ptSMKZLs+QYdDKB9ORzYbWvKd+hQys=;
 b=uZc3DdwG7HYeTlQSDFXrwMGtWxeUvCzOY86hAmp3AliykU8O6fV1fFsWk6Clt3Ctfy
 YTJj7SstRUYOH3nKAmUSkkHefpoPkFW0geEYaGPNIh7XZ8zOWsqyKLMV9qL2p3Bsy2Gr
 sWhRPuzMNx9ugXcAMokB7UHtcuSGkdu/WkXkgBEcz5coKds9ntTleSQQDw9gSX7gitZL
 s77c5reMC4FGt7ZuFtTJUZvhvZGui2QX8jgR9FE+eIQFeD3x5cGCOCY+0nord77BTn4G
 tUX152JFfZXT0qaqj1xSjPkwbUVp6fRLdXNL+koyAl+lfhrFH9g0iem/wndo4CjU5cGL
 AqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719964968; x=1720569768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RoPvNz3WgwXS1ptSMKZLs+QYdDKB9ORzYbWvKd+hQys=;
 b=H9HqxFEDbME8KvO3+HcbVBMiS+IabwW9bGcAtQBDlvuZW0eX87ZXP3YYeJ3F2rgYtQ
 xGkx7sPgFsRt6mFDqIGumUIHfNw8sQDfCLjJFHoAoCPrvG/+nSvRBrb3e7igZdpQsylC
 3P457cDOv2XHuViBzfjNKajNJKpA9hqysHWPvuOzkifvRXd1mkU0N18pkuHAgVbRvcSt
 zQKR8Y57MPgyUd/+FpgHg4dnhtsVqNsf6kcTVbB0ErK5wBe/07yq5GSwmjeQl4t14HY7
 SZgZvjZ/K0rrgyc6eVzNhWIckukBUr2DvytscsWbAsIPHMcRbLzqeck8jgxnltETJQ/Z
 0lvQ==
X-Gm-Message-State: AOJu0YzxPCdz0GZRKvQF1CjelXVRsavQcj8OAtXo1v3fMmCjIBFT+01k
 dyIdQlQ+3NWD8JyIKGVGBfovydWMTfwvxk4/vJLWlbso2C3a/b4st5IUa3TERiAz9vgHZxXq6n/
 lYKeu0IX+4O3dnkRdP/t6KyWFM464E6LJwcHazA==
X-Google-Smtp-Source: AGHT+IHakEYiGjdZxwD3vnvK1Bea2VjH6yCfdMEvsBLaC3WQyWUG0c9B0/Q0x6jmd5fpKLXFj/tv2tz09UCFrS4v6Gg=
X-Received: by 2002:a17:90a:564f:b0:2c9:69cc:3a6f with SMTP id
 98e67ed59e1d1-2c969cc3cc8mr1713936a91.31.1719964968399; Tue, 02 Jul 2024
 17:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-5-raymond.mao@linaro.org>
 <20240702224825.GT38804@bill-the-cat>
In-Reply-To: <20240702224825.GT38804@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 2 Jul 2024 20:02:37 -0400
Message-ID: <CAEfUkULVRD_SQWP9f9bjRutXi33aqiEaNhTWfdF9qKWvLhKJ1g@mail.gmail.com>
Subject: Re: [PATCH v4 04/29] lib: Adapt digest header files to MbedTLS
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Tom,

On Tue, 2 Jul 2024 at 18:48, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Jul 02, 2024 at 11:22:40AM -0700, Raymond Mao wrote:
>
> > Adapt digest header files to support both original libs and MbedTLS
> > by switching on/off MBEDTLS_LIB_CRYPTO.
> > Introduce <alg>_LEGACY kconfig for legacy hash implementations.
> [snip]
> > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > index 3e9057f1acf..6662a9d20f1 100644
> > --- a/lib/mbedtls/Kconfig
> > +++ b/lib/mbedtls/Kconfig
> > @@ -21,9 +21,105 @@ if LEGACY_CRYPTO
> >
> >  config LEGACY_CRYPTO_BASIC
> >       bool "legacy basic crypto libraries"
> > +     select MD5_LEGACY if MD5
> > +     select SHA1_LEGACY if SHA1
> > +     select SHA256_LEGACY if SHA256
> > +     select SHA512_LEGACY if SHA512
> > +     select SHA384_LEGACY if SHA384
> > +     select SPL_MD5_LEGACY if MD5 && SPL
> > +     select SPL_SHA1_LEGACY if SHA1 && SPL
> > +     select SPL_SHA256_LEGACY if SHA256 && SPL
> > +     select SPL_SHA512_LEGACY if SHA512 && SPL
> > +     select SPL_SHA384_LEGACY if SHA384 && SPL
> >       help
> >         Enable legacy basic crypto libraries.
> >
> > +if LEGACY_CRYPTO_BASIC
> > +
> > +config SHA1_LEGACY
> > +     bool "Enable SHA1 support with legacy crypto library"
> > +     depends on LEGACY_CRYPTO_BASIC && SHA1
> > +     help
> > +       This option enables support of hashing using SHA1 algorithm
> > +       with legacy crypto library.
> > +
> > +config SHA256_LEGACY
> > +     bool "Enable SHA256 support with legacy crypto library"
> > +     depends on LEGACY_CRYPTO_BASIC && SHA256
> > +     help
> > +       This option enables support of hashing using SHA256 algorithm
> > +       with legacy crypto library.
> > +
> > +config SHA512_LEGACY
> > +     bool "Enable SHA512 support with legacy crypto library"
> > +     depends on LEGACY_CRYPTO_BASIC && SHA512
> > +     default y if TI_SECURE_DEVICE && FIT_SIGNATURE
> > +     help
> > +       This option enables support of hashing using SHA512 algorithm
> > +       with legacy crypto library.
> > +
> > +config SHA384_LEGACY
> > +     bool "Enable SHA384 support with legacy crypto library"
> > +     depends on LEGACY_CRYPTO_BASIC && SHA384
> > +     select SHA512_LEGACY
> > +     help
> > +       This option enables support of hashing using SHA384 algorithm
> > +       with legacy crypto library.
> > +
> > +config MD5_LEGACY
> > +     bool "Enable MD5 support with legacy crypto library"
> > +     depends on LEGACY_CRYPTO_BASIC && MD5
> > +     help
> > +       This option enables support of hashing using MD5 algorithm
> > +       with legacy crypto library.
> > +
> > +if SPL
> > +
> > +config SPL_SHA1_LEGACY
> > +     bool "Enable SHA1 support in SPL with legacy crypto library"
> > +     depends on LEGACY_CRYPTO_BASIC && SPL_SHA1
> > +     default y if SHA1 && LEGACY_CRYPTO_BASIC
> > +     help
> > +       This option enables support of hashing using SHA1 algorithm
> > +       with legacy crypto library.
> > +
> > +config SPL_SHA256_LEGACY
> > +     bool "Enable SHA256 support in SPL with legacy crypto library"
> > +     depends on LEGACY_CRYPTO_BASIC && SPL_SHA256
> > +     default y if SHA256 && LEGACY_CRYPTO_BASIC
> > +     help
> > +       This option enables support of hashing using SHA256 algorithm
> > +       with legacy crypto library.
> > +
> > +config SPL_SHA512_LEGACY
> > +     bool "Enable SHA512 support in SPL with legacy crypto library"
> > +     depends on LEGACY_CRYPTO_BASIC && SPL_SHA512
> > +     default y if SHA512 && LEGACY_CRYPTO_BASIC
> > +     help
> > +       This option enables support of hashing using SHA512 algorithm
> > +       with legacy crypto library.
> > +
> > +config SPL_SHA384_LEGACY
> > +     bool "Enable SHA384 support in SPL with legacy crypto library"
> > +     depends on LEGACY_CRYPTO_BASIC && SPL_SHA384
> > +     default y if SHA384 && LEGACY_CRYPTO_BASIC
> > +     select SPL_SHA512
> > +     help
> > +       This option enables support of hashing using SHA384 algorithm
> > +       with legacy crypto library.
> > +
> > +config SPL_MD5_LEGACY
> > +     bool "Enable MD5 support in SPL with legacy crypto library"
> > +     depends on LEGACY_CRYPTO_BASIC && SPL_MD5
> > +     default y if MD5 && LEGACY_CRYPTO_BASIC
> > +     help
> > +       This option enables support of hashing using MD5 algorithm
> > +       with legacy crypto library.
> > +
> > +endif # SPL
> > +
> > +endif # LEGACY_CRYPTO_BASIC
> > +
> >  config LEGACY_CRYPTO_CERT
> >       bool "legacy certificate libraries"
> >       help
>
> This is all certainly moving in the right direction, but there's
> dependency issues:
>    aarch64:  w+   xilinx_zynqmp_kria
> +(xilinx_zynqmp_kria)
> +(xilinx_zynqmp_kria) WARNING: unmet direct dependencies detected for
> SPL_MD5_LEGACY
> +(xilinx_zynqmp_kria)   Depends on [n]: LEGACY_CRYPTO [=y] && SPL [=y] &&
> LEGACY_CRYPTO_BASIC [=y] && SPL_MD5 [=n]
> +(xilinx_zynqmp_kria)   Selected by [y]:
> +(xilinx_zynqmp_kria)   - LEGACY_CRYPTO_BASIC [=y] && LEGACY_CRYPTO [=y]
> && MD5 [=y] && SPL [=y]
>

I am a bit confused by SPL_MD5, why it is [n] when both MD5 and SPL are [y].
Of course we can replace 'SPL_MD5' with 'MD5 && SPL' to solve the warning,
but I guess the wrong dependence is on SPL_MD5 but not the new added ones.
```
config SPL_MD5
bool "Support MD5 algorithm in SPL"
depends on SPL
```
I think it should be 'default y if SPL && MD5' instead of 'depends on SPL'.

Similarly SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not selected when both
ASYMMETRIC_PUBLIC_KEY_SUBTYPE
and SPL are selected;
SPL_ASN1_DECODER is not selected when both ASN1_DECODER and SPL are
selected.

I think generally for each algorithm, 'SPL_<ALG>' config should be selected
when both 'SPL' and '<ALG>' are selected.

If you agree I can fix this in the next patch set.

Regards,
Raymond
