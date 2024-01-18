Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA67C4725D
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 00:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1EF887A18;
	Thu, 18 Jan 2024 01:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="elVy6DWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4FC187A18; Thu, 18 Jan 2024 01:16:33 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D58FE87994
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 01:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so13669341a12.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705536985; x=1706141785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wqATuZvY5HfQc7Do+EKxXF7wPGpKaMaXvFYmiqxSdF0=;
 b=elVy6DWqEw1vKQ69ToES1GbV4v2gcqK9ROmIX9g4UggBxY5atWNPIqfqUIC6D6d+9P
 rpHxrvRUdw5ER7+o1PdU46SUXJms+7HUgTCry9bSq6dZvnTaYSYk+BnsV7lWmJd3epA8
 pQUsbnuBeKZvLicmab4D95FAZoD8FY9tEYBE13HZbirq+OGuyHbm2oFWmUQhPOiJVJ7z
 pQmWJhlMbJsnS0kOpPmhp7CEot5BiyfVtKUXRhWjfeeUBxL9TTRM4jBeNvMsY5cI3R6c
 mmX8EpkBcpmkkkp5EHvzPsAU0QqGwA1BbQ9hPxDR9oezpAlX50h65I7Sq2awka36JJ/9
 yTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705536985; x=1706141785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wqATuZvY5HfQc7Do+EKxXF7wPGpKaMaXvFYmiqxSdF0=;
 b=uijZQQgS3fF1PshW2j8kyuom2PJu7n+BJl9S40wD44bIIPXOUCJLIvqZJDYCoI2PQd
 QPLWwtohNvYujHxJcGFRaRAEL4Nl8gykYD8IgNsFEi6LAzTnI4T6KaNFhzK/fiZ/QeIP
 lqXshknPJDnZgN5Jz0llqbQ16bf7JRMeod3iVaY/PGql+XsHM5u6t8227XByOeuY6TTV
 vOndsnppYAxbXA9WwcrVILA7ZBvjX2AplHmsIcfu71gmNjh6xMBngLKShDxS9GLtTW5e
 VOOxFFmrtCUAEDskfZ/kWaib+0HPQ1eJiWC1phPEmk7S3/r0LibQPxJIgr//J40uQzAW
 OLNA==
X-Gm-Message-State: AOJu0YxkoeTo1kijJabFnsTh/lT2+UDpVHU9+Fr/4xpLprffmXIzH+Gq
 +NeFKckco1nG1UTyaI9DPhFZFcg4wgAdG/2N1pB/2TtmqLpx8jGKjjM+EGRoYCrRKv8wfpL97rF
 USbv2NQ95bQ+atfCINGmbw27Z/SOoLm0u4CXC59QpaYLPGPGst64=
X-Google-Smtp-Source: AGHT+IHCusFPq73lA6WM45tX0MJMrAX7pqADJvkNgQuo3z9eVw4CE6PPw9m2PdV0MxKO97IIDnKTInTkqsclb8NBB+Q=
X-Received: by 2002:a05:6402:1283:b0:559:d52e:613d with SMTP id
 w3-20020a056402128300b00559d52e613dmr54962edv.43.1705536985233; Wed, 17 Jan
 2024 16:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20240117094432.1049168-1-masahisa.kojima@linaro.org>
 <20240117094432.1049168-2-masahisa.kojima@linaro.org>
 <CAC_iWjLWhaLtoooiqvM9AjMqp1rdtmAS3oPO+am5KV72OdGYfw@mail.gmail.com>
In-Reply-To: <CAC_iWjLWhaLtoooiqvM9AjMqp1rdtmAS3oPO+am5KV72OdGYfw@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 18 Jan 2024 09:16:14 +0900
Message-ID: <CADQ0-X9FP2R2SiNZwhbo1vAn7uLTcdia=+dOo9SN27BF2CzL+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] efi_loader: avoid pointer access after calling
 efi_delete_handle
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>
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

On Wed, 17 Jan 2024 at 20:52, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Kojima-san
>
> On Wed, 17 Jan 2024 at 11:46, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > efi_delete_handle() calls efi_purge_handle(), then it finally
> > frees the EFI handle.
> > Both diskobj and handle variables in efi_disk_remove() have
> > the same pointer, we can not access diskobj->dp after calling
> > efi_delete_handle().
> >
> > This commit saves the struct efi_device_path pointer before
> > calling efi_delete_handle(). This commit also fixes the
> > missing free for volume member in struct efi_disk_obj.
> >
> > This commit also removes the container_of() calls, and
> > adds the TODO comment of missing efi_close_protocol() call
> > for the parent EFI_BLOCK_IO_PROTOCOL.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  lib/efi_loader/efi_disk.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index 013842f077..ce46c1092a 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -707,35 +707,46 @@ int efi_disk_remove(void *ctx, struct event *event)
> >         struct udevice *dev = event->data.dm.dev;
> >         efi_handle_t handle;
> >         struct blk_desc *desc;
> > +       struct efi_device_path *dp = NULL;
> >         struct efi_disk_obj *diskobj = NULL;
> > +       struct efi_simple_file_system_protocol *volume = NULL;
> >         efi_status_t ret;
> >
> >         if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
> >                 return 0;
> >
> > +       if (!handle)
> > +               return 0;
> > +
>
> Is there a chance dev_tag_get_ptr() will return a NULL handle?

There is no chance unless we actually set a NULL.
Checking the return value of dev_tag_get_ptr above is enough, I will
remove this.

>
> >         id = device_get_uclass_id(dev);
> >         switch (id) {
> >         case UCLASS_BLK:
> >                 desc = dev_get_uclass_plat(dev);
> >                 if (desc && desc->uclass_id != UCLASS_EFI_LOADER)
> > -                       diskobj = container_of(handle, struct efi_disk_obj,
> > -                                              header);
> > +                       diskobj = (struct efi_disk_obj *)handle;
> >                 break;
> >         case UCLASS_PARTITION:
> > -               diskobj = container_of(handle, struct efi_disk_obj, header);
> > +               diskobj = (struct efi_disk_obj *)handle;
> > +
> > +               /* TODO: closing the parent EFI_BLOCK_IO_PROTOCOL is missing. */
> > +
> >                 break;
> >         default:
> >                 return 0;
> >         }
> >
> > +       if (diskobj) {
> > +               dp = diskobj->dp;
> > +               volume = diskobj->volume;
> > +       }
> > +
> >         ret = efi_delete_handle(handle);
>
> Hmm, in which context are the dp and volume pointers allocated? The
> handle is now freed, can we reliably access dp and volume ptrs?

dp and volume are allocated in efi_disk_add_dev() when the block
device is probed.
efi_delete_handle() will remove all protocols from the handle,
efi_uninstall_protocol()
checks whether protocol_interface is actually installed. So dp and
volume should be
freed after efi_delete_handle().

Thanks,
Masahisa Kojima

>
> >         /* Do not delete DM device if there are still EFI drivers attached. */
> >         if (ret != EFI_SUCCESS)
> >                 return -1;
> >
> > -       if (diskobj)
> > -               efi_free_pool(diskobj->dp);
> > -
> > +       efi_free_pool(dp);
> > +       free(volume);
> >         dev_tag_del(dev, DM_TAG_EFI);
> >
> >         return 0;
> > --
> > 2.34.1
> >
>
> Thanks
> /Ilias
