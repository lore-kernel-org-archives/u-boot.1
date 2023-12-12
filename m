Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1A1C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78CC087800;
	Tue, 12 Dec 2023 17:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="KaDMu1vv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3723E877E1; Tue, 12 Dec 2023 17:04:44 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99C58760D
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1rD5F9-000BXB-U7; Tue, 12 Dec 2023 17:04:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1702397079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=TDlidrbJin3XO3NNAdN7M0tu3uBmnycMekN9Y00XE9I=;
 b=KaDMu1vvFwzYsyNL66AJYFfotvY5yhraMzS/qPQk3VzP6xtFiViS7YPCUs9AZ6676xrehV
 /XsIimDb6batSfvr7HmPkLJVXuo1ryNfPczXveumPQfScj0uM9ExGOO6+7fOOCzZ0tDw/c
 MkkolVb32vpfahevpOfYoluV6A8Wq9Pcf2pnjDlHD0yYWU+s+spyGLEsehIrntbD+OiYG4
 z7a1HHRkQxzdOyjblKr848TE7EWtqVJ2Fk6zdPoT5FjFK4Ab48N6Ie5glnaWVBLbpOM7vP
 9knF2qNi7FnyrYFVZL2ItCtWDVoh+N8gLC/DbqxoDueplbmoBXPTEWkdgZv9ig==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Wenyou Yang <wenyou.yang@microchip.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH 0/4] Facilitate new atmel raw nand driver for SAMA5D2
Date: Tue, 12 Dec 2023 17:04:19 +0100
Message-Id: <20231212160423.44290-1-ada@thorsis.com>
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

Hei hei,

for some downstream boards with SAMA5D27 SiP SoCs with raw NAND flash I
added the necessary nodes to sama5d2.dtsi with just one little
guesswork: the clocks.  Motivation was to fix reading from raw nand
flash which failed on some of those boards, while others worked fine.
So I suppose the timings for the external interface were set to too slow
values. (IIRC I took them from the sama5d2_ptc_ek_nandflash board code
back in 2019.)

The solution was basically to switch from the old non-DM driver with
hardcoded timings for the external memory interface to the new DM based
driver introduced earlier this year, which sets the timings based on
ONFI parameters read from the flash chip.

Works for me, but I have no boards with that SoC _and_ a raw NAND flash
at hand, which are supported by upstream U-Boot.  The only matching
upstream config is sama5d2_ptc_ek_nandflash_defconfig but because we
don't have that board, I did not touch it.

(When that driver was added with 6a8dfd57220d ("nand: atmel: Add DM
based NAND driver") the author claims in the commit message it was
tested on SAMA5D3, but none of the sama5d3 configs actually uses it.)

Some more changes to the board dts are necessary, but porting from Linux
is straightforward.  The necessary changes to the defconfig should look
like this:

 # CONFIG_I2C is not set
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_ATMEL_EBI=y
+CONFIG_MFD_ATMEL_SMC=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
-CONFIG_NAND_ATMEL=y
-CONFIG_ATMEL_NAND_HW_PMECC=y
-CONFIG_PMECC_CAP=8
+CONFIG_DM_MTD=y
+CONFIG_DM_NAND_ATMEL=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_PHY_SMSC=y
 CONFIG_MACB=y

Hope the changes are acceptable nevertheless.  The last patch has a
trivial fix for the new atmel raw nand driver which I came up with while
working on this.

Greets
Alex

Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Wenyou Yang <wenyou.yang@microchip.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>

Alexander Dahl (4):
  ARM: dts: at91: sama5d2: Move sfr node
  ARM: dts: at91: sama5d2: Port ebi/nand nodes from linux
  ARM: dts: at91: sama5d2: Align more node names with Linux
  mtd: nand: raw: atmel: Remove duplicate definitions

 arch/arm/dts/sama5d2.dtsi          | 74 ++++++++++++++++++++++++++----
 drivers/mtd/nand/raw/atmel/pmecc.c |  3 --
 2 files changed, 65 insertions(+), 12 deletions(-)


base-commit: 2f0282922b2c458eea7f85c500a948a587437b63
-- 
2.39.2

