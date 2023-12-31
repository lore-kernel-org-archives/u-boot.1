Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFD2C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 12:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F09E87721;
	Sun, 31 Dec 2023 13:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I/MmbWq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3661B87084; Sun, 31 Dec 2023 13:47:45 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B2D87721
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 13:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6806914dba7so25225736d6.2
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 04:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704026860; x=1704631660; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bESmkj3v8ngDstndpuYChwBnIsksDej3Y7IvQOLzxY=;
 b=I/MmbWq4e9+y7JbuVHS5aVJJbBU2A7jskljww35v3ss1XJlMEA1BJTuAL/QDZn6jAZ
 j5Hrn/9dBQQbaRnNyZ9jB8US7Cr0TGWT3wxjom1WSsRhw4HnPZxEGExU8g7awEP5dj70
 lrRojyM3Ag78VkHCHt9C8aB9ZW+7w44pg0EZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704026860; x=1704631660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bESmkj3v8ngDstndpuYChwBnIsksDej3Y7IvQOLzxY=;
 b=pXYqcF7Zs0gI0DM82ZpgFWXdBtRja1RwmYPuK/XARahFCGa0JJarTI02WGeeOgxaMm
 6YMOzhf3CCv4oQCYgb1R/ZVMaU9i6MQH2t6njvcZBDn8Oe0AwLn5gWoNhRE1LRMsA7eD
 ddFivSSlltKJKrajdH19L/hGpxh+Qb2Jb3L4rIa0mBza72kYrk5J25HqbP8uGS4j/P1g
 CFXS4eD8Gd/306eNlMTU0AtFVZzR//VbV6UQT8KGITy8Vy3inUWV0L7cGzr+cll5vsb4
 Ui78SmP8axAmcGR70Kk9m9VHzLiDcWIsQTJ8p8I+1ErbK9SS/Gc99Wgv+q1iBu06JiSL
 5tkA==
X-Gm-Message-State: AOJu0YxVW5Pff2XamJ49SFIVSgEWL6jteVhIhmuzreQlTZhxAb5/4Ky0
 L4F7FM6Q7SkSt7J6D8KO6LjYJqRAzheiAlN/wDVNjBJ7E/8A
X-Google-Smtp-Source: AGHT+IHVsKYEyJUmNi6sotvSDG+NZUqXepCHqvi3Fw9O1HdRQbILJ7kHpGTgUu2TO//G06joOJGo3AnwzKC4lgW4owM=
X-Received: by 2002:a05:6214:c2a:b0:680:b154:bdd4 with SMTP id
 a10-20020a0562140c2a00b00680b154bdd4mr396506qvd.66.1704026860688; Sun, 31 Dec
 2023 04:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20231228194725.2482268-1-sjg@chromium.org>
 <20231228212429.GR2652760@bill-the-cat>
In-Reply-To: <20231228212429.GR2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 05:47:30 -0700
Message-ID: <CAFLszTif8GwJYdKF5Mq=gBB-ZW4wjJ7B9cjHRJdNi=QVAxMo=w@mail.gmail.com>
Subject: Re: [PATCH v6] fdt: Allow the devicetree to come from a bloblist
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerry Van Baren <vanbaren@cideas.com>,
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>
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

Hi,

On Thu, Dec 28, 2023 at 2:24=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 28, 2023 at 07:47:25PM +0000, Simon Glass wrote:
>
> > Standard passage provides for a bloblist to be passed from one firmware
> > phase to the next. That can be used to pass the devicetree along as wel=
l.
> > Add an option to support this.
> >
> > Tests for this will be added as part of the Universal Payload work.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> [snip]
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index 00c0aeff893..ae451b9caf7 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -105,6 +105,19 @@ config OF_EMBED
> >
> >  endchoice
> >
> > +config OF_BLOBLIST
> > +     bool "Provided by a bloblist at runtime"
> > +     depends on BLOBLIST && OF_SEPARATE
>
> This is now even more confusing, frankly. The help for OF_SEPARATE says:
> If this option is enabled, the device tree will be built and placed as a
> separate u-boot.dtb file alongside the U-Boot image.
>
> So why would you enable that to then have a device tree passed via
> bloblist instead?

Historical....

>
> We should probably start by fixing all of this confusing naming / logic
> and then correct things such that:
> - OF_EMBED wins if set. This is the override-has-been-set we-must-use-it
>   switch. First choice, not last choice. If binman needs tweaks so that
>   it will still generate images for platforms in this case, that needs
>   to happen.

Perhaps we should rename this to OF_EMBED_DEBUG ? Really it should not
be used by any board.

> - If we have a bloblist, we scan the bloblist for DT and if found, use
>   it.

unless we don't want to, e.g. because that DT has a bug or we want to
use a different one during development.

> - If it looks like we've been booted as a fake Linux kernel, and we can
>   start with just aarch64 and let riscv come in as a follow up, so
>   what's documented within
>   https://www.kernel.org/doc/html/latest/arch/arm64/booting.html#call-the=
-kernel-image
>   then we use that device tree.

Eek, really? Is this the rpi case and you are trying to make it
generic? I would rather that be a board-specific thing, calling into a
generic implementation. We should encourage bloblist.

>   - This _may_ just end up having to be "Does x0 (or similar) point to a
>     valid DT?" as I don't know how correct everything using this method
>     today is too what the spec above lists.

OK, well a generic impl would be good I suppose, but dereferencing
pointers to look for a magic number might not end well.

> - If we have a dtb appended to use by what we call today OF_SEPARATE but
>   should really stop calling it that we use that.

Yes it is a complete misnomer now. I will try to think of a better
name. It really just controls generation of u-boot.dtb and what goes
in u-boot.bin so perhaps we can just drop it and have OF_EMBED be
false in the normal case. Or rename to OF_STANDARD ?

>
> At that point, we can probably have zero "totally board specific kludge
> for device tree location", and kill off OF_HAS_PRIOR_STAGE too (since
> that's really just bloblist or fake-linux-kernel). We'll also be able to
> support migration from fake-linux-kernel to bloblist

OF_HAS_PRIOR_STAGE controls things like building the DT and OF_BOARD
... which from what you say above can perhaps go away. But there are
quite a lot of board_fdt_blob_setup() functions...it doesn't look like
they are all the same.

Automatic is OK I suppose. I just want to make sure that these things
can be disabled easily so it is possible to use the DT built by U-Boot
without hacking the code. That is my goal with having a Kconfig to
enable this mechanisms.

Regards,
Simon
