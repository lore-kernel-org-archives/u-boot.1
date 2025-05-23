Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C64C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CB1383599;
	Fri, 23 May 2025 18:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RIvP93x8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9239C8331C; Fri, 23 May 2025 18:37:12 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81911832C8
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 18:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so1827956666b.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748018230; x=1748623030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zuLWcRH9iLnTtsom92GHy7K14mUY1YJMc2eXhgDsjFI=;
 b=RIvP93x8CQWAA5glqcrrhyPGzf9r4ApbcpnglzdaYbiJhacd8VwIXJJ5cLmM56NhUp
 xBggfja1LsCE5cPogY97lyHM9uJ+oVpNFT18b26HXZPaEXljwLwxjqPWoEK1JXOulDs1
 +mpS4LTO8JdjGStWrZQbXM/XAxNXse+2wrKGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748018230; x=1748623030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zuLWcRH9iLnTtsom92GHy7K14mUY1YJMc2eXhgDsjFI=;
 b=Ty1kd4gDQcbpEaQBtGH/joK5R1CPBPsNK6paTSW9Cen56Cp8CL0OCcrpvDCcNFBou1
 nCHIvzZ2ugFhogAQe+AbXCsXHEQByWp0OPk65d1hPIcko8abmbsZPTKcfYhSadqFtSZy
 fBVL8JQ1rKbaSnpugCrD6TXBMBJ6iPhSZ6f/rKBg5A7oWl4V4SNxP709Xd+e0lucqUzP
 LEFU27OqrYWTqHXKnkDLL/3XMlVUYJ+2asAcpKtbTlB0m8bGp21sasKR9s2DBZN8GseS
 plRBMcrDc/DdTRLNq/KEUHd+d4o9QcEeSL12o2uIQHWiD1LBcGl3P9n0G1lwzijjSx1b
 InPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBIQAgRGcJwGAb2saJvDtt4hwbBuXHRC0/LYtODJYsaBeHYu21MW2csHuPHiVcehSS77WfQbA=@lists.denx.de
X-Gm-Message-State: AOJu0YwH1N6VYBuoPDNYff4kZu9qEGLScu9ddy7zcepXmeb5O3PNNGdv
 zSIc9X36s1bxQAXZh/hxB2O4/kXm6cWleS/puEb16e6f4+U6iVoiGg3Nc7sS8E2cnpODt7nl8Fz
 1/F9OK8GUn1WQKqElJjXYfcGklcPTOBrIXl3FGa7I
X-Gm-Gg: ASbGnctD/cvMEKwwIQVH2kJNI3Gdi/zz48DEkzJT2z6J/TArQrpXKMYMhCvEM4VIYqN
 HooUnz61Ojp8jwK3SFRq6191lFVwuH6nwZRjeD2JE5yn2crWX/z6foJLjhQioM4RVc5F8zZVxAk
 ZkeEuSGeTPo6pOwAcisK+TgdvOk+vXXNaNHg==
X-Google-Smtp-Source: AGHT+IGmBT92XcfTYNZ/QcEhgvmdtOPyy3EyspSRV5sBu34etnDvueFMfclTzQWdcg04ImO5rqhsPzOzn6Q2ihpO2I0=
X-Received: by 2002:a17:907:3f08:b0:ad5:697f:f1be with SMTP id
 a640c23a62f3a-ad5697ff2e1mr1843444166b.49.1748018229784; Fri, 23 May 2025
 09:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250523130651.1329593-1-sjg@chromium.org>
 <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
In-Reply-To: <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 17:36:52 +0100
X-Gm-Features: AX0GCFtOLyjg5OPgo8Lz4Z8DlVaF4nQxeYDoYu1AdLSPAfs_T2OZl5_BVCXaeOY
Message-ID: <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Adriano Cordova <adrianox@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?Q?Christian_Kohlschu=CC=88tter?= <christian@kohlschutter.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Janis Danisevskis <jdanisevskis@aurora.tech>, Janne Grunau <j@jannau.net>, 
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Moritz Fischer <moritzf@google.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 23 May 2025 18:56:12 +0200
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

Hi Heinrich,

On Fri, May 23, 2025, 15:19 Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 23.05.25 15:06, Simon Glass wrote:
> > Some functions provided in lib/efi_loader are actually useful for the
> > app as well. This series refactors the Kconfig and directories a little
> > so that code is easier to share.
> >
> > As a starting point, it moves some filename and device-path functions to
> > the new directory.
> >
> > The next step would be to move device-path code over, but this will need
> > some discussion.
>
> Hello Simon,
>
> Overall the ideas in this series look fine to me. But this series does
> not apply to origin/next.
>
> Applying: efi_loader: Separate device path into its own header
> Patch failed at 0001 efi_loader: Separate device path into its own header
> error: patch failed: cmd/efidebug.c:8
> error: cmd/efidebug.c: patch does not apply
> error: patch failed: include/efi_loader.h:967
> error: include/efi_loader.h: patch does not apply
> error: patch failed: lib/efi_loader/efi_bootmgr.c:12
> error: lib/efi_loader/efi_bootmgr.c: patch does not apply
> error: patch failed: lib/efi_loader/efi_device_path.c:10
> error: lib/efi_loader/efi_device_path.c: patch does not apply
> error: patch failed: lib/efi_loader/efi_helper.c:6
> error: lib/efi_loader/efi_helper.c: patch does not apply
>
> Please, resend the series based on origin/next.
>
> Patches that are not based on upstream U-Boot cannot be reviewed via
> this mailing list.

