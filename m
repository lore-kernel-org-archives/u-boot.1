Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC53C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 06:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D535801F5;
	Tue, 21 Jan 2025 07:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G3iUWeBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5480A80326; Tue, 21 Jan 2025 07:43:34 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C43A800CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 07:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-85c662ebbc3so853998241.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737441810; x=1738046610; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NAMLrkrUIMv+1g82XmppFiliW767Q2RLFV3twLRzV8=;
 b=G3iUWeBxFdczPOsVyRQCAdeUmtEF4nwaPLn7b+CCY5rz8aBuNzUIxu8boIlOhd5uuS
 uy/7e3/udkf91izUps9LQRGOM4JsJzd4QTf7YeuqJ/VFQDY3fGck7npdLs9g6roM9nuk
 dHYo/TT+oJksloYj2flNxwVfulyF1QTawF63yLdWqxTHpIXwz34q4/aC9WW02B5fZ8so
 icBDFd5Ehle4txSmSMQiXD1+mwzO3070ch+6LtgSjJZU6Gw0K6TFUALh6VcADluNpKN2
 mJf2GaRhN2NBGxa2SShzahb+CTHkzRyTXwiZQMw4oprw7iWUSwfidFDdTq+e1pZjHNct
 vjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737441810; x=1738046610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NAMLrkrUIMv+1g82XmppFiliW767Q2RLFV3twLRzV8=;
 b=RgDD5pL7QvV6yDZN5vGatEKz/OcOVpkWZNQpUoBbOpsd79VRxcD/9YwrtmSsZgizbJ
 ncHyWxLSiBXD7IF0mNYPZv48XpSgqC8Pnv6unBIcZLlwkoPIXFPceNZPmvTFG8XkhDvY
 TdtWk2qE9Q4VcWHEANw7RYibTYTUVEBOG8A7YMOqTyMN3AIdyuf+jZNSBLWQaZL3q7wG
 wBK3Sf08/fTn459usEM6BGLA+xW/Zcst3F23UVbnpj8bG+rRy1hEAbPxi/3GlOtLUZ47
 lnNA6rFkDvL2NldpJDzHp9P9QnI1mj0qW4RXStFTrhTRlGBXMrF7iMBmyZMzJICpHgF4
 o99g==
X-Gm-Message-State: AOJu0YzttnQMZSqBMIKd9ccQodwvkhiw64hMfHzrezq66WRzz6KDUvaF
 9HL0cMpGLklVDJ0cga1LISk6cxRY/dYwIMTqCe/nEuCKUWI1ahm2wy/h6ra3Sy9Iv7KnKqsZCvj
 tswblU+COEbtEPPeIV19tCi32Zu1HRNSHPDZ97Q==
X-Gm-Gg: ASbGncuyIE82AnDLtAUTkan2trbmKfsbWNeidD1iGTd3qp9yqHwop0HNwoTXirp9bJk
 f1E3/cguDVlOhTiYC8lv4B6XSIUwSbPm1P+2XciMp5yjzghRRHJsO
X-Google-Smtp-Source: AGHT+IGvMRce0liQeMF44oaBqKQUKNiomVCuvdbU4oYyoux9zz2TYYyP+jdbmm/UH2VoYxxjrsEjEhbhyDA52rWsiZs=
X-Received: by 2002:a05:6102:4b08:b0:4af:c58f:4550 with SMTP id
 ada2fe7eead31-4b690ba200bmr12916928137.7.1737441810278; Mon, 20 Jan 2025
 22:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-5-sughosh.ganu@linaro.org>
 <877c6p7juk.fsf@waldekranz.com>
 <CADg8p96jX0eDKpxTuBLKS5vx=UJ=QLeBxnmfroUFYZ8VJWv1Pg@mail.gmail.com>
 <874j1t7dsw.fsf@waldekranz.com>
 <CADg8p9421OsmGMRfHCYqfeDJFN6+NFoc42tD5BSnGW69cYc49g@mail.gmail.com>
 <871pwx78yz.fsf@waldekranz.com>
 <CADg8p95HGYytdP+_PrZThW_g56GJWA=UXW5yUmaO9NWXDmHoUA@mail.gmail.com>
 <87y0z55frs.fsf@waldekranz.com>
In-Reply-To: <87y0z55frs.fsf@waldekranz.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 21 Jan 2025 12:13:18 +0530
X-Gm-Features: AbW1kvaBjZqSWWwUeSOh9SPto2JmNobLktbIczuN_f7M0MM4oueek9des_e70g4
Message-ID: <CADg8p97e9f-=oh4CcK9H1WdUquQkuY5Tp0PUboRj40xbpOcpBw@mail.gmail.com>
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

