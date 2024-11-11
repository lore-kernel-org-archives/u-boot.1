Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB355D2E9E7
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 13:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7497889340;
	Mon, 11 Nov 2024 14:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pyr3BnEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D38989394; Mon, 11 Nov 2024 14:03:50 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D21C88F41
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 14:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9ec267b879so814363566b.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 05:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731330224; x=1731935024; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMrV4bh7jR3qfEjQjhpWzLpdGIc1MZpmEn3jYFBv5fw=;
 b=Pyr3BnEjv/BL37RmIrwN+sN4s/hw7sFDGmTlm9rYnh/OPJRys1sfJ0tnfKmkuwW3ea
 vLf8RsZIZt22VMxU4ol6E4CFdKZlVHvnSMnnz445xt+CFErRLP5IoGHxTLoxI6TvxiXa
 mqGxfN9ULveLQEfVIPMbDErun0xtuVicDxUmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731330224; x=1731935024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMrV4bh7jR3qfEjQjhpWzLpdGIc1MZpmEn3jYFBv5fw=;
 b=RZo9i95n7rxb49686i7pZVlKJolVHby7SrFp/2AQac5kTnv6BAaZ08wtHvNnJ/Tr74
 vEnQ8rKGdFq0C5NOjMWtboHutXxgpUmqAxjh1BIe+a/BE2FWh4eQyI73xsjeoGpu7XdL
 yGbwp0BEVNakn9VKMm90OffzO4X38hBs16FhG5vS985pBomeoDUqvGv1j4Xu/u9PAi5I
 aa8/gbPaQgiQZs+qovVRq90tSc7AcnKGXc2kcgF0zlaYQ85cedLyDvHELQ4957ZfkAMj
 Vge6ZJT7LnEUMkCHjvOgA6I/IWMdfAa0V40m7byNBHKVTKefd1a88NVvolV5hDOCWqIN
 XJlg==
X-Gm-Message-State: AOJu0YySIzvGCyqYjjzYzRfGyWwRfhchv3qFl+hQuddBsenKMncZGCX3
 CjKjivbtBD2NLd/mZ/Ws9UAzzSmb6GHdZQpLBNeIG+rcENNT+6YpAkqDi8lidRn/FaRbqxYAmVI
 wqh07cLNyt0v+gG9Atd4kdwmeKS/gVGALuNJv
X-Google-Smtp-Source: AGHT+IGG7+SosLhu+XjIN3gcjK9uwdKDx+mIwMxliDf147DmIhA7OeQNbkxAZbz5i/PJCBdE32brod1cH4ar2ZKKmQE=
X-Received: by 2002:a17:907:3f9b:b0:a9a:bbcc:5092 with SMTP id
 a640c23a62f3a-a9eefff14a5mr1271338766b.39.1731330223662; Mon, 11 Nov 2024
 05:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20241107213150.1711962-1-sjg@chromium.org>
 <20241107213150.1711962-7-sjg@chromium.org>
 <d2d6f345-cdd0-4b1c-b91e-60910409eb44@cherry.de>
 <CAFLszTgxEGw-_uAJReLPWDAcKzKzSmCKRqJMWKcb=zC3inZkmg@mail.gmail.com>
 <913dcd1a-4157-420a-b0f0-89d6f99bd5ae@cherry.de>
In-Reply-To: <913dcd1a-4157-420a-b0f0-89d6f99bd5ae@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Nov 2024 06:03:29 -0700
Message-ID: <CAFLszThNfJA88vbMyQJeaPR19Td-8JrKPHRUW7upWLZhEkjeeA@mail.gmail.com>
Subject: Re: [PATCH v10 06/10] sandbox: Report host default-filename in native
 mode
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Quentin,

On Mon, 11 Nov 2024 at 05:55, Quentin Schulz <quentin.schulz@cherry.de> wro=
te:
>
> Hi Simon,
>
> On 11/11/24 1:41 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Mon, 11 Nov 2024 at 03:03, Quentin Schulz <quentin.schulz@cherry.de>=
 wrote:
