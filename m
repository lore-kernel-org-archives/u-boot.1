Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785B5E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F2C80315;
	Tue, 17 Dec 2024 20:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EacKjdvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683CB8022F; Tue, 17 Dec 2024 20:48:29 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E878036E
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2efb17478adso4765377a91.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464905; x=1735069705; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Y12bLJzMEMPqPQZIP9h6gU937To0FCqOzS7aj+y5FU=;
 b=EacKjdvTct0KhVk/bk0GbXPS/xZ9LVtThhUg5Cfs/F9fRpzxkGFQRhVQkz2NLp+ySd
 z3HfSMAtX4jc25CAF21c/QYaLUVOzHniIdoJ5Mn7wbpfNfjGQqYLc8pSXjJ/Ghv5E0ek
 lb9e+/IypgQN1Xv/FuKn/OEcZl/LcSUaC38tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464905; x=1735069705;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Y12bLJzMEMPqPQZIP9h6gU937To0FCqOzS7aj+y5FU=;
 b=vKnMbtm/flEqZYAr9DqFOE3c5H4AOmW4OaRzidO0LyEamRXrO38+G4Xyd6XEQJ9JKx
 qkkfjhNsQrvuXptePXxb8knyu5qCeuHDHJ1mNW5yf450VDyNKsk2LLu9szr1M3EoXYdz
 U5sYudAeQWR4ya8fE83rzvlo0ZhXOjuHWNM23J3rei7K+jAJlVaiYkAoXuwVLacJowsm
 /u4MzX5+qIJCAXQXUJp5Oxs59RGA7fl5/9hjqSdiyYO2Vxa3QeNEWJI+X/NImwB0lNuZ
 +oyIMc43FpWrbk0FJmK0HN0X1QMIRLqQvpQ8y2Z+DU0uP4z8hfa7HEd5ah68ZoQYd18y
 byhQ==
X-Gm-Message-State: AOJu0Yzps0EyzLavu5vZbF+rSC9danD1kzkGUvB7FrckPjsJbd6AvvAx
 GNmwdzR3h+sI6KpgUk2lEP/iHsAgW4VjuQR+vzAAXNKv/bIY5YmFPdxd6UjX1t0nUkx2Ky8G1BS
 EXoVU8AjI48mX3142fRo3zW4OXnlbXJsj8O5T
X-Gm-Gg: ASbGncv56E9rKp5FXo2y7cCVab1cnLjGAYzeVna/od7+3unAbXhNDajMip5MtJ4XoNi
 fYfoo7iEW0w7RYlvZBMWdpyZBXIxfTk6Kzy3mlVM=
X-Google-Smtp-Source: AGHT+IF4tF3yTfZsWEfkLLZNSKGJFqiwmjDOJEzUTfsf02Dp37SG7tEjRL2+15au+14eZUd8sC2O670Ry5GA2BUgb5Y=
X-Received: by 2002:a17:90b:2b8e:b0:2ee:d63f:d71 with SMTP id
 98e67ed59e1d1-2f2e91d6163mr223964a91.14.1734464905085; Tue, 17 Dec 2024
 11:48:25 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:48:11 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjJRK2wvObHAtDENQQqmZwwbcozexXtWwzbvscmdT_jRfg@mail.gmail.com>
References: <CAC_iWjJRK2wvObHAtDENQQqmZwwbcozexXtWwzbvscmdT_jRfg@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-4-sjg@chromium.org>
 <CAC_iWjLVee69ALVcHixM+H4wvJhM5R03-jDCwL7unipRtr-0Fw@mail.gmail.com>
 <CAFLszTgxbkFP9o+tb-983P3vPmH+qHd8vp7VBym2WafhcwKQLg@mail.gmail.com>
 <CAC_iWjLNvR=TMp9tvuwrxmjqN7+Gz8-CZbaCgq841NcPQNQukA@mail.gmail.com>
 <CAFLszTiirJ9eLJ6R4rJ5LDWA4M2o3Mksdk8z35=NKQM244LKYA@mail.gmail.com>
