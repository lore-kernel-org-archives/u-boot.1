Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8297CEBF9A
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 11:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B3B890C6;
	Fri, 27 Sep 2024 13:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aoYT4uhk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E7AE88F28; Fri, 27 Sep 2024 13:30:44 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C426C890C6
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 13:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e06fade5eeso1634056a91.2
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 04:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727436640; x=1728041440; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftJGpDBJTda+Qtx6mcacj7jb/9lMKTQfp3iZYZGBO+A=;
 b=aoYT4uhkPwitb9lrhdm60v/AMMZBLMINM43THcg15RMvsJ4Y1KSEna3NMlo0KdFVBg
 t5sCO1O1Fgd7i7Fwy5fui/wXyOqjtgDjo9VxWKbepbS+NHwdRhHQ8gtqX+0Hi7jfUysC
 c6JkMdqWoQ+nHKBw8iLx8dxQeADDXL283ZxfINEmEQc91VsssMgCuLmVc/o40exO526s
 lnwjxBMx5uMvHnlZ5ncvrpPCzIhtkMFlq5jtOEb/1RLd950TAI2/6O35Mu9z3wGEmBeJ
 bETo7SfDU37mFydYjs+zeGk252oI0oD70BasOvLHkn0BQWUy3suYEY4gdPS9X8E5KFbE
 lY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727436640; x=1728041440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftJGpDBJTda+Qtx6mcacj7jb/9lMKTQfp3iZYZGBO+A=;
 b=hx1mM9PxPEtAjMA05+b5jAxB76W36k8LOCY1pYBRdfdAgT7iDNA+fzSAyd5C7rRhaZ
 gIRO5lr0M29GI3Pr/IoZjILKJgBHJTnsQGa1wDOxPzl3gwSLAebahbI46K3KotvGllSO
 +AZjgdibb9BW2iqitDzYmiOf69toQzYAwHhl/YgP169MBd5HkptcjIHZEojBC6fXC6Xa
 wRah2pNm7YgjRANIN1cvpH7JXP1Pt8A+oQOoO6s7MA8XgL+DzGCEjMSuCpOz6J7O1Z2q
 zYTdgsf93Iy88UPD7brypV34lcWp66MmxAjpR9z4Cb5Z7Zgj23A0AHchvDRhYsJLqFC4
 3yTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWidN3S4GrFrW+VV+2v4ENtFjbyxLVJvyW6fRsgW0SZAQHfIgqfSmyvYNYTBptNLg9AhK+zt/w=@lists.denx.de
X-Gm-Message-State: AOJu0YxT0FrvHSZruIeUJoJ6q+AAB6A9OSxQVM49V3Mg0Lr2CJdLYuTl
 crOlxPLptdEuy6xQ1qMJrmJz8WwNFWNz9JHUNBfOXpfflFGK5E3yH08KVGsRgIwYAqNlJIIlSWx
 Sbk8lozdwFqdA8KcZsDrN8XyEAmj7nZntDFV1IQ==
X-Google-Smtp-Source: AGHT+IGZv257ksV6z/b2TIO2ltWxE3LRoRXwSNF8GNMlzV2JnpvCdnphdNoWLuP85KpsgETrV16WP18z2U1BxxoshhU=
X-Received: by 2002:a17:90a:9e1:b0:2d3:c9bb:9cd7 with SMTP id
 98e67ed59e1d1-2e0b8ed4a59mr3187240a91.36.1727436640163; Fri, 27 Sep 2024
 04:30:40 -0700 (PDT)
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
In-Reply-To: <CAFLszTjoZuF6x38j_PyQdO9W_zzyQY+DPrXKm8J2pM-T_GYsgA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Sep 2024 14:30:03 +0300
Message-ID: <CAC_iWjLR7ndQAPOhe+Z-11F-nFXBGpPUOZB=Mmwt36CzJtvD0g@mail.gmail.com>
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

