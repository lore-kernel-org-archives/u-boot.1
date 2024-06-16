Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4527C27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 14:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088BA87B30;
	Sun, 16 Jun 2024 16:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Z3saoTn3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wF+IU5AQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44EF687FC2; Sun, 16 Jun 2024 16:59:18 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3055C87837
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 16:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W2GPb0ZLqz9sWx;
 Sun, 16 Jun 2024 16:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718549955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qHQrGhThNpLDkigBNmOtz3ntm1rLWsOZpSNktN6Q7Bg=;
 b=Z3saoTn3PpykYCAzNEOizLewZzl3eMSfCgt7XQzf4MnqnT/iZizpjl/86QytU1sUTP0fP1
 FBV7zZ9cw0ahoP3pNDXtw/rR5rMpuPPvbSHzuQAGaIto2vbWRYoQdHK47Ewj4Ge8AznsCL
 NCwBhpQ8nZfLyn1RJeJOnW6CVGYAUKQOKa1JiBQKamoH+oOTC39SChnIMQim5raHd1q4k1
 vQ/Bcuack357vMhyaI2Tuo/GoJiAxhW3x7OCe7uQ6F9gKhED03APEsGub3/QL1jRvKzKvQ
 zAYVcaRWlZAjmnwHYaS/csmDw4up610JGLm35wkOYwRirOKEeQQupESfL9MLKA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718549953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qHQrGhThNpLDkigBNmOtz3ntm1rLWsOZpSNktN6Q7Bg=;
 b=wF+IU5AQb0olq3TiW9UXvKoTsWKWJigDgQAz6Qf4DquLqIXBEV6cWa14HurE9ekI8BsuB8
 deeRFkUqeIamFAJMWDiBVPy9dYAE5ozzxT/YhKZxoIIzwdbTJwH4FojpdgSpSp8BQ02aaI
 UEKuGD18N0Wxbwi3MkcY/hkVSt5PWHQ9KzkZ4cu2xg8hQJs7N2Vftv6Rf2zYUlXQRde1IK
 30Jc2BB07nDINVpoVln18YfpkrVUaFfbUnGI5LXkYX/wIzPEZiEVYt3xMma7E33b7IySKB
 EiGeEXxTYkVX5RXrZTUvqOOzo7DWxdMTV9P2Y11hEDT29BUKuraTc+p9RswAnA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5] mmc: Poll CD in case cyclic framework is enabled
Date: Sun, 16 Jun 2024 16:58:49 +0200
Message-ID: <20240616145857.26833-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mb9idnhj18rktbbsbfg8s5im6f88gcmf
X-MBO-RS-ID: e9ff1fd3941a02202b6
X-Rspamd-Queue-Id: 4W2GPb0ZLqz9sWx
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

In case the cyclic framework is enabled, poll the card detect of already
initialized cards and deinitialize them in case they are removed. Since
the card initialization is a longer process and card initialization is
done on first access to an uninitialized card anyway, avoid initializing
newly detected uninitialized cards in the cyclic callback.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: Move the cyclic registration/unregistration into mmc init/deinit
V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
    does not work with structure members
V4: Stuff the code with CONFIG_IS_ENABLED() variants to avoid #ifdefs
V5: Rebase on u-boot/next
---
 drivers/mmc/mmc.c | 32 ++++++++++++++++++++++++++++++++
 include/mmc.h     |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index b18dc331f78..7cf64535b68 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3005,6 +3005,20 @@ static int mmc_complete_init(struct mmc *mmc)
 	return err;
 }
 
+static void __maybe_unused mmc_cyclic_cd_poll(void *ctx)
+{
+	struct mmc *m = ctx;
+
+	if (!m->has_init)
+		return;
+
+	if (mmc_getcd(m))
+		return;
+
+	mmc_deinit(m);
+	m->has_init = 0;
+}
+
 int mmc_init(struct mmc *mmc)
 {
 	int err = 0;
@@ -3027,6 +3041,19 @@ int mmc_init(struct mmc *mmc)
 	if (err)
 		pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
 
+	if (CONFIG_IS_ENABLED(CYCLIC, (!mmc->cyclic), (NULL))) {
+		/* Register cyclic function for card detect polling */
+		CONFIG_IS_ENABLED(CYCLIC,
+			(mmc->cyclic = cyclic_register(mmc_cyclic_cd_poll,
+						       100 * 1000,
+						       mmc->cfg->name, mmc)));
+		if (CONFIG_IS_ENABLED(CYCLIC, (!mmc->cyclic), (NULL))) {
+			printf("Failed to register %s CD poll function\n",
+			       mmc->cfg->name);
+			err = -EINVAL;
+		}
+	}
+
 	return err;
 }
 
@@ -3034,6 +3061,11 @@ int mmc_deinit(struct mmc *mmc)
 {
 	u32 caps_filtered;
 
+	if (CONFIG_IS_ENABLED(CYCLIC, (mmc->cyclic), (NULL))) {
+		cyclic_unregister(CONFIG_IS_ENABLED(CYCLIC, (mmc->cyclic), NULL));
+		CONFIG_IS_ENABLED(CYCLIC, (mmc->cyclic = NULL));
+	}
+
 	if (!CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) &&
 	    !CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) &&
 	    !CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
diff --git a/include/mmc.h b/include/mmc.h
index 7f1900363b9..7c98ace5346 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -14,6 +14,7 @@
 #include <linux/sizes.h>
 #include <linux/compiler.h>
 #include <linux/dma-direction.h>
+#include <cyclic.h>
 #include <part.h>
 
 struct bd_info;
@@ -733,6 +734,8 @@ struct mmc {
 	bool hs400_tuning:1;
 
 	enum bus_mode user_speed_mode; /* input speed mode from user */
+
+	CONFIG_IS_ENABLED(CYCLIC, (struct cyclic_info *cyclic));
 };
 
 #if CONFIG_IS_ENABLED(DM_MMC)
-- 
2.43.0

