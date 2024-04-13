Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54583C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FE4881D6;
	Sat, 13 Apr 2024 20:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FdmTYgLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46155880AB; Sat, 13 Apr 2024 20:15:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4402588054
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032099; bh=9KgjbzU0TfBrTZBul/EdwB+9MBKEiS8M5dziXv9UXGo=;
 b=FdmTYgLkpsAId5o5f06xkyjn/V4V32/DOnQazTvPb454SZ90paSrRvTtzHV4/3gH6HPkSWmMe
 7uhcPDSPp1pWKQJnbMjLavdyO923b6Hx1Cim7KortyoG1ZCIl5CwdmTMKa2N6Dot+Rusw6qYyg5
 MmWHRqzeVW0eHaBOvVPVrAjZ0F6Tit00w47dP8kyV14/q54TXt3m/fCB9gxK+PeJWubvozQCiye
 jdZiI7ovV4fHwMFvOUSs2xmz5b4+Ila9Lhhx+eWYTIF7ZXAy5xwBbPbWuotAGEeFAk39f3V1rDP
 izevxmtN6UE1VfCG4P2bmJntlmSofRsr81cNwBQYX/tA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 06/23] rockchip: rk35xx: Sort imply statements
 alphabetically
Date: Sat, 13 Apr 2024 18:13:40 +0000
Message-ID: <20240413181425.1384357-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661acba06fbb975d49a65423
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

Sort imply statements under ROCKCHIP_RK3568 and ROCKCHIP_RK3588
alphabetically.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/mach-rockchip/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index fee463e6d92f..649c22618f36 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -305,12 +305,12 @@ config ROCKCHIP_RK3568
 	select BOARD_LATE_INIT
 	select DM_REGULATOR_FIXED
 	select DM_RESET
-	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
-	imply ROCKCHIP_COMMON_BOARD
-	imply OF_LIBFDT_OVERLAY
-	imply ROCKCHIP_OTP
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
+	imply OF_LIBFDT_OVERLAY
+	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_OTP
+	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
 	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
 	help
 	  The Rockchip RK3568 is a ARM-based SoC with quad-core Cortex-A55,
@@ -332,16 +332,16 @@ config ROCKCHIP_RK3588
 	select BOARD_LATE_INIT
 	select DM_REGULATOR_FIXED
 	select DM_RESET
-	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
-	imply ROCKCHIP_COMMON_BOARD
-	imply OF_LIBFDT_OVERLAY
-	imply ROCKCHIP_OTP
-	imply MISC_INIT_R
-	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
-	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
+	imply BOOTSTD_FULL
 	imply CLK_SCMI
+	imply MISC_INIT_R
+	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
+	imply OF_LIBFDT_OVERLAY
+	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_OTP
 	imply SCMI_FIRMWARE
-	imply BOOTSTD_FULL
+	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
+	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
 	help
 	  The Rockchip RK3588 is a ARM-based SoC with quad-core Cortex-A76 and
 	  quad-core Cortex-A55 including NEON and GPU, 6TOPS NPU, Mali-G610 MP4,
-- 
2.43.2

