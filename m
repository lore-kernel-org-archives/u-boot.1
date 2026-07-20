Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D09C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9183D406DD;
	Mon, 20 Jul 2026 18:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IjQPVf_rQFw9; Mon, 20 Jul 2026 18:10:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9B59406E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571030;
	bh=hPStC4Fvk/MXlnOHUlpmAJhjhNUv7ajzK27Sli3bXaU=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qAPgEx5sei4mfcO8nG9cFOU7igEO58rIl94bh7m/+9aiXKix4oQspstJ/tmlRXfNj
	 dMsGwwo9PvADOgR9rD1ZNw5lenkCuelmXHp4CfBy7qme00lBANVaxDpaPCIMxKqi7H
	 ft0xHls0PeXXI63wwbZRUEaFHsUZVJLr50oQcyhzSkdEIyqM11xADQ/ouqvOmlrhRq
	 rti1SjreoO9SWhi1UKpkvH72VPIQJmp4iRkS62SuFsRiPW6YNSiaSWtnkXAqd37jKb
	 ad51IoVq4clZk4BQJ1C4I2Yv5i5VIVlcIfhJ6FSbTmgCatvoeaZOJvRRv/LHbfGF6r
	 Ma2kv8zLMPTeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9B59406E7;
	Mon, 20 Jul 2026 18:10:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ECE9C150D
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE93140159
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFhz9PiSK97C for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2B81E40136
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B81E40136
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B81E40136
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A9784A6B; Mon, 20 Jul 2026 18:42:17 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D460B84A4B
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:42:14 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49557167508so19209035e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565734; x=1785170534;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hPStC4Fvk/MXlnOHUlpmAJhjhNUv7ajzK27Sli3bXaU=;
 b=TUumb0L6SYwQAsRIB4ZDaqEGeDn0xmC3uOEYvNsxQClrn/+2KcjcPbYZ4IAYlE8xZ0
 9FnMbItbOi7Kh9sXePiJ4iG/z+N3UvfBV7qEyo2yUpx5oxD7OojLFzTCrVG0lpPIhQUP
 KOyxY3+YPJvE9z9sMtg6TVZCEZ7O+0LCu7jnzAFT/LRuyi8MgHDQRZAUlvVXxx9cDN70
 xgcn40hO4cKTq6x6fr834mdm/q6Msm/8a8Ksh8H4L/cAWp3sP41xpFxbFrbSjpnGS7FL
 /Q/rnbJ+30fwEDVCP3lKub/LrvTjprg/X6oOMjHtoL9gU738n2FeePVywO38fX26oRHj
 lhCQ==
X-Gm-Message-State: AOJu0Yz4kuIYQOAU8F5u+OwO2zwI6IdY1v1SQWH4KDMX8kcavmzHTdqf
 7SkRvVHt1orNmKYkV2nTQ5eK+4viJZULHPKMSb+QF/XO46BMgThyA8rMIHkH6t0tX4U=
X-Gm-Gg: AfdE7ckPWw8AXhWArqJgQ/YN9y0N06c0eplJxffKu0l/A93EiTQEJL0e3jMCYErnn7h
 FRhwZFiPW+n9+8Mqyh48Mr5rkTM3MjKtpuIDBv4xWouYQRYQR208eQtXywtv1vD4VEBhU2m8jiW
 44jfY84h6MlXqAoYXr6zw6LYAESybcJoJVf8dcNkSMMak8jm6wjdaVTcUH5TPLerZFXkbKeoHq7
 fEFf4AKuUUMOt2RqBPuwCv6l3MtZnzLfymQF4fW5IUVc6NfiXX2khdCyaTMwaYBhrFtRQPQMAA+
 drnWeqeqeJkPTnRro5GyvtOFzfaZY9X9e/M2o0tyt30VDJleOlgdJeN8T1qJnHFjl9Amu71UDF0
 imEy6JLskCTSkn6CHh4A4mxs0YpQW80K0uCefNUhZ3sWYPw5+IHekFuTWRxZbZAK0EeXZshE9Nv
 5Xp6p/6cgu6XTyErSSJyTY9bjhlXKq2A==
X-Received: by 2002:a05:600c:42c6:b0:495:4182:4456 with SMTP id
 5b1f17b1804b1-4954a4104e1mr102528005e9.29.1784565734059; 
 Mon, 20 Jul 2026 09:42:14 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:42:12 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:59 +0100
