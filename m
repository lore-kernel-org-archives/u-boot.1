Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F26DC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 19:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E708C801F5;
	Mon, 20 Jan 2025 20:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zc/Faqee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEDBC8032B; Mon, 20 Jan 2025 20:25:17 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A98801CF
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 20:25:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4afeb79b52fso1222744137.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737401113; x=1738005913; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVfVEY1RxRZHjXJ/8FyEWsKyiEFMgJ4It/BHbitZiQ0=;
 b=zc/FaqeeugCvCWASm7s6SahadqU4mynygkI7zLuEEzzJcZ1TT71H3TwWT7DkkqqNpp
 6EUuvTpdP+g2uv7ocsCIs0RfYwp8S95GPieThpl1Vxd7wTwbwsBqzjaPfxSfGWdEzvNF
 BMyHsQnrCtFbuAQ+v651Hhl5sg3d9YM9vgA+XcyhnqqeqhbwG+k2+/zp7dc52HAuv5+y
 hK11Vqq6aTWO3EsV/hs3pxEf16ChRXIoVMi8hVMEf6H5z9MVMzJXbhxJu5kItdIfhsl0
 7M9r6uw9bPX4pF7Kkisxmgd0VBgxE6CwvPnMgy7AXc1uMMMgQgSCyLQdNvKznyROG+bv
 g3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737401113; x=1738005913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVfVEY1RxRZHjXJ/8FyEWsKyiEFMgJ4It/BHbitZiQ0=;
 b=hsgky5inzlMzWtA0iuOJo99PatDcXfvGSobYZ1Nb+L1LX3b/KfQtWeA0YOZj82spPr
 D4LAaEXIbzRTEuJxhgJyS2jv26wYK2QSMAyd/YJ7+R7/Y4LaJOU5wN6OuYLJJAibB7Ey
 QJRXnntdQHFd79k0jiWdOr0/lyS70iM5VJFz870PwvCqSRkNlTs2a7uicSNVyNPcGZ8Y
 JSaDGPLO6I8VMePxvIyXtaYyFzUoe/xwqf07JebGsXW2tmh+M0ymR3GdVgJltyjTkKgI
 zsQn7eWe49k4cSVyIJPNGOjixIm5jg1MK0eXEmWI+aQdCPyUneQ+xLxljwOruBNNk3Dk
 WBFQ==
X-Gm-Message-State: AOJu0YyIVuYAYcdo1K4uPFKSH8OmiTg4a+wFOqpi50gR0aEkLKChdH3b
 RsYPyb2UbT/c9F9YleJ4glvcm6dHsLuoTjQEHc83jmipPpoEJSFuAUUJ8RobeS8RpUX09bcHDGn
 AmAGp4/cYoj9fUbKERv2YaW6DMX3RBXDccPw5Fw==
X-Gm-Gg: ASbGnctWUC/6ZKkJ2sOQGq5/WH3PCmjIwu6MYF/BtF03mh5lpZ5XmUrTxlWjYj2ewEz
 jAzvBb/ti+Q4mU5SPijWiZjyr13ep3c4zahExl40yigvx8RtTNSYj
X-Google-Smtp-Source: AGHT+IE/iXhtrB6vpVv8Wn6mKGjvFYKjEg3wOSDFO/KQEA/wPjo8pyNqYG2o9C4lryW0LBhYlSHOC8+H/LL9LJgGVbU=
X-Received: by 2002:a05:6102:cd4:b0:4b2:c105:dc40 with SMTP id
 ada2fe7eead31-4b690bfc8c0mr11979228137.8.1737401113511; Mon, 20 Jan 2025
 11:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-5-sughosh.ganu@linaro.org>
 <877c6p7juk.fsf@waldekranz.com>
 <CADg8p96jX0eDKpxTuBLKS5vx=UJ=QLeBxnmfroUFYZ8VJWv1Pg@mail.gmail.com>
 <874j1t7dsw.fsf@waldekranz.com>
 <CADg8p9421OsmGMRfHCYqfeDJFN6+NFoc42tD5BSnGW69cYc49g@mail.gmail.com>
 <871pwx78yz.fsf@waldekranz.com>
In-Reply-To: <871pwx78yz.fsf@waldekranz.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 21 Jan 2025 00:55:02 +0530
X-Gm-Features: AbW1kvZQ5rzMPcBorG4gNTVvzLH3OSg1_hNlz8Yn16QwyRjb5wm_63Q04fUMPjM
Message-ID: <CADg8p95HGYytdP+_PrZThW_g56GJWA=UXW5yUmaO9NWXDmHoUA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] blkmap: store type of blkmap device in
 corresponding structure
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Bin Meng <bmeng@tinylab.org>
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

On Mon, 20 Jan 2025 at 21:50, Tobias Waldekranz <tobias@waldekranz.com> wro=
te:
>
> On m=C3=A5n, jan 20, 2025 at 21:10, Sughosh Ganu <sughosh.ganu@linaro.org=
> wrote:
> > On Mon, 20 Jan 2025 at 20:06, Tobias Waldekranz <tobias@waldekranz.com>=
 wrote:
