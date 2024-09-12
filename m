Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C295DEE644D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C3B88D6A;
	Thu, 12 Sep 2024 08:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kkTJoVLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 042D788DAF; Thu, 12 Sep 2024 08:06:55 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC6F388BDA
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a8d1a00e0d0so5887266b.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121211; x=1726726011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fyMuykqgpD8/sXjQDPhPhQhPdCqDLb1jKMgIkLGujDg=;
 b=kkTJoVLEtBS3gGdZotthn2uP5IOrAeIPpDghBSNsv7Lr9stUAXuxrTnPnq21okPNlK
 anPfFtUI0hlnyCeR6FJSmh85cn7edex22aA3wmTR7bJxPoG9MaUYYZN9CJPyEISQ2ATx
 SI6vdGjsGM5yJrSu9PR95f837ROPlcqChda9TnVasWMngWYiia+Qsz2yhmPMBQCh9stB
 CCr6ytO+Rns+CGNQzIBgwY8Q00uSXmhsyPzeSANU/Y8dI6coaB+8cQLlCeXTR68Mx+f2
 GkrDkmhd13GiVDwDYt0VviWJX2GIPQOitR1llwDLKvk2eN8+g47FD/rJrJ3Sp6C3auzN
 93WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121211; x=1726726011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyMuykqgpD8/sXjQDPhPhQhPdCqDLb1jKMgIkLGujDg=;
 b=wDngMBQ9WYXg6mBc0ZPX0HWxG+HkDro/+2y8+qPOK8h7/BejHvE5b/4KKpt5//ID4N
 HXahwQg5D5csJ1+KWhRF4WjkxxEyoxpY3/l4wv6fw37psXvnfS54oZYtGf5fpVKrXUSv
 Lx3WFd26pk38SDSg2Xl88POlfs/xiG7XRUBNPe2u+zrIliW+jRnmqZ/e1/T+qUPYbH/Z
 AaSHkoE4cfGRar5R0Wv4sl/bBNJVD7jkKU6/tDyweldMjx+4MNX6iWkb3SkKUQreg7VX
 tBIn6moc0+HRWDbjuKgG/CqaiSRgIdK9SAXr64DVE6gWGkGQ45kSP0IpKw8WUzWPkFIb
 nh7Q==
X-Gm-Message-State: AOJu0YwDhWEiQvOMcSzS17q4bqxoyTZLbcACdQE0AbCsNl7p3rNClJ/K
 Jml2wqebqsxqYleth+kmtFNtMYYnPS09NRpUTqA3A4ngCxK52LJlRmgAVA==
X-Google-Smtp-Source: AGHT+IEFRlQzGslbTPykRQugMCAantQRAspW0qOvzui3GdP313ULvu12fEujfGdpJUdGiJQiyIbr7w==
X-Received: by 2002:a17:906:478f:b0:a7a:9447:3e88 with SMTP id
 a640c23a62f3a-a9029610fb8mr64791966b.10.1726121211055; 
 Wed, 11 Sep 2024 23:06:51 -0700 (PDT)
Received: from 77c10117340a.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2598b844sm698112866b.76.2024.09.11.23.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:06:50 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH 0/9] add support for Enclustra Mercury AA1 SoMs
Date: Thu, 12 Sep 2024 06:06:40 +0000
Message-Id: <20240912060649.190-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 08:13:00 +0200
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

Introduce the support for three variants of Enclustra's Intel Mercury AA1 (with
Intel Arria10) SoMs and additional configs. This is supposed to be the first
step to upstream several of Enclustras SoC FPGA Modules. There are still things
to be modified. So, this is supposed to start the discussion and also to
clarify some of my open issues. I verified boot on SD card and emmc is booting,
as also checkpatch is mostly fine and I hope the git comments are reasonable.

Open Issues I still have:

- checkpatch.pl: CONFIG options for env settings in
  include/configs/socfpga_mercury_aa1.h show up as error at checkpatch.pl.
