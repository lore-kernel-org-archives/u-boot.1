Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10062C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C7988541;
	Mon, 10 Jun 2024 03:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZUdkgGvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED3188468; Mon, 10 Jun 2024 03:12:46 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46116884C5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-24c9f628e71so1992945fac.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981963; x=1718586763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roWRK/rU+GAWWadjVAp6QeIoYQp30k3brzMlJdJKnGA=;
 b=ZUdkgGvnrgZ2ZI5a668+x5ElOVAui39aEln/qfQEGpWKIZ89HK7crxKIP6Jrdnqjyc
 ROS4fsIv0u0K8ht7PseMRSgHxHo+Ngt7llwl9ZgbstNenC6uO2Eiv43PPLdgBGkzV/q7
 JW+Ni86vPJuNjKTjngEo5eITwfLiFj0aMziP94yTw95OR+EUrZl2xkw66muOMH+3h/y0
 OEy3lCa4oPxYGqKDE3lELlzMSLOsjPOG619JohReQzpWbWxR4Kr7QS539g37oK4+j022
 s+t+ZvVznbKZVRu4rLJr8D0IT6w9X8i9pqGttBYZ96OegeDmmPgD/4oFzRpzH6tvnO/q
 QQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981963; x=1718586763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=roWRK/rU+GAWWadjVAp6QeIoYQp30k3brzMlJdJKnGA=;
 b=HDYHXfiUTJ2VaYunWjlLfthAA6dNXN+GIDUhGcoI3cc3zq6EAw3mCv9h6jZaPTwtfw
 geW2JmTFEJTvT8G3buxeaCWwPlm2A2RSUiZsp+BufFjK4bY1eHe6yd7IjBFmuQoPQQ9Z
 gGrFAVmBOG9M8GQj7p9+JImewQLOtGAyueMq8kh+SaHY6ee+AnTsJBU77AbVbYCBjUOk
 7KAMGvdOaQl/NN5LJX/PdpjfjEBnAwYKyb0Ti6/zAGJq38JAq4g4I1lqYSpEF41Xfgmy
 TmxWcrfYaavIegVu84SgBFILXFO8Gp7Rvw2BQULtkTLnoVdqgthbyFCWaEG3vK8E0Z4u
 gkJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrGqvjG6EPITnkvBHqUinIbge/bnv9FGj4c/+x76aRr9rwKVqt73uKcF23u09ngRWGByRbxWDXLFbqyLxyerwEDFZWQw==
X-Gm-Message-State: AOJu0Yw94sikF24APPAHTJ0bP/8DfLAG9ojhLS7k+/VRMVFMb82WeExG
 OiaJUAxqeAIubAoYSiDITiWJTfCSqSF7ZvqjZx+XI2EQ8mzDedI+YWNlM0D+xHI=
X-Google-Smtp-Source: AGHT+IH1Rk1l4FllECmwxhgHDm62Feqw2rlKTVxkQvprzH+90gA097XKMNUnJQthptEqMsoRPnVFKw==
X-Received: by 2002:a05:6870:55ca:b0:254:a9bd:70b2 with SMTP id
 586e51a60fabf-254a9bdcf5cmr4076841fac.59.1717981963054; 
 Sun, 09 Jun 2024 18:12:43 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9896fbfcfsm615803a34.34.2024.06.09.18.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:42 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 22/40] mmc: exynos_dw_mmc: Use .of_to_plat for device tree
 parsing
Date: Sun,  9 Jun 2024 20:12:08 -0500
Message-Id: <20240610011226.4050-23-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

exynos_dwmci_get_config() is called from the probe function and used to
read data from device tree. Make use of .of_to_plat driver callback
instead, and convert exynos_dwmci_get_config() to match its signature.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index de39a8d7f3c1..95c64b9eda54 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -224,10 +224,13 @@ static int do_dwmci_init(struct dwmci_host *host)
 	return exynos_dwmci_core_init(host);
 }
 
-static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
-				   int node, struct dwmci_host *host,
-				   struct dwmci_exynos_priv_data *priv)
+#ifdef CONFIG_DM_MMC
+static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 {
+	const void *blob = gd->fdt_blob;
+	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
+	struct dwmci_host *host = &priv->host;
+	int node = dev_of_offset(dev);
 	int err = 0;
 	u32 timing[3];
 
@@ -287,7 +290,6 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 	return 0;
 }
 
-#ifdef CONFIG_DM_MMC
 static int exynos_dwmmc_probe(struct udevice *dev)
 {
 	struct exynos_mmc_plat *plat = dev_get_plat(dev);
@@ -302,10 +304,6 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 		return err;
 #endif
 
-	err = exynos_dwmci_get_config(dev, gd->fdt_blob, dev_of_offset(dev),
-				      host, priv);
-	if (err)
-		return err;
 	err = do_dwmci_init(host);
 	if (err)
 		return err;
@@ -336,6 +334,7 @@ U_BOOT_DRIVER(exynos_dwmmc_drv) = {
 	.name		= "exynos_dwmmc",
 	.id		= UCLASS_MMC,
 	.of_match	= exynos_dwmmc_ids,
+	.of_to_plat	= exynos_dwmmc_of_to_plat,
 	.bind		= exynos_dwmmc_bind,
 	.ops		= &dm_dwmci_ops,
 	.probe		= exynos_dwmmc_probe,
-- 
2.39.2

