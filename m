Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366C0C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 19:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931678875D;
	Tue,  2 Jul 2024 21:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PoCSAX2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2738F88765; Tue,  2 Jul 2024 21:54:49 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B6D88732
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 21:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38027so1297105a12.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719950086; x=1720554886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zptezHsPnlwjgURMO8o3BSzvce8axDnGvBInrETCHz0=;
 b=PoCSAX2JEg3jRtUVZTWvOA4a+uix0xjQIArFgKNJjYkj3ZVfO5kz1muXV8lrTxwDWq
 rdG2Ux3N5N4JSBfqPCxFBZGIIh1u1tmeG3QPcMn58mKRfZWkDHFqV+4eVvU511mBeAo2
 oJg7pxmyVLMnHpmvKQz0Ysfelw+H4HkbfcrdfuQaYBzgqsmrIvlB6+mKjzUOgoliHE1O
 bTYWc7VltIEWMYCS4UfRvglQxhtvX/Qgr/KxzU8KqfOA6GJRoIVYIrIe37qs8fB8airK
 bSgUBlKW/HKtoPfgJbea1vVvN9yWIAo0MaJKjLzApesMo1F33l4aM/Xcdes2Ds0BLrsO
 Gcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719950086; x=1720554886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zptezHsPnlwjgURMO8o3BSzvce8axDnGvBInrETCHz0=;
 b=sBp6IjTyeWY1hLESmAMA6EAn0Mjyk5v2mMi6rMwhRVEXGXVCFy2v0tW0FV1i80cYSb
 0JC8AP6HgNU3vHMbnFWn2blyZcKEw7N12BjSYgdOAjsp61PiK6BM3HB/XyaEtd/Hf3gc
 9RotlNXECNo8nShlP9zMm+PS41pOApepR2tRkVuPjvJJ8wrqehALOUlFETxvoV3sJVmp
 lHAQgTIhguXplgXmAU66ZPwoYbTmuK2DJ71EcKIik9yGZrg8iZox+DobMZjqCasOYOW7
 Q8/p08yOX+WbPafuM/GaNJt6RzkMSVaUUi/RaNDmLtUJpAX20y0PYJWuw7a6Znsc5LVm
 bwzA==
X-Gm-Message-State: AOJu0YyFtbT1PA1hdgRqQGefPHR8HRaFG5e2S9dRiYRlmc5P4bATE5tq
 +nlljLOhiiXIoEDd8Ts7rB/9SwNrDQXhw7hWnrbl/bTD0bXyc8empX/jjMq6vpE=
X-Google-Smtp-Source: AGHT+IEmWVR1sj5bVXTtnurzDWlgZuXGJCcSOnZQ5dE7//Jn4rCAtdO7Zb4C51rbqcKH8X6s9zSyIA==
X-Received: by 2002:a05:6402:17ce:b0:57c:6ba4:3d89 with SMTP id
 4fb4d7f45d1cf-587a0dedd63mr5627306a12.40.1719950085683; 
 Tue, 02 Jul 2024 12:54:45 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com
 ([2a04:ee41:1:104e:687f:b3:44db:a3e0])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c838casm6111280a12.4.2024.07.02.12.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 12:54:45 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Judith Mendez <jm@ti.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Aswath Govindraju <a-govindraju@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] mmc: am654_sdhci: Add the quirk to set TESTCD bit
Date: Tue,  2 Jul 2024 21:54:29 +0200
Message-Id: <20240702195429.985628-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The ARASAN MMC controller on Keystone 3 class of devices need the SDCD
line to be connected for proper functioning.

In cases where this can't be connected, add a quirk to force the
controller into test mode and set the TESTCD bit. Use the flag
"ti,fails-without-test-cd", to implement this above quirk when required.

Additionally, this quirk also avoids waiting for the controller debounce
time.

This commit is similar to linux kernel commit c7666240ec76
("drivers: mmc: sdhci_am654: Add the quirk to set TESTCD bit").

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/mmc/am654_sdhci.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index fadab7d40bb7..43f890d269e9 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -106,6 +106,8 @@ struct am654_sdhci_plat {
 #define FREQSEL_2_BIT	BIT(2)
 #define STRBSEL_4_BIT	BIT(3)
 #define DLL_CALIB	BIT(4)
+	u32 quirks;
+#define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 };
 
 struct timing_data {
@@ -351,10 +353,8 @@ int am654_sdhci_init(struct am654_sdhci_plat *plat)
 }
 
 #define MAX_SDCD_DEBOUNCE_TIME 2000
-static int am654_sdhci_deferred_probe(struct sdhci_host *host)
+static int am654_sdhci_cd_poll(struct mmc *mmc)
 {
-	struct udevice *dev = host->mmc->dev;
-	struct am654_sdhci_plat *plat = dev_get_plat(dev);
 	unsigned long start;
 	int val;
 
@@ -369,12 +369,35 @@ static int am654_sdhci_deferred_probe(struct sdhci_host *host)
 		if (get_timer(start) > MAX_SDCD_DEBOUNCE_TIME)
 			return -ENOMEDIUM;
 
-		val = mmc_getcd(host->mmc);
+		val = mmc_getcd(mmc);
 	} while (!val);
 
+	return 0;
+}
+
+static int am654_sdhci_deferred_probe(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct am654_sdhci_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	if (!(plat->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST)) {
+		if (am654_sdhci_cd_poll(host->mmc))
+			return -ENOMEDIUM;
+	}
+
 	am654_sdhci_init(plat);
 
-	return sdhci_probe(dev);
+	ret = sdhci_probe(dev);
+
+	if (plat->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
+		u8 hostctrlreg = sdhci_readb(host, SDHCI_HOST_CONTROL);
+
+		hostctrlreg |= SDHCI_CTRL_CD_TEST_INS | SDHCI_CTRL_CD_TEST;
+		sdhci_writeb(host, hostctrlreg, SDHCI_HOST_CONTROL);
+	}
+
+	return ret;
 }
 
 static void am654_sdhci_write_b(struct sdhci_host *host, u8 val, int reg)
@@ -680,6 +703,9 @@ static int am654_sdhci_probe(struct udevice *dev)
 
 	regmap_init_mem_index(dev_ofnode(dev), &plat->base, 1);
 
+	if (plat->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST)
+		am654_sdhci_deferred_probe(host);
+
 	return 0;
 }
 
@@ -729,6 +755,8 @@ static int am654_sdhci_of_to_plat(struct udevice *dev)
 
 	dev_read_u32(dev, "ti,strobe-sel", &plat->strb_sel);
 	dev_read_u32(dev, "ti,clkbuf-sel", &plat->clkbuf_sel);
+	if (dev_read_bool(dev, "ti,fails-without-test-cd"))
+		plat->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
 
 	ret = mmc_of_parse(dev, cfg);
 	if (ret)
-- 
2.34.1

