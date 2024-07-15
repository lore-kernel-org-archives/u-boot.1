Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F486C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488B088856;
	Mon, 15 Jul 2024 13:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IHlGO+vO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B6588827; Mon, 15 Jul 2024 13:39:45 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A612887FD
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-79f16cad2a7so289258385a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721043582; x=1721648382; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HHObd9eQCqNDkRzhOv9xilr9TXESEYXilNApwzSiQCk=;
 b=IHlGO+vO/MrhBABkPcP7xlkyxPNKYTu239yxK7KMoBt6w4AuotlTLsZCuvKctVjeJo
 E/gx3XAw/c6VSLJPc9KBJ2JosCNK8Pk+4riwDH4Zb4w9k6oZFz60KIp5/DqPsL2wwjCR
 HAiqnmB3HBMa58N1AAK35PKcU2zeMt/OZlQI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721043582; x=1721648382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HHObd9eQCqNDkRzhOv9xilr9TXESEYXilNApwzSiQCk=;
 b=cyExtqxrrF1P9heujik1xW9q/VFkET4wW8M77GhCS0z7xOXEffFfC7d0Yr1fKjRU6x
 tmiOdxIlegQgAgVXEARJIIN7upi7USkMQh9YtlQbw8PdFrmxL1n+rHAyr6DpFLkdp+rg
 jnSkCSVunHg8XVrcKktbMVCHAcKULzwX7OklqQm5GgbhRsbot/xN7GxhAKQWAGaDh0hd
 4Ufhte5S9zAvJ56UjN0Lc7JginkvOthT/acx66JalmoPeApSRjWIrDodz1KA0QTiJ2fm
 cuK4LvRVkEJoH48UDravNB7/WXZZaCfYXvY+c2qk61Hj8lYPeC0x+zKltuQ5zb7S5KHa
 9O9g==
X-Gm-Message-State: AOJu0YxrmdxkaLm3rHkm04fRhqlq8AZv4JOhY8xQQpdwujX7KAcYMtr7
 ahLe9X5JZi3qrtzdhzBZbR+PV3jrLGpmmqJBCKLuhErqD7KKM6u9ZVKekcyC1V2/Le4iiIYktI4
 DN+KgqiW9M8w62eHmqKmqFRTh5A067R/lQ5wP
X-Google-Smtp-Source: AGHT+IEdCMFDY4ABnyYbur7gAgoB9dYE/M331ktEHlx9fg6frGfPy9ZS25SINs0j0RdAv8o+1xO36uYzdjCOlzTNKLQ=
X-Received: by 2002:a05:6214:d6a:b0:6b5:7fe8:c4fc with SMTP id
 6a1803df08f44-6b61c204391mr242817246d6.56.1721043582471; Mon, 15 Jul 2024
 04:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-10-sughosh.ganu@linaro.org>
 <CAFLszTiN1K4tazqaBBCS37VHVtJ0ise2RQC2AGaLKg1SMFj9JQ@mail.gmail.com>
 <CADg8p974419Rqisf0qwH46FVobDYsxuLjnD5UV4kGRPcK7_vCg@mail.gmail.com>
In-Reply-To: <CADg8p974419Rqisf0qwH46FVobDYsxuLjnD5UV4kGRPcK7_vCg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 12:39:31 +0100
Message-ID: <CAFLszTjH=fvN3bWTieqfmKvdT9mdKRzBV4+zBBftD4Vg9ZwX=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/48] lmb: remove call to lmb_init()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

Hi Sughosh,

On Mon, 15 Jul 2024 at 10:31, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Sat, 13 Jul 2024 at 20:45, Simon Glass <sjg@chromium.org> wrote:
> >
> > kHi Sughosh,
> >
> > On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > The LMB module will be changed to have persistent and global memory
> > > maps of available and used memory. With this change, there won't be
> > > any need to explicitly initialise the LMB memory maps. Remove the call
> > > to the lmb_init() function.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1: New patch
> > >
> > >  arch/arm/mach-stm32mp/dram_init.c |  1 -
> > >  board/xilinx/common/board.c       |  1 -
> > >  drivers/iommu/apple_dart.c        |  1 -
> > >  drivers/iommu/sandbox_iommu.c     |  1 -
> > >  include/lmb.h                     |  1 -
> > >  lib/lmb.c                         | 18 ------------------
> > >  test/lib/lmb.c                    | 18 ------------------
> > >  7 files changed, 41 deletions(-)
> >
> > I can't actually find the call to lmb_init(). Where is it?
>
> Sorry, I do not understand this question. This patch removes the
> lmb_init() definition, as well as calls to the function from the rest
> of the files.

I see later you add lmb_mem_regions_init() so that there are two init
functions. We should really only have one.

Regards,
Simon
