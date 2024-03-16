Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0FCC48BF6
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 20:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C1BC87F64;
	Sat, 16 Mar 2024 21:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q77Wl+QG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AD8ja6oH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B05E487F88; Sat, 16 Mar 2024 21:14:35 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707B6878AA
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 21:14:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Txsls15T2z9sc8;
 Sat, 16 Mar 2024 21:14:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710620073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7+X0sAHS3eKEendquGM01lS/60qiCHxMybbKys9c5WM=;
 b=q77Wl+QGUy4rFinMB2kRsUntqoRGPgSDusleLPGslbQ4P6UbtlzdwiXsUglm9fSWctOD/4
 AFtNw7lwv/MWzsPQX+0OMbgja2/UoiGk/uZ1rQFc/muecIZMeeabUnjMMz2LoiJ8qvFhPy
 8bFEZ9EHdAxD4PH+a6diZxtYA21R0HWanBo71K5nBc/At0K0X7ZQ3SuE2YWlJru7TlT5IR
 cUdfq4GOwMzCMYwD1TqW9pYQdkw4PXiGBkFd9NWI/A7RpQ1PeJBnYb0qAEiNnAaA9LxZdv
 2UK2eODwt+0+G+xhO1du6czcsXpQo+yYe1UY8fCotbDyYSrN/Bq7gly91XR41w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710620071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7+X0sAHS3eKEendquGM01lS/60qiCHxMybbKys9c5WM=;
 b=AD8ja6oHRHEQ8HwBRTy2KdguS8lETUXBBPSPXiAYBpbZ+UnMqua6PRwM3L550XGtMsrBob
 rG9+wBfrbIUQTDkbGzqDqaG2DXA48yWJa8mrytdv7dSSe5NjkdxFakZ3vQMBL6p2+i+HHi
 kaGxDi5ld3/eXh9FVfDnynuKIuX/+8XBicUG7g0eKZ5NVzLHobWTJH/ratnPQoXC/RxcFB
 1nrI9L0FkVrO7uB8jaqYvGIca++8E6rZ9x1Ct6keCxyzJutTsBeLTjLgoT9TtMMU+1Pk5p
 ehKmpAFHabRwINURE4eQr42zRDbV2wZXvyW4AEVxiDMW3YToKGi3i9WjVmkIbA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
Date: Sat, 16 Mar 2024 21:13:57 +0100
Message-ID: <20240316201416.211480-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f1e68811c07960b5009
X-MBO-RS-META: x9r5m9hkc35gurqdfx84ykprpoeryhaf
X-Rspamd-Queue-Id: 4Txsls15T2z9sc8
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
---
 drivers/mmc/mmc.c | 32 ++++++++++++++++++++++++++++++++
 include/mmc.h     |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index eb5010c1465..e90ffd5dcd1 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2985,6 +2985,20 @@ static int mmc_complete_init(struct mmc *mmc)
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
@@ -3007,6 +3021,19 @@ int mmc_init(struct mmc *mmc)
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
 
@@ -3014,6 +3041,11 @@ int mmc_deinit(struct mmc *mmc)
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
index 1022db3ffa7..706566fa1ad 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -14,6 +14,7 @@
 #include <linux/sizes.h>
 #include <linux/compiler.h>
 #include <linux/dma-direction.h>
+#include <cyclic.h>
 #include <part.h>
 
 struct bd_info;
@@ -739,6 +740,8 @@ struct mmc {
 	u8 hs400_tuning;
 
 	enum bus_mode user_speed_mode; /* input speed mode from user */
+
+	CONFIG_IS_ENABLED(CYCLIC, (struct cyclic_info *cyclic));
 };
 
 #if CONFIG_IS_ENABLED(DM_MMC)
-- 
2.43.0

