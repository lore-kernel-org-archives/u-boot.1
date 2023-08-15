Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3D0C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4198697B;
	Tue, 15 Aug 2023 18:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VP+3XDCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F8C8698D; Tue, 15 Aug 2023 18:31:01 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F24B86940
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692117057; x=1692721857; i=xypron.glpk@gmx.de;
 bh=yUXxqdIh1Z7jssG8s+M00/rsImCFvEce2L4GDeLZojk=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=VP+3XDCag4hDWFd3iB415f3+Ud3U2xX/vkR4qu+LO0o24MqgmSZcrdcIcfUxy87Gbp3QtUa
 POy1iGwubmNGlRYGeYaEy0zpZeC7c0d4DYDNf8INSyPL9Vtk2Rhl3eOiFzdqXJuHupPsGwSJN
 x8GihZbscp7F9Dgwo9oB2UpIeh2qpWU/pfqXMXAMrdWXmOPlM3VWML7s9YgLg05dzlV2COylc
 UgGDZ/Jo+rXs/aHoYJakZyZP5unqU+E23E9ETq9VNupRLr8OCPXSJip3Y81dBCIrdF6MIeNV5
 4/A2bIWiR1QeF6vTksluZ+l6OXneRHkyNbifUnaOxCIOoQVvc0/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKu0-1qKya109Lk-00Sj8b; Tue, 15
 Aug 2023 18:30:57 +0200
Message-ID: <5e7a5766-0afd-0051-af97-d3bedf4712d2@gmx.de>
Date: Tue, 15 Aug 2023 18:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request for efi-2023-10-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UOb6fmERK4YB1hU3oRYq4qXDsZ5fnG2GK8YPDmQYl159w95U780
 anZkVcpejYvlY9OA+1Wh+7QeeYGbrdRpuYlvacp9m21VDmQ9Z37ZYPD+JnkXDt3Bshugt90
 I9Zf+Ho1SA9q0DE2xGr+6On6S2kXshVwcrh6TM3DpJle6bioPCW/4B9XosfQp8AhgtfDLtL
 srUPW5ekhl7dgOv+vsT0A==
UI-OutboundReport: notjunk:1;M01:P0:5zRJPIT/eJw=;kqir6axu+Cb4bYRId90cVYXnu9L
 01hneqcuKJIZCpHfyl8vAd8ByMAjJFRfoqOZtC3ychfyLZBveNrVqn+gBkLfk4/1jIVyR9xcW
 1ZSiDe8mevdhPJ1H+JWxwycOejk1WatGPXGKl1o2DHhJXYsa1vtoBaMuZPcuD64Hp8EYj/mc6
 Svcwc/xAaXR15g7F07LjApt9yUOl6zP3on09gisUJxfN07ewYLv5myxq4apIBFItGh4vJ9ZMd
 uCVxiAyudp6OZwRzBkTNNSFkOLIdj3cVTVMkqsdSkSzHe6/0PraKHg021OnzRoUFuyPdbrIjX
 9/X8/T0THCguhpkuZAY0EZ7GKyISELHkO9qeMJGusiUp4VAqSC87CBQhnhat8ZJXjMQU/s9eG
 hXOOXlrkOgNl20StIxkKuJCtcjquGFHmWsKfisnYcOe5M2JYLhyPv9QXpeIPq1hnD3IxFstb/
 g5z5HkZC75n41txaeoLb2ME/s4ftkcVoa5gY1wdswrPNyH+2pw+0mZyPCQzj8WbG/97oSaz2d
 8YfoPRkZwofg6GeXb3w72Jm5akErKB06NXivL03gIK/VmEDONJDA0TkY0qx6YSP3Y2ZmzIL2g
 Wpqc+SYV4zqYnhgWpitRHpZF+6nFxaW+jSqofo2/2ZN44O0codtlSgy+RgIIa+jY4KL18PeFx
 w5B3Mjk/MQCdvDV1cFAmrQ1a7BHA9Fv+y+62QXtIO/xSrqcHTX5Z9bm1DIHRRf4KaS3OfUpKN
 TOYMol6BTrQ9NL3lbYb/xvb1J4n6P/QmTKPSomZCfjzJRXFWLbSaPDUaN+27otv+BnFV4oTra
 ELLXV91HZHPlQsJSKnmjDTU/M/8V4fgnpH6VBiP5HMn+/KTjYZLhlaGNLs6iI33RvZo93rxgn
 YRkCWIOix3j+iQSJ6R8lNbDzd8KGITLMVV2MrFVA7PWI0D+B4a/oIW8DHgou3p5ulDfS61DSq
 HQ8nBX0NxHR/0H2P3hc26XTVG0Y=
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

