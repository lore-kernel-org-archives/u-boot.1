Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ABDC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 09:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6438A838D7;
	Wed,  8 Jul 2026 11:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20251104.gappssmtp.com header.i=@monstr-eu.20251104.gappssmtp.com header.b="fuNvKmdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B3F684118; Wed,  8 Jul 2026 11:09:35 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E0D80433
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 11:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso842739a12.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 02:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1783501772; x=1784106572;
 darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=579L8mxZHwuRPOhVX4uNDEnsTjDiPI7pDIV0xWzG0b0=;
 b=fuNvKmdAcI3n1YU7f7tGzUXxQoJNqCxJco1enmmWbhgerA9PMvYczbB4/RpbVyP2jt
 X2T0/fxK7LFBapzQ/tH2wGqz1ypGgs7+2zgl/qMztp2axNsalYyDMvrPiGaTXjk6Bxyx
 +GdQcBONBSqEjsjjW7WrNi9z7OzBLBdOFc/rSLb3VxEJtcLzXY+5WYgm73eFcr7+DQEA
 9+OkKG24pkPUnuttU5vviqlPYQzmENs8+e0PtQ8RDzU4LbXcqfJA1XuNsYjjy1szMS9f
 DrM/cdzP3wSfcfS+hI8nTbLSXNoA7nNAPtxe6Ssief+GjO+GLJjLOxJJxF5cSH/nFzIZ
 3FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783501772; x=1784106572;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=579L8mxZHwuRPOhVX4uNDEnsTjDiPI7pDIV0xWzG0b0=;
 b=btgGgTl6uOQwtem11vLvc1zGVZfGczGKDAP/c7SuIJaKcG8UAX6RYrkekkk7rIjzGn
 FxKOIkshoNztNP1ipP9XH1G/nYXFefAfoa4s42RUdI0WuLZWmGVBAC6teqSWiH83HY65
 Gt2ivdy3w3fjoOG9OA+t6Ij10n/aA9GPO3BUupdnVNlrqZs3dqc8y1ykRB2UBSC3RyPf
 Eb5Xby8MAGF3WRNgJ7a1DepbpVn+iciD8PCJWeVAMxyGUenEt0P2ZnMNm2k1t7ET6n4n
 rlhlulnPjV4o/yhUwRaT6l+1hWtDi+LPskkxxHDWthaB8p5CmzmTLO6/tQpfQk8zvFEZ
 F7nw==
X-Gm-Message-State: AOJu0YxY52RHcVVTIwuD4uhSI8T+tZhGUBm+Zna3TQx7Qhr4uBCOmkWj
 xISW0J8KfPlc3tqOWaty6vTzNWxiFdV8UfSfyZYjGXYClogGk0yMYAAuJnAl6t27xsTcK2ww53b
 CEbbITQ==
X-Gm-Gg: AfdE7ckAOJEFoGsfpczyYnVN3R8w+/vjfmvIbcGTrgJ+5DVBw0YSNyfdZJzpm6IH7V2
 o4Bvc7cqVmQWCubjgo+zYz6CWIsxnZ+XCEKbNb7ZmVQuoHwILo2AntpdCIZzvU2MeDY0Ay0z7e4
 XN2cQSSMUP+8IDPhbAwIrSfXAhp5aaVbGszwiSA+8qksf2QjB0nHW+yR6BBhcxWZLRjZFrLR0sG
 faRBG/sSZzhezFegUL/U4s2oaeFf+azIayi0aWW7/QkWb8jqnN2OukpUdod2b05UKMXYMtZ06jO
 HOjZkV/sLnbHEp1Ij60IG8z4odDWbJz8ynrHxpq189Yoktjh2aVjBYnq+FZIWw5evhD5lo3keGh
 mOqGPQteiiWM2NXYKdN4SENJO3Gf6zurW811SQvmSvPVM89x4EeSv18u58UTwqgvXMEdKitC/PM
 sWgFPCy7Ge5us7JojyH0GvHtXfdXlugY2KFgpHvF2ShvJ5OzNu0E0Mz0zaHLk9ZGFuSsXSR18g
X-Received: by 2002:a05:6402:5385:b0:698:81ab:c936 with SMTP id
 4fb4d7f45d1cf-69ab44a6198mr674889a12.23.1783501772029; 
 Wed, 08 Jul 2026 02:09:32 -0700 (PDT)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d9ea0asm7130968a12.22.2026.07.08.02.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 02:09:31 -0700 (PDT)
Message-ID: <e5c267b5-2be7-4a86-aa36-a19ee56658d5@monstr.eu>
Date: Wed, 8 Jul 2026 11:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] amd/xilinx/fpga patches for v2025.10-rc1 v3
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

