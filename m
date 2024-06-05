Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35997C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 15:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53DAE882E2;
	Wed,  5 Jun 2024 17:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA95B8831D; Wed,  5 Jun 2024 17:56:34 +0200 (CEST)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A8288250
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 17:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvXBl32Yhzd5t;
 Wed,  5 Jun 2024 17:56:31 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvXBk64X5zBFr; Wed,  5 Jun 2024 17:56:30 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 05 Jun 2024 17:56:06 +0200
Subject: [PATCH next v2 1/6] rockchip: jaguar-rk3588: use default env size
 for Rockchip on MMC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-misc-tsd-v2-1-12479432c90f@cherry.de>
References: <20240605-misc-tsd-v2-0-12479432c90f@cherry.de>
In-Reply-To: <20240605-misc-tsd-v2-0-12479432c90f@cherry.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
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

The default env size is 0x8000 when building for Rockchip SoCs with
support for environment stored in MMC.

Jaguar hasn't entered mass production just yet, so it's a breaking
change we can afford in the name of consistency.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/jaguar-rk3588_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index b69cf4cd057..36bf34d97c8 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
-CONFIG_ENV_SIZE=0x1f000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-jaguar"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_ROCKCHIP_BOOT_MODE_REG=0x0

-- 
2.45.1

