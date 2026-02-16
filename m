Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED82E63F25
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 07:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA148063E;
	Mon, 16 Feb 2026 08:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nQVo6hnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C899480B98; Mon, 16 Feb 2026 08:25:25 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07AB580325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 08:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64adabaafd6so2478361d50.0
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 23:25:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771226721; cv=none;
 d=google.com; s=arc-20240605;
 b=WTmxlhgC46sI3Lgd1t86ukkDvy9kyebxAqZfMwFpMOAXC3M5OjFAV+YSlQ90K9cXtd
 oSSijp6RbxqvzaA5SCMP83UQef5O5eGMohUuq0+jsM5CTvBxdQ0OQCSVpJ51j/PgIdkX
 Ak+YwiKkfz7FXXb6b5+K3Ws1FierZiDgGUvMjRfFuWbthqgEjsEiJbY4yBLV2v+Of5V5
 SNVg4OOex13tv94baKBoWzfbqZyWQd2jIkNnEcUGiQLQqr5Lpv/mCfjT0eE2J/31LBBk
 +wJ4sjluBrnUHqFJSPpYpsao2fTvHVnpamLP5FZKldqt6qvNvUPM5CGOg5P+j6+kCETO
 WvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZfxbCY4J6H6jUaPDGpg06UUuFpbEBiru0y0rJmCL7sA=;
 fh=JXKyUqRZ1s306E6zfakd30zkGsWrC/ZiVH0uqMjSU5Y=;
 b=WSBNGz7newR0G/ePgp4TFXOdoDEETIyMGnvBgg7D5ZSJn/ua99a8RW6fmORPPgBgmk
 XNkCM+oenCm+buZqQyk/gGcE1I0RJp6LYFqaUe2TsRDB+J314gCIzOwXaQaYA+Lr7zKK
 IfEv3h3nBN1ZwEXzZQmYHHm8K1DI4fEuPRb31PyyruHFY9OQOpO5EtYldUwveLo/m68t
 2UAq9oK2z6E4VJMgzMyEI8eodpOzu8ivQcl7pPktR6JIbV/giLgbtnGk8R9v89NUkgdc
 rZOBjNrD/J666GlTXpkPAxGLPKtDCmBMFGGLMTNB4bJwxjKZNldpTziqigQ+jjuoC4rq
 32Jw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771226721; x=1771831521; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfxbCY4J6H6jUaPDGpg06UUuFpbEBiru0y0rJmCL7sA=;
 b=nQVo6hnNK0yqxNjj/uqBE9f1X5jicT/1Q8Tcw2hQqpCSIrdfMLJt0le3kF1SclxSpg
 eavutosMPjkK6IezWTAOGhg3FFIthZ9dru9quYk8NU34pvgoGeYnaMwWu/QKB4KJ/ylh
 SSDRWqrs/g7Bu6p3PwAsjA5SeBJTcuuBdXnvSOZYUnFzmpHDw9Zf3uFC3nCieye1u2Zn
 gdwfB/9iiV6/GnDLwvzooXdSCZ795CCulX+4x45ZnnXAQ16bSecuJvj6klmEQNA+wGGp
 Y/+f3zsvRi7Oci5InVv3yi7DCzRYJuXZWdqYqqM4X7n4QYg2hcPKhRi1pDnx7bY0Qmsv
 b+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771226721; x=1771831521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfxbCY4J6H6jUaPDGpg06UUuFpbEBiru0y0rJmCL7sA=;
 b=PEK3j8dkKvP5Yb/Vsnc582yljOTz1b9pVNZZ3OneHuif4lYqm5GDiPXUuoyueg3Jm7
 C7UIJks/wBFPRHrJXWHhRbbapHPHfGrwt0iWGRcUtA41lNxCI77GM4DF93uDN56hLjvz
 t9toYQXkQqKwmbjrpnmVngtKJZ8qGzGHMTjRlBaXTRq9AKqGH7KA23jRQx+Cosrh2jEh
 Yy/WEU/4U/tJFTmAcwfoZGu0EXBasN0y6mSvTWdAlJm1BrnD71h3iaJoW5Iad/fuRgS0
 2c27/Ua2xpXJwm04NCSLIBdlTSMFjzVwbERCnd8wVcYKoItzHcT1YYMTKVEOifslqa5I
 TLNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ5sbtqEFQB3f6PRgwhLvzsx6mTwRCkVuL7LFbyvvyZruy0ZWFTtpRrXQjZJVVoVYO3M4zrZk=@lists.denx.de
X-Gm-Message-State: AOJu0YxWvvkXtI2h/LDIreZ5H9M8zMAf226U68A/FUiVOmgE3nIx8S9e
 8WiXplIGCoyhFCXWspLjf3AmJUYzT/Q0h06B6EJpvY7oGm8+WUCQQ4yn75jf9aPfhqhIRlsH4/P
 vIgD5grO2AV+VM6o7J3kxsLccESTldzi7j2B3eya6yg==
