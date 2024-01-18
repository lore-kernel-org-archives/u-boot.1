Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAAEC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 06:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9460F8791E;
	Thu, 18 Jan 2024 07:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="adWj8RQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE18F8794F; Thu, 18 Jan 2024 07:14:22 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A3887887
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 07:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2cdeb954640so19299401fa.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 22:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705558460; x=1706163260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l9yUHlgSRFYSyFs2oH104Uzm2zbeGyBuD+iGQ7pArGg=;
 b=adWj8RQIDXu8TuX73eXCscKcLc3YO/qV7JSuFKxjB2YF168U0V5F7vJxYRIE2M+S5n
 PF1FflrbJqm22GUv4Z36XIFMfl2Hv+OC1Hsm6hYzDsD78dgZ38tllyP75GJtl8FkHybJ
 2txZxvUXextBvIwU2K+68D5cYxwM7lUn5TePdgdDeMbFUWxRxZ+04bRjMi/5luRGfJMl
 lPqfpcVgwcqAQABQGNpkn31g8rIOXuACj6iq/ZJnMu0RdaQdtikjVWxOqXgBkJIZqu7C
 vUUzVc8oS6iEzjq1gSEpSFDqog7hfOrU8laN0Ylo8AORjOJSjTz2ozTL/B+enrTr7RQP
 OrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705558460; x=1706163260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l9yUHlgSRFYSyFs2oH104Uzm2zbeGyBuD+iGQ7pArGg=;
 b=aab+/0xL+DklRiN+PNZLttIXk1kEKZ4tpN5ZagOsvjsdAxhCzAUw6X8pnBLvgRcgsG
 bBI7JiGSkyml1RQjBqQC6Taiyq9MNxsIawiPiyZv4uP9FmXqtQ0tyLjtC6ljXVNPUDLW
 kRk8NOPeTM/8FSECTpSMzr66JLNsEdImfSXtv11g3c3/z2/rbMaiOnF/+z9s35K/Bay1
 ysuvgMdm65W8yMpAwvgRHJ3kjPXR2WLD2xtnf4pEzZ6KhmeMe6Jvt6ANjkToTWv274F3
 GUBV3Xvv8n9Lt8rzIDvrUhgU1+A8ZQvu9YUlUTGWq18pyfha6bYFaxtdg6ViF3Iycz1s
 fMsA==
X-Gm-Message-State: AOJu0Yw//tZZQ6CqZI8NkQG67SlWCEVyHOXjEmVSIT1vKqSme4kuZCkx
 BaMFMy0jPGTGTaJXyrxtPy4C6JB/O79+oYU/yu0NitZlTMmgDleLXkty9x7kYKpNqOuYxpDSq9u
 BbTSJdyQmDBiPOy68FqQoex6lCUK/m/RD4hWC9br9fVDyoXfRU84=
X-Google-Smtp-Source: AGHT+IE6ocR7znCMy1pyvFo20wD13wrcY8k2WrXO6ZPmoIg9OIxLo5PYk5k0edwJ88U83r4wLCgpq9E0sxdhM9vtUUs=
X-Received: by 2002:a05:651c:1551:b0:2cd:f8b7:2116 with SMTP id
 y17-20020a05651c155100b002cdf8b72116mr178964ljp.96.1705558459686; Wed, 17 Jan
 2024 22:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20240117094432.1049168-1-masahisa.kojima@linaro.org>
 <20240117094432.1049168-2-masahisa.kojima@linaro.org>
 <CAC_iWjLWhaLtoooiqvM9AjMqp1rdtmAS3oPO+am5KV72OdGYfw@mail.gmail.com>
 <CADQ0-X9FP2R2SiNZwhbo1vAn7uLTcdia=+dOo9SN27BF2CzL+w@mail.gmail.com>
In-Reply-To: <CADQ0-X9FP2R2SiNZwhbo1vAn7uLTcdia=+dOo9SN27BF2CzL+w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Jan 2024 08:13:43 +0200
Message-ID: <CAC_iWjJ6M9HKc6DqeC_Qoyh-b3umb4ahYQeuQDr16dJF_cK=UA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] efi_loader: avoid pointer access after calling
 efi_delete_handle
