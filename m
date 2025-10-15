Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A938CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FE4838AA;
	Wed, 15 Oct 2025 17:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="keHthE4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E39A7835B0; Wed, 15 Oct 2025 16:32:57 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C91834D4
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so5664994f8f.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538775; x=1761143575; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WNRDxUD7dqMoMKbmkPhRutT8/NDVqXIfr5a7PBuyHxA=;
 b=keHthE4d9c7U8zbA/ZLCSwai6jE/BSLcnyXDEpuUbk0z3fwIf+tXIdxm8XANnYS2I7
 hO04NInh0is+5Joo1g/++zsac8xzU1vxhlfT3nZoEO0kNslr1hQMSLvm1zRu5eEpD1g4
 +E8nY7DY+RVlGOakB7US/pYDMqbmndG9IangkS0xBLhT5mtgIRBlyu6w+4kkWYlgtpjI
 //aVpp5lT/dYQfwB4l5Kaam1I83A2hqo6T+vUmihcNXXGeNC0jn3wHPQyeYNFpS3oo/z
 jwtUr0WEtkXdllnYJ4JlMRvjTye+jfi789a8ay6x2EP6lvkcqAmZKYuZBt/I+AaxWHQN
 EMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538775; x=1761143575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNRDxUD7dqMoMKbmkPhRutT8/NDVqXIfr5a7PBuyHxA=;
 b=Ogtsi52Pept01pBPQPVSL/4kz8DX27Et7NqOwPUz/5rPdaL6aqsRB1UhX4IorDUt78
 jR7SdBQTqBCWo7OAiNLG3sI8zyjDBJqRBMN2DCGfAAWB90JkJSElqSJsCFzdI2QY68xR
 DnPJuOSfK+qxZbtty0EoYlZSKjEEw2ppHoc/9IV1ZQF9upDhCMJHajPaUi+qnAZfjxwg
 iu3MJZFlSEUEFRgk74CLY7QGp/AI/wh3g7lnXBb4RAFUVw7jVo0OdyMsfyz/dzjw9P0i
 Lc8U/0E4oB3mIpv63Eyzw52bSFiZGszqqWV0JXC3eQ5rfkmoa88+4TBKmh3H9+qxO/x5
 LhaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIYTN0AV5uUnp0nhCqJ+bpBI+ros+tpgl9EGNxMjq4znMJRfejCKazhBCx9IazxNmoP8dLtFc=@lists.denx.de
X-Gm-Message-State: AOJu0YzSwqLdLzD12L/kXmkZYgsBkC6dRsXTPwYMkIqMA1OCDfZ8jNVT
 ultvBA9KZsTZAlKq6bZnoeYE4aAqLZ5qk55lng2s5Be87VDziv9tYh6rFb6PTpU9IYc=
X-Gm-Gg: ASbGnctWQHQn7RVy1RkxD7Rejbq5v5bgvxcYIlHQnssvua3YPQTHl5SFYUVoI/w99mE
 4e4nCVok0GUHNzTKmaudutvGLz57Ifie8oUuc7RFQW1AWug3hFreOEsLvG+eTki96cGxh8LpGgk
 7Kld0EYqWPOK/5aivq2+v0XWVvKmIQI0pBh5vinPCbH+JK9UU9QW67+By2W5HgpoflFxpqTKQUi
 RSugv8rNFPt9YutlZg4Q421ZrD3VQxXCQiQKyfoUz3UkxMUnE3VYEeFJTliGBtuOhP9LH5ylP9I
 A2h0bTpG9SVNSnGZd4qvBq0Auf+dHxFuzir4mb3w78IgCkuy+MRg0YRwg8cixyfdS8Y1VSZoPeL
 SmUX9wYoRXR0mcki8DACgp0OfaAGBxQtyQq2MHUiBJ+iRdDNLkVlqVx5GjxJCl6UcInwrcL6UKg
 1Fw8U2kdQF
X-Google-Smtp-Source: AGHT+IHx2AJ0imqM0pHJ6UM8S9Z+SV2DnDS3huIp3+irF8Q2x0JcKbIuWNif+U4AlFTxFFyWT7iHGg==
X-Received: by 2002:a5d:588b:0:b0:425:7f10:ada7 with SMTP id
 ffacd0b85a97d-42667458124mr20041885f8f.20.1760538775250; 
 Wed, 15 Oct 2025 07:32:55 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:54 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:22 +0100
