Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA93CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D85838EF;
	Wed, 15 Oct 2025 17:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jYaMHKlF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 209DD8323A; Wed, 15 Oct 2025 16:33:10 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 169868357F
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so53838055e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538786; x=1761143586; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZtjuoaIn0U4yu07uuoXlyfcO+nTQuUSRN4E068cr5Lo=;
 b=jYaMHKlFbb/QDm7BBTGaat/dZ8ATL1Fty+HrS3+tYtjv9Wlr0qXIgqb8njPcZ5YERR
 8zqKbfvK5ruoQVt874TeHhYGnvoZ0Q6c+KcoiK7d+fjPi4MtqAKwfz6wno7V7rf0XYWn
 /W8lf/UmU2cjG7CTnlXZaN3CGfHGxV/4wl71Qb/FHbVH+ZEjH+TOPZqT4eQD0mM0+wcY
 wuaqj1oUTZMJ8ClAO5doBkCtBZT705ZgOOG5gCN996kUMiz95/jaZTxmLw0MYNJWGVoi
 40NCZjrXXrV1ttM83URR/YdAiBtYMGqcKplaccz+pgvy84dh+GuvpbttTWUPmPCb758h
 iN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538786; x=1761143586;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtjuoaIn0U4yu07uuoXlyfcO+nTQuUSRN4E068cr5Lo=;
 b=u1Iti5ZPHvTXg5bGlI4Zpk/p4hsomV7AQsbfnK/mRZgE99Rq44Q7HViEzKJKCGB17/
 zTXdx2kiUfM97BUmRyRoqe05u/QslD1o5Sd73M5j5CZAUMS5Blrbw4T3o/pCuyOueLG9
 Z7r+HXme3qKOUIgickDMlfMPnrxFQb8KbCjDkcCVWXdJLgtekNJbJuyV/bK2x/KWTYIL
 ST8en20HJ0aE9CZ+402vrXfMA/vuBToLYXTI80RbiUW/KWvBC0XU8UxWJyBJZ17O017p
 F0Lm7S1BCRCQxoz3smF5ktHLUe56TLauJBboEML0VJz0npakU0xnnTy3C0mYWSkZ/SYV
 QGaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa8MRYhiNW2Pbcl080JRngVF5IrRCmYKAlFA9VJIRMZphP67rN7AUYfIvykTh3L+ducK6wpIY=@lists.denx.de
X-Gm-Message-State: AOJu0YzZJuAV/ztfELk6j0jnFjw5ieJ4WgRkeqqg+hcrIU9pj4LZNXV2
 YVxYfD8S404u6H3aSjQM+mW67sW9dqJaXqVA8t6xyv5OkvhegwpCJuoeLMmG9fAbzeI=
X-Gm-Gg: ASbGncuY3qeaYS7Sp1nWXznb3yjazash61fVGqMG9ws6tblv8DFRFg3KFhT5UbGJAW/
 RKIeKzSSAhNiTSLFxDjIj1xrVp0hunL1ogTDQ+0zRuYpikOw3G7kTcjfviqgPlyExJLNxp4rIQ1
 dkqByq3scbsgKGmZoXlJ5XCdzipn1yu7gq1lLijsifFGpGZGh7lFJyUB3tcVP/+DywoXUiCCYR6
 hBxAvakuU4j9soYlxgkcbTbIuWg3Z3jstbFFsJwG6zG2siEuvWQ75saji+pKP2zGYsrxYr9cnuq
 /ihtWgTJ7Jexq8l/cQEbrm2Zyym380HxzI6Khpy974NRUZtm+hk5/NMm4o2JDdA7SSwn6V+PUfH
 ZwZABrATfRG7HNzObBeciUBMyEwhMa5vvLFbDjM9k61rWJYIom1j1G+rTa7OC4GVPZfG/jVn26w
 ==
X-Google-Smtp-Source: AGHT+IEdszMazYCX1mfKMEp6V/yCkwDB7tZvnNIFm4qDr/MLX7UV5zEV1LJQ9klORTW5GZniNL68Yg==
X-Received: by 2002:a05:600c:c16d:b0:46e:36ba:9253 with SMTP id
 5b1f17b1804b1-46fa9aa1d5fmr225175385e9.15.1760538786474; 
 Wed, 15 Oct 2025 07:33:06 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:33:05 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:28 +0100
Subject: [PATCH 23/24] clk: stm32: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-23-5f80f827407e@linaro.org>
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
 drivers/clk/stm32/clk-stm32-core.c | 4 ++--
 drivers/clk/stm32/clk-stm32f.c     | 6 +++---
 drivers/clk/stm32/clk-stm32h7.c    | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index 858f122db1a6db02eadc110a7b3e14192654d8ff..5220d49d4206808734f9838d3e55298cf6b163ab 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -106,11 +106,11 @@ static ulong stm32_clk_get_rate(struct clk *clk)
 	struct clk *c = NULL;
 
 	if (!clk->id || clk_get_by_id(clk->id, &c))
-		return -ENOENT;
+		return 0;
 
 	ops = clk_dev_ops(c->dev);
 	if (!ops->get_rate)
-		return -ENOSYS;
+		return 0;
 
 	return ops->get_rate(c);
 }
diff --git a/drivers/clk/stm32/clk-stm32f.c b/drivers/clk/stm32/clk-stm32f.c
index fceb3c44b94e4e4f5249ff1bc99c7ae4adba4316..db64139d13d4b3fff74838d9e14ae6c5e61c7941 100644
--- a/drivers/clk/stm32/clk-stm32f.c
+++ b/drivers/clk/stm32/clk-stm32f.c
@@ -310,7 +310,7 @@ static unsigned long stm32_clk_get_pllsai_rate(struct stm32_clk *priv,
 		break;
 	default:
 		log_err("incorrect PLLSAI output %d\n", output);
-		return -EINVAL;
+		return 0;
 	}
 
 	return (stm32_clk_get_pllsai_vco_rate(priv) / pll_div_output);
@@ -414,7 +414,7 @@ static ulong stm32_clk_get_rate(struct clk *clk)
 		vco = (priv->hse_rate / pllm) * plln;
 		sysclk = vco / pllp;
 	} else {
-		return -EINVAL;
+		return 0;
 	}
 
 	switch (clk->id) {
@@ -491,7 +491,7 @@ static ulong stm32_clk_get_rate(struct clk *clk)
 
 	default:
 		dev_err(clk->dev, "clock index %ld out of range\n", clk->id);
-		return -EINVAL;
+		return 0;
 	}
 }
 
diff --git a/drivers/clk/stm32/clk-stm32h7.c b/drivers/clk/stm32/clk-stm32h7.c
index df82db69738a5d9704592d5cdbec52125c0620a1..eb8fb72976b60c8016408693631470a0e369e8cb 100644
--- a/drivers/clk/stm32/clk-stm32h7.c
+++ b/drivers/clk/stm32/clk-stm32h7.c
@@ -573,7 +573,7 @@ static u32 stm32_get_PLL1_rate(struct stm32_rcc_regs *regs,
 		break;
 	}
 
-	return -EINVAL;
+	return 0;
 }
 
 static u32 stm32_get_apb_psc(struct stm32_rcc_regs *regs, enum apb apb)
@@ -780,7 +780,7 @@ static ulong stm32_clk_get_rate(struct clk *clk)
 	default:
 		dev_err(clk->dev, "unexpected gate_offset value (0x%x)\n",
 			gate_offset);
-		return -EINVAL;
+		return 0;
 		break;
 	}
 }

-- 
2.47.3

