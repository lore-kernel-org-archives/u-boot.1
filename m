Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9934E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A008806D4;
	Wed, 15 Jan 2025 02:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VmcW9Idv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A6E280702; Wed, 15 Jan 2025 02:18:41 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 219308069A
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so12175940a12.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736903918; x=1737508718; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LMKJIJOJc9C0XJes7Ry9Hu/dCxNCF73Vj4/4JCsAn8M=;
 b=VmcW9IdvsojGlK6mxMBTOIDZNj5ycQdS/XHKsbJGU7T0dqAibbthAc60rMa68QGU4u
 OYIt1Fi5d6+R3V8rZoO6rNOKT/Ju/FfKFX0RdnWryCPd3PcgTymFkmhe93/LfvkJ4ptf
 Tr5b01KC4i8L6rfOvxHdrPqxvmMgeCq4v8FRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903918; x=1737508718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LMKJIJOJc9C0XJes7Ry9Hu/dCxNCF73Vj4/4JCsAn8M=;
 b=Fkm3v6yBRxY24Qm2Dysr2xaB5pw9a9f64uwqp5tuD2WMzAK8NQtns3s9kyc2IXRS17
 XkEXiuVgbGNiqu7yyyJ0eRyRU/tEatCLuzTwabxVCBOSmEsYuq/EDMIFTK8SJVetUKaV
 hYrHgDrhrcptwxRBN6jrJpc7V3rurC/Vfcm526YoRYDFFXqfubz3nNqSV9g9qiAqGY91
 nZKFfqV5JLWKax2699M/PkcFRX0pvC1kwmiiX4aghjBqaSJBDE1b5aBsXYd9DzA9UPbG
 npSzm4YV0Rl9OQmYEyhd2GwgkUfTl1XuIIkXeH1VhBeKzvh7xVaQe2AAMMwYQTEHHZv5
 RH/g==
X-Gm-Message-State: AOJu0YzPBQT0pAukn3/Qn1AtM8w03K5KwnK8lj6eYPZ7HWU1FN04Mb55
 KbeoArtkY/f1IUC8MZ6OPMsSOUfWxxc3FI2pRvcDf4AD0XsVxC2HcF3AF8E2hBs5UcjZ68kSkEz
 6RshOTmILeVIYCdz5mfotVmvs2rfFXT6XbgCR
X-Gm-Gg: ASbGncuuiB5AIm9N/c0mPwUB4GLa7FG3GHYZeVj8A5G/VtZAo297Tv7wGtYHzzQXzY3
 6Bo0oa5twA0D1zqsPro+KcGWCPiiaMJ12JQ3gxRo=
X-Google-Smtp-Source: AGHT+IGV6aW37OcpSECWB+b7ngyp6BByrl65XnzD1uT8LjAxLDx9J3SKYqNU1w7XVdxS0tpLBIp+e0Gz6u3q30KRh+M=
X-Received: by 2002:a17:907:cbc9:b0:ab2:b6e2:fcc9 with SMTP id
 a640c23a62f3a-ab2b6e2ff66mr2486995366b.45.1736903917858; Tue, 14 Jan 2025
 17:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-2-sjg@chromium.org>
 <20250114012226.GG3476@bill-the-cat>
 <CAFLszTj9zAE_KniCZ2xHGHt1fK7jhTBHzfkdSif6XNuzKtWOTA@mail.gmail.com>
 <20250114165801.GJ3476@bill-the-cat> <20250114173343.GO3476@bill-the-cat>
In-Reply-To: <20250114173343.GO3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 18:18:26 -0700
X-Gm-Features: AbW1kvbKo--TwwVgCV-Q3bwW0rd4lKtTT3DSEu6OuSuUkaCXtW6l1FZ4QKbmfCo
Message-ID: <CAFLszTi1epQ+6AGMK_pkjnTQmDU8--xS-NXfk5iM=q_wi6xyWw@mail.gmail.com>
Subject: Re: [PATCH 01/15] vbe: Split out some VBE code into a common file
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

Hi Tom,

