Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76675D49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 17:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE2D28941D;
	Sun,  1 Dec 2024 18:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XtnLn0tl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C7978971E; Sun,  1 Dec 2024 17:15:43 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 140AE82BA7
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ea8b039ddcso2337834a91.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733069739; x=1733674539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ehoW0vk9PiQwiIF5o3X6lgM6aTfPf4D6GNHO95Pvv64=;
 b=XtnLn0tl9fy3Ixm579MmnUGO9HqrS4HI4dlGm+e279wjbzXAOGh3OVUgeXSx3eDXGF
 2AOJJMmfD321zmSREQNak0zEVxbYRP2BfI75Xox5Jj0HpsQ1Tj4XVNfp0SJdRxoVwN3V
 a+9sP29nSF8VGWqxesGghuTW8MY9EAX0dWnBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069739; x=1733674539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehoW0vk9PiQwiIF5o3X6lgM6aTfPf4D6GNHO95Pvv64=;
 b=WbhaJz13psGDNyyw6u6NHVWpX0gm1/iQ0dxEHE4rl0AeizTwFg6glGPRSlifXuMHo1
 IQDXGN3dy5AUW4mPBnCSMzWQaOE6+YBmj31LymYiZzT5TaFFqa55L9o6KyfAgw0V3L5P
 IP4Qj1InbHXKaPtKqpXHvjHgQ7Rmu3s9/mefT0nuYaslaYK8fqKJU3QF+yqBQpG9IfVK
 KMWun9QaN/bT6ThB7efDPuhbNAVm2Bb3tnHZED4vCpJsNLBo6nbD7TT7qMkG2sQ2Y4dn
 cBZbFD9UebQumYM1NJlH3Lr0rGkwM6+yCv1tdtINPQTE+B87Q5yl2H4zRN7IbDujm6r6
 +DSw==
X-Gm-Message-State: AOJu0YzDm6raPbNL1s7gFSlxj0ZE4bXoFGJUapK0ZI0fcxCKmSGMbSMV
 s6/D0eSS3ev3DQUk/xxwYxZ1/DJRcuvk5OFzVkN22dFo1/pwpOuou4AobB44ta4xT7qKXmJf8uc
 ZGD7MmhgZuqcQ60YQOx4ZWyA1sr8JUtakw3MZ
X-Gm-Gg: ASbGncvBdNLNCutEarz0NndURhsNPTZtE/ADuWkb01HMAWnrJ3qylwfGvyoYu3iSqmD
 av0Kz60h9bTFXT4Urp/FgP3jjVNaNPA==
X-Google-Smtp-Source: AGHT+IEyE0Nh0HDXlFO6gOv3jsFAls4/T3gq+dSSCQSipissdKr6K4zhXBHjC3lpY2B6mjWIlJhs4VojmyTbTavTf6A=
X-Received: by 2002:a17:90b:1fce:b0:2ee:acb4:fecd with SMTP id
 98e67ed59e1d1-2eeacb500admr3976294a91.9.1733069739523; Sun, 01 Dec 2024
 08:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
In-Reply-To: <20241123195616.305687-1-mjg59@srcf.ucam.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 09:15:12 -0700
Message-ID: <CAFLszThjGaKd3Z8fYaBqANDnyGOtGSF7t-o7B1B70R9q9jYfgA@mail.gmail.com>
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
X-Mailman-Approved-At: Sun, 01 Dec 2024 18:16:49 +0100
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

Hi Matthew,

On Sat, 23 Nov 2024 at 12:56, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> We run a mixed environment including traditional embedded Linux and
> UEFI. For consistency it's valuable to use U-Boot in both cases, but on
> UEFI systems we want to run the full Linux kernel UEFI boot stub. This
> patchset adds support for that, along with various other quality-of-life
> improvements such as automatically finding partitions based on their
> GUID, automatic identification of load addresses where the firmware has
> given us constraints, support for EFI variable access in the EFI app,
> drivers for EFI network adapters and TPMs, support for embedding DTBs in
> the EFI app, and a couple of bug fixes.
>
>
> Janis Danisevskis (1):
>   Fix efi_bind_block.
>
> Matthew Garrett (9):
>   Add EFI handover support to bootm
>   Add part_find command
>   Add a command to find a load address
>   Hook up EFI env variable support in the EFI app
>   Add EFI network driver
>   Add UEFI TPM2 driver
>   Support separate DTB files with the UEFI app
>   Use the correct ramdisk address
>   Add command to set an environment variable to an EFI variable
>
>  Makefile                        |   7 +-
>  arch/x86/config.mk              |   2 +-
>  arch/x86/lib/bootm.c            |  60 ++++++++----
>  arch/x86/lib/elf_x86_64_efi.lds |   4 +
>  boot/bootm.c                    |   5 +
>  cmd/Kconfig                     |  23 ++++-
>  cmd/Makefile                    |   3 +
>  cmd/addr_find.c                 |  87 +++++++++++++++++
>  cmd/efigetenv.c                 | 133 ++++++++++++++++++++++++++
>  cmd/part_find.c                 | 156 ++++++++++++++++++++++++++++++
>  drivers/net/Kconfig             |   7 ++
>  drivers/net/Makefile            |   1 +
>  drivers/net/efi_net.c           | 110 +++++++++++++++++++++
>  drivers/tpm/Kconfig             |   7 ++
>  drivers/tpm/Makefile            |   1 +
>  drivers/tpm/tpm2_efi.c          |  97 +++++++++++++++++++
>  include/asm-generic/sections.h  |   1 +
>  include/bootm.h                 |   6 ++
>  include/efi.h                   |  24 +++++
>  include/efi_tcg2.h              |   1 +
>  lib/efi/Makefile                |   2 +-
>  lib/efi/efi.c                   |   1 +
>  lib/efi/efi_app.c               |  41 ++++++++
>  lib/efi/efi_app_init.c          | 163 ++++++++++++++++++++++++++++++--
>  lib/efi/efi_dtb.S               |   6 ++
>  lib/efi/efi_vars.c              |  44 +++++++++
>  lib/fdtdec.c                    |   3 +
>  27 files changed, 967 insertions(+), 28 deletions(-)
>  create mode 100644 cmd/addr_find.c
>  create mode 100644 cmd/efigetenv.c
>  create mode 100644 cmd/part_find.c
>  create mode 100644 drivers/net/efi_net.c
>  create mode 100644 drivers/tpm/tpm2_efi.c
>  create mode 100644 lib/efi/efi_dtb.S
>  create mode 100644 lib/efi/efi_vars.c
>
> --
> 2.47.0
>

Thank you for sending this and for your interesting talk at plumbers.
It is a novel approach and potentially provides an alternative to grub
and EFI_LOADER, etc.

I'd like to try getting this running in CI as we don't have any such
tests for the app or payload at present.

Regards,
Simon
