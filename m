Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF57CDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 07:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 435B984949;
	Thu, 25 Jun 2026 09:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="LTtzPaSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4FAA8494B; Thu, 25 Jun 2026 09:15:33 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A0784975
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id F0C934E408CB;
 Thu, 25 Jun 2026 07:15:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C58505FF03;
 Thu, 25 Jun 2026 07:15:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5A854106C85A9; 
 Thu, 25 Jun 2026 09:15:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782371729; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=50YgtahBJDGU7nFfsnCYcWQjMwBvrmUq5qvL7eTgWOg=;
 b=LTtzPaSFZVsXdnObsVav0jTFHkjrRJc2JrlivWkSyjY5B0RJDzfAJF6P1l7BzwYLI/U+6o
 1CQGIzqVSrvVTUlolw+Dh5fM/zHx/2q1DoF6ndRl00dnhd6rZ0er3zA0/6LVAPv2I7bux8
 8Z9oqx7QBCOaNXHR3Rxi7q5bjcE6RNPiOD51ZaSQP+BeQXKtvMTSrTKzZGdhCDm60uT7HL
 Y0u/gLnpwxI7wvHwlfd9fmy5m2yTZRWStoOVsiOaImiR6RdJAhcz7fApdoe5SgcPDpR/ol
 z64nbE+lwUc7cfYkBCs+b7fNjZj1Vt07zV4boV8kqg+dBBfrj7Gi5Uy41AYo1Q==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v4 06/19] board: mach-k3: r5: common: enable GTC after
 core_resume
Date: Thu, 25 Jun 2026 09:15:02 +0200
Message-ID: <20260625071515.91243-7-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625071515.91243-1-richard.genoud@bootlin.com>
References: <20260625071515.91243-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Abhash Kumar Jha <a-kumar2@ti.com>

The GTC counter values are restored in the resume sequence by TIFS as
part of the core_resume API. Enable GTC counter after it is restored.

Also add a check to make sure that rproc_load only enables the GTC counter
in the case of a cold boot.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/r5/lpm-common.c       | 11 +++++++++++
 drivers/remoteproc/ti_k3_arm64_rproc.c | 10 ++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index afc6b5cf5376..7889922a7e24 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -266,6 +266,7 @@ static void resume_rproc_f(void)
 {
 	struct power_domain rproc_pwrdmn;
 	struct udevice *dev;
+	void *gtc_base;
 	int ret;
 
 	ret = uclass_get_device_by_seq(UCLASS_REMOTEPROC, 1, &dev);
@@ -276,6 +277,16 @@ static void resume_rproc_f(void)
 	if (ret)
 		panic("power_domain_get_rproc() failed: %d\n", ret);
 
+	gtc_base = dev_read_addr_ptr(dev);
+	if (!gtc_base)
+		panic("Get GTC address failed\n");
+
+#define GTC_CNTCR_REG	0x0
+#define GTC_CNTR_EN	0x3
+
+	/* GTC counter values have been restored by TIFS, so enable the counter */
+	writel(GTC_CNTR_EN, gtc_base + GTC_CNTCR_REG);
+
 	ret = power_domain_on(&rproc_pwrdmn);
 	if (ret)
 		panic("power_domain_on failed: %d\n", ret);
diff --git a/drivers/remoteproc/ti_k3_arm64_rproc.c b/drivers/remoteproc/ti_k3_arm64_rproc.c
index 403c6bed2e8c..9b8a6b7dc53a 100644
--- a/drivers/remoteproc/ti_k3_arm64_rproc.c
+++ b/drivers/remoteproc/ti_k3_arm64_rproc.c
@@ -17,6 +17,7 @@
 #include <dm/device_compat.h>
 #include <linux/err.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <mach/hardware.h>
 #include "ti_sci_proc.h"
 
 #define INVALID_ID	0xff
@@ -78,8 +79,13 @@ static int k3_arm64_load(struct udevice *dev, ulong addr, ulong size)
 	/* Store the clock frequency down for GTC users to pick  up */
 	writel((u32)gtc_rate, rproc->gtc_base + GTC_CNTFID0_REG);
 
-	/* Enable the timer before starting remote core */
-	writel(GTC_CNTR_EN, rproc->gtc_base + GTC_CNTCR_REG);
+	if (!j7xx_board_is_resuming()) {
+		/*
+		 * In case of a fresh boot, enable the timer before
+		 * starting the remote core.
+		 */
+		writel(GTC_CNTR_EN, rproc->gtc_base + GTC_CNTCR_REG);
+	}
 
 	/*
 	 * Setting the right clock frequency would have taken care by
