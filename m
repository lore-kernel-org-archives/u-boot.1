Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309CEC3601A
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 22:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCBC082B27;
	Sun,  6 Apr 2025 00:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SjZADAUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF7982B27; Sun,  6 Apr 2025 00:13:32 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C70EE82ABA
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 00:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-af6a315b491so2785778a12.1
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743891207; x=1744496007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqRN4BOJRz5HuTYf5bcnlogkD6JTsPSyi60mFnFlM8k=;
 b=SjZADAUoxvR+2/0xZKMhMQeputvoECmSJRGfsMIeAqQNuu7cGIBMzeIegXHvWshbHG
 7fhIhVt1bi16yHINqabi4VX9BjCF0sUmLMU65mmOcoE9bj3YR/Wge3oRsowkMC9tUb6K
 vpdwX3XfV3Yg3k5jE/C8TreXgcNfi51Z60SHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743891207; x=1744496007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqRN4BOJRz5HuTYf5bcnlogkD6JTsPSyi60mFnFlM8k=;
 b=cbCsVJaovQ3kV/ftek3pVPJz5WfvVLOi6mP507AEkMXKluydQ3j0YuFpS9ebVJkgmv
 cPzKxXTbsXIURkicfTdoGmHhT4Rlwg8n54eZfdBiIez9zxtJiSBum3xQkVeiyM62H0+e
 NLpBs6qGMF/h9tJsMPiYad1e1nWKivF8mXQ0d2GhmR/fA9E7C1K65Mb5LRIr3tyaTe/k
 8n8Tk361M5VUUo2EDe2D8VTSY21/AwRxMz2IzO+k28Es1P3zdjuU0x6KzXiUlh70GRQJ
 MoI3kP7RMnqeKvPQymXFSSX/KJi4saya4BN1dUlHYBuB03jsBKtgGcK5d7xlDNrMqqbn
 q5ZQ==
X-Gm-Message-State: AOJu0YxCyARJ7w2zuKNCV5Z7THaVfWWbEfrHgQRWl7KKTfbkPF0mWMXP
 NPHpxTNtqwetfA1rVLM0cfWJk5ZcJlgKVhIpcOXk7jEWmho6ASDYmxT/t8xdaM78kd2OFsjqloI
 P+Q==
X-Gm-Gg: ASbGnctmj9OvOiQzpZIUhSAexwa9ROflIAQRbOK26nvcaqu3RVAtyIAjRe4t2tCOqzQ
 RoGrcbGMVpxTvlC6IJTxI27l4H9gzT8u2aQlEHoK8GB/MThClWHLPlrcQnKWyJKnRORrtXAhAVh
 X+IgRMHT3gLtjXPSP19DdmvFFU7c07yIrjIby3X40ww9nj7PSwjS4rfPwI6KZ08qB7Iiq8Z45xG
 zrNq5yINNiwNuJMfZB//TKAVM7+ueiBlhvi+x7GUGbxerH790Vb4RB4XT1ucDxIoLwObNymPuc9
 CxCgmLbN9TgPdtx0YaFygdfg73+F6y23vxSJyxMcIEk=
X-Google-Smtp-Source: AGHT+IHSchHkvLwFTljc4pmaAMwO4NXUDeOWljG2BNk3f6NG0zzoKa8X1Ot9qHUasxR8KtEeO9ASUw==
X-Received: by 2002:a17:902:c94e:b0:224:5a8:ba29 with SMTP id
 d9443c01a7336-22a8a0b38bdmr87775605ad.43.1743891207123; 
 Sat, 05 Apr 2025 15:13:27 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866e612sm54431615ad.200.2025.04.05.15.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 15:13:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, neil.armstrong@linaro.org,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Christian=20Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot-amlogic@groups.io
Subject: [PATCH 2/3] designware: Use the remove() method with related drivers
Date: Sun,  6 Apr 2025 10:12:46 +1200
Message-ID: <20250405221308.498047-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250405221308.498047-1-sjg@chromium.org>
References: <20250405221308.498047-1-sjg@chromium.org>
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
implement the remove() method. Add this so that DMA is stopped when the
OS is booted to avoid memory corruption, etc.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
---

 drivers/net/designware.c    |  2 +-
 drivers/net/designware.h    | 12 ++++++++++++
 drivers/net/dwmac_meson8b.c |  6 ++++++
 drivers/net/dwmac_s700.c    |  6 ++++++
 drivers/net/dwmac_socfpga.c |  6 ++++++
 5 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index eebf14bd51a..d4d31925fca 100644
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
index fde4aabbace..b2152f8da9b 100644
--- a/drivers/net/dwmac_meson8b.c
+++ b/drivers/net/dwmac_meson8b.c
@@ -145,6 +145,11 @@ static int dwmac_meson8b_probe(struct udevice *dev)
 	return designware_eth_probe(dev);
 }
 
+static int dwmac_meson8b_remove(struct udevice *dev)
+{
+	return designware_eth_remove(dev);
+}
+
 static const struct udevice_id dwmac_meson8b_ids[] = {
 	{ .compatible = "amlogic,meson-gxbb-dwmac", .data = (ulong)dwmac_setup_gx },
 	{ .compatible = "amlogic,meson-g12a-dwmac", .data = (ulong)dwmac_setup_axg },
@@ -158,6 +163,7 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
 	.of_match	= dwmac_meson8b_ids,
 	.of_to_plat = dwmac_meson8b_of_to_plat,
 	.probe		= dwmac_meson8b_probe,
+	.remove		= dwmac_meson8b_remove,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_meson8b_plat),
diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
index 969d247b4f3..cfb37c3aa71 100644
--- a/drivers/net/dwmac_s700.c
+++ b/drivers/net/dwmac_s700.c
@@ -44,6 +44,11 @@ static int dwmac_s700_probe(struct udevice *dev)
 	return designware_eth_probe(dev);
 }
 
+static int dwmac_s700_remove(struct udevice *dev)
+{
+	return designware_eth_remove(dev);
+}
+
 static int dwmac_s700_of_to_plat(struct udevice *dev)
 {
 	return designware_eth_of_to_plat(dev);
@@ -60,6 +65,7 @@ U_BOOT_DRIVER(dwmac_s700) = {
 	.of_match = dwmac_s700_ids,
 	.of_to_plat = dwmac_s700_of_to_plat,
 	.probe  = dwmac_s700_probe,
+	.remove	= dwmac_s700_remove,
 	.ops    = &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct eth_pdata),
diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
index a9e2d8c0972..8e7a9975d28 100644
--- a/drivers/net/dwmac_socfpga.c
+++ b/drivers/net/dwmac_socfpga.c
@@ -130,6 +130,11 @@ static int dwmac_socfpga_probe(struct udevice *dev)
 	return designware_eth_probe(dev);
 }
 
+static int dwmac_socfpga_remove(struct udevice *dev)
+{
+	return designware_eth_remove(dev);
+}
+
 static const struct udevice_id dwmac_socfpga_ids[] = {
 	{ .compatible = "altr,socfpga-stmmac" },
 	{ }
@@ -141,6 +146,7 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
 	.of_match	= dwmac_socfpga_ids,
 	.of_to_plat = dwmac_socfpga_of_to_plat,
 	.probe		= dwmac_socfpga_probe,
+	.remove		= dwmac_socfpga_remove,
 	.ops		= &designware_eth_ops,
 	.priv_auto	= sizeof(struct dw_eth_dev),
 	.plat_auto	= sizeof(struct dwmac_socfpga_plat),
-- 
2.43.0

base-commit: bcfa94be955ef263d37918ef4b8f898ee8964c61
branch: eth
