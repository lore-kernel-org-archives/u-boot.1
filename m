Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B7EC48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 16:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34B4787E18;
	Wed, 14 Feb 2024 17:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="NT2BlGMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 919C187E07; Wed, 14 Feb 2024 17:00:06 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E07587DD0
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 17:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55ee686b5d5so7614941a12.0
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 08:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1707926395; x=1708531195;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOknemz5GA0vvp2rNtpuPab2p4Gc60yYXzcWY94SYCI=;
 b=NT2BlGMXVUK/A05vdFpHSH9FHNIbhP5CJ5vEvRmTMWxSZPloRflnzYSjKmBj5Fd3Nv
 6t5pI3oBBSc0Bzintst8sDC+Au/2gYi0WBIebltsodZhDUfFApy+oKWXBS0TRBy0BfNc
 43J8lKwqBIk5pChAtlt3d3qqwakm1J7wZBLesTyY9cFIQRZWbvDJWCPRq7eedkPD7fGX
 3DkNg5P6B/Nph57579FbHFiAxGp1Np3ihlLUvh2pGeBvWkg06XFO+8y49JIhm0CaNDpf
 qbv9VZF782p0sQ8t/BJkbSvRoqOYWZxxN10W8/7mjtCkwXag5OJUqKFYlxyN0+V7Uk7O
 g+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707926395; x=1708531195;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZOknemz5GA0vvp2rNtpuPab2p4Gc60yYXzcWY94SYCI=;
 b=RBB5aiTprd3Dh8K85IZcNL1RD3p9JR7DzxsPqSIh4YxSJLl7XgvPQ0puwKUPjv+DL6
 dE1Kxb4n6dYc45057v9de9B0PD58nQC59sklGJwbxwXNbAunaRK7GX7wmorqbBT9X/tw
 GNyRAuyjGg4mpCyMyHwSp6sbPVdlQEXkPIsjZGuGBMLBfmtaQyvSlLyFEbpMjaypmIv2
 m1jewdceS2Wg5dBhyXeyctX6kiWGlhXTwZapiC9cNYDI9H7vRvyJXhonk7Of9AUrr1jU
 geXE9bKg8QOn6OtZDkGAdxnd5cUNXa4iwkLaf1BmqhBMBnXc7GM6bL2J4s5OMVaAB/yA
 EfBA==
X-Gm-Message-State: AOJu0YwdME6ooV7WiJLaoY5g5E7vT/VPNixt+QmQpRI+mipnq+sWRYWj
 +VL/mqtoXNc/VYODRUcn6MZvtQD7XW9UlDcFiw5dLUZxBCBK6wuYRZTR4CdC4sjrc/qkshTjAKK
 DAUTD
X-Google-Smtp-Source: AGHT+IFZ5jNpCn11tJZHcw49l327VjTFrSdhDDpE9ID7tBo7Vjjpetk6EsjbNFOiaErnf3HmIMRmeQ==
X-Received: by 2002:aa7:d4cd:0:b0:55f:fd10:5e73 with SMTP id
 t13-20020aa7d4cd000000b0055ffd105e73mr2526870edr.20.1707926395378; 
 Wed, 14 Feb 2024 07:59:55 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a056402401400b00561c666991csm2654446eda.73.2024.02.14.07.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 07:59:54 -0800 (PST)
Message-ID: <ff2b2845-9520-4264-bc49-72075736d3b4@monstr.eu>
Date: Wed, 14 Feb 2024 16:59:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] xilinx patches for v2024.04-rc3
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

please pull these patches to your branch. Most of them are related to device 
tree and aligning with the latest dt schema for SR certification.
CI is not reporting any issue too.

Thanks,
Michal


The following changes since commit e8f2404e093daf6cc3ac2b3233e3c6770d13e371:

   Merge branch 'master-779h0-r2' of 
https://source.denx.de/u-boot/custodians/u-boot-sh (2024-02-11 12:42:25 -0500)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2024.04-rc3

for you to fetch changes up to c2ad5fb616d4e8aa2ac00e224030589847731fbe:

   arm64: versal-net: Setup correct addresses of GICR/GICD (2024-02-14 11:23:43 
+0100)

----------------------------------------------------------------
Xilinx changes for v2024.04-rc3

zynqmp:
- Cover missing _SE chip variants to fix fpga programming

versal:
- Enable LTO for mini configurations

versal-net:
- Enable LTO for mini configurations
- Fix GIC address to aligned with real silicon

xilinx:
- DTs cleanup and fixups
- Enable HTTP boot
- Add missing spl header to zynqmp.c

----------------------------------------------------------------
Michal Simek (10):
       arm64: xilinx: Enable EFI_HTTP_BOOT by default
       arm64: zynqmp: Sync clock labels with kr260 revB
       arm64: zynqmp: Describe 25MHz fixed clock for PL GEMs
       arm64: zynqmp: Fix kr260 clock wiring
       xilinx: Fix fpga region DT nodes name
       arm64: zynqmp: Remove arm,cortex-a53-edac node
       arm64: zynqmp: Align nvmem-fw node with dt-schema
       arm64: zynqmp: Do not expose usbhub nodes on kr260 usb1
       arm64: zynqmp: Disable DP on kd240
       arm64: versal-net: Setup correct addresses of GICR/GICD

Saeed Nowshadi (1):
       arm64: zynqmp: Add 'silabs, skip-recall' to all si570 clk nodes

Venkatesh Yadav Abbarapu (4):
       soc: zynqmp: Add the IDcode for dr_SE and eg_SE variants
       configs: versal: Enable CONFIG_LTO for mini qspi/ospi
       configs: versal_net: Enable CONFIG_LTO for mini qspi/ospi
       xilinx: zynqmp: Add the missing function prototype

  arch/arm/dts/zynq-7000.dtsi                   |   2 +-
  arch/arm/dts/zynqmp-e-a2197-00-revA.dts       |   5 +
  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso        |  16 +++
  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso        |  25 ++--
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso        |   8 ++
  arch/arm/dts/zynqmp.dtsi                      | 131 ++++++++++----------
  board/xilinx/zynqmp/zynqmp.c                  |   1 +
  configs/xilinx_versal_mini_ospi_defconfig     |   1 +
  configs/xilinx_versal_mini_qspi_defconfig     |   1 +
  configs/xilinx_versal_net_mini_ospi_defconfig |   1 +
  configs/xilinx_versal_net_mini_qspi_defconfig |   1 +
  configs/xilinx_versal_net_virt_defconfig      |   1 +
  configs/xilinx_versal_virt_defconfig          |   1 +
  configs/xilinx_zynqmp_kria_defconfig          |   1 +
  configs/xilinx_zynqmp_virt_defconfig          |   1 +
  drivers/soc/soc_xilinx_zynqmp.c               |  28 ++++-
  include/configs/xilinx_versal_net.h           |   4 +-
  17 files changed, 149 insertions(+), 79 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