To: Masahisa Kojima <masahisa.kojima@linaro.org>
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

On Thu, 18 Jan 2024 at 02:16, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> On Wed, 17 Jan 2024 at 20:52, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Kojima-san
> >
> > On Wed, 17 Jan 2024 at 11:46, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > efi_delete_handle() calls efi_purge_handle(), then it finally
> > > frees the EFI handle.
> > > Both diskobj and handle variables in efi_disk_remove() have
> > > the same pointer, we can not access diskobj->dp after calling
> > > efi_delete_handle().
> > >
> > > This commit saves the struct efi_device_path pointer before
> > > calling efi_delete_handle(). This commit also fixes the
> > > missing free for volume member in struct efi_disk_obj.
> > >
> > > This commit also removes the container_of() calls, and
> > > adds the TODO comment of missing efi_close_protocol() call
> > > for the parent EFI_BLOCK_IO_PROTOCOL.
> > >
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > > ---
> > >  lib/efi_loader/efi_disk.c | 23 +++++++++++++++++------
> > >  1 file changed, 17 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > > index 013842f077..ce46c1092a 100644
> > > --- a/lib/efi_loader/efi_disk.c
> > > +++ b/lib/efi_loader/efi_disk.c
> > > @@ -707,35 +707,46 @@ int efi_disk_remove(void *ctx, struct event *event)
> > >         struct udevice *dev = event->data.dm.dev;
> > >         efi_handle_t handle;
> > >         struct blk_desc *desc;
> > > +       struct efi_device_path *dp = NULL;
> > >         struct efi_disk_obj *diskobj = NULL;
> > > +       struct efi_simple_file_system_protocol *volume = NULL;
> > >         efi_status_t ret;
> > >
> > >         if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
> > >                 return 0;
> > >
> > > +       if (!handle)
> > > +               return 0;
> > > +
> >
> > Is there a chance dev_tag_get_ptr() will return a NULL handle?
>
> There is no chance unless we actually set a NULL.
> Checking the return value of dev_tag_get_ptr above is enough, I will
> remove this.
>
> >
> > >         id = device_get_uclass_id(dev);
> > >         switch (id) {
> > >         case UCLASS_BLK:
> > >                 desc = dev_get_uclass_plat(dev);
> > >                 if (desc && desc->uclass_id != UCLASS_EFI_LOADER)
> > > -                       diskobj = container_of(handle, struct efi_disk_obj,
> > > -                                              header);
> > > +                       diskobj = (struct efi_disk_obj *)handle;
> > >                 break;
> > >         case UCLASS_PARTITION:
> > > -               diskobj = container_of(handle, struct efi_disk_obj, header);
> > > +               diskobj = (struct efi_disk_obj *)handle;
> > > +
> > > +               /* TODO: closing the parent EFI_BLOCK_IO_PROTOCOL is missing. */
> > > +
> > >                 break;
> > >         default:
> > >                 return 0;
> > >         }
> > >
> > > +       if (diskobj) {
> > > +               dp = diskobj->dp;
> > > +               volume = diskobj->volume;
> > > +       }
> > > +
> > >         ret = efi_delete_handle(handle);
> >
> > Hmm, in which context are the dp and volume pointers allocated? The
> > handle is now freed, can we reliably access dp and volume ptrs?
>
> dp and volume are allocated in efi_disk_add_dev() when the block
> device is probed.
> efi_delete_handle() will remove all protocols from the handle,
> efi_uninstall_protocol()
> checks whether protocol_interface is actually installed. So dp and
> volume should be
> freed after efi_delete_handle().

Ok that makes sense,

With the check above removed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>
> Thanks,
> Masahisa Kojima
>
> >
> > >         /* Do not delete DM device if there are still EFI drivers attached. */
> > >         if (ret != EFI_SUCCESS)
> > >                 return -1;
> > >
> > > -       if (diskobj)
> > > -               efi_free_pool(diskobj->dp);
> > > -
> > > +       efi_free_pool(dp);
> > > +       free(volume);
> > >         dev_tag_del(dev, DM_TAG_EFI);
> > >
> > >         return 0;
> > > --
> > > 2.34.1
> > >
> >
> > Thanks
> > /Ilias
