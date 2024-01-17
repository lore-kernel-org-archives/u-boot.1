Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AF0C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 13:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7835E879C4;
	Wed, 17 Jan 2024 14:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="A5CG77iw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59AAE86FB0; Wed, 17 Jan 2024 14:53:46 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFFF6879C4
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 14:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a2d6ded84fcso322481066b.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 05:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1705499623; x=1706104423;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uruGiBeBvvJzXEGBV/w6rRqdh7RopYGwVYPFOHZXWyU=;
 b=A5CG77iwkuDNypMuDxiPprLVTkY85yLu2NNGOzlQJVvGY0eKkFRoUXc+j0BOUiBoZB
 yA1Cn/BIalI5LT2CQLrHGslax5ouvSp9JxR1F9/LHXS28kjv7IXTUAkYuHuiv4C1E5hb
 TC6/pc6k2SQkUjoYrap7UXjGUgAfiwTu5N/NX9ane9GHGe/MQIIoayFdfnAC2r1a3daL
 1flwAjSrNLn6+1gPfev4LLZoIVZ2zQkzo6CyEGGG9q8/GbMJ9THs5+edweE9GI33hHDP
 N8S5t9MsaY+VsC5P+m0H9fc2xsVPGudpsGlYhNBFxe4CHNaLqJx/nJLHdVorpXWHL/SQ
 itQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705499623; x=1706104423;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uruGiBeBvvJzXEGBV/w6rRqdh7RopYGwVYPFOHZXWyU=;
 b=wOcQDoBWomUR9NMsBkBBJ89IX3he+HP6IV1uQJnoGbC9R58cEJ7cM0802XdtxXjPq3
 3k0ZF5YS7uDK9AE8gtERAL5IDcqXRtgB4hcaSzCTYBGJWLLtIb2kCqgeUo+mvp1sdY9U
 e/4W6HUmZL0w1tB2TskDT8B0Fr2+zg4uKAOD0xMsYCPRFjrhtAFjNkSkqC0w+aHuJJM2
 Td+20Ng+exb3UHQciu8/3rEZ2+hNjBnnOYx5WjOPQR2luJFRLOLx+I4Up5d3lodHPpVx
 iJ51tCYNcmKSmoGPOtox0Myj7zMd7MVrOawMKzEosYChvW1M8juHOPHQy0bb72ePxW1p
 mC7w==
X-Gm-Message-State: AOJu0Yzvh9CF9i5b7PdxX7/pn9p52LQUDDyR5RldIGkcbHUOCJb6Ds9n
 nxogMnZRJwcJp68jBYHsvpvY8qKJz9ZzNT049/+3jW3Eq8Y6
X-Google-Smtp-Source: AGHT+IGClGfB94hHFFnZSmJIhGBM6UykyE5yjhRmWHL33tu2oUfOx6EAMqSf5vDlornh2bq3CSwvew==
X-Received: by 2002:a17:906:2804:b0:a27:c8da:a0f9 with SMTP id
 r4-20020a170906280400b00a27c8daa0f9mr3957371ejc.153.1705499623179; 
 Wed, 17 Jan 2024 05:53:43 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a13-20020a170906274d00b00a2b608ad048sm7794322ejd.28.2024.01.17.05.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 05:53:42 -0800 (PST)
Message-ID: <02d7eee4-f480-4abd-9610-3ccff08c268e@monstr.eu>
Date: Wed, 17 Jan 2024 14:53:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] xilinx patches for v2024.04-rc1-v2
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

please pull these patches to your tree. They are mostly targeting DT for fixing 
issues against DT schema and SR IR certification. I can't see any issue from 
buildman or Gitlab CI.

Thanks,
Michal

The following changes since commit c5e461fbf7cc72f0c1c8a79226b6a5170e56cb4d:

   Merge tag 'u-boot-imx-master-20240108' of 
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-01-08 13:39:43 -0500)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2024.04-rc1-v2

for you to fetch changes up to 0a4595b538cc601563e828270ca822720c6eb6fe:

   configs: zynqmp_kria: Enable CONFIG_OF_BOARD_SETUP (2024-01-17 08:12:21 +0100)

----------------------------------------------------------------
Xilinx changes for v2024.04-rc1-v2

xilinx:
- Enable NFS, WGET, DNS and BLKMAP by default

