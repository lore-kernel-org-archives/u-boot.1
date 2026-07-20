Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF14FC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FD1C60786;
	Mon, 20 Jul 2026 18:10:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ixnaEjgXfSzQ; Mon, 20 Jul 2026 18:10:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE8156079F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571022;
	bh=GZCyGQOYX+8KFxTEJvgN+MGa+rsqZQWWNJfeY8VTn4k=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0CLDgVzHqxau1Uw1SbNSrpOR4E91uzWkpFTTA56mryYBPdLJ28AgeV72fMhRbXbtV
	 RaH47SiyPOEXTbcrJP5G+Wp/r3DaHk8RwcVZ5idJBcZPtNcYw3dCC/OmfDBfCds0/S
	 8aXOb7WkIEvvgrC6mN/DzCTJvoqTF2Az1XnHwcbCkc6wNCpebhI99P4q1esMquuHex
	 wpJOzOoO8w7CPFiWsc0Ic4LvXYfXUSmCzTl7arPRU3KpuDE5tmnCatOwh98MWTZ7/d
	 iEAwrk+GXv7l4K9DDx4B9xk7duxsMV3JXm0LFlSA0qSVdPLmZkxm+WANm52FSvF+Cv
	 vLzfNbhiCtZUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE8156079F;
	Mon, 20 Jul 2026 18:10:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6253F1331
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54215606C6
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tm73nxmzit_X for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6AFBC6060E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AFBC6060E
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AFBC6060E
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57A19846A4; Mon, 20 Jul 2026 18:40:55 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 231C4844F6
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:40:51 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so79144305e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565650; x=1785170450;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GZCyGQOYX+8KFxTEJvgN+MGa+rsqZQWWNJfeY8VTn4k=;
 b=N72QwvXm4zhvCbGX6OGS0kLDIsKE8kY4kDxSXSzHX0O+wq+EAmCkVjEpzMR3iLomk3
 5/UFHMZ85HeHh2ym+SWGkn5gPTiKKof6jj6Ios9C3RHhAGZX4sp18eYh2BOJjvWvYO6q
 M7N/Tx0YK+FMRPxPHw0SQnlusKVKdtIxPDvIgciIfctOzXiaonD9tyIgWpwRMtBrLq4L
 ijZad62Uhf9SoFvdPSkpOJZh9/KaVl9n6aW6RcOFwb8QuW+1IJNqu0evyjAnhxmsWVBL
 2mfTNsGYh2dipnhDv6zN0j7N+FUrbVOKBeol0j/cDalArM9vqtsa8g/U7O35MnxHEAaT
 O2qg==
X-Gm-Message-State: AOJu0YyPzqMcYCl95/gl24rzYRZYTHlSWRDmE/i7A/Szck2Xr1H3O7cY
 7wAaKoB66uqhtnxJjAAz8eAIRm/sGrwvFm3PsaNskWYI9kLv+N/Aho7CVBIqmp55U5w=
X-Gm-Gg: AfdE7clza1x6fhJz0hfe2bcy2v4ZAa6SAPjgsz9XjL5HxHe8gv0rlo4lYiMPpndPsoW
 S+Mn6Sw7ZPkj7IS+iHXvOHXT3mchDXUXL1joE2oLnhaOWzoJrOpod0Tmo9ymhNRtHH2jhOwaGOM
 Q4IAO/33Qm12jRtU0oB88vxug9OLwqTx9z3rvghym2uHpOg3jkN2qI0DUHQCYfkxeMnh5ynQNlx
 T4cAzmnZzRS1rqigA4yLbzL7aFwHcrLqa7k4P6RqWPNZr77yyhso6meFyJkReF4kjSx6NjtjFKg
 uWYNZqFSTEfZGp9Mv1VPnjLGwLE5hugz0+LA1y8h6xaLgbTrVZspG/4oLHbNKGDsLry0LruGjjL
 E3og83X6ig4TBS69dJMUA5T7HkPCOp4r5kTdh5B7wAq1nMV9SwoXapnp+09gpw9q1iJmvijEDGa
 vHzbMInwODeqOoXqISpsPm3hGhnrBusg==
X-Received: by 2002:a05:600c:3ba5:b0:495:4b42:8677 with SMTP id
 5b1f17b1804b1-4954b42873emr175037265e9.18.1784565650570; 
 Mon, 20 Jul 2026 09:40:50 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:40:49 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:30 +0100
