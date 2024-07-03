Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80897C30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 11:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B710A887EA;
	Wed,  3 Jul 2024 13:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="urpbZYZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E0E88808; Wed,  3 Jul 2024 13:35:19 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7B9B887E3
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 13:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7594c490b04so335554a12.3
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 04:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720006515; x=1720611315; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VBZglBQdDhtZST6U5k01HQvldxseMQQcfgVLA8olrmc=;
 b=urpbZYZUPAlPh4HOjpaemzdoxz7FanLwMQ/e2op0NCCGT5Cscbf09nAcjiyeSJNwT1
 YGl2RI5H7a/P0VLs69b0f7EbwrIxiwHYYwaLF5gH8alWBfG8f5aljBdJpwdqhbXeQ0Fb
 IAuMWv4eTldgX9neK3/aCNzpa4TD2cpqmzzzayNXLzNYrCnMTvT3edzU0ktqlao8mN7r
 IS5XzYh0Oes//PaBPHBgdBjQMFfIb6Si9nEoa6yjx4uZPjBlkgeEL9kNts1YYGzqNeBf
 QnE0xV75cqH/vXIPJyxfyfJFPK0MK6n10YuYKE8SLmq4p2dW1tlk/+GHmneme5DGHnbt
 HXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720006515; x=1720611315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VBZglBQdDhtZST6U5k01HQvldxseMQQcfgVLA8olrmc=;
 b=jDPE3frGRvcTRQKeki8pAt/lQd4W5Iu+FNjdYF1SjXyo+Q1b1WF/DfL9mTemI7+heW
 CCwbhifYwAsJ9a6X47YDDgznfAJ7/fojsaZB0Wq4X+jEAoghDRZds+7C0NdLSfBCJLnU
 O6til9LBR2Dj9rJapNsW6i//ufBkWOSM6dLfRTvND0DOl/IG8mE6ZKVrYPTOoDktts8W
 8UuT3iV/Ye0f18KpquFdZEJCGckp22MedoQa72Ndc9CFfTlOP1mm8K5BgEV9PRgG90jP
 KCydZPVQzQJWvekNTDrBDMb5cOOX/66nvtES8g1oYFErGhRGVuLCMtK4VX8kgEbcd99y
 0SoQ==
X-Gm-Message-State: AOJu0YyKsjSRVcc48jVU0jxtaJffgQRLOseFcCx61P0oWj/B/KENkUOc
 tYoHH0FCR4sEFAF5SCTKfm5gVBFrNXr9hTRriH7U7eFw2eRxoKNhyA4Ow9J+kjnFNC2drO0t9tc
 pAiut3CtF40YsI5EAJKHMjlBdCOJIpUgnObc4TQ==
X-Google-Smtp-Source: AGHT+IGz9fIdTL/PqfF8yMQBItX0U32E8lIGBqW7fBIjCcxH1gvAQ2Wk2LEyyDUM7QleJQdB8hH5Tty6S6ypVS7gS24=
X-Received: by 2002:a05:6a20:cf84:b0:1bd:2894:4015 with SMTP id
 adf61e73a8af0-1bef620fa9fmr16053741637.50.1720006515207; Wed, 03 Jul 2024
 04:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-10-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-10-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jul 2024 14:34:38 +0300
Message-ID: <CAC_iWjKC0sB++5um6TpnOxmkY8DhoNEx76C2UOeKsF7cX8yXCA@mail.gmail.com>
Subject: Re: [PATCH v4 09/29] makefile: add mbedtls include directories
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add the mbedtls include directories into the build system.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
> Changes in v3
> - Remove changes for PLATFORM_CPPFLAGS.
> Changes in v4
> - Fix errors when building without "O=".
> - Minor fix of the include directories.
>
>  Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 07d7947c8af..fd855dbd5c9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
>  UBOOTINCLUDE    := \
>         -Iinclude \
>         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> +       $(if $(CONFIG_MBEDTLS_LIB), \
> +               "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \

don't you need a full path to the config file?
> +               -I$(srctree)/lib/mbedtls \
> +               -I$(srctree)/lib/mbedtls/port \
> +               -I$(srctree)/lib/mbedtls/external/mbedtls \
> +               -I$(srctree)/lib/mbedtls/external/mbedtls/include) \

Most of these paths are explicitly added in patch #3. Why don't we
just keep them there?

Thanks
/Ilias
>         $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
>                 $(if $(CONFIG_HAS_THUMB2), \
>                         $(if $(CONFIG_CPU_V7M), \
> --
> 2.25.1
>
