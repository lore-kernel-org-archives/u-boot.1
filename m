Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AF8CFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D38383B85;
	Sun, 23 Nov 2025 23:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SzpY+ycu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F277B83BD2; Sun, 23 Nov 2025 23:57:56 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D71B83B7E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AEE933F7C6; 
 Sun, 23 Nov 2025 22:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938672;
 bh=4ZQtk9wnumGiqkvyWPmGjN3CcaXSV67BiIDCQGQl/H0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SzpY+ycultC32118MfSDmTQPNDAZxBozY/OZ3iLoGcH5PctiyKnAlf/9xf+Nb0ZO/
 zmlvMoVXo0cJ/CFSg+LJaQ1EchPD0Ta6K0P6Bys9HTACUnFl3ikpCS5O90ZR0IN/C3
 wbpDALc5olnBmJKhr4IDIba7Dw0dqJFNtVyD55Ti/Tg+crWVHbBEI/0GKfcSXaXILr
 hVMeQoPY+U0bv3tKDk3Az3ym1/owTP6jJlYI/8mAIkK1dSnimlcvN8O9jXm3PA3Swo
 biWWuvs6f9hcwOzfA7nlSOCR3WRrVOOAPpprJFsF81BGcy3nJkR27byIwALUg11wwh
 WTxUO1Nju9wN4eHHZpCxkvpZFf7qDglgQFSJpoeOibdirQXJ+Ty5FPnvx6F9TxvYIP
 TBQ7X1oWmLNn21su2hpIqu91ku65svOqTcc0FXWDqV5STEOk0A3NRc47du0YcrnLYr
 RtqTmKHozKxBjVWuDWN43gXgg/faibYPCKCXcXUtspROYG5bPFbgWQoIO85M5TfdYa
 xcn5VeyBqAZVmBSSUqq1LRUuJaDIhKeFBwD3nb9DkfZAGdy1pkvEXD8zQCvTx+KthP
 nBkKvYdOGmafRkBd4vtm369grrXeynfvMdCYNRSN/zF924/aeUBwp1RCpan0BGmOsp
 F3n86hFUAJqLo1EnN8+aSlNI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 00/19] test: let UNIT_TEST imply CONSOLE_RECORD
Date: Sun, 23 Nov 2025 23:56:52 +0100
Message-ID: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Many C unit tests are not executed if CONFIG_CONSOLE_RECORD is not set.
Hence Tom suggested to let UNIT_TEST imply CONSOLE_RECORD.

The first patch makes the skipped C unit tests visible.

The rest of the series deals with hidden bugs in our tests.

The 'fdt get value' command returned incorrect values on low-endian
systems. So this needed fixing too.

Sorry Tom that the seris is so long. Most of the patches can be applied
independently. But all but the first are prerequisite for letting
UNIT_TEST imply CONSOLE_RECORD.

Gitlab CI results are here:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/28488

Heinrich Schuchardt (19):
  test: Let pytest indicate skipped C unit tests
  test: cmd/bdinfo: consider ARM architecture specific info
  test: print_display_buffer must consider 64bit support
  test: don't test for CONFIG_UNIT_TEST twice
  test: print_do_hex_dump test depends on HEXDUMP
  test: bdinfo: correct expected X86 arch info
  test: cmd_exit_test depends on CONFIG_HUSH_PARSER
  test: do not assume memory size 256 MiB in cmd_test_meminfo
  ppce500: increase SYS_MALLOC_F_LEN to 0x800
  test: the cmd/font test requires the sandbox
  test: correct comments in test/cmd/font.c
  test: fix bdinfo_test_all boot_params expectation
  malta: increase SYS_MALLOC_F_LEN and SYS_MALLOC_LEN
  test: consider endianness in print_display_buffer
  test: fix cmt/msr test
  test: relax cread_test time constraint
  test: cmd/bdinfo: consider PPC architecture specific info
  cmd: fix 'fdt get value'
  test: let UNIT_TEST imply CONSOLE_RECORD

 cmd/fdt.c                      | 26 ++++++++------
 configs/malta64_defconfig      |  2 --
 configs/malta64el_defconfig    |  2 --
 configs/malta_defconfig        |  2 --
 configs/maltael_defconfig      |  2 --
 configs/qemu-ppce500_defconfig |  1 +
 test/Kconfig                   |  2 ++
 test/Makefile                  |  4 +--
 test/cmd/Makefile              |  4 +--
 test/cmd/bdinfo.c              | 62 ++++++++++++++++++++++++++++++++--
 test/cmd/fdt.c                 |  2 +-
 test/cmd/font.c                |  4 +--
 test/cmd/meminfo.c             |  2 +-
 test/cmd/msr.c                 |  4 +--
 test/common/cread.c            |  9 ++---
 test/common/print.c            | 53 ++++++++++++++++++++++++++---
 test/py/tests/test_ut.py       |  7 ++++
 17 files changed, 148 insertions(+), 40 deletions(-)

-- 
2.51.0

