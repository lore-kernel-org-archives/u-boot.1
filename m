Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7C8CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C25A2838BB;
	Wed, 15 Oct 2025 17:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pq8Jr3Um";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 956BE834D4; Wed, 15 Oct 2025 16:32:59 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD94D8323A
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so40098895e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538777; x=1761143577; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yZOP747qP9TvGlWOGQzVrh1zEKGuFC/MQYjdG7AwW6c=;
 b=pq8Jr3Ummiefx7mWiwqmhQSU5iu0M7+URJJrDWhuuVs8MuPLEnhFcLXiRphe4in2nT
 zAO2OzudsFHOwRTAaANmvy2+ehJebhLXv7lZXJttCEbAUgqQ4pDB12WCJdEY+atKr1rn
 Q488TKIxk25TOT57feq25XGXmOxDBdgCHsedMmeOo38eGTLiRuKQIlBYc9wa3NmIPN0Q
 DQPTCZdELnizhbQ5RLu3HKs5KNkno7ed9RlwjT0CrFKOO72MM6g5nwVm55rTYwVhxAj8
 bfn513LcfDLqZwBTqztEgQ6AYKsz0RNU7Ii/N5C6ZhZzfSV8DE81Qkb/pTGC3nW+kZd+
 B3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538777; x=1761143577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZOP747qP9TvGlWOGQzVrh1zEKGuFC/MQYjdG7AwW6c=;
 b=U59cbsK70NcGs4LvG6O0IyvKMUJ0j61Zkon7GIZFBZwOAISiY0OxchC82iZbvQ4H9a
 jXzsFGgu2K9hxj7Q4Za0GlZGFix6Uu7HkbxP6VayAHzCcng59gcs5wfsS2uER0zxQdUK
 H8R3zMFSptQCHWzejaR9SgBz8/XhF22YHMBXG42XduK6RinzAQGqihJjaamvfBGy7Z1Q
 pE5PdbypcAKdrjOjau7Oy2EaUkdav5Y99dDrxw/77xFthkXjVIvD69meNsxlUWy30yV4
 z/HHGhnZ6bhc/nwtx6Tn/Eb7H1BAofxZaR1+/PUMucORF2dsmNNM4ZMGF3zTrL5bKXEL
 76bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3P/5OYxenE8m+AdMfv5BWdWShmoReLRQdUI0FeUp/upo+ZgA/eJFiMBHf4rfxEgJCKFDG6IQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxTv7R7LkMk4Lk1Ol6RjdjzFlfpopacPVDRri25pzzAPaGoYbFf
 v/EOUKwLNOi8cObmqG+HzbeKlwzLHlaF3WVcxtH0mhhbU+PYCKL9eE5oa6UWvhcv9F8=
X-Gm-Gg: ASbGnctCR7sI/ASL1T2NyOPDYYUgqBZ5pxDy3jrcx/Kqn/c2mKetRdy6DJlgFCQVByr
 1RytW+0sr6jBgFlFvnxCDwhNrKceN7RxHiHZZ3hImyuDwbj6Uv9LgMnBROLqWvmBcROuopRFsb8
 3LpUpi+vKlPCCPR4CHwx2axfjIL4aSU7KBXtxLPMEwwLgOODbPsYHEoiiEg/Cf9Puk2nqksoBZg
 7yd8WLrg4Zr68Eb7eSQbhTFSIJGVyo+4/tnNYUxCdsvlB3uAtA+sBLJ2bND4ZVmarJHVEkxYKo0
 UvSA/I9i96UXUzvZ3CO0DuCe9a36DWt3VkKnYc1UMRBNU/Q2UQXnGMyCfP588bp5nhPoZFZbMW/
 E8jDWLR3otKq9qr1k3ecaDPXrucd4/u/W3Ty7kXfZF6qWlcAm/Vds8U2Zntmhbt6n6uZySGlmZ6
 gwLenUIlmU
X-Google-Smtp-Source: AGHT+IEvPQEGRvjNPScz+QHjC4EXtJD+XpmF5vTYSMC30pFSyoimCJc/gOkBM6dMSxidro4+Kd9DVg==
X-Received: by 2002:a05:600c:a12:b0:471:3b6:f2d with SMTP id
 5b1f17b1804b1-47103b61adcmr12957405e9.38.1760538777100; 
 Wed, 15 Oct 2025 07:32:57 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:56 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:23 +0100
Subject: [PATCH 18/24] clk: mediatek: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-18-5f80f827407e@linaro.org>
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
 drivers/clk/mediatek/clk-mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index f91777e968a63477c4e75872af632a6b7c855c51..75ae9787d4469e6a40d1437d245d0e9d79b22bf7 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -725,7 +725,7 @@ static ulong mtk_clk_gate_get_rate(struct clk *clk)
 	const struct mtk_gate *gate;
 
 	if (id < priv->tree->gates_offs)
-		return -EINVAL;
+		return 0;
 
 	gate = &priv->gates[id - priv->tree->gates_offs];
 	/*

-- 
2.47.3

