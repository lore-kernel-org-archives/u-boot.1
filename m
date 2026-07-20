Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF78C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0316480DB2;
	Mon, 20 Jul 2026 18:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XbK4VfzRg59n; Mon, 20 Jul 2026 18:10:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 597B180D92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571016;
	bh=L62KcZJMZM5fYllfbi5oyR5Nu1iE7a44Kfhk46KYCJk=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lbax6W0a6MUh/2ZTR9S+JI4dfcYygOVk6tATv+2/esnXz7ag20zHI/rv6H0txwiWn
	 /sXvnhhuRG04L9yKYHqQYxaaJ9jO80Uw6BKA2u1zk9TBT593wJbF1At5UQGR5wOlFu
	 bPPx368QlBZcbMMU53MDUnScr8OzDaEHUKi7v3AJIZhYKfFO1J70CrMOJM6KEsWXjj
	 Eokj9AWImrU8nVH8YsD+U8uD2q49psq/y1M2gT+tjwCBHLDegmwc3pZ/4pC6yckOsq
	 LTQha14A8cEjboc0py6GMlOZIAlHdxExJJiNd8wIsXQjrjsk9XdEHZ3gedG09N0vr+
	 M12iXQCCwtUYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 597B180D92;
	Mon, 20 Jul 2026 18:10:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFDDA1A33
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C154B40136
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9wXPKT31mn9 for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6DBC340165
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DBC340165
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DBC340165
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B569E84A51; Mon, 20 Jul 2026 18:41:59 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D818493F
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:57 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49557167508so19205215e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565717; x=1785170517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L62KcZJMZM5fYllfbi5oyR5Nu1iE7a44Kfhk46KYCJk=;
 b=ealMfC/QENHMnyxgSCd17FsGNGhXuNmqco1f9rBXi7kz9ahe/w9j5EiPkid+eyqvDa
 kOEtMNEes+QfSxXIV7VrP8Onhtc2tnjXqp+8kI/+JoI9eWabOFygE95kxUigBWzBqpbG
 D7kgqFm9FD735/5F99i8lS2I26uvIirsk6qDhlDE3fajin5IkL+JQI8hYLYlPzmvlAkr
 /mTbfbYPHk1aThLal/lFJABIpt03o0E3ErdokNapScjAVtyJkXcbID2t881YN8t828Zu
 8epYTDWR1IX5U13c4uU+dQvYVDupjnyOxSPrYR6UhgSYf08H4qySeqzuYH6VZPqAuJ0v
 yXPQ==
X-Gm-Message-State: AOJu0YwwWBdWtuKfHHGBQQltEmuQQHLmO5NUKS8dWWigqPAr3HWQkO+P
 rx3VGWo7SiNhExZWc8fzUFMchV4YLNO3x++DgyNNQybak5VEoM39weyeocyPKiyXBIQ=
X-Gm-Gg: AfdE7clr4Su4xWGP+9W/c2JHWVaMboI1l3J/AmLKT+f6LsvoLbIHnoBl00BxBjl1kDi
 u6tyMBZsT/j7ys7tLg7WX4M5M1mD1U+GlL56aDyJVHhsFM/limSjf/Rb7elcWT2UqCarkxIWPbH
 oi6a/JUi1q/j4Qw7VoyodkLZ6nrikWgyoBk4DS4FJMYxcFJ80N79bDSoboICRVZDg5A+6AlwKra
 x6lB6PYAtwULp3XVViSDwBiVH7DMLfUOfb5mWsso9a5EBlUbrYxCxRHonivCy7B++H7+1a9ZLKl
 Stw1muelHSvu6g1MfDukse+zlZQNVg+A9aPT5Q+kzyJ4As2qvaMfSGZudeJ0qX5lBT9sP8nZRJP
 YL7Z0tLUc/zRECaDsM9V18TjAclC6Jfnl628vwmx9NGNQMpFEvYLbRPkp6mect1JfcoX/vElV33
 R78r1RCZzPLtUrwhZAf95MNOKdsF/4CWpX3Lk6Di2o
X-Received: by 2002:a05:600c:5850:b0:495:406f:dff6 with SMTP id
 5b1f17b1804b1-4954a4106ddmr120850085e9.33.1784565716833; 
 Mon, 20 Jul 2026 09:41:56 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:54 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:53 +0100
