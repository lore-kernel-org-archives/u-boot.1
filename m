Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30E2CD1284
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 06:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFF6883E5;
	Fri,  5 Apr 2024 08:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jaCEAeRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 702D7883EA; Fri,  5 Apr 2024 08:37:42 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4898D87C2D
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 08:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-516cbf3fd3dso1936277e87.2
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 23:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712299059; x=1712903859; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2C2WprXsHoLlw4JqqO4ZcN8gNLvjskbyEInmedDKP0k=;
 b=jaCEAeRUN5MoRTBvr0LRuK0crMwtA2bMhRVZaFIPr57wecu4jRvcTS9WMMnYbDuDB3
 C4mBCl+PNee8EReKsmXwj6PihYQERLKj7Siue8p02jChoBbrg5nMzh+TFXJBfpDxi1sa
 CCe4MUnO0HPuhJV30PuwFMvgR1p7Y46oftMW+IZdiGn0fXc4pZAVMtKQeY3EZo9Lp6u1
 GJXThaMt9XmQ6pxQGlF9TH0/zBso+/rAvlPlpnBIphNq9poRqt2SXyEKWMSRlljNbThT
 x4AoXmEwgOqywT3D5RPpmcgwnIVoRzLAw9hUe4lNzMd/1Xq+SnA6J8MT9cy+eXJiGnU4
 ON1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712299059; x=1712903859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2C2WprXsHoLlw4JqqO4ZcN8gNLvjskbyEInmedDKP0k=;
 b=UaIosgPpXsnuYBMCpRjGp4j5PzPFr3Hl44g1yXp47zyYlqD4hje5OamAaR52IUBS9E
 FppItPLYL5nEYVHjBDMTFVTgvIpzSPR3gikaotWmdOGB4QRE05aluzAndzGOnvBnXOdq
 C2vgPlTjc/E5gKxOllBdil/UjS4lMI/+L6DvBuD0i8BVjoq1dfJPlizp8KX28ZWg7E3C
 MHKDhgobedZo+551mZ8XzbVm0L5ZylVC4joZz4ljYWNTOEdeeujwfXD9A+Y2TtMd+JPW
 7kQPHETS53KrbSWl0YUsqywYBrgqa6sk/BJC2QAVbaaaZBaaJ+N7IRgZTUvtXX2BlMn7
 p8LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7MlgOo/O7c7zQa+G+r7kFD4uLjPOskHUNknGGr9XqN8rzKC2sYrZHflba1r1xNvlYmlSJSj/w57iZ6Xub6tkIOSSDPw==
X-Gm-Message-State: AOJu0YwsBSJm9FcPZlUPqbA4EiN+dxh8QJxlled3iGlosH1uF4UvhZuI
 JNOiO+44a4RA+9PK0pnwbz2kRGU9TJ4Xqmp6wx4pDU69MZlLVHntKbxTeSUDm0+yu93EBSJk7XJ
 Qe7lcgVZIKaCbQMj6R5BWe5/XEqO58XMGt1o5dw==
X-Google-Smtp-Source: AGHT+IGcNI2SqKmWjJWnJ02FZjzpnGua4R06n9FNzRHQz+7ScURtTZncR1TlWDx/L2SI2J4hCxPd6y2yZNB8wdas3tU=
X-Received: by 2002:ac2:42c9:0:b0:516:c8e5:9647 with SMTP id
 n9-20020ac242c9000000b00516c8e59647mr317617lfl.19.1712299059528; Thu, 04 Apr
 2024 23:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240404074819.52156-1-ilias.apalodimas@linaro.org>
 <eb1c51e3-17e0-4c76-a703-da18a85a1ba7@gmx.de>
In-Reply-To: <eb1c51e3-17e0-4c76-a703-da18a85a1ba7@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 5 Apr 2024 09:37:03 +0300
Message-ID: <CAC_iWjLq9_3OFo4kwcgREzv7RR84bBCh7jYHtP6KTGbMk_RfLw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: move efi_var_collect to common functions
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <apalos@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
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

