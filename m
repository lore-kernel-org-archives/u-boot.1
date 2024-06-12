Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9741BC27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 14:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F3A3887DB;
	Wed, 12 Jun 2024 16:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B2788805; Wed, 12 Jun 2024 16:41:12 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB603887C3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 16:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VzpBY26tWz5Gl;
 Wed, 12 Jun 2024 16:41:09 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VzpBX3dn6z8H7; Wed, 12 Jun 2024 16:41:08 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Jun 2024 16:40:49 +0200
Subject: [PATCH 2/2] rockchip: puma-rk3399: get closer to other Theobroma
 defconfigs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-ringneck-bootd-v1-2-f0bc3816b822@cherry.de>
References: <20240612-ringneck-bootd-v1-0-f0bc3816b822@cherry.de>
In-Reply-To: <20240612-ringneck-bootd-v1-0-f0bc3816b822@cherry.de>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 heiko@sntech.de
X-Mailer: b4 0.14-dev-a6ee3
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Disable support for unused OSes as Linux is the primary target.

Disable support for bootz as zImage isn't a format compatible with
Aarch64 machines so it should never be attempted to be booted.

Enable a bunch of commands:
 - erofs
 - gpio
 - squashfs

that could be useful and are also found in Jaguar and Tiger defconfigs.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/puma-rk3399_defconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 34a0b575991..3196b5e24b1 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -29,7 +29,12 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_TPL=y
-CONFIG_CMD_BOOTZ=y
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_CMD_VBE is not set
+# CONFIG_BOOTM_VXWORKS is not set
+CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
@@ -41,6 +46,8 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EROFS=y
+CONFIG_CMD_SQUASHFS=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_OVERWRITE=y

-- 
2.45.2