Additionally an env file as demo is provided, along with instructions.
Although, I noticed, when providing a uboot.env file as binary, this replaces
the default (socfpga) environment. Is there a way to just append some settings
by a compiled uboot.env? As this happens to be, when declared in
include/configs. Also other boards (still) used to have settings in board
header files in include/configs. So, do I need to remove CONFIG_ entries in
this file, or may it be acceptable?

- MAC address from secure eeprom: The implementation does not bring in a new
  driver. It uses actually the ATSHA204a driver following DM and already
existing in uboot. Function is verified. Is this usage ok?

- Si53338 driver: This is a new clock generator driver with partly generated
  code. To be honest, I'm not sure if this should be even be upstreamed. Fact
is, the SoMs work w/o this driver. Optional features may need that driver on
the system later. It's a nice to have, but also quite specific.

- DT: We don't have upstream kernel DT fragments, so that's also why we still
  use the classic location here. The bigger problem is, I have 3x (slightly)
different AA1 modules. All can be combined with three different baseboards.
Most of those combinations support several bootmodes (SD, eMMC, QSPI) with yet
another .dtsi fragment. What is the best way to deal with this situation? For
sure I don't like to bring in all combinations as particular new DT setups.
Hence, the current approach is to have a top level "enclustra-aa1.dts"
including particular .dtsi elements. In combination then using .dtbos and a
boot.scr approach. I feel a fit image can be part of the solution, but I'm
unsure. I'm unsure if this is part of the BSP later, say a yocto setup, or part
of the bootloader. Is it enough to just provide the .dtsi elementst or also an
.its file for a demo? In the documentation .rst file currently I refere to the
described. Do I need to improve this setup, and what would be the desired
approach for this situation?

- uImage: uImage was the classic approach at Enclustra. Anyway this goes into
  the same direction as above: A more advanced approach would involve a fit
image, as e.g. the "image.ub" Xilinx is doing. But is this needed? Doesn't it
also depend on the specific customer and project? Hence, a similar question, is
there anything missing? What would be additionally needed? Or, is the current
setup is enough?

- Maintainer: checkpatch.pl complains about a missing maintainer entry for the
  new board. So, I registered myself, since I have access to this hardware.
Unsure here, please let me know how to procede.

