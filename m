Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AEFC02198
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 07:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE9F80562;
	Thu,  6 Feb 2025 08:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="LjzZlgQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EC80806FB; Thu,  6 Feb 2025 08:57:45 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB0980104
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 08:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ab751a7f67bso84801166b.1
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 23:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1738828663; x=1739433463;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+NVGHxvFdxOrPHbmmoAwJ87IHQrL1GW/2pVGP4gORg=;
 b=LjzZlgQXjtO6DXMCPEZActHEkp8XX/28ZBy3kKhWsLND2yahkX+ZZ+vKAuYCcMEVXB
 tISHdZCSrdDIRCI5bAGTT6dgDsvtt5113gVAqKp0wp5504Z0tCB0TLqk+Rr3SebJyAsk
 g/gJtvtrOfO7x4GRf4oE2EAePmJVUQ67jL75rDP7XjaWV4V0gL4ZUln+MC95811H4Lrj
 xuLrv9C8EZgibOmBAZsdzzwwTeYwEbhBd+re1wekcDFhWLDcs4zgWzo8r3UzkYmQvEt/
 /qRH3kbRnMWl3embKMeaExfg//gE1CIOiYpReJ1wn8RUC7Y3EDYQIyASQ1JBTb/BBeNS
 tPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738828663; x=1739433463;
 h=content-transfer-encoding:cc:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U+NVGHxvFdxOrPHbmmoAwJ87IHQrL1GW/2pVGP4gORg=;
 b=Gs4lOeHz8j8sxL5QrSU/cI3MzVMyMPVYd/v98Vkx2lsfC74QZd4Yh7NQsENjugR12u
 nduPKC5+PNAz0k5pPonu0WKvdQRRckAOd4gUVd2XmqoRw/JEB7BwRMfZ1R5ySdIFy8fM
 iugUykuD1Fye3elXbnGXsT6Z12tsZNbw666ncRKqhjEVn5H+iSZzU+g7lBRaLPVQMmAb
 F3ooKjOeFrwLEAbVYl6E9JgSgPQZt4H1prsCgn0Bo4vaigqRjSclo/Psv6oXdze+R6EK
 ivHyq1ePfQNQ/gRVELePoHUL6uBNItoBVHXlfO85RIjWsYbg5LpBFTFHducBYQn62ijG
 HsFQ==
X-Gm-Message-State: AOJu0YyjqYVuyHWYA3MCdROLFtTikwBom2+9Xd8wPf8rSTu1ebdBQRlD
 /NknlEC+Sioy8aluYSq+S3FL83fpPRjqo4glIwmFYjFmEF02ywoeM/qTnEgO5w==
X-Gm-Gg: ASbGnctDiAzCpPfXyBCB+dtabS7nqPDaKvpHDcEUVfcFxnzwZTG68K8YR18769NWTNP
 arWEK1L8z2HtoiNwXpsEuMQfFuDjJmSySSfJZ+cGCBR8tZB/JgpDiefdXfnNH3XbjL3Icb7xSVx
 ckqUXXHWSpj+6DZh9nGT9VRgxHFYKzqQbgMn3aUgGRBtv7h+YOzbBI+6p9efgH+g2AlwJCBXkVP
 TLCsK/U16WAhrK73hSwkoK52EVYpLktlBuAlWfr6KhDzyDhoqGsmcKqkysYOrxfnCNvziGYJzJI
 M+IdQtMYM3nyrpZdmt0ugSbMRvy0HBE=
X-Google-Smtp-Source: AGHT+IFT7AshvnpMOdkpJbxIvuvMJABljSPQSYVcE4ixpWMIQo9ALQC+29uL2dlBvYRO5B5HnFYHLw==
X-Received: by 2002:a17:907:60cc:b0:ab3:a4f6:7549 with SMTP id
 a640c23a62f3a-ab75e2fc28amr616922666b.45.1738828662598; 
 Wed, 05 Feb 2025 23:57:42 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7732e7173sm57463566b.111.2025.02.05.23.57.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 23:57:42 -0800 (PST)
Message-ID: <08076b31-b5e6-4321-af5f-0d59b559e21f@monstr.eu>
Date: Thu, 6 Feb 2025 08:57:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] amd/xilinx patches for v2025.04-rc2
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

please pull these patches to your tree. Nothing really significant there. Some 
binman fixes which were not spot before and switching our platform to LWIP to 
have cover it better.

