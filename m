Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15829D2E9E3
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79DC28935B;
	Mon, 11 Nov 2024 13:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k3Yp0VQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 836AD8936B; Mon, 11 Nov 2024 13:41:41 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F0EF89357
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so948337066b.0
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 04:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731328899; x=1731933699; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTJL7L+bVSOvN3CJlBGC9+Vt7G3Gav/rxizVXC700wA=;
 b=k3Yp0VQepKiUtUPcgpsnagD6j0gnuHrE3LLhWMH1znnKLhMlHulorfEpfTEKwiBF5E
 R7/va6hDgggyZKpCOsYVvw7gZuvGmmRWNPPJ/oJznN6ZiPNn2XC6xGu087L4SoNLeW0U
 Mkh+H9oqXCP6so4IB3jfUjoKquAx7tixB5mZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731328899; x=1731933699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTJL7L+bVSOvN3CJlBGC9+Vt7G3Gav/rxizVXC700wA=;
 b=eb6KSPwXKlQUI0VG7vQrnRCkLMbqgI7xVMm0jEamlSjNlbhw955hQHbWdh7nvUiXW6
 qJyGZfxWsUnvlPuLPqWYTV1U0JsF/+A4iTiHCZeZ2I2WX75kknD8uoJXziK9zH3pBeCY
 p4yHq+Y7VVWujx2aFFaUg3vnuZ00pxVDApW8/eChMWwWXUZ5PQ2AjLoz/yi9lSwvgdYm
 st/FvnCbWStms/NdOr1eipvN7CJuxPe5wAreV4TdK5FpuE18uAvsRqV8bpX4ziIuVFnQ
 3MxAubbeov3kl/alC2za8rRMZMJoYhdiYTXgqZSTRUTnHv9rlGIttz4zhTFBhFDe0nGY
 F6nA==
X-Gm-Message-State: AOJu0YxbGIfWRgtqI/KsG2AL8G/2XpKmG6sHcZMmvNZkQhj9rZqnlXZv
 78rWidNe/nrmNVWsMl30ddkYlOfaOZysqWv2Z7kU8rsV4GsB5INOHO+TTUBtrciQcU4LT+yn3vY
 5a79QbWuglheiuC1td5MNHnxPfdJHoniS4zES
X-Google-Smtp-Source: AGHT+IEoHv1Wtr8lm/jq5tN4U+Tc2bH8k3qC8JoTRY+ynK7kitx14Vm+do45b1P/SYWSUp02S9UgutC/k2ircmWTX+4=
X-Received: by 2002:a17:907:7b89:b0:a9a:5b84:ac81 with SMTP id
 a640c23a62f3a-a9eeffe9032mr801707666b.31.1731328898669; Mon, 11 Nov 2024
 04:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20241107213150.1711962-1-sjg@chromium.org>
 <20241107213150.1711962-7-sjg@chromium.org>
 <d2d6f345-cdd0-4b1c-b91e-60910409eb44@cherry.de>
In-Reply-To: <d2d6f345-cdd0-4b1c-b91e-60910409eb44@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Nov 2024 05:41:27 -0700
Message-ID: <CAFLszTgxEGw-_uAJReLPWDAcKzKzSmCKRqJMWKcb=zC3inZkmg@mail.gmail.com>
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

On Mon, 11 Nov 2024 at 03:03, Quentin Schulz <quentin.schulz@cherry.de> wro=
te:
>
> Hi Simon,
>
> On 11/7/24 10:31 PM, Simon Glass wrote:
> > When the --native flag is given, pretend to be running the host
> > architecture rather than sandbox.
> >
> > Allow the same control for PXE too.
> >
>
> Commit 7506c1566998 ("sandbox: Report host default-filename in native
> mode") breaks building jaguar-rk3588_defconfig, I believe it's this patch=
?
>
> Reverting it makes the build pass again.
>
> HOST_ARCH is empty in include/generated/version_autogenerated.h for some
> reason. Though it was also empty before.
>
> The error is:
>
> """
> lib/efi_loader/efi_helper.c:26:15: error: operator '=3D=3D' has no left o=
perand
>     26 | #if HOST_ARCH =3D=3D HOST_ARCH_X86_64
>        |               ^~
> lib/efi_loader/efi_helper.c:29:17: error: operator '=3D=3D' has no left o=
perand
>     29 | #elif HOST_ARCH =3D=3D HOST_ARCH_X86
>        |                 ^~
> lib/efi_loader/efi_helper.c:32:17: error: operator '=3D=3D' has no left o=
perand
>     32 | #elif HOST_ARCH =3D=3D HOST_ARCH_AARCH64
>        |                 ^~
> lib/efi_loader/efi_helper.c:35:17: error: operator '=3D=3D' has no left o=
perand
>     35 | #elif HOST_ARCH =3D=3D HOST_ARCH_ARM
>        |                 ^~
> lib/efi_loader/efi_helper.c:38:17: error: operator '=3D=3D' has no left o=
perand
>     38 | #elif HOST_ARCH =3D=3D HOST_ARCH_RISCV32
>        |                 ^~
> lib/efi_loader/efi_helper.c:41:17: error: operator '=3D=3D' has no left o=
perand
>     41 | #elif HOST_ARCH =3D=3D HOST_ARCH_RISCV64
>        |                 ^~
> lib/efi_loader/efi_helper.c:45:2: error: #error Unsupported Host
> architecture
>     45 | #error Unsupported Host architecture
>        |  ^~~~~
> lib/efi_loader/efi_helper.c: In function =E2=80=98efi_get_basename=E2=80=
=99:
> lib/efi_loader/efi_helper.c:73:38: error: =E2=80=98HOST_BOOTEFI_NAME=E2=
=80=99 undeclared
> (first use in this function); did you mean =E2=80=98BOOTEFI_NAME=E2=80=99=
?
>     73 |         return efi_use_host_arch() ? HOST_BOOTEFI_NAME :
> BOOTEFI_NAME;
>        |                                      ^~~~~~~~~~~~~~~~~
>        |                                      BOOTEFI_NAME
> lib/efi_loader/efi_helper.c:73:38: note: each undeclared identifier is
> reported only once for each function it appears in
> lib/efi_loader/efi_helper.c: In function =E2=80=98efi_get_pxe_arch=E2=80=
=99:
> lib/efi_loader/efi_helper.c:79:24: error: =E2=80=98HOST_PXE_ARCH=E2=80=99=
 undeclared
> (first use in this function); did you mean =E2=80=98HOST_ARCH=E2=80=99?
>     79 |                 return HOST_PXE_ARCH;
>        |                        ^~~~~~~~~~~~~
>        |                        HOST_ARCH
> lib/efi_loader/efi_helper.c: In function =E2=80=98efi_get_basename=E2=80=
=99:
> lib/efi_loader/efi_helper.c:74:1: warning: control reaches end of
> non-void function [-Wreturn-type]
>     74 | }
>        | ^
> make[2]: *** [scripts/Makefile.build:256: lib/efi_loader/efi_helper.o]
> Error 1
> make[1]: *** [scripts/Makefile.build:398: lib/efi_loader] Error 2
> make: *** [Makefile:1914: lib] Error 2
> make: *** Waiting for unfinished jobs....
> """
>
> The build host for me is Fedora 41.

Which cross-toolchain are you using? That variable is set at the top
of Makefile so it would be worth seeing what MK_ARCH is returning.

Regards,
Simon
