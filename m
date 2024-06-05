Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5AFC27C5E
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 13:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6664A88356;
	Wed,  5 Jun 2024 15:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EC+cU7Vf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8042A88369; Wed,  5 Jun 2024 15:17:51 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EEC588377
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 15:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6afc61f9a2eso7253366d6.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717593467; x=1718198267; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4zjdQKJlqpcawQCiGO//p8SSvKoKFXUQSoekL/URfM=;
 b=EC+cU7VfJzYqwU+GqnK1pWgYUmmY2jyaw3gXkJV5AIUMuA1e6ChATUGvUIo7uwPbbD
 hr/Ac1dq9g7y3rPUhBS0Kcw5buyd2IfZgcRrwa2oghI3eIZUlQ8qepF2PGzbg9eLz33+
 COpn9j2C0UH4/cyUZpjBozZjoOKftJuGQmCbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717593467; x=1718198267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4zjdQKJlqpcawQCiGO//p8SSvKoKFXUQSoekL/URfM=;
 b=QNaiq3m5KitnSOO7pMTxrzeCN/dO3LVQ7NdiTV6tUXHa7k3b3QsNKr2XJsp0jzIQmV
 U/r3Ph1XAIpKARtGtaLFCwLyFikAOx8BP1QnNcqBk/I+B7C7ob5HxYIUuwWEvdkEFETV
 2dQ3qneIVM4DCWQXxFSJKW2BdfFuKfE2i+9QcoRSDwHf5+Dt/9iMtSXRve+7uBJTmFQ5
 FrGa+GovOfR12KVOA3I3iT7chd29RZKW1GRXmtk8nKUeeC/aRLEpyRonBPjb11DPpF37
 hwxBkHILMMbPDxYPG19xalqJ+6QzSkaLKICoBexM72DTgkaOwzXBKQNDr3ASp8Hrf461
 KqkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBNTjPL3LJbFEMEEv7t1aal1h1cuChVcrPeLpFQa791hVk/8FVmn5Z+Om9L1jVB5PgnIC0bhCcaBT7Cwy1AI7qAZGlFA==
X-Gm-Message-State: AOJu0YzM38uZ3xDAgX6Q7Kpvd0XukrUq/dX6l8vwEdogWToZFfv1eouQ
 DigB6mN6Ja0kncpqlgmJgvR0RipRvb4m/qRTWYfSCwqg8N1T5a0D2V9nKWcuHus+gjJverU1+js
 N0MEtedljz/erhBHTjlIW0AILO4kHRIGfCwZt
X-Google-Smtp-Source: AGHT+IFeL5DiU+k8vIGZEIYUksY+LSbLWEYeoM5bkZ3wjJ9h+KM/P54FAsA+IKepH7VdwcZ4VJhZoJO93bDfFxbRjBA=
X-Received: by 2002:a05:6214:1304:b0:6af:4fcd:3065 with SMTP id
 6a1803df08f44-6aff72de233mr106552296d6.19.1717593466941; Wed, 05 Jun 2024
 06:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <CANV2PTOAc50sXtz2V6s7bgnEk02TV_7+VArxBpHhF_tCGNjsmA@mail.gmail.com>
 <CAFLszTikFOL3MCOLr+MVg+sGdt3sxcjq6zhbgZxCMyVf-scRdQ@mail.gmail.com>
 <2ce195a5-e1af-43d6-82bd-252bccaa8e24@canonical.com>
In-Reply-To: <2ce195a5-e1af-43d6-82bd-252bccaa8e24@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Jun 2024 07:17:36 -0600
Message-ID: <CAFLszTj2aoxmPJUFo7CFq9u5kD2mBRbJxmNVm5xXmjrBGN7=Rg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] efi_loader: improve device-tree loading
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de, 
 E Shattow <lucent@gmail.com>
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

Hi Heinrich,

