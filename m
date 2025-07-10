Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E75C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 14:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B2B7835C9;
	Thu, 10 Jul 2025 16:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z5Vfke10";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69BB183653; Thu, 10 Jul 2025 16:16:40 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B1D3835B6
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 16:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-553c31542b1so982503e87.2
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752156998; x=1752761798; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ClNSnTWn9sXTvzgolmApj7ZPpThb1nmLVTAy3VCPvU=;
 b=Z5Vfke10OdjH2MhB6WvTs+3/JW+DLWT15P7ablwio5hy6WagnyIdxT05k3QY8XHWU3
 UsM4SKKJ8j2lB1pu+M7zSlRJ6AhyjvwTkmryt2vXEdhj8CWq4gS0bqHPkaU+L7D9yYsM
 cXdeEnvpEwsT7UEHkd36SfRH62Y6uTDPcA4YJZ9t4J1qnBoI8vZTckRj6PEpisQd6Xl2
 wcd3/oLMuIfu1PBRHzePnROa6llr8kvouLwu3X3dWdRxLFjbUNNVBaLhgCH4zz8Hk/QK
 cCYG1gf4UAVc/fQTZKO2zVYB+gqccX/ftca9C7XrlL65mIH7gms+gLVLLIMD1NhJ0V4q
 XWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752156998; x=1752761798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ClNSnTWn9sXTvzgolmApj7ZPpThb1nmLVTAy3VCPvU=;
 b=jrb/b+gxYNGl0FhW91l6bsyhh6iHLzK1VlX/b0RKBujPDnUMKq3l7wSOpticjwO5jx
 0IjWUW7zThD8Lasqpx1PBg3+v+utlDxV9J0VxuSkPY484peOxN59LzXXwMAr/3TBW9D2
 5f1r7UXOhY2dVXDgYDJuCvKtx3ORcMk0Vj1hWG6eAtcRGJepvUaEogK55WPr49TZYP4P
 0KIHUftsCQ5lhUHfYo4AtUhSCbujy/xE38JB+PsSOFMHYVY/Ef1eLsjB6iQZgeCViKXf
 WheyA/GTcUrOl2nBQ9h3T2mKpF10Ai0cLPnsKr57RGDCWrmEsnx7kMBJ6c5qPlfyOsAm
 CgBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoFTRpEg3VecMY4JoBmZHRkvk5rkAuXynvRWi1k4awRor0OzN0weVZFRFU0Ss1Z7hpqR03Ivw=@lists.denx.de
X-Gm-Message-State: AOJu0YzUNlYDIUsI/iERKKGdNW/wHDyMX2d2vgybebdfv2sv6FFxohtW
 OvF+x5fC/spjoi9kX1XAyoU59FwEyx42rLuoX6D2DyGZNNfz3cPHKu+6FFd1YA/Cmu/OlJxq2zG
 BW/2z8pIIyOIekrfkuegHZnTril8u5l4=
X-Gm-Gg: ASbGncuIVA5qsrEAAS90XtH9TSZdtKjUhsjfI058nIQieqa0pCR4qxjZIRQNUg3pjky
 Jv3F7OK4jDewJm0b+4qll3MXQ8aEOVgVD7V9jyFEgDxwtEQDCONmd+d/Hxj/9HuoT4h6JtYjDLo
 JCOAIYG4Jtu6saE0VSBU5MQwGYCjDf2NrXmqAL8LvhhvukRFwMFZY3zwehIWSCdKfckhpON1qe4
 i0=
X-Google-Smtp-Source: AGHT+IEiVVwljuBjFAE4/NpkHXvd9p6EubiShTmxdaX+8DVmgDV7BxeEs+ryhTD8V+CHMygno6R38CCQSx6utNTHrr8=
X-Received: by 2002:a05:6512:acf:b0:553:2645:4e90 with SMTP id
 2adb3069b0e04-55935b3ac63mr1245305e87.52.1752156997269; Thu, 10 Jul 2025
 07:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20250627185723.342553-2-ilias.apalodimas@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 10 Jul 2025 11:16:25 -0300
X-Gm-Features: Ac12FXyGhFlNPOeMMZsD6p8R1b9CPMpAavQUuGRkSNQFEjDvLm02hEqx8o6tuYw
Message-ID: <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, sughosh.ganu@linaro.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, 
 Olaf Mandel <o.mandel@menlosystems.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>, 
 Prasad Kummari <prasad.kummari@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
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

Hi Ilias,

On Fri, Jun 27, 2025 at 3:57=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Our last sync with the kernel was 5.1. Even that was a partial one
> as some patches from 4.x kernels were already missing making the
> transition to a modern kbuild infeasible.
>
> We are so out of sync now, that tracking the patches and backporting
> them one by one makes little sense and it's going to take ages.
>
> This is an attempt to sync up Makefile[.lib/.kbuild].
> Unfortunately due to sheer amount of patches this is not easy to review,
> but that's what we decided during a community call.
>
> One of the biggest changes is get rid of partial linking entirely and
> build .a archives isntead of .o.
> We diaviate from the kernel on that. Instead of calling a custom script
> to create the archive symbol table, we call ar with rcTP (isntead of
> rcSTP) since we want a resulting archive that's sauble with the linker.
>
> The only affected platforms are PPC ones. Unfortunately I don't have any
> of them around to test, but the objdump of the resulting files --
> arch/powerpc/lib/built-in.[oa] looks identical.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

This commit breaks the mx6sabresd_defconfig build on my Ubuntu 2022.04 mach=
ine:

$ make mx6sabresd_defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
$ make
scripts/kconfig/conf  --syncconfig Kconfig
  UPD     include/config.h
  CFG     u-boot.cfg
  GEN     include/autoconf.mk
  GEN     include/autoconf.mk.dep
  CFG     spl/u-boot.cfg
  GEN     spl/include/autoconf.mk
make: *** arch/arm/mach-imx/: Is a directory.  Stop.
