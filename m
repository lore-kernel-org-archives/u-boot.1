Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09424C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6829E88701;
	Thu, 25 Jul 2024 22:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HEVZXp4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B65884A7; Thu, 25 Jul 2024 22:45:39 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C488859B
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7044bda722fso184479a34.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940335; x=1722545135; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZV+9/tuIYxOCUWV8xGDM20QwAQGvcpEliEOoPAYw3+k=;
 b=HEVZXp4fWtYLn1Gtv5T/SHJl8wKxrh9UkgsT8Kp+K2+cupXxV5iSezq+CmLls3n+iv
 aMnyH8RnX0EgeS8tXxCRynCGEZvcvCA73gaG6XI3Zs19GiWeM9UqLTss9XzfCO0YR5iq
 9mAGMep0lCc7934Qc2hls8Yxm462Mi1JKBEvlyC++Xy5JCOMkNbqwEXSQXP5ruptE5px
 cwz/o5AT59N3lUODuk+wnPV14HglUVd1twxujTwpPU6ESf+/uECHJvrTvCBr8BS2l2jq
 vzR4wgwqvKvUqizmsEd9eOBfpCsNY2hoABhkWehsn07L5UnXPH0pV1dfu22xoGjkuyQi
 vlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940335; x=1722545135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZV+9/tuIYxOCUWV8xGDM20QwAQGvcpEliEOoPAYw3+k=;
 b=WE6szn7ky7oHo4Mt/R4S/80SsxldHZg/kYNm1i8Wz0yXikN67tveMrjkmg95ML0YMW
 l651W0t3KaMVRdfX0T1jGfrNGYoBuhlKAM2FZCAhSZOloPGANIT0evNfkFmfhhJ8oHBm
 HXpvq2CFWJL2UsXdUAP34/XhReUDkyfDyjMDfHHlYvh7RxsiEcXmifPc/EK8YaKMSlfp
 ehrMmVglG/hU2Ytp4R/CclEXXUEVlW9e/MXQAyNbTLAT7ENsPyzpMKLEMiaOYvdDjz3g
 j5ClsF33OT81ay5R07oAgwtKHUdaQgAnGttmdBD1t3HhWZL5mfn8LAj0GSpJ+V2pH+Xq
 V+xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQPZOK2l/ua3i+qdisgDF4W8doH2vtiz+onq3KOonf9t8hjgJF5nKnq4zopOqAFqSX8GjXxF2v73yohzDM896Ao76QUw==
X-Gm-Message-State: AOJu0YwclZVeGjTzABbQoozu/Fd3l15iFlK6UyLoHuyD0ReQp7+YzOYX
 JkWlw2/ErGOQNx5IXCBAYDbaDB+jH+tqO9ZCk6bb0WUK/pKACiWpaNnptTfqXuA=
X-Google-Smtp-Source: AGHT+IHFlwrLin1ugKy9Vs4knqlc0Kiy/zz6rzqFNt8V1zgQz4FRDfSa6lHfayJXJl+QzEM1LK1Eyg==
X-Received: by 2002:a05:6830:6286:b0:704:4d36:f450 with SMTP id
 46e09a7af769-7092e6bcef8mr5031737a34.9.1721940335376; 
 Thu, 25 Jul 2024 13:45:35 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093050a657sm459573a34.13.2024.07.25.13.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:35 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 19/38] mmc: exynos_dw_mmc: Don't call pinmux functions on
 ARM64 chips
Date: Thu, 25 Jul 2024 15:45:01 -0500
Message-Id: <20240725204520.18134-20-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

