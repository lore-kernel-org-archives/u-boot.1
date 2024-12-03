Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9FFE6C611
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 07:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D1E895BD;
	Tue,  3 Dec 2024 08:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="avJ6VIwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E09ED895CE; Tue,  3 Dec 2024 08:42:41 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F95895AF
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 08:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa578d10d50so837925666b.1
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 23:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1733211759; x=1733816559;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8z3zuvykAfp23Y8YXq36Zrs+BfKbey40UdjymsO/2w=;
 b=avJ6VIweD3axTjlweowgQmSKN+SCO+rMFG1eMugH/KX/BIZ1lAOUKxc1pBBh2N3JJv
 KrCED8FCaSJEjyxITRm3wyb+XMuK6yCDPyNBzrtys1YsUFPtAe+B89speNjhWer4E+dg
 YP+fzynE80/vYi8U6FAiY8XU7IwPXYfa1kyWVw1Nw39ID4zddZm3RW0RNt+O5k/JOMWx
 yd48ilZTybh7vymryylj3MX6FIrhpkCUoC5RRofhz3TDqH956cx2aXh0dOygUizsUWv9
 mEc/9wp6Z3eVr0F175huBgXpW14XEwUiPMbO6OLDsBItLLqJBumwK6WiPT9NOfoFpatx
 n7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733211759; x=1733816559;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g8z3zuvykAfp23Y8YXq36Zrs+BfKbey40UdjymsO/2w=;
 b=H26ytIRTplpw0aL/JjS4wTPEqgyNMIwycVqpyrXj0idRu6ZGTyPnlkJKvEWaATkeMZ
 kQDYHMHXh12XJDjOzjCvdiLZGanIZphzoWqJC6mY0W44Y0kADjxZ6XI+vGKMEbnw3DDa
 crOcgS6bPcJ8C2R4gr3JIQ1YehFRtZarfgHczXSu2NEjCCsNAnt38yZ99fPGm96AkwMx
 Y2xQj2KH8+b5tt66G6F7/OSqUrth729gq83AXvPyJGRNka23rVLZPbX4+rLW4d11QmBh
 e/KeJ9mzS/DNZtGFRYKEd0VxaSXom8RgfHaYSvw5FkiMlFUzzgLevp/jTfKJJK76/vvw
 0EIw==
X-Gm-Message-State: AOJu0Yy+hUZpboiqYtriliwit2vlG0I3sCQZZW7N3xfqjaTKGVvieFF7
 OB+WxG417MjAbeQustHYh9LvSucSLdeYNSDiTm1ZOqlRemTbZfmpORPtRI9XkJxURznZkPHwGnP
 iNA==
X-Gm-Gg: ASbGnct0A3xsANqbEFZfHyF9rRS6zpvr4p0ilXYfeo440lVnreCSS11VC+fxPE/bBBq
 DqIbTI2NR1apNGFCXyERWJOLWfSHR1EqzY8nnt12YmfmPyyNabEPEBAk31w+P9OHQNBN7U3ti7j
 XYBKDV9cNGwR+n9IVaas2ysG0UUGUOueM/pC17em+/V9BpypX9ql3qdpfOKfMM2Js69DRUVTARh
 4ctTgYkW+TJZb7l4R07eKq5cbFliHQGLb5aAyxvxKT37HRCV69PcBEjuXjCMJ0VEQ==
X-Google-Smtp-Source: AGHT+IGLTS70V65r3OFWgZKmKyLPE9BgtkwRbjD0+ioLKFX/ICzy7ZJgFDOiTdGLCRdRaT/n3Dcflw==
X-Received: by 2002:a17:906:2921:b0:aa5:c3d3:3249 with SMTP id
 a640c23a62f3a-aa5f7f2cc03mr121595566b.54.1733211758727; 
 Mon, 02 Dec 2024 23:42:38 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5999032c1sm581779366b.133.2024.12.02.23.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 23:42:38 -0800 (PST)
Message-ID: <d28b39e9-2ba0-4581-830e-8b6f8ec9989d@monstr.eu>
Date: Tue, 3 Dec 2024 08:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] xilinx patches for v2025.04-rc1
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

please pull these patches to your next branch. The biggest change is to start to 
use binman instead of arch/arm/mach-zynqmp/mkimage_fit_atf.sh script.

Thanks,
Michal

The following changes since commit 62224280d9e89648ae90346c0aede76f9b7e7610:

   Merge tag 'u-boot-dfu-next-20241126' of 
https://source.denx.de/u-boot/custodians/u-boot-dfu into next (2024-11-26 
10:50:05 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.04-rc1

