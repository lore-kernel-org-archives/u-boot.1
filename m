Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23199C48BF9
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 967A2870D2;
	Wed, 15 Nov 2023 14:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XifvvK/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC8A871DF; Wed, 15 Nov 2023 14:41:17 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A051686FBB
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9d216597f64so1025764466b.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700055675; x=1700660475; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OKznDgL85ESQEQd1SNRQVpGfPibWaLlTDg7PfcnO63Q=;
 b=XifvvK/LlusXpJVvGXaaTnzoU2fxShAvgWeXiGE1oH0qil4ZVR00XwV33r+56e6spg
 GBa2OGlF7YQNZ5fTCYSMrSRcsBDyh7F1bhXqLURtvxDyfv0mAdYbbVINeq74QxJ1r35C
 NWfIQtetYGNnyCGrpE0AGCgcmSNs2yIoTPPD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700055675; x=1700660475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OKznDgL85ESQEQd1SNRQVpGfPibWaLlTDg7PfcnO63Q=;
 b=ZZHvNbCqo2fqjwGKb5rBRdtHtzBYcA76Em05ZuJyF2h2cmVXx/kmkrllHDX5Qtviio
 kdyfOCUMCkLwaRhDEBZ6tuiqfK4XPCTB58fbl31vJkNdL3NU2UXsrXchLUfPomjWF/JG
 VHnbC/52TxYYN3wB9ra+QCIOGz7fSCg2K5VKI9nrfjMHP9uxVaAJo0uxNTeBci0/ggw6
 4tSNPgmHMZyyjbK9MaFri4qem2n8M1aCJ1304oC/U2H021OJO3JFa50MrrOONllvhWN9
 RV8rsbuBR/wzGBKAj5gtf+ntAv8eKDRyRj4ziOY7G094L5odQrJQ/q7WUAPgWLW7oKGN
 0cWA==
X-Gm-Message-State: AOJu0Yx4R1pLiEMohCbT47eUQzBD/oDCGpmm43H7DlXAAnnTN0ZaoI3T
 w1ZHOLUv12nB9elZscMb+Vaf9mbZt/J7AqBz513Tcw==
X-Google-Smtp-Source: AGHT+IEeT9YGQj/kR+0UXI0YpHvBUd1mjimOswPqX/JBasTyyKFupU/kbRk3dxPWEg3HzGwWgxpIjbH+yp9gCCVL02w=
X-Received: by 2002:a17:906:cb95:b0:9c7:5186:de1a with SMTP id
 mf21-20020a170906cb9500b009c75186de1amr10440024ejb.8.1700055674978; Wed, 15
 Nov 2023 05:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20230920030027.1385833-1-sjg@chromium.org>
 <20230920030027.1385833-12-sjg@chromium.org>
 <d643e467-cd35-4b15-907d-a8e79a2e4bda@gmx.de>
In-Reply-To: <d643e467-cd35-4b15-907d-a8e79a2e4bda@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 06:41:00 -0700
Message-ID: <CAPnjgZ2yoa-Ddtpaxhnj9rWvTewVjzxD4G33qk4pehdPooAyvg@mail.gmail.com>
Subject: Re: [PATCH v5 11/20] efi: x86: Correct the condition for installing
 ACPI tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 15 Nov 2023 at 04:09, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/20/23 05:00, Simon Glass wrote:
> > It is not always the case that U-Boot builds the ACPI tables itself. For
> > example, when booting from coreboot, the ACPI tables are built by
> > coreboot.
> >
> > Correct the Makefile condition so that U-Boot can pass on tables built
> > by a previous firmware stage.
> >
> > Tidy up the installation-condition code while we are here.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Add new patch
> >
> >   lib/efi_loader/Makefile    |  2 +-
> >   lib/efi_loader/efi_setup.c | 10 +++++-----
> >   2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > index 1a8c8d7cab5c..0eb748ff1a59 100644
> > --- a/lib/efi_loader/Makefile
> > +++ b/lib/efi_loader/Makefile
> > @@ -78,7 +78,7 @@ obj-$(CONFIG_EFI_ESRT) += efi_esrt.o
> >   obj-$(CONFIG_VIDEO) += efi_gop.o
> >   obj-$(CONFIG_BLK) += efi_disk.o
> >   obj-$(CONFIG_NETDEVICES) += efi_net.o
> > -obj-$(CONFIG_GENERATE_ACPI_TABLE) += efi_acpi.o
> > +obj-$(CONFIG_ACPI) += efi_acpi.o
>
> This change merged as
> 53e8e6f98679 ("efi: x86: Correct the condition for installing ACPI tables")
> looks wrong:
>
> For QEMU with CONFIG_ACPI=y and CONFIG_GENERATE_ACPI=n I get
>
>      EFI using ACPI tables at 0
>      Error: Cannot initialize UEFI sub-system, r = 14
>
> Device-trees are only suppressed in the bootefi command if
> CONFIG_GENERATE_ACPI=y.
>
> Currently CONFIG_ACPI=y only indicates that ACPI libraries are built. It
> does not indicate that ACPI tables exist on the platform.

Similarly, neither does GENERATE_ACPI

Perhaps we should also check for tables being present?

 if (IS_ENABLED(CONFIG_ACPI) && gd_acpi_start()) {

?

>
> Best regards
>
> Heinrich
>
>
> >   obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += efi_smbios.o
> >   obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
> >   obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_tcg2.o
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index 58d4e1340233..ad719afd6328 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -321,11 +321,11 @@ efi_status_t efi_init_obj_list(void)
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> >   #endif
> > -#ifdef CONFIG_GENERATE_ACPI_TABLE
> > -     ret = efi_acpi_register();
> > -     if (ret != EFI_SUCCESS)
> > -             goto out;
> > -#endif
> > +     if (IS_ENABLED(CONFIG_ACPI)) {
> > +             ret = efi_acpi_register();
> > +             if (ret != EFI_SUCCESS)
> > +                     goto out;
> > +     }
> >   #ifdef CONFIG_GENERATE_SMBIOS_TABLE
> >       ret = efi_smbios_register();
> >       if (ret != EFI_SUCCESS)
>

Regards,
Simon
