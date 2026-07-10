Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8DDC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 20:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DE9D84ABE;
	Fri, 10 Jul 2026 22:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="N5DdOQCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0FDC84AD6; Fri, 10 Jul 2026 22:16:47 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B97B5849BA
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 22:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 38C18B00548;
 Fri, 10 Jul 2026 22:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783714604;
 bh=F80P4w4tb9KMTRjHoDKsPL+Ss46Qt6CtJ/zVi/SFPdk=;
 h=From:To:Cc:Subject:Date:From;
 b=N5DdOQCygh7WMQ+HXOW+Vmrhh88SXYeVFPJ/8amlRwfbfie43UwepKZjawtb2iwuP
 Z94dRn9ANjhoZClnrgLxThpsZKLvFP+VOqbiuKwS66SWl0/L3UVEFHcBXyQ8vBXiP9
 LNcB1wtXczt7zFsxHyxQ+aAf7VOr7a/c3XSDgcOMGLeTQyfCh2kyD9zbCYrhF+abik
 xZVoBUxjgPu1UFB0GbYzybCgar1EFIXKlY8MG5i3wiVgedMb+uy0pqhog62dFzyhFy
 Vf5h3oldhNy+y7bhDOlb+6l7yLInb1Qt3NWUfeQf02Pv/MxEjO6QLchCJPiaZjNYc0
 Vf+kate8A4EVQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Vincent Jardin <vjardin@free.fr>, Alice Guo <alice.guo@nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: [PATCH v4 0/7] pmbus: PMBus 1.x framework, CLI,
 regulator and thermal support
Date: Fri, 10 Jul 2026 22:16:05 +0200
Message-ID: <20260710201631.2469728-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


This series adds U-Boot's PMBus 1.x support as a small boot-time
layer (not a hwmon clone):

  - a decoder + transport library and the pmbus CLI command
  - a shared UCLASS_REGULATOR adapter plus a catch-all driver for
    compliant chips, add the MPS MPQ8785 per-chip driver
  - a generic PMBus die-temperature UCLASS_THERMAL bridge
  - migration of the shared NXP VID rail-trim code to this framework
  - a sandbox PMBus chip emulator and "ut dm pmbus" unit tests that
    exercise most subcommand of the CLI.

The goal is to identify PMBus regulators at boot, print telemetry and
decode chip alerts before the kernel takes over - no polling, no
sysfs, no fan loops. Linux owns the runtime side.

Changes in v4:
- CLI: <addr>, <reg> and <val> hexadecimal ("0x" optional)
  à la i2c command convention
- sandbox_pmbus_read(): reject len < 1 (Simon Glass)
- reject block reads shorter than length + payload (except the
  one-byte SMBus length probe) so the length byte never lies about
  the data actually returned (Simon Glass)
- CAPABILITY: drop the PEC bit (0xb0 -> 0x30), the stub implements
  no PEC (Simon Glass)
- configs/sandbox_defconfig: use savedefconfig (Simon Glass)
- drop console_record_reset() (Simon Glass)
- drop "0x" prefixes from hex command arguments. It
  parses addr/reg/val as hex based on i2c convention (Simon Glass)

Changes in v3:
- pmbus_read_string(): fix 1 byte stack overflow
- pmbus dump: print MFR_ID/MODEL/REVISION with the proper byte order
- typo: Adaapted -> Adapted
- vid_read_vout_mode(): avoid confusions error vs mode.

Changes in v2:
- Apply Tom Rini's v1 review: drop the local DT binding YAML files

Vincent Jardin (7):
  pmbus: add PMBus 1.x framework, CLI, and binding
  power: regulator: add generic PMBus UCLASS_REGULATOR adapter
  power: regulator: add MPS MPQ8785 PMBus regulator driver
  board: nxp: vid: introduce PMBus framework support
  thermal: pmbus: add PMBus die-temp driver
  test: dm: pmbus: add a sandbox PMBus chip emulator
  test: dm: pmbus: test pmbus command and framework

 MAINTAINERS                             |  15 +
 arch/Kconfig.nxp                        |   4 +
 arch/sandbox/dts/test.dts               |  10 +
 board/nxp/common/vid.c                  | 110 +--
 board/nxp/common/vid.h                  |  15 +-
 cmd/Kconfig                             |  14 +
 cmd/Makefile                            |   1 +
 cmd/pmbus.c                             | 814 ++++++++++++++++++++++
 configs/sandbox_defconfig               |   6 +
 doc/develop/index.rst                   |   1 +
 doc/develop/pmbus.rst                   | 637 +++++++++++++++++
 drivers/power/regulator/Kconfig         |  43 ++
 drivers/power/regulator/Makefile        |   4 +
 drivers/power/regulator/mpq8785.c       | 494 +++++++++++++
 drivers/power/regulator/pmbus_generic.c |  90 +++
 drivers/power/regulator/pmbus_helper.c  | 315 +++++++++
 drivers/power/regulator/pmbus_helper.h  |  90 +++
 drivers/power/regulator/sandbox_pmbus.c | 171 +++++
 drivers/thermal/Kconfig                 |   8 +
 drivers/thermal/Makefile                |   1 +
 drivers/thermal/pmbus_thermal.c         |  33 +
 include/pmbus.h                         | 667 ++++++++++++++++++
 lib/Kconfig                             |  16 +
 lib/Makefile                            |   1 +
 lib/pmbus.c                             | 877 ++++++++++++++++++++++++
 test/dm/Makefile                        |   1 +
 test/dm/pmbus.c                         | 242 +++++++
 27 files changed, 4625 insertions(+), 55 deletions(-)
 create mode 100644 cmd/pmbus.c
 create mode 100644 doc/develop/pmbus.rst
 create mode 100644 drivers/power/regulator/mpq8785.c
 create mode 100644 drivers/power/regulator/pmbus_generic.c
 create mode 100644 drivers/power/regulator/pmbus_helper.c
 create mode 100644 drivers/power/regulator/pmbus_helper.h
 create mode 100644 drivers/power/regulator/sandbox_pmbus.c
 create mode 100644 drivers/thermal/pmbus_thermal.c
 create mode 100644 include/pmbus.h
 create mode 100644 lib/pmbus.c
 create mode 100644 test/dm/pmbus.c

-- 
2.43.0

base-commit: f605dcee103c897b6f1a8873549a36949bd4e2a1
branch: for-upstream/pmbus-v7
