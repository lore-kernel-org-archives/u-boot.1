Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B367CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910BB88CFC;
	Thu, 26 Sep 2024 10:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="R1vgvl6N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1735B88A0A; Thu, 26 Sep 2024 10:02:00 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62F558891E
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6dbc75acbfaso6865547b3.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337713; x=1727942513; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXDAyslcfri1l1rNa58aT9TI7KYDvAg/qIxf85nYlxM=;
 b=R1vgvl6NQCRqkXvUFcHeNSYZSKa28RrswXZqvGHp7i9qK788B408aOrBvFjcBvKJoP
 hj3CBB514bsoHMobHc7SbwKpqhsM6OGmGpEwPrFW4r7sdTQWWA957Hez39CULwrRI6se
 CvvEKxy9pC5lYsMSz726dCi1Odjs3dd5TFkHb9O0vtwTYtwDRUaDmv8aK90bFoizp2ct
 /NSTwV0IxxwjTLyCzUNptpgW9DhF+N5sgZOM3cM79stYjIcWaXfuK32cKYvFQ2A6Awqt
 Ev2A0ZrwgU6srn7SQTHTHsT1u6m29meYFiU7m8YyWd/708rjUOkROYbDPnSQrpd7gwfr
 IeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337713; x=1727942513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXDAyslcfri1l1rNa58aT9TI7KYDvAg/qIxf85nYlxM=;
 b=IC34d4Foe1dUa7vl2xZTiXZEZH+E0QNMMVJoLcK8JgWIJHtQRsLq9J/fqkAguVbFA7
 wENo7G8kEQqeuYAb++soXglza4iy12M4f68srfJ4E/1H9kR5dEc/Nabq7ttxpSHh5ZzF
 sjNPotY7E3yHUhMCLakVza7NqklXVwnkrvveUDlmPnasI0PzcWheldZnqsGZgTafW+ck
 Xt/VQjQJd/SlzOdoR+sS4po/6xepBRS3WisB5bWzb6Jz0EmebU4ILAYK7WaKy+h24VYY
 Qlp6zFtGBAYJy9gJCFA8zuLNqmTbGmO9Tfzr7WtGnhdW2BuEAlkroyKlgk9NNPjiFD9P
 6Rdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNIBSLCkKOMAgsXUU9ABsdzpYYWR9EgRTTJT3nSZy406bdredvdwCsKeUAs0Wq2aN7xiHHka0=@lists.denx.de
X-Gm-Message-State: AOJu0Yypva8kcIN4jixs1UV0EQyI3TKw0fRCmPMaABvxS/iFt12RuJai
 W26/CGCddqiBkWfAkOptIF7AviIu85io4ru8RcGns624mtgEfWVtvpgJGBXWD7FN73pKZWmJCwy
 updfnan1PemKhBGeKGWMflaEoHOYHiJ1nkPsoGw==
X-Google-Smtp-Source: AGHT+IHJfD/06/oIa30ttrqpT+Ve/PJ8W0dAncyeRQWgwMmLnKXuoJYU4fYHuFGBkMFQ22UkTtd9JdTI/le5mWF4MdQ=
X-Received: by 2002:a05:690c:4a87:b0:618:2381:2404 with SMTP id
 00721157ae682-6e21d9f0428mr38652317b3.44.1727337713023; Thu, 26 Sep 2024
 01:01:53 -0700 (PDT)
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
In-Reply-To: <CAFLszTgaVdgPNSC+vxZoH7ko5n_d6F_QnGfgL-biZ19edaUxQQ@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Thu, 26 Sep 2024 10:01:41 +0200
Message-ID: <CALNFmy3-0u=RhhiPgCzj2szzhaADXrWm79jkD1p3pmpmto456g@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
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

