Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83B8EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3910586E20;
	Mon, 11 Sep 2023 16:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C4d0Xv4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC5F86A82; Mon, 11 Sep 2023 16:03:04 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 837CC86E1A
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BE2vlP017479;
 Mon, 11 Sep 2023 09:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694440977;
 bh=oYR8H8dR6kAps3iJgoNOlaAXKKm4krB5u9GJoKqoat0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=C4d0Xv4stelQicdBhjUPP4/o6Obcw7XL+9EoiGC11+Gr6hlcxnR+2E9WQFTlIMl9H
 w2ZSWa+Um3VeTpE7ggTpL9Ex1BFJXNKOs9GWSkT9zhMZipRiQE6dB5yXGkQWWg+PDP
 A3NBYF/yi7YgS6FyBPsr51BZmj21+ospgSwLpFrc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BE2vSe056533
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 09:02:57 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:02:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:02:57 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BE2vik115177;
 Mon, 11 Sep 2023 09:02:57 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Marcel Ziswiler <marcel@ziswiler.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] arm: dts: k3-pinctrl: Sync with kernel v6.6-rc1
Date: Mon, 11 Sep 2023 09:02:55 -0500
Message-ID: <20230911140256.945074-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230911140256.945074-1-nm@ti.com>
References: <20230911140256.945074-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Sync pinctrl header with v6.6-rc1

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/k3-pinctrl.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/k3-pinctrl.h b/arch/arm/dts/k3-pinctrl.h
index c97548a3f42d..2a4e0e084d69 100644
--- a/arch/arm/dts/k3-pinctrl.h
+++ b/arch/arm/dts/k3-pinctrl.h
@@ -11,6 +11,7 @@
 #define PULLUDEN_SHIFT		(16)
 #define PULLTYPESEL_SHIFT	(17)
 #define RXACTIVE_SHIFT		(18)
+#define DEBOUNCE_SHIFT		(11)
 
 #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
 #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
@@ -29,9 +30,20 @@
 #define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
 #define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
 
+#define PIN_DEBOUNCE_DISABLE	(0 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF1	(1 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF2	(2 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF3	(3 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF4	(4 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
+#define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
+
 #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
+#define AM62PX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
+#define AM62PX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
+
 #define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
-- 
2.40.0

