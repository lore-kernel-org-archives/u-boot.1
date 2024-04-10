Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8459ECD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 14:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB3D286E40;
	Wed, 10 Apr 2024 16:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="uzkjYrPx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F54A87F52; Wed, 10 Apr 2024 16:53:50 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0C283348
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 16:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d89346eb45so42646521fa.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1712760827; x=1713365627;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svEU2SI6ox9dbBTKva5/0T+ECDUC697EVQHzd+pCuI0=;
 b=uzkjYrPxawhQbpFuSMEBRy0DHzuHHpHTsPn8Ll/kl2pDkHMCf1GuZ4MRilrPoHftQ2
 tlblyzMyGFm2xbA2ufF6D0pwSLhuhSLKkeW9xmIbRIwtJoywqSOhCiMFyaVGDOA4mRLc
 ovrtkGbm1v9xhLTtuec85r+SBYcYP7J+l8bKRW6sY8VewHfmvMk9C4YN2rx2jN2VApdg
 VyN7RrZ1JNcfo5moh7Qe1lsqXqz06pyNtXnnGtITaI1U+/ZV7t5zIdo9KVQNebUqrUhK
 oCZJHYkJcjhNB6ziZrHEOiD6rRqQXs9oyAyJ2B+pAxZoHOdXZqpVJ20kEjBDgzVBwDVu
 dyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712760827; x=1713365627;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=svEU2SI6ox9dbBTKva5/0T+ECDUC697EVQHzd+pCuI0=;
 b=UcFsK4sP5CO+Y4fqhjPqWqwhtd53/MCXNi48pNDkP1nEEnsdSBAEa90tBHHOUdwJQE
 0mMJD9GKJFUS1vAxLEpM+rs2fTfRJMJx4EgUxd3C4MOpYJy2uRenFR2t2IGinB6J7hfX
 HMRi3hosPXMxOEmxumJBH+NL5fHXsjq4csQmoFOBKneGKb05JWa4timEvRhGnRI3P77+
 3Ih49VRQ+TyneQxYgSnLPO93aqVO9XfuPnM5ol7YZUvZfJ7WJIgklq4SPR3+GDKkrS1a
 RKvVaSX1KdXBjfvAIqSrxfX9VuWz1PF87u0+RI5AyEyKsSglzfpojcZ/rlA0a4BRdVv9
 omNA==
X-Gm-Message-State: AOJu0Yy2BmtIItb4h8ji3T+cCzfFF1fp3ZN7mCXS/O/O8zsDbZibfxGt
 9nYQdGlNEufDu9nPWha60sdGIPrpRXGptmc/WiE2PAaFoDQGBnbwaLL1mx2IiminUQog21GYq4W
 e+Q==
X-Google-Smtp-Source: AGHT+IHUhxf5K685qX+MPZLQ5MNoRLQsMYrCy8b0La+z0/VLBa/h/Fr36j92slxY1uPb58MrsgDaaA==
X-Received: by 2002:a2e:a223:0:b0:2d6:8e88:5a8b with SMTP id
 i3-20020a2ea223000000b002d68e885a8bmr2641696ljm.32.1712760826818; 
 Wed, 10 Apr 2024 07:53:46 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 xi1-20020a170906dac100b00a51d3785c7bsm4135960ejb.196.2024.04.10.07.53.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 07:53:46 -0700 (PDT)
Message-ID: <5559177c-9db3-4470-be0b-90562422de72@monstr.eu>
Date: Wed, 10 Apr 2024 16:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] xilinx patches for v2024.07-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

please apply these patches to your tree. Gitlab CI is not showing any issue and 
buildman for our platforms is also not showing any issue.

If you have time please take a look at this
https://lore.kernel.org/r/CAHTX3d+qAMKgL9T5Fo6y=rvXDiMS_mCiCEGazHt07eiVN32Fgw@mail.gmail.com
because we have issue in initcall code in connection to reporting issue back.

Thanks,
Michal

The following changes since commit abd4fb5ac13215733569925a06991e0a182ede14:

   Merge patch series "Dockerfile: Build coreboot from source" (2024-02-27 
16:28:57 -0500)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2024.07-rc1

for you to fetch changes up to f03f962c602c428a1091c3e0fad25b4cf64c9497:

   xilinx: common: Fix MAC address read from EEPROM (2024-04-10 15:16:57 +0200)

----------------------------------------------------------------
Xilinx changes for v2024.07-rc1

xilinx:
- Do not call env_get_location when !ENV_IS_NOWHERE
- Add FDT_FIXUP_PARTITIONS support
- Fix legacy format MAC decoding

zynqmp:
- Enable semihosting SPL support
- DT updates
- Kconfig resort/cleanup
- Don't describe second image/capsule if !SPL
- Add support for dfu/capsule description via MTD
- Support JTAG as alternative boot mode
- Add support for TEG soc variant

zynqmp-kria:
- Wire usb4 boot device
- Update SDIO tristate pin configuration
- Disable SPI_FLASH_BAR to avoid issue with SPI after update

