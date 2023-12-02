Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B9CC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 23:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1787E87735;
	Sun,  3 Dec 2023 00:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GbavhNT+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hc7fvTFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47725877E9; Sun,  3 Dec 2023 00:41:21 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69FD7876B2
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 00:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SjRJv0LfCz9smg;
 Sun,  3 Dec 2023 00:41:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701560479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c0TFJuDr42aJ65Zbd6MnRyhCiBxWYVLRID1J9pngqE0=;
 b=GbavhNT+shsu6Ct3DcUI6TGt8zAslhMCla5WMOiLl7xaatvsKHQ2M7Kwqe8p0Gl7NwwKC+
 u37gWJ7P41YBG90yQIbtNqYZb1zMEZ9cEZqK0mQ32NQj5RkZj3rqRhymlIQ5c3TzqKvHKj
 VcGq/bj+Ub66WmzTWoZANmXicvZtKXh33pBIcZQnvhgbTtG2F7Cglf0t54A7pySNVirAYu
 BpCVGs0uXT2Nay7QN66OpvCEFc4woE1CHvsVHH9N8vCiTdRAVlAVZ7iw3iXSs6Yh9q0E0P
 +xZv3PfG5KodVyk06epoqbcqyBYnmLPhr87oJAjtxQpvrD3X13vYmDGQTQUIcQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701560477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c0TFJuDr42aJ65Zbd6MnRyhCiBxWYVLRID1J9pngqE0=;
 b=hc7fvTFhWqmFzbftCUlTjCA+4FWmYzQp18IBmGL9Xy+UDe83gJwJmBcutItEUlwC+jT7Gw
 Stm7VRsjnpeCjaYy0vnKbV+OEt0yFzzVoiOZcuGypEiXeNzHZb6qmrYJkEcoVb6uRAILVs
 8/aCBht9qtYFKu7ZXmUlQcd0vMRv1tpCprZkZD2AYPO0VBGzlNpadzbu3FBCmAWwusY0h3
 g+UI3Lj6Ed9cJdaDUUUxUWlT3gfyK19vt+amQ5o42J7I9vXgvHLnPZW+8IAHg/tKQxl5Iq
 plWM137VpQ0ix1gB+8jOdU+Tf9caw2IH6hDCQ3G1FyXy1FyzIT4mM9AGS5MQmw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: Poll CD in case cyclic framework is enabled
Date: Sun,  3 Dec 2023 00:40:26 +0100
Message-ID: <20231202234109.208243-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c7eb02ce5d85c5527c2
X-MBO-RS-META: ebrb5y78a1p1oqzpnwdsuxwdmkodc5s3
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
---
 drivers/mmc/mmc-uclass.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index cdead044177..c4c9881c40b 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -8,6 +8,7 @@
 #define LOG_CATEGORY UCLASS_MMC
 
 #include <common.h>
+#include <cyclic.h>
 #include <bootdev.h>
 #include <log.h>
 #include <mmc.h>
@@ -343,8 +344,23 @@ struct blk_desc *mmc_get_blk_desc(struct mmc *mmc)
 	return desc;
 }
 
+static void mmc_cyclic_cd_poll(void *ctx)
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
 void mmc_do_preinit(void)
 {
+	struct cyclic_info *cyclic;
 	struct udevice *dev;
 	struct uclass *uc;
 	int ret;
@@ -362,6 +378,17 @@ void mmc_do_preinit(void)
 
 		if (m->preinit)
 			mmc_start_init(m);
+
+		if (!CONFIG_IS_ENABLED(CYCLIC))
+			continue;
+
+		/* Register cyclic function for card detect polling */
+		cyclic = cyclic_register(mmc_cyclic_cd_poll, 100 * 1000,
+					 m->cfg->name, m);
+		if (cyclic)
+			continue;
+
+		printf("Failed to register %s CD poll function\n", m->cfg->name);
 	}
 }
 
-- 
2.42.0

