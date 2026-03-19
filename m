Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28AE1091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F98B841DD;
	Fri, 20 Mar 2026 00:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PiJSh+wP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4611083FC5; Thu, 19 Mar 2026 21:57:56 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E8A83FC0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso872469f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953874; x=1774558674; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NHMCT0l4Jf8/yJh3+wXTuLS4ZMIPSdrQseiOyewPPU0=;
 b=PiJSh+wPG5p7ZFGZqQ3bdcw9PLYr64bfIQmcIuJAxcIOXto7yuKea6Gv2Iz9XZhzBF
 MRG19CAdfhFPyAX/KVfq1f/iN496o91Pm8gJ+4v8N78+LtOhppHBuLFjuFWI708BVsho
 KdSo4qU5WqtMDAVqY6fVxlAb3XxtyTjfBFuisosA3cEnk+2cxI8JY/F+OTr7aWuNpLAJ
 aOtfiBImql0HkLgd91f1H88lL+kwjeO2Xkebhd6bfVXH/xltTdkUdN3INUC7Y3diCAgU
 T0timicV+z9ONO/kpEETYc6HCZsGPoAJS66+sr77ts/jtv0NaI+RYLIVTVpaxl98glfA
 RgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953874; x=1774558674;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NHMCT0l4Jf8/yJh3+wXTuLS4ZMIPSdrQseiOyewPPU0=;
 b=TOfoFLe0ZxKN5jLnB58bvnQOup4otL1W/qQDmAO4/qJwVR8/+1TXkk4LK6FbsdVJgU
 TKzUKkjUqXT0Y3vp6d+DS+ytu8yG+ccqLlDRjwS77tWI5rsKFNyv9RQm/o3BJZkxzuat
 vTPMLJ6ZBTfNpbk/KMLDpiFkhpCgmaSaV3ouF0siVTA9cl4HzUvtgP5YOjVBa37xQ9u+
 CPJPFHJkvX+UA5GUXKyuAT89uJIrN0w2oAuykvC0Ry3N2LeuzHpcP//OguShLHVcwjSk
 NMdwYDqBC/eCmI+TgMmsbowZnGYaZth2Vz5hXUHVG34rTnKchxdo76MKO7pDigo4JZbE
 mj0A==
X-Gm-Message-State: AOJu0Yx99v8S50O8yEL1Bs1CB3huyHMTWJmXh1jqtr4F3J76DUCjLEsW
 znsT+Ds9iYs1vm8/nm/zAbZ2WgNFoNTDQaYHefNvFfDf8MRWQ+x2Gstk2eDIteJtz4s=
X-Gm-Gg: ATEYQzwQDric1IFoIWCF2KAj9UDYCRXEWJvCMYGAW7uACWACUhPtktEGz/zPz/mRTD7
 Z4PDotfyb01pHwL7jDOltbdrKK813yUTePareXohLxizgb8Ie94+x/RXIck6xBINJpVZZi765EJ
 BShmfq2ISKk8V4oHwMlITXmGEXzwLZDCxLMevfjJLk/MSWHOfAvVt01PmpjYq0mAK5mFM2HYcfW
 CcV0ozpGEeDg92q2Oy1SdS2GFHEAKh/Nj8/7sk73NTyTdCLgu2nkFLzPMJgo/qtSGqe+YPhjhPV
 GqiDrgHgKYtKBeeXL0oWwo4YB31smGKUIOYqoqb937WRo8XNKBB+1bmVRNoc//cXNeOum2k4CrW
 AJwaUVIRzrJuwDHkgyobXKw60qWW9ABZ6m9c6W2sV0Z0xX6CxFpHnIFxC8tQ4U0IqXshWdED0yE
 bpZqa7/QZW8ZjZZ90dcLgqHanIoeCZ6U/S5YnryzWK8hhtLG4xFIN6qvfhvQ68zMmJ4UQ=
X-Received: by 2002:a5d:5d86:0:b0:43b:3e0b:721e with SMTP id
 ffacd0b85a97d-43b64281744mr1233471f8f.40.1773953873449; 
 Thu, 19 Mar 2026 13:57:53 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:52 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:37 +0100
Subject: [PATCH RFC 15/40] clk: restrict clk/imx to MACH_IMX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-15-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=740;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=P+s1PrmAiVVmjoxgBNQcFmgXXPk98ex7zsSP+SOdMU0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yfwC7y58feP78p++9rmTwo9faK85uSEk5PL+2PwjK
 3guMfi86ChlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATqRJiZFj5+lK76CX+0AWP
 ytoyPZOiVaKFik+ped09HjPPWudP9xmG/5mz8+3vH323/qWP7Ml5jDr2NYF7a+6zTn70LfSz3jy
 vnFIA
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

Only build IMX clocks when MACH_IMX is enabled, otherwise IMX clock
drivers get compiled for all platforms with CLK_CCF enabled.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f0c0d8a5c28..f96d57a3223a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -15,9 +15,9 @@ obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
 obj-y += adi/
 obj-y += airoha/
 obj-y += analogbits/
-obj-y += imx/
+obj-$(CONFIG_$(PHASE_)MACH_IMX) += imx/
 obj-$(CONFIG_CLK_JH7110) += starfive/
 obj-y += tegra/
 obj-y += ti/
 obj-$(CONFIG_CLK_THEAD) += thead/

-- 
2.51.0

