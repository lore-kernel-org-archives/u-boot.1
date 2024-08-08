Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B71C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E23888B86;
	Thu,  8 Aug 2024 05:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y+gxXCXN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D027488AEA; Thu,  8 Aug 2024 05:15:05 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05DDC888BC
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-267b7ef154aso367214fac.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086899; x=1723691699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGSehZbyVmfZFJWsa6AwvbuNwM7MFiH8p2cT6TnAGUM=;
 b=y+gxXCXN9vUzbCcB4oD9gicjifJ4alU4yCYwE38NuvTLtyOnW12zTyhIrPLRKr4jRJ
 igfppADyftY8sBn/h/HXOMQDfSdhoboz2KxehZqpxJIfi2+UHfAoJ6V9j5VSFKr3iNy8
 UNnbg/uZMRpYTw7Ltk6ImZgF5Rh5OFgLioghsdIc4HVT+VSEEzfnrNs1hfP/IXCIaZ/M
 78x1S40rCFmGZDvbHPJFPQrGon7lfA1oTI4UJj/H7Yyv5H4MYojiUHbUzzfdVNRbrSMk
 4fHdIix4nV0ktEiXJzgiyWij9XJ502f+E0isvTExaC8SYLR4YRu47wGYcjDT7Q/ZRXvs
 0Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086899; x=1723691699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGSehZbyVmfZFJWsa6AwvbuNwM7MFiH8p2cT6TnAGUM=;
 b=b5mgWZty8IHMhpeyagI/yHWvksBggoDynJVy9CbeqjoyQskby3bDnI8MyFiIqOTspx
 Aqo5tS7RwPCDLFGygdlqa9MGl05WZQYXUxXrx3o5mUnITIS4hzr3gxmXYB+Qe1Q0+xYB
 QbYNvXAS3sO2kYCU3I/tG60GkT6XeSrKx1TUnuW6e/GVZk3j8gzHzx5hZ69wmRpVownn
 5FfsrZuVDqyMC/EdYpzrmtwSFjXLJMJZ3khYU73TTPUWKetwgAmDznTx0tqm53Z1M/b5
 nRNZSLL1lk7b+r2jGVBOK7VMIvJ7v3PHs9WrMw5JhVt9cYoa9GeWbdf1RS9prUMFWcCE
 VVlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUOae1pMK4vQDaNYTOAvP0aTUUd+LNh3hJj/GREPhVPLmWDBjDIo3uA/a9Vr21he4Dc23Jdp0g7D+Bk8K8i9dTmw39wQ==
X-Gm-Message-State: AOJu0YwQVKTDPzhk37DK6r/bOHBcKX6dxr1/QCsvg0j39+StaR4sglGS
 hMQ5aL354vMJgqQ4z4Z80NyG/C6h26c6bQmUyc6VvvOcWY8UispNJPcxr+cAudY=
X-Google-Smtp-Source: AGHT+IFThUceAJVP2z1c9KMM5UxEWZXb7oHd8MrgWbU+UHGp3RSncA4RWi4ceqLjlNhTnuoc8Hav6g==
X-Received: by 2002:a05:6870:8199:b0:268:952b:d2a4 with SMTP id
 586e51a60fabf-2692b7ba256mr551343fac.32.1723086898850; 
 Wed, 07 Aug 2024 20:14:58 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a3a773c4fsm5127951a34.78.2024.08.07.20.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:58 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 19/38] mmc: exynos_dw_mmc: Don't call pinmux functions on
 ARM64 chips
Date: Wed,  7 Aug 2024 22:14:25 -0500
Message-Id: <20240808031444.9619-20-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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
Changes in v5:
  - (none)

Changes in v4:
  - (none)

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