On Fri, 5 Apr 2024 at 09:33, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 4/4/24 09:48, Ilias Apalodimas wrote:
> > From: Ilias Apalodimas <apalos@gmail.com>
> >
> > efi_var_collect() was initially placed in efi_var_file.c, since back
> > then we only supported efi variables stored in a file. Since then we
> > support variables stored in an RPMB as well and use that function to
> > collect variables that should be present at runtime.
>
> Thanks for cleaning this up.
>
> In the CONFIG_EFI_MM_COMM_TEE=y case we seem not to need efi_var_file.c
> anymore. Can we add this diff:
>
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -72,11 +72,11 @@ obj-y += efi_string.o
>   obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += efi_unicode_collation.o
>   obj-y += efi_var_common.o
>   obj-y += efi_var_mem.o
> -obj-y += efi_var_file.o
>   ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
>   obj-y += efi_variable_tee.o
>   else
>   obj-y += efi_variable.o
> +obj-y += efi_var_file.o
>   obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
>   endif
>   obj-y += efi_watchdog.o

Yes, I'll add it on v2

Thanks
/Ilias
>
> Another comment below.
>
> >
> > So let's move it around in efi_var_common.c which makes more sense
> >
> > Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: Ilias Apalodimas <apalos@gmail.com>
> > ---
> >   lib/efi_loader/efi_var_common.c | 76 +++++++++++++++++++++++++++++++++
> >   lib/efi_loader/efi_var_file.c   | 64 ---------------------------
> >   2 files changed, 76 insertions(+), 64 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> > index 16b2c3d48828..07b9603d49f3 100644
> > --- a/lib/efi_loader/efi_var_common.c
> > +++ b/lib/efi_loader/efi_var_common.c
> > @@ -9,6 +9,7 @@
> >   #include <efi_loader.h>
> >   #include <efi_variable.h>
> >   #include <stdlib.h>
> > +#include <u-boot/crc.h>
> >
> >   enum efi_secure_mode {
> >       EFI_MODE_SETUP,
> > @@ -416,3 +417,78 @@ void *efi_get_var(const u16 *name, const efi_guid_t *vendor, efi_uintn_t *size)
> >
> >       return buf;
> >   }
> > +
> > +/**
> > + * efi_var_collect() - Copy EFI variables mstching attributes mask
> > + *
> > + * @bufp:    buffer containing variable collection
> > + * @lenp:    buffer length
> > + * @attr_mask:       mask of matched attributes
> > + *
> > + * Return:   Status code
> > + */
> > +efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
> > +                                         u32 check_attr_mask)
> > +{
> > +     size_t len = EFI_VAR_BUF_SIZE;
> > +     struct efi_var_file *buf;
> > +     struct efi_var_entry *var, *old_var;
> > +     size_t old_var_name_length = 2;
> > +
> > +     *bufp = NULL; /* Avoid double free() */
> > +     buf = calloc(1, len);
> > +     if (!buf)
> > +             return EFI_OUT_OF_RESOURCES;
> > +     var = buf->var;
> > +     old_var = var;
> > +     for (;;) {
> > +             efi_uintn_t data_length, var_name_length;
> > +             u8 *data;
> > +             efi_status_t ret;
> > +
> > +             if ((uintptr_t)buf + len <=
> > +                 (uintptr_t)var->name + old_var_name_length)
> > +                     return EFI_BUFFER_TOO_SMALL;
> > +
> > +             var_name_length = (uintptr_t)buf + len - (uintptr_t)var->name;
> > +             memcpy(var->name, old_var->name, old_var_name_length);
> > +             guidcpy(&var->guid, &old_var->guid);
> > +             ret = efi_get_next_variable_name_int(
> > +                             &var_name_length, var->name, &var->guid);
> > +             if (ret == EFI_NOT_FOUND)
> > +                     break;
> > +             if (ret != EFI_SUCCESS) {
> > +                     free(buf);
> > +                     return ret;
> > +             }
> > +             old_var_name_length = var_name_length;
> > +             old_var = var;
> > +
> > +             data = (u8 *)var->name + old_var_name_length;
> > +             data_length = (uintptr_t)buf + len - (uintptr_t)data;
> > +             ret = efi_get_variable_int(var->name, &var->guid,
> > +                                        &var->attr, &data_length, data,
> > +                                        &var->time);
> > +             if (ret != EFI_SUCCESS) {
> > +                     free(buf);
> > +                     return ret;
> > +             }
> > +             if ((var->attr & check_attr_mask) == check_attr_mask) {
> > +                     var->length = data_length;
> > +                     var = (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length, 8);
> > +             }
> > +     }
> > +
> > +     buf->reserved = 0;
> > +     buf->magic = EFI_VAR_FILE_MAGIC;
> > +     len = (uintptr_t)var - (uintptr_t)buf;
> > +     buf->crc32 = crc32(0, (u8 *)buf->var,
> > +                        len - sizeof(struct efi_var_file));
> > +     buf->length = len;
> > +     *bufp = buf;
> > +     *lenp = len;
> > +
> > +     return EFI_SUCCESS;
> > +}
> > +
> > +
>
> This produces a warning
>
> .git/rebase-apply/patch:95: new blank line at EOF.
>
> Could you, please, remove the blank lines at the end of the file.
>
> Best regards
>
> Heinrich
>
> > diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> > index 532b6b40eefe..413e1794e88c 100644
> > --- a/lib/efi_loader/efi_var_file.c
> > +++ b/lib/efi_loader/efi_var_file.c
> > @@ -52,70 +52,6 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
> >       return EFI_SUCCESS;
> >   }
> >
> > -efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
> > -                                         u32 check_attr_mask)
> > -{
> > -     size_t len = EFI_VAR_BUF_SIZE;
> > -     struct efi_var_file *buf;
> > -     struct efi_var_entry *var, *old_var;
> > -     size_t old_var_name_length = 2;
> > -
> > -     *bufp = NULL; /* Avoid double free() */
> > -     buf = calloc(1, len);
> > -     if (!buf)
> > -             return EFI_OUT_OF_RESOURCES;
> > -     var = buf->var;
> > -     old_var = var;
> > -     for (;;) {
> > -             efi_uintn_t data_length, var_name_length;
> > -             u8 *data;
> > -             efi_status_t ret;
> > -
> > -             if ((uintptr_t)buf + len <=
> > -                 (uintptr_t)var->name + old_var_name_length)
> > -                     return EFI_BUFFER_TOO_SMALL;
> > -
> > -             var_name_length = (uintptr_t)buf + len - (uintptr_t)var->name;
> > -             memcpy(var->name, old_var->name, old_var_name_length);
> > -             guidcpy(&var->guid, &old_var->guid);
> > -             ret = efi_get_next_variable_name_int(
> > -                             &var_name_length, var->name, &var->guid);
> > -             if (ret == EFI_NOT_FOUND)
> > -                     break;
> > -             if (ret != EFI_SUCCESS) {
> > -                     free(buf);
> > -                     return ret;
> > -             }
> > -             old_var_name_length = var_name_length;
> > -             old_var = var;
> > -
> > -             data = (u8 *)var->name + old_var_name_length;
> > -             data_length = (uintptr_t)buf + len - (uintptr_t)data;
> > -             ret = efi_get_variable_int(var->name, &var->guid,
> > -                                        &var->attr, &data_length, data,
> > -                                        &var->time);
> > -             if (ret != EFI_SUCCESS) {
> > -                     free(buf);
> > -                     return ret;
> > -             }
> > -             if ((var->attr & check_attr_mask) == check_attr_mask) {
> > -                     var->length = data_length;
> > -                     var = (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length, 8);
> > -             }
> > -     }
> > -
> > -     buf->reserved = 0;
> > -     buf->magic = EFI_VAR_FILE_MAGIC;
> > -     len = (uintptr_t)var - (uintptr_t)buf;
> > -     buf->crc32 = crc32(0, (u8 *)buf->var,
> > -                        len - sizeof(struct efi_var_file));
> > -     buf->length = len;
> > -     *bufp = buf;
> > -     *lenp = len;
> > -
> > -     return EFI_SUCCESS;
> > -}
> > -
> >   /**
> >    * efi_var_to_file() - save non-volatile variables as file
> >    *
>
