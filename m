Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0D7C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 05:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D75B282102;
	Tue,  3 Jun 2025 07:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="LiFxwidn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C8480BAE; Tue,  3 Jun 2025 07:06:49 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA25081E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 07:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2426dda6b=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1748927207; x=1780463207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/lF+C0s3vgY5Xc8Ftjw12gqZhjWeXGlf2lEz590QW50=;
 b=LiFxwidnmNhgRQnVqJn2deFb/2mK8ufYzfvsD13XhMpmmQ1Gre626puS
 ypiI6jCUbbeixhmUrET6bLDMOi1O3VeT8oALsK7VC+IObhq9OzoXc/qzu
 AavjrZtcPndAbRG5V2zX0sOhGT/lVbylLBEnVA2PyRE0qq0vNO2e/6SN7
 sWgShZVZM1Al8hPfXW7Q6/6BCCuOO2c8S6YYXQ/yKAr8Nx67/nbemkZGn
 qrmoXt+edgcwdxvdQ6HE/BsG9IRufm8SC2sGZSLbnoB0fnqaFMn2H0KhP
 EJkXBhNlPppBbeEJo7I6C16GrjQqPbLq1XwRi28jFfLm5q/gXtjI6eykQ Q==;
X-CSE-ConnectionGUID: 1XF8A2VYROKM/ET8yAvjUw==
X-CSE-MsgGUID: 3KJ30YYIQ+C7Z5nDJa49Pw==
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="273727169"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Jun 2025 22:06:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 2 Jun 2025 22:06:22 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 2 Jun 2025 22:06:16 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <Oliver.Gaskell@analog.com>,
 <malysagreg@gmail.com>, <nathan.morrison@timesys.com>,
 <mkorpershoek@kernel.org>, <robert.marko@sartura.hr>,
 <jerome.forissier@linaro.org>, <sebastian.reichel@collabora.com>,
 <duje.mihanovic@skole.hr>, <sumit.garg@kernel.org>,
 <patrice.chotard@foss.st.com>, <nicolas.ferre@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v6 1/9] dt-bindings: drop at91.h from clock includes
Date: Tue, 3 Jun 2025 10:35:48 +0530
Message-ID: <20250603050556.80851-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603050556.80851-1-manikandan.m@microchip.com>
References: <20250603050556.80851-1-manikandan.m@microchip.com>
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
index d62dd35a385..883169e3dee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -468,7 +468,6 @@ F:	drivers/memory/atmel-ebi.c
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