X-Gm-Gg: AZuq6aIXTF+RYUXhfZdVgqlw77CAST/vUv8R0ce3h3UUC5VzdKSgrdrJOOY+AvzPOZ5
 v3bL14iRql5IBSBsauNjK1mxd8CVrFHMpxKQjAsJvbrRz7j/JNccf9GNid+T7xuNslyXS/hetkU
 pkNYrAjxc6zH6/VeBZlHuf06T4rmVCv7QVgZh89VyUenbTc08VI01lge/Z6NZd0fWgrlk7hxG/8
 qY803Kguf+MyjNaLdLW8VtM/E1zDcJQ+ajaey4l6ZfNBHlOLq2efrGi7Q9lkequuxDN53yQGFwJ
 9fRAoFkz2r5KSpA2dw2YFUxnvfuZvsO2mVMRIdf7qLa1zjAIjlXf6D4vvc4YsfrnfIP149noc7w
 6/8uO4ma0cOog4I0OG/+Cmr1iW6JOGkat3fFXc9Tms0mEPEsWNy3fZKk5sTC6fqZ2WEJa2f7BEL
 ODmHMdjy/9mHL0Z0rbQ48AmrQ/bH+dwv+jSkH+iBSJXchSt2XLz/bjLsbHO582z4RwNnmnSLjr8
 J1GLHEamwWXWhX95i1nHhKgTobzm7wTau5L1temGTc0gDAbNpXRdhipGpJkmQPXsW2lvuxxtoRS
 z+6moDZ9W+uBedul2FGCwDrH9O5zAaCVS+tMD7V8Rh2D
X-Received: by 2002:a05:690e:b8b:b0:64a:d83d:c262 with SMTP id
 956f58d0204a3-64c197a4341mr7296088d50.1.1771226720716; Sun, 15 Feb 2026
 23:25:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770825377.git.michal.simek@amd.com>
 <35ddf2fe394ee55c66f349dc5cc33fe1dda8f864.1770825377.git.michal.simek@amd.com>
 <1508c7be-0700-43ec-adfa-29ea16081b2f@gmx.de>
In-Reply-To: <1508c7be-0700-43ec-adfa-29ea16081b2f@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Feb 2026 09:24:44 +0200
X-Gm-Features: AZwV_QiLY8Jkws3W23fjMRj8auNGekIzA0iy34BQHWeQ5ARRQjFIpsk3TjcYvBI
Message-ID: <CAC_iWjLzrc37fuBAMojgbhO9Gg8oRjfEUbzoJd288LQtzqLS3A@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] efi_vars: Implement SPI Flash store
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Shantur Rathore <i@shantur.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
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

Hi Heinrich

[...]

> >
> > +config EFI_VARIABLE_SF_STORE
> > +     bool "Store non-volatile UEFI variables in SPI Flash"
> > +     depends on SPI_FLASH
> > +     help
> > +       Select this option if you want non-volatile UEFI variables to be
> > +       stored in SPI Flash.
> > +
> > +       Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
> > +       the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
> > +       needed.
> > +
> > +       Note that SPI Flash devices have a limited number of program/erase
> > +       cycles. Frequent updates to UEFI variables may cause excessive wear
> > +       and can permanently damage the flash device, particularly on SPI NAND
> > +       or low-end SPI NOR parts without wear leveling. This option should be
> > +       used with care on such systems, and is not recommended for platforms
> > +       where UEFI variables are updated frequently.
> > +
> >   config EFI_MM_COMM_TEE
> >       bool "UEFI variables storage service via the trusted world"
> >       depends on OPTEE
> > @@ -153,7 +171,7 @@ endchoice
> >
> >   config EFI_RT_VOLATILE_STORE
> >       bool "Allow variable runtime services in volatile storage (e.g RAM)"
> > -     depends on EFI_VARIABLE_FILE_STORE
> > +     depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
>
> Hello Michal,
>
> If the backend store is SPI flash, we should not publish the variable
> "RTStorageVolatile" at runtime as currently defined.

We had this discussion on a previous version. I asked Michal to either
update the commit message with instructions on how to update the SPI
flash, or remove the EFI_RT_VOLATILE_STORE from SPI flashes.
Technically writing these from a bash script would work, although I
agree that ideally we want this into efivar.
I don't mind if we currently prohibit EFI_RT_VOLATILE_STORE from SPI

>
> For the background see this commit for the efivar library:
>
> https://github.com/rhboot/efivar/commit/68daa04654acbe1bbaa17ebfc23c371b39e69c6b
>
> The first three patches look correct to me and I will add them to a
> merge request for efi-next.
>
> The usage of efi_var_mem_ins() and efi_var_mem_del() when SetVariable()
> does not change anything is not flash-friendly. Michal, do you want to
> have a look at this area?
>
> @Ilias, @Vincent:
> We currently lack documentation for the 3 variables.
> Would it make sense to add the definition of the variables to chapter
> source/chapter5-variable-storage.rst.

I'll send a patch to update the documentation and we can discuss it.

