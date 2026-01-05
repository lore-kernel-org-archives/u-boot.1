Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADFBC79FBC
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 19:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFECD83EF2;
	Mon,  5 Jan 2026 20:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="R0jUxa3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D471283EAF; Mon,  5 Jan 2026 20:47:41 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C44A839DD
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 20:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
 bh=qa1EHb6x1iZj9p3ajuUWtIdyGviqVhDY0XRqQWwWHik=; b=R0jUxa3TY0tBcWg1KfVqajYrAD
 SGBegjiqaX2dM4be7sOYe/fE+glNwKOUMy9Dtm/uiq7ZEpCatDrSoHiPgHVpdWXIxRoaGcD5OJCzU
 SutDa0XLltndzaiQs4CG/W+oueZSP1M80+1NFpz76/wk30+GTh3fYrzzQuTxs8XENu2BtqJyhY2I9
 tuZxSNI6G2YqJXoU0nQeqYnvV3alm0s+2aKBDk3ICFonv2TpzJjkfHV6ds0rWanrzVR4vTlEVJmky
 GBLtcB5Y5alxtysiAM9wEc1wPwy8Hgjv58TVuaDDd/H7izjMVtHbI7vTPa9h/S9DVT5sN0ZhBlFOz
 /0mpeiTQ==;
Received: from i53875bd9.versanet.de ([83.135.91.217] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vcqY7-001AcR-OB; Mon, 05 Jan 2026 20:47:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, trini@konsulko.com, u-boot@lists.denx.de,
 Daniel Bast <2790401+dbast@users.noreply.github.com>
Subject: [PATCH 01/12] rockchip: board: qnap-ts433: Fix TPL binary in
 build-example
Date: Mon,  5 Jan 2026 20:47:12 +0100
Message-ID: <20260105194723.2928608-2-heiko@sntech.de>
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

In the example on how to modify the serial-console in the TPL binary
we already use the v1.21 of the 1560MHz DDR-init binary.

Yet in the build-example the TPL link goes to v1.13 of the 1056MHz
DDR-init.

Not only will that setup reduce performance but it also will prevent
actual serial output from the DDR init, because someone following the
examples will have modified a different binary.

I've been running the 1560MHz DDR-speed in all my tests on now 3
different devices and never saw any issues with it, so adapt the
build-example to link to the faster binary.

Suggested-by: Daniel Bast <2790401+dbast@users.noreply.github.com>
Fixes: d3cacb79e706 ("board: rockchip: add support for Qnap TS433 devices")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 doc/board/qnap/ts433.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/qnap/ts433.rst b/doc/board/qnap/ts433.rst
index 1e1bfbb9190..5e5f0394ada 100644
--- a/doc/board/qnap/ts433.rst
+++ b/doc/board/qnap/ts433.rst
@@ -46,7 +46,7 @@ Building U-Boot
 
     $ export CROSS_COMPILE=aarch64-linux-gnu-
     $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.34.elf
-    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1056MHz_v1.13.bin
+    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin
     $ make qnap-ts433-rk3568_defconfig
     $ make
 
-- 
2.47.2

