Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460CACF58D4
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA59889C5;
	Fri, 20 Sep 2024 08:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CmaM3Et2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B4A890F0; Fri, 20 Sep 2024 08:36:48 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50AE88875
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7db1f13b14aso1306908a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726814204; x=1727419004; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W1LlmtI/oDWD5YrTD0rBCavZ0kO8JoGWEYYsNTXN8WA=;
 b=CmaM3Et2lKG49IFmdfX3gFQa/rP+tw1DGbPgsqAcD9X+aQJTbZ5ylKn+iPp5ZtSjyO
 ljxJQV8z4lvgwrjNtKEJIVlTu1RasYvLQb5/z5O3wpaKVcXOHKFXrkXfxuXBH8VyGh8X
 G08X24iN4KWiJa3cV0hMrhbDM1fu820sx11w3bICJhtpHRrMNdAl7q1HIO0u7eZEh9RI
 LOO0Vh/fuinuC5XKvEIq6BynOEZVIz90NSD3qc76M05JWkIzgnMsLBS7WpfXLJXjKRBw
 RkDfIAN0ZOQ4F+JeZ03bPBYJzG40HPoD5qZleAJKE4V06lLbwolO+HRchhhEFy0hFxZE
 73Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726814204; x=1727419004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W1LlmtI/oDWD5YrTD0rBCavZ0kO8JoGWEYYsNTXN8WA=;
 b=u9lUTQRVBEBxG1e2I0KOxo0/YFRIkygE4cQyfUMEVCDBirsepb1XF9frXH/A0YGXgy
 evHbSyqmyfiF3T4jinP9G0x3UQYBFLsqoUXBciWyL8oICHSncnNuS4xJyQ+Y3khL0aS7
 ZmjLdNgkcddQZ1dMZXIVcWtU6myRKScsrcc4eOxyzWlzbeJrn+7fVt391kZJ+6J65wxr
 OSkzHSR2jhxzVqDDPVi58XN5z15eaIeliRdQ5ObHrRn+qF/mDDaK8P3QTqNilwxlBeoV
 bm44S728UNEAfGWSTwauV26oOTzx2Wjo6FgpJ3pmbKqo8UV71TBQvtaP1fMuZfCefaFQ
 oRvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0aacgXg+eYXeg8DQwxPJL/kC0mZ/Rl2cs4eLbO9oT7QgCKPlulryKdg9VdRhXWLyVa2G+fYg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxk/uc0RTFAO7SEukSQHwhrMkUCNkWdeNU5ZLSjGIs13nL7LtVF
 PivVGe9ynIcY2f0S/1IUJHbcXPUm557yvKNTjpYr/m6Hl7cTqCMlt5yAAkF22XV92Qsn0Rk0m67
 ucnAOm+hor3GRbG2i48N84AgBBrxsIMh2FbzQsA==
X-Google-Smtp-Source: AGHT+IGiY/gCArN5fbCLvOOuOJTRHxaNty7UBizEkM2jaFPnDe0tyQNv9IwfPiAu8mLrPCFIqUGJPv0pHmATZTFdtg4=
X-Received: by 2002:a17:90b:17cb:b0:2d8:859b:931c with SMTP id
 98e67ed59e1d1-2dd80cd71femr2439940a91.33.1726814204322; Thu, 19 Sep 2024
 23:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-15-patrick.rudolph@9elements.com>
 <CAFLszTimAFGocvqbnT=JVsA2bjNa=ZfxP6Sy46a9e6VkhtdojQ@mail.gmail.com>
 <CAC_iWjLASm6U8kC68MJ0uZ14MGFS_SSL3Pcd8hcEH=a=W8gvBQ@mail.gmail.com>
 <CAFLszTgYHO7FgbCgfRwqT_yj4KBm31xKdEUrn0pZkhtLzOh=HQ@mail.gmail.com>
 <CAC_iWjKv+Z4K5xPW6MZhBZ67-rDy9iRVaoqfLKmJRwSG9nKnfA@mail.gmail.com>
 <CAFLszThA5eOM_xiMgDu=B4wAcP7wV9bzfc565rES8z6d1F8fjg@mail.gmail.com>
