Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F48CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 12:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0032986D6E;
	Fri, 13 Oct 2023 14:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="Oe8N8AmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77DE886E9F; Fri, 13 Oct 2023 14:44:59 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9856C86D62
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 14:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso200991b3a.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1697201095; x=1697805895;
 darn=lists.denx.de; 
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d707BuDIk6rPToL5RYQVMw5i1fz4poUz3QK9m1vRUKg=;
 b=Oe8N8AmFYffemd3Ep8Hi+nkfOmJqlUFxyj6LLGZxGM8eqnr82iryYHz7BYC2JA+3gO
 SMGPv/oUE8Xnyi9Ah/q1TkiZJFPpeESP/DuLVKOn5pBf/WYy2MVZ3GCaMBS8094LWhg1
 yDFXJHDMNBG2pMgHtDbEAoC3LzWzEb6to/OsZxVJ60Z+Ef363ErE2kP8Sw/dVj6ZvYsZ
 p7RFTIOX8vv3fMUUoHvbEZIlrWjnQP6uQPsOHoXdsJmMOsGwHSMDALjK9iPwujMtACNI
 g1GOaUwVtIvIwbMVpa6O6Kc9JSB60Hj3enNiTH5gwrm6vVlNzkh2q5W2K2U6zPIc6v4e
 SCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201095; x=1697805895;
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d707BuDIk6rPToL5RYQVMw5i1fz4poUz3QK9m1vRUKg=;
 b=i+Fp/jt3GEN4iAQ8/55blxJQibgTdHR1hBVSbcu+L5+R/AyOh9YGWqwpyDqjIOSHvL
 LCT88F+KgEtBtGF/QOOsC7zq10Fva9HQCQuXGzvtK7+qvqeaKb6c2x/k0iJN9tjCqEPs
 2YZ8z8GPWCKTGpBDEei7GZaSf6HUktXaQDqdViPr+VeQWyDVd5wF7VqhSEvgdsDGhZtW
 QsbZGPi/+yQaYV3+W4BHBr6Jj+p8FdBHnkW/RptJVdLKcWyAV2ZHzFIAeg0h4mx0F/E1
 2pp1a1Zfl4pUbb4Iu+vDhAoL7W2QymxQy4sy+Mky0AoiRAKcdWOZ/CgcLCq5Oh1Pz03X
 AkBQ==
X-Gm-Message-State: AOJu0Yx89EfMtwuTspiux2q/S/T7+i6urnHnpwjY/DazFhKZ0D1DIYrN
 tnZ097X3zZA2fx5kDj56BCLvoFvIC92CGx+6ML+cgw==
X-Google-Smtp-Source: AGHT+IEjqr/HB37aFDNEaE5JDIg4bs8cpbwxAHLr49qX3oKmWoqi+e/TmblBPcyrqG38DUG0K01FwA==
X-Received: by 2002:a05:6a00:988:b0:690:c887:8cd8 with SMTP id
 u8-20020a056a00098800b00690c8878cd8mr31694184pfg.32.1697201094806; 
 Fri, 13 Oct 2023 05:44:54 -0700 (PDT)
Received: from [192.168.137.2] ([149.199.80.131])
 by smtp.gmail.com with ESMTPSA id
 b2-20020aa78702000000b00690fb385ea9sm13484591pfo.47.2023.10.13.05.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 05:44:54 -0700 (PDT)
Message-ID: <c0186a3f-1654-4a51-b6e5-1aafe174b587@monstr.eu>
Date: Fri, 13 Oct 2023 14:44:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] xilinx patches for v2024.01-rc1 v3
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
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

please apply to following patches to your tree. The most of them are DT chagnes 
are coming from Linux dt schema validation, fixing DT warnings W=1, sync it with 
upstream kernel
and adding missing pieces. Also new DTSes are added to described other boards. 
It most interesting are adding support for new Kria SOM Kd240 board and 
descriptions related to System Controllers which
are ZynqMP based SOCs available on Versal/Versal NET evaluation boards which are 
handling DUT resources.

