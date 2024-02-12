Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA45C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE1CF87EDA;
	Mon, 12 Feb 2024 14:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QBChbUoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFCE87EDA; Mon, 12 Feb 2024 14:51:26 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55AF587732
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2DAF5CE12C4;
 Mon, 12 Feb 2024 13:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45491C43390;
 Mon, 12 Feb 2024 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707745881;
 bh=oHVuhA2iI06UOUufsPSmWyHjsKK+/M749PiiP6BlGeI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QBChbUoG8XSR3MrngUkRYPFGoo82vedoHV0iZTbfelg39g9R2jtNwz7Nbl28IN1Xs
 HIjbYbjLN9kv1xuJ4xCQu8JDu0aArhGHpuLFTsDEbmL8LY8HosFUqukcc5X29FipLs
 wGloLQBEVWSlL0QJ6Ytd89wLcCL7BIMBprtorRAfihloTEae69dW+D9JaDV75ZF/kj
 hD0lprs50SRRbRZb9Ds3qCrqBX9edNQ5xFf6EAo7UTeZRYQEWxsKPqOoY1KW3DxtgI
 PQFRxMCiEIaab6lsnQ2PYNgr1LEowiFGycchAV1gmIo6f4F/3Ckb8hx3dVrV1p9cVy
 AFxfyVq6oMzvg==
Received: by wens.tw (Postfix, from userid 1000)
 id F37A85FBEA; Mon, 12 Feb 2024 21:51:18 +0800 (CST)
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
Subject: [PATCH v2 2/5] rockchip: rk3399: Read cpuid and generate MAC address
 from efuse
Date: Mon, 12 Feb 2024 21:51:05 +0800
Message-Id: <20240212135111.1767734-3-wens@kernel.org>
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

The rockchip-efuse driver supports the efuse found on RK3399. This
hardware block is part of the SoC and contains the CPUID, which can
be used to generate stable serial numbers and MAC addresses.

Enable the driver and reading cpuid by default for RK3399.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm/mach-rockchip/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 0553967b947f..2c6b045c51c8 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -270,6 +270,9 @@ config ROCKCHIP_RK3399
 	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
 	imply BOOTSTD_FULL
 	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
+	imply MISC
+	imply ROCKCHIP_EFUSE
+	imply MISC_INIT_R
 	help
 	  The Rockchip RK3399 is a ARM-based SoC with a dual-core Cortex-A72
 	  and quad-core Cortex-A53.
-- 
2.39.2

