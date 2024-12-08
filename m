Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD21E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16D9989520;
	Sun,  8 Dec 2024 16:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CWgN0HVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F4E89575; Sun,  8 Dec 2024 16:28:56 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E86389473
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa650ccbe0eso199932066b.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733671734; x=1734276534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R8TKaEGi704x+pmTdvi4ezQ9Ps3fXLvPjSFlqoDrwuc=;
 b=CWgN0HVs2DvF8/OyL4AZztTY1iIWdnwprOcBOKu58726xeMslUNkCfSXGAr/0/0gDf
 DN6NqB/5DUq4o4ntCPLItCPN8Dad8JVVafEw+GiYnQVNqOiloCf2wryyLAXAW9YKtUA8
 Lo4El2CgbOyemFaHzsOfVIdfV8kiUKqJg55Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733671734; x=1734276534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R8TKaEGi704x+pmTdvi4ezQ9Ps3fXLvPjSFlqoDrwuc=;
 b=gTQaZrWbz5Ze7LyvRMdGG7GZahKxe9mCXQCD4CiV5arzHzwJWQ8VqlUrv2cXXToCkw
 mA6qVy4ct2e8kxFfkmT2e5XUiyXWiiG9w4fUOr4bs0upKIk/UFZJEQhKSrNZqbvA6sfa
 7sOhzv1pQ5OBJK+GY6uOHX+gwZd2fVK3Mjk4uuwIflVUTaY+ZJtZQumaQf8k9JNVM+eP
 GBsxfqtVgUZyR43MddUlaejT6esuIcW9+uR6jfaJX6jnfjqDMOPuhBdSPCZ0jv/zzeyH
 WiKC/i0aaDQcgUA4/4kZnRytoUnJMVMYSKZYDDHmdf2n4HJ1VD9J98C81iQN1O/o3JLh
 K+Yg==
X-Gm-Message-State: AOJu0Yz3BJDfjlIsyT83se7XZGOlZ/tZyxSUNE4za3bYboWet+OWfcpj
 IWLpsOlwj4dDdAkZnU2d2tPp6Ch52OvsmJ1V1iJUVqpiwcOkzxNGxEcMw/PT3q8iyuEdYdEl+5r
 KP2ci06KcUyFXaOP5PDM4I19+2E+z+KqOj7sS
X-Gm-Gg: ASbGncsIX8gadZMQEnu822aQa0fPqiqjzFS81QmE42tT+JYd6+z0xmRBPedRZIMVbWS
 sJ4+kcByhtnB/BymypWTVXcPjvZ8jL/EZ
X-Google-Smtp-Source: AGHT+IFDSBXTzqjcwiNmSRqS4hnbhK5lMkdanSKWvMaQl76d9uTDHhoAaqhljBHXVesp/USssR3/u62MazLuX27jXGI=
X-Received: by 2002:a17:907:774a:b0:aa6:7737:199c with SMTP id
 a640c23a62f3a-aa677373eccmr258468066b.15.1733671733984; Sun, 08 Dec 2024
 07:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <CAFLszThjGaKd3Z8fYaBqANDnyGOtGSF7t-o7B1B70R9q9jYfgA@mail.gmail.com>
In-Reply-To: <CAFLszThjGaKd3Z8fYaBqANDnyGOtGSF7t-o7B1B70R9q9jYfgA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 8 Dec 2024 08:28:42 -0700
Message-ID: <CAFLszTitRwZbOMd-a0nQKzkBUg1OorNFrGzsdyZPtV9rdfEnyg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Improve UEFI app support
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Boon Khai Ng <boon.khai.ng@intel.com>,
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
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
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 08 Dec 2024 16:58:09 +0100
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

Hi,

