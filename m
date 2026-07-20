Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7CBC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCABA6073C;
	Mon, 20 Jul 2026 18:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P1yMTKFaeK-V; Mon, 20 Jul 2026 18:10:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C110B60756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571007;
	bh=6IqL86a9cg8ZLIZfPCFH9wTS2eij4868wo8to0JLqx0=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jWeaEbBrkS9ko4/5DOZ6T+rzxMPp9mfwUB/WuFVpMC2zGjPmGKzasfgvqbdUUUgen
	 6OYo1q/IvT0XbWKp4kjvLDMLI7ouJqgj3uClcdQbEwTHBgwrjrF4LBQUyPqII6nWx4
	 fFGuz9JOVNeeL45s+vEV+mT/r7C1MOeB9OMgFSS/nesvgHpqZSvXUxv3jNAYC52Fu9
	 ndQEfL+SO84PDl5i6qqa4nQSST6dCjQ9EPHW9WU7VxkYFxbcZ1p02Q74+YoC3mx71N
	 d1udA7CXLb70/PuTrifNO47jc78EbCrwFGvJy3PPeZq5JfmuqMykucXb/6VGySW7Sj
	 BduvlZaMF73ZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C110B60756;
	Mon, 20 Jul 2026 18:10:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F19D21DCD
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E372840136
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1muHMpI0MzHP for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7833640202
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7833640202
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7833640202
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6884D84A73; Mon, 20 Jul 2026 18:42:13 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99FDC84A52
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:42:08 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso10221355e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565728; x=1785170528;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6IqL86a9cg8ZLIZfPCFH9wTS2eij4868wo8to0JLqx0=;
 b=o7vs/6MxiH+x/XgRuUQ+g1mYlgKUJ907r1L7Q86oK+7ZQPAPE+nnFDk3VvwEZVk1kU
 rwD7J6+1gNC1k8qXxFFteo8ZEZYumBoohab40ACf2OORbmk+pZZ70NMYCpese4muCKfY
 f7+HJR3m5GxuusimQtE5sWXF+OeeX5LnohQitbD1HM+VaEnDgVDBs+FUlycIg70PjiEU
 ji83PHk9UyIzpJd+ySLrwGn0itpgqD05QfXA6YOdIYlE1isDHgPV9KRSB3kMATCyTj36
 MMyPLAFN7glycZpWZRn0kGjr8ZL5oDFzC2r/34qrjfwruuYS3J4ao01cLdI+3mP7IZMG
 qYHQ==
X-Gm-Message-State: AOJu0YzrN+NuSCj/NA0Nx2WVDoniGB6mhU/qWPpfye1QPtZgz/GwGKxg
 JxAi3RnmDpRF+C6fcySijo2+BvTREclH9/AbIzR8aqyfgEcXSBdu6Tl7K2JJkw58vYk=
X-Gm-Gg: AfdE7ckfHTWGy3BimSe5nA2+Romy5ARmesaJsHlHOrD8fKAq/VknyPCMudq0MTb2KXc
 4aN2Tz0/pKfKo9jBG/zSOsYt+ff6li3NJ0CNVcTOObHfeOtiGfXvp+DDHvKC/mlMdJf2N5t9r46
 UN+DUlBiz3j8h8QXQOEBtoZ9Zv8+HCPpId05Nehhz9+5oH25C63IJYQKHwxy16MfjdhvJrwI0xV
 NbhJGNMcCsYcyi1DiUIt0a4/GOpX7miSlIw84LRU+n6uJ2+T2zfRnHCyj99XtSXMDwsuE5Ax4Zt
 0lPP5zIuRZfMERvgPczsZTc7Pv50ccXRb0h7bohP/CaqDa6q3ezr69F5Zl92Wr6eibWqSMJZZBv
 ZZVmbVrbsyiszdklFP+R51iNn2V/g+XPKQFqWZBIQqjt2/dqdCsoIzp0NGN1VgLfgAG9uMeLOQe
 D3ECg2UzZuxw5A240zWMWURi3uHtt0HA==
X-Received: by 2002:a05:600c:1381:b0:493:b698:9247 with SMTP id
 5b1f17b1804b1-4954a33dd74mr169707635e9.14.1784565727989; 
 Mon, 20 Jul 2026 09:42:07 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:42:07 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:57 +0100
