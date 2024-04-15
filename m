Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6EDC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 21:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 142128826E;
	Mon, 15 Apr 2024 23:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LEHh8D9m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6652A88145; Mon, 15 Apr 2024 23:27:54 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6B7F8780A
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 23:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43FLRmgU001222;
 Mon, 15 Apr 2024 16:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713216468;
 bh=O+G9UPyyR1dWWn4oDE6d5nr6Vg6FnAkZNjp0O+XRf6o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LEHh8D9mcVAYTGSTe5Xxxq0zCDURCd0ro/5ueyD71zB6e9B5NxNCvPos/N0dontnh
 BOLiEOOtiyn1Btt8SbwBLkwsyrWSTsnYlKAXl3yuyGnV2Kt2YF6GdKR9rsvWLxNsaU
 yamUrLmyUNGNg8mSJOGL1QXiJpYR3RpmUyU8e4Rk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43FLRmVX017644
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Apr 2024 16:27:48 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 16:27:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 16:27:47 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43FLRlu5070400;
 Mon, 15 Apr 2024 16:27:47 -0500
From: Judith Mendez <jm@ti.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: Nitin Yadav <n-yadav@ti.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH 1/5] mmc: am654_sdhci: Add tuning algorithm for delay chain
Date: Mon, 15 Apr 2024 16:27:43 -0500
Message-ID: <20240415212747.2678974-2-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240415212747.2678974-1-jm@ti.com>
References: <20240415212747.2678974-1-jm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Currently the sdhci_am654 driver only supports one tuning
algorithm which should be used only when DLL is enabled. The
ITAPDLY is selected from the largest passing window and the
buffer is viewed as a circular buffer.

The new tuning algorithm should be used when the delay chain
is enabled; the ITAPDLY is selected from the largest passing
window and the buffer is not viewed as a circular buffer.

This implementation is based off of the following paper: [1].

Also add support for multiple failing windows.

[1] https://www.ti.com/lit/an/spract9/spract9.pdf

Fixes: a759abf569d4 ("mmc: am654_sdhci: Add support for software tuning")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/am654_sdhci.c | 107 +++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index 05595bdac39..e5ad00e2531 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -97,6 +97,7 @@ struct am654_sdhci_plat {
 	u32 strb_sel;
 	u32 clkbuf_sel;
 	u32 flags;
+	bool dll_enable;
 #define DLL_PRESENT	BIT(0)
 #define IOMUX_PRESENT	BIT(1)
 #define FREQSEL_2_BIT	BIT(2)
@@ -110,6 +111,12 @@ struct timing_data {
 	u32 capability;
 };
 
+struct window {
+	u8 start;
+	u8 end;
+	u8 length;
+};
+
 static const struct timing_data td[] = {
 	[MMC_LEGACY]	= {"ti,otap-del-sel-legacy",
 			   "ti,itap-del-sel-legacy",
@@ -280,8 +287,11 @@ static int am654_sdhci_set_ios_post(struct sdhci_host *host)
 		ret = am654_sdhci_setup_dll(plat, speed);
 		if (ret)
 			return ret;
+
+		plat->dll_enable = true;
 	} else {
 		am654_sdhci_setup_delay_chain(plat, mode);
+		plat->dll_enable = false;
 	}
 
 	regmap_update_bits(plat->base, PHY_CTRL5, CLKBUFSEL_MASK,
@@ -375,38 +385,99 @@ static void am654_sdhci_write_b(struct sdhci_host *host, u8 val, int reg)
 	writeb(val, host->ioaddr + reg);
 }
 #ifdef MMC_SUPPORTS_TUNING
-#define ITAP_MAX	32
+#define ITAPDLY_LENGTH 32
+#define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
+
+static u32 am654_sdhci_calculate_itap(struct udevice *dev, struct window
+			  *fail_window, u8 num_fails, bool circular_buffer)
+{
+	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
+	u8 first_fail_start = 0, last_fail_end = 0;
+	struct window pass_window = {0, 0, 0};
+	int prev_fail_end = -1;
+	u8 i;
+
+	if (!num_fails)
+		return ITAPDLY_LAST_INDEX >> 1;
+
+	if (fail_window->length == ITAPDLY_LENGTH) {
+		dev_err(dev, "No passing ITAPDLY, return 0\n");
+		return 0;
+	}
+
+	first_fail_start = fail_window->start;
+	last_fail_end = fail_window[num_fails - 1].end;
+
+	for (i = 0; i < num_fails; i++) {
+		start_fail = fail_window[i].start;
+		end_fail = fail_window[i].end;
+		pass_length = start_fail - (prev_fail_end + 1);
+
+		if (pass_length > pass_window.length) {
+			pass_window.start = prev_fail_end + 1;
+			pass_window.length = pass_length;
+		}
+		prev_fail_end = end_fail;
+	}
+
+	if (!circular_buffer)
+		pass_length = ITAPDLY_LAST_INDEX - last_fail_end;
+	else
+		pass_length = ITAPDLY_LAST_INDEX - last_fail_end + first_fail_start;
+
+	if (pass_length > pass_window.length) {
+		pass_window.start = last_fail_end + 1;
+		pass_window.length = pass_length;
+	}
+
+	if (!circular_buffer)
+		itap = pass_window.start + (pass_window.length >> 1);
+	else
+		itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
+
+	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
+}
+
 static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 {
 	struct udevice *dev = mmc->dev;
 	struct am654_sdhci_plat *plat = dev_get_plat(dev);
-	int cur_val, prev_val = 1, fail_len = 0, pass_window = 0, pass_len;
-	u32 itap;
+	struct window fail_window[ITAPDLY_LENGTH];
+	u8 curr_pass, itap;
+	u8 fail_index = 0;
+	u8 prev_pass = 1;
+
+	memset(fail_window, 0, sizeof(fail_window));
 
 	/* Enable ITAPDLY */
 	regmap_update_bits(plat->base, PHY_CTRL4, ITAPDLYENA_MASK,
 			   1 << ITAPDLYENA_SHIFT);
 
-	for (itap = 0; itap < ITAP_MAX; itap++) {
+	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
 		am654_sdhci_write_itapdly(plat, itap);
 
-		cur_val = !mmc_send_tuning(mmc, opcode, NULL);
-		if (cur_val && !prev_val)
-			pass_window = itap;
+		curr_pass = !mmc_send_tuning(mmc, opcode, NULL);
 
-		if (!cur_val)
-			fail_len++;
+		if (!curr_pass && prev_pass)
+			fail_window[fail_index].start = itap;
 
-		prev_val = cur_val;
+		if (!curr_pass) {
+			fail_window[fail_index].end = itap;
+			fail_window[fail_index].length++;
+		}
+
+		if (curr_pass && !prev_pass)
+			fail_index++;
+
+		prev_pass = curr_pass;
 	}
-	/*
-	 * Having determined the length of the failing window and start of
-	 * the passing window calculate the length of the passing window and
-	 * set the final value halfway through it considering the range as a
-	 * circular buffer
-	 */
-	pass_len = ITAP_MAX - fail_len;
-	itap = (pass_window + (pass_len >> 1)) % ITAP_MAX;
+
+	if (fail_window[fail_index].length != 0)
+		fail_index++;
+
+	itap = am654_sdhci_calculate_itap(dev, fail_window, fail_index,
+					  plat->dll_enable);
+
 	am654_sdhci_write_itapdly(plat, itap);
 
 	return 0;
-- 
2.43.2

