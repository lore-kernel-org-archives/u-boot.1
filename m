Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF5FCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 19:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27FEA86F20;
	Tue, 17 Oct 2023 21:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U2v6QTbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E6268644E; Tue, 17 Oct 2023 21:40:20 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45EAF86F20
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 21:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507c78d258fso81721e87.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697571616; x=1698176416; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oQx0auV6nRDm/8fYvnKdu2Lp5i5CzjUXM56pbPQFHwc=;
 b=U2v6QTbhqUV7roweGrFT7I+aA/drq4wjzLQCCeL5/CppRa3cb876AzwRb/UYml9The
 xf6LDsIfYnQIHTgxj04I0IuMOIM2PV2GzP2Zlfg2WU6SH8qX4WNsHOEqrZlTKaNg0t4N
 pphUfZVgMiYKUKxm/PBrC+N9mleoToOoXGjiIRh1/9uPgY1uduk3SwvdIlnLw2YORTq8
 NdVHCHohex5I6v9R4/etGA5cFz5v/yChAQXKQB8npxaRs+vr179Rx32YHxyN5qniquVq
 5ed5WPg5gdQoKx0aW4vDMSs2ZbIWW4Oyt03MHWEcCLrUiWd+5BpErbnm4xM4g9ywyvGS
 ONVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697571616; x=1698176416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQx0auV6nRDm/8fYvnKdu2Lp5i5CzjUXM56pbPQFHwc=;
 b=W/5xTzlGKvFoUUsoN4/Q0ZMYhsRYdM5tl99ju6SyoT6lj5mpNhidSUTAfZD+YobM/0
 JFkKhmbLXZ4Gah+Fw8IWgbJDL5azzzVUwBGcsZSjIkpbsnJwj3/I2Z9wDF+OtEPs0jy1
 qPRdwSN74mv0MMUE0NL1UWeV9GbOz/Hj6RjZwWmlLLV2/tZwuP4h6ChsGol3e9BkuhEV
 q0CLvY+sTeaTYcs9I1wf7DZJrTTukM5igBT+XAen4mfKfz9bSRtTwGW3i+MPRaXXG6zC
 jFx2keufNtR0kuwlRbVWNsVMqtD+bSJaumHSHtJxQFzGY92fy97BVB3qtOPJyFTmY60n
 H/9A==
X-Gm-Message-State: AOJu0YwUo5I/LWM0J+lTLql1Tug3UJ8HF10B4Nxk0L8w97JuN1MaCD1H
 TPIhLOvn0Ag6LxY3D7RtWXyQDSNytksCEbfavduuxw==
X-Google-Smtp-Source: AGHT+IHzcK99I5lX5MNN6f+foR4ccs+DNy0ePeE+nyFrruILsZKRX5cRIv3FHil5satA7iWKwOENgkRQsxdEHAZG/l8=
X-Received: by 2002:ac2:43ae:0:b0:507:a1b3:2d47 with SMTP id
 t14-20020ac243ae000000b00507a1b32d47mr2482732lfl.17.1697571616257; Tue, 17
 Oct 2023 12:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231017175148.75215-1-heinrich.schuchardt@canonical.com>
 <87v8b5qceb.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87v8b5qceb.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Oct 2023 22:39:40 +0300
Message-ID: <CAC_iWjK-sb1y0E+2ciiEDs8upd7gJ7U6F2XKSmSBwE1wdx+Zcg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix efi_bootmgr_enumerate_boot_option
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 masahisa.kojima@linaro.org, raymond.mao@linaro.org, u-boot@lists.denx.de
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

Hi Mark,

On Tue, 17 Oct 2023 at 22:25, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Date: Tue, 17 Oct 2023 19:51:48 +0200
> >
> > Only auto-generate boot options for removable media.
> >
> > For testing the different handling of removable and non-removable devices
> > an emulated USB device can be used:
> >
> >     make qemu-riscv64_smode_defconfig; make
> >     qemu-system-riscv64 -M virt -kernel u-boot.bin -nographic \
> >     -device qemu-xhci -drive if=none,file=disk.img,format=raw,id=USB1 \
> >     -device usb-storage,drive=USB1,removable=on
>
> Unless I misunderstand what this patch does, this may result in
> systems that don't boot after installation.
>
> On most boards U-Boot does not provide a way to create persistent EFI
> variables after ExitBootServices() is called.  This means that an OS
> installer cannot create a boot entry for the OS installation it just
> created.  Therefore the EFI boot manager will not boot the newly
> installed system.
>
> Now as long as the traditional distro boot mechanism or the EFI distro
> boot bootmeth is enabled the system will probobly still attempt to
> boot the installed system.  But do want to rely on that?

No, we don't.  We already discussed this with Heinrich (offline) and I
think we should not merge that.  The EFI spec doesn't limit the boot
manager to removable entries only. In [0] it mentions

"if the boot image is not loaded via EFI_BOOT_SERVICES.LoadImage() the
boot manager is required to check for a default application to boot.
Searching for a default application to boot happens on ** both
removable and fixed media types**. This search occurs when the device
path of the boot image listed in any boot option points directly to an
EFI_SIMPLE_FILE_SYSTEM_PROTOCOL device and does not specify the exact
file to load. The file discovery method is explained in Boot Option
Recovery. The default media boot case of a protocol other than
EFI_SIMPLE_FILE_SYSTEM_PROTOCOL is handled by the
EFI_LOAD_FILE_PROTOCOL for the target device path and does not need to
be handled by the boot manager."

So scanning both is required.

[0] https://uefi.org/specs/UEFI/2.10/03_Boot_Manager.html#load-option-processing

Regards
/Ilias
>
> > Fixes: c416f1c0bcab ("bootmenu: add removable media entries")
> > Fixes: 339b527bd450 ("Move bootorder and bootoption apis to lib")
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  lib/efi_loader/efi_bootmgr.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index a40762c74c..96d45157b3 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -346,7 +346,7 @@ error:
> >  }
> >
> >  /**
> > - * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootable media
> > + * efi_bootmgr_enumerate_boot_option() - boot options for removable boot media
> >   *
> >   * @opt:             pointer to the media boot option structure
> >   * @volume_handles:  pointer to the efi handles
> > @@ -370,6 +370,9 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
> >               struct efi_device_path *device_path;
> >               struct efi_device_path *short_dp;
> >
> > +             if (!efi_disk_is_removable(volume_handles[i]))
> > +                     continue;
> > +
> >               ret = efi_search_protocol(volume_handles[i], &efi_guid_device_path, &handler);
> >               if (ret != EFI_SUCCESS)
> >                       continue;
> > @@ -674,7 +677,10 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
> >               goto out;
> >       }
> >
> > -     /* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
> > +     /*
> > +      * Enumerate all removable devices supporting the
> > +      * EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
> > +      */
> >       ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> > --
> > 2.40.1
> >
> >
