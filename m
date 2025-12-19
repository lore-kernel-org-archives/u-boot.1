Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE47D767C3
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 10:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33B580050;
	Fri, 19 Dec 2025 11:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="JjVBIuAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 215E580077; Fri, 19 Dec 2025 11:54:40 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B768E8003E
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 11:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b73a9592fb8so333599066b.1
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 02:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1766141677; x=1766746477;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzomSwqh2smGp9BMUOshZdwJS5OXXoq5A6WsVmN/hDE=;
 b=JjVBIuAyyt1vOKrLHBFq5sD8hsZHOTs09ElVH5wVSBvBTE9BX/bFr2gLg/CCJouJo7
 w3snHJeJVMJKzIYIiAeTMWB7MZCvdS9ID8DVHiF3GwVxtvxnjCrQbrfF5z4N5mS93lsa
 xMq582ajjIjeEAFhZRlyrdCPErx2GOd+gWxajIx1vWrgmMJEVT1FYD6Ozkvk4sqpnHoX
 o3BrTCJ+iUOb1pVK1c+dOtiafgytcSSIGAyjfpTFxcy3h9jD4+4QJaXT/vnYMD6vFrCD
 tbdThZxUWiIEfjvjOI5ri3r6lYKYBEohVqspgGeDvJC8wpC6PII3QlzNljKe7vCVeH67
 LNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766141677; x=1766746477;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VzomSwqh2smGp9BMUOshZdwJS5OXXoq5A6WsVmN/hDE=;
 b=X6KiB37oRrx2MrdGDLlcwmVYt2CsiOPsAGIOllA0tkej6ts3xE5Al8pc/XQgcnOvyK
 kN3SJPKDsn7+6X6ZgZ5MXWDq1R7VroYaEmnI+tIZ1ein4Px8x1fqMnwBNV7bZPajTv4K
 nayhOeYDtagvdLktAoXAuLb7vAEvyngfkyBrRlw15YynWOQhODlsjBQCuXKLSl43Tlz3
 iArnnYfz6E148gi9i5mLsBMP3k+cqA5MHz4mDssyJCYIfr2U/3k0oU+CpdG3kLvNlVnE
 NTTpmLaQggu4qc67JclYbBS13wOb0BBQMGy7kAiT0Sr7tIsfrtBtkand8e/YpTJ/3IRO
 zdSw==
X-Gm-Message-State: AOJu0YxIO5zlW+nanXY2LekaWaQ705MYAxuaoYb0gw+bHURxO/baPxmg
 taGs49XjVY7GEpySUKlgGkQXndF0S97kZo9tgdxmrOqHURFLfJm93Q4BEsSkyysaj8QgUM/t2RQ
 56LseeQ==
X-Gm-Gg: AY/fxX5iXqXlZTRniFQCPplnuBMPt2ymuEcvGH4ocpZPf0E5Fy7KHe2tdi5o/GjRsCh
 +8fb7SGPz+ED4WzlNU3mqJClM0+MWvNNbB8Jsln7lzDmGf6bnQeYaK4kb3amFyUXghhxZcggtTj
 tZuWGLYWw/vpjjfB+6DVOCdS6xnKLad1gpO8e2ypyM/Fdr8ZyRqbWI/HnZvyP0Vz+OUgdfvBw5p
 /Yd96C0IBvzO2lH5h7Uv2bxJ6CxxNDQ/MKqyCrhX76IdRfq6DB8hVtH9sPenH+nud/h4twBKNuL
 WpdREmAx3OPfvoOn+owSRq/e9zWrAJW/4Z0VjEkv0vanzfRz+VLUj4uFpPUuejhnsOXAhyXzsR3
 9cQ83dFPA7xpqItfDXxaYNhIduIadCGo8Bhg11DBlMHEJw1Vf/hNsTyBR9xl5TZ5Q6WJwhDwlIz
 TJ4GczWM4aYS/d
X-Google-Smtp-Source: AGHT+IFsL1GiHjvA1EP373Wsqt1GB1OVG2EOu2q8HdauGEv8lR18XUVvYiBOQoYUUe0wDLNCKYtcbQ==
X-Received: by 2002:a17:907:1b26:b0:b72:84bd:88f3 with SMTP id
 a640c23a62f3a-b803563ee36mr275583466b.11.1766141676940; 
 Fri, 19 Dec 2025 02:54:36 -0800 (PST)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037ad2732sm203694366b.20.2025.12.19.02.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 02:54:36 -0800 (PST)
Message-ID: <21930cc8-6895-4722-8caa-9d222a4d563a@monstr.eu>
Date: Fri, 19 Dec 2025 11:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] AMD/Xilinx changes for 2026.04-rc1
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

it is time to cleanup my queue. I can't see any issue in CI. I hope that 
removing cdns,is-dma property again is not going to cause issues on other 
platforms that's why I want to also get it to next sooner rather then later.

