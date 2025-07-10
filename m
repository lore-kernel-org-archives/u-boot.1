Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF51FC83F1B
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 14:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E718363C;
	Thu, 10 Jul 2025 16:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h2FtyWIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B58083653; Thu, 10 Jul 2025 16:28:13 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58A25835C9
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 16:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70f94fe1e40so24301177b3.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752157690; x=1752762490; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIagwolHpwRRrKcmdztCc/pra/2yd2KqX/22Mqz0IpQ=;
 b=h2FtyWIjEafhr+3a0XN4lvi4mzEl4UqWVXGztxIKA6L+L6XqJXgG0C9aqk9ALseAKv
 0p1iGRXABWaIrMT+9/3yllcIP5DOIWoUm/EsQu/ER7iZ+rCLRRwjAKIYincuA7ZoxAZ6
 hM8pd1alFIkScf+V+xIWBfGjteJJmkLa7ssJ2K34ZpQVj3iRTWbaLWcnDc6+I24MzEPn
 LeVJZ1az8FuJOFusmeR8kp0mH/7e3GBuMqdCL7CYU7ogosjuaNhQvPVSihgE/rZdDlW3
 qrJid3VxOcFxWBCebpYmMc87qR6OgYBC261JVF0MyknlQye+gQ1fiuS1yFH96EEBWHfM
 NTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752157690; x=1752762490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HIagwolHpwRRrKcmdztCc/pra/2yd2KqX/22Mqz0IpQ=;
 b=cttmwDDB4hvfx4V63+PROulbffe5q/n4d2FLrQfneaviJhmImu3ypdilPF1h6h+XEI
 vZ1GgaDxoAYRZkjsIhqXIAvYGvxjYHQVHKLB6SNKCmZR56BsFJLq4P9m5EojNnh7vWhX
 5bdSddDPDEA7kAm85N6OrgoCEN5G2OvdAyGhmqFfQM9hgsN0Z+v/ermssvcnV6Mojiav
 Sq9SVj/M7b1FJGjxanrIW+fKRVkzuh0nScGT0k14lXdbet4a8GNfnyIY5+lNU35yYjGw
 l4drpDVGNr0SR+eYd7BLumYhSlFPREoJUs8kcYWEhHoN1+Y/2gmsvhB2kqiFN3hP6r6r
 7EeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH2ZmHP3xpnZ0ZXE/bwdj+kwptO5qfbC6nYWC2wbpdWBz4HPi4Yxl+2Y/+3bIH+f8WlR1KXqs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4IgYo6SzP39PDDw/VIboJAJ1wwqdf/gMK9kH4DjJ8DflOjPuO
 laisAjDmmSRoUE3QlNuvnRlAJQQwL/nxGjUyfbTgXPPq5OJzF10g84GnvKAWo/4Zp3+GeSW0Vp3
 V5ArYjFif/YOMVlvHWbzESJeD3frE/mHt7uIuy2B32w==
X-Gm-Gg: ASbGncsJToJKFo49o3uSp4iLIsofvosJ6n6jk3K9sfxIJVgPlG4HyJ5tU+j0KT84VS2
 Js/0Th81rtqvZzNxpknfbL8J8f8n/6qXA11RXcxanhUQP3fEXwkM0BAbYlk5+aLGaWykXk2bguT
 Pci8E8LZsD0dcEuYgD8zKCYSIxsKJDAseG/oNp7dZZufW/Z0QAtPk0oA==
X-Google-Smtp-Source: AGHT+IFkvzDgIjV+NVPYw660QVfBCKqsFgh1X29alCT5lhwv1uEXT2ynqbkf0cVELGC9vbVdTjUySV3PVbGKKQDke4s=
X-Received: by 2002:a05:690c:685:b0:712:c5f7:1eef with SMTP id
 00721157ae682-717c149bfe7mr56594937b3.3.1752157690126; Thu, 10 Jul 2025
 07:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 10 Jul 2025 17:27:34 +0300
X-Gm-Features: Ac12FXx5wd6wcYrHojLAkFC4Z0UoLKYERbu7ivy4twl4nBQKEKh94dfVGBrhcOg
Message-ID: <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
To: Fabio Estevam <festevam@gmail.com>
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

Hi Fabio


On Thu, 10 Jul 2025 at 17:16, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Ilias,
>
> On Fri, Jun 27, 2025 at 3:57=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Our last sync with the kernel was 5.1. Even that was a partial one
> > as some patches from 4.x kernels were already missing making the
> > transition to a modern kbuild infeasible.
> >
> > We are so out of sync now, that tracking the patches and backporting
> > them one by one makes little sense and it's going to take ages.
> >
> > This is an attempt to sync up Makefile[.lib/.kbuild].
> > Unfortunately due to sheer amount of patches this is not easy to review=
,
> > but that's what we decided during a community call.
> >
> > One of the biggest changes is get rid of partial linking entirely and
> > build .a archives isntead of .o.
> > We diaviate from the kernel on that. Instead of calling a custom script
> > to create the archive symbol table, we call ar with rcTP (isntead of
> > rcSTP) since we want a resulting archive that's sauble with the linker.
> >
> > The only affected platforms are PPC ones. Unfortunately I don't have an=
y
> > of them around to test, but the objdump of the resulting files --
> > arch/powerpc/lib/built-in.[oa] looks identical.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> This commit breaks the mx6sabresd_defconfig build on my Ubuntu 2022.04 ma=
chine:
>
> $ make mx6sabresd_defconfig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   YACC    scripts/kconfig/zconf.tab.c
>   LEX     scripts/kconfig/zconf.lex.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> #
> # configuration written to .config
> #
> $ make
> scripts/kconfig/conf  --syncconfig Kconfig
>   UPD     include/config.h
>   CFG     u-boot.cfg
>   GEN     include/autoconf.mk
>   GEN     include/autoconf.mk.dep
>   CFG     spl/u-boot.cfg
>   GEN     spl/include/autoconf.mk
> make: *** arch/arm/mach-imx/: Is a directory.  Stop.

Thanks I'll try to reproduce it later today and let you know. Do you
know if we build this defonconfig in the CI?

Thanks
/Ilias