Subject: [PATCH 32/36] clk/qcom/ccf: adapt clocks for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-32-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=25499;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=VeSyjSAQY1TC/PQ6aQluvHsRGtE/xFHxYpu17Lp2kgc=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+GiQQWSlpG9h9pRY2xQ8J0taIe1daG69Tpz
 EevAMD9QNiJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhgAKCRAFgzErGV9k
 tjWzEACUqSnRrbChcOQJx1nOl5GF1JJePkIWb5PYG9oEHwD1niWi2MZcI3LCUd/NyB+IRSIXcJ1
 l7h3cBeLXXN22ZmEeXayXMAP1aC+55frAzw8JI5o2lfag2ZG1ANPXKd7WT6N5IUo588ddDluhqL
 azRk618UN5J6AASpBtkY41Uf2B0yImRU4Nm0uLYxN+WcoCnXehme8ZYG6OYOpbZi90/LDwVzEII
 WUhGIHlAgeXHh/32nO+Zfj6hUu5PoIV+Z/2YOepYmZ3WrLX6GIanIgyrDimrsmKDYIAueM7L8IQ
 Ql9L9/rNq+DYPX4tH7J+pSzx9MxjQGLk9qqjJPydE6RNrxLSU08Df1FXQAkzraJpO2ffRAyeMPi
 NR/THMAlJChYRP8XzWlxG5a3pivMKtjS76SfD9ccRUBWV0DoUs2ab7WPSXS0CWbOzmtaEqKiF6l
 1bK8sTMJ7alIyIvzJJnzPlpWJMK/+oDY49opuJv4qu/TNvHW8ZQbVP221gBjEenrV0zAhGdj8ln
 EntxsJgnUai1aqEdbO9M0lLOt+gz8dvI04TpS7PgLDs/PjcHE/8R+cTOcE1OT6MG4rZ9t7pb2hq
 hy01bkUP1zRWrXJBwGl45AyruhjIJMSZwO1VkvHA9ru2QXbdN/Cl7fY4mDLGKwhpexhEAsg3IO4
 9eBqNfTEeDOi/eQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565734; x=1785170534; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hPStC4Fvk/MXlnOHUlpmAJhjhNUv7ajzK27Sli3bXaU=;
 b=lLnf+S7Y+St01/zuQ5hLNY/4mfWKf38MSWyzzGDW+cylvnEGgqmN1wOOrg/gMH/kyJ
 v8+xMGN2d9GI6Kd/o9a5Mxp/K7ZqiTr0Ru3XGsy7Eyal9Fm23Z48Fk06XATp2pb33jnP
 9Uhv06uxUNrkVu2Cdy6OQIOSJLh1a24v96tOp78vAoLp7DSVzMW8GTgae/2aSUoosKkX
 hcZ5xzsls3WoRvc2ltojDisEwmTD59zI9EAtYpur3uyWLWC3EojfoI4HKkcvm2O7sXbl
 o1zeU4PBY9QJQ1xTBnsym6qQvYUMx8TI27k7h3njxLbFRisMtMFZW4qCmJhVmmw9X/kO
 zMtQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=lLnf+S7Y
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="lLnf+S7Y"; 
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

Adapt the various clock type helpers to work with U-Boot CCF, these
changes are quite minor, predominantly just the superficial API
differences.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/Kconfig                  |   1 +
 drivers/clk/qcom/ccf/Makefile             |  21 ++++
 drivers/clk/qcom/ccf/clk-alpha-pll.c      |   5 +-
 drivers/clk/qcom/ccf/clk-branch.c         |   7 +-
 drivers/clk/qcom/ccf/clk-branch.h         |   1 +
 drivers/clk/qcom/ccf/clk-rcg2.c           | 157 ++++++------------------------
 drivers/clk/qcom/ccf/clk-regmap-divider.c |   2 +-
 drivers/clk/qcom/ccf/clk-regmap-mux-div.c |   1 +
 drivers/clk/qcom/ccf/clk-regmap-mux.c     |   2 +-
 drivers/clk/qcom/ccf/clk-regmap-phy-mux.c |   2 +-
 drivers/clk/qcom/ccf/clk-regmap.c         |  10 +-
 drivers/clk/qcom/ccf/clk-regmap.h         |   2 +-
 drivers/clk/qcom/ccf/clk-rpmh.c           | 113 ++++++++++-----------
 13 files changed, 122 insertions(+), 202 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 95b650831a39..1c15d21c01b3 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -2,8 +2,9 @@ if ARCH_SNAPDRAGON || ARCH_IPQ40XX
 
 config CLK_QCOM
 	bool
 	depends on CLK && DM_RESET && POWER_DOMAIN
+	select REGMAP if CLK_CCF_FULL
 	def_bool n
 
 menu "Qualcomm clock drivers"
 
