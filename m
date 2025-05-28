Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B55C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 07:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E08A283192;
	Wed, 28 May 2025 09:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Iy/TYalY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAC24831C5; Wed, 28 May 2025 09:40:55 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B62183164
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-604533a2f62so6613996a12.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748418052; x=1749022852; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R8OHSRUu6c/sIbRb0Cl1Sma1pqVVPtm8yI1tCl6eZM8=;
 b=Iy/TYalYJkWVtWs0o4JFdaDyPonA7/Hwvbn3bYLe6ak7DOTkhKYDNjfVov58BLTSbs
 Phi8BNL5vt5+iuW/Kv3lEwaDLhpTXfT4jRe3i6HEM5WMOdM7F5kGnyiWI3iKMIUfbk6I
 EhYkh/gGrh0Ru3tz7SsC5p5zb0tiewtR1i60E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748418052; x=1749022852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R8OHSRUu6c/sIbRb0Cl1Sma1pqVVPtm8yI1tCl6eZM8=;
 b=vs+AO9Gz/h7qqAByYCgKVIDiNwHe+RgVnGbc2xspehjdER7KtJcCVtF10BCSdygBfx
 VKB/tIfSxdZ5wYoDSxeC1N622xKELBdaXGSZd9iS0w/KkV7DS0b8e/9INicqoPDJvlOm
 l0UnSnEkBmkTmOX4rpW36V0vrltlwFih52GjaxNH/lNEcHOFXGKW0RBScyU3feEqC36P
 xQN60gwnQv2ydn+edFPFghIZThz8Y2xQbOhglPHnWzE2jva5LMaV63dTFgO4xtW6aWk9
 WI7BSwA33ZmCww5nHyUHfYIwS1spcK6cBESgzgn0cIV3dP+3hJiiuHacMAltBX8djwGZ
 iN0g==
X-Gm-Message-State: AOJu0YzK5GzVODPYP6y3k3dHGTjxKINc23JucORxezFURxcTAB7O5f8L
 3nQm71ER9JupTuDx6NW3XvUSINkxQLJEo+GA8y7FNEkpDcHCppMJB9uIAillKUXMWBKhFe5XHXW
 659MmccQcYP7WEwwGCZTXYtaoKia0Ti1G47jGTdzjz4rvMg+0UPAmwQ==
X-Gm-Gg: ASbGncvOl76mlTAAzgwGDXmELd1P9bpOZMyfOQgok6aZQmbGF3r/QMH3sfH40Su/vHL
 DYQDDMkSRHLKNwd0n3MTt/5Wucn8moM3PRp63RBEl/cCUqZI6N/0R1lkclzG9pjzDkwzhrgdk26
 LGB6YyfvIm/o7VAVdg+h8Ep1/eNoCr37k=
X-Google-Smtp-Source: AGHT+IEYD6n2lBz4Cgf87nLxnwjVcHpLK63VKI1TNCWR6Vbwte5Xy1/3xzqHJctwI9e4xyGh/fY1kHBLPUnpatxZosQ=
X-Received: by 2002:a05:6402:5245:b0:604:bbd2:7c6c with SMTP id
 4fb4d7f45d1cf-604bbd27e36mr9220623a12.27.1748418051868; Wed, 28 May 2025
 00:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250523130651.1329593-1-sjg@chromium.org>
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 08:40:40 +0100
X-Gm-Features: AX0GCFs56jtLPxqW0Vz--jS5GUJGrUg1J6wV4uIselZaYvJeeaSVyNklRY2VXCs
Message-ID: <CAFLszTi1xiq5FO4aPn9U0DkQpJrFQ=zdVMtmj7adizh4FkpAZg@mail.gmail.com>
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
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
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 28 May 2025 09:42:47 +0200
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

