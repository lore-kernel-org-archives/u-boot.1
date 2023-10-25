Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32910C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 18:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0AE87A02;
	Wed, 25 Oct 2023 20:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="YFbtGGJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCA687240; Wed, 25 Oct 2023 20:23:49 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB807879E0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 20:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9be7e3fa1daso11701266b.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698258223; x=1698863023; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6aeQilhAX5unkLqiN4I2bOnUN4QqeK696Zsr8e3lgyo=;
 b=YFbtGGJMkciLYOooz5O2Ja7edDxqrW4kN9NjHGIYeCUBRHO5IyQ8EzhGYaQCq60Hpz
 /+4DBCAxOzFjN3NGE2DowAqlvC7CmYFDkeob2VkhaaYWmYr5jq8/lRvOjzYebcVw5r+W
 RCpioHGChHTNMubVTKLy96XXGqXTpAxH1JxCA/gW5N/rNrFwUFlMTGsPGgeXrz8CoZiD
 v38pKz68hYwgIKFTAaMaPCdI+Tz2QEdcJyOEStzYQoU5Gqsi7w01v8abzZuRDDCESXyY
 5uwCw2lVJrPtcfv0fd6qNvbC2j+STEPMgxRop2CA+M+Fs2wbmuXe5APAw1Uaiud9fTxD
 UAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698258223; x=1698863023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6aeQilhAX5unkLqiN4I2bOnUN4QqeK696Zsr8e3lgyo=;
 b=Wp47v7hqelBJeg8wod0Lxx3qmazy/DlNYdOtp/FirqBBAWYH5RzWnyFtuLlWVsA55L
 x8ZGxIEbKzN0jEz98DM0FvXG3wrnSfGXaRcLdjADkccZM5j1sJc2OeMuw3mL+pAO5c+c
 aGMQ2CiivJbWf8eO7QStKgCQiOrozDylOWDOcx7WW0L13HOrTih0a/gEig9aI4+JJWn1
 qpqy1l77XZQRR/2FaUVIUzPyixyoHjLiA3OY+BkxBtP5hypw8sNSHjV6Xzgeg9061RFc
 LeHDXcmKSicDwLZmMPtdbexOrfzvTh4pfE9L6I2ZPsltbpnm0uN6NifgmYU8oNWijJIx
 qwbw==
X-Gm-Message-State: AOJu0YyYUYRJMtRUIs6Ii9i/45fZ0YFtMzz6qTuNHbMDOYEwUePLrF02
 GGwCy+YdSPWPMb5GkiYjoSDRJ/dNI/6wnoYHUoGcBA==
X-Google-Smtp-Source: AGHT+IE87krh5c5qH02CW2TYJ7aTP0P7jtKSj8eHVDANMSq2fmIol04/tFXii6ryrlmiF9iTsM4hsH6bkFLqg/h8L+o=
X-Received: by 2002:a17:907:9623:b0:9ae:6da8:1819 with SMTP id
 gb35-20020a170907962300b009ae6da81819mr11652571ejc.48.1698258223112; Wed, 25
 Oct 2023 11:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ07zojtkV6ReQiC3XPf_AW96YnAc6APqhfk7wUDMmyOrA@mail.gmail.com>
