Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C53FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B3984150;
	Sat, 25 Apr 2026 22:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20251104.gappssmtp.com header.i=@monstr-eu.20251104.gappssmtp.com header.b="NaydSHo7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D704684178; Sat, 25 Apr 2026 22:24:42 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35A1084099
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6764e36dc88so9471112a12.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1777148679; x=1777753479;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akzVFqalptCAxvjPp3UsLlkMnq77io5GmGNeX0T6TIo=;
 b=NaydSHo7L0kxrn3tnmSnVwIM9e1ZmtMaQbJ+5zZ7VxQIM3ZiFUutDGIe3iR+85vDcz
 4wYAtE8CgIBeJ2Ij9axunKyoy0Mn0f2QY5pDWxP/yMYM6jrr5u0iOGPxQiurxMXrwuSb
 tFNvbo6zQCUJpMGM1FnUqSYV9+Vg+252G/FRUTTL4RtiEkgDf4se5/ER99Ddbn8wFpZ4
 VGryLYk0csdVYA1A/UqqgzfPkIUl1fw8C9kKT6JGfJSUD3KKj1h+LinxllMgeT0UvDmJ
 zIU3KzXmAcJknadMgwjV6zLBSXbKtv3LrBiD89iMnhqLTKJ9GIbs2UH4SstmWci4y6Di
 3isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777148679; x=1777753479;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=akzVFqalptCAxvjPp3UsLlkMnq77io5GmGNeX0T6TIo=;
 b=f81S9k2qyyFsZLWydygzeALgOxFYkAFoGv4HMUpf3JFDzJgd1H9rQhynTsA+HTD6Bu
 o2R6EiLK1xyU7igaY8YNukIS8TJN/oQi4ODuPvMaSVoKnhYWjkVnAS8qK2AfYRR9qCut
 Twq1yXwPyR2KToEzcgDfOg3vAv2azX9+bkJDa2zpakjP0f+I2iVr3z27IvC2FPhH+ije
 JF3RPD97pzj4teB3/xAlBLjngV4Rc8ZO+MwYxOs/bcuf3t6mHKKHPn1Y8W7HIfm8DooN
 mF+xfGpc7rSV0IvKOK+jDtf4UHo7CoLHyg3GlpQUMUnuyC1HhmfZLKGtIDLBNH4Cy3lO
 r1WA==
X-Gm-Message-State: AOJu0YzcVrMRN8gkCtei3Qv5zcmYLGwICepD9r5hi3hTLzKcEaEj+2u1
 lMGv5tNQ/yUB0MUDT01iduzVp51O06va8ml2cMW0ZE7g+tWLOrLM4Nl5SI/meT721c2VnDWbgxO
 Q1RDoWg==
X-Gm-Gg: AeBDieu+SqsFGRj7zOL8j0zAWppdDu4O+0Z+esfwEIDpiOJsc8PLuVCq24DR5II1aBm
 O1Io/S19p0fZQqQL6cg1u0iuQDXyDyykdtHPVpdqZIpDUApSqDn3xvNBeT/EjOx96PzggV/q6zj
 LFFbNkgQay4bhuHS/3tcbVJgdj/oDxr55LkJTOViMiEq9R0vB63eQD7Gj5DDCds4PYU1fpKV71/
 rpN9BW36rc5BkuT1S5j5CRlmdj+TO5tq8kIP/9s25WA37xhD1hhei51M/8VsxzbF1sT7LeDOjeE
 rTjD7ddyeGyQHEKPx+bbt0TeWPfeQIwW8UeKFwRdy2mYHdcjub6ChVHnfzktCZk7AGeZJBsZ0mQ
 m9IVLdhCZR2Mlwt3OS/ugD/X75TmXouVxx8aIEF0s6zyKntghSA6YdeE3FtJ5FahP9EympdFpVN
 GJvomsMDmNcoqfq1wUNi5jPRUr8wTPLeVA3lD4FNdJ8n3uTWxqTsd8qYSFEpXvMQ==