zynqmp:
- Support new power-management node
- Remove multiple blank lines from DTSes
- Wire multiboot with DFU infrastructure
- Fix i2c-gpio pinctrl group name
- SOM DT changes (phy on kd240, kv260 cleanups
- Cleanup i2c bus on zcu1285
- DT cleanup (fix node names not to use _)
- Fix USB interrupts
- Cleanup zcu100 DT
- Add support for kaslr-seed

zynqmp_r5:
- Fix W=1 issue with missing dir

tools:
- Improve zynqmpimage mkimage support

----------------------------------------------------------------
Brandon Maier (4):
       tools: zynqmpimage: show info on partition 0
       tools: zynqmpimage: print all partition sizes
       tools: zynqmpimage: add partition extracting
       tools: zynqmpimage: print partition names

Michal Simek (17):
       xilinx: Enable DNS/WGET and BLKMAP for http boot
       arm64: zynqmp: Describe ethernet phy on kd240
       arm64: zynqmp: Fix i2c bus for kd240
       arm64: zynqmp: Generate dfu_alt_info based on multiboot register
       arm64: zynqmp: Move fixed clock to / for kv260
       arm64: zynqmp: Fix clock node name in kv260 cards
       arm64: zynqmp: Remove mt25qu512a compatible string from SOM
       arm64: zynqmp: Rename i2c?-gpio to i2c?-gpio-grp
       arm64: zynqmp: Describe interrupt by using macro (OCM)
       arm64: zynqmp: Add missing description for efuse aeskey/pufuser
       arm64: xilinx: Remove multiple blank lines from DTSes
       arm64: zynqmp: Replace '-' by '_' in fixed clock nodes
       arm64: zynqmp: Add support for new power-management node name
       arm64: zynqmp: Match dwc3 interrupts description with values
       arm64: zynqmp: Rename zynqmp-power node to power-management
       arm64: zynqmp: Remove ltc2954 node
       arm64: zynqmp: Start TPM automatically via preboot on Kria

Shubhrajyoti Datta (1):
       arm64: zynqmp: Update the i2c0 node for zcu1285

Tejas Bhumkar (1):
       xilinx: Enable the NFS command by default

Venkatesh Yadav Abbarapu (3):
       xilinx: r5: Include the sys_r5_proto.h header for future use
       xilinx: board: Update the kaslr-seed property
       configs: zynqmp_kria: Enable CONFIG_OF_BOARD_SETUP

  arch/arm/dts/zynq-zc702.dts                         |   2 +-
  arch/arm/dts/zynqmp-dlc21-revA.dts                  |   5 +-
  arch/arm/dts/zynqmp-e-a2197-00-revA.dts             |   2 +-
  arch/arm/dts/zynqmp-mini-emmc0.dts                  |   2 +-
  arch/arm/dts/zynqmp-mini-emmc1.dts                  |   2 +-
  arch/arm/dts/zynqmp-mini-qspi.dts                   |   2 +-
  arch/arm/dts/zynqmp-p-a2197-00-revA.dts             |   4 +-
  arch/arm/dts/zynqmp-sc-revB.dts                     |   6 +-
  arch/arm/dts/zynqmp-sc-vpk120-revB.dtso             |   1 -
  arch/arm/dts/zynqmp-sc-vpk180-revA.dtso             |   1 -
  arch/arm/dts/zynqmp-sc-vpk180-revB.dtso             |   1 -
  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso              |   4 +-
  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso              |  14 +-
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso              |   2 +-
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso              |  52 +++---
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso              |  54 +++---
  arch/arm/dts/zynqmp-sm-k26-revA.dts                 |   2 +-
  arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts          |  10 +-
  arch/arm/dts/zynqmp-vpk120-revA.dts                 |  10 +-
  arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts            |   2 +-
  arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts            |   2 +-
  arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts            |   4 +-
  arch/arm/dts/zynqmp-zcu100-revC.dts                 |  11 +-
  arch/arm/dts/zynqmp-zcu102-revA.dts                 |   4 +-
  arch/arm/dts/zynqmp-zcu104-revA.dts                 |   2 +-
  arch/arm/dts/zynqmp-zcu104-revC.dts                 |   2 +-
  arch/arm/dts/zynqmp-zcu106-revA.dts                 |   4 +-
  arch/arm/dts/zynqmp-zcu111-revA.dts                 |   4 +-
  arch/arm/dts/zynqmp-zcu1285-revA.dts                | 174 --------------------
  arch/arm/dts/zynqmp-zcu208-revA.dts                 |   4 +-
  arch/arm/dts/zynqmp-zcu216-revA.dts                 |   4 +-
  arch/arm/dts/zynqmp-zcu670-revA.dts                 |   6 +-
  arch/arm/dts/zynqmp-zcu670-revB.dts                 |   6 +-
  arch/arm/dts/zynqmp.dtsi                            |  14 +-
  arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h |   5 +
  board/xilinx/common/board.c                         |  49 ++++++
  board/xilinx/zynqmp/zynqmp.c                        |  11 +-
  board/xilinx/zynqmp/zynqmp_kria.env                 |   7 +-
  configs/xilinx_versal_net_virt_defconfig            |   4 +
  configs/xilinx_versal_virt_defconfig                |   4 +
  configs/xilinx_zynq_virt_defconfig                  |   1 +
  configs/xilinx_zynqmp_kria_defconfig                |   1 +
  configs/xilinx_zynqmp_virt_defconfig                |   5 +
  tools/zynqmpimage.c                                 | 113 ++++++++++---
  tools/zynqmpimage.h                                 | 107 ++++++++++++
  45 files changed, 398 insertions(+), 328 deletions(-)
  create mode 100644 arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
