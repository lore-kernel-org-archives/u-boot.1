Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1410D3B9A4
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D4289C97;
	Tue, 26 Nov 2024 16:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DO1OxE7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064FC89C9B; Tue, 26 Nov 2024 16:42:10 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF6689C9C
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa51b8c5f4dso572051066b.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635727; x=1733240527; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NrUM5yeQ0sYSfPzeyirb7G2JiQOLKICjhPtm+NyyLC8=;
 b=DO1OxE7/Rt3f8+FJiu6V6Zp8yPVkkJfDZrVTh+nLv+LnQ8ifC1jhhJwAQSiaKpLozz
 5+ZfB/7xxDbSKFUSp1KW2NslXS+WHPGsxRdC4boztonngWFjH+4GaJCCK8awYWH2M3UT
 ZTXUS/0WCt1moHFY7QModiWaBT7JrS8rr1Akg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635727; x=1733240527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NrUM5yeQ0sYSfPzeyirb7G2JiQOLKICjhPtm+NyyLC8=;
 b=vx60zpZQyK0OuqhLYeZj6/GKH3N5o3Tg5WD0qM5/g1KlI5dmirjPTg6fzE5LFNUmmY
 k4sNHb/xLiD/+BHTfbn+QmLNxa6uwQGeBivQKHnzYsn0AwPMwn9XOdJ1V4GeGSW3qzsK
 i3thRN4PcTfct4Ln4HP52nl6ZtDPP6Vl/KGJITlUYZQMpet4yyypZyx31sHBQO9unNRV
 N1trYU12SN+lwOOZ6k7Ur8h9iAQ3phLONSqTdYVUg9GoQ9N4QRzueT239bDYJ+KHPV7V
 X3oFaY3/vKHpfPxFWxzTGiysJOybM8f1WahASSJzZJpT5jzI+l+fg3RnYA/RiU/kB7J3
 SK1Q==
X-Gm-Message-State: AOJu0YzDgOJY1yQMQoBcEUh5aJ5xcZvgPW6r8J9BCWuyAffJgtuXXz+x
 DkuKARVsWfjiKPx0K59Tm6B7V/Rxi+P0RFJI8wEBIJQUCpiuR0Jdx/p/IXl72LDD4IzcpGRxYQY
 smoDf7f7Yf8/TGrnuqm3+wYLGDhLi1uYPxZze
X-Gm-Gg: ASbGncsGa7Y106+xb3XDrRCMlh8YDiuS0teaobnzulpmZ4dCjg1kXamLNyyAT3uUKdu
 lEcXMROzje9zEN8Yy2+4Hk2HzOQAb9bI=
X-Google-Smtp-Source: AGHT+IHhz3ihi12xESjJySrPNVje1M6TaIDAGeqZ6ZNmntcnYOhIxkxH7ccuOgIgTuK5aI5qsMNj40UYi0KLv5ApyJw=
X-Received: by 2002:a17:906:cc1:b0:aa5:41b2:e23c with SMTP id
 a640c23a62f3a-aa541b2f6d4mr738465066b.54.1732635727176; Tue, 26 Nov 2024
 07:42:07 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <CAC_iWjJif4Q1FYGkQC6fO3bSkxtrYYBkPYagd-Wn1fQf7GV2kg@mail.gmail.com>
In-Reply-To: <CAC_iWjJif4Q1FYGkQC6fO3bSkxtrYYBkPYagd-Wn1fQf7GV2kg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:41:55 -0700
Message-ID: <CAFLszTiQYeV7x7bdpq-Cfc2f6_w1jyg2ttmWpP-yNm0nD6hnzw@mail.gmail.com>
Subject: Re: [PATCH 00/13] efi: Tidy up confusion between pointers and
 addresses
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Janne Grunau <j@jannau.net>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Ilias,

On Tue, 26 Nov 2024 at 01:13, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> Apart from the comments on the other patches, the SCT memory tests
> crash with this series. Please run it locally before sending a v2.

I did briefly get it running on my laptop, but not for x86_64. I
understand from Heinrich that EDK2 doesn't build for any architecture
at present.

Which arch are you using? I'd like to be able to run SCT easily, if possible.

Regards,
Simon

>
> Thanks
> /Ilias
>
> On Mon, 25 Nov 2024 at 22:45, Simon Glass <sjg@chromium.org> wrote:
> >
> > The EFI-loader implementation converts things back and forth between
> > addresses and pointers, with not much consistency in how this is done.
> >
> > Within most of U-Boot a pointer is a void * and an address is a ulong
> >
> > This convention is very helpful, since it is obvious in common code as
> > to whether you need to call map_sysmem() and friends, or not.
> >
> > As part of cleaning up the EFI memory-management, I found it almost
> > impossible to know in some cases whether something is an address or a
> > pointer. I decided to give up on that and come back to it when this is
> > resolved.
> >
> > This series starts applying the normal ulong/void * convention to the
> > EFI_loader code, so making things easier to follow.
> >
> > Link: https://lore.kernel.org/u-boot/20240725135629.3505072-1-sjg@chromium.org/
> >
> >
> > Simon Glass (13):
> >   efi: Define fields in struct efi_mem_desc
> >   efi_loader: Convert efi_get_memory_map() to return pointers
> >   efi_loader: Show the resulting memory address from an alloc
> >   efi_loader: Update startimage_exit self-test to check error
> >   efi_loader: Move some memory-function comments to header
> >   efi_loader: Use the enum for memory type
> >   efi_loader: Make more use of ulong
> >   efi_loader: Tidy up use of addresses
> >   lmb: Reduce mapmem contortions in lmb_map_update_notify()
> >   efi_loader: Simplify efi_dp_from_mem()
> >   efi_loader: Tidy up efi_reserve_memory()
> >   efi_loader: Drop extra brackets in efi_mem_carve_out()
> >   efi_loader: Don't try to add sandbox runtime code
> >
> >  include/efi.h                                 |  15 ++
> >  include/efi_api.h                             |   6 +-
> >  include/efi_loader.h                          | 100 +++++--
> >  lib/efi_loader/efi_bootbin.c                  |   3 +-
> >  lib/efi_loader/efi_bootmgr.c                  |  11 +-
> >  lib/efi_loader/efi_boottime.c                 |  51 ++--
> >  lib/efi_loader/efi_device_path.c              |  18 +-
> >  lib/efi_loader/efi_dt_fixup.c                 |   8 +-
> >  lib/efi_loader/efi_helper.c                   |   7 +-
> >  lib/efi_loader/efi_image_loader.c             |   2 +-
> >  lib/efi_loader/efi_memory.c                   | 246 +++++++-----------
> >  lib/efi_loader/efi_var_mem.c                  |   6 +-
> >  .../efi_selftest_startimage_exit.c            |   6 +-
> >  lib/lmb.c                                     |  10 +-
> >  14 files changed, 251 insertions(+), 238 deletions(-)
> >
> > --
> > 2.43.0
> >
