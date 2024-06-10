Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD2DC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BD598855B;
	Mon, 10 Jun 2024 03:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PsnLx8db";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D2888570; Mon, 10 Jun 2024 03:12:53 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 936318852D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f9b4d69f53so318811a34.0
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981969; x=1718586769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkBYLDMNy9wxXgWOrWauPEIUoZP7Gr0vIfWYR8w1fHA=;
 b=PsnLx8db3ojueQiJSXNmZO/ECbDFmHsK/VsADZJcNakEe2xOjWq10dF/YsIHYJGNYm
 XLTPwbQV9Y/1FwFWoGXzEUZz9gN8wQ+Yc9cpH9nIl40B4HDc1a/Cw1ysR71VTIZbGaSc
 z8fUBq6dfK2Lr+awEwEaVbhXUHitiG0B1sNGB0uSYLfrePO0OXBWugFqCH3A6fyX660t
 PwD4DUH7c0PCM9EDF4j6OhTgJWsqfPlSgiebB79VrP8cLgiC+uoFBkAkla8v51bwBqLs
 Sp+lhO2wifj0H6y1tDcB4GB9nNQQWfuAYoUmrjMr1S2k4QQgLwX/SK4TP0T/WY2rF3bt
 XQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981969; x=1718586769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkBYLDMNy9wxXgWOrWauPEIUoZP7Gr0vIfWYR8w1fHA=;
 b=nFO1FWwnjeLECfzCWmwDxypcDL+vL30tGRPvLPV047mtlJDgZwhDruFWPw2oRs80Tg
 YlLIfIsDmrQPir/nTy2oN7mr4ayFjX9CgyoIuLeDAFeaJ4+6Rb8HuI5pDMQMGQf14M7A
 E2rM2W+KO94M0QbToJinZVeTzDxN4poRfjNILGT340/xa4EZf0e8RFbgwd+00/Pz2MMg
 VN7K2Wf3XGG9fLjYg/A+Nq1PMAexfLhFmLxG1dgdG1JHmIenLg1mm+HC9GV7+ztUnwRF
 Rn9cSG94q6hNgE4gilXRMG9F1aAfrSCadkH/lZ5/FZTjUdzFJkdnjdWPILjV+JFAkHyE
 X2ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7+y5a0rc2Tkasht6amGloi9DaxVzP0To8DUTU8GlncYILtKeGsLnNQjV28SS+ObG+I9k7PdsXaPoxvUBdULfig4HqQw==
X-Gm-Message-State: AOJu0YxfUGG30wD7uLVPp+UeMfhWkAOeeWoN/XE+tcF1YmQDFqp24xWs
 Pj7vmZKnKg3PIvCOmv75D027y+0PbFn/e+epCCckc7bIVllQCXxcRmi2KPuaPpg=
X-Google-Smtp-Source: AGHT+IHXLuaEQEskaDfStv8tXr4Cp+Uw+ccEoayV8BOdj74JVVC5dV6MCbtGKloo0sZCsKkfSwrJtg==
X-Received: by 2002:a9d:6b18:0:b0:6f9:c46e:af75 with SMTP id
 46e09a7af769-6f9c46eb427mr724182a34.11.1717981969284; 
 Sun, 09 Jun 2024 18:12:49 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f94dcf47e7sm1566970a34.61.2024.06.09.18.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:48 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 31/40] mmc: exynos_dw_mmc: Set requested freq in
 get_mmc_clk() callback
Date: Sun,  9 Jun 2024 20:12:17 -0500
Message-Id: <20240610011226.4050-32-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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
index ef03eac5657b..5be0cb009e4e 100644
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