On Tue, 21 Jan 2025 at 03:06, Tobias Waldekranz <tobias@waldekranz.com> wro=
te:
>
> On tis, jan 21, 2025 at 00:55, Sughosh Ganu <sughosh.ganu@linaro.org> wro=
te:
> > On Mon, 20 Jan 2025 at 21:50, Tobias Waldekranz <tobias@waldekranz.com>=
 wrote:
> >>
> >> On m=C3=A5n, jan 20, 2025 at 21:10, Sughosh Ganu <sughosh.ganu@linaro.=
org> wrote:
> >> > On Mon, 20 Jan 2025 at 20:06, Tobias Waldekranz <tobias@waldekranz.c=
om> wrote:
> >> >>
> >> >> On m=C3=A5n, jan 20, 2025 at 19:30, Sughosh Ganu <sughosh.ganu@lina=
ro.org> wrote:
> >> >> > On Mon, 20 Jan 2025 at 17:55, Tobias Waldekranz <tobias@waldekran=
z.com> wrote:
> >> >> >>
> >> >> >> On m=C3=A5n, jan 20, 2025 at 16:20, Sughosh Ganu <sughosh.ganu@l=
inaro.org> wrote:
> >> >> >> > Add information about the type of blkmap device in the blkmap
> >> >> >> > structure. Currently, the blkmap device is used for mapping to=
 either
> >> >> >> > a memory based block device, or another block device (linear
> >> >> >> > mapping). Put information in the blkmap structure to identify =
if it is
> >> >> >> > associated with a memory or linear mapped device. Which can th=
en be
> >> >> >> > used to take specific action based on the type of blkmap devic=
e.
> >> >> >>
> >> >> >> Is this restriction really necessary? Why should it not be possi=
ble to
> >> >> >> setup a block map like this:
> >> >> >>
> >> >> >>  myblkmap:
> >> >> >> .--------.      .-----.
> >> >> >> | slice0 +------> RAM |
> >> >> >> :--------:      '-----'     .-------.
> >> >> >> | slice1 +------------------> eMMC0 |
> >> >> >> :--------:      .-------.   '-------'
> >> >> >> | slice2 +------> eMMC1 |
> >> >> >> '........'      '-------'
> >> >> >>
> >> >> >> Linux's "device mapper", after which blkmaps are modeled, works =
in this
> >> >> >> way.  I.e. a blkmap is just a collection of slices, and it is up=
 to each
> >> >> >> slice how its data is provided, meaning that the user is free to=
 compose
> >> >> >> their virtual block device in whatever way they need.
> >> >> >
> >> >> > The blkmap structure, the way it is designed, is pointing to the
> >> >> > underlying block device. How can a single blkmap then be associat=
ed
> >> >>
> >> >> The `struct udevice *blk` from `struct blkmap` is a reference to th=
e
> >> >> block device which represents the block map itself ("myblkmap" in t=
he
> >> >> picture above), not any lower device.
> >> >
> >> > Okay. I got confused with the comment associated with that member,
> >> > which says, "Underlying block device". This I interpreted to be the
> >> > block device that is associated with the blkmap structure.
> >>
> >> Yeah I agree that it could be made clearer :)
> >>
> >> >>
> >> >> > with slices of different types? Would that not contravene with th=
e
> >> >> > idea of a block device associating with a blkmap?
> >> >>
> >> >> For slices which are linear mappings (and are thus backed by some o=
ther
> >> >> underlying block device), their reference to that lower device ("eM=
MC0"
> >> >> and "eMMC1" above) is stored in the `struct udevice *blk` member of
> >> >> `struct blkmap_linear`.
> >> >
> >> > Okay. But then, the computation of the blocksize seems to be happeni=
ng
> >> > at the blkmap device level, which again implies having the same set =
of
> >> > slices associated with the blkmap. Any reason why the blksize is not
> >> > taken from the block device associated with that slice? That would
> >> > make it clear that the slice mapping type is independent from the
> >> > parent blkmap device.
> >>
> >> In the original series, only linear mappings to devices which used blo=
ck
> >> sizes of 512 was supported, precisely because otherwise you need to do
> >> proper translation to work in all cases.
> >>
> >> I tried to argue this point on the list back then:
> >> https://lore.kernel.org/u-boot/875y3wohrt.fsf@waldekranz.com/
> >> but I did not get my point across and the restriction was lifted anywa=
y.
> >>
> >> >>
> >> >> Slices which are backed by memory does not have any reference to a =
lower
> >> >> device, but merely a pointer to the start of the mapping - `void *a=
ddr`
> >> >> in `struct blkmap_mem`.
> >> >>
> >> >> The overarching idea is that the block map does not have to know
> >> >> anything about the implementation of how any individual slice choos=
es to
> >> >> provide its data.  It only knows about their sizes and offsets.  Ba=
sed
> >> >> on that information, it simply routes incoming read/write requests =
to
> >> >> the correct slice.
> >> >
> >> > Okay. I think, for my solution, I will just need to move type
> >> > identification to the slice, instead of the blkmap device.
> >> >
> >> >>
> >> >> >>
> >> >> >> Looking at the pmem patch that follows this one, I am not able t=
o find
> >> >> >> anything that would motivate restricting the functionality eithe=
r.
> >> >> >
> >> >> > The subsequent patch is adding the persistent memory node to the
> >> >> > device-tree. The pmem node that is to be added is the memory mapp=
ed
> >> >> > blkmap device. The logic does check for the type of the blkmap de=
vice
> >> >> > and then proceeds to add the pmem node only for the memory mapped
> >> >> > blkmaps.
> >> >>
> >> >> Sorry I am confused.  Why do you need a block map device to add the=
 pmem
