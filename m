Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51715C25B79
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 09:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2218C88582;
	Fri, 24 May 2024 11:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C435884BE; Fri, 24 May 2024 11:24:02 +0200 (CEST)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [83.166.143.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15168864F
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 11:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vm03M3btxzm5G;
 Fri, 24 May 2024 11:23:59 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vm03M01ddzxqx; Fri, 24 May 2024 11:23:58 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 24 May 2024 11:23:32 +0200
Subject: [PATCH next v2 7/8] rockchip: evb-px30: make UART5 the debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-px30-of_upstream-v2-7-fdc7887097a2@cherry.de>
References: <20240524-px30-of_upstream-v2-0-fdc7887097a2@cherry.de>
In-Reply-To: <20240524-px30-of_upstream-v2-0-fdc7887097a2@cherry.de>
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
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

In the Device Tree, UART5 is the system UART, but in the defconfig it
currently is UART2. Let's sync the two by making the defconfig use UART5
as well.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/evb-px30_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
index a5833ad6d09..abe545625a5 100644
--- a/configs/evb-px30_defconfig
+++ b/configs/evb-px30_defconfig
@@ -10,7 +10,7 @@ CONFIG_ROCKCHIP_PX30=y
 CONFIG_TARGET_EVB_PX30=y
 # CONFIG_TPL_LIBCOMMON_SUPPORT is not set
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_DEBUG_UART_BASE=0xFF160000
+CONFIG_DEBUG_UART_BASE=0xff178000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y

-- 
2.45.1

