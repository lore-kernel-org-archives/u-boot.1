Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AFDC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 09:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A222F879C7;
	Wed, 25 Oct 2023 11:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05B22879D1; Wed, 25 Oct 2023 11:51:44 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2410587230
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 11:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA77BE000B;
 Wed, 25 Oct 2023 09:51:37 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, heiko@sntech.de
Subject: [PATCH 0/2] rockchip: ringneck-px30: always reset STM32 companion
 controller on boot
Date: Wed, 25 Oct 2023 11:51:13 +0200
Message-ID: <20231025-ringneck-stm32-reset-v1-0-052562bec53f@theobroma-systems.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: foss@0leil.net
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

It's happened that glitches on the STM32_RST and STM32_BOOT lines have
put the STM32 companion microcontroller into DFU mode making it not boot
its FW, rendering it useless for the user.

Considering that the STM32 companion microcontroller is always reset on
a reboot or power cycle, resetting it once again in U-Boot SPL isn't
going to hurt it any more.

For ATtiny companion microcontroller, the situation is a bit different
because a reboot or power cycle doesn't reset it. Additionally, since it
can only be reset with a UPDI reset on the STM32_RST line, and that is
virtually impossible to mistakenly trigger, the ATtiny is unlikely to be
in unwanted reset or enter reset because U-Boot toggles STM32_RST line.

This series adds this (sometimes) required reset of the MCU in U-Boot
SPL on Ringneck PX30 to recover from this unwanted DFU state.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Quentin Schulz (2):
      rockchip: ringneck-px30: always reset STM32 companion controller on boot
      rockchip: ringneck-px30: enable SPL_BOARD_INIT

 .../ringneck_px30/ringneck-px30.c                  | 52 ++++++++++++++++++++++
 configs/ringneck-px30_defconfig                    |  1 +
 2 files changed, 53 insertions(+)
---
base-commit: 351da15f71e3d70dbc63e90781b403415452d864
change-id: 20231024-ringneck-stm32-reset-b5b7e7355ae4

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>

