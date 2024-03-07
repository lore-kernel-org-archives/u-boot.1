Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F50C48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 09:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3A6287EBD;
	Thu,  7 Mar 2024 10:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="k0aEYyVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8256087EBD; Thu,  7 Mar 2024 10:10:25 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2D83875FC
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 10:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1709802616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=9lYvsY0fiIuk1Vx8u7KiiYuW5OgKkDOu2u0mcYWPmqw=;
 b=k0aEYyVmpo8u+WNFpP5ZvwJ7ANAbGExeLgdOCljGSfVlK241bvqusxpRL32Mf5wECz3eDf
 LnONG35cup6nH6QPx8NPvtxa7Hb66w4FMzUDJpBGcXKa66nhXfRDtqGzZyS2GHkvWQNmLk
 /PfxxGpB2Ghg33lzt3k65uh/oi2ZTXZxvDkAsgqpgzqwjZXYS0095vJoxCmRW0850eLIsW
 3huwyLCFfG4V8u27/462018VQiqWUnn2dus5MXnuXV21obVXnD7KmarQx7WSPXKD378WP/
 Ssb+dqFblDd/SybXT3qJm7dssWf4NPzRxknf5IaWSlHAb8FYgRTrECS89w4Tjg==
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH 0/4] mtd: nand: raw: Collected improvements
Date: Thu,  7 Mar 2024 10:10:10 +0100
Message-Id: <20240307091014.39796-1-ada@thorsis.com>
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
First three patches are minor fixes.  Fourth patch is introducing a new
subcommand for the new atmel nand controller driver, which helped me a
lot when investigating issues.

Series is based on upstream next branch, but should also apply to master
cleanly.

Greets
Alex

Alexander Dahl (4):
  mtd: nand: raw: Use macro nand_to_mtd() where appropriate
  mtd: nand: raw: Port another option flag from Linux
  mtd: nand: raw: Fix (most) Kconfig indentation
  mtd: nand: raw: atmel: Introduce optional debug commands

 drivers/mtd/nand/raw/Kconfig                 | 115 +++++----
 drivers/mtd/nand/raw/atmel/nand-controller.c | 251 ++++++++++++++++++-
 drivers/mtd/nand/raw/nand_base.c             |   6 +-
 include/linux/mtd/rawnand.h                  |   7 +
 4 files changed, 321 insertions(+), 58 deletions(-)


base-commit: 6eb682bc7ea398fad4aadb612c690884e73edc03
-- 
2.39.2