Regards
/Ilias
>
> Would an efivar helper for SPI flash make sense?
> How should RTStorageVolatile describe a SPI flash location?
>
> Best regards
>
> Heinrich
>
> >       help
> >         When EFI variables are stored on file we don't allow SetVariableRT,
> >         since the OS doesn't know how to write that file. At the same time
> > @@ -194,6 +212,21 @@ config FFA_SHARED_MM_BUF_ADDR
> >         the MM SP in secure world.
> >         It is assumed that the MM SP knows the address of the shared MM communication buffer.
> >
> > +config EFI_VARIABLE_SF_OFFSET
> > +     hex "EFI variables in SPI flash offset"
> > +     depends on EFI_VARIABLE_SF_STORE
> > +     help
> > +       Offset from the start of the SPI Flash where EFI variables will be stored.
> > +       This should be aligned to the sector size of SPI Flash.
> > +
> > +config EFI_VARIABLE_SF_DEVICE_INDEX
> > +     int "Device Index for target SPI Flash"
> > +     depends on EFI_VARIABLE_SF_STORE
> > +     default 0
> > +     help
> > +       The index of SPI Flash device used for storing EFI variables. This would be
> > +       needed if there are more than 1 SPI Flash devices available to use.
> > +
> >   config EFI_VARIABLES_PRESEED
> >       bool "Initial values for UEFI variables"
> >       depends on !COMPILE_TEST
> > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > index ca1775eb03be..d73ad43951b1 100644
> > --- a/lib/efi_loader/Makefile
> > +++ b/lib/efi_loader/Makefile
> > @@ -54,6 +54,7 @@ obj-y += efi_variable_tee.o
> >   else
> >   obj-y += efi_variable.o
> >   obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
> > +obj-$(CONFIG_EFI_VARIABLE_SF_STORE) += efi_var_sf.o
> >   obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
> >   endif
> >   obj-y += efi_watchdog.o
> > diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
> > new file mode 100644
> > index 000000000000..61d68f7c5c94
> > --- /dev/null
> > +++ b/lib/efi_loader/efi_var_sf.c
> > @@ -0,0 +1,92 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * SPI Flash interface for UEFI variables
> > + *
> > + * Copyright (c) 2023, Shantur Rathore
> > + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> > + */
> > +
> > +#define LOG_CATEGORY LOGC_EFI
> > +
> > +#include <efi_loader.h>
> > +#include <efi_variable.h>
> > +#include <spi_flash.h>
> > +#include <dm.h>
> > +
> > +efi_status_t efi_var_to_storage(void)
> > +{
> > +     efi_status_t ret;
> > +     struct efi_var_file *buf;
> > +     loff_t len;
> > +     struct udevice *sfdev;
> > +
> > +     ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
> > +     if (len > EFI_VAR_BUF_SIZE) {
> > +             log_err("EFI var buffer length more than target SPI Flash size");
> > +             ret = EFI_OUT_OF_RESOURCES;
> > +             goto error;
> > +     }
> > +
> > +     log_debug("%s - Got buffer to write buf->len : %d\n", __func__, buf->length);
> > +
> > +     if (ret != EFI_SUCCESS)
> > +             goto error;
> > +
> > +     ret = uclass_get_device(UCLASS_SPI_FLASH, CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
> > +     if (ret)
> > +             goto error;
> > +
> > +     ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_VAR_BUF_SIZE);
> > +     log_debug("%s - Erased SPI Flash offset %x\n", __func__, CONFIG_EFI_VARIABLE_SF_OFFSET);
> > +     if (ret)
> > +             goto error;
> > +
> > +     ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
> > +     log_debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
> > +
> > +     if (ret)
> > +             goto error;
> > +
> > +     ret = EFI_SUCCESS;
> > +error:
> > +     if (ret)
> > +             log_err("Failed to persist EFI variables in SF\n");
> > +     free(buf);
> > +     return ret;
> > +}
> > +
> > +efi_status_t efi_var_from_storage(void)
> > +{
> > +     struct efi_var_file *buf;
> > +     efi_status_t ret;
> > +     struct udevice *sfdev;
> > +
> > +     buf = calloc(1, EFI_VAR_BUF_SIZE);
> > +     if (!buf) {
> > +             log_err("%s - Unable to allocate buffer\n", __func__);
> > +             return EFI_OUT_OF_RESOURCES;
> > +     }
> > +
> > +     ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
> > +     if (ret)
> > +             goto error;
> > +
> > +     ret = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
> > +                             EFI_VAR_BUF_SIZE, buf);
> > +
> > +     log_debug("%s - read buffer buf->length: %x\n", __func__, buf->length);
> > +
> > +     if (ret || buf->length < sizeof(struct efi_var_file)) {
> > +             log_err("%s - buffer read from SPI Flash isn't valid\n", __func__);
> > +             goto error;
> > +     }
> > +
> > +     ret = efi_var_restore(buf, false);
> > +     if (ret != EFI_SUCCESS)
> > +             log_err("%s - Unable to restore EFI variables from buffer\n", __func__);
> > +
> > +     ret = EFI_SUCCESS;
> > +error:
> > +     free(buf);
> > +     return ret;
> > +}
>
