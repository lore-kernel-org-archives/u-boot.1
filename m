Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DEFC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 967EA84A4A;
	Tue,  7 Jul 2026 17:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="x9c98AcK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEA3084A67; Tue,  7 Jul 2026 17:22:28 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CCE284A4A
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so3068872a91.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783437744; x=1784042544;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xbNxuUf/vmjGflLaeB1GjCN5s4w5Yd/k9B/MI/N7spg=;
 b=x9c98AcKGUFE+2rTZ2p587oG6PIxZ/q/+WGRx8hkLcl0W+G750qNQzNlpBaPREkZ82
 g0MR88R5YgCmwqm/32O3geZB78fImV/wUTWhpaW+FPsGeOYAqgMPY1rULhkzfinSiBLi
 2l3BCPjTBwPETw9TE6JshzVKp47xIf4Y2JsqD2z6AWxoTFeqkYgu8T6a5CeMEN6kr7bF
 Lg1H09ny27VLtlGRZqSiBfRz5araYDy5DM0N47Rtq7u7U2e+7rDo0YjILWjihARCe8aG
 zjAhge3bJzTJTmUWcSMpPL5TxC3yfS0wBc8hhl7OumWo/N5yDRUVoiQYa/y0EghqyF82
 lJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437744; x=1784042544;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xbNxuUf/vmjGflLaeB1GjCN5s4w5Yd/k9B/MI/N7spg=;
 b=l+8JQFt3+MVIqvA3GVKdWqHmTIBV/n7b/bcPnli4joGaXGtITNWkMF2dsqXNIuwfDO
 dq5ZJlKZU98MV+eblyJCAVoC2kd6Ldgv82x34+AuzPJe/PJtq/pDmuuI0Sr4438/O+UZ
 YZBhxaE8yjkgZDv5p8V4Kdv9AE1jSZzfq7vGE0ePyBU9mEGO8XK6DwbHS/uLkWr79hMH
 9S0dxT8DmcTNOJ0pJfHlJFoLA7QRbejA6R3Y6pM2dM585od0ubh3lVh/6zUG4VQAxQuG
 AtkkcwfhjHHXEUSysdFy+KwoRRS1+KVJKpamAS2DEVO3NtadR9U4V57AHVS7NSy7Xsck
 uXUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RotOviASQnKZhXqGN6V6g+pt3m5tvf6ecQL/w6psUGiHlNq47eLQ/ty2U/NqyTB56dSUOukG7U=@lists.denx.de
X-Gm-Message-State: AOJu0YwvzmoN1J/5kmlPhVA7eHGXC8BxDDEKbBshbvhPSFsyiEx1IufD
 6tYJehaGDFt/Zrjzf0VOFR3SZHvaM0af+bYSZ1Ifg6bzCvnQ5MJ92TrgbvwpWNXHfqM=
X-Gm-Gg: AfdE7cnsLj1W4ylmWlLXqk/NHs/83DO0FVBqL7Oy7SKxu2CHxXC3x5trQKpC7kOk/eB
 cbtmFIAknt9KlZa1js+1OXU62Hg10DrtsJSk2NmpNq727MnivwmMg9HYyWhn+F6N7/h5FpX7RDX
 mXkdMPfYG7wKIDk2x26uDq1hxg+LN7pUr9j+k5OU6T6K9AybTsMTqiYCn+AknmLr5b87spnLMpY
 Riu+8DM0DKTauNM68gG5ZF/dUR0l/uLBGSeGw7qUCdfMKNlw0XGq+4z0zjHS5FJJrdCIdG5dKmL
 a3I649RSPLF2Mmlmxsw9nKqsc3a22OIDHZkyUWIXTGcgIw90fexQgnuNsU5TSxe2sEUgzUH10Df
 QVxqWJ0GnnlDfp0bEVv5wj2PtGGe/bZUXkbY1bzeCZy+GX+NG1UVs72XGsQD6c7jTcy1KXp+4xv
 vILEzSBcD7Pdj5ImQp82C8owNKSwh7HBETYY7akX1D3liS5lGpr9VxaLTnvCPL3pb8ktqA8hd9p
 sSrmMyAwfN4O4n366Y+27xk6xXPigI5vkUEVnUsMMRntqxWH/vFX4ekwxdkhSWU
X-Received: by 2002:a17:90b:35cf:b0:380:8b14:d8e6 with SMTP id
 98e67ed59e1d1-387570c3f1bmr5590093a91.17.1783437744476; 
 Tue, 07 Jul 2026 08:22:24 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483ddd1sm9594997eec.9.2026.07.07.08.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:22:23 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 07 Jul 2026 23:21:44 +0800
