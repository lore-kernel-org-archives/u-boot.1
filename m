Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6BBE77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 01:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3814D89589;
	Mon,  9 Dec 2024 02:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oL+/QM0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 658D7893E6; Mon,  9 Dec 2024 00:07:41 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F4188DB6
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 00:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa662795ca3so191489866b.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 15:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733699255; x=1734304055; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GjOfrwTxQv2UKyIoEXNjIxiLN6Uau3JaYhqgRp9QNaE=;
 b=oL+/QM0SBuHXepPG0KXV4Oco25R40++ejO0XMgHpzVAGFBwrVJcKPSEYg/JSLs2Pho
 B7RDFIbRL+pLJmerUgePhgN2hVIApn5tP8bfGT/oD3X13ktz7XMkULcQYNBZN65D6/Lk
 aWGV6Hrxs3V0kjzkgjz38Lv2YHFoP1WbSfWLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733699255; x=1734304055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GjOfrwTxQv2UKyIoEXNjIxiLN6Uau3JaYhqgRp9QNaE=;
 b=M4GMFrTzu9p/8SV+Q+8BHpixE7pOMFSe3mFOMtpMxVN0ZRVS/1VcfawDApAJM3eSiy
 icv+e/IC4V9l4dT1uRA5qFmizfFnDLc0lGYpJt9X23v43wHqh3Jl7lqL4HUQ6Djsf8LX
 RWmm7HFPIY2XrRv4Pfe3d1SQV/94XMh7sKlnFP8Mscz3nm0EcgXx1yt2rqEqi/Nf3l2v
 9xp1cSF+RRbq0Zb1p4xGeu+8ITExFgeHKD2nnektXU2JGLlNBtq4re3LnyuzBE44O64/
 CTqropogABlz1WKwlnw4dUY8hLRpcPAoGUgGc6n7CUfA3w0qq3UzLPRoXtN4h05lCKO1
 XZdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0skwBKfCOJJDHoBBlWyNbV0NEUu+qbXGuthdITTNOJSNkj9Sju8YfVFN4tqr+nU9CcOK/9So=@lists.denx.de
X-Gm-Message-State: AOJu0YyahulrTVGrLZ0LtSaClCK8iQAoJem/wr9Fok9xqMFpYrIiTlyn
 8JBatFVAW28FH+CwJiIHZe/R13/rRw1InPNqarzJ8RbDfQfDuwANu2UJhqJB/MBAmNviwRHAt0S
 pAqUyeORuQff5hzlilCxpAB5II7FFXXowd72D
X-Gm-Gg: ASbGncuMYfuuZ85eNry5QGu5trvf/GdQtt9jTbMduKOus6ZObP9N+X1PlKf/4s5b9nB
 DHRJnBnSbB0G8NtpJ4eP5TpLIyhJdxw==
X-Google-Smtp-Source: AGHT+IGzsAPkJ3uG7nvNHfYcOlxAWhjPffLKdEG91nhD+EMpLOQJTmMToj3nxL9krU8N+qlv98UFaQO1EDZV4Y1eMXY=
X-Received: by 2002:a17:907:3a0f:b0:aa6:2b21:ab5b with SMTP id
 a640c23a62f3a-aa63739e4e9mr1040803566b.12.1733699255382; Sun, 08 Dec 2024
 15:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <CAFLszThjGaKd3Z8fYaBqANDnyGOtGSF7t-o7B1B70R9q9jYfgA@mail.gmail.com>
 <CAFLszTitRwZbOMd-a0nQKzkBUg1OorNFrGzsdyZPtV9rdfEnyg@mail.gmail.com>
 <20241208155123.GG2457179@bill-the-cat>
In-Reply-To: <20241208155123.GG2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 8 Dec 2024 16:07:22 -0700
Message-ID: <CAFLszTh=fsR51k-Gew1XKgfFq-WjV1nX4Bvj_VJEqD-BRk7qMQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Improve UEFI app support
To: Tom Rini <trini@konsulko.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Boon Khai Ng <boon.khai.ng@intel.com>, Bryan Brattlof <bb@ti.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christophe ROULLIER <christophe.roullier@foss.st.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Gabor Juhos <j4g8y7@gmail.com>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Philip Oberfichtner <pro@denx.de>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, Romain Naour <romain.naour@smile.fr>, 
 Sam Edwards <CFSworks@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailman-Approved-At: Mon, 09 Dec 2024 02:00:16 +0100
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

Hi Tom,

