Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B13ECCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC48083621;
	Wed, 15 Oct 2025 17:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GqCpDH+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B42B9835C6; Wed, 15 Oct 2025 16:32:29 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC31834D4
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e52279279so48282785e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538747; x=1761143547; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MbJGyCPupNXvdaZuspymNgL6rmLyPY5BcTTejfTvzn4=;
 b=GqCpDH+o0Nt5KSS7JOzkc/Flt/2dPPeQF4bLv7rhgneBO1EtmEgCdqgfTOHehPwm3k
 ECQb480qBBjpMz/0KKgGi+zmqu5OaxmzdoW0zeGFrMwFwdUHflIq8mYea583cHQ9ggKB
 LaEEgLBOxjtFBJTsvybQRGoxL2UtJqohJO37p1KRJl4sHP2HUe4HWjbwmq3oecMlMwQE
 eW6hOSxbP3F6TrP13Mmx8DvdeE981NAPo0kopOwVj0uqDmPsQENkZpjU8aoDT0YjcvCj
 8YRCUBQQO0FUkO88X7ymB/svRxIdQl9Xvoo0C99gUL1wYk3GgQBFu2xhm1+U4q+VB6jm
 n2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538747; x=1761143547;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbJGyCPupNXvdaZuspymNgL6rmLyPY5BcTTejfTvzn4=;
 b=wXDEqV038fmUfMzg/k8okeoMoaWsybSI2rrOw2IRYXu8hp7uevBbIE2fqp6cR3T3GD
 /T2ofVI3QiF8E2SY8bNSvhbxLMDi8w8mQZqEgmwBQc0tHaclogE/lC7tqcd9savFn/Lz
 BdZR3JA+C97FyrswsUNrla9Sjg1gSAqH1yrFiWb+K/iFhJGD2r464GtSO4F4532tNT/0
 GjpKzOAX/GMAUOPItZG4CiuNGt6S5cnc/l9guWQzUWOq8BD3bG1aZ0YSKGLfGOKCeIeT
 uiuikp+nM2CC4XFIztXaK6pd9Oa57R9waRJEU3/2K0oHw1pQ1yBW5vn+yB9jutwTgZmP
 AUzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLqZC8iuxYyuouQSw04TlnkGeYQjse6EH8Fn/vaDPSOwFBTP0FJtmQoMjshsgOHAmh/kyY+Ro=@lists.denx.de
X-Gm-Message-State: AOJu0YxBayGPlpig/df2ASEmhTpPvGXsDe8ZmKCVop9xOrhHIowchM1e
 sdp1lbbqz1lkrNw+jNiDK7xPmNASrmWBM9243uuo5EuWcSiIGMj9ReqyQqlY1DMahto=
X-Gm-Gg: ASbGncvkDmaxj/XG264wfExnIFcMz3DV2s9exaN/tIPrpxnMzAmU7G+LGJFBEyILvMf
 oVW3SWiWlcWAyiLPFgrlXbv9OVfB+NtWo0t464kTAlHzwbII4WpQJ+e1LcQlZMnNFjJbDpI5Sbh
 2jb/YxjzQwKuBsJQ16DIqL/mYf8m0cl9aY6DbnQSPb4uW7ntAeAtFlwY2omDcOWNbr/9gH/6Zta
 QXi3Oshez6PgrqmWMD2V2JISfmXNy+tYwjdIHKcD0WFrjoEvmigozXTd3ztRwaPIsLfWgd2gZsy
 NOX3jRWIlJKzQG3475vYWRfKWDhg6/T9toJLkXgoPuLN6G04aABNuyCB6Clyjino95tK6LgYWFX
 0AyaWbyFzFwo1Jvd/92HxFTYunBO8QdLc/UngyKeCkCi5Ld+U0HzqTsQsdIWZbKkwojsdKwKdS/
 6iS8WiENbd
X-Google-Smtp-Source: AGHT+IGi5fNTGKvgaEXbnvfgUckaDznPDbpCkdyTHr9U1ivBHTEOZKwwP8TWWCIEcxcSc0ljuw95ww==
X-Received: by 2002:a05:600d:d:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-47109da53bcmr1352065e9.15.1760538745360; 
 Wed, 15 Oct 2025 07:32:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:07 +0100
Subject: [PATCH 02/24] clk: sifive: Remove negative error returns from
 clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-2-5f80f827407e@linaro.org>
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
 drivers/clk/sifive/sifive-prci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index de55504b5c90785f8d5f1f66eb914847feb4a495..01fcc85ab23ff56886638cc0581b5389012de154 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -548,11 +548,11 @@ static ulong sifive_prci_parent_rate(struct __prci_clock *pc, struct prci_clk_de
 		}
 
 		if (i >= data->num_clks)
-			return -ENXIO;
+			return 0;
 
 		p = &data->clks[i];
 		if (!p->pd || !p->ops->recalc_rate)
-			return -ENXIO;
+			return 0;
 
 		return p->ops->recalc_rate(p, sifive_prci_parent_rate(p, data));
 	}
@@ -572,11 +572,11 @@ static ulong sifive_prci_get_rate(struct clk *clk)
 		(struct prci_clk_desc *)dev_get_driver_data(clk->dev);
 
 	if (data->num_clks <= clk->id)
-		return -ENXIO;
+		return 0;
 
 	pc = &data->clks[clk->id];
 	if (!pc->pd || !pc->ops->recalc_rate)
-		return -ENXIO;
+		return 0;
 
 	return pc->ops->recalc_rate(pc, sifive_prci_parent_rate(pc, data));
 }

-- 
2.47.3