diff --git a/drivers/clk/qcom/ccf/Makefile b/drivers/clk/qcom/ccf/Makefile
new file mode 100644
index 000000000000..1d8fcdd3667f
--- /dev/null
+++ b/drivers/clk/qcom/ccf/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2023 Linaro
+
+obj-y += common.o common-uboot.o
+obj-y += clk-regmap.o
+obj-y += clk-alpha-pll.o
+obj-y += clk-rcg2.o
+obj-y += clk-branch.o
+obj-y += clk-regmap-divider.o
+obj-y += clk-regmap-mux.o
+obj-y += clk-regmap-mux-div.o
+obj-y += clk-regmap-phy-mux.o
+obj-y += clk-rpmh.o
+obj-y += reset.o
+obj-y += gdsc.o
+
+obj-$(CONFIG_CLK_QCOM_SM8650) += gcc-sm8650.o \
+				 dispcc-sm8550.o \
+				 tcsrcc-sm8650.o
+
diff --git a/drivers/clk/qcom/ccf/clk-alpha-pll.c b/drivers/clk/qcom/ccf/clk-alpha-pll.c
index 6aeba40358c1..58a13521abc3 100644
--- a/drivers/clk/qcom/ccf/clk-alpha-pll.c
+++ b/drivers/clk/qcom/ccf/clk-alpha-pll.c
@@ -3,16 +3,19 @@
  * Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved.
  * Copyright (c) 2021, 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <asm/io.h>
+#include <div64.h>
+#include <linux/bug.h>
 #include <linux/kernel.h>
-#include <linux/export.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
 
 #include "clk-alpha-pll.h"
 #include "common.h"
+#include "common-uboot.h"
 
 #define PLL_MODE(p)		((p)->offset + 0x0)
 # define PLL_OUTCTRL		BIT(0)
 # define PLL_BYPASSNL		BIT(1)
diff --git a/drivers/clk/qcom/ccf/clk-branch.c b/drivers/clk/qcom/ccf/clk-branch.c
index 444e7d8648d4..0b91a71289b2 100644
--- a/drivers/clk/qcom/ccf/clk-branch.c
+++ b/drivers/clk/qcom/ccf/clk-branch.c
@@ -3,13 +3,13 @@
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
  * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/export.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 
 #include "clk-branch.h"
@@ -83,10 +83,13 @@ static int clk_branch_wait(const struct clk_branch *br, bool enabling,
 			if (check_halt(br, enabling))
 				return 0;
 			udelay(1);
 		}
-		WARN(1, "%s status stuck at 'o%s'", name,
+		WARN(1, "%s status stuck at 'o%s'\n", name,
 				enabling ? "ff" : "n");
+		u32 val;
+		regmap_read(br->clkr.regmap, br->halt_reg, &val);
+		printf("%s: halt_reg %#x val %#x\n", name, br->halt_reg, val);
 		return -EBUSY;
 	}
 	return 0;
 }
diff --git a/drivers/clk/qcom/ccf/clk-branch.h b/drivers/clk/qcom/ccf/clk-branch.h
index 6bc2ba2b5350..5cc5c2e9d165 100644
--- a/drivers/clk/qcom/ccf/clk-branch.h
+++ b/drivers/clk/qcom/ccf/clk-branch.h
@@ -5,8 +5,9 @@
 #define __QCOM_CLK_BRANCH_H__
 
 #include <linux/bitfield.h>
 #include <linux/clk-provider.h>
