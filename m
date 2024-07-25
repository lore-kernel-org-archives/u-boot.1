Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82EFC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10221887BE;
	Thu, 25 Jul 2024 22:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yTpH8G+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1CC988755; Thu, 25 Jul 2024 22:45:46 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59FC886BB
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5ce74defe41so224066eaf.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940343; x=1722545143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYl84zpmq8oB0F/2M/jvoXCLKz/Vg/dfNowtvf55vCo=;
 b=yTpH8G+Ehki1WHHN32LCvWLv9RdhhsJyZG2MeryHnLxk02CQwSYXmG3+ICEBsStFl1
 m9NPNpF2dRV+TYbeXb10ge82ZgvSxX0jEvTB05L0qwm6aXQtlMzD9nKrdLirv8ij9Hrh
 8ZfZjoBtWQBfgEsPqDOzcfoWZAIbg4weO4FwDec+oLPB3VhQylolJWhU+/Z8zE3aSy+9
 YhTc82Wzc2Yi8HbJpM/XMcOwnCiRo1ouCFTHRPwEr+ne8IfxGtr1iiV6ghslFhKPbNVl
 t0a+T+42dSVhJCNgNWKTijtJkhP7kSSc0+PZIYFs4hrbHyzK63OwqnWN5flz2nlJVJZB
 r7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940343; x=1722545143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dYl84zpmq8oB0F/2M/jvoXCLKz/Vg/dfNowtvf55vCo=;
 b=X0as0SXDS5nV4PZ8kLnpjdk2Vy823SxRtP/EvZRU6+Pw2mM0Ve6dk76ILolZHz8IGT
 hzx6hfb1Oh848tdsyOLqRbZ140F07a1xsVbd2URrYameKWoBQxkSItoVBPiEfLezVpML
 LDW9kX6Ey7piFokugY9zQ7aEdHxeTyQJN9B6g/sxA6F1KjTM9zst8ZiUGnUz0fTMkYxU
 9RuTA7DHfWjlS6sexG1eUlZScNh2CshLN3y3SMNydBIfqmX6imHU4wgqlxh8DijWyJ5G
 zcAz2f/PJA/GGoWe5T4BHuGYAZ51XyAn7t4HPww4XbE6aGH3j6vh9aLAvOSUJ7686nQe
 koJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGmk0r7hEaGf1q2qsVawM38GXoi/nzGbcZ/UZlZKl0uDrFPI2bIrZPECK5qCZrlmAtHYJBf0Xai1NrrwLWQspUzyiwrg==
X-Gm-Message-State: AOJu0YzNsHB/hK4ht+VCuQNbigNsGX+C4aX3vslSniw/nUl54z93q2Lx
 CI6lkv1qVYgEUhppGJ0ETybuOB21ngFGCb6zqe74EfJtfpRxUTjmfSkeLftAqE8=
X-Google-Smtp-Source: AGHT+IHMAkGCwFA7QH8Goed4ALm59AQDOynr9E3pf0YpZ6Ak/pGyRtJhqOa6XTd97/qMLKf1195I5w==
X-Received: by 2002:a05:6820:4b83:b0:5ce:a225:cbb2 with SMTP id
 006d021491bc7-5d5b3b4943emr3901652eaf.1.1721940343498; 
 Thu, 25 Jul 2024 13:45:43 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d5b346db58sm233296eaf.4.2024.07.25.13.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:43 -0700 (PDT)
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
Subject: [PATCH v4 30/38] mmc: exynos_dw_mmc: Set requested freq in
 get_mmc_clk() callback
Date: Thu, 25 Jul 2024 15:45:12 -0500
Message-Id: <20240725204520.18134-31-semen.protsenko@linaro.org>
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
Changes in v4:
  - (none)

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

