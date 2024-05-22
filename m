Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF363C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D52288828;
	Thu, 23 May 2024 01:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RGnfh5vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D186884F1; Thu, 23 May 2024 01:32:11 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E61B3885A3
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5b2e93fddafso681780eaf.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420723; x=1717025523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EFUZEz59WZt7THpMWPnZBiu5col5B90eUJjjXBJTJnU=;
 b=RGnfh5vyPik1Qk0Dv2sx0zYnwlQ9lnSnG11TZHj/Wv2KHTCbtkhdi/+bg2d3VL0/61
 gLOydjZCvdtsIU4s7ZR9KAHY/5orNEyLUPxfMWRBvNhMonBtiVXNwAk23TYZSQ8ZGXH6
 E4Y3uahcCQ7i/hgSfGkcOkQWcqt9mpudRirJ+1DtsBCDDAHGEWa5C/sm1UmaBxc18YEM
 8ZQSifAOlZieOn9L+lM8gosx676XaHreACj9YdD26+eEDJCO4thioimEqpQq6VPUkF8T
 c04uuzzSyzZ9aMGIzGxl4viPp6MO5DEIafz8cUVgPfEaWe9re7B0zj1hH2EJHAqDjK7r
 YtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420723; x=1717025523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EFUZEz59WZt7THpMWPnZBiu5col5B90eUJjjXBJTJnU=;
 b=iuzCNPHsG8giMynzXKn4dlvB/RzKvVBR+w93I/+vU/7ydIiv9U1AD+S8Tns82oQw0M
 k6v6nMQcwc39R3IZX2KBRopBfUIyX2NDUVtNvsNCd/WNKLAHMDL7PfQ7nJp6EzY0d26M
 mLe7zU9MYSucJ/47nTX1hdJ+jFDlpS4NHzj9CLmyy4H1i91cp1L3Kv20AkG3zXJo5IiJ
 EMMCiodFncEbi+HOwRovNjsvksHtohFZr0XvLOrrJDQQRsIUuFtZ6GT/fnrmltWDnyha
 iVTW0AhWpIEPsduRPmcjZ89HvNPzabrZvBKMr+pcGUd7fB8PDkEnQ1sJ1CP8p/964N6I
 Dphg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURapaMoCQufDzTSKSzlcK8EgpnjUsZHT0pzTZuASYwnR9E4gNJ6IikhUd5MeR2of3E/2ib5CCFCHXz9utEwb+PREvg8g==
X-Gm-Message-State: AOJu0YzCQU0a1ynj0YOYT/zU+JulmKdQZz9v2Hjf/iwWMfWnmSTxWaTO
 qcauQKwkeNzPSm1e3jZuZOR/s6GUuq455vYs1LEzMC8Z/Afz5KTdePubLI4Gsyg=
X-Google-Smtp-Source: AGHT+IHHC5iSOTfXRiIkjFzse4S9Q0eV2t0SQ315w6fieIZuAgYq3oPLzow66dfaIaUKaSvV7WGzRg==
X-Received: by 2002:a05:6820:1507:b0:5b7:339f:ba5c with SMTP id
 006d021491bc7-5b7fc4f4935mr359340eaf.1.1716420723676; 
 Wed, 22 May 2024 16:32:03 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b291865d8asm5609942eaf.11.2024.05.22.16.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:03 -0700 (PDT)
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
Subject: [PATCH 32/42] mmc: exynos_dw_mmc: Set requested freq in get_mmc_clk()
 callback
Date: Wed, 22 May 2024 18:31:25 -0500
Message-Id: <20240522233135.26835-33-semen.protsenko@linaro.org>
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
 drivers/mmc/exynos_dw_mmc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index d3708ecb6407..938fd51a2ac6 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -170,7 +170,17 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
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

