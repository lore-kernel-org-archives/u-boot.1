Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BCDECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5952488F6A;
	Tue, 10 Sep 2024 11:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="l0awNHsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC4F988F6B; Tue, 10 Sep 2024 11:14:06 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B3888F69
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD6AC24000D;
 Tue, 10 Sep 2024 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725959640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EhFtx2vtSkVZVMGqXOH5o5viVeBCPI3bIrmO0MRhttM=;
 b=l0awNHsu74vESFjMRm+nig2ZGT2+670QFbDDNLD4kDCWKtuhPoMqZ4bjFblzZ0rJF3Bgsi
 /lwXy1D+Ya0hBcDpnu6b7qxrS1OGxF3humVMDLzin58VJo9+eWwK4qPH5p2DFJuRvlOmFz
 X3/zLDgzF6ZKCwtzdBEIEF6oAdYKJCm1NyGpEhXqzJ/sZEiDUZ3bjWFWml/IYF1w1WnLt4
 lFfgTgdwukpRlfMrMrYekJWjA8+YkQOqWsCeRklPkoFe5FHeYhBU8BAVyyqEosJ+h7RAgT
 rJM4URbNSJi6EQ36KU/0WzKDXszZpeS1o+HvvaY5Ec69Igdd0+Nki6VbxOD5MQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] pwm: imx: Don't drop the enable bit once set
Date: Tue, 10 Sep 2024 11:13:59 +0200
Message-ID: <20240910091359.102121-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
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

Changing the duty-cycle should not blindly override (and clear) the
enable (EN) bit if it has already been set. For instance, a PWM
backlight can be enabled and set to a specific intensity using two
operations. The order of these operations should not matter.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pwm/pwm-imx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 8fbb40cc276..8bcc8f2af02 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -21,10 +21,11 @@ int pwm_config_internal(struct pwm_regs *pwm, unsigned long period_cycles,
 	u32 cr;
 
 	writel(0, &pwm->ir);
-	cr = PWMCR_PRESCALER(prescale) |
+
+	cr = readl(&pwm->cr) & PWMCR_EN;
+	cr |= PWMCR_PRESCALER(prescale) |
 		PWMCR_DOZEEN | PWMCR_WAITEN |
 		PWMCR_DBGEN | PWMCR_CLKSRC_IPG_HIGH;
-
 	writel(cr, &pwm->cr);
 	/* set duty cycles */
 	writel(duty_cycles, &pwm->sar);
-- 
2.43.0

