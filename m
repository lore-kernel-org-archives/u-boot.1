Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ED6CEBF9C
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 12:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CDBA89105;
	Fri, 27 Sep 2024 14:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AyrOFzxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EDAA89108; Fri, 27 Sep 2024 14:35:21 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92AA3890C6
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 14:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cb259e2eafso17783386d6.0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727440517; x=1728045317; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orJbm0lbQH/JTNDLT0DC7HmSfcdOMKQpeSLkiLYnnC8=;
 b=AyrOFzxqrvpkiZkLg8gGFIciAzQYZeU3Rhb9d/PgsAUap1uPvwK2psl4/uSZIBDn5t
 h4sWBZ3Tovc6mCsQF84VneF7/0GzbkHOMuaqqi7bzpS8/tVmzOM2dqxbZYue9wGZHFvx
 HtGwVJ0UMJZcD2ip7JeCBqh+76y6LVUmY+9G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727440517; x=1728045317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orJbm0lbQH/JTNDLT0DC7HmSfcdOMKQpeSLkiLYnnC8=;
 b=Uj1Zs94iba5DVYM+sDNPjtk6zmv8U4aej5wMrfHmn+8Fj4sBBAebeadEdRo/KlGdy9
 2TSZ3W+cdl9qeQhHu5nJM1gMLx3dt0Za4JoLUx0w3MOx//mr2TgKiwXJ3x+AVBv7KXfj
 UuuFe4xw3M8hD7Zlt1MpYnthoW+isWFSFJ5U87yt8lqdi9+Qe3BHAZk+xjUNBiPSR+Xz
 vjw7kVCqlUZH7BbkNaWttk7kAeX7LwS0+2cbwJz8GfJV3qBJrQPJnenH1Wv6X3l1yv/l
 1SvsYHb80k5eibLjhOAmLeXJM7QBgCY6Q8bJPXgue9wxJYp0lQln0Z3eGAmG/uGy5ZHW
 wXKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUem/F6Y3e6m38RDTuvKSo4gjz5gxcesfXuh6N/wKI3wxbs9iX61o8sB325VPtIfxPfW1UG8IQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyvZvZgEo1anjujUobrgU6zkF/Ow8XEVe6GXihNMyeQ+P57VEOX
 ZXLUHfX54namPEbBZxRCpc+W0RZ81NaIF4wt1tbEYqyRkdY267cgmOZHPVchyQhRcRrKoaN9+tX
 b+jR1ERkrlOcaAPfnyoz4eKM7OL++bvluNvZNWzrSBEnUlupdN9DP
X-Google-Smtp-Source: AGHT+IE+r3CkIDrbxjgOOpHSEQ3BxAtOSWHZafMAcVvx3tGuKoNhApD9raMcH5WIZlIvM6WxLvdKPC6Rd5GYbxno5WA=
X-Received: by 2002:a05:6214:489:b0:6cb:2de5:d7a1 with SMTP id
 6a1803df08f44-6cb2f270becmr119908336d6.8.1727440517324; Fri, 27 Sep 2024
 05:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-15-patrick.rudolph@9elements.com>
 <CAFLszTimAFGocvqbnT=JVsA2bjNa=ZfxP6Sy46a9e6VkhtdojQ@mail.gmail.com>
 <CAC_iWjLASm6U8kC68MJ0uZ14MGFS_SSL3Pcd8hcEH=a=W8gvBQ@mail.gmail.com>
 <CAFLszTgYHO7FgbCgfRwqT_yj4KBm31xKdEUrn0pZkhtLzOh=HQ@mail.gmail.com>
 <CAC_iWjKv+Z4K5xPW6MZhBZ67-rDy9iRVaoqfLKmJRwSG9nKnfA@mail.gmail.com>
 <CAFLszThA5eOM_xiMgDu=B4wAcP7wV9bzfc565rES8z6d1F8fjg@mail.gmail.com>
 <CAC_iWjLqmN0uA85RayC2hnMOJfCqumCpiq=waQwakd6ECfbXkg@mail.gmail.com>
 <CAFLszTgaVdgPNSC+vxZoH7ko5n_d6F_QnGfgL-biZ19edaUxQQ@mail.gmail.com>
 <CALNFmy3-0u=RhhiPgCzj2szzhaADXrWm79jkD1p3pmpmto456g@mail.gmail.com>
 <CAFLszThqaF9oSxEW5ZYw9udqtC+8n3BhQj313qUvRvrQV=OwWw@mail.gmail.com>
 <CAC_iWjKPrUu+j5dJNbQWZB+J7OUa1X01e_d8cN=YSrO_86cOhA@mail.gmail.com>
 <CAFLszTjoZuF6x38j_PyQdO9W_zzyQY+DPrXKm8J2pM-T_GYsgA@mail.gmail.com>
 <CAC_iWjLR7ndQAPOhe+Z-11F-nFXBGpPUOZB=Mmwt36CzJtvD0g@mail.gmail.com>