Subject: [PATCH 17/24] clk: ti: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-17-5f80f827407e@linaro.org>
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
In-Reply-To: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Paul Barker <paul@pbarker.dev>, uboot-snps-arc@synopsys.com, 
 Dai Okamura <okamura.dai@socionext.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 adsp-linux@analog.com, uboot-stm32@st-md-mailman.stormreply.com
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <ziyao@disroot.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Michal Simek <michal.simek@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Heiko Schocher <hs@nabladev.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Sam Shih <sam.shih@mediatek.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Wed, 15 Oct 2025 17:55:48 +0200
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

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/ti/clk-am3-dpll-x2.c | 4 ++--
 drivers/clk/ti/clk-divider.c     | 4 ++--
 drivers/clk/ti/clk-mux.c         | 2 +-
 drivers/clk/ti/clk-sci.c         | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/clk-am3-dpll-x2.c b/drivers/clk/ti/clk-am3-dpll-x2.c
index 1b0b9818cdd4d410bb0abf4ad8c3c5401b875147..dacde89efc490fb76f3a66c10af3348bc238eecc 100644
--- a/drivers/clk/ti/clk-am3-dpll-x2.c
+++ b/drivers/clk/ti/clk-am3-dpll-x2.c
@@ -22,8 +22,8 @@ static ulong clk_ti_am3_dpll_x2_get_rate(struct clk *clk)
 	unsigned long rate;
 
 	rate = clk_get_rate(&priv->parent);
-	if (IS_ERR_VALUE(rate))
-		return rate;
+	if (!rate)
+		return 0;
 
 	rate *= 2;
 	dev_dbg(clk->dev, "rate=%ld\n", rate);
diff --git a/drivers/clk/ti/clk-divider.c b/drivers/clk/ti/clk-divider.c
index 40a742d7fdc48ecf1c6b51913cc83cfa3d46e950..213be7dca30d7203dd36fbb95f4a0ac6592b5565 100644
--- a/drivers/clk/ti/clk-divider.c
+++ b/drivers/clk/ti/clk-divider.c
@@ -216,8 +216,8 @@ static ulong clk_ti_divider_get_rate(struct clk *clk)
 	u32 v;
 
 	parent_rate = clk_get_rate(&priv->parent);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	v = clk_ti_readl(&priv->reg) >> priv->shift;
 	v &= priv->mask;
diff --git a/drivers/clk/ti/clk-mux.c b/drivers/clk/ti/clk-mux.c
index db5393414318f11c193a5f498c60a2415ec6fabc..ea424a197c1065d928d13de11529fd5a27865def 100644
--- a/drivers/clk/ti/clk-mux.c
+++ b/drivers/clk/ti/clk-mux.c
@@ -129,7 +129,7 @@ static ulong clk_ti_mux_get_rate(struct clk *clk)
 	index = clk_ti_mux_get_index(clk);
 	parent = clk_ti_mux_get_parent_by_index(&priv->parents, index);
 	if (IS_ERR(parent))
-		return PTR_ERR(parent);
+		return 0;
 
 	rate = clk_get_rate(parent);
 	dev_dbg(clk->dev, "rate=%ld\n", rate);
diff --git a/drivers/clk/ti/clk-sci.c b/drivers/clk/ti/clk-sci.c
index e374bd3bcc20d140ca0e25d0ec63f3faeda06901..c055f6c678a58604d581a2fde3e5d94019d5c577 100644
--- a/drivers/clk/ti/clk-sci.c
+++ b/drivers/clk/ti/clk-sci.c
@@ -76,7 +76,7 @@ static ulong ti_sci_clk_get_rate(struct clk *clk)
 	ret = cops->get_freq(sci, clk->id, clk->data, &current_freq);
 	if (ret) {
 		dev_err(clk->dev, "%s: get_freq failed (%d)\n", __func__, ret);
-		return ret;
+		return 0;
 	}
 
 	debug("%s(current_freq=%llu)\n", __func__, current_freq);

-- 
2.47.3

