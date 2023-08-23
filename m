Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E67EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB97086421;
	Wed, 23 Aug 2023 15:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="dh1zQ/oN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B43BE864BA; Wed, 23 Aug 2023 15:59:29 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB5118641F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1qYoNs-001Zv1-98; Wed, 23 Aug 2023 15:58:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1692799167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=f2SD+flkWK0M7JQ3P7+7Dxxky3MekCe6ZHVt3q5kq1A=;
 b=dh1zQ/oNdYAU/RfbzyAKZjUYAeMLXTnGieGBjYr3pKFXxOuY2r2r8beskTpd9tIv9yzsV0
 x9SSNVzZraL2WjuiZ3I+D+y/3N7nHskEqVY5hjf1sUntlLhR2PDHch2TnxY2edWng7Igc/
 Fgtfeur8OJqx41TDNaLJTpbTZutkW5sbvvmmi8lUhNnpzHNJ2UVP+C+IOGlT5PDq7W1TEX
 YHWADcyJWlyaEhWvRM/zyRqaLW5L/xugprDwDfjjPUZVN08w0gNKbJDJGjWT3B2RgrSVsZ
 YQt8EXu7r5LI5JK8pLp3KCpfXq1E8aDFhcNBCj5gfkXj2azpa5pfB2JA3J4EWA==
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: Sergiu Moga <sergiu.moga@microchip.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/5] at91: sam9x60-curiosity: Misc improvements
Date: Wed, 23 Aug 2023 15:58:51 +0200
Message-Id: <20230823135856.376351-1-ada@thorsis.com>
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

while working with the sam9x60-curiosity board I noticed some things
still have rough edges on U-Boot shell for that device.  With these
patches (and some more config options enabled), the following commands
now work as expected: reset, led, button.

The whole series is based on atmel/next.

Note: some things here might be useful to implement for other Microchip
boards.  However I currently only have this one board, and I'm not sure
if this is a direction appreciated by Microchip?  So you might see all
this as suggestion.

See notes on patches for specific changes from v1 to v2 and below for
summary of the changes.

Greets
Alex

v1 -> v2:
  - reworded some commit messages
  - reenabled CONFIG_SYSRESET and CONFIG_SYSRESET_AT91
  - split up LED patch in two new patches

Alexander Dahl (5):
  configs: at91: sam9x60_curiosity: Sync both defconfig variants
  configs: at91: sam9x60: Switch to new reset driver
  ARM: dts: at91: sam9x60-curiosity: Sync LED nodes from Linux
  board: sam9x60-curiosity: Let LED subsystem init leds if enabled
  ARM: dts: at91: sam9x60-curiosity: Sync gpio button from Linux

 .../dts/at91-sam9x60_curiosity-u-boot.dtsi    | 18 +++++++
 arch/arm/dts/at91-sam9x60_curiosity.dts       | 50 +++++++++++++++++++
 .../sam9x60_curiosity/sam9x60_curiosity.c     | 18 +++++++
 configs/sam9x60_curiosity_mmc1_defconfig      |  2 +
 configs/sam9x60_curiosity_mmc_defconfig       | 17 ++++++-
 configs/sam9x60ek_mmc_defconfig               |  2 +
 configs/sam9x60ek_nandflash_defconfig         |  2 +
 configs/sam9x60ek_qspiflash_defconfig         |  2 +
 8 files changed, 110 insertions(+), 1 deletion(-)


base-commit: 0498ff933813932ff057cdc314ab46df4a596d06
-- 
2.30.2