mbv:
- Enable SPL and binman
- Small platform changes

zynqmp-nand:
- Error out in case of unsupported SW ECC
- Clean error path

versal-net:
- Support multiple locations for variables

----------------------------------------------------------------
James Hilliard (1):
       xilinx: zynq: add FDT_FIXUP_PARTITIONS support

Lukas Funke (1):
       arm64: zynqmp: Add label to pmu fwnode

Manikanta Guntupalli (1):
       arm64: zynqmp: dts: Add required properties for rs485 support for KD240

Michal Simek (15):
       arm64: zynqmp: Remove snps,enable_guctl1_ipd_quirk property
       riscv: mbv: Align addresses with default DT
       riscv: mbv: Enable REMAKE_ELF by default
       riscv: mbv: Switch to OF_SEPARATE with fixed address
       riscv: mbv: Moving little_endian variable to data section
       riscv: mbv: Enable SPL and binman
       arm64: zynqmp: Fix gpio-key DT description
       arm64: zynqmp: Remove additional compatible string for sc-revB
       arm64: zynqmp: Describe USB wakeup interrupt
       arm64: zynqmp: Do not setup default SPL options without SPL
       arm64: zynqmp: Do not describe u-boot.itb if SPL is disabled
       arm64: zynqmp: Also support JTAG as alternative boot mode
       xilinx: Do not call private env_get_location() when !ENV_IS_NOWHERE
       arm64: zynqmp: Generate desc when SPL_FS_LOAD_PAYLOAD_NAME is valid
       arm64: zynqmp: Add MTD partition handling for dfu_alt_info generation

Petr Zejdl (1):
       xilinx: common: Fix MAC address read from EEPROM

Sean Anderson (1):
       arm64: zynqmp: Support semihosting boot method

Shubhangi Shrikrushna Mahalle (1):
       arm64: zynqmp: Add bootcmd_usb4 variable

Tejas Bhumkar (2):
       arm64: zynqmp: Disable Tri-state for SDIO
       configs: zynqmp_kria: Deactivate CONFIG_SPI_FLASH_BAR

Venkatesh Yadav Abbarapu (6):
       arm64: zynqmp: Add usb4 to the boot targets
       mtd: nand: arasan: Print warning for unsupported ecc modes
       mtd: nand: arasan: Fix the crash caused by use after free
       xilinx: versal-net: Add support for saving env based on bootmode
       arm64: dts: zynqmp: make hw-ecc as the default ecc mode
       soc: zynqmp: Add the IDcode for TEG variant

Vishal Sagar (1):
       arm64: zynqmp: Describe DisplayPort connector for Kria

  arch/arm/Kconfig                           |  8 +++
  arch/arm/dts/zynqmp-mini-nand.dts          |  6 ++
  arch/arm/dts/zynqmp-sc-revB.dts            |  4 +-
  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso     |  2 +
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso     | 20 +++++++
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso     |  1 +
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso     | 21 +++++++
  arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts |  2 +-
  arch/arm/dts/zynqmp-vpk120-revA.dts        |  2 +-
  arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts   |  6 +-
  arch/arm/dts/zynqmp-zcu208-revA.dts        |  2 +-
  arch/arm/dts/zynqmp-zcu216-revA.dts        |  2 +-
  arch/arm/dts/zynqmp-zcu670-revA.dts        |  2 +-
  arch/arm/dts/zynqmp-zcu670-revB.dts        |  2 +-
  arch/arm/dts/zynqmp.dtsi                   | 14 ++---
  arch/arm/mach-zynqmp/Kconfig               | 27 +--------
  arch/arm/mach-zynqmp/spl.c                 | 15 +++--
  arch/riscv/dts/xilinx-mbv32.dts            |  3 +
  board/xilinx/Kconfig                       |  1 +
  board/xilinx/common/board.c                | 31 ++++++++--
  board/xilinx/mbv/Kconfig                   | 14 ++++-
  board/xilinx/mbv/board.c                   | 10 ++++
  board/xilinx/versal-net/board.c            | 32 ++++++++++
  board/xilinx/versal/board.c                |  2 +
  board/xilinx/zynqmp/zynqmp.c               | 62 +++++++++++++++++---
  board/xilinx/zynqmp/zynqmp_kria.env        |  4 +-
  configs/xilinx_mbv32_defconfig             | 23 ++++++--
  configs/xilinx_mbv32_smode_defconfig       | 25 ++++++--
  configs/xilinx_versal_net_virt_defconfig   |  3 +
  configs/xilinx_zynqmp_kria_defconfig       |  1 -
  drivers/mtd/nand/raw/arasan_nfc.c          | 34 +++++++----
  drivers/serial/serial_xuartlite.c          |  2 +-
  drivers/soc/soc_xilinx_zynqmp.c            |  8 +++
  env/Kconfig                                |  2 +-
  34 files changed, 302 insertions(+), 91 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