+#include <linux/regmap.h>
 
 #include "clk-regmap.h"
 
 /**
diff --git a/drivers/clk/qcom/ccf/clk-rcg2.c b/drivers/clk/qcom/ccf/clk-rcg2.c
index e18cb8807d73..2f60830fc302 100644
--- a/drivers/clk/qcom/ccf/clk-rcg2.c
+++ b/drivers/clk/qcom/ccf/clk-rcg2.c
@@ -2,27 +2,23 @@
 /*
  * Copyright (c) 2013, 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <div64.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/bug.h>
-#include <linux/export.h>
-#include <linux/clk.h>
+#include <clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/rational.h>
 #include <linux/regmap.h>
 #include <linux/math64.h>
-#include <linux/gcd.h>
-#include <linux/minmax.h>
-#include <linux/slab.h>
-
-#include <asm/div64.h>
 
 #include "clk-rcg.h"
 #include "common.h"
+#include "common-uboot.h"
 
 #define CMD_REG			0x0
 #define CMD_UPDATE		BIT(0)
 #define CMD_ROOT_EN		BIT(1)
@@ -132,9 +128,9 @@ static int update_config(struct clk_rcg2 *rcg)
 			return 0;
 		udelay(1);
 	}
 
-	WARN(1, "%s: rcg didn't update its configuration.", name);
+	WARN(1, "%s: rcg didn't update its configuration.\n", name);
 	return -EBUSY;
 }
 
 static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
@@ -222,9 +218,11 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	u32 cfg;
 
 	regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
 
-	return __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
+	ulong rate = __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
+	pr_debug("%s: %s: rate %lu parent_rate %lu\n", __func__, clk_hw_get_name(hw), rate, parent_rate);
+	return rate;
 }
 
 static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 				    struct clk_rate_request *req,
@@ -349,22 +347,31 @@ static int _freq_tbl_fm_determine_rate(struct clk_hw *hw, const struct freq_mult
 	struct clk_hw *p;
 	int index;
 
 	f = qcom_find_freq_multi(f, rate);
-	if (!f || !f->confs)
+	if (!f || !f->confs) {
+		dev_err(hw->clk->dev, "%s: couldn't match rate %lu\n", clk_hw_get_name(hw), rate);
 		return -EINVAL;
+	}
+
+	log_debug("%s: %s rate %lu table rate %lu\n", __func__,
+		clk_hw_get_name(hw), rate, f->freq);
 
 	conf = __clk_rcg2_select_conf(hw, f, rate);
 	if (IS_ERR(conf))
 		return PTR_ERR(conf);
 	index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
-	if (index < 0)
+	if (index < 0) {
+		dev_err(hw->clk->dev, "Couldn't find index for src %#x: %d\n", conf->src, index);
 		return index;
+	}
 
 	clk_flags = clk_hw_get_flags(hw);
 	p = clk_hw_get_parent_by_index(hw, index);
-	if (!p)
+	if (!p) {
+		dev_err(hw->clk->dev, "%s: couldn't get parent index %d\n", clk_hw_get_name(hw), index);
 		return -EINVAL;
+	}
 
 	if (clk_flags & CLK_SET_RATE_PARENT) {
 		rate = f->freq;
 		if (conf->pre_div) {
@@ -1203,122 +1210,8 @@ const struct clk_ops clk_pixel_ops = {
 	.determine_rate = clk_pixel_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_pixel_ops);
 
-static int clk_gfx3d_determine_rate(struct clk_hw *hw,
-				    struct clk_rate_request *req)
-{
-	struct clk_rate_request parent_req = { .min_rate = 0, .max_rate = ULONG_MAX };
-	struct clk_rcg2_gfx3d *cgfx = to_clk_rcg2_gfx3d(hw);
-	struct clk_hw *xo, *p0, *p1, *p2;
-	unsigned long p0_rate;
-	u8 mux_div = cgfx->div;
-	int ret;
-
-	p0 = cgfx->hws[0];
-	p1 = cgfx->hws[1];
-	p2 = cgfx->hws[2];
-	/*
-	 * This function does ping-pong the RCG between PLLs: if we don't
-	 * have at least one fixed PLL and two variable ones,
-	 * then it's not going to work correctly.
-	 */
-	if (WARN_ON(!p0 || !p1 || !p2))
-		return -EINVAL;
-
-	xo = clk_hw_get_parent_by_index(hw, 0);
-	if (req->rate == clk_hw_get_rate(xo)) {
-		req->best_parent_hw = xo;
-		return 0;
-	}
-
-	if (mux_div == 0)
-		mux_div = 1;
-
-	parent_req.rate = req->rate * mux_div;
-
-	/* This has to be a fixed rate PLL */
-	p0_rate = clk_hw_get_rate(p0);
-
-	if (parent_req.rate == p0_rate) {
-		req->rate = req->best_parent_rate = p0_rate;
-		req->best_parent_hw = p0;
-		return 0;
-	}
-
-	if (req->best_parent_hw == p0) {
-		/* Are we going back to a previously used rate? */
-		if (clk_hw_get_rate(p2) == parent_req.rate)
-			req->best_parent_hw = p2;
-		else
-			req->best_parent_hw = p1;
-	} else if (req->best_parent_hw == p2) {
-		req->best_parent_hw = p1;
-	} else {
-		req->best_parent_hw = p2;
-	}
-
-	clk_hw_get_rate_range(req->best_parent_hw,
-			      &parent_req.min_rate, &parent_req.max_rate);
-
-	if (req->min_rate > parent_req.min_rate)
-		parent_req.min_rate = req->min_rate;
-
-	if (req->max_rate < parent_req.max_rate)
-		parent_req.max_rate = req->max_rate;
-
-	ret = __clk_determine_rate(req->best_parent_hw, &parent_req);
-	if (ret)
-		return ret;
-
-	req->rate = req->best_parent_rate = parent_req.rate;
-	req->rate /= mux_div;
-
-	return 0;
-}
-
-static int clk_gfx3d_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
-		unsigned long parent_rate, u8 index)
-{
-	struct clk_rcg2_gfx3d *cgfx = to_clk_rcg2_gfx3d(hw);
-	struct clk_rcg2 *rcg = &cgfx->rcg;
-	u32 cfg;
-	int ret;
-
-	cfg = rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
-	/* On some targets, the GFX3D RCG may need to divide PLL frequency */
-	if (cgfx->div > 1)
-		cfg |= ((2 * cgfx->div) - 1) << CFG_SRC_DIV_SHIFT;
-
-	ret = regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, cfg);
-	if (ret)
-		return ret;
-
-	return update_config(rcg);
-}
-
-static int clk_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
-			      unsigned long parent_rate)
-{
-	/*
-	 * We should never get here; clk_gfx3d_determine_rate() should always
-	 * make us use a different parent than what we're currently using, so
-	 * clk_gfx3d_set_rate_and_parent() should always be called.
-	 */
-	return 0;
-}
-
-const struct clk_ops clk_gfx3d_ops = {
-	.is_enabled = clk_rcg2_is_enabled,
-	.get_parent = clk_rcg2_get_parent,
-	.set_parent = clk_rcg2_set_parent,
-	.recalc_rate = clk_rcg2_recalc_rate,
-	.set_rate = clk_gfx3d_set_rate,
-	.set_rate_and_parent = clk_gfx3d_set_rate_and_parent,
-	.determine_rate = clk_gfx3d_determine_rate,
-};
-EXPORT_SYMBOL_GPL(clk_gfx3d_ops);
-
 static int clk_rcg2_set_force_enable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const char *name = clk_hw_get_name(hw);