X-Received: by 2002:a17:907:9341:b0:b9e:503:5923 with SMTP id
 a640c23a62f3a-ba4229dc662mr1018998966b.30.1776950451346; 
 Thu, 23 Apr 2026 06:20:51 -0700 (PDT)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba45503c435sm655091966b.43.2026.04.23.06.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 06:20:50 -0700 (PDT)
Message-ID: <a37aad0d-34a0-48a5-8f9b-8553f11b1f16@monstr.eu>
Date: Thu, 23 Apr 2026 15:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] AMD/Xilinx changes for 2026-07-rc1 v3
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

please pull these patches to your tree. The biggest part is new pcie driver for 
Versal Gen 2 SOC. Others are small fixes and adjustments.

Thanks,
Michal

The following changes since commit e973fa5115e40f93bb1425db5b1cc1f3d9b8047d:

   cli: flush stdin before enabling cli (2026-04-22 14:23:49 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2026.07-rc1-v3

for you to fetch changes up to 9e0511261221b63458bc0d4cfd08596f5c8840d4:

   net: zynq_gem: Clear stale speed bits in NWCFG before setting new ones 
(2026-04-23 11:52:18 +0200)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.07-rc1 v3

versal2:
- Wire PCIe IP

cmd/fpga:
- Fix loadb help text guarding
- Add support for skipping fpga ID check

zynqmp:
- Describe missing devices/IDs
- Fix issue around zu63dr_SE

clk/versal:
- Fix out-of-bounds parent id for DUMMY_PARENT

net/gem:
- Add support for 10GBE
- Clear stale speed bits in NWCFG

net/axi_emac:
- Filter out broadcast and multicast packets

pci:
- Add driver for AMD PCIe IP based on DesignWare core

----------------------------------------------------------------
Michal Simek (5):
       net: xilinx: Reject broadcast and multicast packets in AXI Ethernet MAC
       soc: xilinx: zynqmp: Add support for new ZynqMP devices
       board: xilinx: zynqmp: Register alternate FPGA device for zu63dr_SE
       cmd: fpga: Fix wrong preprocessor guard for loadb help text
       fpga: xilinx: Add option to skip bitstream ID check

Padmarao Begari (1):
       clk: versal: Fix out-of-bounds parent id for DUMMY_PARENT

Pranav Sanwal (3):
       pci: Add AMD Versal2 DW PCIe host controller driver
       arm: versal2: Map PCIe DBI and config regions when PCIe is enabled
       amd: versal2: Enable PCIe/NVMe support and add NVMe boot target

Pranav Tilak (3):
       net: zynq_gem: add SPEED_10000 case in clock rate selection
       net: zynq_gem: set 128-bit AXI bus width for 10GBE
       net: zynq_gem: reinitialize RX BDs on every init

Rafał Hibner (1):
       net: zynq_gem: Clear stale speed bits in NWCFG before setting new ones

  MAINTAINERS                        |   5 +
  arch/arm/mach-versal2/cpu.c        |  18 +-
  board/xilinx/zynqmp/zynqmp.c       |  17 ++
  cmd/fpga.c                         |   2 +-
  configs/amd_versal2_virt_defconfig |   6 +
  drivers/clk/clk_versal.c           |   1 +
  drivers/fpga/xilinx.c              |   7 +-
  drivers/net/xilinx_axi_emac.c      |  20 +-
  drivers/net/zynq_gem.c             |  61 +++--
  drivers/pci/Kconfig                |  11 +
  drivers/pci/Makefile               |   1 +
  drivers/pci/pcie_dw_amd.c          | 250 ++++++++++++++++++++
  drivers/soc/soc_xilinx_zynqmp.c    |  45 ++++
  include/configs/amd_versal2.h      |   9 +-
  14 files changed, 425 insertions(+), 28 deletions(-)
  create mode 100644 drivers/pci/pcie_dw_amd.c

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