Dear Tom,

The following changes since commit 832148f675e427060be074c276956962fa9b5cb=
6:

   Merge tag 'u-boot-rockchip-20230814' of
https://source.denx.de/u-boot/custodians/u-boot-rockchip (2023-08-14
09:11:09 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2023-10-rc3

for you to fetch changes up to d768dd88552df18d4a0527cf3d6ddd05dc072f02:

   common: return type board_get_usable_ram_top (2023-08-15 18:21:17 +0200=
)

=2D---------------------------------------------------------------
Pull request for efi-2023-10-rc3

Documentation:

* Correct description of board_get_usable_ram_top
* Add partition API to HTML documentation
* Describe  lmb_is_reserved
* doc/sphinx/requirements.txt: Bump certifi up

UEFI:

* Fix  efi_add_known_memory
* Make distro_efi_boot() static

Other:

* Correct return type board_get_usable_ram_top

=2D---------------------------------------------------------------
Bin Meng (1):
       bootmeth: efi: Make distro_efi_boot() static

Heinrich Schuchardt (5):
       lmb: description lmb_is_reserved, lmb_is_reserved_flags
       doc: description of board_get_usable_ram_top()
       doc: add partition API to HTML documentation
       efi_loader: fix efi_add_known_memory()
       common: return type board_get_usable_ram_top

Tom Rini (1):
       doc/sphinx/requirements.txt: Bump certifi up

  arch/arm/mach-imx/imx8m/soc.c           |   2 +-
  arch/arm/mach-mvebu/arm64-common.c      |   2 +-
  arch/arm/mach-rockchip/sdram.c          |   2 +-
  arch/arm/mach-stm32mp/dram_init.c       |   2 +-
  arch/arm/mach-sunxi/board.c             |   2 +-
  arch/arm/mach-tegra/board2.c            |   2 +-
  arch/mips/mach-jz47xx/jz4780/jz4780.c   |   2 +-
  arch/mips/mach-octeon/dram.c            |   2 +-
  arch/riscv/cpu/fu540/dram.c             |   2 +-
  arch/riscv/cpu/fu740/dram.c             |   2 +-
  arch/riscv/cpu/generic/dram.c           |   2 +-
  arch/riscv/cpu/jh7110/dram.c            |   2 +-
  arch/x86/cpu/broadwell/sdram.c          |   2 +-
  arch/x86/cpu/coreboot/sdram.c           |   2 +-
  arch/x86/cpu/efi/payload.c              |   2 +-
  arch/x86/cpu/efi/sdram.c                |   2 +-
  arch/x86/cpu/ivybridge/sdram.c          |   2 +-
  arch/x86/cpu/qemu/dram.c                |   2 +-
  arch/x86/cpu/quark/dram.c               |   2 +-
  arch/x86/cpu/slimbootloader/sdram.c     |   2 +-
  arch/x86/cpu/tangier/sdram.c            |   2 +-
  arch/x86/include/asm/u-boot-x86.h       |   2 +-
  arch/x86/lib/fsp1/fsp_dram.c            |   2 +-
  arch/x86/lib/fsp2/fsp_dram.c            |   2 +-
  board/broadcom/bcmns3/ns3.c             |   2 +-
  board/imgtec/boston/ddr.c               |   2 +-
  board/menlo/m53menlo/m53menlo.c         |   2 +-
  board/raspberrypi/rpi/rpi.c             |   2 +-
  board/ti/am65x/evm.c                    |   2 +-
  board/ti/j721e/evm.c                    |   2 +-
  board/ti/j721s2/evm.c                   |   2 +-
  board/toradex/verdin-am62/verdin-am62.c |   2 +-
  board/xilinx/common/board.c             |   2 +-
  boot/bootmeth_efi.c                     |   2 +-
  common/board_f.c                        |   2 +-
  doc/api/index.rst                       |   1 +
  doc/api/part.rst                        |   6 +
  doc/sphinx/requirements.txt             |   2 +-
  include/init.h                          |  17 ++-
  include/lmb.h                           |  21 +++-
  include/part.h                          | 210
+++++++++++++++++---------------
  lib/efi_loader/efi_memory.c             |   2 +-
  42 files changed, 185 insertions(+), 144 deletions(-)
  create mode 100644 doc/api/part.rst