@@ -1372,8 +1265,11 @@ static int __clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;
 
+	log_debug("%s: %s rate %lu parent_rate %lu policy %sp\n", __func__,
+		clk_hw_get_name(hw), rate, parent_rate, policy == FLOOR ? "floor" : "ceil");
+
 	switch (policy) {
 	case FLOOR:
 		f = qcom_find_freq_floor(rcg->freq_tbl, rate);
 		break;
@@ -1383,8 +1279,15 @@ static int __clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 	default:
 		return -EINVAL;
 	}
 
+	if (!f) {
+		dev_err(hw->clk->dev, "%s: couldn't find frequency for rate %lu\n", clk_hw_get_name(hw), rate);
+		return -EINVAL;
+	}
+
+	log_debug("%s: found freq %p rate %lu\n", __func__, f, f ? f->freq : 10101010);
+
 	/*
 	 * In case clock is disabled, update the M, N and D registers, cache
 	 * the CFG value in parked_cfg and don't hit the update bit of CMD
 	 * register.
@@ -1447,8 +1350,10 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
 static void clk_rcg2_shared_disable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 
+	log_debug("%s: %s\n", __func__, clk_hw_get_name(hw));
+
 	/*
 	 * Store current configuration as switching to safe source would clear
 	 * the SRC and DIV of CFG register
 	 */
diff --git a/drivers/clk/qcom/ccf/clk-regmap-divider.c b/drivers/clk/qcom/ccf/clk-regmap-divider.c
index 4f5395f0ab6d..f37556d31f4e 100644
--- a/drivers/clk/qcom/ccf/clk-regmap-divider.c
+++ b/drivers/clk/qcom/ccf/clk-regmap-divider.c
@@ -2,12 +2,12 @@
 /*
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <dm/ofnode.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/regmap.h>
-#include <linux/export.h>
 
 #include "clk-regmap-divider.h"
 
 static inline struct clk_regmap_div *to_clk_regmap_div(struct clk_hw *hw)
diff --git a/drivers/clk/qcom/ccf/clk-regmap-mux-div.c b/drivers/clk/qcom/ccf/clk-regmap-mux-div.c
index 6044839da85a..9c0eb8e1b8e2 100644
--- a/drivers/clk/qcom/ccf/clk-regmap-mux-div.c
+++ b/drivers/clk/qcom/ccf/clk-regmap-mux-div.c
@@ -3,8 +3,9 @@
  * Copyright (c) 2017, Linaro Limited
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
+#include <dm/ofnode.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/regmap.h>
diff --git a/drivers/clk/qcom/ccf/clk-regmap-mux.c b/drivers/clk/qcom/ccf/clk-regmap-mux.c
index 45d9cca28064..c6f95a3d4e5f 100644
--- a/drivers/clk/qcom/ccf/clk-regmap-mux.c
+++ b/drivers/clk/qcom/ccf/clk-regmap-mux.c
@@ -2,12 +2,12 @@
 /*
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <dm/ofnode.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/regmap.h>
-#include <linux/export.h>
 
 #include "clk-regmap-mux.h"
 
 static inline struct clk_regmap_mux *to_clk_regmap_mux(struct clk_hw *hw)
diff --git a/drivers/clk/qcom/ccf/clk-regmap-phy-mux.c b/drivers/clk/qcom/ccf/clk-regmap-phy-mux.c
index 7b7243b7107d..04f79591aef4 100644
--- a/drivers/clk/qcom/ccf/clk-regmap-phy-mux.c
+++ b/drivers/clk/qcom/ccf/clk-regmap-phy-mux.c
@@ -2,12 +2,12 @@
 /*
  * Copyright (c) 2022, Linaro Ltd.
  */
 
