Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F819C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A77888AB;
	Thu, 23 May 2024 01:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="enFOo9bB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112D18857F; Thu, 23 May 2024 01:32:13 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A3B885C9
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6f0f5645c68so3338957a34.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420725; x=1717025525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USy/FxJoc3CcVXZRxjRE8i0H1uQ2k9nCv79T/rPzTVI=;
 b=enFOo9bB7X8N7IhAqF7lAza+XXrmpq13AkzIp0tBhUopg7ledOkYAV/a7uAzxwd5rw
 FiGTvQDrkCeQgv2Fozm3i8BkVvFRpEFPsGu3Lu1Eq4k86IpEdx/5vLtqTOjpbalx7FZ8
 an73wQWjTpwEz89hgaIqdzO9viLnDzCl4v2CDQW8smmzohS3nx+1CaT3R5FePHMdZZ9S
 VPHRfmAWclLGWGLyKr2QgR5FczOjxfj4m9IpvWqHEW/1Qq6NW4cWhFiim8dwPgIRIWnY
 21dYpXFqmHeLmd4lT9gYP3XJ4aNThdt1sj0BZp0HYIFxa5nF0UV3jbACbcIeiMP5E+6b
 b5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420725; x=1717025525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USy/FxJoc3CcVXZRxjRE8i0H1uQ2k9nCv79T/rPzTVI=;
 b=L4EenWvK/FysQXPj9BoNnNu9NGpeFRpTZj9V/6cMYbrUVdkkcOqDgLghxNC2MB35QD
 kP4KurKmStD2drl1OrnetiUi5FFlI5NIYGBUmYMvkKbOKLhQHnUIh2b1M+cOBjzRv2YE
 oyUcbiFe0HJuWeL83RvMpkNDJvWxvIDwxoePSDmjq54qtcNA9VETJB7K55v3l73KEKRq
 4IkGTI7HnGJRqAnvHh/D/nqwBqikwlvH88br47uSGYGm4dlQ8kZH7fnq34vRzY944eUn
 /iIxXIGNJYygfSeq1tr0Q3af9MvRuV/9tqGEJP6LjXkDQgICsZfDrkJgcvORiIN+CJTd
 oawA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5dV2gv8eJd/PjbDosf2wDgIt2y4vNa7h22d/ypB4yEjZyMTmlAWnmK861hb6T7vH3lrMOytAook30jUW6ZL4Kefl9QA==
X-Gm-Message-State: AOJu0YzofKt6IR7EWvdI3DDjH+esJ38Da9TSjB8Gt2TtUCo+OFxR7Trq
 egE1BHOBFMXATnH5EG5POf8q7kJG97nC3J6amQ3UbNeovfBZhtmH1eWA9zRXWQ8=
X-Google-Smtp-Source: AGHT+IG0xbnz8icTEPgoWRcSYyTlzK+KuPZbDrCZczCDkH9pb7Lys5j4wcgcYfEFpkv1bE1/70EDFg==
X-Received: by 2002:a9d:5c0b:0:b0:6f0:e6e2:83b0 with SMTP id
 46e09a7af769-6f665471c57mr3712006a34.5.1716420725762; 
 Wed, 22 May 2024 16:32:05 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0fdc57a9csm4206240a34.58.2024.05.22.16.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:05 -0700 (PDT)
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
Subject: [PATCH 35/42] mmc: exynos_dw_mmc: Use CONFIG_IS_ENABLED() to check
 config options
Date: Wed, 22 May 2024 18:31:28 -0500
Message-Id: <20240522233135.26835-36-semen.protsenko@linaro.org>
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

Use CONFIG_IS_ENABLED() macro to check config options as recommended by
checkpatch, instead of checking those with just #ifdef CONFIG_...

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index e416fbe5397a..b7c3b356f0ac 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -28,7 +28,7 @@
 /* Quirks */
 #define DWMCI_QUIRK_DISABLE_SMU		BIT(0)
 
-#ifdef CONFIG_DM_MMC
+#if CONFIG_IS_ENABLED(DM_MMC)
 #include <dm.h>
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -47,7 +47,7 @@ struct exynos_dwmmc_variant {
 
 /* Exynos implmentation specific drver private data */
 struct dwmci_exynos_priv_data {
-#ifdef CONFIG_DM_MMC
+#if CONFIG_IS_ENABLED(DM_MMC)
 	struct dwmci_host host;
 #endif
 	struct clk clk;
@@ -59,7 +59,7 @@ struct dwmci_exynos_priv_data {
 static struct dwmci_exynos_priv_data *exynos_dwmmc_get_priv(
 		struct dwmci_host *host)
 {
-#ifdef CONFIG_DM_MMC
+#if CONFIG_IS_ENABLED(DM_MMC)
 	return container_of(host, struct dwmci_exynos_priv_data, host);
 #else
 	return host->priv;
@@ -231,7 +231,7 @@ static int exynos_dwmci_core_init(struct dwmci_host *host)
 	host->clksel = exynos_dwmci_clksel;
 	host->get_mmc_clk = exynos_dwmci_get_clk;
 
-#ifndef CONFIG_DM_MMC
+#if !CONFIG_IS_ENABLED(DM_MMC)
 	/* Add the mmc channel to be registered with mmc core */
 	if (add_dwmci(host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ)) {
 		printf("DWMMC%d registration failed\n", host->dev_index);
@@ -338,7 +338,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-#ifdef CONFIG_DM_MMC
+#if CONFIG_IS_ENABLED(DM_MMC)
 static int exynos_dwmmc_probe(struct udevice *dev)
 {
 	struct exynos_mmc_plat *plat = dev_get_plat(dev);
-- 
2.39.2

