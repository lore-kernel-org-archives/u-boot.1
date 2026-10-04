Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE2FCA5FE4
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 04:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ACF680993;
	Sun,  4 Oct 2026 04:07:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tjIXUNU2aP8d; Sun,  4 Oct 2026 04:07:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EB135808AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791086835;
	b=FE6prRGttEI0MJ9XR0/SIyD4LqSU5v/N8nOrJNuEs3p+LJqVBpl9PmFdLA5lvQ3mCbbY
	 vG1Ech9KDqQrzCZp7R+3FURBynA+xLzx29BhRz64NYtsLkpevG6GNMs2hZZBOOIEyH7+d
	 IudG4f2BdTmni+aLbCdmi+PSlhoVGu1eBpCUnNnBeySNrZn2TiL4IgrteDTJCtt5AuhmU
	 MQ4tLv5xKJvmZEfXfEb5Scksh6+x0Tyx2zj9ruTi+dyRa54mVeX7kfT4bRWWXn/ma6IuO
	 Iu/XDOPic4ETg25Z/VS8Vj6papN5Cf9OVLO3woDoo67MTBUPxLZj0NmU5OTPooijyHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791086835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+umWrWlBE+4aE3tpjfntqZ/ntN+WXq/Hki2c8F4NFww=;
	b=Sh458WYeckN2D4TioE7x05uJMAnNP4VblC7bYMhbs1BlO9HQy0cNwV1dW8vw/vlOIWud
	 BJ9G9TpFf1/tZ6nKSK4cV4mLpueBgZKXqaVkypK4V2HX1Rs+R1u3OBzAOsotGP1aUgsIN
	 Wrq+9OPO0M15vPq/4l8gUNX6w6G31nsL6OtkvnBfL3MegdnS75zh63m4sNznPHHdd55s4
	 lyWucHAxdS4APmrTaSl7kEPJmdF/1s1LtamUAm5kv8gPpnlsXX2ydvo4inpt94+nQDROc
	 8lkctaknPNq3K+vdeH7/gj5z3qRE78EK+x6q9IIXnS1eXWXv2OuYVNKC1Hidhbhka7Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=cSWFFOpE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791086835;
	bh=+umWrWlBE+4aE3tpjfntqZ/ntN+WXq/Hki2c8F4NFww=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZFG0WetbBngkLlKZhLI9TcPwY44NBEMJuf0cbkYAVFLcTLPz4CcuVAsGnKmWdkw/9
	 gNPBxnZgPsYIwfvHuCbIve2ETXYCqCiylmUOSSS3zGS1xE0PYCRI8naHJycZz3zzJA
	 Hem5hWSOso+cAslZEtcdJxYRwUk3ZTl4hHAkRDc8FKeO35ivs2kN/9oqoaDeKgbUQ8
	 vfpW8PeI5/L1tfZJ5Y++ViLPqgqJ+jxlWDv+nsi07bmNoxx0XuwZgifuGRHYlPypLI
	 l67gxgJ/Vnn67RyFfTr2kOovk3Brl6htEyDtLk9nmRZDtz0saNocI5kNR2v7xqXxSW
	 Z3qG/5WvEnMRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB135808AE;
	Sun,  4 Oct 2026 04:07:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 38F6E1A6
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 363568088A
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2YgGEFrvyM6 for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 04:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B6F6780F02
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791086833;
 b=q8V+RcHbSoofDxjHSUO3/hnSQMuuCYHFMzjCPs3YWOuzOyu8cc3uLVqrp128hnRon5r3
 jvlwCuisGhm9kbFIc1Wa08BqxIYVNLVA2hJHzvKzSeJGmwF3KBz1jScaftuTO0BpgCb2S
 9h3dnlxvFmz/yYQrhI4F71VA4dn6drDhy+rGsxEPRDb9o70s4jEHE6Vp0KO3LM3aU0yu9
 WWOyGG3Mzjz/0Jg9JQRTu2OWTkrE5byU/gn4c+HODkII4AiDgOJeGyDMw7Q5ChrPH2Hs8
 msIXRJvsGzcOs+YVv6XUBLTn7dd61UTU6sth/8sF01ReNw5lNrMtGYw4Dga748JQtqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791086833;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=+umWrWlBE+4aE3tpjfntqZ/ntN+WXq/Hki2c8F4NFww=;
 b=NmiLC5Cj+5gEaJdOIa0wofUHQiYiPs0sPzBlNUHc4T3DcWNDwgXTb7nlRefWAV1nsJlP
 QS5Pwtx1OJk0jfwkfQGOvZ7FKW/O9wBs6HbySmWZAbSpvlRmaM6MSMYBAukl9l9UKUDFQ
 Vj1yNjIQGqq+XncYuPhY2MNDyUSDKb2r0u8Tr8IovVKC4QJHZnbSn19T1j2/HsYYJtqpr
 2k4SXF29Jskzv/XBLwP7PPFPBTsWGplqFBPiy+JM+wPYtDRvxucrXxMletc5cEXv5yf0K
 FKR6J+HLp3lvqAoBxgcDQfZ/lKZk/89i6u9u7+8l6utnRlFAkeqV32H9AJlHsUTf4/w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=cSWFFOpE; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=cSWFFOpE
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6F6780F02
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 39900107834; Sun, 04 Oct 2026 06:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791086828; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=+umWrWlBE+4aE3tpjfntqZ/ntN+WXq/Hki2c8F4NFww=;
 b=cSWFFOpEuOxXdR1/kHnx1BuvD+MAb3OULphLHMVsrG8Mopb1fMkkmT99JMukl898WiA/1c
 UWavgIxnzEqHuHn5PGCmHFKeBIM+O9Obzt7fH8oYeV1lVSue0kju7DgqlzT47Rqbah0DS8
 1R3qW5BiYenjpHpBzlXL934XQK+wiCyiwONqvYl2LOI/GGicMiA1AqueEaPX8E01/XYbZY
 +fEu+ca6/h22gqoCgQsjevYnqT1REY6OEwv6BZFKufnlNwIxCGnD+3iPulIUuT9tzI1Pcp
 ZaSzyMKNe62snakjHnOUTtnm6VFLpAlGebhWpa72AaSGYfUcXKsofNFtIeIPdg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Heiko Schocher <hs@nabladev.com>, Anshul Dalal <anshuld@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>, Cole Munz <Munzzyy1@proton.me>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 0/5] mtd: Microchip 23LCV1024 SPI SRAM
