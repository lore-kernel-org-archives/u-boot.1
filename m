Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8201091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7960F8422D;
	Fri, 20 Mar 2026 00:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HCD1XNlp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6946983FC0; Thu, 19 Mar 2026 21:58:29 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DA583FF5
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439b611274bso607524f8f.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953907; x=1774558707; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=geeTFJxfIoKH4agH5iM4UtAr30/4Md9xbBZc/3+TNDE=;
 b=HCD1XNlp1SZO+ej/1A+nzZQ6tFtHW4ydrnmsf++VCeNimPXVYaQzY4vnpyb4HzdMw9
 aYstsTOBWnsHC2iMcrDMd37H1IuC3bsVFfJ9c951oJOGqZYwp7HLGSibnDPpH774JuiO
 ueKGoV+0lReQwIKA8KfhSH+tSIUVvHv1sHEq8lQLjfXFOTgc2+rSvxnQQnkLQGA8nmxv
 /Pc6tppu3rTQG08wwAwj+wFHqGulJ+gew2094g2t0Qxe5Dy5nxL5Sb+Q+UV+IFPEhDfG
 qdzQK9RIysHasPK+7zWjZnK1FvzhBqzhibXg7ZkzN20BlxVvc1/7Lluc7eXYSN76AGMD
 bfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953907; x=1774558707;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=geeTFJxfIoKH4agH5iM4UtAr30/4Md9xbBZc/3+TNDE=;
 b=bUZWZ6EBZ47BPQ4NAGq3PNRVguJylGqvA/X8sqj2e17iTfy8Bq6pRaYVjc4S+qF0MX
 EkUvfHXTLRlQTy76w35rC2++kvckFvsjagz4bqGAmtqdQRc0QZFDOVp7ekdjLrqTEwqw
 AQtigpkh5HE2UDoaobLrsIedZ+TgA3yoIw5TKzWG7s6IF3Ju4gyvIjwv42i3rjOqFlbs
 e7vlAXtjT8R5Nx58fEBjqIVLv4wvUZe03+zFxXWqXa66SDsCy51/YwEimq+mUcxXvbqE
 GTtzZqctIRzr6mHfRtWcLeCQS+eGPj4Fb6iN1xDfdrJQCfiXzj99iF8dzi/rGkH8hmkC
 re3g==
X-Gm-Message-State: AOJu0Yw1dESUC/wCer5fJOGY6z03hgI6D8bHVdVa7DDhJJfHUvCaiD3t
 dfBSsqY+s34y68ATVtCjRzes7ZohuYRIbjA8Ico6P22v3HpUyU73bVRaZ3xuHerJPYo=
X-Gm-Gg: ATEYQzwuSH53iKfmogzenz5mBF2AaHIVqgNasrjMEpXvqz2b6SnbroCqCRaf9ZLkIxV
 Sh1afFdmV4NVeUDKvpNJ20rkR47U8FYkbyRj8mGlT7GXHsJLztRHfJZ36iWfEOJsPYpKXjWrZFl
 NO6cCHt9aWMElC4IrYTg1Wa3BFaGJciUe4uZkMyX1cKDNOw+5VYBex21m+2Hihkat+hDVvUTWsQ
 zM5GXbI/P3AXoInHjPbPGRY1ydZnn10taQu3PBaGOF1ahzw3n6YlU4qQq/Um0K/WYrj+eMnq9iJ
 8rnarIn441rmJo5r40IHdB5cwPJCo+YFP92SsiRr0vLfFI1AhrB4xrjs6/nhkHPQyeIbTaZ/O3u
 IqEdssge0GX0WAB1BWRtHtVF74EQ1MnwublROR4xjr0NAys9GKNQ9TTqlrMfguYwinprhDSHhue
 ADLMQHWGMYrBzjKvX96v8rgv/E5brWwqqjjuKetdvFTZ0iHH24E1U9EyPDYM0XsM5K2WE=
X-Received: by 2002:a05:6000:2f84:b0:43b:464a:28de with SMTP id
 ffacd0b85a97d-43b64243b0dmr1202144f8f.14.1773953906364; 
 Thu, 19 Mar 2026 13:58:26 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:58:25 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:45 +0100
Subject: [PATCH RFC 23/40] clk/ccf: adapt clk-conf for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-23-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7465;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=roeni2Z1q01ICrw8UsZIOklSexsFxp8L4nYGbj+0P6Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yQL2y51qVykGJ5bm/g4Oi571M+FvcbJunqhzq8T7q
 7u4nGU7SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwESS1Rn+cLrdDCo7P60kp/yp
 CP9lXbndodcNvK462bCuWLe3VPneJ4b/FanRnEUrFRU3t7zOVZ3OvVDU0onlrpL/R479X4If3da
 YAQA=
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

