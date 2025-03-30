Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301DAC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 13:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 304F980FDA;
	Sun, 30 Mar 2025 15:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y8hXrV8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D1F81879; Sun, 30 Mar 2025 15:29:19 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884EE80F9C
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 15:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3965c995151so1948975f8f.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743341357; x=1743946157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/pvf0FVIPVEiWNt2gxmK6FtYz2pSGKkXZw1X21OYMec=;
 b=Y8hXrV8vKI3w0e+Bia7dfw3zu3flXtbWv0ilaHbr1n8MfaK45+pGKhUIoDHqs+5j8Z
 P3NopCd4PUfBVMO9lcX5LT/wfPpICswoLZSSLUqXIyM3mCyUVYwFGTadsGIuTpm55pAe
 lxAH9vcb+fsAcG+1y0gkPa5+UI62YWkVlr0MwrNiq/lhN8tDr92xdikHVGd8wvAuAWiR
 Aki7SXJFvta5BPh0gj8HHPAlQv+ZzlGimBgALHsOEHDqtaZ0At26wxCjZYOucLfstSgQ
 OebbL5wr9EH5MCHu+RC3Hviw8b3hUkz3og/cumVOy+mz7+nPdSj21NKXA7KTtipcPNik
 7hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743341357; x=1743946157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/pvf0FVIPVEiWNt2gxmK6FtYz2pSGKkXZw1X21OYMec=;
 b=i8csFuUW5DZlBRaoA7pBW6R4Y3+eoQNLMI5X72uHDPI/v4PrV1jF4NArnK49Dg/EyQ
 hOqWO+2lWYTN4MKKjtu2dwPgIBkOiyuHLmSUQLvRl/3m3UeriLlRxQPY45YmAuQHD4AJ
 eTm0B4as+qevDv9YT0mTutYxGN2HLkwCQyJfPBblr3YZJQ7APFQfFOssnwcIs0fEVSf1
 CP32VrZkUJWeoZouOuRP5dwc4/7XW9ydYSZAA8GaQF8FJVF0fGPvvbi94ftzxgMlbsYb
 N0iAac5dQknwZYlB5DQB1Gku4cJ/Djj2uGfbBz9nCblH0gdi4QwcEoH/SSUw4asHjul1
 a+sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLv4EtYZFYLAMXwjTxOXa5Qu1NgsbujHJyWfmsd9fW6ARYx2t0zNLrn86J91UIrWaNQDakHIE=@lists.denx.de
X-Gm-Message-State: AOJu0YzZZmeBHgmZqmTqlvg8zOwcgXOoUfIRUPWAcya2Z7zpma6ijBzv
 t1IFNHUbLDAOITZgni0lCOK8Nsif8Jda3YtIVf0hHeeG1A+xexIDnKW3Z0xf7hjj3GmFgJrP4kZ
 7nfLJilkXvkLrgKubaKUGp5hZamXeWsCXr7ZK/g==
X-Gm-Gg: ASbGnctuMvdvvJuMjn2SBbiIDn/4qN/WgHI+29IJlD3w1z3NpBugRCtXdMb5hO26zFY
 VnAUsNHVpj6inURmYgYEZtqRPcUVcvYbQyjQ0FBtHno9O/CpdvGBay0Zvj7BJiiNEUicQe9UtC8
 1XLgAtm3jJ8GNYB+zN1+6AHeQJlRksigsoEpOxbeKpr+sx+5q9DOadsE8tZcM=
X-Google-Smtp-Source: AGHT+IHM0XhMy0kXuqiLceqKH5lQERoJD+nTntYu8FIREgDXXjhy0EoAwNWWL5+sn5y/4Vwpm3zD+Ped9l4ucN4BIt4=
X-Received: by 2002:a05:6000:2b05:b0:390:f9d0:5df with SMTP id
 ffacd0b85a97d-39c1211d7a6mr3262256f8f.52.1743341356857; Sun, 30 Mar 2025
 06:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
 <CAFLszThUo1u58Vwy77UEQZG79f7-BB2ysB5-oq-DHbP4c_ciRQ@mail.gmail.com>
 <CALeDE9MFGFEUmOHyOFFyLL4TeaZKjDSt+LBEfNEGgHSdtwDetg@mail.gmail.com>
In-Reply-To: <CALeDE9MFGFEUmOHyOFFyLL4TeaZKjDSt+LBEfNEGgHSdtwDetg@mail.gmail.com>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Sun, 30 Mar 2025 14:29:06 +0100
X-Gm-Features: AQ5f1JqX9UAjoUvT_7DJFilLSaiR5_uoJjMqMjpnIVQ2mRD-ZqYAcWy5--rsJh8
Message-ID: <CACr-zFCecvu=VGp9ncHSF1QY6U-hu_NgxLoij6O5n8nsjao-Mw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] rpi: Tidy up booting
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, 
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

I tried to boot a mainline 6.12 kernel on a CM4 with U-Boot 2025.01;
it doesn't work without this patch series and complains that the DTB
is mangled. Not sure why, as there appears to be adequate space in
that gap.
I didn't look much further than setting alternative load addresses for
it to work (without this series). With this series it boots perfectly
out of the box!
I will add some tags to the individual commits shortly.

For reference the working addresses I used were:
setenv kernel_addr_r 0x02000000
setenv fdt_addr_r 0x10000000

Side note: It would be quite nice to add kernel_comp_addr_r and
kernel_comp_size to be able to boot compressed kernels; I will put
this on my TODO list for some day.


Cheers!

Chris

On Mon, 3 Feb 2025 at 03:41, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Thu, 30 Jan 2025 at 19:55, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi,
> >
> > On Thu, 19 Dec 2024 at 17:34, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
> > > ramdisk, by expanding the available space.
> > >
> > > It also tidies up some strange behaviour with the provided FDT, where a
> > > separate pointer is maintained to it, even though U-Boot has copied it
> > > and placed it in its own space. This avoids strange bugs where it
> > > accidentally gets overwritten when loading a file into memory.
> > >
> > > The patch to expand the devicetree was dropped, meaning that people
> > > should be careful to unset fdt_addr in the environment.
> > >
> > > In version 2, it incorporates some changes to fdt_addr, etc. suggested
> > > by Tom, as well as adding myself as a maintainer.
> > >
> > > Changes in v4:
> > > - Expand the comment on set_fdt_addr()
> > > - Update the commit message to talk in terms of my testing
> > >
> > > Changes in v3:
> > > - Add to the existing comment block
> > > - Update the comment block with the new values, including compression
> > >
> > > Changes in v2:
> > > - Add new patch to make myself an rpi maintainer
> > > - Add new patch to set bootm_size
> > > - Add new patch to drop fdt_high and initrd_high
> > > - Drop patch to allow expanding the devicetree during relocation
> > >
> > > Simon Glass (5):
> > >   rpi: Add myself to the list of maintainers
> > >   rpi: Set bootm_size to 512MB
> > >   rpi: Drop fdt_high and initrd_high
> > >   rpi: Update environment to support booti and large initrd
> > >   rpi: Use the U-Boot control FDT for fdt_addr
> > >
> > >  MAINTAINERS                   |  1 +
> > >  board/raspberrypi/rpi/rpi.c   | 20 +++++++++----------
> > >  board/raspberrypi/rpi/rpi.env | 37 +++++++++++++++++++----------------
> > >  3 files changed, 31 insertions(+), 27 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
> >
> > We have hit rc1 now. Is there any interest in applying this series?
> >
>
> I have started testing it but I am traveling so have limited devices (and
> time) to test and I want to do more thorough testing on my return later in
> the week.
