Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64300F364DC
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 11:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F6B84199;
	Fri, 10 Apr 2026 13:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="o+lR6fD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B401B8419C; Fri, 10 Apr 2026 13:04:41 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BBF284105
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 13:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so21890885e9.3
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775819077; x=1776423877;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vBVWWARiE/U5RerqrTVYs5Kew8r11V7W6NHM5GIr89o=;
 b=o+lR6fD9ubkKAHTZsu7GJssocJOUNNp3unlkpz6y6vRtnqWP0IZBTI7ds4gCf/2rUJ
 I3OWBLIvtgbIPxMQRo2GUBzTmXxhK76sNo0yd4yjoXSBYXvcL6Dm9VP6/9SrA8b67YsH
 NFUOo+VCcyFq/rzelY82HPXEJw9TbTlm/5kvSqemU13sDKBszynKCMlRNAA3TzcYr7Fc
 G5j29xwzSRaZBucCdDMon4MvZtw6S9NDZt/BZvrf4D9+QwzUxSqyl8jXWLHj5wAsB70N
 RDC9jmlt70t2Pn0oqUlMMxN82mvs41MFwIlZGKvjUB+PQBTI3rH0rGdLbJ6vmYgNUFZj
 J+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775819077; x=1776423877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vBVWWARiE/U5RerqrTVYs5Kew8r11V7W6NHM5GIr89o=;
 b=RhWLyYcxp+vx9Ldxyc/LFaqqRg0uWtHQS+tOb72v2IBr1tl02KJuDgpqA1JM9gVF31
 MYWHQ4pGWir9BIXrQ7WpEZNsYL17RWyv7HDhnO2jpUx+3OCv3uwUqV+b0q+92VpRfTpo
 nhSA+/EzOzGu1RX8B++rOXcOrrHvnM77i0XsUIW5JWqcx45Kntovw1Iwwm4+bOcphkKE
 8fyn7T7tGZiHtMR2OKLRwcrJe3lIiNpyaoQ41U/GyoWO/IvReCZd9PgK3qGTBllnYbwf
 pHRBe9QalZSMmhnSRZY35Cx9KGevMAkjICOQyeg9RN3u0ljlsQuALEVVl2vHvPtIvopd
 /nkA==
X-Gm-Message-State: AOJu0YzV8eFZ7mA0tG0pCQ279gjE07fMLPwXx71v155cSb5IkVYXxaMQ
 ktfDNOTPTb4YFnSwf9uqubjIPOmlcHoJWMBMOgyTFA+4iS9DZI4vY+1XtvgSPbEHXdc=
X-Gm-Gg: AeBDieuEqDQrxl57vAMKW8EefcHXS/jRsTeSc1I/IE/ivyPYNfx1wmzUdrv4ExVJ58l
 M9Jlpl5qwSqxKERBfioM1eiNfeufCVEuCeU7jnCUT/BwBl4g0jOtCjCWrFJOL1/JjqcBVQZYZdp
 WHgHlLEwc4ufmdKWT2g6Ket/Ybjod5uYhWmJMIVUJ2TsA8ubl5nMYEQyBKHiXMmEibCnmitztuz
 7uYNHAyx+OebrWkHMKKHbThjvDfbHGOgt4hZbCl559qF4OP8PGgHp6NnkfHwf5NGmndqXW05a9/
 cPzA4fcOamL1Fo8S49/pDpzDlpt7ZKAtyfbSbDaNUe/iSFrAw6DvwpDUaZ3Q5pM9uxAgpNWHgBT
 MjZQGFoIdqp/J6LGfBD+AqkGOpIJf3rGSbnBz5j1/gSVuQOUvv8/K3m6UoQhHlPfXZEaT1OML76
 vO4O4sY2m9Fu8qIBNshHdkSFStuxHbj4w=
X-Received: by 2002:a05:600c:8595:b0:485:3b00:f93b with SMTP id
 5b1f17b1804b1-488d6ab8082mr25731875e9.31.1775819076669; 
 Fri, 10 Apr 2026 04:04:36 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d681ecd5sm17588125e9.19.2026.04.10.04.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 04:04:36 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 13:04:05 +0200
