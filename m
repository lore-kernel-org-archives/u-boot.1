Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359421091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67BD9842F4;
	Fri, 20 Mar 2026 00:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FEMsmpCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63A0B83FC5; Thu, 19 Mar 2026 21:59:05 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BE7D83F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43b45bb7548so914291f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953942; x=1774558742; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9xvrXcpZ8i0ywOmDf+Q4Z8hYkutdUIK0fivHIy7piVE=;
 b=FEMsmpCqc/zDRx0ZVrJ7R4sX0wZqRWnYTWt5JrI/P88vfL5yJ9oMc2LEUpBu6hvwya
 I1hkTag89VZ7OQv5P6dik4kThvm/pvybHipbz7jOJSJAN4/COU7M30UhwVWJmW6Alro5
 NnaohJVZreuJakNobxRALqN9YZB3vuJmjDsdZDrO4O3A9muuajz5RAliK/3ujGrkIfMT
 2u/HINXR+0JVWr9+NwfxjkPNRlV4mdiSyNtpt0IizcYA6xUmoMFgaK82z/mlhq04u7tj
 8byhvR+5WAs+zsu5DTjetvYtlE4eIaKPWx0BxY1BNNuPisPNFD5h7Ih89AqESV5uMTeJ
 99Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953942; x=1774558742;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9xvrXcpZ8i0ywOmDf+Q4Z8hYkutdUIK0fivHIy7piVE=;
 b=KDKsPIbUCal16oZL54cBbz93lrhMV8tIlUhoMynx2Q1CWSolpczAsLE++CWKEJLI82
 32M/CHCVU2dHpdVYOM1r71PQVVQ2dbSEOLSP1gNrQPgZht2AQywan0/khi4mm14BGEVh
 0KJncoVdhRobVSGmIh2hAnV7m9oYg3+iKc6jbBS8uUBebhHb+9Gq1OyEbGRnmNpJaulQ
 oLxrSnqK0yJ8o9BJuxKRM0cq3SB8mAxDisu0viAqp+L54B0YCoeEbEh8ah9LPQQ28xx3
 az6VdZcKZ51QKPOcxmLCEH+2ZJ+Wl4tdJsUtHh81HGHjsvDiR8fSYhQHO6yqszvboRJ+
 zZ7w==
X-Gm-Message-State: AOJu0YyOPscw3ndPyssF3Cdc8P+wYUNuFxIEaDsGCgd4m/gMTHSSfcYU
 /WsdgCa001oOzO1pv1q/fS3IVC9LWg1ChCcC+vA/JappHM8E31PmSvBZ3SIkP+aQHeM=
X-Gm-Gg: ATEYQzyLn8Nfx2vVTiWz0v2Q41OHwf2IbSY/zzdzjxEhBTyliZxQMTLWoNM9trrPiGz
 ZERDINWzU74aeQdhwy88FBQA5yN7QBUTflqbuU0ZB9gaH1mKn/4hG37ZQP4JeoPYhzFekzii6iL
 HTdAOp9N23uuIGyNk4m8ub1YHRpc7r5EuiP1+MbaS1qw2MojCZzz+XLIFpkYJY26CisGWN5atrO
 tid+88zHa2UnL7mQa3+maIalUXxu8Es/5dxNI6EZ3C27RmD9ijLEzimTo8RhS7FqG2LLMoZpdJp
 HiWx3qcrf/YEb9+BV9YiFax0KaRWIV41S1uefJD8smDQvfUlGyWUPOTVX1K10L6KmkqhjAqbDmr
 hH84QE4TzPVpYYniZRQHmwGXRtY0RKLw4l5bTYrOdlKe7N9kGa6rrfa5s+Fwa9LFf7qCPPNhULk
 omke2PE3G9N1gY6NsvggosNzMlXH3kULcqPt+UeUtiPLHXPJqP5mZjoLMVnpoF6fbH1Jo=