Subject: [PATCH 03/36] clk: move fixed clocks to clk/basic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-3-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2099;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=iaJMzmGqn3WlQwJyPBCduRSzMj5ZyvuxjJQpqvEm5NY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+AvAs1McNG/9L8GpQobLzAoR9QCs2me7Fnn
 Qd/H16qrzmJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgAAKCRAFgzErGV9k
 thZMD/40lr+oVa2xLQhmPDEwIWWb6nPC0Z/DtPmvVCW/fYZsYfCtsrXXEjFq0NP2x2Bj6dPZb3x
 4k3pMauKbQ+XiH85gfmdF6JqRecPc6M7ejhIulvcq/FgggBu24gjNd2Kzil5ZIbGpx66C0lBH/f
 yRyC0Focg336zNyYJxn+VTnbwSMU/yQO32qkP/Skk4j+sS6R4gMp/sxMa5tqNyJXci/gDehvSfG
 fjjBCU0+IeLjQeoFnthGISbQaYGCH8nYWrKXQN3+aTuJCjMckV0sEXm3GwpOFsizvokNX9f0Rbz
 wCe4L8XDx7ObPLb55q3eLXxKYrMXn+KoCOPwQFhDwq9bDRAiPWUxlJzw1vR2Dxbri77uHBzBG1M
 AxG7ohaGTLFjas6GmjprHtP7zBSzwyrCeN4iqJqMnt/LgTJM3+GhZQTPqJjv4POc/6W1uaP98NE
 ybkxp1tApdD20QQqTR/kAEDNsKMF+tLExwJ9pNs9poDwjPZd8ZGxS5UmN5R4sTHhfAdEkB2i7Ux
 zzG9werjJKpBnpIoBXlBBBnMZjsSwbYYo48rSNQAPJ1K8h/H8QdB+V69FPDeXsDrsTw/WuwjAGm
 LArIIG42FTppNet46ERQ57Xg3wQYPFtMaB5rguYHfoUlus8zDfvLoQgUigeDLlKItdrHYpUKCg7
 beTogDME9XLfvaQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565650; x=1785170450; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GZCyGQOYX+8KFxTEJvgN+MGa+rsqZQWWNJfeY8VTn4k=;
 b=vx2ZiOpWS3ZmkSF6U6/hSSebVGWaCYD5qlDCKISU2LpcRM71UlpxaBny306OCtufqZ
 vQSgRGWDMnS+zo2AeVdwVd9YQL7jna2Vz7RpxvxRKhr+SwylJ1DY7AWOV42G9+FLjQY9
 Oz2RubbyLaCncuWeI8vri7zgP5Ed5oj7JrVXNKyVdlFd2g+WVS49qXZotmPdewHGQwYy
 FqIaicosKSag4yblpwH824FXvKiYkXbqK9Y3npO43/wdWnSB4wc2u/7+5M5TEoxYD6B4
 uZXk9We27r41qEJonJF85BBWbIe50Ba6taBSq10CmhxGeoI/qY8do0UpjErQ+ctodt2e
 j02A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=vx2ZiOpW
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="vx2ZiOpW"; 
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

Linux CCF has incompatible implementations of fixed-rate/fixed-factor
clocks, move the U-Boot versions of these drivers to clk/basic and only
build them if CCF_FULL is not enabled.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Makefile                       | 8 ++++++--
 drivers/clk/basic/Makefile                 | 7 +++++++
 drivers/clk/{ => basic}/clk_fixed_factor.c | 0
 drivers/clk/{ => basic}/clk_fixed_rate.c   | 0
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e9a0759e93aa..35a5f81202e1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -4,16 +4,20 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 
 obj-$(CONFIG_$(PHASE_)CLK) += clk-uclass.o
-obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
-obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
 obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
 # U-Boot/IMX "micro" CCF port
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += uccf/
 
+# U-Boot basic fixed clocks, full CCF has a
+# different and incompatible implementation
+ifndef CONFIG_CLK_CCF_FULL
+obj-y += basic/
+endif
+
 obj-y += adi/
 obj-y += airoha/
 obj-y += analogbits/
 obj-$(CONFIG_MACH_IMX) += imx/
diff --git a/drivers/clk/basic/Makefile b/drivers/clk/basic/Makefile
new file mode 100644
index 000000000000..4cf9469d2312
--- /dev/null
+++ b/drivers/clk/basic/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2026 Linaro Ltd.
+#
+
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
+obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
diff --git a/drivers/clk/clk_fixed_factor.c b/drivers/clk/basic/clk_fixed_factor.c
similarity index 100%
rename from drivers/clk/clk_fixed_factor.c
rename to drivers/clk/basic/clk_fixed_factor.c
diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/basic/clk_fixed_rate.c
similarity index 100%
rename from drivers/clk/clk_fixed_rate.c
rename to drivers/clk/basic/clk_fixed_rate.c

-- 
2.55.0

