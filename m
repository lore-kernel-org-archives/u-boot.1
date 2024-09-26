Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1747CCCFA15
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 11:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0474E88D3A;
	Thu, 26 Sep 2024 13:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YoB5Ncn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF29D88D54; Thu, 26 Sep 2024 13:18:46 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38CFA88D38
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2053616fa36so9657895ad.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 04:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727349522; x=1727954322; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lincjFuWnIjJJPS7lLRXQksdS3sxyxYLgaCzLq2QGJQ=;
 b=YoB5Ncn/8etmbN+yntTFNtKcLmK4HH1rT0bLOiQzItnIfyfzBUOtpw8eOB1ETGUnRo
 kBSh6Z+LwILSCQ3J1ITJU3po95wWZ3vIoot8Q7sV1J8kiG32KouFaXp3ORDcG+PHokcS
 CT7EAYnpeY2580LlrtmyGUVCBq+myQA/EJHlcygVrX3gi4decR8lY81e2ziVQbyd4rB0
 F+R/zfcpEC5q6pGxYTw3GdZJLxpIIvL9hCnCpiaysl9NdfvEYZ0upfgWXZKx4N2vzvz8
 FVkFOadAXOcpAziWLwbPJwYStF5JF0QdSfOH+bPwD7iZ3FsJ3VfzloWichLim3BZAqQ/
 n9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727349522; x=1727954322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lincjFuWnIjJJPS7lLRXQksdS3sxyxYLgaCzLq2QGJQ=;
 b=OqReYWTPgSlkg8wX660Rhe/BBq3WLKCtOorVO2rzS/LBD8i3MwjEmZRmPvSgPgolOq
 3uvMRSTCmC4+bPVw73HaKQHOyH5rShDTggr2DQaHjaM7ZAOa4T6a6QRzcOeot7qYsXXb
 EAbFZ4gE/7q/vUSlUlQSOXSgOlQ/aiKkzBbxaVKDuIT7KBACGQ0YdnZiqG1305op+qis
 kCPDtQpEl26bRlrW43UUJueejFOiaOSjxGoTLmufIcFntNKORUj6AmKETntmJ9S2h0ud
 jt+sbcAubhBxfRcmwJq33wZDn2mKzJHB/FHqwAdujgj8ZukNttNlI0iGx7d5A6NqrMbl
 H9Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQYewoo7xIGmjEugruuy9QWYSKtu+ZcwyuHsd2JbgXRdwJHFsmPmFgSifQpfCyFAXoVPj1CAQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyVscVX4NhQ01FLas1M1/bl0j9C4wD4fxEibEps4PoQ//2mV2iN
 m9qlGgdo+jSxhISsQ/ldBFO6blLyG3btdIvKnfFOkNV03eALxwSWY/QKlmAAk1nbi8rEg3N5WgV
 MfsDKYOamBUbViQRqsg4buzfyomxB+OyXlatipw==
X-Google-Smtp-Source: AGHT+IETfZsLXDB6cRuKcXg+A8tnjA7HLUIUrXc/7LYXgf52a/TcC+/sazWoH+hT5Nuqs62/yX26qDzkA5/AefxLITA=
X-Received: by 2002:a17:902:c946:b0:20b:20b:1881 with SMTP id
 d9443c01a7336-20b020b1b1cmr70506695ad.36.1727349522360; Thu, 26 Sep 2024
 04:18:42 -0700 (PDT)
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
In-Reply-To: <CAFLszThqaF9oSxEW5ZYw9udqtC+8n3BhQj313qUvRvrQV=OwWw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Sep 2024 14:18:05 +0300
Message-ID: <CAC_iWjKPrUu+j5dJNbQWZB+J7OUa1X01e_d8cN=YSrO_86cOhA@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Simon Glass <sjg@chromium.org>
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

