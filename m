Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0696CF395D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6DB891FB;
	Thu, 19 Sep 2024 17:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W50nOUVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D6A78927D; Thu, 19 Sep 2024 17:36:25 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B43D891FB
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c54b1f52f7so6090076d6.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726760182; x=1727364982; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Yi63NK3PzUHhOCnPvq+9jLkTdhdJpivMI4mS+qhjCI=;
 b=W50nOUVNZSE9QoncV2CK/sgopOT4l7tvKvnQjFXOdUR0+C2Lbx6vFxXA6p0pMx+m04
 1G0QwArbJ8H3wu9iuk2oLrgwwcDBlQNgPBEfY69sHwi0RbG2ZyPTz5Fp+LWjPgihUgen
 mqtpoa96WgToY+Bi77yOjQSsvd56qNkmu4ycc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726760182; x=1727364982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Yi63NK3PzUHhOCnPvq+9jLkTdhdJpivMI4mS+qhjCI=;
 b=DNr4ZCzARAGh06tYBAPZjhDK5eaOSrwzV+j3pyMc2Rj092gWtdILB0Ee5D0QjyP4X7
 LM0Kk0sIimJjJUYI3NP5FO6EUz5eImb43WDfdqx7Pls8XAoEZVGtE1F6oJf0AqPeVUMF
 BgWHRAuY+/B8W4K9IOD+LvzVFa1N0sP1vm9xtZn6YkRifCMuGXQVEFjHfUqr1lVavtJx
 n2I7e/o7491/xzgZ0lLqwJPZdSZaiwJJf4JWjFkZrGuutOHXudq4TmeySquUfGXfoXwB
 53rL9AbKVRgrOyTVQYKCaVIBE8PKg0Z6onfZZbtZXLl+70FyEf1Ed8DxXVJq+hm9thb4
 ZhbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmtdBd2Pzt+gNy516nxazVh82911BrTf7oApZtPPzb0fCLFXSMj9WPLvbaTQ09fjjrs4VYJZg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/WazyPxehshTGRGm+s6t8Blm/dLcpCzfDa8EoPOv+2yn+tfOi
 cXoOjox7Vy3P/2gJF/kvdyVwX4LPoHhUt8bg6GXFumNsdB7t04EK4O3j8MfGY8qxeKvb9EdgEg0
 IsuQqoWcCjAXaI1JF0jYWBEZBmlMEd1qYrR0l
X-Google-Smtp-Source: AGHT+IF4ryLywuREX2cOaPe5YqEJ/AutqphwLT5wHbfCLvQ9OshDPld1xaVW56mpRIjcYgBzj/ryuqOkUAvNaAfqijY=
X-Received: by 2002:a05:6214:5992:b0:6c7:5e91:bf7 with SMTP id
 6a1803df08f44-6c75e910c0cmr45068926d6.4.1726760181792; Thu, 19 Sep 2024
 08:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-15-patrick.rudolph@9elements.com>
 <CAFLszTimAFGocvqbnT=JVsA2bjNa=ZfxP6Sy46a9e6VkhtdojQ@mail.gmail.com>
 <CAC_iWjLASm6U8kC68MJ0uZ14MGFS_SSL3Pcd8hcEH=a=W8gvBQ@mail.gmail.com>
 <CAFLszTgYHO7FgbCgfRwqT_yj4KBm31xKdEUrn0pZkhtLzOh=HQ@mail.gmail.com>
 <CAC_iWjKv+Z4K5xPW6MZhBZ67-rDy9iRVaoqfLKmJRwSG9nKnfA@mail.gmail.com>
In-Reply-To: <CAC_iWjKv+Z4K5xPW6MZhBZ67-rDy9iRVaoqfLKmJRwSG9nKnfA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 17:36:10 +0200
Message-ID: <CAFLszThA5eOM_xiMgDu=B4wAcP7wV9bzfc565rES8z6d1F8fjg@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, 19 Sept 2024 at 17:20, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
>
> [...]
>
> > > > > +
> > > > > +               if (!addr)
> > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > +       } else {
> > > > > +               pages = efi_size_in_pages(TABLE_SIZE);
> > > > > +
> > > > > +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > > > > +                                        EFI_ACPI_RECLAIM_MEMORY,
> > > > > +                                        pages, &new_acpi_addr);
> > > > > +               if (ret != EFI_SUCCESS)
> > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > +
> > > > > +               addr = (void *)(uintptr_t)new_acpi_addr;
> > > > > +       }
> > > > > +
> > > >
> > > > The tables should be written regardless of whether EFI_LOADER is enabled.
> > >
> > > *Why*? How do you expect to hand them over to the OS?
> >
> > Why - because boards which need ACPI tables to boot should generate
> > them;
>
> Noone argued that.
>
> > also this happens when U-Boot starts up, in last_stage_init()
> > How - it isn't possible, but eventually I suppose it will be, once we
> > have a use case for booting with ACPI but without EFI
>
> Are you aware of such an OS? If not, we can accept the patches when we
> have a reason.

Which patches? This is how it works today. We set up the tables in
last_stage_init(), so they can be examined while in U-Boot.

It is the patches to change this which I object to.

> I remember patches being hard NAK'ed on using DTs to pass the ACPI
> table address in the past.

Yes, I believe Bytedance carries a patch locally for that :-)

>
> >
> > >
> > > >
> > > > Can we drop this else clause? We should always use the bloblist.
> > >
> > > Both Heinrich and I said the exact opposite. Unless there's a
> > > perfectly good reason why we should keep them in bloblist memory, I'd
> > > like us to do that
> >
> > The main reason is that we should not be putting things in memory
> > between the start of RAM and the bottom of the U-Boot area. That
> > region of memory is supposed to be for loading images. Most boards
> > hard-code the image-load addresses in environment variables. But even
> > if they didn't, we should not be using that memory for U-Boot data.
>
> EFI allows you to request a specific address to use. We can choose one
> that fits the requirements

So long as it is in U-Boot's space, that is fine. I just sent a patch
about relocation which covers this. It occured to me that this feature
of U-Boot, which I have always assumed was common knowledge, may have
not been noticed.

> >
> > Another reason is that the bloblist is designed for this, for keeping
> > tables in a small, contiguous area of memory, so that when passed to
> > Linux they are not spread all over the place.
>
> Linux does not and will not read tables from a bloblist though

Indeed. There really isn't any point, anyway, since there are other
ways of passing the tables along...except for ACPI with FDT but that
isn't a valid use case for Linux so far.

Regards,
Simon

[..]
