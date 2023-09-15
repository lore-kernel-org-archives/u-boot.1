Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115C0EE6432
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 07:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0859865FB;
	Fri, 15 Sep 2023 09:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JPjOy9Sw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ECFC86679; Fri, 15 Sep 2023 09:46:13 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE75865D0
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 09:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-26fc5a218daso1368439a91.1
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694763969; x=1695368769; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YiMV6jeqsBXwEIdRiJigOnrneXttcQk/QfTPgu2QYdA=;
 b=JPjOy9SwjoxdGgdSE0pWgJhdkeq6BAjxL8dqA4F1ioIShtMNO6OFbVET8QIO2GhD4Y
 SXyKTPIR23aH46klHJwHrEGDrDL9yP3r6/hLIuybv12KT6OglaTLLi10ourN2TsWrgFw
 N8fhhRCtQ6qZ7K5TvutEE99mrJuh3x8aQQnNQRPSOqtG/5BIIuXkn3eCT3OabbeR8i25
 90LJuvOEoarvrI2JwrZV05zKxMJaFi/ZLT5oln6wX6vvVzgvxh62QFWw/4uURCWGKEHV
 5mMHbin/QJqur7hXp9eaZtw6zL7P/vxbnL6/VHKc5McSx4nQ2cVdErlRtnU2a+g+6q4N
 KxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694763969; x=1695368769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YiMV6jeqsBXwEIdRiJigOnrneXttcQk/QfTPgu2QYdA=;
 b=w4NtnWDM3Di0YVfkCApMXwRtSa6GwHHXRtGwNTAUktDGoGiOfzhYWAtJNGXhDbkoYW
 Sk9D3j71g0Sbca/6TUYB/OmPvMueCLwPqykzvLN0GLLQ2izDMKJR1yRLVFi7gxUnNwkb
 LHvd+wT16BxoyV5u3e1yslDc9NFTWLf23//KxhzMpA6Pmonx0PBz2wIrnX0J8Or64TLO
 gHpNCKjGXPkoUG5f9ydSoNRNs3T+AWGfqwC8ht7nvmfdrB6TpoPXMcxBhnNDlf8O6cHi
 og0N1d1NjFOZQTCKLe51g1CFglhRwmsz+g/DRG8iHy18QYQFH/jmd1VfWa0lSJlG9Ttt
 huIQ==
X-Gm-Message-State: AOJu0YwMaXackOZDIzPhQIPQkXOwlax7cKXeaxRGZKrzA0dtYn4HK9jI
 UFrQ92edxkBoMF/zEwtkEy2H6a/Zr0lmATTWgwO3GA==
X-Google-Smtp-Source: AGHT+IEe1exaNZF4ViIDe5QqgdxhxfCKpc4KT8HWYOc/Q9Uy5haRxcqFZRkHku7iRGZK3RtcrZGOIefuhCGPn2QSP4c=
X-Received: by 2002:a17:90a:e011:b0:274:9970:9f17 with SMTP id
 u17-20020a17090ae01100b0027499709f17mr692225pjy.26.1694763968951; Fri, 15 Sep
 2023 00:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-5-masahisa.kojima@linaro.org> <ZQMRB9allzBqrFGX@hera>
 <CADQ0-X9mDQbRRatGsKuJNYUGVRC8K-N96HAHXuxpR_wMG=HHAA@mail.gmail.com>
 <ZQP6XU+Y2SiCOchV@hades>
In-Reply-To: <ZQP6XU+Y2SiCOchV@hades>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 15 Sep 2023 16:45:57 +0900
Message-ID: <CADQ0-X91SadeqxSxtHZ4N8+m1O3Qe5GGa4iDfeFp5iPVHBq8-g@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] efi_loader: support boot from URI device path
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>
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

