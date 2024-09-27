Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2489CEBF93
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 10:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36329890DB;
	Fri, 27 Sep 2024 12:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aFSqFLhl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC20E890D0; Fri, 27 Sep 2024 12:53:48 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3630890DF
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 12:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6c548eb3354so15214066d6.2
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727434423; x=1728039223; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSWu/kZ2az7Fj2JeKRtzufrfnNsKewHNvObszY4CvGA=;
 b=aFSqFLhlP3MKcmukHpcwpETLppMKc/CTXEKyQ+LaU6Slya6czjTJnChD2LeOFBoK+5
 Ur2oyY0gdvKZOCmaYtQjmHCYp8xrvi/7ZXtDTPP41Xz/eJNKH7k1cbfTfR8J+qtm898n
 UNEhGZzbBF6PLuTBcszUb/ChPtv4F7ehCJn74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727434423; x=1728039223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSWu/kZ2az7Fj2JeKRtzufrfnNsKewHNvObszY4CvGA=;
 b=Ex6eNHz/8tOJ51ZFia9KYUe/taPpFBQrs4GLKGyv3aWyl+qTPDf6CgT5oP8fG3aqxd
 cB0LAgbMRjEmCcFPQbln69aLi8XpJKDUPcCYzsr6RGhEkBFKtqQC96Q90Y1n6pzvj1ji
 OhaKCMEC/3PeiOo0GvL0wu+vJLApvxenHeBF4sCMKcI/BJmFugVGRKjDClXTEajlt/a3
 wytlucinPaHBg+ud+8n4qMC2+hWlFOyS5ip8IH4Rp1aqNjuzLO2ob9HaUtZtAHCYTDc2
 upphuRu8m2VrjN3fXKYmY+VHjCxXpL9usR50QsZ+aTOgqZqZ3e9+F1bnSNI2CoSyvVX2
 QJYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfy26yhd1tfNw9ZoFHPmoCwNUJ7bdn/cMzvKHCMVIEFXMfB8VSWlxMLWwUmS0DCb3yH2G9Phc=@lists.denx.de
X-Gm-Message-State: AOJu0YwytRi0J0JDfmDt6i/A2izXPvlahCmWLiOx427hH48Gu6U3Q8iq
 K8mCI2uv9UxyxULXEIKx+c2kkRjOlq1XP4I4aP5S7F/jnaz66NeupY6dg2a48QlvJq9UJlOEZ6r
 QIKJJvxM5gZDx9TG6xOyW5amRihvit30XPjMz
X-Google-Smtp-Source: AGHT+IFTri0EwJZFoO1pCDTQ2BQltSToTcDnm9i6h2c65rkl3ugZ50/kV1mTIQHG0ykiN/vfiWxQtWZpzYiw4P2KjBQ=
X-Received: by 2002:a05:6214:5d82:b0:6cb:3a7b:96be with SMTP id
 6a1803df08f44-6cb3b480d6emr55690286d6.0.1727434422721; Fri, 27 Sep 2024
 03:53:42 -0700 (PDT)
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
In-Reply-To: <CAC_iWjKPrUu+j5dJNbQWZB+J7OUa1X01e_d8cN=YSrO_86cOhA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 04:53:32 -0600
Message-ID: <CAFLszTjoZuF6x38j_PyQdO9W_zzyQY+DPrXKm8J2pM-T_GYsgA@mail.gmail.com>
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

On Thu, 26 Sept 2024 at 13:18, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 26 Sept 2024 at 14:04, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Patrick,
> >
> > On Thu, 26 Sept 2024 at 10:01, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Hi Simon,
> > > On Fri, Sep 20, 2024 at 6:01=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Fri, 20 Sept 2024 at 08:36, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Thu, 19 Sept 2024 at 18:36, Simon Glass <sjg@chromium.org> wro=
te:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Thu, 19 Sept 2024 at 17:20, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.org>=
 wrote:
