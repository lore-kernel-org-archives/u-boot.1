Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65618C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 15:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9A9987F00;
	Mon, 11 Mar 2024 16:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="VyHkkCMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2529587EEB; Mon, 11 Mar 2024 16:23:12 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C4687E88
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 16:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710170587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=Kc2E5treAWwibWP5Iv6Ea+jsuh5zmLs7aRFWxO92N/M=;
 b=VyHkkCMp1nM1C7FPqD0VMsvJWQCInnp0Td320SZEHWyxJ4jxXkBYDg64T95lCtEOtwAIaZ
 kUjfngSo5qIVK2p4MgcWLOBrwDOg4taGmyk5M/D419/v6xw16zD/uI9aGAepIPOMya13an
 EKVV+1RCaBW3ARNNb3RVkCxWSphU2GfI7AGbiF+d7dlAkScStSUZJnWU9WogtS+iEKbo1Q
 KZEr+JqPu9Ku5Oh4ELSchFW9IEyUOYRMeInx2jZqEFA8QMEB/tiWHA/Q3unQVJUBCZ1MHK
 SHmtgk86E9vK38lmFAWOlPe9I/A2AwQ45MN0KW/lKkWJ+Izpnoia1dVQdXvz6Q==
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>
Subject: [RFC PATCH 0/3] mtd: nand: raw: atmel: Using dm driver for older sam9
 SoCs
Date: Mon, 11 Mar 2024 16:23:03 +0100
Message-Id: <20240311152306.2358845-1-ada@thorsis.com>
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

Hello raw NAND fans,

today I thought it would be interesting to have all that automatic NAND
flash timings setting usable with an old board featuring a at91sam9g20
SoC, which would pave the way to get rid of the old atmel raw nand
driver eventually.  My "let's try this quickly" ended up in "damn this
took hours and now I'm stuck".

Those older SoCs have no hardware ecc engine like the sama5d2 or sam9x60
have, which the Linux driver can work with.  (The U-Boot driver was
ported from Linux back then.)

The problem is NAND flash detection fails because the atmel nand
controller drivers fails on probing.  In fact
`atmel_nand_controller_init()` tries to set the pointer `nc->pmecc` by
calling `devm_atmel_pmecc_get()`.  That one probably gets a
-EPROBE_DEFER returned by `atmel_pmecc_get_by_node()` and then
`atmel_nand_controller_init()` returns -EPROBE_DEFER too and probing the
driver fails.  I suspect it should work fine if `nc->pmecc` would be
NULL, but I have no idea what would be the right place to implement
this.  I also suspect that -EPROBE_DEFER contradicts the U-Boot driver
model somehow?  The raw/atmel/nand-controller driver was adapted (quite
a bit) to work with U-Boot, but maybe some aspects of U-Boot driver
model where not considered correctly?

The attached patches are what I have so far, marked them as RFC because
my actual goal of using the new dm based driver for the old SoC was not
completed.

Greets
Alex

P.S.: Patch stack based on next.

Alexander Dahl (3):
  ARM: dts: at91sam9260: Add modern NAND controller nodes
  memory: atmel-ebi: Add compatible for older 9260 cores
  mtd: nand: raw: atmel: Remove redundant PMECC probe

 arch/arm/dts/at91sam9260.dtsi                | 47 ++++++++++++++++++++
 drivers/memory/atmel_ebi.c                   |  1 +
 drivers/mtd/nand/raw/atmel/nand-controller.c |  7 ---
 drivers/mtd/nand/raw/atmel/pmecc.c           |  1 +
 4 files changed, 49 insertions(+), 7 deletions(-)


base-commit: beedf675b36841ce1e077779157a87a6505317e6
-- 
2.39.2