There are other changes sent but I want to clean my queue to enable testing for it.

Thanks,
Michal

The following changes since commit 83aa0ed1e93e1ffac24888d98d37a5b04ed3fb07:

   Merge branch '2023-10-06-spl-prepare-for-universal-payload' (2023-10-06 
17:23:47 -0400)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2024.01-rc1-v3

for you to fetch changes up to 7a82bfff5ea7089905dff14e65436d23c1e5adc4:

   test/py: net: Add a test for 'pxe get' command (2023-10-10 14:57:29 +0200)

----------------------------------------------------------------
Xilinx changes for v2024.01-rc1 v3

clk:
- remove additional compatible strings for Versal NET

net:
- zynq_gem: Fix clock calculation for MDC for higher frequencies

pinctrl:
- core: Extend pinmux status buffere size
- zynqmp driver: Show also tristate configuration

test:
- add test case for pxe get

Xilinx:
- describe SelectMAP boot mode

Zynq:
- Fix nand description in DT

ZynqMP:
- DTS sync patches with kernel and also W=1 related fixes
- Add support for KD240, zcu670, e-a2197 with x-prc cards, SC revB/C with i2c
   description for other SC based boards
- k24 psu_init cleanup

----------------------------------------------------------------
Laurent Pinchart (2):
       arm64: dts: zynqmp: zcu106a: Describe DisplayPort connector
       arm64: dts: zynqmp: Add ports for the DisplayPort subsystem

Love Kumar (1):
       test/py: net: Add a test for 'pxe get' command

Michal Simek (29):
       arm64: zynqmp: Describe assigned-clocks for uarts
       arm64: zynqmp: Rename dt overlay file names from dts to dtso
       arm64: zynqmp: Remove resetin/out from K24 psu_init
       arm64: zynqmp: Describe interrupts by using macros
       arm64: xilinx: Remove address/size-cells from flash node
       arm64: xilinx: Use lower case for partition address
       arm64: zynqmp: Describe bus-width for SD card on KV260
       arm64: zynqmp: Fix Siva's email address format
       arm64: xilinx: Put ethernet phys to mdio node
       arm64: xilinx: Remove address/size-cells from gem nodes
       arm64: zynqmp: Convert kv260-revA overlay to ASCII text
       arm64: zynqmp: Sync licenses with Linux kernel
       ARM: zynq: Describe nand device in DT
       arm64: zynqmp: Aligned QSPI configuration with latest spec
       arm64: zynqmp: Add support for KD240 Kria SOM CC
       arm64: zynqmp: Remove xlnx,fclk nodes
       arm64: zynqmp: Add support for vck190 revB system controller
       arm64: zynqmp: Add x-prc-01/02/03/04/05 revA support from SC
       arm64: zynqmp: Add support for vpk120-revA
       arm64: zynqmp: Create description for generic SC (vpk120-revB)
       arm64: zynqmp: Add support for SC revC
       arm64: zynqmp: Describe i2c structures for SCs
       arm64: zynqmp: Add support for VPXA2785
       arm64: zynqmp: Add support for zcu670-revA
       arm64: zynqmp: Add support for zcu670-revB
       arm: dts: xilinx: Remove undocumented is-dual property
       arm64: zynqmp: Do not use '_' in DT node names
       Revert "clk: versal: Enable clock driver for Versal NET"
       arm64: xilinx: Do not use '_' in si5335 DT node names

Polak, Leszek (1):
       arm64: versal: Add SelectMAP boot mode identification

Tanmay Shah (1):
       arm64: dts: xilinx: zynqmp: Add RPU subsystem device node

