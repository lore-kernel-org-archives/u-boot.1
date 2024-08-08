Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460A4C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13C7788C0F;
	Thu,  8 Aug 2024 05:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FiCcR0Aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D40D588B8D; Thu,  8 Aug 2024 05:15:10 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C20E88B1E
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5b986a806so736522eaf.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086907; x=1723691707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWrhxoCkEjPUic6kyEGt3ZwqMIeuuOwcuUhFbLTHQ3Q=;
 b=FiCcR0AjyqDPumbGI9lpf/iYgZ53oSFjVDtRsiNGlzBxjkB7lnt3uc8KH8xiOPfrZ0
 SDZnlNiktyhdnBBAAPGusQwSKBH2/kSh7IKjh91LZTPO+v2bsgviCNVWET8vmON/NqhR
 bLQVxMLXLSj9tX6JE7Gne69KAg+lxj2yDOo+US81F20J5jX+u3+v6JykiZPvB82il5+e
 98mIiDnFGLGtvwsG/w6fyUi9qTjGEJK2EwB8dj9gDBDj6FrXHL8NQ13R6tI6LQPLeZAd
 lu+HSiZke11CqjkGIsqk23lxgtBuap0Ws/9JsmHkYfVZCX4UWx3vluWF+s5JLGMs+LKl
 9W4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086907; x=1723691707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWrhxoCkEjPUic6kyEGt3ZwqMIeuuOwcuUhFbLTHQ3Q=;
 b=V6IuUI4qpiAa71aD/fZPUwHUOl+vAP7NkGXDATMVgREMUU73CBHF53Yqb1iHcpPtWI
 kBlWFQ+Lk38SRsi7PLbQ51bm8d8xdQzCs85xMUnmYcXJiggYEF3mucS6iGVqKQ84oMr4
 ymt/Zjthk1sLLLxRQDPEW1LGgD5u9N5T3w6zu9MvYIw5mczuHElCGeSyfIbGanfO25rT
 uTWdGzBFkjRJ20Nrb+/fVNlbR6gty0hjknLFBghB/RXYIs92+DM4wpWk6KBzMNfGR33+
 wByLY6kzzRUd4lJB+99Wwrz0+mLId7HV87oGL04nG26obK/C+PyiEkE24jhCTaMFX1cg
 gxvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsPcfGUtCcNWMONHCoRZxh/E8TPyDtCsIMN7/psv18t04mRw2WlkKU3ancak5wpdr4Tdvr2AjJzDMDPSg86sXKgRMlDg==
X-Gm-Message-State: AOJu0YyLIHqDmvP+kd4j4qFg92yFX3jq+cMchkblEXepDtdMnCelJesO
 uiAPePEVhmWYliCWhd5iNa6ZTUe8B/GqyRSSZrX+hX+hJ3mNWEYyBiKB+ajgy5g=
X-Google-Smtp-Source: AGHT+IEYYqqh7zXMVa3eYRMnhKsXTuUUFXjQL8NpOguI3PJEqBDfxuGB1C2Xg6gLnaHSwt6jw3pjhw==
X-Received: by 2002:a05:6808:16ab:b0:3db:14d0:32c6 with SMTP id
 5614622812f47-3dc3bfb13bfmr119546b6e.24.1723086907315; 
 Wed, 07 Aug 2024 20:15:07 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db563b8815sm4621381b6e.39.2024.08.07.20.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:07 -0700 (PDT)
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
Subject: [PATCH v5 30/38] mmc: exynos_dw_mmc: Set requested freq in
 get_mmc_clk() callback
Date: Wed,  7 Aug 2024 22:14:36 -0500
Message-Id: <20240808031444.9619-31-semen.protsenko@linaro.org>
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
Changes in v5:
  - (none)

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

