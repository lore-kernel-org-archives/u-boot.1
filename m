Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1D0C30653
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 12:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA8AB88670;
	Mon,  1 Jul 2024 14:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="naKemW8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C0C288677; Mon,  1 Jul 2024 14:51:13 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF7F8866B
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 14:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-79c04e6e1b9so225192685a.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719838269; x=1720443069; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Jj6hn/wPpGj2ttyzqOfGFQxy4nn3JvYKDD/5zer5Lk=;
 b=naKemW8+r8Cnm3M0bzNL5XUYdPXHKAH64pmbAVqP9HxLfT2m2sz4koWdNH6mIAXkKl
 WbFbOkwvmKOU7StGxtJgKZZvKL4ktMqqXUj7U4B76JaaUyO8J/axcbhS8gLxgdo+l+Z8
 oE8TP6OXjP+qWGO/g0/skclJbB9045jJG/0/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719838269; x=1720443069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Jj6hn/wPpGj2ttyzqOfGFQxy4nn3JvYKDD/5zer5Lk=;
 b=GpsOVC5cRsGSu3ajOg+cYLzp85i7qRXYyT6uzP2CMlhqAnAR/JxRovDE2VFz1fmuok
 KEG0MxrlmGkML+m6sb7fLvH8zZGY9EAG9LwIw9Mos4x1v9LOcJiSy+/gWFuPPeaveJIz
 c1l27Vu8vVeBK9/MRRTHhJsuhUFCtO2wc8qiAirdllipI3ad0EeFJxPZ9aVyJAOGpyUE
 1q05UuhTo/W/xqX+8wMDuYNQkS3N9tRmpIDGjmrCo28lyXVTK/3ibd3BV9HDiUHlgJZl
 TNTcesN8uTx6T3hmLOuQyk4wNYbqIoFrVwcDP+g5nx6qMUkVS3BTgsJpVKblo/8wJ3Dy
 yEyg==
X-Gm-Message-State: AOJu0Yz1AYbHYylcL6Zu6P+qodSX1nWttHj3TANfKRYT00uvA/ZituJw
 xP1iUpdGyMf5WPDnAH/zZUuwXXn5GgwQwbCeTuBWEqUOWOeKUp1nxgQ4841lj6/qZcNIMlqgTP1
 x4Bf2ClL+eS7pOcyc8DPlvk4Puma8+Ltgwayl
X-Google-Smtp-Source: AGHT+IEaMjnJrcvntb8qlqS27dvioEUuVdzQhCyC8SFs0LLHm7VhXyX/2izjyAxCdIxxdZOJt8JjPSGTfSdW3NmLhHE=
X-Received: by 2002:ad4:5766:0:b0:6b5:2655:4518 with SMTP id
 6a1803df08f44-6b5b70a3b52mr87641076d6.20.1719838269293; Mon, 01 Jul 2024
 05:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240628024804.149871-1-marex@denx.de>
 <CAFLszTh_u8ipmSqyi73TVZ=kCGnk8mnb7Ww3HeHwUXSEdGqVEg@mail.gmail.com>
 <4a6085d9-9c52-49a1-8c36-c3d1094b8a28@denx.de>
In-Reply-To: <4a6085d9-9c52-49a1-8c36-c3d1094b8a28@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jul 2024 13:50:58 +0100
Message-ID: <CAFLszThFjnjWQLHd5G-LBrkZwxQkvq9PeRHZ0=kSTqhs7K-6CA@mail.gmail.com>
Subject: Re: [PATCH v2] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

Hi Marek,

On Sun, 30 Jun 2024 at 06:24, Marek Vasut <marex@denx.de> wrote:
>
> On 6/28/24 9:32 AM, Simon Glass wrote:
> > Hi Marek,
>
> Hi,
>
> >> ---
> >>   common/spl/spl_fit.c                | 29 +++++++++++++++++++++++++++--
> >>   doc/device-tree-bindings/config.txt | 11 +++++++++++
> >>   2 files changed, 38 insertions(+), 2 deletions(-)
> >
> > Once this is figured out, can you extend test/image/spl_load_os.c to
> > test this code?
>
> It seems there is nothing which would do even basic tests for SPL
> fitImage DT handling in that test? Or am I reading the current test wrong ?

That test handles loading of a FIT, but doesn't check what happens to
the DT. You could add more asserts to spl_load_test(), or create a new
test. You can run it in the sandbox_spl build with:

sandbox_spl/spl/u-boot-spl -u -c "exit"

>
> >> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> >> index 988125be008..0a6b5ea8212 100644
> >> --- a/common/spl/spl_fit.c
> >> +++ b/common/spl/spl_fit.c
> >> @@ -363,6 +363,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
> >>   {
> >>          struct spl_image_info image_info;
> >>          int node, ret = 0, index = 0;
> >> +       char dtoname[256];
> >>
> >>          /*
> >>           * Use the address following the image as target address for the
> >> @@ -448,9 +449,13 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
> >>                          if (ret < 0)
> >>                                  break;
> >>
> >> -                       /* Make room in FDT for changes from the overlay */
> >> +                       /*
> >> +                        * Make room in FDT for changes from the overlay,
> >> +                        * the overlay name and the trailing NUL byte in
> >> +                        * that name.
> >> +                        */
> >>                          ret = fdt_increase_size(spl_image->fdt_addr,
> >> -                                               image_info.size);
> >> +                                               image_info.size + strlen(str) + 1);
> >
> > Oh and I missed the room for the property, sorry. It needs something like this:
> >
> > ALIGN(strlen(str) + 1, 4) + 12 + 4
> >
> > the first bit is the string-table size increase
> >
> > 12 is sizeof(struct fdt_property)
> > 4 is the u32 size
> >
> > Alos, is there any way to check that there is actually enough space to
> > increase the size?
>
> fdt_increase_size() would fail if there isn't enough space, so that
> should cover the check.

Yes it does, but I meant the memory about the DT. Do we know how much
space space there is to increase the DT into?

>
> >> diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
> >> index f50c68bbdc3..7aa6d9a72c6 100644
> >> --- a/doc/device-tree-bindings/config.txt
> >> +++ b/doc/device-tree-bindings/config.txt
> >> @@ -95,6 +95,17 @@ rootdisk-offset (int)
> >>   silent-console (int)
> >>          If present and non-zero, the console is silenced by default on boot.
> >>
> >> +u-boot,spl-applied-dto-* (int)
> >> +       Emitted by SPL into U-Boot control DT root node in case a DTO from
> >> +       fitImage was applied on top of U-Boot control DT by the SPL fitImage
> >> +       loader. The single integer cell indicates in which order was the DTO
> >> +       applied by the SPL and matches the index of the DTO in the fitImage.
> >> +       DTOs in fitImage may be skipped using board_spl_fit_append_fdt_skip(),
> >> +       therefore the integers might not be monotonically incrementing, there
> >> +       may be gaps. This property can be used to determine which DTOs were
> >> +       applied by the SPL from running U-Boot by inspecting the U-Boot
> >> +       control DT.
> >
> > Should we send a binding with this? I wonder if it would be better to
> > make the filename a property value rather than including it in the
> > property name/string table? That way you would not need the
> > integers...the ordering would be enough.
> >
> > E.g.
> >
> > u-boot,spl-applied-dtos = "fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast",
> >        "fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast";
> >
> > But that might be more annoying to construct as you would probably
> > need fdt_setprop_placeholder()
>
> It is easier to test for a presence of property from U-Boot shell, also
> the property is integer where the integer indicates the index of the DTO
> when it was applied.

Right, but in my suggestion the ordering is obvious, from the stringlist.

Regards,
Simon
