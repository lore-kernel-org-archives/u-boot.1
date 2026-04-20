Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D44EF5A8B6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62AE84413;
	Mon, 20 Apr 2026 21:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NtKk6rQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10E8C843FF; Mon, 20 Apr 2026 21:33:30 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C690084376
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so457608766b.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776713607; cv=none;
 d=google.com; s=arc-20240605;
 b=hnHnU3Jvt6mN6EGqdbOb1D9ICdM4izfvB24Wo7B0FxLmK0I8HWjWuZa0imHpwZc5cC
 oMkUZ1EdlZ3/YwKLm3JM0t1wb+2V0mXiz2bnMFmu8tKTlfZFOr4eBXgeDNjaT6tLaFoM
 yaHTsxFY37/k6Y4TDQ/8F28HlfcbiVJA3E4boGx+uxEbxRGJkVG1k841oglZ4xtkuF+m
 m0fVic76jtYOz6eriTMcVEzMn6vkEPS0b6mn0Y0bxf3gjSvIH21rKl9ya9j/MHUyTiEE
 XLmf79VqVVnfc/eDXg0tB4iIlm5Jza999JRXdeVdMoctLD6nSYgDgq/IFnsFJamPRi6m
 NTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0w5lhyE7lOLb/8C+bj7XsqgucYPTTjWibCRX2IlnABk=;
 fh=hl+4EPCgakLOnk7XW3qrLoLdx2BF565tvPN7+O4zasE=;
 b=EFh+WHmunQDnZrlTRPEG4PTpkWhgAoZsw3n/iyTf2QeJGN2KytAh3V4ti9MXGm912K
 OCEdlelT7bMA+ykXUP6t7wKG2wRfYGcKw0sdERfZcgo9DrjxQn8V5GTm2Y69O9r6ArDN
 S8NtCO6zZ9Fxpy81OlfZdsTw1Wuw/Fpnmj87SNOG1Ki0X5eyjr/av2Dd+H0w6ji+4s3f
 Zr3/14lcFN1B01oBTrcp5wY6wAQDzVzGWQTL12RdHa2SvEXacPI/CLQ+iN0+eXe7F7rN
 re8zU0z4IdJlAfCOZNfb4D8rpC+rVrX6WpCHd+dGN85SWcRafrg0GZBict+5rCr5I7EG
 Fwsg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776713607; x=1777318407; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0w5lhyE7lOLb/8C+bj7XsqgucYPTTjWibCRX2IlnABk=;
 b=NtKk6rQYRa1y4SSeV9txNrc4D0dXxNWN+P4zDNuHG3lNu3L3ZPYfM7Po/SRsp//eZ3
 52ShtbJmGO3gO4dCmVEd10rW5OX+sxYa597JiG+VxbS1xHnSvjMNzpJ0vLhdL1nkuRCq
 LweahlvAE+d1BWZrv+Ur4n15igwGHOkr77QKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776713607; x=1777318407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0w5lhyE7lOLb/8C+bj7XsqgucYPTTjWibCRX2IlnABk=;
 b=ZN6JiKm6d317QQUvHdgz3rJpAq8KUhprdDUG/x/FN2nIY96jzAlZRTvaiZJqqULkwT
 eIVh11bIrf749oiLZ2kRicb+oXRFBMD/z/f1hZwRM0ENwpVoyMMf+DsQtn6pYjibIojg
 /tZQh246QAHo4cZBD5ma3PMZ9NveZbnoU4iJJb2EFn66gPD1cQu9sdJ8oKuJXprm5r8V
 ZPROLdvWBh2GQFCadMXu0LS8HSFqK0d9swM6s9GZPB0SRflSZNry3bNahNDeDyjAXh8u
 T2G5LDO2FGzp1Z+CGAWKV6E8LnlDPkRaPGSGiQ7FQskAhMd9wmEDQJjS1lMoqnlnMxez
 rakA==
X-Gm-Message-State: AOJu0Yytxngjo1az9nEGos+cYFf91+twaDG3lBQfxzwx+22hsy3I8lZS
 WbutkkV8m0HxW0x3yGqWLKjaCKS46gLFbBp9+xnDQJ4otpeoeLrHGvmOf//nNjHHa1H8tIsjgX8
 r2Dmc/SYcxmowb4QYr7PX7ep9QLjx1RpvTV8IR7SEK5Yr+q8z5bIwrQ==
