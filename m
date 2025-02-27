Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B944EC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 09:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4C480FE1;
	Thu, 27 Feb 2025 10:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="PARocSCt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C01980FF2; Thu, 27 Feb 2025 10:36:32 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2972807FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=14638ef94=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1740648990; x=1772184990;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B13nV20Z1JbsjLc39MgqMyFTEONLMjGnq76U2iftZJc=;
 b=PARocSCthsg1ut1jEC7E76Ccm7l6RzpI/2dI5cWjclSn0Jk1vSwk4VGE
 bxmRHyT+9n9vDEVvs+Gp+WR53UtSiiYzhDL7eYitga8EnzF07npYT6q8O
 4c4m8kPmbTIlm4ONIRHWgdTpHKoXOx4RQrj6g+leDvsnSg7kUV3OKLfNy
 CVPeguDcFRqc/hCe0lJHDiLWEIE64rcDs0lc7PQBK21YY34LY7z76xIU7
 x4hx6kHSfgojJmJ4jKskh0u0l3rIVGKCsE5sWFxFXH4QK5yHZnWLS5VZ5
 IrCkg9UH7UJ3gpQMlawpkKREu1TmNIraH2TRbdPCw+L9a0Y9tCyswHCod g==;
X-CSE-ConnectionGUID: +gZNKDzDRg6edr6VwrslzA==
X-CSE-MsgGUID: NVmT6ZzBTUe9U+zAEg+ixA==
X-IronPort-AV: E=Sophos;i="6.13,319,1732604400"; d="scan'208";a="269591702"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2025 02:36:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Feb 2025 02:36:21 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 27 Feb 2025 02:36:14 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sumit.garg@linaro.org>, <kever.yang@rock-chips.com>, 
 <marek.vasut+renesas@mailbox.org>, <jonas@kwiboo.se>, <festevam@denx.de>, 
 <Oliver.Gaskell@analog.com>, <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <caleb.connolly@linaro.org>, <andre.przywara@arm.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>,
 <nicolas.ferre@microchip.com>, <mihai.sain@microchip.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
Date: Thu, 27 Feb 2025 15:05:52 +0530
Message-ID: <20250227093559.797618-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227093559.797618-1-manikandan.m@microchip.com>
References: <20250227093559.797618-1-manikandan.m@microchip.com>
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

Add PMC clock definitions for MCK and UTMI which will be required
for the sam9x7 OF_upstream DT since the clock framework is not in
sync with Linux and also include this header in 'clock/at91.h' file

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 include/dt-bindings/clk/at91.h   | 3 +++
 include/dt-bindings/clock/at91.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
index a178b94157b..016c6e0c620 100644
--- a/include/dt-bindings/clk/at91.h
+++ b/include/dt-bindings/clk/at91.h
@@ -24,4 +24,7 @@
 #define USB_UTMI2		1
 #define USB_UTMI3		2
 
+#define PMC_MCK			1
+#define PMC_UTMI		2
+
 #endif
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index ab3ee241d10..7235b3ba01e 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -6,6 +6,8 @@
  * Licensed under GPLv2 or later.
  */
 
+#include <dt-bindings/clk/at91.h>
+
 #ifndef _DT_BINDINGS_CLK_AT91_H
 #define _DT_BINDINGS_CLK_AT91_H
 
-- 
2.25.1

