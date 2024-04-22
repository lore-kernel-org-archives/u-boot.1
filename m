Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2668CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7F4388386;
	Mon, 22 Apr 2024 08:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="smvIMdIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4017C88374; Mon, 22 Apr 2024 08:30:41 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D65CD88329
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767415; bh=4X/VSpQ27BN4tliCLTbiZ0x9KXVFSXNbxiyAZa6YYTQ=;
 b=smvIMdIm9KzjID+JJ/HS3Nc1Zm3SDwypTWiJI3yMNp0L06JQoRkajWL5cLpgbU3TyaoJLUfCB
 PIthH+bVHi3tT9U/6KgZFemeWwGNiEOV8qw/eF1S4eHoAuU/DRdpH8D2dEL6+TwTMw6ytgThnxT
 3TS0MlGmh25TTqfWvyZ7wfpTMr1eehourbspdTHMWzOiboiSMqHVo/XFfEqIVk3lRpX5XMliEla
 P2hrDVV8ZlLkRgU2JDwsTxLQ0ojpIsdOxYlq75mMzGwsPX0DMWhYUmzaHbfiHNwiOsOV7fL4XBR
 MZ0FUW2g6XQ0QB+CGDZx4vFCv8UHMLOMiuUJjE4THhuA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 09/28] rockchip: rk35xx: Imply support for GbE PHY
Date: Mon, 22 Apr 2024 06:28:46 +0000
Message-ID: <20240422062936.681359-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 662603f634ba165ad447431d
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
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
v3: Collect r-b tag
v2: Collect r-b tag
---
 arch/arm/mach-rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 7b54a6f7dddc..ded749e92bdd 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -310,6 +310,7 @@ config ROCKCHIP_RK3568
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
 	imply OF_LIBFDT_OVERLAY
+	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_OTP
@@ -341,6 +342,7 @@ config ROCKCHIP_RK3588
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
 	imply OF_LIBFDT_OVERLAY
+	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_OTP
-- 
2.43.2

