Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DD8C43602
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 15:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1990E84A4A;
	Mon, 29 Jun 2026 17:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="MdIOUhgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42E3184A4A; Mon, 29 Jun 2026 17:52:04 +0200 (CEST)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2FE84A45
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 17:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-139f3eaaa49so1097839c88.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782748319; x=1783353119;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O4njntQyscN20yA26T/Uzg79uBYIe31nY8wY52gxelo=;
 b=MdIOUhgYJ+dHBP3VQCjtZiRty7TBWnh7NDC92TReMcqJ+QWsAcEq8HJjifdv9oHdzv
 yruSLqe4q4UizszRaE2rPXHawDJfFbH7CqsIj4Asz41o5piB5tIp0rcxKz1Chy4essMb
 LemMy8qNbq9tCHAjD7noyd+AgjrFhDy/n9/Ia16SPByeyFgmnCBAhULfxY3WT4sRomlA
 +Z/MAvpiBLf++Ne3kHJ6xoM3mocthX+U7+iyJdpfztxVgY5kKWSgAMGmeNX13lI7fWS9
 xAOQKiEHhlNw554IUCNAvOfYhseh5WN17lQl18sKYA2hkS/hvOywaaxFiQaSEqa6zhS9
 kl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748319; x=1783353119;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O4njntQyscN20yA26T/Uzg79uBYIe31nY8wY52gxelo=;
 b=eyqdlwG6dt3lCMVe9+61Gg+7YMNbdAUmTc39a4eM0bC2+vkLbo3li47Tr8STGBlOXa
 p/siZvoYiDugZy86xdTL/FyNYIGGtE7FKmXFdnihVap3kiNqUg7UkKFIOJYS2AMdxRrg
 DPKPmoheOxTsK5aVQobb+9nZ2RMCbPzC6npbD6j9NNDSoD3RdiCPQ0WqpfG/eJ8VZ1OA
 RcIbr9VrPRyxLChQKf4bh5nPRtwJFoDiYjfhjM7rIuxct4V3U7QBwPxf3NAH5bv4lSDB
 t1buIyLz2CtDUwbMKbcvLexGlfFn/LFecOs4cr2gkHG7ZBFdmxO572qO6ZUy6jB5ULIm
 yXWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bAJQccDyRYyoOCh6XyLh2TQtBlNhtHkNlP+ML7zmH2z/dY52DRt2AVhWPkSxe1z13OWhhCyU=@lists.denx.de
X-Gm-Message-State: AOJu0YxxQ31X4f9WLZ5sH/50wlTLjBl9a8GzXGTNpBiHo8CnncMtg3g3
 dZ0L/iiBFMLKg5tQ+PxVMXy+fzQNvYe/W8QtpZB/kljcs6dSR8Hz/XDHSklCjBUVKx52h0FaBSA
 mZjWPgplqTQ==
X-Gm-Gg: AfdE7cnpUokMSFRUOKpPNF7CLV4G40xvJqKJRxcTNZMZ17yge5k/UK6rAmyqjqJj3Vy
 mdAB54e9o1Qxp7/QH/t+8QQfTo28qT8D+sU6+LjLaE93FQqczHEp6kOoygBehHwz3ySqOCuw016
 TKSo2ghE7x3sPfkfKqp/pzZLNeiFlY0rFCFxiBo+sRK8q1mS4lwLykUGKMHoKAyMOeNwXiTbLLR
 Z0/YgYgvVAgmSEmNbTfBrMUDv8Ezs4oxxTLcYh5r/3dEK9pjtWYZOmv/ruNODliDN4Y2/9sdF+7
 /4xHo0OInQ6CAjjn33jzVBMaBmGBNKu5RFWwnP3t7fZtT4PzFvLPrqkw3GUvc68ohMRD/hl41+1
 nMt2mFRLKTALa+xvdnxZUigJg2rzr0WYpQ2FQ6lfiueZkxitbHvmCNxHKi+w90WyWsqx/CbbGAW
 34gfNLf5VLnMtcU6cuiP6jKuQSxWIbNuQtHQZy9Ev+lw2yToZ0DELnmno4uv/knDd0EzyMw37sg
 8xGXmuBuBtH38IHIRYlQKIr/QuUfQ8fSM/getiVit6NeAFFNKGzUg==
X-Received: by 2002:a05:7022:ec2:b0:136:9ebf:3be7 with SMTP id
 a92af1059eb24-13b2a1aab7bmr2660c88.26.1782748318969; 
 Mon, 29 Jun 2026 08:51:58 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm46510090c88.7.2026.06.29.08.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:51:58 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 29 Jun 2026 23:51:16 +0800
Subject: [PATCH v2 v2 2/8] mmc: sdhci: add quirk to enable CMD23 for
 multi-block transfers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-m4-v2-2-cbc91c6b83d8@riscstar.com>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
In-Reply-To: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Introduce a controller-specific quirk to select CMD23 (SET_BLOCK_COUNT)
for read/write multi-block operations instead of the legacy CMD18/CMD25
with open-ended or pre-defined block counts.

