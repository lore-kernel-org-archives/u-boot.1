Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282A1CD6E64
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 13:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B05585423;
	Wed, 11 Oct 2023 15:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F92286C33; Wed, 11 Oct 2023 15:16:28 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2450585423
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 15:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp83t1697030154tjl7m69d
Received: from ubuntu.. ( [111.196.129.4]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 21:15:52 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: 3M0okmaRx3hdYyJne62VqnKyXbjoTtl30zLyxtNutB1OKYm1TkGjLYrY3y8kT
 Cdz/y1TOe61XIUGABj6cFMtc3ekrtGhnHi+Dam5TqIDYnmdhj/+9te4boZmcsyHAWERDHgR
 BjFBGs+BnFoNwYz1rmceW0kKyl4BZGsKGNFCshe3j3DMtcUtmBkxNM68qrlhcV3bnDrKmSu
 qOMFXrszoHZ1nf2H6bm7d2JdLWDBmMTXXqpDXEpi7F7i1ylDKVVPXl4vpozP3ZrK1SL5+ST
 uJdr5JVyvlIJIlkmXXuMBnG7YuZbTNXkk/MvTvqEwQMAVj/xDERrXZBuKeIV9i1c9VOTkqc
 Vwr0v1hk5+hafd1xCSeP/2GzKbzfUIkqiIDr0ZyAVwfxoo4lc4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16090740394536989669
From: Bin Meng <bmeng@tinylab.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/9] ufs: Add a PCI UFS controller support
Date: Wed, 11 Oct 2023 21:15:43 +0800
Message-Id: <20231011131552.14665-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

This adds a PCI UFS controller support and enables the support on
QEMU RISC-V for testing.

Requiring QEMU v8.2+.

This series is avaiable at u-boot-x86/ufs for testing.

Changes in v2:
- fix a build warning

Bin Meng (9):
  ufs: Correct the UFS terminlogy
  ufs: Add a line feed to the end of some dev_xxx() messages
  cmd: kconfig: Make ufs prompt look similar to other commands
  cmd: ufs: Correct the help text
  pci_ids: Add Red Hat vendor and device IDs
  ufs: Allow mmio registers on the PCI bus
  ufs: Add a PCI based UFS controller driver
  ufs: Handle UFS 3.1 controllers
  qemu: riscv: Enable UFS support

 board/emulation/qemu-riscv/Kconfig |  2 ++
 cmd/Kconfig                        |  2 +-
 cmd/ufs.c                          |  2 +-
 doc/board/emulation/qemu-riscv.rst |  8 +++++-
 drivers/ufs/Kconfig                | 11 ++++++++
 drivers/ufs/Makefile               |  1 +
 drivers/ufs/ufs-pci.c              | 45 ++++++++++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c           |  2 +-
 drivers/ufs/ufs.c                  | 31 ++++++++++++--------
 drivers/ufs/ufs.h                  |  1 +
 include/pci_ids.h                  |  7 +++++
 11 files changed, 97 insertions(+), 15 deletions(-)
 create mode 100644 drivers/ufs/ufs-pci.c

-- 
2.34.1

