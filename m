Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD46BE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 15:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB208800D6;
	Fri, 13 Dec 2024 16:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RUNtnTN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08D28012C; Fri, 13 Dec 2024 16:08:23 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CC54800AA
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 16:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so278607166b.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734102500; x=1734707300; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DjUMv/EymDA1SGlesrPYgxnXoOuzjmnHp9xnck1w2Kw=;
 b=RUNtnTN1MfwrwpUnjQn5qcArGoOl+cOf+Fday72GTG6BPTirlgxe9FcF8p2BjGmLaD
 667Z5oNT3keOb8pHM+5hDhRMXIVEoSQ1D7Ji9nVPof/TpdHKPL+tBjeSLaT3kHdvfx67
 qzLXMZ/FJPaZknRlfPBRx7jc2uv9Ym3z0hS+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734102500; x=1734707300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DjUMv/EymDA1SGlesrPYgxnXoOuzjmnHp9xnck1w2Kw=;
 b=C7P+MPWODZfaYayjxfkO6eThIkkUusxZcKVAtHoPumIkg/Uep/CGTlUP+M7nyqjQAx
 A/6dkMUSAGCkSnZfloiTP102/Fvz+OcMQ+2i6JyvoRM0RsA1To44edG3ZE0IueJ1T21F
 x35YnuYrkcyK6Lk7JfSl1zLkbKmkz9aB+TSjU6w1Mh/rQD2ioH0aiTj39Er6pGla+P5/
 ui4JknPCjq0w+8qcZasBh2yCn1/Fh/7pDUun5HLqhN2GY5UPRbwJ7Rqz5JoPwXz1Zp9c
 77j6+nRKvZ93g8OdBcKmOB0duUtTH1WXB0Yn4//CfX3feHhRZrlAUf7HjDUr6zCJOJxk
 UxqQ==
X-Gm-Message-State: AOJu0YyHkSvxiSzfYqMHcE2dHnp7BsdN/5L+jSGYDvD6S48fBRktOZCL
 rN9Rrf3JrtNfoRtpLRUFElQVMRTtFXnaCZZbho9/P5BBTxlZYPJ0+rILJwrnRbfcx9MGigj5B4f
 O+K2QpsJhufQ2nydLVhjz8T01YkM8YBQrG5xV
X-Gm-Gg: ASbGncuMJCbhpSrKRNtKrJ4w6X0/4V3e2jkhlNYX0X/jxi+1NJxHoF6ea1L81jzjcv9
 HG+F/nCuBtKCW+k10cHSdMl5kh3DABuTeDMcamcU=
X-Google-Smtp-Source: AGHT+IFKCV4wOdbXzBdDM0ZyuLBdNXSgMjOXJ214xTmrucydNt0uelZti7qsf8/QxEa/c5urx3s9JAtn2BbF+H3c8Ds=
X-Received: by 2002:a17:906:f597:b0:aa6:1c6a:30a1 with SMTP id
 a640c23a62f3a-aab779cffcbmr330778266b.32.1734102498967; Fri, 13 Dec 2024
 07:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-5-sjg@chromium.org>
 <CAC_iWjKaywBv3qyk=fHNqH_anC3xT63Ua2=DMG2w1=LEt2vDLg@mail.gmail.com>
 <CAFLszTj8z+CL4FU_6yGjvN82ARYr3ZiWsGd7h9A=p6ObhEKcug@mail.gmail.com>
 <CAC_iWjJtG2qoHEWW8h7hVVU1c6+dPFJ3X7jYSe5H0UzXkSHxcQ@mail.gmail.com>
 <CAFLszTinZrL8VLiMSk-PxWP7oWdY=35kNNUYXXx3EfEz7Z72cQ@mail.gmail.com>
 <CAC_iWjL94RJCD4cM+SPS6FRAEM8VoK4kLSovOJFc6sJQ3FaSDA@mail.gmail.com>
