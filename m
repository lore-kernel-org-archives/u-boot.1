Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BA8E85371
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 16:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4E1D840F1;
	Fri,  3 Apr 2026 18:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="mfNM+G2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C80B584142; Fri,  3 Apr 2026 18:25:53 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194C383DC9
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 18:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=TT
 pmrImfxd5wgzVNhuGFctk9QO6fKNgNZJuabJPxe/8=; b=mfNM+G2lMINOQVq12p
 a/F6VWWbboLpv0umK74aRhai/C03V927dBtpUlwHEtSZirgd3Ejtyg/4wyOMEpYz
 /Riqa/5oRRN04SwbY9P79IE83E/B7Lc/VIhonY7Ob6DfoU3rPTZGhqBUUvpvNpDH
 5jIP7z6ysekPmx5TTKOIFLthU=
Received: from server-e.. (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgAnAXQF6s9pHqSgBw--.137S2;
 Sat, 04 Apr 2026 00:25:46 +0800 (CST)
From: sgdfkk@163.com
To: u-boot@lists.denx.de
Cc: Du Huanpeng <u74147@gmail.com>
Subject: [PATCH v7 0/7] add loongson mips ls1c300 initial support
Date: Sat,  4 Apr 2026 00:25:34 +0800
Message-ID: <20260403162541.86608-1-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgAnAXQF6s9pHqSgBw--.137S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXry3KF4fAF4xKFyrCFW8Xrb_yoW5uryxpw
 s0ya1rGr4jvry7Arn3tFyUXr4rA34rGrZI9FsFqr1rWas2v3WUCFs3Ja47tr43AFW8JFy8
 XF1ruF47GanFk3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWrWwUUUUU=
X-Originating-IP: [240e:3b0:4805:581::3001]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbCwAoLYmnP6grVOQAA3J
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
 arch/mips/dts/loongson32-ls1c300b.dtsi        | 151 ++++++++++++++
 arch/mips/dts/ls1c300-eval.dts                |  30 +++
 arch/mips/mach-loongson/Kconfig               |  69 +++++++
 arch/mips/mach-loongson/Makefile              |   6 +
 arch/mips/mach-loongson/cpu.c                 |  19 ++
 arch/mips/mach-loongson/include/mach/serial.h |  16 ++
 arch/mips/mach-loongson/ls1c300/Makefile      |   7 +
 arch/mips/mach-loongson/ls1c300/gpio.c        |  66 +++++++
 arch/mips/mach-loongson/ls1c300/init.c        |  61 ++++++
 .../mach-loongson/ls1c300/lowlevel_init.S     | 134 +++++++++++++
 arch/mips/mach-loongson/ls1c300/sdram.S       |  95 +++++++++
 arch/mips/mach-loongson/ls1c300/serial.c      | 104 ++++++++++
 arch/mips/mach-loongson/spl.c                 |  46 +++++
 board/loongson/ls1c300-eval/Kconfig           |  12 ++
 board/loongson/ls1c300-eval/MAINTAINERS       |   7 +
 board/loongson/ls1c300-eval/Makefile          |   3 +
 board/loongson/ls1c300-eval/board.c           |  19 ++
 configs/ls1c300_defconfig                     |  52 +++++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/loongson/Makefile                 |   3 +
 drivers/clk/loongson/clk-ls1c300.c            | 186 ++++++++++++++++++
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/loongson_wdt.c               | 127 ++++++++++++
 include/configs/ls1c300.h                     |  38 ++++
 include/dt-bindings/clock/ls1c300-clk.h       |  18 ++
 include/dt-bindings/reset/ls1c300-reset.h     |  36 ++++
 30 files changed, 1336 insertions(+)
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