On Fri, 15 Sept 2023 at 15:32, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Kojima-san,
>
> > > > +                                       efi_handle_t *image_handle)
> > > > +{
> > > > +     efi_status_t ret;
> > > > +     efi_handle_t bm_handle;
> > > > +     struct efi_handler *handler;
> > > > +     struct efi_device_path *file_path;
> > > > +     struct efi_device_path *device_path;
> > > > +
> > > > +     if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&bm_handle)) {
> > > > +             log_warning("DM_TAG_EFI not found\n");
> > > > +             return EFI_INVALID_PARAMETER;
> > > > +     }
> > > > +
> > > > +     ret = efi_search_protocol(bm_handle,
> > > > +                               &efi_simple_file_system_protocol_guid, &handler);
> > > > +     if (ret != EFI_SUCCESS)
> > > > +             return ret;
> > > > +
> > > > +     ret = efi_search_protocol(bm_handle, &efi_guid_device_path, &handler);
> > > > +     if (ret != EFI_SUCCESS)
> > > > +             return ret;
> > > > +
> > > > +     ret = efi_protocol_open(handler, (void **)&device_path, efi_root, NULL,
> > > > +                             EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > > > +     if (ret != EFI_SUCCESS)
> > > > +             return ret;
> > > > +
> > > > +     file_path = expand_media_path(device_path);
> > > > +     ret = EFI_CALL(efi_load_image(true, efi_root, file_path, NULL, 0,
> > > > +                                   image_handle));
> > > > +
> > > > +     efi_free_pool(file_path);
> > > > +
> > > > +     return ret;
> > > > +}
> > >
> > > We need to decide what we want here.  There were recently some patches from
> > > Raymond [0] which piggybacked on your earlier eficonfig work.  I think the
> > > last patch of this series hasn't been merged due to a test failing, but we
> > > should fix it.
> > > That patch has a different approach.  Everytime a disk appears it will add
> > > a boot option if the default filepath is found and that's how we fixed the
> >
> > efi_bootmgr_update_media_device_boot_option() automatically adds the
> > boot option if the device handle installed EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> > but it does not check whether the default file path is found or not.
> > When the user selects the automatically created boot option,
> > expand_media_path()
> > is called and efibootmgr tries to boot with the default file.
> >
>
> Ah correct.  On the function above though, we are we open coding a
> different version of efi_open_protocol()?  Can't we call that instead of
> efi_search_protocol()/efi_protocol_open()?

I will call efi_open_protocol() instead. Thanks.

>
> > > behaviour of efibootmgr to adhere to the EFI spec.  This patch is doing the
> > > opposite, trying to detect the BOOTAA64.EFI etc on the fly.  I think I
> > > prefer the approach you have here, but we should end up with one solution
> > > to solve both.
> >
> > This HTTP Boot case is slightly different from the case where the user selects
> > the automatically added boot option.
> > In this case, user selects the URI device path boot option. The
> > efibootmgr downloads the
> > file, mount the image, and try to boot with the default file name on the fly.
> > When the patch[0] is merged, it is possible to boot the downloaded iso
> > image from the
> > automatically added "blkmap" boot option, but I think efibootmgr needs
> > to boot with
> > the URI device path user selected that this series does, not boot
> > from the "blkmap" boot option.
> >
>
> Indeed, the used must still select the 'http://' boot option.
> It's been a while and I don't remember the eficonfig details.  Do you
> remember why we decided to store the load options after scanning back then?

We just followed the EDK2 reference implementation.

> IOW if we pick this up, can we also use it on the efibootmgr code and scan
> all disks on the fly instead of adding boot options?

Yes, it is possible, but I'm not sure scanning all the disks on the fly
is a good idea. For users, it is hard to control which device is selected
to boot.

Now come to think of it, we add the one load option for each disk when the
disk is detected, then try to boot with the default file by scanning
the default boot file
in the selected disk.

In current implementation, the following load options are automatically created.

Boot0000:
attributes: A-- (0x00000001)
  label: virtio 0:1
  file_path: /HD(1,GPT,b6b38698-f211-4d78-b208-f68e5523e588,0x800,0x100000)
  data:
    00000000: c1 ac c1 38 c0 9f f0 41 b9 01 fa 74 d6 d6 e4 de  ...8...A...t....
