Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5B2C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 15:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3023D883D1;
	Wed,  5 Jun 2024 17:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63CA88365; Wed,  5 Jun 2024 17:56:36 +0200 (CEST)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB0F88258
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 17:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvXBp36cXz14Gg;
 Wed,  5 Jun 2024 17:56:34 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvXBn58CDz9jM; Wed,  5 Jun 2024 17:56:33 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 05 Jun 2024 17:56:11 +0200
Subject: [PATCH next v2 6/6] rockchip: ringneck-px30: fix TPL_MAX_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-misc-tsd-v2-6-12479432c90f@cherry.de>
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

Ringneck was mistakenly set to allow up to 128KiB for the TPL code size
while PX30 SoC only has 16KiB of SRAM.

Therefore, let's use the default value of TPL_MAX_SIZE from the SoC
(which is 10KiB) so that the max code size is actually checked and
useful.

Fixes: c925be73a0a8 ("rockchip: add support for PX30 Ringneck SoM on Haikou Devkit")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/ringneck-px30_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index a22d25e0089..9965e55d611 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -14,7 +14,6 @@ CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_DEBUG_UART_BASE=0xFF030000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
-CONFIG_TPL_MAX_SIZE=0x20000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y

-- 
2.45.1

