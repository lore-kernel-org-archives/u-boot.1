Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96FAC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 12:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B8E87508;
	Tue, 19 Dec 2023 13:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KoLgGetj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA7D87517; Tue, 19 Dec 2023 13:24:56 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DE6887032
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4A48A3F6E1; 
 Tue, 19 Dec 2023 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702988692;
 bh=0cJTH8rZHi+0Wl56uGwRPAzltbH56/zSK20WrjIxtAc=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=KoLgGetjP+Vv74uYfZDVAEXnLwuqV8xOgXAqcbDL1g4eQqNo6UlYiyjv5A0QT76ht
 RPW9tKHvLyNCWa5qPm62XujbcqZUf+W3aXXv9GOmzxauiNUb32PPUzLbteNQFTdway
 jpnqDtoKRlTB5Na1Xu6OKgtD2ez7GWgT8QbW+ZGUKaJy2lzznAWymIseL6YU5D2QD5
 ky/I1OEebkwUek6pK9zGosDwCFP4wkyOuxTtBB7BKgOkmeR3DfyouwYBc8OuyaHQVx
 SiI24Hh2Oevx/wEj0RLY/UjdbylBKxVU1VNVTA+8Wir8669HvvpiyJ84tbSoFOkQsz
 X7GIaTXGJ0fZg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/9] acpi: add ACPI support on QEMU ARM and RISC-V
Date: Tue, 19 Dec 2023 13:24:30 +0100
Message-Id: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
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

QEMU 8.1.2 can create ACPI tables for the ARM and RISC-V architectures
Allow passing them through to the operating system.
Provide a new config fragment that enables this.

v3:
	let tables in global data depend on CONFIG_(SPL_)ACPI
v2:
	consider ARM architecture too
	invoke write_acpi_tables() via EVT_LAST_STAGE_INIT

Heinrich Schuchardt (9):
  acpi: Kconfig symbol CONFIG_QFW_ACPI
  acpi: carve out qfw_acpi.c
  arm: add ACPI fields to global data
  risc-v: add ACPI fields to global data
  acpi: enable writing ACPI tables on QEMU
  risc-v: add support for QEMU firmware tables
  riscv: allow usage of ACPI
  configs: qemu: add config fragment for ACPI
  arm: enable support for QEMU firmware tables

 MAINTAINERS                          |   1 +
 arch/Kconfig                         |   1 +
 arch/arm/include/asm/global_data.h   |   7 +-
 arch/riscv/include/asm/global_data.h |   6 +
 board/emulation/configs/acpi.config  |   3 +
 board/emulation/qemu-arm/Kconfig     |   1 +
 board/emulation/qemu-riscv/Kconfig   |   2 +
 doc/board/emulation/acpi.rst         |  23 +++
 doc/board/emulation/index.rst        |   1 +
 drivers/misc/Kconfig                 |   7 +
 drivers/misc/Makefile                |   1 +
 drivers/misc/qfw.c                   | 240 -----------------------
 drivers/misc/qfw_acpi.c              | 281 +++++++++++++++++++++++++++
 lib/acpi/Makefile                    |   2 +-
 lib/acpi/acpi_writer.c               |   4 +-
 15 files changed, 336 insertions(+), 244 deletions(-)
 create mode 100644 board/emulation/configs/acpi.config
 create mode 100644 doc/board/emulation/acpi.rst
 create mode 100644 drivers/misc/qfw_acpi.c

-- 
2.40.1

