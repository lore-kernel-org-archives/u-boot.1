Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90284CD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 18:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF61787F24;
	Tue,  9 Apr 2024 20:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rQDlAFiu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2298815E; Tue,  9 Apr 2024 20:03:12 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6726687E06
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 20:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-516d3776334so6133460e87.1
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712685790; x=1713290590; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ar+GLkq8olXtXCFZ6gNxbEZsIwgSsM7ajECkSqXCbvU=;
 b=rQDlAFiucTNy7ku3nZNOF89rRfYA5qFIjS9whbJrvvSQ7krqHHdT9YebB84JA8SIUU
 SKkFSpnpjtnmZyD0ZXFJ7IEsbhPHJyAju+6ukDIA4R47J1WkjMAXjlX8jKxzd7GWASc4
 rzHAP2eQYCXhvF1oKGogEKyFaCzsvw/temTYb1kis7kRxstupvDl4BNVRGlbdM3ZJEkj
 tzELMo5sKRv/UEkN/r85PDgC7TY/JM4fI+sCCINWIZOVvleGFVO5JMbSLdHwyssNLaIs
 pi4xcpm8sRaRvpQm39r2GCnOX/yT8Tjc7ee80Mit+3Yx6RUR9YgglsnygmNejy6sBa0F
 o+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712685790; x=1713290590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ar+GLkq8olXtXCFZ6gNxbEZsIwgSsM7ajECkSqXCbvU=;
 b=d+YLEtu6KbHl0mLrbj+Nbfza5+RgBqtBvGSUnRDyisVXAsS8I2nont7pOxDvkLCusm
 DdScP9D0abXY6Ukm+FQqTmeJ4ZWBn7GjWCgS6s9e84JvMhpA3UEzm7Y3hlaNQWVPIgXa
 d2GFF3E5RarstOOvBFuTuUWdpV01LnENCM1E+hCLn2aGlVRG0rDFN51RS9L12ON2/lJO
 FOe0etwvBRxCNZlfBtibVbZ9N08qO7/3c6BPSZWL7jYUVmvRxzb8pfd4Xk0JbpvkEj3L
 FvaXdIG4MksWXIEUq298qK9KX2+Y3SXfjEPG4XwVCIUdAO/L7aDlmn6wNty3HBMKL49f
 Cl+Q==
X-Gm-Message-State: AOJu0Ywdc+DxBmuiZuc4IeM4iOfL9NwXCPMIV528PtJuLUZhj352Al+e
 DVlucVaHh+VyfjyRjijapUe6wzqUD56a7I6CsAMFFL9HP4GVk3nHBtKv6J7/7QE=
X-Google-Smtp-Source: AGHT+IHAHvfYi+kK/KT9MFrNBuQP6Us7cetEBBm2YruJ5s90S/r8/aWwWotLw++lrWnManSCoepbKA==
X-Received: by 2002:a05:6512:471:b0:516:cd83:a967 with SMTP id
 x17-20020a056512047100b00516cd83a967mr115188lfd.39.1712685789585; 
 Tue, 09 Apr 2024 11:03:09 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170907272400b00a4e5866448bsm5928783ejl.155.2024.04.09.11.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 11:03:08 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Apr 2024 20:03:01 +0200
Subject: [PATCH 2/7] mmc: msm_sdhci: use modern DT handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-b4-qcom-mmc-fixes-v1-2-5039164ecbf7@linaro.org>
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2155;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GNkT+VoVVSHYWOeeCeepO0GYTFZwgAuMqkw0qhSSg8I=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFYLYpDY2H860LTRSC0PYBg1Tki71CFX/6j3Fe
 AKMDQYudLeJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhWC2AAKCRAFgzErGV9k
 tkaAEACSYQavKHBDJWC0X9y/ZhoR/i3dgRrhBgyRkrehUJJ+DLMnMqPMfGwEH+2LUGM7X32JKP5
 Bqs8Wx6DhcDMTnkkqPsPulg1oJNHsyEWhLHHW0lS0HZ2tdGv2Xf2gItmlAZ9nUiFr9djsFPuJX8
 2+CUhvqiammCdr9CJ1IB4+3D/9iGMRsUhuTuWii1VEQpXu3D+LIJ+4jJ8FO4Cp6q1GZPiFcUPWN
 TXB7GtXMPipaj1aMLX1ZRJWCHmIvE71TRCgRquIpexqJoLfjPmTfQhHz7cdN8yE79iS+bSMU3Hj
 /spcexaFDS7D6GWQpEvkpzNrSB/N5cFZnQc/2/ez3y5PFKsr97G+X+fYAdB2CcR8IZ6qAUrR1ac
 2pk+WNAMQ7Wy+8nr2TJuH8PGB6Ie/SxBC7ill/RRcHP79jYMyKheLgV00QvMmsNjGVZndnfXGTx
 vJveU++hds/X1+1vS+xcjd0IdZbvG2hXox8a4uMSrJoMEGnZW8P0H2pENtrgZmkKYFxZvIYw/7b
 lKfJa88iFb8RZqGpkw7JwFawcEfElr8ygyX+tUHhc9TYHiIrwNdZ1uTEa4Ntjalz5e+Nz37bb6l
 9C9kDuMiMgR/bE5xqOz3k1i9emVN5PIipUtzX+3taRqHT3s1O3xAAaSPJHd7JeNsagbaf+WHhvv
 d5orHiJ/YiqweuA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

using fdtdec_* functions is incompatible with OF_LIVE and generally
offers a less friendly interface. Update to use dev_read_* functions
instead.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mmc/msm_sdhci.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index f23d425144ef..5689b4765122 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -205,9 +205,9 @@ static int msm_sdc_remove(struct udevice *dev)
 
 	var_info = (void *)dev_get_driver_data(dev);
 
 	/* Disable host-controller mode */
-	if (!var_info->mci_removed)
+	if (!var_info->mci_removed && priv->base)
 		writel(0, priv->base + SDCC_MCI_HC_MODE);
 
 	clk_release_bulk(&priv->clks);
 
@@ -215,23 +215,33 @@ static int msm_sdc_remove(struct udevice *dev)
 }
 
 static int msm_of_to_plat(struct udevice *dev)
 {
-	struct udevice *parent = dev->parent;
 	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info;
 	struct sdhci_host *host = &priv->host;
-	int node = dev_of_offset(dev);
+	int ret;
+
+	var_info = (void*)dev_get_driver_data(dev);
 
 	host->name = strdup(dev->name);
 	host->ioaddr = dev_read_addr_ptr(dev);
-	host->bus_width = fdtdec_get_int(gd->fdt_blob, node, "bus-width", 4);
-	host->index = fdtdec_get_uint(gd->fdt_blob, node, "index", 0);
-	priv->base = (void *)fdtdec_get_addr_size_auto_parent(gd->fdt_blob,
-			dev_of_offset(parent), node, "reg", 1, NULL, false);
-	if (priv->base == (void *)FDT_ADDR_T_NONE ||
-	    host->ioaddr == (void *)FDT_ADDR_T_NONE)
+	ret = dev_read_u32(dev, "bus-width", &host->bus_width);
+	if (ret)
+		host->bus_width = 4;
+	ret = dev_read_u32(dev, "index", &host->index);
+	if (ret)
+		host->index = 0;
+	priv->base = dev_read_addr_index_ptr(dev, 1);
+
+	if (!host->ioaddr)
 		return -EINVAL;
 
+	if (!var_info->mci_removed && !priv->base) {
+		printf("msm_sdhci: MCI base address not found\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
 static int msm_sdc_bind(struct udevice *dev)

-- 
2.44.0

