Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438581091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DF28421C;
	Fri, 20 Mar 2026 00:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MoirSXu7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2C483FC0; Thu, 19 Mar 2026 21:58:16 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C825C83F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43b48ac2727so992094f8f.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953894; x=1774558694; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pMnsXnuvD55VljGKPUuKjkZRHIGIxyT6zTMvwS8mH4I=;
 b=MoirSXu7AUDfCC9aSrLvdt2lX6aJq1+ZeRqZ4pUPPEMc5efQbvLxrLr0WH7YEX2r62
 xO0y8kJ7gOayOX+CXvFWWGdTLv4hnYtQ3isggCIwcfASnuS5mBcwPk6zxlsQ8z3Ae8lZ
 B6GkfF75n95EmL4TF6OqusDOcVXIPXJw0ze/9WENr/F15TQ352yM34M2iSRpPRZBRRLD
 iR+pVi9IguA993F2E5KtNYaK4XcZ/XXUL0uiRdPmWGEoIaKt0upQBSia/K6qcdUMmay7
 MUxqiVR7dh10f4rsxnWVHgzjJdgNnLMV0h3kROcSEZJenENzoklkNDiw8wZCw2iRxTZL
 dQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953894; x=1774558694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pMnsXnuvD55VljGKPUuKjkZRHIGIxyT6zTMvwS8mH4I=;
 b=WeDnaG/JSXt+Nitz+Z01LgTvVt6zwbl/teXR1dmrLEKzBA10l4F3xSeUr+sAAxJxbE
 LC19YT5sEHqpiKHwqDhgE3VqIFNatLOnsGd3WEh3M6287vkf6AisE7EZe6pIPFx4V3KZ
 wr00UyrBBdJd2hUF2j5FoX99+dD646UeGZD52UQRNVIumvqS+ec8z9NlOQ/tkrO+gitK
 NOe83MyPL+j3SDG4Uqcg1sSxgAS72TJI4eb8uTVf0R8K+F8mT4e9II4xKf84eWCD6f7/
 z6BpvcWmHqM8POEtIf4dXJ9SWWIaxzYVZ5SoyI8p3c+U6RHnjpgZI9XaDA4zTpVjQsh2
 qHXw==
X-Gm-Message-State: AOJu0Yxl7qyptawPWAO6lglthXeWAx0F6KcUCbWECTu7b+wAxU4urld6
 OBe090OtGpQhygIlWTdO9uQJRYeKc6giJeW/4A343BJ26SpX845Fy/tlVRQq4BVPIoY=
X-Gm-Gg: ATEYQzwhPKRS3TTs4rtjaRZyKdIJhIK2XbUmPmGB7xJ5F1Q3MUF6YNA5yP613LukcZ4
 JwO7dE/WsQLUVkoyO8e8GygGejme/p3Zw3/CeUevMJlmzpdAaherj0PbUrcCWOpGZVCMTv9HjLd
 1e2HxKbyImI+kNMaWOAdbet6ejshTj9Vq2vEB3LJc4AMIuzME4rWhWHp5Rh3abNhy+e9dCCKryb
 HAnnO8ASdtqnzdQ4DV1ewkzCQsRfNMi3ZImrR9gPCXqY6VPEtpQuzp4tNGexUO5Org4LLsIXKFY
 MXlzErHJfvanDm3uhti90uBJohdavJM6EsKhPXo4ktIwmxXSTLzaHJLscyHCoL61StGhgQZyBSY
 fNexHFaHMr3i9Qrp3kUJi9SZYakInZsfBR+0bFypV35vktf7eSU1F5FPI4NSe8Um20K7laM+Rcu
 1E+Ophlxmp4nPlI08NYnttTZSGXQ16Y6aib/w90MxiY+uc9PfbgN1k4LtUVbovNoCzQ64=
X-Received: by 2002:a5d:584c:0:b0:43b:498f:dcf0 with SMTP id
 ffacd0b85a97d-43b642430ddmr1291132f8f.9.1773953893945; 
 Thu, 19 Mar 2026 13:58:13 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:58:13 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:42 +0100
Subject: [PATCH RFC 20/40] clk: make clk_get_parent_rate return signed long
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-20-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, 
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Sam Day <me@samcday.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=FTNIXLG8hV/CteP0oaof3lhlj3wmvNeIdcnwzCFT8d4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yfw7mCbc33ZCx3/3ocMsxyR03Sw8WPiemt5qSp2zq
 vw546vPHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAimnMYGXYc/3noRGfbFP3l
 v1XnL+WqEd45d2/0FAa7Ncr3V3/52lDE8E+3+cgsRSbdb08K3F9kZc+QvJgiUb7YuzByqtTzk3O
 /3isGAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:01:15 +0100
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

This function can return negative values, update its prototype to
reflect this and avoid potential underflow issues with error conditions.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/clk-uclass.c | 2 +-
 include/clk.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index db4f056e4816..095329e25f15 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -514,9 +514,9 @@ struct clk *clk_get_parent(struct clk *clk)
 
 	return pclk;
 }
 
-ulong clk_get_parent_rate(struct clk *clk)
+long clk_get_parent_rate(struct clk *clk)
 {
 	const struct clk_ops_uboot *ops;
 	struct clk *pclk;
 
diff --git a/include/clk.h b/include/clk.h
index 3cd080b43264..0520032f692c 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -468,9 +468,9 @@ struct clk *clk_get_parent(struct clk *clk);
  *		clk_request/get_by_*().
  *
  * Return: clock rate in Hz, or -ve error code.
  */
-ulong clk_get_parent_rate(struct clk *clk);
+long clk_get_parent_rate(struct clk *clk);
 
 /**
  * clk_round_rate() - Adjust a rate to the exact rate a clock can provide
  * @clk: A clock struct that was previously successfully requested by

-- 
2.51.0

