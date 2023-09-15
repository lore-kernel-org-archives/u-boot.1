Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9691EEE6442
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 08:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A223586915;
	Fri, 15 Sep 2023 10:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sk/0pdq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C01386907; Fri, 15 Sep 2023 10:12:34 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE45868D7
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 10:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-502defbb0c3so3166831e87.0
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694765551; x=1695370351; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9G2TnizzQksMd2324L+m7cxEtQ7TCcd+gLmZK5vgTMo=;
 b=Sk/0pdq5Ldw3d9OvmSh26Hb9RLbPsXNCbnbzTnEhaWyPV0wjg6HWcY+1Kq3jP1tddP
 JLaeUPlNozF3m/R8KzH1LqYNO8u12l6u5rTp76bsKa/jfCBkLxhDJ2OgDilIO6DnAS3F
 f0A7dCFuxU/gdYN4hc1aqaE8fGlJLYl9geKsiDDaVro7SCwrd+dUDhV+J1r6RRvsPB7g
 7Mpd3Y/RFoxSm5WBeXk7s6HCbD9wheGkn1MaR9e4espsxZRFSQzUk72eCVhLzj8U1j6s
 MYOF34HIoGmdw/KvJAEaQlKD3BUp2DoaMGGZdcoRA5IkGBIMfXgZLlMq6Tbvv0qVmX6D
 tzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694765551; x=1695370351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9G2TnizzQksMd2324L+m7cxEtQ7TCcd+gLmZK5vgTMo=;
 b=i6c/Gf+A2wKtOnhyd4fBGy5SPQtUBIOD3TtuUp41tozpUFkgE3ucHt2Z56cWl1sbEc
 DScX9nTth0gDaN/y/TOowwPXdhN1jkGnbOdisdUhDMFUhv29DeY5MNL9zgM3V7wTRFMT
 0ygaLWFeBmOo4u587t5Ji3XwwVqMxo3dHQeZkQ+r2CDAPpwFob9P/mysWNjuN4iECt+G
 p90T8lnwPyjXt58D2ZUCTkOCIL9HqzQEmY44TrgssowyE1Q9sVMnlqRYh4F7a4c3bJz0
 lKqSBSde83t1ToVcEBlMlr8D4589wapQiHab8o1/iwBiRyQVwCPm1CnhC35YCqraa+QP
 RzKg==
X-Gm-Message-State: AOJu0YzTun4868tTa1KhesaORy3MtJW6r+j4NCWqBr8jpKfsoe0cN6Dg
 fR243Un67CA2dsOJr3IWAOpL3afKrvsTQEteEHKoQQ==
X-Google-Smtp-Source: AGHT+IE7Y47K9SxeIW8iuqdikDlbMrIuotukkOetBEhMDzwRHsdXO2uYPptrQpNxbXCsBzl6UMAOdaUcoIkQE1Is1bY=
X-Received: by 2002:a05:6512:38d1:b0:4f8:711b:18b0 with SMTP id
 p17-20020a05651238d100b004f8711b18b0mr852192lft.3.1694765550767; Fri, 15 Sep
 2023 01:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-5-masahisa.kojima@linaro.org> <ZQMRB9allzBqrFGX@hera>
 <CADQ0-X9mDQbRRatGsKuJNYUGVRC8K-N96HAHXuxpR_wMG=HHAA@mail.gmail.com>
 <ZQP6XU+Y2SiCOchV@hades>
 <CADQ0-X91SadeqxSxtHZ4N8+m1O3Qe5GGa4iDfeFp5iPVHBq8-g@mail.gmail.com>
In-Reply-To: <CADQ0-X91SadeqxSxtHZ4N8+m1O3Qe5GGa4iDfeFp5iPVHBq8-g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 Sep 2023 11:11:54 +0300
Message-ID: <CAC_iWjLx=3w4TXMGr1p=0-BLevcq6GfdnWq0X6qVSPnd1knXKA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] efi_loader: support boot from URI device path
To: Masahisa Kojima <masahisa.kojima@linaro.org>
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

Kojima-san

[...]

>
> We just followed the EDK2 reference implementation.
>
> > IOW if we pick this up, can we also use it on the efibootmgr code and scan
> > all disks on the fly instead of adding boot options?
>
> Yes, it is possible, but I'm not sure scanning all the disks on the fly
> is a good idea. For users, it is hard to control which device is selected
> to boot.
>
> Now come to think of it, we add the one load option for each disk when the
> disk is detected, then try to boot with the default file by scanning
> the default boot file
> in the selected disk.
>
> In current implementation, the following load options are automatically created.
>
> Boot0000:
> attributes: A-- (0x00000001)
>   label: virtio 0:1
>   file_path: /HD(1,GPT,b6b38698-f211-4d78-b208-f68e5523e588,0x800,0x100000)
>   data:
>     00000000: c1 ac c1 38 c0 9f f0 41 b9 01 fa 74 d6 d6 e4 de  ...8...A...t....
> Boot0001:
> attributes: A-- (0x00000001)
>   label: virtio 0:2
>   file_path: /HD(2,GPT,98533ff2-11d5-428c-b323-9afaf6b4abd8,0x100800,0x1122000)
>   data:
>     00000000: c1 ac c1 38 c0 9f f0 41 b9 01 fa 74 d6 d6 e4 de  ...8...A...t....

