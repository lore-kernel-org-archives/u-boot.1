Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3F1C79FBD
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 19:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6090C83E21;
	Mon,  5 Jan 2026 20:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="Uj5GFO5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2BC83EA6; Mon,  5 Jan 2026 20:47:39 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A95A8399B
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 20:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
 bh=01TwqvCUf5znCYTAi4SLOTlw7tf1uwB1fn555GgeDog=; b=Uj5GFO5LQIOoNz3QfhVntmWY78
 7FZzrK9c5dM3E4HLPqXAM/n4gv9laXehxaUZNPUnfed9EIGGjD2gysdip0rBhJ1Lq3jr/5Bqrknrk
 YWvIgpqZ2odAsx94xPlP9kBTUQV2hkPjP2hY+Eg1LTZ6eWsCAzA86KBl9cghFYVBeifrUUHuE4Mbr
 ODNWycyra+9dKQUSGppNDxmGWVTLmeu/SqxfkvLyaVGdcAS8yS4TC6iC/ITKpUiFevfcp0GzwVYTh
 c826rOIU7Zv0WxhB++vpOpdCrWAuQQCssD/c/35PXkyglau+DUQUng3TdCEnPE7yvtT7FmRgxpGSO
 LiANW1Qg==;
Received: from i53875bd9.versanet.de ([83.135.91.217] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vcqY8-001AcR-1d; Mon, 05 Jan 2026 20:47:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de,
	trini@konsulko.com,
	u-boot@lists.denx.de
Subject: [PATCH 02/12] rockchip: board: qnap-ts433: drop DW_MMC config options
Date: Mon,  5 Jan 2026 20:47:13 +0100
Message-ID: <20260105194723.2928608-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260105194723.2928608-1-heiko@sntech.de>
References: <20260105194723.2928608-1-heiko@sntech.de>
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

The TS433 does not have a SD-card slot, just the separate SDHCI-controlled
EMMC on the board.

So drop the 2 config options.

Fixes: d3cacb79e706 ("board: rockchip: add support for Qnap TS433 devices")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 configs/qnap-ts433-rk3568_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
index 1e494073bc9..ebcd3b69e90 100644
--- a/configs/qnap-ts433-rk3568_defconfig
+++ b/configs/qnap-ts433-rk3568_defconfig
@@ -51,8 +51,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-- 
2.47.2

