Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FAAC4829A
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 06:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 758F387E9A;
	Sat, 10 Feb 2024 07:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rvCIUH62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A2287E9E; Sat, 10 Feb 2024 07:33:06 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21AF087E98
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 07:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BE2CCCE0E42;
 Sat, 10 Feb 2024 06:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767CAC433F1;
 Sat, 10 Feb 2024 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707546780;
 bh=GZ5teW6afNDodvHcK5VhexC1t38loWFfWNR8LofZ23I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rvCIUH62EBKiQuX/zPIV7CG83WIbWAeipFQCHl+Q3QHkZEnAdYOSTJ4hRsIaWXfBL
 TCntVAiEVpdhrN+biaIBmGoEioj2myi9WRUJyvldWp6yn7ESICMrFP9HtoykpUn7qG
 Z8qFW6X5Vy3rNDpEHvzOFfcujV19BstTUtiGfa32ayuOUxd4ucw6NCpoq93vB7teng
 LNIjNoR/9/Iu/MXiY003r7OXAnCmpB1qO4lfzj/2WMYNweBYRRjbFfGMzNajQK24Vn
 vsolNzlAQVcm8B++x/AodAygL7WSK5DyWltGcnEZ2r5t0RVtuLLK3VIatRrXeHRwws
 a/11KHXR1IJcQ==
Received: by wens.tw (Postfix, from userid 1000)
 id 0C5265FB5F; Sat, 10 Feb 2024 14:32:58 +0800 (CST)
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
Subject: [PATCH 2/4] rockchip: rk3399: Read cpuid and generate MAC address
 from efuse
Date: Sat, 10 Feb 2024 14:32:48 +0800
Message-Id: <20240210063252.1065611-3-wens@kernel.org>
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

The rockchip-efuse driver supports the efuse found on RK3399. This
hardware block is part of the SoC and contains the CPUID, which can
be used to generate stable serial numbers and MAC addresses.

Enable the driver and reading cpuid by default for RK3399.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 20670fb57376..2558d956b8c6 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -269,6 +269,8 @@ config ROCKCHIP_RK3399
 	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
 	imply BOOTSTD_FULL
 	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
+	imply ROCKCHIP_EFUSE
+	imply MISC_INIT_R
 	help
 	  The Rockchip RK3399 is a ARM-based SoC with a dual-core Cortex-A72
 	  and quad-core Cortex-A53.
-- 
2.39.2

