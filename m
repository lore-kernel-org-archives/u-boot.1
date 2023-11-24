Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378EFC61D97
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 11:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B63F8711D;
	Fri, 24 Nov 2023 12:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="cVCVEVQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE35874B1; Fri, 24 Nov 2023 12:58:40 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBC887008
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 12:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-548ce39b101so2494780a12.2
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 03:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700827117; x=1701431917;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhC275vTBWOoH4glqj1wkpuTeihajj3Ix6KpfQru+AY=;
 b=cVCVEVQVV8d9haXxM14Wm4JmSc87+c3+qqasmWmtEZecyHrPQC0vRFRNPlTxZ8awb3
 Z4lgLLqeOSePGcPC5jFwP0cF9hbKSgvtgU7fQe+kqxQHuqJMOESap7yrnYyvekUoP94d
 Q3acHoY2ech2JIzXOltLGZAWl5by6EzPhcn/pzxI25eevRQkmxLX0C3KiWEszcWKOsO6
 0OgWJjENE8Tz1uFQzJVjk8Tlzh7dJ/vZGkjh5YTg23NK1AO92ylWwFVojw9uxT1LzP+6
 bLCU5kC3xTE0hpqaTb0qUR7rwNVMW/6iUAAFXY9vmY/8xt0t4FkptqDhw5S8uf9wiECD
 hYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700827117; x=1701431917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xhC275vTBWOoH4glqj1wkpuTeihajj3Ix6KpfQru+AY=;
 b=ncOS7ZYlpcC4olfUvIZ0/liDfrWeSqx4nC6er8hS0FfqGl8P8NIKawRmAAtSNUgSl7
 Kc3YWuMkwiMIpEcoAjhZWlO9yl+oXzmU0NTSAo1iyqX3v8yW/XQC2c4KnZmMx/k5PsEH
 kxbq65JVf4I53ifjDsp7BTAewPvY9YOozcCF/cm7I6+1HRG0LVNWio5bHI7OxegVZa9t
 PEdj4tVEtuEwvPkjvhe/MnvULRvxaNGAAnkOWJ3ZyrG2ILFmdelgu63R6QCCLCojzJPx
 wTWkH3uEN7gv4Y0UHhZi7B9PXk8Grvi83XtgdmIYL5/7n9GEiZ18obTInNgOPWoC7l7G
 4M+w==
X-Gm-Message-State: AOJu0Yxjt6eOjwc8e3aBOnYI/2125OIu9B5kT5UViOHtKVm03DjPV6kR
 aWR59kscvlhZZKrRg7cG6ieG4uHvcbfpCsuZpkL+yw==
X-Google-Smtp-Source: AGHT+IFRtOuV25Ie774edxUPeKi3eMyjxSqsG+Vqlz6YRO4e1I0fnMbg5qclW7yPG4PqHWeOLMzI+A==
X-Received: by 2002:a17:906:2c4d:b0:9bf:b022:dc7 with SMTP id
 f13-20020a1709062c4d00b009bfb0220dc7mr1930448ejh.48.1700827117157; 
 Fri, 24 Nov 2023 03:58:37 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com.
 [209.85.218.53]) by smtp.gmail.com with ESMTPSA id
 hk15-20020a170906c9cf00b009fef7d22c98sm1981869ejb.35.2023.11.24.03.58.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:58:36 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-a049d19b63bso256475066b.2
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 03:58:36 -0800 (PST)
X-Received: by 2002:a17:907:b00e:b0:a01:8ef2:844 with SMTP id
 fu14-20020a170907b00e00b00a018ef20844mr1640517ejc.11.1700827115783; Fri, 24
 Nov 2023 03:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20231121235713.1530289-1-i@shantur.com>
 <20231121235713.1530289-3-i@shantur.com>
 <CAC_iWjKxyRWd+bf==mO0tLQEG843J631xNQRo0_ueGXpdNCokg@mail.gmail.com>
In-Reply-To: <CAC_iWjKxyRWd+bf==mO0tLQEG843J631xNQRo0_ueGXpdNCokg@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 24 Nov 2023 11:58:24 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3bfArFaiWGg_1EdnkhUeaLXc75SRo7TB8LfjGr1AzFJw@mail.gmail.com>
Message-ID: <CAHc5_t3bfArFaiWGg_1EdnkhUeaLXc75SRo7TB8LfjGr1AzFJw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] efi_vars: Implement SPI Flash store
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, takahiro.akashi@linaro.org
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Ilias and Akashi,

