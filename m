Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9512BCF9C69
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 11:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF96888CA3;
	Mon, 23 Sep 2024 13:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="y7tOr7jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF3F88CBA; Mon, 23 Sep 2024 13:54:33 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C6E88C91
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 13:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8a6d1766a7so600580666b.3
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1727092471; x=1727697271;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WeLK2FQ9r5nSHjtGiNBiIkYFGi9NKjAWSx9v9GovrDg=;
 b=y7tOr7jwQ7UJk27rZID+2E+5OLK+7ZkIjPoUhVVEF3UmfrOkziP3KQCbs6Qc5fwouO
 qb4WG6+2v+x80a9le8ZV/C/v8zqISEPd6cLl5KmDQImV7bBrnxmfVUO7Z9PKpj0V0/YV
 bJfCNbG7YrUBPHdIF7nohViFSGGLQLoZWQbeC5K2qz2Kn2UIBMHR7NDr2aDxjf/XG/AP
 XPStlwR+ipOvjWUezDdHr5b0+hwufL/dpiGS0jtk4KRtoITzUNSLcw3qGk/zUQ2Mi1pK
 qBO6m+vUhlwY+kxxrghwaRP9EMZj5i0SxPtlO8LPqlCZuQz6elLfPrwZ1T2Ka75B9Ds2
 H8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727092471; x=1727697271;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WeLK2FQ9r5nSHjtGiNBiIkYFGi9NKjAWSx9v9GovrDg=;
 b=C2LczrC/KwvvzVgNv4qPH064IatbQM5jK+mXuLbPCpnpMEmu7oGODAEUestMCpvy+j
 JBi7278oyZnimS7hXbfpmsiGLmLrXu9M7gwrxZ9hP0Eo/sPKr4acOVAX/UzjAzrBj1JE
 FbcEXfR5APJYHiGrLrEW17HYoHZGMWCG5GzBkhK1yqmFdMUa8CLeYM8urImL02cePbIz
 cFW+cBT7x37khw4pehlAJVr6dKEwaI+P69Du07EwBPcroyw4fa8Ix9XznbLIULiq07Kh
 ekT5yP3CmURZGYYN2lFdqAqZlH5IGihNJoDrMJNt3+LCErtxgm9S7DJ/Tz0cHiCdFNQt
 UJSA==
X-Gm-Message-State: AOJu0YznMs4ZohacI+Zo2aJHWlcXvhd8jzEa0f2YtXIEIuVLsVUufT1H
 PBeJc+uLJ69nSkq2v8vcB6mdknW+sggKARGPsy4UTdb/sjrI5r38WJwnwOponJjiQjGiZFvKEhY
 I6lyo
X-Google-Smtp-Source: AGHT+IFQH91II1AOoByvTDooZCYoAraZYc0y9x3OVZOioLy3v54c/EmJAToLjuwbppylYemeGf07Hw==
X-Received: by 2002:a17:907:f786:b0:a8a:7897:c043 with SMTP id
 a640c23a62f3a-a90d50ee840mr1057151466b.43.1727092470787; 
 Mon, 23 Sep 2024 04:54:30 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612e5675sm1210911866b.169.2024.09.23.04.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2024 04:54:30 -0700 (PDT)
Message-ID: <2a5d1c10-f5ed-4d13-aacb-280c7a3a6180@monstr.eu>
Date: Mon, 23 Sep 2024 13:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] xilinx patches for v2025.01-rc1
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

please pull these patches to your tree. Most of them are related to dt-schema 
and it's alignment.
But the most useful one is work done Prasad for being able to apply DT overlays 
via Makefile rules. The rest are just small fixes.

Thanks,
Michal

