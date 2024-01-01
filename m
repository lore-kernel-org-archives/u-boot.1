Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7C4C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 22:41:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713B48785F;
	Mon,  1 Jan 2024 23:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LqEQJ5JD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C78E87834; Mon,  1 Jan 2024 23:41:43 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E45877EC
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 23:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-680a06cc763so21145116d6.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 14:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704148900; x=1704753700; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wUl0O2E5jS4EXtrU0zrmW6qnXeC+9jDGoUEzwainEo=;
 b=LqEQJ5JDOBJMozELovMU3UWCfLDoMY7qkAA63qgOPQAudQ/iD6ULk3sqePGcjwzEgE
 62uId0qQDpNqZLrkJ/wbZQ/9fLdKWRtzPPBzbYJ5WFbOSvDXLLFkt4QwXO1fzzI7/10u
 9DDo9E7+xTGzgZSTRXUHAuWxu0BhtobqvCz58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704148900; x=1704753700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wUl0O2E5jS4EXtrU0zrmW6qnXeC+9jDGoUEzwainEo=;
 b=WqA/K3buA1s3WS/UCGzbg7bKIIZJm1lpxDMTkyP8Yg6CnDUVYGPOXjAqHHx2ofY0bb
 EKgzfpIuzk9uo8QGzH5eB3vpQMsVyo2OKV/VzKebC9A005emwm1a4ioiFISpVa121myK
 JMpoXAq8zHsXWxxZ/iSQ5N38183e4wbfhXwKJltXJj6eEcazyogUOBRzlBHY+QkYqfb9
 xUyugq4lRzIq+bYUogOnmeITqwQyK7V1WqmZA7I4hLcbstUqm6ggTgEAFHBUziNOhSDo
 +0qyOW7vOVlD+RK+NRlpSIARdTp0pQNIWM9dVcbHTYrBbW322cnxR4SvrQmyfAEJ/D+B
 oXBQ==
X-Gm-Message-State: AOJu0Yz6eJpzYdhn4fbs/pxCv01DnnelbBMXZ4kLt0+MuO8k/Y2X0r03
 04Chjaw2WC8kgj2m/mPx4s3IK7TR7pkhUs3P0NS7Y/gS1ADhpCiFF0NvXqc=
X-Google-Smtp-Source: AGHT+IG4zdCJEx5UYg9TY4bRP2UryQ8/BtHic1y4Ewol+NLzWWzo/M5JzSMZaVxJNpetnmFyp1y64+O5tqOvraIIf6c=
X-Received: by 2002:ad4:4eed:0:b0:67f:74f6:4cd8 with SMTP id
 dv13-20020ad44eed000000b0067f74f64cd8mr28941447qvb.130.1704148899980; Mon, 01
 Jan 2024 14:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20240101185004.268790-1-heinrich.schuchardt@canonical.com>
 <20240101185004.268790-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240101185004.268790-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jan 2024 15:41:29 -0700
Message-ID: <CAFLszTiH6awH9jt514b0Tod-dB0jigYa3vo2gtTRxZHRk2nNkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi_loader: provide tool to dump SMBIOS table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Mon, Jan 1, 2024 at 11:50=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> An EFI binary dmidump.efi is provided that can be used to check the SMBIO=
S
> table for consistency and to dump it as a file.
>
> The tool provides the following commands:
>
> check
>     Check the SMBIOS table for consistency.
>
> exit
>     Leave the tool.
>
> help
>     Show available commands.
>
> save
>     Save the SMBIOS table to a file on the EFI system partition. The file
>     can be further analyzed with the dmidecode command line tool::
>
>         dmidecode --from-dump <filename>
>
> Specifying 'nocolor' as load option data suppresses colored output and
> clearing of the screen.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         fix an incorrect variable usage when checking the result of memcm=
p
> ---
>  lib/efi_loader/Makefile  |   7 +
>  lib/efi_loader/dmidump.c | 595 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 602 insertions(+)
>  create mode 100644 lib/efi_loader/dmidump.c

Does this tool need tests?

Can you please split up do_save() a bit and also move the command loop
into its own function? Otherwise it looks good to me.

>
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 24d33d5409..71880d330e 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -16,6 +16,8 @@ CFLAGS_boothart.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
>  CFLAGS_REMOVE_boothart.o :=3D $(CFLAGS_NON_EFI)
>  CFLAGS_helloworld.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
>  CFLAGS_REMOVE_helloworld.o :=3D $(CFLAGS_NON_EFI)
> +CFLAGS_dmidump.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
> +CFLAGS_REMOVE_dmidump.o :=3D $(CFLAGS_NON_EFI)
>  CFLAGS_dtbdump.o :=3D $(CFLAGS_EFI) -Os -ffreestanding
>  CFLAGS_REMOVE_dtbdump.o :=3D $(CFLAGS_NON_EFI)
>  CFLAGS_initrddump.o :=3D $(CFLAGS_EFI) -Os -ffreestanding

Is there a way to have a list of these tools such that the flags stuff
is done automatically and doesn't need to be repeated each time?

> @@ -31,6 +33,11 @@ always +=3D helloworld.efi
>  targets +=3D helloworld.o
>  endif
>
> +ifneq ($(CONFIG_GENERATE_SMBIOS_TABLE),)
> +always +=3D dmidump.efi
> +targets +=3D dmidump.o

How about smbios_tool ? I think 'dmi' is a bit of an obfuscation.

> +endif
> +
>  ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>  always +=3D dtbdump.efi
>  targets +=3D dtbdump.o

[..]

Regards,
SImon
