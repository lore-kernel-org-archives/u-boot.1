Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2F7C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 06:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F8AE8488D;
	Sun,  5 Jul 2026 08:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="XkvtPChb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2458488D; Sun,  5 Jul 2026 08:08:40 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFDB883314
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 08:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ca64c3ce5fso20143535ad.3
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 23:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783231716; x=1783836516;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lYbrSfKfNCZotan7dJn6zu4rR24ajo8FicL36H/p+FI=;
 b=XkvtPChbIUSLcY8LIK8m1J080PyooF9iSdGsDe4J4M4swYhWALb2uiEvfSnfELMDIe
 7lKVlt5fly4VVeQXmjy5UDFzUTxDNEOJQwlaOdyk5ru6ANlDKRlinMx7RUMQWYxduYyO
 bqed2t2Yrk2VVseG6ndEdjS+v6Xp6YJVF/X3Wi3g54nox0ldQin9KZeqz78A5jQFD+OT
 IBWOQMyuwfan/gKbIh1ybKg7IMrSsy25WtCmE9SWBLFIOHGvwMN0vyqGE/jR8ugB1cSm
 ocYXUMVMOjkDMDgu07Bzsbpno5ynphqTug4Pi1wG8wjiPtin+mdfCty4y7QRraMI0R8r
 V3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783231716; x=1783836516;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lYbrSfKfNCZotan7dJn6zu4rR24ajo8FicL36H/p+FI=;
 b=JNlpA9QwZq2tGwk68St2G4zwN/mFif2Vn9VC9Bzxji3O6hAyN07XmqzZUNxcGJcjof
 FEUbKlADwUFl+ZhGx6W/8kYO6zq7lnzmT/GSTgo6zg/I0zW+W3OrhG2pvQ0PFH6YSNE2
 Y+gA13Y0+j5H5tdViOgAO+CUD/Vlr7nVjChU5oAWnZX9EigDLIrKBY24Q9H/rHVkL+ka
 UJPbX6yE2vB+FSV+A5Z4CCaEvmIYKKGOtaWb4WqG0EtoGpJRTDObyaUmjVx0ABmpFYCp
 3isjruWIRFxNifFJDSgxveqXY8Bbzinkl4NQyprwjcX5KZ5qdBURq0gsvx1kjl+rDe7Q
 c5SQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PpSod99lvWHUYwwwjK3NGixmitoVu21bGjO5k2gtlp+aa/AW4P9jdTc3qZz7cTZ4vZLjyB1E=@lists.denx.de
X-Gm-Message-State: AOJu0YzPCD4FRne5M+brwioccTQ+gm2fpzfmuTS+Vj88FGVHgX5lNfC+
 v2jM+AWoy987r+llVe2aYiz7PUCFah3jlYlMYAXI5xt9OHqvvAFRudoaW9oXIDusCk0=
X-Gm-Gg: AfdE7cmJvbrmc3zI7Tjo0HHMyheXsSuwyiaP6svCSWw0Qx9I6IrH8y008EUNb8mVXIn
 kyJu51CweRnZVOYTn4k9O8hm1p+lF7xAkZj5LjDeA6sfCDbe5koUucV4lq5rR6B4bdI62X5W5+V
 zuwdeu/rdS83i5c+AkG2141GVMOLPiQERP6aJKAqiUlvXYBNQZj+byFrByiu0i5ku7h9x1IXkGB
 pHZHmXUSfETsV+dqsxSdjqP1kr8jWZpZacaJWAv5fdkZOuJ6B/Rea3NSs+oYXow7d+tFx5Wjn4G
 8MhwS7FHnWJ8ol97XV7BXwli8GMoCVKFa8eD3iOPU960xRyxq8r5e6/B4g98H5dwDCGZPGfDwuG
 7Vehfz1sGWWIaOofCuQ3hIAvAYP04lTaRwUPdBmLJNNshdXZpV4Iz+AZRNxgxD0ag+Y/Y5JZ3HK
 ZWhRh1iuZex7Qxdqn8MDLDa6fafGCJvsovJ8Obj3vwMX/Ce6MNHmr1JaLEna5w5ormNLwzEp3I1
 XUVgw/BRz+eofLhyNWzbwokyrQGg8pepkr3YqDbcLGU6vzwwslv+shgCY4cspBe