Hi Simon,
On Fri, Sep 20, 2024 at 6:01=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Ilias,
>
> On Fri, 20 Sept 2024 at 08:36, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 19 Sept 2024 at 18:36, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Thu, 19 Sept 2024 at 17:20, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.org> wrote=
:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > >
> > > > [...]
> > > >
> > > > > > > > +
> > > > > > > > +               if (!addr)
> > > > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > > > > +       } else {
> > > > > > > > +               pages =3D efi_size_in_pages(TABLE_SIZE);
> > > > > > > > +
> > > > > > > > +               ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY=
_PAGES,
> > > > > > > > +                                        EFI_ACPI_RECLAIM_M=
EMORY,
> > > > > > > > +                                        pages, &new_acpi_a=
ddr);
> > > > > > > > +               if (ret !=3D EFI_SUCCESS)
> > > > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > > > > +
> > > > > > > > +               addr =3D (void *)(uintptr_t)new_acpi_addr;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > >
> > > > > > > The tables should be written regardless of whether EFI_LOADER=
 is enabled.
> > > > > >
> > > > > > *Why*? How do you expect to hand them over to the OS?
> > > > >
> > > > > Why - because boards which need ACPI tables to boot should genera=
te
> > > > > them;
> > > >
> > > > Noone argued that.
> > > >
> > > > > also this happens when U-Boot starts up, in last_stage_init()
> > > > > How - it isn't possible, but eventually I suppose it will be, onc=
e we
> > > > > have a use case for booting with ACPI but without EFI
> > > >
> > > > Are you aware of such an OS? If not, we can accept the patches when=
 we
> > > > have a reason.
> > >
> > > Which patches? This is how it works today. We set up the tables in
> > > last_stage_init(), so they can be examined while in U-Boot.
> >
> > What I mean, is that until we have a valid use case to store the ACPI
> > in a bloblist, I prefer them being allocated with proper EFI memory
> > backing
>
> I'm going to assert prior art here. If ARM is to have ACPI in U-Boot,
> it should follow the most recent x86 approach and store it in the
> bloblist. That is what the blloblist is for. It also avoids using
> memory below the U-Boot area, which is not allowed.
>
> >
> > >
> > > It is the patches to change this which I object to.
> > >
> > > > I remember patches being hard NAK'ed on using DTs to pass the ACPI
> > > > table address in the past.
> > >
> > > Yes, I believe Bytedance carries a patch locally for that :-)
> >
> > Exactly
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Can we drop this else clause? We should always use the blobli=
st.
> > > > > >
> > > > > > Both Heinrich and I said the exact opposite. Unless there's a
> > > > > > perfectly good reason why we should keep them in bloblist memor=
y, I'd
> > > > > > like us to do that
> > > > >
> > > > > The main reason is that we should not be putting things in memory
> > > > > between the start of RAM and the bottom of the U-Boot area. That
> > > > > region of memory is supposed to be for loading images. Most board=
s
> > > > > hard-code the image-load addresses in environment variables. But =
even
> > > > > if they didn't, we should not be using that memory for U-Boot dat=
a.
> > > >
> > > > EFI allows you to request a specific address to use. We can choose =
one
> > > > that fits the requirements
> > >
> > > So long as it is in U-Boot's space, that is fine. I just sent a patch
> > > about relocation which covers this. It occured to me that this featur=
e
> > > of U-Boot, which I have always assumed was common knowledge, may have
> > > not been noticed.
> > >
> > > > >
> > > > > Another reason is that the bloblist is designed for this, for kee=
ping
> > > > > tables in a small, contiguous area of memory, so that when passed=
 to
> > > > > Linux they are not spread all over the place.
> > > >
> > > > Linux does not and will not read tables from a bloblist though
> > >
> > > Indeed. There really isn't any point, anyway, since there are other
> > > ways of passing the tables along...except for ACPI with FDT but that
> > > isn't a valid use case for Linux so far.
> >
> > What we are trying to do with EFI is to stay as close to the spec and
> > the current OS implementations as possible. So again, please allocate
> > EFI memory for the ACPI tables. The patches to convert it to bloblist
> > allocating them are minimal, so we can do it, once there's an actuall
> > need for it.
>
> As it stands today, efi_acpi_register() does not do an EFI allocation,
> it just adds the existing allocation to the EFI tables. This works
> fine for x86 - see arch/x86/lib/tables.c - so I would like ARM to do
> the same. The need for it is (as above) that we should ensure that
> memory usage is within the U-Boot area. This is something which
> bloblist handles automatically. It is also nice to see all the tables
> in one place with 'bloblist list'
>

So what's the consent and the next step here?
Is the current code OK as is, as it works with both BLOBLIST and without?
Should I drop support for one or the other?

> Regards,
> Simon