Venkatesh Yadav Abbarapu (4):
       net: zynq_gem: Update the MDC clock divisor in the probe function
       pinctrl: Increase size of pinmux status buffer
       pinctrl: zynqmp: Display the tristate configuration for all pins
       net: phy: xilinx_phy: Get rid of using property xlnx, phy-type

  arch/arm/dts/Makefile                                                |  20 +
  arch/arm/dts/avnet-ultra96-rev1.dts                                  |   2 +-
  arch/arm/dts/bitmain-antminer-s9.dts                                 |   3 +
  arch/arm/dts/versal-mini-emmc0.dts                                   |   2 +-
  arch/arm/dts/versal-mini-emmc1.dts                                   |   2 +-
  arch/arm/dts/versal-mini-ospi.dtsi                                   |   2 +-
  arch/arm/dts/versal-mini-qspi.dtsi                                   |   2 +-
  arch/arm/dts/versal-mini.dts                                         |   2 +-
  arch/arm/dts/zynq-cc108.dts                                          |   1 -
  arch/arm/dts/zynq-dlc20-rev1.0.dts                                   |   1 -
  arch/arm/dts/zynq-minized.dts                                        |   1 -
  arch/arm/dts/zynq-topic-miami.dts                                    |   1 -
  arch/arm/dts/zynq-topic-miamilite.dts                                |   1 -
  arch/arm/dts/zynq-topic-miamiplus.dts                                |   1 -
  arch/arm/dts/zynq-zc770-xm011.dts                                    |   3 +
  arch/arm/dts/zynqmp-clk-ccf.dtsi                                     |  23 +-
  arch/arm/dts/zynqmp-dlc21-revA.dts                                   |  10 +-
  arch/arm/dts/zynqmp-e-a2197-00-revB.dts                              |  34 +
  arch/arm/dts/zynqmp-g-a2197-00-revA.dts                              |  10 +-
  arch/arm/dts/zynqmp-m-a2197-01-revA.dts                              |  19 +-
  arch/arm/dts/zynqmp-m-a2197-02-revA.dts                              |  19 +-
  arch/arm/dts/zynqmp-m-a2197-03-revA.dts                              |  19 +-
  arch/arm/dts/zynqmp-mini-emmc0.dts                                   |   2 +-
  arch/arm/dts/zynqmp-mini-emmc1.dts                                   |   2 +-
  arch/arm/dts/zynqmp-mini-nand.dts                                    |   2 +-
  arch/arm/dts/zynqmp-mini-qspi.dts                                    |   2 +-
  arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso               |  76 +++
  arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso               |  76 +++
  arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso               |  80 +++
  arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso               |  86 +++
  arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso               |  86 +++
  arch/arm/dts/zynqmp-p-a2197-00-revA.dts                              |  18 +-
  arch/arm/dts/zynqmp-sc-revB.dts                                      | 430 
+++++++++++++
  arch/arm/dts/zynqmp-sc-revC.dts                                      |  37 ++
  arch/arm/dts/zynqmp-sc-vek280-revA.dtso                              | 230 +++++++
  arch/arm/dts/zynqmp-sc-vek280-revB.dtso                              |  15 +
  arch/arm/dts/zynqmp-sc-vhk158-revA.dtso                              | 321 
++++++++++
  arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso                       | 460 
++++++++++++++
  arch/arm/dts/zynqmp-sc-vpk120-revB.dtso                              | 326 
++++++++++
  arch/arm/dts/zynqmp-sc-vpk180-revA.dtso                              | 371 
+++++++++++
  arch/arm/dts/zynqmp-sc-vpk180-revB.dtso                              | 337 
++++++++++
  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso                               | 353 
++++++++++
  arch/arm/dts/{zynqmp-sck-kr-g-revA.dts => zynqmp-sck-kr-g-revA.dtso} |   0
  arch/arm/dts/{zynqmp-sck-kr-g-revB.dts => zynqmp-sck-kr-g-revB.dtso} |   0
  arch/arm/dts/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} |  11 +-
  arch/arm/dts/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} |   5 +-
  arch/arm/dts/zynqmp-sm-k26-revA.dts                                  |   6 +-
  arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts                |   2 -
  arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts                           | 438 
+++++++++++++
  arch/arm/dts/zynqmp-vpk120-revA.dts                                  | 574 