On Wed, Nov 22, 2023 at 6:58=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Shahtur
>
> On Wed, 22 Nov 2023 at 01:58, Shantur Rathore <i@shantur.com> wrote:
> >
> > Currently U-boot uses ESP as storage for EFI variables.
> > Devices with SPI Flash are used for storing environment with this
> > commit we allow EFI variables to be stored on SPI Flash.
> >
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> > ---
> >
> >  include/efi_variable.h        | 25 ++++++++++
> >  lib/efi_loader/Kconfig        | 18 +++++++
> >  lib/efi_loader/Makefile       |  1 +
> >  lib/efi_loader/efi_var_sf.c   | 91 +++++++++++++++++++++++++++++++++++
> >  lib/efi_loader/efi_variable.c |  4 ++
> >  5 files changed, 139 insertions(+)
> >  create mode 100644 lib/efi_loader/efi_var_sf.c
> >
> > diff --git a/include/efi_variable.h b/include/efi_variable.h
> > index ca7e19d514..766dd109f5 100644
> > --- a/include/efi_variable.h
> > +++ b/include/efi_variable.h
> > @@ -188,6 +188,31 @@ efi_status_t efi_var_from_file(void);
> >
> >  #endif // CONFIG_EFI_VARIABLE_FILE_STORE
> >
> > +#ifdef CONFIG_EFI_VARIABLE_SF_STORE
> > +
> > +/**
> > + * efi_var_from_sf() - read variables from SPI Flash
> > + *
> > + * EFI variable buffer is read from SPI Flash at offset defined with
> > + * CONFIG_EFI_VARIABLE_SF_OFFSET of length CONFIG_EFI_VAR_BUF_SIZE
> > + *
> > + *
> > + * Return:     status code
> > + */
> > +efi_status_t efi_var_from_sf(void);
> > +
> > +/**
> > + * efi_var_to_sf() - save non-volatile variables to SPI Flash
> > + *
> > + * EFI variable buffer is saved to SPI Flash at offset defined with
> > + * CONFIG_EFI_VARIABLE_SF_OFFSET of length CONFIG_EFI_VAR_BUF_SIZE.
> > + *
> > + * Return:     status code
> > + */
> > +efi_status_t efi_var_to_sf(void);
> > +
> > +#endif // CONFIG_EFI_VARIABLE_SF_STORE
> > +
> >  /**
> >   * efi_var_mem_init() - set-up variable list
> >   *
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 4ccd26f94a..1fcc6fabb4 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -54,6 +54,17 @@ config EFI_VARIABLE_FILE_STORE
> >           Select this option if you want non-volatile UEFI variables to=
 be
> >           stored as file /ubootefi.var on the EFI system partition.
> >
> > +config EFI_VARIABLE_SF_STORE
> > +       bool "Store non-volatile UEFI variables in SPI Flash"
> > +       depends on SPI_FLASH
> > +       help
> > +         Select this option if you want non-volatile UEFI variables to=
 be
> > +         stored in SPI Flash.
> > +         Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash t=
o use as
> > +         the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines th=
e space
> > +         needed.
> > +
> > +
> >  config EFI_MM_COMM_TEE
> >         bool "UEFI variables storage service via the trusted world"
> >         depends on OPTEE
> > @@ -108,6 +119,13 @@ config EFI_VARIABLE_NO_STORE
> >
> >  endchoice
> >
> > +config EFI_VARIABLE_SF_OFFSET
> > +       hex "EFI variables in SPI flash offset"
> > +       depends on EFI_VARIABLE_SF_STORE
> > +       default 0x7D0000
> > +       help
> > +         Offset from the start of the SPI Flash where EFI variables wi=
ll be stored.
> > +
> >  config EFI_VARIABLES_PRESEED
> >         bool "Initial values for UEFI variables"
> >         depends on !EFI_MM_COMM_TEE
> > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > index 8d31fc61c6..b9b715b1ff 100644
> > --- a/lib/efi_loader/Makefile
> > +++ b/lib/efi_loader/Makefile
> > @@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) +=3D ef=
i_unicode_collation.o
> >  obj-y +=3D efi_var_common.o
> >  obj-y +=3D efi_var_mem.o
> >  obj-y +=3D efi_var_file.o
> > +obj-$(CONFIG_EFI_VARIABLE_SF_STORE) +=3D efi_var_sf.o
> >  ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
> >  obj-y +=3D efi_variable_tee.o
> >  else
> > diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
> > new file mode 100644
> > index 0000000000..e604a2225c
> > --- /dev/null
> > +++ b/lib/efi_loader/efi_var_sf.c
> > @@ -0,0 +1,91 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * File interface for UEFI variables
> > + *
> > + * Copyright (c) 2023, Shantur Rtahore
>
> Name is misspelled
>

Fixed, thanks. I shouldn't be sending patches 2 minutes before midnight

> > + */
> > +
> > +#define LOG_CATEGORY LOGC_EFI
> > +
> > +#include <efi_loader.h>
> > +#include <efi_variable.h>
> > +#include <spi_flash.h>
> > +#include <dm.h>
> > +
> > +efi_status_t efi_var_to_sf(void)
> > +{
> > +       efi_status_t ret;
> > +       struct efi_var_file *buf;
> > +       loff_t len;
> > +       struct udevice *sfdev;
> > +
> > +       ret =3D efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
> > +       if (len > EFI_VAR_BUF_SIZE) {
> > +               log_err("EFI var buffer length more than target SF size=
");
> > +               ret =3D EFI_BAD_BUFFER_SIZE;
>
> The UEFI spec doesn't define this return code for SetVariable.
> Instead, EFI_OUT_OF_RESOURCES is used when the available storage isn't
> enough to hold the variable and its data.
>
> > +               goto error;
> > +       }
> > +
> > +       debug("%s - Got buffer to write buf->len : %d\n", __func__, buf=
->length);
> > +
> > +       if (ret !=3D EFI_SUCCESS)
> > +               goto error;
> > +
> > +       ret =3D uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
>
> This is a bit weird. Do we always want to use the first available SPI
> on the system to store the variables?
> I don't remember if the driver model has a mechanism to define one of
> the SPI flashes, but if it doesn't perhaps we should use a Kconfig for
> it?

Taken care of in V2. Thanks.

>
> > +       if (ret)
> > +               goto error;
> > +
> > +       ret =3D spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET=
, EFI_VAR_BUF_SIZE);
> > +       debug("%s - Erased SPI Flash offset %lx\n", __func__, CONFIG_EF=
I_VARIABLE_SF_OFFSET);
> > +       if (ret)
> > +               goto error;
> > +
> > +       ret =3D spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET=
, len, buf);
> > +       debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
> > +
> > +       if (ret)
> > +               goto error;
> > +
> > +       ret =3D EFI_SUCCESS;
> > +error:
> > +       if (ret)
> > +               log_err("Failed to persist EFI variables in SF\n");
> > +       free(buf);
> > +       return ret;
> > +}
> > +
> > +efi_status_t efi_var_from_sf(void)
> > +{
> > +       struct efi_var_file *buf;
> > +       efi_status_t ret;
> > +       struct udevice *sfdev;
> > +
> > +       buf =3D calloc(1, EFI_VAR_BUF_SIZE);
> > +       if (!buf) {
> > +               log_err("Out of memory\n");
> > +               return EFI_OUT_OF_RESOURCES;
> > +       }
>
> You don't want normal memory for the variables.  Instead, you want EFI
> memory which is marked for EFI runtime services data. U-Boot already
> has code to support Get/GetNextvariableRT, you just need to use
> efi_var_mem_init().
> If you need hints have a look at lib/efi_loader/efi_variable_tee.c
> which implements variables stored in an RPMB, but still uses the
> memory backend for runtime services.
>

I believe EFI Runtime stuff is handled by efi_variable.c functions.
This code is run while we are still in U-boot to initialise the memory back=
ed.
As of now, we don't have the SetVariableRT so I guess this won't be a probl=
em.
I took the code from efi_var_file.c and just replaced file storage
with SPI Flash.

I will have to look deeper once I get to implement SetVariableRT which will
be a separate patch series once I get this in.

I have submitted V2 of the patch, can you kindly review them.

Kind regards,
Shantur