Thanks,
Michal


The following changes since commit 97c125e6bb441a8062bdd28e82f17b1da1224416:

   Gitlab: Add results.xml to the list of artifacts as well. (2025-02-04 
11:57:36 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.04-rc2

for you to fetch changes up to 0f019056b2d23aaa839fab31c016d73009870a23:

   zynqmp: Save "bootseq" environment variable in decimal format (2025-02-05 
16:22:55 +0100)

----------------------------------------------------------------
AMD/Xilinx changes for v2025.04-rc2

fpga:
- Cleanup help
- Show xilinx only options on Xilinx devices

ospi-versal:
- Fix alignment issue
- Fix cadence_qspi_flash_reset() prototype

zynqmp:
- Define usb_pgood_delay
- Fix bootseq number

versal:
- Fix mini_ospi configuration

versal2:
- Enable OPTEE

xilinx:
- Enable some flashes
- Clean up SYS_MALLOC_F_LEN Kconfig
- Some binman fixes
- DT updates
- Enable mkfwumdata compilation
- Enable meminfo command
- Switch to LWIP and enable HTTPS

----------------------------------------------------------------
Alexander Dahl (1):
       fpga: Avoid ignored-qualifiers warning

Benjamin Szőke (1):
       zynqmp: Save "bootseq" environment variable in decimal format

Ibai Erkiaga (5):
       fpga: fix alignment on fpga cmd usage info
       fpga: improve loads usage information
       fpga: resort fpga commands
       fpga: xilinx exclusive commands
       fpga: add new symbol for fpga_loadb

Michal Simek (9):
       xilinx: Remove SYS_MALLOC_F_LEN setup via board Kconfig
       arm64: zynqmp: Describe ethernet controllers via aliases on SOM
       xilinx: Enable mkfwumdata tool for a/b update
       xilinx: Enable meminfo command with mapping
       xilinx: Enable MBEDTLS/LWIP/WGET and WGET_HTTPS
       fpga: Make do_fpga_loads() static
       arm64: zynqmp: Fix TEE loading address and add hash
       arm64: zynqmp: Use DTB address base from .config
       arm64: zynqmp: Describe images without TF-A

Padmarao Begari (2):
       spi: cadence_qspi: Fix OSPI DDR mode alignment issue
       configs: versal: update initial stack pointer

Prasad Kummari (2):
       configs: zynqmp: Add usb_pgood_delay for SOM boards
       arm64: zynqmp: enable u-boot itb generation via binman if SPL is enabled

Venkatesh Yadav Abbarapu (3):
       xilinx: Enable support for Infineon Octal flashes
       arm64: versal2: Enable the OPTEE command
       spi: cadence_qspi: Add missing prototype for cadence_qspi_flash_reset

  arch/arm/dts/zynqmp-binman-som.dts        | 19 +++++-
  arch/arm/dts/zynqmp-binman.dts            | 39 ++++++++----
  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso    |  4 ++
  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso    |  5 ++
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso    |  4 ++
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso    |  4 ++
  arch/arm/mach-zynq/Kconfig                |  3 -
  arch/arm/mach-zynqmp-r5/Kconfig           |  3 -
  arch/arm/mach-zynqmp/Kconfig              |  3 -
  board/xilinx/zynqmp/zynqmp.c              |  2 +-
  board/xilinx/zynqmp/zynqmp_kria.env       |  1 +
  cmd/Kconfig                               | 35 ++++++-----
  cmd/fpga.c                                | 65 +++++++++-----------
  configs/amd_versal2_virt_defconfig        | 15 ++---
  configs/microblaze-generic_defconfig      |  2 +
  configs/xilinx_versal_mini_ospi_defconfig |  2 +-
  configs/xilinx_versal_net_virt_defconfig  | 13 ++--
  configs/xilinx_versal_virt_defconfig      | 14 ++---
  configs/xilinx_zynq_virt_defconfig        |  9 ++-
  configs/xilinx_zynqmp_kria_defconfig      | 17 ++---
  configs/xilinx_zynqmp_virt_defconfig      | 20 ++----
  drivers/fpga/fpga.c                       | 14 ++---
  drivers/spi/cadence_ospi_versal.c         | 12 ++++
  drivers/spi/cadence_qspi.h                |  2 +-
  include/configs/xilinx_zynqmp.h           |  1 +
  include/fpga.h                            |  6 +-
  26 files changed, 177 insertions(+), 137 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
