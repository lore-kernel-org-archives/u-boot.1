Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCDCE74AC0
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 15:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E12C7893D9;
	Tue,  3 Dec 2024 16:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IudBkU3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0EE893DB; Tue,  3 Dec 2024 16:55:26 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58BC5893D6
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 16:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so826126966b.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 07:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733241324; x=1733846124; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0eDjfxfTp0jB6ypXV48Dgn1Gaxf+ElKTKGJIMdVl2lk=;
 b=IudBkU3bITtcr02wBFLlU7rv9Rio+//dmJywpeRqE5Wl/7qbvRYxCSrK5cO4oygPTH
 /FozUSu2ndl5Hpp1/rGWoyoBAv4txaqcAmCtcHizhYQl9610lHKj43o6d8ueFVDlWV8h
 WGZ27+fcvs1VOjnZEGlUDNH4tRYJVO8wsKbvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733241324; x=1733846124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0eDjfxfTp0jB6ypXV48Dgn1Gaxf+ElKTKGJIMdVl2lk=;
 b=dDEzbUKsbKlKOSr9y3LVBTQ2FttlvMKbr/HMZhDirK3OiYie1NiYeztCDHETUMTCWw
 4Og5bdU233pF3wkA2ImMfWqBrP9eT3VbjOQ/MlgieGsYers95b2ZpbUQMv3FwCBjmXOE
 +ArAtZlO7F2d42kI0s45ALzIqTJQInSFwHl63uoA7pop+BB3bkyxb4rhTixoPJGk2RyG
 CLrZvMzOpKJINllfxG9DvIopVOJ/fCxM2h39UtNkwa5QeODukUr6NlC1ee/RUvEQwGtH
 qWnMoswaxjVE9OY4abGGRailPamme3Nzo38NZlHcjydGrSsNNoZNKsuQZJXJVwsz4f2f
 G5Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUavnPWMgahKSmNPWytxPEqkFVOIEVm6q9sqvcuhCmu05jcM7M4Wgx7zj4UA0ubGW6s/LvrEQ4=@lists.denx.de
X-Gm-Message-State: AOJu0YwJjVP7SjuXhYlcSKr7R94xHiw6tF0aYk4MyU8PPzpvk6W/W20A
 2JyzzHVAuV/zq5ssn/UcIFJk9ZLm1rKFfW19ovqh1IM6IHWIjwoBQzwkaMx4V481h/4pFtZXXrK
 ElaYflwkXTp9zvICjQ55c8e3iNZodMjYjFkag
X-Gm-Gg: ASbGncuR674cfHLa9h8NTG2K2/p/1u9eCvq2eeCmWIpWOEDigmXFPJ18uxtTcPtCCX7
 9nkfLq0txFGEczawlMu0F8J5qq8wOGny+
X-Google-Smtp-Source: AGHT+IEx6Cn3LH/b85XpqfIUd1/RvmJ5uiWSfbKyrYhDZ8uUYc+lOgKk61MuFcVb5EdFSVEtXQFZICoMNta4zgXsbCI=
X-Received: by 2002:a17:906:cc1:b0:a99:8a5c:a357 with SMTP id
 a640c23a62f3a-aa5f7f2ba6amr208974966b.58.1733241323798; Tue, 03 Dec 2024
 07:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-5-sjg@chromium.org>
 <20241202201832.GH2457179@bill-the-cat>
 <CAFLszTitE4Gq+LUEm64ro2eL4_VME+gDh7s2jEnBTmVvkgX9sg@mail.gmail.com>
 <CAC_iWjLex4Z41CDpx4u07XeCYgjB7H+Ynd8aQYL-wruH7yRmQA@mail.gmail.com>
 <CAFLszTiMi89uydJUmDg740opTJXm0YJ8WUQ5aJPwxPnb+9EGMw@mail.gmail.com>
 <20241203140952.GV2457179@bill-the-cat>
