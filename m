Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308FBCCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 11:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2C188CD9;
	Thu, 26 Sep 2024 13:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AP07cW9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B039788D38; Thu, 26 Sep 2024 13:05:05 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C412C88A0A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cb2f271043so7485236d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 04:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727348696; x=1727953496; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ue1eWPH1utHZkT4XxZouyIpF9bUkfOwxMsrl8KgXnbU=;
 b=AP07cW9q62xy+FwBKb1GjfKq4ERob5zRgxkjclLe5FUwddLgSbk4HUempAAlNqpXx1
 CvoT5d548JOG+VLH4w17MxvD7JjnWkbngnGVqU8uLJkUKTiq++nA6Mq1im/jiSD0UMPI
 JBQuvae1QprK31AtrYrB8gdI6wGWicTz07vyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727348696; x=1727953496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ue1eWPH1utHZkT4XxZouyIpF9bUkfOwxMsrl8KgXnbU=;
 b=g7Jq+6kt4ijRGxU0pzfr+YoPf1BYb8+mF0aINLGtiGb60H68fsQdTbftg6mG+eDw2D
 9u81yt6jTyH8Gz9wJr1g18f+epcAWZHfarKBnsU4mVwRyLlSjBTXYh/IrFIBCWJS3buw
 t43GgNAbnGTrLfFjZH1FPS5AEyWUdz8D/3r5VwIfqxw+Loku9yAIDGzAvMUnSFrBWEpV
 l5bCP5TXc4Knf7xaGNtAS5LDUN+8ZmavvG0ZCTGRK41ld8EPXkC8fN1WF7qvzRBcgzPW
 KBtRhcTUM3ikgRvl3hPchdxdvazEr/BMZPU9kJTcPqexWDPFiw1z9CzlaZRfoW063uty
 0CLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiF6NjrPHNsKI+SDWY+f/7F5rkSlxuw6KaMCubac9rwinG8u5U09zGqcUdBKe7FSJUlvXiRrA=@lists.denx.de
X-Gm-Message-State: AOJu0YwtkixZst/667de7z+tMH1CR6birsGe2FVd8RxMiQIK3hQqW2bc
 R9w/o55tTDK93wXD9ebZpg6LX3AAxWlkMIA/QqBhyqz5iEKLBy8WAwndut3OUH1p3Pw02adqRMi
 UdXKOfAJyGXy87R59bxgWWQS1wSOYC3DK47QH
X-Google-Smtp-Source: AGHT+IG3QzZ+Hd+9U/afEfklDgP6/3Ix8wtZcR0cLBbsZc68Et9LKPYIqrQDJRxR7FTtlU4dfYYGIRx7vCwBpa1XZhg=
X-Received: by 2002:a05:6214:54c6:b0:6c7:c5b8:62d9 with SMTP id
 6a1803df08f44-6cb1dd6f173mr85550776d6.3.1727348695670; Thu, 26 Sep 2024
 04:04:55 -0700 (PDT)
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
In-Reply-To: <CALNFmy3-0u=RhhiPgCzj2szzhaADXrWm79jkD1p3pmpmto456g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 13:04:43 +0200
Message-ID: <CAFLszThqaF9oSxEW5ZYw9udqtC+8n3BhQj313qUvRvrQV=OwWw@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Patrick,

