Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F11DCCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C9A83655;
	Wed, 15 Oct 2025 17:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BTxfOZIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D2C8313B; Wed, 15 Oct 2025 16:32:31 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32418835B0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so4142085e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538749; x=1761143549; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X4USdmUWRoBxa2auUBl/bOqEZus6FVT4B5gwKLaCSZQ=;
 b=BTxfOZIoMxvLjYNuib+gVkzrlu4b1xRlESq587uncs1JDWQ3mpghAQ5YIV4ue4kWCV
 qFMZKR3+LYTu1WymYaCR2lnFnNrsOw41ThrMHsy+5BsRUs95/ysrCRPo67KdHtdbsObg
 Z+ak+oFh9IoU2naEIlx1LuIFSO9aMf9a+w3zTijPisjmzClGy9YnSRdxDDAKDNV36MiQ
 hymBr87P2kUFJLNJlR1NwHErlB2xu6vu5qvGTu4uuJ7Dml4K9pS6o3qpc3X+6jDez3LZ
 H/Uf/WThsWWU38g9hQ9f7nDbIC/VCVxozBAXTUpGF1LdZ2EcUhJQlg4FJMExXAu5QuEB
 DdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538749; x=1761143549;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4USdmUWRoBxa2auUBl/bOqEZus6FVT4B5gwKLaCSZQ=;
 b=iKB7F0A9dFqO1srt8qYJmNbhTpmoGxfmq7StbXKhbSKYzh4qbrakK1keTnqvR7gWus
 0gA7tuD2R1mK7auLHaAA0ThyqJP6Soue+C9Io3ZHsHsH4OzMoVrrc2zl90kh8vZ7iLpk
 drBQm0nBQQm8peMArxFIjR2QpoQ7qCyb5yEgPm3ZCfRg5Am5Iv5Gq80+MHXzni2FAr5B
 hK0rHJJXs6Y09OZQuWOJ4mc0YehS8uYh+mRNHiRN8Tw8AP419F/YPtmmOcBagtTgpVTj
 pXsm1mm4CLPylJEKOnb3wCQRN5+WdtR4ZeEwfRx4f+MSGGy/82UDZtGCFZ3/a9P4TebC
 LaUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyyWa6yyJ0mwnMWZS5VgLdQsd9bOEHs+1EWEAkGtQvvBGxCGfEnkChI2OPgj8qs7FXmst+7tA=@lists.denx.de
X-Gm-Message-State: AOJu0YwH0E6GPABUVssmq/+54A1wS4nnv0CCDeL/OmYvXSPF/azgXyM8
 Kvl/mXghVRA5f3iEJO+KPTc0racOpfhUu2UxogSdj8PkW2dY76KO6wAfc1K2d66m0Bo=
X-Gm-Gg: ASbGncvpeHG75W0ejqSq0b/OGMx0qyw0U5nED7nznk/bbHiZhj2l4LCCTmDBc+dIoNW
 BDyQhafyjQ4pEqG7y/vJjeVQM8ZLPi0+c2QCDTejd+hoYj7ppj5kkoMuAku0NTQTMYJhuXiX5u2
 SqTeM3wGhZqUs6IZMjPSgTC8VtQLGwyfNARUQwa26IYPuP1j+3LiRCw2SS+3MFQCwpvx7QsSyyR
 prPhxf+aWKhWpPj972lN4eVn50B8bsZ88AqLm+1IwZ+gF0N/se9i2hKmMnEUvaY8Me5gia7CxYS
 HfMuIs5w/HB+hH4yTlP5XVgSoXUyGOU4OjMp6WrnXonFoYpKZcxmJyQJHfv6kBFJjrhe/uhGOqu
 JyqILtZ0oc7wpt5beXu8izLcmRJ6MvXHODeVQCJE1v2XLGn5pIXM3KQtgsOY5KMNewBkVDxXtCh
 tMCMY78mDZ
X-Google-Smtp-Source: AGHT+IGukt19G/PYZOSW4vD1zMsgMCtooeLi8q7LKqiyW8/UWAJG648gEKOHzHmpGSlcRpHmeIFn2w==
X-Received: by 2002:a05:600c:d2:b0:46d:83e7:45ec with SMTP id
 5b1f17b1804b1-47109b4ff60mr1887255e9.11.1760538748490; 
 Wed, 15 Oct 2025 07:32:28 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:27 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:08 +0100
Subject: [PATCH 03/24] clk: armada-37xx: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-3-5f80f827407e@linaro.org>
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
 drivers/clk/mvebu/armada-37xx-periph.c | 2 +-
 drivers/clk/mvebu/armada-37xx-tbg.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 30330393f760fe34b3c78f23b617309b18903477..938881056d373e9978ff34376edc76527ebe4c0f 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -325,7 +325,7 @@ static ulong armada_37xx_periph_clk_get_rate(struct clk *clk)
 	struct a37xx_periphclk *priv = dev_get_priv(clk->dev);
 
 	if (clk->id >= priv->count)
-		return -EINVAL;
+		return 0;
 
 	return periph_clk_get_rate(priv, clk->id);
 }
diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index c1bab84c070e35f3ce739cfce2e1468157ebe71b..d61b1d34fc64cfff473ead2bf8b0e929d4957994 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -88,7 +88,7 @@ static ulong armada_37xx_tbg_clk_get_rate(struct clk *clk)
 	struct a37xx_tbgclk *priv = dev_get_priv(clk->dev);
 
 	if (clk->id >= NUM_TBG)
-		return -ENODEV;
+		return 0;
 
 	return priv->rates[clk->id];
 }

-- 
2.47.3

