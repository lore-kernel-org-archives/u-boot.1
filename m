Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A328C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 17:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF9288606;
	Thu, 23 May 2024 18:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4191A87ABC; Thu, 23 May 2024 18:59:52 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D41A885D7
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 18:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VlZCm6QJPz77s;
 Thu, 23 May 2024 18:59:48 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VlZCl4tF4z8ns; Thu, 23 May 2024 18:59:47 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 23 May 2024 18:59:35 +0200
Subject: [PATCH v2 2/3] rockchip: Use common bss and stack addresses on
 PX30
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-px30-2024-07-rc-v2-2-e46782d5520c@cherry.de>
References: <20240523-px30-2024-07-rc-v2-0-e46782d5520c@cherry.de>
In-Reply-To: <20240523-px30-2024-07-rc-v2-0-e46782d5520c@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: trini@konsulko.com, jonas@kwiboo.se, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>
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

See commit 008ba0d56d00 ("rockchip: Add common default bss and stack
addresses") for memory layout. This migrates PX30 to use the new layout,
except for TPL. Indeed, PX30 is extremely limited in SRAM, so we need to
be extra careful about what goes into the TPL and how much we can
allocate there, so let's keep the current value for
TPL_SYS_MALLOC_F_LEN (already present in the PX30-specific Kconfig, from
an earlier commit).

This will allow us to use the same memory layout on one more Rockchip
SoC, which is always a nice thing. Additionally, this will make it
easier to fix U-Boot proper pre-reloc running out of memory on PX30 in a
subsequent commit.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/px30/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
index e39472604c3..dcf9eb8144b 100644
--- a/arch/arm/mach-rockchip/px30/Kconfig
+++ b/arch/arm/mach-rockchip/px30/Kconfig
@@ -68,8 +68,11 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "px30"
 
+config ROCKCHIP_COMMON_STACK_ADDR
+	default y
+
 config SYS_MALLOC_F_LEN
-	default 0x400
+	default 0x400 if !SPL_SHARES_INIT_SP_ADDR
 
 config SPL_SERIAL
 	default y

-- 
2.45.1