This allows SDHCI host controllers that support CMD23 to improve I/O
efficiency by reducing the number of CMD12 (STOP_TRANSMISSION) commands
for multi-block transfers.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 drivers/mmc/mmc.c   | 22 ++++++++++++++++++----
 drivers/mmc/sdhci.c |  3 +++
 include/mmc.h       |  5 ++++-
 include/sdhci.h     |  1 +
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index f0e38efb262..9f2c8cb8d14 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -461,6 +461,15 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
 	struct mmc_cmd cmd;
 	struct mmc_data data;
 
+	if (IS_ENABLED(CONFIG_MMC_QUIRKS) &&
+	    (mmc->quirks & MMC_QUIRK_BLK_CMD23)) {
+		cmd.cmdidx = MMC_CMD_SET_BLOCK_COUNT;
+		cmd.cmdarg = blkcnt & 0x0000ffff;
+		cmd.resp_type = MMC_RSP_R1;
+		if (mmc_send_cmd(mmc, &cmd, NULL))
+			return 0;
+	}
+
 	if (blkcnt > 1)
 		cmd.cmdidx = MMC_CMD_READ_MULTIPLE_BLOCK;
 	else
@@ -481,7 +490,9 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
 	if (mmc_send_cmd(mmc, &cmd, &data))
 		return 0;
 
-	if (blkcnt > 1) {
+	if (blkcnt > 1 &&
+	    IS_ENABLED(CONFIG_MMC_QUIRKS) &&
+	    !(mmc->quirks & MMC_QUIRK_BLK_CMD23)) {
 		if (mmc_send_stop_transmission(mmc, false)) {
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 			log_err("mmc fail to send stop cmd\n");
@@ -1436,6 +1447,9 @@ static int sd_get_capabilities(struct mmc *mmc)
 
 	if (mmc->scr[0] & SD_DATA_4BIT)
 		mmc->card_caps |= MMC_MODE_4BIT;
+	if (IS_ENABLED(CONFIG_MMC_QUIRKS) &&
+	    !(mmc->scr[0] & SD_SCR_CMD23_SUPPORT))
+		mmc->quirks &= ~MMC_QUIRK_BLK_CMD23;
 
 	/* Version 1.0 doesn't support switching */
 	if (mmc->version == SD_VERSION_1_0)
@@ -2963,9 +2977,9 @@ int mmc_get_op_cond(struct mmc *mmc, bool quiet)
 		return err;
 
 #ifdef CONFIG_MMC_QUIRKS
-	mmc->quirks = MMC_QUIRK_RETRY_SET_BLOCKLEN |
-		      MMC_QUIRK_RETRY_SEND_CID |
-		      MMC_QUIRK_RETRY_APP_CMD;
+	mmc->quirks |= MMC_QUIRK_RETRY_SET_BLOCKLEN |
+		       MMC_QUIRK_RETRY_SEND_CID |
+		       MMC_QUIRK_RETRY_APP_CMD;
 #endif
 
 	err = mmc_power_cycle(mmc);
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 08594e10266..f670b8edd61 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -741,6 +741,9 @@ static int sdhci_init(struct mmc *mmc)
 		}
 	}
 #endif
+	if (IS_ENABLED(CONFIG_MMC_QUIRKS) &&
+	    (host->quirks & SDHCI_QUIRK_BLK_CMD23))
+		host->mmc->quirks |= MMC_QUIRK_BLK_CMD23;
 
 	sdhci_set_power(host, fls(mmc->cfg->voltages) - 1);
 
diff --git a/include/mmc.h b/include/mmc.h
index 9509c9e9543..ba2425b96e0 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -141,6 +141,8 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
 #define SD_HIGHSPEED_BUSY	0x00020000
 #define SD_HIGHSPEED_SUPPORTED	0x00020000
 
+#define SD_SCR_CMD23_SUPPORT	BIT(1)
+
 #define UHS_SDR12_BUS_SPEED	0
 #define HIGH_SPEED_BUS_SPEED	1
 #define UHS_SDR25_BUS_SPEED	1
@@ -343,7 +345,8 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
 
 #define MMC_QUIRK_RETRY_SEND_CID	BIT(0)
 #define MMC_QUIRK_RETRY_SET_BLOCKLEN	BIT(1)
-#define MMC_QUIRK_RETRY_APP_CMD	BIT(2)
+#define MMC_QUIRK_RETRY_APP_CMD		BIT(2)
+#define MMC_QUIRK_BLK_CMD23		BIT(3)
 
 enum mmc_voltage {
 	MMC_SIGNAL_VOLTAGE_000 = 0,
diff --git a/include/sdhci.h b/include/sdhci.h
index fb847821d58..64f6f6ab2bf 100644
--- a/include/sdhci.h
+++ b/include/sdhci.h
@@ -256,6 +256,7 @@
 #define SDHCI_QUIRK_SUPPORT_SINGLE	(1 << 10)
 /* Capability register bit-63 indicates HS400 support */
 #define SDHCI_QUIRK_CAPS_BIT63_FOR_HS400	BIT(11)
+#define SDHCI_QUIRK_BLK_CMD23		BIT(12)
 
 /* to make gcc happy */
 struct sdhci_host;

-- 
2.51.0