Lothar Rubusch (9):
  doc: board: enclustra: add Enclustra Intel AA1 SoM
  ARM: dts: socfpga: add Enclustra Intel AA1
  ARM: socfpga: add Enclustra AA1 SoM support
  ARM: socfpga: add Enclustra AA1 extra env settings
  ARM: socfpga: add Enclustra AA1 demo env files
  ARM: socfpga: add Enclustra AA1 boot scripts
  ARM: socfpga: AA1: support MAC from secure eeprom
  ARM: socfpga: add si5338 clock generator support
  ARM: socfpga: make AA1 use si5338 clock gen

 arch/arm/dts/ME-AA1-270-2I2-D11E-NFX3.dtsi    |  14 +
 arch/arm/dts/ME-AA1-270-3E4-D11E-NFX3.dtsi    |  14 +
 arch/arm/dts/ME-AA1-480-2I3-D12E-NFX3.dtsi    |  15 +
 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/enclustra-aa1.dts                |  32 ++
 .../dts/socfpga_arria10_mercury_aa1_handoff.h | 307 ++++++++++++
 .../dts/socfpga_enclustra_mercury_aa1.dtsi    | 179 +++++++
 ...cfpga_enclustra_mercury_aa1_qspi_boot.dtsi |  18 +
 ...fpga_enclustra_mercury_aa1_sdmmc_boot.dtsi |  18 +
 .../dts/socfpga_enclustra_mercury_pe1.dtsi    |   7 +
 .../dts/socfpga_enclustra_mercury_pe3.dtsi    |   8 +
 .../dts/socfpga_enclustra_mercury_st1.dtsi    |   8 +
 arch/arm/mach-socfpga/Kconfig                 |   9 +
 board/enclustra/bootscripts/qspi-aa1.cmd      |  12 +
 board/enclustra/bootscripts/sd-aa1.cmd        |  10 +
 board/enclustra/common/Kconfig                |  24 +
 board/enclustra/common/Makefile               |   7 +
 board/enclustra/common/enclustra_mac.h        |  48 ++
 board/enclustra/common/mac_atsha204.c         |  97 ++++
 board/enclustra/common/mac_common.c           |  54 +++
 board/enclustra/common/mac_ds28.c             |  88 ++++
 board/enclustra/mercury_aa1/Kconfig           |  15 +
 board/enclustra/mercury_aa1/MAINTAINERS       |  10 +
 board/enclustra/mercury_aa1/Makefile          |   4 +
 board/enclustra/mercury_aa1/bitstream.its     |  32 ++
 board/enclustra/mercury_aa1/mercury_aa1.c     | 199 ++++++++
 board/enclustra/mercury_aa1/mercury_aa1.env   |  65 +++
 .../socfpga_enclustra_mercury_aa1_defconfig   |  81 ++++
 doc/board/enclustra/index.rst                 |   9 +
 doc/board/enclustra/mercury-aa1.rst           | 209 +++++++++
 doc/board/index.rst                           |   1 +
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/skyworks/Kconfig                  |  10 +
 drivers/clk/skyworks/Makefile                 |   3 +
 drivers/clk/skyworks/Si5338-RevB-Registers.h  | 441 ++++++++++++++++++
 drivers/clk/skyworks/si5338_clkgen.c          | 177 +++++++
 drivers/clk/skyworks/si5338_clkgen.h          |  18 +
 drivers/misc/Kconfig                          |   2 +-
 include/configs/socfpga_mercury_aa1.h         |  68 +++
 40 files changed, 2316 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/ME-AA1-270-2I2-D11E-NFX3.dtsi
 create mode 100644 arch/arm/dts/ME-AA1-270-3E4-D11E-NFX3.dtsi
 create mode 100644 arch/arm/dts/ME-AA1-480-2I3-D12E-NFX3.dtsi
 create mode 100644 arch/arm/dts/enclustra-aa1.dts
 create mode 100644 arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_aa1.dtsi
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_aa1_qspi_boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_aa1_sdmmc_boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_pe1.dtsi
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_pe3.dtsi
 create mode 100644 arch/arm/dts/socfpga_enclustra_mercury_st1.dtsi
 create mode 100644 board/enclustra/bootscripts/qspi-aa1.cmd
 create mode 100644 board/enclustra/bootscripts/sd-aa1.cmd
 create mode 100644 board/enclustra/common/Kconfig
 create mode 100644 board/enclustra/common/Makefile
 create mode 100644 board/enclustra/common/enclustra_mac.h
 create mode 100644 board/enclustra/common/mac_atsha204.c
 create mode 100644 board/enclustra/common/mac_common.c
 create mode 100644 board/enclustra/common/mac_ds28.c
 create mode 100644 board/enclustra/mercury_aa1/Kconfig
 create mode 100644 board/enclustra/mercury_aa1/MAINTAINERS
 create mode 100644 board/enclustra/mercury_aa1/Makefile
 create mode 100644 board/enclustra/mercury_aa1/bitstream.its
 create mode 100644 board/enclustra/mercury_aa1/mercury_aa1.c
 create mode 100644 board/enclustra/mercury_aa1/mercury_aa1.env
 create mode 100644 configs/socfpga_enclustra_mercury_aa1_defconfig
 create mode 100644 doc/board/enclustra/index.rst
 create mode 100644 doc/board/enclustra/mercury-aa1.rst
 create mode 100644 drivers/clk/skyworks/Kconfig
 create mode 100644 drivers/clk/skyworks/Makefile
 create mode 100644 drivers/clk/skyworks/Si5338-RevB-Registers.h
 create mode 100644 drivers/clk/skyworks/si5338_clkgen.c
 create mode 100644 drivers/clk/skyworks/si5338_clkgen.h
 create mode 100644 include/configs/socfpga_mercury_aa1.h

-- 
2.25.1