Yep, that's exactly what I was thinking as an alternative.  On the
automatically scan boot option, just search for '1234567' on the load
options.
Keep in mind that patch from Raymon is failing on an erofs selftest.
But when I was looking at it, I came to the conclusion, that due to
the EFI subsystem coming up earlier a print changes and that test gets
utterly confused.  IOW that patch seems fine, but you'll probably need
to adjust a selftest as well.

Thanks
/Ilias
>
> For this disk, only the block device "virtio 0" load option is enough,
> we can search
> for the default boot file on the fly. This is what EDK2 does.
>
> Thanks,
> Masahisa Kojima
>
>
>
> >
> > > >
> > > > > +
> > > > > +/**
> > > > > + * load_default_file_from_blk_dev() - load the default file
> > > > > + *
> > > > > + * @blk              pointer to the UCLASS_BLK udevice
> > > > > + * @handle:  pointer to handle for newly installed image
> > > > > + * Return:   status code
> > > > > + */
> > > > > +static efi_status_t load_default_file_from_blk_dev(struct udevice *blk,
> > > > > +                                                efi_handle_t *handle)
> > > > > +{
> > > > > +     efi_status_t ret;
> > > > > +     struct udevice *partition;
> > > > > +
> > > > > +     /* image that has no partition table but a file system */
> > > > > +     ret = try_load_default_file(blk, handle);
> > > > > +     if (ret == EFI_SUCCESS)
> > > > > +             return ret;
> > > > > +
> > > > > +     /* try the partitions */
> > > > > +     device_foreach_child(partition, blk) {
> > > > > +             enum uclass_id id;
> > > > > +
> > > > > +             id = device_get_uclass_id(partition);
> > > > > +             if (id != UCLASS_PARTITION)
> > > > > +                     continue;
> > > > > +
> > > > > +             ret = try_load_default_file(partition, handle);
> > > > > +             if (ret == EFI_SUCCESS)
> > > > > +                     return ret;
> > > > > +     }
> > > > > +
> > > > > +     return EFI_NOT_FOUND;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * try_load_from_uri_path() - Handle the URI device path
> > > > > + *
> > > > > + * @uridp:   uri device path
> > > > > + * @lo_label label of load option
> > > > > + * @handle:  pointer to handle for newly installed image
> > > > > + * Return:   status code
> > > > > + */
> > > > > +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> > > > > +                                        u16 *lo_label,
> > > > > +                                        efi_handle_t *handle)
> > > > > +{
> > > > > +     char *s;
> > > > > +     int uri_len;
> > > > > +     int image_size;
> > > > > +     efi_status_t ret;
> > > > > +     ulong image_addr;
> > > > > +
> > > > > +     s = env_get("loadaddr");
> > > > > +     if (!s) {
> > > > > +             log_err("Error: loadaddr is not set\n");
> > > > > +             return EFI_INVALID_PARAMETER;
> > > > > +     }
> > > > > +     image_addr = hextoul(s, NULL);
> > > > > +     image_size = wget_with_dns(image_addr, uridp->uri);
> > > > > +     if (image_size < 0)
> > > > > +             return EFI_INVALID_PARAMETER;
> > > > > +
> > > > > +     /*
> > > > > +      * If the file extension is ".iso" or ".img", mount it and try to load
> > > > > +      * the default file.
> > > >
> > > > Don't we have a better way to validate isos and efi apps instead of
> > > > the extension?  The efi is checked against a valid PE/COFF image so I guess
> > > > we'll really on the mount to fail for isos?
> > >
> > > EDK2 reference implementation checks the file type with the following priority.
> > >  1) "Content-Type" header in HTTP response message
> > >  2) Filename Extensions
> > > Documentation is here[1].
> > >
> > > Since "Content-Type" is not available in the current U-Boot wget, file extension
> > > is used to identify ISO images.
> >
> > Ok fair enough, we can go back and improve this once lwip is merged I guess
> >
> > >
> > > [1] https://github.com/tianocore/tianocore.github.io/wiki/HTTP-Boot#ram-disk-boot-from-http
> > >
> >
> > [...]
> >
> > Thanks
> > /Ilias
