Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA15C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 08:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED74A8784B;
	Mon, 15 Jan 2024 09:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="izrJLmvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C800876DD; Mon, 15 Jan 2024 09:03:19 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E41E807E4
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 09:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a2dbc61fe89so69853766b.0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 00:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705305797; x=1705910597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VJv7JBuguQmPpPEzX3TsGYZJXjhp3EARyLG9Ovj17yE=;
 b=izrJLmvnedYHLEsYhL2bwp77tgpyln6iTV25TYOEmlVL1fehxa9jWEzksxhyj6eQt4
 vnRIl4m6eNm4APMrDVsFKucK9VXNBfl5H+hexQzpSP6x7hDWJ5uIGQ7ht+EnuMAqq0QC
 d+s2sCFNry4PMddZlgT87Bd46z2Zk2LFcwSgwyPq/KvIW6B2bVlzWOeGZVWJw1qLYF2/
 4iYt5X6LrPBM/CI3yfqY9F95WIBlYYENS/XELmAJ6N35Y2+7NlPyY5kUY+scaJqT/fG3
 LbXEJScBkc7k+8VcBF9HoMkSKaDOiiqPNI7YyyDQ8PyeqDqskUkYRv6P2zv6jDpEAEmk
 Nc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705305797; x=1705910597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJv7JBuguQmPpPEzX3TsGYZJXjhp3EARyLG9Ovj17yE=;
 b=EwoBrphmxpiBKLvNmBW8tMRchzDYm/aibrWl7iyxC4yy0dXCV+MCNeRjBp3eDmIlJL
 +UxvRRCWwV+vev006c1U9j4jgkBm6OtlT4Hm12VLDsQM09uEPd/D7yxrJZYSvmL2givx
 MeX3Vd8U0wkJ/s622040DC1HN8ycZ2C101jEHOR5TITXJ+8XY2eyx/2Mr4YAEVBfGZGB
 ZOfeRpAJICsRdsfk26/NqjuoGy7WVBpzEutbtKHwqqr/4I5I2jef3QRjvbhN+v+Kf8rZ
 wce3kFiZUmWF2D/mFi2pOqHwXnQc9njTItvlLeayuVrhZFsvpBWlqqI9qAU/YVAkBy7T
 ACEw==
X-Gm-Message-State: AOJu0Yx+gdyHbb7LMuiQGzD55olfRDx+16IT3/L9HaF5Coz09odBv0Xs
 fSXk1oTrsSK8u16o++UbGG3konSCUJufO+zr4nvQdSclnTsvWA==
X-Google-Smtp-Source: AGHT+IFvv6OmFGYZKopeBR5PM9TwK0IHCMMvPq8nB3wUuWqR8VBGlq/gwG7uqbaUQQ8YPqqJmGuQtyJ3S9CuGP70kT0=
X-Received: by 2002:a17:907:a705:b0:a2c:f8c2:4941 with SMTP id
 vw5-20020a170907a70500b00a2cf8c24941mr2353161ejc.27.1705305796774; Mon, 15
 Jan 2024 00:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20231225044356.626900-1-masahisa.kojima@linaro.org>
 <20231225044356.626900-3-masahisa.kojima@linaro.org>
 <585c8dd4-2fc9-44ff-b71b-ca1ad384c223@gmx.de>
 <CADQ0-X-LuZGHRGR=MkXEHaHg4p3ToBU2CbxkP9Phyw8sGCrBtw@mail.gmail.com>
 <4C5AB456-685F-4912-9528-298C2080F122@gmx.de>