+#include <linux/bug.h>
 #include <linux/clk-provider.h>
 #include <linux/bitfield.h>
 #include <linux/regmap.h>
-#include <linux/export.h>
 
 #include "clk-regmap.h"
 #include "clk-regmap-phy-mux.h"
 
diff --git a/drivers/clk/qcom/ccf/clk-regmap.c b/drivers/clk/qcom/ccf/clk-regmap.c
index 92ac4e0d7dbe..bc59b2456a3e 100644
--- a/drivers/clk/qcom/ccf/clk-regmap.c
+++ b/drivers/clk/qcom/ccf/clk-regmap.c
@@ -2,12 +2,13 @@
 /*
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <dm/ofnode.h>
+#include <dm/device.h>
 #include <linux/device.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
-#include <linux/export.h>
 
 #include "clk-regmap.h"
 
 /**
@@ -93,14 +94,11 @@ EXPORT_SYMBOL_GPL(clk_disable_regmap);
  * Clocks that use regmap for their register I/O should register their
  * clk_regmap struct via this function so that the regmap is initialized
  * and so that the clock is registered with the common clock framework.
  */
-int devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk)
+int devm_clk_register_regmap(struct udevice *dev, struct clk_regmap *rclk, struct regmap *regmap)
 {
-	if (dev && dev_get_regmap(dev, NULL))
-		rclk->regmap = dev_get_regmap(dev, NULL);
-	else if (dev && dev->parent)
-		rclk->regmap = dev_get_regmap(dev->parent, NULL);
+	rclk->regmap = regmap;
 
 	return devm_clk_hw_register(dev, &rclk->hw);
 }
 EXPORT_SYMBOL_GPL(devm_clk_register_regmap);
diff --git a/drivers/clk/qcom/ccf/clk-regmap.h b/drivers/clk/qcom/ccf/clk-regmap.h
index 14ec659a3a77..c23160f2b6e5 100644
--- a/drivers/clk/qcom/ccf/clk-regmap.h
+++ b/drivers/clk/qcom/ccf/clk-regmap.h
@@ -32,7 +32,7 @@ static inline struct clk_regmap *to_clk_regmap(struct clk_hw *hw)
 
 int clk_is_enabled_regmap(struct clk_hw *hw);
 int clk_enable_regmap(struct clk_hw *hw);
 void clk_disable_regmap(struct clk_hw *hw);
-int devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk);
+int devm_clk_register_regmap(struct udevice *dev, struct clk_regmap *rclk, struct regmap *regmap);
 
 #endif
diff --git a/drivers/clk/qcom/ccf/clk-rpmh.c b/drivers/clk/qcom/ccf/clk-rpmh.c
index 1a98b3a0c528..dc1a75c3ff50 100644
--- a/drivers/clk/qcom/ccf/clk-rpmh.c
+++ b/drivers/clk/qcom/ccf/clk-rpmh.c
@@ -5,18 +5,16 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/string_choices.h>
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/rpmh.h>
 #include <soc/qcom/tcs.h>
 
 #include <dt-bindings/clock/qcom,rpmh.h>
 
+#include "common-uboot.h"
+
 #define CLK_RPMH_ARC_EN_OFFSET		0
 #define CLK_RPMH_VRM_EN_OFFSET		4
 
 /**
@@ -58,9 +56,9 @@ struct clk_rpmh {
 	u32 aggr_state;
 	u32 last_sent_aggr_state;
 	u32 valid_state_mask;
 	u32 unit;
-	struct device *dev;
+	struct udevice *dev;
 	struct clk_rpmh *peer;
 };
 
 struct clk_rpmh_desc {
@@ -69,9 +67,9 @@ struct clk_rpmh_desc {
 	/* RPMh clock clkaN are optional for this platform */
 	bool clka_optional;
 };
 
-static DEFINE_MUTEX(rpmh_clk_lock);
+// static DEFINE_MUTEX(rpmh_clk_lock);
 
 #define __DEFINE_CLK_RPMH(_name, _clk_name, _res_name,			\
 			  _res_en_offset, _res_on, _div)		\
 	static struct clk_rpmh clk_rpmh_##_clk_name##_ao;		\
@@ -265,9 +263,9 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
 	} else {
 		cmd_state = 0;
 	}
 
