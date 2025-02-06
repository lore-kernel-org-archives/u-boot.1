Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAE4C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 10:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E2F580819;
	Thu,  6 Feb 2025 11:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="h11TlIZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE9A8082D; Thu,  6 Feb 2025 11:57:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900E5807E4
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 11:57:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738839359; x=1739444159; i=xypron.glpk@gmx.de;
 bh=mAJjUjr4gHMchGfMJIqZPO6gWe9BY/O58Wga8pW0wEs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=h11TlIZ2feHIJohQmD2jM5FM9G4L+qWrGiDjAJmXL5rKxsVhriNkT1ssA4ffJVzx
 Gt6Sm4Qkjuo8ZOobBLfvWlOlFS4LeO5zGrycaDg6J0Pc5RioCKpxEONcrNvFP623R
 lQxDJWkajiS8LPg1yMzXYRA19+WvshHJ4t8SwU8wVRjopys0ilVqTjRPFaObnfdo4
 Pore77CIluIzoniGZkVYR9f5JQZ4g/NJUOZIHjjh9388U9K1MU9kpAuu3qRZthv9E
 GMamEmp5C2numiJt+Dky/e5pX9nkbaIDuHrRR4/W82sUiCkVQ5pq9TmRiVsFry2Oy
 f8hIfQuO60GQD41nNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNJq-1ttpSW44hO-00NzD7; Thu, 06
 Feb 2025 11:55:59 +0100
Message-ID: <b3e20c80-f26e-42a5-b477-569b5182ede7@gmx.de>
Date: Thu, 6 Feb 2025 11:55:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/32] arm: Support building as an EFI app
To: Simon Glass <sjg@chromium.org>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bryan Brattlof <bb@ti.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@denx.de>,
 Janne Grunau <j@jannau.net>, Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Leo <ycliang@andestech.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Matthew Garrett <mgarrett@aurora.tech>, Matthias Brugger
 <mbrugger@suse.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Weinberger <richard@nod.at>, Rick Chen <rick@andestech.com>,
 Robert Marko <robert.marko@sartura.hr>, Sam Edwards <CFSworks@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250203174245.1331464-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:emUoXo+ePneYbdVJvxmfJdvWfon1BPQsjZrl0jEmjY7bdlxUagH
 ee1DHR3yWHZe2RQ6N1YkIOipL2xIuRCfqJaknuDkRPBcWcI6wM4UCVeqbey94kSD32s4a/G
 qejjIUV6MigoomiSfWoJe/qZO9ZumJpJew7CGGHACWtsUjRDICA4EK8ze3Pq1XDn1xvwW5Y
 zLReIt05cKSPOEB1Q1iHg==
UI-OutboundReport: notjunk:1;M01:P0:mlNubd8rhms=;bIhWvlrktJgR2YqL5fvJOHK0t6k
 CEyVJ4NArtviET/RW5eqrNl4TYy4r/nKE7GMNkaKD2Dsx14No1k/FCL/FZtnxeRrp+ptXzyS9
 7vpKXZFUfrpjvauXZnrbi/kVZ/A0elXV7nE6AoG1RDkrkn1kuFQuCvyKR+j2ruRBmejTy3hJB
 diVy8CbP9omCZTqlXdVU1EieRBa7TkZwQP9g3iuKmXc2PvxIkV659qLx2eEFcUcozkxrTo40Z
 LgPdCeaMOgfG2mclCxVb6uPBHTlhgFCjoX8NjFjji2OZEkuMIeAshLUml8koE3IGd7wfpOrlP
 28OSpK4kdxsNVclU1mZ7KhhxuXdGMLLho3CY4LYmoiAvCv8xKqABxn/40A10oXWdcIRztkzyv
 7S9QRpBXnlTuUVnLXF1GZOuOt5KWaJrazJs0tzW2jTqDzn/Jq24k5KWYsCTJbDAxcBpAusft3
 Dl2tmX61o5zhDh+kAfYEAj4Lh5nRcRLbxFBVXtMtcsIzPqtT45lQFlWGOFyTXCZtFSw1RXi3x
 QNP5+6VNOGWwWaQ3qG09sml0MME5LZOemj91pPbzueA2+X/6r2eeZ2iBUafSDDIouutP9vza/
 WbI9mVb7bc5NI6e5ynOJ49zfd9S+cZPZsuYddFPT+x5+/rAsy0wwcvnfQ1Huuok1mzRfslGng
 6ytmEHrrcZg1zc6BU5wt1AQHjmrT8l0MHtgx3NbVGvDA3tIjjSEtnMIdEWWXoMgqTdJ+vfepo
 s39c3IZyFbDjW0GkCXpPy6kEg0Oxnz3Zli5THeJdJvreMETBP6KB+zyPCPgOk0qvrnGM/i+Jo
 oenuMUptDWBbtSZrsx1w/+y+9epy4/0VE3VELq7gRGJPXV+iJQET/ri9HvTl9MKhmxvFPZp2m
 w099YJ+rzrKXzGo3fXVZetSHuLkD/yFHJX1bY0kWHi8X54ZM2EFvrNb/qFk6AO2QevjVHxH6i
 hNKLviKe2bBqWSybMAnNexqQ91HOvQxo/CmzVQf8iMoCmAcaXNQr4VIUn4AFgNyMqtYx62+Xj
 MJByvTcvkLjhWwN5WIHO7ZhbZZKiNUJEks6vzrdoO8wQbl3A4LjJ9cWmJZJK4/Kse+lv1KW0B
 PQRHXQz2rhNxN1S97pQlyEFFU9PKatnLVMZkiZj1wwW1Sy7p6aD6MT4JAK2oT2fXnt0Ry5Hw2
 wunZh8BhUlKOrivfbKqP4GlDzy5Aa8zG6Eug8Ath0vnKUNvVGEYfJoP3bBoRvENpgacwnmnwX
 p4XPjc5iBsqS/+GQzw9UNKHyKGdu/loUz/IXiexpfcyf4cqy0zYxq3xRdbDXuynF/Zaq2QuoX
 ttsvhOp7TinG9FG67tbjIuCeSTgR5MPIlGpLbIr39nBWjX/eyfsxrJOUmtIMrs/wq7tjQeRnF
 DlqryaCACBN287xnIv+CqBbRpt8jFYrQW/QNh2T03pwdjwmUDKcJTJUBXg
