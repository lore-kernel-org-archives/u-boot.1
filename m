Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ED8C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 779E786BA4;
	Mon, 16 Oct 2023 16:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697467836;
	bh=SFQcx5YxVunuswRMwKIsL4iDX+Gai5CHseHoWlOx1yw=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tBFMklUCoMWGutRzHJzTcbT9tP/SyRhaDqkr1jizwC7oxl4niFU+GFYQxRVLS6Rjw
	 YnGXdXMlJuHGwRmGXuZcnkuCIz7DbecVoRgPpP5e/gQmXTYQpF+vzztqi39o/8gFPh
	 thc5bj3GGtuG07yuoXsuDjS8/eF7JkJwDmjayFjIUt3xv8VX0DmTd32gDy/yGNtnDB
	 lzHPACGtBqa+iqUFgrVaKotIwKQpskHR5fmYrPOSqodfFHO9igR4vqMsjz5tzuhgNv
	 6wN+RPcvCNBJvwLMT8bKUjgvQZa9zqnUYnGjpt5LWBVqcgo4A/Imo9V7Xms8c4BifF
	 f8dI+MXLsoGNw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90D386BF2; Mon, 16 Oct 2023 16:50:31 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9770286B73
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4S8Km32fvKz9sq7;
 Mon, 16 Oct 2023 16:50:27 +0200 (CEST)
Message-ID: <ddd355c2-344e-4fbd-ace9-29d10f3966d3@denx.de>
Date: Mon, 16 Oct 2023 16:50:26 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-marvell/master
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

please pull this first batch of Marvell related patches:

----------------------------------------------------------------
- dns325: Enable 2nd harddrive (Peter & Stefan)
- marvell: cn9310-crb: Misc fixes to SPI / pincntrl in DTS (Chris)
- kirkwood: Add support for ZyXEL NSA325 board (Tony)
- sata_mv: Add bootstd hook to enable sata_bootdev (Tony)
- x240/AC5/AC5X: Disable SMBIOS (Chris)
- Revert "arm: mvebu: x240: Use i2c-gpio instead of built in controller" 
(Chris)
- DS116/N2350: Enable bootstd (Tony)
- clearfog: Support multiple DDR sizes (Josua)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=317&view=results

Thanks,
Stefan

The following changes since commit 3c3f1626919cd93cbe6c56e3849937de5be18dbb:

   Merge tag 'dm-pull-13oct23' of 
https://source.denx.de/u-boot/custodians/u-boot-dm (2023-10-14 10:50:20 
-0400)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to d2387c6227715eee8fd07466ed4eeffdcc9f86d2:

   arm: mvebu: AC5/AC5X: Disable SMBIOS (2023-10-16 14:00:45 +0200)

----------------------------------------------------------------
Chris Packham (5):
       ARM64: dts: marvell: cn9310: Use appropriate label for spi1 pins
       ARM64: dts: marvell: cn9310-crb: Remove duplicate pinctrl
       arm: mvebu: x240: Disable SMBIOS
       Revert "arm: mvebu: x240: Use i2c-gpio instead of built in 
controller"
       arm: mvebu: AC5/AC5X: Disable SMBIOS

Josua Mayer (2):
       arm: mvebu: clearfog: read number of ddr channels from tlv data
       arm: mvebu: clearfog: support 512MB memory size from tlv eeprom

Stefan Roese (1):
       kirkwood: dns325: Enable 2nd harddrive

Tony Dinh (4):
       arm: kirkwood: Add support for ZyXEL NSA325 board
       arm: mvebu: sata_mv: Add bootstd hook to enable sata_bootdev
       arm: mvebu: Enable bootstd for Synology DS116 board
       arm: mvebu: Enable bootstd for Thecus N2350 board

  arch/arm/dts/Makefile                    |   1 +
  arch/arm/dts/ac5-98dx35xx-atl-x240.dts   |  30 +---
  arch/arm/dts/cn9130-crb.dtsi             |   7 +-
  arch/arm/dts/cn9130-db.dtsi              |   2 +-
  arch/arm/dts/cn9130.dtsi                 |   2 +-
  arch/arm/dts/kirkwood-6282.dtsi          | 161 +++++++++++++++++++++
  arch/arm/dts/kirkwood-nsa325.dts         | 231 
+++++++++++++++++++++++++++++++
  arch/arm/dts/kirkwood-nsa3x0-common.dtsi | 157 +++++++++++++++++++++
  arch/arm/mach-kirkwood/Kconfig           |   7 +
  board/d-link/dns325/dns325.c             |   1 +
  board/solidrun/clearfog/clearfog.c       |  17 ++-
  board/solidrun/common/tlv_data.c         |   7 +-
  board/solidrun/common/tlv_data.h         |   1 +
  board/zyxel/nsa325/Kconfig               |  12 ++
  board/zyxel/nsa325/MAINTAINERS           |   9 ++
  board/zyxel/nsa325/Makefile              |  11 ++
  board/zyxel/nsa325/kwbimage.cfg          |  55 ++++++++
  board/zyxel/nsa325/nsa325.c              | 196 ++++++++++++++++++++++++++
  configs/ds116_defconfig                  |   3 +-
  configs/mvebu_ac5_rd_defconfig           |   1 +
  configs/n2350_defconfig                  |   3 +-
  configs/nsa325_defconfig                 |  81 +++++++++++
  configs/x240_defconfig                   |   2 +-
  drivers/ata/sata_mv.c                    |   8 +-
  include/configs/ds116.h                  |  12 +-
  include/configs/n2350.h                  |  12 +-
  include/configs/nsa325.h                 |  37 +++++
  27 files changed, 1007 insertions(+), 59 deletions(-)
  create mode 100644 arch/arm/dts/kirkwood-6282.dtsi
  create mode 100644 arch/arm/dts/kirkwood-nsa325.dts
  create mode 100644 arch/arm/dts/kirkwood-nsa3x0-common.dtsi
  create mode 100644 board/zyxel/nsa325/Kconfig
  create mode 100644 board/zyxel/nsa325/MAINTAINERS
  create mode 100644 board/zyxel/nsa325/Makefile
  create mode 100644 board/zyxel/nsa325/kwbimage.cfg
  create mode 100644 board/zyxel/nsa325/nsa325.c
  create mode 100644 configs/nsa325_defconfig
  create mode 100644 include/configs/nsa325.h