> >> >> node to the device tree?
> >> >
> >> > This is needed to include the RAM based block device information in
> >> > the device-tree as pmem node. The OS installer then uses this pmem
> >> > device as the block device which contains the installation packages,
> >> > and proceeds with the OS installation.
> >>
> >> But even if the user has not setup a blkmap, don't you want to inject
> >> the pmem node in the DT anyway?  All you need is the size and offset o=
f
> >> the blob right?  Is that not available from `image_setup_libfdt()`?
> >
> > Not sure if I am getting your point. The image_setup_libfdt() function
> > is fixing up the devicetree before it gets passed on to the OS. In my
> > subsequent patch, the image_setup_libfdt() is calling the blkmap
> > helper function (added in that patch) to check for any memory mapped
> > blkmap devices, and add corresponding pmem nodes for those. The
> > current case where this is happening in U-Boot is as part of
> > EFI_HTTP_BOOT, where if an ISO or an img file has been obtained over
> > the network, it gets mounted as a blkmap device, and that gets
> > notified to the OS. So, if this happens to be an install image, the
> > kernel knows about it through the pmem node in the DT.
>
> Alright, but then it seems like the implementation of EFI_HTTP_BOOT is
> the one with enough context to known when to add the pmem node, no?
> Could it not use the event subsystem to register a fixup?  I.e. when it
> creates the block map, it also ought to know that the image must be
> protected.  I imagine something like (pseudo code, but you get the
> idea):
>
> +struct efi_pmem {
> +    void *base;
> +    size_t size;
> +}
> +
> +efi_add_pmem(void *_pmem, struct event *event)
> +{
> +    const struct event_ft_fixup *fixup =3D &event->data.ft_fixup;
> +    struct efi_pmem pmem =3D _pmem;
> +
> +    fdt_fixup_pmem_region(fixup->tree, pmem->addr, pmem->size);
> +    free(pmem);
> +}
>
>  efi_http_boot()
>  {
>      ...
>      bm =3D blkmap_ramdisk_create(imgbase, imgsize);
> +    if (needs_protection) {
> +        struct efi_pmem *pmem =3D xmalloc(sizeof(*pmem));
> +        pmem->base =3D imgbase;
> +        pmem->size =3D imgsize;
> +        event_register("efi_add_pmem", EVT_FT_FIXUP, efi_add_pmem, pmem)=
;
> +    }
>     ...
>  }

The earlier version was written on similar lines, where the helper
function was getting the image address and size from the efi_http_boot
context structure. There was a review comment asking me to decouple
the solution from EFI_HTTP_BOOT, and add the pmem nodes after scanning
the blkmap devices. This would make it a little more generic, and not
tie it closely with EFI_HTTP_BOOT.

Also, one issue with using the event based framework is that the user
might choose to pass a different devicetree to the OS from the one on
which the fixup was done. Calling the helper function from
image_setup_libfdt() ensures that the fixup happens on the DT that
gets passed on to the OS.

>
>
> > If you are referring to a scenario where the memory based block device
> > does not get set up as a blkmap device, that will anyways require
> > explicit intervention of the user to add the pmem node, because
> > otherwise there is no way to find out existence of such a device. This
> > can then be done through an explicit command. But the EFI_HTTP_BOOT
> > use-case does require scanning for the memory base blkmap devices.
>
> With the approach above, I think we could get out of marking every
> configured blkmap as reserved (which might not be what the user wants),
> and instead let the creator of the device decide on whether this is
> needed or not.

I am not sure what you mean by marking the blkmap as reserved, but
these changes are simply marking the blkmap devices in the DT before
booting the OS. The kernel can then parse these pmem regions to check
for the availability of an installation.

-sughosh