On Fri, 27 Sept 2024 at 13:53, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 26 Sept 2024 at 13:18, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 26 Sept 2024 at 14:04, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Patrick,
> > >
> > > On Thu, 26 Sept 2024 at 10:01, Patrick Rudolph
> > > <patrick.rudolph@9elements.com> wrote:
> > > >
> > > > Hi Simon,
> > > > On Fri, Sep 20, 2024 at 6:01=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Fri, 20 Sept 2024 at 08:36, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Thu, 19 Sept 2024 at 18:36, Simon Glass <sjg@chromium.org> w=
rote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Thu, 19 Sept 2024 at 17:20, Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.or=
g> wrote:
> > > > > > > > >
> > > > > > > > > Hi Ilias,
> > > > > > > > >
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > > > > > +
> > > > > > > > > > > > +               if (!addr)
> > > > > > > > > > > > +                       return log_msg_ret("mem", -=
ENOMEM);
> > > > > > > > > > > > +       } else {
> > > > > > > > > > > > +               pages =3D efi_size_in_pages(TABLE_S=
IZE);
> > > > > > > > > > > > +
> > > > > > > > > > > > +               ret =3D efi_allocate_pages(EFI_ALLO=
CATE_ANY_PAGES,
> > > > > > > > > > > > +                                        EFI_ACPI_R=
ECLAIM_MEMORY,
> > > > > > > > > > > > +                                        pages, &ne=
w_acpi_addr);
> > > > > > > > > > > > +               if (ret !=3D EFI_SUCCESS)
> > > > > > > > > > > > +                       return log_msg_ret("mem", -=
ENOMEM);
> > > > > > > > > > > > +
> > > > > > > > > > > > +               addr =3D (void *)(uintptr_t)new_acp=
i_addr;
> > > > > > > > > > > > +       }
> > > > > > > > > > > > +
> > > > > > > > > > >
> > > > > > > > > > > The tables should be written regardless of whether EF=
I_LOADER is enabled.
> > > > > > > > > >
> > > > > > > > > > *Why*? How do you expect to hand them over to the OS?
> > > > > > > > >
> > > > > > > > > Why - because boards which need ACPI tables to boot shoul=
d generate
> > > > > > > > > them;
> > > > > > > >
> > > > > > > > Noone argued that.
> > > > > > > >
> > > > > > > > > also this happens when U-Boot starts up, in last_stage_in=
it()
> > > > > > > > > How - it isn't possible, but eventually I suppose it will=
 be, once we
> > > > > > > > > have a use case for booting with ACPI but without EFI
> > > > > > > >
> > > > > > > > Are you aware of such an OS? If not, we can accept the patc=
hes when we
> > > > > > > > have a reason.
> > > > > > >
> > > > > > > Which patches? This is how it works today. We set up the tabl=
es in
> > > > > > > last_stage_init(), so they can be examined while in U-Boot.
> > > > > >
> > > > > > What I mean, is that until we have a valid use case to store th=
e ACPI
> > > > > > in a bloblist, I prefer them being allocated with proper EFI me=
mory
> > > > > > backing
> > > > >
> > > > > I'm going to assert prior art here. If ARM is to have ACPI in U-B=
oot,
> > > > > it should follow the most recent x86 approach and store it in the
> > > > > bloblist. That is what the blloblist is for. It also avoids using
> > > > > memory below the U-Boot area, which is not allowed.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > It is the patches to change this which I object to.
> > > > > > >
> > > > > > > > I remember patches being hard NAK'ed on using DTs to pass t=
he ACPI
> > > > > > > > table address in the past.
> > > > > > >
> > > > > > > Yes, I believe Bytedance carries a patch locally for that :-)
> > > > > >
> > > > > > Exactly
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Can we drop this else clause? We should always use th=
e bloblist.
> > > > > > > > > >
> > > > > > > > > > Both Heinrich and I said the exact opposite. Unless the=
re's a
> > > > > > > > > > perfectly good reason why we should keep them in blobli=
st memory, I'd
> > > > > > > > > > like us to do that
> > > > > > > > >
> > > > > > > > > The main reason is that we should not be putting things i=
n memory
> > > > > > > > > between the start of RAM and the bottom of the U-Boot are=
a. That
> > > > > > > > > region of memory is supposed to be for loading images. Mo=
st boards
> > > > > > > > > hard-code the image-load addresses in environment variabl=
es. But even
> > > > > > > > > if they didn't, we should not be using that memory for U-=
Boot data.
> > > > > > > >
> > > > > > > > EFI allows you to request a specific address to use. We can=
 choose one
