Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68A1CE7AA6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 00:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F195188CC2;
	Fri,  6 Sep 2024 02:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EoOHnh8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5180E88CC5; Fri,  6 Sep 2024 02:28:31 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24A588CB6
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 02:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6c353f2f954so8206396d6.3
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725582508; x=1726187308; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aO4CPTRBRUipCXndKIME5moiyZjBsTbNqPaHTutIubM=;
 b=EoOHnh8I2aqjV2JPIvmA7ftad13V6wPxlau+eG3oNcRuAVHOu9nMATCRjtLXQ7F+8n
 oUgM+exKBIQNZbrIM2vPaoh8E1E6ObFSkcjlW2ubJhE2ZTsu05Pv/0csc5v74KCzlOP5
 OD6eDiHZ5YQCx8spv7Ie/1K7ggVuQ2BosspVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725582508; x=1726187308;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aO4CPTRBRUipCXndKIME5moiyZjBsTbNqPaHTutIubM=;
 b=iZuHVmrRKCSYfFb2SlaIWTPnk5HgvExiZTJTKt2v0P6NuuVXdvKIMv4meMLXojY0DO
 tN19AyPyMvZoprK1HV4DnH4SGvJ6GZvgrpeiKqG9BvM+LoP0+dgPD9RIgOYT8B9KoQ9p
 4+1b77oVBJA5TsEprlI5ro/pQEywyq1MBXbZ9BxV+FFy2TUEp2yLiHmcO9ytXwl7l1Yt
 bSq2blvDBYNeGk0hFMbOgx3rw6rOLOy9XPyzRz5Tg6c0YmrSqrbNU9AdG4Y5BQ2rxJDV
 PVOWR+omctC4EmDPEjnk8y3XQYZBX+QS62rtnomL7d8/KuDtpvUr+TtXO8UTKjBQl5Oj
 OMeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNL6sn9OEFwljzMhl7gQOZBBYukSX/ULw5AVx0cS6BbuM44NewOnfz1Nm2t4KK6I3Wc6qiGcw=@lists.denx.de
X-Gm-Message-State: AOJu0YzjPW2Tr9DtIgpz4evHinrs1CMrJh1ScR6GoXCTRbA18NssekIS
 e++9Q84nSHH+t/qGag29VYg2ZibV+B6D4JRWlgpAIZ18Eykjf8ibdNk/ncj3gu9hCKaIaugc9ts
 cw2wT6GpD+JrWKIPq4/kUvEZUdDVui6Qc0HWe
X-Google-Smtp-Source: AGHT+IEKkHXCq/c9mssqp2xcrGHtHtjSg7UdYrbMu81X6WZjdBeHlk3q+mLk0emUq0yZz4ibPGS1uCuIGQhUPBKOpkM=
X-Received: by 2002:a05:6214:3a09:b0:6c1:6aa0:c21 with SMTP id
 6a1803df08f44-6c5282fe5aemr14284856d6.3.1725582507576; Thu, 05 Sep 2024
 17:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240901222259.456932-1-sjg@chromium.org>
 <Ztlh70H-G6eP0wOr@debian>
In-Reply-To: <Ztlh70H-G6eP0wOr@debian>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Sep 2024 18:28:16 -0600
Message-ID: <CAFLszTieH03eQ4gTmu+HjYbRNLXkBjfR2g3kqZkR3f9U7-0C5A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] efi: Start tidying up memory management
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>
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

Hi Vincent,

On Thu, 5 Sept 2024 at 01:47, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> On Sun, Sep 01, 2024 at 04:22:56PM -0600, Simon Glass wrote:
> > We have been discussing the state of EFI memory management for some
> > years so I thought it might be best to send a short series showing some
> > of the issues we have talked about.
> >
> > This one just deals with memory allocation. It provides a way to detect
> > EFI 'page allocations' when U-Boot' malloc() should be used. It should
> > help us to clean up this area of U-Boot.
> >
> > It also updates EFI to use U-Boot memory allocation for the pool. Most
> > functions use that anyway and it is much more efficient. It also avoids
> > allocating things 'in space' in conflict with the loaded images.
>
> Hi Simon,
>
> Thank you for this series.
>
> I did test it on top of v2024.10-rc4 with AArch64 simulators (FVP & Qemu)=
, with
> OS boots and ACS-IR, and I see no regression. Same with sandbox on x86 an=
d the
> python tests.
>

Thank you for testing.

Ilias, Heinrich, can this series (and the EFI-test one) be applied?
Sughosh has already sent a follow up where we start to diverge on how
to fix the memory-allocation problems, so I would like to make sure
these are in there first.

Regards,
Simon


> Best regards,
> Vincent.
>
> >
> > This series also includes a little patch to show more information in
> > the index for the EFI pages.
> >
> > Note that this series is independent from Sugosh's lmb series[1],
> > although I believe it will point the way to simplifying some of the
> > later patches in that series.
> >
> > Overall, some issues which should be resolved are:
> > - allocation inconsistency, e.g. efi_add_protocol() uses malloc() but
> >   efi_dp_dup() does not (this series makes a start)
> > - change efi_bl_init() to register events later, when the devices are
> >   actually used
> > - rather than efi_set_bootdev(), provide a bootstd way to take note of
> >   the device images came from and allow EFI to query that when needed
> > - EFI_LOADER_BOUNCE_BUFFER - can use U-Boot bounce buffers?
> >
> > Minor questions on my mind:
> > - is unaligned access useful? Is there a performance penalty?
> > - API confusion about whether something is an address or a pointer
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D416441
> >
> > Changes in v3:
> > - Add new patch to drop the memset() from efi_alloc()
> > - Drop patch to convert device_path allocation to use malloc()
> >
> > Changes in v2:
> > - Drop patch 'Show more information in efi index'
> > - Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
> > - Add the word 'warning', use log_warning() and show the end address
> >
> > Simon Glass (3):
> >   efi: Drop the memset() from efi_alloc()
> >   efi: Allow use of malloc() for the EFI pool
> >   efi: Show the location of the bounce buffer
> >
> >  common/dlmalloc.c            |   7 +++
> >  include/efi_loader.h         |  29 ++++++++-
> >  include/malloc.h             |   7 +++
> >  lib/efi_loader/efi_bootbin.c |  11 ++++
> >  lib/efi_loader/efi_memory.c  | 119 ++++++++++++++++++++++++-----------
> >  5 files changed, 136 insertions(+), 37 deletions(-)
> >
> > --
> > 2.34.1
> >
