Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9BFC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DDA287ED3;
	Mon, 12 Feb 2024 14:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qlC0ZLtU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4678787CB5; Mon, 12 Feb 2024 14:51:24 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021B787732
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6CC15CE1140;
 Mon, 12 Feb 2024 13:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C72C433C7;
 Mon, 12 Feb 2024 13:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707745878;
 bh=Hh58Vyx5X3Ux+ThWYWau0eY3c6rTzfB9pvRaIEFJGKA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qlC0ZLtUP3MFBETF2SuVZAi+JP6fnEMdn2aSUn29Yj/OsvFMqLmn2wasStRjOuJ+c
 i89jW6dq7BFjJu6iMHNA+lpwk1iX80Emj854GxOBBTHEwAsUAaKZFMDyWH9/NwmSoC
 C1Uf6si63NxBYZstZVQcJsp/CHz0c1B6JpY9RPZJLHMqyXeRzU7fUnGBSzQIjUX+B6
 FY21BOIGPBfahKOtOTaCaD/4ZDRayRiHfv1bPoFcY8k1dhXD3mbqdPyxl4Njk0X8d9
 pZkV1bLfXjoUzFUiyi7hxQEsWFfZAS+0SOhS24+fUTUu16qg9FNgSlLW4lxWk8Y87H
 Yw/oGLHBisAIQ==
Received: by wens.tw (Postfix, from userid 1000)
 id 0887E5FCDD; Mon, 12 Feb 2024 21:51:15 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, Jonas Karlman <jonas@kwiboo.se>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/5] rockchip: rk3328: Read cpuid and generate MAC address
 from efuse
Date: Mon, 12 Feb 2024 21:51:04 +0800
Message-Id: <20240212135111.1767734-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212135111.1767734-1-wens@kernel.org>
References: <20240212135111.1767734-1-wens@kernel.org>
MIME-Version: 1.0
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

From: Chen-Yu Tsai <wens@csie.org>

The rockchip-efuse driver supports the efuse found on RK3328. This
hardware block is part of the SoC and contains the CPUID, which can
be used to generate stable serial numbers and MAC addresses.

Enable the driver and reading cpuid by default for RK3328.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm/mach-rockchip/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1bc7ee904275..0553967b947f 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -189,6 +189,9 @@ config ROCKCHIP_RK3328
 	select ENABLE_ARM_SOC_BOOT0_HOOK
 	select DEBUG_UART_BOARD_INIT
 	select SYS_NS16550
+	imply MISC
+	imply ROCKCHIP_EFUSE
+	imply MISC_INIT_R
 	help
 	  The Rockchip RK3328 is a ARM-based SoC with a quad-core Cortex-A53.
 	  including NEON and GPU, 1MB L2 cache, Mali-T7 graphics, two
-- 
2.39.2

