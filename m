Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A3AC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14AE81B4B;
	Wed, 12 Mar 2025 19:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S9pQ6Vlk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3870980756; Wed, 12 Mar 2025 19:08:19 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6E781D25
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso87596a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802896; x=1742407696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMHfeD/TssdMz79yuyWsbyBP7r1AXdqXCW/hlEZG2Cw=;
 b=S9pQ6Vlk3H7bRX9/uGX76REgVX676UgbIb8BPDpkwP/KAXB/NpIWnFfLR8bu0Ve5Aa
 c/5Wspgj3RK7VIE4Tg8F7pqTf00NxuO7eNMURtAU0CSOxlOxbEJV7xMhiVKRlt3mVCCX
 BNKZqB7LIkMCrcMaVUkcJ/x2jEX0VCmqfvIoyxEixmLAAzvBgvjPhmO2pl/neeIGRCd4
 NT5AAqSSte8JWw/Z33Cc5jNhpJuogMQzDW4h7SxhblmseaoPbPY40CFPE3KxuO/rK2k9
 rsdBHP95Jq4mdbSQuVwTYNt2TXqjQJqrLb1j2KJhfn6UtTmU7n5dBaTmuAVwvaH67llN
 ptYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802896; x=1742407696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMHfeD/TssdMz79yuyWsbyBP7r1AXdqXCW/hlEZG2Cw=;
 b=ZuNKY8eaQl6at0XX875wxi7txahpmrtu3pAaRcpCBkZDgVXRAZo7Nb04XFBXzeZNct
 49TuhUVvFkc0x2EwFGjDS1Lk2/4XCCLuHcou2pKM+t7N9HYe03Tljbyd2fzWzJBAYpf2
 KlQyxz9ndIKM0FtsNCiTv3Arqxunm891cEczsa8o1ka3ZYJ6KEtOZcq/+2kYpRR8AEcx
 yDUJVqBoDR55+BL1mhsu2dr0p1QJOesEczkcdg+Rbxa4EWpWGZsBLHM/6sOSuLohe1oM
 1oCND5l72GCRpsPZK0PWNGvMxXu0Sq7C+gu7zM3TEz2ueJaGpy9WoZMUxJlh8Vw5L6Ak
 gXjA==
X-Gm-Message-State: AOJu0YzCEPzBgpVd0ve4oYeV/xWseCp1fUtk2aAWOBlcpKmDQqONkULE
 r5pbTnDf/lPxPGQOHCxizWT8IRZvR8slfw5CNuCp05iWzg7dMZGxs47+PA==
X-Gm-Gg: ASbGnctIHPVbGplSaRS+OojsL7WCuz3x0EA52FGAd0wenTptfDJ6o0L9HW5CmyQhkcp
 62zUsSp5/Z+it5oND18wzznTe3jZz7ENuwo/wd2/pdogS/wAT82lGAxK5Q0K2uGwuOQ7g/Lo59n
 tjNTLVIrbK6fKKNxx2Z7SSk5TFaP/rdlTaR80ObBOIL/22ddsNPCCZHGMjdsJgBqmDpmYZk2eTD
 3WYuWpF7KUR+gFC7h0ujdcqOcTZaEiEbHGiX2eV5zUdUTqaZ+4ryWq5So2UtfBzrcVGEoohK7Le
 fjvvK4wkpebRfGXRYvc6rMPKUJG5qJ2Ut1d3
X-Google-Smtp-Source: AGHT+IHKs2zulL/sW5/MC/EDYUweXiUJnff4iLs5sb4+KbAIiRdM82X8A1rVZScDaUcZOTYux4f6fg==
X-Received: by 2002:a05:6402:518a:b0:5e5:ca1b:c425 with SMTP id
 4fb4d7f45d1cf-5e5e24153e1mr32486489a12.17.1741802895649; 
 Wed, 12 Mar 2025 11:08:15 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:15 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 09/13] video: bridge: ssd2825: add HS delays configuration
Date: Wed, 12 Mar 2025 20:07:50 +0200
Message-ID: <20250312180754.120946-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312180754.120946-1-clamor95@gmail.com>
References: <20250312180754.120946-1-clamor95@gmail.com>
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

Set HS Zero and Prepare delays from device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/ssd2825.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
index df69f993ea1..e7c9dc6b62b 100644
--- a/drivers/video/bridge/ssd2825.c
+++ b/drivers/video/bridge/ssd2825.c
@@ -120,6 +120,9 @@ struct ssd2825_bridge_priv {
 	struct clk *tx_clk;
 
 	u32 pll_freq_kbps;	/* PLL in kbps */
+
+	u32 hzd;		/* HS Zero Delay in ns */
+	u32 hpd;		/* HS Prepare Delay is ns */
 };
 
 static int ssd2825_spi_write(struct udevice *dev, int reg,
@@ -303,7 +306,9 @@ static void ssd2825_setup_pll(struct udevice *dev)
 	struct mipi_dsi_device *device = &priv->device;
 	struct display_timing *dt = &priv->timing;
 	u16 pll_config, lp_div;
+	u32 nibble_delay, nibble_freq_khz;
 	u32 pclk_mult, tx_freq_khz, pd_lines;
+	u8 hzd, hpd;
 
 	tx_freq_khz = clk_get_rate(priv->tx_clk) / 1000;
 	pd_lines = mipi_dsi_pixel_format_to_bpp(device->format);
@@ -315,12 +320,19 @@ static void ssd2825_setup_pll(struct udevice *dev)
 
 	lp_div = priv->pll_freq_kbps / (SSD2825_LP_MIN_CLK * 8);
 
+	/* nibble_delay in nanoseconds */
+	nibble_freq_khz = priv->pll_freq_kbps / 4;
+	nibble_delay = 1000 * 1000 / nibble_freq_khz;
+
+	hzd = priv->hzd / nibble_delay;
+	hpd = (priv->hpd - 4 * nibble_delay) / nibble_delay;
+
 	/* Disable PLL */
 	ssd2825_write_register(dev, SSD2825_PLL_CTRL_REG, 0x0000);
 	ssd2825_write_register(dev, SSD2825_LINE_CTRL_REG, 0x0001);
 
 	/* Set delays */
-	ssd2825_write_register(dev, SSD2825_DELAY_ADJ_REG_1, 0x2103);
+	ssd2825_write_register(dev, SSD2825_DELAY_ADJ_REG_1, (hzd << 8) | hpd);
 
 	/* Set PLL coeficients */
 	ssd2825_write_register(dev, SSD2825_PLL_CONFIGURATION_REG, pll_config);
@@ -515,6 +527,9 @@ static int ssd2825_bridge_probe(struct udevice *dev)
 		return PTR_ERR(priv->tx_clk);
 	}
 
+	priv->hzd = dev_read_u32_default(dev, "solomon,hs-zero-delay-ns", 133);
+	priv->hpd = dev_read_u32_default(dev, "solomon,hs-prep-delay-ns", 40);
+
 	return ssd2825_bridge_hw_init(dev);
 }
 
-- 
2.43.0