Date: Sun,  4 Oct 2026 06:06:44 +0200
Message-ID: <20261004040657.3156402-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The 23LCV1024 is a 1 Mbit serial SRAM with battery backup on an SPI
bus, used as non volatile scratch storage. This adds a driver for it,
plus a sandbox emulation and a unit test.

The driver sits in UCLASS_MTD, the way the SPI NAND driver does, so
the device is reached through the mtd command. v1 put it in
UCLASS_SPI_FLASH to borrow the sf command, which meant shimming
struct spi_nor fields for a device with no flash semantics.

Reworked this now in v2 (comments from Simon)

Add patch "mtd: refuse an erase on a device that cannot erase" in v2
which prepares the MTD core for devices which have no erase function.

Patch 2 does the same for partitions on such a device, which are
aligned on the write size instead of the erase size the device does
not have. Without it "mtd list" divides by zero as soon as the device
tree gives the RAM partitions.

Patch 3 is the driver itself, now in drivers/mtd/spi_ram.c without erase
function.

patch 4 teaches the sandbox SPI emulation to bind something other than
the flash emulator

patch 5 is the emulation and the test.

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=218&view=results

Changes in v2:
- New patch. The SRAM driver of patch 3 has no erase, which the old
  mtd_erase() would have turned into a NULL pointer jump
- New patch mtd: align a partition on the write size if the device cannot erase
  Testing on the board dropped for "mtd list" command:
  ### ERROR ### Please RESET the board ###
  This is because division by erase_size, which the SPI RAM driver
  sets to 0. Added for this case also sandbox test.
