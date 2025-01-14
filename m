Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791DBE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 14:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D907980758;
	Tue, 14 Jan 2025 15:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="I/D4CsDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EA580758; Tue, 14 Jan 2025 15:50:21 +0100 (CET)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A729E80657
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 15:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so1129366966b.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1736866218; x=1737471018;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Autf/+KohvDzspUpzHSfNYQpkzr+Uts7P2hznDR5CyE=;
 b=I/D4CsDmiS7UEFTRBCHgutYtrjzLkV/OtUnv0CGaipjPKkoVaxVavaLW2aBlin+PnA
 0CQZ0UAZsZJPJhDdkHHioFEwLVHuK6l6szUVJjzsWsCNkKrAA6lFLCr/YuTSbZ77huuz
 x8xVdExraElMCD3R2RUQRvC3Lr2xnuxxmeDfwUu3Hy91SNVVeMY0U9qPgDevsAkINMc0
 MiMIZDYteyWkOATub1TMEsrH2hwwGXQSSwYsT8c7sUZNwrxp0dFTsYyF3nSG9pnMOkOZ
 EWugvcKEVsmu4LinpaBtoa+u+2e1pFIe/lsHGpsWm0OsWKpVuJT7hJJMk/B3B/E59VOX
 ogIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736866218; x=1737471018;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Autf/+KohvDzspUpzHSfNYQpkzr+Uts7P2hznDR5CyE=;
 b=Xjtz68WxhdJqX8xqe/3Ev3/z3j8D8/eEONIVp7xo3LswJzmD58RTr5oODOpacdXsi9
 0YOgRmRJ4BeUe2cTn+txsagFgbdJX5Qsa8TTY3f/NBP9syclQ395iUOP0xvaiRVF8M+6
 7xES8tREWOrKGN1NeMX6YFOGw0x1EKYsNyTywjgm7Z4CVSEfJNDo2LOvBiYzN/dxVbON
 lVd+kkVhLA9RHNJE9HdsFgmmERApCXC1DrVndwlFhvvT/vQP+lsUOlbEyuuoZRJ33oAU
 OzCIEFE4B3cHv2BjFKGDyfZr21dwXdF50MY1n2y3ymUGxA12WvZN8EzvRpbTg4zLad3q
 3JSQ==
X-Gm-Message-State: AOJu0Yxzy55zcW+26mDLfLIN/S+O9n/AsdNDYCruM7FmuIdiD5MMcDDG
 Z7XHK3IkmGOk0MsOFY4kdw8Xh/DUgjBFsTIju1F1Nu5Slj6DHL6chDgtvAEDS8xIfNDPl0j8Jmj
 /R6Yc2m/SgA==
X-Gm-Gg: ASbGncvKPxlZVxWmkx13poklBxcN9UVJAT6S0u4sWvNBABYYjT1zasBgEXB/5vH49Jd
 yvpqF9NNjNPOvC/4WKAEEY+YZrTeWffHMM43TM8wbTKh3MHq/qhfCQjP4Zxp9QnakAHl4LKb+qL
 baIn0U23ibBrTDd+/aSik2LoUMtUZ1upsmmwKwrsVkxmbhUL7nbtee6rgzsNJPLUwbVAfM3kP7n
 vFnMzGYb69mw/D8RyttRnEuuVQfhShGf9mjUEMAYQRVwRoirzCHPr229MGECSB3dTi7blh2
X-Google-Smtp-Source: AGHT+IGf4GU4HV7Dw4CdmL3aeoQUW3OD6ITmgK2Nwtg9LQZ4eA0ItF1w3/Dmx5NUtigABext8B1lLw==
X-Received: by 2002:a17:907:1c24:b0:aaf:c27e:12e7 with SMTP id
 a640c23a62f3a-ab2ab55985emr2397822366b.23.1736866217927; 
 Tue, 14 Jan 2025 06:50:17 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c906004fsm636850366b.30.2025.01.14.06.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 06:50:17 -0800 (PST)
Message-ID: <c9bd4bcb-8118-4433-b103-4fdc476c7344@monstr.eu>
Date: Tue, 14 Jan 2025 15:50:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] xilinx patches for v2025.04-rc1 v2
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

here are some patches I have collected so far. There is nothing significant in 
it. Just trying to clean my inbox. I am not expecting many changes for .04 anyway.

