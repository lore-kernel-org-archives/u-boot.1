Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FCEC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5571F82A53;
	Mon, 28 Apr 2025 16:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jvCI+y88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7804982A5E; Mon, 28 Apr 2025 16:54:13 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C1A782A33
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriano.cordova@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ADA7D3F162
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745852049;
 bh=hIxsaIPqzHp5BjtZUGWPuYZscXi8HjXuqCuqKc1l68Q=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=jvCI+y88mbBdKqxaK5aUo5l2py5wVFaDLR2yCPuhh/TLuFlTxVOWIhLsPHU6F0+OF
 Tegh7xMWM+LWWiUASA2m5dbZ6NRyqXSCYEk6W8rRB8BKH/gL4hxatZJdXqDELCZwCP
 jSUQ3ko1+Ssq4sw1eLTJ+eDfgwxPbfmzPX2T/yryQKu/iv/cqE65KcAjdOaLJfuHEn
 h7aHJjLNNdOF+HOBTB52dB6V324s7HQRWT2vurhVt8qcGj3J02EWeCRbuceTw8sYmo
 mcKhSXlCxf8gNfwBOvFykQU++ncmDqVe+hychIu1dRdkC3WxVGv192JfaZWMm5lmvA
 Bty2ckJDNYunw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39abdadb0f0so1582807f8f.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745852049; x=1746456849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hIxsaIPqzHp5BjtZUGWPuYZscXi8HjXuqCuqKc1l68Q=;
 b=IZ8JOXEPbEkWJgKcUiYT+c4JQm52vhH6XAx5qD3IvxiXlcIxVkouBOITY1jYfQ01RQ
 9sN5rY3MJmgInwy6l5NBExizloORbEtU3OvlCCfb6DdyrXzpg8i4FYVrecFv4eGIR9kw
 p3//0zUWXvQkQFuINbkqPPSGWObPXVaJC5QHUkeMm2FVYwNka1rGxJVqJOn4c29EN5js
 llK0fPNHx8VWKpUXvQxyEPSKCa5n81rgA/ckxriKv5HDwEzcknzamNwbXRhY2kcuzriT
 jzd+IBThf2bqRANA8bVC8TBybI6EY+cK5EuWpsGlAHHoAusYR45QMroz7WsG8ZxCzjDd
 5gdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCW4ievB5A8cg3Ivf1CHra1bKMiKQiuS5yduS6ry5i5pGsaNDAwn2zcXwkaaXsTayJerQbrm8=@lists.denx.de
X-Gm-Message-State: AOJu0YxCTOYbJgDaNmemV+wrjMpnr1mPQgdMiEF3awlkbubu8mNqiXIp
 iuvsicAMOGhf0gJKZzn9p7tWzpaaw3dv46WtXqJgP5r2n7Qh5NXpHuy5omFURdAod082ofg3hbX
 SDw3Sf+4A2vHyYsXH/qQzPoAD2TFfcrpyPd9CSc0icqM1qLqFFYY9o3sTlui5si3F0mMH0eimhG
 JhSJVgvSbUwamlY2/lhl3fTvvnAqRhcICVqFR3nuAnbg==
X-Gm-Gg: ASbGncsisbt6ba5EyuFmeDaIrVBhbSAR4YirROg+8pwi3k4h4OlmyBkVd9ePFxg6+3f
 q0dpn/K4YbumcJ4Nj9dTX5dt8ATfwHsXig/ehgMLWtwVyCBExKcACdYkqaad1Wc/Z5xGP+zR8FR
 aytmF+hNzJJZ1pNWtOhf18z97gNQ==
X-Received: by 2002:a5d:4885:0:b0:39c:1404:312f with SMTP id
 ffacd0b85a97d-3a07aa67ab0mr4821858f8f.1.1745852049027; 
 Mon, 28 Apr 2025 07:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEthrLwhrgJP1+zgyrLyJ51ppXZIA0eWEcdtYCi4Es7EyccLHBy633LSubgDbhX4LdhT+zNpYwVAUGRCBNol0I=
X-Received: by 2002:a5d:4885:0:b0:39c:1404:312f with SMTP id
 ffacd0b85a97d-3a07aa67ab0mr4821841f8f.1.1745852048651; Mon, 28 Apr 2025
 07:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250427234527.2076444-1-adriano.cordova@canonical.com>
 <CAC_iWjJ2-mA5URoT8A2CRBXG17zm-CCkSyiW2gN-V2nyv3Pa5g@mail.gmail.com>
In-Reply-To: <CAC_iWjJ2-mA5URoT8A2CRBXG17zm-CCkSyiW2gN-V2nyv3Pa5g@mail.gmail.com>
From: Adriano Cordova Fedeli <adriano.cordova@canonical.com>
Date: Mon, 28 Apr 2025 10:54:46 -0400
X-Gm-Features: ATxdqUEzN7cfPvaWoK41Ti6ZUOWH51XHrKrLYbLKLhn1Xc75Q_vHc7nvt4VcFrU
Message-ID: <CAFQa3M+E9_yx2vox3Psmi5XgcVG80KWQJiaKO7_P7hSPbYFSiA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: bootbin: do not load an initrd if none is
 provided
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, 
 sjg@chromium.org, trini@konsulko.com, o451686892@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thanks, I updated the patch and split it into two

