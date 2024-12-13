Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A38E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B862980137;
	Fri, 13 Dec 2024 13:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Aw4ookfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2601880141; Fri, 13 Dec 2024 13:13:11 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72BE280104
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6ef9b8b4f13so14390547b3.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734091987; x=1734696787; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=79dZlrg9Nb2bJJweB7hTgRWegHbvWYmmG4JJZxxkGpQ=;
 b=Aw4ookfbtHs9+/6zwxmvrImlU1erudW7MCXVO9wLuNVZzx4/+r5kF1sAyNxT2g3GcC
 Hox5WI+qaWlqHW48/AdWTrjli06GRE94FjpoArZu8GE15uy6SbeM/YFy5YIREKaif2hM
 aX4FBnwn9hpc7Qtdpcf2YkRvzbnjdB0FgCWgH/XGNdgbTbDwO0zcUSaovMVZ6GfcBHPR
 ISZZSI2Dzr4ri6GdWodlftWEOpl4s2XwIKBCp0ujdjdA7sNXGf5phH287c93bF1DaBuC
 aUJL/tR031Vpb141AaM3D0W6qXew1yCzMX4C7++L6qEkNKqnSj/xc+wmCPSXA2CEM6LB
 8UnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734091987; x=1734696787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=79dZlrg9Nb2bJJweB7hTgRWegHbvWYmmG4JJZxxkGpQ=;
 b=X2bDMmlaN55zJGRaZ607MFe7I3tHNMxq/cocERhq23BULL2Oq0t6Tf9WCNTq8s5ZRd
 FGpLAS+xBGCsStr0bLas/0mhK2bhsaMHZ9/EUA3N1j7yRlwZ6jL5zP5ikPP8uiIOOLDl
 aaxD+0gHXjXivgxr6GuaXRs6zotztbS8oZzBUaar4CocHGLr00FyFhrbgrNEYuboFq5b
 6GOVdmNYMYHM8BvTVe+LzE5PVY8yYOuH7DpifK6z6WGOS4EId11FkBZMWvRUFX12JeK/
 DcOjvG9ZI1o/gmM7xZUfiYrF5Dve/MyjQ2KVirVgInQTgrC2aYADP/up5ehgVo2f5KzT
 RAFw==
X-Gm-Message-State: AOJu0Yw3mCCyBiGA004NHl3dfokdSZJK2etKJl9jj/z5HE2lKvAsjwrF
 /TePW9GF4sFY61KxbwaA9w/2bik2RP/8dHOAZxJiFoCBeQZAzLiLveYS8UcT7SsUTr3aM453fc2
 Fof+BxoQnAGf0p+zNORu+V85Yw0Ho6RhM0uEbHA==
X-Gm-Gg: ASbGnctpYIDPj8wfnEssf07O0Vuh9IIzzaq4Oyt15zKYnw97/0RQVSzgkO8fKzG3TkV
 tj435ZaE12+WRNuKVMuM9UJhXzM9P60fDBw9lKw==
X-Google-Smtp-Source: AGHT+IGkzSnWet1OqYZSPa5OIpYvDMDkva/wNxEBxjzM0T20wYKFG40zxswzzMpV8AUNrFcxdrOUmL5r4bMLf6Wr5WM=
X-Received: by 2002:a05:690c:8:b0:6ef:4a57:fc89 with SMTP id
 00721157ae682-6f279b14117mr18981387b3.19.1734091987302; Fri, 13 Dec 2024
 04:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-5-sjg@chromium.org>
 <CAC_iWjKaywBv3qyk=fHNqH_anC3xT63Ua2=DMG2w1=LEt2vDLg@mail.gmail.com>
 <CAFLszTj8z+CL4FU_6yGjvN82ARYr3ZiWsGd7h9A=p6ObhEKcug@mail.gmail.com>
 <CAC_iWjJtG2qoHEWW8h7hVVU1c6+dPFJ3X7jYSe5H0UzXkSHxcQ@mail.gmail.com>
 <CAFLszTinZrL8VLiMSk-PxWP7oWdY=35kNNUYXXx3EfEz7Z72cQ@mail.gmail.com>