In-Reply-To: <4C5AB456-685F-4912-9528-298C2080F122@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 15 Jan 2024 17:03:05 +0900
Message-ID: <CADQ0-X-agZPPQCjcGVKgYrPukoeVYPq=jdaNGc-n5nmkiCPqpA@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_loader: avoid pointer access after calling
 efi_delete_handle
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Takahiro Akashi <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Tue, 26 Dec 2023 at 10:43, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 26. Dezember 2023 02:13:08 MEZ schrieb Masahisa Kojima <masahisa.kojima@linaro.org>:
> >Hi Heinrich,
> >
> >On Mon, 25 Dec 2023 at 19:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 12/25/23 05:43, Masahisa Kojima wrote:
> >> > efi_delete_handle() calls efi_purge_handle(), then it finally
> >> > frees the efi handle.
> >> > Both diskobj and handle variables in efi_disk_remove() have
> >> > the same pointer, we can not access diskobj->dp after calling
> >> > efi_delete_handle().
> >> >
> >> > This commit saves the struct efi_device_path pointer before
> >> > calling efi_delete_handle(). This commit also fixes the
> >> > missing free for volume member in struct efi_disk_obj.
> >> >
> >> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >> > ---
> >> >   lib/efi_loader/efi_disk.c | 12 +++++++++---
> >> >   1 file changed, 9 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> >> > index a2f8b531a3..415d8601ba 100644
> >> > --- a/lib/efi_loader/efi_disk.c
> >> > +++ b/lib/efi_loader/efi_disk.c
> >> > @@ -701,7 +701,9 @@ int efi_disk_remove(void *ctx, struct event *event)
> >> >       struct udevice *dev = event->data.dm.dev;
> >> >       efi_handle_t handle;
> >> >       struct blk_desc *desc;
> >> > +     struct efi_device_path *dp = NULL;
> >> >       struct efi_disk_obj *diskobj = NULL;
> >> > +     struct efi_simple_file_system_protocol *volume = NULL;
> >> >       efi_status_t ret;
> >> >
> >> >       if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
> >> > @@ -722,14 +724,18 @@ int efi_disk_remove(void *ctx, struct event *event)
> >> >               return 0;
> >> >       }
> >> >
> >> > +     if (diskobj) {
> >>
> >>
> >>    diskobj = container_of(handle, struct efi_disk_obj, header);
> >>
> >> can be replaced by
> >>
> >>    diskobj = handle
> >>
> >> We should check the handle immediately after dev_tag_get_ptr() and
> >> return 0 if the handle == NULL.
> >
> >OK, I will try to improve the efi_disk_remove() function.
> >
> >>
> >> > +             dp = diskobj->dp;
> >> > +             volume = diskobj->volume;
> >> > +     }
> >> > +
> >> >       ret = efi_delete_handle(handle);
> >>
> >> We must not delete the handle in case of UCLASS_EFI_LOADER.
> >>
> >> Instead of calling efi_delete_handle we should uninstall all protocols
> >> that we have installed. If no protocol is left the handle will go away.
> >>
> >> To make the protocols to delete tractable they should be opened with
> >> BY_DRIVER.
> >
> >efi_delete_handle() calls efi_remove_all_protocols(), and frees the efi handle
> >if no protocol is left on the handle.
> >So I think efi_delete_handle() does all the required processes mentioned above.
>
> Given an EFI application like iPXE that provides a handle with the block IO protocol implemented by the application: Why should U-Boot remove the block IO protocol or the device path protocol when the application calls DisconnectController()?

Yes, but the current implementation does the same.
So in the case of UCLASS_EFI_LOADER, we need to immediately return without
calling efi_delete_handle(), is my understanding correct?
I checked lib/efi_selftest/efi_selftest_block_device.c implementation,
the teadown() process uninstalls the all protocol_interface then
the EFI handle goes away if no protocol is left.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
> >
> >>
> >> When a partition is removed we must close the protocol interfaces opened
> >> with EFI_OPEN_PROTOCOL_BY_CHILD_CONTROLLER (cf. efi_disk_add_dev()).
> >
> >OK, I will fix this.
> >
> >Thanks,
> >Masahisa Kojima
> >
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >> >       /* Do not delete DM device if there are still EFI drivers attached. */
> >> >       if (ret != EFI_SUCCESS)
> >> >               return -1;
> >> >
> >> > -     if (diskobj)
> >> > -             efi_free_pool(diskobj->dp);
> >> > -
> >> > +     efi_free_pool(dp);
> >> > +     free(volume);
> >> >       dev_tag_del(dev, DM_TAG_EFI);
> >> >
> >> >       return 0;
> >>