> > > > > > > >
> > > > > > > > Hi Ilias,
> > > > > > > >
> > > > > > >
> > > > > > > [...]
> > > > > > >
> > > > > > > > > > > +
> > > > > > > > > > > +               if (!addr)
> > > > > > > > > > > +                       return log_msg_ret("mem", -EN=
OMEM);
> > > > > > > > > > > +       } else {
> > > > > > > > > > > +               pages =3D efi_size_in_pages(TABLE_SIZ=
E);
> > > > > > > > > > > +
> > > > > > > > > > > +               ret =3D efi_allocate_pages(EFI_ALLOCA=
TE_ANY_PAGES,
> > > > > > > > > > > +                                        EFI_ACPI_REC=
LAIM_MEMORY,
> > > > > > > > > > > +                                        pages, &new_=
acpi_addr);
> > > > > > > > > > > +               if (ret !=3D EFI_SUCCESS)
> > > > > > > > > > > +                       return log_msg_ret("mem", -EN=
OMEM);
> > > > > > > > > > > +
> > > > > > > > > > > +               addr =3D (void *)(uintptr_t)new_acpi_=
addr;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > >
> > > > > > > > > > The tables should be written regardless of whether EFI_=
LOADER is enabled.
> > > > > > > > >
> > > > > > > > > *Why*? How do you expect to hand them over to the OS?
> > > > > > > >
> > > > > > > > Why - because boards which need ACPI tables to boot should =
generate
> > > > > > > > them;
> > > > > > >
> > > > > > > Noone argued that.
> > > > > > >
> > > > > > > > also this happens when U-Boot starts up, in last_stage_init=
()
> > > > > > > > How - it isn't possible, but eventually I suppose it will b=
e, once we
> > > > > > > > have a use case for booting with ACPI but without EFI
> > > > > > >
> > > > > > > Are you aware of such an OS? If not, we can accept the patche=
s when we
> > > > > > > have a reason.
> > > > > >
> > > > > > Which patches? This is how it works today. We set up the tables=
 in
> > > > > > last_stage_init(), so they can be examined while in U-Boot.
> > > > >
> > > > > What I mean, is that until we have a valid use case to store the =
ACPI
> > > > > in a bloblist, I prefer them being allocated with proper EFI memo=
ry
> > > > > backing
> > > >
> > > > I'm going to assert prior art here. If ARM is to have ACPI in U-Boo=
t,
> > > > it should follow the most recent x86 approach and store it in the
> > > > bloblist. That is what the blloblist is for. It also avoids using
> > > > memory below the U-Boot area, which is not allowed.
> > > >
> > > > >
> > > > > >
> > > > > > It is the patches to change this which I object to.
> > > > > >
> > > > > > > I remember patches being hard NAK'ed on using DTs to pass the=
 ACPI
> > > > > > > table address in the past.
> > > > > >
> > > > > > Yes, I believe Bytedance carries a patch locally for that :-)
> > > > >
> > > > > Exactly
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Can we drop this else clause? We should always use the =
bloblist.
> > > > > > > > >
> > > > > > > > > Both Heinrich and I said the exact opposite. Unless there=
's a
> > > > > > > > > perfectly good reason why we should keep them in bloblist=
 memory, I'd
> > > > > > > > > like us to do that
> > > > > > > >
> > > > > > > > The main reason is that we should not be putting things in =
memory
> > > > > > > > between the start of RAM and the bottom of the U-Boot area.=
 That
> > > > > > > > region of memory is supposed to be for loading images. Most=
 boards
> > > > > > > > hard-code the image-load addresses in environment variables=
. But even
> > > > > > > > if they didn't, we should not be using that memory for U-Bo=
ot data.
> > > > > > >
> > > > > > > EFI allows you to request a specific address to use. We can c=
hoose one
> > > > > > > that fits the requirements
> > > > > >
> > > > > > So long as it is in U-Boot's space, that is fine. I just sent a=
 patch
> > > > > > about relocation which covers this. It occured to me that this =
feature
> > > > > > of U-Boot, which I have always assumed was common knowledge, ma=
y have
> > > > > > not been noticed.
> > > > > >
> > > > > > > >
> > > > > > > > Another reason is that the bloblist is designed for this, f=
or keeping
> > > > > > > > tables in a small, contiguous area of memory, so that when =
passed to
> > > > > > > > Linux they are not spread all over the place.
> > > > > > >
> > > > > > > Linux does not and will not read tables from a bloblist thoug=
h
> > > > > >
> > > > > > Indeed. There really isn't any point, anyway, since there are o=
ther
> > > > > > ways of passing the tables along...except for ACPI with FDT but=
 that
> > > > > > isn't a valid use case for Linux so far.
> > > > >
> > > > > What we are trying to do with EFI is to stay as close to the spec=
 and
> > > > > the current OS implementations as possible. So again, please allo=
cate
> > > > > EFI memory for the ACPI tables. The patches to convert it to blob=
list
> > > > > allocating them are minimal, so we can do it, once there's an act=
uall
> > > > > need for it.
> > > >
> > > > As it stands today, efi_acpi_register() does not do an EFI allocati=
on,
> > > > it just adds the existing allocation to the EFI tables. This works
> > > > fine for x86 - see arch/x86/lib/tables.c - so I would like ARM to d=
o
> > > > the same. The need for it is (as above) that we should ensure that
> > > > memory usage is within the U-Boot area. This is something which
> > > > bloblist handles automatically. It is also nice to see all the tabl=
es
> > > > in one place with 'bloblist list'
> > > >
> > >
> > > So what's the consent and the next step here?
> > > Is the current code OK as is, as it works with both BLOBLIST and with=
out?
> > > Should I drop support for one or the other?
> >
> > Just BLOBLIST. The EFI allocation is done using efi_acpi.c which you
> > can check to make sure it is working.
> >
> > Using efi_allocate_pages() before the app starts is not good.
>
> Simon, please stop trying to enforce decisions on subsystems you don't
> maintain. I am pretty sure both Heinrich and I said no to this.

I am the ACPI maintainer, and x86 maintainer long before ACPI came in
for ARM (which I originally hacked together, as you know). I also
wrote bloblist, including the header file which says:

 * 6. Bloblist is designed to be passed to Linux as reserved memory. While =
linux
 * doesn't understand the bloblist header, it can be passed the indivdual b=
lobs.
 * For example, ACPI tables can reside in a blob and the address of those i=
s
 * passed to Linux, without Linux ever being away of the existence of a
 * bloblist. Having all the blobs contiguous in memory simplifies the
 * reserved-memory space.

This decision has serious impacts on memory management in U-Boot. It
also bears on the complexity of memory, how bootstd works, board
scripts and the like. We should discuss this and figure out a path
forward.

Regards,
Simon
