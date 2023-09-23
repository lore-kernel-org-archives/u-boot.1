Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE49CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA66F869B6;
	Sat, 23 Sep 2023 20:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lIazJCJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 995538641B; Sat, 23 Sep 2023 20:32:18 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DEE98640F
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-532c81b9adbso4731674a12.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695493936; x=1696098736; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tnruRBVLGjDwa2LAE4mp/v4wz1gdsjSQwMjap63E5dI=;
 b=lIazJCJuCOvThkxduPNsjj5c6f7geH/CGf4j42IeqpkkIZLWBiqqxeU7T7vSbYB7fI
 TJ7FqS2oTaomXBVekvr7E4xlbs4Zl2oR9AilNOf+ydslShMVRwCMxUsF29IuSa1TYEuh
 MhLIvlXbkto0yeG+1t7jU+wWmyZU09EZzDUbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695493936; x=1696098736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tnruRBVLGjDwa2LAE4mp/v4wz1gdsjSQwMjap63E5dI=;
 b=w0JGNrC+IOEEeKgVE33Q/I2gQm/Jmd7P/Hv2asyt+bXA2WI1GECXYabLElkp7g99oQ
 KeBdIJcXVziOL/3gBlKLV553sOhNrFJudytsAH1oFFIzDa0we3YidG7yt5yKzH1DqicE
 4kmA8RQkpEjQ+T60gaKm0IiHoB0TKlLe7erhUdowlYn3qJ3LjX1XoeJYJv2tsKTG642C
 GLu4shYDUGQ+pOzMONNhwC3B9EkLzb4kr0DW57KU8zspJGZFrUsZy5VtbeY5OtCKYTB0
 ZlE06zSbrziFTipf+mqGB9edDKTusUQUcVk8Wb5HOZdhTYkENvVpBw/Tc1OCJh4X/l1G
 AZhg==
X-Gm-Message-State: AOJu0Yz7oEa99m1kA4RpUG/AjArgrdGHZRNg75ynWgDMgI9EelsjNQZr
 yWC+/kd336JSFrAqS6mMC6lCyMBCtbI+DXhuKdDo5Q==
X-Google-Smtp-Source: AGHT+IE6nLHxuSAnIDCcDvOx4KhfBPIqy/ziEBXSKVsXT9dKuvy7xoZ805d+HR4ZpiH7tNyinLOA5K054+gjR4PirK4=
X-Received: by 2002:a05:6402:511:b0:533:6f75:c205 with SMTP id
 m17-20020a056402051100b005336f75c205mr2332102edv.20.1695493935800; Sat, 23
 Sep 2023 11:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230228155605.1209559-1-pbrobinson@gmail.com>
 <Y/445vMVy2hXrDAJ@bill-the-cat>
In-Reply-To: <Y/445vMVy2hXrDAJ@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 Sep 2023 12:31:58 -0600
Message-ID: <CAPnjgZ1LcPKr+KLNkS6cXDwxQjeP2tLKDTDBvFmXQpQkgXq2hg@mail.gmail.com>
Subject: Re: [PATCH] rpi: Use OF_BOARD rather than OF_EMBED
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 u-boot@lists.denx.de
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

Hi,

On Tue, 28 Feb 2023 at 10:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 28, 2023 at 03:56:05PM +0000, Peter Robinson wrote:
>
> > The use of OF_EMBED isn't recommended for standard use and the OF_BOARD
> > is actually a better fit for the Raspberry Pi as the prior firmware
> > provides a DT that can be used by U-Boot and the subsequent OS too, but
> > it still allows the loading of a DT from disk as well if users wish
> > to use the upstream kernel DT.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  configs/rpi_0_w_defconfig      | 2 +-
> >  configs/rpi_2_defconfig        | 2 +-
> >  configs/rpi_3_32b_defconfig    | 2 +-
> >  configs/rpi_3_b_plus_defconfig | 2 +-
> >  configs/rpi_3_defconfig        | 2 +-
> >  configs/rpi_4_32b_defconfig    | 1 +
> >  configs/rpi_4_defconfig        | 1 +
> >  configs/rpi_arm64_defconfig    | 1 +
> >  configs/rpi_defconfig          | 2 +-
> >  9 files changed, 9 insertions(+), 6 deletions(-)
>
> My only concern is from when I did:
> https://patchwork.ozlabs.org/project/uboot/patch/20211224165704.2855211-1-trini@konsulko.com/
> so I think you need to also drop the "imply OF_HAS_PRIOR_STAGE" from the
> Kconfig files and should probably move to select (do not allow the user
> to override this, it shall always be OF_EMBED now), or at least imply
> (sufficiently advanced users may want a different choice and should be
> able to make it).

This very old patch seems to have arrived in my queue. I am pleased to see it!

From my understanding the correct thing here is to 'imply
OF_HAS_PRIOR_STAGE' in the Kconfig, which is done for some rpi boards
but not all. Then the OF_BOARD setting becomes the default.

We should not really 'select OF_HAS_PRIOR_STAGE' since it makes
testing with a U-Boot-supplied DT impossible.

Regards,
Simon