Added comments from Simon:
- Moved from UCLASS_SPI_FLASH to UCLASS_MTD, the way the SPI NAND
  driver sits. The struct spi_nor shim and the dm_spi_flash_ops are
  gone with it, and the device is reached through the mtd command
  rather than sf.
- Moved from drivers/mtd/spi/ to drivers/mtd/, where the other
  standalone MTD drivers live.
- Dropped the erase operation. v1 filled the range with 0xff from a
  malloc'd buffer and claimed the bus once per 1 KB chunk. A RAM needs
  no erase, and patch 1 makes mtd_erase() answer -EOPNOTSUPP.
- Dropped the linux/mtd/spi-nor.h include, spi_flash.h pulled it in
  anyway and it advertised a NOR driver.
- sprintf() into a fixed field replaced by snprintf() into a buffer the
  driver owns.
- Copyright: dropped the trailing full stop and added Stefan Bigler's
  address.
fixed checkpatch warning:
- Added a MAINTAINERS entry, as the move out of drivers/mtd/spi/
  dropped a checkpatch warning.
Added comments from Simon:
- sandbox,emul is a phandle to an emulation node whose compatible
  selects the driver, instead of a string naming a U-Boot driver. That
  property is already a phandle for I2C and PCI, and dtoc treats it as
  one, so v1 would have given the same name two meanings.
- Renamed sandbox_sf_unbind_emul() to sandbox_spi_unbind_emul(), it is
  no longer specific to SPI NOR.
- The error paths name the driver or the node that could not be bound.
Added comments from Simon:
- The test drives the device through the MTD layer instead of the
  spi_flash uclass.
- Uses sandbox_spi_get_emul() rather than reaching into state->spi[][].
- Added a spi1 alias so that dev_seq() of the bus does not depend on
  probe order.
- The erase part checks for -EOPNOTSUPP now. The v1 comment about
  covering more than one staging step went with the erase loop.
- The emulation lives in its own node with its own compatible, which is
  what patch 4 resolves the phandle to.
- Added the emulation and the test to the MAINTAINERS entry.
Found while Stefan Bigler tested the series on hardware:
- Added partitions to the device in the test device tree and a second
  test that writes through one of them, which is what "mtd list" on his
  board fell over.

Heiko Schocher (5):
  mtd: refuse an erase on a device that cannot erase
  mtd: align a partition on the write size if the device cannot erase
  mtd: add driver for the Microchip 23LCV1024 SPI SRAM
  sandbox: spi: let a slave point at the emulation it needs
  test: dm: add a test for the Microchip 23LCV1024 SPI SRAM

 MAINTAINERS                     |   7 +
 arch/sandbox/dts/test.dts       |  37 ++++++
 arch/sandbox/include/asm/test.h |   8 ++
 configs/sandbox_defconfig       |   2 +
 drivers/mtd/Kconfig             |  23 ++++
 drivers/mtd/Makefile            |   2 +
 drivers/mtd/mtdcore.c           |   3 +
 drivers/mtd/mtdpart.c           |  38 ++++--
 drivers/mtd/spi/sandbox.c       |  65 ++++++++--
 drivers/mtd/spi_ram.c           | 222 ++++++++++++++++++++++++++++++++
 drivers/mtd/spi_ram_sandbox.c   | 190 +++++++++++++++++++++++++++
 drivers/spi/Kconfig             |   2 +-
 include/spi_flash.h             |   2 +-
 test/dm/Makefile                |   1 +
 test/dm/sf.c                    |   4 +-
 test/dm/spi.c                   |  10 +-
 test/dm/spi_ram.c               | 167 ++++++++++++++++++++++++
 17 files changed, 752 insertions(+), 31 deletions(-)
 create mode 100644 drivers/mtd/spi_ram.c
 create mode 100644 drivers/mtd/spi_ram_sandbox.c
 create mode 100644 test/dm/spi_ram.c

---
base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
branch: spi-ram-v2

-- 
2.55.0

