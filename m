Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C610CF259F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0808852D;
	Mon, 14 Oct 2024 04:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E7yDz672";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78EED88EFE; Sun, 13 Oct 2024 16:32:41 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF2E88F0A
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 16:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c936e8ea13so757899a12.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728829955; x=1729434755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1arLXL5EVzM7qpbYXSEhqWnhRPWdSt8Bq04nvM5EBaA=;
 b=E7yDz672lnXje2Mv6PMHjFIeCRF8XOGyyDF8dRBnmvW2edh7aQEXycl6J2cUM0hf6d
 dX28KQV0ITFdJ/jiW2MgPdd/sXAEWTJe7o+UyF8g0HiBYKOs3qgznzzDJGEraNclUoAP
 kLmYMu1y+Iv3xslIXxQgS8BkgnA1o5p9PiP3XfmJbL8rGBr7Bwp9tYChnPiuawIXrhvU
 YZjDZ/hLQHYHYyzajXm8qGR9R1fUod9V9EM8KKyrUYtxsVTB9B6KULlqv1c/nmiY1g4q
 ftoEfwmR2ZRhf1f9q+NXgwPwOPTeY9fwb/J849rer0JAQJHxpK6XfHmEYreo2u2nV9wS
 zCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728829955; x=1729434755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1arLXL5EVzM7qpbYXSEhqWnhRPWdSt8Bq04nvM5EBaA=;
 b=qDAvF/az6K8cteCP6xSNU1cBrqnrXR5b0IE/jITQm/2Kr815206gopMOuYsA6vdYbo
 kkEFCFeEkBYEJZNR5EEWOyovESJAQ8iit1u+pYNSsMJO+cKAiyf/gdLbRAaslqv/uKaa
 KRls0yD6DT8Wg4LOvyuU+L9HxdZ4IsU8rEGv5bHzg8zbgpvaPNaQb36fq4z/9jeGyExb
 r2GThK6gXfgCUznqrR0OJXNNSHNbJN5gTxiubkkqbNfCUaCEYyfb+iXPVTj+f9cMe+TQ
 Cz4/cVvwsf+kUa8rX4NLce7dBVATblEs+I+BUJ8+ZLrLusCn6BkcGG0CB9oL+c7RBfTM
 MiNw==
X-Gm-Message-State: AOJu0YzPnU9oxV4M+zWXmEMfwb2uQ515pCT5ZxGchFkzNvqKeSoykm3D
 yPbL7y9/wDTUSMYaC+8Clm2Nl8gzx0WmgqtVMMfoCDFIhTaZWC0R2orFiQ==
X-Google-Smtp-Source: AGHT+IHIOSL3fMpGx/wVlVolqLvmt2kI5B4u+vVz3fJmaNQdzuFvcs/aVcdzIU/vwQ7HfwPrPRHbSw==
X-Received: by 2002:a17:906:c113:b0:a99:8517:4777 with SMTP id
 a640c23a62f3a-a99b95c482bmr381917966b.10.1728829954734; 
 Sun, 13 Oct 2024 07:32:34 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99efcf15d1sm189886266b.102.2024.10.13.07.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 07:32:34 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH 00/10] add support for Enclustra Mercury AA1 SoMs
Date: Sun, 13 Oct 2024 14:32:22 +0000
Message-Id: <20241013143232.2090645-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Oct 2024 04:44:22 +0200
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

The DT approach is partly based on dts/upstream, which are (going to be)
upstreamed to the linux kernel.

---
v2 -> v3:
- update of DT concept to work with dts/upstream
- update of DT parts in arch/arm/dts, because of:
  -- the handoff initialization of the Arria10 SoC
  -- the fpga loader for the bitstream in the DTS
  -- the adjustments to access the boot media, from where to load the fpga.itb
  -- and to mux media for booting, e.g. QSPI off, when booting from MMC
