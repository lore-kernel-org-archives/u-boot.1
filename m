Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCF3D767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 081D5892CD;
	Thu, 31 Oct 2024 19:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YmZwOpeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1629892CD; Thu, 31 Oct 2024 19:02:15 +0100 (CET)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D0388B8F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1730397733;
 bh=qW4FXsjoMc5zZhgu5TU4zXmmvTInE2tDq1ShIrmmroI=;
 h=From:To:Cc:Subject:Date:From;
 b=YmZwOpeEyDaMvg7yYdLsBEvnSWtnfMHt2ZtuAyxT2Btk4BucXRXsbyR9tyJSvxkWq
 AY/x22glJIbtAIcIruFtY5Qp/UmDfbr4PVkJAHG2Kb5KKZD8shVCH0ltnxpGpwNZAH
 fpKZ+H943DGw8o6KDQxd9nvThMV1GOSSoBt22c1wEfArNfmf5tiG1575XE9Y7LAqEE
 RaU1RO+fKtIdSyJ4ftw8Md2QydY5mnJkfA1kZfkeWdWr4XXwiT2X54uU+61EUcXAc5
 hoctfAPE5qTrKeTxeL9Nv8CDvL+v/YKs7PwpNt8V0C0EShT+kHHo10b1R1wrgR3x/7
 sZPRICh9AifRg==
Received: from jupiter.universe (dyndsl-091-248-210-236.ewe-ip-backbone.de
 [91.248.210.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2AE4E17E36BE;
 Thu, 31 Oct 2024 19:02:13 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id DC4DB480075; Thu, 31 Oct 2024 19:02:12 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 1/1] rockchip: rock5b-rk3588: Enable automatic PCI
 enumeration
Date: Thu, 31 Oct 2024 19:01:56 +0100
Message-ID: <20241031180212.116330-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
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

PCI enumeration is required to detect the onboard Ethernet device.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 configs/rock5b-rk3588_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index c54e13e8732c..e5b9f7d326b4 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -17,6 +17,7 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_PCI=y
+CONFIG_PCI_INIT_R=y
 CONFIG_DEBUG_UART=y
 CONFIG_AHCI=y
 CONFIG_FIT=y
-- 
2.45.2

