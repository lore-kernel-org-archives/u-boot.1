Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06C1C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6619081F66;
	Mon,  5 May 2025 17:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z1C4fyQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D86B81FAB; Mon,  5 May 2025 17:37:50 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB353801BE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f6214f189bso8655699a12.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459467; x=1747064267; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ET4J9gPBjIZ85iu+3BjLQA9TOkWMOC3ugJmGUQl5xS8=;
 b=Z1C4fyQjRL0SHldcK6RI/n/3g9nJLTYTlOwR6qnge1GoaK6mVF6iLc0mHdxHrDa9Tr
 KwWGk4U1dgEtA5IzmFpk+I5eYfqquBFlNtejzH3ynceBcdc18C0UeDpalOwuRzDla46r
 05Dal/EC5Y4AiOBZDhD4xDoBqHMFV7faMe4lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459467; x=1747064267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ET4J9gPBjIZ85iu+3BjLQA9TOkWMOC3ugJmGUQl5xS8=;
 b=rvXUG9fGTgHpCiMWsIaz03F15ZRHYOj40DnhnDJpcFfCqj3AOg7ZOURkAPrqE6zqeF
 5XgrTW9sn8Bv68lFas/dLbWjPEmfaqGs8XoUxeOC58ZYOzN9s4v1nL3w8UpQ+gbI4Fvd
 mUAkLQPbvYUaxrmFjjFT8WIBACZizpZQylDhiRQg/oZ5WU6ARNfxAYG4k0tVWHtQgESY
 xhitIxagJYd3sGiHOcVlBVCxt8EnVDBA0cktRiXIFujZTMzVZ9FfN3/NvujukeShL18S
 DIP9Gu/b+YTbOKd2KY8rJwzD/SLEqxR6o23QJLRiwQL5KuDemL8XCXMBg6pe5JtKJsL4
 sDhQ==
X-Gm-Message-State: AOJu0YxSWPjGt+hPGgcw8AnDH08u51hxKEnskGAA+G1Y4N1NsDvY0LDr
 F3rbPDT1+sayL45k8ovyMJwGLZj+tGKNEZLQJ9MvfHwHNxCYhYmRL7Y37KK2g3+/4J9200kz98r
 pVe4n5x9OVvwCV+ejcIkz4ABSaP+xgQbPrOjF
X-Gm-Gg: ASbGncsZmoFhvgKNVL/5nW6KBHuElJgVisWnDP4YklsYiGMxeQ5I+0vH+Uc09w82kC2
 T0FC+REzVxZ++2GEdopkfGbIFh4ZtRvwZ/WML+LWZnFpaRUkVupSWhQmx119VcnvOJ6vnDESCIE
 zsMjW9c80Sb1MDmMsf7C4Bwh8=
X-Google-Smtp-Source: AGHT+IHiHbp2JvxRz5dEtoJt+EeqIFTadOg9A53SMBLP4kIzTsOKJDbdPYHtVxcy/B3GCAmbt00ciRoDg27wDsgvsYQ=
X-Received: by 2002:a05:6402:3584:b0:5f8:504a:88c9 with SMTP id
 4fb4d7f45d1cf-5fa77fe6c0dmr12200000a12.7.1746459467273; Mon, 05 May 2025
 08:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250501133726.2627373-1-sjg@chromium.org>
 <20250501133726.2627373-16-sjg@chromium.org>
 <5403d72f-65b3-47f8-912e-d1b64e111f00@cherry.de>
