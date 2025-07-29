Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3B7C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 13:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E6AB82B20;
	Tue, 29 Jul 2025 15:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DRopVXfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D97B382BA1; Tue, 29 Jul 2025 15:28:03 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ADDA81E13
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 15:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4brx3y6JRqz9t5q;
 Tue, 29 Jul 2025 15:27:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753795678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=InIEMF5dtL0vXQOy8qYrlO8L4Bc3eraEL81fcAtX+FI=;
 b=DRopVXfAMzqwpQjh9QVdlcf6WMe5rHvZFPsYZf6fZ0QxisXWevY8DDWM8Cl1gc9Q6SFtSH
 RPfKaGHGg7VmiXRPB+6olEWBcXaAs0Q80SCV4DQYHRapmxtWD5gm3q/wD7YIAY6WRkXxtr
 b6tx0s+xBjjcDO0fgBZX3fqLuGzLuE8ljhWWZshkaV5sEZZcK5OhcFFdDeTOQu1CDoImQE
 LG3vFOUUGNB/MSENG8Gk7mL/tjgFI38emk5q/YBLzUvFL7POsrJBWCLDp7qpCojBxKCOaN
 nY5kWM1WBk0ua+g26ZHFt2qlCn9fYn8LovlhUV9zDsDu/iydnWmHIG+1JrhdRw==
Message-ID: <9a29d856-02b9-4a30-8691-d43b90b21fbf@mailbox.org>
Date: Tue, 29 Jul 2025 15:27:58 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <stefan.roese@mailbox.org>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 863dc9d6e020f24f8c1
X-MBO-RS-META: owpc9xuoqy6n3aers7zwdgfwfbjrqx39
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

please pull this next batch of mostly Marvell related patches:

----------------------------------------------------------------
- cmd: tlv_eeprom: Minor improvements (Hugo)
- kirkwood: Enable bootstd and other modernization for ib62x0 board (Tony)
- spi: mvebu: Correct dependencies on MVEBU_A3700_SPI (Tom)
- ddr: marvell: a38x: Fix unsigned issues detected by smatch (Andrew)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=394&view=results

Thanks,
Stefan

The following changes since commit 182cb30084516c3085d2ca5dde3f105f7625d774:

   Prepare v2025.10-rc1 (2025-07-28 18:23:01 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-marvell.git 
tags/u-boot-marvell-20250729

for you to fetch changes up to b35ddfc57a49701835f46dba5b00417c2a444e33:

   ddr: marvell: a38x: Fix unsigned issues (2025-07-29 08:44:18 +0200)

----------------------------------------------------------------
Andrew Goodbody (1):
       ddr: marvell: a38x: Fix unsigned issues

Hugo Villeneuve (2):
       cmd: tlv_eeprom: fix typo errors in comments and error msg
       cmd: tlv_eeprom: improve mac_read_from_eeprom() log messages

Tom Rini (1):
       spi: mvebu: Correct dependencies on MVEBU_A3700_SPI

Tony Dinh (1):
       arm: kirkwood: Enable bootstd and other modernization for ib62x0 
board

  cmd/tlv_eeprom.c                                   | 18 +++++++-------
  configs/ib62x0_defconfig                           | 16 ++++---------
  .../marvell/a38x/mv_ddr4_training_calibration.c    | 13 +++++-----
  drivers/spi/Kconfig                                |  2 ++
  include/configs/ib62x0.h                           | 28 
+++++++++++++++++-----
  5 files changed, 43 insertions(+), 34 deletions(-)

