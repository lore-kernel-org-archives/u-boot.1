Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7FFC27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28320889C8;
	Fri, 14 Jun 2024 13:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51C6889B3; Fri, 14 Jun 2024 13:05:10 +0200 (CEST)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AB0889B7
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W0xJM1dbxzXw2;
 Fri, 14 Jun 2024 13:05:07 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W0xJL5VbTzQbp; Fri, 14 Jun 2024 13:05:06 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 14 Jun 2024 13:04:55 +0200
Subject: [PATCH next 3/4] rockchip: px30: imply ARMV8_CRYPTO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-ringneck-no-gadget-v1-3-d3bc6e5088de@cherry.de>
References: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
In-Reply-To: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

PX30 supports ARMv8 Cryptography Extensions so let's enable it by
default for all PX30 to make FIT verification when enabled much faster.

While A35 shouldn't be impacted by ARMV8_SET_SMPEN cache coherency
according to the Kconfig help text, let's enable it just in case since
it exists in the documentation[1].

For u-boot part of the FIT image, it is now taking 5ms against currently
35ms. fdt-1 check lowered from 3ms to <1ms. atf-1 from 6ms to <1ms.

[1] https://developer.arm.com/documentation/100236/0100/register-descriptions/aarch64-system-registers/cpu-extended-control-register--el1?lang=en

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 14b3ab1a572..2242ed9184b 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -16,6 +16,8 @@ config ROCKCHIP_PX30
 	select DEBUG_UART_BOARD_INIT
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_ROCKCHIP_COMMON_BOARD
+	imply ARMV8_CRYPTO
+	imply ARMV8_SET_SMPEN
 	help
 	  The Rockchip PX30 is a ARM-based SoC with a quad-core Cortex-A35
 	  including NEON and GPU, Mali-400 graphics, several DDR3 options

-- 
2.45.2