On Tue, 14 Jan 2025 at 10:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jan 14, 2025 at 10:58:01AM -0600, Tom Rini wrote:
> > On Tue, Jan 14, 2025 at 05:58:04AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 13 Jan 2025 at 18:22, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jan 09, 2025 at 05:29:56AM -0700, Simon Glass wrote:
> > > >
> > > > > Loading a FIT is useful for other VBE methods, such as ABrec, so start
> > > > > a new common file. Add functions for reading the version and nvdata.
> > > > > Also add a function to get the block device.
> > > >
> > > > This is not a good commit message when you're also introducing
> > > > functional changes (blk_dread -> blk_read).
> > >
> > > Yes, I did not actually notice this size change at all, as mentioned,
> > > as I only built for a few boards (firefly rk3399/rk3288 and a few
> > > sandbox ones). The blk_dread() function is the old API for reading
> >
> > You have much faster build machines available than I do, it would be
> > good to run a world build before/after (it might take an hour on
> > alexandra) before posting these big series.

OK. I used to do this, but with CI sometimes grabbing the machines it
ends up with a huge load and sometimes runs out of memory. I suppose I
can stop the runner before doing it and remember to restart it
afterwards. Or perhaps Alex has enough memory per thread? (96GB).

> >
> > > from a block. It didn't occur to me that blk_dread() would bypass the
> > > cache.
> >
> > Yes, how is that happening? That's what doesn't make sense.

OK, I see. It is actually one level deeper than I thought.

PARTITIONS is not enabled, for example on phycore_am62x_r5_usbdfu
which means that blk_get_dev() returns NULL

So long as all the code is in one module, blk_get_dev() returning NULL
causes the calls to vbe_simple_read_state() and simple_read_nvdata()
to be dropped, so their code is dropped too, so there is no
blk_read()/blk_dread() call. It is optimised away. It just happens to
be the only call in U-Boot

> >
> > >
> > > > Further, this functional
> > > > change seems to introduce some other code being pulled in very
> > > > unexpectedly, and that needs to be explained. For example,
> > > > phycore_am62x_r5_usbdfu is another case and that has
> > > > CONFIG_BLOCK_CACHE=y but CONFIG_SPL_BLOCK_CACHE=n, and yet the size
> > > > growth is in full U-Boot.
> > >
> > > This board currently uses blk_dread(), but not blk_read(), so the
> > > addition of a blk_read() call in non-SPL causes the BLK cache to be
> > > pulled in.
> >
> > But, how? I mean, this sounds like some underlying bug that needs to be
> > fixed. The platform sets CONFIG_BLK=y and CONFIG_BLOCK_CACHE=y and
> > drivers/block/blk-uclass.c has:
> > ulong blk_dread(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt,
> >                 void *buffer)
> > {
> >         return blk_read(desc->bdev, start, blkcnt, buffer);
> > }
> >
> > Or perhaps the answer / problem here is that I need to track down what's
> > going wrong here instead of asking you to track this down.
>
> So, digging in to this, what's going on is that the platforms I've noted
> here (and a few others) don't actually enable any block devices. That's
> why, today, with VBE on still, they discard all of the code still. Your
> rework means that while there's still no block devices, we're now
> including the code. What to do? Both of:
> - These platforms *should* disable the assorted block device related
>   library options they have enabled if / when possible (it might not be
>   a neat and easy un-tangle).

As above, the issue seems to be PARTITIONS

> - VBE needs to handle the case where there's not a block device enabled
>   and not fail the build. Part of this requires the Kconfig rework I
>   linked to earlier (so that we can have BLK off) to be complete, but
>   having the VBE code check for BLK being enabled either in Makefile or
>   C code should be the same regardless.

I thought you NAK'd my patch to drop the 'depends on BLK' for bootstd?

From what I can tell EFI_LOADER doesn't do any block access unless
PARTITIONS is enabled. I don't want that for VBE because the VBE data
is not actually in a partition (although perhaps it could be in
future).

Anyway, from what I can tell, the code-size increase is explainable
and perhaps we should just accept it.

Regards,
Simon
