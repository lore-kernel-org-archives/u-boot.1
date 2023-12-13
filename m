Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F75CC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F16687633;
	Wed, 13 Dec 2023 20:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cFNSpClO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98563874CC; Wed, 13 Dec 2023 20:51:03 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B42D875FC
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dbc666461daso4594757276.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497060; x=1703101860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sbXjdk17Bcf5PjJIV2q8j1XO08gX4k6pzPX3QrXoiik=;
 b=cFNSpClO3DWf4eByPptdWzWKsSkq5j2ylGvUapZUG5KDFsMji2i84ZYGOFncolFDev
 AYKRy++Jc4siqfSkyCOcYv/mN1AyCBB2799sv/BCZKvtHKkMt93wuPrRfUX6BnEQSwfl
 Nn5kC4mL8/L20j9E4JQ9ylzykIcRqTmrxxWA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497060; x=1703101860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sbXjdk17Bcf5PjJIV2q8j1XO08gX4k6pzPX3QrXoiik=;
 b=A05y2dQtiS7QxClXcVSd9eRQ161ubdxBBZOmpr1XnNtXyrwrkHENLAcu+qQRZBfEMY
 j6GTZl3zYv9B5OKUtxtsR3NKB1ph3HRn3zjOsIEwOxLbWKRaBrRJcw5i1jb0JBnn5gU4
 y3vhO2KXn1QeFwmuKlEztFawKBBVj9M48U14nmI7IhXg4sY2Gh9dj2rDi3N/Di7yBhhG
 V9ZoLbQH3aHYQVpbiW9y0grqZaxqBlsMYAk5E6c70Z6c36MBV48rBzN+fEa+OhXlDL07
 D44bUJw25QUwpZ/8M8c5eeAy0hge0kNYx0T/puZf+2Khe32lzA1/VUKxq1x0/3aWk41F
 8Ppw==
X-Gm-Message-State: AOJu0YwxuKPyx59O32MBE7hZ8S5FwmM+ETvwrd0EKkNqMeT2NTvCT8JO
 c8fmu0Bk5UsUnm6ZB2/33OOUahvt6cjclO/tf+1RiQ==
X-Google-Smtp-Source: AGHT+IFYep7zcy78MMJXqlUMgpYPWeyhRgUVwT6ks0hp3oHoiDqkBOd6UVEyVBVWvzpV9qewKVuB+fevBvqE5PmTG9s=
X-Received: by 2002:a5b:b03:0:b0:db5:44c9:26c5 with SMTP id
 z3-20020a5b0b03000000b00db544c926c5mr6169634ybp.48.1702497059666; Wed, 13 Dec
 2023 11:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20231213085737.299773-1-masahisa.kojima@linaro.org>
 <dcc6a681-2ede-49ba-ad0d-069933ad32ca@gmx.de>
In-Reply-To: <dcc6a681-2ede-49ba-ad0d-069933ad32ca@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:50:00 -0700
Message-ID: <CAPnjgZ1FC1c4D3NfX7+WNmWWwmvEOLARXZtDZEtdYMcoego6Jw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: eliminate efi_disk_obj structure
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, 13 Dec 2023 at 07:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 13.12.23 09:57, Masahisa Kojima wrote:
> > Current code uses struct efi_disk_obj to keep information
> > about block devices and partitions. As the efi handle already
> > has a field with the udevice, we should eliminate
> > struct efi_disk_obj and use an pointer to struct efi_object
> > for the handle.
> >
> > efi_link_dev() call is moved inside of efi_disk_add_dev() function
> > to simplify the cleanup process in case of error.
>
> I agree that using struct efi_disk_obj as a container for protocols of a
> block IO device is a bit messy.
>
> But we should keep looking up the handle easy. Currently we use
>
> diskobj = container_of(this, struct efi_disk_obj, ops);
>
> Instead we could append a private field with the handle to the
> EFI_BLOCK_IO_PROTOCOL structure.
>
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >   lib/efi_loader/efi_disk.c | 209 +++++++++++++++++++++-----------------
> >   1 file changed, 116 insertions(+), 93 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index f0d76113b0..cfb7ace551 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -27,27 +27,24 @@ struct efi_system_partition efi_system_partition = {
> >   const efi_guid_t efi_block_io_guid = EFI_BLOCK_IO_PROTOCOL_GUID;
> >   const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
> >
> > -/**
> > - * struct efi_disk_obj - EFI disk object
> > - *
> > - * @header:  EFI object header
> > - * @ops:     EFI disk I/O protocol interface
> > - * @dev_index:       device index of block device
> > - * @media:   block I/O media information
> > - * @dp:              device path to the block device
> > - * @part:    partition
> > - * @volume:  simple file system protocol of the partition
> > - * @dev:     associated DM device
> > - */
> > -struct efi_disk_obj {
> > -     struct efi_object header;
> > -     struct efi_block_io ops;
> > -     int dev_index;
> > -     struct efi_block_io_media media;
> > -     struct efi_device_path *dp;
> > -     unsigned int part;
> > -     struct efi_simple_file_system_protocol *volume;
> > -};
> > +static efi_handle_t efi_blkio_find_obj(struct efi_block_io *blkio)
> > +{
> > +     efi_handle_t handle;
> > +
> > +     list_for_each_entry(handle, &efi_obj_list, link) {
> > +             efi_status_t ret;
> > +             struct efi_handler *handler;
> > +
> > +             ret = efi_search_protocol(handle, &efi_block_io_guid, &handler);
> > +             if (ret != EFI_SUCCESS)
> > +                     continue;
> > +
> > +             if (blkio == handler->protocol_interface)
> > +                     return handle;
> > +     }
>
> Depending on the number of handles and pointers this will take a
> considerable time. A private field for the handle appended to struct
> efi_block_io would allow a fast lookup.
>
> EDK II does the same. See the definition of RAM_DISK_PRIVATE_FROM_BLKIO
> which uses macro BASE_CR() to find the private fields.

That seems pretty ugly to me, but if it really is that slow, I suppose it is OK.

Can we attach efi_block_io to the driver model BLK device?

Regards,
Simon