Boot0001:
attributes: A-- (0x00000001)
  label: virtio 0:2
  file_path: /HD(2,GPT,98533ff2-11d5-428c-b323-9afaf6b4abd8,0x100800,0x1122000)
  data:
    00000000: c1 ac c1 38 c0 9f f0 41 b9 01 fa 74 d6 d6 e4 de  ...8...A...t....

For this disk, only the block device "virtio 0" load option is enough,
we can search
for the default boot file on the fly. This is what EDK2 does.

Thanks,
Masahisa Kojima



>
> > >
> > > > +
> > > > +/**
> > > > + * load_default_file_from_blk_dev() - load the default file
> > > > + *
> > > > + * @blk              pointer to the UCLASS_BLK udevice
> > > > + * @handle:  pointer to handle for newly installed image
> > > > + * Return:   status code
> > > > + */
> > > > +static efi_status_t load_default_file_from_blk_dev(struct udevice *blk,
> > > > +                                                efi_handle_t *handle)
> > > > +{
> > > > +     efi_status_t ret;
> > > > +     struct udevice *partition;
> > > > +
> > > > +     /* image that has no partition table but a file system */
> > > > +     ret = try_load_default_file(blk, handle);
> > > > +     if (ret == EFI_SUCCESS)
> > > > +             return ret;
> > > > +
> > > > +     /* try the partitions */
> > > > +     device_foreach_child(partition, blk) {
> > > > +             enum uclass_id id;
> > > > +
> > > > +             id = device_get_uclass_id(partition);
> > > > +             if (id != UCLASS_PARTITION)
> > > > +                     continue;
> > > > +
> > > > +             ret = try_load_default_file(partition, handle);
> > > > +             if (ret == EFI_SUCCESS)
> > > > +                     return ret;
> > > > +     }
> > > > +
> > > > +     return EFI_NOT_FOUND;
> > > > +}
> > > > +
> > > > +/**
> > > > + * try_load_from_uri_path() - Handle the URI device path
> > > > + *
> > > > + * @uridp:   uri device path
> > > > + * @lo_label label of load option
> > > > + * @handle:  pointer to handle for newly installed image
> > > > + * Return:   status code
> > > > + */
> > > > +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> > > > +                                        u16 *lo_label,
> > > > +                                        efi_handle_t *handle)
> > > > +{
> > > > +     char *s;
> > > > +     int uri_len;
> > > > +     int image_size;
> > > > +     efi_status_t ret;
> > > > +     ulong image_addr;
> > > > +
> > > > +     s = env_get("loadaddr");
> > > > +     if (!s) {
> > > > +             log_err("Error: loadaddr is not set\n");
> > > > +             return EFI_INVALID_PARAMETER;
> > > > +     }
> > > > +     image_addr = hextoul(s, NULL);
> > > > +     image_size = wget_with_dns(image_addr, uridp->uri);
> > > > +     if (image_size < 0)
> > > > +             return EFI_INVALID_PARAMETER;
> > > > +
> > > > +     /*
> > > > +      * If the file extension is ".iso" or ".img", mount it and try to load
> > > > +      * the default file.
> > >
> > > Don't we have a better way to validate isos and efi apps instead of
> > > the extension?  The efi is checked against a valid PE/COFF image so I guess
> > > we'll really on the mount to fail for isos?
> >
> > EDK2 reference implementation checks the file type with the following priority.
> >  1) "Content-Type" header in HTTP response message
> >  2) Filename Extensions
> > Documentation is here[1].
> >
> > Since "Content-Type" is not available in the current U-Boot wget, file extension
> > is used to identify ISO images.
>
> Ok fair enough, we can go back and improve this once lwip is merged I guess
>
> >
> > [1] https://github.com/tianocore/tianocore.github.io/wiki/HTTP-Boot#ram-disk-boot-from-http
> >
>
> [...]
>
> Thanks
> /Ilias