X-Received: by 2002:a05:6000:40c7:b0:435:e3bd:5838 with SMTP id
 ffacd0b85a97d-43b64277ea7mr1269355f8f.25.1773953941616; 
 Thu, 19 Mar 2026 13:59:01 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:59:00 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:54 +0100
Subject: [PATCH RFC 32/40] clk/qcom: move existing clock drivers to
 clk/qcom/basic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-32-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8763;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Qy527/8RecTsJ5eEbcqcHYJgzU6oqp8gpAtbhRyAq54=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yYIhip9/X98V8vZ6gt/M1bsMkljmKO/dFPHY9YP+s
 zLP6tU+HSUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAixx8wMuyW06wRcnqc4OMQ
 9vBu7bK6g1sYm3acWGV6lvGTze6vHu4M3/NSl8krzBOX63k8uyRW9MCUgnL3WNac6z3PzvyP/3n
 8BwA=
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

These drivers will be deprecated and removed in favour of CCF.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/Makefile                     | 28 ++++++---------------------
 drivers/clk/qcom/basic/Makefile               | 25 ++++++++++++++++++++++++
 drivers/clk/qcom/{ => basic}/clock-apq8016.c  |  0
 drivers/clk/qcom/{ => basic}/clock-apq8096.c  |  0
 drivers/clk/qcom/{ => basic}/clock-ipq4019.c  |  0
 drivers/clk/qcom/{ => basic}/clock-ipq5424.c  |  0
 drivers/clk/qcom/{ => basic}/clock-ipq9574.c  |  0
 drivers/clk/qcom/{ => basic}/clock-qcm2290.c  |  0
 drivers/clk/qcom/{ => basic}/clock-qcom.c     |  0
 drivers/clk/qcom/{ => basic}/clock-qcom.h     |  0
 drivers/clk/qcom/{ => basic}/clock-qcs404.c   |  0
 drivers/clk/qcom/{ => basic}/clock-qcs615.c   |  0
 drivers/clk/qcom/{ => basic}/clock-qcs8300.c  |  0
 drivers/clk/qcom/{ => basic}/clock-sa8775p.c  |  0
 drivers/clk/qcom/{ => basic}/clock-sc7280.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sdm845.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm6115.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm6350.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm7150.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8150.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8250.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8550.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8650.c   |  0
 drivers/clk/qcom/{ => basic}/clock-x1e80100.c |  0
 24 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 82a5b166196c..71b0bf7f44a7 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -1,25 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# (C) Copyright 2023 Linaro
+# (C) Copyright 2026 Linaro
 