- implementation of kconfig options to combine SoM .dtsi file, carrier board
  .dtsi files, boot-mode parts, and so on resulting in a single .dts
  file located in arch/arm/dts because of the above mentioned reasons
- adjustents to (better) satisfy dtb checks
- updated MAINTAINERS
- updated documentation
- update to use standard boot and environment as only environment, removal of
  explicit variables and environment files
- removal of duplicate codes
- cleanup and implement altera_set_storage (boot media switch command in
  u-boot shell) based on DM
- fix spansion flash access to allow flashing from off the u-boot shell,
  this patch was already presented separately, the fix is actively needed for
  the AA1 SoM
- sort lists in several files alfabetically
- update boot commands using && instead of ;

v1 -> v2:
- removal si5338 driver
- removal si5338 driver usage
- rename .c file for the boot cmd, build conditionally
- add separate .c file for late boot init to read MAC address from eeprom
- keep DT approach for u-boot under discussion
- fix issues in doc
- update MAINTAINERS to cover doc

---
Lothar Rubusch (10):
  doc: board: enclustra: add Enclustra Mercury+ AA1
  ARM: socfpga: add Mercury+ AA1 SoM support
  ARM: dts: socfpga: add Mercury+ AA1 for u-boot dts
  ARM: socfpga: add Enclustra storage switch
  ARM: socfpga: add Mercury+ AA1 extra env settings
  ARM: socfpga: add Mercury+ AA1 boot scripts
  ARM: socfpga: AA1: support MAC from secure eeprom
  misc: atsha204a: update kconfig description
  ARM: dts: arria10: update according to DTSpec
  ARM: socfpga: update function call to modern API

 arch/arm/dts/socfpga_arria10.dtsi             |  42 ++-
 .../socfpga_arria10_enclustra_mercury_aa1.dts | 103 ++++++
 .../socfpga_arria10_mercury_aa1-u-boot.dtsi   |  19 ++
 .../dts/socfpga_arria10_mercury_aa1_handoff.h | 305 ++++++++++++++++++
 arch/arm/mach-socfpga/Kconfig                 |   9 +
 arch/arm/mach-socfpga/misc_arria10.c          |   2 -
 board/enclustra/bootscripts/qspi-aa1.cmd      |  12 +
 board/enclustra/bootscripts/sd-aa1.cmd        |   9 +
 board/enclustra/common/Kconfig                |  25 ++
 board/enclustra/common/Makefile               |   7 +
 board/enclustra/common/enclustra_mac.h        |  48 +++
 board/enclustra/common/mac_atsha204.c         | 102 ++++++
 board/enclustra/common/mac_common.c           |  52 +++
 board/enclustra/common/mac_ds28.c             |  93 ++++++
 board/enclustra/mercury_aa1/Kconfig           |  52 +++
 board/enclustra/mercury_aa1/MAINTAINERS       |  12 +
 board/enclustra/mercury_aa1/Makefile          |  10 +
 .../mercury_aa1/aa1_board_late_init.c         |  17 +
 .../mercury_aa1/aa1_set_storage_cmd.c         | 190 +++++++++++
 board/enclustra/mercury_aa1/fpga.its          |  32 ++
 .../socfpga_enclustra_mercury_aa1_defconfig   |  86 +++++
 doc/board/enclustra/index.rst                 |   9 +
 doc/board/enclustra/mercury-aa1.rst           | 227 +++++++++++++
 doc/board/index.rst                           |   1 +
 include/configs/socfpga_mercury_aa1.h         |  23 ++
 25 files changed, 1476 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
 create mode 100644 arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
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
 create mode 100644 board/enclustra/mercury_aa1/fpga.its
 create mode 100644 configs/socfpga_enclustra_mercury_aa1_defconfig
 create mode 100644 doc/board/enclustra/index.rst
 create mode 100644 doc/board/enclustra/mercury-aa1.rst
 create mode 100644 include/configs/socfpga_mercury_aa1.h

-- 
2.25.1

