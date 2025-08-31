Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EE6CA0FE8
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C168393E;
	Sun, 31 Aug 2025 18:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KrFjJt1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17BA98341A; Sun, 31 Aug 2025 18:50:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF37D8393E
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756659036; bh=U4Mk5DTX+TEMjtPk/+GQdjjY9aW0YFAREXKTDEPUYQQ=;
 b=KrFjJt1FVPm+J/G7n1Z2fswq71/2s1bD8apIB7gD3jbnR3OnpvqBFOxzY5Le3PCxHEbEEh2zB
 PjRcHaIOg+LIYd8xHIthH6rosXdCWgQyALb3oEtrxwStTnNvseRZvAjGbm6MnaEGU++8PVvkZ2j
 qJs0Y/k1ECGrZUZRmZ6L0Ds5REFt4HE8MZXxxO5unZ4KlJkZw5KcyogDjhLwUhIsTuP5EZikJN5
 /FjSK4Ld1qTuJUIK8DXev8seArrBIcCCKC9s5SKTMePqNlgPiPAd2SBNQGX3cK0ulexg/gYI0Pm
 uZ9BOYcnsVEOtZlOHcLwoYdRbi4phRQQOslRtTRONADA==
X-Forward-Email-ID: 68b47d587f68b507ca9c39e7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 03/18] rockchip: odroid-go2: Remove incorrect re-defined
 spi0 alias
Date: Sun, 31 Aug 2025 16:49:20 +0000
Message-ID: <20250831165001.2749711-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831165001.2749711-1-jonas@kwiboo.se>
References: <20250831165001.2749711-1-jonas@kwiboo.se>
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

The alias spi0 is incorrectly being re-defined in board u-boot.dtsi to
the SPI flash controller instead of the actual spi0 controller.

SPI flash support is currently not working on odroid-go2 due to missing
Kconfig options and other required device tree changes.

Remove the re-defined alias for spi0 to allow use of the real spi0,
proper SPI flash support is introduced in a later patch.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch, split from next patch
---
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
index f37daa893c79..38778d1aa6cf 100644
--- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
@@ -16,7 +16,6 @@
 		mmc0 = &sdmmc;
 		serial1 = &uart1;
 		serial2 = &uart2;
-		spi0 = &sfc;
 	};
 
 	dmc {
-- 
2.51.0