X-Mailman-Approved-At: Thu, 06 Feb 2025 11:58:48 +0100
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

On 2/3/25 18:41, Simon Glass wrote:
> The original x86 EFI-app was written back in 2015, about a year before
> the EFI-loader was introduced. At that point, ARM mostly used U-Boot and
> FIT (Flat Image Tree).
>
> Today, sadly, there are a few efforts to re-invent FIT poorly, to cater
> to more primitive boot-environments than U-Boot. One justification for
> this re-invetion has been that EDK2 did not support FIT.
>
> EDK2 does now support FIT but only for the firmware stage. Even then,
> vendors tend to use their own forks, so any new features are slow to
> make it into the market.
>
> EDK2 also supports the ext4 filesystem, but many devices don't include
> that feature, so most distros make use of FAT for storing their boot
> files. Since FAT is not journalled, it is not particularly reliable in
> the face of reset, power failure, etc.
>
> As an interim measure, we can use U-Boot as an EFI app running on top of
> whatever EDK2 fork is in use. This allows use of modern features such as
> FIT and filesystems other than FAT. So far this only supports x86, but
> recent ARM laptops are making use of EFI too.
>
> So this series adds an EFI app for 64-bit ARM.
>
> Note: Since U-Boot does not support EFI's GOP 'blt-only' mode, the
> vidconsole does not operate, but it can still be used, since EDK2
> handles drawing instead of U-Boot. As a result, the U-Boot logo is not
> shown.

Thank you Simon for going through this effort to generalize the EFI app.

The EFI app should build on all EFI architecture. Will you add RISC-V
support, too?

Best regards

Heinrich

