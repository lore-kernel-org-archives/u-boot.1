Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3C3C52D6D
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 06:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE0A889BE;
	Tue,  6 Aug 2024 08:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="zQo+zv8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1B5A889E1; Tue,  6 Aug 2024 08:02:46 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F28889AA
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 08:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-530ad969360so448303e87.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 23:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1722924160; x=1723528960;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/2MnFUMvkVA19cj3UGi1uObTDv2jl+K3w9JH/bsZBk=;
 b=zQo+zv8lyKTV8R1qRVFGW1KYDqXAfowowclOt8HMcMjj0uhL7yyJo1IcTrrb/a2AwA
 N6civB2w5dmMEzZHV0POIVToOf5uqng8PxhuGXBFm4NjYutv25UvgzmD4Wocj6/c1GAU
 o/BaIP0TP/AHxMbRzv/h4ZS1Jwwg0lV6IJwjjpaE987pTsK3pDQajLizzVSwGkkAeuzp
 EEVs3GoseJ4o2r6yQzFY5l11QIVT1UsuITqnGvC1FixFPgqXOR5CY/qSzoerXYnMUMyN
 zrsFzO3HerjKV4xBwKj2SlKlbYRUBafYkakwWXy2L0k/T46go5pbJOQ6n9uO+vCqN6QK
 T68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722924160; x=1723528960;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a/2MnFUMvkVA19cj3UGi1uObTDv2jl+K3w9JH/bsZBk=;
 b=jreLDMDOogVIgRMjmtFNco0giYXzBeD3NIEPEWprT/G0W/yNxWF+h8ailmYhNJZXCJ
 FXLCDWDKt0hdAnCeB1F45xs/k3JbCol0SVEGBcNPajkwFb+d/4eaTyddGCLgM7m8vKT/
 h4lOkMID5r30Se/UTh+ch0L/LBlOq4FNm2I776/vIN6vHoDJe1J0myzI2VwWdR+Xczqs
 zA8nzrYX4rqCp1WsUw34yx2KYX7Jez+4fNT4d2Fj1Vn3KxI4yyuvmFMqtZs519xOs5Iz
 0GEU6MljNOkQlL83kMyYYJxLqfqmNWDfqF+O5wSNJ1tsdO5EcHH7shBOMaJXomPr22Rr
 5s2g==
X-Gm-Message-State: AOJu0YxdV2Le7Wi0CygTXm6lbVUrnPpg54k3bcmb1O+DcIf8C7oxKxp4
 hlkt9Cl9ugSLRHBEtGMZZEjL8HtVs6k0Azb4jL3aVuUtFGnWskb0Mbk/VvVDSA==
X-Google-Smtp-Source: AGHT+IFfRqvjAUIGu6v5DYqeF9KHxAiM/AeBtlYINiCbiXpdiTXlD3dtSetGZW67W23zAikNANeplQ==
X-Received: by 2002:a05:6512:eaa:b0:52e:be1f:bf8b with SMTP id
 2adb3069b0e04-530bb3d42b1mr9749609e87.47.1722924159556; 
 Mon, 05 Aug 2024 23:02:39 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b839b2b556sm5609784a12.25.2024.08.05.23.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 23:02:39 -0700 (PDT)
Message-ID: <a28e06df-b7c5-47d2-95de-aad4558d8f23@monstr.eu>
Date: Tue, 6 Aug 2024 08:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] xilinx patches for v2024.07-rc3
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

please pull these patches to your tree. I created tag yesterday and push it to 
gitlab to see issues and rc2 has been created that's why apologize that my tag 
is using rc2. There are new mini defconfigs but they can't break anything.

I am aware about one issue which is in the tree for a while. Please take a look at
https://lore.kernel.org/all/CAHTX3d+qAMKgL9T5Fo6y=rvXDiMS_mCiCEGazHt07eiVN32Fgw@mail.gmail.com/#t
but I didn't get any reaction from Simon about it yet.

Thanks,
Michal

The following changes since commit 6becf9ba1ab82af6f4fcf9f4d0da38f9c75212d2:

   Merge tag 'u-boot-imx-master-20240802' of 
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-08-02 14:40:59 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2024.10-rc2

for you to fetch changes up to 81b28310628fdfde5e4cbee7a947dad0fc717eb8:

   soc: zynqmp: Add support for zu1eg_lr device (2024-08-05 16:14:10 +0200)

----------------------------------------------------------------
AMD/Xilinx changes for v2024.10-rc2

amd/xilinx:
- Enable CONFIG_MMC_SPEED_MODE_SET