+++++++++++++++++
  arch/arm/dts/zynqmp-zc1254-revA.dts                                  |   4 +-
  arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts                             |  15 +-
  arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts                             |  19 +-
  arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts                             |   8 +-
  arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts                             |  26 +-
  arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts                             |  10 +-
  arch/arm/dts/zynqmp-zcu100-revC.dts                                  |   7 +-
  arch/arm/dts/zynqmp-zcu102-rev1.0.dts                                |   2 +-
  arch/arm/dts/zynqmp-zcu102-revA.dts                                  |   8 +-
  arch/arm/dts/zynqmp-zcu102-revB.dts                                  |   3 +-
  arch/arm/dts/zynqmp-zcu104-revA.dts                                  |   3 +-
  arch/arm/dts/zynqmp-zcu104-revC.dts                                  |   5 +-
  arch/arm/dts/zynqmp-zcu106-revA.dts                                  |  28 +-
  arch/arm/dts/zynqmp-zcu111-revA.dts                                  |   8 +-
  arch/arm/dts/zynqmp-zcu1275-revA.dts                                 |   2 +-
  arch/arm/dts/zynqmp-zcu1275-revB.dts                                 |   2 +-
  arch/arm/dts/zynqmp-zcu1285-revA.dts                                 |   2 +-
  arch/arm/dts/zynqmp-zcu208-revA.dts                                  |   7 +-
  arch/arm/dts/zynqmp-zcu216-revA.dts                                  |   7 +-
  arch/arm/dts/zynqmp-zcu670-revA.dts                                  | 669 
+++++++++++++++++++
  arch/arm/dts/zynqmp-zcu670-revB.dts                                  | 672 
++++++++++++++++++++
  arch/arm/dts/zynqmp.dtsi                                             | 255 
+++++---
  arch/arm/mach-versal-net/include/mach/hardware.h                     |   1 +
  arch/arm/mach-versal/include/mach/hardware.h                         |   1 +
  arch/arm/mach-versal/mp.c                                            |   2 +-
  board/xilinx/versal-net/board.c                                      |   3 +
  board/xilinx/versal/board.c                                          |   4 +
  board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c                | 123 ----
  configs/xilinx_zynqmp_virt_defconfig                                 |   2 +-
  drivers/clk/clk_versal.c                                             |   1 -
  drivers/fpga/zynqmppl.c                                              |   2 +-
  drivers/net/phy/xilinx_phy.c                                         |   5 -
  drivers/net/zynq_gem.c                                               |  73 ++-
  drivers/pinctrl/pinctrl-zynqmp.c                                     |   8 +-
  include/dm/pinctrl.h                                                 |   2 +-
  test/py/tests/test_net.py                                            |  66 ++
  86 files changed, 6186 insertions(+), 393 deletions(-)
  create mode 100644 arch/arm/dts/zynqmp-e-a2197-00-revB.dts
  create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso
  create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso
  create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso
  create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso
  create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso
  create mode 100644 arch/arm/dts/zynqmp-sc-revB.dts
  create mode 100644 arch/arm/dts/zynqmp-sc-revC.dts
  create mode 100644 arch/arm/dts/zynqmp-sc-vek280-revA.dtso
  create mode 100644 arch/arm/dts/zynqmp-sc-vek280-revB.dtso
  create mode 100644 arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
  create mode 100644 arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
  create mode 100644 arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
  create mode 100644 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
  create mode 100644 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
  create mode 100644 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
  rename arch/arm/dts/{zynqmp-sck-kr-g-revA.dts => zynqmp-sck-kr-g-revA.dtso} (100%)
  rename arch/arm/dts/{zynqmp-sck-kr-g-revB.dts => zynqmp-sck-kr-g-revB.dtso} (100%)
  rename arch/arm/dts/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} (96%)
  rename arch/arm/dts/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} (98%)
  create mode 100644 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
  create mode 100644 arch/arm/dts/zynqmp-vpk120-revA.dts
  create mode 100644 arch/arm/dts/zynqmp-zcu670-revA.dts
  create mode 100644 arch/arm/dts/zynqmp-zcu670-revB.dts

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
