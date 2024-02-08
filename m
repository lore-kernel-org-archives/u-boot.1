Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFECAC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 09:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B80487E0F;
	Thu,  8 Feb 2024 10:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="oCwCj2WQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECD6987E2D; Thu,  8 Feb 2024 10:30:05 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4691D87E0F
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 10:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 64F1522B5E;
 Thu,  8 Feb 2024 10:29:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1707384596;
 bh=1aE6poAJEtIui6tQQQ80Utlol68/RCb1ib0TC5ajSk8=; h=From:To:Subject;
 b=oCwCj2WQsuN44EsZM/QGKsE0EFAgUyc0T9bb0Od9JSK52tOMapToSB0mi4HngD9PZ
 72vqrIRafIJHDr5T16Kjfml5rlBG2kzSi4Ki3MlCgG1p+3nOCwf/QT0wAF/WbIRDqQ
 XV+MrBab73xGxqTtTs5tMQBPfjiN76FWAhfwUkjWMZk6Nm4x+YN3gR/TGLtRvsIPdk
 G5FwUba7Mv9xmxT3QgSunombjRjd5PISUHDaZzcPS9kQaDgy+a7aziOW6wkCfircbV
 iBkVchceXgz9tFDOhU9gd2vwNfrQ5ebZsnsuvv+ohq5f4ZBS5SvoQ9BjNqtnj6513s
 uWMpsWzC6E0tA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/2] arm: mach-k3: am62: Get soc max temperature by grade
Date: Thu,  8 Feb 2024 10:29:50 +0100
Message-Id: <20240208092951.11769-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208092951.11769-1-francesco@dolcini.it>
References: <20240208092951.11769-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

AM62x SoC is available in multiple temperature grade:
- Commercial: 0° to 95° C
- Industrial: -40° to 105° C
- Automotive: -40° to 125° C

Add a new function that returns the am62 max temperature value
accordingly to its temperature grade in Celsius.

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/mach-k3/include/mach/am62_hardware.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
index 54380f36e161..9c4c6c542b63 100644
--- a/arch/arm/mach-k3/include/mach/am62_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
@@ -42,6 +42,10 @@
 
 #define JTAG_DEV_FEATURE_NO_PRU			0x4
 
+#define JTAG_DEV_TEMP_COMMERCIAL		0x3
+#define JTAG_DEV_TEMP_INDUSTRIAL		0x4
+#define JTAG_DEV_TEMP_AUTOMOTIVE		0x5
+
 #define CTRLMMR_MAIN_DEVSTAT			(WKUP_CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(6, 3)
 #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT	3
@@ -102,6 +106,19 @@ static inline int k3_get_temp_grade(void)
 	return (full_devid & JTAG_DEV_TEMP_MASK) >> JTAG_DEV_TEMP_SHIFT;
 }
 
+static inline int k3_get_max_temp(void)
+{
+	switch (k3_get_temp_grade()) {
+	case JTAG_DEV_TEMP_INDUSTRIAL:
+		return 105;
+	case JTAG_DEV_TEMP_AUTOMOTIVE:
+		return 125;
+	case JTAG_DEV_TEMP_COMMERCIAL:
+	default:
+		return 95;
+	}
+}
+
 static inline int k3_has_pru(void)
 {
 	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
-- 
2.39.2

