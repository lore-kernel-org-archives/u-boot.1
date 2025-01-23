Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3080FC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 12:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490AD807D7;
	Thu, 23 Jan 2025 13:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="HeXYlICq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA293807B4; Thu, 23 Jan 2025 13:12:25 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589B180137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 13:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5627F148A1D9; Thu, 23 Jan 2025 13:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737634342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qEFvRBO4EnoTnG7Sp7G1P85GP8swufBjkngxXzLxges=;
 b=HeXYlICqIU2RhEox4ggqrrtJrRRW8eqdQeqeMIDLZaz37KRL1IH19ziQpoGklaJmCGeg+A
 5ar/zlDx6w2YDE98UZ0c/UOH7l6gy0ZYuoK2VlPlYsi43Bc/ZzOhM3FnTu8PLTh6DH5yXu
 WcBMfRYZz1/pFGf3TL45SLpLQxCWJyJJ8sbhv9usB13RF2+H9QWgbtPhVegKNGgkHUmxIk
 5EWdhXGn+t/y2h8x2YyVw5J8hi5JkYILcwSMJ/VwrEFLvs75RM9d82Q7zzfeIlEQ1WjpVA
 quV4mt7jinWU9lSEejQ7ODLU5G6KKaHK+1VzRuINQ6NFOss6hoIdvCUR9Z/G/w==
From: Alexander Dahl <ada@thorsis.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
 Eugen Hristev <eugen.hristev@microchip.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 u-boot@lists.denx.de, Yoshitaka Ikeda <ikeda@nskint.co.jp>
Subject: [PATCH 0/7] [U-Boot] spi: atmel-quadspi: Refresh and add classic mode
 support
Date: Thu, 23 Jan 2025 13:12:08 +0100
Message-Id: <20250123121215.21001-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

this patch series is for U-Boot, although Linux might be affected.

The quadspi controller on microchip (former atmel) sama5d2, sam9x60 and
other soc variants of the at91 family is usually used in hardware
accelerated spi-mem mode.  It also supports a classic mode for
interfacing all kinds of SPI peripherals like ADCs, IO expanders,
displays, you name it.  However the drivers in Linux and U-Boot did not
support that mode, yet.

While spi-mem subsystem interface is comparable between Linux and
U-Boot, SPI subsystem interface is rather different in Linux and U-Boot.
So there's no previously written Linux support just ported here.  I
tried that, but the simple implementation for U-Boot's .xfer() used here
does not work for Linux' .transfer_one() because of the OVRES flag set
all the time.  I guess a more sophisticated approach has to be taken in
Linux with interrupts, completions and/or dma?

According to commit 24c8ff4684c5 ("spi: Add Atmel QuadSPI driver")
message, the initial U-Boot variant of this driver was ported from Linux
v5.1-rc5 back then.  I hope it's okay to squash the fixes added to Linux
after that into patch 2 and 3 of this series?

Patch 4 and 5 come from my efforts to hack this feature into the Linux
driver.  (Not sure if those should be added to the Linux driver
anyways, even if nobody ever implements transfer_one() over there?)

Patch 5 is the actual work, very much inspired by the current U-Boot
driver atmel_spi for the generic SPI controllers on at91 family.

Patch 1 is copied from my other spi series for U-Boot, just added it
here for better build results.

Patch 6 is optional, because not portable towards Linux.

Tested on top of v2024.10, because v2025.01 won't build as debug
for sam9x60 as described in another thread.  But there are almost no
changes related to at91 socs, boards, and drivers in the last months
here, so it should be comparable.

Greets
Alex

(Cc-ing the contributors of the Linux fixes here.)
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Yoshitaka Ikeda <ikeda@nskint.co.jp>
Cc: Csókás Bence <csokas.bence@prolan.hu>

Alexander Dahl (7):
  spi: atmel-quadspi: Depend on SPI_MEM
  spi: atmel-quadspi: Port collected fixes from Linux v5.10 and v5.15
  spi: atmel-quadspi: Avoid overwriting MR register settings
  spi: atmel-quadspi: Remove default mode setting at probe time
  spi: atmel-quadspi: Allow setting SMM to classic SPI mode
  spi: atmel-quadspi: Add support for classic SPI mode
  spi: atmel-quadspi: Improve probe debugging

 drivers/spi/Kconfig         |   2 +-
 drivers/spi/atmel-quadspi.c | 294 ++++++++++++++++++++++++++++--------
 2 files changed, 228 insertions(+), 68 deletions(-)


base-commit: 2eed5a1ff36217372e19f7513bd07077fc76718a
-- 
2.39.5

