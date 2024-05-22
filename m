Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F57C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA01A885B5;
	Thu, 23 May 2024 01:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wXb3TO3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD5B88585; Thu, 23 May 2024 01:32:01 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A813688571
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6f0ef6bee72so3227476a34.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420715; x=1717025515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHRSnBy+2BQzyt9KLJ0BUCCEWS6AC45UnPZMgtTiNDs=;
 b=wXb3TO3OKNIKDT1ewbg+fLwneTzHdxsqJ3H6nQQNeON+ibVoMvAY86bwamK8bO7+hJ
 5IgFYRdwReBDC2C323qJCX2EfOwiXaSh5yCbw+1l9BlXUnKDGLrjq4XhKTyeS1/RMJJL
 iCcqacsPHnp25rKFG4c4vMCBsEIm/9Ch2z4NYryuoYI6/rOeefSy3JY7aqBGnd6iO6lV
 3dDu/2KPsjj7Dy+2kcmX5rOtLxoDF3KPu+BjhYGu4iDoZRKRxlowxAuOYIiAFWoplWT2
 lG+BqDXQ/LnjpxO5L42aSCbnHNfhR5v0AoBSFh30d6rISoEvFJkKFvw+wB6dOuu+kEh6
 3IdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420715; x=1717025515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHRSnBy+2BQzyt9KLJ0BUCCEWS6AC45UnPZMgtTiNDs=;
 b=LMpwq3SCRfW4dapzcVxnnVP/SLaIMhUWWm2blaULToHFv8yKA6utOpORV5bFOPN5Jw
 Fs1b1nfdRVBN0ZkjSv+WOzkR7w0fvhptzzLLwLzFZcQrNzMl9FciyfYHM9x4zqPGdNTe
 Zo996ht5E+p6dJdFD57RK9WCtndfayUDQEvKLQY/72vTCvXZndxc7Ug48U2qzKiu8igA
 qW8C8EG01rI5HKRCzFOAC73AS+pAPHuzZ8Q+XhpdvzMIDDxheZCOmAQhKOwjGuqU+N9Z
 TcjmeNr5+9kAVQLopKL359JMMbYKawqswIEtwcDF/BobQaFqdlaShSxbn0T+rNEUArLQ
 iWNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu5dqyDo4MjzluAQ0hylejFLokMeoqRjxGf6trKOCZc7T9DGVBY/gs66kld2RjSOYm/MyS5dOhcg9r6W//M4E8QOENAA==
X-Gm-Message-State: AOJu0YzqxQlpxYPhHkexfqyRqckIaaTXSjxC8BANiSa84tqtGDaANENS
 YqibphRDTAhNm64CPyE7XMvpxQHcD9JrJCsckS32ioq9I36C25W9FHkDdeL9efc=
X-Google-Smtp-Source: AGHT+IFAAeIjdK8sENtQHM17usHbYucTYwiGBIEQ2oe1mx5G0JJLio6jvh+dl+IPpcPiXaksMzvUsg==
X-Received: by 2002:a9d:7a43:0:b0:6f1:39a4:6131 with SMTP id
 46e09a7af769-6f665c28dbamr3156187a34.11.1716420715387; 
 Wed, 22 May 2024 16:31:55 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0f6ff5488sm4459623a34.40.2024.05.22.16.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:54 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 21/42] mmc: exynos_dw_mmc: Don't call pinmux functions on
 ARM64 chips
Date: Wed, 22 May 2024 18:31:14 -0500
Message-Id: <20240522233135.26835-22-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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
 drivers/mmc/exynos_dw_mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 8e80bd6a059f..6d0872e0df50 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -145,6 +145,7 @@ static int exynos_dwmci_core_init(struct dwmci_host *host)
 
 static int do_dwmci_init(struct dwmci_host *host)
 {
+#if CONFIG_IS_ENABLED(CPU_V7A)
 	int flag, err;
 
 	flag = host->buswidth == 8 ? PINMUX_FLAG_8BIT_MODE : PINMUX_FLAG_NONE;
@@ -153,6 +154,7 @@ static int do_dwmci_init(struct dwmci_host *host)
 		printf("DWMMC%d not configure\n", host->dev_index);
 		return err;
 	}
+#endif
 
 	return exynos_dwmci_core_init(host);
 }
@@ -164,6 +166,7 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 	int err = 0;
 	u32 timing[3];
 
+#if CONFIG_IS_ENABLED(CPU_V7A)
 	/* Extract device id for each mmc channel */
 	host->dev_id = pinmux_decode_periph_id(blob, node);
 
@@ -175,6 +178,12 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
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