In-Reply-To: <5403d72f-65b3-47f8-912e-d1b64e111f00@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 May 2025 17:37:33 +0200
X-Gm-Features: ATxdqUEWC-D2pcmjULfWJqwNubfqKeLxe8CJWhqQKuVTG5h38y2sk0nu8Q4zsKc
Message-ID: <CAFLszTh1Sm9ymBDRLqwncaSHyRVYiabsQvd-hUrzLwo2iOvUnQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] bootstd: Provide a command to select the bootdev
 order
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On Mon, 5 May 2025 at 10:34, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 5/1/25 3:37 PM, Simon Glass wrote:
> [...]
> > diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
> > index 9bee73ead58..294865feb64 100644
> > --- a/boot/bootstd-uclass.c
> > +++ b/boot/bootstd-uclass.c
> > @@ -6,6 +6,8 @@
> >    * Written by Simon Glass <sjg@chromium.org>
> >    */
> >
> > +#define LOG_CATEGORY UCLASS_BOOTSTD
> > +
> >   #include <alist.h>
> >   #include <blk.h>
> >   #include <bootdev.h>
> > @@ -132,6 +134,22 @@ const char *const *const bootstd_get_bootdev_order(struct udevice *dev,
> >       return std->bootdev_order;
> >   }
> >
> > +void bootstd_set_bootdev_order(struct udevice *dev, const char **order_str)
> > +{
> > +     struct bootstd_priv *std = dev_get_priv(dev);
> > +     const char **name;
> > +
> > +     free(std->bootdev_order);  /* leak; convert to use alist */
> > +
>
> leak? and aren't you using alist already?

Not for this, yet.

>
> [...]
>
> > diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
> > index 98a0f43c580..abede194cba 100644
> > --- a/doc/usage/cmd/bootdev.rst
> > +++ b/doc/usage/cmd/bootdev.rst
> > @@ -13,6 +13,7 @@ Synopsis
> >
> >       bootdev list [-p]        - list all available bootdevs (-p to probe)
> >       bootdev hunt [-l|<spec>] - use hunt drivers to find bootdevs
> > +    bootdev order [clear] | [<spec> ...]  - view or update bootdev order
> >       bootdev select <bm>      - select a bootdev by name
> >       bootdev info [-p]        - show information about a bootdev
> >
> > @@ -78,6 +79,27 @@ To run hunters, specify the name of the hunter to run, e.g. "mmc". If no
> >   name is provided, all hunters are run.
> >
> >
> > +bootdev order
> > +~~~~~~~~~~~~~
> > +
> > +This allows the bootdev order to be examined or set. With no argument the
> > +current ordering is shown, one item per line.
> > +
> > +The argument can either be 'clear' or a space-separated list of labels. Each
> > +label can be the name of a bootdev (e.g. "mmc1.bootdev"), a bootdev sequence
> > +number ("3") or a media uclass ("mmc") with an optional sequence number (mmc2).
> > +
> > +Use `bootdev order clear` to clear any ordering and use the default.
> > +
> > +By default, the ordering is defined by the `boot_targets` environment variable
> > +or, failing that, the bootstd node in the devicetree ("bootdev-order" property).
> > +If no ordering is provided, then a default one is used.
> > +
>
> Not sure what's the benefit if we can simply set the environment variable?

The environment variable is there to maintain backwards compatibility
with the distro scripts. It now seems that we are unlikely to ever
drop those, but you never know.

>
> FWIW, it's what we do in
> board/theobroma-systems/common/common.c:setup_boottargets()
>
> One of the benefits I see is dumping the order if that variable isn't
> set (and also not in the DT), but shouldn't that be information we
> should be getting from `bootdev list` instead?

In general, the ordering is not known until a scan is completed, since
scanning can invoke hunters to find other bootdevs not visible prior.

>
> The point I'm trying to make is do we need yet another way to set the
> bootdev order? Printing the order would be welcomed I guess but that
> could be as simple as printing boot_targets environment variable, the DT
> property or whatever the default is if both are missing.

As above, the boot_targets var is for backwards compatibility. The DT
property is fixed and cannot be changed at runtime. So I believe we do
need this command.

>
> If we are to keep the clear command, I would use a flag instead of an
> argument to be consistent with the other bootdev commands, e.g.
> something like `bootdev order -c`.

Yes that sounds better, thanks.

>
> > +Note that this command does not check that the ordering is valid. In fact the
> > +meaning of the ordering depends on what the bootflow iterator discovers when it
> > +is used. Invalid entries will result in no bootdevs being found for that entry,
> > +so they are effectively skipped.
> > +
> >   bootdev select
> >   ~~~~~~~~~~~~~~
> >
> > @@ -171,6 +193,20 @@ This shows using one of the available hunters, then listing them::
> >                   Capacity: 0.0 MB = 0.0 GB (1 x 512)
> >       =>
> >
> > +This shows viewing and changing the ordering::
> > +
> > +    => bootdev order
> > +    mmc2
> > +    mmc1
> > +    => bootdev order 'mmc usb'
> > +    => bootdev order
> > +    mmc
> > +    usb
> > +    => bootdev order clear
> > +    => bootdev order
> > +    No ordering
>
> Shouldn't we be provided with a default one?

See above. I suppose we could implement scanning for bootdevs, but
that would need to be a separate change.

Regards,
Simon
