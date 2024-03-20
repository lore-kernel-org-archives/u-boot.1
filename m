Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68104C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 09:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2593880F8;
	Wed, 20 Mar 2024 10:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="hToPYcCv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97850880E5; Wed, 20 Mar 2024 10:02:22 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA8D880E5
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 10:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710925336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=ShD8VackadON5KJ7YYNSSBno5rz+p2hSLg4Nqpiqo9U=;
 b=hToPYcCvouH2CAVOdFfqjTYraDFMgbBwnRj0dRY8bgSzBOGP+Sf8aQwM+FxwxXqD2xQRyl
 XZQYBstdg+iBvdEU505BCXWx6UJHhtnmpRFmq7WgY8vi8eqk8VtsjkR3dTNsaz290DEG0q
 bTQ2/7MUL88frDe2jwvgCAW8WkCD1sjsLl/zRMi+AXxVU2j3SiyWCKiFnu56YPnCkB1T+J
 gHG9+68u+MrQO8Chb2X7K72JeT68SBUp78uj2emuigT9txPn4aHNB85cS62G0GicF/ymN6
 sTWUl0xncBqG5vGuFm80BrVti7+WaYJcOp9RjPRFJwhRU604RCJYcfn0d22gjQ==
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Mihai Sain <mihai.sain@microchip.com>, Li Bin <bin.li@microchip.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 0/6] mtd: nand: raw: Collected improvements
Date: Wed, 20 Mar 2024 10:02:08 +0100
Message-Id: <20240320090214.40465-1-ada@thorsis.com>
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

Hello everyone,

while working on NAND flash support for a custom board based on the at91
SAM9X60 SoC I stumbled over some issues in the raw nand subsystem.

Four of six patches are minor fixes.

Patch 4 introduces a new subcommand for the new atmel nand controller
driver.  Patch 6 introduces a new subcommand for the nand command to
override ONFI timing mode.  Both are are for debugging purposes only and
thus optional, and need to be enabled through menu.  Both helped me a
lot when investigating issues.

Series is based on upstream next branch, but should also apply to master
cleanly.

Greets
Alex

v1:

Link: https://lore.kernel.org/u-boot/20240307091014.39796-1-ada@thorsis.com/T/#t

v2:

- rebased on recent next
- collected tags
- improved patch 4 after feedback from Mihai
- added new patch 5 with another help text fix
- added new patch 6 with a new debug command
- reworded cover letter

See per patch changes in patches for more detailed changes.

Alexander Dahl (6):
  mtd: nand: raw: Use macro nand_to_mtd() where appropriate
  mtd: nand: raw: Port another option flag from Linux
  mtd: nand: raw: Fix (most) Kconfig indentation
  mtd: nand: raw: atmel: Introduce optional debug commands
  mtd: nand: raw: atmel: Fix comment in timings preparation
  cmd: nand: Add new optional sub-command 'onfi'

 cmd/Kconfig                                  |  10 +
 cmd/nand.c                                   |  61 ++++
 drivers/mtd/nand/raw/Kconfig                 | 115 +++----
 drivers/mtd/nand/raw/atmel/nand-controller.c | 299 ++++++++++++++++++-
 drivers/mtd/nand/raw/nand_base.c             |   8 +-
 include/linux/mtd/rawnand.h                  |   8 +
 6 files changed, 441 insertions(+), 60 deletions(-)


base-commit: f048104999db28d49362201eaebfc91adb14f47c
-- 
2.39.2