On Mon, 28 Apr 2025 at 10:32, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Adriano,
>
> On Mon, 28 Apr 2025 at 02:45, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> > Do not try to create an initrd device path nor try to register
> > an initrd with the EFI_LOAD_FILE2_PROTOCOL if none is provided.
> >
> > Handle initrd installation in efi_binary_run_dp with
> > efi_install_initrd, imitating what is done for the fdt.
> >
> > Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
> > Reported-by: Weizhao Ouyang <o451686892@gmail.com>
> > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > ---
> >  boot/bootm.c                 |  3 +++
> >  include/efi_loader.h         |  2 ++
> >  lib/efi_loader/efi_bootbin.c |  9 ++-------
> >  lib/efi_loader/efi_helper.c  | 29 +++++++++++++++++++++++++++++
> >  4 files changed, 36 insertions(+), 7 deletions(-)
> >
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > index f5cbb10f0d1..9693e0d336d 100644
> > --- a/boot/bootm.c
> > +++ b/boot/bootm.c
> > @@ -1008,6 +1008,9 @@ int bootm_run_states(struct bootm_info *bmi, int
> states)
> >                         ret = 0;
> >         }
> >
> > +       /* Clear the initrd from a previous boot */
> > +       images->initrd_start = 0;
> > +
> >         /* Relocate the ramdisk */
> >  #ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
> >         if (!ret && (states & BOOTM_STATE_RAMDISK)) {
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 144b749278a..84e8cfe320e 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -597,6 +597,8 @@ efi_status_t efi_env_set_load_options(efi_handle_t
> handle, const char *env_var,
> >  void *efi_get_configuration_table(const efi_guid_t *guid);
> >  /* Install device tree */
> >  efi_status_t efi_install_fdt(void *fdt);
> > +/* Install initrd */
> > +efi_status_t efi_install_initrd(void *initrd, size_t initd_sz);
> >  /* Execute loaded UEFI image */
> >  efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
> >  /* Run loaded UEFI image with given fdt */
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index d0f7da309ce..94ba7c5589b 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -215,12 +215,11 @@ out:
> >   * Return:     status code
> >   */
> >  static efi_status_t efi_binary_run_dp(void *image, size_t size, void
> *fdt,
> > -                                     void *initrd, size_t initd_sz,
> > +                                     void *initrd, size_t initrd_sz,
>
> This change is unrelated, please split it on a different patch
>
> >                                       struct efi_device_path *dp_dev,
> >                                       struct efi_device_path *dp_img)
> >  {
> >         efi_status_t ret;
> > -       struct efi_device_path *dp_initrd;
> >
> >         /* Initialize EFI drivers */
> >         ret = efi_init_obj_list();
> > @@ -234,11 +233,7 @@ static efi_status_t efi_binary_run_dp(void *image,
> size_t size, void *fdt,
> >         if (ret != EFI_SUCCESS)
> >                 return ret;
> >
> > -       dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd,
> initd_sz);
> > -       if (!dp_initrd)
> > -               return EFI_OUT_OF_RESOURCES;
> > -
> > -       ret = efi_initrd_register(dp_initrd);
> > +       ret = efi_install_initrd(initrd, initrd_sz);
> >         if (ret != EFI_SUCCESS)
> >                 return ret;
> >
> > diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > index 3936139ca41..6a863c3556c 100644
> > --- a/lib/efi_loader/efi_helper.c
> > +++ b/lib/efi_loader/efi_helper.c
> > @@ -622,6 +622,35 @@ efi_status_t efi_install_fdt(void *fdt)
> >         return EFI_SUCCESS;
> >  }
> >
> > +/**
> > + * efi_install_initrd() - install initrd
> > + *
> > + * Install the initrd located at @initrd using the EFI_LOAD_FILE2
> > + * protocol.
> > + *
> > + * @initrd:    address of initrd or NULL if none is provided
> > + * @initrd_sz: size of initrd
> > + * Return:     status code
> > + */
> > +efi_status_t efi_install_initrd(void *initrd, size_t initd_sz)
> > +{
> > +       efi_status_t ret;
> > +       struct efi_device_path *dp_initrd;
> > +
> > +       if (!initrd)
> > +               return EFI_SUCCESS;
> > +
> > +       dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd,
> initd_sz);
> > +       if (!dp_initrd)
> > +               return EFI_OUT_OF_RESOURCES;
> > +
> > +       ret = efi_initrd_register(dp_initrd);
> > +       if (ret != EFI_SUCCESS)
>
> You have to free the device path here
>
> > +               return ret;
> > +
> > +       return EFI_SUCCESS;
>
> Get rid of this and just return ret.
>
> > +}
> > +
> >  /**
> >   * do_bootefi_exec() - execute EFI binary
> >   *
> > --
> > 2.48.1
> >
> Thanks
> /Ilias
>