In-Reply-To: <CAC_iWjLR7ndQAPOhe+Z-11F-nFXBGpPUOZB=Mmwt36CzJtvD0g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 06:35:06 -0600
Message-ID: <CAFLszThcqgvAf0DDKhOXnKAdQ21r-PLDppTM=CASbaaONTei4g@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Fri, 27 Sept 2024 at 05:30, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 27 Sept 2024 at 13:53, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 26 Sept 2024 at 13:18, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Thu, 26 Sept 2024 at 14:04, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Patrick,
> > > >
> > > > On Thu, 26 Sept 2024 at 10:01, Patrick Rudolph
> > > > <patrick.rudolph@9elements.com> wrote:
> > > > >
> > > > > Hi Simon,
> > > > > On Fri, Sep 20, 2024 at 6:01=E2=80=AFPM Simon Glass <sjg@chromium=
.org> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Fri, 20 Sept 2024 at 08:36, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Thu, 19 Sept 2024 at 18:36, Simon Glass <sjg@chromium.org>=
 wrote:
> > > > > > > >
> > > > > > > > Hi Ilias,
> > > > > > > >
> > > > > > > > On Thu, 19 Sept 2024 at 17:20, Ilias Apalodimas
> > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.=
org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Ilias,
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > > >
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +               if (!addr)
> > > > > > > > > > > > > +                       return log_msg_ret("mem",=
 -ENOMEM);
> > > > > > > > > > > > > +       } else {
> > > > > > > > > > > > > +               pages =3D efi_size_in_pages(TABLE=
_SIZE);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +               ret =3D efi_allocate_pages(EFI_AL=
LOCATE_ANY_PAGES,
> > > > > > > > > > > > > +                                        EFI_ACPI=
_RECLAIM_MEMORY,
> > > > > > > > > > > > > +                                        pages, &=
new_acpi_addr);
> > > > > > > > > > > > > +               if (ret !=3D EFI_SUCCESS)
> > > > > > > > > > > > > +                       return log_msg_ret("mem",=
 -ENOMEM);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +               addr =3D (void *)(uintptr_t)new_a=
cpi_addr;
> > > > > > > > > > > > > +       }
> > > > > > > > > > > > > +
> > > > > > > > > > > >
> > > > > > > > > > > > The tables should be written regardless of whether =
EFI_LOADER is enabled.
> > > > > > > > > > >
> > > > > > > > > > > *Why*? How do you expect to hand them over to the OS?
> > > > > > > > > >
> > > > > > > > > > Why - because boards which need ACPI tables to boot sho=
uld generate
> > > > > > > > > > them;
> > > > > > > > >
> > > > > > > > > Noone argued that.
> > > > > > > > >
> > > > > > > > > > also this happens when U-Boot starts up, in last_stage_=
init()
> > > > > > > > > > How - it isn't possible, but eventually I suppose it wi=
ll be, once we
> > > > > > > > > > have a use case for booting with ACPI but without EFI
> > > > > > > > >
> > > > > > > > > Are you aware of such an OS? If not, we can accept the pa=
tches when we
> > > > > > > > > have a reason.
> > > > > > > >
> > > > > > > > Which patches? This is how it works today. We set up the ta=
bles in
> > > > > > > > last_stage_init(), so they can be examined while in U-Boot.
> > > > > > >
> > > > > > > What I mean, is that until we have a valid use case to store =
the ACPI
> > > > > > > in a bloblist, I prefer them being allocated with proper EFI =
memory
> > > > > > > backing
> > > > > >
> > > > > > I'm going to assert prior art here. If ARM is to have ACPI in U=
-Boot,
> > > > > > it should follow the most recent x86 approach and store it in t=
he
> > > > > > bloblist. That is what the blloblist is for. It also avoids usi=
ng
> > > > > > memory below the U-Boot area, which is not allowed.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > It is the patches to change this which I object to.
> > > > > > > >
> > > > > > > > > I remember patches being hard NAK'ed on using DTs to pass=
 the ACPI
