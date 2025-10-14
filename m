Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDB9CCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 15:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 498CE807B1;
	Tue, 14 Oct 2025 17:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="dHNv4VxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7FC8312A; Tue, 14 Oct 2025 17:14:38 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 866A080107
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 17:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b4f323cf89bso973816066b.2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1760454876; x=1761059676;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQ2/l+GDmpBi0NY9SU8IDx2zM7PZVPBo+05aUkfaAj4=;
 b=dHNv4VxErSiTdBPFJICGHF3PG0j67Jq3i974RNCfahPHmkrq+JtFiHMz2H6W847yi6
 gvDrXxfGLqTqmaaB2rsE4DoyNsarM7weBTzwaT7In1/DLnEYq04kYze7kjhXRkyRfRNn
 ZgCMckQMpxTpl6FaZGt0sYrAKIBb3lNl+/pLKwo1WRaD/y7C4+VdTFKv7SsEpQ4olTqq
 eahUFrmEI0r5IdJ5X0Xlae5QXEv2mJmOG0+WTOo6G6SgLaU6h1QN6RQpANG67mSib2BX
 u87Bz62OkFUi6qXWslWDggQE3xc00F7HmZsA9IoWdZoplLz+tjo6huS29RLcx120/jMS
 WLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760454876; x=1761059676;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fQ2/l+GDmpBi0NY9SU8IDx2zM7PZVPBo+05aUkfaAj4=;
 b=PA+VPCAv1079bgFh4FpIGXnrRMF+bHVgvR4e24EQZN+AD+GSb/NIjm9rGB4qa1+G/C
 RzHj5rNIz7lhFzmo/zpjseTw31gdfadMwhLEBx7kezldVU7Br4J9ntXWZQijRtl5IEUp
 JJaSk+8afnHUC1IYSQHPe9rIXN7WzDIZ5bFE3oaHjdt3uygY7uBMkAdi8Axs0qeQfq3e
 l9ua8U6W3Hx7djLJOmqSPNSDsT0JcPqJcMqutgPg/HLW7E2r2CsAFb5fhCQvJQO+VemI
 mGrupExKkAAB1hZlp32cFJm9n8k6ADUJZSgyj6MIxkk6b2/U10FCnFf2VBNtP/fuByTm
 CJ3Q==
X-Gm-Message-State: AOJu0YxSeeKx3+Ds0QlbrGSawmHh1/NaFu5jBXb4yPg/TYpD4e0QfxoU
 UpNGuBTPhsiu4CAlVQWPyfHBkSuAAldXzBQiyKVtTsUuOK4Q8FJm4tblThUUNw4fUZBGRxPZ58b
 hMOv/2g==
X-Gm-Gg: ASbGncvocT08GcPwiLwnkGzjB4o61+haPTMrAZdOR9WMoB2qGak2LYNl772jb5BT4IN
 A3vG3mOqwuztG7b/ggAJQJ21nYoy2ttqsWGQWuODFTARkEOXkynwy+EzZ/lwpHjmRwv+6sXxvJm
 yQKa0n9lNQpqofUW7H68m8C9D7kbZOcjCP6KWZY1Smf0yGvRj5LlovZMW6HAmxtGTXpb3yYiuZr
 eq5kdScYcb0Z/3s9pBhyFobNemA1/v4RxhcWV94djpdirmHfmPyLxb8RSmXSoNUbA0ycgYNQP8W
 GL2ZX+dKpmuzHGOMb//NauNqEiPxWSoeWiK5Y3nb/QVrbyxrmFtp/Xd/MeLXzOgYukA8RLBFblU
 pX6PngBrkYPmUibFOE9VLwJ43CLMVVUc3BJJUNCIgBV4=
X-Google-Smtp-Source: AGHT+IFtKHWYAumG2id1psBXKdJPel2V4TWzLXXyV38rg2+hSRRHYbyJYspBYodtzXoDdcMbbn4U3w==
X-Received: by 2002:a17:907:6ea9:b0:b0b:f228:25a with SMTP id
 a640c23a62f3a-b50ac8e5713mr2507805866b.64.1760454875757; 
 Tue, 14 Oct 2025 08:14:35 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cccdaa0f9sm2431866b.45.2025.10.14.08.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 08:14:35 -0700 (PDT)