In-Reply-To: <CAFLszThA5eOM_xiMgDu=B4wAcP7wV9bzfc565rES8z6d1F8fjg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Sep 2024 09:36:07 +0300
Message-ID: <CAC_iWjLqmN0uA85RayC2hnMOJfCqumCpiq=waQwakd6ECfbXkg@mail.gmail.com>
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

Hi Simon,

On Thu, 19 Sept 2024 at 18:36, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 19 Sept 2024 at 17:20, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> >
> > [...]
> >
> > > > > > +
> > > > > > +               if (!addr)
> > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > > +       } else {
> > > > > > +               pages = efi_size_in_pages(TABLE_SIZE);
> > > > > > +
> > > > > > +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > > > > > +                                        EFI_ACPI_RECLAIM_MEMORY,
> > > > > > +                                        pages, &new_acpi_addr);
> > > > > > +               if (ret != EFI_SUCCESS)
> > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > > +
> > > > > > +               addr = (void *)(uintptr_t)new_acpi_addr;
> > > > > > +       }
> > > > > > +
> > > > >
> > > > > The tables should be written regardless of whether EFI_LOADER is enabled.
> > > >
> > > > *Why*? How do you expect to hand them over to the OS?
> > >
> > > Why - because boards which need ACPI tables to boot should generate
> > > them;
> >
> > Noone argued that.
> >
> > > also this happens when U-Boot starts up, in last_stage_init()
> > > How - it isn't possible, but eventually I suppose it will be, once we
> > > have a use case for booting with ACPI but without EFI
> >
> > Are you aware of such an OS? If not, we can accept the patches when we
> > have a reason.
>
> Which patches? This is how it works today. We set up the tables in
> last_stage_init(), so they can be examined while in U-Boot.

What I mean, is that until we have a valid use case to store the ACPI
in a bloblist, I prefer them being allocated with proper EFI memory
backing

>
> It is the patches to change this which I object to.
>
> > I remember patches being hard NAK'ed on using DTs to pass the ACPI
> > table address in the past.
>
> Yes, I believe Bytedance carries a patch locally for that :-)

Exactly

>
> >
> > >
> > > >
> > > > >
> > > > > Can we drop this else clause? We should always use the bloblist.
> > > >
> > > > Both Heinrich and I said the exact opposite. Unless there's a
> > > > perfectly good reason why we should keep them in bloblist memory, I'd
> > > > like us to do that
> > >
> > > The main reason is that we should not be putting things in memory
> > > between the start of RAM and the bottom of the U-Boot area. That
> > > region of memory is supposed to be for loading images. Most boards
> > > hard-code the image-load addresses in environment variables. But even
> > > if they didn't, we should not be using that memory for U-Boot data.
> >
> > EFI allows you to request a specific address to use. We can choose one
> > that fits the requirements
>
> So long as it is in U-Boot's space, that is fine. I just sent a patch
> about relocation which covers this. It occured to me that this feature
> of U-Boot, which I have always assumed was common knowledge, may have
> not been noticed.
>
> > >
> > > Another reason is that the bloblist is designed for this, for keeping
> > > tables in a small, contiguous area of memory, so that when passed to
> > > Linux they are not spread all over the place.
> >
> > Linux does not and will not read tables from a bloblist though
>
> Indeed. There really isn't any point, anyway, since there are other
> ways of passing the tables along...except for ACPI with FDT but that
> isn't a valid use case for Linux so far.

What we are trying to do with EFI is to stay as close to the spec and
the current OS implementations as possible. So again, please allocate
EFI memory for the ACPI tables. The patches to convert it to bloblist
allocating them are minimal, so we can do it, once there's an actuall
need for it.

Thanks
/Ilias
>
> Regards,
> Simon
>
> [..]