>
>
> Simon Glass (32):
>    Convert build-efi script to Python
>    Makefile: Avoid using TEXT_BASE if not present
>    video: Move vesa_setup_video_priv() into its own file
>    video: Use a local mode_info struct in the EFI driver
>    lib: Provide fdtdec_get_pci_bar32() only with PCI enabled
>    scripts: Update build-efi to support building U-Boot
>    scripts: Update build-efi to support arm64
>    efi: Rename app and payload to include x86
>    efi: Allow board/efi Kconfig to be used outside x86
>    efi: x86: Move EFI SDRAM-handling into a common file
>    efi: x86: Rework VENDOR_EFI option to permit other archs
>    efi: x86: Allow setting the global_data pointer with EFI
>    efi: Tidy up setup of global_data
>    efi: Rename ImageBase to image_base
>    efi: lmb: Avoid access to _start
>    efi: arm: Don't do the EL2 switch when running under EFI
>    efi: arm: Avoid allocating page tables when running under EFI
>    efi: arm: Avoid enabling caches when running under EFI
>    efi: arm: Implement access to global_data for EFI
>    efi: arm: Omit the ARM start-up code in the EFI app
>    efi: arm: Drop exception code when running as an EFI app
>    efi: arm: Allow use of the EFI table in the app
>    efi: arm: Disable --gc-sections for the app
>    efi: arm: Drop startup code from the app
>    efi: arm: Adjust how the monitor length is calculated
>    efi: arm: Select the EFI linker script for the app
>    efi: arm: Provide startup and relocation code
>    efi: Generate the app as a shared library
>    efi: arm: Disable STATIC_RELA for the EFI app
>    efi: arm: Use EFI flags for all compilation with the app
>    efi: arm: Simplify the crt0 file and update link script
>    efi: arm: Add an EFI app for arm64
>
>   Kconfig                               |   1 +
>   MAINTAINERS                           |   6 +-
>   Makefile                              |   8 +-
>   arch/Kconfig                          |   2 +
>   arch/arm/Kconfig                      |   6 +-
>   arch/arm/Makefile                     |   2 +
>   arch/arm/config.mk                    |  12 ++
>   arch/arm/cpu/armv8/Makefile           |   4 +-
>   arch/arm/cpu/armv8/config.mk          |   7 +-
>   arch/arm/dts/efi-arm_app.dts          |  31 +++
>   arch/arm/include/asm/global_data.h    |  16 +-
>   arch/arm/lib/Makefile                 |  12 +-
>   arch/arm/lib/bootm.c                  |   7 +-
>   arch/arm/lib/cache.c                  |   3 +
>   arch/arm/lib/crt0_aarch64_efi.S       | 158 +++-----------
>   arch/arm/lib/elf_aarch64_efi.lds      |  49 +++--
>   arch/riscv/lib/crt0_riscv_efi.S       |  28 +--
>   arch/x86/Kconfig                      |   4 +-
>   arch/x86/cpu/efi/Makefile             |   1 -
>   arch/x86/include/asm/global_data.h    |   7 +
>   board/efi/Kconfig                     |  41 +++-
>   board/efi/efi-arm_app/Kconfig         |  16 ++
>   board/efi/efi-arm_app/MAINTAINERS     |  13 ++
>   board/efi/efi-arm_app/Makefile        |   5 +
>   board/efi/efi-arm_app/board.c         |  18 ++
>   board/efi/efi-arm_app/efi-arm_app.env |  11 +
>   board/efi/efi-x86_payload/Kconfig     |   2 +-
>   common/board_f.c                      |   4 +-
>   common/board_r.c                      |   9 +-
>   configs/efi-arm_app64_defconfig       |  51 +++++
>   configs/efi-x86_app32_defconfig       |   4 +-
>   configs/efi-x86_app64_defconfig       |   4 +-
>   configs/efi-x86_payload32_defconfig   |   4 +-
>   configs/efi-x86_payload64_defconfig   |   4 +-
>   doc/develop/uefi/u-boot_on_efi.rst    |  21 +-
>   drivers/pci/pci_rom.c                 |  32 ---
>   drivers/video/Makefile                |   2 +
>   drivers/video/efi.c                   |   1 +
>   drivers/video/vesa_helper.c           |  41 ++++
>   include/asm-generic/sections.h        |   2 +
>   include/vesa.h                        |   2 +
>   lib/efi/Kconfig                       |   2 +-
>   lib/efi/Makefile                      |   1 +
>   lib/efi/efi_app.c                     |  13 +-
>   {arch/x86/cpu =3D> lib}/efi/sdram.c     |   1 -
>   lib/fdtdec.c                          |   2 +
>   lib/lmb.c                             |   3 +-
>   scripts/build-efi.py                  | 293 ++++++++++++++++++++++++++
>   scripts/build-efi.sh                  | 207 ------------------
>   49 files changed, 719 insertions(+), 454 deletions(-)
>   create mode 100644 arch/arm/dts/efi-arm_app.dts
>   create mode 100644 board/efi/efi-arm_app/Kconfig
>   create mode 100644 board/efi/efi-arm_app/MAINTAINERS
>   create mode 100644 board/efi/efi-arm_app/Makefile
>   create mode 100644 board/efi/efi-arm_app/board.c
>   create mode 100644 board/efi/efi-arm_app/efi-arm_app.env
>   create mode 100644 configs/efi-arm_app64_defconfig
>   create mode 100644 drivers/video/vesa_helper.c
>   rename {arch/x86/cpu =3D> lib}/efi/sdram.c (94%)
>   create mode 100755 scripts/build-efi.py
>   delete mode 100755 scripts/build-efi.sh
>