env:
- support overriding spi dev from board code

clk:
- Add set_rate support for display clocks

spi:
- Describe is25lp01gg flash

zynq:
- Add support for 7z010_lr and 7z020_lr

zynqmp:
- Add support for zu1eg_lr
- Enable NFS for Kria
- DT changes
- Cleanup firmware handling in board_init()

versal-net:
- Setup spi seq number based on boot device
- dt-schema update for mini configurations

versal2:
- Disable uartlite driver
- Add support for mini configurations
- Enable NFS

----------------------------------------------------------------
Manikanta Guntupalli (2):
       arm64: zynqmp: Add resets property for UART nodes
       arm64: zynqmp: dts: Add rts delay property for rs485 mode on KD240

Michal Simek (7):
       arm64: versal2: Remove UARTLITE from defconfig
       arm64: versal-net: Align node names with dt-schema
       arm64: versal: Remove undocumented cadence,qspi compatible
       arm64: xilinx: Describe TPM reset for Kria CCs
       arm64: zynqmp: Remove PM firmware checking
       ARM: zynq: Add support for 7z010_lr and 7z020_lr
       soc: zynqmp: Add support for zu1eg_lr device

Prasad Kummari (3):
       mtd: spi-nor: ids: Add IS25LP01GG flash support
       xilinx: Enable the NFS command for zynqmp_kria
       amd: Enable the NFS command for Versal Gen 2

Venkatesh Yadav Abbarapu (8):
       clk: zynqmp: Add set_rate support for display clocks
       config: Enable the config CONFIG_MMC_SPEED_MODE_SET
       env_spi: support overriding spi dev from board code
       xilinx: versal-net: Handle spi seq number based on boot device
       arm64: versal2: Add support for mini configuration
       arm64: Add versal2 mini qspi support
       arm64: Add versal2 mini ospi support
       arm64: config: Add versal2 mini emmc defconfig

Vishal Patel (1):
       arm64: zynqmp: Fix pwm-fan polarity

  arch/arm/dts/amd-versal2-mini.dts        | 11 +++
  arch/arm/dts/versal-mini-ospi.dtsi       |  2 +-
  arch/arm/dts/versal-net-mini-emmc.dts    |  4 +-
  arch/arm/dts/versal-net-mini-ospi.dtsi   |  4 +-
  arch/arm/dts/versal-net-mini-qspi.dtsi   |  2 +-
  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso   |  1 +
  arch/arm/dts/zynqmp-sm-k26-revA.dts      |  2 +-
  arch/arm/dts/zynqmp.dtsi                 |  2 +
  arch/arm/mach-zynq/cpu.c                 |  2 +
  board/xilinx/versal-net/board.c          | 45 +++++++++++
  board/xilinx/zynqmp/zynqmp.c             | 13 ---
  board/xilinx/zynqmp/zynqmp_kria.env      |  9 ++-
  configs/amd_versal2_mini_defconfig       | 77 ++++++++++++++++++
  configs/amd_versal2_mini_emmc_defconfig  | 69 ++++++++++++++++
  configs/amd_versal2_mini_ospi_defconfig  | 84 ++++++++++++++++++++
  configs/amd_versal2_mini_qspi_defconfig  | 79 ++++++++++++++++++
  configs/amd_versal2_virt_defconfig       |  3 +-
  configs/xilinx_versal_net_virt_defconfig |  1 +
  configs/xilinx_versal_virt_defconfig     |  1 +
  configs/xilinx_zynq_virt_defconfig       |  2 +-
  configs/xilinx_zynqmp_kria_defconfig     |  1 +
  configs/xilinx_zynqmp_virt_defconfig     |  1 +
  drivers/clk/clk_zynqmp.c                 |  1 +
  drivers/mtd/spi/spi-nor-ids.c            |  2 +
  drivers/soc/soc_xilinx_zynqmp.c          |  8 ++
  env/sf.c                                 | 12 ++-
  include/configs/amd_versal2_mini.h       | 20 +++++
  include/spi.h                            |  2 +
  include/zynqpl.h                         |  6 ++
  29 files changed, 440 insertions(+), 26 deletions(-)
  create mode 100644 arch/arm/dts/amd-versal2-mini.dts
  create mode 100644 configs/amd_versal2_mini_defconfig
  create mode 100644 configs/amd_versal2_mini_emmc_defconfig
  create mode 100644 configs/amd_versal2_mini_ospi_defconfig
  create mode 100644 configs/amd_versal2_mini_qspi_defconfig
  create mode 100644 include/configs/amd_versal2_mini.h

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
