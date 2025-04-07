Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F78C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6963282CEA;
	Mon,  7 Apr 2025 12:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C9CroSf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341C182CF4; Mon,  7 Apr 2025 12:49:23 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D390582CE7
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac6ed4ab410so684704366b.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744022960; x=1744627760; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6vrQHq8CsCdNyMAW3N1XzUf+obSluofNT6cish5UtQ=;
 b=C9CroSf9UF0PYS2M//ltDjaoA3vDIzVPMXKSWxOOJYvQ94sYPkISEw9ZRX7laMYRid
 6UT9fSO7xxOv4kVjCMBNUoFKEHXXpinNdIAzWS/IkeGi0Gupa/mWoBvW8vv78AlaR7XP
 vVK4LxiOJ+MASNMvUgVW1JdsjvZHSAu2XImNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744022960; x=1744627760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6vrQHq8CsCdNyMAW3N1XzUf+obSluofNT6cish5UtQ=;
 b=a9usaq7Z7VELVkUCtJazELdwvn/nO+eVOm0UcjqOASc/THeP/yw6cXzfOcNl9Z7GzG
 ENa3uQYH1n19K6NDEJvwtglziMo7RU5dFJ9SIzYoVPz1+0s+obnkXY+LzKYX05IgNrXO
 wMv61/a5YNdWH8kJoG3Znk9QruMKbH9TXQXsB4fuTxeez0gMx296QUjaLB2h1nhvR/Ls
 iG9oniVKs27JZlD96f9D1+FKYnbnIXpjK0GkkMBoeZefQS+GiEzS9PZKkrYcglIVXikf
 RQbLPzt6k3x8zgY6Hx5DchmgORvA3UgMB3FZrICjuR2XBXL8GYZUHNNIZWin9PH2r1Rx
 hXHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSg0g39gwOaqRUd355fkjiquhEFx9l3WSs6DalKogHutOgONhB35VdqqVVDWxOWuP1Wb+amBM=@lists.denx.de
X-Gm-Message-State: AOJu0YxXPNTtRqA3aARQCHsh6vzAmvl2FEQVCc0Ydw35Wu0O8pVftAPj
 M6FQ5a0v06mjE/ucP74wWucYD381QvlDy5maVBKT84CuGFoOymOsOlCUiR4VcPja3CNDfPvl4l9
 pjn8l+TrUhrkHcnuTcJszDAJIohbxsmXArXVF
X-Gm-Gg: ASbGncsr+vOFdH7SITeDvlN6Ua1TU55zAiC3uNTsbXUUjTpI+Lr37Km0NUvP29BBKFk
 mig/xci8LiVuuD4uoh1gMyaHvSfZ82rLut0urHzAJdOn88fxP3cD6MqG9ozPcHzb+iOjd8R6unK
 P/hbIXEKxxaXxcezP+DCxUcDfLgb5gMViaZxn4gQ==
X-Google-Smtp-Source: AGHT+IFC7NtCo5dZVWswjULhyWe8GwwOapyS4xLAVqejrIXCtY9cl21dxw7FyrMyOJAKpucRNSaKRswj4awHpYAKgC0=
X-Received: by 2002:a17:907:6d07:b0:ac2:d1bd:3293 with SMTP id
 a640c23a62f3a-ac7d18a3f16mr1228541466b.19.1744022960004; Mon, 07 Apr 2025
 03:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250407013513.638110-1-sjg@chromium.org>
 <20250407013513.638110-4-sjg@chromium.org>
 <e2cca54d-188f-450d-ba70-a8a778263a72@gmx.de>
In-Reply-To: <e2cca54d-188f-450d-ba70-a8a778263a72@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 22:49:05 +1200
X-Gm-Features: ATxdqUHhm9nuZn_JGr3NuB5ph7wYdFUEy9fKDMXMvoJNdJfBHHwnEdKvwx3YBGo
Message-ID: <CAFLszTh7BXFvG_q9tMiCmrLZzsQY6uEqQo62wXBBfsPkObO=3g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] efi_loader: Move device-removal later in
 exit-boot-services
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 neil.armstrong@linaro.org, Jonas Karlman <jonas@kwiboo.se>, 
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
 Janne Grunau <j@jannau.net>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 7 Apr 2025 at 19:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote=
:
>
> On 07.04.25 03:35, Simon Glass wrote:
> > This removal should be the last thing done, so that U-Boot does no more
> > memory allocations afterwards, thus avoiding potentially allocating
> > memory which has been freed by a device that fails to de-activate its
> > DMA.
>
> The EFI application that is calling ExitBootServices() has been reading
> the EFI memory map with GetMemoryMap() before. This is checked by
> comparing the MapKey parameter.
>
> Whatever allocations are done or not in ExitBootServices() is not
> visible to the EFI application.
>
> DMA has to be stopped in all cases.

Yes, DMA must be stopped.

>
> I don't understand the virtue of the proposed change.

It is described in the next two paragraphs:

>
> Best regards
>
> Heinrich
>
> >
> > Of course, devices should be marked with DM_FLAG_ACTIVE_DMA or
> > DM_FLAG_OS_PREPARE but this change is good practice, in any case.
> >
> > It also matches the code in announce_and_cleanup(), which we should at
> > some point unify with EFI_LOADER

See above. Also, what do you think about unifying with announce_and_cleanup=
() ?

Regards,
Simon


> >
> > So move the code and add a comment.
> >
> > Note that the TCG2 log is updated after this call, but I cannot see any
> > allocations there.
> >
> > Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
> > Link: https://lore.kernel.org/u-boot/C101B675-EEE6-44CB-8A44-83F72182FB=
D6@kohlschutter.com/
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   lib/efi_loader/efi_boottime.c | 21 +++++++++++++--------
> >   1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottim=
e.c
> > index ffe43accd1e..e525662f82f 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -2250,14 +2250,6 @@ static efi_status_t EFIAPI efi_exit_boot_service=
s(efi_handle_t image_handle,
> >                       list_del(&evt->link);
> >       }
> >
> > -     if (!efi_st_keep_devices) {
> > -             bootm_disable_interrupts();
> > -             if (IS_ENABLED(CONFIG_USB_DEVICE))
> > -                     udc_disconnect();
> > -             board_quiesce_devices();
> > -             dm_remove_devices_active();
> > -     }
> > -
> >       /* Patch out unsupported runtime function */
> >       efi_runtime_detach();
> >
> > @@ -2279,6 +2271,19 @@ static efi_status_t EFIAPI efi_exit_boot_service=
s(efi_handle_t image_handle,
> >       /* Give the payload some time to boot */
> >       efi_set_watchdog(0);
> >       schedule();
> > +
> > +     /*
> > +      * this should be the last thing done, to avoid memory allocation=
s
> > +      * between removing devices and the OS taking over
> > +      */
> > +     if (!efi_st_keep_devices) {
> > +             bootm_disable_interrupts();
> > +             if (IS_ENABLED(CONFIG_USB_DEVICE))
> > +                     udc_disconnect();
> > +             board_quiesce_devices();
> > +             dm_remove_devices_active();
> > +     }
> > +
> >   out:
> >       if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
> >               if (ret !=3D EFI_SUCCESS)
>
