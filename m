Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B87FCAC589
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 06:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 417E688D36;
	Wed, 18 Sep 2024 08:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AXpYiIEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC55288CBB; Tue, 17 Sep 2024 08:22:01 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB9688D22
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 08:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a8a91c8cdd5so60545466b.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 23:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726554119; x=1727158919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oLjOppDkpf4+G02osqITGrPJBIggTgTK+EB9YQab/B4=;
 b=AXpYiIEm+KOrQXDqvbM14JyGEREZ8c12/Tw/8ovGBSspiaHvE9VTL/bLShldS2Igqu
 O7GnNUPjtFPNsnluRbo4UpB4DcfJEnQdYfF1AXHQnDYwy/zxS3WefTJfxP2Zr1dyzVmx
 7qni4PInDwOlehBqn93aeoO0+i4aMW8PIn6Q+8HFA3+36BJNKruvTqXGvaGgMIIKQlux
 sR2HMBXPjpOZ6HKR9OAMLE8TecOqIg3qBuGAZ2MAEOyvVLO9LfXSGsJHVa72AQ/kmI/h
 AgZVmlbwjDRfxCy0Gwyny17bZlpZTPrSUyh3paTIWu9xG+mBnyeigD1vVG3Nl15WmADK
 YBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726554119; x=1727158919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLjOppDkpf4+G02osqITGrPJBIggTgTK+EB9YQab/B4=;
 b=SpYb5yAxZOh0tlnVlG2LrmYLb7OmgMv29L+EL15UGRLIPchbOTzeYOqZ9GZRXL0grG
 n+5CF9OWhpSsl6wFRACruAPOrzj5UpjDGZSODGCpMLVKr7iPnhWXASBsRX/FYLzFYwib
 5AC3ycvWj1l+IYVDW9WUMggcQvJQ3zm6IZKHzpyVXdXz5m4M6It9wuHz9n8c7pHiqCJ1
 0/ggQt5U/Gt+5MnafhYNWt5SCbBstikV/27Em5aWX2vb8Su84ubDjaFhuEuuxhUoxiFn
 dVBgBgNPeHgLXojyv5mkE0Gm3JxyqjzWGJYoqeLd1M+8K8bc7sdheG8vjWEUTH1lSmKW
 6XBA==
X-Gm-Message-State: AOJu0YwfQd3vak8PyYZ93J+Bb+ypja31D++MfXCZkmL+7nvZheukaT5s
 H0EW+V18NlnAVb7vASzCf7LA2HjubS2s4+LYbya7KvYBWyfkOZfZ8OkLbw==
X-Google-Smtp-Source: AGHT+IE9mEnGBUJfR1BfEdF7onAVLvz8lG/ySi4sobOBpqX3c3h/zSv8oVmE2lksv4SLGiiwCewg/A==
X-Received: by 2002:a17:907:9489:b0:a80:a3a8:9867 with SMTP id
 a640c23a62f3a-a902964c0ecmr755891066b.9.1726554118858; 
 Mon, 16 Sep 2024 23:21:58 -0700 (PDT)
Received: from fc8b2ad344cc.pool3007.local ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9061328e61sm403556366b.196.2024.09.16.23.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 23:21:58 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH v2 0/7] add support for Enclustra Mercury AA1 SoMs
Date: Tue, 17 Sep 2024 06:21:50 +0000
Message-Id: <20240917062157.3181-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Sep 2024 08:14:47 +0200
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
clarify some of my open issues. 

On the DT approach: I can agree that in parallel I may go for upstreaming
the kernel DT. There is a fundamental difference, still: In order to
represent the combination of module + baseboard + bootmode for the kernel
DT we have to use a mechanism like DTO. For u-boot this can be simpler.
Currently the few adjustments needed will be represented by the DT files as
are. I propose to keep them, and in case remove them later, which I doubt,
since the full DT for the kernel will cover more details. In case
refactoring is needed I can update the DT also in u-boot.

