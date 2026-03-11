Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9740C1062897
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 561DA8407E;
	Wed, 11 Mar 2026 14:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="BdRg/7Y0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97CFA83FED; Wed, 11 Mar 2026 09:41:44 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8141B83F6D
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 09:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jp
 ck52dDNncPfBiMW+/EvaeAiv1LcEYXUpY1xb4SUvM=; b=BdRg/7Y09hyD5WILfU
 eNO/YrKvixcYv7Lb3HiN4aBzIHFl/MmFN6VAUWJ+/oxBjuHcwU6DxlKnmkCs68p/
 Sk4cnDUlgTY2Sp++DqXc28nSvGNXTErbpdF4cIXhYWOVRJMA8R3CPSXXmeS295oc
 H8VC88aZ9GrXJBlfjTarXx6mk=
Received: from server-e.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wAHLsa5KrFpe9OOAQ--.40770S2; 
 Wed, 11 Mar 2026 16:41:30 +0800 (CST)
From: sgdfkk@163.com
To: duhuanpeng@139.com,
	u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
Subject: [PATCH v6 0/7] add loongson mips ls1c300 initial support
Date: Wed, 11 Mar 2026 16:41:22 +0800
Message-ID: <20260311084129.12809-1-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHLsa5KrFpe9OOAQ--.40770S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr15Jw45KF1kGw4fGr15Jwb_yoWxAw47pF
 s0ya1rGr4jvrW7Jrs3ta48Xr4rA3s5GFZI9F12qr1ruas2v3WUCFs3Ja47trZxJFWkJFy0
 vFyrur4UGFZFkwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcrcfUUUUU=
X-Originating-IP: [240e:3b0:4805:1b6:5ef3:fcff:feed:1d83]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbCwBp-1mmxKrrZCwAA3p
X-Mailman-Approved-At: Wed, 11 Mar 2026 14:15:12 +0100
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

From: Du Huanpeng <u74147@gmail.com>