> > > > > > > > > table address in the past.
> > > > > > > >
> > > > > > > > Yes, I believe Bytedance carries a patch locally for that :=
-)
> > > > > > >
> > > > > > > Exactly
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Can we drop this else clause? We should always use =
the bloblist.
> > > > > > > > > > >
> > > > > > > > > > > Both Heinrich and I said the exact opposite. Unless t=
here's a
> > > > > > > > > > > perfectly good reason why we should keep them in blob=
list memory, I'd
> > > > > > > > > > > like us to do that
> > > > > > > > > >
> > > > > > > > > > The main reason is that we should not be putting things=
 in memory
> > > > > > > > > > between the start of RAM and the bottom of the U-Boot a=
rea. That
> > > > > > > > > > region of memory is supposed to be for loading images. =
Most boards
> > > > > > > > > > hard-code the image-load addresses in environment varia=
bles. But even
> > > > > > > > > > if they didn't, we should not be using that memory for =
U-Boot data.
> > > > > > > > >
> > > > > > > > > EFI allows you to request a specific address to use. We c=
an choose one
> > > > > > > > > that fits the requirements
> > > > > > > >
> > > > > > > > So long as it is in U-Boot's space, that is fine. I just se=
nt a patch
> > > > > > > > about relocation which covers this. It occured to me that t=
his feature
> > > > > > > > of U-Boot, which I have always assumed was common knowledge=
, may have
> > > > > > > > not been noticed.
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Another reason is that the bloblist is designed for thi=
s, for keeping
> > > > > > > > > > tables in a small, contiguous area of memory, so that w=
hen passed to
> > > > > > > > > > Linux they are not spread all over the place.
> > > > > > > > >
> > > > > > > > > Linux does not and will not read tables from a bloblist t=
hough
> > > > > > > >
> > > > > > > > Indeed. There really isn't any point, anyway, since there a=
re other
> > > > > > > > ways of passing the tables along...except for ACPI with FDT=
 but that
> > > > > > > > isn't a valid use case for Linux so far.
> > > > > > >
> > > > > > > What we are trying to do with EFI is to stay as close to the =
spec and
> > > > > > > the current OS implementations as possible. So again, please =
allocate
> > > > > > > EFI memory for the ACPI tables. The patches to convert it to =
bloblist
> > > > > > > allocating them are minimal, so we can do it, once there's an=
 actuall
> > > > > > > need for it.
> > > > > >
> > > > > > As it stands today, efi_acpi_register() does not do an EFI allo=
cation,
> > > > > > it just adds the existing allocation to the EFI tables. This wo=
rks
> > > > > > fine for x86 - see arch/x86/lib/tables.c - so I would like ARM =
to do
> > > > > > the same. The need for it is (as above) that we should ensure t=
hat
> > > > > > memory usage is within the U-Boot area. This is something which
> > > > > > bloblist handles automatically. It is also nice to see all the =
tables
> > > > > > in one place with 'bloblist list'
> > > > > >
> > > > >
> > > > > So what's the consent and the next step here?
> > > > > Is the current code OK as is, as it works with both BLOBLIST and =
without?
> > > > > Should I drop support for one or the other?
> > > >
> > > > Just BLOBLIST. The EFI allocation is done using efi_acpi.c which yo=
u
> > > > can check to make sure it is working.
> > > >
> > > > Using efi_allocate_pages() before the app starts is not good.
> > >
> > > Simon, please stop trying to enforce decisions on subsystems you don'=
t
> > > maintain. I am pretty sure both Heinrich and I said no to this.
> >
> > I am the ACPI maintainer, and x86 maintainer long before ACPI came in
> > for ARM (which I originally hacked together, as you know). I also
> > wrote bloblist, including the header file which says:
>
> That's not the EFI subsystem though. And last time I checked where the
> ACPI tables are allocated makes no difference as long as they are
> installed on a config table.

