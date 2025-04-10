Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD8EC369A4
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D8583A91;
	Thu, 10 Apr 2025 11:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="WOOPQQA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93EC883A92; Thu, 10 Apr 2025 11:01:37 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C017839DD
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1u2nmr-0007bX-3a; Thu, 10 Apr 2025 05:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=Tukf8jVWgUxtXxtxgglGfOget0mfNKJIcHKz1z81+W4=; b=WOOPQQA3tN2TYcQCDb0n
 bL1FsoJ8HLWOtVePkEtHKKgjohV8VeEyHy/USRRVlK9YhYOCy/TC+sxYpG3w3no2it8JN+zGmbgaP
 8HfieKaeKKCyK5sYVOs5YtKg21HOtTR89/cv9zYHnngW2eW6qGtPHiDAnvbO27oyrnkHKftoX3sUp
 f1okyfddeqOGZ+1Dvl1I0jaq/gyYM54iVAyWZZdlNozQGp/zXvLgsIHxeSCyFtFBM9SCkO17Oj0ES
 KNho1FqmrL5UUw9Cw/DrjIu+HTkLEx20GMgbFQAAizUiFbDO1WckzpwYAtbdyD+t7XW8lAkrgcptm
 ttYxqieOn5pIrA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 u-boot@lists.denx.de, regis.ray@landisgyr.com, pascal.dupuis@landisgyr.com
Subject: [PATCH 1/2] mmc: Add a new callback function to perform the 74 clocks
 cycle sequence
Date: Thu, 10 Apr 2025 11:00:20 +0200
Message-ID: <20250410090021.14446-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250410090021.14446-1-othacehe@gnu.org>
References: <20250410090021.14446-1-othacehe@gnu.org>
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

From: Jean-Jacques Hiblot <jjhiblot@ti.com>

Add a new callback function *send_init_stream* which start a sequence of
at least 74 clock cycles.
The mmc core uses *mmc_send_init_stream* in order to invoke the callback
function. This will be used during power cycle where the specification
requires such a sequence after power up.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 drivers/mmc/mmc-uclass.c | 13 +++++++++++++
 drivers/mmc/mmc.c        |  6 ++++++
 include/mmc.h            |  9 +++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index c8db4f811c2..ca5bf1d11e6 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -83,6 +83,19 @@ int mmc_wait_dat0(struct mmc *mmc, int state, int timeout_us)
 	return dm_mmc_wait_dat0(mmc->dev, state, timeout_us);
 }
 
+void dm_mmc_send_init_stream(struct udevice *dev)
+{
+	struct dm_mmc_ops *ops = mmc_get_ops(dev);
+
+	if (ops->send_init_stream)
+		ops->send_init_stream(dev);
+}
+
+void mmc_send_init_stream(struct mmc *mmc)
+{
+	dm_mmc_send_init_stream(mmc->dev);
+}
+
 static int dm_mmc_get_wp(struct udevice *dev)
 {
 	struct dm_mmc_ops *ops = mmc_get_ops(dev);
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 31a72366206..086826c668c 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1663,6 +1663,10 @@ static int mmc_execute_tuning(struct mmc *mmc, uint opcode)
 }
 #endif
 
+static void mmc_send_init_stream(struct mmc *mmc)
+{
+}
+
 static int mmc_set_ios(struct mmc *mmc)
 {
 	int ret = 0;
@@ -2929,6 +2933,8 @@ int mmc_get_op_cond(struct mmc *mmc, bool quiet)
 retry:
 	mmc_set_initial_state(mmc);
 
+	mmc_send_init_stream(mmc);
+
 	/* Reset the Card */
 	err = mmc_go_idle(mmc);
 
diff --git a/include/mmc.h b/include/mmc.h
index 81bccb4cf12..c2d275cdc3e 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -487,6 +487,14 @@ struct dm_mmc_ops {
 	 */
 	int (*set_ios)(struct udevice *dev);
 
+	/**
+	 * send_init_stream() - send the initialization stream: 74 clock cycles
+	 * This is used after power up before sending the first command
+	 *
+	 * @dev:	Device to update
+	 */
+	void (*send_init_stream)(struct udevice *dev);
+
 	/**
 	 * get_cd() - See whether a card is present
 	 *
@@ -566,6 +574,7 @@ struct dm_mmc_ops {
 
 /* Transition functions for compatibility */
 int mmc_set_ios(struct mmc *mmc);
+void mmc_send_init_stream(struct mmc *mmc);
 int mmc_getcd(struct mmc *mmc);
 int mmc_getwp(struct mmc *mmc);
 int mmc_execute_tuning(struct mmc *mmc, uint opcode);
-- 
2.47.1