please pull these patches to your tree. I can't see any issue in CI.
The main part is firmware interface cleanup which I expect will continue in near 
future.

Thanks,
Michal


The following changes since commit ee5d46b45ec0c63f8f9dd1e816e0dac3452ccc3d:

   Merge branch 'next' (2026-07-06 18:26:12 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git 
tags/xilinx-for-v2026.10-rc1-v3

for you to fetch changes up to 34c89c840c33dd154746ebdc9bbf2e4f3614d292:

   arm: dts: zynqmp: Fix space indentation to use tabs (2026-07-08 08:55:52 +0200)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.10-rc1 v3

AMD:
- Firmware interface decoupling (part 1)

ZynqMP:
- DT updates
- Add TCG variant detection

Versal/Versal2:
- Drop DDR MMU mapping and map it dynamically

tools:
- Add register initialization to mkimage

MAINTAINERS:
- Clean Zynq/ZynqMP fragments

ufs:
- Fix driver reregistration

fpga:
- altera: Simplify driver conditional compilation selection

----------------------------------------------------------------
Danish Ahmad Rosdi (1):
       drivers: fpga: Use FPGA_INTEL_SDM_MAILBOX conditional instead of 
Agilex/Stratix10

Erich E. Hoover (1):
       mkimage: allow zynqmpbif to use a register initialization file

Harini T (1):
       arch: arm: dts: Add RTC clock nodes for ZynqMP platform

Marek Vasut (1):
       MAINTAINERS: Replace Zynq/ZynqMP with N:

Michal Simek (28):
       arm64: zynqmp: Drop incorrect #phy-cells from ethernet-phy nodes
       arm64: zynqmp: Use fixed-partitions for MTD
       arm64: zynqmp: Add CMA reserved-memory for runtime FPGA loading
       arm64: zynqmp: dts: Fix file descriptions to match actual filenames
       arm64: zynqmp: Sync compatible string format
       arm64: versal2: Drop static DDR MMU mappings
       arm64: versal: Drop static DDR and PCIe MMU mappings
       arm: xilinx: Guard mach sys_proto.h against multiple inclusion
       arm64: versal2: Decouple multiboot register access from firmware
       arm64: versal2: Move bootmode decoding out of board code
       arm64: versal: Decouple multiboot register access from firmware
       arm64: versal: Move bootmode decoding out of board code
       arm64: versal: Move board_early_init_r clock setup to mach code
       arm64: versal2: Move board_early_init_r clock setup to mach code
       arm64: versal-net: Move board_early_init_r clock setup to mach code
       arm64: zynqmp: Move board_early_init_r clock setup to mach code
       arm64: versal2: Move SoC detection out of board code
       arm64: versal-net: Move SoC detection out of board code
       arm64: versal-net: Move bootmode decoding out of board code
       arm64: zynqmp: Decouple MMIO accessors from firmware
       arm64: versal-net: Deduplicate SPI bootmode handling
       arm64: versal-net: Simplify spi_get_bootseq() bootmode switch
       arm64: versal-net: Do not print bootmode from spi_get_env_dev()
       arm64: versal-net: Look up eMMC device in boot_targets_setup()
       arm64: versal-net: Add mmc_get_env_dev() and deduplicate MMC handling
       arm64: zynqmp: Disable ina226 iio-hwmon nodes
       arm64: xilinx: Add missing newline in kr260-revA
       arm: dts: zynqmp: Fix space indentation to use tabs

Padmarao Begari (1):
       soc: xilinx: zynqmp: Add TCG variant detection for ZU3TCG

Pranav Tilak (1):
       ufs: amd-versal2: Fix missing .priv_auto in driver registration

Rob Herring (Arm) (1):
       arm64: dts: xilinx: Drop "label" property on dlg, slg7xl45106

Shaikh Mohammed Suhan (1):
       arm64: zynqmp: add USB hub supply regulators

Suraj Kakade (1):
       amd: versal2: detect spi env bus from boot mode

Trapti Damodar Balgi (2):
       arm64: zynqmp-dlc21-revA: Update GPIO line names mapping
       arm64: zynqmp-dlc21-revA: add mac nvmem cell for gem0

  MAINTAINERS                                           |  56 +---
  arch/arm/dts/zynqmp-clk-ccf.dtsi                      |  15 +-
  arch/arm/dts/zynqmp-dlc21-revA.dts                    |  17 +-
  arch/arm/dts/zynqmp-e-a2197-00-revA.dts               |  20 ++
  arch/arm/dts/zynqmp-g-a2197-00-revA.dts               |   6 +
  arch/arm/dts/zynqmp-m-a2197-01-revA.dts               |   6 +
  arch/arm/dts/zynqmp-m-a2197-02-revA.dts               |   5 +
  arch/arm/dts/zynqmp-m-a2197-03-revA.dts               |   5 +
  arch/arm/dts/zynqmp-sc-revB.dts                       | 171 ++++++------
  arch/arm/dts/zynqmp-sc-revC.dts                       |   1 -
  arch/arm/dts/zynqmp-sc-vek280-revA.dtso               |   5 +-
  arch/arm/dts/zynqmp-sc-vek280-revB.dtso               |   5 +-
  arch/arm/dts/zynqmp-sc-vhk158-revA.dtso               |   5 +-
  arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso        |  20 +-
  arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso        |  16 ++
  arch/arm/dts/zynqmp-sc-vpk120-revB.dtso               |   5 +-
  arch/arm/dts/zynqmp-sc-vpk180-revA.dtso               |   5 +-
  arch/arm/dts/zynqmp-sc-vpk180-revB.dtso               |   7 +-
  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso                |  22 +-
  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso                |  26 +-
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso                |  25 +-
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso                |  61 ++--
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso                |  23 +-
  arch/arm/dts/zynqmp-sm-k24-revA.dts                   |   7 +-
  arch/arm/dts/zynqmp-sm-k26-revA.dts                   |  11 +-
  arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts |  38 +--
  arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts            |  14 +-
  arch/arm/dts/zynqmp-vpk120-revA.dts                   |  14 +-
  arch/arm/dts/zynqmp-zc1232-revA.dts                   |  55 ++--
  arch/arm/dts/zynqmp-zc1254-revA.dts                   |  53 ++--
  arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts              |  55 ++--
  arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts              | 153 ++++++----
  arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts              | 124 ++++----
  arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts              |  53 ++--
  arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts              |  15 +
  arch/arm/dts/zynqmp-zcu100-revC.dts                   |  19 +-
  arch/arm/dts/zynqmp-zcu102-revA.dts                   |  74 +++--
  arch/arm/dts/zynqmp-zcu102-revB.dts                   |   1 -
  arch/arm/dts/zynqmp-zcu104-revA.dts                   |  56 ++--
  arch/arm/dts/zynqmp-zcu104-revC.dts                   |  57 ++--
  arch/arm/dts/zynqmp-zcu106-revA.dts                   |  74 +++--
  arch/arm/dts/zynqmp-zcu111-revA.dts                   |  70 +++--
  arch/arm/dts/zynqmp-zcu1275-revA.dts                  |  53 ++--
  arch/arm/dts/zynqmp-zcu1275-revB.dts                  |  53 ++--
  arch/arm/dts/zynqmp-zcu1285-revA.dts                  |  15 +
  arch/arm/dts/zynqmp-zcu208-revA.dts                   |  30 +-
  arch/arm/dts/zynqmp-zcu216-revA.dts                   |  30 +-
  arch/arm/dts/zynqmp-zcu670-revA.dts                   |  32 ++-
  arch/arm/dts/zynqmp-zcu670-revB.dts                   |  32 ++-
  arch/arm/dts/zynqmp.dtsi                              |   1 -
  arch/arm/mach-versal-net/cpu.c                        | 149 ++++++++++
  arch/arm/mach-versal-net/include/mach/sys_proto.h     |   6 +
  arch/arm/mach-versal/cpu.c                            |  87 +++++-
  arch/arm/mach-versal/include/mach/sys_proto.h         |  16 ++
  arch/arm/mach-versal2/cpu.c                           | 160 ++++++++++-
  arch/arm/mach-versal2/include/mach/sys_proto.h        |  14 +
  arch/arm/mach-zynqmp/cpu.c                            |  69 ++---
  arch/arm/mach-zynqmp/include/mach/sys_proto.h         |   5 +
  board/amd/versal2/board.c                             | 161 ++---------
  board/xilinx/versal-net/board.c                       | 295 +++++---------------
  board/xilinx/versal/board.c                           |  66 +----
  board/xilinx/zynqmp/zynqmp.c                          |  18 +-
  drivers/firmware/firmware-zynqmp.c                    |  89 ++++++
  drivers/fpga/altera.c                                 |   6 +-
  drivers/soc/soc_xilinx_zynqmp.c                       |   4 +-
  drivers/ufs/ufs-amd-versal2.c                         |   1 +
  tools/zynqmpbif.c                                     |  12 +
  tools/zynqmpimage.c                                   |   4 +-
  tools/zynqmpimage.h                                   |   2 +
  69 files changed, 1834 insertions(+), 1046 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