Subject: [PATCH 30/36] clk/qcom/ccf: add uboot common code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-30-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6750;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=OrF7ejqZl2H2tZ1aq3f/BHlviDVJmWQFQWVhglbosMY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+G3TMoniT/Iv4MP9gmcTh5drOy+EdDWPpkH
 dHfgYVCntyJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhgAKCRAFgzErGV9k
 tkZGD/9kkIp4tnzvrcOunpZSgFEr71p1+7Ap5wsws2OPfzSVV3CmdBbyhFnC9bttvxFutohPFNF
 PibG7PG7ldD5M4Eh7Q+Hd2Wx9HLV/i9omkW7afh8AEt/NYsUKmqyj4Ypsb3Gtg2LB36KzkQrdug
 s1E+476oU/Nu2yQ4BiQw0QTsJkM6hLSs5/CX3UAeNX1fmRvtHPp33nthLuOqTDt6hoXsVN4uawD
 Mwl37qZOTFbOQzmfD/ANzmgX2pAquOjRrppZ1PstMK2pWg5rAMty6XPaSiSWW9dT2tYvjXdvVzW
 9/WR0wLAA9BZ4JevVEsCUvVfjr9GF4bpE4IyNwTbcD0xL+6kmAsWDCNdLpcsI1NSZTBE4f0kJTi
 8yotMQH1p1Np1ZG/+yKUd3e8mXTg1dFuwJE/kUyLiuz0K6SkeliLz9lqHZxLWIgkuLy/kLiTgK2
 X2GhnSV0/joki6luut2fyYX1rCmAgr85v9fi0TWK45ay5EZdmsNDJx0SokeD/2jiW5T1oti12pJ
 xxLYrjZ97uAtSnis/qgi1SDtnb4kOUMoF85dDmEcbNYv3JtkLxZgTN8su+1eBSo1vXA5rLVJ/UU
 zLc5YSGgkNXFgD1A+Cb3QfyBfkDbMcVcJY7Zz1s6W9UboZ/l/aJAGR16ZlCD0uzBFT8ttbyl1tL
 PuKeOO5le/p5J7g==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565728; x=1785170528; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6IqL86a9cg8ZLIZfPCFH9wTS2eij4868wo8to0JLqx0=;
 b=n1zsEMbzmZrVcdughg8EN76Vko59W64BpFaijwo42SlBbQXE7x+9Ghchfo15XWOdgc
 gc9g4AEvUavXgZfHPKaZAObwdFJ2LWiaOdmoXSptLu0pGNfqI/8pzMyMg89FqG/Xv3Ve
 Us6XJdMpsw3Qm0qJvUZwRYn/hAu7RX8UUrJ+8rY21jKvgJtfXG/TRrmDUe+YZ308OxOF
 z4eQds4b0mHIlITAdZ9smqKoMVm8BLFAMfpRB86YEKwzFkTFJPh53hHFH9D/hsWyvP8C
 w2p5s4rYVlRq6q037TXw8NavYFgrG4eWWhCQP08xnFBIQoFUszQaK0ANJ6hTBp9jFnTn
 3l3w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=n1zsEMbz
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="n1zsEMbz"; 
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

Add a few math functions that are missing in U-Boot, as well as a helper
to bind the power domain and reset drivers. These must be adapted from
Linux since each driver is allocated its own udevice.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/ccf/common-uboot.c | 188 ++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/ccf/common-uboot.h |  34 +++++++
 2 files changed, 222 insertions(+)

