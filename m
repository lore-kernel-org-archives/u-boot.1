Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC7EC0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 06:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80B2280F9E;
	Mon, 27 Jan 2025 07:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ESMkGaVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7345D80FC4; Mon, 27 Jan 2025 07:47:03 +0100 (CET)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C136480F96
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 07:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-518799f2828so2090673e0c.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 22:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737960419; x=1738565219; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q+Vd932vKDXXQV0Nx+QLGlCF7opf46BWVx+hjIMHiZs=;
 b=ESMkGaVe/yQtStYfjX2GjwCNoXQ3pNe1ENtVXfcew+YwaVmcw9vq3X2/FI2hgPgYwz
 rkV/VSSLhSoKY88M6ZqVkbWtprOiT+1fPzSrNHtotjCUtxn8QZxaOlxZKSjzDFG+77be
 OLvszuQpIGn6XvHjcIBbaLzk0Q9ylDG8MCc2EnF0H04OKjJylUMXnall09c7iGYhTXcQ
 QCSDU+eotnwHHQaCd6Zi0HeWKMdAX8M3MPlCFfuOkORJLbZLg5upP4n6zIxlBZkwNwKh
 mSys6AyBccETgYtF5Ld/cJlxv033JAuyD5c7l4giSkXNrWvX3J7hQV4XfDAcLWxXL4Tk
 VDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737960419; x=1738565219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q+Vd932vKDXXQV0Nx+QLGlCF7opf46BWVx+hjIMHiZs=;
 b=Mp31X53XGQU+w4UWFo6K0BiunmO0OijCSRZOqlduEX5YUOgKmYisS60H8SeJB/K39G
 n0TldIWUTIE9D9XvHPTtBMWEzj4H9zjAmqn5u7Fz2keAVAKnd0b3B7H4SEO3I+6f7sFc
 gVIivAV4cX+iVrlhw00w1mAttQMlfsohqSZlxY0YLEmkUdjo/Z88+e8HAI/CpK/mN3sh
 FgjpGZFA9yMngtmn9VzOWllj1RNAnmVxcfjdwEk4xJFnAiAjlmqHQoOF7PrfsCBFrtgu
 fKjF/NkpQ0KA7IACh7HQBV/YsCIKa2FkphnlziFOfrjXd4DD/dezeG8d1IWt2db8QdUZ
 8Npg==
X-Gm-Message-State: AOJu0YwnpkuJRnQ3kksEI6/CWGJMA7EJgAbTGJWNcYXvIFHsqmSFsCHI
 nOOmtSCNajigfLeM/M1vOrDiBDjq70Nhd/1cCSpD6XAtEEg9Z5Br2iRAkVXs6bQSKtvaICoU0En
 md8OsyRqzkzFAtDiByrpVu4u2DeEGIDMhhWd0k1u2XiRjqFdh
X-Gm-Gg: ASbGncspfOJmfyBoXT2tmwtYbnaEGItnyKAmj7WO/rA8KQx6eWLn092mSXMFj6KLAgx
 CVq7cdM9geUk4jn8QkxqRcf8bbXsI4mqDL6R6C30chDJUmQI/ZqsoM34acKuVKr8=
X-Google-Smtp-Source: AGHT+IGCne4hJB5GcL29RFgSvNVg4DzWxKqKFINhO5WEvBabXiswtb3R+LGIlUfyBZn6YBvr3IE7vXD+48cCl9hkmr0=
X-Received: by 2002:a05:6122:4302:b0:516:1e32:f8c7 with SMTP id
 71dfb90a1353d-51e4f989935mr10861062e0c.0.1737960419547; Sun, 26 Jan 2025
 22:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <CAC_iWjJtjNE0-VJJT1+aCoaADDNYyy-niZSizo-Sn6898ArLHg@mail.gmail.com>
