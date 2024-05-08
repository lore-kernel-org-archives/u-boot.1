Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF0AC19F4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A9B887DD;
	Wed,  8 May 2024 16:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TgR2+xLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99AFE887C8; Wed,  8 May 2024 16:38:15 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE179884F3
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so173716666b.1
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715179093; x=1715783893; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YmrSe124yrn+Tl1Fea/tr46Sff0yMLJ2PN6LDjfp+Hc=;
 b=TgR2+xLn3WXkAeQYDgce1cCOMLyyWJShGv/pwWUbXB9ENtncSbxMQCUGUAuYGsGeYX
 e7sIB1jbPCIENpsU4triq6xTOTxNjH/aDt4Sb0R18jD2iyzplN3N6YUOus0cAZlQ/zv9
 CvbHTiChdo3CbTHcg6MDeK+obWaGFTag7ri4zrLG1BMg0yKBeO9ysa+K2nfJbYZ3p8Za
 2e5eML3B0vUuyr+Eu/FOpu4vztDKwqJlcvfJrbo43iOoV1cB4gvTRly1MX9eoZCyxjX6
 ZtwiKkXEIBEkLm3bcGrj1xxUZ1+h4KyMN1AJSVduWPHLN5R7/dLkDzWNlxtTFpnD/Rbb
 rLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715179093; x=1715783893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YmrSe124yrn+Tl1Fea/tr46Sff0yMLJ2PN6LDjfp+Hc=;
 b=D0Lp/fA27HGkI73YODZZ817l2er519REWD8S+OYhAWmamcUfo9w+PS7oAXPMbFEyS4
 NlM5UKtLJNvIB4wyh1fGyQ6kltM6Ba6lxPk7HidCm+tegIGHBiIfNRCc4QZjjdrzCYv7
 1c0PyxY6r10bHqHilrp5E1jrH5zkE0FP6lf7qoBnCalRx3Pk6g/K3efp7eLPd9GsGKED
 tP2DBGJS0FPdHYdkn1MLBmHH6GNpfwTKROjmU1lO1jql3SHtJKI27QyO7hbBzqPuLTEh
 MiAEMTxo+hBGWDAsRBalWh+M+HgfJEp8bINQtyOKPkE8Xjwlo5MSdjQMrNNn8d1ylcr3
 Vzyg==
X-Gm-Message-State: AOJu0YxUXFA5UH2wcarspgys1IecP3jHMu5r83Y8n0f4nsIhF2TuYF2T
 Eq80pS1J2pTFwe6zbDJ9j1H+3IYktD9d7J4AOFeYtLpn1UeZqm7JVk+1o6jSZcuHUlAamnvhVpJ
 udKMsCFKsQ9blBBQdDGiZT8/VqFb24q7nYLJHNg==
X-Google-Smtp-Source: AGHT+IH7Vl+3OottP4MStKTe3YCpPux6NlpLeFQTH8Z6z73RX9cclE65xWqL4EeEGzGGKO7x192jhq1I2PIgvW0gWL0=
X-Received: by 2002:a17:906:cb1:b0:a52:6fe5:938b with SMTP id
 a640c23a62f3a-a59e4e3625emr479409966b.26.1715179092948; Wed, 08 May 2024
 07:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-12-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-12-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 May 2024 17:36:58 +0300
Message-ID: <CAC_iWjJfGCMM00uCRCQfNAem1AyMc8XBATuDkaCP452R-wn0iA@mail.gmail.com>
Subject: Re: [PATCH v2 11/28] makefile: add mbedtls include directories
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Andrew Davis <afd@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Tue, 7 May 2024 at 20:56, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add the mbedtls include directories into the build system.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
>
>  Makefile | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 7321fe1499e..80db1dfd8ec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
>  UBOOTINCLUDE    := \
>         -Iinclude \
>         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> +       $(if $(KBUILD_SRC), \
> +               $(if $(CONFIG_MBEDTLS_LIB), \
> +                       "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
> +                       -I$(srctree)/lib/mbedtls \
> +                       -I$(srctree)/lib/mbedtls/port \
> +                       -I$(srctree)/lib/mbedtls/external/mbedtls/include)) \
>         $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
>                 $(if $(CONFIG_HAS_THUMB2), \
>                         $(if $(CONFIG_CPU_V7M), \
> @@ -840,6 +846,13 @@ UBOOTINCLUDE    := \
>
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>
> +ifeq ($(CONFIG_MBEDTLS_LIB),y)
> +PLATFORM_CPPFLAGS += "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
> +                       -I$(srctree)/lib/mbedtls \
> +                       -I$(srctree)/lib/mbedtls/port \
> +                       -I$(srctree)/lib/mbedtls/external/mbedtls/include

cpp_flags already includes UBOOTINCLUDE.

/Ilias
> +endif
> +
>  # FIX ME
>  cpp_flags := $(KBUILD_CPPFLAGS) $(PLATFORM_CPPFLAGS) $(UBOOTINCLUDE) \
>                                                         $(NOSTDINC_FLAGS)
> --
> 2.25.1
>
