Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DF7C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19E1F884DC;
	Mon, 22 Jul 2024 19:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BW85u562";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4393A88614; Mon, 22 Jul 2024 19:58:02 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE4F688614
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-703775e4d5dso2242966a34.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671078; x=1722275878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaXsGm/EMP0xrerv4pMH9IvwpK22W5xwacPA9TDWRnE=;
 b=BW85u562zC+FXTO2TDya/cdolygZ7rC4tZdOhLZdW8FVGI09euRAkqmzlLh2nIzVia
 ksY8yXbaAadlXsG2NNH5FdrfnC2eLqD1xb2/4ci4zAmvtJqe+3Pa8C67ETYy1edZl6Dz
 PgwJISRtv/8hJ73peBrZkeEvqmfILODJohQFeMLeVCEIPrAeVNSA6iAM6ZaQDsUb2PLH
 ls/lyoUucmog+2PYWnYgt3tJ6sw29Dr81ZhrpHGYZmyCtUTwV7/VQ7Qscu5EVdb3Uz+b
 JphdwFrGxGAyIph3gkhz/icfOw7JoZpOz4eCV4gjnYOPE2rsxXHK1uJyM2XkUJuNuG3Y
 u9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671078; x=1722275878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xaXsGm/EMP0xrerv4pMH9IvwpK22W5xwacPA9TDWRnE=;
 b=dVLCB49Ga07mqGZc1g9qIfVluybMQexFCmUar7a7Y9VgSkOlEuVEbXCGPO0hKOVNHc
 4P9iLMmVEEvxQHo+r9I+Xxo3tUEo8QLA/swC3jzCG0O2K8dNyuOyr1f2YrWg7guljvfd
 Ev7I2qmZW0KtvXY2LXbLmKJN648sDdqZGVU9gSTF2F2HEDjNkF7AFg+p3HGEer80dvZz
 Bn0aW+TXZ+2ALIzsJZ/OF/pHv0AmMzSrWFiif9wDIVmQw/rMbZik/CEsBS7jKVXnhcOa
 M2pc5wZ7nY4Vj8nbm5op0UbDAEwdtR0jPop+Ccxwg0NZQoVo1voMyTdIQC5Nd7+I4jGk
 Ddew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs9tktYIP8It3tZ+s809FLSETkMgQ+mp17djujnm+gGOpkv1elXq2wC3k6zCGjBs6NM112tM/A+Z8yJTTcr03SHKTdeA==
X-Gm-Message-State: AOJu0Yxug6PVtIjjVMIWiQgYJRymDNONgsMcDYgQ6Aa1RTIf75Iuhbdo
 U11RkueFqo08FH28Z5zZwKqRR8qpInxKwA2lzd54Xb2PnyZmArUUblijxiNDFo4=
X-Google-Smtp-Source: AGHT+IF7ZnztR4IyAqv8AJJpPZ5txVccTfNQS3rBHxFUJlwqOg4bznvQzVbHZXD+NlM+g7xXJcLYXw==
X-Received: by 2002:a05:6830:3814:b0:703:77b1:c653 with SMTP id
 46e09a7af769-709009b1172mr11080955a34.24.1721671078530; 
 Mon, 22 Jul 2024 10:57:58 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60d6ed1sm1635243a34.39.2024.07.22.10.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:58 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 23/38] mmc: exynos_dw_mmc: Read upstream SDR timing
 properties
Date: Mon, 22 Jul 2024 12:57:25 -0500
Message-Id: <20240722175740.6985-24-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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

The obsolete "samsung,timing" dts property is now split into
"samsung,dw-mshc-ciu-div" (for holding the internal DW MMC divider
value) and "samsung,dw-mshc-sdr-timing" (for actual timing values) in
upstream Linux kernel. Rework the driver to make use of new properties
instead of the old one. All affected dts files were already updated
accordingly.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 50d0208b29fd..4108af47e518 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -227,7 +227,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
 	int err = 0;
-	u32 timing[3];
+	u32 div, timing[2];
 
 #ifdef CONFIG_CPU_V7A
 	const void *blob = gd->fdt_blob;
@@ -262,16 +262,16 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	/* Extract the timing info from the node */
-	err = dev_read_u32_array(dev, "samsung,timing", timing, 3);
+	div = dev_read_u32_default(dev, "samsung,dw-mshc-ciu-div", 0);
+	err = dev_read_u32_array(dev, "samsung,dw-mshc-sdr-timing", timing, 2);
 	if (err) {
-		printf("DWMMC%d: Can't get sdr-timings for devider\n",
-				host->dev_index);
+		printf("DWMMC%d: Can't get sdr-timings\n", host->dev_index);
 		return -EINVAL;
 	}
 
-	priv->sdr_timing = (DWMCI_SET_SAMPLE_CLK(timing[0]) |
-			DWMCI_SET_DRV_CLK(timing[1]) |
-			DWMCI_SET_DIV_RATIO(timing[2]));
+	priv->sdr_timing = DWMCI_SET_SAMPLE_CLK(timing[0]) |
+			   DWMCI_SET_DRV_CLK(timing[1]) |
+			   DWMCI_SET_DIV_RATIO(div);
 
 	/* sdr_timing didn't assigned anything, use the default value */
 	if (!priv->sdr_timing) {
-- 
2.39.2

