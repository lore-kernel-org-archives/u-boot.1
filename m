Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1C1CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 13:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 247CF86FD9;
	Fri, 20 Oct 2023 15:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="uCwrXU8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C6E871F6; Fri, 20 Oct 2023 15:21:48 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52D886FAD
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 15:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso137086666b.0
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 06:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697808106; x=1698412906; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XjPs3rgV8oL7sgyLjqxRKzO2OFfqpxNfXleI1r2Ev54=;
 b=uCwrXU8+R5nVVPeXsogtjBw3kAk41W7SJkFTKEtJJFBxAte0wtCfkGBRzWEVS+do9/
 +e3IhmCuElFA98H+VR5YV9Al5dv2TU48IvR19mzU9lSMXS2gnILo30PATc3B3qy/G/p+
 Jvm4zbwkXEc7jF5d5aeymOTlL0lf0bydLbJn9ORkk1YH21zXv7x2dNveMVbh/4XVZ7Pg
 yJ7AVI71M1SNXOtzMiE7oMHbyCYJ+fWMOvXnzJBt6Adv7l7mDxjloQefvJEIfTHC8AjF
 Z1Vzl1lAYReAReLWF2A7ZIU9P7EwXBhta54sZDn0UBYLFg/ox8AeSWi2K0qNfE8p9Ytv
 vaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697808106; x=1698412906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XjPs3rgV8oL7sgyLjqxRKzO2OFfqpxNfXleI1r2Ev54=;
 b=UPIMOKRJ/9p6qrEwSue+RNcTrZ2MmeZtOxqNXz1Y3xwUPJVRJh4ZW60aS4lC4ZO4gv
 tfjI+Ir03EQg3gaZLthxdVuquYjZG1UP75cWQbV0dUqwO+qiXKaXR+RhJ85dXya6LZKl
 58zio/ifvigFiS/u7m7eRva9VET1v+j+zDx9CPk8iQKZY+zFr4OzcAQgGjs1p8BEAmEs
 iHwvaNOxSsE5JBUhnouxKC62VEqEFfqnkmXuMUWzX6jz0D6kdKlgM1a17cPv9eZpIbmr
 O/A1JmN1KQKDOdhseBUM3Ibq4XcWcpHsVwOHGEZUhn1LOhLZadYOuWSyUjGYaxv5f5jf
 h0PA==
X-Gm-Message-State: AOJu0YynPiKlgEBZGqDqdlXWn98Yu3jW3xfrCvJf0GXGqPc6Ej8QQDXG
 8VPZCHsTDk2gYXiB80D2+Als7c7RCFzWc7YeClo2XePOrta3Y3SsdO16NQ==
X-Google-Smtp-Source: AGHT+IH1cApDSWEIzVk78kjCXxUMP+lUOg+HRHsDzDEdpn1UfsNaJ00fQDXlqryqZxSMoy8iYADfaP7rW+17TvGqQjs=
X-Received: by 2002:a17:907:7da4:b0:9bf:4915:22c9 with SMTP id
 oz36-20020a1709077da400b009bf491522c9mr1344702ejc.32.1697808105952; Fri, 20
 Oct 2023 06:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
 <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
In-Reply-To: <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Fri, 20 Oct 2023 06:21:33 -0700
Message-ID: <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

+Doug Anderson

Hi Heinrich,

On Thu, 19 Oct 2023 at 09:09, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 19.10.23 15:55, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Wed, 18 Oct 2023 at 02:15, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 10/18/23 05:33, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Tue, 17 Oct 2023 at 07:50, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> Forward and backward compatibility of Linux kernel device-trees is
> >>>> sometimes missing. One solution approach is to load a kernel specific
> >>>> device-tree. This can either be done via a U-Boot scripts (like the one
> >>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
> >>>> The boot loader approach currently requires to know the device-tree name
> >>>> before first boot which makes it unusable for generic images.
> >>>>
> >>>> Expose the device-tree file name as EFI variable FdtFile.
> >>>> This will allow bootloaders to load a kernel specific device-tree.
> >>>>
> >>>> The variable will not be exposed on ACPI based systems or if the
> >>>> environment variable fdtfile is not defined.
> >>>>
> >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>> ---
> >>>> v2:
> >>>>           Use a unique GUID to enable future U-Boot independent
> >>>>           standardization.
> >>>>           Do not try to add the variable on ACPI based systems.
> >>>> ---
> >>>>    include/efi_loader.h       |  5 +++++
> >>>>    lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> >>>>    2 files changed, 35 insertions(+)
> >>>
> >>> I was too slow to reply to v1.
> >>>
> >>> Does grub load the DT? I was assuming that U-Boot would pass it on?
> >>> What is the interface between U-Boot and grub?
> >>
> >> The device-tree built into U-Boot is often out of date and not usable to
> >> boot current Linux. A single device-tree can be loaded by U-Boot from
> >> file and passed on as EFI configuration table. This device-tree may not
> >> be compatible with all kernel versions exposed by GRUB.
> >>
> >> GRUB provides a devicetree command. It is disabled if you use secure
> >> boot. At least in Debian and Ubuntu GRUB invokes the
> >> EFI_DT_FIXUP_PROTOCOL exposed by U-Boot to run U-Boot's device-tree
> >> fix-ups after loading a device-tree.
> >>
> >> Vendor scripts for GRUB like Ubuntu's /etc/grub.d/10_linux add
> >> devicetree commands to the boot options in grub.cfg.
> >
> > Thanks. I wonder if you could document this somewhere? It seems like
> > there are a lot of options and it is quite complicated.
> >
> > Back to the question, I suppose you are expecting grub to load the DT
> > using this filename? But why doesn't U-Boot load it instead? It seems
> > very convoluted.
>
> A separate file of this name exists for every kernel version installed.
> The loaded dtb must match the kernel. U-Boot does not know what kernel
> version will be chosen in GRUB. And for a generic image GRUB does not
> what board it is on.
>
> >
> > Also, can we test this interface?
>
> Neither the sandbox nor QEMU have environment variable fdtfile. And we
> don't create the EFI variable with ACPI as used on the sandbox.

I worry that this is creating another interface that some poor sod is
going to have to deal with in the future. Is this part of the EFI
standard?

We should really be using the compatible string to choose the
devicetree. Why are we using filenames at all? What is the
relationship between the compatible string and the filename? Is there
a lookup table, or should we create one?

The correct way of doing this is implemented in U-Boot with
CONFIG_FIT_BEST_MATCH. Can we mirror something like that in grub, etc?

Regards,
Simon
