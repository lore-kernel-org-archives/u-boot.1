Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2D2E909A5
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F7C483CB1;
	Tue, 17 Feb 2026 14:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vXweGmgA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD3D83CF2; Tue, 17 Feb 2026 14:49:51 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FEF83981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8BFF1C1356B;
 Tue, 17 Feb 2026 13:50:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0689D606D1;
 Tue, 17 Feb 2026 13:49:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9D171103689BD; Tue, 17 Feb 2026 14:49:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771336188; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=pd0zbEs8uvNr/TueH+I29j3zDSPB8Ou9Vv/rdnPN7g0=;
 b=vXweGmgA0wEQu0OcdZHvXXsr9eAX7QYTCc/uVuBIPJufoEtsP28gyczFDop4bSBaX013K0
 nyWw0W6LYBw2Y1/t21wKe9Jd7YGY9/XlqB5snv8Zb4sfMCLZTCO/3IuT7YNoI4Qw9KW/uB
 LdAnHwXWhjQpjW5dOMiWIX3M7CCxfU7Bl++V8xeGxRwlwMW15TfhiB+KBEwk91GavavWW3
 et3lQuT5O+b1Z6ugE8JE27KmsZVCCgOo4B17Ue9tI4yNDV/Psk7iynhpK3nMLMbZ/2Tfbm
 PjZXlEcJ5bNOGerSpHIMIO9T1wLGvs1S0ZkooFgME0/O3DdFmfz0LZK7FvcHdQ==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: julien.peeters@eove.fr, Kory Maincent <kory.maincent@bootlin.com>,
 thomas.petazzoni@bootlin.com, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH] mmc: fsl_esdhc_imx: Skip voltage switching for fixed 1.8V
 regulator
Date: Tue, 17 Feb 2026 14:49:39 +0100
Message-ID: <20260217134940.548212-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
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

When using a fixed 1.8V regulator for vqmmc (indicated by vs18_enable),
attempting to change the voltage produces spurious errors since the
regulator cannot be adjusted. The driver currently attempts the voltage
change, receives -ENOSYS from the regulator subsystem, and reports:

  Setting to 1.8V error: -38
  esdhc_set_voltage error -5

Fix this by checking vs18_enable early in esdhc_set_voltage() and
returning -ENOTSUPP for all voltage switch requests, not just 3.3V.
This prevents unnecessary regulator operations and eliminates the
error messages when the hardware is correctly configured with a fixed
1.8V supply.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/mmc/fsl_esdhc_imx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 7dc76563b7e..335b44a8a1a 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -752,10 +752,11 @@ static int esdhc_set_voltage(struct mmc *mmc)
 	int ret;
 
 	priv->signal_voltage = mmc->signal_voltage;
+	if (priv->vs18_enable)
+		return -ENOTSUPP;
+
 	switch (mmc->signal_voltage) {
 	case MMC_SIGNAL_VOLTAGE_330:
-		if (priv->vs18_enable)
-			return -ENOTSUPP;
 		if (CONFIG_IS_ENABLED(DM_REGULATOR) &&
 		    !IS_ERR_OR_NULL(priv->vqmmc_dev)) {
 			ret = regulator_set_value(priv->vqmmc_dev,
-- 
2.43.0

