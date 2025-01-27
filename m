Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6490C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 11:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D8C81119;
	Mon, 27 Jan 2025 12:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y1NCFP3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7356F8111F; Mon, 27 Jan 2025 12:45:35 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A155581115
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 12:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e54bd61e793so7047510276.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 03:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737978331; x=1738583131; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cFPPFyo2YfEPcSvwn7e/CEZBaLf/HylkYkbQwA47zvU=;
 b=y1NCFP3bU54c7ASn6TEkMEJrdsJWIsffJR48Wd5MGcTFT0hogVFTjmOkp/OYEjPoOk
 7mKle2u6IrEab+LzvPaFx8l0awenj1Bk6Xbgp1YElm3u3hHOJ+Gg51AHd05eEzb3mH57
 +39zDm5eM7Emnt2rVtZiVM+HYcQO0exdrpE8A6qaIyZ/55VNn9ND6cQBWLHQ/tnNYc9h
 CHDlmkvlMLcSt0LScIAKiAoCq+OLkflWIVgunzZ909OhnDd0+W0VV6+DLpevbl5TS8iM
 C0jd+oQtrON/pgN1ecJparaZHrScnuOj4qdIPCOHg19F6XUqk92tB7I+THH1lVnAVv3h
 7+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737978331; x=1738583131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cFPPFyo2YfEPcSvwn7e/CEZBaLf/HylkYkbQwA47zvU=;
 b=PZrGPqsyswZPijfgkhYdZecTg16fah7wOfW/D+HRpwSZsD9I+BkmGkSyGUKCUnn1cq
 QsU+quidrlSPppmM3dTRzoYMZMwInF0crc3S5F3zWx+HV2jyMS/l2fUkjCNOxwGzPpfB
 3QznMbv6Nh7pg9a7l41NDmnchPGDl8kyu70VwLMZ0hu5U1cwxhmA7XhBEAH0BkRBqxGt
 ICPUCzrZbhmdhnrNY8MO3Mtwg5hePRg573jophEV5QEcpTmOlBZHpMzRlAlVJ/poFcfd
 +3EicDT6Ejs+aFx6mbiM76+qZn6DlKF8c1JCTrWHTMVssUO0Sr40WlLlaDj5eRD4tisg
 QSnA==
X-Gm-Message-State: AOJu0Yw+aIf0IeB70jRkDLlMI4d2zTTmsmpNrAegYQR032Z6WIFUCxsk
 r9WdvAqqeyoO07a0kJOEb31wx69x4at2u3Y82b3LJI8PP6+vmJziQBX1i/7lsPqkFJdkswv5wKE
 hPWVXCop5mXyGLDW2Jgh+vzOIYP3qvjUNUYlFJg==
X-Gm-Gg: ASbGncu9N0z7UnGehJi5KS+WpymmoNtx+6NpTTq2ktPeeYHRAl1nqm6AbpFjdEhViU7
 h2cO80jKDx1TWhlE+nCwv/yeweF2hh1pRG0qNMExNSQRWhDpucHVi/gd5thLtQIHZi+Ila2HX
X-Google-Smtp-Source: AGHT+IGQEgi7wWwc9hFBJbHFfXCWYawKVUn+3kp3BS/lx8w1B6IlUkPHvsB5LUSANuPSsoAVYC4e/AlqS8gv8m3QxPE=
X-Received: by 2002:a05:6902:1703:b0:e58:1556:2c18 with SMTP id
 3f1490d57ef6-e5815562f6cmr15656381276.41.1737978331450; Mon, 27 Jan 2025
 03:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <CAC_iWjJtjNE0-VJJT1+aCoaADDNYyy-niZSizo-Sn6898ArLHg@mail.gmail.com>
 <CADg8p978OtFgkimMSsWyqk9pW5FgkBKdXFTKWf8UEtR=zb7U5Q@mail.gmail.com>
In-Reply-To: <CADg8p978OtFgkimMSsWyqk9pW5FgkBKdXFTKWf8UEtR=zb7U5Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Jan 2025 13:44:55 +0200
X-Gm-Features: AWEUYZnzewac2bvd-M5aWINubJmzdoXOdol2lRmvHiVaUEImnRqn8UR2WJaUGVE
Message-ID: <CAC_iWjKsYRqN2jK5DqGhJPMN77OthtkG9X8sT3fheLKur_Z23Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add pmem node for preserving distro ISO's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
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