With my maintainer hat on, ACPI tables go in a bloblist.

The difference it makes is that the tables end up in the U-Boot memory-area=
.

>
> >
> >  * 6. Bloblist is designed to be passed to Linux as reserved memory.
> > While linux
> >  * doesn't understand the bloblist header, it can be passed the indivdu=
al blobs.
>
> And as I already said, *when* bloblist is consumed by any OS and you
> have a valid use case other than "I can do bloblist list and I like
> it", you can change 3 lines of code and allocate the ACPI table there.

Bloblist is not intended to be consumed by an OS. It is a firmware
construct, a way for U-Boot to arrange things in such a way that they
can be located and updated at runtime. What objection do you actually
have to using bloblist for tables?

>
> >  * For example, ACPI tables can reside in a blob and the address of tho=
se is
> >  * passed to Linux, without Linux ever being away of the existence of a
> >  * bloblist. Having all the blobs contiguous in memory simplifies the
> >  * reserved-memory space.
>
> No, it doesn't because all of the other tables are currently allocated
> by the EFI subsystem. So it actually fragments it. Apart from that You
> dont really know what the OS is going to do with that memory. It
> depends on the EFI memory type and OS decisions.

The ACPI table is not allocated by the EFI subsystem. Neither is
SMBIOS, which currently uses malloc() but should move into a bloblist
too. The system table is in U-Boot's data region. Much of EFI's data
and all the driver model stuff is in the malloc() region.

>
> >
> > This decision has serious impacts on memory management in U-Boot. It
> > also bears on the complexity of memory, how bootstd works, board
> > scripts and the like. We should discuss this and figure out a path
> > forward.
>
> It has close to zero impact because *all* of the EFI memory lives in
> top memory. So apart from the EFI_BOUNCE_BUFFER perhaps,  I don't see
> why the impact is """serious""".
> EFI allocates memory which does not affect U-Boot of file loading
> apart from the max size allowed. Now with LMB it is marked as
> reserved. So why is this any different from any other LMB reservation?
> It's memory used by someone that you aren't allowed to use, just like
> we reserve U-Boot memory. If there's a bug in reservations, by all
> means, let's fix it.

I think you are saying that because only a small amount of memory is
affected it doesn't matter much. Well, I suppose so. But if it doesn't
matter, why is Sughosh spending all this time solving the problem?
Also with [1] I definitely saw it allocating stuff where it should
not. If it has so little impact, why are we still discussing it? Also,
my efforts seem to have uncovered latent bugs, where EFI tests fail if
there is not a large margin after each allocation. That should be
cause for concern. We would not put up with that elsewhere in U-Boot.

I am not trying to mess with EFI in U-Boot, if that is what you are
worried about. Actually I haven't been paying it enough attention as
it is in good hands...but I need to put more time into it. As a
subsystem it is here for the long haul and it needs to interoperate
properly. I was at a conference last week where there was a talk about
U-Boot as an EFI app with a pass-through (i.e. not calling
exit-boot-services) to Linux's EFI stub. There is a lot of activity in
this area. EFI is an important piece of technology in the industry.
But this is U-Boot, and we just need to design things properly. I have
quietly commented on some of my concerns (e.g. efi_set_bootdev()) but
have not put time into fixing them.

There is no need for the 6-8 tidy allocations, which are done before
the app starts, to be allocated in the wrong place, with a small
impact. We can just do it in malloc(). Let's just fix it.

There is no need for the tables to be allocated in an EFI-specific
way, or using lmb. We have bloblist for that purpose. What's the
concern?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240725135629.3505072=
-7-sjg@chromium.org/