X-Gm-Gg: AeBDieuPvo8DoyjjuGxC05luO+IuV75YETDhOgmwtAa6cAw1XbalpJ0CUHZh17mMISA
 GABh2cG2w4KZAOIeiulYHR9VufeEAIBH2BQlu4R+NIUUpcPTSgE3+v9lrnzHDRQUiwVfTpq/SXG
 l52C84wJFDNcre/3vJj16if/ot1YJvNiCJOelPlQA42bWyCZq/vO1LPNj3wxR2yOdup9KwQW86j
 AllvpHptzPZQXRAgvh2C5/1HuRYW8KVKMWh0Fg/fzdtPCw7ZomO8QSrp0SnYKism8gFArLRP0cK
 PCOYR4uvkyRZmikjPe4V
X-Received: by 2002:a17:907:da7:b0:ba7:62f:9fa4 with SMTP id
 a640c23a62f3a-ba7062fa21cmr321304066b.6.1776713607154; Mon, 20 Apr 2026
 12:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <034a4ae4-b579-42b0-b6b0-3a204737156f@proton.me>
 <CAFLszTgnGxLnEYdPyymLowq9jUTfRyneAPfBLu336MGQB__YDg@mail.gmail.com>
 <48fd3747-7843-4d44-b31d-0ba6ed63c315@proton.me>
In-Reply-To: <48fd3747-7843-4d44-b31d-0ba6ed63c315@proton.me>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:33:11 +1200
X-Gm-Features: AQROBzD1VBtXdwBgVFkKtx481_jSbU3iO2qsMGj608s_-ZRaNwh17_HXAGkKQ-c
Message-ID: <CAFLszTi7pk3+jjuEpdjP4Otk07r92hhGj5jxu7cq2wZ4dMrUUQ@mail.gmail.com>
Subject: Re: How to build U-Boot with a custom out-of-tree device tree
To: Johannes Krottmayer <krotti83@proton.me>
Cc: u-boot@lists.denx.de
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

Hi Johannes,

On Tue, 21 Apr 2026 at 00:40, Johannes Krottmayer <krotti83@proton.me> wrote:
>
> Hi Simon!
>
> Thanks for your answer.
>
> On 4/20/26 2:51 AM, Simon Glass wrote:
> > Hi Johannes,
> >
> > On Sun, 19 Apr 2026 at 02:40, Johannes Krottmayer <krotti83@proton.me> wrote:
> >>
> >> Hello,
> >>
> >> This question is generic and also valid for none RISC-V boards.
> >> I think it's maybe already asked, but didn't find any useful
> >> information this time. My question is, is it possible to pass
> >> a specific device tree blob to the build system from U-Boot?
> >>
> >> Example: RISC-V board Starfive VisionFive 2 8GiB variant
> >>
> >> The default in-source-tree device tree from the VisionFive 2 has
> >> only 4GiB RAM. I own the 8GiB (RAM-IC BiWin BMWZCX32H2A-64G-X)
> >> variant. So therefore can I pass the device tree blob directly
> >> to U-Boot's build system without modifying CONFIG_DEFAULT_DEVICE_TREE
> >> in the device configuration? Exists there an environment variable?
> >>
> >> Want to use U-Boot's EFI subsystem as loader for bare-metal
> >> environments. And I think when I want to get the
>  memory map
> >> via EFI there will with the default device tree only <4GiB free
> >> usable memory shown, although there are 8GiB.
> >
> > You can build with: make DEVICE_TREE=...
> >
> > See dts/Makefile for the logic.
> >
>
> Didn't figured out how it works with the variable DEVICE_TREE
> yet.
>
> But I found the variable EXT_DTB in your described Makefile.
> Have tried it now with a precompiled device tree and it works
> fine.
>
> make EXT_DTB=/path/to/custom_board.dtb

Oh yes, since it is not in the normal directory you need to use that.
I should have pointed to the documentation:

https://docs.u-boot.org/en/latest/develop/devicetree/control.html#configuration

Regards,
Simon
