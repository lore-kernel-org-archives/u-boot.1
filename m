Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424F7C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 22:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8424087168;
	Mon, 13 Nov 2023 23:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KyNmZSRS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2738F8711E; Mon, 13 Nov 2023 23:08:44 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA168711E
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 23:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9e61e969b1aso518631766b.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 14:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699913321; x=1700518121; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+11BcwJg/fP9mFUJPO0rZx12trVuhU1OUupmI4Hp1UY=;
 b=KyNmZSRSAxW6Bv14RveDXwIrdp/7kI3LhE3jcyPqnv0n70LD3uE910XnN9JcDRzRtm
 058aem1wX4EWQVX22Rwj7O8zbgQPdbDbGK4HK9df11iOR0W5RzsACWfDyKPJ3jCbfC+e
 D02Y0jeq06OK2+qmH4yPXqclO3iyXEVBW1B/t6qw/YwtrqyFItvxnuHAA8QWm4ZvmCyY
 c1xb6iSD7XlEN/O470WeSp+oQyGwESrKZvGGqjfzBEOoNvvhgcHnqkjLqcl5HYDE/TWX
 7PUHXd71jgf2pztb2stIHBfn9xzCWwF9ew3trs1ArRIjLkXWkrwxN0ndyVhNgzJHaezH
 eQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699913321; x=1700518121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+11BcwJg/fP9mFUJPO0rZx12trVuhU1OUupmI4Hp1UY=;
 b=kCacr8DRW+I9vFGOwa5Pf2Lr1j4Wpuw6QueLwJxDcVMTkbDVXOynoTTfWW0UqwZ/B8
 7f9gY21h2bcsw0/vvbfIFciF+mYKuLznA6zWlHJL6GHB/wz3JYvnb3xxQlx5cAzgKodD
 wwdcPI4kaz5FZj7OBx9eiaByfWAIrZ5lgcoOcRG7IZqY/Nx+O08WVCqEWfJUQRZaOEvT
 9M1kGS1JHE3Spd5vPxi4s4/YluhEkJ5Ke/Mrvd91ozEXrxU/9RoHl/NP7LI2bfH5eM0X
 TnHB3QyzowqUIGr/hOKeAzPxSMYxJbQGdF97YlX8HFwOMFVEdfoRbVQNlnrrxwct3Qrr
 iyqg==
X-Gm-Message-State: AOJu0YyIIDQ6yGYogtD2rg1ghfMF9Op5Hm9yijijnsfyvmOv3PTDOZTp
 gX+RAz3RjKoO8ynv3jkIboylykqCyoV7im1pfsQ=
X-Google-Smtp-Source: AGHT+IFu1OlWJrtHz9WISbV6HXyWIR88NQe0mqn5MsUDbPfL58e3dBG+MZDnBoreHdwxLemgmVAW35/s1BY5I7nNq1E=
X-Received: by 2002:a17:906:3950:b0:9e0:4910:164a with SMTP id
 g16-20020a170906395000b009e04910164amr5194329eje.28.1699913320743; Mon, 13
 Nov 2023 14:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-5-sjg@chromium.org>
In-Reply-To: <20231112200255.172351-5-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 14 Nov 2023 06:08:33 +0800
Message-ID: <CAEUhbmVg0m6BJQ_k82Hiqc8AJW1ricfd8WhdKCzAVdj1OOm=Vg@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] x86: Enable SSE in 64-bit mode
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
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

Hi Simon,

On Mon, Nov 13, 2023 at 4:03=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> This is needed to support Truetype fonts. In any case, the compiler
> expects SSE to be available in 64-bit mode. Provide an option to enable
> SSE so that hardware floating-point arithmetic works.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
> Changes in v4:
> - Use a Kconfig option
>
>  arch/x86/Kconfig          |  8 ++++++++
>  arch/x86/config.mk        |  4 ++++
>  arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
>  drivers/video/Kconfig     |  1 +
>  4 files changed, 25 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 99e59d94c606..6b532d712ee8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
>         hex
>         default 0x10000
>
> +config X86_HARDFP
> +       bool "Support hardware floating point"
> +       help
> +         U-Boot generally does not make use of floating point. Where thi=
s is
> +         needed, it can be enabled using this option. This adjusts the
> +         start-up code for 64-bit mode and changes the compiler options =
for
> +         64-bit to enable SSE.

As discussed in another thread, this option should be made global to
all architectures and by default no.

> +
>  config HAVE_ITSS
>         bool "Enable ITSS"
>         help
> diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> index 26ec1af2f0b0..2e3a7119e798 100644
> --- a/arch/x86/config.mk
> +++ b/arch/x86/config.mk
> @@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
>  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
>  else
>  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-common -mar=
ch=3Dcore2 -m64
> +
> +ifndef CONFIG_X86_HARDFP
>  PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
>  endif
>
> +endif # IS_32BIT
> +
>  PLATFORM_RELFLAGS +=3D -fdata-sections -ffunction-sections -fvisibility=
=3Dhidden
>
>  KBUILD_LDFLAGS +=3D -Bsymbolic -Bsymbolic-functions
> diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
> index 2647bff891f8..5ea746ecce4d 100644
> --- a/arch/x86/cpu/x86_64/cpu.c
> +++ b/arch/x86/cpu/x86_64/cpu.c
> @@ -10,6 +10,7 @@
>  #include <init.h>
>  #include <asm/cpu.h>
>  #include <asm/global_data.h>
> +#include <asm/processor-flags.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -39,11 +40,22 @@ int x86_mp_init(void)
>         return 0;
>  }
>
> +/* enable SSE features for hardware floating point */
> +static void setup_sse_features(void)
> +{
> +       asm ("mov %%cr4, %%rax\n" \
> +       "or  %0, %%rax\n" \
> +       "mov %%rax, %%cr4\n" \
> +       : : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
> +}
> +
>  int x86_cpu_reinit_f(void)
>  {
>         /* set the vendor to Intel so that native_calibrate_tsc() works *=
/
>         gd->arch.x86_vendor =3D X86_VENDOR_INTEL;
>         gd->arch.has_mtrr =3D true;
> +       if (IS_ENABLED(CONFIG_X86_HARDFP))
> +               setup_sse_features();
>
>         return 0;
>  }
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 6f319ba0d544..39c82521be16 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -180,6 +180,7 @@ config CONSOLE_ROTATION
>
>  config CONSOLE_TRUETYPE
>         bool "Support a console that uses TrueType fonts"
> +       select X86_HARDFP if X86

This should be "depends on HARDFP", indicating that the TrueType
library is using hardware fp itself, and user has to explicitly turn
the hardware fp Kconfig option on.

"Select" does not work for architectures that does not have the
"enabling hardware fp" logic in place.

>         help
>           TrueTrype fonts can provide outline-drawing capability rather t=
han
>           needing to provide a bitmap for each font and size that is need=
ed.
> --

Regards,
Bin