On Sun, 1 Dec 2024 at 09:15, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Matthew,
>
> On Sat, 23 Nov 2024 at 12:56, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >
> > We run a mixed environment including traditional embedded Linux and
> > UEFI. For consistency it's valuable to use U-Boot in both cases, but on
> > UEFI systems we want to run the full Linux kernel UEFI boot stub. This
> > patchset adds support for that, along with various other quality-of-life
> > improvements such as automatically finding partitions based on their
> > GUID, automatic identification of load addresses where the firmware has
> > given us constraints, support for EFI variable access in the EFI app,
> > drivers for EFI network adapters and TPMs, support for embedding DTBs in
> > the EFI app, and a couple of bug fixes.
> >
> >
> > Janis Danisevskis (1):
> >   Fix efi_bind_block.
> >
> > Matthew Garrett (9):
> >   Add EFI handover support to bootm
> >   Add part_find command
> >   Add a command to find a load address
> >   Hook up EFI env variable support in the EFI app
> >   Add EFI network driver
> >   Add UEFI TPM2 driver
> >   Support separate DTB files with the UEFI app
> >   Use the correct ramdisk address
> >   Add command to set an environment variable to an EFI variable
> >
> >  Makefile                        |   7 +-
> >  arch/x86/config.mk              |   2 +-
> >  arch/x86/lib/bootm.c            |  60 ++++++++----
> >  arch/x86/lib/elf_x86_64_efi.lds |   4 +
> >  boot/bootm.c                    |   5 +
> >  cmd/Kconfig                     |  23 ++++-
> >  cmd/Makefile                    |   3 +
> >  cmd/addr_find.c                 |  87 +++++++++++++++++
> >  cmd/efigetenv.c                 | 133 ++++++++++++++++++++++++++
> >  cmd/part_find.c                 | 156 ++++++++++++++++++++++++++++++
> >  drivers/net/Kconfig             |   7 ++
> >  drivers/net/Makefile            |   1 +
> >  drivers/net/efi_net.c           | 110 +++++++++++++++++++++
> >  drivers/tpm/Kconfig             |   7 ++
> >  drivers/tpm/Makefile            |   1 +
> >  drivers/tpm/tpm2_efi.c          |  97 +++++++++++++++++++
> >  include/asm-generic/sections.h  |   1 +
> >  include/bootm.h                 |   6 ++
> >  include/efi.h                   |  24 +++++
> >  include/efi_tcg2.h              |   1 +
> >  lib/efi/Makefile                |   2 +-
> >  lib/efi/efi.c                   |   1 +
> >  lib/efi/efi_app.c               |  41 ++++++++
> >  lib/efi/efi_app_init.c          | 163 ++++++++++++++++++++++++++++++--
> >  lib/efi/efi_dtb.S               |   6 ++
> >  lib/efi/efi_vars.c              |  44 +++++++++
> >  lib/fdtdec.c                    |   3 +
> >  27 files changed, 967 insertions(+), 28 deletions(-)
> >  create mode 100644 cmd/addr_find.c
> >  create mode 100644 cmd/efigetenv.c
> >  create mode 100644 cmd/part_find.c
> >  create mode 100644 drivers/net/efi_net.c
> >  create mode 100644 drivers/tpm/tpm2_efi.c
> >  create mode 100644 lib/efi/efi_dtb.S
> >  create mode 100644 lib/efi/efi_vars.c
> >
> > --
> > 2.47.0
> >
>
> Thank you for sending this and for your interesting talk at plumbers.
> It is a novel approach and potentially provides an alternative to grub
> and EFI_LOADER, etc.
>
> I'd like to try getting this running in CI as we don't have any such
> tests for the app or payload at present.

I'm planning to pull this in as this seems like an important use case.
I'm not sure how much time Matthew will have for this, and I want to
avoid this series going stale.

The comments which are not 'why do you want to do this?' are fairly
minor, so I'll send a follow-up to resolve them next week. We should
also think about what code we could move from lib/efi_loader to
lib/efi so we can share it with the app.

Matthew, thanks again for sending this. if you are planning to do more
here in the short term, please let me know.

Regards,
Simon
