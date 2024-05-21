Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7475C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2511588709;
	Tue, 21 May 2024 09:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eOOx3Wbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419EB8870C; Tue, 21 May 2024 09:13:44 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A43B187FA1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4019262024;
 Tue, 21 May 2024 07:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BDEC2BD11;
 Tue, 21 May 2024 07:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275619;
 bh=aYdE7Yz7TNGRPCM5b0bGfYQtQnE+imZliZigySm9Zr8=;
 h=From:To:Cc:Subject:Date:From;
 b=eOOx3WbobvqMFsPRQWXg/3idiMLkg6IHf3x2sA3Qrs2QGWbz4NH9tYvmTf9HdBtp6
 YQUocycWDSVbiOs4wtEqiv4JRZPv6tRA6VpRCGOr3BNCJ9kzM36jlxqo9MX+c3Zwuj
 3HzWKZgInIvgSbyk+eEzxHG3wiq78KbB1R477YQu1jZNWhdxLW2S0pe+JMNgXTJyz5
 JiWAY/CbDgwqXWV+PnN8N6U11Ns7oj0qaSDWSugidK7J1U0JgSYScM3qFX5YJQ+74H
 004vJsKrcgkjm4tgjgMlmHwOvoPiaGZSyQd7sq3pGbSBii/x3hsOrsaBMSR9Rc+6PN
 7DDEK9o/KTeQA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 00/11] 'eeprom' command improvements
Date: Tue, 21 May 2024 09:13:24 +0200
Message-ID: <20240521071335.4193-1-kabel@kernel.org>
X-Mailer: git-send-email 2.44.1
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

Hi Tom,

this series contains improvements for the 'eeprom' command:
- refactors
- fixes
- improvements
- ability to use driver model EEPROMs (uclass UCLASS_I2C_EEPROM)
- more flexible EEPROM layout support

It should not cause any behavior change for any existing board.

This series is a dependency for some DDR issue fixes for Turris Omnia.
I will be sending that one separately.

github PR link (with CI):
  https://github.com/u-boot/u-boot/pull/540
- there is a failure for
    test.py for sandbox sandbox_clang
  but it seems unrelated to these changes

Marek Behún (11):
  common: eeprom_layout: Assign default layout methods and parameters
    before specific ones
  common: eeprom_layout: Split field finding code from the field update
    function
  common: eeprom_field: Fix updating binary field
  common: eeprom_field: Drop unnecessary comparison
  cmd: eeprom: Fix usage help for the eeprom command
  cmd: eeprom: Hide eeprom layout versioning behind a Kconfig option
  cmd: eeprom: Deduplicate parse_i2c_bus_addr() calls
  cmd: eeprom: Refactor eeprom device specifier parsing
  cmd: eeprom: Refactor command execution into function by action
  cmd: eeprom: Don't read/write whole EEPROM if not necessary
  cmd: eeprom: Extend to EEPROMs probed via driver model

 cmd/Kconfig                   |   9 +-
 cmd/eeprom.c                  | 305 +++++++++++++++++++++++++---------
 common/eeprom/eeprom_field.c  |   4 +-
 common/eeprom/eeprom_layout.c |  54 +++---
 configs/cm_fx6_defconfig      |   1 +
 configs/cm_t43_defconfig      |   1 +
 include/eeprom_layout.h       |   4 +
 7 files changed, 273 insertions(+), 105 deletions(-)

-- 
2.44.1