X-Received: by 2002:a05:6a20:734a:b0:3bf:6c08:fb9e with SMTP id
 adf61e73a8af0-3c03e540da9mr5272387637.50.1783231716263; 
 Sat, 04 Jul 2026 23:08:36 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f38ee1333sm22291719eec.24.2026.07.04.23.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:08:35 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 05 Jul 2026 14:07:54 +0800
Subject: [PATCH v3 3/9] mmc: sdhci: enable CMD23 for multi-block transfers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-m4-v3-3-5a9bc7f25fc5@riscstar.com>
References: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
In-Reply-To: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
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
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>
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

Enable the host controller's support for the CMD23 (SET_BLOCK_COUNT)
command to manage multi-block read/write operations. This allows the
MMC core to use CMD23 in preference to the legacy CMD18/CMD25 plus
CMD12 sequence, reducing command overhead and improving I/O
performance on multi-block transfers.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v3:
- Avoid to use quirk to enable CMD23. Use capability instead.
---
 drivers/mmc/mmc.c | 18 ++++++++++++++----
 include/mmc.h     |  6 +++++-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index f0e38efb262..bc8e9ee6d1c 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -461,6 +461,14 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
 	struct mmc_cmd cmd;
 	struct mmc_data data;
 
+	if (mmc->host_caps & MMC_CAP_CMD23) {
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
@@ -481,7 +489,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
 	if (mmc_send_cmd(mmc, &cmd, &data))
 		return 0;
 
-	if (blkcnt > 1) {
+	if (blkcnt > 1 && !(mmc->host_caps & MMC_CAP_CMD23)) {
 		if (mmc_send_stop_transmission(mmc, false)) {
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 			log_err("mmc fail to send stop cmd\n");
@@ -1436,6 +1444,8 @@ static int sd_get_capabilities(struct mmc *mmc)
 
 	if (mmc->scr[0] & SD_DATA_4BIT)
 		mmc->card_caps |= MMC_MODE_4BIT;
+	if (!(mmc->scr[0] & SD_SCR_CMD23_SUPPORT))
+		mmc->host_caps &= ~MMC_CAP_CMD23;
 
 	/* Version 1.0 doesn't support switching */
 	if (mmc->version == SD_VERSION_1_0)
@@ -2963,9 +2973,9 @@ int mmc_get_op_cond(struct mmc *mmc, bool quiet)
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
diff --git a/include/mmc.h b/include/mmc.h
index 9509c9e9543..b663da71019 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -67,6 +67,7 @@ struct bd_info;
 #define MMC_CAP_NONREMOVABLE	BIT(14)
 #define MMC_CAP_NEEDS_POLL	BIT(15)
 #define MMC_CAP_CD_ACTIVE_HIGH  BIT(16)
+#define MMC_CAP_CMD23		BIT(17)
 
 #define MMC_MODE_8BIT		BIT(30)
 #define MMC_MODE_4BIT		BIT(29)
@@ -141,6 +142,8 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
 #define SD_HIGHSPEED_BUSY	0x00020000
 #define SD_HIGHSPEED_SUPPORTED	0x00020000
 
+#define SD_SCR_CMD23_SUPPORT	BIT(1)
+
 #define UHS_SDR12_BUS_SPEED	0
 #define HIGH_SPEED_BUS_SPEED	1
 #define UHS_SDR25_BUS_SPEED	1
@@ -343,7 +346,8 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
 
 #define MMC_QUIRK_RETRY_SEND_CID	BIT(0)
 #define MMC_QUIRK_RETRY_SET_BLOCKLEN	BIT(1)
-#define MMC_QUIRK_RETRY_APP_CMD	BIT(2)
+#define MMC_QUIRK_RETRY_APP_CMD		BIT(2)
+#define MMC_QUIRK_BLK_CMD23		BIT(3)
 
 enum mmc_voltage {
 	MMC_SIGNAL_VOLTAGE_000 = 0,

-- 
2.51.0

