Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70F9C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766F088714;
	Mon, 22 Jul 2024 19:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uOFBG1c7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD42588700; Mon, 22 Jul 2024 19:58:06 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC0FC884F9
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7036e383089so2219421a34.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671083; x=1722275883; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84FJEpEOxftXRM7klNVnM18RgAFuIoL7LFsM7XGUkQU=;
 b=uOFBG1c7nhnFD4cU/aj5mH0refspdL06N54pQnEqWNCeG5E1cS9SH7Ig5IL0JoT/4j
 PkO7AgAzDoJsnpRwxY1W75cn0qpzqvwQaK9W+v5EQLGlur5S8yqZY4apBVVznOpjgevp
 lOnz4zjm8U7Kl8MqPKCoURrw2nxoNX7gCSJTMYhYMCR5jUdDw9n4FBE/COh//XgHyCs6
 5H3O8PsKsvf9/mVBOOjNKl0ZG5QDpwl6twTw7vS4oG/NKVn+T4hAWEJ7q7NaRVyAiC2a
 w8ndQYUUTktz4eXfWbUcizLK3/TdRe//kXFjdSBlXghg3CFaR+ZrHRUZTd/KEhmoIEEj
 eN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671083; x=1722275883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84FJEpEOxftXRM7klNVnM18RgAFuIoL7LFsM7XGUkQU=;
 b=UrHSabaFd4uY2dX+9IDkM6wzVVDgbz7P9avgVtBhb3OgoUGxOEmEreOq1ZFo93uyIT
 ucjakuZLcDcEkO49JPensR2+883nPrCg/Vsbu6hA5mLr3OcRmzFtYCGXNHK2Rw3lPRSo
 KWKUVpOxHBlb8hdwzksbbvXvpz0m3YMA3ulWFSNLBSym+dgpfA98UIFNyWrvo3rJrBwP
 64TD1aogauumdsXzOn46JT6L7aN0JZZtDLQLcYhXbRZ49oUSLeG//RIXtcNyeSU01YZt
 X6TE+f+X3N8mKrHXIgPbxKlo1BBOmpxrjmIheZmevThCyAS3db82CSIrW3qntIj9C1+e
 jGMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3+krHASUOfAriIje+o0dzIPWxJLc00VV4IrU822bomrj1gqjXbQEvuGebJ3X3F51NBAa7x1kqkkK21H9Iap/dNOoqDA==
X-Gm-Message-State: AOJu0YyoQ49T59x8a2poO0zGFOzVhSrvxvQdQr4Pk7c2N6yGcHNT47BJ
 BtTkODnrMnDU9jcGPBQel22Sb+A3QP6LKqoxu8iMaODyB0lDrZm5d+1DqBJNBdM=
X-Google-Smtp-Source: AGHT+IE6bKqwMVQw1LJdD+HIBxMscq1n7bh66xju9qFubt2UCN6Xr+09hHK8wEzozNW3OF6s9FlMyA==
X-Received: by 2002:a05:6830:b85:b0:708:9433:3574 with SMTP id
 46e09a7af769-7091810e12amr666959a34.16.1721671083469; 
 Mon, 22 Jul 2024 10:58:03 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60a4b41sm1608414a34.8.2024.07.22.10.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:03 -0700 (PDT)
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
Subject: [PATCH v3 30/38] mmc: exynos_dw_mmc: Set requested freq in
 get_mmc_clk() callback
Date: Mon, 22 Jul 2024 12:57:32 -0500
Message-Id: <20240722175740.6985-31-semen.protsenko@linaro.org>
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

By now exynos_dw_mmc driver was relying on the correct CIU clock
frequency being set on driver init. But dw_mmc core is actually trying
to change CIU clock rate dynamically, on init and in set_ios() callback,
which it's requesting via host->get_mmc_clk() callback (the name is
misleading: although it's called "get_mmc_clk()", it can actually
request both get and set operations). Implement setting the requested
rate for CIU clock in Exynos driver to achieve the correct dw_mmc core
driver operation at all times. DDR mode requires the clock to be twice
as fast (when 8 bit bus is used), so handle this too, to make DDR
function properly.

This change makes the eMMC throughput on E850-96 board twice as fast.
That's because "clock-frequency" is set to 800 MHz in E850-96 device
tree, but for DDR52 mode it should be 416 MHz (and TRM states it should
be 400 MHz for DDR50/8bit mode). The dw_mmc core is requesting 52 MHz
bus_hz for DDR52 mode, and DDR+8bit mode means it should be x2 fast, so:

    f_ciu = 2 * ciu_div * f_bus = 2 * 4 * 52e6 = 416 MHz,

where f_ciu   - freq of clock fed to DW MMC block from CMU (SDCLKIN), Hz
      f_bus   - freq of clock fed to the card (CCLKIN), Hz
      ciu_div - value of internal divider (in DW MMC block).

Another way to work that around would be overriding the
"clock-frequency" property in corresponding dts. But setting the clock
frequency dynamically as it's done here looks much neater.

This implementation follows what's done in Linux kernel dw_mmc-exynos
driver in .set_ios() callback for MMC_TIMING_MMC_DDR52 case.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 32f3ea168b6c..ee3ae9f5e650 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -169,7 +169,17 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 	u8 clk_div;
 	int err;
 
+	/* Should be double rate for DDR mode */
+	if (host->mmc->selected_mode == MMC_DDR_52 && host->mmc->bus_width == 8)
+		freq *= 2;
+
 	clk_div = exynos_dwmmc_get_ciu_div(host);
+	err = exynos_dwmmc_set_sclk(host, freq * clk_div);
+	if (err) {
+		printf("DWMMC%d: failed to set clock rate (%d); "
+		       "continue anyway\n", host->dev_index, err);
+	}
+
 	err = exynos_dwmmc_get_sclk(host, &sclk);
 	if (err) {
 		printf("DWMMC%d: failed to get clock rate (%d)\n",
-- 
2.39.2