-	cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
+	cmd_state = min_t(u32, cmd_state, BCM_TCS_CMD_VOTE_MASK);
 
 	if (c->last_sent_aggr_state != cmd_state) {
 		cmd.addr = c->res_addr;
 		cmd.data = BCM_TCS_CMD(1, enable, 0, cmd_state);
@@ -309,8 +307,10 @@ static int clk_rpmh_bcm_set_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long parent_rate)
 {
 	struct clk_rpmh *c = to_clk_rpmh(hw);
 
+	printf("%s: %s: rate %lu parent_rate %lu\n", __func__, clk_hw_get_name(hw), rate, parent_rate);
+
 	c->aggr_state = rate / c->unit;
 	/*
 	 * Since any non-zero value sent to hw would result in enabling the
 	 * clock, only send the value if the clock has already been prepared.
@@ -900,9 +900,9 @@ static const struct clk_rpmh_desc clk_rpmh_glymur = {
 	.clks = glymur_rpmh_clocks,
 	.num_clks = ARRAY_SIZE(glymur_rpmh_clocks),
 };
 
-static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
+static struct clk_hw *of_clk_rpmh_hw_get(struct ofnode_phandle_args *clkspec,
 					 void *data)
 {
 	struct clk_rpmh_desc *rpmh = data;
 	unsigned int idx = clkspec->args[0];
@@ -914,16 +914,16 @@ static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
 
 	return rpmh->clks[idx];
 }
 
-static int clk_rpmh_probe(struct platform_device *pdev)
+static int clk_rpmh_probe(struct udevice *dev)
 {
 	struct clk_hw **hw_clks;
 	struct clk_rpmh *rpmh_clk;
 	const struct clk_rpmh_desc *desc;
 	int ret, i;
 
-	desc = of_device_get_match_data(&pdev->dev);
+	desc = (void *)dev_get_driver_data(dev);
 	if (!desc)
 		return -ENODEV;
 
 	hw_clks = desc->clks;
@@ -947,17 +947,17 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 			if (desc->clka_optional &&
 			    !strncmp(rpmh_clk->res_name, "clka", sizeof("clka") - 1))
 				continue;
 
-			dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
+			dev_err(dev, "missing RPMh resource address for %s\n",
 				rpmh_clk->res_name);
 			return -ENODEV;
 		}
 
 		data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
 		if (IS_ERR(data)) {
 			ret = PTR_ERR(data);
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"error reading RPMh aux data for %s (%d)\n",
 				rpmh_clk->res_name, ret);
 			return ret;
 		}
@@ -966,78 +966,65 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 		if (aux_data_len == sizeof(*data))
 			rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
 
 		rpmh_clk->res_addr += res_addr;
-		rpmh_clk->dev = &pdev->dev;
+		rpmh_clk->dev = dev;
 
-		ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
+		ret = devm_clk_hw_register(dev, hw_clks[i]);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to register %s\n", name);
+			dev_err(dev, "failed to register %s\n", name);
 			return ret;
 		}
 	}
 
 	/* typecast to silence compiler warning */
-	ret = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_rpmh_hw_get,
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_rpmh_hw_get,
 					  (void *)desc);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to add clock provider\n");
+		dev_err(dev, "Failed to add clock provider\n");
 		return ret;
 	}
 
-	dev_dbg(&pdev->dev, "Registered RPMh clocks\n");
+	dev_dbg(dev, "Registered RPMh clocks\n");
 
 	return 0;
 }
 
