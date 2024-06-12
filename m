Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654CEC27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 08:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CC888527;
	Wed, 12 Jun 2024 10:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gFeV+0qH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 895908859A; Wed, 12 Jun 2024 10:17:27 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29EA5883E8
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 10:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57c75464e77so2488607a12.0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 01:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1718180244; x=1718785044;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzGfcvXht8cMsMNWELrlsvdc7aeI0uvcORlk/LPnIhc=;
 b=gFeV+0qHwsfZ1eV0kuTtQiFZEgmIedRz7Azp/mbkd+KTLkmPYZixH3cmuhW8kZiaj9
 GqULUSEkDc43t74LM+CL5t9I80HPbAlhZwNKttjsWD5teokUddymCLyoYq1Jlx0csyIi
 cD9DDa2i5P+lYXJDxnK1Am90DlkVGgQEGcAU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718180244; x=1718785044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzGfcvXht8cMsMNWELrlsvdc7aeI0uvcORlk/LPnIhc=;
 b=pVHUFGdA+UuOk2twK26znzGAVKJTIGTUWwUBGd8LI+iqOI88Z+tIzDN5yC34m5Hz/7
 BJq3N0Hbro5XAmXvWXl2guW7qTLqwHvJqDQU3fqBeEy1HHEPrE7oroHDulH08iEviOPa
 sBFEBkMF15Jmlo8nfKkOXDRo8OLRVRFFizD6QZTQvaQohOhUGiinQatAsXzFgy786Vbf
 oHn3UzpcgMm0A+XNK60Bx9RV70ApBjlOGdR3fcKGEq7kd3wdPcl08+S0/sA8fKwxvyLd
 L3HxlwVCn+s0SMMbfqtTPIovJ78Y4W0unvy5X3aSEc9PGNxedZpXpFF957dV3i6rFqTi
 bO7g==
X-Gm-Message-State: AOJu0Yy4SzHfj6BPRlVZz6dE7Kzs2CLNmVQk36jKHtsl1NtTL81A/4Oi
 P7qXA6iRT3ELLriG+lpcU9g5bZbcSiJzXavxMzaDck79jBOA4Re95t9Wv6leLDOUSrceDF8Yw61
 yBdV8WELocxNHmFGZnPJvU4F50qkREks3gFkEOw==
X-Google-Smtp-Source: AGHT+IEOPIOqoUR1HTHaBAkl1KgjEZM7JMt/1NBH7u7iRo4SY2v/FFA7cebcj7nfiJMri+RkVXC4zb89w0Gcho9LFE4=
X-Received: by 2002:a17:906:f190:b0:a6f:ea6:9534 with SMTP id
 a640c23a62f3a-a6f47f82720mr71661066b.76.1718180244324; Wed, 12 Jun 2024
 01:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
In-Reply-To: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 12 Jun 2024 10:17:12 +0200
Message-ID: <CAOf5uwkjz0qNkvsWzEQ+kPy66X9Eassq0b1PMDG2r7fYv94_OQ@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Fix include directory for OF_UPSTREAM
To: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 xypron.glpk@gmx.de, marek.vasut+renesas@mailbox.org, sumit.garg@linaro.org, 
 afd@ti.com, bb@ti.com, mr.bossman075@gmail.com, leon@georgemail.eu
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

Hi Tom

On Mon, Jun 3, 2024 at 5:08=E2=80=AFPM Patrick Barsanti
<patrick.barsanti@amarulasolutions.com> wrote:
>
> Always prioritizing u-boot includes causes problems when trying to migrat=
e
> boards to OF_UPSTREAM that have different local devicetree files with
> respect to the upstream ones, if local DT headers are not dropped.
> At the same time if local and upstream files are the same, migrations
> can be, and have been, introduced without dropping local DT headers.
> This also causes problems whenever upstream DTS and DT headers are patche=
d.
>
> For example, now migrating a board based on `imx6ul.dtsi` to OF_UPSTREAM
> breaks it, as there are some missing defines in a local DT header file
> (`imx6ul-clock.h`); the solution would be to drop it, which has not alway=
s
> been done in previous OF_UPSTREAM migration patches for other boards
> because most of the time the two are the same. This solution is also
> vulnerable to ABI breakage, although this has not yet happened since the
> introduction of OF_UPSTREAM support and is unlikely.
>
> Maintainers assure backwards compatibility for DT headers when syncing th=
e
> upstream folder with the kernel.
> The problem is that, at the current state, all boards that have not dropp=
ed
> their local headers when migrating to OF_UPSTREAM will break once the
> upstream devicetrees are patched, for example, to use any newly added
> define which is not present in the local DT header file, even if those
> changes are backwards compatible.
>
> This patch fixes these problems by prioritizing upstream includes when
> `CONFIG_OF_UPSTREAM=3Dy`, while keeping current prioritization when it is
> not.

Do you have some comments here? We would like to move upstream dts for
imx6 boards
too

Michael

>
> Also in case of ABI breakage in the kernel, keeping redundant header file=
s
> (only until strictly necessary, e.g. until all boards including them have
> been migrated to OF_UPSTREAM) together with this selective prioritization
> of the include folder is a solution for keeping not-yet-migrated boards
> from breaking.
>
> Link: https://lore.kernel.org/u-boot/20240528084224.113385-1-patrick.bars=
anti@amarulasolutions.com/
> Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
> Tested-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>
> Changes in v2:
> - Reword and correct the commit message following the discussion
> with Sumit, per Michael's suggestion.
>
>  Makefile | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 79b28c2d81..899ae664ca 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -826,6 +826,19 @@ KBUILD_HOSTCFLAGS +=3D $(if $(CONFIG_TOOLS_DEBUG),-g=
)
>
>  # Use UBOOTINCLUDE when you must reference the include/ directory.
>  # Needed to be compatible with the O=3D option
> +ifeq ($(CONFIG_OF_UPSTREAM),y)
> +UBOOTINCLUDE    :=3D \
> +       -I$(srctree)/dts/upstream/include \
> +       -Iinclude \
> +       $(if $(KBUILD_SRC), -I$(srctree)/include) \
> +       $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
> +               $(if $(CONFIG_HAS_THUMB2), \
> +                       $(if $(CONFIG_CPU_V7M), \
> +                               -I$(srctree)/arch/arm/thumb1/include), \
> +                       -I$(srctree)/arch/arm/thumb1/include)) \
> +       -I$(srctree)/arch/$(ARCH)/include \
> +       -include $(srctree)/include/linux/kconfig.h
> +else
>  UBOOTINCLUDE    :=3D \
>         -Iinclude \
>         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> @@ -837,6 +850,7 @@ UBOOTINCLUDE    :=3D \
>         -I$(srctree)/arch/$(ARCH)/include \
>         -include $(srctree)/include/linux/kconfig.h \
>         -I$(srctree)/dts/upstream/include
> +endif
>
>  NOSTDINC_FLAGS +=3D -nostdinc -isystem $(shell $(CC) -print-file-name=3D=
include)
>
> --
> 2.45.1
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