On Fri, 23 May 2025 at 14:07, Simon Glass <sjg@chromium.org> wrote:
>
> Some functions provided in lib/efi_loader are actually useful for the
> app as well. This series refactors the Kconfig and directories a little
> so that code is easier to share.
>
> As a starting point, it moves some filename and device-path functions to
> the new directory.
>
> The next step would be to move device-path code over, but this will need
> some discussion.
>
>
> Simon Glass (10):
>   efi_loader: Separate device path into its own header
>   efi: Include device-path functions in the EFI API docs
>   efi: Rename END to EFI_DP_END
>   efi: Rename the lib/efi directory
>   efi: Rename CONFIG_EFI to CONFIG_EFI_CLIENT
>   efi: Create a new CONFIG_EFI
>   efi: Update maintainers for EFI_CLIENT
>   efi: Move the base name and PXE info into lib/efi
>   efi: Adjust copyright and mention constant source
>   efi: Move FDT-filename discovery into lib/efi
>
>  MAINTAINERS                                |   5 +-
>  Makefile                                   |   4 +-
>  arch/arm/include/asm/global_data.h         |   2 +-
>  arch/x86/Kconfig                           |   6 +-
>  arch/x86/cpu/Makefile                      |   2 +-
>  arch/x86/cpu/efi/Kconfig                   |   2 +-
>  arch/x86/cpu/x86_64/Makefile               |   2 +-
>  cmd/Makefile                               |   2 +-
>  cmd/bootefi.c                              |   1 +
>  cmd/eficonfig.c                            |   5 +-
>  cmd/efidebug.c                             |   7 +-
>  cmd/part_find.c                            |  10 +-
>  configs/efi-arm_app64_defconfig            |   2 +-
>  configs/efi-x86_app32_defconfig            |   2 +-
>  configs/efi-x86_app64_defconfig            |   2 +-
>  configs/efi-x86_payload32_defconfig        |   2 +-
>  configs/efi-x86_payload64_defconfig        |   2 +-
>  doc/api/efi.rst                            |   6 +
>  doc/develop/uefi/u-boot_on_efi.rst         |  18 +-
>  drivers/block/Kconfig                      |   2 +-
>  include/efi_device_path.h                  | 420 +++++++++++++++++++++
>  include/efi_loader.h                       |  57 +--
>  include/init.h                             |   2 +-
>  lib/Kconfig                                |   2 +-
>  lib/Makefile                               |   1 +
>  lib/efi/Kconfig                            |  86 +----
>  lib/efi/Makefile                           |  28 +-
>  lib/efi/basename.c                         | 153 ++++++++
>  lib/efi_client/Kconfig                     |  83 ++++
>  lib/efi_client/Makefile                    |  28 ++
>  lib/{efi => efi_client}/efi.c              |   0
>  lib/{efi => efi_client}/efi_app.c          |   0
>  lib/{efi => efi_client}/efi_app_init.c     |   0
>  lib/{efi => efi_client}/efi_dtb.S          |   0
>  lib/{efi => efi_client}/efi_info.c         |   0
>  lib/{efi => efi_client}/efi_stub_arm64.c   |   0
>  lib/{efi => efi_client}/efi_stub_x86.c     |   0
>  lib/{efi => efi_client}/efi_vars.c         |   0
>  lib/{efi => efi_client}/sdram.c            |   0
>  lib/efi_driver/efi_uclass.c                |   1 +
>  lib/efi_loader/Kconfig                     |   3 +
>  lib/efi_loader/efi_bootbin.c               |   1 +
>  lib/efi_loader/efi_bootmgr.c               |   4 +-
>  lib/efi_loader/efi_boottime.c              |   1 +
>  lib/efi_loader/efi_capsule.c               |   1 +
>  lib/efi_loader/efi_console.c               |   1 +
>  lib/efi_loader/efi_device_path.c           | 175 +++------
>  lib/efi_loader/efi_device_path_utilities.c |   3 +-
>  lib/efi_loader/efi_disk.c                  |   1 +
>  lib/efi_loader/efi_fdt.c                   |  64 +---
>  lib/efi_loader/efi_helper.c                |  81 +---
>  lib/efi_loader/efi_net.c                   |   1 +
>  lib/efi_loader/efi_tcg2.c                  |   1 +
>  lib/uuid.c                                 |   4 +-
>  test/lib/efi_device_path.c                 |   1 +
>  55 files changed, 814 insertions(+), 473 deletions(-)
>  create mode 100644 include/efi_device_path.h
>  create mode 100644 lib/efi/basename.c
>  create mode 100644 lib/efi_client/Kconfig
>  create mode 100644 lib/efi_client/Makefile
>  rename lib/{efi => efi_client}/efi.c (100%)
>  rename lib/{efi => efi_client}/efi_app.c (100%)
>  rename lib/{efi => efi_client}/efi_app_init.c (100%)
>  rename lib/{efi => efi_client}/efi_dtb.S (100%)
>  rename lib/{efi => efi_client}/efi_info.c (100%)
>  rename lib/{efi => efi_client}/efi_stub_arm64.c (100%)
>  rename lib/{efi => efi_client}/efi_stub_x86.c (100%)
>  rename lib/{efi => efi_client}/efi_vars.c (100%)
>  rename lib/{efi => efi_client}/sdram.c (100%)
>
> --
> 2.43.0
>
> base-commit: 3599a58a5114224a01557d18371036a5823233cc
> branch: app

Tom has asked that I not send emails on each patch when they are
applied to my tree. So in this case I am replying manually on the
cover letter.

For this series:
1. Pulled in the updated commits from Heinrich from -next:

f4bbd7b9faa efi_loader: Separate device path into its own header
f139fbe64b0 efi: Include device-path functions in the EFI API docs
162a6b3df34 efi: Rename END to EFI_DP_END

2. Pulled in the rest of these patches, since they depend on patches
not present / rejected / changes-requested for -next:
5f4327ec9f3 efi: Rename the lib/efi directory
ca1f2dbd8e7 efi: Rename CONFIG_EFI to CONFIG_EFI_CLIENT
a07abd67dac efi: Create a new CONFIG_EFI
c787cb9d278 efi: Update maintainers for EFI_CLIENT
624cdc9228d efi: Move the base name and PXE info into lib/efi
0121164befb efi: Adjust copyright and mention constant source
ed4bb8d9826 efi: Move FDT-filename discovery into lib/efi

Applied to sjg/master, thanks!

Regards,
Simon