Date: Tue, 17 Dec 2024 11:48:11 -0800
X-Google-Sender-Auth: 06gfx_-8I1EB88Sj3AqjJAPuUYg
Message-ID: <CAFLszTgh9UK-v3ZUbGWxY2urgTykp5SVro6oXgdK7J7qUPn27Q@mail.gmail.com>
Subject: Re: [PATCH v5 03/23] efi_loader: Add comments where incorrect
 addresses are used
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

On Thu, 12 Dec 2024 at 15:44, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 11 Dec 2024 at 23:15, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Wed, 11 Dec 2024 at 17:58, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 11 Dec 2024 at 07:48, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Some functions are passing addresses instead of pointers to the
> > > > > efi_add_memory_map() function. This confusion is understandable since
> > > > > the function arguments indicate an address.
> > > > >
> > > > > Make a note of the 8 places where there are problems, which would break
> > > > > usage in sandbox tests.
> > > > >
> > > > > Future work will resolve these problems.
> > > >
> > > > NAK, this serves no purpose whatsoever. Just send a patch with
> > > > whatever changes you think are needed
> > >
> > > Please see below
> > >
> > > >
> > > > Thanks
> > > > /Ilias
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > > A request was made in v4 to drop this patch, but in the same thread, a
> > > > > query was sent about why we need these addresses, so at least until the
> > > > > series is about to be applied, I've left it in, so we can have that
> > > > > discussion in one place and build a shared understanding of why these
> > > > > addresses are needed, instead of peppering the rest of the series with
> > > > > similar questions.
> > >
> > > I'm quite happy to drop this patch. But I want to first make sure that
> > > you understand that these bugs exist today in the code, albeit they
> > > only matter on sandbox.
> >
> > Thei weird thing is sandbox works perfectly fine in EFI, passes all
> > internal tests, EFI SCT tests, loads binaries etc. Any idea why that
> > works?
>
> From what I can tell, the code mentioned is not tested by sandbox yet.
> It would just segfault. We do have a lot of self tests, but my
> bootflow_efi should allow testing of more features over time. I
> noticed the runtime-code issue when looking at an EFI log.
>
> BTW how are you running that? When I tried it on x86_64 it just
> crashed. Are you using the sandbox build on an Arm64 machine?

Yes, and it passes all the SCT tests.

Thanks
/Ilias
>
> >
> > > You will notice that my future patches don't
> > > change the code mentioned in this file. The bugs are simply resolved
> > > by reworking the EFI-loader memory map to use addresses, instead of
> > > pointers cast to u64
> > >
> > > So can you please confirm this makes sense? (if not, let's discuss
> > > it). Then I can drop this patch and the later one.
> >
> > The ptrs to u64 doesn't make too much sense tbh. I do understand how
> > sandbox works, but EFI deals with physical addresses which are also
> > mapped 1:1
>
> Yes, and that's why (in efi_boottime) the conversion is done in one
> place (from u64 pointers/addresses to U-Boot addresses). It simplifies
> the code and avoids the kind of bugs here.
>
> Regards,
> Simon
>
>
> >
> > Thanks
> > /Ilias
> > >
> > > > >
> > > > > Link: https://lore.kernel.org/u-boot/CAC_iWjLex4Z41CDpx4u07XeCYgjB7H+Ynd8aQYL-wruH7yRmQA@mail.gmail.com/
> > > > >
> > > > > (no changes since v2)
> > > > >
> > > > > Changes in v2:
> > > > > - Add a new patch with comments where incorrect addresses are used
> > > > >
> > > > >  lib/efi_loader/efi_acpi.c    | 2 ++
> > > > >  lib/efi_loader/efi_bootmgr.c | 5 +++++
> > > > >  lib/efi_loader/efi_helper.c  | 1 +
> > > > >  lib/efi_loader/efi_smbios.c  | 6 +++++-
> > > > >  lib/efi_loader/efi_var_mem.c | 2 ++
> > > > >  5 files changed, 15 insertions(+), 1 deletion(-)
> > > > >
Applied to sjg/master, thanks!