-obj-y += clock-qcom.o
-obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
-obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
-obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
-obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
-obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
-obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
-obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
-obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
-obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
-obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
-obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
-obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
-obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
-obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
-obj-$(CONFIG_CLK_QCOM_SM7150) += clock-sm7150.o
-obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
-obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
-obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
-obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
-obj-$(CONFIG_CLK_QCOM_X1E80100) += clock-x1e80100.o
+ifndef CONFIG_CLK_CCF_FULL
+obj-y += basic/
+else
+obj-y += ccf/
+endif
diff --git a/drivers/clk/qcom/basic/Makefile b/drivers/clk/qcom/basic/Makefile
new file mode 100644
index 000000000000..82a5b166196c
--- /dev/null
+++ b/drivers/clk/qcom/basic/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2023 Linaro
+
+obj-y += clock-qcom.o
+obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
+obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
+obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
+obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
+obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
+obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
+obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
+obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
+obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
+obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
+obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
+obj-$(CONFIG_CLK_QCOM_SM7150) += clock-sm7150.o
+obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
+obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
+obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
+obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
+obj-$(CONFIG_CLK_QCOM_X1E80100) += clock-x1e80100.o
diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/basic/clock-apq8016.c
similarity index 100%
rename from drivers/clk/qcom/clock-apq8016.c
rename to drivers/clk/qcom/basic/clock-apq8016.c
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/basic/clock-apq8096.c
similarity index 100%
rename from drivers/clk/qcom/clock-apq8096.c
rename to drivers/clk/qcom/basic/clock-apq8096.c
diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/basic/clock-ipq4019.c
similarity index 100%
rename from drivers/clk/qcom/clock-ipq4019.c
rename to drivers/clk/qcom/basic/clock-ipq4019.c
diff --git a/drivers/clk/qcom/clock-ipq5424.c b/drivers/clk/qcom/basic/clock-ipq5424.c
similarity index 100%
rename from drivers/clk/qcom/clock-ipq5424.c
rename to drivers/clk/qcom/basic/clock-ipq5424.c
diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/basic/clock-ipq9574.c
similarity index 100%
rename from drivers/clk/qcom/clock-ipq9574.c
rename to drivers/clk/qcom/basic/clock-ipq9574.c
diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/basic/clock-qcm2290.c
similarity index 100%
rename from drivers/clk/qcom/clock-qcm2290.c
rename to drivers/clk/qcom/basic/clock-qcm2290.c
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/basic/clock-qcom.c
similarity index 100%
rename from drivers/clk/qcom/clock-qcom.c
rename to drivers/clk/qcom/basic/clock-qcom.c
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/basic/clock-qcom.h
similarity index 100%
rename from drivers/clk/qcom/clock-qcom.h
rename to drivers/clk/qcom/basic/clock-qcom.h
diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/basic/clock-qcs404.c
similarity index 100%
rename from drivers/clk/qcom/clock-qcs404.c
rename to drivers/clk/qcom/basic/clock-qcs404.c
diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/basic/clock-qcs615.c
similarity index 100%
rename from drivers/clk/qcom/clock-qcs615.c
rename to drivers/clk/qcom/basic/clock-qcs615.c
diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/basic/clock-qcs8300.c
similarity index 100%
rename from drivers/clk/qcom/clock-qcs8300.c
rename to drivers/clk/qcom/basic/clock-qcs8300.c
diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/basic/clock-sa8775p.c
similarity index 100%
rename from drivers/clk/qcom/clock-sa8775p.c
rename to drivers/clk/qcom/basic/clock-sa8775p.c
diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/basic/clock-sc7280.c
similarity index 100%
rename from drivers/clk/qcom/clock-sc7280.c
rename to drivers/clk/qcom/basic/clock-sc7280.c
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/basic/clock-sdm845.c
similarity index 100%
rename from drivers/clk/qcom/clock-sdm845.c
rename to drivers/clk/qcom/basic/clock-sdm845.c
diff --git a/drivers/clk/qcom/clock-sm6115.c b/drivers/clk/qcom/basic/clock-sm6115.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm6115.c
rename to drivers/clk/qcom/basic/clock-sm6115.c
diff --git a/drivers/clk/qcom/clock-sm6350.c b/drivers/clk/qcom/basic/clock-sm6350.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm6350.c
rename to drivers/clk/qcom/basic/clock-sm6350.c
diff --git a/drivers/clk/qcom/clock-sm7150.c b/drivers/clk/qcom/basic/clock-sm7150.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm7150.c
rename to drivers/clk/qcom/basic/clock-sm7150.c
diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/basic/clock-sm8150.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm8150.c
rename to drivers/clk/qcom/basic/clock-sm8150.c
diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/basic/clock-sm8250.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm8250.c
rename to drivers/clk/qcom/basic/clock-sm8250.c
diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/basic/clock-sm8550.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm8550.c
rename to drivers/clk/qcom/basic/clock-sm8550.c
diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/basic/clock-sm8650.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm8650.c
rename to drivers/clk/qcom/basic/clock-sm8650.c
diff --git a/drivers/clk/qcom/clock-x1e80100.c b/drivers/clk/qcom/basic/clock-x1e80100.c
similarity index 100%
rename from drivers/clk/qcom/clock-x1e80100.c
rename to drivers/clk/qcom/basic/clock-x1e80100.c

-- 
2.51.0