Subject: [PATCH v4 03/10] mmc: enable CMD23 for multi-block transfers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-m4-v4-3-dbd01185f911@riscstar.com>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
In-Reply-To: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
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

Enable the support for the CMD23 (SET_BLOCK_COUNT) command to
manage multi-block read/write operations. This allows the MMC
core to use CMD23 in preference to the legacy CMD18/CMD25 plus
CMD12 sequence, reducing command overhead and improving I/O
performance on multi-block transfers.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

---
v4:
- Add CMD23 on write.
- Fix on using CMD23 only for CMD18/CMD25.
v3:
- Avoid to use quirk to enable CMD23. Use capability instead.
---
 drivers/mmc/mmc.c       | 16 +++++++++++++++-
 drivers/mmc/mmc_write.c | 19 +++++++++++++++----
 include/mmc.h           |  3 +++
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index f0e38efb262..9cd9307c8cd 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -461,6 +461,14 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
 	struct mmc_cmd cmd;
 	struct mmc_data data;
 
+	if (blkcnt > 1 && mmc->host_caps & MMC_CAP_CMD23) {
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
@@ -1037,6 +1045,10 @@ static int mmc_get_capabilities(struct mmc *mmc)
 
 	mmc->card_caps = MMC_MODE_1BIT | MMC_CAP(MMC_LEGACY);
 
+	/* CMD23(SET_BLOCK_COUNT) requires eMMC spec v3.1 or above */
+	if (mmc->version < MMC_VERSION_3)
+		mmc->host_caps &= ~MMC_CAP_CMD23;
+
 	if (mmc_host_is_spi(mmc))
 		return 0;
 
@@ -1436,6 +1448,8 @@ static int sd_get_capabilities(struct mmc *mmc)
 
 	if (mmc->scr[0] & SD_DATA_4BIT)
 		mmc->card_caps |= MMC_MODE_4BIT;
+	if (!(mmc->scr[0] & SD_SCR_CMD23_SUPPORT))
+		mmc->host_caps &= ~MMC_CAP_CMD23;
 
 	/* Version 1.0 doesn't support switching */
 	if (mmc->version == SD_VERSION_1_0)
diff --git a/drivers/mmc/mmc_write.c b/drivers/mmc/mmc_write.c
index 928c05872ca..971e61295a1 100644
--- a/drivers/mmc/mmc_write.c
+++ b/drivers/mmc/mmc_write.c
@@ -165,7 +165,15 @@ static ulong mmc_write_blocks(struct mmc *mmc, lbaint_t start,
 
 	if (blkcnt == 0)
 		return 0;
-	else if (blkcnt == 1)
+	if (blkcnt > 1 && mmc->host_caps & MMC_CAP_CMD23) {
+		cmd.cmdidx = MMC_CMD_SET_BLOCK_COUNT;
+		cmd.cmdarg = blkcnt & 0x0000ffff;
+		cmd.resp_type = MMC_RSP_R1;
+		if (mmc_send_cmd(mmc, &cmd, NULL))
+			return 0;
+	}
+
+	if (blkcnt == 1)
 		cmd.cmdidx = MMC_CMD_WRITE_SINGLE_BLOCK;
 	else
 		cmd.cmdidx = MMC_CMD_WRITE_MULTIPLE_BLOCK;
@@ -191,10 +199,13 @@ static ulong mmc_write_blocks(struct mmc *mmc, lbaint_t start,
 		 */
 	}
 
-	/* SPI multiblock writes terminate using a special
-	 * token, not a STOP_TRANSMISSION request.
+	/*
+	 * SPI multiblock writes terminate using a special token, not CMD12.
+	 * When CMD23 was issued the card auto-terminates, so CMD12 is also
+	 * skipped in that case.
 	 */
-	if (!mmc_host_is_spi(mmc) && blkcnt > 1) {
+	if (!mmc_host_is_spi(mmc) && blkcnt > 1 &&
+	    !(mmc->host_caps & MMC_CAP_CMD23)) {
 		cmd.cmdidx = MMC_CMD_STOP_TRANSMISSION;
 		cmd.cmdarg = 0;
 		cmd.resp_type = MMC_RSP_R1b;
diff --git a/include/mmc.h b/include/mmc.h
index 9509c9e9543..4bda44ea220 100644
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

-- 
2.51.0