---
Changelog for v6:
  - rebase to 2026.3.10, version [ba7bf918dafcd093ad733b07ba490baeb20cf5da]
  - no more includes common.h
  - use <linux/time.h> MSEC_PER_SEC instead of self made
  - The board specific parts should be in the board MAINTAINER file
  - rename arch/mips/mach-lsmips/ to ...mach-loongson/
  - rename functions names from lsmips_* to loongson_*
  - rename drivers/clk/lsmips/ to ...loongson/, rename clk driver name too
  - move TEXT_BASE, SPL_TEXT_BASE from mach-xxx/Kconfig to ls1c300_defconfig
  - rename hardware register name CONFIG_VALID to VALID (checkpatch error)
  - change dt bindings header license to gpl-2.0 OR MIT (checkpatch warning)
  - change dm-u-boot to bootph- in device tree
  - remove guards(#if/#endif) from include/configs/ls1c300.h
  - keep ARCH_LSMIPS macro, should I change it too ???

Changelog for v5:
   - add detail commit message
   - small fix in watchdog driver

Changelog for v4:
   - rebase to [247aa5a191159ea7e03bf1918e22fbbb784cd410]
   - fix rebase issues
   - use spl without SPL_DM
   - fix some more codingstyle
   - fix some more typo
   - add comments about writing sdram controler
   - keep .noreoder and do not use delay slot

Changelog for v3:
   - change cpu clock id from CLK_CPU to CLK_CPU_THROT
   - migrate all APB dev's clock id to CLK_APB
   - remove uarts' <reg-shift> property to use default value <0>
   - move /clocks/acc node to /soc/acc
   - call clk_request() before use a clk
   - make get_tbclk() return 1/2 clock of cpu
   - disable debug_uart by default
   - add ops for cpu_throt_factor clk
   - declare MSEC_PER_SEC for converting between sec and msec
   - return a error code when the wdt clock is out of range
   - minor format and codingstyle fixes
   - rebase to [9859465bfe838bc8264d45e1a1bed847bba74bad]

Changelog for v2:
1. dtsi:
  add status disabled for uart0 ~ uart11
  remove bootargs from chosen
  make serial0 alias for uart2
  oscillator remove @0 unit-address
  change uart2 address to kuseg

2. cleanup Kconfig and update defconfig
- make these options configurable, disabled by default:
  CMD_DM
  DM_ETH
  DM_GPIO
  DM_SPI
  DM_SPI_FLASH
  DM_RESET
  PINCONF
  PINCTRL
  PINMUX
  RESET_LSMIPS
- make these options configurable, enabled by default:
  CLK
  DISPLAY_CPUINFO
  SYSRESET
  ROM_EXCEPTION_VECTORS
- disabled:
  CONFIG_ENV_IS_IN_SPI_FLASH

3. fix codingstyle drivers/watchdog/lsmips-wdt.c
- priv->base + offset
- add comment for default clock value

4. remove address base definition header
- remove arch/mips/mach-lsmips/ls1c300/ls1c300.h
- clean up files uses this header

5. spl and debug uart
- add comment for spl & debug uart pinmuxing
- cleanup unused registers base header

6.  dtsi
- add "loongson,ls1c300-uart" to all uart node

7. board dts
- add memory node to board dts, start at 0x80000000, size 64MB

8. Kconfig
- make ROM_EXCEPTION_VECTORS user configureable
- enable ROM_EXCEPTION_VECTORS in defconfig

9.
- seperate sdram_init to sdram_init.S
- add macro helpers to do sdram, pll lowlevel init

10. dtsi
- move clock nodes to /clocks/xxx

11.
- define CONFIG_SKIP_LOWLEVEL_INIT to 1

12.
- remove option PINCTRL_LS1C300 from Kconfig

13.
- dram_init, use get_ram_size() to detect ram size.

14. clk driver
- create custom clock ops for PLL
- remove debug code

15.
- rebase to 59bffec43a657598b194b9eb30dc01eec06078c7
- remove CONFIG_SYS_MONITOR_BASE from include/configs/


Du Huanpeng (7):
  mips: loongson: minimal initial SoC support
  mips: loongson: lowlevel initialize
  mips: loongson: lowlevel debug serial
  mips: loongson: ls1c300 board support
  mips: loongson: add clk driver
  mips: loongson: add watchdog driver
  mips: loongson: ls1c300 dts and bindings

 MAINTAINERS                                   |   9 +
 arch/mips/Kconfig                             |  11 ++
 arch/mips/Makefile                            |   1 +
 arch/mips/dts/loongson32-ls1c300b.dtsi        | 151 +++++++++++++++
 arch/mips/dts/ls1c300-eval.dts                |  30 +++
 arch/mips/mach-loongson/Kconfig               |  69 +++++++
 arch/mips/mach-loongson/Makefile              |   6 +
 arch/mips/mach-loongson/cpu.c                 |  19 ++
 arch/mips/mach-loongson/include/mach/serial.h |  16 ++
 arch/mips/mach-loongson/ls1c300/Makefile      |   7 +
 arch/mips/mach-loongson/ls1c300/gpio.c        |  66 +++++++
 arch/mips/mach-loongson/ls1c300/init.c        |  61 ++++++
 .../mach-loongson/ls1c300/lowlevel_init.S     | 134 +++++++++++++
 arch/mips/mach-loongson/ls1c300/sdram.S       |  95 ++++++++++
 arch/mips/mach-loongson/ls1c300/serial.c      | 104 ++++++++++
 arch/mips/mach-loongson/spl.c                 |  46 +++++
 board/loongson/ls1c300-eval/Kconfig           |  12 ++
 board/loongson/ls1c300-eval/MAINTAINERS       |   7 +
 board/loongson/ls1c300-eval/Makefile          |   3 +
 board/loongson/ls1c300-eval/board.c           |  19 ++
 configs/ls1c300_defconfig                     |  52 +++++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/loongson/Makefile                 |   3 +
 drivers/clk/loongson/clk-ls1c300.c            | 179 ++++++++++++++++++
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/loongson_wdt.c               | 127 +++++++++++++
 include/configs/ls1c300.h                     |  36 ++++
 include/dt-bindings/clock/ls1c300-clk.h       |  18 ++
 include/dt-bindings/reset/ls1c300-reset.h     |  36 ++++
 30 files changed, 1327 insertions(+)
 create mode 100644 arch/mips/dts/loongson32-ls1c300b.dtsi
 create mode 100644 arch/mips/dts/ls1c300-eval.dts
 create mode 100644 arch/mips/mach-loongson/Kconfig
 create mode 100644 arch/mips/mach-loongson/Makefile
 create mode 100644 arch/mips/mach-loongson/cpu.c
 create mode 100644 arch/mips/mach-loongson/include/mach/serial.h
 create mode 100644 arch/mips/mach-loongson/ls1c300/Makefile
 create mode 100644 arch/mips/mach-loongson/ls1c300/gpio.c
 create mode 100644 arch/mips/mach-loongson/ls1c300/init.c
 create mode 100644 arch/mips/mach-loongson/ls1c300/lowlevel_init.S
 create mode 100644 arch/mips/mach-loongson/ls1c300/sdram.S
 create mode 100644 arch/mips/mach-loongson/ls1c300/serial.c
 create mode 100644 arch/mips/mach-loongson/spl.c
 create mode 100644 board/loongson/ls1c300-eval/Kconfig
 create mode 100644 board/loongson/ls1c300-eval/MAINTAINERS
 create mode 100644 board/loongson/ls1c300-eval/Makefile
 create mode 100644 board/loongson/ls1c300-eval/board.c
 create mode 100644 configs/ls1c300_defconfig
 create mode 100644 drivers/clk/loongson/Makefile
 create mode 100644 drivers/clk/loongson/clk-ls1c300.c
 create mode 100644 drivers/watchdog/loongson_wdt.c
 create mode 100644 include/configs/ls1c300.h
 create mode 100644 include/dt-bindings/clock/ls1c300-clk.h
 create mode 100644 include/dt-bindings/reset/ls1c300-reset.h

-- 
2.43.0