Thanks,
Michal

The following changes since commit 6a0db9ee030f634731b792d864fc7a9df6cc6b80:

   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-usb 
(2025-01-13 08:25:00 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.04-rc1-v2

for you to fetch changes up to 3a2bf24a85b2b35f1c7d6f0633d6aa528a6970b8:

   rtc: zynqmp: allow on Versal architectures (2025-01-14 15:34:51 +0100)

----------------------------------------------------------------
AMD/Xilinx changes for v2025.04-rc1 v2

Versal:
- Enable dfu support for SPI with multiboot

ZynqMP:
- Align multiboot reg description
- DT syncups
- Wire missing DTs in defconfig
- Kria: Remove usb hub initialization via commands
- Kria: Update DP reset in psu_init

AMD/Xilinx:
- Enable SPI_STACKED_PARALLEL configs

SPI/ZYNQMP_GQSPI:
- Update debug message to use log_debug()

RTC:
- Enable ZYNQMP_RTC for Versal SOCs

----------------------------------------------------------------
Ibai Erkiaga (1):
       zynqmp_gqspi: update to log_debug

Jonathan Stroud (1):
       arm64: zynqmp: Add eeprom labels for System Controller dts

Michal Simek (8):
       arm64: versal: Wire SPIs for dfu_alt_info variable generation
       arm64: versal: Support operations around multiboot register
       arm64: versal: RO multi_boot register in non JTAG bootmode
       arm64: zynqmp: Do not use hardcoded address in do_zynqmp_reboot()
       arm64: zynqmp: Sync DTs with Linux v6.13-rc1
       zynqmp: Remove usb init initialization for Kria
       xilinx: Sort OF_LIST and add missing vpk120 and zcu670 platforms
       arm64: zynqmp: Enable iio-hwmon description only for SOM

Naman Trivedi (1):
       arm64: zynqmp: add clock-output-names property in clock nodes

Neal Frager (1):
       board: zynqmp: zynqmp-sm-k26-revA: release DP from reset

Venkatesh Yadav Abbarapu (2):
       config: xilinx: Enable the SPI_STACKED_PARALLEL config option
       board: xilinx: Add missing prototype for set_dfu_alt_info

Vincent Fazio (1):
       rtc: zynqmp: allow on Versal architectures

  arch/arm/dts/zynqmp-clk-ccf.dtsi                      |  15 ++-
  arch/arm/dts/zynqmp-e-a2197-00-revA.dts               |   4 +
  arch/arm/dts/zynqmp-sc-revB.dts                       |   1 +
  arch/arm/dts/zynqmp-sm-k26-revA.dts                   |  22 +----
  arch/arm/dts/zynqmp-zcu100-revC.dts                   |   4 -
  arch/arm/dts/zynqmp-zcu102-revA.dts                   |   4 -
  arch/arm/dts/zynqmp-zcu104-revA.dts                   |   4 -
  arch/arm/dts/zynqmp-zcu104-revC.dts                   |   4 -
  arch/arm/dts/zynqmp.dtsi                              | 102 +++++++++++++++++++-
  arch/arm/mach-zynqmp/zynqmp.c                         |   2 +-
  board/xilinx/versal/board.c                           |  91 ++++++++++++++---
  board/xilinx/zynqmp/zynqmp-sm-k26-revA/psu_init_gpl.c |   2 +-
  board/xilinx/zynqmp/zynqmp_kria.env                   |  14 +--
  configs/amd_versal2_mini_qspi_defconfig               |   1 +
  configs/xilinx_versal_mini_qspi_defconfig             |   1 +
  configs/xilinx_versal_net_mini_qspi_defconfig         |   1 +
  configs/xilinx_versal_virt_defconfig                  |   1 +
  configs/xilinx_zynqmp_kria_defconfig                  |   1 +
  configs/xilinx_zynqmp_mini_qspi_defconfig             |   1 +
  configs/xilinx_zynqmp_virt_defconfig                  |   2 +-
  configs/zynq_cse_qspi_defconfig                       |   1 +
  drivers/rtc/Kconfig                                   |   2 +-
  drivers/spi/zynqmp_gqspi.c                            |   2 +-
  23 files changed, 212 insertions(+), 70 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
