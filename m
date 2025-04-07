Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A8EC3600C
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 01:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4270B82C8A;
	Mon,  7 Apr 2025 03:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U9h+89Yf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A10D82CAE; Mon,  7 Apr 2025 03:35:45 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF4F82CA8
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 03:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2260c91576aso29734965ad.3
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 18:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743989740; x=1744594540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2X8KJewfU5JWVH+GKLrxtiYMARmXughHoHsMBbsu6U=;
 b=U9h+89Yfa1slbeXh5Mvpzky8WtIpgw6ryYNHSVUNGLluWkFdFSGM98KY4lxVSveP/+
 mFP4JOuI2YOvRdYzTWVoiwcK3lRO/NHhLUiW34bVWN2hD5OdvAUs8291RVm/uCRFUebK
 H08FBxLLXIC92D+/b/MvYoWJc8m6xkvOUwtRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743989740; x=1744594540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2X8KJewfU5JWVH+GKLrxtiYMARmXughHoHsMBbsu6U=;
 b=F/tLdekyKf1ffNnd8XjJxMYIYyEfojZODD4Vv9+LjRSadA/RFXMp/FwBxJIZtPdO9H
 lgUwZuDs8pT/RWpoOiYV+ZtmIZCDGlGqpkhmphFgDtyeBYp7xgxX6mTrAeL6lCTqFbff
 18kmbWiy1jQLgp4IZ88ZOkE4q5bvLqfNOgfLhonD4VS3aVVrNAaHh+XoAcmy6gpa8BBH
 ZykAHIx3Ut5DcbXSKNNM1QoiDqjGwu4Mzt2lS40W5VyEMbcPg5Nf6aXNiA4LEk9+20cd
 P/XexKFOVchEPOXnbi5mnrDMRkRaPFVuv/1UrJoi8gEcXgtBm/CbD+BAMKoHLwatWapW
 F+YQ==
X-Gm-Message-State: AOJu0Yxe1+teDZ9uxQ/oWLXBvvJvBFX3VKVND5YXC6oYFhH3ThzncMOC
 gzKZnYq59EsW4KqE2rNHO9WWdF/NzCp+bP0yvFrbBqpkQezEhbKahQZn0d9mUBX3C8VEwSHlYN3
 s3A==
X-Gm-Gg: ASbGncusLoiXB6ml8xLD2GPR8AfulMe/kMz+vd5NQeCkiBpjhLmNbkyLgSNcbBuTNly
 019/Rex/UPODrXY3oP8aCPNs6G1zqdjulLwrEJSh51FTHcdLgSs8uMp7KzFLMrlU0akiHtIHOH/
 Rf+E15LSMJvWXEHAxN+ABAldjT+VpCXyN6fMGiXEDHjOvcgLVwXmy6Oc8MwGiRq0P3jKAg7SNQS
 AWu+khCnGHsriGb7VFrrGLqaNBPMiuZzEYSfMLueK8SnfyyqichKmqixMWG3Tk7UezwJ+ySIocj
 t8OZF/bL8SdZBYbNpkC338vxg5J3YD5E92GlWtt6wj5EFxUB
X-Google-Smtp-Source: AGHT+IHFpxTWjZ2KwunxG9odW3T+YFoM6ECGGTFQ7hzlYI9PeB30MEsB3O/DhaQ6q7SO2q/a/Eviqw==
X-Received: by 2002:a17:903:22cc:b0:223:6657:5008 with SMTP id
 d9443c01a7336-22a8a06b7f6mr176075605ad.24.1743989740421; 
 Sun, 06 Apr 2025 18:35:40 -0700 (PDT)
Received: from chromium.org ([161.29.84.47]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785adad8sm69535765ad.35.2025.04.06.18.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 18:35:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 neil.armstrong@linaro.org, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Christian=20Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot-amlogic@groups.io
Subject: [PATCH v2 1/4] designware: Use the remove() method with related
 drivers
Date: Mon,  7 Apr 2025 13:35:07 +1200
Message-ID: <20250407013513.638110-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407013513.638110-1-sjg@chromium.org>
References: <20250407013513.638110-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Several drivers make use of the designware Ethernet driver but do not
implement the remove() method. Add this to keep things tidy.

Note that the Ethernet uclass calls each driver's stop() method on
removal, so there is no need to do that here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
---

Changes in v2:
- Use the designware_eth_remove() method directly
- Add gmac_rockchip too
- Reword the commit message to mention the uclass' actions

 drivers/net/designware.c    |  2 +-
 drivers/net/designware.h    | 12 ++++++++++++
 drivers/net/dwmac_meson8b.c |  1 +
 drivers/net/dwmac_s700.c    |  1 +
 drivers/net/dwmac_socfpga.c |  1 +
 drivers/net/gmac_rockchip.c |  1 +
 6 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 07b0f49ef58..5385849ea6b 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -805,7 +805,7 @@ clk_err:
 	return err;
 }
 
-static int designware_eth_remove(struct udevice *dev)
+int designware_eth_remove(struct udevice *dev)
 {
 	struct dw_eth_dev *priv = dev_get_priv(dev);
 
diff --git a/drivers/net/designware.h b/drivers/net/designware.h
index e47101ccaf6..8c9d0190e03 100644
--- a/drivers/net/designware.h
+++ b/drivers/net/designware.h
@@ -247,6 +247,18 @@ struct dw_eth_dev {
 
 int designware_eth_of_to_plat(struct udevice *dev);
 int designware_eth_probe(struct udevice *dev);
+
+/**
+ * designware_eth_remove() - Remove the device
+ *
+ * Disables DMA and marks the device as remove. This must be called before
+ * booting an OS, to ensure that DMA is inactive.
+ *
+ * @dev: Device to remove
+ * Return 0 if OK, -ve on error
+ */
+int designware_eth_remove(struct udevice *dev);
+
 extern const struct eth_ops designware_eth_ops;
 
 struct dw_eth_pdata {
diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
index fde4aabbace..bf94e50842d 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -158,6 +158,7 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
 	.of_match	= dwmac_meson8b_ids,
 	.of_to_plat = dwmac_meson8b_of_to_plat,
 	.probe		= dwmac_meson8b_probe,
+	.remove		= designware_eth_remove,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_meson8b_plat),
diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
index 969d247b4f3..e78193f3376 100644
--- a/drivers/net/dwmac_s700.c
+++ b/drivers/net/dwmac_s700.c
@@ -60,6 +60,7 @@ U_BOOT_DRIVER(dwmac_s700) = {
 	.of_match = dwmac_s700_ids,
 	.of_to_plat = dwmac_s700_of_to_plat,
 	.probe  = dwmac_s700_probe,
+	.remove	= designware_eth_remove,
 	.ops    = &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct eth_pdata),
diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
index a9e2d8c0972..dda33f90d65 100644
--- a/drivers/net/dwmac_socfpga.c
+++ b/drivers/net/dwmac_socfpga.c
@@ -141,6 +141,7 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
 	.of_match	= dwmac_socfpga_ids,
 	.of_to_plat = dwmac_socfpga_of_to_plat,
 	.probe		= dwmac_socfpga_probe,
+	.remove		= designware_eth_remove,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_socfpga_plat),
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index 8cfeeffe95b..5c542d62bd8 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -756,6 +756,7 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
 	.of_match = rockchip_gmac_ids,
 	.of_to_plat = gmac_rockchip_of_to_plat,
 	.probe	= gmac_rockchip_probe,
+	.remove	= designware_eth_remove,
 	.ops	= &gmac_rockchip_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct gmac_rockchip_plat),
-- 
2.43.0