> >>
> >> On m=C3=A5n, jan 20, 2025 at 19:30, Sughosh Ganu <sughosh.ganu@linaro.=
org> wrote:
> >> > On Mon, 20 Jan 2025 at 17:55, Tobias Waldekranz <tobias@waldekranz.c=
om> wrote:
> >> >>
> >> >> On m=C3=A5n, jan 20, 2025 at 16:20, Sughosh Ganu <sughosh.ganu@lina=
ro.org> wrote:
> >> >> > Add information about the type of blkmap device in the blkmap
> >> >> > structure. Currently, the blkmap device is used for mapping to ei=
ther
> >> >> > a memory based block device, or another block device (linear
> >> >> > mapping). Put information in the blkmap structure to identify if =
it is
> >> >> > associated with a memory or linear mapped device. Which can then =
be
> >> >> > used to take specific action based on the type of blkmap device.
> >> >>
> >> >> Is this restriction really necessary? Why should it not be possible=
 to
> >> >> setup a block map like this:
> >> >>
> >> >>  myblkmap:
> >> >> .--------.      .-----.
> >> >> | slice0 +------> RAM |
> >> >> :--------:      '-----'     .-------.
> >> >> | slice1 +------------------> eMMC0 |
> >> >> :--------:      .-------.   '-------'
> >> >> | slice2 +------> eMMC1 |
> >> >> '........'      '-------'
> >> >>
> >> >> Linux's "device mapper", after which blkmaps are modeled, works in =
this
> >> >> way.  I.e. a blkmap is just a collection of slices, and it is up to=
 each
> >> >> slice how its data is provided, meaning that the user is free to co=
mpose
> >> >> their virtual block device in whatever way they need.
> >> >
> >> > The blkmap structure, the way it is designed, is pointing to the
> >> > underlying block device. How can a single blkmap then be associated
> >>
> >> The `struct udevice *blk` from `struct blkmap` is a reference to the
> >> block device which represents the block map itself ("myblkmap" in the
> >> picture above), not any lower device.
> >
> > Okay. I got confused with the comment associated with that member,
> > which says, "Underlying block device". This I interpreted to be the
> > block device that is associated with the blkmap structure.
>
> Yeah I agree that it could be made clearer :)
>
> >>
> >> > with slices of different types? Would that not contravene with the
> >> > idea of a block device associating with a blkmap?
> >>
> >> For slices which are linear mappings (and are thus backed by some othe=
r
> >> underlying block device), their reference to that lower device ("eMMC0=
"
> >> and "eMMC1" above) is stored in the `struct udevice *blk` member of
> >> `struct blkmap_linear`.
> >
> > Okay. But then, the computation of the blocksize seems to be happening
> > at the blkmap device level, which again implies having the same set of
> > slices associated with the blkmap. Any reason why the blksize is not
> > taken from the block device associated with that slice? That would
> > make it clear that the slice mapping type is independent from the
> > parent blkmap device.
>
> In the original series, only linear mappings to devices which used block
> sizes of 512 was supported, precisely because otherwise you need to do
> proper translation to work in all cases.
>
> I tried to argue this point on the list back then:
> https://lore.kernel.org/u-boot/875y3wohrt.fsf@waldekranz.com/
> but I did not get my point across and the restriction was lifted anyway.
>
> >>
> >> Slices which are backed by memory does not have any reference to a low=
er
> >> device, but merely a pointer to the start of the mapping - `void *addr=
`
> >> in `struct blkmap_mem`.
> >>
> >> The overarching idea is that the block map does not have to know
> >> anything about the implementation of how any individual slice chooses =
to
> >> provide its data.  It only knows about their sizes and offsets.  Based
> >> on that information, it simply routes incoming read/write requests to
> >> the correct slice.
> >
> > Okay. I think, for my solution, I will just need to move type
> > identification to the slice, instead of the blkmap device.
> >
> >>
> >> >>
> >> >> Looking at the pmem patch that follows this one, I am not able to f=
ind
> >> >> anything that would motivate restricting the functionality either.
> >> >
> >> > The subsequent patch is adding the persistent memory node to the
> >> > device-tree. The pmem node that is to be added is the memory mapped
> >> > blkmap device. The logic does check for the type of the blkmap devic=
e
> >> > and then proceeds to add the pmem node only for the memory mapped
> >> > blkmaps.
> >>
> >> Sorry I am confused.  Why do you need a block map device to add the pm=
em
> >> node to the device tree?
> >
> > This is needed to include the RAM based block device information in
> > the device-tree as pmem node. The OS installer then uses this pmem
> > device as the block device which contains the installation packages,
> > and proceeds with the OS installation.
>
> But even if the user has not setup a blkmap, don't you want to inject
> the pmem node in the DT anyway?  All you need is the size and offset of
> the blob right?  Is that not available from `image_setup_libfdt()`?

Not sure if I am getting your point. The image_setup_libfdt() function
is fixing up the devicetree before it gets passed on to the OS. In my
subsequent patch, the image_setup_libfdt() is calling the blkmap
helper function (added in that patch) to check for any memory mapped
blkmap devices, and add corresponding pmem nodes for those. The
current case where this is happening in U-Boot is as part of
EFI_HTTP_BOOT, where if an ISO or an img file has been obtained over
the network, it gets mounted as a blkmap device, and that gets
notified to the OS. So, if this happens to be an install image, the
kernel knows about it through the pmem node in the DT.

If you are referring to a scenario where the memory based block device
does not get set up as a blkmap device, that will anyways require
explicit intervention of the user to add the pmem node, because
otherwise there is no way to find out existence of such a device. This
can then be done through an explicit command. But the EFI_HTTP_BOOT
use-case does require scanning for the memory base blkmap devices.

-sughosh
