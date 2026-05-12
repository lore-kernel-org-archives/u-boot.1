Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1703ACD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 12:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC0D983C51;
	Tue, 12 May 2026 14:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sairon.cz header.i=@sairon.cz header.b="QyEawGu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39CBD83C51; Tue, 12 May 2026 14:25:11 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D146F8341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 14:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sairon@sairon.cz
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso63172615e9.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sairon.cz; s=google; t=1778588708; x=1779193508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5jOD8I8I8fyAdkE2Et3QQYzi+7u/PuEMQBu6dOqcY4U=;
 b=QyEawGu/uTmk7JIBI5fEFuyToS3r7cFV2mafAfHp8DpcXvpFFxTqAwAP5Lwr7ZL6SD
 CdDK4XQAkf9Txa1ZJuXQ1yMdhEgX7F9Q01eTh5IrtnhBO+ziZqCimC00qPiehJMDyV+h
 e9pxxjhs2slcPva6n1Qw+LYVM6Wz+k3jfAO0dwPu98M7iZssZVa/miFm6dsbmhtzMgSU
 f6c8ii5Ldqt0CGQS4VgcSLITnlW3vZ4bBuCkeiCsRZKE1xfJzfmnthVOKXIZD5FW3tBB
 fmVbNLq1tn1hVRAy2taC19KSyiqa8DccbIOUktjraZ58V60nRdKqreG1xPb+c2Xiy90u
 VU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778588708; x=1779193508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jOD8I8I8fyAdkE2Et3QQYzi+7u/PuEMQBu6dOqcY4U=;
 b=eWgLdLlmCcW9Qxdvat/P6k+YIiumVY9ne0TDzkECVHoFjbija66ZXSvk+ilV+S9IhD
 IHm7QgmnWRwynYxpQCQHOcb5uAEAOPfkdtnwcytiG2Ftdp484mMKPHll/LFkVmuF70bt
 fgGOrSE8BpQc3nIZr3Hn2cdOBWwlJ+p84KM1xLzY3K69mEUeOoAzoMyO+gju4U7aSpLg
 yEY+ZgG8TP/TdkkbwnI/tw2hs1N7YFaM+KNgGIkJZiNCau6eaX+4Q+1vq4JaXOr3MwLH
 c8Hkrk1yiQyTxKUu1PQj4sB2dHdjWwNCtDAcNo5gm75cvz375h0okMc2/5Hx1K9xisRH
 bPHQ==
X-Gm-Message-State: AOJu0YzjbsOtO87u0MlnknfJGuv+y++ihUC2Y15/968C9+bdbv3EMmKa
 d7YztNLHoruWMgg1WdLNviD2n2UJuyn7ElaoC3AgQ6PP35NcYITkJJekSPsZhw2PjA3liMgh/5c
 1i0Tom1k=
X-Gm-Gg: Acq92OH73I4H7kngFXnes6ghHtUie/smWEt72nPt+RzL9NCNuYrKpahEwB+cGbnCqB8
 SpbLuUQxTRQh3w1bUI8YoMV40UXYoUZawHb0xswWruuITgyflIx32UorRsvvXRgyI2ropCQREAY
 AkUe+3u3PvclKyuU9u6pRitjv0H0IhXylwPxnR7sw2L/0YpiIJm+0T3alE/Hs8dJI6ksaSxNWbD
 e53j80VYeEaK7TjpGoVZHOEm3YwTHW7e+JVodm6sCAeI9DxqmtYA/Sqj8rZMc5PenGUrADCIj3g
 Oq72EMGjmni5dXEvc08sjTHXziGsC6kGkdM/32C/hryMMB3EGwgNtdG5+UTxfwvYFsJML4fZ9OU
 GZaELl0TEEKAe2NGSaf+dQ9EzMXgZg41E23A4OPy65DL0IGIW2YdR5IJLt4LY9+gbBk+1e1eAtU
 DoQR/kZ13Np9TnW3jdJhmfJ5jqb5xxop0w8qkW5G3o3ZszRuKN/LBNpk7JNIbr0r1MBVWao8Gx6
 NbwiJhbOathpsCadoGNuxK4/1fCUE20yBUwwWC8