Subject: [PATCH 26/36] clk/qcom: move existing clock drivers to clk/qcom/basic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-26-8fece1b0333d@linaro.org>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>, 
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, 
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9567;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=z9SffBjeVfnijsq7n2pdL3PlnTUsXLMeHI6g1tsajSY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+E62zX3fy/wtRDpViwOJaIYTXJjl+dyYOeO
 PXRV68y9SqJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhAAKCRAFgzErGV9k
 tqoiD/0c7VGYU5OF8zqRSZplTUD6loVvcEa1s/kAgrz5qEDSo3d02meTr7lIbANq4jZEo5kS/iw
 pLLn9igapj9Mkk836vAacbAikNLimM8cMYHaLF6lgQo6z0XI1kxyqmIdeMTZBt08YavuWnZxcYk
 19rovOl8/nx1YsQ+cSgnE0JqukAN2M0AO06HVoIrtcgON2zXd14LXNWfX1A6bxVHxdeu7CJ/cjt
 TZZvgqVrqqLpp5TXno4vqSK/sL953i/luw/as/s/3W+Sfyyiq2L8tFJqTF9xsHfPxUo1PN0jM33
 j1t5M2NTLlyFIxR/HKpYKxeOXIbSP91XNplHrJe/QJc49r8r4FJ4YNtdf/I3/ZtEQ1eKguJSlIY
 cqT8FId0x2qAFITnNKN4KNkRCQy04zpQxc5nTBqVmx6PNgxMlwSjmIuEyCfISQV5BnNAxkVllZI
 +JsAKn7k/CeqJHmbj0fXrG3YBJUu0CWqQl1u71/Rn3tBX49IRpnrv8Dc+AvqwyArbu2dgc2DM/G
 Ux835g3arEwRxnXASwsC4etFXrSFXgT57F+YVQytMA6MHLw8lveWPCUGzYWsDUxeMmOdoGJ4f7j
 3FDqq2GCHGGY/O3QwLXIMewi+KX0idYcgplqDXJxRu+oeo5nhODro/AXi5eodIjvoKxlWErrLJQ
 jZxHxYJWB9co3yA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565717; x=1785170517; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L62KcZJMZM5fYllfbi5oyR5Nu1iE7a44Kfhk46KYCJk=;
 b=VAB3KMzBIErU1WfbzTUu/TnHvvWEz6UThwwdPGrX2wHAYMIkiW2DXPIfE4DgFiy92x
 61w9lEbcDrnVSKK+RfFXzHO79jjSA3HJeW79scIXMEGXMmueRkB9k7MHRyVWv7O3XIz5
 BvaMr0SVxwzzhC8VWlnzoDFi8jpodbHWM2TFGgmiRF6zN6YKUyR4DcjqLW8479EA1O95
 jG8PB8VvmuiRdisdaJ7PVueIewaHqteEiLX4B/BFQdRYWwHKkQp0w3UEGaTDLKETFszb
 in3ESjPeQVB4fZXVhfaoZ3CVkKR/khtibuS65pIgWl/JInNXxU7Q0oUEBSpiZJXLlsqO
 pgBA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=VAB3KMzB
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="VAB3KMzB"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Casey Connolly via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Casey Connolly <casey.connolly@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

These drivers will be deprecated and removed in favour of CCF.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/Makefile                     | 31 ++++++---------------------
 drivers/clk/qcom/basic/Makefile               | 28 ++++++++++++++++++++++++
 drivers/clk/qcom/{ => basic}/clock-apq8016.c  |  0
 drivers/clk/qcom/{ => basic}/clock-apq8096.c  |  0
 drivers/clk/qcom/{ => basic}/clock-ipq4019.c  |  0
 drivers/clk/qcom/{ => basic}/clock-ipq5424.c  |  0
 drivers/clk/qcom/{ => basic}/clock-ipq9574.c  |  0
 drivers/clk/qcom/{ => basic}/clock-milos.c    |  0
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
 drivers/clk/qcom/{ => basic}/clock-sm6125.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm6350.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm7150.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8150.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8250.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8550.c   |  0
 drivers/clk/qcom/{ => basic}/clock-sm8650.c   |  0
 drivers/clk/qcom/{ => basic}/clock-x1e80100.c |  0
 26 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1adca029b110..71b0bf7f44a7 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -1,28 +1,9 @@
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
-obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
-obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
-obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
-obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
-obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
-obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
-obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
-obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
-obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
-obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
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
index 000000000000..1adca029b110
--- /dev/null
+++ b/drivers/clk/qcom/basic/Makefile
@@ -0,0 +1,28 @@
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
+obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
+obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
+obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
+obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
+obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
+obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
+obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
+obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
+obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
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
diff --git a/drivers/clk/qcom/clock-milos.c b/drivers/clk/qcom/basic/clock-milos.c
similarity index 100%
rename from drivers/clk/qcom/clock-milos.c
rename to drivers/clk/qcom/basic/clock-milos.c
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
diff --git a/drivers/clk/qcom/clock-sm6125.c b/drivers/clk/qcom/basic/clock-sm6125.c
similarity index 100%
rename from drivers/clk/qcom/clock-sm6125.c
rename to drivers/clk/qcom/basic/clock-sm6125.c
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
2.55.0

