Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710D1C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CCA580FAC;
	Thu, 20 Feb 2025 22:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="F7DAWiu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1972080F96; Thu, 20 Feb 2025 22:59:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E7F80077
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 22:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bb8a=VM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1740088743; bh=qfhPD5zkBlyvrpdczRF71Ey0xrAUVN9msYmnesKEsZA=;
 b=F7DAWiu8MSq/1eHLHXafZ2KeIwN9DV4eLdfOq6ErXAUZpb9J0/+H5OnaD0u4gKqrRCQbQVZqD
 l+xN4THef+Naiwyj1QIsY6oT24ZIZ5iTywZ7cJTdya7S3ZiZoPeXY6Ifa2rnt23fOimVzIURC1W
 5JOoTxMor6ph0Q++21VF2L6Yezf4st+i383OpIBo70SEmeCDzlu7noHUbghnAoy/pmKUTBfnXiG
 xZu6/Dzc9gJCfFpuJQU0dSKCtHeBUViP4kVp1XODir81v/Z+5dNEV80O7aMP9lkRUAeuWeS/wYK
 a/wl+YvT3/DzvXQDpzvTUxLIk+lVvKiVEK0fdPOBIHog==
X-Forward-Email-ID: 67b7a5a563718a8557eae153
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.56
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 5/6] rockchip: Move imply ROCKCHIP_EXTERNAL_TPL under SoC
 Kconfig symbol
Date: Thu, 20 Feb 2025 21:56:59 +0000
Message-ID: <20250220215709.407413-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220215709.407413-1-jonas@kwiboo.se>
References: <20250220215709.407413-1-jonas@kwiboo.se>
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

New Rockchip SoCs will typically require use or an external TPL when
support for the SoC is added to U-Boot.

Move imply ROCKCHIP_EXTERNAL_TPL under SoC Kconfig symbol to remove a
future likelihood of a long "default y if" line.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/mach-rockchip/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 7d867173fa1d..4a0faba9a67d 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -179,6 +179,7 @@ config ROCKCHIP_RK3308
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
+	imply ROCKCHIP_EXTERNAL_TPL
 	imply ROCKCHIP_OTP
 	imply SPL_CLK
 	imply SPL_DM_SEQ_ALIAS
@@ -341,6 +342,7 @@ config ROCKCHIP_RK3568
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
+	imply ROCKCHIP_EXTERNAL_TPL
 	imply ROCKCHIP_OTP
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
 	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
@@ -375,6 +377,7 @@ config ROCKCHIP_RK3588
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
+	imply ROCKCHIP_EXTERNAL_TPL
 	imply ROCKCHIP_OTP
 	imply SCMI_FIRMWARE
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
@@ -501,7 +504,6 @@ config TPL_ROCKCHIP_COMMON_BOARD
 
 config ROCKCHIP_EXTERNAL_TPL
 	bool "Use external TPL binary"
-	default y if ROCKCHIP_RK3308 || ROCKCHIP_RK3568 || ROCKCHIP_RK3588
 	help
 	  Some Rockchip SoCs require an external TPL to initialize DRAM.
 	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
-- 
2.48.1

