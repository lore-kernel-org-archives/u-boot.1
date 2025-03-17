Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F97C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 06:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 462EE810F4;
	Mon, 17 Mar 2025 07:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="iAs+xpo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3805080FEC; Mon, 17 Mar 2025 07:56:54 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1EE80FEC
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1648c5b74=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1742194612; x=1773730612;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=48AOUKlSR8daDk/R2i1LnYqKHFkCp3IOhRcqELSkaHI=;
 b=iAs+xpo9qSjrMrHjJii5YJJ19hwdioN6PS3Tk5VvZhQiOoVeIlBTd/8T
 1WuraPYS26lcv9sYWNOMFw8dfG1Imm8VCooN6GgRoPlj3MLOaV9obwtO3
 PbYCwdUqB/HwSszoIEcdeMU1qzMO+5/lkHjpkoM1agnIBZWQnE4Q8AqqG
 REkAxRaPeyh0Bmu1eOlHg8b+GG9G8jTt4uEXgFs1Fg4EBsOnflAgTxaCV
 B9JuC2scIuH4YXU+54B2rH4yCrFp51qRrSaotVYdAx0tDvVywFWwPPVLy
 biflm0+1lejJPrzPuwCRHo5c9bHt+f62qutHj5XedqkjazhmvpOabaieP g==;
X-CSE-ConnectionGUID: IVX55pi7TFqyIf6mJ6M0sg==
X-CSE-MsgGUID: 1m5BFNr9Sx6+GLdw/8MmZw==
X-IronPort-AV: E=Sophos;i="6.14,253,1736838000"; d="scan'208";a="39230083"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Mar 2025 23:56:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Mar 2025 23:56:36 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 16 Mar 2025 23:56:30 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <nathan.morrison@timesys.com>, <ilias.apalodimas@linaro.org>,
 <greg.malysa@timesys.com>, <caleb.connolly@linaro.org>,
 <Oliver.Gaskell@analog.com>, <robert.marko@sartura.hr>,
 <jerome.forissier@linaro.org>, <semen.protsenko@linaro.org>,
 <william.zhang@broadcom.com>, <nicolas.ferre@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v4 1/8] dt-bindings: drop at91.h from clock includes
Date: Mon, 17 Mar 2025 12:26:02 +0530
Message-ID: <20250317065609.55071-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250317065609.55071-1-manikandan.m@microchip.com>
References: <20250317065609.55071-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Remove clock/at91.h file as it is subset of
dts/upstream/include/dt-bindings/clock/at91.h.
The constants defined in this header are being used only in dts

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 MAINTAINERS                      |  1 -
 include/dt-bindings/clock/at91.h | 23 -----------------------
 2 files changed, 24 deletions(-)
 delete mode 100644 include/dt-bindings/clock/at91.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 10f7f1fd180..9322bc542e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -464,7 +464,6 @@ F:	drivers/memory/atmel-ebi.c
 F:	drivers/misc/microchip_flexcom.c
 F:	drivers/timer/atmel_tcb_timer.c
 F:	include/dt-bindings/clk/at91.h
-F:	include/dt-bindings/clock/at91.h
 F:	include/dt-bindings/dma/at91.h
 F:	include/dt-bindings/mfd/at91-usart.h
 F:	include/dt-bindings/mfd/atmel-flexcom.h
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
deleted file mode 100644
index ab3ee241d10..00000000000
--- a/include/dt-bindings/clock/at91.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * This header provides constants for AT91 pmc status.
- *
- * The constants defined in this header are being used in dts.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef _DT_BINDINGS_CLK_AT91_H
-#define _DT_BINDINGS_CLK_AT91_H
-
-#define AT91_PMC_MOSCS		0		/* MOSCS Flag */
-#define AT91_PMC_LOCKA		1		/* PLLA Lock */
-#define AT91_PMC_LOCKB		2		/* PLLB Lock */
-#define AT91_PMC_MCKRDY		3		/* Master Clock */
-#define AT91_PMC_LOCKU		6		/* UPLL Lock */
-#define AT91_PMC_PCKRDY(id)	(8 + (id))	/* Programmable Clock */
-#define AT91_PMC_MOSCSELS	16		/* Main Oscillator Selection */
-#define AT91_PMC_MOSCRCS	17		/* Main On-Chip RC */
-#define AT91_PMC_CFDEV		18		/* Clock Failure Detector Event */
-#define AT91_PMC_GCKRDY		24		/* Generated Clocks */
-
-#endif
-- 
2.25.1

