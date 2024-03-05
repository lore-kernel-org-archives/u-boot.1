Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9455BC54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0686B88063;
	Tue,  5 Mar 2024 14:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P/3R/5MD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0425B88059; Tue,  5 Mar 2024 14:25:15 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC2228804B
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:25:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E1DA161381;
 Tue,  5 Mar 2024 13:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4790DC43399;
 Tue,  5 Mar 2024 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709645110;
 bh=PGy67LoBvYDN64njYKZ61rY6vEQFhEAOsBp4Yrz2IPg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=P/3R/5MDz/z1d91UcsWoUm7uA3KDtyYNY11fKEmtTw6jZf3QHdjL6FWIXP7ULIKvJ
 EGAWxblFlp1/vAS2+73b89tuV2VMEfU6sg2g9JJXo/qD+ntvbXGbZrOpCz7s16sc2t
 C7Io5g/b1TPJy6SevyAQoi3xp93RtDwKKR+9GesJueEuOSaQQ0A+Nvko5lUg15dIiY
 YlxHPJqpu/GE5vsb0lnpFJusXwc+WQQaVs6ergSuCuLG1vc9NoO7u2H4MQtg0UNjbE
 +ueBMHGRSg9z6GKiqCeA+4euVfioOv95JOWx/dcRf5AMxBWK6oEOUAio099pe0UQX+
 HByvO5bWoIHvQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 05 Mar 2024 15:24:54 +0200
Subject: [PATCH 2/5] configs/am62x_beagleplay_a53_defconfig: enable DM_ETH_PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-for-2024-07-beagleplay-eth-v1-2-e1294a575cc1@kernel.org>
References: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
In-Reply-To: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=785; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=PGy67LoBvYDN64njYKZ61rY6vEQFhEAOsBp4Yrz2IPg=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl5x0rgcFvZ4DG3URs8KT/dDnoRsZg6ByMDnaLD
 IFEfa8iF4eJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZecdKwAKCRDSWmvTvnYw
 ky5QD/oDdYi5FaDaZkz7Xerm1IV5JfuKR0JbPUUepGeZQmMgR+oA5SRf5FFJ9khtXr6qwWC4vZ3
 yhJMRAdba5n/VjRHC7zBUTAxnencavv805Oq9Q+6muc5xpjzjEJ/Ev8UqxricibsudzLdn8jAiB
 uAfHjEPTX2kadWNRUIGixZCUt0N8at6UeQkYjd0cCt4zBUvKfQf9u/f0GKrsL3znpIllfo2c2yR
 8B+dIzn3TXxoOsUO7+L8pz3HLaI1f01hXn6f1nqZSTzd1oWmnzbO9/XAKE9k4W1j4kdPG6Unfeh
 ZVba/up5KDH93h2h0PHYuys/+bhzAn03lfSXWRw1rpS461vbTNK8h7C9UsikSgAUKr0HQgZ5nZs
 ooPLjysyVaskufr6zuy8nrxUhxAlVytMazzV41LpqoaO8y0J/Dzb7qrMw4Z4vFNujLKYpmlUi4O
 5tismTqQwMmi9W9efn6Mg0XrguNdXwpKPGXOuXeGb/nrYpBNvBSlJQB1wqGVN8iUHhShcP00TQX
 HkPzfIPRVjeV7BgOnmI42SoulE4qpAjqjzVa0FuoQnifeC63FIlqeK2kd8Lqg8hdtGhI7xFK4IC
 7WQ8fJVOeUq4IZeiZClvtwFPoOg0qCLvjzsiPoj4O3UGbk8tIb+UhxzuWCHkjXMtYKGlghhxUXj
 QaGD+1KDDnB7VgA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

Reset GPIO handling is done in ETH PHY Class driver.
Enable DM_ETH_PHY.

We don't use Fixed PHY so disable PHY_FIXED.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 configs/am62x_beagleplay_a53_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index 1f43891d10..a8925e4dcf 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -90,9 +90,9 @@ CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
 CONFIG_PHY_REALTEK=y
 CONFIG_PHY_TI=y
-CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
 CONFIG_PHY=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y

-- 
2.34.1