In-Reply-To: <CAC_iWjJtjNE0-VJJT1+aCoaADDNYyy-niZSizo-Sn6898ArLHg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 27 Jan 2025 12:16:48 +0530
X-Gm-Features: AWEUYZlHvo8aKX9marTUyyKmXQ8-J3_ua1dtd97wbojEiaNBjy4wFAuJa7dXjJk
Message-ID: <CADg8p978OtFgkimMSsWyqk9pW5FgkBKdXFTKWf8UEtR=zb7U5Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add pmem node for preserving distro ISO's
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Fri, 24 Jan 2025 at 17:10, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Heinrich, Tobias
>
> There's a slight problem that I forgot when commenting v2.
>
> Heinrich's idea of plugging this into blkmap is eventually the right
> thing to do.
>
> However, when I started coding this I only added the pmem memory as
> 'reserved' in the DT hoping that would work.
> Unfortunately, this depends on a kernel config option. I've managed to
> track down the problem here[0], but I haven't found time to test it
> properly and send it upstream.
> So for this feature to work reliably we *need* to remove the memory
> map we hand over to the OS.
>
> Since using EFI memmap function into the blkmap code makes no sense,
> can we perhaps merge v2 (or a variant of it), which only targets EFI,
> with an explanation of *why* while I try to sort out the kernel issue?

If it has been decided to go with the approach taken in V2, I will
send an updated series which incorporates the other nits that Heinrich
had on the patches. Those were handled in this version.

-sughosh

>
>
> [0] https://git.linaro.org/people/ilias.apalodimas/net-next.git/commit/?h=main
>
> Thanks
> /Ilias
>
> On Mon, 20 Jan 2025 at 12:51, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> >
> > When installing a distro via EFI HTTP boot some OS installers expect
> > the .iso image to be preserved and treat it as a "CDROM" to install
> > packages.
> >
> > This is problematic in EFI, since U-Boot mounts the image, starts the
> > installer, and eventually calls ExitBootServices. At that point the
> > image U-Boot mounted disappears. Some distros don't care and download
> > the missing packages from a web archive, while others halt the
> > installation complaining they can't find certain packages.
> >
> > If the firmware uses ACPI, this is supported by using NFIT which
> > provides NVDIMM ramdisks to the OS and preserves the image.
> > We don't have anything in place for Device Trees though. Since DT
> > supports persistent memory nodes (pmem) use those and preserve the
> > .iso for installers.
> >
> > The issue can be reproduced by attempting an EFI HTTP boot with Ubuntu
> > live server ISO, or a Rocky Linux ISO. The installation would fail
> > with the failure to locate certain packages.
> >
> > The earlier version had aligned the addition of pmem nodes with the
> > EFI HTTP boot feature. This has been changed, based on a review
> > comment from Heinrich to instead be done by looping through the memory
> > based blkmamp devices.
> >
> > Changes since V2:
> > * Fix a checkpatch error for putting a blank line after a function
> > * Use blkmap device based scanning for adding the pmem nodes
> >
> >
> >
> > Ilias Apalodimas (2):
> >   efi_loader: add a function to remove memory from the EFI map
> >   efi_loader: preserve installer images in pmem
> >
> > Masahisa Kojima (1):
> >   fdt: add support for adding pmem nodes
> >
> > Sughosh Ganu (2):
> >   blkmap: store type of blkmap device in corresponding structure
> >   blkmap: add pmem nodes for blkmap mem mapping devices
> >
> >  boot/fdt_support.c            |  40 ++++++++++++-
> >  boot/image-fdt.c              |   9 +++
> >  cmd/blkmap.c                  |  16 ++++--
> >  drivers/block/blkmap.c        |  90 +++--------------------------
> >  drivers/block/blkmap_helper.c |  47 +++++++++++++++-
> >  include/blkmap.h              | 103 +++++++++++++++++++++++++++++++++-
> >  include/efi_loader.h          |  11 ++--
> >  include/fdt_support.h         |  13 +++++
> >  lib/efi_loader/efi_bootmgr.c  |  22 ++++++--
> >  lib/efi_loader/efi_memory.c   |  51 ++++++++++++-----
> >  lib/lmb.c                     |   4 +-
> >  test/dm/blkmap.c              |  16 +++---
> >  12 files changed, 302 insertions(+), 120 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
