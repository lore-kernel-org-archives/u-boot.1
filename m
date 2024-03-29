Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C245C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 19:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B2D88286;
	Fri, 29 Mar 2024 20:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Jlxy6lBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC5188286; Fri, 29 Mar 2024 20:03:15 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCDD98827D
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 20:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=52ff=LE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711738986; bh=c28IrvljOgXAhgCbY5WNz0S0PtAtmaf6LghNeXlVkUU=;
 b=Jlxy6lBX4QW0hYDOnjdwDQnf1mKhIW7SYfH+sH8GrwRPN5bBSNZzZ47avGomXFkqXfORLI24F
 3CrZzOvcyR3gDtxU/kNslSDQKY7urs6Ex/58lnAzLjNaQNMsoFO/53J7h+5roUwlvlUr1MG5aIE
 FqVFUuoRl1pZnoQVOFsDkubzwgNePQv7OfWe7BFMp7RVGFKNBp1W4xgfg5SnqQOa+Z7K2sZb1TQ
 rriDLNonFrJaLtaGuz7tWcQUvXuMeeajfxe+UJh5tGWaWzmHyZ0ycwQPZ5BhqTJVpVoYNsA2tYm
 bW0/jtHPN6xmLepZJe9/P2SUTRv0xAKcFSsWzyUXXPtg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 08/19] rockchip: rk35xx: Imply support for GbE PHY
Date: Fri, 29 Mar 2024 19:01:49 +0000
Message-ID: <20240329190224.3613471-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240329190224.3613471-1-jonas@kwiboo.se>
References: <20240329190224.3613471-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66071068c77850cc7d0ca0db
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

Imply support for GbE PHY status parsing and configuration when support
for onboard ethernet is enabled.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index d518913f8a37..d85b59a92da2 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -316,6 +316,7 @@ config ROCKCHIP_RK3568
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
 	imply OF_LIBFDT_OVERLAY
+	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_OTP
@@ -347,6 +348,7 @@ config ROCKCHIP_RK3588
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
 	imply OF_LIBFDT_OVERLAY
+	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_OTP
-- 
2.43.2

