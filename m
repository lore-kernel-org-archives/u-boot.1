Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2122C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 15:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A808488027;
	Thu, 25 Jul 2024 17:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P6XMn3wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE5C4879AF; Thu, 25 Jul 2024 17:58:20 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC2A287EDC
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5aecbe0a9so12305eaf.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721923096; x=1722527896; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zP0w8H3kysWU01Fwil6otTPbYVmaAL+0XHoTwpduKf0=;
 b=P6XMn3wkLkAlcfY2nclfSH0qNHqq5W/TZqAZZnaOYzjxqO+gszbpLY2w5Z2vNGyjy7
 FHNxiprPaLsPG7AiYK/uTFRDiDtqAS4DoMsH2A+ELyc4fVDi1fE66zGnYmKNgTjwmdqC
 28ECHEP4j7kZqpdSDxvAz2z5YO6b89rG93cCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721923096; x=1722527896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zP0w8H3kysWU01Fwil6otTPbYVmaAL+0XHoTwpduKf0=;
 b=NRgBGwROcLjMJZ16yNlnmmbJi44t35SL+OKkBbhTcvdVsy04XPDwtbfL+mhR9V1cjz
 4wKLyahs9YuWyMZR5Ntqg2+hU6zeeCwsGYJplLW0zyv7XvIKsGG3Zqb9fLSCq9HejqkX
 eEvdypiIW7kF3pJ4Px/E0bqjRT59MbWSmWC8wBy54/pfGp8iW4iNzkyy9GpmDii8NEcA
 A7k+EZw/2CzuGwKL/W9n/5zqlv4VUaz1BPyKbri6xLSaXAXhRqClLFrgeQG309OYHy59
 p3icqKIBYbWt79mbxH3v1QDMVJGw1h2y0RaWe6xvrdB+G5bIWkeb1wNFXJzAux6JAkOA
 kMIA==
X-Gm-Message-State: AOJu0Yyx7SFsVs82pDQbnB1BfjiKP2L5NYKrwoqFcbF5qcB+7SXQDXlu
 4LooOBdlDbgEYDUPoBCGFlcJzWTuG13Fbhu2ZU5wDTMazejIAIRb2fNtMZ7uMUu+1ah3pSgQ3hF
 shBXHeC0iIOk4DAuVtNhvOiZiXd6X4yh0EoJa
X-Google-Smtp-Source: AGHT+IFn17LxWnJw4J8mtWSbJ8eZTDxoWAreR7QFc65n3QJ7w2KTXjzzZKtbXyt6vk1liF5H8Oyr3fLYEUcvqH93Ox4=
X-Received: by 2002:a05:6358:52cc:b0:19f:2c7e:a226 with SMTP id
 e5c5f4694b2df-1acfb893b16mr280429255d.5.1721923096394; Thu, 25 Jul 2024
 08:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240725135629.3505072-1-sjg@chromium.org>
 <CAC_iWjK4gn8GkUb7khSQFMC+LqPN4PQZLxqJK+gZE_TLnMfUKQ@mail.gmail.com>
In-Reply-To: <CAC_iWjK4gn8GkUb7khSQFMC+LqPN4PQZLxqJK+gZE_TLnMfUKQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 09:58:06 -0600
Message-ID: <CAFLszTjnAc_zp8MXT5g7FbWRrHcVzq6PGf-1pYzCH6sJveOd0w@mail.gmail.com>
Subject: Re: [PATCH 0/6] efi: Start tidying up memory management
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, Jul 25, 2024, 08:26 Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Simon
>
> On Thu, 25 Jul 2024 at 16:58, Simon Glass <sjg@chromium.org> wrote:
> >
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
>
> The EFI memory allocations and mappings are described in the EFI spec.
> Look at chapter 7.2 Memory Allocation Services. This patchset breaks
> various aspects of the spec, since the metadata needed for the EFI
> memory map is not kept from malloc. The reason efi_add_protocol() uses
> calloc, is that this is memory used from our internal implementation
> of the protocol linked list -- IOW how to search and identify
> protocols that we add in a list and not UEFI boot or runtime services.


Er, yes, I am aware of that chapter:-)

Can you please be more specific about which various aspects this will break?

Also please let me know if you have comments on any of the patches.

Regards,
Simon


> Thanks
> /Ilias
>
>
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
> > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=416441
> >
> >
> > Simon Glass (6):
> >   doc: Show more information in efi index
> >   efi: Convert device_path allocation to use malloc()
> >   efi: Allow monitoring of page allocations
> >   efi: Avoid pool allocation in efi_get_memory_map_alloc()
> >   efi: Use malloc() for the EFI pool
> >   efi: Show the location of the bounce buffer
> >
> >  doc/develop/uefi/index.rst               |   2 +-
> >  include/efi_loader.h                     |  24 ++++
> >  lib/efi_loader/efi_bootbin.c             |  10 ++
> >  lib/efi_loader/efi_device_path.c         |  43 ++++---
> >  lib/efi_loader/efi_device_path_to_text.c |   2 +-
> >  lib/efi_loader/efi_memory.c              | 148 +++++++++++------------
> >  lib/efi_loader/efi_setup.c               |   7 ++
> >  7 files changed, 133 insertions(+), 103 deletions(-)
> >
> > --
> > 2.34.1
> >
>