Subject: [PATCH 3/4] net: cpsw: Use driver data for phy_sel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-cpsw-switch-v2026-07-next-v1-3-c914724b13e4@baylibre.com>
References: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
In-Reply-To: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491; i=msp@baylibre.com;
 h=from:subject:message-id; bh=ciu1GP6BGxcvj1E+kKXDkvBl+hBgQYNeE1oUeiZKczs=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbN81DdW+0m5x9Glx2eJ2Qa1FgRXWB6iynxf4eR+ezc
 e8Jnbumo5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACaSoMLIcPhzxLLbujd2sHKG
 35v+VrFT7PpmrlNdfJuClVIkZ5m7qTD8dxCTnV23jmfXN/t9qwrrb0YVn56zZvueiyw5Ao8infp
 z+AA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Use driver data to pass the correct gmii_sel function. This way new
compatibles don't need manual compatible matching as is done in
cpsw_phy_sel().

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/net/ti/cpsw.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c
index c844416d50ca3db9bb0d9ffe56cd9c352b8c58b0..b1fb009822e9586886e5487e4fbeee115eec9a59 100644
--- a/drivers/net/ti/cpsw.c
+++ b/drivers/net/ti/cpsw.c
@@ -216,6 +216,10 @@ struct cpsw_priv {
 	u32				phy_mask;
 };
 
+struct cpsw_driver_data {
+	void (*gmii_sel)(struct cpsw_priv *priv, phy_interface_t phy_mode);
+};
+
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
 	int idx;
@@ -1067,6 +1071,13 @@ static void cpsw_gmii_sel_dra7xx(struct cpsw_priv *priv,
 static void cpsw_phy_sel(struct cpsw_priv *priv, phy_interface_t phy_mode)
 {
 	const char *compat = priv->data->phy_sel_compat;
+	const struct cpsw_driver_data *drv_data =
+		(const struct cpsw_driver_data *)dev_get_driver_data(priv->dev);
+
+	if (drv_data && drv_data->gmii_sel) {
+		drv_data->gmii_sel(priv, phy_mode);
+		return;
+	}
 
 	if (!strcmp(compat, "ti,am3352-cpsw-phy-sel"))
 		cpsw_gmii_sel_am3352(priv, phy_mode);
@@ -1222,13 +1233,6 @@ static int cpsw_eth_of_to_plat(struct udevice *dev)
 
 			if (ofnode_read_bool(subnode, "rmii-clock-ext"))
 				data->rmii_clock_external = true;
-
-			data->phy_sel_compat = ofnode_read_string(subnode,
-								  "compatible");
-			if (!data->phy_sel_compat) {
-				pr_err("Not able to get gmii_sel compatible\n");
-				return -ENOENT;
-			}
 		}
 	}
 
@@ -1253,9 +1257,19 @@ static int cpsw_eth_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static const struct cpsw_driver_data cpsw_data_am3352 = {
+	.gmii_sel = cpsw_gmii_sel_am3352,
+};
+
+static const struct cpsw_driver_data cpsw_data_dra7xx = {
+	.gmii_sel = cpsw_gmii_sel_dra7xx,
+};
+
 static const struct udevice_id cpsw_eth_ids[] = {
-	{ .compatible = "ti,cpsw" },
-	{ .compatible = "ti,am335x-cpsw" },
+	{ .compatible = "ti,cpsw",			.data = (ulong)&cpsw_data_am3352 },
+	{ .compatible = "ti,am335x-cpsw",		.data = (ulong)&cpsw_data_am3352 },
+	{ .compatible = "ti,am4372-cpsw",		.data = (ulong)&cpsw_data_am3352 },
+	{ .compatible = "ti,dra7-cpsw",			.data = (ulong)&cpsw_data_dra7xx },
 	{ }
 };
 #endif

-- 
2.53.0

