Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721E2C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E19180F65;
	Fri, 28 Aug 2026 13:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uEaFpgGG9sLr; Fri, 28 Aug 2026 13:58:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925501;
	bh=wqyR4lZJcmd1X4DEGf4X0gqDDS0Oos0kHlFaLks4hJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aMFE8FVFPhZlIVpm11ZNfHN4XVH5Rg8tZiktNiR82zX2quA1kQu7xSHxW2WoIxXRd
	 +HtBujZcjZlS/TCoqvCtzZJOUDIqdl8RQpcFFSTfYDSL+fHhvoN9WC5H/7zt3dF0I9
	 EEUm9HThcCH2RQybeOA6uRirXk36y5Zy0uDAPIwF+lNDS6xckumvRi9il+vJIndOZd
	 aTbdeOAsAW4hM+ZaHs1cMkHTLHV1NJDDXyCTIvL1TO0E2vMyAPiwIE4IE3UaPwJ4jF
	 mpEQrvr8xh/vKeDtIfkmkpRyQ4cSKhjQU7UzcRGwvp2iPQOBpS/hl7e0yocUNsN+hR
	 qBg8CS+m7Or4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDCF880F39;
	Fri, 28 Aug 2026 13:58:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03EC3334
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDF6A403A1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kNJFufl0IYys for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Q7CshSfb
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C758840317
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id C58C51A18A3;
 Fri, 28 Aug 2026 13:58:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 97C8560537;
 Fri, 28 Aug 2026 13:58:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5041411C781DF; 
 Fri, 28 Aug 2026 15:58:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925494; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=wqyR4lZJcmd1X4DEGf4X0gqDDS0Oos0kHlFaLks4hJw=;
 b=Q7CshSfbCaTYpt8GqgUZlmNdJBtzT3SAsan1701Yzkv+kBXlxnF7JM7b2bugYEDSmOgN/x
 NgwV+WaeLo+F4QBsLMkZD8okNaoKWSsMxUO/ffOfzvUNxW4WgEKYZvLPUFXleonEnNGCci
 PNr3LFugHznaONhjRySQJaIE3DnX3V4JP2hAy0HvUpJ+4J+bGQ4Icl3sbGUju9mOdjWAre
 8Pp4k60oLu2hZ/j/boyxt57Cq45WUAO48mgMVW2KDv/L0s5HUfHISNWJdiR1LLX+HQf33F
 jF7uSD9+sM68Edg+xl5O5uS06haNagh5QJ0lReuhsO8EXNkC6LP1HrJGB7cwvw==
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
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 08/21] board: mach-k3: r5: common: enable GTC after
 core_resume
Date: Fri, 28 Aug 2026 15:57:17 +0200
Message-ID: <20260828135730.1565643-9-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
index ab39ea0cd67d..4f515b51fd40 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -311,6 +311,7 @@ static void resume_rproc_f(void)
 {
 	struct power_domain rproc_pwrdmn;
 	struct udevice *dev;
+	void *gtc_base;
 	int ret;
 
 	ret = uclass_get_device_by_seq(UCLASS_REMOTEPROC, 1, &dev);
@@ -321,6 +322,16 @@ static void resume_rproc_f(void)
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