The following changes since commit 948616894c6d3316a5ac8f2a891783e3e7ff3516:

   mtd: spi-nor: scale up timeout for full-chip erase (2024-09-19 16:42:31 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.01-rc1

for you to fetch changes up to 61bf0fa8663d85c5d4088a9f82c9244181f3adce:

   xilinx: zynqmp: Add bootmenu support (2024-09-20 15:33:01 +0200)

----------------------------------------------------------------
AMD/Xilinx changes for v2025.01-rc1

kbuild:
- Add rules for automatically applying DT overlays

Microblaze:
- Enable bootscript location via DT

AMD/Xilinx
- Enable SIMPLE_PM_BUS by default

ZynqMP:
- DT updates and alignments with dt-schema
- Call fdtoverlay via make directly
- Enable non-invasive CCI-400 PMU debug
- Disable secure access for boot devices
- Add new zynqmp reboot command

Versal NET:
- Cleanup spi_get_env_dev()

Kria:
- Add bootmenu support

sdhci:
- Do not call device_is_compatible everywhere

net:
- Remove is-internal-pcspma DT flag

----------------------------------------------------------------
John Vicky Vykuntapu (1):
       xilinx: zynqmp: Add bootmenu support

Michal Simek (14):
       xilinx: Enable SIMPLE_PM_BUS
       arm64: zynqmp: Add missing vc7_xin fixed clock to sc-vpk180-revA
       net: gem: Remove undocumented is-internal-pcspma dt flag
       arm64: zynqmp: Define only one revision in zcu106-rev1.0
       arm64: zynqmp: Fix status property for m-a2197 boards
       arm64: zynqmp: Align gpio hogs with dt-schema
       xilinx: Fix axi and mmc node names in mini configuration
       arm64: zynqmp: Fix gpio-line-name size for m-a2197 platforms
       arm64: zynqmp: Fix comment style around gpio line-names
       arm64: zynqmp: fix i2c mux bus description for m-a2197 platforms
       arm64: zynqmp: Align mini-qspi DT with dt-schema
       arm64: zynqmp: Define phy-mode in zcu1275-revB
       arm64: zynqmp: Use generic spi@ name in zcu111-revA
       arm64: zynqmp: Rename ina226-vccint-io-bram-ps nodes

Padmarao Begari (2):
       mmc: zynq_sdhci: Remove device_is_compatible() function
       board: xilinx: Remove conditional check for Microblaze

Prasad Kummari (4):
       xilinx: versal-net: fix no previous prototype for function warning.
       arm64: zynqmp: Add u-boot command to boot into recovery image
       kbuild: cherry-pick kbuild fdtoverlay changes from linux
       arm64: zynqmp: Remove overlays and add new dtb entries for ZynqMP

Sean Anderson (2):
       zynqmp: Disable secure access for boot devices
       arm: zynqmp: Enable non-invasive CCI-400 PMU debug

  arch/arm/dts/Makefile                                  | 78 +++++++++++++++-----
  arch/arm/dts/versal-mini-emmc0.dts                     |  2 +-
  arch/arm/dts/versal-mini-emmc1.dts                     |  2 +-
  arch/arm/dts/versal-mini-ospi.dtsi                     |  2 +-
  arch/arm/dts/versal-mini-qspi.dtsi                     |  2 +-
  arch/arm/dts/zynq-cse-nand.dts                         |  2 +-
  arch/arm/dts/zynq-cse-nor.dts                          |  2 +-
  arch/arm/dts/zynq-cse-qspi.dtsi                        |  2 +-
  arch/arm/dts/zynqmp-dlc21-revA.dts                     |  3 +-
  arch/arm/dts/zynqmp-e-a2197-00-revA.dts                |  1 -
  arch/arm/dts/zynqmp-g-a2197-00-revA.dts                |  3 +-
  arch/arm/dts/zynqmp-m-a2197-01-revA.dts                | 16 ++--
  arch/arm/dts/zynqmp-m-a2197-02-revA.dts                | 16 ++--
  arch/arm/dts/zynqmp-m-a2197-03-revA.dts                | 16 ++--
  arch/arm/dts/zynqmp-mini-emmc0.dts                     |  4 +-
  arch/arm/dts/zynqmp-mini-emmc1.dts                     |  4 +-
  arch/arm/dts/zynqmp-mini-nand.dts                      |  2 +-
  arch/arm/dts/zynqmp-mini-qspi.dts                      | 16 ++--
  arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso |  8 +-
  arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso |  8 +-
  arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso |  8 +-
  arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso |  8 +-
  arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso |  8 +-
  arch/arm/dts/zynqmp-p-a2197-00-revA.dts                | 11 ++-
  arch/arm/dts/zynqmp-sc-revB.dts                        |  2 +-
  arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso         |  8 +-
  arch/arm/dts/zynqmp-sc-vpk180-revA.dtso                |  6 ++
  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso                 |  1 -
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso                 |  1 -
  arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts             |  1 -
  arch/arm/dts/zynqmp-vpk120-revA.dts                    |  1 -
  arch/arm/dts/zynqmp-zcu106-rev1.0.dts                  |  2 +-
  arch/arm/dts/zynqmp-zcu111-revA.dts                    |  2 +-
  arch/arm/dts/zynqmp-zcu1275-revB.dts                   |  1 +
  arch/arm/dts/zynqmp-zcu208-revA.dts                    |  4 +-
  arch/arm/dts/zynqmp-zcu216-revA.dts                    |  4 +-
  arch/arm/dts/zynqmp-zcu670-revA.dts                    |  2 +-
  arch/arm/dts/zynqmp-zcu670-revB.dts                    |  2 +-
  arch/arm/mach-zynqmp/include/mach/hardware.h           | 11 ++-
  arch/arm/mach-zynqmp/zynqmp.c                          | 26 +++++++
  board/xilinx/common/board.c                            | 39 +++++-----
  board/xilinx/versal-net/board.c                        |  5 +-
  board/xilinx/zynqmp/zynqmp.c                           |  8 ++
  board/xilinx/zynqmp/zynqmp_kria.env                    | 12 ++-
  configs/amd_versal2_virt_defconfig                     |  1 +
  configs/xilinx_versal_net_virt_defconfig               |  1 +
  configs/xilinx_versal_virt_defconfig                   |  1 +
  configs/xilinx_zynq_virt_defconfig                     |  2 +
  configs/xilinx_zynqmp_kria_defconfig                   |  1 +
  configs/xilinx_zynqmp_virt_defconfig                   |  1 +
  drivers/mmc/zynq_sdhci.c                               | 39 ++++++----
  drivers/net/zynq_gem.c                                 |  9 +--
  scripts/Kbuild.include                                 |  4 +
  scripts/Makefile.build                                 |  1 +
  scripts/Makefile.lib                                   | 27 +++++++
  55 files changed, 293 insertions(+), 156 deletions(-)


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
