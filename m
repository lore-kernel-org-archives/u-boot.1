Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3B606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l1cQkaan;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=PCq8Tsp/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C6EC817B2;
	Sat,  7 Nov 2026 12:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIuul5QSOf3V; Sat,  7 Nov 2026 12:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71771814F2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055864;
	b=F23wvZPtJtZk6qSUWCGiOvbZiuLxkAfYzt84ipe2C0yblb95C7J29yOn4A3FfyPLUGJ5
	 Sb94kLnXSUrqEpIO1b39DkVM3KG6ic29Q8UAkORnHSUQHqa+L2YMVqY458VOXxc7ifHJh
	 R55z/vQmgmW9Y4nAq4R9s9KyAnOtA5d0VwBVhZMeW1F2TzWnQhdZ6Bp4VpoC3YQxe94oy
	 nuaBnXDVKmcddHZJ11V24Xu2Rx1GnvbU0OoT2tgar4SqC7rgYZFD83oyLz/k04E946j2J
	 rDue3Q6FB7TJOFlI3h+jG2+gg0rg5PFXwJm9cU8tyUXQYDRJCNL2uFBN3YXFvI6b3IQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055864;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1Up9bWnC1/WPiZd1TnVYk6sc88h5Cgq8wCuR4Q5sm4o=;
	b=YjzpMjZ69BFi2XzWRxI1nNMk/QpBacINRQ9VPyxG49PJMqGLrk7MLl4bnXwQQ2qDKzIj
	 05ADHwMzuKG50nf44IYSSoz/Ndg/Z2Tlykn1oW+2YBkYLmuO3lbbHz+AnZoNMnzAgBbj4
	 56h6Okp+QKBZcMxXchIqMxmLplRAT0M5cTRY2wSrjnWn7kDscqZuvm7divACJC3qEJGgT
	 NkwwmvPD7f/yjivRgr0tYj7gSKD18cODEOpqXnBCY0moNFyIreCrkm5r1NeQvm7x89uFE
	 Y3fNZWnaBOG8beAv1UYhnmCWPEfxxyp+mfRerC7ivVvUZTUaec90ZczD7oszQgHS9QA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055864;
	bh=1Up9bWnC1/WPiZd1TnVYk6sc88h5Cgq8wCuR4Q5sm4o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l1cQkaanStGUrMZZHP1c/LHA5/OFLjag+NZCnocw7t3WUjLH/e+iOTwEJkyJxCCJe
	 MAFjLlvr26E2r9ECCCs8hw4nR/vLjqASljbDNKy9sINAyBUtPiks0P3hoHz+m/4hS7
	 XWwbmEJIHhVagkulaNCJ+NR+xQWj85xKnuiLajzg+1m7nq8ialHKFQRCgEnrCoqSar
	 PfOgde8rtY6Ku7f2tbgXplxUHywmd5wKVyUfYdi8Xo9QJsdfZ5Jo0BNuflrquqmet8
	 WhfY36Gfw5mz4huYDRzbCqaJCOALhZh6xHwPS3FLeOaVm7QkeEzCgAyIwlyyFPp20y
	 wCNegCONSi7lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71771814F2;
	Sat,  7 Nov 2026 12:51:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 562EA2E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53AB840111
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L8m_Tok6Fkg2 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:54:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 71CE14009B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=138.232.1.142
X-Greylist: delayed 556 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 07 Nov 2026 11:54:27 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=student.uibk.ac.at
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at
 header.a=rsa-sha256 header.s=prod24a header.b=PCq8Tsp/
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=138.232.1.142;
 helo=lmr1.uibk.ac.at; envelope-from=christian.koever-draxl@student.uibk.ac.at;
 receiver=<UNKNOWN> 
