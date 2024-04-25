Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95527C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 10:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8876B88F05;
	Thu, 25 Apr 2024 12:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 044D088ED9; Thu, 25 Apr 2024 12:47:06 +0200 (CEST)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2694A88DC3
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 12:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VQCGZ5q9TzQCV;
 Thu, 25 Apr 2024 12:47:02 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VQCGY1RH2zrDs; Thu, 25 Apr 2024 12:47:01 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 25 Apr 2024 12:46:25 +0200
Subject: [PATCH v4 02/11] rockchip: NR_DRAM_BANKS now defaults to 10 when
 Rockchip TPL blob is used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-rk35xx-dram-atags-v4-2-331401a58e8e@theobroma-systems.com>
References: <20240425-rk35xx-dram-atags-v4-0-331401a58e8e@theobroma-systems.com>
In-Reply-To: <20240425-rk35xx-dram-atags-v4-0-331401a58e8e@theobroma-systems.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, John Clark <inindev@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jagan Teki <jagan@edgeble.ai>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Joseph Chen <chenjh@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de, Chris Morgan <macromorgan@hotmail.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

When Rockchip TPL blob is used, the memory areas that can be used for
DRAM is gotten from ATAGS passed through the DRAM at a specific address.

The DDR_MEM tag contains at most 10 areas, so we should default to 10 if
Rockchip TPL blob is used. Note that it is technically possible we need
more if one of those 10 areas overlaps with reserved memory area,
forcing us to split it in two. But a default doesn't need to handle all
cases, only most.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/mach-rockchip/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 4f22d9bde9f..644f7997a29 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -574,6 +574,9 @@ config ROCKCHIP_COMMON_STACK_ADDR
 	imply TPL_SYS_MALLOC_F if TPL
 	imply TPL_SYS_MALLOC_SIMPLE if TPL
 
+config NR_DRAM_BANKS
+	default 10 if ROCKCHIP_EXTERNAL_TPL
+
 source "arch/arm/mach-rockchip/px30/Kconfig"
 source "arch/arm/mach-rockchip/rk3036/Kconfig"
 source "arch/arm/mach-rockchip/rk3066/Kconfig"

-- 
2.44.0

