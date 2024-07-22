Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C17DC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9081788617;
	Mon, 22 Jul 2024 19:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mjk2ORzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4679088614; Mon, 22 Jul 2024 19:57:59 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB7388621
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-70365f905b6so3012348a34.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671076; x=1722275876; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUyYRxpueeOSVxhoJgsfpm5qpbIninTSmLGdu9hQMkw=;
 b=mjk2ORzAgDx4WGM8bhhd7/X5VkUmJ/NRYmlQn7gJeWH27ckrV8yEiU8u7jBWHulvFH
 VXdmbP/SEMNOMnoZqcZ6B6YDLlMtTivqgEqTe/4MfHyyM9OXgod9HgyxJW9agRv+Rb+h
 9pglUZc/gqZaSFEE87dqpsdJ90RvA5LgM65jYVpz1XnXcd/vTRyYFMmzzpfy+DRYz37d
 NrlHx1m0tlrwNZV86LRi+4/g0dsJlC4dB+OMUrJeLjcxT8/bBCJLKYp/W57cnffQDXrL
 bPmlwtUVfwkRWrRtKsyf8mfEJgmbSw0ATMLCtBJ4/nYkB5ShRCvVrXdqhiWEueKtVt3A
 4Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671076; x=1722275876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qUyYRxpueeOSVxhoJgsfpm5qpbIninTSmLGdu9hQMkw=;
 b=skwtOTDVGtNk77raDIdBjypiGplt3gTXwiWV0/hPIozWdgoGbpJBg4v2CBAQ8pY62R
 O38xigAggYhy14aobEk7WXO3552m5lH/WO8KL5HrWGjctShdS4ewSNFtRSyhcJ7plKpy
 k3o1E4pCF+7P07qw4odFwsTbPWiP1MlRHgQtD0KIAsIy8amb9zYebcbnAapxk8MTEX00
 bCm8WFxvruAbKEs9YE/CR63LGelkCmYWquUDykOt8nR6BarBYn9RK0d0yOmgoCWLd+oN
 xcg3ff5q6cppFZRihl2HNjKCAuNyUA7nmYWMbjJ8kekvLawAR7JJlUw7aPi2TbcT4TQo
 50uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNGUULBEnRn3bDZX/7xAYrYxiJaBHVCEhU4nhz+KaN5rOcf6up7FAPVU9PvCCb8yPVQQ4aULzZ0e5ggVBYXwWyLcMZcw==
X-Gm-Message-State: AOJu0YwJTqmQC+Zyr8teVSmvKH5q9qiS/+U9/zYUW51uTD6mZFnakOVa
 rnUkc+MrHFFX95pDw1GIAs9XeBclZmTAvlD80W1RQiIXCCyznBjnMaCtjvEIFw4=
X-Google-Smtp-Source: AGHT+IGynBMbX3cCCVXjyDaZdlirWAutMqDiPwTHUeb0Cawg/WCCqCb/iNXNp4C9b0bfl6lW61/6zA==
X-Received: by 2002:a05:6830:488c:b0:708:b46d:5c76 with SMTP id
 46e09a7af769-709008dd3abmr9251818a34.17.1721671075771; 
 Mon, 22 Jul 2024 10:57:55 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60eb421sm1658717a34.44.2024.07.22.10.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:55 -0700 (PDT)
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
Subject: [PATCH v3 19/38] mmc: exynos_dw_mmc: Don't call pinmux functions on
 ARM64 chips
Date: Mon, 22 Jul 2024 12:57:21 -0500
Message-Id: <20240722175740.6985-20-semen.protsenko@linaro.org>
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

Pinmux configuration on ARM64 platforms must be performed during startup
in pinctrl driver using info from device tree. exynos_pinmux_config()
and pinmux_decode_periph_id() are only available on ARM32 platforms, so
don't call those functions on ARM64 platforms. Instead of the latter
function, use "non-removable" property from device tree to derive the
dev_index value.

This fixes next linking errors on ARM64 platforms:

    ld: drivers/mmc/exynos_dw_mmc.o:
      in function `exynos_dwmci_get_config':
      undefined reference to `pinmux_decode_periph_id'
    ld: drivers/mmc/exynos_dw_mmc.o:
      in function `do_dwmci_init':
      undefined reference to `exynos_pinmux_config'

Fixes: a082a2dde061 ("EXYNOS5: DWMMC: Added FDT support for DWMMC")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - Replaced CONFIG_IS_ENABLED() with #ifdef

 drivers/mmc/exynos_dw_mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index aa542c13fea8..ed2752391603 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -144,6 +144,7 @@ static int exynos_dwmci_core_init(struct dwmci_host *host)
 
 static int do_dwmci_init(struct dwmci_host *host)
 {
+#ifdef CONFIG_CPU_V7A
 	int flag, err;
 
 	flag = host->buswidth == 8 ? PINMUX_FLAG_8BIT_MODE : PINMUX_FLAG_NONE;
@@ -152,6 +153,7 @@ static int do_dwmci_init(struct dwmci_host *host)
 		printf("DWMMC%d not configure\n", host->dev_index);
 		return err;
 	}
+#endif
 
 	return exynos_dwmci_core_init(host);
 }
@@ -163,6 +165,7 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 	int err = 0;
 	u32 timing[3];
 
+#ifdef CONFIG_CPU_V7A
 	/* Extract device id for each mmc channel */
 	host->dev_id = pinmux_decode_periph_id(blob, node);
 
@@ -174,6 +177,12 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 		printf("DWMMC%d: Can't get the dev index\n", host->dev_index);
 		return -EINVAL;
 	}
+#else
+	if (dev_read_bool(dev, "non-removable"))
+		host->dev_index = 0; /* eMMC */
+	else
+		host->dev_index = 2; /* SD card */
+#endif
 
 	/* Get the bus width from the device node (Default is 4bit buswidth) */
 	host->buswidth = fdtdec_get_int(blob, node, "samsung,bus-width", 4);
-- 
2.39.2

