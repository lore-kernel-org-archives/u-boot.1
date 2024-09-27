Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F05CDD1AE
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 13:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73DD7890AA;
	Fri, 27 Sep 2024 15:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w4iA3qNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 598F4890E9; Fri, 27 Sep 2024 15:38:52 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FC4F89089
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 15:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7d7a9200947so1463326a12.3
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727444328; x=1728049128; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VJ3MrTpU6PfhVXuaB8tv5bPb16y+63SXU49l+213Asw=;
 b=w4iA3qNrsHLPba6ozWSiG2XqyMa8gdZqIQ4g0gSebVoNyQQTzbkTL/TXq0NfUWEHHg
 riGeybOY4tDzXFKT/pI3ZBr+1tmlVrt9Ob/haDa4hC1wt7adY1La2ZUQpUGnEX8OAYS+
 rLM+tsEye1Xz42gaAUEGMIjNzLeGyzWRIo+ecuFydTOvOQRY3NDzL7A09QWFocj7K5QT
 gmzcAEURWapjcUwhPdPnGqY6mBgEa5XpdMDP2M/vHZ7NN+D9ruaaYq9ubj5oGh0XiCrw
 S4sdorGt2khlZH7+cwj7mZiDtjEb+hPEzFxfenh3z13YX+MlmWiXMrOdgvr2795wAaYu
 0DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727444328; x=1728049128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJ3MrTpU6PfhVXuaB8tv5bPb16y+63SXU49l+213Asw=;
 b=TTa1SMP4FwHMK5EPq7Ra749ebmWzuXNpSU+JSNbzPgGdUbU97hI7z8BrNgsqdgUq7j
 lN5uXU9Hsl3ILI/DZWne9gzZ7RRRHgSOQ747/mRGajmkPViVwTulwMxFlGD4XNhrprye
 xVVsnXsr8svHp0uuY48gSandLcKSj3k9s0WpM/zrnxhOg2NPnd7qHrgYYoEKFewf6rwc
 iJGipLdx7HkUW3g87rc1JWYmZY5225W6BDi6mKOMSudGhdly9gYb7c5GPqyGa5j+4EXV
 kfeTjw300WZ0gYOXytINzOTCEDoTEGKj8ZhSBA1MTtFpR40P0IOuu2XA2LolmoZIH/pS
 5tug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmCEnQrTS5ThJUztNbJOoI2fmAyHeuTVu2xkeYDP4alFCLFxBzs3p2oH9Yg6yprHtXIrum1CI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2R6DgifxGkFt04vdfIQLjMMALAYH76UdfbAojLwbey/jQMYQB
 KUGEgbB0EM7IE/Rrz2WB/F+e+CeWPFAkAc622vBjSqjftic5rLGzOeg5dyTJ/bRID+V2LNfdxFL
 zCM7NxEolfQ8zIX3R08+Bu5bkHJVIIS52n1wcPK9UPTE5r8rn
X-Google-Smtp-Source: AGHT+IGuLAFn18VXSafirQUHN3v6nupId53tyVn/uImW9ihHrldsE8t9+Hclkm8avfj3bCN8TZjIj3lt3Gk8HvcTtDc=
X-Received: by 2002:a05:6a20:6526:b0:1d4:fb8c:f515 with SMTP id
 adf61e73a8af0-1d4fb8cf747mr3583373637.4.1727444327754; Fri, 27 Sep 2024
 06:38:47 -0700 (PDT)
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
 <CAFLszThcqgvAf0DDKhOXnKAdQ21r-PLDppTM=CASbaaONTei4g@mail.gmail.com>
 <CAC_iWjJnANTb27oWVJiucUSPfuE5gW7HWDQCjTegDy1iVeQqNg@mail.gmail.com>
