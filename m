Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01CEC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 15:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FA286308;
	Tue, 21 Nov 2023 16:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bC2sGeSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80686875A4; Tue, 21 Nov 2023 16:28:01 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACE08071F
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2B76C3FB5B; 
 Tue, 21 Nov 2023 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700580478;
 bh=rCCPULRubbunTT/svtBi46JitqclyO9YdTfSUUKQ7NY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=bC2sGeScZBcaE+3HVWp3ukxbUHJbP3V/KBcjOx14DpNQkcsGBHx8a/rIAdqnDPwEr
 FH/j+zXVdZzp4/6Bo/22wTKJ1tqC1o4P6ZlcCXyl/vc+mB2eaciFXJMZjxo9tHwIdp
 AxRenWOEl0Hrrx7yZiyNzLBtEw7lD6Em0aWWzVqVQ6PMJmEegva3axhjF5YL4Tqsg+
 ag5lHKhed1R4RJuyHiQsg6A2+y0NBVyGG7di8QmgF9hv4UWaUjuslBvlUPEa+nw/L7
 aKVGO92Lr0QbIYLdhNi/v1PJcUtQMqiIa6XNF6prfYz4WVKjS45sTdJVHBveipwaNq
 PQPaNr6tdjflA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/7] risc-v: add ACPI support on QEMU
Date: Tue, 21 Nov 2023 16:27:33 +0100
Message-Id: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

QEMU 8.1.2 can create ACPI tables for the RISC-V architecture.
Allow passing them through to the operating system.
Provide a new defconfig that enables this.

This series depends on

[PATCH] acpi: move acpi_get_rsdp_addr() to acpi/acpi_table.h
https://lore.kernel.org/u-boot/20231109172302.54324-1-heinrich.schuchardt@canonical.com/

v2:
	provide a new Kconfig symbol CONFIG_QFW_ACPI
	carve out qfw_acpi.c
	use CONFIG_ACPI to select QFW support
	provide a Kconfig fragment instead of a new defconfig

Heinrich Schuchardt (7):
  acpi: Kconfig symbol CONFIG_QFW_ACPI
  acpi: carve out qfw_acpi.c
  risc-v: add ACPI fields to global data
  risc-v: add support for QEMU firmware tables
  riscv: qemu: copy ACPI tables from QEMU
  riscv: allow usage of ACPI
  configs: qemu: add config fragment for ACPI

 MAINTAINERS                             |   1 +
 arch/Kconfig                            |   1 +
 arch/riscv/include/asm/global_data.h    |   4 +
 board/emulation/configs/acpi.config     |   3 +
 board/emulation/qemu-riscv/Kconfig      |   2 +
 board/emulation/qemu-riscv/qemu-riscv.c |  17 ++
 doc/board/emulation/acpi.rst            |  23 +++
 doc/board/emulation/index.rst           |   1 +
 drivers/misc/Kconfig                    |   7 +
 drivers/misc/Makefile                   |   1 +
 drivers/misc/qfw.c                      | 240 ----------------------
 drivers/misc/qfw_acpi.c                 | 256 ++++++++++++++++++++++++
 lib/acpi/Makefile                       |   2 +-
 lib/acpi/acpi_writer.c                  |   4 +-
 14 files changed, 319 insertions(+), 243 deletions(-)
 create mode 100644 board/emulation/configs/acpi.config
 create mode 100644 doc/board/emulation/acpi.rst
 create mode 100644 drivers/misc/qfw_acpi.c

-- 
2.40.1