-static const struct of_device_id clk_rpmh_match_table[] = {
-	{ .compatible = "qcom,glymur-rpmh-clk", .data = &clk_rpmh_glymur},
-	{ .compatible = "qcom,milos-rpmh-clk", .data = &clk_rpmh_milos},
-	{ .compatible = "qcom,qcs615-rpmh-clk", .data = &clk_rpmh_qcs615},
-	{ .compatible = "qcom,qdu1000-rpmh-clk", .data = &clk_rpmh_qdu1000},
-	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = &clk_rpmh_sa8775p},
-	{ .compatible = "qcom,sar2130p-rpmh-clk", .data = &clk_rpmh_sar2130p},
-	{ .compatible = "qcom,sc7180-rpmh-clk", .data = &clk_rpmh_sc7180},
-	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
-	{ .compatible = "qcom,sc8180x-rpmh-clk", .data = &clk_rpmh_sc8180x},
-	{ .compatible = "qcom,sc8280xp-rpmh-clk", .data = &clk_rpmh_sc8280xp},
-	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
-	{ .compatible = "qcom,sdm670-rpmh-clk", .data = &clk_rpmh_sdm670},
-	{ .compatible = "qcom,sdx55-rpmh-clk",  .data = &clk_rpmh_sdx55},
-	{ .compatible = "qcom,sdx65-rpmh-clk",  .data = &clk_rpmh_sdx65},
-	{ .compatible = "qcom,sdx75-rpmh-clk",  .data = &clk_rpmh_sdx75},
-	{ .compatible = "qcom,sm4450-rpmh-clk", .data = &clk_rpmh_sm4450},
-	{ .compatible = "qcom,sm6350-rpmh-clk", .data = &clk_rpmh_sm6350},
-	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
-	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
-	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
-	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
-	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
-	{ .compatible = "qcom,sm8650-rpmh-clk", .data = &clk_rpmh_sm8650},
-	{ .compatible = "qcom,sm8750-rpmh-clk", .data = &clk_rpmh_sm8750},
-	{ .compatible = "qcom,x1e80100-rpmh-clk", .data = &clk_rpmh_x1e80100},
+static const struct udevice_id clk_rpmh_match_table[] = {
+	{ .compatible = "qcom,glymur-rpmh-clk", .data = (ulong)&clk_rpmh_glymur},
+	{ .compatible = "qcom,milos-rpmh-clk", .data = (ulong)&clk_rpmh_milos},
+	{ .compatible = "qcom,qcs615-rpmh-clk", .data = (ulong)&clk_rpmh_qcs615},
+	{ .compatible = "qcom,qdu1000-rpmh-clk", .data = (ulong)&clk_rpmh_qdu1000},
+	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = (ulong)&clk_rpmh_sa8775p},
+	{ .compatible = "qcom,sar2130p-rpmh-clk", .data = (ulong)&clk_rpmh_sar2130p},
+	{ .compatible = "qcom,sc7180-rpmh-clk", .data = (ulong)&clk_rpmh_sc7180},
+	{ .compatible = "qcom,sc7280-rpmh-clk", .data = (ulong)&clk_rpmh_sc7280},
+	{ .compatible = "qcom,sc8180x-rpmh-clk", .data = (ulong)&clk_rpmh_sc8180x},
+	{ .compatible = "qcom,sc8280xp-rpmh-clk", .data = (ulong)&clk_rpmh_sc8280xp},
+	{ .compatible = "qcom,sdm845-rpmh-clk", .data = (ulong)&clk_rpmh_sdm845},
+	{ .compatible = "qcom,sdm670-rpmh-clk", .data = (ulong)&clk_rpmh_sdm670},
+	{ .compatible = "qcom,sdx55-rpmh-clk",  .data = (ulong)&clk_rpmh_sdx55},
+	{ .compatible = "qcom,sdx65-rpmh-clk",  .data = (ulong)&clk_rpmh_sdx65},
+	{ .compatible = "qcom,sdx75-rpmh-clk",  .data = (ulong)&clk_rpmh_sdx75},
+	{ .compatible = "qcom,sm4450-rpmh-clk", .data = (ulong)&clk_rpmh_sm4450},
+	{ .compatible = "qcom,sm6350-rpmh-clk", .data = (ulong)&clk_rpmh_sm6350},
+	{ .compatible = "qcom,sm8150-rpmh-clk", .data = (ulong)&clk_rpmh_sm8150},
+	{ .compatible = "qcom,sm8250-rpmh-clk", .data = (ulong)&clk_rpmh_sm8250},
+	{ .compatible = "qcom,sm8350-rpmh-clk", .data = (ulong)&clk_rpmh_sm8350},
+	{ .compatible = "qcom,sm8450-rpmh-clk", .data = (ulong)&clk_rpmh_sm8450},
+	{ .compatible = "qcom,sm8550-rpmh-clk", .data = (ulong)&clk_rpmh_sm8550},
+	{ .compatible = "qcom,sm8650-rpmh-clk", .data = (ulong)&clk_rpmh_sm8650},
+	{ .compatible = "qcom,sm8750-rpmh-clk", .data = (ulong)&clk_rpmh_sm8750},
+	{ .compatible = "qcom,x1e80100-rpmh-clk", .data = (ulong)&clk_rpmh_x1e80100},
 	{ }
 };
-MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
 
-static struct platform_driver clk_rpmh_driver = {
-	.probe		= clk_rpmh_probe,
-	.driver		= {
-		.name	= "clk-rpmh",
-		.of_match_table = clk_rpmh_match_table,
-	},
+U_BOOT_DRIVER(clk_rpmh) = {
+	.name = "clk-rpmh",
+	.id = UCLASS_NOP,
+	.probe = clk_rpmh_probe,
+	.of_match = clk_rpmh_match_table,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-static int __init clk_rpmh_init(void)
-{
-	return platform_driver_register(&clk_rpmh_driver);
-}
-core_initcall(clk_rpmh_init);
-
-static void __exit clk_rpmh_exit(void)
-{
-	platform_driver_unregister(&clk_rpmh_driver);
-}
-module_exit(clk_rpmh_exit);
-
 MODULE_DESCRIPTION("QCOM RPMh Clock Driver");
 MODULE_LICENSE("GPL v2");

-- 
2.55.0