> > > > > > > > that fits the requirements
> > > > > > >
> > > > > > > So long as it is in U-Boot's space, that is fine. I just sent=
 a patch
> > > > > > > about relocation which covers this. It occured to me that thi=
s feature
> > > > > > > of U-Boot, which I have always assumed was common knowledge, =
may have
> > > > > > > not been noticed.
> > > > > > >
> > > > > > > > >
> > > > > > > > > Another reason is that the bloblist is designed for this,=
 for keeping
> > > > > > > > > tables in a small, contiguous area of memory, so that whe=
n passed to
> > > > > > > > > Linux they are not spread all over the place.
> > > > > > > >
> > > > > > > > Linux does not and will not read tables from a bloblist tho=
ugh
> > > > > > >
> > > > > > > Indeed. There really isn't any point, anyway, since there are=
 other
> > > > > > > ways of passing the tables along...except for ACPI with FDT b=
ut that
> > > > > > > isn't a valid use case for Linux so far.
> > > > > >
> > > > > > What we are trying to do with EFI is to stay as close to the sp=
ec and
> > > > > > the current OS implementations as possible. So again, please al=
locate
> > > > > > EFI memory for the ACPI tables. The patches to convert it to bl=
oblist
> > > > > > allocating them are minimal, so we can do it, once there's an a=
ctuall
> > > > > > need for it.
> > > > >
> > > > > As it stands today, efi_acpi_register() does not do an EFI alloca=
tion,
> > > > > it just adds the existing allocation to the EFI tables. This work=
s
> > > > > fine for x86 - see arch/x86/lib/tables.c - so I would like ARM to=
 do
> > > > > the same. The need for it is (as above) that we should ensure tha=
t
> > > > > memory usage is within the U-Boot area. This is something which
> > > > > bloblist handles automatically. It is also nice to see all the ta=
bles
> > > > > in one place with 'bloblist list'
> > > > >
> > > >
> > > > So what's the consent and the next step here?
> > > > Is the current code OK as is, as it works with both BLOBLIST and wi=
thout?
> > > > Should I drop support for one or the other?
> > >
> > > Just BLOBLIST. The EFI allocation is done using efi_acpi.c which you
> > > can check to make sure it is working.
> > >
> > > Using efi_allocate_pages() before the app starts is not good.
> >
> > Simon, please stop trying to enforce decisions on subsystems you don't
> > maintain. I am pretty sure both Heinrich and I said no to this.
>
> I am the ACPI maintainer, and x86 maintainer long before ACPI came in
> for ARM (which I originally hacked together, as you know). I also
> wrote bloblist, including the header file which says:

That's not the EFI subsystem though. And last time I checked where the
ACPI tables are allocated makes no difference as long as they are
installed on a config table.

>
>  * 6. Bloblist is designed to be passed to Linux as reserved memory.
> While linux
>  * doesn't understand the bloblist header, it can be passed the indivdual=
 blobs.

And as I already said, *when* bloblist is consumed by any OS and you
have a valid use case other than "I can do bloblist list and I like
it", you can change 3 lines of code and allocate the ACPI table there.

>  * For example, ACPI tables can reside in a blob and the address of those=
 is
>  * passed to Linux, without Linux ever being away of the existence of a
>  * bloblist. Having all the blobs contiguous in memory simplifies the
>  * reserved-memory space.

No, it doesn't because all of the other tables are currently allocated
by the EFI subsystem. So it actually fragments it. Apart from that You
dont really know what the OS is going to do with that memory. It
depends on the EFI memory type and OS decisions.

>
> This decision has serious impacts on memory management in U-Boot. It
> also bears on the complexity of memory, how bootstd works, board
> scripts and the like. We should discuss this and figure out a path
> forward.

It has close to zero impact because *all* of the EFI memory lives in
top memory. So apart from the EFI_BOUNCE_BUFFER perhaps,  I don't see
why the impact is """serious""".
EFI allocates memory which does not affect U-Boot of file loading
apart from the max size allowed. Now with LMB it is marked as
reserved. So why is this any different from any other LMB reservation?
It's memory used by someone that you aren't allowed to use, just like
we reserve U-Boot memory. If there's a bug in reservations, by all
means, let's fix it.

Thanks
/Ilias

>
> Regards,
> Simon