In-Reply-To: <CAC_iWjL94RJCD4cM+SPS6FRAEM8VoK4kLSovOJFc6sJQ3FaSDA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Dec 2024 08:08:07 -0700
Message-ID: <CAFLszTgQr-czmdwzHbNvZOxMzUzM0zb8EDUhVLq6ArM+DUe0Bg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Fri, 13 Dec 2024 at 05:13, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 13 Dec 2024 at 05:53, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 12 Dec 2024 at 08:45, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Thu, 12 Dec 2024 at 15:45, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Thu, 12 Dec 2024 at 00:49, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > This uses a few global variables at present. With the bootflow we have
> > > > > > the required parameters, so add a function which accepts these. Update
> > > > > > the existing function to call the new one with the globals.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
> > > > > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > > > > > index 8febd325f34..8ebd48547cb 100644
> > > > > > --- a/lib/efi_loader/efi_bootbin.c
> > > > > > +++ b/lib/efi_loader/efi_bootbin.c
> > > > > > @@ -209,18 +209,22 @@ out:
> > > > > >  }
> > > > > >
> > > > > >  /**
> > > > > > - * efi_binary_run() - run loaded UEFI image
> > > > > > + * efi_binary_run_() - run loaded UEFI image
> > > > > >   *
> > > > > >   * @image_ptr: memory address of the UEFI image
> > > > > >   * @size:      size of the UEFI image
> > > > > >   * @fdt:       device-tree
> > > > > > + * @device:    EFI device-path
> > > > > > + * @image:     EFI image-path
> > > > > >   *
> > > > > >   * Execute an EFI binary image loaded at @image.
> > > > > >   * @size may be zero if the binary is loaded with U-Boot load command.
> > > > > >   *
> > > > > >   * Return:     status code
> > > > > >   */
> > > > > > -efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > > > > > +efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> > > > > > +                            struct efi_device_path *device,
> > > > > > +                            struct efi_device_path *image)
> > > > > >  {
> > > > >
> > > > > This needs to be static here. Not the next patch. But I don't think we
> > > > > need this at all (look below)
> > > > >
> > > > > >         efi_status_t ret;
> > > > > >
> > > > > > @@ -236,6 +240,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> > > > > >         if (ret != EFI_SUCCESS)
> > > > > >                 return ret;
> > > > > >
> > > > > > -       return efi_run_image(image_ptr, size, bootefi_device_path,
> > > > > > -                            bootefi_image_path);
> > > > > > +       return efi_run_image(image_ptr, size, device, image);
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * efi_binary_run() - run loaded UEFI image
> > > > > > + *
> > > > > > + * @image:     memory address of the UEFI image
> > > > > > + * @size:      size of the UEFI image
> > > > > > + * @fdt:       device-tree
> > > > > > + *
> > > > > > + * Execute an EFI binary image loaded at @image.
> > > > > > + * @size may be zero if the binary is loaded with U-Boot load command.
> > > > > > + *
> > > > > > + * Return:     status code
> > > > > > + */
> > > > > > +efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > > > > > +{
> > > > > > +       return efi_binary_run_(image, size, fdt, bootefi_device_path,
> > > > > > +                              bootefi_image_path);
> > > > > >  }
> > > > >
> > > > > We don't need functions and wrappers for such a simple call. Just
> > > > > update all the callisites with the extra parameters and keep one
> > > > > function
> > > >
> > > > If you look at the two call sites, you'll see that they would need to
> > > > pass bootefi_device_path and bootefi_image_path in. but these are
> > > > static variables in this file.
> > >
> > > Ah fair enough, then please rename efi_binary_run_ -> _efi_binary_run
> > > ands make it static on this patch
> >
> > I don't mind where the underscore goes. I changed my mind about that
> > when the dtc maintainer pointed out that C-library functions start
> > with underscore, so putting an underscore at the start of the function
> > is confusing things.
> >
> > "The underscore prefix is reserved for functions and types used by the
> > compiler and standard library. The standard library can use these
> > names freely."[1]
> >
> > But I don't mind. We don't even use the C library except for sandbox
> > and tools. So let me know what you think.
>
> I don't mind really. you can do __efi_binary_run() or keep whjat you
> have. I jsut find the leading underscores a bit easier to read and
> spot, but not a huge deal

Yes I find them easier to read also. I'll go with a single underscore,
since __ is supposed to be for start-up code, or something.

But Tom asked me not to send anything until Wednesday and I'm heading
off for a few weeks at EOW. Let's see what you decide on the big
series, and then perhaps I can send both before I go.

Regards,
Simon

> > [1] https://stackoverflow.com/questions/39625352/why-do-some-functions-in-c-have-an-underscore-prefix
