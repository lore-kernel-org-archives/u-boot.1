Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4CAC001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 21:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476B087516;
	Fri, 20 Oct 2023 23:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="zM9fGLG8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E8A87517; Fri, 20 Oct 2023 23:19:29 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D45C087516
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 23:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d9a4c0d89f7so1285898276.1
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697836765; x=1698441565; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Acho/F8ZOLJgR8Vg6oDvEJfv1NIsyf2STRkzsl6NsAI=;
 b=zM9fGLG8Hqum8NAQ7PEI04jJIQXrfDxaKfw67hjSAnbWjpRYy3nsPaRF1a+pLPFAD7
 2qxlvdVqZiHuLq8CSAAYPU+fJgLTXmxhp2iqPm0IUNGhQDnVyC1mz8QEOa9qu5VbNRPU
 1yWrnPaTR9hE/CmG9WfIhqzWI+moxA9emNeODfwMKN9WwaL4bx7RF7LplZt2KTEK0Ij0
 ZF3w0VFb5T9SaI6kkCNilxo5UZglGHpzcBpwzf0LT5z35UPh4B/PfP4rnNSodgJ+aJKe
 WrNfDixsl/5FtXHxUl/3o8qBDi2vBFoMXcNc48CW2ZQiDTEvlE7WrPgGLAKK8a9c1VLd
 BkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697836765; x=1698441565;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Acho/F8ZOLJgR8Vg6oDvEJfv1NIsyf2STRkzsl6NsAI=;
 b=kDdpOvXkPoi/70G/nWubdJf6Do14Wwuk2fdlhWpzQZJB/vGoCTt3LWaDPlP1Gbn3Ot
 ZguN4qyCtPdl4mb9mIBZv6wunl8M0kE9UUhQH8gtJVjyJ11cE1K8pEg8TypAjx6FX5BA
 YrA4UmD1KNQtJNHoLfZnIN61wAtVzktYDwPq57szd3D+WMfjPvBcdravp8kVyFinNrQ1
 SgYWjevv7EB+hcx704zuAY7j2biwGiHuBN7FwbThfFg6R4DV0LmDs1jY3nLkMlJx9Grg
 NxufnXkOitcA/34plVgwlfc/cckIrhK3tIC9xSW5Dm9MQ00i6pNZPPbmJL/GZ+xNmC1e
 7aHA==
X-Gm-Message-State: AOJu0YyJhPMY6hrBE5cGUviseFLb/h8rkGs54/m/U7+Jmlb9YpkowvIG
 wBtwMx9jdYc4w/DUes3MpXsN3IVauSZxoR3jTjZQ/Q==
X-Google-Smtp-Source: AGHT+IF7ncmQVYXQ3LMCAJBepfDhICTFoDzLM7D9YvKPZdF+T7h+tTAQL8op3BlyYVyhQNPZ3h0a3dziUeLfbK7N+ZQ=
X-Received: by 2002:a25:7756:0:b0:c4b:ada8:8b86 with SMTP id
 s83-20020a257756000000b00c4bada88b86mr3434466ybc.64.1697836765350; Fri, 20
 Oct 2023 14:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
 <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
 <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
In-Reply-To: <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Fri, 20 Oct 2023 14:19:07 -0700
Message-ID: <CAPnjgZ075xPLLgKTM9VnKpp20G-Jj5H=TDmkTtLq=CRvO2UK3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Doug Anderson <dianders@chromium.org>
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

Trying again to add Doug as we chatted briefly about this yesterday.

On Fri, Oct 20, 2023, 07:21 Simon Glass <sjg@google.com> wrote:
>
> +Doug Anderson
>
> Hi Heinrich,
>
> On Thu, 19 Oct 2023 at 09:09, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 19.10.23 15:55, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Wed, 18 Oct 2023 at 02:15, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> On 10/18/23 05:33, Simon Glass wrote:
> > >>> Hi Heinrich,
> > >>>
> > >>> On Tue, 17 Oct 2023 at 07:50, Heinrich Schuchardt
> > >>> <heinrich.schuchardt@canonical.com> wrote:
> > >>>>
> > >>>> Forward and backward compatibility of Linux kernel device-trees is
> > >>>> sometimes missing. One solution approach is to load a kernel specific
> > >>>> device-tree. This can either be done via a U-Boot scripts (like the one
> > >>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
> > >>>> The boot loader approach currently requires to know the device-tree name
> > >>>> before first boot which makes it unusable for generic images.
> > >>>>
> > >>>> Expose the device-tree file name as EFI variable FdtFile.
> > >>>> This will allow bootloaders to load a kernel specific device-tree.
> > >>>>
> > >>>> The variable will not be exposed on ACPI based systems or if the
> > >>>> environment variable fdtfile is not defined.
> > >>>>
> > >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >>>> ---
> > >>>> v2:
> > >>>>           Use a unique GUID to enable future U-Boot independent
> > >>>>           standardization.
> > >>>>           Do not try to add the variable on ACPI based systems.
> > >>>> ---
> > >>>>    include/efi_loader.h       |  5 +++++
> > >>>>    lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> > >>>>    2 files changed, 35 insertions(+)
> > >>>
> > >>> I was too slow to reply to v1.
> > >>>
> > >>> Does grub load the DT? I was assuming that U-Boot would pass it on?
> > >>> What is the interface between U-Boot and grub?
> > >>
> > >> The device-tree built into U-Boot is often out of date and not usable to
> > >> boot current Linux. A single device-tree can be loaded by U-Boot from
> > >> file and passed on as EFI configuration table. This device-tree may not
> > >> be compatible with all kernel versions exposed by GRUB.
> > >>
> > >> GRUB provides a devicetree command. It is disabled if you use secure
> > >> boot. At least in Debian and Ubuntu GRUB invokes the
> > >> EFI_DT_FIXUP_PROTOCOL exposed by U-Boot to run U-Boot's device-tree
> > >> fix-ups after loading a device-tree.
> > >>
> > >> Vendor scripts for GRUB like Ubuntu's /etc/grub.d/10_linux add
> > >> devicetree commands to the boot options in grub.cfg.
> > >
> > > Thanks. I wonder if you could document this somewhere? It seems like
> > > there are a lot of options and it is quite complicated.
> > >
> > > Back to the question, I suppose you are expecting grub to load the DT
> > > using this filename? But why doesn't U-Boot load it instead? It seems
> > > very convoluted.
> >
> > A separate file of this name exists for every kernel version installed.
> > The loaded dtb must match the kernel. U-Boot does not know what kernel
> > version will be chosen in GRUB. And for a generic image GRUB does not
> > what board it is on.
> >
> > >
> > > Also, can we test this interface?
> >
> > Neither the sandbox nor QEMU have environment variable fdtfile. And we
> > don't create the EFI variable with ACPI as used on the sandbox.
>
> I worry that this is creating another interface that some poor sod is
> going to have to deal with in the future. Is this part of the EFI
> standard?
>
> We should really be using the compatible string to choose the
> devicetree. Why are we using filenames at all? What is the
> relationship between the compatible string and the filename? Is there
> a lookup table, or should we create one?
>
> The correct way of doing this is implemented in U-Boot with
> CONFIG_FIT_BEST_MATCH. Can we mirror something like that in grub, etc?
>
> Regards,
> Simon