X-Received: by 2002:a05:600c:4f51:b0:48d:1a94:56c with SMTP id
 5b1f17b1804b1-48e51f3054cmr491876775e9.18.1778588707725; 
 Tue, 12 May 2026 05:25:07 -0700 (PDT)
Received: from krabice.lan (ip-89-103-66-201.bb.vodafone.cz. [89.103.66.201])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e606020sm18361395e9.5.2026.05.12.05.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 05:25:06 -0700 (PDT)
From: =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>
To: u-boot@lists.denx.de
Cc: Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Matthias Brugger <mbrugger@suse.com>, "Ivan T . Ivanov" <iivanov@suse.de>,
 =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>
Subject: [PATCH] mmc: bcmstb: Fix non-removable check in bcm2712 init
Date: Tue, 12 May 2026 14:24:35 +0200
Message-ID: <20260512122435.1118557-1-sairon@sairon.cz>
X-Mailer: git-send-email 2.54.0
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

sdhci_brcmstb_init_2712() reads host->mmc->host_caps to decide whether
to force card-detect for a non-removable eMMC, or to route the CD signal
for a removable SD card. At the time this function runs from
sdhci_bcmstb_probe(), however, host->mmc->host_caps is still zero, that
field is only populated later by the MMC uclass, after the driver's
probe returns. mmc_of_parse() has already filled plat->cfg.host_caps
from the device tree by this point, so check that field instead.

Without the fix, every BCM2712 SDHCI instance takes the else branch and
writes SDIO_CFG_SD_PIN_SEL = SDIO_CFG_SD_PIN_SEL_CARD (0x02), including
the non-removable eMMC on boards such as CM5 on Home Assistant Yellow.
The SDIO_CFG block lies outside the SDHCI core's reset scope, so this
value persists across SDHCI_RESET_ALL into the next stage. On the
BCM2712, having SD_PIN_SEL set to "SD" when the Linux kernel performs
its first set_power(MMC_POWER_UP) write racily prevents the SDHCI
POWER_ON bit from latching (see [1] for the whole backstory) - the
voltage bits stick but POWER_ON drops - which wedges the first CMD0 the
full 10 s software timeout. On Home Assistant Yellow this manifested as
a ~20 s eMMC probe delay on roughly one in two Linux boots when U-Boot
was the previous stage. Booting directly from the Pi firmware (no U-Boot
in between) left SD_PIN_SEL at its default and did not exhibit the race.

Reading plat->cfg.host_caps lets init_2712 see the "non-removable"
property and take the correct branch, leaving SD_PIN_SEL untouched for
the eMMC.

[1] https://github.com/home-assistant/operating-system/pull/3700#issuecomment-4430229511

Fixes: 10127cdbab64 ("mmc: bcmstb: Add support for bcm2712 SD controller")
Signed-off-by: Jan Čermák <sairon@sairon.cz>
---
 drivers/mmc/bcmstb_sdhci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/bcmstb_sdhci.c b/drivers/mmc/bcmstb_sdhci.c
index 7bddbebb162..f27b84a6ee4 100644
--- a/drivers/mmc/bcmstb_sdhci.c
+++ b/drivers/mmc/bcmstb_sdhci.c
@@ -56,7 +56,7 @@ struct sdhci_brcmstb_dev_priv {
 
 static int sdhci_brcmstb_init_2712(struct udevice *dev)
 {
-	struct sdhci_host *host = dev_get_priv(dev);
+	struct sdhci_bcmstb_plat *plat = dev_get_plat(dev);
 	void *cfg_regs;
 	u32 reg;
 
@@ -65,8 +65,8 @@ static int sdhci_brcmstb_init_2712(struct udevice *dev)
 	if (!cfg_regs)
 		return -ENOENT;
 
-	if ((host->mmc->host_caps & MMC_CAP_NONREMOVABLE) ||
-	    (host->mmc->host_caps & MMC_CAP_NEEDS_POLL)) {
+	if ((plat->cfg.host_caps & MMC_CAP_NONREMOVABLE) ||
+	    (plat->cfg.host_caps & MMC_CAP_NEEDS_POLL)) {
 		/* Force presence */
 		reg = readl(cfg_regs + SDIO_CFG_CTRL);
 		reg &= ~SDIO_CFG_CTRL_SDCD_N_TEST_LEV;
