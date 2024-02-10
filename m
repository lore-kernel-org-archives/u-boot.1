Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB66C48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 06:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF6F787E92;
	Sat, 10 Feb 2024 07:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gf87lkhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC72B87E95; Sat, 10 Feb 2024 07:33:02 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D16C787E91
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 07:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 31F0A60916;
 Sat, 10 Feb 2024 06:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F824C433C7;
 Sat, 10 Feb 2024 06:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707546778;
 bh=5JMBYrsj5TD93om7R5mq+wEnDgj7ipKCHedAGjqh2dQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gf87lkhP+RBeM/q+MMFQ9fHK5ad/OfcI1/Nnsda5C7W/8HCaCF1qYMs2F1qUVexjl
 Qzn9TmVAhe7NiOSbVEQ2E+JggBNGF7BZ5PIgrweaQHekj6UPqe3wbJdy9wg6Yb6PeR
 XAxeszk5FO7tmYzzgH2kBa2onJNi7NGYC71SSyvN1AWwzLuUpR/kFT1ByrgmCAnE/R
 wQg/V5rUDa/MZ3BCCXGjL6UkQFl71Cp21IWZxL3jR8ev4eTQZWaAoCJQXg9WY7zpbn
 pawCKsUF71VMMB9YpgnsqSfU4Z+9QzQG6Ldpz0XcLfAhs0YIfUHE5stdZ1Z3WstSKZ
 aZ50+0Ax/aWRw==
Received: by wens.tw (Postfix, from userid 1000)
 id C7EEC5FDDF; Sat, 10 Feb 2024 14:32:55 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, Jonas Karlman <jonas@kwiboo.se>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/4] rockchip: rk3328: Read cpuid and generate MAC address
 from efuse
Date: Sat, 10 Feb 2024 14:32:47 +0800
Message-Id: <20240210063252.1065611-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240210063252.1065611-1-wens@kernel.org>
References: <20240210063252.1065611-1-wens@kernel.org>
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
---
 arch/arm/mach-rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1bc7ee904275..20670fb57376 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -189,6 +189,8 @@ config ROCKCHIP_RK3328
 	select ENABLE_ARM_SOC_BOOT0_HOOK
 	select DEBUG_UART_BOARD_INIT
 	select SYS_NS16550
+	imply ROCKCHIP_EFUSE
+	imply MISC_INIT_R
 	help
 	  The Rockchip RK3328 is a ARM-based SoC with a quad-core Cortex-A53.
 	  including NEON and GPU, 1MB L2 cache, Mali-T7 graphics, two
-- 
2.39.2

