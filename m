Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC831E77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE0E78030F;
	Thu, 19 Dec 2024 03:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QQ31nkFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA56A8021A; Thu, 19 Dec 2024 03:39:04 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ABB58021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so237261866b.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734575942; x=1735180742; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bJ231Ry+cYuQZPt3gYX0mWZtJcxaX1uZlSywYL5TIe8=;
 b=QQ31nkFi1vUdDXKc2VHb45lMCf/Z9Zw+h7t96g+LcSVWZYoB/cgllMu5k8+BgPdFUz
 T4+anPWDX/wyvwQ6A+j9LlNNJqZ+8IAm5NjZhO68+YclwXBvcAzu0vEIWDmrljg6ZRr/
 RJlVMdwGUPsKZXe+MAv13sxzAy/d79n48peNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734575942; x=1735180742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bJ231Ry+cYuQZPt3gYX0mWZtJcxaX1uZlSywYL5TIe8=;
 b=dwa5OQ61Wg3f1TNP2EFr0meA7pVZDBVVAO2AmltOmiTSFzTC847Zu8pVx9v6WaqXg2
 k8lpAIpjaRbjkLo9KcdURHrsH9Kv8E7FL5r/csIMPSFGfs45ijd5IuUVGszK9XB/bj7z
 dHV2w7i0L4FOVcQM6CUWZxc+swTeWkAZ2u05jui7AWs+doEBs+PFpnrU0ZqRXleCdhD7
 Z+n7qn81+N/P8Q4f5fyQiJKL39U7lFpQVhz41fOP0SnJ2Y8mRx5zRyQeJSTYsdkO6iPf
 TcZiZrAWEYnBXLK7SCBFhQN1mclvQ/+vB+5ue5nauUBSEIUp5MIgHK+Tsi2xPkQyeuPA
 IxIw==
X-Gm-Message-State: AOJu0Yyyf/FoGc8kMVs45jkbb1iHy3R85T7ajVMlLMJPIlFoOfMNUGCW
 OS5AheviNJL0xpD8zf/ISR+brqsdAPodXeH+L7i+cKnaxc/VnOg9udwaNmHQ23kCVoVOBnNZ19n
 S0ULjRro9fq7EFYIcpqcTBaWBd08aki4scrto
X-Gm-Gg: ASbGncsrsasE4HvnN8H17G0s5OUKudM755VDxpk4xAUc7VBiSjw9jGz8wajuZ7OUwkn
 M3Gb7UAgd3S3QJEbgYoQpgQEkKTrW4ZW64HIyiXo=
X-Google-Smtp-Source: AGHT+IEQfD5CpA0jiyhltD1PgLYTRAU4eK7VkI8BMO8FbGEEOzHs/+9Ag+yZWwu4VSoiXExMGVV28TYpEqBsiBZElJA=
X-Received: by 2002:a17:906:31d0:b0:aa6:88a2:cfbd with SMTP id
 a640c23a62f3a-aac081b90c2mr121981466b.22.1734575941842; Wed, 18 Dec 2024
 18:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-4-sjg@chromium.org>
 <CAC_iWj+5-uoXq9BanaOSxedVgbBYNFQ2AZVqka+J7iwMv=eC5w@mail.gmail.com>
In-Reply-To: <CAC_iWj+5-uoXq9BanaOSxedVgbBYNFQ2AZVqka+J7iwMv=eC5w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Dec 2024 19:38:49 -0700
Message-ID: <CAFLszTh2611n1qZRWsodHEeQ7_JwcK75=+qDpcO+fB7zOo-eYQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] efi_loader: Update efi_run_image() to accept image
 and device path
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>
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

Hi Ilias,

On Thu, 12 Dec 2024 at 00:44, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
> >
> > Provide these globals as parameters to this function, on the way to
> > making it possible to start an image without relying on the globals.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Adjust argument ordering for efi_run_image()
> >
> >  lib/efi_loader/efi_bootbin.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index ec8f4e4f7f4..8febd325f34 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -139,9 +139,13 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
> >   *
> >   * @source_buffer:     memory address of the UEFI image
> >   * @source_size:       size of the UEFI image
> > + * @device:            EFI device-path
> > + * @image:             EFI image-path
> >   * Return:             status code
> >   */
> > -static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
> > +static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
> > +                                 struct efi_device_path *device,
> > +                                 struct efi_device_path *image)
> >  {
> >         efi_handle_t mem_handle = NULL, handle;
> >         struct efi_device_path *file_path = NULL;
> > @@ -149,7 +153,7 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
> >         efi_status_t ret;
> >         u16 *load_options;
> >
> > -       if (!bootefi_device_path || !bootefi_image_path) {
> > +       if (!device || !image) {
> >                 log_debug("Not loaded from disk\n");
> >                 /*
> >                  * Special case for efi payload not loaded from disk,
> > @@ -169,9 +173,8 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
> >                         goto out;
> >                 msg_path = file_path;
> >         } else {
> > -               file_path = efi_dp_concat(bootefi_device_path,
> > -                                         bootefi_image_path, 0);
> > -               msg_path = bootefi_image_path;
> > +               file_path = efi_dp_concat(device, image, 0);
> > +               msg_path = image;
> >                 log_debug("Loaded from disk\n");
> >         }
> >
> > @@ -208,7 +211,7 @@ out:
> >  /**
> >   * efi_binary_run() - run loaded UEFI image
> >   *
> > - * @image:     memory address of the UEFI image
> > + * @image_ptr: memory address of the UEFI image
> >   * @size:      size of the UEFI image
> >   * @fdt:       device-tree
> >   *
> > @@ -217,7 +220,7 @@ out:
> >   *
> >   * Return:     status code
> >   */
> > -efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > +efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
>
> The * is enough, please drop the _ptr rename

The next patch adds a new parameter called 'image', which is the name
used throughout the file, so it seems better to rename this one.

> >  {
> >         efi_status_t ret;
> >
> > @@ -233,5 +236,6 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> >         if (ret != EFI_SUCCESS)
> >                 return ret;
> >
> > -       return efi_run_image(image, size);
> > +       return efi_run_image(image_ptr, size, bootefi_device_path,
> > +                            bootefi_image_path);
> >  }
> > --
> > 2.34.1
> >
>
> With the ptr rename removed
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

OK, dropped.

Regards,
Simon
