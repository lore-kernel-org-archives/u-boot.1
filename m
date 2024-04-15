Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D447C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D653788134;
	Mon, 15 Apr 2024 09:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="tjQlkhX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E7288155; Mon, 15 Apr 2024 09:46:01 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D4DE870D2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C5D9C148D064; Mon, 15 Apr 2024 09:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1713167154; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=r/8ftVKwWTg2vgsUB4dOIdzcb+slFBE/okr9rH3P06s=;
 b=tjQlkhX9Jrn/NfaU81W0DHgXBkI9ei6OTDLSBzBChwyN/EqkrYfnqMwkhzgZzadI8hkZrM
 mjOUsPdNhEGBOIOL/sswB4L6W53ZGlAk2pfQwv969uF+9+9Ju1z6McW+5mxHbeAhJs0pBu
 C2mW7q2TKPR+HzbvNuIzCNBQBKDW0/A0ptp3vxepsJTFZNcnZTYSz/4I17iK0Umcyy+mJJ
 kcTCWPwaBp4oridYNKWb6NtzVMicF+NdSwDOMXElG9LVgQ6FKkC6XlS94BPwKYfRrWwN8v
 YN+pZkOZKjKb6Sb/sMlTuAUis/DlXdGk1rq1gdPPg28cXWQxmKq9XbMihLBLtQ==
From: Alexander Dahl <ada@thorsis.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>, Li Bin <bin.li@microchip.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3 0/3] mtd: nand: raw: Collected improvements
Date: Mon, 15 Apr 2024 09:45:44 +0200
Message-Id: <20240415074547.779264-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello everyone,

while working on NAND flash support for a custom board based on the at91
SAM9X60 SoC I stumbled over some issues in the raw nand subsystem.

Some trivial patches of previous iterations of this series were already
applied.

Patch 1 introduces a new subcommand for the new atmel nand controller
driver.  Patch 2 introduces a new subcommand for the nand command to
override ONFI timing mode.  Both are are for debugging purposes only and
thus optional, and need to be enabled through menu.  Both helped me a
lot when investigating issues.  Patch 3 is a fix carried over from
at91bootstrap for faster at91 SoCs with certain raw NAND chips.

Series is based on post v2024.04 master now.

Greets
Alex

v3:

- 4 patches removed, applied to master
- other 2 patches from v2 unchanged, still under test
- added new third patch with a fix for atmel nand timings (forgot to
  send that with v2)

v2:

Link: https://lore.kernel.org/u-boot/20240320090214.40465-1-ada@thorsis.com/

- rebased on recent next
- collected tags
- improved patch 4 after feedback from Mihai
- added new patch 5 with another help text fix
- added new patch 6 with a new debug command
- reworded cover letter

v1:

Link: https://lore.kernel.org/u-boot/20240307091014.39796-1-ada@thorsis.com/

See per patch changes in patches for more detailed changes.

Alexander Dahl (3):
  mtd: nand: raw: atmel: Introduce optional debug commands
  cmd: nand: Add new optional sub-command 'onfi'
  mtd: nand: raw: atmel: Fix pulse read timing for certain NAND flashes

 cmd/Kconfig                                  |  10 +
 cmd/nand.c                                   |  61 ++++
 drivers/mtd/nand/raw/Kconfig                 |   9 +
 drivers/mtd/nand/raw/atmel/nand-controller.c | 308 ++++++++++++++++++-
 drivers/mtd/nand/raw/nand_base.c             |   2 +-
 include/linux/mtd/rawnand.h                  |   1 +
 6 files changed, 386 insertions(+), 5 deletions(-)


base-commit: b03b49046af5dfca599d2ce8f0aafed89b97aa91
-- 
2.39.2

