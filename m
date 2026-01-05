Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436A0C79FBC
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 19:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F53839A8;
	Mon,  5 Jan 2026 20:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="oI1oUgGc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02FC583E7F; Mon,  5 Jan 2026 20:47:38 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E51983D62
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 20:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
 bh=LmSYLYg2ZgeCWoo1uwqPusypNTIu5dJA/6SqEcKE4RU=; b=oI1oUgGcFUqbe17KisZ7TNbkXL
 a8bmlg3FkPg6ciDKUn+vrbUqyKzIGygVp+qcSQoY16fgXHZIm6+/8zHTIkocxLZZTg+7mCBgoQRDx
 dDWksiEXcJJ7haj10C4ktNs/uDBdYTXpFyIsIQpqSEY5AOv83cFj2LliXGUuvpWx/OEfZ4/PRi5ip
 Vw6aS99FRX4aEGV1EfDRHoyQLqNPi0D1quv+8wlYsFkc46Ib0awwntQ4z0R1ZBnssGvtRKWwk0faX
 JaOW2MEfeEMqzIBgPtmAVtVYf9XhnH0bTp7fdHulkykMbtMjaRla0Q05UZsVviQop5oH4ll3OmUYo
 QrUHAByQ==;
Received: from i53875bd9.versanet.de ([83.135.91.217] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vcqY8-001AcR-CG; Mon, 05 Jan 2026 20:47:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de,
	trini@konsulko.com,
	u-boot@lists.denx.de
Subject: [PATCH 03/12] rockchip: board: qnap-ts433: Fix dir naming to allow
 build-system to find it
Date: Mon,  5 Jan 2026 20:47:14 +0100
Message-ID: <20260105194723.2928608-4-heiko@sntech.de>
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

Right now the board directory for the TS433 only contains its Kconfig
which is linked to directly from the main RK3568 Kconfig.

But as the namings are currently set, the build system will never find
the board directory to check if it contains something to build.

So adapt the board naming to a pattern similar to all the other boards
(boardname_rkSoC).

Fixes: d3cacb79e706 ("board: rockchip: add support for Qnap TS433 devices")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/rk3568/Kconfig            | 2 +-
 board/qnap/{ts433 => ts433_rk3568}/Kconfig       | 4 ++--
 board/qnap/{ts433 => ts433_rk3568}/MAINTAINERS   | 2 +-
 include/configs/{qnap_ts433.h => ts433_rk3568.h} | 0
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename board/qnap/{ts433 => ts433_rk3568}/Kconfig (70%)
 rename board/qnap/{ts433 => ts433_rk3568}/MAINTAINERS (87%)
 rename include/configs/{qnap_ts433.h => ts433_rk3568.h} (100%)

diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
index 2730220a18e..16e14ee4fa7 100644
--- a/arch/arm/mach-rockchip/rk3568/Kconfig
+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
@@ -76,7 +76,7 @@ source "board/hardkernel/odroid_m1/Kconfig"
 source "board/hardkernel/odroid_m1s/Kconfig"
 source "board/pine64/quartz64_rk3566/Kconfig"
 source "board/powkiddy/x55/Kconfig"
-source "board/qnap/ts433/Kconfig"
+source "board/qnap/ts433_rk3568/Kconfig"
 source "board/radxa/zero3-rk3566/Kconfig"
 source "board/xunlong/orangepi-3b-rk3566/Kconfig"
 
diff --git a/board/qnap/ts433/Kconfig b/board/qnap/ts433_rk3568/Kconfig
similarity index 70%
rename from board/qnap/ts433/Kconfig
rename to board/qnap/ts433_rk3568/Kconfig
index b00e1f9f2ef..c5f9db849f2 100644
--- a/board/qnap/ts433/Kconfig
+++ b/board/qnap/ts433_rk3568/Kconfig
@@ -1,12 +1,12 @@
 if TARGET_QNAP_TS433_RK3568
 
 config SYS_BOARD
-	default "qnap_ts433"
+	default "ts433_rk3568"
 
 config SYS_VENDOR
 	default "qnap"
 
 config SYS_CONFIG_NAME
-	default "qnap_ts433"
+	default "ts433_rk3568"
 
 endif
diff --git a/board/qnap/ts433/MAINTAINERS b/board/qnap/ts433_rk3568/MAINTAINERS
similarity index 87%
rename from board/qnap/ts433/MAINTAINERS
rename to board/qnap/ts433_rk3568/MAINTAINERS
index c2b31ad9794..02ce7ff383c 100644
--- a/board/qnap/ts433/MAINTAINERS
+++ b/board/qnap/ts433_rk3568/MAINTAINERS
@@ -1,7 +1,7 @@
 QNAP-TS433
 M:	Heiko Stuebner <heiko@sntech.de>
 S:	Maintained
-F:	board/qnap/ts433/
+F:	board/qnap/ts433_rk3568/
 F:	doc/board/qnap/
 F:	include/configs/qnap_ts433.h
 F:	configs/qnap-ts433-rk3568_defconfig
diff --git a/include/configs/qnap_ts433.h b/include/configs/ts433_rk3568.h
similarity index 100%
rename from include/configs/qnap_ts433.h
rename to include/configs/ts433_rk3568.h
-- 
2.47.2