In-Reply-To: <CAPnjgZ07zojtkV6ReQiC3XPf_AW96YnAc6APqhfk7wUDMmyOrA@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 25 Oct 2023 18:23:24 +0000
Message-ID: <CAPnjgZ3zFnAaivWa1BaUDbTfzRc-SZ_H8+YSvAKtwBJ64=XftQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google.com> wrote:
>
> Hi Heinrich,
>
> On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > Forward and backward compatibility of Linux kernel device-trees is
> > sometimes missing. One solution approach is to load a kernel specific
> > device-tree. This can either be done via a U-Boot scripts (like the one
> > generated by Debian package flash-kernel or by a boot loader like GRUB.
> > The boot loader approach currently requires to know the device-tree name
> > before first boot which makes it unusable for generic images.
> >
> > Expose the device-tree file name as EFI variable FdtFile.
> > This will allow bootloaders to load a kernel specific device-tree.
>
> kernel-specific
>
> >
> > The variable will not be exposed on ACPI based systems or if the
> > environment variable fdtfile is not defined.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v4:
> >         Generalize the description of the content of $fdtfile.
> > v3:
> >         Add documentation
> > v2:
> >         Use a unique GUID to enable future U-Boot independent
> >         standardization.
> >         Do not try to add the variable on ACPI based systems.
> > ---
> >  doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
> >  include/efi_loader.h       |  5 +++++
> >  lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> >  3 files changed, 49 insertions(+)
> >
> > diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > index fb16ac743a..702c490831 100644
> > --- a/doc/develop/uefi/uefi.rst
> > +++ b/doc/develop/uefi/uefi.rst
> > @@ -916,6 +916,20 @@ So our final format of the FilePathList[] is::
> >
> >      Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
> >
> > +EFI variable FdtFile
> > +~~~~~~~~~~~~~~~~~~~~
> > +
> > +Ideally U-Boot would always expose a device-tree that can be used for booting
> > +any operating systems. Unfortunately operating systems like Linux sometimes
> > +break forward and backward compatibility. In this case there is a need to load
> > +an operating system version specific device-tree.
>
> This seems to be a strong statement. Given the effort that goes into
> the DT, changes are supposed to be backwards-compatible. Is this
> generally true, or is it just that we want an up-to-date DT for the
> kernel to enable new features?

Did you see this comment?

Regards,
Simon

>
> > +
> > +U-Boot has an environment variable fdtfile identifying the device-tree file to
> > +load. The content of this variable is exposed as EFI variable Fdtfile, vendor
> > +GUID d45dde69-3bd6-40e0-90d5-6b606aa57730. It contains the device-tree path
> > +name as a NUL terminated ASCII string. On many architectures the file name is
>
> NUL-terminated
>
> > +preceded by a vendor directory ('vendor-directory/board-name.dtb').
> > +
> >  Links
> >  -----
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index e24410505f..146e7f1bce 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -152,6 +152,11 @@ static inline efi_status_t efi_launch_capsules(void)
> >         EFI_GUID(0x8108ac4e, 0x9f11, 0x4d59, \
> >                  0x85, 0x0e, 0xe2, 0x1a, 0x52, 0x2c, 0x59, 0xb2)
> >
> > +/* Vendor GUID for the FdtFile variable */
> > +#define VENDOR_FDTFILE_GUID \
> > +       EFI_GUID(0xd45dde69, 0x3bd6, 0x40e0, \
> > +                0x90, 0xd5, 0x6b, 0x60, 0x6a, 0xa5, 0x77, 0x30)
> > +
> >  /* Use internal device tree when starting UEFI application */
> >  #define EFI_FDT_USE_INTERNAL NULL
> >
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index e6de685e87..71bcde645b 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -17,6 +17,8 @@
> >
> >  efi_status_t efi_obj_list_initialized = OBJ_LIST_NOT_INITIALIZED;
> >
> > +efi_guid_t vendor_fdtfile_guid = VENDOR_FDTFILE_GUID;
> > +
> >  /*
> >   * Allow unaligned memory access.
> >   *
> > @@ -26,6 +28,27 @@ void __weak allow_unaligned(void)
> >  {
> >  }
> >
> > +/**
> > + * efi_init_fdtfile() - set EFI variable FdtFile
> > + *
> > + * Return:     status code
> > + */
> > +static efi_status_t efi_init_fdtfile(void)
> > +{
> > +       char *val;
> > +
> > +       val = env_get("fdtfile");
> > +       if (!val)
> > +               return EFI_SUCCESS;
> > +
> > +       return efi_set_variable_int(u"FdtFile",
> > +                                   &vendor_fdtfile_guid,
> > +                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> > +                                   EFI_VARIABLE_RUNTIME_ACCESS |
> > +                                   EFI_VARIABLE_READ_ONLY,
> > +                                   strlen(val) + 1, val, false);
> > +}
> > +
> >  /**
> >   * efi_init_platform_lang() - define supported languages
> >   *
> > @@ -250,6 +273,13 @@ efi_status_t efi_init_obj_list(void)
> >         if (ret != EFI_SUCCESS)
> >                 goto out;
> >
> > +       /* Define EFI variable FdtFile */
> > +       if (!CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)) {
> > +               ret = efi_init_fdtfile();
> > +               if (ret != EFI_SUCCESS)
> > +                       goto out;
> > +       }
> > +
> >         /* Indicate supported features */
> >         ret = efi_init_os_indications();
> >         if (ret != EFI_SUCCESS)
> > --
> > 2.40.1
> >
>
> Assuming my concerns above are figured out:
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> SImon
