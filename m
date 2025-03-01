Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9BDC021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 16:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB2C810F6;
	Sat,  1 Mar 2025 17:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fg3qF6u5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50910810FE; Sat,  1 Mar 2025 17:34:45 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36517810F5
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 17:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e095d47a25so5410101a12.0
 for <u-boot@lists.denx.de>; Sat, 01 Mar 2025 08:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740846882; x=1741451682; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/gxa8OuNLKT7RtzdewLI48954VmuZWFlddJPX3Qexlw=;
 b=Fg3qF6u5sOPbhU/GtBul/FHx7K4LYhrVkUnnsGS8an2V4k31/NTjc94kpntpx+aDUT
 lIYVc1U+2aCpr5mocIV4NvRKEUIGEeTs9uDJmOScNJ9bV/knXriLd9rYBeB6qzsf9PCx
 aqujdYSDYlxn/of5rIapYDNaZnvOm+MvoREJgsuY6D5wmqcPNQDEWmg12x/UEI4wvTnv
 R5JGIetJG57pOazwLPe43lFx1/Go8lkLsBSubyIdLni061gV1ESzmaxZBQgLPJ3E1Dws
 4FTehNIk4XyQeaq4oXtquHnwAJwV9QGLbd7JzZGY9sE1iGmcJQYe8VLIOIS1K7E26qJF
 74kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740846882; x=1741451682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/gxa8OuNLKT7RtzdewLI48954VmuZWFlddJPX3Qexlw=;
 b=o8qLNEJF/ibaPDp9e1JtOfrPCva3kjbQTMlaj894UjE1WljNb1AK9K5BPaJZ10gsJS
 NB0agk0BFlme5ieF8NnM7N6h2RA0yI1OOP/iIXoP8tkUD6+MJ4g3tfLqH+48Fnx09tOI
 jzHwshSKlroxCNC2HqMchDiSY/e4yRRoC71plcrw3YrrUR2qHB0KmNfDNjcVq29gCov9
 nxfETHJLRtm0bapx+wg2MSyD/Gfr+2/bRud1f8deGPUO5fEii150+5ufal0S2ZLLTyqp
 BAo4EofTR6Qs0B1QLaNZlC/5mxgyiswFIuo5G3ojIda52STo+3LLmxb6RUnK5I1Y7Szy
 tWsw==
X-Gm-Message-State: AOJu0YzfQDsT+shTyXYpaqQiX8PESlnGM9+z61XIIaqSSVQg5U6QZjL7
 Exk8DEbANX4fYPPCCyUxxCfC/KSgZp49/EFDQnJ3GqJ/KwimhWC3XuQ50cQcz2IsJc7iLVPsrzw
 /M8nEmz70AtpH50uqi882Wbp3tIs=
X-Gm-Gg: ASbGncsKLs6K2JToBiNZkM1dVRzajz0iitiqlSK3mjn66O0ySObFYLYMLobDP75mzZ9
 Pt++GK0YPt5rNfvzhusrI+jpisHt9fx52nCYYNO0VRprB3TIApM+FaqKI0/JhG6/vVaf9T2uG6h
 Z0v4u9Z3ydeZ0Vv1Ro3QpvtntQ/S6++vGfIOfAm438/0g69swzQFyaSgC2B0A=
X-Google-Smtp-Source: AGHT+IEStbY5zQ9HSnBPlhQuMikUyQeyrlN1EjAqsLcpYa1BhvfIwB5Sg0ZhoY6MrISuvdFgVcOtrCdHkLTF42gky3s=
X-Received: by 2002:a17:907:1c84:b0:aab:eefd:bfd8 with SMTP id
 a640c23a62f3a-abf2682d1f1mr1014895466b.49.1740846882283; Sat, 01 Mar 2025
 08:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20250226141952.1195955-1-raymond.mao@linaro.org>
In-Reply-To: <20250226141952.1195955-1-raymond.mao@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 1 Mar 2025 16:34:31 +0000
X-Gm-Features: AQ5f1JperS9ECWcaRIHtM48n-5kwdSmVb9E7nVc62ZE7xRytSR9WqUDFTozDwwA
Message-ID: <CALeDE9NRbYqGG=xEJJTG9sojey6CeADs72cMVG-Pa_2dDd4bcw@mail.gmail.com>
Subject: Re: [PATCH] tools: add HOSTCFLAGS from openssl pkg-config
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
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

On Wed, 26 Feb 2025 at 14:27, Raymond Mao <raymond.mao@linaro.org> wrote:

> HOSTCFLAGS of some tools components (image-host, rsa-sign and
> ecdsa-libcrypto) depend on the directory where openssl is installed.
> Add them via pkg-config.
> This fixes a potential build failure in tools when openssl in installed
> in varied directories.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>
 Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
>  tools/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/Makefile b/tools/Makefile
> index 237fa900a24..aafca65eb46 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -75,6 +75,9 @@ FIT_OBJS-y := fit_common.o fit_image.o image-host.o
> generated/boot/image-fit.o
>  FIT_SIG_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := image-sig-host.o
> generated/boot/image-fit-sig.o
>  FIT_CIPHER_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := generated/boot/image-cipher.o
>
> +HOSTCFLAGS_image-host.o += \
> +       $(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo
> "")
> +
>  # The following files are synced with upstream DTC.
>  # Use synced versions from scripts/dtc/libfdt/.
>  LIBFDT_OBJS := $(addprefix libfdt/, fdt.o fdt_ro.o fdt_wip.o fdt_sw.o
> fdt_rw.o \
> @@ -83,8 +86,12 @@ LIBFDT_OBJS := $(addprefix libfdt/, fdt.o fdt_ro.o
> fdt_wip.o fdt_sw.o fdt_rw.o \
>  RSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/rsa/, \
>                                         rsa-sign.o rsa-verify.o \
>                                         rsa-mod-exp.o)
> +HOSTCFLAGS_rsa-sign.o += \
> +       $(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo
> "")
>
>  ECDSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/ecdsa/,
> ecdsa-libcrypto.o)
> +HOSTCFLAGS_ecdsa-libcrypto.o += \
> +       $(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo
> "")
>
>  AES_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/aes/, \
>                                         aes-encrypt.o aes-decrypt.o)
> --
> 2.25.1
>
>