Received: from lmr1.uibk.ac.at (lmr1.uibk.ac.at [138.232.1.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71CE14009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:26 +0000 (UTC)
Received: from surface-pro-5 (178.115.47.78.wireless.dyn.drei.com
 [178.115.47.78]) (authenticated bits=0)
 by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A7Bivmp711658
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 7 Nov 2026 12:45:02 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A7Bivmp711658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
 s=prod24a; t=1794051904;
 bh=1Up9bWnC1/WPiZd1TnVYk6sc88h5Cgq8wCuR4Q5sm4o=;
 h=From:To:Cc:Subject:Date;
 b=PCq8Tsp/+0X+lt8B5CPP80y6s7OmuK01z5PbVuuZ+X/9h7qBmjlw2NZ3KSvxe9WPT
 Zz/cUfjlUg23QIemShK2liu7j9MOl3HYrOPq+QmzyUBQlanMQ3Zcew1/6A+CDjdDpw
 xZ9iyYnAIreBxaHapCvgPi5IYjwSgSQyLSeqJ5Jo=
From: christian.koever-draxl@student.uibk.ac.at
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [RFC PATCH 00/10] Add STM32L4R5 / NUCLEO-L4R5ZI support
Date: Sat,  7 Nov 2026 12:44:45 +0100
Message-ID: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:50:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

This series adds support for the STM32L4+ family and the ST NUCLEO-L4R5ZI
board (STM32L4R5ZIT6: Cortex-M4, 2 MiB flash, 640 KiB SRAM).

Unlike the F4/F7/H7 boards, the L4R5 has no external memory controller,
and 640 KiB of SRAM is too small to relocate U-Boot next to its stack,
malloc area and an application. Patch 1 therefore adds
CONFIG_ARMV7M_XIP: U-Boot executes in place from flash, .data is copied
to SRAM by the reset handler and relocation is skipped. It only takes
effect when enabled, so other ARM boards are unchanged.

Patches 2-8 add the SoC support: an RCC clock driver (120 MHz from
HSI16 via the main PLL, Range 1 boost), the pinctrl compatible, LPUART
support in serial_stm32 (different baud rate generator), the family,
the SoC device tree and the board. U-Boot keeps its own data in
SRAM1 + SRAM2 so that SRAM3 stays free for applications.

Patches 9-10 add an optional "bootapp" command that starts a bare-metal
ARMv7-M application from its vector table as after a reset, and enable
it on the board. They are independent of the rest of the series.

Why RFC:
There is no STM32L4 device tree or RCC binding in Linux, so the DT
(arch/arm/dts/stm32l4r5*) and include/dt-bindings/clock/stm32l4-clock.h
are U-Boot local and OF_UPSTREAM cannot be used. How would the STM32
maintainers like to handle this: upstream the binding and DT to Linux
first, or accept U-Boot-local files for now? Feedback on the XIP
approach in patch 1 is also very welcome.

Tested on a NUCLEO-L4R5ZI (DEV_ID 0x470, 2 MiB dual-bank flash):
- banner and prompt on the ST-Link VCP, warm reset
- clk dump: SYSCLK/HCLK/PCLK1/PCLK2 at 120 MHz; register state of
  RCC, FLASH_ACR and PWR checked over SWD
- sleep 2/10/30 measured on the host: 2.007/10.004/30.002 s
- baudrate 9600 <-> 115200 switching (LPUART prescaler)
- led and button commands, GPIO output state checked over SWD
- bootapp: test application at 0x08040000 runs with its own vector
  table; misaligned, unmapped and invalid vector tables are rejected
- stack/.bss overlap check triggers with a forced oversized malloc area

Build-tested at every patch: stm32f429-discovery; at the end also
stm32f746-disco and stm32h743-disco.

Use of AI tools
---------------
Following the transparency expectations of the Linux kernel
(Documentation/process/generated-content.rst), which U-Boot has no
separate policy for: this series was produced with heavy use of an AI
coding assistant, Claude Code with the model Claude Opus 5.5
(Anthropic).

- Portions affected: essentially all code, device tree, Kconfig,
  documentation and commit messages in this series were generated by
  the assistant. I directed the design, reviewed every file and asked
  for the changes needed to follow existing U-Boot conventions.
- Prompts (summary of a long interactive session): download U-Boot,
  the ST documentation (RM0432, DS12902, PM0214, UM2179, ES0393) and
  the Arm GNU toolchain; port U-Boot to the NUCLEO-L4R5ZI for a console
  and for starting bare-metal applications, reusing existing STM32
  drivers only after checking them against RM0432; then review all
  files against the conventions of the tree, keep the defconfig
  minimal and prepare the series for the mailing list. The design
  decisions (execute in place, SRAM3 kept free, the bootapp handover)
  were discussed and agreed before implementation.
- Register-level facts were taken from RM0432 and checked against the
  reference manual text; reused drivers were compared register by
  register before reuse.
- Testing: the assistant built and flashed the board through OpenOCD /
  ST-Link and drove the console from scripts; register state was read
  back over SWD and timing was measured against the host clock (see
  the test list above). Independent review passes by separate AI
  reviewer instances were run and their findings fixed.

I understand the changes and take responsibility for them; questions
and review comments are welcome.

Christian Stefan Kövér-Draxl (10):
  arm: armv7m: support executing U-Boot in place from flash
  dt-bindings: clock: add STM32L4 RCC clock and reset identifiers
  clk: stm32: add STM32L4+ RCC driver
  pinctrl: stm32: add STM32L4R5 compatible
  serial: stm32: add LPUART support
  arm: stm32: add STM32L4 family
  ARM: dts: stm32: add STM32L4R5 SoC device tree
  board: st: add NUCLEO-L4R5ZI
  cmd: add bootapp command for ARMv7-M
  board: st: stm32l4r5zi-nucleo: enable bootapp

 arch/arm/Kconfig                              |  23 +
 arch/arm/cpu/armv7m/start.S                   |  11 +
 arch/arm/cpu/armv7m/u-boot-xip.lds            |  92 ++++
 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/stm32l4-u-boot.dtsi              |  13 +
 arch/arm/dts/stm32l4r5-pinctrl.dtsi           |  22 +
 arch/arm/dts/stm32l4r5.dtsi                   | 135 +++++
 arch/arm/dts/stm32l4r5zi-nucleo-u-boot.dtsi   |  23 +
 arch/arm/dts/stm32l4r5zi-nucleo.dts           |  71 +++
 arch/arm/include/asm/arch-stm32l4/stm32.h     |  34 ++
 arch/arm/include/asm/armv7m.h                 |   9 +
 arch/arm/lib/crt0.S                           |   4 +-
 arch/arm/lib/relocate.S                       |   4 +
 arch/arm/lib/stack.c                          |  14 +
 arch/arm/mach-stm32/Kconfig                   |  18 +
 arch/arm/mach-stm32/soc.c                     |   2 +-
 arch/arm/mach-stm32/stm32l4/Kconfig           |  11 +
 board/st/stm32l4r5zi-nucleo/Kconfig           |  15 +
 board/st/stm32l4r5zi-nucleo/MAINTAINERS       |  11 +
 board/st/stm32l4r5zi-nucleo/Makefile          |   3 +
 .../stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c   |  80 +++
 cmd/Kconfig                                   |   7 +
 cmd/Makefile                                  |   1 +
 cmd/bootapp.c                                 | 126 +++++
 configs/stm32l4r5zi-nucleo_defconfig          |  36 ++
 doc/board/st/stm32_MCU.rst                    |  27 +-
 drivers/clk/stm32/Kconfig                     |   9 +
 drivers/clk/stm32/Makefile                    |   1 +
 drivers/clk/stm32/clk-stm32l4.c               | 483 ++++++++++++++++++
 drivers/misc/stm32_rcc.c                      |   6 +
 drivers/pinctrl/pinctrl_stm32.c               |   1 +
 drivers/serial/Kconfig                        |   4 +-
 drivers/serial/serial_stm32.c                 |  56 +-
 drivers/serial/serial_stm32.h                 |  11 +
 include/configs/stm32l4r5zi-nucleo.h          |  12 +
 include/dt-bindings/clock/stm32l4-clock.h     |  44 ++
 36 files changed, 1408 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/cpu/armv7m/u-boot-xip.lds
 create mode 100644 arch/arm/dts/stm32l4-u-boot.dtsi
 create mode 100644 arch/arm/dts/stm32l4r5-pinctrl.dtsi
 create mode 100644 arch/arm/dts/stm32l4r5.dtsi
 create mode 100644 arch/arm/dts/stm32l4r5zi-nucleo-u-boot.dtsi
 create mode 100644 arch/arm/dts/stm32l4r5zi-nucleo.dts
 create mode 100644 arch/arm/include/asm/arch-stm32l4/stm32.h
 create mode 100644 arch/arm/mach-stm32/stm32l4/Kconfig
 create mode 100644 board/st/stm32l4r5zi-nucleo/Kconfig
 create mode 100644 board/st/stm32l4r5zi-nucleo/MAINTAINERS
 create mode 100644 board/st/stm32l4r5zi-nucleo/Makefile
 create mode 100644 board/st/stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c
 create mode 100644 cmd/bootapp.c
 create mode 100644 configs/stm32l4r5zi-nucleo_defconfig
 create mode 100644 drivers/clk/stm32/clk-stm32l4.c
 create mode 100644 include/configs/stm32l4r5zi-nucleo.h
 create mode 100644 include/dt-bindings/clock/stm32l4-clock.h

-- 
2.56.0