> >>
> >> Hi Simon,
> >>
> >> On 11/7/24 10:31 PM, Simon Glass wrote:
> >>> When the --native flag is given, pretend to be running the host
> >>> architecture rather than sandbox.
> >>>
> >>> Allow the same control for PXE too.
> >>>
> >>
> >> Commit 7506c1566998 ("sandbox: Report host default-filename in native
> >> mode") breaks building jaguar-rk3588_defconfig, I believe it's this pa=
tch?
> >>
> >> Reverting it makes the build pass again.
> >>
> >> HOST_ARCH is empty in include/generated/version_autogenerated.h for so=
me
> >> reason. Though it was also empty before.
> >>
> >> The error is:
> >>
> >> """
> >> lib/efi_loader/efi_helper.c:26:15: error: operator '=3D=3D' has no lef=
t operand
> >>      26 | #if HOST_ARCH =3D=3D HOST_ARCH_X86_64
> >>         |               ^~
> >> lib/efi_loader/efi_helper.c:29:17: error: operator '=3D=3D' has no lef=
t operand
> >>      29 | #elif HOST_ARCH =3D=3D HOST_ARCH_X86
> >>         |                 ^~
> >> lib/efi_loader/efi_helper.c:32:17: error: operator '=3D=3D' has no lef=
t operand
> >>      32 | #elif HOST_ARCH =3D=3D HOST_ARCH_AARCH64
> >>         |                 ^~
> >> lib/efi_loader/efi_helper.c:35:17: error: operator '=3D=3D' has no lef=
t operand
> >>      35 | #elif HOST_ARCH =3D=3D HOST_ARCH_ARM
> >>         |                 ^~
> >> lib/efi_loader/efi_helper.c:38:17: error: operator '=3D=3D' has no lef=
t operand
> >>      38 | #elif HOST_ARCH =3D=3D HOST_ARCH_RISCV32
> >>         |                 ^~
> >> lib/efi_loader/efi_helper.c:41:17: error: operator '=3D=3D' has no lef=
t operand
> >>      41 | #elif HOST_ARCH =3D=3D HOST_ARCH_RISCV64
> >>         |                 ^~
> >> lib/efi_loader/efi_helper.c:45:2: error: #error Unsupported Host
> >> architecture
> >>      45 | #error Unsupported Host architecture
> >>         |  ^~~~~
> >> lib/efi_loader/efi_helper.c: In function =E2=80=98efi_get_basename=E2=
=80=99:
> >> lib/efi_loader/efi_helper.c:73:38: error: =E2=80=98HOST_BOOTEFI_NAME=
=E2=80=99 undeclared
> >> (first use in this function); did you mean =E2=80=98BOOTEFI_NAME=E2=80=
=99?
> >>      73 |         return efi_use_host_arch() ? HOST_BOOTEFI_NAME :
> >> BOOTEFI_NAME;
> >>         |                                      ^~~~~~~~~~~~~~~~~
> >>         |                                      BOOTEFI_NAME
> >> lib/efi_loader/efi_helper.c:73:38: note: each undeclared identifier is
> >> reported only once for each function it appears in
> >> lib/efi_loader/efi_helper.c: In function =E2=80=98efi_get_pxe_arch=E2=
=80=99:
> >> lib/efi_loader/efi_helper.c:79:24: error: =E2=80=98HOST_PXE_ARCH=E2=80=
=99 undeclared
> >> (first use in this function); did you mean =E2=80=98HOST_ARCH=E2=80=99=
?
> >>      79 |                 return HOST_PXE_ARCH;
> >>         |                        ^~~~~~~~~~~~~
> >>         |                        HOST_ARCH
> >> lib/efi_loader/efi_helper.c: In function =E2=80=98efi_get_basename=E2=
=80=99:
> >> lib/efi_loader/efi_helper.c:74:1: warning: control reaches end of
> >> non-void function [-Wreturn-type]
> >>      74 | }
> >>         | ^
> >> make[2]: *** [scripts/Makefile.build:256: lib/efi_loader/efi_helper.o]
> >> Error 1
> >> make[1]: *** [scripts/Makefile.build:398: lib/efi_loader] Error 2
> >> make: *** [Makefile:1914: lib] Error 2
> >> make: *** Waiting for unfinished jobs....
> >> """
> >>
> >> The build host for me is Fedora 41.
> >
> > Which cross-toolchain are you using? That variable is set at the top
> > of Makefile so it would be worth seeing what MK_ARCH is returning.
> >
>
> Ahah! I had forgotten I use ccache so my CROSS_COMPILE is "ccache
> aarch64-linux-gnu-", without "ccache" in there it works.
>
> I can suggest:
> """
> diff --git a/Makefile b/Makefile
> index 7275a02f24c..2aa115f2097 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -21,7 +21,7 @@ include include/host_arch.h
>   ifeq ("", "$(CROSS_COMPILE)")
>     MK_ARCH=3D"${shell uname -m}"
>   else
> -  MK_ARCH=3D"${shell echo $(CROSS_COMPILE) | sed -n
> 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
> +  MK_ARCH=3D"${shell echo $(CROSS_COMPILE) | sed -n 's/^\(ccache
> \)\?[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
>   endif
>   unexport HOST_ARCH
>   ifeq ("x86_64", $(MK_ARCH))
> """
>
> an opinion on this or do I just send this as a patch and it can be
> discussed on the ML?
>
> This works for me both with and without ccache in CROSS_COMILE.

Yes, please send as a patch, looks OK to me.

I often wonder if we could have tests for the Makefile logic...

Regards,
Simon
