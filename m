Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE2EC28B20
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 01:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75280805C8;
	Sat, 29 Mar 2025 02:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tTKdJZDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A120D809A5; Sat, 29 Mar 2025 02:17:21 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555A18059D
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 02:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-30185d00446so3823664a91.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 18:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743211037; x=1743815837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f8qWFrZ+DsbmVZf3xb9mVmpVW2Sxd4LepFc8cZ7Ag0E=;
 b=tTKdJZDcZXrR04iQkCzf4b7qq3rdxTYogWYIuBCAo1avARdQe9ae7Yt82K8dfz9nQc
 vLY4VkB5pefPxaRArTUnHKuWHCULMiEq88Ncrv5PbbyPYFB3bhF6l1bsMLSU+A9WrxB4
 Px9SgE4dyGHa/yn/PUePTlTJbBaaE2Qw61u17kmHsAClG3S+tBZgLX3Q/wQUJacD15WM
 DFtNUuvFOretw++B7U96R+eI2J9XnWKJQDzvRiJZnYR4P6NWcVY4sDWhx2/JdlJ2lRpy
 AyoDCe3XuiWSDH/h41MXAdKAGhMKd0QSJOziRGhemBbwreJWJLdrOLyAOB6Vbn/ynF9Y
 OkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743211037; x=1743815837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f8qWFrZ+DsbmVZf3xb9mVmpVW2Sxd4LepFc8cZ7Ag0E=;
 b=hb7tPkSe1Ej6M6GRu9Mxvb4jsEaBoabZwkT49S4YDTE2a07u8Qhmg3ptHL7KGQkDoK
 hSCqYSgFEgh+kziasBXRwCoJBpJo6Fr+e/P/MBIrxW/AqP5ZGj3qQuoa65s9rainL0sl
 tH1hSsB6FOR+swFj8+WDtCnhuB2CEQoVMUvKzhhddoJVU5nvLAwOMwKCjHTq1+Vv4YQ5
 6rGjTAnck7DqZemfQcnnVGikhikh0hNAMrlfezajB5YkBJGA6W43C2k46WVpP1AfrH87
 aoiPD7TBAtSlU+bU1gBLUQIgNCOvvJf4pUWpjcjAaL1D4uTcTSlvZNaL9lqM17FoYjh/
 OC0g==
X-Gm-Message-State: AOJu0YxJT+Sag8jmKZrO5ELx1LYmN2DcP5YUZaRI731crQqYrziO/2jO
 nubURK1xPrSPu0/F/DpfcFk+kClnChv2eMxuxLUz81Jh3DWbgZrVljjB7skASyUMTD5ymLsx0j5
 nIziDiKT2QIalrXJ6LnTkvgUrBN3eoOdRs/II6w==
X-Gm-Gg: ASbGnctxV0CDPyraGdc0ssrqaX4zNrwtphWr3bGlUf1C64ZlOlEltRpyoxd790nsIM4
 sRB0GxCkE9yNHSD3Z5xAotDHxLVJc5ulltPV+TEGhqAB7LXn3npuezGJcIMWFzKYSt7UVeDBi37
 ijVDKWGZggqOysZJdxIcR48uJtXO2s
X-Google-Smtp-Source: AGHT+IF/QroYx8+aoKblf2JkXaOdc2mUinqU0EsyS0H0ELwxGB3F7QDx5z+X2kWD9/CZJdV7RYBAnYqM3eTJ9RjwM3k=
X-Received: by 2002:a17:90a:d007:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-305319e146fmr2826545a91.11.1743211036547; Fri, 28 Mar 2025
 18:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <CAFLszTjpbxH6_LEuv5mAyOjt812hXvTKL1nDpP42HMJXwMryWA@mail.gmail.com>
 <CAEfUkU+tYjjNQAmwv2=FWkPYxLZriAd3FdAVQQrdt7PTXK_xiQ@mail.gmail.com>
 <CAFLszTiwNM3=ZgFRU+rJN=nmQ9YuS8gkUf_jRNqhSJpuELi09g@mail.gmail.com>
 <CAEfUkU+6O7z_FxuopJ0R8AnqXFPT5jThKn8AkDHLJqrUEi5g4w@mail.gmail.com>
 <CAFLszTiZEsmPaTpD9EZWmQWtURMqTcynmda7K24wFvVoacX8zw@mail.gmail.com>