On Wed, 5 Jun 2024 at 02:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 29.05.24 18:30, Simon Glass wrote:
> > Hi,
> >
> > On Tue, 28 May 2024 at 18:38, E Shattow <lucent@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> On Tue, May 28, 2024 at 7:43=E2=80=AFAM Heinrich Schuchardt
> >> <heinrich.schuchardt@canonical.com> wrote:
> >>>
> >>> In U-Boot EFI boot options can already specify both an EFI binary and
> >>> an initrd. With this series we can additionally define the matching
> >>> device-tree to be loaded in the boot option.
> >>>
> >>> With the last patch the boot manager will fall back the device-tree
> >>> specified by $fdtfile in directories '/dtb/', '/', or '/dtb/current/'
> >>> on the boot device if no device-tree is specified in the boot
> >>> option or via a bootefi command parameter.
> >>>
> >>
> >> As tested the $fdtfile environment variable has no effect on
> >> global EFI boot when i.e. EFI/BOOT/BOOTRISCV64.EFI
> >> on EFI System Partition and no user-added boot option;
> >> $fdtfile env variable is not used with "mmc 0" or whichever
> >> global boot option is enabled by default in the boot order.
> >>
> >> Adding a boot option for EFI/BOOT/BOOTRISCV64.EFI
> >> and giving this priority in the boot order allows $fdtfile to
> >> be effective here. This is consistent with what is described
> >> by the series. Would the global EFI boot also get support
> >> for $fdtfile either with this or a later series?
> >>
> >>> v2:
> >>>          Update efi_dp_concat() instead of new function efi_dp_merge(=
).
> >>>          Carve out a function efi_load_option_dp_join() which we can
> >>>          use both for the eficonfig and the efidebug command.
> >>>          Rename variables id_dp, final_dp_size.
> >>>          Rename create_initrd_dp() to create_lo_dp_part().
> >>>          Use enum as parameter for create_lo_dp_part().
> >>>          Put all related changes into one patch.
> >>>
> >>> Heinrich Schuchardt (8):
> >>>    efi_loader: allow concatenation with contained end node
> >>>    cmd: eficonfig: add support for setting fdt
> >>>    cmd: efidebug: add support for setting fdt
> >>>    efi_loader: load device-tree specified in boot option
> >>>    efi_loader: move distro_efi_get_fdt_name()
> >>>    efi_loader: return binary from efi_dp_from_lo()
> >>>    efi_loader: export efi_load_image_from_path
> >>>    efi_loader: load distro dtb in bootmgr
> >>>
> >>>   boot/bootmeth_efi.c                        |  60 +---------
> >>>   cmd/eficonfig.c                            |  83 +++++++++----
> >>>   cmd/efidebug.c                             | 130 +++++++++++++++---=
---
> >>>   include/efi_loader.h                       |  24 +++-
> >>>   lib/efi_loader/Makefile                    |   1 +
> >>>   lib/efi_loader/efi_bootbin.c               |   2 +-
> >>>   lib/efi_loader/efi_bootmgr.c               |  75 +++++++++++-
> >>>   lib/efi_loader/efi_boottime.c              |   3 +-
> >>>   lib/efi_loader/efi_device_path.c           |  40 ++++---
> >>>   lib/efi_loader/efi_device_path_utilities.c |   2 +-
> >>>   lib/efi_loader/efi_fdt.c                   | 117 ++++++++++++++++++=
+
> >>>   lib/efi_loader/efi_helper.c                |  44 +++++++
> >>>   12 files changed, 445 insertions(+), 136 deletions(-)
> >>>   create mode 100644 lib/efi_loader/efi_fdt.c
> >>>
> >>> --
> >>> 2.43.0
> >>>
> >>
> >
> > Can we use the best-match compatible approach as expected by the new
> > 'make image.fit' in Linux?
> >
> > Filenames should be deprecated IMO. I am happy to help work on how to
> > do that if you agree.
>
> Hello Simon,
>
> It is the OS that creates boot options. The OS can determine the exact
> dtb file based on the compatible string and the kernel version once per
> kernel upgrade. This is much more efficient than doing the same on every
> boot.
>
> Replacing $fdtfile by a matching logic could make sense. But please
> consider the effect on boot time if have to read through more than 1000
> arm64 dtbs with U-Boot's non-caching file-system drivers.

The suggested option here is to use FIT, which is very fast at
scanning the files. Please see [1]

Failing that, we could implement a way (in FIT) of specifying that the
FDT is in an external file. In that case FIT would become a mapping
from compatible strings to filenames.

Regards,
Simon

[1] https://github.com/open-source-firmware/flat-image-tree/blob/main/sourc=
e/chapter3-usage.rst