There are multiple patches related to UFS which have been sent and also some 
other platform related one that's why I expect another pull request for rc1 in 
future.

Thanks,
Michal


The following changes since commit 930eff5416ea98ebd09cec73f5d06a7033b4d52e:

   Merge tag 'u-boot-socfpga-next-20251217' of 
https://source.denx.de/u-boot/custodians/u-boot-socfpga into next (2025-12-18 
08:06:10 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2026.04-rc1

for you to fetch changes up to 0b880fc95dbaed88dd55060730857b8f52765c57:

   arch/arm/mach-zynqmp: configure default BL32_LOAD_ADDR (2025-12-19 10:57:58 
+0100)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.04-rc1

xilinx:
- Sync ESRT with detected GUID
- DT cleanups
- Add logic for FRU information multiple times
- Enable more drivers pca9541, usb5744
- Enable more commands
- Cleanup firmware DT bindings

firmware:
- Add enhancement SMC format support

clk/versal:
- Various cleanups
- Add support for Versal Gen 2

i2c:
- cdns: Add timeout for RXDV status bit polling

spi:
- cadence: Remove cdns,is-dma DT property
- cadence: Remove duplicated return
- cadence_versal: Update flash reset delay

memtop:
- Update max memory reserved spaces to 64

Versal Gen 2:
- Aligned addresses with default memory map
- Add support for reading multiboot value

MB-V:
- Make SPL smaller
- Add support for SPI
- Move SPL to run out of BRAM

ZynqMP:
- Change default load address for BL32

----------------------------------------------------------------
Michal Simek (13):
       clk: versal: Use __data macro for moving variable to data section
       clk: versal: Add support for CLK_AUTO_ID
       clk: versal: Cleanup driver
       firmware: xilinx: Add support for enhancement SMC format
       clk: versal: Enable clock driver for Versal Gen 2
       spi: cadence: Remove cdns,is-dma DT property
       arm64: xilinx: Remove unnecessary #address/size-cells
       xilinx: amd: Enable the PCA9541 I2C Bus arbiter
       arm64: versal2: Enable USB5744 usb hub
       cadence_qspi: Remove duplicated return
       arm64: versal2: Read and show multiboot value
       xilinx: versal: Get rid of xlnx-versal-power.h from bindings
       xilinx: mbv32: Disable floating point

Neal Frager (1):
       arch/arm/mach-zynqmp: configure default BL32_LOAD_ADDR

Padmarao Begari (7):
       board: xilinx: Update ESRT after copying GUID
       board: xilinx: Retry FRU EEPROM read on timeout
       i2c: cdns: Add timeout for RXDV status bit polling
       xilinx: mbv: Disable SPL GZIP
       xilinx: mbv: Remove debug UART support
       board: xilinx: add SPL boot device support
       xilinx: mbv: Update defconfigs as per memory map

Venkatesh Yadav Abbarapu (4):
       common: memtop: Update the MEM_RGN_COUNT macro to 64
       arm64: versal2: Update the text base and dtb address
       arm64: versal2: Enable reset and poweroff via sysreset framework
       cadence_qspi: Update the delays for flash reset

  arch/arm/dts/versal-mini-ospi.dtsi             |  3 +-
  arch/arm/dts/versal-net-mini-ospi.dtsi         |  3 +-
  arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso |  3 --
  arch/arm/mach-versal2/include/mach/hardware.h  |  4 +-
  arch/arm/mach-zynqmp/Kconfig                   |  2 +-
  board/amd/versal2/board.c                      | 22 ++++++++
  board/xilinx/common/board.c                    | 23 ++++++++-
  board/xilinx/mbv/board.c                       | 14 +++--
  common/memtop.c                                |  2 +-
  configs/amd_versal2_virt_defconfig             |  5 ++
  configs/xilinx_mbv32_defconfig                 | 19 ++++---
  configs/xilinx_versal_virt_defconfig           |  1 +
  configs/xilinx_zynqmp_virt_defconfig           |  1 +
  drivers/clk/Kconfig                            |  2 +-
  drivers/clk/clk_versal.c                       | 49 +++++++++++++-----
  drivers/firmware/firmware-zynqmp.c             | 36 +++++++++++++
  drivers/i2c/i2c-cdns.c                         | 11 ++++
  drivers/spi/cadence_ospi_versal.c              |  7 ++-
  drivers/spi/cadence_qspi.c                     | 23 ++++++---
  drivers/spi/cadence_qspi.h                     |  2 -
  include/dt-bindings/power/xlnx-versal-power.h  | 54 --------------------
  include/zynqmp_firmware.h                      |  8 +++
  22 files changed, 188 insertions(+), 106 deletions(-)
  delete mode 100644 include/dt-bindings/power/xlnx-versal-power.h

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

