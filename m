Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92445CEFCFE
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 20:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1094A83D9F;
	Tue,  6 Jan 2026 21:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="I6tZNIbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A567C83FD3; Tue,  6 Jan 2026 21:05:18 +0100 (CET)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EAA383BC4
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 21:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767729916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=S23UXZC7bifb4DemG47kh0936IUQbFQntrScWahrnOM=;
 b=I6tZNIbE3c9K321RKfjV6ZP4MgWNkkjV5pJeqGfca2zxkG67JrHmF4BNukXAI6LLbnauk4
 sO1sZLdYHYRTugO59H2E2S2x6D8CZCm4ECM3gHY9qSdKMH3av6hB5qENlo6vY/uND595rY
 Kqwv07E0pHNV2hXZ2hvLzbUUYS9xOm0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Tom Rini <trini@konsulko.com>, Adam Ford <aford173@gmail.com>,
 u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] clk: versaclock: Add separate config for SPL
Date: Tue,  6 Jan 2026 15:05:06 -0500
Message-Id: <20260106200506.679762-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

The versaclock driver operates on an external clock configured via I2C.
The provided clocks may not be necessary in SPL, and SPL_CCF also
increases the binary size. Add a separate configuration option to allow
enabling versaclock only in U-Boot proper.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/clk/Kconfig  | 7 +++++++
 drivers/clk/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 85cc472b4cb..e1c0aa74f90 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -222,6 +222,13 @@ config CLK_VERSACLOCK
 	  This driver supports the IDT VersaClock 5 and VersaClock 6
 	  programmable clock generators.
 
+config SPL_CLK_VERSACLOCK
+	tristate "Enable VersaClock 5/6 devices in SPL"
+	default CLK_VERSACLOCK
+	depends on SPL_CLK
+	depends on SPL_CLK_CCF
+	depends on SPL_OF_CONTROL
+
 config CLK_VERSAL
 	bool "Enable clock driver support for Versal"
 	depends on (ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f0c0d8a5c2..7077efe9bb4 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -50,7 +50,7 @@ obj-$(CONFIG_CLK_SIFIVE) += sifive/
 obj-$(CONFIG_CLK_SOPHGO) += sophgo/
 obj-$(CONFIG_CLK_SUNXI) += sunxi/
 obj-$(CONFIG_CLK_UNIPHIER) += uniphier/
-obj-$(CONFIG_CLK_VERSACLOCK) += clk_versaclock.o
+obj-$(CONFIG_$(PHASE_)CLK_VERSACLOCK) += clk_versaclock.o
 obj-$(CONFIG_CLK_VERSAL) += clk_versal.o
 obj-$(CONFIG_CLK_VEXPRESS_OSC) += clk_vexpress_osc.o
 obj-$(CONFIG_CLK_XLNX_CLKWZRD) += clk-xlnx-clock-wizard.o
-- 
2.35.1.1320.gc452695387.dirty

base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
branch: versaclk_spl