The app is quite behind in Tom's tree due to rejected series. In fact
the app is pretty limited on x86 and there is no Arm app at all.

My current plan is to move forward and eventually Tom might take it
via a pull request.

Do you have any other ideas?

Perhaps this is something we could put on the agenda for a future call.

Regards,
Simon


>
> Best regards
>
> Heinrich
>
> >
> >
> > Simon Glass (10):
> >    efi_loader: Separate device path into its own header
> >    efi: Include device-path functions in the EFI API docs
> >    efi: Rename END to EFI_DP_END
> >    efi: Rename the lib/efi directory
> >    efi: Rename CONFIG_EFI to CONFIG_EFI_CLIENT
> >    efi: Create a new CONFIG_EFI
> >    efi: Update maintainers for EFI_CLIENT
> >    efi: Move the base name and PXE info into lib/efi
> >    efi: Adjust copyright and mention constant source
> >    efi: Move FDT-filename discovery into lib/efi
> >
> >   MAINTAINERS                                |   5 +-
> >   Makefile                                   |   4 +-
> >   arch/arm/include/asm/global_data.h         |   2 +-
> >   arch/x86/Kconfig                           |   6 +-
> >   arch/x86/cpu/Makefile                      |   2 +-
> >   arch/x86/cpu/efi/Kconfig                   |   2 +-
> >   arch/x86/cpu/x86_64/Makefile               |   2 +-
> >   cmd/Makefile                               |   2 +-
> >   cmd/bootefi.c                              |   1 +
> >   cmd/eficonfig.c                            |   5 +-
> >   cmd/efidebug.c                             |   7 +-
> >   cmd/part_find.c                            |  10 +-
> >   configs/efi-arm_app64_defconfig            |   2 +-
> >   configs/efi-x86_app32_defconfig            |   2 +-
> >   configs/efi-x86_app64_defconfig            |   2 +-
> >   configs/efi-x86_payload32_defconfig        |   2 +-
> >   configs/efi-x86_payload64_defconfig        |   2 +-
> >   doc/api/efi.rst                            |   6 +
> >   doc/develop/uefi/u-boot_on_efi.rst         |  18 +-
> >   drivers/block/Kconfig                      |   2 +-
> >   include/efi_device_path.h                  | 420 +++++++++++++++++++++
> >   include/efi_loader.h                       |  57 +--
> >   include/init.h                             |   2 +-
> >   lib/Kconfig                                |   2 +-
> >   lib/Makefile                               |   1 +
> >   lib/efi/Kconfig                            |  86 +----
> >   lib/efi/Makefile                           |  28 +-
> >   lib/efi/basename.c                         | 153 ++++++++
> >   lib/efi_client/Kconfig                     |  83 ++++
> >   lib/efi_client/Makefile                    |  28 ++
> >   lib/{efi => efi_client}/efi.c              |   0
> >   lib/{efi => efi_client}/efi_app.c          |   0
> >   lib/{efi => efi_client}/efi_app_init.c     |   0
> >   lib/{efi => efi_client}/efi_dtb.S          |   0
> >   lib/{efi => efi_client}/efi_info.c         |   0
> >   lib/{efi => efi_client}/efi_stub_arm64.c   |   0
> >   lib/{efi => efi_client}/efi_stub_x86.c     |   0
> >   lib/{efi => efi_client}/efi_vars.c         |   0
> >   lib/{efi => efi_client}/sdram.c            |   0
> >   lib/efi_driver/efi_uclass.c                |   1 +
> >   lib/efi_loader/Kconfig                     |   3 +
> >   lib/efi_loader/efi_bootbin.c               |   1 +
> >   lib/efi_loader/efi_bootmgr.c               |   4 +-
> >   lib/efi_loader/efi_boottime.c              |   1 +
> >   lib/efi_loader/efi_capsule.c               |   1 +
> >   lib/efi_loader/efi_console.c               |   1 +
> >   lib/efi_loader/efi_device_path.c           | 175 +++------
> >   lib/efi_loader/efi_device_path_utilities.c |   3 +-
> >   lib/efi_loader/efi_disk.c                  |   1 +
> >   lib/efi_loader/efi_fdt.c                   |  64 +---
> >   lib/efi_loader/efi_helper.c                |  81 +---
> >   lib/efi_loader/efi_net.c                   |   1 +
> >   lib/efi_loader/efi_tcg2.c                  |   1 +
> >   lib/uuid.c                                 |   4 +-
> >   test/lib/efi_device_path.c                 |   1 +
> >   55 files changed, 814 insertions(+), 473 deletions(-)
> >   create mode 100644 include/efi_device_path.h
> >   create mode 100644 lib/efi/basename.c
> >   create mode 100644 lib/efi_client/Kconfig
> >   create mode 100644 lib/efi_client/Makefile
> >   rename lib/{efi => efi_client}/efi.c (100%)
> >   rename lib/{efi => efi_client}/efi_app.c (100%)
> >   rename lib/{efi => efi_client}/efi_app_init.c (100%)
> >   rename lib/{efi => efi_client}/efi_dtb.S (100%)
> >   rename lib/{efi => efi_client}/efi_info.c (100%)
> >   rename lib/{efi => efi_client}/efi_stub_arm64.c (100%)
> >   rename lib/{efi => efi_client}/efi_stub_x86.c (100%)
> >   rename lib/{efi => efi_client}/efi_vars.c (100%)
> >   rename lib/{efi => efi_client}/sdram.c (100%)
> >
>