diff --git a/drivers/clk/qcom/ccf/common-uboot.c b/drivers/clk/qcom/ccf/common-uboot.c
new file mode 100644
index 000000000000..c37239cacad2
--- /dev/null
+++ b/drivers/clk/qcom/ccf/common-uboot.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: BSD-3-Clause AND GPL-2.0
+/*
+ * Clock and reset drivers for Qualcomm platforms Global Clock
+ * Controller (GCC).
+ *
+ * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
+ * (C) Copyright 2020 Sartura Ltd. (reset driver)
+ *     Author: Robert Marko <robert.marko@sartura.hr>
+ * (C) Copyright 2022 Linaro Ltd. (reset driver)
+ *     Author: Sumit Garg <sumit.garg@linaro.org>
+ *
+ * Based on Little Kernel driver, simplified
+ */
+
+#include <clk-uclass.h>
+#include <linux/clk-provider.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/delay.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+#include <reset-uclass.h>
+#include <power-domain-uclass.h>
+
+#include "common-uboot.h"
+#include "common.h"
+#include "gdsc.h"
+#include "reset.h"
+
+int qcom_cc_bind_pd_reset(struct udevice *parent)
+{
+	struct qcom_cc_desc *data = (struct qcom_cc_desc *)dev_get_driver_data(parent);
+	struct regmap *regmap;
+	int ret;
+
+	regmap = qcom_cc_map(parent, data);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	if (data->resets) {
+		ret = qcom_reset_register(parent, data->resets, data->num_resets, regmap);
+		if (ret)
+			return ret;
+	}
+
+	if (data->gdscs) {
+		ret = gdsc_register(parent, data->gdscs, data->num_gdscs, regmap);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+// FIXME: import gcd.c from Linux?
+/**
+ * gcd - calculate and return the greatest common divisor of 2 unsigned longs
+ * @a: first value
+ * @b: second value
+ */
+unsigned long gcd(unsigned long a, unsigned long b)
+{
+	unsigned long r = a | b;
+
+	if (!a || !b)
+		return r;
+
+	/* Isolate lsbit of r */
+	r &= -r;
+
+	while (!(b & r))
+		b >>= 1;
+	if (b == r)
+		return r;
+
+	for (;;) {
+		while (!(a & r))
+			a >>= 1;
+		if (a == r)
+			return r;
+		if (a == b)
+			return a;
+
+		if (a < b)
+			swap(a, b);
+		a -= b;
+		a >>= 1;
+		if (a & r)
+			a += b;
+		a >>= 1;
+	}
+}
+
+/*
+ * calculate best rational approximation for a given fraction
+ * taking into account restricted register size, e.g. to find
+ * appropriate values for a pll with 5 bit denominator and
+ * 8 bit numerator register fields, trying to set up with a
+ * frequency ratio of 3.1415, one would say:
+ *
+ * rational_best_approximation(31415, 10000,
+ *		(1 << 8) - 1, (1 << 5) - 1, &n, &d);
+ *
+ * you may look at given_numerator as a fixed point number,
+ * with the fractional part size described in given_denominator.
+ *
+ * for theoretical background, see:
+ * https://en.wikipedia.org/wiki/Continued_fraction
+ */
+
+void rational_best_approximation(
+	unsigned long given_numerator, unsigned long given_denominator,
+	unsigned long max_numerator, unsigned long max_denominator,
+	unsigned long *best_numerator, unsigned long *best_denominator)
+{
+	/* n/d is the starting rational, which is continually
+	 * decreased each iteration using the Euclidean algorithm.
+	 *
+	 * dp is the value of d from the prior iteration.
+	 *
+	 * n2/d2, n1/d1, and n0/d0 are our successively more accurate
+	 * approximations of the rational.  They are, respectively,
+	 * the current, previous, and two prior iterations of it.
+	 *
+	 * a is current term of the continued fraction.
+	 */
+	unsigned long n, d, n0, d0, n1, d1, n2, d2;
+	n = given_numerator;
+	d = given_denominator;
+	n0 = d1 = 0;
+	n1 = d0 = 1;
+
+	for (;;) {
+		unsigned long dp, a;
+
+		if (d == 0)
+			break;
+		/* Find next term in continued fraction, 'a', via
+		 * Euclidean algorithm.
+		 */
+		dp = d;
+		a = n / d;
+		d = n % d;
+		n = dp;
+
+		/* Calculate the current rational approximation (aka
+		 * convergent), n2/d2, using the term just found and
+		 * the two prior approximations.
+		 */
+		n2 = n0 + a * n1;
+		d2 = d0 + a * d1;
+
+		/* If the current convergent exceeds the maxes, then
+		 * return either the previous convergent or the
+		 * largest semi-convergent, the final term of which is
+		 * found below as 't'.
+		 */
+		if ((n2 > max_numerator) || (d2 > max_denominator)) {
+			unsigned long t = ULONG_MAX;
+
+			if (d1)
+				t = (max_denominator - d0) / d1;
+			if (n1)
+				t = min(t, (max_numerator - n0) / n1);
+
+			/* This tests if the semi-convergent is closer than the previous
+			 * convergent.  If d1 is zero there is no previous convergent as this
+			 * is the 1st iteration, so always choose the semi-convergent.
+			 */
+			if (!d1 || 2u * t > a || (2u * t == a && d0 * dp > d1 * d)) {
+				n1 = n0 + t * n1;
+				d1 = d0 + t * d1;
+			}
+			break;
+		}
+		n0 = n1;
+		n1 = n2;
+		d0 = d1;
+		d1 = d2;
+	}
+	*best_numerator = n1;
+	*best_denominator = d1;
+}
+
diff --git a/drivers/clk/qcom/ccf/common-uboot.h b/drivers/clk/qcom/ccf/common-uboot.h
new file mode 100644
index 000000000000..9ffb6555292c
--- /dev/null
+++ b/drivers/clk/qcom/ccf/common-uboot.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
+ */
+#ifndef _CLOCK_QCOM_H
+#define _CLOCK_QCOM_H
+
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <linux/compat.h>
+#include <linux/delay.h>
+#include <div64.h>
+#include <linux/bug.h>
+
+struct udevice;
+
+int qcom_cc_bind_pd_reset(struct udevice *parent);
+
+unsigned long gcd(unsigned long a, unsigned long b);
+
+void rational_best_approximation(
+	unsigned long given_numerator, unsigned long given_denominator,
+	unsigned long max_numerator, unsigned long max_denominator,
+	unsigned long *best_numerator, unsigned long *best_denominator);
+
+#define usleep_range(min, max) udelay(max)
+
+static inline const char *str_enable_disable(bool v)
+{
+	return v ? "enable" : "disable";
+}
+#define str_disable_enable(v)		str_enable_disable(!(v))
+
+#endif /* _CLOCK_QCOM_H */

-- 
2.55.0

