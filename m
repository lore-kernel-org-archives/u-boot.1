Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEC9C3600B
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 02:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D141781E3E;
	Fri, 28 Mar 2025 03:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ppvPF/2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C69806FC; Thu, 27 Mar 2025 18:17:44 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D6ED805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 18:17:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so966340f8f.2
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743095862; x=1743700662; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iUKhKIgv71fYY8T5j7ndIEHglXkBkJnEnJdQnWRr0nE=;
 b=ppvPF/2A91ZAWgUHkgIy/BH8Kbv6JHazRUX+axRPSTpM8I6kRmYQC0ZYoCrosNsVUB
 fVp0u9T7UZZtjL5JluT+T2OEcDjuFiXOcmHa1vpJ+RizP+3nfdsk636RZfUGItobpgPa
 4YLA/nG/Lz8zM/sV0RVa4g3HV+wXn07pspLXGmAwUZNd9QK22UxiCgDmtI2h+L6mmitw
 BsJdr20fO+e1oQeWiv4bNvx922LGuaLNpGFHqj6Q4FkEZqiGeg+Fp79A+JG1+/r+GKCK
 74XM6TCiL929Wr5QPSf66u8+ooQS0sPvVvtqYTzXoRRFHourm2u9izQkur7w5LyxcTJB
 ywUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743095862; x=1743700662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iUKhKIgv71fYY8T5j7ndIEHglXkBkJnEnJdQnWRr0nE=;
 b=uC3153LX0XzAmVPJw647jJRzAmRsX8jrh/TDqLOcctgiBBudRPkXrkFl3FG94VxOzX
 LiLssKFYUaL2dudC2lqhdnYT0/AmRHbtSJF1zFt/y0dG3E5rPxfUjrp8A0b8M3m/5pOh
 GXTEztvsQC5ZOzZzizPCBXc2ozaYC87kxjMdHh9j23IE2qaVSMGGSgJCmDpBcoLU+ofa
 pRIaiEj4TjoWDp3XCNf3udjkgRIZjLKd+F8I2uWYPqr7XjkP5VFW57EyAFqKHK+56I9l
 ZJKujvdCRJdEm2xrDjtdANzQWimlWwLse8w+QdBowu5pgUf3qdwJYwmagXWJ2Mfp9EWj
 BUOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdUSExNps1ZSYEOp0Yo2AdjPYhJNpAPxivFbbRPEnWRZBOx8VfkhrfKPlG4LQxJsbk45IRFPQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyyuVNmPFwOaT2N82IH5upUwboZZJOJXp9tMN6Sg/6NcUPXoIUP
 kZExjUniYgu6GU8mTLK79gmrBdnxLPirm5U4Y4LA5qwqi5I9TuiPclvRa15ZSRs=
X-Gm-Gg: ASbGnct2LyWXHAe2Q0EGPRhskMgxesGgEnJVqdox1KSPrOvgsZyGKKTzPtiH9gc9i4g
 hKWMhrSC0Itx5b988ffaDpKhg4sgF211FQaB+3YTi+nhvrs1u4MEb0xJbPZ9f2r0cXXvDFwJRoH
 0yirdXG5n/k/W1g7GfmKMUWgdb5q929YPIHxrswxmyEInsTeK4Y4dONDw2a1d2ozLFFCv1mGoxh
 9oofEDWD5bVG5pTctVqsonuZE/7tW4vH1tYZ4xm/r95ks9ZJLURtxRPiJcJrqXd3HGfeavJz8Jy
 RQQOUfur2uML8lYF+nNxZqbNWkpljEdnvytjBvPWQAd9j1R+qo/mcl6wIhtJZUzGrVDIel/uM1U
 =
X-Google-Smtp-Source: AGHT+IFP88IMfCt7JvVD5uy7nSz97rusSSL4U7Cn0W0nkCCHNgrQbX3btYAkHzv/yXvzAZEh/lDV3w==
X-Received: by 2002:a05:6000:2cd:b0:391:3f4f:a172 with SMTP id
 ffacd0b85a97d-39ad17893b4mr4335398f8f.49.1743095861595; 
 Thu, 27 Mar 2025 10:17:41 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe389sm44008135e9.19.2025.03.27.10.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 10:17:40 -0700 (PDT)
