Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5853C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 13:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA1AB82F33;
	Fri, 27 Jun 2025 15:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA1082FCA; Fri, 27 Jun 2025 15:30:40 +0200 (CEST)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7829E82E35
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 15:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bTGdh6s0Vz2G0;
 Fri, 27 Jun 2025 15:30:32 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bTGdh1dHwzllY; Fri, 27 Jun 2025 15:30:32 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/4] rockchip: theobroma-systems: enable CMD_ERASEENV
 command for all boards
Date: Fri, 27 Jun 2025 15:30:15 +0200
Message-Id: <20250627-tsd-eraseenv-v1-0-46b69659f879@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOecXmgC/x3MQQqAIBBG4avErBNMsKKrRAtxfms2Fk5EEN09a
 fkt3ntIUQRKU/NQwSUqe67o2obiFvIKI1xNzjpvezeYU9mgBAXyZbxNkcPoGRZUk6Mgyf3v5uV
 9P+VClZxeAAAA
X-Change-ID: 20250627-tsd-eraseenv-50fcda85de0e
To: Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

This enables the CMD_ERASEENV (`env erase`) command for all Theobroma
boards as this is very useful to start from a fresh environment instead
of doing what I used to do (which doesn't actually work properly):

env default -a && env save

Tested on SD card on all boards. Also tested on SPI-NOR on RK3399 Puma.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (4):
      rockchip: tiger-rk3588: enable "env erase" command
      rockchip: jaguar-rk3588: enable "env erase" command
      rockchip: ringneck-px30: enable "env erase" command
      rockchip: puma-rk3399: enable "env erase" command

 configs/jaguar-rk3588_defconfig | 1 +
 configs/puma-rk3399_defconfig   | 1 +
 configs/ringneck-px30_defconfig | 1 +
 configs/tiger-rk3588_defconfig  | 1 +
 4 files changed, 4 insertions(+)
---
base-commit: 359e3012921f2fc2d43f3c4e320a752173f82b82
change-id: 20250627-tsd-eraseenv-50fcda85de0e

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