On Sun, Dec 8, 2024, 08:51 Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 08, 2024 at 08:28:42AM -0700, Simon Glass wrote:
> > Hi,
> >
> > On Sun, 1 Dec 2024 at 09:15, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Matthew,
> > >
> > > On Sat, 23 Nov 2024 at 12:56, Matthew Garrett <mjg59@srcf.ucam.org>
wrote:
> > > >
> > > > We run a mixed environment including traditional embedded Linux and
> > > > UEFI. For consistency it's valuable to use U-Boot in both cases,
but on
> > > > UEFI systems we want to run the full Linux kernel UEFI boot stub.
This
> > > > patchset adds support for that, along with various other
quality-of-life
> > > > improvements such as automatically finding partitions based on their
> > > > GUID, automatic identification of load addresses where the firmware
has
> > > > given us constraints, support for EFI variable access in the EFI
app,
> > > > drivers for EFI network adapters and TPMs, support for embedding
DTBs in
> > > > the EFI app, and a couple of bug fixes.
> > > >
> > > >
> > > > Janis Danisevskis (1):
> > > >   Fix efi_bind_block.
> > > >
> > > > Matthew Garrett (9):
> > > >   Add EFI handover support to bootm
> > > >   Add part_find command
> > > >   Add a command to find a load address
> > > >   Hook up EFI env variable support in the EFI app
> > > >   Add EFI network driver
> > > >   Add UEFI TPM2 driver
> > > >   Support separate DTB files with the UEFI app
> > > >   Use the correct ramdisk address
> > > >   Add command to set an environment variable to an EFI variable
> > > >
> > > >  Makefile                        |   7 +-
> > > >  arch/x86/config.mk              |   2 +-
> > > >  arch/x86/lib/bootm.c            |  60 ++++++++----
> > > >  arch/x86/lib/elf_x86_64_efi.lds |   4 +
> > > >  boot/bootm.c                    |   5 +
> > > >  cmd/Kconfig                     |  23 ++++-
> > > >  cmd/Makefile                    |   3 +
> > > >  cmd/addr_find.c                 |  87 +++++++++++++++++
> > > >  cmd/efigetenv.c                 | 133 ++++++++++++++++++++++++++
> > > >  cmd/part_find.c                 | 156
++++++++++++++++++++++++++++++
> > > >  drivers/net/Kconfig             |   7 ++
> > > >  drivers/net/Makefile            |   1 +
> > > >  drivers/net/efi_net.c           | 110 +++++++++++++++++++++
> > > >  drivers/tpm/Kconfig             |   7 ++
> > > >  drivers/tpm/Makefile            |   1 +
> > > >  drivers/tpm/tpm2_efi.c          |  97 +++++++++++++++++++
> > > >  include/asm-generic/sections.h  |   1 +
> > > >  include/bootm.h                 |   6 ++
> > > >  include/efi.h                   |  24 +++++
> > > >  include/efi_tcg2.h              |   1 +
> > > >  lib/efi/Makefile                |   2 +-
> > > >  lib/efi/efi.c                   |   1 +
> > > >  lib/efi/efi_app.c               |  41 ++++++++
> > > >  lib/efi/efi_app_init.c          | 163
++++++++++++++++++++++++++++++--
> > > >  lib/efi/efi_dtb.S               |   6 ++
> > > >  lib/efi/efi_vars.c              |  44 +++++++++
> > > >  lib/fdtdec.c                    |   3 +
> > > >  27 files changed, 967 insertions(+), 28 deletions(-)
> > > >  create mode 100644 cmd/addr_find.c
> > > >  create mode 100644 cmd/efigetenv.c
> > > >  create mode 100644 cmd/part_find.c
> > > >  create mode 100644 drivers/net/efi_net.c
> > > >  create mode 100644 drivers/tpm/tpm2_efi.c
> > > >  create mode 100644 lib/efi/efi_dtb.S
> > > >  create mode 100644 lib/efi/efi_vars.c
> > > >
> > > > --
> > > > 2.47.0
> > > >
> > >
> > > Thank you for sending this and for your interesting talk at plumbers.
> > > It is a novel approach and potentially provides an alternative to grub
> > > and EFI_LOADER, etc.
> > >
> > > I'd like to try getting this running in CI as we don't have any such
> > > tests for the app or payload at present.
> >
> > I'm planning to pull this in as this seems like an important use case.
> > I'm not sure how much time Matthew will have for this, and I want to
> > avoid this series going stale.
> >
> > The comments which are not 'why do you want to do this?' are fairly
> > minor, so I'll send a follow-up to resolve them next week. We should
> > also think about what code we could move from lib/efi_loader to
> > lib/efi so we can share it with the app.
> >
> > Matthew, thanks again for sending this. if you are planning to do more
> > here in the short term, please let me know.
>
> Please don't grab other peoples patch series and pick them up for your,
> well, whatever you want to call "ci/master". You can do what you like
> with patches you wrote but taking submissions from others is just going
> to confuse the situation as to if you are, or are not, forking the
> project at this point.

This is a special situation as I had requested the series based on a talk
that I saw. I am interested in building on this work and obviously don't
want to do it on an out-of-tree basis.

I have to say I felt quite uncomfortable at the response we gave this new
contributor. If I had received such a response on my first series to U-Boot
I would never have come back.

I intend to keep the openness to new ideas in the future.

Re the patchwork thing, it was temporary while I was bringing in the
series. It should be fixed now.

Regards,
Simon