In-Reply-To: <CAC_iWjJnANTb27oWVJiucUSPfuE5gW7HWDQCjTegDy1iVeQqNg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Sep 2024 16:38:11 +0300
Message-ID: <CAC_iWjLw=BLOABvHGtcUgNtwYttcNS=OM-+-cdheasra-WNi_A@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Fri, 27 Sept 2024 at 16:14, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > > > > > > > in one place with 'bloblist list'
> > > > > > > >
> > > > > > >
> > > > > > > So what's the consent and the next step here?
> > > > > > > Is the current code OK as is, as it works with both BLOBLIST and without?
> > > > > > > Should I drop support for one or the other?
> > > > > >
> > > > > > Just BLOBLIST. The EFI allocation is done using efi_acpi.c which you
> > > > > > can check to make sure it is working.
> > > > > >
> > > > > > Using efi_allocate_pages() before the app starts is not good.
> > > > >
> > > > > Simon, please stop trying to enforce decisions on subsystems you don't
> > > > > maintain. I am pretty sure both Heinrich and I said no to this.
> > > >
> > > > I am the ACPI maintainer, and x86 maintainer long before ACPI came in
> > > > for ARM (which I originally hacked together, as you know). I also
> > > > wrote bloblist, including the header file which says:
> > >
> > > That's not the EFI subsystem though. And last time I checked where the
> > > ACPI tables are allocated makes no difference as long as they are
> > > installed on a config table.
> >
> > With my maintainer hat on, ACPI tables go in a bloblist.
> >
> > The difference it makes is that the tables end up in the U-Boot memory-area.
> >
> > >
> > > >
> > > >  * 6. Bloblist is designed to be passed to Linux as reserved memory.
> > > > While linux
> > > >  * doesn't understand the bloblist header, it can be passed the indivdual blobs.
> > >
> > > And as I already said, *when* bloblist is consumed by any OS and you
> > > have a valid use case other than "I can do bloblist list and I like
> > > it", you can change 3 lines of code and allocate the ACPI table there.
> >
> > Bloblist is not intended to be consumed by an OS. It is a firmware
> > construct, a way for U-Boot to arrange things in such a way that they
> > can be located and updated at runtime. What objection do you actually
> > have to using bloblist for tables?
>
> That bloblist, is currently used for the firmware handoff protocol.
> And that protocol *ends* when U-Boot launches, so I don't see why
> adding anything there that's not defined makes any sense.
>
> >
> > >
> > > >  * For example, ACPI tables can reside in a blob and the address of those is
> > > >  * passed to Linux, without Linux ever being away of the existence of a
> > > >  * bloblist. Having all the blobs contiguous in memory simplifies the
> > > >  * reserved-memory space.
> > >
> > > No, it doesn't because all of the other tables are currently allocated
> > > by the EFI subsystem. So it actually fragments it. Apart from that You
> > > dont really know what the OS is going to do with that memory. It
> > > depends on the EFI memory type and OS decisions.
> >
> > The ACPI table is not allocated by the EFI subsystem. Neither is
> > SMBIOS, which currently uses malloc() but should move into a bloblist
> > too.
>
> SMBIOS is different. it's not tightly linked to EFI. But we mark that
> region properly in memory as well.
>
> > The system table is in U-Boot's data region. Much of EFI's data
> > and all the driver model stuff is in the malloc() region.
>
> You keep saying "much of EFI data" and I keep repeating that whatever
> is *not* needed by the EFI spec, internal allocations, lists, etc we
> use malloc. Whatever is described in the EFI spec, we use
> efi_allocate_XXXXXX()
>
> >
> > >
> > > >
> > > > This decision has serious impacts on memory management in U-Boot. It
> > > > also bears on the complexity of memory, how bootstd works, board
> > > > scripts and the like. We should discuss this and figure out a path
> > > > forward.
> > >
> > > It has close to zero impact because *all* of the EFI memory lives in
> > > top memory. So apart from the EFI_BOUNCE_BUFFER perhaps,  I don't see
> > > why the impact is """serious""".
> > > EFI allocates memory which does not affect U-Boot of file loading
> > > apart from the max size allowed. Now with LMB it is marked as
> > > reserved. So why is this any different from any other LMB reservation?
> > > It's memory used by someone that you aren't allowed to use, just like
> > > we reserve U-Boot memory. If there's a bug in reservations, by all
> > > means, let's fix it.
> >
> > I think you are saying that because only a small amount of memory is
> > affected it doesn't matter much.
>
> No, I am saying this because you need to allocate the memory
> regardless if you want to support EFI. So as long as it's not in the
> middle of the memory space, not allowing you to load stuff, it makes
> little difference.
>
> > Well, I suppose so. But if it doesn't
> > matter, why is Sughosh spending all this time solving the problem?
>
> First of all, we got multiple asks from Tom saying LMB wasn't doing
> all that it should for a long time and needed fixing regardless.
> LMB prior to the patches was calling efi_get_memory_map_alloc() on the
> reserve function and be aware of EFI mappings, but that wasn't the
> best solution. With the lmb created on the fly we also had to call
> that function every time before LMB could decide what memory is free.
>
> > Also with [1] I definitely saw it allocating stuff where it should
> > not. If it has so little impact, why are we still discussing it?
>
> So why is this a problem if LMB now says "you are going to overwrite
> system memory"?