Message-ID: <0476a23e-3de6-4619-b2f1-d2be7765e23d@linaro.org>
Date: Thu, 27 Mar 2025 18:17:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/29] arm: Support building as an EFI app
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, =?UTF-8?Q?Jonas_Schw=C3=B6bel?=
 <jonasschwoebel@yahoo.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Matthew Garrett <mgarrett@aurora.tech>, Matthias Brugger
 <mbrugger@suse.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Weinberger <richard@nod.at>, Rick Chen <rick@andestech.com>,
 Sam Edwards <CFSworks@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20250215032254.4121030-1-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 28 Mar 2025 03:20:27 +0100
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



On 2/15/25 04:22, Simon Glass wrote:
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

It also does a lot of small tangential cleanup (and is kinda big). Could 
you send patches 2, 3, 11 and 12 separately? These are all sensible in 
their own right (and would help with EFI stub as well).

A looot of the later patches look like they can be squashed too, as-is I 
don't think this series is bisect-safe (which in fairness would probably 
only affect someone who is actually building the EFI app, but even so).

I'm looking forward to getting all this EFI loader stuff in better shape 
for when I finally get back around to working on the EFI stub support 
for ARM, so happy to see this cleanup.

Kind regards,
> 
> Note: Since U-Boot does not support EFI's GOP 'blt-only' mode, the
> vidconsole does not operate, but it can still be used, since EDK2
> handles drawing instead of U-Boot. As a result, the U-Boot logo is not
> shown.
> 
> Changes in v4:
> - Got back to depending on HAVE_TEXT_BASE
> - Drop the confusing comment about position-independent code
> - Put EFI_LDS back as it is required for building helloword.efi etc.
> - Put the config.mk changes in the board directory
> 
> Changes in v3:
> - Use the same copyright message as the original pci_rom.c file
> - Rewrite the commit message
> - Drop setting of EFI_LDS and rely on the CONFIG_SYS_LDSCRIPT value
> 
> Changes in v2:
> - Depend on CONFIG_EFI_APP instead
> - Drop change to u-boot-elf rule
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Drop the word 'Sadly'
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Add new patch to rename VENDOR_EFI to ARCH_EFI
> - Update to use ARCH_EFI instead of VENDOR_EFI
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Rework the commit message to clarify the relationship to link-scripts
> - Expand commit message to explains that EFI_APP skips relocation
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Document the x86 field better and add a comment for ARM too
> - Mention '64-bit ARM' here, rather than just 'ARM'
> - Put the EFI-app case first in setup_mon_len(), for clarity
> - Use ARCH_EFI instead of VENDOR_EFI
> - Merge the linker-script rules into Kconfig in this patch
> - Drop patch 'Select the EFI linker script for the app'
> 
> Simon Glass (29):
>    Makefile: Avoid using TEXT_BASE with the EFI APP
>    video: Move vesa_setup_video_priv() into its own file
>    video: Use a local mode_info struct in the EFI driver
>    lib: Provide fdtdec_get_pci_bar32() only with PCI enabled
>    efi: Rename app and payload to include x86
>    efi: Allow board/efi Kconfig to be used outside x86
>    efi: x86: Move EFI SDRAM-handling into a common file
>    treewide: Rename VENDOR_EFI to ARCH_EFI
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
>    efi: arm: Drop exception-level code when running as EFI app
>    efi: arm: x86: Allow use of the EFI table in the app
>    efi: arm: Disable --gc-sections for the app
>    efi: arm: Drop startup code from the app
>    efi: arm: Adjust how the monitor length is calculated
>    efi: arm: Provide startup and relocation code
>    efi: Generate the app as a shared library
>    efi: arm: Disable STATIC_RELA for the EFI app
>    efi: arm: Use EFI flags for all compilation with the app
>    efi: arm: Simplify the crt0 file and update link script
>    efi: arm: Add an EFI app for arm64
> 
>   Kconfig                               |   1 +
>   MAINTAINERS                           |   4 +-
>   Makefile                              |   7 +-
>   arch/Kconfig                          |   2 +
>   arch/arm/Kconfig                      |   6 +-
>   arch/arm/Makefile                     |   2 +
>   arch/arm/config.mk                    |  12 ++
>   arch/arm/cpu/armv8/Makefile           |   4 +-
>   arch/arm/cpu/armv8/config.mk          |   2 +-
>   arch/arm/dts/efi-arm_app.dts          |  31 +++++
>   arch/arm/include/asm/global_data.h    |  18 ++-
>   arch/arm/lib/Makefile                 |  12 +-
>   arch/arm/lib/bootm.c                  |   7 +-
>   arch/arm/lib/cache.c                  |   3 +
>   arch/arm/lib/crt0_aarch64_efi.S       | 158 ++++----------------------
>   arch/arm/lib/crt0_arm_efi.S           |   2 +-
>   arch/arm/lib/elf_aarch64_efi.lds      |  49 +++++---
>   arch/riscv/lib/crt0_riscv_efi.S       |  30 ++---
>   arch/x86/Kconfig                      |   4 +-
>   arch/x86/cpu/efi/Makefile             |   1 -
>   arch/x86/include/asm/global_data.h    |   9 +-
>   board/efi/Kconfig                     |  44 ++++++-
>   board/efi/efi-arm_app/Kconfig         |  19 ++++
>   board/efi/efi-arm_app/MAINTAINERS     |  13 +++
>   board/efi/efi-arm_app/Makefile        |   5 +
>   board/efi/efi-arm_app/board.c         |  18 +++
>   board/efi/efi-arm_app/config.mk       |   4 +
>   board/efi/efi-arm_app/efi-arm_app.env |  11 ++
>   board/efi/efi-x86_payload/Kconfig     |   2 +-
>   common/board_f.c                      |   6 +-
>   common/board_r.c                      |   9 +-
>   configs/efi-arm_app64_defconfig       |  51 +++++++++
>   configs/efi-x86_app32_defconfig       |   4 +-
>   configs/efi-x86_app64_defconfig       |   4 +-
>   configs/efi-x86_payload32_defconfig   |   4 +-
>   configs/efi-x86_payload64_defconfig   |   4 +-
>   doc/develop/uefi/u-boot_on_efi.rst    |  17 +--
>   drivers/pci/pci_rom.c                 |  32 ------
>   drivers/video/Makefile                |   2 +
>   drivers/video/efi.c                   |   1 +
>   drivers/video/vesa_helper.c           |  41 +++++++
>   include/asm-generic/sections.h        |   2 +
>   include/vesa.h                        |   2 +
>   lib/efi/Kconfig                       |   2 +-
>   lib/efi/Makefile                      |   1 +
>   lib/efi/efi_app.c                     |  13 ++-
>   {arch/x86/cpu => lib}/efi/sdram.c     |   1 -
>   lib/fdtdec.c                          |   2 +
>   lib/lmb.c                             |   3 +-
>   49 files changed, 431 insertions(+), 250 deletions(-)
>   create mode 100644 arch/arm/dts/efi-arm_app.dts
>   create mode 100644 board/efi/efi-arm_app/Kconfig
>   create mode 100644 board/efi/efi-arm_app/MAINTAINERS
>   create mode 100644 board/efi/efi-arm_app/Makefile
>   create mode 100644 board/efi/efi-arm_app/board.c
>   create mode 100644 board/efi/efi-arm_app/config.mk
>   create mode 100644 board/efi/efi-arm_app/efi-arm_app.env
>   create mode 100644 configs/efi-arm_app64_defconfig
>   create mode 100644 drivers/video/vesa_helper.c
>   rename {arch/x86/cpu => lib}/efi/sdram.c (94%)
> 

-- 
Caleb (they/them)