Basic changes to adapt clk-conf to build properly on U-Boot

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/ccf/clk-conf.c   | 84 ++++++++++++++++++++++++--------------------
 include/linux/clk/clk-conf.h | 12 +++----
 2 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/ccf/clk-conf.c b/drivers/clk/ccf/clk-conf.c
index 303a0bb26e54..7b29562e297c 100644
--- a/drivers/clk/ccf/clk-conf.c
+++ b/drivers/clk/ccf/clk-conf.c
@@ -3,66 +3,65 @@
  * Copyright (C) 2014 Samsung Electronics Co., Ltd.
  * Sylwester Nawrocki <s.nawrocki@samsung.com>
  */
 
-#include <linux/clk.h>
+#include <dm/ofnode.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/clk-conf.h>
+#include <linux/compat.h>
 #include <linux/device.h>
-#include <linux/of.h>
 #include <linux/printk.h>
-#include <linux/slab.h>
 
-static int __set_clk_parents(struct device_node *node, bool clk_supplier)
+static int __set_clk_parents(ofnode node, bool clk_supplier)
 {
-	struct of_phandle_args clkspec;
+	struct ofnode_phandle_args clkspec;
 	int index, rc, num_parents;
 	struct clk *clk, *pclk;
 
-	num_parents = of_count_phandle_with_args(node, "assigned-clock-parents",
-						 "#clock-cells");
+	num_parents = ofnode_count_phandle_with_args(node, "assigned-clock-parents",
+						 "#clock-cells", 0);
 	if (num_parents == -EINVAL)
 		pr_err("clk: invalid value of clock-parents property at %pOF\n",
-		       node);
+		       &node);
 
 	for (index = 0; index < num_parents; index++) {
-		rc = of_parse_phandle_with_args(node, "assigned-clock-parents",
-					"#clock-cells",	index, &clkspec);
+		rc = ofnode_parse_phandle_with_args(node, "assigned-clock-parents",
+					"#clock-cells", 0, index, &clkspec);
 		if (rc < 0) {
 			/* skip empty (null) phandles */
 			if (rc == -ENOENT)
 				continue;
 			else
 				return rc;
 		}
-		if (clkspec.np == node && !clk_supplier) {
-			of_node_put(clkspec.np);
+		if (ofnode_equal(clkspec.node, node) && !clk_supplier) {
+			ofnode_put(clkspec.node);
 			return 0;
 		}
 		pclk = of_clk_get_from_provider(&clkspec);
-		of_node_put(clkspec.np);
+		ofnode_put(clkspec.node);
 		if (IS_ERR(pclk)) {
 			if (PTR_ERR(pclk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get parent clock %d for %pOF\n",
-					index, node);
+					index, &node);
 			return PTR_ERR(pclk);
 		}
 
-		rc = of_parse_phandle_with_args(node, "assigned-clocks",
-					"#clock-cells", index, &clkspec);
+		rc = ofnode_parse_phandle_with_args(node, "assigned-clocks",
+					"#clock-cells", 0, index, &clkspec);
 		if (rc < 0)
 			goto err;
-		if (clkspec.np == node && !clk_supplier) {
-			of_node_put(clkspec.np);
+		if (ofnode_equal(clkspec.node, node) && !clk_supplier) {
+			ofnode_put(clkspec.node);
 			rc = 0;
 			goto err;
 		}
 		clk = of_clk_get_from_provider(&clkspec);
-		of_node_put(clkspec.np);
+		ofnode_put(clkspec.node);
 		if (IS_ERR(clk)) {
 			if (PTR_ERR(clk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get assigned clock %d for %pOF\n",
-					index, node);
+					index, &node);
 			rc = PTR_ERR(clk);
 			goto err;
 		}
 
@@ -78,40 +77,40 @@ err:
 	clk_put(pclk);
 	return rc;
 }
 
-static int __set_clk_rates(struct device_node *node, bool clk_supplier)
+static int __set_clk_rates(ofnode node, bool clk_supplier)
 {
-	struct of_phandle_args clkspec;
+	struct ofnode_phandle_args clkspec;
 	int rc, count, count_64, index;
 	struct clk *clk;
-	u64 *rates_64 __free(kfree) = NULL;
-	u32 *rates __free(kfree) = NULL;
+	u64 *rates_64 = NULL;
+	u32 *rates = NULL;
 
-	count = of_property_count_u32_elems(node, "assigned-clock-rates");
-	count_64 = of_property_count_u64_elems(node, "assigned-clock-rates-u64");
+	count = ofnode_count_u32_elems(node, "assigned-clock-rates");
+	count_64 = ofnode_count_u64_elems(node, "assigned-clock-rates-u64");
 	if (count_64 > 0) {
 		count = count_64;
 		rates_64 = kcalloc(count, sizeof(*rates_64), GFP_KERNEL);
 		if (!rates_64)
 			return -ENOMEM;
 
-		rc = of_property_read_u64_array(node,
+		rc = ofnode_read_u64_array(node,
 						"assigned-clock-rates-u64",
 						rates_64, count);
 	} else if (count > 0) {
 		rates = kcalloc(count, sizeof(*rates), GFP_KERNEL);
 		if (!rates)
 			return -ENOMEM;
 
-		rc = of_property_read_u32_array(node, "assigned-clock-rates",
+		rc = ofnode_read_u32_array(node, "assigned-clock-rates",
 						rates, count);
 	} else {
 		return 0;
 	}
 
 	if (rc)
-		return rc;
+		goto out_free;
 
 	for (index = 0; index < count; index++) {
 		unsigned long rate;
 
@@ -120,29 +119,30 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 		else
 			rate = rates[index];
 
 		if (rate) {
-			rc = of_parse_phandle_with_args(node, "assigned-clocks",
-					"#clock-cells",	index, &clkspec);
+			rc = ofnode_parse_phandle_with_args(node, "assigned-clocks",
+					"#clock-cells", 0,	index, &clkspec);
 			if (rc < 0) {
 				/* skip empty (null) phandles */
 				if (rc == -ENOENT)
 					continue;
 				else
-					return rc;
+					goto out_free;
 			}
-			if (clkspec.np == node && !clk_supplier) {
-				of_node_put(clkspec.np);
+			if (ofnode_equal(clkspec.node, node) && !clk_supplier) {
+				ofnode_put(clkspec.node);
 				return 0;
 			}
 
 			clk = of_clk_get_from_provider(&clkspec);
-			of_node_put(clkspec.np);
+			ofnode_put(clkspec.node);
 			if (IS_ERR(clk)) {
 				if (PTR_ERR(clk) != -EPROBE_DEFER)
 					pr_warn("clk: couldn't get clock %d for %pOF\n",
-						index, node);
-				return PTR_ERR(clk);
+						index, &node);
+				rc = PTR_ERR(clk);
+				goto out_free;
 			}
 
 			rc = clk_set_rate(clk, rate);
 			if (rc < 0)
@@ -152,8 +152,14 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 			clk_put(clk);
 		}
 	}
 	return 0;
+
+out_free:
+	kfree(rates);
+	kfree(rates_64);
+
+	return rc;
 }
 
 /**
  * of_clk_set_defaults() - parse and set assigned clocks configuration
@@ -166,13 +172,13 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
  * listed in its 'assigned-clocks' or 'assigned-clock-parents' properties.
  * If @clk_supplier is false the function exits returning 0 as soon as it
  * determines the @node is also a supplier of any of the clocks.
  */
-int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
+int of_clk_set_defaults(ofnode node, bool clk_supplier)
 {
 	int rc;
 
-	if (!node)
+	if (!ofnode_valid(node))
 		return 0;
 
 	rc = __set_clk_parents(node, clk_supplier);
 	if (rc < 0)
diff --git a/include/linux/clk/clk-conf.h b/include/linux/clk/clk-conf.h
index eae9652c70cd..93bb6c582b4e 100644
--- a/include/linux/clk/clk-conf.h
+++ b/include/linux/clk/clk-conf.h
@@ -6,19 +6,17 @@
 
 #ifndef __CLK_CONF_H
 #define __CLK_CONF_H
 
+#include <dm/ofnode.h>
 #include <linux/types.h>
 
-struct device_node;
-
-#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-int of_clk_set_defaults(struct device_node *node, bool clk_supplier);
+#if CONFIG_IS_ENABLED(CLK_CCF_FULL)
+int of_clk_set_defaults(ofnode node, bool clk_supplier);
 #else
-static inline int of_clk_set_defaults(struct device_node *node,
-				      bool clk_supplier)
+int of_clk_set_defaults(ofnode node, bool clk_supplier)
 {
-	return 0;
+	return -ENOSYS;
 }
 #endif
 
 #endif /* __CLK_CONF_H */

-- 
2.51.0