On Thu, 26 Sept 2024 at 10:01, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Hi Simon,
> On Fri, Sep 20, 2024 at 6:01=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Ilias,
> >
> > On Fri, 20 Sept 2024 at 08:36, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 19 Sept 2024 at 18:36, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Thu, 19 Sept 2024 at 17:20, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.org> wro=
te:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > >
> > > > > [...]
> > > > >
> > > > > > > > > +
> > > > > > > > > +               if (!addr)
> > > > > > > > > +                       return log_msg_ret("mem", -ENOMEM=
);
> > > > > > > > > +       } else {
> > > > > > > > > +               pages =3D efi_size_in_pages(TABLE_SIZE);
> > > > > > > > > +
> > > > > > > > > +               ret =3D efi_allocate_pages(EFI_ALLOCATE_A=
NY_PAGES,
> > > > > > > > > +                                        EFI_ACPI_RECLAIM=
_MEMORY,
> > > > > > > > > +                                        pages, &new_acpi=
_addr);
> > > > > > > > > +               if (ret !=3D EFI_SUCCESS)
> > > > > > > > > +                       return log_msg_ret("mem", -ENOMEM=
);
> > > > > > > > > +
> > > > > > > > > +               addr =3D (void *)(uintptr_t)new_acpi_addr=
;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > >
> > > > > > > > The tables should be written regardless of whether EFI_LOAD=
ER is enabled.
> > > > > > >
> > > > > > > *Why*? How do you expect to hand them over to the OS?
> > > > > >
> > > > > > Why - because boards which need ACPI tables to boot should gene=
rate
> > > > > > them;
> > > > >
> > > > > Noone argued that.
> > > > >
> > > > > > also this happens when U-Boot starts up, in last_stage_init()
> > > > > > How - it isn't possible, but eventually I suppose it will be, o=
nce we
> > > > > > have a use case for booting with ACPI but without EFI
> > > > >
> > > > > Are you aware of such an OS? If not, we can accept the patches wh=
en we
> > > > > have a reason.
> > > >
> > > > Which patches? This is how it works today. We set up the tables in
> > > > last_stage_init(), so they can be examined while in U-Boot.
> > >
> > > What I mean, is that until we have a valid use case to store the ACPI
> > > in a bloblist, I prefer them being allocated with proper EFI memory
> > > backing
> >
> > I'm going to assert prior art here. If ARM is to have ACPI in U-Boot,
> > it should follow the most recent x86 approach and store it in the
> > bloblist. That is what the blloblist is for. It also avoids using
> > memory below the U-Boot area, which is not allowed.
> >
> > >
> > > >
> > > > It is the patches to change this which I object to.
> > > >
> > > > > I remember patches being hard NAK'ed on using DTs to pass the ACP=
I
> > > > > table address in the past.
> > > >
> > > > Yes, I believe Bytedance carries a patch locally for that :-)
> > >
> > > Exactly
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Can we drop this else clause? We should always use the blob=
list.
> > > > > > >
> > > > > > > Both Heinrich and I said the exact opposite. Unless there's a
> > > > > > > perfectly good reason why we should keep them in bloblist mem=
ory, I'd
> > > > > > > like us to do that
> > > > > >
> > > > > > The main reason is that we should not be putting things in memo=
ry
> > > > > > between the start of RAM and the bottom of the U-Boot area. Tha=
t
> > > > > > region of memory is supposed to be for loading images. Most boa=
rds
> > > > > > hard-code the image-load addresses in environment variables. Bu=
t even
> > > > > > if they didn't, we should not be using that memory for U-Boot d=
ata.
> > > > >
> > > > > EFI allows you to request a specific address to use. We can choos=
e one
> > > > > that fits the requirements
> > > >
> > > > So long as it is in U-Boot's space, that is fine. I just sent a pat=
ch
> > > > about relocation which covers this. It occured to me that this feat=
ure
> > > > of U-Boot, which I have always assumed was common knowledge, may ha=
ve
> > > > not been noticed.
> > > >
> > > > > >
> > > > > > Another reason is that the bloblist is designed for this, for k=
eeping
> > > > > > tables in a small, contiguous area of memory, so that when pass=
ed to
> > > > > > Linux they are not spread all over the place.
> > > > >
> > > > > Linux does not and will not read tables from a bloblist though
> > > >
> > > > Indeed. There really isn't any point, anyway, since there are other
> > > > ways of passing the tables along...except for ACPI with FDT but tha=
t
> > > > isn't a valid use case for Linux so far.
> > >
> > > What we are trying to do with EFI is to stay as close to the spec and
> > > the current OS implementations as possible. So again, please allocate
> > > EFI memory for the ACPI tables. The patches to convert it to bloblist
> > > allocating them are minimal, so we can do it, once there's an actuall
> > > need for it.
> >
> > As it stands today, efi_acpi_register() does not do an EFI allocation,
> > it just adds the existing allocation to the EFI tables. This works
> > fine for x86 - see arch/x86/lib/tables.c - so I would like ARM to do
> > the same. The need for it is (as above) that we should ensure that
> > memory usage is within the U-Boot area. This is something which
> > bloblist handles automatically. It is also nice to see all the tables
> > in one place with 'bloblist list'
> >
>
> So what's the consent and the next step here?
> Is the current code OK as is, as it works with both BLOBLIST and without?
> Should I drop support for one or the other?

Just BLOBLIST. The EFI allocation is done using efi_acpi.c which you
can check to make sure it is working.

Using efi_allocate_pages() before the app starts is not good.

Regards,
Simon
