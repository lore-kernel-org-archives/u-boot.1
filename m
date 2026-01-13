Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A077CF45C6
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 01:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A0E836AC;
	Tue, 13 Jan 2026 02:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="RrmPU0s2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FDDF836C8; Tue, 13 Jan 2026 02:21:19 +0100 (CET)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41CB6836A3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1768267276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wGXyLTHJB3uCrX5hdiXOHymhYhIB0DY+XQN4Yt/ekOU=;
 b=RrmPU0s2vibOsAGrihxx+k5NJf4FyQ9bu3V/5UgKTzR40wHc58ZGQs5EWTRAU5or1MdMUM
 HOzl0vjGD586FnigQTucnjxjzaW/EbMTKw2NNAekzDFcMzofqajXjZ1zlhrqWffZne5hdg
 DMhplAZGt6GYjzAdV86CK2fzJXlkVwo=
From: Sean Anderson <sean.anderson@linux.dev>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 0/3] PCI: Add power sequencing driver for PCI slots
Date: Mon, 12 Jan 2026 20:20:34 -0500
Message-Id: <20260113012037.2566942-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Now with tests! This took longer than I thought it would...

Changes in v3:
- Use a parallel structure for emulation
- Add PCI bridge emulation
- Add a test

Changes in v2:
- Return early if there's no PERST GPIO
- Only mdelay if we need to
- Use CONFIG_IS_ENABLED to set .probe directly

Sean Anderson (3):
  PCI: sandbox: Use a parallel structure for emulation
  PCI: sandbox: Add PCI bridge emulation
  PCI: Add power sequencing driver for PCI slots

 arch/sandbox/dts/sandbox.dtsi         |  16 ++-
 arch/sandbox/dts/test.dts             | 132 +++++++++++++----
 arch/sandbox/include/asm/test.h       |   1 +
 configs/sandbox64_defconfig           |   2 +
 configs/sandbox_defconfig             |   2 +
 doc/develop/driver-model/pci-info.rst |  59 ++------
 drivers/misc/p2sb_emul.c              |   7 +-
 drivers/misc/swap_case.c              |   7 +-
 drivers/pci/Kconfig                   |   8 ++
 drivers/pci/Makefile                  |   2 +-
 drivers/pci/pci-emul-uclass.c         |  82 ++++++++---
 drivers/pci/pci-uclass.c              |  65 +++++++++
 drivers/pci/pci_sandbox.c             |  94 +++---------
 drivers/pci/pci_sandbox_bridge.c      | 192 +++++++++++++++++++++++++
 include/pci.h                         |   5 +-
 test/dm/pci.c                         | 199 ++++++++++++++++++++++++++
 16 files changed, 694 insertions(+), 179 deletions(-)
 create mode 100644 drivers/pci/pci_sandbox_bridge.c

-- 
2.35.1.1320.gc452695387.dirty

base-commit: 141be72e2a9d43aa4e3d1a6a6e0ab8f9eb8784c6
branch: pci_pwrseq