On Thu, 26 Sept 2024 at 14:04, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Patrick,
>
> On Thu, 26 Sept 2024 at 10:01, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Hi Simon,
> > On Fri, Sep 20, 2024 at 6:01=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Fri, 20 Sept 2024 at 08:36, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, 19 Sept 2024 at 18:36, Simon Glass <sjg@chromium.org> wrote=
:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Thu, 19 Sept 2024 at 17:20, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.org> w=
rote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > > > > +
> > > > > > > > > > +               if (!addr)
> > > > > > > > > > +                       return log_msg_ret("mem", -ENOM=
EM);
> > > > > > > > > > +       } else {
> > > > > > > > > > +               pages =3D efi_size_in_pages(TABLE_SIZE)=
;
> > > > > > > > > > +
> > > > > > > > > > +               ret =3D efi_allocate_pages(EFI_ALLOCATE=
_ANY_PAGES,
> > > > > > > > > > +                                        EFI_ACPI_RECLA=
IM_MEMORY,
> > > > > > > > > > +                                        pages, &new_ac=
pi_addr);
> > > > > > > > > > +               if (ret !=3D EFI_SUCCESS)
> > > > > > > > > > +                       return log_msg_ret("mem", -ENOM=
EM);
> > > > > > > > > > +
> > > > > > > > > > +               addr =3D (void *)(uintptr_t)new_acpi_ad=
dr;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > >
> > > > > > > > > The tables should be written regardless of whether EFI_LO=
ADER is enabled.
> > > > > > > >
> > > > > > > > *Why*? How do you expect to hand them over to the OS?
> > > > > > >
> > > > > > > Why - because boards which need ACPI tables to boot should ge=
nerate
> > > > > > > them;
> > > > > >
> > > > > > Noone argued that.
> > > > > >
> > > > > > > also this happens when U-Boot starts up, in last_stage_init()
> > > > > > > How - it isn't possible, but eventually I suppose it will be,=
 once we
> > > > > > > have a use case for booting with ACPI but without EFI
> > > > > >
> > > > > > Are you aware of such an OS? If not, we can accept the patches =
when we
> > > > > > have a reason.
> > > > >
> > > > > Which patches? This is how it works today. We set up the tables i=
n
> > > > > last_stage_init(), so they can be examined while in U-Boot.
> > > >
> > > > What I mean, is that until we have a valid use case to store the AC=
PI
> > > > in a bloblist, I prefer them being allocated with proper EFI memory
> > > > backing
> > >
> > > I'm going to assert prior art here. If ARM is to have ACPI in U-Boot,
> > > it should follow the most recent x86 approach and store it in the
> > > bloblist. That is what the blloblist is for. It also avoids using
> > > memory below the U-Boot area, which is not allowed.
> > >
> > > >
> > > > >
> > > > > It is the patches to change this which I object to.
> > > > >
> > > > > > I remember patches being hard NAK'ed on using DTs to pass the A=
CPI
> > > > > > table address in the past.
> > > > >
> > > > > Yes, I believe Bytedance carries a patch locally for that :-)
> > > >
> > > > Exactly
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Can we drop this else clause? We should always use the bl=
oblist.
> > > > > > > >
> > > > > > > > Both Heinrich and I said the exact opposite. Unless there's=
 a
> > > > > > > > perfectly good reason why we should keep them in bloblist m=
emory, I'd
> > > > > > > > like us to do that
> > > > > > >
> > > > > > > The main reason is that we should not be putting things in me=
mory
> > > > > > > between the start of RAM and the bottom of the U-Boot area. T=
hat
> > > > > > > region of memory is supposed to be for loading images. Most b=
oards
> > > > > > > hard-code the image-load addresses in environment variables. =
But even
> > > > > > > if they didn't, we should not be using that memory for U-Boot=
 data.
> > > > > >
> > > > > > EFI allows you to request a specific address to use. We can cho=
ose one
> > > > > > that fits the requirements
> > > > >
> > > > > So long as it is in U-Boot's space, that is fine. I just sent a p=
atch
> > > > > about relocation which covers this. It occured to me that this fe=
ature
> > > > > of U-Boot, which I have always assumed was common knowledge, may =
have
> > > > > not been noticed.
> > > > >
> > > > > > >
> > > > > > > Another reason is that the bloblist is designed for this, for=
 keeping
> > > > > > > tables in a small, contiguous area of memory, so that when pa=
ssed to
> > > > > > > Linux they are not spread all over the place.
> > > > > >
> > > > > > Linux does not and will not read tables from a bloblist though
> > > > >
> > > > > Indeed. There really isn't any point, anyway, since there are oth=
er
> > > > > ways of passing the tables along...except for ACPI with FDT but t=
hat
> > > > > isn't a valid use case for Linux so far.
> > > >
> > > > What we are trying to do with EFI is to stay as close to the spec a=
nd
> > > > the current OS implementations as possible. So again, please alloca=
te
> > > > EFI memory for the ACPI tables. The patches to convert it to blobli=
st
> > > > allocating them are minimal, so we can do it, once there's an actua=
ll
> > > > need for it.
> > >
> > > As it stands today, efi_acpi_register() does not do an EFI allocation=
,
> > > it just adds the existing allocation to the EFI tables. This works
> > > fine for x86 - see arch/x86/lib/tables.c - so I would like ARM to do
> > > the same. The need for it is (as above) that we should ensure that
> > > memory usage is within the U-Boot area. This is something which
> > > bloblist handles automatically. It is also nice to see all the tables
> > > in one place with 'bloblist list'
> > >
> >
> > So what's the consent and the next step here?
> > Is the current code OK as is, as it works with both BLOBLIST and withou=
t?
> > Should I drop support for one or the other?
>
> Just BLOBLIST. The EFI allocation is done using efi_acpi.c which you
> can check to make sure it is working.
>
> Using efi_allocate_pages() before the app starts is not good.

Simon, please stop trying to enforce decisions on subsystems you don't
maintain. I am pretty sure both Heinrich and I said no to this.

Thanks
/Ilias
>
> Regards,
> Simon