for you to fetch changes up to 46097afc70352ce5dc0caa8f95b74cba1e00af9b:

   arm64: zynqmp: Update the usb5744 hub node as per binding (2024-11-29 
13:22:16 +0100)

----------------------------------------------------------------
AMD/Xilinx changes for v2025.04-rc1

binman:
- Separate binman description from main DT

zynqmp:
- Enable binman for ZynqMP platforms
- DT sync with Linux v6.12
- Update usb5744 hub for SOMs

common:
- Drop SPL_FIT_GENERATOR support

versal2
- Enable OPTEE layers

ospi:
- Refactor the flash reset functionality

pytest:
- Fix tcminit mode handling

----------------------------------------------------------------
Love Kumar (1):
       test/py: zynqmp_rpu: Fix tcminit mode value

Marek Vasut (1):
       Makefile: Drop SPL_FIT_GENERATOR support

Michal Simek (8):
       binman: Add option for pointing to separate description
       common: binman: Calling initr_binman() when BINMAN_FDT
       arm64: zynqmp: Describe empty binman node
       arm64: zynqmp: Add binman description for SOM
       arm64: zynqmp: Generate u-boot.itb and QSPI image via binman
       arm64: zynqmp: Remove mkimage fit script
       arm64: zynqmp: Also generate images with single DT
       arm64: zynqmp: Sync with v6.12 kernel

Venkatesh Yadav Abbarapu (4):
       configs: zynqmp_kria: Enable the USB onboard hub
       configs: versal2: Enable OPTEE support
       cadence_qspi: Refactor the flash reset functionality
       arm64: zynqmp: Update the usb5744 hub node as per binding

  Makefile                                         |  29 +--
  arch/arm/Kconfig                                 |   1 +
  arch/arm/dts/Makefile                            |   3 +
  arch/arm/dts/zynqmp-binman-mini.dts              |  10 +
  arch/arm/dts/zynqmp-binman-som.dts               | 225 ++++++++++++++++++
  arch/arm/dts/zynqmp-binman.dts                   | 206 +++++++++++++++++
  arch/arm/dts/zynqmp-clk-ccf.dtsi                 |  16 ++
  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso           |  37 +--
  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso           |  67 ++++--
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso           |  68 ++++--
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso           |  24 +-
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso           |  33 ++-
  arch/arm/dts/zynqmp-sm-k26-revA.dts              |   2 +-
  arch/arm/dts/zynqmp-smk-k26-revA.dts             |   2 +-
  arch/arm/dts/zynqmp-u-boot.dtsi                  |  11 +
  arch/arm/dts/zynqmp-zcu102-revA.dts              |   1 +
  arch/arm/dts/zynqmp-zcu1275-revA.dts             |   3 +-
  arch/arm/dts/zynqmp.dtsi                         |  44 +++-
  arch/arm/mach-zynqmp/Kconfig                     |  14 ++
  arch/arm/mach-zynqmp/mkimage_fit_atf.sh          | 240 --------------------
  boot/Kconfig                                     |  15 --
  common/board_r.c                                 |   7 +-
  configs/amd_versal2_virt_defconfig               |   3 +
  configs/xilinx_zynqmp_kria_defconfig             |   4 +
  configs/xilinx_zynqmp_mini_defconfig             |   2 +
  configs/xilinx_zynqmp_mini_emmc0_defconfig       |   3 +
  configs/xilinx_zynqmp_mini_emmc1_defconfig       |   3 +
  configs/xilinx_zynqmp_mini_nand_defconfig        |   2 +
  configs/xilinx_zynqmp_mini_nand_single_defconfig |   2 +
  configs/xilinx_zynqmp_mini_qspi_defconfig        |   3 +
  configs/xilinx_zynqmp_virt_defconfig             |   3 +
  doc/usage/fit/howto.rst                          |   4 -
  drivers/spi/cadence_ospi_versal.c                |  45 +---
  drivers/spi/cadence_qspi.c                       |   6 +-
  lib/Kconfig                                      |   9 +
  test/py/tests/test_zynqmp_rpu.py                 |  84 ++++---
  36 files changed, 791 insertions(+), 440 deletions(-)
  create mode 100644 arch/arm/dts/zynqmp-binman-mini.dts
  create mode 100644 arch/arm/dts/zynqmp-binman-som.dts
  create mode 100644 arch/arm/dts/zynqmp-binman.dts
  create mode 100644 arch/arm/dts/zynqmp-u-boot.dtsi
  delete mode 100755 arch/arm/mach-zynqmp/mkimage_fit_atf.sh

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