---
v1 -> v2:
- removal si5338 driver
- removal si5338 driver usage
- rename .c file for the boot cmd, build conditionally
- add separate .c file for late boot init to read MAC address from eeprom
- keep DT approach for u-boot under discussion
- fix issues in doc
- update MAINTAINERS to cover doc
---

Lothar Rubusch (7):
  doc: board: enclustra: add Enclustra Intel AA1 SoM
  ARM: dts: socfpga: add Enclustra Intel AA1
  ARM: socfpga: add Enclustra AA1 SoM support
  ARM: socfpga: add Enclustra AA1 extra env settings
  ARM: socfpga: add Enclustra AA1 demo env files
  ARM: socfpga: add Enclustra AA1 boot scripts
  ARM: socfpga: AA1: support MAC from secure eeprom

 arch/arm/dts/ME-AA1-270-2I2-D11E-NFX3.dtsi    |  14 +
 arch/arm/dts/ME-AA1-270-3E4-D11E-NFX3.dtsi    |  14 +
 arch/arm/dts/ME-AA1-480-2I3-D12E-NFX3.dtsi    |  15 +
 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/enclustra-aa1.dts                |  32 ++
 .../dts/socfpga_arria10_mercury_aa1_handoff.h | 307 ++++++++++++++++++
 .../dts/socfpga_enclustra_mercury_aa1.dtsi    | 179 ++++++++++
 ...cfpga_enclustra_mercury_aa1_qspi_boot.dtsi |  18 +
 ...fpga_enclustra_mercury_aa1_sdmmc_boot.dtsi |  18 +
 .../dts/socfpga_enclustra_mercury_pe1.dtsi    |   7 +
 .../dts/socfpga_enclustra_mercury_pe3.dtsi    |   8 +
 .../dts/socfpga_enclustra_mercury_st1.dtsi    |   8 +
 arch/arm/mach-socfpga/Kconfig                 |   9 +
 board/enclustra/bootscripts/qspi-aa1.cmd      |  12 +
 board/enclustra/bootscripts/sd-aa1.cmd        |  10 +
 board/enclustra/common/Kconfig                |  24 ++
 board/enclustra/common/Makefile               |   7 +
 board/enclustra/common/enclustra_mac.h        |  48 +++
 board/enclustra/common/mac_atsha204.c         |  97 ++++++
 board/enclustra/common/mac_common.c           |  54 +++
 board/enclustra/common/mac_ds28.c             |  88 +++++
 board/enclustra/mercury_aa1/Kconfig           |  15 +
 board/enclustra/mercury_aa1/MAINTAINERS       |  11 +
 board/enclustra/mercury_aa1/Makefile          |  10 +
 .../mercury_aa1/aa1_board_late_init.c         |  17 +
 .../mercury_aa1/aa1_set_storage_cmd.c         | 177 ++++++++++
 board/enclustra/mercury_aa1/bitstream.its     |  32 ++
 board/enclustra/mercury_aa1/mercury_aa1.env   |  65 ++++
 .../socfpga_enclustra_mercury_aa1_defconfig   |  79 +++++
 doc/board/enclustra/index.rst                 |   9 +
 doc/board/enclustra/mercury-aa1.rst           | 207 ++++++++++++
 doc/board/index.rst                           |   1 +
 drivers/misc/Kconfig                          |   2 +-
 include/configs/socfpga_mercury_aa1.h         |  68 ++++
 34 files changed, 1663 insertions(+), 1 deletion(-)
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
 create mode 100644 board/enclustra/mercury_aa1/aa1_board_late_init.c
 create mode 100644 board/enclustra/mercury_aa1/aa1_set_storage_cmd.c
 create mode 100644 board/enclustra/mercury_aa1/bitstream.its
 create mode 100644 board/enclustra/mercury_aa1/mercury_aa1.env
 create mode 100644 configs/socfpga_enclustra_mercury_aa1_defconfig
 create mode 100644 doc/board/enclustra/index.rst
 create mode 100644 doc/board/enclustra/mercury-aa1.rst
 create mode 100644 include/configs/socfpga_mercury_aa1.h

-- 
2.25.1