In-Reply-To: <20241203140952.GV2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 08:55:11 -0700
Message-ID: <CAFLszThL8Uj6bB=BL-w5Y-EBGErVHsfqHQH02anws9oz08EHrQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/25] efi_loader: Add comments where incorrect
 addresses are used
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Tue, 3 Dec 2024 at 07:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 03, 2024 at 06:45:58AM -0700, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Tue, 3 Dec 2024 at 01:49, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, 3 Dec 2024 at 02:22, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Mon, 2 Dec 2024 at 13:18, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Dec 01, 2024 at 08:24:23AM -0700, Simon Glass wrote:
> > > > >
> > > > > > Some functions are passing addresses instead of pointers to the
> > > > > > efi_add_memory_map() function. This confusion is understandable since
> > > > > > the function arguments indicate an address.
> > > > > >
> > > > > > Make a note of the 8 places where there are problems, which would break
> > > > > > usage in sandbox tests.
> > > > > >
> > > > > > Future work will resolve these problems.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > Please just resolve these rather than introducing a patch to then fix
> > > > > them later. This is something that should have been fixup'd before
> > > > > posting. Thanks.
> > > >
> > > > That was deliberate, as I wanted people to see the problems. It will
> > > > save discussion on later patches where the problems are fixed, if we
> > > > can agree that these are actual problems. If people are happy to add
> > > > review tags to the later patches then I'm happy to redo it.
> > >
> > > I am pretty sure Heinrich has repeated this in the past. Why do we
> > > have to sprinkle around map_sysmem/unmap sysmem for sandbox?
> > > Polluting the entire u-boot to support a special platform is less than
> > > ideal. Why can't sandbox limit this internally and do whatever
> > > mappings it needs when it receives an address?
> >
> > Tom, I suppose I have made my point.
> >
> > Ilias, this is documented at [1] and has been the same for 10 years.
> >
> > See for example the 'md' command, do_mem_md(), which shows how 'md 0'
> > is implemented in sandbox.
> >
> > As I have mentioned before, the nice thing is that you can easily make
> > code work with sandbox just by converting casts from
> > address-to-pointer into map_sysmem().
> >
> > Back to this series, if you look at efi_allocate_pages() you'll
> > currently see three calls (two map_to_sysmem() one map_sysmem(), but
> > now, with this series, there is none. It also makes it a lot easier to
> > understand what is going on, IMO.
> >
> > Regards,
> > Simon
> >
> > [1] https://docs.u-boot.org/en/latest/arch/sandbox/sandbox.html#memory-emulation
>
> This is something I was wondering about yesterday in fact. Especially
> these days when "everyone" is developing on machines with 8GB or more of
> memory, why does sandbox not just malloc 512MB/1GB/2GB/4GB (make it a
> switch?) and pretend that area is memory starting at some address.
> Especially if it's less than 4GB and starts at 0x80000000 more "memory
> starts at 0" bugs would be found and fixed. I swear we did something
> like that in my OS class 20+ years ago. I'm not sure what your link is
> meant for, as it doesn't say why sandbox works the way it does, merely
> that it works this way. Not that it can't work some other way.

It could work some other way, it's just that this seems to be the best way.

It is easier to have memory starting at address zero (many platforms
do), For example, tests can assume that and are easier to write,
particularly tests which check cmdline output.

But note that the actual pointer address is elsewhere, so we do get a
segfault if a null pointer is used. That has indeed found a lot of
bugs.

Using a mapping does make it easy to see when code has been set up for sandbox.

Some tests rely on memory being preserved across phases, so if memory
moves around in each phase, it gets pretty confusing. Also things like
kernel_addr_r become hard, and printing out addresses becomes very
confusing when every address is 0x555555599fbc ...

In my opinion, sandbox is an important and useful feature of U-Boot.
It is where I do almost all of my development and testing. We have >1k
tests. So I believe it is worth the cost of a little discipline around
address/pointer casting. What do you think?

Regards,
Simon