Message-ID: <4ffe0d16-3b4f-4a00-a3dc-7dcd7239f5f1@monstr.eu>
Date: Tue, 14 Oct 2025 17:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] AMD/Xilinx changes for 2026-01-rc1 v2
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

please pull these patches to your tree.
I have also took FWU patches which are only for our platform.

Thanks,
Michal

The following changes since commit eea470fd7f6a0db9fbdf8ab187a8b522dbb49c10:

   Subtree merge tag 'v6.17-dts' of dts repo [1] into dts/upstream (2025-10-08 
15:01:20 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2026.01-rc1-v2

for you to fetch changes up to a040578d8270ed8788d7663808ea63ce5ffd7840:

   spi: cadence-qspi: Remove cdns,is-dma property handling (2025-10-14 16:00:45 
+0200)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.01-rc1 v2

zynqmp:
- DT updates
- Enable new commands

mbv:
- Simplify defconfigs

clk:
- Separate legacy handler and use SMC handler

misc:
- Tighten TTC Kconfig dependency

net:
- Add 10GBE support to Gem

pwm:
- cadence-ttc: Fix array sizes

fwu:
- Add platform hook support

spi:
- Remove undocumented cdns,is-dma property

video:
- Fix DPSUB RGB handling

----------------------------------------------------------------
Andrew Goodbody (2):
       pwm: cadence-ttc: Insufficient elements in array
       video: zynqmp: Prevent use of uninitialised variables

Michal Simek (15):
       clk: xilinx: Call generic smc_call_handler()
       clk: xilinx: Separate legacy format to own handler
       arm64: zynqmp: Remove undocumented arasan, has-mdma property
       arm64: zynqmp: Remove RTC calibration from sm-k26
       arm64: zynqmp: Remove "ti,tps53679" property
       arm64: zynqmp: Fix incomplete comment in zynqmp-sc-vn-p-b2197-00-revA.dtso
       arm64: zynqmp: Enable PSCI 1.0
       arm64: zynqmp: Update compatible string for tps546X24
       arm64: zynqmp: Introduce DP port labels
       arm64: zynqmp: Enable DP for kr260, kv260, zcu100, zcu102, zcu104, zcu111
       arm64: zynqmp: Add pmw_fan label to k26
       arm64: zynqmp: Fix DTOVL warning about graphs in kv/kr260
       xilinx: Replace PHY_VITESSE by PHY_MSCC
       xilinx: Enable SNTP/DATE commands and RTC
       spi: cadence-qspi: Remove cdns,is-dma property handling

Naman Trivedi (1):
       drivers: firmware: update xilinx_pm_request to support max payload

Padmarao Begari (4):
       arm64: xilinx: Add i2c mux idle disconnect property
       FWU: Add platform hook support for fwu metata
       board: xilinx: update guid based on metadata
       xilinx: mbv: Remove redundancy in MB-V defconfigs

Quanyang Wang (1):
       arm64: zynqmp: Disable coresight by default

Radhey Shyam Pandey (1):
       arm64: zynqmp: Revert usb node drive strength and slew rate for zcu106

Tom Rini (1):
       timer: Tighten CADENCE_TTC_TIMER dependencies

Venkatesh Yadav Abbarapu (1):
       drivers: net: Add versal2 10GBE device support

  arch/arm/dts/versal-mini-ospi.dtsi             |   1 -
  arch/arm/dts/versal-net-mini-ospi.dtsi         |   1 -
  arch/arm/dts/zynqmp-g-a2197-00-revA.dts        |   2 +-
  arch/arm/dts/zynqmp-m-a2197-01-revA.dts        |   2 +-
  arch/arm/dts/zynqmp-m-a2197-02-revA.dts        |   2 +-
  arch/arm/dts/zynqmp-m-a2197-03-revA.dts        |   2 +-
  arch/arm/dts/zynqmp-mini-nand.dts              |   1 -
  arch/arm/dts/zynqmp-p-a2197-00-revA.dts        |   2 +-
  arch/arm/dts/zynqmp-sc-vek280-revA.dtso        |   1 +
  arch/arm/dts/zynqmp-sc-vhk158-revA.dtso        |   2 +
  arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso |  28 ++---
  arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso |  16 +--
  arch/arm/dts/zynqmp-sc-vpk120-revB.dtso        |   2 +
  arch/arm/dts/zynqmp-sc-vpk180-revA.dtso        |   1 +
  arch/arm/dts/zynqmp-sc-vpk180-revB.dtso        |   1 +
  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso         |  19 ++++
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso         |   2 +-
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso         |  21 +++-
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso         |   4 +-
  arch/arm/dts/zynqmp-sm-k26-revA.dts            |   3 +-
  arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts     |   2 +-
  arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts       |   1 -
  arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts       |   1 -
  arch/arm/dts/zynqmp-zcu100-revC.dts            |  18 +++
  arch/arm/dts/zynqmp-zcu102-revA.dts            |  18 +++
  arch/arm/dts/zynqmp-zcu104-revA.dts            |  18 +++
  arch/arm/dts/zynqmp-zcu104-revC.dts            |  18 +++
  arch/arm/dts/zynqmp-zcu106-revA.dts            |  14 +--
  arch/arm/dts/zynqmp-zcu111-revA.dts            |  18 +++
  arch/arm/dts/zynqmp.dtsi                       |  18 +--
  arch/arm/mach-zynqmp/aes.c                     |   3 +-
  arch/arm/mach-zynqmp/cpu.c                     |   4 +-
  arch/arm/mach-zynqmp/zynqmp.c                  |  10 +-
  board/xilinx/common/board.c                    |  27 +++++
  board/xilinx/zynqmp/zynqmp.c                   |   2 +-
  configs/amd_versal2_virt_defconfig             |   5 +-
  configs/microblaze-generic_defconfig           |   3 +
  configs/xilinx_mbv32_defconfig                 |   3 +
  configs/xilinx_mbv32_smode_defconfig           |  49 +-------
  configs/xilinx_mbv64_defconfig                 |  47 +-------
  configs/xilinx_mbv64_smode_defconfig           |  50 +-------
  configs/xilinx_versal_net_virt_defconfig       |   5 +-
  configs/xilinx_versal_virt_defconfig           |   5 +-
  configs/xilinx_zynq_virt_defconfig             |   3 +
  configs/xilinx_zynqmp_kria_defconfig           |   1 +
  configs/xilinx_zynqmp_virt_defconfig           |   3 +-
  drivers/clk/clk_versal.c                       |  55 +++++----
  drivers/firmware/firmware-zynqmp.c             |  36 +++---
  drivers/fpga/versalpl.c                        |   5 +-
  drivers/fpga/zynqmppl.c                        |   8 +-
  drivers/gpio/zynqmp_gpio_modepin.c             |   4 +-
  drivers/mmc/zynq_sdhci.c                       |  13 ++-
  drivers/net/zynq_gem.c                         |  95 +++++++++++++++-
  drivers/pinctrl/pinctrl-zynqmp.c               |  24 ++--
  drivers/power/domain/zynqmp-power-domain.c     |   2 +-
  drivers/pwm/pwm-cadence-ttc.c                  |  10 +-
  drivers/reset/reset-zynqmp.c                   |   2 +-
  drivers/soc/soc_amd_versal2.c                  |   2 +-
  drivers/soc/soc_xilinx_versal.c                |   2 +-
  drivers/soc/soc_xilinx_versal_net.c            |   2 +-
  drivers/soc/soc_xilinx_zynqmp.c                |   2 +-
  drivers/spi/cadence_ospi_versal.c              |   4 +-
  drivers/spi/cadence_qspi.c                     |  10 +-
  drivers/spi/cadence_qspi.h                     |   5 -
  drivers/spi/cadence_qspi_apb.c                 | 119 --------------------
  drivers/timer/Kconfig                          |   2 +-
  drivers/video/zynqmp/zynqmp_dpsub.c            |  12 +-
  include/fwu.h                                  |  11 ++
  include/zynqmp_firmware.h                      |   8 +-
  lib/fwu_updates/fwu.c                          |  18 +++
  70 files changed, 481 insertions(+), 429 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
