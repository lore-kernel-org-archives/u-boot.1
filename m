Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAA0C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BD55808B6;
	Sat, 22 Feb 2025 21:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LNhMI2EY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JF44TchA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B479980F92; Sat, 22 Feb 2025 21:36:19 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A4A800C2
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z0f0d2HtZz9sdJ;
 Sat, 22 Feb 2025 21:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QM1+x1DAVmLYpP8h2Moaehzqk8uamI7EU+Evf8Lk1IY=;
 b=LNhMI2EYRTC8SnsN0FvYmBBcoL2mO+qThEUUoz+NNVbYDk8J9DR+wgb3QuFUqJdKL0zYff
 hAc2JqMnXPinvVA2TZsoCfY5NdKx2Gk19+xRj+sx1zkZSU08mokhjhXQfCiHMrX0P3XUrG
 7gd2lgj+bRI1x3QNDtNSTMzW8Eo0pVXsKHnuvIk/+Uw2wzOGjIRZdYYWd1gF5oJX8dZyxI
 /EfJZYueiI7yHetYvKUbn3BQdCy0kS3kpJU1FixLYGuyqRCgl+nVb2te1M2m2OO45NZn9h
 e4Y0oTItAqMdsdgAnhGUhEmeFuE52KAwMPkY42ykGcUpPmTCZ+tIUaIycuJ4gw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QM1+x1DAVmLYpP8h2Moaehzqk8uamI7EU+Evf8Lk1IY=;
 b=JF44TchAkL2pq3j84fPfQcf6tW9R3fjh2JhZcFNjULe5XcOx/cwHfQeIu/kHt0skSaQLIT
 v44YjX2eM5D/uuSTUifwGgG9+pm2jtdmpb04uhqRsng0w5QfTSc0dLEr7KkVkz3Dx7kzT7
 d1DHoeX7BNvUSRLbzF4enZ0zsO8au5vWcwOry0v0SGr5f6yIfB1mn2HqOfYiDxXVbiTOXG
 VYOOlq8Tz42UutVK92fJ3wKyl4aN3A+IwPLAL5qynPcTahUQTdru2ZDHdJ7XphIZ3+aDhq
 /RFr54XlJizure8wALwNMQU1D5uzB5TQf5qCPFr7nYE/HCdX4Z3kGfiPWaOZoQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/23] net: designware: Drop bus index
Date: Sat, 22 Feb 2025 21:33:20 +0100
Message-ID: <20250222203511.195437-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zddmqg8i6pm77w8q43uwedtra46w97oh
X-MBO-RS-ID: cacc99bcb5c3e6afe2f
X-Rspamd-Queue-Id: 4Z0f0d2HtZz9sdJ
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

There is literally one single bbmiiphy bus in this driver,
remove the bus index handling.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Jim Liu <JJLIU0@nuvoton.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: New patch
V3: No change
---
 drivers/net/designware.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 95a459cec2a..de697060d28 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -905,8 +905,6 @@ int designware_eth_probe(struct udevice *dev)
 
 #if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
 	if (dev_read_bool(dev, "snps,bitbang-mii")) {
-		int bus_idx;
-
 		debug("\n%s: use bitbang mii..\n", dev->name);
 		ret = gpio_request_by_name(dev, "snps,mdc-gpio", 0,
 					   &priv->mdc_gpio, GPIOD_IS_OUT
@@ -924,16 +922,11 @@ int designware_eth_probe(struct udevice *dev)
 		}
 		priv->bb_delay = dev_read_u32_default(dev, "snps,bitbang-delay", 1);
 
-		for (bus_idx = 0; bus_idx < bb_miiphy_buses_num; bus_idx++) {
-			if (!bb_miiphy_buses[bus_idx].priv) {
-				bb_miiphy_buses[bus_idx].priv = priv;
-				strlcpy(bb_miiphy_buses[bus_idx].name, priv->bus->name,
-					MDIO_NAME_LEN);
-				priv->bus->read = bb_miiphy_read;
-				priv->bus->write = bb_miiphy_write;
-				break;
-			}
-		}
+		bb_miiphy_buses[0].priv = priv;
+		strlcpy(bb_miiphy_buses[0].name, priv->bus->name,
+			MDIO_NAME_LEN);
+		priv->bus->read = bb_miiphy_read;
+		priv->bus->write = bb_miiphy_write;
 	}
 #endif
 	ret = dw_phy_init(priv, dev);
-- 
2.47.2