Just to make things a bit more clear here, since I don't have a
reproducer. I assume you place the initrd within the memory space of
the bounce buffer. At some point, if that buffer gets used, the initrd
will corrupt. But with the new patches, you won't be able to load
anything on a region that's reserved.

> Also, how are you loading the kernel and initrd? To boot with EFI? Can
> you send me a reproducer?
> What I imagine is happening is that you deliberately choose a high
> address, which somehow gets overwritten. But with LMB in place this
> goes away.
>
> >  Also,
> > my efforts seem to have uncovered latent bugs, where EFI tests fail if
> > there is not a large margin after each allocation. That should be
> > cause for concern. We would not put up with that elsewhere in U-Boot.
> >
> > I am not trying to mess with EFI in U-Boot, if that is what you are
> > worried about. Actually I haven't been paying it enough attention as
> > it is in good hands...but I need to put more time into it. As a
> > subsystem it is here for the long haul and it needs to interoperate
> > properly.
>
> Unfortunately, it doesn't have to merely interpolate. There are some
> spec requirements we can't twist around because we used to do things
> differently 8 years ago. The clear answer here, is disable EFI for
> anyone that thinks it's so intrusive. And report breakages so we can
> fix them.
>
> > I was at a conference last week where there was a talk about
> > U-Boot as an EFI app with a pass-through (i.e. not calling
> > exit-boot-services) to Linux's EFI stub. There is a lot of activity in
> > this area. EFI is an important piece of technology in the industry.
> > But this is U-Boot, and we just need to design things properly. I have
> > quietly commented on some of my concerns (e.g. efi_set_bootdev()) but
> > have not put time into fixing them.
>
> Me neither, but hopefully once the LWIP and mbedTLS are merged, we
> will have time to fix a few things.
>
> >
> > There is no need for the 6-8 tidy allocations, which are done before
> > the app starts, to be allocated in the wrong place, with a small
> > impact. We can just do it in malloc(). Let's just fix it.
>
> I won't repeat why this is problematic, I've explained more than once.
> On top of that this is opportunistic, the way we run things e.g the
> cmd subsystem, efi will be initialized regardless. An app might as
> well return, so without a clear use case of breakage I don't think we
> should change that.
>
> >
> > There is no need for the tables to be allocated in an EFI-specific
> > way, or using lmb.
>
> Neither is for bloblist
>
> > We have bloblist for that purpose. What's the
> > concern?
>
> That it's easier and cleanr for me to review and maintain code that's
> as close to the spec as possible. And I see no reasons to use
> bloblist. Or at least none that are so important.
>
> Thanks
> /Ilias
> >
> > Regards,
> > Simon
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240725135629.3505072-7-sjg@chromium.org/