Hi Sughosh,

On Mon, 27 Jan 2025 at 08:47, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 24 Jan 2025 at 17:10, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Heinrich, Tobias
> >
> > There's a slight problem that I forgot when commenting v2.
> >
> > Heinrich's idea of plugging this into blkmap is eventually the right
> > thing to do.
> >
> > However, when I started coding this I only added the pmem memory as
> > 'reserved' in the DT hoping that would work.
> > Unfortunately, this depends on a kernel config option. I've managed to
> > track down the problem here[0], but I haven't found time to test it
> > properly and send it upstream.
> > So for this feature to work reliably we *need* to remove the memory
> > map we hand over to the OS.
> >
> > Since using EFI memmap function into the blkmap code makes no sense,
> > can we perhaps merge v2 (or a variant of it), which only targets EFI,
> > with an explanation of *why* while I try to sort out the kernel issue?
>
> If it has been decided to go with the approach taken in V2, I will
> send an updated series which incorporates the other nits that Heinrich
> had on the patches. Those were handled in this version.

Yea I think that's the sane thing we can do for now, since this
depends on being able to remove the memory for the map we present to
the OS.

Just don't limit it to http only.

Cheers
/Ilias
>
> -sughosh
>
> >
> >
> > [0] https://git.linaro.org/people/ilias.apalodimas/net-next.git/commit/?h=main
> >
> > Thanks
> > /Ilias
> >
> > On Mon, 20 Jan 2025 at 12:51, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > >
> > > When installing a distro via EFI HTTP boot some OS installers expect
> > > the .iso image to be preserved and treat it as a "CDROM" to install
> > > packages.
> > >
> > > This is problematic in EFI, since U-Boot mounts the image, starts the
> > > installer, and eventually calls ExitBootServices. At that point the
> > > image U-Boot mounted disappears. Some distros don't care and download
> > > the missing packages from a web archive, while others halt the
> > > installation complaining they can't find certain packages.
> > >
> > > If the firmware uses ACPI, this is supported by using NFIT which
> > > provides NVDIMM ramdisks to the OS and preserves the image.
> > > We don't have anything in place for Device Trees though. Since DT
> > > supports persistent memory nodes (pmem) use those and preserve the
> > > .iso for installers.
> > >
> > > The issue can be reproduced by attempting an EFI HTTP boot with Ubuntu
> > > live server ISO, or a Rocky Linux ISO. The installation would fail
> > > with the failure to locate certain packages.
> > >
> > > The earlier version had aligned the addition of pmem nodes with the
> > > EFI HTTP boot feature. This has been changed, based on a review
> > > comment from Heinrich to instead be done by looping through the memory
> > > based blkmamp devices.
> > >
> > > Changes since V2:
> > > * Fix a checkpatch error for putting a blank line after a function
> > > * Use blkmap device based scanning for adding the pmem nodes
> > >
> > >
> > >
> > > Ilias Apalodimas (2):
> > >   efi_loader: add a function to remove memory from the EFI map
> > >   efi_loader: preserve installer images in pmem
> > >
> > > Masahisa Kojima (1):
> > >   fdt: add support for adding pmem nodes
> > >
> > > Sughosh Ganu (2):
> > >   blkmap: store type of blkmap device in corresponding structure
> > >   blkmap: add pmem nodes for blkmap mem mapping devices
> > >
> > >  boot/fdt_support.c            |  40 ++++++++++++-
> > >  boot/image-fdt.c              |   9 +++
> > >  cmd/blkmap.c                  |  16 ++++--
> > >  drivers/block/blkmap.c        |  90 +++--------------------------
> > >  drivers/block/blkmap_helper.c |  47 +++++++++++++++-
> > >  include/blkmap.h              | 103 +++++++++++++++++++++++++++++++++-
> > >  include/efi_loader.h          |  11 ++--
> > >  include/fdt_support.h         |  13 +++++
> > >  lib/efi_loader/efi_bootmgr.c  |  22 ++++++--
> > >  lib/efi_loader/efi_memory.c   |  51 ++++++++++++-----
> > >  lib/lmb.c                     |   4 +-
> > >  test/dm/blkmap.c              |  16 +++---
> > >  12 files changed, 302 insertions(+), 120 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
> > >
