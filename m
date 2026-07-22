Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C4AC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:21:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E15A4607E6;
	Wed, 22 Jul 2026 15:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SoCcpcLu9rp4; Wed, 22 Jul 2026 15:21:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27510607D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784733694;
	bh=4MpTUMx0xUzfW5DVHmgaU8gIkS3JMerbLFuusa430S4=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=wJg8MJOjMHMDKZ4brsKVcRhDdh28jkuj4SNiVsVMcu0cU4FQS6PfBoYm/WbZSZZD/
	 l96TJ+R7pWDI9JSl/SoEAw5fyYzNvwSMFPVdwKgSdj1X8hMvnnCXw7tvmLcyLOdROX
	 iWjyY73VvniuM3QPJL4H3Xz1tn2FSEvb0CIadDeOMaHwSauUGy7L3smMouU1sKJn0u
	 E402hVWpzdvk0TFgxg7wFhzIdVF73oKcVSwfo0jgngtT1NTrtzNUyz8GLlg/A1Ckk7
	 r6S1nsxLyoCnTU3u02447242fTChb43bsHbqFPNZhJPzh9IY3KisLCM8NK3kEsWu2m
	 12CzaqG9TrnWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27510607D4;
	Wed, 22 Jul 2026 15:21:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B3971093
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 492DD607D4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:21:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DDVRGCG-o7aK for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:21:32 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=eric.chung@riscstar.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F0295607C1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0295607C1
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0295607C1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:21:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28A138494B; Wed, 22 Jul 2026 17:21:30 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CECE0848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:21:27 +0200 (CEST)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so9316369a12.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784733686; x=1785338486;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4MpTUMx0xUzfW5DVHmgaU8gIkS3JMerbLFuusa430S4=;
 b=ADuK6UC4rZEEjbyGYJtaKcyVrwUwe0fTbIRBzyPE1p6afHIOMgcuWfyPoLJQRKw/Tm
 rbZ0yoPsPdScgbxx4zixOYjOiYN+L/izAaKvMG2LurQQFWOBAqbRjWdeu4ldpa8EBBH7
 hUc4Gpcc8C6eh0E6JlQrtwvS3A7nrMiJ2NOybUhReNmmTdECZJylTymeganZA6aJnHT0
 EpCY6VWLUaFZOiUO3MuRi2NEietIU3sIlihXWNr4fT+s1WtrteXJmEbob+nB1aJkN2qt
 2fKz5E+lo4qNesj2LW3urVDRghgr+aNErkSHVBdAX5VSmUgFnDARtM7c4E62/Nn7jihA
 d/Ww==
X-Gm-Message-State: AOJu0Yyrn6h7fA2EA5FwFJTbizehzTPmYI6gSiy514QvV1/otxy+zdH6
 4QyYmlA+73uYC4HuC+ksa3h7AFi8V7lyDW1YsICp2zbH2yQtX3kBgBCVezR0ptfdni4=
X-Gm-Gg: AR+sD13NQTv6plujgDVBBmLVduj1Oq/5N+8j5GJ2xZ0ZhJN8iX3MZkIjF9pXc78tzxk
 WzKvVMa7C8TpIsq5ToibIcsc/lkuuVot3y4SkcxOYJzW2thtzfIum15jisKiMiyxDlWoW7kPsVP
 6x1x0YI/fL3KRA0IcYEQBOA1PxAOoGQnoiRRJkefYy9uZQvKz7OQwOj8Xbmg1gKvjgUVu9zuzX9
 b+sphpTwMygjf/gR88cSQlXEvlX3FW/ZhABGGu93iwLVdh3FaW8sAfMavqXtjOxFC0E9hyGGZ6s
 1GYhAv9fwW+JVH25/HVHb3rfUXn653xk9DDoOTP2PhHfVFNYeLt2UPmikOuJxYTzfY7V5y3McIS
 /W/Ma4NWH2b6O39LBjwaU7yvUUY/QU3RytAmVopnSETZfXymLVkDYkCvxuTTTW+pBhvkzF4/1GM
 rMbieF5kMc3H97wq1aXKCpoOKjLYaTGKA1pv8e5WnhuB6Q+fpXHdadjsWSNv2+o4j7OOVzaUUWg
 /Ctth4+Iu4i6Lc2uO3y7qpi/HbkmSy/SNnAhUJPHSE=
X-Received: by 2002:a05:6a20:9397:b0:3c3:80bf:a861 with SMTP id
 adf61e73a8af0-3c3adb10f48mr25516791637.75.1784733685953; 
 Wed, 22 Jul 2026 08:21:25 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc1e3d9sm8962953eec.5.2026.07.22.08.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:21:25 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:21:16 +0800
Subject: [PATCH] mmc: enable CMD23 for multi-block transfers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-mmc_cmd23-v1-1-cc2926f300a9@riscstar.com>
X-B4-Tracking: v=1; b=H4sIAOvfYGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMj3dzc5Pjk3BQjY90UAzPTJDNjM8vkJAMloPqCotS0zAqwWdGxEH5
 xaVJWanIJyACl2loAJTCzxW0AAAA=
X-Change-ID: 20260722-mmc_cmd23-d065b6369cb0
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Han Xu <han.xu@nxp.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784733686; x=1785338486;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4MpTUMx0xUzfW5DVHmgaU8gIkS3JMerbLFuusa430S4=;
 b=O5X9JO7/Syv2PobT31UI+kWo04EYxdKrXE9QTOtENqo8eJ7As2qmk5mQE/mfxBWkmZ
 I/fyQR5CauVzPBlqc00ZrJFeKVyjv+Urf/lAJkjrfYXmdplwHkbS8iLJ8OUrWshpSfOD
 YYwWnaREqj+iTvRlBUmV+FK4TEPIVw8H44uJ9XVb/B9V4QXKnNVERFI1i/uIKRkR6TKZ
 pFZkANCgHBFboXhfIUURLSeTk0mztv4UaJN+bqfHu5mb4Gwnyad5xZCmF/9jaTZP8ORj
 bUoCi4ZNGUXqBULDxj7mmz1C2wqoScXfHjDMy+xx4dP8MXJlbX1lEuT0CodFrUa0ZiOG
 bfyg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=O5X9JO7/
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.chung@riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.b="O5X9JO7/"; 
 dkim-atps=neutral
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
From: Eric Chung via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Eric Chung <eric.chung@riscstar.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable the support for the CMD23 (SET_BLOCK_COUNT) command to
manage multi-block read/write operations. This allows the MMC
core to use CMD23 in preference to the legacy CMD18/CMD25 plus
CMD12 sequence, reducing command overhead and improving I/O
performance on multi-block transfers.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
It's used to support CMD23 in mmc stack.
---
 drivers/mmc/mmc.c       | 16 +++++++++++++++-
 drivers/mmc/mmc_write.c | 19 +++++++++++++++----
 include/mmc.h           |  3 +++
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 2e565560656..76b65742d53 100644
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

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260722-mmc_cmd23-d065b6369cb0

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

