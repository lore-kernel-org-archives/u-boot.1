Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44296C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 22:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66FC86F23;
	Sun,  5 Nov 2023 23:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mMGFcsTr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BZdeuo7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBD086C8E; Sun,  5 Nov 2023 23:43:24 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27D3286C15
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 23:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4SNqJS09Htz9sqw;
 Sun,  5 Nov 2023 23:43:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1699224200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g1VVpiBZ1R15PPyN+ynACiRUo/x1FSPhJ4JnB/dXNWQ=;
 b=mMGFcsTrKt7De67WReooIJwM1MmbEVJTFMpA9Fib9FrSfGoyUpwqw6Xn9qcDBRKGOz9ACS
 0mYq1r7sZhFAoIvUIpTJbSbH/SS3W2p5FvrMr5fviBHPXgtYVGygrG82yz9756BJiuvbK9
 VUxA2sf9qAXELD8TvfSBMIOwtlpipzlRnk+SIg730lLxtgFl284X+puIp6FP8DIbDd5TZ+
 ZRVl7qdcBeh5r5k8wD4vUAmRxJ1uzatAv0Z2VEnCgBgqt5CQ5dlArJKLiodvLhyvI6IPCb
 LPaT6M9lBYov/oNsHA2hWvOir9cLheGo3rxVPbFdPt18t4fP/WtpDhLWUkoeEQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1699224198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g1VVpiBZ1R15PPyN+ynACiRUo/x1FSPhJ4JnB/dXNWQ=;
 b=BZdeuo7Jnf7F94swOp5swDe+4AcmUUJ8pZ1mBLTnwOo7wHwB47UYjcUDWl1SY884g++4GK
 nqxVzeTGWu87KU5KmLgpTdsEamA5t2oBh7lOB6dYFv7Tc+Z6AbBejj7TZJ9DEc4UzrLs4C
 +lZqxug6MiPLBME4VjSGbD+KxGVrWfV5HHPg33fHSyOeFjAQd0yPpD5EtvOCqfS20FVgKg
 7fl/FqjAjSyMosbYW1kHfFA0VvM96h+pDZhYTaF7NCJd/Mo5tdSzlloSaCsz5pnjYf9LPx
 5HAk/kreLvn7TDaNsQeeJ1fTuZbFvpdyMowIV4+nYZS4E6+Lnj594tZXFtdxUw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: renesas-sdhi: Disable clock after tuning reset when
 possible
Date: Sun,  5 Nov 2023 23:42:45 +0100
Message-ID: <20231105224304.103997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gu6ttd71tzqb8fwd6u8me83z65973a8j
X-MBO-RS-ID: b216631e3cdf8e0aeca
X-Rspamd-Queue-Id: 4SNqJS09Htz9sqw
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

Currently the renesas_sdhi_reset_tuning() unconditionally leaves SDHI
clock enabled after the tuning reset. This is not always necessary.

After the driver performed tuning reset at the end of probe function,
or in the unlikely case that tuning failed during regular operation,
the SDHI clock can be disabled after the tuning reset. The following
set_ios call would reconfigure the clock as needed.

In case of regular set_ios call which requires a tuning reset, keep
the clock enabled or disabled according to the mmc->clk_disable state.

With this in place, the controllers which have not been accessed via
block subsystem after boot are left in quiescent state. However, if an
MMC device is used e.g. for environment storage, that controller would
be accessed during the environment load and left active, including its
clock which would still be generated. This is due to the design of the
MMC subsystem, which does not deinit a controller after it was started
once, the controller is only deinited in case of mmc rescan, or before
OS boot.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Note: To address the part where MMC device has been inited once and
      is never deinited until rescan or OS boot, it would likely be
      necessary to implement something like runtime PM, possibly
      based on the cyclic framework. Basically, keep track of when
      the MMC was accessed last, and if certain time elapsed, deinit
      the MMC. This could also be used to handle card detect polling
      at the same time.
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/renesas-sdhi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 8cd501c5f7c..97aaf1e4ec3 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -318,7 +318,7 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_sd_priv *priv)
 		RENESAS_SDHI_SCC_DTCNTL_TAPNUM_MASK;
 }
 
-static void renesas_sdhi_reset_tuning(struct tmio_sd_priv *priv)
+static void renesas_sdhi_reset_tuning(struct tmio_sd_priv *priv, bool clk_disable)
 {
 	u32 reg;
 
@@ -350,6 +350,12 @@ static void renesas_sdhi_reset_tuning(struct tmio_sd_priv *priv)
 	reg = tmio_sd_readl(priv, RENESAS_SDHI_SCC_RVSCNTL);
 	reg &= ~RENESAS_SDHI_SCC_RVSCNTL_RVSEN;
 	tmio_sd_writel(priv, reg, RENESAS_SDHI_SCC_RVSCNTL);
+
+	if (clk_disable) {
+		reg = tmio_sd_readl(priv, TMIO_SD_CLKCTL);
+		reg &= ~TMIO_SD_CLKCTL_SCLKEN;
+		tmio_sd_writel(priv, reg, TMIO_SD_CLKCTL);
+	}
 }
 
 static int renesas_sdhi_hs400(struct udevice *dev)
@@ -629,7 +635,7 @@ int renesas_sdhi_execute_tuning(struct udevice *dev, uint opcode)
 out:
 	if (ret < 0) {
 		dev_warn(dev, "Tuning procedure failed\n");
-		renesas_sdhi_reset_tuning(priv);
+		renesas_sdhi_reset_tuning(priv, true);
 	}
 
 	return ret;
@@ -668,7 +674,7 @@ static int renesas_sdhi_set_ios(struct udevice *dev)
 	    (mmc->selected_mode != UHS_SDR104) &&
 	    (mmc->selected_mode != MMC_HS_200) &&
 	    (mmc->selected_mode != MMC_HS_400)) {
-		renesas_sdhi_reset_tuning(priv);
+		renesas_sdhi_reset_tuning(priv, mmc->clk_disable);
 	}
 #endif
 
@@ -1095,7 +1101,7 @@ static int renesas_sdhi_probe(struct udevice *dev)
     CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
     CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
 	if (priv->caps & TMIO_SD_CAP_RCAR_UHS)
-		renesas_sdhi_reset_tuning(priv);
+		renesas_sdhi_reset_tuning(priv, true);
 #endif
 	return 0;
 
-- 
2.42.0