In-Reply-To: <CAFLszTiZEsmPaTpD9EZWmQWtURMqTcynmda7K24wFvVoacX8zw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 28 Mar 2025 21:17:03 -0400
X-Gm-Features: AQ5f1JrySnJJd1nntSBfOO51xSxMbl0FP5mY0p7sZYnBZxqlOyLIYZLtcnmXM3o
Message-ID: <CAEfUkUL0ofX9eQfbD0GjaG=kSE3ukAQiKFgfUN4ED4dFJ4c3Mg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: fix the overriding of fdt from bloblist
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, Ravi Minnikanti <rminnikanti@marvell.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Fri, 28 Mar 2025 at 11:13, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Fri, 28 Mar 2025 at 08:38, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 28 Mar 2025 at 10:26, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Fri, 28 Mar 2025 at 08:17, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, 28 Mar 2025 at 07:34, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Raymond,
> > > > >
> > > > > On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > >
> > > > > > When a bloblist is valid and contains fdt, it explicitly means
> > > > > > a previous boot stage is passing transfer list compliant with
> > > > > > Firmware Handoff specification, thus the fdt from bloblist should
> > > > > > not be overridden with the ones from board or env variables.
> > > > >
> > > > > Why is that? The board can choose to override it, if it wishes, but in
> > > > > general, if gd->fdt_blob is already set up, it should return -EEXIST
> > > > > from board_fdt_blob_setup().
> > > > >
> > > > First, if a board is running in a "stand-alone" mode, there should not
> > > > be a transfer list passed from the previous boot stage.
> > > > Secondly, overriding the transfer list with the env variables does not
> > > > make sense, since booti, bootm and bootefi are actually using the env
> > > > variables to get the fdt when launching to the kernel.
> > > > We need to do the opposite way - override the env variable with the
> > > > one pointing to the bloblist fdt (See my patch [2/2]), then all boot
> > > > commands can work with the transfer list.
> > >
> > > OK, but now we are going back to the OF_BLOBLIST thing that I did 18
> > > months ago and ended up being the major reason I had to create my own
> > > U-Boot tree just to get my boards working.
> > >
> > > Anyway, Tom has agreed to let me maintain bloblist (and maybe fdt?)
> > > again, so I am going to send a series to 'clean this up' as Ilias
> > > would say. Let's see if that passes muster, because I do agree with
> > > you that if the devicetree is in the bloblist, it should be
> > > definitive.
> > >
> > > Re your second point, do you know why we have fdt_addr? Is it just for
> > > the distro scripts? I'm wondering if we could restrict the use of
> > > fdt_addr to just the places that actually need to use environment
> > > variables.
> > >
> >
> > I understand that there is a clean-up plan from you, so this time I am
> > just trying to minimize the changes (as you can see, just a few lines)
> > to make the transfer list work again.
> > I am also working on the OP-TEE repo project to enable qemu v8 build
> > with transfer list enabled, so users can just use a single command to
> > test the Firmware Handoff feature from TF-A to kernel.
> > But since 70fe23859437, it is broken in U-Boot due to the overriding
> > of the fdt, I made this hotfix in order to let us have the feature
> > work again before the upcoming release.
>
> Yes I looked up that commit but it was over a year ago so I assumed
> that something else was going on.
>

I was mainly focused on the transfer list path from TF-A through
OP-TEE to U-Boot but not much on how U-Boot handles the fdt after it
is exacted from bloblist.
I just occasionally observed this issue when I was trying to use xtest
to run the transfer list unit test I added in OP-TEE a few days ago
and found that the OP-TEE commands didn't work at all in the kernel
due to the overriding of fdt by that commit.

Regards,
Raymond

> Re your project, it would be good to get that running in CI. My old
> standard passage stuff had such a test and I think it was pretty easy
> within U-Boot.
>
> Anyway, this patch doesn't make things any worse.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> SImon
