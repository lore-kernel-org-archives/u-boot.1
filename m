Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBC5C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 205E887EE3;
	Mon, 12 Feb 2024 14:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ugt0Lpke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A2087CB5; Mon, 12 Feb 2024 14:51:34 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308A987EDF
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9573360FE5;
 Mon, 12 Feb 2024 13:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CF3C43390;
 Mon, 12 Feb 2024 13:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707745890;
 bh=Z7+Rr9oxI1+BpHDOkISSJoudldcX/n8bVP3mKKIoIFA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ugt0LpkeRFrFYbkxj+/5CWp2QsUSI7/eH0ij0r44AVaXtTslLdIxUp3c610SyI9jE
 ekTVFsxWVzDnIOy6l011FD+ZbJxp3GSv1ZmWY/gUhcdlb8cELCrpP+lDN4QQOA9/Xo
 XOFpk+4EHGFqOBfcg+6CR4DmEUBWkr3dfuDMdXp0zHUAlglJ/4jSfBOE8A6dkT+cRT
 LU+FemrpkLMm96IbckM6/N/ntk+0cibauHq5Dby+eUF7bRtKu+NOE5NqttKDKhukhN
 0IOeIyFKUjNF/zJ99inm8MwdT3+pllB/QP62YPEPxi+Ze4zbRao/8RhySosKHZcOlE
 c6lGwa2NXiHIg==
Received: by wens.tw (Postfix, from userid 1000)
 id F0CC35FCDD; Mon, 12 Feb 2024 21:51:27 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Tom Rini <trini@konsulko.com>,
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
 Christopher Obbard <chris.obbard@collabora.com>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 5/5] rockchip: nanopi-r4s: Drop ROCKCHIP_OTP
Date: Mon, 12 Feb 2024 21:51:08 +0800
Message-Id: <20240212135111.1767734-6-wens@kernel.org>
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

The NanoPi R4S has an RK3399 SoC, which has efuse supported by
ROCKCHIP_EFUSE, not ROCKCHIP_OTP.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 configs/nanopi-r4s-rk3399_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index f97c06412f07..50dbd7a854d4 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -40,7 +40,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_ROCKCHIP_OTP=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
-- 
2.39.2