In-Reply-To: <CAFLszTinZrL8VLiMSk-PxWP7oWdY=35kNNUYXXx3EfEz7Z72cQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Dec 2024 14:12:31 +0200
Message-ID: <CAC_iWjL94RJCD4cM+SPS6FRAEM8VoK4kLSovOJFc6sJQ3FaSDA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>
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

Hi Simon,

On Fri, 13 Dec 2024 at 05:53, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 12 Dec 2024 at 08:45, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 12 Dec 2024 at 15:45, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Thu, 12 Dec 2024 at 00:49, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > This uses a few global variables at present. With the bootflow we have
> > > > > the required parameters, so add a function which accepts these. Update
> > > > > the existing function to call the new one with the globals.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
> > > > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > > > > index 8febd325f34..8ebd48547cb 100644
> > > > > --- a/lib/efi_loader/efi_bootbin.c
> > > > > +++ b/lib/efi_loader/efi_bootbin.c
> > > > > @@ -209,18 +209,22 @@ out:
> > > > >  }
> > > > >
> > > > >  /**
> > > > > - * efi_binary_run() - run loaded UEFI image
> > > > > + * efi_binary_run_() - run loaded UEFI image
> > > > >   *
> > > > >   * @image_ptr: memory address of the UEFI image
> > > > >   * @size:      size of the UEFI image
> > > > >   * @fdt:       device-tree
> > > > > + * @device:    EFI device-path
> > > > > + * @image:     EFI image-path
> > > > >   *
> > > > >   * Execute an EFI binary image loaded at @image.
> > > > >   * @size may be zero if the binary is loaded with U-Boot load command.
> > > > >   *
> > > > >   * Return:     status code
> > > > >   */
> > > > > -efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > > > > +efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> > > > > +                            struct efi_device_path *device,
> > > > > +                            struct efi_device_path *image)
> > > > >  {
> > > >
> > > > This needs to be static here. Not the next patch. But I don't think we
> > > > need this at all (look below)
> > > >
> > > > >         efi_status_t ret;
> > > > >
> > > > > @@ -236,6 +240,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > > > >         if (ret != EFI_SUCCESS)
> > > > >                 return ret;
> > > > >
> > > > > -       return efi_run_image(image_ptr, size, bootefi_device_path,
> > > > > -                            bootefi_image_path);
> > > > > +       return efi_run_image(image_ptr, size, device, image);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * efi_binary_run() - run loaded UEFI image
> > > > > + *
> > > > > + * @image:     memory address of the UEFI image
> > > > > + * @size:      size of the UEFI image
> > > > > + * @fdt:       device-tree
> > > > > + *
> > > > > + * Execute an EFI binary image loaded at @image.
> > > > > + * @size may be zero if the binary is loaded with U-Boot load command.
> > > > > + *
> > > > > + * Return:     status code
> > > > > + */
> > > > > +efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > > > > +{
> > > > > +       return efi_binary_run_(image, size, fdt, bootefi_device_path,
> > > > > +                              bootefi_image_path);
> > > > >  }
> > > >
> > > > We don't need functions and wrappers for such a simple call. Just
> > > > update all the callisites with the extra parameters and keep one
> > > > function
> > >
> > > If you look at the two call sites, you'll see that they would need to
> > > pass bootefi_device_path and bootefi_image_path in. but these are
> > > static variables in this file.
> >
> > Ah fair enough, then please rename efi_binary_run_ -> _efi_binary_run
> > ands make it static on this patch
>
> I don't mind where the underscore goes. I changed my mind about that
> when the dtc maintainer pointed out that C-library functions start
> with underscore, so putting an underscore at the start of the function
> is confusing things.
>
> "The underscore prefix is reserved for functions and types used by the
> compiler and standard library. The standard library can use these
> names freely."[1]
>
> But I don't mind. We don't even use the C library except for sandbox
> and tools. So let me know what you think.

I don't mind really. you can do __efi_binary_run() or keep whjat you
have. I jsut find the leading underscores a bit easier to read and
spot, but not a huge deal

Thanks
/Ilias
>
> Regards,
> SImon
>
> [1] https://stackoverflow.com/questions/39625352/why-do-some-functions-in-c-have-an-underscore-prefix
